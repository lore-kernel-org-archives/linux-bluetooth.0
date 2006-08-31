Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <35861.212.58.233.129.1157016991.squirrel@samuri.demon.co.uk>
In-Reply-To: <44F69DB8.7000107@palmsource.com>
References: <1155918829.6708.16.camel@localhost>	<7A6DA545D7FDCC4B93DB651FDBC1EDDE4E6E8F@eumonex01.palmsource.com>	<1156890150.19173.8.camel@localhost>
	<44F55222.1030700@palmsource.com>	<1156955722.19749.6.camel@localhost>
	<1156959040.19749.19.camel@localhost>
	<44F69DB8.7000107@palmsource.com>
Date: Thu, 31 Aug 2006 10:36:31 +0100 (BST)
From: andy@samuri.demon.co.uk
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] Broadcom BCM2045 problems
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

Yea I didn't think I could disable my built in dongle as its hard waired
and most of the apps do not support multiple dongles i.e /dev/hci1

But then realised I could Down the hci0 making the other one the defaullt


Thanks for all your help

Your app is really cool now and will brin me much listening pleasure.

I guess the problem with the broadcom is that by the time its
paired/connected the command is lost. This would explain why occasionaly
it works.

Soldering iron and screwdriver time out with the broadcomm and in with a
BT V2 CSR.

