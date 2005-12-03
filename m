Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4391B105.9060403@ncoretech.com>
From: Zaheer Ahamed <zaheer@ncoretech.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-devel] obex command timing out.Unable to connect to sdpd server.
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
Date: Sat, 03 Dec 2005 20:21:49 +0530

Hello All,

After making the correction, the "sdpd" server starts up  successfully.
Now when I try out the commands with obexftp  I get the error below,
In the second case the device seems to get disconnected.

*obexftp -b -l /root*
Scanning ...
Using   00:0B:0D:61:79:BE       BlueZ (0)
Failed to connect to SDP server: Connection timed out

or
*obexftp -b -l*
Scanning ...
Using   00:0B:0D:61:79:BE       BlueZ (0)
usb.c: USB disconnect on device <NULL>-1 address 4
Failed to connect to SDP server: Software caused connection abort


A request to all for any step-by-step guide to Obexftp with Bluetooth.

Warm Regards,

Zaheer.



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
