Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <438088F9.1050307@schugy.de>
From: Christian Schuglitsch <subjectbluez@schugy.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Subject: [Bluez-users] btsco locked up my kernel
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 20 Nov 2005 15:32:25 +0100

I use a Jabra BT200 Headset with an Epox DG3-Dongle.
Usually it works this way:

start application (xmms, TeamSpeak2, skype)
btsco -v  uu:vv:ww:xx:yy:zz 2
enter PIN
enjoy the sound


When I enter the PIN before any application is started then the rfcomm 
channel will be lost within 2 seconds.
This time I was adjusting the volume with my mousewheel in gamix1.99 
while the rfcomm channel became lost because there was no audio stream.

This locked up the hole PC.

Maybe there's someone who can code a workaround.

Regards

Schugy






-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
