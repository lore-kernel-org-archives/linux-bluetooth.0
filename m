Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: soraberri <421246@posta.unizar.es>
Message-ID: <ctbg5m$29s$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] problem decoding Link_Policy_Settings parameter
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
Date: Thu, 27 Jan 2005 20:41:21 +0100

Hi, how are you there?
I hope you could help me with this stoping problem:

let's say I do 'hcitool cc --role=m 00:10:60:A5:8F:8A'
and now, the output in hcidump is the following:

< HCI Command: Create Connection (0x01|0x0005) plen 13
   8A 8F A5 60 10 00 18 CC 02 00 00 00 00
 > HCI Event: Command Status (0x0f) plen 4
   00 01 05 04
 > HCI Event: Connect Complete (0x03) plen 11
   00 29 00 8A 8F A5 60 10 00 01 00
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
   29 00 0F 00
 > HCI Event: Command Complete (0x0e) plen 6
   01 0D 08 00 29 00
 > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
   8A 8F A5 60 10 00 01
 > HCI Event: Max Slots Change (0x1b) plen 3
   29 00 05


My problem is I cannot render an interpretation of the Write Link Policy 
Settings Command, because I read 0x000F as the Link_Policy_Settings 
parameter, and by looking at the bluetooth specification this value is 
not allowed (or at least it is not defined), so what a strange way of 
telling the device to stay master!

thanks all (especially Marcel cause none post of mine has miss one of 
his answers)



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
