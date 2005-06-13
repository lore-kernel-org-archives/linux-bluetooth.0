Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42ACD129.2060506@lesagepono.be>
From: Laurent Lesage <laurent@lesagepono.be>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] pairing plantronics M3000 with my laptop SOLVED
References: <42AA0EED.9060104@lesagepono.be> <42AA5C31.2040009@xmission.com> <42AB720D.20806@lesagepono.be> <42AC42C1.7050903@lesagepono.be> <42ACAE93.3050200@xmission.com>
In-Reply-To: <42ACAE93.3050200@xmission.com>
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
Date: Mon, 13 Jun 2005 00:19:53 +0000

Hi Brad,

In fact, it works.... something to do with reboot... A service to=20
restart??? I just restarted the computer, after a small reboot with XP=20
to use the headset for Skype :-(. Just "modeprobed" snd_bt_sco and=20
emu10k1 and ... the sound was here! I just use /dev/dsp1. XMMS works=20
fine (in mono). just a small (half a second you said?) delay when I use=20
the volume control on xmms. I also used my IAX client, to record=20
parameters for voicemail box : no problem (in fact, that's the only=20
recorder I used on Linux). Used with skype : first "echotest" trial gave=20
horrible recording. Second trial ok (??). After that, ok.

So, I will redo all the trip on another computer and try to describe all=20
the steps for a config like mine. Finally, as often, the job made  by=20
the Debian team is really great. Every tool is easily installed and,=20
thank to the job of  bluez, blue-alsa, it works well.

I don't see if alsa is necessary, because I installed alsa afterwards=20
and continue using OSS in the sound applications. But I don't know if it=20
is integrated in the kernel. As the debian packages are available=20
separately, I suppose it is not, but I'm not sure.

I will try later the project with bluetooth channel and asterisk.

see you soon

Laurent Lesage
Brad Midgley a =E9crit :

> Hi
>
> I suspect a volume problem (try using a soft mixer on your computer=20
> and try volume controls on the headset)
>
> or sco routing; as root run
>  hciconfig hci0 revision
> and see if sco is routed to hci as it should be
>
> It's possible that Marcel's new pskey program can reroute sco but I=20
> haven't tried that.
>
> Brad
>
> Laurent Lesage wrote:
>
>> Laurent Lesage a =E9crit :
>>
>>> Thanks : that works!
>>>
>>>> Brad Midgley a =E9crit : I would try removing /etc/bluetooth/link_ke=
y=20
>>>> so the pairing will be reset.
>>>>
>>>
>> Hi again...
>>
>> well, now it seems to work, but I have no sound : it is like the=20
>> voice packet are not sent to the headset.
>>
>> 1) info about the headset
>>
>>> laptop:/usr/local/btsco/btsco/kernel# hcitool info 00:03:89:4C:2D:C7
>>> Requesting information ...
>>>         BD Address:  00:03:89:4C:2D:C7
>>>         Device Name: M3000 by Plantronics
>>>         LMP Version: 1.1 (0x1) LMP Subversion: 0x349
>>>         Manufacturer: Cambridge Silicon Radio (10)
>>>         Features: 0xbc 0xe8 0x01 0x00 0x00 0x00 0x00 0x00
>>>                 <encryption> <slot offset> <timing accuracy> <role=20
>>> switch>
>>>                 <sniff mode> <SCO link> <HV3 packets> <u-law log>=20
>>> <A-law log>
>>>                 <CVSD>
>>
>>
>>
>>
>> 2)BTSCO :
>>
>>> laptop:/usr/local/btsco/btsco/kernel# btsco -v
>>> btsco v0.4c
>>> Device is 1:0
>>
>>
>>
>> 3)dongle :
>>
>>> laptop:/usr/local/btsco/btsco/kernel# hciconfig -a
>>> hci0:   Type: USB
>>>         BD Address: 00:E0:98:FD:9A:BD ACL MTU: 192:8 SCO MTU: 64:8
>>>         UP RUNNING PSCAN ISCAN
>>>         RX bytes:5979 acl:196 sco:0 events:286 errors:0
>>>         TX bytes:3492 acl:147 sco:0 commands:80 errors:0
>>>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>>>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>>>         Link policy: RSWITCH HOLD SNIFF PARK
>>>         Link mode: SLAVE ACCEPT
>>>         Name: 'laptop-0'
>>>         Class: 0x3e0100
>>>         Service Classes: Networking, Rendering, Capturing
>>>         Device Class: Computer, Uncategorized
>>>         HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP=20
>>> Subver: 0x20d
>>>         Manufacturer: Cambridge Silicon Radio (10)
>>>
>> Using Debian Sarge, with a patch for bluez from march 2005. Got btsco=20
>> form cvs. Compiled without error. Seems running ok. When using XMMS,=20
>> I see a second audio device "bluetooth headset", I see it with alsa=20
>> and with OSS output plugin. If I try to play a song with XMMS, I hear=20
>> a "beep" indicating the activation of the SCO channel. I can see it=20
>> with "btsco -v", verbose mode. I also can adjust the volume of my=20
>> headset : it's echoed on the output of btsco. On the other side, if I=20
>> use the oss mixer, I hear a small beep in the headset and see that=20
>> the volume is changed accordingly to the mixer on the computer. Same=20
>> for microphone.
>>
>> So (I'm BT newbie...), the "signalling" seems to work perfect *BUT*=20
>> no voice packet are sent. HCIdump shows the "signalling packets" but=20
>> after that, no other packet. with XMMS, if I "play", the song remains=20
>> still (time stops). Just the beep in my ear to say that the channel=20
>> is opened (I hear the same under WinXP when I accept to "connect" the=20
>> headset, pushing on the "answer" button of the headset), and another=20
>> beep when I stop the song and thus, "disconnect" the SCO channel=20
>> (again, I see all that with btsco -v and hcidump).
>>
>> When I will get it , I will resume the whole thing for configs like=20
>> mine. Help me get the sound work :-(
>>
>> thanks
>>
>> Laurent
>>
>>
>>
>> -------------------------------------------------------
>> This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you=20
>> shotput
>> a projector? How fast can you ride your desk chair down the office=20
>> luge track?
>> If you want to score the big prize, get to know the little guy.  Play=20
>> to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
>> _______________________________________________
>> Bluez-users mailing list
>> Bluez-users@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/bluez-user
>> s
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you=20
> shotput
> a projector? How fast can you ride your desk chair down the office=20
> luge track?
> If you want to score the big prize, get to know the little guy.  Play=20
> to win an NEC 61" plasma display: http://www.necitguy.com/?r=3D20
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
