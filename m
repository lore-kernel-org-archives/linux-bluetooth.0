Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <BAY117-W237C70C2335D64377F116FC09E0@phx.gbl>
From: "" <semiyd@hotmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Thu, 18 Oct 2007 03:14:37 +0000
In-Reply-To: <BAY117-W28F4B89B2868D45873A26CC09E0@phx.gbl>
References: <BAY117-W36EE4B29F3D4550A7C9847C09E0@phx.gbl>
	<d89ddf300710171849p3cd9da02kb7488387e095b534@mail.gmail.com>
	<BAY117-W28F4B89B2868D45873A26CC09E0@phx.gbl>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] SCO connection timed out issue
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1006924193=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1006924193==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


PS:  the debug information from "aplay -D bluetooth /1.wav " indicates that the audio service(audio[326], that is /lib/bluetooth/bluetoothd-service-audio) is killed .

don't know why.........



> From: semiyd@hotmail.com
> To: bluez-devel@lists.sourceforge.net
> Date: Thu, 18 Oct 2007 02:46:06 +0000
> Subject: Re: [Bluez-devel] SCO connection timed out issue
>
>
> Brad:
>
> thanks for the hint!
> According to what u mentioned , i read about the page:http://wiki.bluez.org/wiki/HOWTO/AudioDevices
> which says"Note: you will not need bluetooth-alsa, plugz, btsco or the like for audio to work. They are obsolete."
> So it seems i shoud get rid of all the btsco,plugz stuff.
> After i deleted btsco/plugz,then what kind of command should i use?
> i tried "aplay -D bluetooth /1.wav "(which has nothing to do with btsco or plugz)and get this:
>
> \ $ aplay -D bluetooth /1.wav
> audio[326]: Accepted new client connection on unix socket (fd=8)
> audio[326]: Package PKT_TYPE_CFG_REQ:0
> hcid[318]: /org/bluez: org.bluez.Manager.FindAdapter()
> audio[326]: Got path /org/bluez/hci0 for adapter with address 00:80:E1:00:00:00
> hcid[318]: /org/bluez/hci0: org.bluez.Adapter.GetRemoteServiceHandles()
> hcid[318]: no matching session found. creating a new one
> hcid[318]: sdp session added to cache
> hcid[318]: /org/bluez/hci0: org.bluez.Adapter.GetRemoteServiceHandles()
> hcid[318]: found matching session, removing from list
> hcid[318]: sdp session added to cache
> hcid[318]: /org/bluez/hci0: org.bluez.Adapter.GetRemoteServiceHandles()
> hcid[318]: found matching session, removing from list
> hcid[318]: sdp session added to cache
> hcid[318]: /org/bluez/hci0: org.bluez.Adapter.GetRemoteServiceRecord()
> hcid[318]: found matching session, removing from list
> hcid[318]: sdp session added to cache
> hcid[318]: /org/bluez/hci0: org.bluez.Adapter.GetRemoteServiceRecord()
> hcid[318]: found matching session, removing from list
> hcid[318]: sdp session added to cache
> hcid[318]: /org/bluez/hci0: org.bluez.Adapter.GetRemoteServiceRecord()
> hcid[318]: found matching session, removing from list
> hcid[318]: sdp session added to cache
> hcid[318]: /org/bluez/hci0: org.bluez.Adapter.GetRemoteServiceRecord()
> hcid[318]: found matching session, removing from list
> hcid[318]: sdp session added to cache
> audio[326]: Audio service discovery completed with success
> hcid[318]: /org/bluez/hci0: org.bluez.Adapter.FinishRemoteServiceTransaction()
> hcid[318]: found matching session, removing from list
> audio[326]: Found Hansfree record
> audio[326]: Discovered Headset service on RFCOMM channel 1
> audio[326]: Found Headset record
> audio[326]: Found Audio Sink
> audio[326]: Selecting default device
> audio[326]: avdtp_ref(0x3b018): ref=2
> audio[326]: a2dp_source_request_stream: selected SEP 0x37250
> audio[326]: avdtp_ref(0x3b018): ref=3
> hcid[318]: link_key_request (sba=00:80:E1:00:00:00, dba=00:0D:3C:EB:53:F0)
> audio[326]: AVDTP: connected signaling channel to 00:0D:3C:EB:53:F0
> audio[326]: session_cb
> audio[326]: DISCOVER request succeeded
> audio[326]: seid 1 type 1 media 0 in use 0
> audio[326]: seid 2 type 1 media 0 in use 0
> audio[326]: session_cb
> audio[326]: GET_CAPABILITIES request succeeded
> audio[326]: seid 1 type 1 media 0
> hcid[318]: link_key_request (sba=00:80:E1:00:00:00, dba=00:0D:3C:EB:53:F0)
> hcid[318]: link_key_request (sba=00:80:E1:00:00:00, dba=00:0D:3C:EB:53:F0)
> audio[326]: session_cb
> audio[326]: GET_CAPABILITIES request succeeded
> audio[326]: seid 2 type 1 media 0
> audio[326]: Discovery complete
> audio[326]: avdtp_set_configuration(0x3b018): int_seid=1, acp_seid=1
> audio[326]: session_cb
> audio[326]: SET_CONFIGURATION request succeeded
> audio[326]: SBC Source: Set_Configuration_Cfm
> audio[326]: avdtp_ref(0x3b018): ref=4
> audio[326]: stream state changed: IDLE -> CONFIGURED
> audio[326]: session_cb
> audio[326]: OPEN request succeeded
> audio[326]: stream state changed: CONFIGURED -> OPEN
> audio[326]: AVDTP: connected transport channel to 00:0D:3C:EB:53:F0
> audio[326]: SBC Source: Open_Cfm
> audio[326]: session_cb
> audio[326]: START request succeeded
> audio[326]: SBC Source: Start_CAlignment trap: bluetoothd-serv (326) PC=0x0001be44 Instr=0xe1c320b0 Address=0xbec85c2d FSR 0x813
> fm
> audio[326]: SBC Source SEP 0x37250 locked
> aplay: main:550: audio open error: Input/output error
> hcid[318]: Service owner exited: :1.2
> hcid[318]: Audio service (audio) was killed by signal 7
> hcid[318]: link_key_request (sba=00:80:E1:00:00:00, dba=00:0D:3C:EB:53:F0)
>
> some kind of Input/output error.... any ideas?
>
>
>
>
> thanks in advance!
>
>
> semiyd
>
>
>> Date: Wed, 17 Oct 2007 19:49:57 -0600
>> From: bmidgley@gmail.com
>> To: bluez-devel@lists.sourceforge.net
>> Subject: Re: [Bluez-devel] SCO connection timed out issue
>>
>> semiyd
>>
>>> Later i found something.I checked out the website "
>>> http://wiki.bluez.org/wiki/Audio" and found that the
>>> /bluez-utils-3.20/audio/gateway.c implements the
>>> org.bluez.audio.gateway interface.But when i looked into the
>>> gateway.c, there's nothing in there.And /bluez-
>>> utils-3.20/audio-api.txt also says that the audio gateway service is
>>> not yet implemented in the current bluez. Is that true? If it is so
>>> ,does this means that there's no way we can enable the SCO/A2DP audio
>>> connection to the headset right now?
>>
>> for now the files there are named backward. gateway.c would contain
>> code for talking to a gateway device, not for being a gateway. You can
>> experiment now with sco/a2dp to a headset just fine.
>>
>>> I'm really confused cause i read about an
>>> article:http://bluetooth-alsa.sourceforge.net/build.html ,which
>>> teaches the reader how to enable bluez audio without mentioning
>>> anything about the org.bluez.audio.gateway implementation.
>>
>> the bluetooth-alsa stuff is all old. that's why there's a banner
>> across the top of the page directing people to the new stuff.
>>
>> brad
>>
>> -------------------------------------------------------------------------
>> This SF.net email is sponsored by: Splunk Inc.
>> Still grepping through log files to find problems? Stop.
>> Now Search log events and configuration files using AJAX and a browser.
>> Download your FREE copy of Splunk now>> http://get.splunk.com/
>> _______________________________________________
>> Bluez-devel mailing list
>> Bluez-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
> _________________________________________________________________
> Explore the seven wonders of the world
> http://search.msn.com/results.aspx?q=7+wonders+world&mkt=en-US&form=QBRE
>

_________________________________________________________________
News, entertainment and everything you care about at Live.com. Get it now!
http://www.live.com/getstarted.aspx


--===============1006924193==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============1006924193==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1006924193==--
