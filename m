Return-Path: <bluez-users-bounces@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: joakim@verona.se
Date: Tue, 19 Sep 2006 17:20:26 +0200
Message-ID: <m3venjsx1h.fsf@kurono.home>
References: <m33bapwl0u.fsf@kurono.home> <450F208F.4080204@xmission.com>
	<m34pv4ux3e.fsf@kurono.home> <m3venkt9uk.fsf@kurono.home>
	<450FDFC9.6060804@palmsource.com> <m3eju8t4f2.fsf@kurono.home>
	<m3ac4wt3qf.fsf@kurono.home> <450FEBAA.1060005@palmsource.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Subject: Re: [Bluez-users] a2play and btsco questions
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--=-=-=
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Frédéric DALLEAU <frederic.dalleau@palmsource.com> writes:

>>> Some problems remains:
>>> - the sound is much "choppier" than with a2play
>>>     
> It should not be that bad, try another audio player ( 
> xmms/amarok/xine/mpg321 )
>>> I suspect this line from a2dpd output:
>>> setscheduler returns -1 (errno=1:Operation not permitted)
>>>
>>> must I run a2dpd as root?
>>>     
> not necessary but can help as it increase priority
>>> - I only get sound in 1 earpiece, the sound is very soft in the other one.
>>>     
> bug, use sample.a2dprc as a base
> revert the value used for enablereversestereo (1 instead of 0)

Thanks, I didnt notice this file.

>> Forgot:
>> the "cmd" definitions doesnt seem to do anything!
>>   
> Does your headset support AVRCP ? sdptool browse "ad:dr:ess"

Im not sure how to interpret it. I attach the output.
--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=headsetcap

Browsing 00:16:B8:0E:8B:15 ...
Service Name: SonyEricsson Remote Control Service
Service RecHandle: 0x10301
Service Class ID List:
  "AV Remote" (0x110e)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 23
  "AVCTP" (0x0017)
    uint16: 0x100
Profile Descriptor List:
  "AV Remote" (0x110e)
    Version: 0x0100

Service Name: SonyEricsson Remote Control Service
Service RecHandle: 0x10302
Service Class ID List:
  "AV Remote Target" (0x110c)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 23
  "AVCTP" (0x0017)
    uint16: 0x100
Profile Descriptor List:
  "AV Remote" (0x110e)
    Version: 0x0100

Service Name: SonyEricsson Audio Service
Service RecHandle: 0x10303
Service Class ID List:
  "Audio Sink" (0x110b)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 25
  "AVDTP" (0x0019)
    uint16: 0x100
Profile Descriptor List:
  "Advanced Audio" (0x110d)
    Version: 0x0100

Service Name: SEMC HLA
Service RecHandle: 0x10501
Service Class ID List:
  "" (0x8e771301)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 61689
  "" (0x8e770300)
Profile Descriptor List:

Service Name: SonyEricsson Headset Service
Service RecHandle: 0x10002
Service Class ID List:
  "Headset" (0x1108)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 1
Profile Descriptor List:
  "Headset" (0x1108)
    Version: 0x0100

Service Name: SonyEricsson HandsfreeService
Service RecHandle: 0x10003
Service Class ID List:
  "Handsfree" (0x111e)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 2
Profile Descriptor List:
  "Handsfree" (0x111e)
    Version: 0x0102


--=-=-=
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit



> Frédéric
>
>
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV

-- 
Joakim Verona
http://www.verona.se

--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--=-=-=--
