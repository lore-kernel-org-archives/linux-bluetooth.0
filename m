Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4391A0A9.5090706@ncoretech.com>
From: Zaheer Ahamed <zaheer@ncoretech.com>
MIME-Version: 1.0
To: bluez-devel@lists.sf.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-devel] sdpd deamon fails to start.
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
Date: Sat, 03 Dec 2005 19:12:01 +0530

Hello All,

I have installed the bluez utilities on my embedded linux system.
However when I start "sdpd" I get the following error.

Jan 31 03:32:31 Simputer daemon.info hcid[1298]: Bluetooth HCI daemon
Jan 31 03:32:31 Simputer daemon.info hcid[1298]: HCI dev 0 up
Jan 31 03:32:31 Simputer daemon.info hcid[1298]: Starting security manager 0
Jan 31 03:32:33 Simputer daemon.err sdpd[1369]: init_server: binding 
UNIX socket: No such file or directory
Jan 31 03:32:33 Simputer daemon.err sdpd[1369]: main: Server 
initialization failed

Can anyone point out to any missing steps.
also can any body guide me to a documentation for using ObexFtp.

Warm Regards,

Zaheer.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
