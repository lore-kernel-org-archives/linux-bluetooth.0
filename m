Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Matthias Albert <matthias@ma-c.de>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1097845922.12708.16.camel@ringo.aicas.burg>
Mime-Version: 1.0
Subject: [Bluez-users] rfcomm pppd
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
Date: 15 Oct 2004 15:12:02 +0200

Hello,

now I'm able to establish a connection from my ipaq (running familiar)
to my notebook (linux, debian host).

hcitool scan -> list of all available bluetooth devices
 -> select the one I need
sdptool browse <bluetoothadress> -> gives me list of all availble
profiles

rfcomm connect 0 <bluetoothadress> 1 -> do a serial connection to my bt
device

rfcomm show -> give me a list of established connections

So everytime I do this, the pppd is starting. If nothing happens the
connection will be closed. Where can I define which program should be
started? I don't want that pppd is starting. I want to see with minicom
what happen on the device. Do you know what I mean?. So where can I
define this?

Kind regards,

Matthias



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
