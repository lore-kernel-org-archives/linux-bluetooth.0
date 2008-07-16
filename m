Return-Path: <cyrus@holtmann.org>
Message-ID: <e96e9eeb0807160834n6eb74e3dn133d7abfb333d07b@mail.gmail.com>
Date: Wed, 16 Jul 2008 18:34:37 +0300
From: "Voni Hakau" <hakauvoni@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-users] bluez-utils 3.36: Unable to get on D-Bus
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

Hi all,

I get the following error:

# hcid -n -s -d
hcid[467]: Bluetooth HCI daemon
hcid[467]: Enabling debug information
hcid[467]: Unable to get on D-Bus

Can someone please help me how to debug this ?

I use bluez-utils 3.36 with the newest d-bus.

I got d-bus up and running (dbus-daemon --system is running, and I the
UNIX domain socket file is created).

Any ideas ?

Thank you
Voni

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
