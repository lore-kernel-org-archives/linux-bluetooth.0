Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <1130408837.4360ab85c798a@site.hu>
From: Gabor LENGYEL <Lgaga@freemail.hu>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Subject: [Bluez-users] authentication question
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
Date: Thu, 27 Oct 2005 12:27:17 +0200

Hi!

I'm developing software where I need to make sure that a certain Bluetooth
device (eg. a mobile phone) is near (present). Identification is based on
bdaddr, a trivial approach is to check whether discovery finds it or not, or
does it reply to l2 echo request or not.

However, an attacker can change a malicious device's bdaddr to whatever, thus
impersonating the device i'm looking for. I implemented a simple
challenge-response protocol between the mobile device (j2me) and the host, but
i'm not sure if this is secure without application level encryption.

After reading quite a lot, i'm still confused about what security modes and
pairing mean exactly. My simple protocol runs over l2cap, after previously
pairing the mobile device and the host computer. But does pairing ensure
authenticity? Or do i need application level encryption with an application
level shared secret to authenticate the mobile device? This seems unnecessary,
considering all the security measures taken by the Bluetooth protocol.

Sorry for the long question, thank you!
Gabor


---------------------------------------------------------------
This mail sent through: www.site.hu - One Site to host them all


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
