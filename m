Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4200D3B6.1050708@tootai.net>
From: administrator tootai <admin@tootai.net>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Re: Connection issue with headset
References: <41FA06A5.3010904@tootai.net> <ctdn6n$sqs$1@sea.gmane.org> <41FE4744.5010804@tootai.net> <ctob73$ph0$1@sea.gmane.org>
In-Reply-To: <ctob73$ph0$1@sea.gmane.org>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
Date: Wed, 02 Feb 2005 14:20:54 +0100

Sebastian Roth a =E9crit :

> Hi Daniel,

Hi Sebastian

>
>>>> nomade:/home/dh# btsco 00:0b:2e:06:01:2e
>>>> Device is 1:0
>>>> Voice setting: 0x0060
>>>> RFCOMM channel 6 connected
>>>
>>>
>>>
>>> You have to press the headset button now!
>>
> I wanted to say that you have to press the button like on a cd-player.
> First turn on your cd-player or headset ;-) then start btsco and now
> push the button once more!

Did not help. I made following:

- modprobe snd-bt-sco
- headset is switch off
- btsco 00:0b:2e:06:01:2e
Device is 1:0
Failed to connect to SDP server: Host is down
Assuming channel 2
- I swith on headset, information above is completed by
Voice setting: 0x0060
RFCOMM channel 2 connected

So there is communication between my usb BT adapter and the BT Headset.=20
But still nothing more. When I run

mpg123 --au - <MySongFile>.mp3 | /usr/src/btsco/sbc/sbcenc - |=20
/usr/src/btsco/a2play 00:0b:2e:06:01:2e

still have

MPEG 1.0 layer III, 128 kbit/s, 44100 Hz joint-stereo
subbands =3D 1
allocation method =3D 1
channel_mode =3D 2
blocks =3D 3
sampling frequency =3D 2
bitpool =3D 32
frame len =3D 72
Using address: 00:0b:2e:06:01:2e
Can't connect to 2E:01:06:2E:0B:00. Invalid argument(22)
cannot open psm_cmd =3D 0

> [...]
> My headset has a so called "scan mode". I have to turn it off and press
> the button for a long time. Now the LED is blinking alternately red and
> green. Only in this mode it show's up on hcitool scan! btw no address
> is needed when scanning for devices.
> $ hcitool scan

Ok, this I got. It's the same manipulation as if you want to enter the=20
PIN code for pairing. And I got:
nomade:# hcitool scan
Scanning ...
        00:0B:2E:06:01:2E       BT1000

So everything concerning connection seems to be fine but I still can't=20
see any traffic going through! Has someone an idea on what is this=20
invalid argument error (22) with a2play?

Thanks for your help

--=20
Daniel


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
