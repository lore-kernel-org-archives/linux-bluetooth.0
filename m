Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Release of new BlueZ libs and utils
From: Marcel Holtmann <marcel@holtmann.org>
To: Edd Dumbill <edd@usefulinc.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1073388369.8729.164.camel@saag>
References: <1071791711.6635.18.camel@pegasus>
	 <1073147533.8729.53.camel@saag>  <1073148476.8729.56.camel@saag>
	 <1073149849.25261.97.camel@pegasus>  <1073154814.8729.66.camel@saag>
	 <1073212685.25261.138.camel@pegasus>  <1073388369.8729.164.camel@saag>
Content-Type: text/plain
Message-Id: <1073392659.2508.43.camel@pegasus>
Mime-Version: 1.0
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
Date: Tue, 06 Jan 2004 13:37:39 +0100

Hi Edd,

> > > > ACL data: handle 0x002a flags 0x02 dlen 18
> > >     L2CAP(d): cid 0x41 len 14 [psm 3]
> > >       RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
> > >       dlci 2 frame_type 0 credit_flow 15 pri 0 ack_timer 0 frame_size
> > > 667 max_retrans 0 credits 3
> > > < ACL data: handle 0x002a flags 0x02 dlen 8
> > >     L2CAP(d): cid 0x169 len 4 [psm 3]
> > >       RFCOMM(s): DM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x73
> > 
> > how long is the time between these two packets?
> 
> no perceptible delay between these two.

this only happens when rfcomm_connect_ind() returns false and this means
that we can't create the new socket. In most cases this is because there
is no listen socket for it. Do /proc/bluetooth/rfcomm show the listen
socket on that channel? Do you use the same channel number in your SDP
record as for dund?

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
