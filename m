Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <439060DA.4000401@anymore.nl>
From: Arjan Schrijver <arjan@anymore.nl>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-devel] hciattach patch: make the device string longer
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
Date: Fri, 02 Dec 2005 15:57:30 +0100

Hi people,

For our port on the HP Ipaq 1940, we want to use Bluez as the bluetooth 
library.
Our work is mostly based at handhelds.org, we want to have the Familiar 
distribution on our devices too.
We were having some problems with hciattach not working as it should, 
and finally pinpointed it on one specific line.
At the top of main() in hciattach.c, the device node is put in a 
variable 'dev', which is only 20 bytes long. The problem is that our 
device is (with null-termination character) exactly 21 bytes long.
So that's why I propose the patch at the bottom of this mail, it's 
actually a 1-character patch.
Excuse me if I break into existing conversations, or this has already 
been fixed in CVS. (I only checked the latest release)
Thanks in advance for your comments!

Regards, Arjan Schrijver


--- tools/hciattach.c.old       2005-12-02 10:51:22.000000000 +0100
+++ tools/hciattach.c   2005-12-02 10:52:17.000000000 +0100
@@ -968,7 +968,7 @@
        int send_break = 0;
        pid_t pid;
        struct sigaction sa;
-       char dev[20];
+       char dev[25];

        detach = 1;
        printpid = 0;




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
