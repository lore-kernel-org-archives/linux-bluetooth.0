Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Sending arbitrary data to a connected device
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <200511262023.23140.Loial@home.nl>
References: <200511262023.23140.Loial@home.nl>
Content-Type: text/plain
Message-Id: <1133033547.15981.2.camel@blade>
Mime-Version: 1.0
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
Date: Sat, 26 Nov 2005 20:32:27 +0100

Hi Rutger,

> I have a bluetooth device here that has an LCD display. I want to be able to 
> send arbitrary data to the device. This way I can (hopefully) make text 
> appear on the LCD display. The problem is, that I can not find enough 
> documentation to send the arbitrary data. So I'm hoping to find some help 
> here...
> 
> What I have done so far:
> - Open the hci device
> - Create a connection to the LCD device (I have no idea what all the ptype 
> flags (HCI_DM1 etc...) in hci_create_connection do :( ). This gives me a 
> handle to the LCD device.
> - I now can send hci_send_req's by filling in ogf and ocf with e.g. 
> OGF_STATUS_PARAM and OCF_READ_RSSI to read the RSSI.
> 
> But, now I'm stuck. What function can I call to send arbitrary hex data?
> Do I use hci_send_req and fill in other values for ogf/ocf and plug the data 
> into rparam? Or do I use another function? (which??)
> Any help is appreciated!

totally wrong direction. Use sdptool and its various option to discover
the services offered by this LCD device.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
