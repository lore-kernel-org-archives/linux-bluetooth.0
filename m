Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] PROBLEM: device node rfcomm0 is removed, but not
	created.
From: Marcel Holtmann <marcel@holtmann.org>
To: Christoph Burger-Scheidlin <andersin@gmx.net>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200404281515.02262.andersin@gmx.net>
References: <200404281515.02262.andersin@gmx.net>
Content-Type: text/plain
Message-Id: <1083158876.4000.26.camel@pegasus>
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
Date: Wed, 28 Apr 2004 15:27:56 +0200

Hi Christoph,

> [1] device node rfcomm0 is removed by sysfs upon ppp disconnect, but not 
> created on connect
> 
> [2] I am connecting a palm Tungsten T to my linux box using bluetooth (bluez 
> stack). I am using dund to listen for incoming connections. My problem is, 
> that the device node rfcomm0 is not created automatically. However, if I 
> create it manually, it is removed upon termination of the connection, by 
> sysfs presumably. Creating the node manually, the connection works fine.
> 
> In my rfcommd.conf settings, I have set:
> rfcomm0 {
>                 bind no;
>                 device <btaddr of palm>;
>                 channel 1;
>                 comment "Tungsten";
> }
> 
> which appears to be the problem. Setting "bind yes;" will cause the device 
> node to be created, but the connection fails, presumably because the Tungsten 
> does not allow binding.
> 
> I also tested bluetooth connectivity with my cellphone. issuing the command
> rfcomm bind 3 <btaddr of cellphone> works and also creates the device 
> node /dev/rfcomm3.
> 
> [3] bluetooth rfcomm sysfs
> 
> [4] 2.6.5
> 
> I will be happy to provide the rest upon request, but deem it too long to post 
> it initially

the problem will be that the dund creates the RFCOMM TTY devices by
itself and actually when you use udev it takes some time until the
device node appears. The "rfcomm connect" function had the same problem
and we need a similar fix for dund.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
