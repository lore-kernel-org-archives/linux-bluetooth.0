Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] dund
From: Marcel Holtmann <marcel@holtmann.org>
To: "Peter K. Martin" <Peter.K.Martin@t-online.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAAcQVCQupGlk2RyIgNqeo5ggEAAAAA@t-online.de>
References: 
	 <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAAcQVCQupGlk2RyIgNqeo5ggEAAAAA@t-online.de>
Content-Type: text/plain
Message-Id: <1099394704.10948.36.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 02 Nov 2004 12:25:03 +0100

Hi Peter,

> I need additional help to establish a connection from my Toshiba to an
> accesspoint. The AP supports LAP via DUN but needs a password for the
> connection.
>  
> I'm able to find the AP
> 
>  
> 
> Linux-Notebook:~ # hcitool scan
> 
> Scanning ...
> 
>         00:0B:CE:00:01:8F       Bluetooth-Modul
> 
>  
> but I'm not able to connect via dund
>  
> 
> Linux-Notebook:~ # dund --connect 00:0B:CE:00:01:8F
> 
>  
> 
> there is no response. lsmod gives me

take a look at the syslog.

> and sdptool browse gives the response, that the access is rejected.
>  
> What can I do to connect to the AP?

Run "hcidump -X" as root see why it fails. Is the hcid running?

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
https://lists.sourceforge.net/lists/listinfo/bluez-users
