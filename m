Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20060119043024.47723.qmail@web15005.mail.cnb.yahoo.com>
From: Chenghua Yan <hua9008@yahoo.com.cn>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1691789102-1137645024=:46561"
Subject: [Bluez-users] Questions about btsco
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
Date: Thu, 19 Jan 2006 12:30:24 +0800 (CST)

--0-1691789102-1137645024=:46561
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit

Hi all
   
  When I run the command
  # btsco -v bdaddr
  I have thouble with it.
  It stops by the line:
  " ret=poll(pfds,nfds,-1); "
  The parameters it returns are:
  ret=-1,error=4,EINTR=4
  Is it related with my USB Dangle(it is ISSC,not CSR)?
  Or any other reasons?
  If it is,then what should I do ?
   
  Thanks.
   
   

		
---------------------------------
无限容量雅虎相册，原图等大下载，超快速度，赶快抢注！ 
--0-1691789102-1137645024=:46561
Content-Type: text/html; charset=gb2312
Content-Transfer-Encoding: 8bit

<DIV id=RTEContent>Hi all</DIV>  <DIV>&nbsp;</DIV>  <DIV>When I run the command</DIV>  <DIV># btsco -v bdaddr</DIV>  <DIV>I have thouble with it.</DIV>  <DIV>It stops by the line:</DIV>  <DIV>" ret=poll(pfds,nfds,-1); "</DIV>  <DIV>The parameters it returns are:</DIV>  <DIV>ret=-1,error=4,EINTR=4</DIV>  <DIV>Is&nbsp;it related with my USB Dangle(it is ISSC,not CSR)?</DIV>  <DIV>Or any other reasons?</DIV>  <DIV>If it is,then what should I do ?</DIV>  <DIV>&nbsp;</DIV>  <DIV>Thanks.</DIV>  <DIV>&nbsp;</DIV>  <DIV>&nbsp;</DIV><p>
		<hr size=1><a href="https://reg.cn.yahoo.com/cnreg/cnreg_first?id=78999&.prop=photo" target=blank>无限容量雅虎相册，原图等大下载，超快速度，赶快抢注！</a> 
--0-1691789102-1137645024=:46561--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
