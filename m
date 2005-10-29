Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <436375B7.5050404@over-here.org>
From: Eran <eran_l@over-here.org>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] AmbiCom BT2000E on a 2.6.13-mh2 kernel
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
Date: Sat, 29 Oct 2005 15:14:31 +0200

Hello,

I am trying to get my AmbiCom card to work under 2.6.13-mh2 kernel. I 
have found references to LKML post where there's a description how to 
make it work with serial_cs.

I have followed the steps, my pcmcia subsystems identifies the card 
under /dev/ttyS1. setserial with a baud rate and hciattch with ericsson 
as type works pretty well.
However hciconfig shows a device with 00's as the address and hciconfig 
hci0 up times out ("Can't init device hci0: Connection timed out (110)").

I have also tried with 57600 as the speed, to no avail. Can someone 
assist? what am I doing wrong?

Thank you,
ERan


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
