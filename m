Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41192066.1060202@csr.com>
From: Carl Orsborn <cjo@csr.com>
MIME-Version: 1.0
To: Jonathan Paisley <jp-www@dcs.gla.ac.uk>
CC: James Courtier-Dutton <James@superbug.demon.co.uk>,
   BlueZ Mailing List
    <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] snd-bt-sco development teamup...
References: <4117AB9A.9010909@dark-reality.de>
    <1092071356.4564.12.camel@pegasus> <4117B098.5020805@dark-reality.de>
    <1092073167.4564.26.camel@pegasus>
    <4117C0AB.2010609@superbug.demon.co.uk>
    <1092090364.4564.46.camel@pegasus> <41180E64.1010007@dark-reality.de>
    <1092140041.4564.96.camel@pegasus>
    <4118C562.1050300@superbug.demon.co.uk>
    <Pine.LNX.4.59.9999.0408101435250.22497@brava.dcs.gla.ac.uk>
    <4118DAF9.2080204@csr.com> <4118EEEB.4010602@superbug.demon.co.uk>
    <3A71B5F8-EAFD-11D8-A26F-000D932E1CC8@dcs.gla.ac.uk>
In-Reply-To: <3A71B5F8-EAFD-11D8-A26F-000D932E1CC8@dcs.gla.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 10 Aug 2004 20:22:14 +0100

Jonathan Paisley wrote:
> On 10 Aug 2004, at 16:51, James Courtier-Dutton wrote:
>> So, I suggest we might do better if we provide a number of different 
>> ways to get sound to bluetooth devices, in order of preference.
>> 1) PCM as Carl suggests
>> 2) Bypass HCI stack and send SCO direct to USB devices. I don't think 
>> one can do that for UART based devices. I don't know what is best for 
>> PCI devices, as I have not looked at the PCI source code. I 
>> concentrated on the USB source code when I tried before.
>> 3) Current HCI stack method. <- Last resort.
> Perhaps somebody with more bluetooth know-how can comment here, but:
> 
>  1) I thought PCM was for connection from the bluetooth chip to some 
> other hardware (e.g., a physical earpiece). That's not an option for 
> getting audio to the computer unless the device in question has some 
> funky other connection to the computer.

Correct.  Our BT chips all have a PCM port which routes one
or more audio streams directly to external chips (usually audio codecs),
so the audio packets don't flow over HCI.  (A SCO connection is
created, managed and destroyed over HCI, but the audio packets
run through the PCM port.)  The PCM port connection is usually
used in dedicated audio devices: cell phones, headsets, etc.

Some of our chips include an audio codec, so they can directly drive
a microphone and earpiece.  (The chips were designed to form the core
of a headset.)  In this case, the SCO packets never leave the chip.

As far as I've seen, all BT chip manufacturers provide a PCM port.
The manufacturers' PCM ports are, inevitably, manufacturer-specific,
though they should all have a common core of functionality.

>  2) Isn't the SCO-over-USB standard defined in terms of the HCI 
> protocol? How do you go about bypassing it?

I don't understand suggestion (2) above (HCI stack bypass).  The
"standard" BT stack loses interest in SCO at HCI - it doesn't travel
through L2CAP, etc.  One could conceive of routing an audio
sample stream to another device at, or just above, the host's USB
driver level.  But this feels awfully like the "last resort"
option (3).

Carl



**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

This footnote also confirms that this email message has been swept by
MIMEsweeper for the presence of computer viruses.

www.mimesweeper.com
**********************************************************************



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
