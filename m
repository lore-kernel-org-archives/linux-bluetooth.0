Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45782179.6090305@csr.com>
Date: Thu, 07 Dec 2006 14:13:13 +0000
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <200612011448.32667.akohlsmith-bluez@benshaw.com>	<200612040855.29496.akohlsmith-bluez@benshaw.com>	<1165241266.12640.30.camel@localhost>
	<200612041031.06996.akohlsmith-bluez@benshaw.com>
In-Reply-To: <200612041031.06996.akohlsmith-bluez@benshaw.com>
Subject: Re: [Bluez-devel] "promiscuous mode" for hci devices?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Andrew Kohlsmith wrote:
> On Monday 04 December 2006 09:07, Marcel Holtmann wrote:
>> The radio, baseband and link manager are part of the Bluetooth chip and
>> not accessible via the host operating system.
> 
> That's what I was getting at; the device *does* see all communications, but 
> unless there is a method to flip on the equivalent of ethernet's promiscuous 
> mode, you'll never see anything not intended for you.  Your message suggests 
> that there is no HCI call to do this, which puts me out of luck.

No. Your assumptions are wrong. The device does *not* see all
communication, even with complete control of the baseband firmware,
putting a mass produced standard device into promiscuous mode is
impossible.

Your analogy between Ethernet and Bluetooth is flawed. Ethernet packets
are transmitted on a wire. Wires are quiet between packets. The signal
to noise ratio is good. This allows a device easily to identify the
start of any packet without knowing anything about the contents.

Bluetooth packets are transmitted on a radio. The signals you're looking
for are often not far off the noise level. This means you get random
data between packets. To avoid triggering on the noise you need to look
for a long sequence of bits. To reduce wastage, the sequence used is
related to part of the MAC address of the master. So, the only (easy)
way to know that the packet exists at all is to know the address being
used.

However, before you get that far, there's the problem of knowing which
channel to listen to. Bluetooth packets are spread over 79 frequencies.
The link hops between these, changing frequency for every packet. A
(standard) radio can be tuned to only one frequency at a time. So, in
your Ethernet analogy, imaging your Ethernet packets are coming down
79 wires in an almost random order. You have no custom hardware so you'd
have to switch those wires in and out of your Ethernet card in the right
order before each packet is received.

This is a very important point. You wrote that "any device in a shared
medium would by its very nature have to receive all messages". At best
an unsynchronised Bluetooth device gets just one seventh-nineth of all
messages into its radio and then has to worry about distinguishing
messages from noise.

Supposing you solve the frequency hopping problem - say by having an
array of 79 devices, one for each frequency - and the correlator
problem, you next have to contend with whitening. Each packet is
trivially scrambled to remove DC bias. The scrambling is simply related
to the Bluetooth clock, so can take one of 64 sequences. Bluetooth chips
are set up to know the sequence to use for each packet. They can't
simply try all of them.

Then, there are persistent changes to the state of a link. For example,
switching between basic rate and enhanced data rate changes the packet
format. A Bluetooth receiver has to know which mode to be in. It knows
because it was party to the LMP negotiation. A stateless promiscuous
sniffer would have to try both.

This gets you as far as knowing that a packet exists. In theory, all
the problems so far could be overcome with sufficient custom equipment,
but you're probably talking about a crate of FPGAs.

However, even if you were to assemble all that equipment, you will
fall over at the next hurdle: all non-trivial Bluetooth traffic is
encrypted specifically to prevent sniffing. Unless you know the
encryption keys for all traffic in the area you want to sniff, you're
doomed (this applies to normal Bluetooth sniffers to - you have to
get the encryption keys into them somehow).

The best you could do with a standard dongle, albeit with modified
firmware, is to report all the unencrypted traffic in a single
piconet. However, that's a lot less than a promiscuous mode.

Man in the middle attacks are different. In this case, the man in
the middle wants to intercept the traffic for just one connection.
This is much closer to the sniffer problem and doesn't require being
promiscuous. It would still require firmware modification.

	- Steven
-- 


To access the latest news from CSR copy this link into a web browser:  http://www.csr.com/email_sig.php

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
