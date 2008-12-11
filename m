Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 11 Dec 2008 12:34:28 -0800
Message-ID: <35c90d960812111234v14bf1835u6899f434231c9f84@mail.gmail.com>
Subject: Clock control of a Bluetooth UART via hci_ll.c
From: Nick Pelly <npelly@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@google.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

(expecting to have to post this to LKML, but trying linux-bluetooth first)

On embedded architectures we need to perform clk_enable() and
clk_disable() on the bluetooth uart when the bluetooth chip enters and
exists low power mode. This needs to be independent of tradtional
linux cpu suspend/resume modes that correspond to the linux CPU power
state, because many Bluetooth chips (eg TI BRF6300) have low power
modes that are independent of the linux cpu..

hci_ll.c knows when the bt chip has entered low power mode, as it
contains the HCILL state machine. But the clk_enable() and
clk_disable() should be done from the uart driver since that driver
owns the uart clock.

The question is - what interface should hci_ll.c use to tell the uart
driver when to enter and exit low power modes?

Right now we call new functions in our uart driver directly from
hci_ll.c. We know this not going to get accepted upstream, because we
have bypassed the tty and serial_core layers. We are looking for a
better designed solution, which I expect would have to pass through
these layers and use an existing uart_ops (serial_core.h).

A requirements for this interface are that it cannot sleep (hci_ll.c
needs to make these clock requests while holding a spinlock). This
eliminates many uart_ops including .ioctl (uart_ioctl() grabs a
mutex).

.pm is no good because it gets called during suspend() and resume().

>From our investigation, the only really promising option amongst the
existing set of uart_ops seems to be to use .set_termios with a baud
rate of zero. It seems API compliant for the uart driver to then
clk_disable().

clk_enable() could be triggered by hci_ll.c by restoring the old baud
rate. Unfortunately this means hci_ll would need to track the old baud
rate. Also, wakeup can occur via RX traffic on the bluetooth chip in
which case the uart driver needs to trigger the clk_enable(). It would
have to restore the baud rate itself, which may not be API friendly.
It also leaves the question of what happens if userspace changes the
baud rate while the uart is clocked off.

So this approach has its issues, but is the only workable solution we
have right now that uses an existing uart operation.

Any thoughts on this approach? Any other ideas?

Thanks,
Nick
