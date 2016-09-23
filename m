Return-Path: <Dean_Jenkins@mentor.com>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
To: Dean Jenkins <Dean_Jenkins@mentor.com>, Marcel Holtmann
	<marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg
	<johan.hedberg@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>
Subject: [PATCH V2 0/7] Bluetooth HCI LDISC and BCSP fixes
Date: Fri, 23 Sep 2016 18:56:25 +0100
Message-ID: <1474653392-28770-1-git-send-email-Dean_Jenkins@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

This patchset contains the following commits:

Dean Jenkins (4):
  Bluetooth: Tidy-up coding style in hci_bcsp.c
  Bluetooth: BCSP fails to ACK re-transmitted frames from the peer
  Bluetooth: Add mutex to hci_uart_tty_ioctl()
  Revert "Bluetooth: hci_ldisc: Fix null pointer derefence in case of
    early data"

Deepak Das (1):
  Bluetooth: Prevent scheduling of work after hci_uart_tty_close()

Vignesh Raman (2):
  Bluetooth: Use single return in hci_uart_tty_ioctl() call
  Bluetooth: Fix HCI UART HCI_UART_PROTO_SET locking

 drivers/bluetooth/hci_bcsp.c  | 128 ++++++++++++++++++++++++------------------
 drivers/bluetooth/hci_ldisc.c |  63 +++++++++++++--------
 drivers/bluetooth/hci_uart.h  |   4 +-
 3 files changed, 117 insertions(+), 78 deletions(-)

This V2 patchset is in response to my previous V1 patchset released here:
http://www.spinics.net/lists/linux-bluetooth/index.html#68405
with E-mail subject "[PATCH v1 0/4] Bluetooth HCI LDISC and BCSP fixes"

Changes since patchset V1
-------------------------

New commit as requested by Marcel
"Bluetooth: Tidy-up coding style in hci_bcsp.c"

Spilt commit as requested by Marcel
"Bluetooth: prevent a race condition on hci_uart_tty_ioctl() call"
into
"Bluetooth: Use single return in hci_uart_tty_ioctl() call"
"Bluetooth: Add mutex to hci_uart_tty_ioctl()"

Revert commit
"Bluetooth: hci_ldisc: Fix null pointer derefence in case of early data"

Reordered the patches
The patchset contains 2 BCSP related patches and 5 HCI UART LDISC patches.
The BCSP related patches can be applied independently of the HCI UART LDISC
patches.


Background information
----------------------

6 out of these 7 commits were originally developed and validated on an
ARM i.MX6 based commercial project running a highly modified 3.14 Linux kernel.
The commits were needed to improve BCSP recovery and to avoid kernel crashes in
the Bluetooth sub-system start-up and shutdown scenarios.

The "Bluetooth: hci_ldisc: Fix null pointer derefence in case of early data"
commit from upstream kernel v4.7-rc1 was not included in the i.MX6 kernel
so this patchset is reverting this commit as this patchset fixes the same issue.

The commits are used with a UART based Bluetooth Radio Module that uses BCSP.
This means the commits should have no impact on USB based Bluetooth Radio
Modules which are typically used on x86 based computer systems.

The commits have been forward-ported to bluetooth-next master branch HEAD
(acf91ec Bluetooth: btwilink: Save the packet type before sending)
and built but not tested.

The commits were also sanity tested on top of linux-stable v4.7.4 on a 64-bit
x86 Linux laptop with a USB to UART based Bluetooth Radio Module. The sanity
tests used l2ping to confirm that a remote Bluetooth smartphone could be
contacted.


Risks
-----

The HCI UART LDISC patches have only been validated with the BCSP Data Link
protocol layer.

Recommend that other Data Link Layer protocols are tested as we are unable to
test them. However, code inspection suggests that the HCI UART LDISC patches
should be OK but the changes have not been proven to work for the other Data
Link Layer protocols.


Commit details
--------------

The following 2 BCSP commits are a pair.

