Return-Path: <Steven.Singer@csr.com>
Message-ID: <3F84295E.9020303@csr.com>
Date: Wed, 08 Oct 2003 16:12:30 +0100
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Peter Bergmann <bergmann.peter@gmx.net>,
   BlueZ Mailing List
    <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] Reducing power consumption (Was: bluetooth and wireless
    lan horror)
References: <1065171540.1734.97.camel@pegasus>
    <28385.1065174121@www39.gmx.net> <1065174943.1734.101.camel@pegasus>
    <3F7D5B72.1050900@csr.com> <1065443556.21958.39.camel@pegasus>
    <3F83F423.7020406@csr.com> <1065613768.5327.138.camel@pegasus>
In-Reply-To: <1065613768.5327.138.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

Marcel Holtmann wrote:
> It can be useful for all kind of devices where power consumption is
> essential. Even an iPAQ with a PAN connection can profit from it. The
> Microsoft HID devices make heavy use of sniff mode, before they
> disconnect the ACL link after 12 minutes of idle time. And everyone
> talks about the long battery life time of Bluetooth HID devices, so this
> looks like the right way to reduce power consumption.

I think, in the HID profile, it's the HID client device (the mouse or
whatever) that controls the sniff settings and chooses when to disconnect.
It's the client that has to keep power consumption extremely low to make
its battery last for months. It's the client that has the input from the
sensor (for example) to determine when would be a good time to bring the
link latency down. All the server has to do is enable sniff and let the
client sort it out.

If you're looking at BlueZ HID clients (say BlueZ on a palmtop which
can behave as a HID device for a desktop machine) then you will need
to look at controlling sniff.

However, as you say, for battery powered devices, sniff is generally
a good thing. In Bluetooth, active slaves are required to listen in
every slot. This burns power. Just switching into sniff with a short
interval (say 25 ms - same as the poll period) can have a significant
effect on power consumption. Of course, if you're on a mains powered
machine, or if the power consumption of your Bluetooth device is a
small fraction of your total power consumption, then this is not worth
bothering with. In fact, in these cases, you probably shouldn't do it
and you should let the device at the other end of the link decide what
settings are most profitable for it.

How much power you save depends on the host transport and the host
transport settings. Some scenarios allow us to save more power than
others. I've tried to simplify the description to try and keep it
general rather than too CSR specific but, because I know only the CSR
solution in detail, some of this might not apply to other chipsets.

For all scenarios, even short sniffs can be a significant improvement
over being an active slave. Just allowing the dongle to keep its radio
turned off most of the time could save maybe a factor of two in power
(depending on sniff settings).

For some scenarios, such as bus powered USB dongles and H4 UART dongles
with very high baud rates, this might be the best you can do.

Other scenarios may improve things dramatically, particularly at long
sniff intervals. If the Bluetooth dongle is a self powered USB device
and if you support remote wakeup then suspending it may help.

For UARTs, both with H4 and BCSP, using a lower baud rate might help the
power consumption even on short sniff intervals (of course it will hurt
the data rate)

Using a host transport that supports devices going to sleep - BCSP
is an example - really helps at long sniff intervals (say one second
or more).

The question is how much of a saving do you need? Even flat out,
any Bluetooth radio will be pushed to draw more than 60 mA. An
active, but idle, link will draw less than that. What's the total
power consupmtion of an iPAQ? Is 60 mA a significant fraction? At
what point do we stop caring?

Sometimes the critical factor is not the current consumption of the
Bluetooth dongle, but of the whole system. If you have a situation
where both ends of the link are free to go to sleep, such as with BCSP
or suspended self-powered USB devices, then being able to shut the host
down and wake it up when Bluetooth activity occurs could be a
significant long-term power saving.

Sometimes, what eats most current, on average, is time spent without a
link but being discoverable and/or connectable. Using BCSP will help
compared to H4. Suspending self-powered USB devices may help.

	- Steven
-- 



**********************************************************************
The information transmitted is intended only for the person or
entity to which it is addressed and may contain confidential 
and/or privileged material. 
Any review, retransmission, dissemination or other use of, or
taking of any action in reliance upon, this information by 
persons or entities other than the intended recipient is 
prohibited.  
If you received this in error, please contact the sender and 
delete the material from any computer.
**********************************************************************