> Pleased you sort it out! And pleased it's not the code. Pity we have not
> tried another dongle first ! At least 30 mails passed in this thread :D
>
> Fr=C3=A9d=C3=A9ric
>
> Andrew Waldram a =C3=A9crit :
>> Hi Fr=C3=A9d=C3=A9ric,
>>
>> thought I'd change the subject to reflect my true issue ;-)
>> Got it!!
>>
>> well sort of its the Broadcom BCM2045
>>
>> I tried another dongle bringing my integrated one down with hciconfig
>> hci0 down
>> hci0:   Type: USB
>>         BD Address: 00:12:0E:2E:E9:35 ACL MTU: 1017:8 SCO MTU: 64:8
>>         DOWN
>>         RX bytes:38581 acl:54 sco:0 events:4397 errors:0
>>         TX bytes:8951643 acl:16215 sco:0 commands:177 errors:0Pleased
>> you sort it out! And pleased it's not the code. Pity we have
>> not tried another dongle first ! At least 20 mails passed in this
>> thread :D
>>
>> At least we found the 100% cpu...
>>
>> Fr=C3=A9d=C3=A9ric
>>
>>
>>         Features: 0xff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80
>>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>>         Link policy: RSWITCH HOLD SNIFF PARK
>>         Link mode: SLAVE ACCEPT
>>
>> hci1:   Type: USB
>>         BD Address: 11:11:11:11:11:11 ACL MTU: 678:8 SCO MTU: 64:10
>>         UP RUNNING PSCAN
>>         RX bytes:7700 acl:37 sco:0 events:848 errors:0
>>         TX bytes:414743 acl:783 sco:0 commands:35 errors:0
>>         Features: 0xbf 0xfe 0x8d 0x78 0x08 0x18 0x00 0x00
>>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>>         Link policy: RSWITCH HOLD SNIFF PARK
>>         Link mode: SLAVE ACCEPT
>>         Name: 'BlueZ (1)'
>>         Class: 0x3e0100
>>         Service Classes: Networking, Rendering, Capturing, Object
>> Transfer, Audio
>>         Device Class: Computer, Uncategorized
>>         HCI Ver: 1.2 (0x2) HCI Rev: 0x1fe LMP Ver: 1.2 (0x2) LMP Subver:
>> 0x1fe
>>         Manufacturer: Integrated System Solution Corp. (57)
>>
>> and with the issc donble all works like this all the time not 1 in 30
>> whooo hoo
>>
>> andy@sidney:~$ l2test -i hci1 -P 25 -d
>> l2test[23181]: Waiting for connection on psm 25 ...
>> l2test[23185]: Connect from 00:0D:44:2A:5C:12 [imtu 672, omtu 672,
>> flush_to 65535, mode 0, handle 1, class 0x040418]
>> l2test[23185]: Receiving ...
>> l2test[23185]: Recevied 2 bytes
>> 00000000: 00 01
>>
>> Don't know what to try from here at least it's not your code :-)
>>
>> Could be a problem with the broadcom patch ???
>>
>> for completness here the hciconfig for the broadcom when its up
>>  hci0:   Type: USB
>>         BD Address: 00:12:0E:2E:E9:35 ACL MTU: 1017:8 SCO MTU: 64:8
>>         UP RUNNING PSCAN
>>         RX bytes:38978 acl:54 sco:0 events:4415 errors:0
>>         TX bytes:8951964 acl:16215 sco:0 commands:195 errors:0
>>         Features: 0xff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80
>>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>>         Link policy: RSWITCH HOLD SNIFF PARK
>>         Link mode: SLAVE ACCEPT
>>         Name: 'BlueZ (0)'
>>         Class: 0x3e0100
>>         Service Classes: Networking, Rendering, Capturing, Object
>> Transfer, Audio
>>         Device Class: Computer, Uncategorized
>>         HCI Ver: 2.0 (0x3) HCI Rev: 0x2000 LMP Ver: 2.0 (0x3) LMP
>> Subver: 0x4127
>>         Manufacturer: Broadcom Corporation (15)
>>
>> Any ideas anyone????
>>
>>
>> On Wed, 2006-08-30 at 17:35 +0100, Andrew Waldram wrote:
>>
>>> Thanks for the reply
>>> Here is what I get
>>> First attempt and next 30 ;-)
>>>
>>> andy@sidney:~$ l2test -P 25 -d
>>> l2test[20236]: Waiting for connection on psm 25 ...
>>> and dmesg
>>> [17217759.712000] hci_acldata_packet: hci0 ACL packet for unknown
>>> connection handle 11
>>>
>>> 31st attempt
>>> andy@sidney:~$ l2test -P 25 -d
>>> l2test[20302]: Waiting for connection on psm 25 ...
>>> l2test[20314]: Connect from 00:0D:44:2A:5C:12 [imtu 672, omtu 672,
>>> flush_to 6553 5, mode 0, handle 11, class 0x040418]
>>> l2test[20314]: Receiving ...
>>> l2test[20314]: Recevied 2 bytes
>>> 00000000: 00 01
>>>
>>> At least the typo matches
>>> tried restarting bluez utils but it doesn't alter the situation
>>> reset headphones still no go.
>>>
>>> looks timmingish to me :-) maybe the broadcom
>>>
>>> On Wed, 2006-08-30 at 10:53 +0200, Fr=C3=A9d=C3=A9ric DALLEAU wrote:
>>>
>>>> Hi Andrew,
>>>>
>>>> Don't stop your wife from talking yet, I still do not understand what
>>>> happen but I have a new test. If you have compiled (and installed)
>>>> bluez-utils, you should have a tool called l2test. If not get it, then
>>>> stop the a2dpd daemon and run :
>>>> killall a2dpd
>>>> l2test -P 25 -d
>>>> Then switch on your headset and connect it. Give me the full output.
>>>> Mine is the following :
>>>>
>>>> frederic.dalleau@fdalleau:~>l2test -P 25 -d
>>>> l2test[4457]: Waiting for connection on psm 25 ...
>>>> l2test[4458]: Connect from 00:0D:44:2A:17:C7 [imtu 672, omtu 672,
>>>> flush_to 65535, mode 0, handle 42, class 0x040418]
>>>> l2test[4458]: Receiving ...
>>>> l2test[4458]: Recevied 2 bytes
>>>> 00000000: 00 01                                            ..
>>>>
>>>> Hey, there's a typo in this log :D
>>>>
>>>> Fr=C3=A9d=C3=A9ric
>>>>
>>>> Andrew Waldram a =C3=A9crit :
>>>>
>>>>> Hi Frederic,
>>>>>
>>>>>  took your advise and compiled latest Bluez (3.4) yet still pressing
>>>>> play gives
>>>>>
>>>>> root@sidney:/home/andy# /usr/local/sbin/hcidump
>>>>> HCI sniffer - Bluetooth packet analyzer ver 1.32
>>>>> device: hci0 snap_len: 1028 filter: 0xffffffff
>>>>>
>>>>>
>>>>>> HCI Event: Connect Request (0x04) plen 10
>>>>>>
>>>>>>
>>>>> < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
>>>>>
>>>>>
>>>>>> HCI Event: Command Status (0x0f) plen 4
>>>>>> HCI Event: Link Key Request (0x17) plen 6
>>>>>>
>>>>>>
>>>>> < HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
>>>>>
>>>>>
>>>>>> HCI Event: Command Complete (0x0e) plen 10
>>>>>> ACL data: handle 11 flags 0x02 dlen 12
>>>>>>
>>>>>>
>>>>>     L2CAP(s): Connect req: psm 25 scid 0x0040
>>>>>
>>>>>
>>>>>> HCI Event: Connect Complete (0x03) plen 11
>>>>>>
>>>>>>
>>>>> < HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
>>>>>
>>>>>
>>>>>> HCI Event: Command Complete (0x0e) plen 6
>>>>>>
>>>>>>
>>>>> < HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
>>>>>
>>>>>
>>>>>> HCI Event: Command Status (0x0f) plen 4
>>>>>>
>>>>>>
>>>>> < HCI Command: Remote Name Request (0x01|0x0019) plen 10
>>>>>
>>>>>
>>>>>> HCI Event: Connection Packet Type Changed (0x1d) plen 5
>>>>>> HCI Event: Max Slots Change (0x1b) plen 3
>>>>>> HCI Event: Command Status (0x0f) plen 4
>>>>>> HCI Event: Remote Name Req Complete (0x07) plen 255
>>>>>>
>>>>>>
>>>>> It looks like the connection is formed but the play command is never
>>>>> recieved ???
>>>>>
>>>>> Any help anyone with more experience of hcidump than me.
>>>>>
>>>>> Do you think it may be the broadcom dongle I've built into my machine
>>>>> (I
>>>>> have the kernel patches for it).
>>>>>
>>>>> On a plus note forward and reverse skip is a lot more responsive with
>>>>> 3.4 ..
>>>>>
>>>>> This isn't a show stopper just an anoyance.
>>>>>
>>>>> Just to recap
>>>>> pressing play on headphones from 'on' does not start xmms .ie
>>>>> headphone
>>>>> initiated play
>>>>> pause for >10 secs leads to having to restart session as headphone
>>>>> stays
>>>>> disconnected again headphone initiated (sometimes works).
>>>>>
>>>>> everything else is really working well (pc initiated session)
>>>>>
>>>>> of cause one solution would be to stop the wife talking to me for
>>>>> more
>>>>> than 10sec ;=3D)
>>>>>
>>>>>
>>>>> On Sat, 2006-08-19 at 10:12 +0100, Frederic Dalleau wrote:
>>>>>
>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> I really don't know about the internals of bluez. The only thing is,
>>>>>> try to update your bluez if you do not already use the latest. Only
>>>>>> someone really in the deep could help.
>>>>>>
>>>>>> Advice anyone?
>>>>>>
>>>>>> Fr=C3=A9d=C3=A9ric
>>>>>>
>>>>>>
>>>>>> -------- Message d'origine--------
>>>>>> De: bluez-devel-bounces@lists.sourceforge.net de la part de Andrew
>>>>>> Waldram
>>>>>> Date: ven. 18/08/2006 18:33
>>>>>> =C3=80: BlueZ development
>>>>>> Objet : [Bluez-devel] a2pdbtsco won'tcompile (FIX) plus
>>>>>> xmmserror(trialsandtribulations) howcool is this!!! new patch
>>>>>>
>>>>>> Fr=C3=A9d=C3=A9ric
>>>>>>
>>>>>>
>>>>>> Ok thought I'd start from scratch
>>>>>>
>>>>>> ensure a2dpd has only 1 session
>>>>>> first attempt it all worked ??????
>>>>>> next attempt and subsequent
>>>>>>
>>>>>> sudo hcidump =3D
>>>>>>
>>>>>> andy@sidney:/etc/apanel$ sudo hcidump
>>>>>> HCI sniffer - Bluetooth packet analyzer ver 1.28
>>>>>> device: hci0 snap_len: 1028 filter: 0xffffffff
>>>>>>
>>>>>>
>>>>>>> HCI Event: Connect Request (0x04) plen 10
>>>>>>>
>>>>>>>
>>>>>> < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
>>>>>>
>>>>>>
>>>>>>> HCI Event: Command Status (0x0f) plen 4
>>>>>>> HCI Event: Link Key Request (0x17) plen 6
>>>>>>>
>>>>>>>
>>>>>> < HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
>>>>>>
>>>>>>
>>>>>>> HCI Event: Command Complete (0x0e) plen 10
>>>>>>> ACL data: handle 11 flags 0x02 dlen 12
>>>>>>>
>>>>>>>
>>>>>>     L2CAP(s): Connect req: psm 25 scid 0x0040
>>>>>>
>>>>>>
>>>>>>> HCI Event: Connect Complete (0x03) plen 11
>>>>>>>
>>>>>>>
>>>>>> < HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
>>>>>>
>>>>>>
>>>>>>> HCI Event: Command Complete (0x0e) plen 6
>>>>>>>
>>>>>>>
>>>>>> < HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
>>>>>>
>>>>>>
>>>>>>> HCI Event: Command Status (0x0f) plen 4
>>>>>>> HCI Event: Connection Packet Type Changed (0x1d) plen 5
>>>>>>> HCI Event: Max Slots Change (0x1b) plen 3
>>>>>>>
>>>>>>>
>>>>>> a2dpd
>>>>>> andy@sidney:~$ a2dpd
>>>>>> a2dpd [Aug 17 2006 21:24:09] starting ...a2dpd
>>>>>> addr=3D00:0D:44:2A:5C:12
>>>>>> timer=3D4000 us [Aug 17 2006 21:24:09]
>>>>>> setscheduler returns 0 (errno=3D0:Success)
>>>>>> Accepting incoming tcp stream connection
>>>>>> New connection to bluetooth [44100 hz]
>>>>>> avrcp: Accepting incoming connection
>>>>>> avdtp: Accepting incoming connection
>>>>>>
>>>>>>
>>>>>> And now when it works.
>>>>>>
>>>>>> HCI sniffer - Bluetooth packet analyzer ver 1.28
>>>>>> device: hci0 snap_len: 1028 filter: 0xffffffff
>>>>>>
>>>>>>
>>>>>>> HCI Event: Connect Request (0x04) plen 10
>>>>>>>
>>>>>>>
>>>>>> < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
>>>>>>
>>>>>>
>>>>>>> HCI Event: Command Status (0x0f) plen 4
>>>>>>> HCI Event: Link Key Request (0x17) plen 6
>>>>>>>
>>>>>>>
>>>>>> < HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
>>>>>>
>>>>>>
>>>>>>> HCI Event: Command Complete (0x0e) plen 10
>>>>>>> HCI Event: Connect Complete (0x03) plen 11
>>>>>>>
>>>>>>>
>>>>>> < HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
>>>>>>
>>>>>>
>>>>>>> ACL data: handle 11 flags 0x02 dlen 12
>>>>>>>
>>>>>>>
>>>>>>     L2CAP(s): Connect req: psm 25 scid 0x0040
>>>>>> < ACL data: handle 11 flags 0x02 dlen 16
>>>>>>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
>>>>>>       Connection successful
>>>>>>
>>>>>>
>>>>>>> HCI Event: Command Complete (0x0e) plen 6
>>>>>>>
>>>>>>>
>>>>>> < HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
>>>>>>
>>>>>>
>>>>>>> HCI Event: Command Status (0x0f) plen 4
>>>>>>> HCI Event: Connection Packet Type Changed (0x1d) plen 5
>>>>>>> HCI Event: Max Slots Change (0x1b) plen 3
>>>>>>> ACL data: handle 11 flags 0x02 dlen 16
>>>>>>>
>>>>>>>
>>>>>>     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
>>>>>>       FlushTO 65535
>>>>>> < ACL data: handle 11 flags 0x02 dlen 14
>>>>>>     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
>>>>>>       Success
>>>>>> < ACL data: handle 11 flags 0x02 dlen 12
>>>>>>     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
>>>>>>
>>>>>>
>>>>>>> ACL data: handle 11 flags 0x02 dlen 14
>>>>>>>
>>>>>>>
>>>>>>     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
>>>>>>       Success
>>>>>>
>>>>>>
>>>>>>> HCI Event: Encrypt Change (0x08) plen 4
>>>>>>> HCI Event: Number of Completed Packets (0x13) plen 5
>>>>>>> ACL data: handle 11 flags 0x02 dlen 6
>>>>>>>
>>>>>>>
>>>>>>     L2CAP(d): cid 0x0040 len 2 [psm 25]
>>>>>>       AVDTP(s): Discover cmd: transaction 0
>>>>>> < ACL data: handle 11 flags 0x02 dlen 6
>>>>>>     L2CAP(d): cid 0x0040 len 2 [psm 25]
>>>>>>       AVDTP(s): Discover rej: transaction 0
>>>>>>         Error code 6
>>>>>> < ACL data: handle 11 flags 0x02 dlen 12
>>>>>>
>>>>>> a2dpd
>>>>>>
>>>>>> andy@sidney:~$ a2dpd
>>>>>> a2dpd [Aug 17 2006 21:24:09] starting ...a2dpd
>>>>>> addr=3D00:0D:44:2A:5C:12
>>>>>> timer=3D4000 us [Aug 17 2006 21:24:09]
>>>>>> setscheduler returns 0 (errno=3D0:Success)
>>>>>> Accepting incoming tcp stream connection
>>>>>> New connection to bluetooth [44100 hz]
>>>>>> avrcp: Accepting incoming connection
>>>>>> avdtp: Accepting incoming connection
>>>>>> avdtp: socket 7: Connection from 12:5C:2A:44:0D:00, mtu=3D672
>>>>>> avdtp: socket 7: Received failed result=3D-1 (errno=3D11:Resource
>>>>>> temporarily unavailable)
>>>>>> avdtp: socket 7: Received failed result=3D-1 (errno=3D11:Resource
>>>>>> temporarily unavailable)
>>>>>> socket 7: Received 2 bytes
>>>>>> 00000: 00 01
>>>>>> DEBUG: a2dp_handle_avdtp_message: (errno=3D11:Resource temporarily
>>>>>> unavailable)Unexpected headset directive 1
>>>>>> DEBUG: a2dp_handle_avdtp_message: Answering command packet
>>>>>> (msgtype=3DMESSAGE_TYPE_REJECT,signal=3D1)
>>>>>> avdtp: socket 7: Received frame, start xmms --play
>>>>>>
>>>>>>
>>>>>> so it looks to my simple mind that l2cap never completes properly.
>>>>>>
>>>>>> Not sure why when running both as forground tasks appear to get
>>>>>> different result to what I've posted previously but possibly I'm an
>>>>>> idiot ;-), Or maybe there is more than one problem, or to many
>>>>>> changes
>>>>>> invalidating findings.
>>>>>>
>>>>>> At least I can see why its not working now but don't know what todo
>>>>>> about it
>>>>>>
>>>>>> maybe I should never have looked at each log in isolation so think
>>>>>> we
>>>>>> should go from here as I can reproduce this easily.
>>>>>>
>>>>>>
>>>>>>
>>>>>> --------------------------------------------------------------------=
-----
>>>>>> Using Tomcat but need to do more? Need to support web services,
>>>>>> security?
>>>>>> Get stuff done quickly with pre-integrated technology to make your
>>>>>> job
>>>>>> easier
>>>>>> Download IBM WebSphere Application Server v.1.0.1 based on Apache
>>>>>> Geronimo
>>>>>> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&=
dat=3D121642
>>>>>> _______________________________________________
>>>>>> Bluez-devel mailing list
>>>>>> Bluez-devel@lists.sourceforge.net
>>>>>> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>>>>>>
>>>>>>
>>>>>>
>>>>> ---------------------------------------------------------------------=
----
>>>>> Using Tomcat but need to do more? Need to support web services,
>>>>> security?
>>>>> Get stuff done quickly with pre-integrated technology to make your
>>>>> job easier
>>>>> Download IBM WebSphere Application Server v.1.0.1 based on Apache
>>>>> Geronimo
>>>>> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&d=
at=3D121642
>>>>> _______________________________________________
>>>>> Bluez-devel mailing list
>>>>> Bluez-devel@lists.sourceforge.net
>>>>> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>>>>>
>>>>>
>>>> ----------------------------------------------------------------------=
---
>>>> Using Tomcat but need to do more? Need to support web services,
>>>> security?
>>>> Get stuff done quickly with pre-integrated technology to make your job
>>>> easier
>>>> Download IBM WebSphere Application Server v.1.0.1 based on Apache
>>>> Geronimo
>>>> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&da=
t=3D121642
>>>> _______________________________________________
>>>> Bluez-devel mailing list
>>>> Bluez-devel@lists.sourceforge.net
>>>> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>>>>
>>> -----------------------------------------------------------------------=
--
>>> Using Tomcat but need to do more? Need to support web services,
>>> security?
>>> Get stuff done quickly with pre-integrated technology to make your job
>>> easier
>>> Download IBM WebSphere Application Server v.1.0.1 based on Apache
>>> Geronimo
>>> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D121642
>>> _______________________________________________
>>> Bluez-devel mailing list
>>> Bluez-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>>>
>>
>> -------------------------------------------------------------------------
>> Using Tomcat but need to do more? Need to support web services,
>> security?
>> Get stuff done quickly with pre-integrated technology to make your job
>> easier
>> Download IBM WebSphere Application Server v.1.0.1 based on Apache
>> Geronimo
>> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D121642
>> _______________________________________________
>> Bluez-devel mailing list
>> Bluez-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>>
>
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job
> easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>



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
