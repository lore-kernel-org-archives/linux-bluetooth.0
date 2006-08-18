Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Fri, 18 Aug 2006 14:24:10 +0100
Message-ID: <056BF200E9632F4285220E570FEED673E7FE61@GBMDDMH202AMSX.gb001.siemens.net>
In-Reply-To: <44E5BDB1.1030904@palmsource.com>
From: "Waldram, Andrew (SBS UK)" <andrew.waldram@siemens.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] a2pdbtsco	won'tcompile	(FIX)	plus	xmmserror(trials
	andtribulations)	howcool is	this!!!	new patch
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

 =


Ok on it this evening


-----Original Message-----
From: bluez-devel-bounces@lists.sourceforge.net [mailto:bluez-devel-bounces=
@lists.sourceforge.net] On Behalf Of Fr=E9d=E9ric DALLEAU
Sent: 18 August 2006 14:17
To: BlueZ development
Subject: Re: [Bluez-devel] a2pdbtsco won'tcompile (FIX) plus xmmserror(tria=
ls andtribulations) howcool is this!!! new patch

Hi Andrew,

Are these 3 assumption valid at the same time?

- Hcidump does show the connections
- a2dpd does nothing at all just sits there looking pretty
- AVDTP(s): Discover rej: transaction 0

If these three points are absolutly true at a time, then you have another s=
oftware answering the bluetooth connection. It's not an a2dpd as the main t=
cpsocket would be busy. I thought it wasn't possible but I can't see anothe=
r point since you have an answer that a2dpd do not display. Curiously, this=
 software also reject the avdtp_discover as do a2dpd. Aven't you forgotten =
an a2recv or any other bluetooth software in your startup scripts? It may b=
e kde or gnome-bluetooth related too I don't now what they do with a2dp...

Try the following to make sure :

# a2dpd MUST NOT be running
killall -9 a2dpd
sudo hcidump L2CAP

Then connect your headset normally (Pressed play 2 times from switched off =
headset switched on then pressed play), you should see the following :

HCI sniffer - Bluetooth packet analyzer ver 1.28
device: hci0 snap_len: 1028 filter: 0x8
> L2CAP(s): Connect req: psm 25 scid 0x0041                         <------=
---------------------- The headset wants to connect to psm 25
< L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0041 result 2 status 0 =

    Connection refused - PSM not supported                          <------=
---------------------- Refused as nobody listen that psm

If the connection is accepted we will know that a2dpd do not answer, now we=
 must find who.

open a root shell and type 'ps uax' to see all running processes
then for each pid try 'kill -9 pid' until you find the good one :D


Hope we get it one day :D
Fr=E9d=E9ric


Waldram, Andrew (SBS UK) a =E9crit :
>  =

> This is what I get when it's failing you can see why I don't have  a clue
>
> Accepting incoming tcp stream connection
> New connection to bluetooth [44100 hz]
> avrcp: Accepting incoming connection
> avdtp: Accepting incoming connection
>
> Pressed play 2 times from switched off headset switched on then pressed p=
lay.
>
> Hcidump does show the connections but a2dpd does nothing at all just sits=
 there looking pretty.
>
> HCI sniffer - Bluetooth packet analyzer ver 1.28
> device: hci0 snap_len: 1028 filter: 0x400
>   =

>> AVDTP(s): Discover cmd: transaction 0
>>     =

> < AVDTP(s): Discover rej: transaction 0
>     Error code 6
>   =

>> AVDTP(s): Discover cmd: transaction 0
>>     =

> < AVDTP(s): Discover rej: transaction 0
>     Error code 6
>
>   =

>>> Is the alsa plugin setup as default or explicitly set to xmms?
>>>       =

> Explicitly set to xmms =

>
> Of interest the only time I got it to work was when a2dpd was running in =
the forground (from console) never works when running from deamon.
>
> All other avtp funtions work great play pause<10secs skip and rev
>
> Volume also works great but as that's a built in hardware funstion of the=
 headset ;-)
>
> -------------------------------------------------------------------------=
--------- =

>
>
>
> -----Original Message-----
> From: bluez-devel-bounces@lists.sourceforge.net [mailto:bluez-devel-bounc=
es@lists.sourceforge.net] On Behalf Of Fr=E9d=E9ric DALLEAU
> Sent: 18 August 2006 11:00
> To: BlueZ development
> Subject: Re: [Bluez-devel] a2pdbtsco won'tcompile (FIX) plus xmmserror(tr=
ials andtribulations) howcool is this!!! new patch
>
> Hi,
>
> Could you give me the failing log? Is the alsa plugin setup as default =

> or explicitly set to xmms?
> A few comments about the traces :
>
> avdtp: Accepting incoming connection
>
> That line shows we are awaiting an incoming connexion, you should always =
have it since starting a2dpd. If you start up a2dpd without sending sound, =
this is one of the two last lines. Nothing should be displayed after.
>
>
> avdtp: socket 7: Connection from 12:5C:2A:44:0D:00, mtu=3D672
>
> That one show we received an incoming connexion, if we don't have this =

> one, it's the headset that do not connect. It will be difficult to know =

> why! Try to switch off then on!
>
>
> avdtp: socket 7: Received failed result=3D-1 (errno=3D11:Resource
> temporarily unavailable)
> This one is too say we wait for answer but it is just a timeout.
>
>  =

