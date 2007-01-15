Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Mon, 15 Jan 2007 12:15:20 -0800
Message-ID: <D8CE9CFA707C894180BAC8CDD154F8460AD538BE@msiexch01.marvell.com>
From: "Quinton Yuan" <qyuan@marvell.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] plugz issues (Quinton)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


Frederic
Sorry, looks like I missed your first reply, and catch it in this digest
1. with plugin-rate=44100 and enable flags=1 on head version plugz
	audio playback speed is still not correct, didn't give me the
bandwidth display neither.
	Disable debug output make no difference

2. btsco-0.5 package
	works fine with a2play and plug in, however, both have audio
break 	(play few seconds then stop then play) issue, one thing noticed
is 	that bandwidth display is correct (with flags=1), but seems not
math 	your figure (my is 24525 (191 kbps)

3. head version btsco (checked out from cvs)
	works ok with a2play, plug in play back speed looks ok, but have
audio 	break issue


Thanks/Quinton

PS, log file from btsco-0.5

ot@localhost ~]# a2dpd
Cannot open /dev/input/uinput: No such file or directory
a2dpd [Jan 15 2007 10:46:44] starting ...a2dpd addr=00:08:1b:00:00:85
timer=999 us [Jan 15 2007 10:46:44]
avdtp: Accepting incoming connection
New connection to bluetooth [44100 hz, 2 channels, 16 bits]
avrcp: Accepting incoming connection
PCM thread 0.5 started (44100 Hz, 2 channels, 16 bits)
DEBUG: a2dp_new: 00:08:1b:00:00:85, 44100
DEBUG: detect_a2dp: Found A2DP Sink
DEBUG: connect_stream: Found A2DP Sink at the destination (psm_cmd=25)
DEBUG: connect_stream: Sent the Stream End Point Discovery Command
DEBUG: a2dp_handle_avdtp_message: Read non command packet
(msgtype=2,signal=1)
DEBUG: connect_stream: Got a Stream End Point Discovery (6 bytes)
Response (msgtype=2,pkttype=0,lbl=0,sig=1,rfa=0)
020104080808
DEBUG: connect_stream: received 2 capabilities
DEBUG: process_seid: Got capabilities response:
servcap_cap=1, servcap_len=0,
cap_type=7, length=6, media_type=0, codec=0
DEBUG: process_seid: Got Set Configurations Response (2
bytes:msgtype=2,pkttype=0,lbl=2,sig=3,rfa=0)
DEBUG: connect_stream: Sent stream start(seid=1)
DEBUG: connect_stream: Got start stream confirm
DEBUG: listen_thread: Listen thread running [control_sk=8]
avrcp: socket 12: Connection from 85:00:00:1B:08:00, mtu=672
DEBUG: a2dp_transfer_raw: Bandwith: 26705 (208 kbps) 32
DEBUG: a2dp_transfer_raw: Bandwith: 24525 (191 kbps) 32
DEBUG: a2dp_transfer_raw: Bandwith: 24525 (191 kbps) 32
DEBUG: a2dp_transfer_raw: Bandwith: 24525 (191 kbps) 32
DEBUG: a2dp_transfer_raw: Bandwith: 24525 (191 kbps) 32
DEBUG: a2dp_transfer_raw: Bandwith: 24525 (191 kbps) 32
DEBUG: a2dp_transfer_raw: Bandwith: 24525 (191 kbps) 32
DEBUG: a2dp_transfer_raw: Bandwith: 24525 (191 kbps) 32
DEBUG: a2dp_transfer_raw: Bandwith: 24525 (191 kbps) 32
DEBUG: a2dp_transfer_raw: Bandwith: 24525 (191 kbps) 32
DEBUG: a2dp_transfer_raw: Bandwith: 24525 (191 kbps) 32
DEBUG: a2dp_transfer_raw: Bandwith: 24525 (191 kbps) 32
DEBUG: a2dp_transfer_raw: Bandwith: 24525 (191 kbps) 32
DEBUG: a2dp_transfer_raw: Bandwith: 24525 (191 kbps) 32
DEBUG: a2dp_transfer_raw: Bandwith: 24525 (191 kbps) 32
DEBUG: a2dp_transfer_raw: Bandwith: 24525 (191 kbps) 32
DEBUG: a2dp_transfer_raw: Bandwith: 24525 (191 kbps) 32
DEBUG: a2dp_transfer_raw: Bandwith: 24525 (191 kbps) 32
DEBUG: a2dp_transfer_raw: Bandwith: 24525 (191 kbps) 32
handling SIGINT
Destroying lpA2dp, end of loop
DEBUG: a2dp_destroy: Begin
Client thread 5 ending: no error
socket 8: Receive failed -1
A2DPD still 3 clients running
DEBUG: a2dp_destroy: Receiving answer to close stream
DEBUG: a2dp_destroy: Received answer size=2
5208
DEBUG: a2dp_free: 
DEBUG: a2dp_destroy: a2dp_destroy(0x9f86c60) OK
AVRCP Receive failed: Success
avrcp: socket 12: timed out
A2DPD still 2 clients running
buffer overflow line 422 (size=2568 check=FDFDFDFD)
A2DPD terminated succesfully





