Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Release of new BlueZ libs and utils
From: Marcel Holtmann <marcel@holtmann.org>
To: Xavier Garreau <x.garreau@prim-time.fr>
Cc: Edd Dumbill <edd@usefulinc.com>,
   BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <013e01c3d454$33776570$b67ba8c0@zaz1>
References: <1071791711.6635.18.camel@pegasus>
	 <1073147533.8729.53.camel@saag>  <1073148476.8729.56.camel@saag>
	 <1073149849.25261.97.camel@pegasus>  <1073154814.8729.66.camel@saag>
	 <1073212685.25261.138.camel@pegasus> <1073388369.8729.164.camel@saag>
	 <013e01c3d454$33776570$b67ba8c0@zaz1>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1073394366.2508.55.camel@pegasus>
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
Date: Tue, 06 Jan 2004 14:06:06 +0100

Hi Xavier,

> You said dund was running on channel 3, which is the same as dlci 6 as =
the
> P800 get the Direction bit set to 1, being the session initiator (BT sp=
ec.
> =A75.4). The SE P800 is aking for a connection on dlci 2 which is refus=
ed, of
> course.
>=20
> Am I right RFCOMM gurus ?

yes, this is correct. The channel numbers of the SDP record and dund
must match.

Do anyone have an old Symbian Bluetooth phone (Nokia 7650, 3650, Sony
Ericsson P800, P900) for me so I can implement the mRouter stuff to get
rid of these stupid setups?

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