> socket 7: Received 2 bytes
> 00000: 00 01
> Those two lines follow the connection from the headset. It's an AVDTP_DIS=
COVER we answer by rejecting the DISCOVER, but we launch xmms who in turn w=
ill start a brand new connection.
>
>
> Forked xmms --play
>
> That line show we forked to start xmms. It should appear a few seconds =

> after the previous one.
>
>
> Fr=E9d=E9ric
>
>
>
>
> Waldram, Andrew (SBS UK) a =E9crit :
>   =

>>  =

>> Fr=E9d=E9ric
>>
>> Tried everything you sugested still the same play from start will not st=
art xmms (mormaly see below) and pressing pause wait 15 sec then play resul=
ts in nothing. I would say it was my headphones but it did work from avrcp =
and your first patch.
>>
>> Hcidump does show the press's but a2dpd does not show anything at all ju=
st sits waiting incomming connection.
>>
>> After repeated tries I did get it once to start xmms (output follows) so=
 I'm confident my configuration is correct (could it be timming/parsing blu=
etooth response)
>>
>> The logs look a little  strange and it doesn't work 99.9% of the time =

>>
>> I've put markers where I think something may be wrong can you think of a=
nything else I can tru to pin this down (so close yet so far).
>>
>> On a plus note your latest patches seem to have reduced the latency for =
skip forward and back .
>>   =

>>     =

> Really? I'm really sure to have done nothing about this :D
>   =

>>  Accepting incoming tcp stream connection
>> New connection to bluetooth [44100 hz]
>> avrcp: Accepting incoming connection
>> avdtp: Accepting incoming connection
>> avdtp: socket 7: Connection from 12:5C:2A:44:0D:00, mtu=3D672
>> avdtp: socket 7: Received failed result=3D-1 (errno=3D11:Resource
>> temporarily unavailable)<-----------------------------------------------=
--------
>> avdtp: socket 7: Received failed result=3D-1 (errno=3D11:Resource
>> temporarily unavailable)<-----------------------------------------------=
--------
>> socket 7: Received 2 bytes
>> 00000: 00 01
>> DEBUG: a2dp_handle_avdtp_message: (errno=3D11:Resource temporarily
>> unavailable)Unexpected headset directive 1  <---------------------------=
----------------------------
>> DEBUG: a2dp_handle_avdtp_message: Answering command packet
>> (msgtype=3DMESSAGE_TYPE_REJECT,signal=3D1)
>> avdtp: socket 7: Received frame, start xmms --play
>> avdtp: socket 7: timed out
>> Forked xmms --play
>> Message: device: pcm.a2dpd
>> immsd: version 3.0.1 ready...
>> DEBUG: _snd_pcm_a2dpd_open: (errno=3D0:Success)name pcm.a2dpd mode 1
>> DEBUG: a2dp_alloc: (errno=3D0:Success)Init
>> DEBUG: a2dp_alloc: (errno=3D0:Success)OK
>> DEBUG: a2dp_params: (errno=3D0:Success)a2dp 0x8295e18
>> DEBUG: a2dp_params: (errno=3D0:Success)format S16_LE rate 44100 channels=
 2
>> DEBUG: a2dp_params: (errno=3D0:Success)frame_bytes 4 period_bytes 8192
>> period_size 2048 buffer_size 4096
>> DEBUG: a2dp_prepare: (errno=3D0:Success)a2dp 0x8295e18
>> Accepted 7
>> PCM thread 0.7 started
>> Accepting incoming tcp stream connection
>> DEBUG: a2dp_new: Begin
>> DEBUG: a2dp_new: bdaddr/dest is 00:0D:44:2A:5C:12
>> DEBUG: a2dp_alloc: Begin
>> DEBUG: a2dp_connect: a2dp 0x8057810
>> DEBUG: connect_stream: Begin
>> DEBUG: connect_stream: Using address: 12:5C:2A:44:0D:00
>> DEBUG: detect_a2dp: Begin
>>
>> ------------------------------------------------------------------------=
---------- =

>>
>> -----Original Message-----
>> From: bluez-devel-bounces@lists.sourceforge.net [mailto:bluez-devel-boun=
ces@lists.sourceforge.net] On Behalf Of Brad Midgley
>> Sent: 17 August 2006 15:07
>> To: BlueZ development
>> Subject: Re: [Bluez-devel] a2pdbtsco won'tcompile (FIX) plus xmmserror(t=
rials andtribulations) howcool is this!!! new patch
>>
>> Fr=E9d=E9ric
>>
>>   =

>>     =

>>> Try to use the latest patch http://fdalleau.free.fr/patch_to_try
>>> Minor changes has been done. It worked all night long!
>>>     =

>>>       =

>> FYI I just applied this.
>>
>> Brad
>>
>> -------------------------------------------------------------------------
>> Using Tomcat but need to do more? Need to support web services, security?
>> Get stuff done quickly with pre-integrated technology to make your job e=
asier
>> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geroni=
mo
>> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D121642
>> _______________________________________________
>> Bluez-devel mailing list
>> Bluez-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>>
>> -------------------------------------------------------------------------
>> Using Tomcat but need to do more? Need to support web services, security?
>> Get stuff done quickly with pre-integrated technology to make your job e=
asier
>> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geroni=
mo
>> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D121642
>> _______________________________________________
>> Bluez-devel mailing list
>> Bluez-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>>   =

>>     =

>
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job ea=
sier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job ea=
sier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>   =



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
