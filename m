Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] OBEX Push without pairing
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <42242BAB.7080406@futurlink.com>
References: <42242BAB.7080406@futurlink.com>
Content-Type: text/plain
Message-Id: <1109667687.17256.140.camel@pegasus>
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
Date: Tue, 01 Mar 2005 10:01:27 +0100

Hi Pedro,

> I am writing an applications that, among other things, sends an OBEX 
> Push to a device (e.g. a mobile phone). This is working fine, except for 
> one thing: whenever I send something to the device, the first time it 
> always asks for the PIN. I have seen that, for example, kbluetooth (the 
> KDE Bluetooth framework) and Impronto can send a file without pairing 
> first. How can I do that?
> 
> I am sure that I am missing something, but still have not found what. In 
> my application, I call to socket(), bind() to a local address 
> (BDADDR_ANY) and then connect(). It is at the connect stage that the 
> pairing takes place. I have been following the code of kbluetooth and 
> all I can see is that I am doing essentially the same.

it seems that your device is working in security mode 3 and then
actually every ACL connection requests the authentication. The simple
answer is to use security mode 1/2.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
