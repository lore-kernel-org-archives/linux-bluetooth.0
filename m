Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Newbie2
From: Marcel Holtmann <marcel@holtmann.org>
To: Ricky Soh <rickysoh@gmail.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <db972f4304081918374eb047c6@mail.gmail.com>
References: <db972f4304081918374eb047c6@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1092989927.18082.56.camel@pegasus>
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
Date: Fri, 20 Aug 2004 10:18:47 +0200

Hi Ricky,

> I have bought a bluetooth dongle and is working in linux environment.
> However, i have problem getting rfcomm and hcitool to work. I did a
> hciconfig and see that the device is up and working. However when i
> try to connect to it using
> 
> rfcomm -i hciX  connect hci0
> 
> I got: can't connect RFcomm socket: Host is down. When i did hcitool cc method:
> 
> hcitool -i hci0 cc --role=m 00:01:...
> Can't create connection: Connection timed out
> or 
> Can't create connection: Input/output error
> 
> Sorry, i am new in this field. Could anyone give me some pointers?

read the manpages of these tools and be aware of that you never can
connect back to your dongle. Loopback connections are not possible with
Bluetooth.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