I have tried the settings you suggested, basically they make no 
-----Original Message-----
From: bluez-devel-bounces@lists.sourceforge.net
[mailto:bluez-devel-bounces@lists.sourceforge.net] On Behalf Of
bluez-devel-request@lists.sourceforge.net
Sent: Monday, January 15, 2007 5:55 AM
To: bluez-devel@lists.sourceforge.net
Subject: Bluez-devel Digest, Vol 9, Issue 53


Subject: Re: [Bluez-devel] RE :   RE :2 plugz issues
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <45AB87B7.80703@palmsource.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed

Any updates?

Frederic Dalleau a ?crit :
>
> Now get back to :
> sbcbitpool=32
> rate=44100
> plugin-rate=44100
> also add
> flags=1 to display bandwith
> With a bitpool of 32 you should see bandwith around 26703 b/s.
>
> Here are a few tests.
> Add enabledebug=0 in .a2dprc see if it is better (remove all traces)
> Try a2dpd from btsco-0.5.tgz (not the cvs head) instead of plugz.
> you could also test other bitpool values (53 is the only mandatory 
> value, 64 or 16 or 8 can work too, but quality can suffer)
>
> or another media player known to work, like xine or vlc.
>
> with xmms Start streaming one minute then press stop on the player, 
> does it continue playing?
>
> Fr?d?ric
>
>
>
>
> -------- Message d'origine--------
> De: bluez-devel-bounces@lists.sourceforge.net de la part de Quinton
Yuan
> Date: mar. 09/01/2007 18:40
> ?: bluez-devel@lists.sourceforge.net
> Objet : [Bluez-devel]  RE :2 plugz issues
>  
> Frederic
> Thanks for your reply, sounds still not right on headset side, below 
> are .a2dprc file, attached is a2dpd log
>
> Regards/Quinton
>
> From: "Frederic Dalleau" <Frederic.Dalleau@palmsource.com>
> Subject: [Bluez-devel] RE :  1. Re: 2 plugz issues (Brad Midgley)
> To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
> Message-ID:
>
<7A6DA545D7FDCC4B93DB651FDBC1EDDE4E6EB6@eumonex01.palmsource.com>
> Content-Type: text/plain; charset="iso-8859-1"
>
> Try to add the following in .a2dprc
> sbcbitpool=32
> rate=44100
> plugin-rate=0
>
> If it doesn't fix the problem, then provide us your .a2dprc and what 
> adapter you are using.
>
> Fr?d?ric
>
>
>
> [Shuangqing (Quinton) Yuan]
> [a2dpd]
> #
> # Rate
> # use 32000 if your headset seems to not support 44100 (HP works well 
> at 44100, Sonorix at 32000)
> # However, 44100 is mandatory
> #
> rate=44100
> sbcbitpool=32
> #rate=32000
>
> #
> # plugin-rate default is the rate used between the plugin and the
daemon
> # if this value is 0 then
> # if this value is not 0 then alsa will convert all stream to the 
> specified rate and then send it to the daemon
> # if this value is 0, then alsa will do no conversion at all, the 
> daemon will do it's own resampling.
> # This "features" is disabled because of the crappy quality of the 
> daemon resampler
> # To test a2dpd resampling from 32000 to 44100 use plugin-rate=32000 
> and rate=44100
> #plugin-rate=32000
> plugin-rate=0
>
> # Recommended
> enablereversestereo=1
>
> #
> # AVRCP Commands to run
> # If these entries are emptied, then some keyboard entry will be sent 
> to /dev/uinput
> #
> cmdplay=xmms --play
> cmdpause=xmms --pause
> cmdprev=xmms --rew
> cmdnext=xmms --fwd
> cmdnew=xmms --play
> # Put to 0 to ignore AVRCP (if your computer freezes when commands are

> received)
> enableavrcp=1
>
> #
> # Audio routing
> #
> # If set to 1 (at a2dp startup only) a2dp will reread configuration
file
> #? for audio routing changes each second
> enablerereadconfig=1
>
> # 0 => Bluetooth A2DP Sink
> # 1 => Alsa
> enableredirectalsa=0
>
> # Your bluetooth headset address
> #Belkin TuneStage
> #address=00:08:1b:8a:40:95
> #motorola S805
> address=00:0C:55:D1:D0:D6
> #BlueJay with A2DP demo program
> #address=00:50:43:20:6c:62
> # Address of your alsa output (default : plughw:0,0) you have to know 
> what to do
> alsaoutput=
>
>
------------------------------------------------------------------------
-
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to 
> share your
> opinions on IT & business topics through brief surveys - and earn cash
>
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDE
V 
>
<http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVD
EV> 
>
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>
------------------------------------------------------------------------
>
>
------------------------------------------------------------------------
-
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to
share your
> opinions on IT & business topics through brief surveys - and earn cash
>
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDE
V
>
------------------------------------------------------------------------
>
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>   


-- 
Frederic

Without the wind, the grass does not move.




------------------------------

------------------------------------------------------------------------
-
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share
your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDE
V

------------------------------

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel


End of Bluez-devel Digest, Vol 9, Issue 53
******************************************

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
