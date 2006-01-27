Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20060127081807.37283.qmail@web50509.mail.yahoo.com>
From: Mahtab Hossain <mahtab_hossain2002@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1635045577-1138349887=:37066"
Subject: [Bluez-users] hci_create_connection
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
Date: Fri, 27 Jan 2006 00:18:07 -0800 (PST)

--0-1635045577-1138349887=:37066
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

I know this has been discussed a lot of times in  this list and the conclusion was that, only use "hci_create_connection"  for debugging purpose.
  
  I created the connections with "hci_create_connection" and the  connection gets lost everytime after 40-50 seconds just like the  following email from this list (mine are BroadCom based Dongles):
  
  
"I am connecting a Armadillo CF card to a TDK PC card using "hcitool cc
 <BD_ADDR>".  The connection appears fine, but after a short period (40 sec
 or so) seems to drop off.  I am running a script to monitor the RSSI values.
 This worked fine with a 3Com card, but connection drops with the TDK.
 
 Any ideas why?
 
 Tim"
 
  I didn't see any follow-ups to this email. Any insights on why this  should happen. I know "hci_create_connection" makes link-level  connections without taking into account the transport level protocols  (like L2CAP) running on the host. But for the RSSI, TPL etc.  extraction, I need to create only link-level connection so  "hci_create_connection" would have been perfect choice for me without  that problem. Any explanation?
  If not successful, I have to work around it by creating higher transport level connections it seems.
  
  Thanks
  Mahtab
  

			
---------------------------------
 Yahoo! Autos. Looking for a sweet ride? Get pricing, reviews, & more on new and used cars.
--0-1635045577-1138349887=:37066
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div id="RTEContent">I know this has been discussed a lot of times in  this list and the conclusion was that, only use "hci_create_connection"  for debugging purpose.<br>  <br>  I created the connections with "hci_create_connection" and the  connection gets lost everytime after 40-50 seconds just like the  following email from this list (mine are BroadCom based Dongles):<br>  <br>  <pre>"I am connecting a Armadillo CF card to a TDK PC card using "hcitool cc<br> &lt;BD_ADDR&gt;".  The connection appears fine, but after a short period (40 sec<br> or so) seems to drop off.  I am running a script to monitor the RSSI values.<br> This worked fine with a 3Com card, but connection drops with the TDK.<br> <br> Any ideas why?<br> <br> Tim"<br> </pre>  I didn't see any follow-ups to this email. Any insights on why this  should happen. I know "hci_create_connection" makes link-level  connections without taking into account the transport level protocols  (like L2CAP) running on the host. 
 But for
 the RSSI, TPL etc.  extraction, I need to create only link-level connection so  "hci_create_connection" would have been perfect choice for me without  that problem. Any explanation?<br>  If not successful, I have to work around it by creating higher transport level connections it seems.<br>  <br>  Thanks<br>  Mahtab<br>  </div><p>
	
		<hr size=1> <a href="http://us.rd.yahoo.com/evt=38381/ ylc=X3oDMTEzcGlrdGY5BF9TAzk3MTA3MDc2BHNlYwNtYWlsdGFncwRzbGsDMWF1dG9z/*http://autos.yahoo.com/index.html ">Yahoo! Autos</a>. Looking for a sweet ride? Get pricing, reviews, & more on new and used cars.
--0-1635045577-1138349887=:37066--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
