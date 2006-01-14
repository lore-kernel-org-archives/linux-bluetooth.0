Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20060114084456.68918.qmail@web15010.mail.cnb.yahoo.com>
From: Chenghua Yan <hua9008@yahoo.com.cn>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-959185179-1137228296=:68873"
Subject: [Bluez-users] BTSCO problems
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
Date: Sat, 14 Jan 2006 16:44:56 +0800 (CST)

--0-959185179-1137228296=:68873
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit

  Hi all:
   
  I am now using btsco to make my pc and headset connect.The maker of the Dangle i use is ISSC,the protocol dump is bluez,and linux-2.6.14.I have configured everything following the guide of the bluetooth-alsa project,but i still have problems as following:
   
   
  # btsco 00:02:4D:0F:07:EA (the bdaddr of my headset)
  It returns:
  Error:Failed to connect to SDP server : Software caused connection abort
  Assuming channel 2
   
  Can't connect RFCOMM channel : connection refused
   
  When i add "-v" like this:
  # btsco -v 00:02:4D:0F:07:EA
  It returns:
  btsco v0.4
  Voice setting:0x0060
  RFCOMM channel 1 connected
   
  Why it doesn't work without "-v" ?
  What are they differences?
  What should I do then?
   
  Thanks. 


		
---------------------------------
无限容量雅虎相册，原图等大下载，超快速度，赶快抢注！ 
--0-959185179-1137228296=:68873
Content-Type: text/html; charset=gb2312
Content-Transfer-Encoding: 8bit

<DIV id=RTEContent>  <DIV id=RTEContent>Hi all:</DIV>  <DIV>&nbsp;</DIV>  <DIV>I am now using btsco to make my pc and headset connect.The maker of the&nbsp;Dangle i use is ISSC,the protocol dump is bluez,and linux-2.6.14.I have configured&nbsp;everything following the guide of the bluetooth-alsa project,but i still have problems as following:</DIV>  <DIV>&nbsp;</DIV>  <DIV>&nbsp;</DIV>  <DIV># btsco 00:02:4D:0F:07:EA (the bdaddr of my headset)</DIV>  <DIV>It returns:</DIV>  <DIV>Error:Failed to connect to SDP server&nbsp;: Software caused connection abort</DIV>  <DIV>Assuming channel 2</DIV>  <DIV>&nbsp;</DIV>  <DIV>Can't connect RFCOMM channel&nbsp;: connection refused</DIV>  <DIV>&nbsp;</DIV>  <DIV>When i add&nbsp;"-v" like this:</DIV>  <DIV># btsco&nbsp;-v 00:02:4D:0F:07:EA</DIV>  <DIV>It returns:</DIV>  <DIV>btsco v0.4</DIV>  <DIV>Voice setting:0x0060</DIV>  <DIV>RFCOMM channel 1 connected</DIV>  <DIV>&nbsp;</DIV>  <DIV>Why it doesn't work without "-v" ?</DIV>  <DIV>What&
 nbsp;are
 they differences?</DIV>  <DIV>What should I do then?</DIV>  <DIV>&nbsp;</DIV>  <DIV>Thanks.&nbsp;</DIV></DIV><p>
		<hr size=1><a href="https://reg.cn.yahoo.com/cnreg/cnreg_first?id=78999&.prop=photo" target=blank>无限容量雅虎相册，原图等大下载，超快速度，赶快抢注！</a> 
--0-959185179-1137228296=:68873--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
