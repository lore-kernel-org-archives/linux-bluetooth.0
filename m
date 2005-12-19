Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43A62010.5090009@comcast.net>
From: dave sailer <d.sailer@comcast.net>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] palm & bluez
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
Date: Sun, 18 Dec 2005 21:50:56 -0500

I'm trying to pair my palm tungsten e2 with a 2.6.11-gentoo-r9 box. I 
currently use a bluetooth keyboard & mouse, so bluez is working on the 
gentoo box. I can discover the palm from linux..

myth1 ~ # hcitool scan
Scanning ...
        00:07:E0:71:37:54       vsailer


and the palm discovers the bluetooth dongle.  On the palm I attempt to 
pair, typing in a passkey, which I then type on the gentoo box but back 
on the palm I get "Unable to add Myth1 BlueZ(0) to your trusted device 
list". hcidump gives me....


< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
    bdaddr 00:07:E0:71:37:54 len 1 pin '1'
 > HCI Event: Command Complete (0x0e) plen 10
    PIN Code Request Reply (0x01|0x000d) ncmd 1
    status 0x00 bdaddr 00:07:E0:71:37:54
 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 47 reason 0x13
    Reason: Remote User Terminated Connection

I know it appears the problem is with the palm, but I'm not sure what 
else to try here. Didn't find much in the palm newsgroups.





-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
