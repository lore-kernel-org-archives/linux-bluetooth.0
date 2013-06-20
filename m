Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Alex Deymo <deymo@chromium.org>
Date: Wed, 19 Jun 2013 17:56:32 -0700
Message-ID: <CAGd9gwhd4DuEw_jHJAZF99YwNT==-s9yW6KEkZ_A2w+eeFy88w@mail.gmail.com>
Subject: [BUG] HCI_RESET and Num_HCI_Command_Packets limit
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Cc: keybuk <keybuk@chromium.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I'm experiencing a problem that wedges the bluetooth adapter from time
to time. The repro case can be hit with this scenario:

run bluetoothd
while hciconfig hci0 up && hciconfig hci0 down; do echo -n .; done

In few iterations you will have a timeout while trying to bring up the
interface. This is just a repro case, the real scenario just happens
from time to time if you for instance restart bluetoothd at the right
(or wrong!) moment.

The problem is the following:
Setting up the interface, the host will send several HCI commands to
set things like the device class or the local name. If it happens that
the hciconfig makes the host send a HCI_Reset command after another
command was sent but before the corresponding event was received, then
the adapter is blocked for a while. Recovery it from that situation is
kind of random. A few attempts of hcidump hci0 up may or not work....
but the problem was before.

In the hci trace you see below, the last HCI Event received has a
value of Num_HCI_Command_Packets of 1, which according to the Core
spec (Vol2, part E, sec 7.7.14) means that we can only send 1 HCI
command until we receive the next event; but the trace shows that we
sent 2: Write Local Name and a Reset. So the host here doesn't follow
the spec... am I right?

Even worse, after the HCI_Reset the host shall not send additional HCI
commands before the Command Complete event is received (sec 7.3.2).
According to the spec, if you want to reset the adapter, you have to
wait until the completion of any command if you already reached the
num_HCI_Command_Packets limit??? There's no alternative/exception to
reset the adapter? :-(

How can I workaround this problem?

Thanks,
Alex.

< HCI Command: Write Class of Device (0x03|0x0024) plen 3             94.190995
        Class: 0x080104
          Major class: Computer (desktop, notebook, PDA, organizers)
          Minor class: Desktop workstation
          Capturing (Scanner, Microphone)
> HCI Event: Command Complete (0x0e) plen 4                           94.191963
      Write Class of Device (0x03|0x0024) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Local Name (0x03|0x0013) plen 248                94.191997
        Name: Chromebook
< HCI Command: Reset (0x03|0x0003) plen 0                             95.200150
< HCI Command: Reset (0x03|0x0003) plen 0                            106.228014
< HCI Command: Reset (0x03|0x0003) plen 0                            117.261787
< HCI Command: Reset (0x03|0x0003) plen 0                            128.293874
