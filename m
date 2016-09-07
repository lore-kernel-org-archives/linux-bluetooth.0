Return-Path: <Dean_Jenkins@mentor.com>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
To: Dean Jenkins <Dean_Jenkins@mentor.com>, Marcel Holtmann
	<marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg
	<johan.hedberg@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>
Subject: [PATCH v1 0/4] Bluetooth HCI LDISC and BCSP fixes
Date: Wed, 7 Sep 2016 15:15:06 +0100
Message-ID: <1473257710-2073-1-git-send-email-Dean_Jenkins@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

This patchset contains the following commits:

Dean Jenkins (1):
  Bluetooth: BCSP fails to ACK re-transmitted frames from the peer

Deepak Das (1):
  Bluetooth: Prevent scheduling of work after hci_uart_tty_close()

Vignesh Raman (2):
  Bluetooth: Fix HCI UART HCI_UART_PROTO_SET locking
  Bluetooth: prevent a race condition on hci_uart_tty_ioctl() call

 drivers/bluetooth/hci_bcsp.c  | 82 +++++++++++++++++++++++++------------------
 drivers/bluetooth/hci_ldisc.c | 63 ++++++++++++++++++++++-----------
 drivers/bluetooth/hci_uart.h  |  3 ++
 3 files changed, 94 insertions(+), 54 deletions(-)

Background information
----------------------

These 4 commits were originally developed and validated on an ARM i.MX6 based
commercial project running a highly modified 3.14 Linux kernel. The commits were
needed to improve BCSP recovery and to avoid kernel crashes in the Bluetooth
sub-system start-up and shutdown scenarios.

The commits are used with a UART based Bluetooth Radio Module that uses BCSP.
This means the commits should have no impact on USB based Bluetooth Radio
Modules which are typically used on x86 based computer systems.

The commits have been forward-ported to bluetooth-next master branch HEAD
(4e9a68b fakelb: fix schedule while atomic)

The commits were also sanity tested on top of linux-stable v4.7.2 on a 64-bit
x86 Linux laptop with a USB to UART based Bluetooth Radio Module. The sanity
tests used l2ping to confirm that a remote Bluetooth smartphone could be
contacted.

Commit details
--------------

The following 2 commits are a pair and needs discussion in the community:

1. "Bluetooth: Fix HCI UART HCI_UART_PROTO_SET locking"

This patch fixes a kernel NULL pointer dereference crash when starting-up the
Bluetooth sub-system.

There is a flaw that HCI_UART_PROTO_SET is set before hci_uart_set_proto() is
successfully run to set the hu->proto->recv function pointer. This allows the
UART driver to attempt to process RX characters before the recv function pointer
has been set so causing a NULL pointer dereference crash.

The commit modifies the implementation to only set HCI_UART_PROTO_SET after
hci_uart_set_proto() has successfully executed.

It is thought that the following commit introduced in kernel v4.7-rc1
84cb3df0 "Bluetooth: hci_ldisc: Fix null pointer derefence in case of early data"
fixes the same crash by adding HCI_UART_PROTO_READY.

A doubt is which solution is most effective which might mean the proposed
patch is now redundant. However, both solutions can co-exist. This needs
discussion in the community.


2. "Bluetooth: prevent a race condition on hci_uart_tty_ioctl() call"

This patch avoids a race condition by adding a mutex to hci_uart_tty_ioctl()
to prevent concurrency.

It is unclear whether this patch is now redundant due to kernel v4.7-rc1 commit
84cb3df0 "Bluetooth: hci_ldisc: Fix null pointer derefence in case of early data"

This needs discussion in the community.


3. "Bluetooth: BCSP fails to ACK re-transmitted frames from the peer"

This patch had previously been released to the mailing list in 2014 but somehow
never got into bluetooth-next at that time. Probably, there was an oversight in
keeping track of the patch to ensure it got reviewed by the maintainer.

The idea of this patch to make sure that the BCSP header of all received BCSP
frames from the Bluetooth Radio Module are consumed. The BCSP header contains
sequence counters for reliable transmitted, and received acknowledgment frames.
The acknowledgment counter is received in either reliable or unreliable frames.
These 2 independent counters are needed for a duplex link to track
acknowledgments and to trigger retransmissions.

In the local BCSP peer, each new reliable transmit frame increments the local TX
sequence number (modulo 8). The local BCSP peer has a window size of 4 so must
not transmit any new reliable frames until less than 4 acknowledgments are
pending. When a reliable BCSP frame is received, the remote BCSP peer's TX
sequence number is read and checked, and an acknowledgment frame should be sent
back to confirm the remote BCSP peer's transmission status.

The current implementation has a flaw because when the received reliable BCSP
frame does not have the expected remote TX sequence counter value, it causes the
whole frame to be dropped and causes the so-called "Out-of-order packet arrived"
error message to be generated. This incorrect behaviour means that the local
BCSP peer's acknowledgment counter number is not processed meaning that the
remote BCSP peer may have acknowledged the local BCSP peer's transmission but
the indication is ignored by the local BCSP peer. This can cause the local BCSP
peer to unnecessarily re-transmit. In addition the remote BCSP peer is not sent
an acknowledgment frame to update its transmission status. This can cause the
remote BCSP peer to unnecessarily retransmit frames.

In other words, the current implementation is weak in sending acknowledgments
in response to already received frames.

The flaw is observed with a poor performing UART driver which causes occasional
corruption of received or transmitted frames. BCSP is designed to compensate
for such issues by using its recovery mechanism and the flaw is in the
recovery mechanism.

The flaw can be triggered when the local BCSP peer fails to receive a reliable
frame from the remote BCSP peer so that reception of the next new reliable frame
from the remote BCSP peer causes the received transmission counter to skip over
(modulo 8) a value due to the missing frame. This generates the so-called
"Out-of-order packet arrived" error message but the acknowledgment counter
in the received frame's BCSP header is valid and should be processed and not
ignored. This protocol failure can be recovered when the local BCSP peer
retransmits an unacknowledged frame and the remote BCSP peer responds with an
acknowledgment using an unreliable frame so avoids the flawed code.

Alternatively, the flaw is triggered when the local BCSP peer tries to send
an acknowledgment frame to the remote BCSP peer but the remote BCSP peer failed
to receive the acknowledgment. This causes the local BCSP peer to increment
(modulo 8) the expected next remote BCSP peer's transmission sequence counter.
When the remote BCSP peer retransmits the unacknowledged frame, the local BCSP
peer is expecting the next counter value so causing the so-called
"Out-of-order packet arrived" error message to be generated. This causes the
received BCSP frame to be dropped so the local BCSP peer fails to send an
acknowledgment frame. This protocol failure due to the flaw may be
unrecoverable. However, recovery is sometimes possible when the remote BCSP peer
resends multiple unacknowledged frames so the next expected counter value is
seen so gets past the flawed code.


4. "Bluetooth: Prevent scheduling of work after hci_uart_tty_close()"

This patch prevents adding a transmission work item to the hu->write_work work
queue during execution of hci_uart_tty_close(). A kernel crash has been
observed whist BCSP was scheduling a retransmission and shutdown of the HCI UART
was in progress.

The fix introduces a new HCI_UART proto flag bit called HCI_UART_UNREGISTERING
and adds a spinlock to hci_uart_tx_wakeup() to force that function to run
consecutively with respect to hci_uart_tty_close().

The git commit text of the patch gives a fuller explanation so please read
that.

-- 
2.7.4
