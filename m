Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Sun, 12 Aug 2007 12:45:20 -0700 (PDT)
From: Jim Carter <jimc@math.ucla.edu>
To: bluez-devel@lists.sourceforge.net
Message-ID: <Pine.LNX.4.64.0708121241480.5934@xena.cft.ca.us>
MIME-Version: 1.0
Subject: [Bluez-devel] a2dpd_ipc.c infinite loop stomped
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Versions: 
SuSE 10.2, kernel 2.6.18
bluez-utils 3.7
plugz from CVS on 2007-08-05

If ~/.a2dprc is configured with the various cmds nonexecutable, e.g.
	cmdplay=nonexistent --play
then upon the corresponding AVRCP event (such as when the headphone
connects), a2dpd will fork a process that uses 100% of CPU time and 
drives Pulseaudio crazy (also 100% CPU, on a dual core machine), 
eventually killing it.

The reason is this:  In a2dpd_ipc.c, subroutine async_run_process
forks and the child execs (execvp) the command, which fails, so 
execvp returns.  The child then does a DBG printout (if enabled) and 
returns from the subroutine back to the main loop where the parent is 
also executing. Things go downhill from there.  

The attached patch makes the child exit in this case.  I also "improved"
some of the error messages so you can recognize spurious whitespace. 
I wish I could give an unconditional error printout, i.e. not only if
debug printout is turned on, but I didn't see a relevant macro.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)


--- plugz/alsa-plugins/a2dpd/a2dpd_ipc.c.orig	2007-05-23 06:14:41.000000000 -0700
+++ plugz/alsa-plugins/a2dpd/a2dpd_ipc.c	2007-08-12 11:33:48.000000000 -0700
@@ -433,8 +433,8 @@
         char* argv[8];
         int i = 0, status = 0;
         strncpy(command, cmd, sizeof(command));
-        DBG("Command is %s", command);
         command[sizeof(command)-1]= '\0';
+        DBG("Command is '%s'", command);
         memset(argv, 0, sizeof(argv));
         argv[0] = command;
 
@@ -451,7 +451,7 @@
         }
 
 	for(i=0; i < ARRAY_SIZE(argv); i++) {
-		DBG("argv[%d] = %s", i, argv[i]?argv[i]:"NULL");
+		DBG("argv[%d] = '%s'", i, argv[i]?argv[i]:"NULL");
 		if(!argv[i]) break;
 	}
 
@@ -466,12 +466,12 @@
 
                                 // Replace children with new process
                                 i = execvp(command, argv);
-                                DBG("execlp failed %s=%d (errno=%d:%s)", cmd, i, errno, strerror(errno));
-                                break;
+                                DBG("execvp failed (%d), command='%s' (errno=%d:%s)", i, cmd, errno, strerror(errno));
+                                exit(EXIT_FAILURE);
                         case -1:
                                 // failed
-                                DBG("Fork %s failed", cmd);
-                                break;
+                                DBG("Fork failed, command='%s' (errno=%d:%s)", cmd, errno, strerror(errno));
+                                exit(EXIT_FAILURE);
                         default:
                                 DBG("Forked %s", cmd);
                                 // Parent wait for completion if asked

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
