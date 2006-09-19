Return-Path: <bluez-users-bounces@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: joakim@verona.se
Date: Tue, 19 Sep 2006 14:55:52 +0200
Message-ID: <m3ac4wt3qf.fsf@kurono.home>
References: <m33bapwl0u.fsf@kurono.home> <450F208F.4080204@xmission.com>
	<m34pv4ux3e.fsf@kurono.home> <m3venkt9uk.fsf@kurono.home>
	<450FDFC9.6060804@palmsource.com> <m3eju8t4f2.fsf@kurono.home>
Mime-Version: 1.0
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

joakim@verona.se writes:

> Fr=E9d=E9ric DALLEAU <frederic.dalleau@palmsource.com> writes:
>
>
>
>> Hi,
>> plugin type is a2dpd
>>
>> pcm.headphone {
>>               type a2dpd   <------------------here
>>               bdaddr "00:16:B8:0E:8B:15"
>> }
>
> Thanks for spotting this!
>
> Some problems remains:
> - the sound is much "choppier" than with a2play
> I suspect this line from a2dpd output:
> setscheduler returns -1 (errno=3D1:Operation not permitted)
>
> must I run a2dpd as root?
>
> - I only get sound in 1 earpiece, the sound is very soft in the other one.

Forgot:
the "cmd" definitions doesnt seem to do anything!

>
>> Fr=E9d=E9ric
>>
>>
>>
>> joakim@verona.se a =E9crit :
>>> joakim@verona.se writes:
>>>
>>> I tried the a2dpd daemon as per Brad:s suggestion, but Im having
>>> difficulties. The build and install went ok.
>>>
>>> This is my configuration:
>>> ~/.asoundrc
>>> pcm.headphone {
>>>               type a2dp
>>>               bdaddr "00:16:B8:0E:8B:15"
>>> }
>>>
>>> ~/.a2dprc
>>> [a2dpd]
>>> address=3D00:16:B8:0E:8B:15
>>> cmdplay=3Decho play
>>> cmdnext=3Decho next
>>> cmdpause=3Decho pause
>>> cmdprev=3Decho prev
>>> cmdnew=3Decho cmdnew
>>> logfile=3D/tmp/a2dpdlog
>>>
>>> then I start a2dpd
>>>
>>> then I test with:
>>> mplayer -ao alsa:device=3Dheadphone 01.mp3
>>>
>>> alsa-init: using device headphone
>>> DEBUG: _snd_pcm_a2dp_open: name headphone mode 0
>>> DEBUG: _snd_pcm_a2dp_open: bdaddr/dest is 00:16:B8:0E:8B:15
>>> DEBUG: a2dp_alloc: init
>>> DEBUG: a2dp_connect: a2dp 0xa3b75b8 (sk=3D0, control_sk=3D0)
>>> DEBUG: connect_stream: Using address: 15:8B:0E:B8:16:00
>>> DEBUG: detect_a2dp: Found A2DP Sink
>>> DEBUG: connect_stream: Found A2DP Sink at the destination
>>> DEBUG: do_connect: Connected [imtu 672, omtu 672, flush_to 65535]
>>> DEBUG: connect_stream: Sent the Stream End Point Discovery Command
>>> DEBUG: connect_stream: couldn't get avdtp_discover
>>>
>>> So something goes wrong
>>>
>>> a2dpd has this to say:
>>> a2dpd
>>> Cannot open /dev/input/uinput: No such file or directory
>>> a2dpd [Sep 19 2006 11:50:59] starting ...a2dpd addr=3D00:16:B8:0E:8B:15
>>> timer=3D4000 us [Sep 19 2006 11:50:59]
>>> setscheduler returns -1 (errno=3D1:Operation not permitted)
>>> main_thread:Accepting incoming tcp stream connection
>>> New connection to bluetooth [44100 hz]
>>> avrcp: Accepting incoming connection
>>> avdtp: Accepting incoming connection
>>>
>>>
>>> the device works in stereo with a2dplay
>>>
>>>
>>>   =

>>>> Brad Midgley <bmidgley@xmission.com> writes:
>>>>
>>>>     =

>>>>> joakim
>>>>>
>>>>>       =

>>>>>> I'm using my HBH-DS970 headset with a2play, and it works nicely.
>>>>>> However, I would also like o use the daemon functionality of the bts=
co
>>>>>> key daemon at the same time, so as to control playback with the
>>>>>> headset butons. Is this possible?
>>>>>>         =

>>>>> well it might be possible for you to hack something together using the
>>>>> btsco settings file.
>>>>>
>>>>> if your headset supports avrcp, you should be able to use the alsa
>>>>> plugin and a2dpd daemon to control playback. that would be more flexi=
ble.
>>>>>       =

>>>> According to the docs I need a2play to play stereo, since the
>>>> HBH-DS970 supports stereo. Has this requirement changed? It would be
>>>> much nicer wih a proper alsa device of course.
>>>>
>>>>     =

>>>>> brad
>>>>>
>>>>> ---------------------------------------------------------------------=
----
>>>>> Take Surveys. Earn Cash. Influence the Future of IT
>>>>> Join SourceForge.net's Techsay panel and you'll get the chance to sha=
re your
>>>>> opinions on IT & business topics through brief surveys -- and earn ca=
sh
>>>>> http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CI=
D=3DDEVDEV>>>>>> -- =

>>>> Joakim Verona
>>>> http://www.verona.se>>>>>
>>>> ----------------------------------------------------------------------=
---
>>>> Take Surveys. Earn Cash. Influence the Future of IT
>>>> Join SourceForge.net's Techsay panel and you'll get the chance to shar=
e your
>>>> opinions on IT & business topics through brief surveys -- and earn cash
>>>> http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=
=3DDEVDEV>>>>
>>>   =

>>
>>
>> -------------------------------------------------------------------------
>> Take Surveys. Earn Cash. Influence the Future of IT
>> Join SourceForge.net's Techsay panel and you'll get the chance to share =
your
>> opinions on IT & business topics through brief surveys -- and earn cash
>> http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=
=3DDEVDEV
>
> -- =

> Joakim Verona
> http://www.verona.se
>
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share y=
our
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDEV

-- =

Joakim Verona
http://www.verona.se


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
