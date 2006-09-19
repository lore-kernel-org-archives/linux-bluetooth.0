Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <450FEBAA.1060005@palmsource.com>
Date: Tue, 19 Sep 2006 15:07:54 +0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?= <frederic.dalleau@palmsource.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <m33bapwl0u.fsf@kurono.home>
	<450F208F.4080204@xmission.com>	<m34pv4ux3e.fsf@kurono.home>
	<m3venkt9uk.fsf@kurono.home>	<450FDFC9.6060804@palmsource.com>
	<m3eju8t4f2.fsf@kurono.home> <m3ac4wt3qf.fsf@kurono.home>
In-Reply-To: <m3ac4wt3qf.fsf@kurono.home>
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
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


>> Some problems remains:
>> - the sound is much "choppier" than with a2play
>>     =

It should not be that bad, try another audio player ( =

xmms/amarok/xine/mpg321 )
>> I suspect this line from a2dpd output:
>> setscheduler returns -1 (errno=3D1:Operation not permitted)
>>
>> must I run a2dpd as root?
>>     =

not necessary but can help as it increase priority
>> - I only get sound in 1 earpiece, the sound is very soft in the other on=
e.
>>     =

bug, use sample.a2dprc as a base
revert the value used for enablereversestereo (1 instead of 0)
> Forgot:
> the "cmd" definitions doesnt seem to do anything!
>   =

Does your headset support AVRCP ? sdptool browse "ad:dr:ess"

Fr=E9d=E9ric



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
