Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <db972f4304101203089c825b1@mail.gmail.com>
From: Ricky Soh <rickysoh@gmail.com>
Reply-To: Ricky Soh <rickysoh@gmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Bluez-users] Bluetooth Passive Mode
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
Date: Tue, 12 Oct 2004 18:08:57 +0800

I understand that when a device is in discoverable mode, it is
actually in a passive (receiving) mode while waiting for ppl to probe
him. To disable this mode while keep bluetooth on, one need to
deactivate the scan mode by doing a hciconfig noscan.

However, is there a way to enable my bluetooth device in only passive
receiving mode? In other words, is it possible to make my device
non-discoverable yet, it can still grab all Bluetooth signals off the
air?


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
