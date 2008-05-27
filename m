Return-Path: <cyrus@holtmann.org>
From: "ShiroiKuma" <bluez-users@sumou.com>
To: bluez-users@lists.sourceforge.net
Date: Tue, 27 May 2008 02:18:54 +0200
Message-Id: <20080527001041.M20414@ShiroiKuma.org>
MIME-Version: 1.0
Subject: [Bluez-users] How do you start the audio service in bluez-utils
	3.30-3
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi:

I'm having some difficulties using bluez-audio. I'm using Debian sid bluez-utils 3.30-3

I've seen that since version 3.30-1 the bluez-audio service is no longer started via
/usr/lib/bluetooth/bluetoothd-service-audio and instead bluez-utils switched to shared library objects which are loaded
by hcid

How do I start the audio service now?

dbus-send --system --print-reply --dest=org.bluez /org/bluez org.bluez.Manager.ListServices gives me:
method return sender=:1.45 -> dest=:1.50 reply_serial=2
   array [
   ]

and dbus-send --system --type=method_call --print-reply --dest=org.bluez /org/bluez org.bluez.Manager.ActivateService
string:audio gives me:
Error org.bluez.Error.NoSuchService: No such service

I've googled, but haven't found anything that would point me towards a solution, the only mention, The bluez Wiki at
http://wiki.bluez.org/wiki/HOWTO/AudioDevices just says:
Make sure the audio service is installed

So how should I proceed?

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
