Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Triona Ryan <triona.ryan@nuigalway.ie>
Subject: Re: [Bluez-users] local device class...
To: bluez-user@schaettgen.de
Cc: bluez-users@lists.sourceforge.net
Message-id: <01LKZV8BIK3M00286V@beacon.nuigalway.ie>
MIME-version: 1.0
Content-type: text/plain
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
Date: Sat, 19 Feb 2005 17:00:19 +0000

Sorry for the delay. I had been working on FC2 and I'm not sure what packages ar
e where, so I as advised to 
upgrade to FC3, which took more time than I thought
. 

Following this link:
http://www.comp.lancs.ac.uk/~fittond/bt/bt_comms_howto.
html

I installed FC3, then openobex1.0.1, then downloaded opd, and even though 
I can send to the phone, I'm still unable to send to my PC. 

*****************

I'm very confused as to what packages are outdated etc. Should I need any more 
than the above?

*****************


In relation to your email, 

I was only add
ing the rfcomm channel in "sdptool add", but now it is already added with the op
d command. 

So does sdptool list exactly one obex push service?
yes

Is the rfc
omm channel in the sdp record the one which the obex server is 
listening on? Yo
u can check it directly on the PC runnning the Obex server 
with 'sdptool browse
 FF:FF:FF:00:00:00'

[root@IT103-115 opd]# sdptool browse FF:FF:FF:00:00:00
Brow
sing FF:FF:FF:00:00:00 ...
Service Name: Public Browse Group Root
Service Descri
ption: Root of public browse hierarchy
Service Provider: BlueZ
Service RecHandle
: 0xf89e0008
Service Class ID List:
  "Browse Group Descriptor" (0x1001)
Languag
e Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100


Service Name: OBEX Object Push
Service RecHandle: 0xf89e07f0
Service Class ID 
List:
  "OBEX Object Push" (0x1105)
Protocol Descriptor List:
  "L2CAP" (0x0100)

  "RFCOMM" (0x0003)
    Channel: 9
  "OBEX" (0x0008)
Profile Descriptor List:
 
 "OBEX Object Push" (0x1105)
    Version: 0x0100

Service Name: SDP Server
Servi
ce Description: Bluetooth service discovery server
Service Provider: BlueZ
Servi
ce RecHandle: 0x0
Service Class ID List:
  "SDP Server" (0x1000)
Protocol Descri
ptor List:
  "L2CAP" (0x0100)
    PSM: 1
    Version: 0x0001
Language Base Attr 
List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100

Yes, and I
 am binding on rfcomm on channel 9, then using the opd server:

#  opd --channel
 9 --path /tmp/opd --metadata
opd[21881]: OBEX Push Daemon - version 0.2 started

opd[21881]: Failed to register BtOBEX server on RFCOMM channel 9. (-94 / 0)

I 
don't know if any of the obex push tool on linux take a look at the device 
clas
s at all. I can only speak for the kde tools, and those don't. It's more 
likely
 a problem with the sdp record. There should be just one for obex push 
(or to b
e more exact: one for each running obex push server) and it must 
point to the r
ight rfcomm channel. If it's just a mobile phone which refuses 
to send files to
 this PC, the device class could in fact be the problem. 
Obviously the best way
 to find out is to change it to 0x100100 and see what 
happens.

I had done this
 already many times, but to no avail. However, at the moment with the new FC3, I
 can see Object Transfer, so thankfully it's no longer an issue, be it relevant 
or not! ;) 

Is my sdp still not registering perhaps?

Thanks, Triona

Fred

-- 

Fred Schaettgen
bluez-devel@schaettgen.de
===========End of original message te
xt===========





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
