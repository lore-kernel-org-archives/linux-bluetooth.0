Return-Path: <cyrus@holtmann.org>
Date: Wed, 30 Jan 2008 14:20:22 -0800 (PST)
From: "Russell A. Bell" <rbell@alumnus.caltech.edu>
Message-Id: <200801302220.m0UMKKCN012585@alumnus.caltech.edu>
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] unique bus name
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

	Quoth the 'AudioDevices' wiki:

	'The ":X.Y" in the following examples is the unique bus name
of the audio service. You get it in the reply to the ActivateService
method call:
	$dbus-send --system --print-reply --dest=org.bluez /org/bluez org.bluez.Manager.ActivateService string:audio'

	When I make this call I get three numbers back, for example:

	method return sender=:1.0 -> dest=:1.1
	   string ":1.2"

which is the 'unique bus name of the audio service'?  I think 1.0 is
the source (i.e., the bluetooth transceiver); the destination would
seem to be :1.1; what is :1.2 ?
	When I try to use either of them to CreateHeadset I get:

	Error org.freedesktop.DBus.Error.ServiceUnknown: The name :1.x was not provided by any .service files

for 1.1 or 1.2

	/var/log/debug contains:

Jan 30 13:14:29 randytool hcid[8110]: Child PID 8115 got the unique bus name :1.2
Jan 30 13:14:29 randytool hcid[8110]: name_listener_add(:1.2)
Jan 30 13:14:29 randytool hcid[8110]: /org/bluez: org.bluez.Database.AddServiceRecord()
Jan 30 13:14:29 randytool hcid[8110]: Service owner exited: :1.2
Jan 30 13:14:29 randytool hcid[8110]: Audio service (audio) exited with status 1


	Does this indicate that the service record was created then
deleted immediately?

russell bell

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
