Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Edd Dumbill <edd@usefulinc.com>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Message-Id: <1098722840.6927.4.camel@saag>
Mime-Version: 1.0
Content-Type: text/plain
Subject: [Bluez-users] Linux 2.6.10-rc1 HID problems
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
Date: Mon, 25 Oct 2004 17:47:20 +0100

Hi Marcel,

Running Linux 2.6.10-rc1 I've got the following HID related problems:

* the multimedia keys on my Apple Bluetooth keyboard no longer work
(showkey shows nothing)

* the microsoft bluetooth mouse no longer generates scroll wheel events
(xev shows nothing)

hidd is running with --master (the apple keyboard won't successfully
reconnect otherwise).

-- Edd



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
