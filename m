Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Pavel Ruzicka <pavouk@pavouk.org>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] bluez compact flash kernel compatability question
Cc: lady jane <lady3jane2002@yahoo.com>
References: <20051026194053.60184.qmail@web51305.mail.yahoo.com>
In-Reply-To: <20051026194053.60184.qmail@web51305.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200510262304.21536.pavouk@pavouk.org>
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
Date: Wed, 26 Oct 2005 23:04:21 +0200

Hello,

> from what i can tell, the socket card seems to be well
> supported under both 2.4 and 2.6 kernels. can anyone
> confirm this? please specify revision code as well.

I have old revision F Socket CF bluetooth card.
This card id Nokia dtl1 based and works under kernel 2.4
and 2.6. Only one problem is, that driver doesn't support
suspend/resume. After suspending is needed eject/insert
by cardctl utility or physical reinsert.

New revisions use serial.cs driver. There are needed patch
for some 2.6 kernels, but I don't know if recent 2.6 kernel
for Zaurus have this baudrate patch included.

These cards are perfect, because they have built-in antena.

best regards,

Pavel Ruzicka


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
