Return-Path: <alwaysgone@seznam.cz>
From: =?us-ascii?Q?Dave=20Dev?= <alwaysgone@seznam.cz>
To: =?us-ascii?Q?Marcel=20Holtmann?= <marcel@holtmann.org>
Cc: =?us-ascii?Q?BlueZ=20Mailing=20List?= <bluez-users@lists.sourceforge.net>
In-Reply-To: <1091738430.20839.53.camel@pegasus>
Subject: =?us-ascii?Q?Re=3A=20=5BBluez=2Dusers=5D=20Multi=2DThread=20Problem=20with=20BlueZ?=
Date: Fri, 06 Aug 2004 12:44:20 +0200 (CEST)
Message-Id: <45805.135566-18161-1963570206-1091789060@email.seznam.cz>
Content-Type: text/plain;
	charset="iso-8859-2"
Mime-Version: 1.0
Reply-To: =?us-ascii?Q?Dave=20Dev?= <alwaysgone@seznam.cz>
List-ID: <bluez-users.lists.sourceforge.net>

Hey Marcel!

To refresh your memory:

We have a Server side Java application that utilizes Rococo's Bluetooth=
 stack to connect to the underlining Bluez stack.  This server has diff=
erent services that are used by clients side devices (at this time only=
 symbian phones- Nokia, Siemens, etc.).
 
The problem seems to appear when server/RFCOMMservice (SERVICE register=
ed as a service to SDPD.) is trying to send data ( size  more then  10k=
 ) to client1 and then another client -- client2 -- tries to connect to=
 it at the same time (while client1 is connected), all this using RFCOM=
M layer. (Note:  If only one phone is connected, it works perfectly)

When two phones try to connect at the same time, sometimes it completly=
 frezes or phone-client2 is not even able to --> discover <-- the Serve=
r while the Server is sending data to client1.  For both clients, I'm h=
andling them by using separates threads and just use the API from Rococ=
o to send data to the connected clients...
 
Not really sure how to test this and find out what the problem might be=
.  Rococo says they dont use anything else, they just call BlueZ layer =
-- and the last time we asked you, you said it works without problems. =
 But when i am not even able to discover the Server when it's busy, the=
n it cant be on the application layer nor Rococo. (USB hardware?  We ha=
ve tried many different ones!)
 
We were previously trying to solve this before, but have been unlucky t=
hus far.  By using hcidump we found that the Server doesnt act like a m=
aster as it should, but it switches between slave and master modes. And=
 Symbian phones don't want to switch themself into slave while they're =
connected to the Server. So when sending data to a phone, during that t=
ime those two device switch between master and slave, fighing who will =
be master.
 
Bluez is set up as follow :
 
device {
        # Local device name
        #   %d - device id
        #   %h - host name
        name "Jellingspot";

        # Local device class
        class 0x100;

        # Default packet type
        pkt_type DM5;  *****************  We have tried all packet type=
s, others just crash -- this is the most stable one...

        # Inquiry and Page scan
        iscan enable; pscan enable;

        # Default link mode
        #   none   - no specific policy 
        #   accept - always accept incoming connections
        #   master - become master on incoming connections,
        #            deny role switch on outgoing connections
        #
        #lm accept,master;
        #
        lm accept;          ************** CANT do master otherwise it =
wont work with symbian phones..

        # Default link policy
        #   none    - no specific policy
        #   rswitch - allow role switch
        #   hold    - allow hold mode
        #   sniff   - allow sniff mode
        #   park    - allow park mode
        #
        #lp hold,sniff;
        #
        lp hold,sniff,park;

        # Authentication and Encryption
        #auth enable;
        #encrypt enable;

 
Does that help?





=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Original message =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
From: "Marcel Holtmann" <marcel@holtmann.org>
To: "Dave Dev" <alwaysgone@seznam.cz>
Copy (Cc): "BlueZ Mailing List" <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Multi-Thread Problem with BlueZ
Date: 5. 8. 2004 22:40
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

< Hi Dave,
< 
< > Just dropping a line to say that BlueZ (seemingly) has the same pro=
blem we had before -- we cannot connect two devices at once to the stac=
k -- when BT is sending information (say, 10 - 100kb), we can't even di=
scover the device it's sending over .... Have you tested it with mutlip=
le socket connections?
< 
< I don't have any clue what you are talking about. Be more specific.
< 
< Regards
< 
< Marcel
< 
< 

____________________________________________________________
Anonymn=ED p=F8ipojen=ED k internetu od Seznamu
http://ad.seznam.cz/clickthru?spotId=3D74638
