Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <20061218100538.29964.qmail@web52107.mail.yahoo.com>
Date: Mon, 18 Dec 2006 02:05:38 -0800 (PST)
From: Paolo Casaschi <kazavsky67-news@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] snd_bt_sco, btsco and suspend/hibernate
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hello,

I'm using a bluetooth headset (via snd_bt_sco and btsco) with Ubuntu Edgy.

Normally, I can talk with Skype using the bluetooth headset and everything works ok (thanks to some help from this list few weeks ago).

However, if I hibernate my laptop, then the bluetooth headset remains silent.
I tried a few things, like:
- adding /etc/init.d/bluetooth to the list of services to be restarted when suspending
- adding snd_bt_sco to the list of modules to be unloaded/reloaded when suspending
- combinations of the above

I even tried to resume from suspend and then manually:
- exit skype (the only program using the headset)
- stop the /etc/init.d/bluetooth service
- unload snd_bt_sco with "modprobe -r"
- reload snd_bt_sco with "modprobe"
- restart the /etc/init.d/bluetooth service
- restart skyp
- associate the bluetooth headset (the association btsco... does not show any error)
Still the skype test call does not send any sound to the headset.

Any suggestion how to make snd_bt_sco, /etc/init.d/bluetooth and btsco working after resuming from hibernate suspend?

-- Paolo




-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
