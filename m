Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Jayathilake LS E/00/102" <sanjeewa.e00@ee.pdn.ac.lk>
To: bluez-users@lists.sourceforge.net
Message-Id: <20060120084602.M85826@ee.pdn.ac.lk>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Subject: [Bluez-users] voice over sco using SiW3000 (Silicon Wave)
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
Date: Fri, 20 Jan 2006 14:45:51 +0600



Hi

I am strugling with sending voice to a bluetooth headset via linux pc 
(with USB dongle). currently I have linux box with RedHat 9 install and 
 kernal is 2.4.20(patch with patch-2.4.20-mh6)  .and also I have 
 installed bluez-2.12, further did some modification to the hci_usb.c.
 I am using bluezsco and alsa-0.9.6
 
 finally we could send voice to headset via USB dongle(CSR) no problem ,
 
 1. But with dongle (Silicon wave) it was not working .
 2. also setups are quite same with other one(CSR) but only the noise can 
    be heard.
 3. seems to me sco channal was the problem .
 4. when I see use hcidump I could see there are no sco packets comming.
 
 If u can please send me why this is not working , do these two types 
 different  and it will be a great help if u can send me a solution

Lasantha



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
