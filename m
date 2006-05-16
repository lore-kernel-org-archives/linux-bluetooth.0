Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20060516104849.16848.qmail@web50514.mail.yahoo.com>
From: Mahtab Hossain <mahtab_hossain2002@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-2080163837-1147776529=:16521"
Subject: [Bluez-users] Request with RSSI
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
Date: Tue, 16 May 2006 03:48:49 -0700 (PDT)

--0-2080163837-1147776529=:16521
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

In the previous emails from the archive, I read that "hci_inquiry"  doesn't provide RSSI value on Inquiry. The suggestion was to use raw  sockets to achieve it.
  
  I had found Scott Gifford's code using exactly that approach (in the  archive). But my problem is: I always get EVT_INQUIRY_RESULT, not the  desired  EVT_INQUIRY_RESULT_WITH_RSSI.
  
  I check the "mode" value usingn "hci_read_inquiry_mode" which gave me  1. Is it correct? I don't know what mode should be set for  Request_with_RSSI.
  
  Also, my hci_send_cmd looks like the following (copied from Scott's program):
  hci_send_cmd(dd, OGF_LINK_CTL, OCF_INQUIRY, INQUIRY_CP_SIZE, &cp);
  where
  cp.lap[2] = 0x9e
  cp.lap[1] = 0x8b
  cp.lap[0] = 0x33
  
  I don't know what these values mean (I see exactly similar value for  cp.lap in the hci_inquiry function from the bluez libraries). Could  anyone give me any pointers to know more about them?
  
  Thanks
  Mahtab
  
  PS. My dongle and mobile phone both support "Request with RSSI" feature.
  
		
---------------------------------
Yahoo! Messenger with Voice. Make PC-to-Phone Calls to the US (and 30+ countries) for 2¢/min or less.
--0-2080163837-1147776529=:16521
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

In the previous emails from the archive, I read that "hci_inquiry"  doesn't provide RSSI value on Inquiry. The suggestion was to use raw  sockets to achieve it.<br>  <br>  I had found Scott Gifford's code using exactly that approach (in the  archive). But my problem is: I always get EVT_INQUIRY_RESULT, not the  desired&nbsp; EVT_INQUIRY_RESULT_WITH_RSSI.<br>  <br>  I check the "mode" value usingn "hci_read_inquiry_mode" which gave me  1. Is it correct? I don't know what mode should be set for  Request_with_RSSI.<br>  <br>  Also, my hci_send_cmd looks like the following (copied from Scott's program):<br>  hci_send_cmd(dd, OGF_LINK_CTL, OCF_INQUIRY, INQUIRY_CP_SIZE, &amp;cp);<br>  where<br>  cp.lap[2] = 0x9e<br>  cp.lap[1] = 0x8b<br>  cp.lap[0] = 0x33<br>  <br>  I don't know what these values mean (I see exactly similar value for  cp.lap in the hci_inquiry function from the bluez libraries). Could  anyone give me any pointers to know more about them?<br>  <br>  Thanks<br> 
 Mahtab<br>  <br>  PS. My dongle and mobile phone both support "Request with RSSI" feature.<br>  <p>
		<hr size=1>Yahoo! Messenger with Voice. <a href="http://us.rd.yahoo.com/mail_us/taglines/postman1/*http://us.rd.yahoo.com/evt=39663/*http://voice.yahoo.com">Make PC-to-Phone Calls</a> to the US (and 30+ countries) for 2¢/min or less.
--0-2080163837-1147776529=:16521--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
