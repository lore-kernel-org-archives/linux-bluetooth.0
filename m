Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] BT unter SuSE 9.2
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAAe5n9ZOsCok+R7CALunouowEAAAAA@t-online.de>
References: 
	 <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAAe5n9ZOsCok+R7CALunouowEAAAAA@t-online.de>
Content-Type: text/plain
Message-Id: <1102758152.19086.12.camel@pegasus>
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
Date: Sat, 11 Dec 2004 10:42:32 +0100

Hi Peter,

> at first, thanks a lot. Now there is no error-message any more.

you are welcome.

> I'm able to get a connection with the BT-accesspoint, but only for a short
> time. The AP is identified as LAN/Bluetooth Network Device.
> With Connection Info I see the Device name, Address and Signal strength
> during connection. After a short time the connection goes down (timeout?).
> 
> With YaST I configured bnepX and it is shown as network device bnep0. The AP
> is plugged in a telephonesystem (DSL-System) which has also a router- and a
> switch-function. I need the router-function in order to reach the internet.
> But I'm not able to use bnep0 for the configuration of DSL with YaST neither
> ISDN and Modem. I only find bnep0 in YaST at network device, like ethppp0
> and so on. Have I to install additional systems to make bnep0 available for
> DSL???

Why don't you try the easy way first? Use pand to connect and then use
DHCP to configure your IP address. What kind of AP is this?

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
