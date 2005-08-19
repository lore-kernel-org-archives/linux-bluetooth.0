Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Kevin Page <maillists@krp.org.uk>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1124468372.2968.76.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-users] 8250.c kernel patch for Socket CF bluetooth card
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
Date: Fri, 19 Aug 2005 17:19:32 +0100

Hi,

Firstly, I can confirm that the patch to 8250.c (posted to this list by
Mathias Adam on 2005-03-05) applies cleanly to 2.6.12 (Fedora patched
kernel 2.6.12-1.1398_FC4), and that with this patch my Socket
CompactFlash bluetooth card works again (without it I get the "BCSP
timed out" error on hciattach).

Secondly, does anyone know if this patch has already been pushed
upstream to the kernel?

Regards,

kev



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
