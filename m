Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: "Peter K. Martin" <Peter.K.Martin@t-online.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAAmw8F2L2GLkSuK/qWO0/qzgEAAAAA@t-online.de>
References: 
	 <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAAmw8F2L2GLkSuK/qWO0/qzgEAAAAA@t-online.de>
Content-Type: text/plain
Message-Id: <1102968227.2143.16.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-users] Re: Toshiba and BT (SuSE 9.2)
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
Date: Mon, 13 Dec 2004 21:03:47 +0100

Hi Peter,

> here I'm again, the story is still runing. Now I'm able to connect to
> the BT-accesspoint with pand only a short time till timeout.
> I tried hcitool cc <baddr>
> At first I have to start dmabt
> 
> Linux-Notebook:~ # dmabt
> 
> then
> 
> Linux-Notebook:~ # hcitool scan
> 
> Scanning ...
> 
>         00:0B:CE:00:01:8F       Bluetooth-Modul
> 
> the next step was
> 
> Linux-Notebook:~ # hcitool cc 00:0B:CE:00:01:8F
> 
> Linux-Notebook:~ # hcitool con
> 
> Connections:
> 
>         < ACL 00:0B:CE:00:01:8F handle 41 state 1 lm SLAVE
> 
> Linux-Notebook:~ # ip link show
> 
> 1: lo: <LOOPBACK,UP> mtu 16436 qdisc noqueue
> 
>     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
> 
> 2: eth0: <BROADCAST,MULTICAST,NOTRAILERS,UP> mtu 1500 qdisc pfifo_fast
> qlen 1000
> 
>     link/ether 00:08:0d:a9:18:53 brd ff:ff:ff:ff:ff:ff
> 
> 3: sit0: <NOARP> mtu 1480 qdisc noqueue
> 
>     link/sit 0.0.0.0 brd 0.0.0.0
> 
> Linux-Notebook:~ #                 
> 
> 
>  
> With YaST pand was set as pand --search --master
> and as networkdevice bnep0 was initialized, so I don't understand why
> it doesn't apear within the listing of ip link show.
> The setup of network accesses by YaST for DSL also doesn't give me the
> opportunity to use bnep0 as connection for DSL. There is only as
> PPP-Modus PPP via Ethernet, etc. available, but not PPP via Bluetooth
> as I expected. 
>  
> Please, what is to do in order to get this foolish bnep0 device
> availabe for DSL? bnep0 only appears in the initialization-area for
> network devices.

maybe it is not a good idea to configure bnep0 with YaST at the moment
and actually I never tried this. If your AP is configured in router mode
then you should simply run "pand -n -c <bdadd>" and then "dhcpcd bnep0".

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
