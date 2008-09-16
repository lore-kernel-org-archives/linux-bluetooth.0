Return-Path: <cyrus@holtmann.org>
To: bluez-users@lists.sourceforge.net
To: bluez-users@lists.sourceforge.net
Date: Tue, 16 Sep 2008 12:46:50 +0100
Message-ID: <YCQ6BUzm.1221565610.4609910.fma@alezan.org>
From: =?ISO-8859-1?Q?Fr=E9d=E9ric?= <frederic.mantegazza@gbiloba.org>
MIME-Version: 1.0
Subject: [Bluez-users] Issue with discover_devices() in PyGTK GUI
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


Hello,

In my PyGTK app., I want to retreive available bluetooth devices. I try
to use discover_devices(), without success. I always get:

Traceback (most recent call last):
  File
"/home/fma/develop/papywizard/trunk/papywizard/controller/bluetoothChooserC=
ontroller.py",
line 123, in refreshView
    devices =3D bluetooth.discover_devices(lookup_names=3DTrue)
  File "/usr/lib/python2.5/site-packages/bluetooth/bluez.py", line 17,
in discover_devices
    sock =3D _gethcisock ()
  File "/usr/lib/python2.5/site-packages/bluetooth/bluez.py", line 226,
in _gethcisock
    raise BluetoothError ("error accessing bluetooth device")
BluetoothError: error accessing bluetooth device

But it only occurs from the PyGTK app; it works fine from ipython...

Are there some know issues with graphical toolkits? Is it a threading
process (the function id called in a dialog, from the main loop of gtk)?

Thanks,

--
   Fr=E9d=E9ric

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
