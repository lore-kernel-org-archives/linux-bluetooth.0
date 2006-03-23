Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Mitja Pufic <m@section-one.org>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] btsco not working with 3Com 3CREB96 and SE HBH-602
In-Reply-To: <4422851C.6020900@runbox.com>
Message-ID: <Pine.LNX.4.61.0603231619010.25910@cherokee.spacecom.si>
References: <4422851C.6020900@runbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 23 Mar 2006 16:22:56 +0100 (CET)

Hello,

This is a very old dongle, with bluecore01 and confirms with bluetooth 
1.0b specification. And as far as I know it has SCO mapped to PCM and not 
HCI, so this is the reason, why your setup is not working. Check mail 
list archive how to change this, or if it is even possible on this old 
chip. PCMCIA version does not have this problem.

br, Mitja

On Thu, 23 Mar 2006, Tom K wrote:

> First post here, not a developer, but I'm posting here as advised on the
> bluetooth-alsa site.
> 
> I have a 3Com 3CREB96 USB dongle and a SonyEricsson HBH-602 headset. I have
> the following installed on the laptop:
> 
> kernel 2.6.15
> bluez-libs 2.25
> bluez-utils 2.25
> bluez-hcidump 1.29
> btsco 0.41
> 
> Bluetooth daemons are running, snd-bt-sco is loaded, hci0 is up, with the
> voice 0x0060 setting. The devices are paired successfully. I now run btsco -v
> A1:B2:C3:D4:E5:F6, and get the following response:
> 
> btsco v0.41
> Device is 1:0
> Voice setting: 0x0060
> RFCOMM channel 1 connected
> recieved AT*ECBP=?
> recieved AT+CLIP=1
> recieved AT+CSCS="UTF-8"
> recieved AT+CLAN?
> 
> In another terminal, I try aplay -B 1000000 -D plughw:Headset test.wav, and
> the following is added in the btsco terminal:
> 
> i/o needed: connecting sco...
> Can't connect SCO audio channel
> : Connection refused
> 
> I shut down btsco, and after nearly 30 seconds, I hear a single beep in the
> headset. I run btsco again as above, with the same initial response, and run
> aplay again. This time, the sound file plays through the headset, and btsco
> shows the following:
> 
> i/o needed: connecting sco...
> connected SCO channel
> Done setting sco fd
> recieved AT+VGS=12
> Sending up speaker change 12
> speaker volume: 12 mic volume: 11
> driver is not in use
> disconnected SCO channel
> RFCOMM channel lost
> 
> btsco then shuts itself down.
> 
> All the above is consistently reproducable. Also, the same responses are seen
> if arecord is used instead of aplay, except of course that a file is recorded
> instead of played on the second attempt.
> 
> About a year ago, I had the same headset working correctly with btsco and a
> 3Com BT PCMCIA card, which I unfortunately can no longer use.
> 
> If more info is required - hcidump, logs, etc - let me know. I am aware that
> this is a dev list, so I will understand completely if nobody is interested.
> 
> All the best
> Tom K.
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by xPML, a groundbreaking scripting language
> that extends applications into web and mobile media. Attend the live webcast
> and join the prime developer group breaking into this new coding territory!
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
> 


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
