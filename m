Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4396F911.40705@rumms.uni-mannheim.de>
From: =?ISO-8859-15?Q?Andreas_F=E4rber?= <afaerber@rumms.uni-mannheim.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Subject: [Bluez-devel] Reading RSSI of non-connected devices
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
Date: Wed, 07 Dec 2005 16:00:33 +0100

Hello,

We are trying to programmatically read the signal strength of Bluetooth 
devices at discovery time (not only for connections). Seeing through the 
source code it appears that in some cases (BT 1.2?) an inquiry gets an 
HCI response that includes the RSSI (struct inquiry_info_with_rssi). 
This information appears to be cached in struct inquiry_data if 
available, 0 otherwise. However the only way to access this information 
seems to be to get a pointer to a hci_dev struct (e.g. through 
hci_dev_get(int index)) and use its inq_cache member? Getting this 
information from the client side is not possible right now?

As I understand it from the code, the libBluetooth.so library does an 
ioctl on an HCI socket with specific predefined commands such as HCIINQUIRY.
How should we go about adding the functionality we need? Would we need 
to define a custom HCI socket command and handle it somewhere in a 
customized Kernel module? Or is there an easier way?

Thanks for any hints,

Andreas



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
