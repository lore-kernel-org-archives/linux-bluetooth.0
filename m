Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050128141322.96979.qmail@web60904.mail.yahoo.com>
From: Ka Kin Cheung <michaelhku2002@yahoo.com.hk>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-891329071-1106921601=:95083"
Subject: [Bluez-users] rfcomm question 2-AT command
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
Date: Fri, 28 Jan 2005 22:13:21 +0800 (CST)

--0-891329071-1106921601=:95083
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8bit

Hi Marcel!
I have written a program that the menu can be sent to T610 by AT command. However, I face a problem. When I send one menu to the mobile, there is 4-5 seconds delay. The syntax of my program is:
sprintf(command, "AT*EASM=\"Bt-IrConverter\",1,1,%d", item_brand+1);
  ret_code=put_command (command, answer, sizeof (answer), 5, 0);
  for (j=0; j<item_brand; j++)
  {
   sprintf(command, ",\"%s\"", device[j]);
   ret_code=put_command (command, answer, sizeof (answer), 5, 0);
   }
  sprintf(command, ",\"quit\",\r");
where the variable device[j] stores the string extracted from MySQL db. So, why is that? And how can I reduce the delay?
Thank you very much.
Michael



---------------------------------
新年願望第一位 :  找到友緣人 

--0-891329071-1106921601=:95083
Content-Type: text/html; charset=big5
Content-Transfer-Encoding: 8bit

<DIV>Hi Marcel!</DIV>
<DIV>I have written a program that the menu can be sent to T610 by AT command. However, I face a problem. When I send one menu to the mobile, there is 4-5 seconds delay. The syntax of my program is:</DIV>
<DIV>sprintf(command, "AT*EASM=\"Bt-IrConverter\",1,1,%d", item_brand+1);<BR>&nbsp;&nbsp;ret_code=put_command (command, answer, sizeof (answer), 5, 0);<BR>&nbsp;&nbsp;for (j=0; j&lt;item_brand; j++)<BR>&nbsp;&nbsp;{<BR>&nbsp;&nbsp;&nbsp;sprintf(command, ",\"%s\"", device[j]);<BR>&nbsp;&nbsp;&nbsp;ret_code=put_command (command, answer, sizeof (answer), 5, 0);<BR>&nbsp;&nbsp;&nbsp;}<BR>&nbsp;&nbsp;sprintf(command, ",\"quit\",\r");</DIV>
<DIV>where the variable device[j] stores the string extracted from MySQL db. So, why is that? And how can I reduce the delay?</DIV>
<DIV>Thank you very much.</DIV>
<DIV>Michael</DIV><p><br><hr size=1>新年願望第一位 :  <a href=http://hk.personals.yahoo.com>找到友緣人 </a><br>
--0-891329071-1106921601=:95083--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
