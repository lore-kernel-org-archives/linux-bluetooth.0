Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] not able to send SCO voice data
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan van der Boom <Johan.vanderBoom@tomtom.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <F162D20C428AB34E9E4491C6CF5F8B9A02A1813B@posthoorn.intra.local>
References: <F162D20C428AB34E9E4491C6CF5F8B9A02A1813B@posthoorn.intra.local>
Content-Type: text/plain
Message-Id: <1098868839.6611.18.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 27 Oct 2004 11:20:39 +0200

Hi Johan,

> I'm trying to run the hstest and am unable to send any SCO voice data to
> the headset. Receiving SCO voice data from the headset works OK. After
> several successful writes to the SCO socket it returns an error. None of
> the successful writes have actually been transmitted over the HCI UART
> link.
> 
> hciconfig returns:
>   ACL MTU: 120:20  SCO MTU: 64:0
> 
> The 'hci read buffer size' command returns:
>   < HCI Command: Read Buffer Size (0x04|0x0005) plen 0
>   > HCI Event: Command Complete (0x0e) plen 11
>     01 05 10 00 78 00 00 14 00 00 00
> 
> What I think is happening, is that the BlueZ stack thinks the bluetooth
> device has not got any space to store any SCO packets since the 'hci
> read buffer size' command returns 0 for HC_Total_Num_SCO_Data_Packets
> and also 0 for HC_SCO_Data_Packet_Length, and therefore does not send
> any SCO data and at some point runs out of internal buffers and returns
> an error in the write to the SCO socket.
> 
> Is this assumption correct?, Or does the BlueZ stack interpret the 0
> HC_Total_Num_SCO_Data_Packets as meaning the bluetooth device does not
> support flow control as is intended by the bluetooth device, and
> something else goes wrong?

I don't think that this is the problem. Since you use an UART as host
transport you should try a voice setting of 0x0040 and modify the hstest
tool to use 8bit instead of 16bit.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
