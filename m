Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Jean-Claude Repetto <jrepetto@free.fr>
To: bluez-devel@lists.sourceforge.net
Message-id: <52492.192.168.0.2.1138486931.squirrel@jcr.homelinux.com>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Subject: [Bluez-devel] dund needs pppd
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 28 Jan 2006 23:22:11 +0100 (CET)

May be it is an evidence for a bluetooth developper, but, as a beginner in
the bluetooth area,  I spend a lot of time trying to establish a
connection with a bluetooth device before I looked at the source code of
dund and realized it needed pppd installed on the computer.

dund reports no error message !

I think it should be nice for future users to add an error message like
that :

diff -ru bluez-utils-2.19.orig/dund/dun.c bluez-utils-2.19/dund/dun.c
--- bluez-utils-2.19.orig/dund/dun.c    2006-01-28 22:33:47.000000000 +0100
+++ bluez-utils-2.19/dund/dun.c 2006-01-28 22:31:10.000000000 +0100
@@ -175,6 +175,7 @@
                close(fd);

        execvp(prog, args);
+        syslog(LOG_INFO, "Error while executing %s\n", prog);
        exit(1);
 }

Thanks,

Jean-Claude






-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
