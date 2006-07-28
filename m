Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Hugues Lafarge <Hugues.Lafarge@afp.com>
Date: Fri, 28 Jul 2006 14:05:11 +0200
Message-ID: <87zmeuq6iw.fsf@phugues.par.afp.com>
MIME-Version: 1.0
Subject: [Bluez-devel] typo in dbus-test python script
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


Hi,

Just in case you did'nt notice, there is apparently a typo in the
dbus-test python script in the CVS repository.

Index: hcid/dbus-test
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-test,v
retrieving revision 1.20
diff -u -r1.20 dbus-test
--- hcid/dbus-test	26 Jun 2006 12:33:13 -0000	1.20
+++ hcid/dbus-test	28 Jul 2006 12:01:58 -0000
@@ -186,7 +186,7 @@
     @dbus.decorators.explicitly_pass_message
     def mgr_signal_handler(*args, **keywords):
         dbus_message = keywords["dbus_message"]
-        print '%s: ' % dbus_messsage.get_member()
+        print '%s: ' % dbus_message.get_member()
         for arg in args[1:]:
             print '%s   ' % arg,
         print

-- 
Hugues Lafarge                    || Email: Hugues.Lafarge@afp.com
Agence France Presse              || Phone: +33 1 40 41 77 15
4 rue de la bourse, 75002 Paris   ||   Fax: +33 1 40 41 79 24
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

This e-mail, and any file transmitted with it, is confidential and  intended solely for the use of the individual or entity to whom it is addressed. If you have received this email in error, please  contact the sender and delete the email from your system. If you are  not the named addressee you should not disseminate, distribute or copy  this email.

For more information on Agence France-Presse, please visit our web site at http://www.afp.com

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
