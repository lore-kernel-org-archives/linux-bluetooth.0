Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-Id: <1131966935.11561.247443316@webmail.messagingengine.com>
From: "manish Verma" <manishverma@fastmail.fm>
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
References: <1131964498.3323.77.camel@Linux.localdoman.com>
Subject: Re: [Bluez-devel] btsco headset almost works
In-Reply-To: <1131964498.3323.77.camel@Linux.localdoman.com>
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
Date: Mon, 14 Nov 2005 03:15:35 -0800

Hi,
what kind of wave file you are playing ? use aply --verbose -D
plughw:headset M1F1.wav ( you can get PCM coded wav files
M1F1-uint8WE-AFsp.wav from
http://www.tsp.ece.mcgill.ca/MMSP/Documents/AudioFormats/WAVE/Samples.html
).
Hope this helps.
Regards,
Manish

On Mon, 14 Nov 2005 04:34:58 -0600, "Steven Winston"
<spwinston@gmail.com> said:
> I'm trying to get btsco to work with my headset.  Thus far, I've managed
> to solve my first problem of having to reinstall ALSA libs; got
> everything to compile and run fine.  btsco even starts and looks to be
> running correctly.  HCIDUMP shows it connects correctly.
> When I go to play a sound file, the device makes a distinctive sound
> (incoming call style sound (wav file being played I guess corresponds to
> the same sound)) I can hear the speaker in the headset turn on.  When I
> stop playing a sound, the speaker turns off.  However, no sound is
> actually played.
> 
> 
> Anyone have a suggestion for what to try next?  Thanks in advance for
> any help.
> 
> I have a motorola HS820 and a CompUSA USB Bluetooth Adapter
> hciconfig -a
> hci0:   Type: USB
>         BD Address: 00:10:60:AE:74:1E ACL MTU: 377:10 SCO MTU: 16:0
>         UP RUNNING PSCAN ISCAN
>         RX bytes:14130 acl:314 sco:0 events:790 errors:0
>         TX bytes:8555 acl:307 sco:0 commands:244 errors:0
>         Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'CW Service'
>         Class: 0x500204
>         Service Classes:
>         Device Class: Phone, Cellular
>         HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver:
> 0x309
>         Manufacturer: Broadcom Corporation (15)
> 
> hcitool info 00:07:A4:47:B0:1D
> Requesting information ...
>         BD Address:  00:07:A4:47:B0:1D
>         Device Name: Motorola HS820
>         LMP Version: 1.2 (0x2) LMP Subversion: 0x525
>         Manufacturer: Cambridge Silicon Radio (10)
>         Features: 0xff 0xff 0x0b 0x00 0x08 0x08 0x00 0x00
>                 <3-slot packets> <5-slot packets> <encryption> <slot
> offset>
>                 <timing accuracy> <role switch> <hold mode> <sniff mode>
>                 <park state> <RSSI> <channel quality> <SCO link> <HV2
> packets>
>                 <HV3 packets> <u-law log> <A-law log> <CVSD> <paging
> scheme>
>                 <transparent SCO> <AFH cap. slave> <AFH cap. master>
> -- 
> Steven Winston <spwinston@gmail.com>
> spwinston@gmail.com
> 
> 
> 
> -------------------------------------------------------
> SF.Net email is sponsored by:
> Tame your development challenges with Apache's Geronimo App Server.
> Download
> it for free - -and be entered to win a 42" plasma tv or your very own
> Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel

-- 
http://www.fastmail.fm - mmm... Fastmail...



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
