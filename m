Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Toshiba and BT (SuSE 9.2)
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAAqEXdOIv5C0ypKYTFbykpjAEAAAAA@t-online.de>
References: 
	 <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAAqEXdOIv5C0ypKYTFbykpjAEAAAAA@t-online.de>
Content-Type: text/plain
Message-Id: <1103226781.6325.5.camel@notepaq>
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
Date: Thu, 16 Dec 2004 20:53:01 +0100

Hi Peter,

> very, very good news. I got the connection.
> 
> ##>
> ##>	dund -n -D -P 1 -X -c 00:0B:CE:00:01:8F
> ##>
> 
> Linux-Notebook:~ # dund -n -D -P 1 -X -c 00:0B:CE:00:01:8F
> dund[8823]: Bluetooth DUN daemon
> dund[8823]: Connecting to 00:0B:CE:00:01:8F channel 1
> dund[8823]: Connection established
> Linux-Notebook:~ # Using interface ppp0
> Connect: ppp0 <--> /dev/rfcomm0
> local  IP address 192.168.1.76
> remote IP address 192.168.1.250
> Script /etc/ppp/ip-up finished (pid 8862), status = 0x0
> 
> What is now to do in order to reach the router and by this the internet?

you may need to tweak some PPP settings to get a defaultroute, but then
it should work out of the box. Your router should do the NAT for you.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
