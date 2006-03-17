Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Service Search failed: Connection timed out
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <fe0a97c20603140341y28c27f40y6d807be1405acfff@mail.gmail.com>
References: <fe0a97c20603140341y28c27f40y6d807be1405acfff@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1142600365.4392.27.camel@localhost>
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
Date: Fri, 17 Mar 2006 13:59:25 +0100

Hi Sowmya,

> Iam trying to use : sdptool browse and Iam getting the error 
> Service Search failed: Connection timed out
> 
> (1)[root@zin03uislnx-10 blue]# sdptool browse 11:11:11:11:11:11
> Browsing 11:11:11:11:11:11 ... 
> Service Search failed: Connection timed out
> 
> I am trying out the thing from my Linux Box which has CSR chipset for
> which there are Bluez drivers.
> The bdaddr "11:11:11:11:11:11" is that of a dongle's (ISSC I guess)
> which is connected to my Windows PC running on XP using the bluetooth
> s/w. 
> 
> Though Iam able to connect to it ... (the icon in the tray turns
> green)  but iam unable to do sdpsearch ... 
> ne ideas?? 
> 
> 
> (2) Can I not initiate pairing from my linux box??? 
> when i give hcitool cc 11:11:11:11:11:11 , the icon turns green thats
> all.... 

you have multiple hcid running. Make sure only one hcid is running at a
time.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