1. "Bluetooth: Tidy-up coding style in hci_bcsp.c"

This patch does some coding style cleanups to make is easier to apply subsequent
patches that have a preferred coding style.


2. "Bluetooth: BCSP fails to ACK re-transmitted frames from the peer"

This patch had previously been released to the mailing list in 2014 but somehow
never got into bluetooth-next at that time. Probably, there was an oversight in
keeping track of the patch to ensure it got reviewed by the maintainer.

The idea of this patch is to make sure that the BCSP header of all received BCSP
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


The following 5 HCI UART LDISC commits are related.

3. "Bluetooth: Use single return in hci_uart_tty_ioctl() call"

This commit tidies up hci_uart_tty_ioctl() to have a single return statement.
This allows the next commit below to add a mutex to protect against concurrency.


4. "Bluetooth: Add mutex to hci_uart_tty_ioctl()"

This patch avoids a race condition by adding a mutex to hci_uart_tty_ioctl()
to prevent concurrency.

Note this commit removes the lockless role of the HCI_UART_PROTO_SET flag
by using a mutex lock.


5. "Bluetooth: Fix HCI UART HCI_UART_PROTO_SET locking"

This patch fixes a kernel NULL pointer dereference crash when starting-up the
Bluetooth sub-system.

There is a flaw that HCI_UART_PROTO_SET is set before hci_uart_set_proto() is
successfully run to set the hu->proto->recv function pointer. This allows the
UART driver to attempt to process RX characters before the recv function pointer
has been set so causing a NULL pointer dereference crash.

The commit modifies the implementation to only set HCI_UART_PROTO_SET after
hci_uart_set_proto() has successfully executed. The HCI_UART_PROTO_SET flag
is no longer used as a lockless solution for hci_uart_tty_ioctl() as a mutex is
used.

These 3 commits fixes the same issue as the kernel v4.7-rc1
"Bluetooth: hci_ldisc: Fix null pointer derefence in case of early data"
which fixes the same crash by adding HCI_UART_PROTO_READY.


6. "Revert "Bluetooth: hci_ldisc: Fix null pointer derefence in case of early
data""

The following 3 commits from this patchset
"Bluetooth: Use single return in hci_uart_tty_ioctl() call"
"Bluetooth: Add mutex to hci_uart_tty_ioctl()"
"Bluetooth: Fix HCI UART HCI_UART_PROTO_SET locking"

fixes the same issue and avoids a potential race condition introduced in kernel
v4.7-rc1.

Therefore, recommend reverting the v4.7-rc1 commmit
"Bluetooth: hci_ldisc: Fix null pointer derefence in case of early data"

The git commit text of the reverted patch gives a fuller explanation so please
read that.

Both solutions can co-exist but better to revert the v4.7-rc1 commmit in my
opinion because the v4.7-rc1 commmit is weaker.


7. "Bluetooth: Prevent scheduling of work after hci_uart_tty_close()"

This patch prevents adding a transmission work item to the hu->write_work work
queue during execution of hci_uart_tty_close(). A kernel crash has been
observed whist BCSP was scheduling a retransmission and shutdown of the HCI UART
was in progress.

The fix introduces a new HCI_UART proto flag bit called HCI_UART_UNREGISTERING
and adds a spinlock to hci_uart_tx_wakeup() to force that function to run
consecutively with respect to hci_uart_tty_close().

The git commit text of the patch gives a fuller explanation so please read
that.


Further work
------------

Note we are working on some cleanups to hci_uart_tty_close() which are now
under test.

Recommend that hci_unregister_dev() is investigated because:

a) Execution time seen as 2 seconds (on x86)- suggesting some timed event occurs
b) Seems to be trying to send HCI message(s) but these will never get through
   to the Radio Module due to the various flags whilst the HCI UART is closing.
c) Suspect that hci_unregister_dev() is responsible for triggering various
   crashes which have been worked around elsewhere over the many years.

-- 
2.7.4
