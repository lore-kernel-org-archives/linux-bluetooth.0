Return-Path: <cyrus@holtmann.org>
To: bluez-users@lists.sourceforge.net
From: Jui-Hao Chiang <windtracekimo@gmail.com>
Date: Thu, 3 Jul 2008 02:56:19 +0000 (UTC)
Message-ID: <loom.20080703T025528-873@post.gmane.org>
Mime-Version: 1.0
Subject: [Bluez-users] scotest problem
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

Hi, the goal of my project is to open multiple SCO connections (for voice call)
from a single USB dongle to two cell phones.
Before doing that, I first want to try scotest in bluez-utils between two USB
dongles.
I am now trying to run Linux 2.6.23 with the following patches
(1) sco-flowcontrol
http://bluetooth-alsa.cvs.sourceforge.net/bluetooth-alsa/plugz/patches/sco-flowcontrol-v4.3.diff?view=log
(2) alternate setting patch
http://thread.gmane.org/gmane.linux.bluez.devel/12893/focus=12903

Does anyone have some experience for these two patches and scotest?
What kernel, hardware, and bluez-utils are you using?
Just want to know if anyone have done this before.

best regards,
Jui-Hao


-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
