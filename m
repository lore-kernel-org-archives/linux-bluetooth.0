Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Problem with rfcomm connect
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200502031010.56642.dolphin@slacky.it>
References: <200502031010.56642.dolphin@slacky.it>
Content-Type: text/plain
Message-Id: <1107428940.11944.29.camel@pegasus>
Mime-Version: 1.0
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
Date: Thu, 03 Feb 2005 12:09:00 +0100

Hi Andrea,

> I own a Belkin F8T001 as a Bluetooth device (=>I installed the related 
> firmware), but I get an error during the rfcomm connect command
> 
> here is my procedure (since only yesterdy I began playing with it, perhaps 
> there is a previous error I make)
> 
> 1) bluefw usb 001/00X
> 2) modprobe l2cap
> 3) modprobe rfcomm
> 4) mknod /dev/rfcomm0 c 216 0
> 5) hciconfig hci0 up
> 6) hciconfig
> 7) hcitool scan
> 8) l2ping 00:01:E3:06:FB:AF
> 9) added the following lines to /etc/bluetooth/rfcomm.conf:
> 
> rfcomm0 {
>   bind yes;
>   # Bluetooth address of the device
>   device 00:01:E3:06:FB:AF;
>   # RFCOMM channel for the connection
>   channel 0;
>   # Description of the connection
>   comment "S55";
>  }
> 10) rfcomm connect rfcomm0 00:01:E3:06:FB:AF
> 
> Everything has worked perfectly till now, but this last command returns "Can't 
> connect RFCOMM socket: Resource temporarily unavailable" or "Can't connect 
> RFCOMM socket: Function not implemented"

how should RFCOMM channel 0 work? Use the one from the "sdptool browse"
result instead.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
