Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <013e01c3d454$33776570$b67ba8c0@zaz1>
From: "Xavier Garreau" <x.garreau@prim-time.fr>
To: "Edd Dumbill" <edd@usefulinc.com>, <bluez-users@lists.sourceforge.net>
References: <1071791711.6635.18.camel@pegasus> <1073147533.8729.53.camel@saag>  <1073148476.8729.56.camel@saag> <1073149849.25261.97.camel@pegasus>  <1073154814.8729.66.camel@saag> <1073212685.25261.138.camel@pegasus> <1073388369.8729.164.camel@saag>
Subject: Re: [Bluez-users] Release of new BlueZ libs and utils
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 6 Jan 2004 13:54:20 +0100

> > > > ACL data: handle 0x002a flags 0x02 dlen 8
> > >     L2CAP(d): cid 0x41 len 4 [psm 3]
> > >       RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
> > > < ACL data: handle 0x002a flags 0x02 dlen 8
> > >     L2CAP(d): cid 0x169 len 4 [psm 3]
> > >       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> > > > HCI Event: Number of Completed Packets(0x13) plen 5
> > > > ACL data: handle 0x002a flags 0x02 dlen 18
> > >     L2CAP(d): cid 0x41 len 14 [psm 3]
> > >       RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len =
8
> > >       dlci 2 frame_type 0 credit_flow 15 pri 0 ack_timer 0 frame_si=
ze
> > > 667 max_retrans 0 credits 3
> > > < ACL data: handle 0x002a flags 0x02 dlen 8
> > >     L2CAP(d): cid 0x169 len 4 [psm 3]
> > >       RFCOMM(s): DM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x73


Hi,

You said dund was running on channel 3, which is the same as dlci 6 as th=
e
P800 get the Direction bit set to 1, being the session initiator (BT spec=
.
=A75.4). The SE P800 is aking for a connection on dlci 2 which is refused=
, of
course.

Am I right RFCOMM gurus ?

Regards,
--=20
Xavier Garreau <x.garreau@prim-time.fr>
Prim'Time Technology
http://www.prim-time.fr/



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
