Return-Path: <Steven.Singer@csr.com>
Message-ID: <3F7D5B72.1050900@csr.com>
Date: Fri, 03 Oct 2003 12:20:18 +0100
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Peter Bergmann <bergmann.peter@gmx.net>,
   BlueZ Mailing List
    <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluetooth and wireless lan horror
References: <1065171540.1734.97.camel@pegasus>
    <28385.1065174121@www39.gmx.net> <1065174943.1734.101.camel@pegasus>
In-Reply-To: <1065174943.1734.101.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

Marcel Holtmann wrote:
 >Peter Bergmann wrote:
 >>Does anyone know if bluez supports this "language code switching" ?
 > this is done by vendor HCI commands if it exists.

And all requirement for 23 hop sequences has been dropped from the BT
1.2 spec. It's been deprecated in 1.1 for some time.

BT 1.2 does, however, support adaptive frequency hopping (AFH). This
should allow a link between two BT 1.2 devices to detect an active
WLAN network and avoid the frequencies used by the WLAN. Unfortunately,
this doesn't help with BT 1.1 devices (BT 1.1 and 1.2 device will
interoperate, but 1.2 features can't be used on the link).

My suspicion is that if you're streaming data then the WLAN network
is using packets that are several milliseconds long. If they were
10 ms then about one in three packets would be transmitted at the
same time as a Bluetooth transmision (assuming an idle Bluetooth link
with a default poll interval of 25 ms). It may be that as you move
further away, the relative powers of the two devices is such that
you're getting what's called 'front-end overload'. This could happen
if you have a Bluetooth device phsycialy close to a WLAN device
particularly if both devices are communicating over a long distance.
When this happens, it might not matter which frequency the Bluetooth
transmission is on, it can still overload the WLAN receiver.

A technique that might be useful for both BT 1.1 and 1.2 devices is
to use sniff. If you chose a relatively long sniff interval (several
hundred milliseconds) then when the link is idle the Bluetooth devices
will communicate only once per interval (as opposed to the default of
about once every 25 ms). If you also chose a fairly high timeout then
once data starts flowing it should be able to stream smoothly. The
only disadvantage of this technique is that when data flow stops you
may get a delay of up to the sniff interval before it can restart.

This should be relatively easy to test. Use the HCI command line tools
to put the link in sniff mode. I suggest parameters of min_interval =
0x200, max_interval = 0x400, attempts = 4, timeout = 40.

In theory it would be possible for BlueZ to detect that the rfcomm
link has gone quiet (a simple timer from the last packet sent or
received) and then automatically switch into sniff mode. An advantage
of this technique is that BlueZ can gradually increase the sniff
interval the longer the link's been idle. The longer the sniff
interval, the longer the latency from when either host sends data
till it can be sent over the air. This would mean that if the link
was idle only briefly you'd get low latency but if you didn't use
the link for a while then it'd take a while for data to flow.

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
