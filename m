Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4939BB42.1080607@slackdot.org>
References: <4939BB42.1080607@slackdot.org>
Date: Sat, 06 Dec 2008 22:16:47 +0100
Message-Id: <1228598207.28839.49.camel@violet.holtmann.net>
Mime-Version: 1.0
Cc: steve@sparta.com
Subject: Re: [Bluez-devel] Continued SCO audio issues...
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Rob,

> I posted a while back about having some issues getting SCO audio to work 
> on some Compulab em-x270 boards. Well, we're still not there, but we've 
> tried a lot more things. I'm going to describe the problem in some more 
> detail now in the hopes that somebody here can help point me in a 
> direction to get this working.
> 
> Symptoms:
> 
>   - Everything involved (bt headset, ALSA, aplay/mplayer/pulseaudio, 
> etc) seems to think everything is working.
>   - No sound comes out of the headset. We hear a hissing from the 
> headset during actual audio playback (or when I have pulseaudio talking 
> to it via 'module-alsa-sink' and the sink is not suspended).
> 
> Config(s) Tested:
> 
>  - Kernels: 2.6.23, 2.6.26, 2.6.27
>  - Bluez: 3.26, 3.36, 4.12, 4.18
>  - ALSA drivers: as shipped w/ kernels above
> 
> We've been through about every possible combination of the above. We've 
> tried hci_usb and btusb. We've tested with 3 models of bt headset and 2 
> development boards. For some reason, the ONLY place I can make SCO audio 
> work is under a stock Ubuntu 8.10 (which uses Bluez 4.12, kernel 2.6.27, 
> and ALSA 1.0.17 for the record).
> 
> I'm stumped. Here is some sample output from various pieces as we try to 
> play a file. Right now we're using Bluez 3.36 (getting 4.x running on 
> this platform was a bit of a PITA and was somewhat unstable so we backed 
> out to what currently ships with openembedded)
> 
> We've tried with separate USB dongles (using the same chipset, that 
> works under Ubuntu 8.10) so it's not the onboard BT chipset...
> 
> # hciconfig hci0 version
> hci0:    Type: USB
>     BD Address: 00:02:5B:00:A5:A5 ACL MTU: 310:10 SCO MTU: 64:8
>     HCI Ver: 2.0 (0x3) HCI Rev: 0xc5c LMP Ver: 2.0 (0x3) LMP Subver: 0xc5c
>     Manufacturer: Cambridge Silicon Radio (10)
> 
> # hciconfig hci0 revision
> hci0:    Type: USB
>     BD Address: 00:02:5B:00:A5:A5 ACL MTU: 310:10 SCO MTU: 64:8
>     Unified 21e
>     Chip version: BlueCore4-ROM
>     Max key size: 128 bit
>     SCO mapping:  PCM

you never thought that routing the SCO packets via the chips internal
PCM (instead of HCI) might be a problem if you wanna use ALSA?

Regards

Marcel



------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
