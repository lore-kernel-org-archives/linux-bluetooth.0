Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: AW: [Bluez-users]  Again dund
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAANK6QCAXtF0GbwUwUahcSwAEAAAAA@t-online.de>
References: 
	 <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAANK6QCAXtF0GbwUwUahcSwAEAAAAA@t-online.de>
Content-Type: text/plain
Message-Id: <1099685906.6919.25.camel@pegasus>
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
Date: Fri, 05 Nov 2004 21:18:26 +0100

Hi Peter,

> refering to Linux I'm a very beginner and thatfore excuse my mistakes,
> please
> 
> ps x gave me:
> 
> Linux-Notebook:~ # ps x
> ...........
>  5173 ?        Ss     0:00 hcid: processing events
> etc ...........

so hcid is running.

> but the hcidump -x
> Linux-Notebook:~ # hcidump -x
> HCIDump - HCI packet analyzer ver 1.7
> device: hci0 snap_len: 1028 filter: 0xffffffff
>   <-- at this point the program stopped and I terminated with crtl-c

Leave it running. You will see something when you do something with the
HCI layer.

> I need some aditional help for the manual of hcid.conf 
> 
> nn:nn:nn:nn:nn:nn  <--- how can I give the address of the BT-modul? what
> does this mean?
> 
>               Parameters  specified within this section will be applied to
> the device with               
>                           this device bluetooth address. All other
> parameters are applied 
>                           from the default section.

You don't need this at the moment.

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
