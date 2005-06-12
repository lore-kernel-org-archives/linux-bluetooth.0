Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42AC42C1.7050903@lesagepono.be>
From: Laurent Lesage <laurent@lesagepono.be>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] pairing plantronics M3000 with my laptop
References: <42AA0EED.9060104@lesagepono.be> <42AA5C31.2040009@xmission.com> <42AB720D.20806@lesagepono.be>
In-Reply-To: <42AB720D.20806@lesagepono.be>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 12 Jun 2005 14:12:17 +0000

Laurent Lesage a =E9crit :

> Thanks : that works!
>
>> Brad Midgley a =E9crit : I would try removing /etc/bluetooth/link_key=20
>> so the pairing will be reset.
>>
>
Hi again...

well, now it seems to work, but I have no sound : it is like the voice=20
packet are not sent to the headset.

1) info about the headset

> laptop:/usr/local/btsco/btsco/kernel# hcitool info 00:03:89:4C:2D:C7
> Requesting information ...
>         BD Address:  00:03:89:4C:2D:C7
>         Device Name: M3000 by Plantronics
>         LMP Version: 1.1 (0x1) LMP Subversion: 0x349
>         Manufacturer: Cambridge Silicon Radio (10)
>         Features: 0xbc 0xe8 0x01 0x00 0x00 0x00 0x00 0x00
>                 <encryption> <slot offset> <timing accuracy> <role swit=
ch>
>                 <sniff mode> <SCO link> <HV3 packets> <u-law log>=20
> <A-law log>
>                 <CVSD>


2)BTSCO :

> laptop:/usr/local/btsco/btsco/kernel# btsco -v
> btsco v0.4c
> Device is 1:0

3)dongle :

> laptop:/usr/local/btsco/btsco/kernel# hciconfig -a
> hci0:   Type: USB
>         BD Address: 00:E0:98:FD:9A:BD ACL MTU: 192:8 SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN
>         RX bytes:5979 acl:196 sco:0 events:286 errors:0
>         TX bytes:3492 acl:147 sco:0 commands:80 errors:0
>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'laptop-0'
>         Class: 0x3e0100
>         Service Classes: Networking, Rendering, Capturing
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP=20
> Subver: 0x20d
>         Manufacturer: Cambridge Silicon Radio (10)
>
Using Debian Sarge, with a patch for bluez from march 2005. Got btsco=20
form cvs. Compiled without error. Seems running ok. When using XMMS, I=20
see a second audio device "bluetooth headset", I see it with alsa and=20
with OSS output plugin. If I try to play a song with XMMS, I hear a=20
"beep" indicating the activation of the SCO channel. I can see it with=20
"btsco -v", verbose mode. I also can adjust the volume of my headset :=20
it's echoed on the output of btsco. On the other side, if I use the oss=20
mixer, I hear a small beep in the headset and see that the volume is=20
changed accordingly to the mixer on the computer. Same for microphone.

So (I'm BT newbie...), the "signalling" seems to work perfect *BUT* no=20
voice packet are sent. HCIdump shows the "signalling packets" but after=20
that, no other packet. with XMMS, if I "play", the song remains still=20
(time stops). Just the beep in my ear to say that the channel is opened=20
(I hear the same under WinXP when I accept to "connect" the headset,=20
pushing on the "answer" button of the headset), and another beep when I=20
stop the song and thus, "disconnect" the SCO channel (again, I see all=20
that with btsco -v and hcidump).

When I will get it , I will resume the whole thing for configs like=20
mine. Help me get the sound work :-(

thanks

Laurent



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
