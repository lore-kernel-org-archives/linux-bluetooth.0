Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] PAN profile of bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
To: blookk - <blookk@hotmail.com>
Cc: bluez-devel@lists.sf.net
In-Reply-To: <BAY1-F217RtMeKbK1tH00042281@hotmail.com>
References: <BAY1-F217RtMeKbK1tH00042281@hotmail.com>
Content-Type: text/plain
Message-Id: <1093865451.5620.9.camel@pegasus>
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
Date: Mon, 30 Aug 2004 13:30:52 +0200

Hi,

> I want to connect 2 pc using the PAN profile. I do this things:
> 
> - In server and client:
> 
> insmod rfcomm
> insmod l2cap
> insmod bnep
> 
> hcid -n &
> sdpd -n &
> sdptool add LAN

there is no "sdptool add", because pand can do this by itself. And btw
you said you wanted PAN and not LAN access using PPP.

> - In the server:
> The file hcid.conf :    lm accept,master;
> in the console     :    pand --listen --role GN
> 
> - In the client:
> The file hcid.conf :    lm accept,master;
> in the console     :    pand --connect 00:11:22:33:44:55

This will never work, because only one can be the master. Don't use the
hcid.conf for setting the master role. Use --master on the server side
call of pand.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
