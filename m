Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20060217195408.21336.qmail@web61223.mail.yahoo.com>
From: deva seetharam <tagsense@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1509687459-1140206048=:20423"
Subject: [Bluez-users] hcidump version 1.30 and DBT-120 version B-4
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
Date: Fri, 17 Feb 2006 11:54:08 -0800 (PST)

--0-1509687459-1140206048=:20423
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

hello all,
 i am trying to develop a bluetooth application on linux. here is my setup:
 * 2.6.12-1-686 kernel
 * bluez libs version 2.25
 * bluez utils version 2.25
 * hcidump version 1.30
 * hardware - D-Link DBT-120 bluetooth dongle version B4
 
 i am trying to run hcidump to sniff bluetooth packets. for some reason, hcidump doesn't produce any output eventhough the there is plenty of bluetooth  traffic in the vicinity (i have verified it using MAC OS bluetooth packet logger).
 
 when i run hcidump, all i get is the following 2 lines:
 HCI sniffer - Bluetooth packet analyzer ver 1.30
 device: hci0 snap_len: 1028 filter: 0xffffffff
 
 (btw, hcitool seems to be working ok. for instance, when i do hcitool -i hci0 scan, i see a bunch of bluetooth devices in our office.)
 
 how do i get hcidump to work with dbt-120? pls. let me know.
 
 thanks in advance,
 deva 
 
 
 
		
---------------------------------
Relax. Yahoo! Mail virus scanning helps detect nasty viruses!
--0-1509687459-1140206048=:20423
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

hello all,<br> i am trying to develop a bluetooth application on linux. here is my setup:<br> * 2.6.12-1-686 kernel<br> * bluez libs version 2.25<br> * bluez utils version 2.25<br> * hcidump version 1.30<br> * hardware - D-Link DBT-120 bluetooth dongle version B4<br> <br> i am trying to run hcidump to sniff bluetooth packets. for some reason, hcidump doesn't produce any output eventhough the there is plenty of bluetooth&nbsp; traffic in the vicinity (i have verified it using MAC OS bluetooth packet logger).<br> <br> when i run hcidump, all i get is the following 2 lines:<br> HCI sniffer - Bluetooth packet analyzer ver 1.30<br> device: hci0 snap_len: 1028 filter: 0xffffffff<br> <br> (btw, hcitool seems to be working ok. for instance, when i do hcitool -i hci0 scan, i see a bunch of bluetooth devices in our office.)<br> <br> how do i get hcidump to work with dbt-120? pls. let me know.<br> <br> thanks in advance,<br> deva <br> <br> <br> <p>
		<hr size=1>Relax. Yahoo! Mail 
<a href="http://us.rd.yahoo.com/mail_us/taglines/virusall/*http://communications.yahoo.com/features.php?page=221">virus scanning</a> helps detect nasty viruses!
--0-1509687459-1140206048=:20423--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
