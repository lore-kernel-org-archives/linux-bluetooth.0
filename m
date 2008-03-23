Return-Path: <cyrus@holtmann.org>
Message-ID: <89b6ba3a0803231540t258807bdk703d843a18a63a3e@mail.gmail.com>
Date: Sun, 23 Mar 2008 23:40:21 +0100
From: "Patryk Zawadzki" <patrys@pld-linux.org>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Recent bluez-gnome problems
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

Hi guys,

I'm in the middle of packaging bluez-gnome 0.25 for PLD Linux. I
already have obex-data-server (with --enable-system-config) packaged
but hit a strange problem.

The interface is visible and hcid is running. I've noticed the
transfer service is no longer part of bluez-utils. First I was unable
to get bluez to a point where it detects any devices. I can see my
laptop from my cell phone but not the other way araound. After bonding
(initialized from the phone) I can send files from my laptop to my
cell phone (it shows bonded devices even if discovery fails to work).
I can't send any files from the phone and I can't browse the phone
contents (phone asks for permission but nautilus shows "connect
failed" when trying to use gvfs-mount obex://[...]/).

bluez-* is 3.29, obex-data-server is 0.3

Any help appreciated. Thanks in advance.

-- 
Patryk Zawadzki
PLD Linux Distribution

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
