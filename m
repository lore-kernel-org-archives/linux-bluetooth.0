Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users]  Again dund
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAA+vFVNecj90SxNE/BGWtzYwEAAAAA@t-online.de>
References: 
	 <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAA+vFVNecj90SxNE/BGWtzYwEAAAAA@t-online.de>
Content-Type: text/plain
Message-Id: <1099925675.6896.158.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 08 Nov 2004 15:54:35 +0100

Hi Peter,

> now I have a new link_key with the right key :) :)
> 
> I'm able to connect via bluetooth
> 
> Linux-Notebook:/ # dund --connect 00:0B:CE:00:01:8F
> 
> Linux-Notebook:/ # dund --show
> rfcomm0: 00:0B:CE:00:01:8F channel 1 pppd pid 6820
> 
> marvelous!! But now I need the next step. I want to use the
> bluetooth-connection as/like an ethernet-connection as the BT-Modul gives me
> the function of a switch and router with DHCP

you get these information from PPP.

> I tried to get infos of the services provided, but no result:
> 
> Linux-Notebook:/ # sdptool browse 00:0B:CE:00:01:8F
> Browsing 00:0B:CE:00:01:8F ...
> Linux-Notebook:/ # 

If the public browse group is not supported you must do this with
"sdptool search --bdaddr 00:0B:CE:00:01:8F lan". Check the manual page
for more details.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users
