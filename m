Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41FE76DA.6000201@tootai.net>
From: administrator tootai <admin@tootai.net>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Re: Connection issue with headset
References: <41FA06A5.3010904@tootai.net> <ctdn6n$sqs$1@sea.gmane.org>	 <41FE4744.5010804@tootai.net> <1107183514.7902.13.camel@pegasus>	 <41FE4F1F.9080201@tootai.net> <1107186911.7902.16.camel@pegasus>
In-Reply-To: <1107186911.7902.16.camel@pegasus>
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
Date: Mon, 31 Jan 2005 19:20:10 +0100

Marcel Holtmann a =E9crit :

>Hi Daniel,
>
> =20
>
>>>what is in /proc/bus/usb/devices? I think that this dongle don't has t=
he
>>>needed USB ISOC endpoints for SCO data.
>>>=20
>>>
>>>     =20
>>>
>>This is not a dongle output, it's the headset one. Here is the output o=
f=20
>>devices.
>>   =20
>>
>
>then forget what I said. You have a CSR dongle with HCI 16.4 and this
>should work fine.
> =20
>
Then is it normal that hcitool scan <btaddr> doesn't find the headset as=20
hcitool info <btaddr> is ok? Meanwhile, I CVS the latest btsco, rebuild=20
everything and tested with the mpg123 sample with a2play. Here the=20
result from output:

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

Many thanks for your help.
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
