Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Problems with InputStream and OutputStream
From: Marcel Holtmann <marcel@holtmann.org>
To: Johannes <lintner@c-lab.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <412DC001.3000307@c-lab.de>
References: <412DC001.3000307@c-lab.de>
Content-Type: text/plain
Message-Id: <1093519463.2581.3.camel@pegasus>
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
Date: Thu, 26 Aug 2004 13:24:23 +0200

Hi Johannes,

> I have the following problem.
> I want to communicate from a mobile phone to an PC with the BlueZ-Stack 
> and backwards.
> In the beginning, I only want to sent short Strings. the way from the 
> phone to the PC works, but the way backwards won't run.
> The server side (PC) tells me, that it send the string (6 bytes long), 
> the client (phone) do receive a connection, but the transported String 
> is empty (is.read() = -1).
> Is it possible, that the BlueZ implementation is the problem? I am sure, 
> that my source (Java) works correct  (on my opinion the problem can 
> cause on two reasons: the BlueZ Stack or the Bluetooth-Stack on my 
> mobile phone).

go ahead and run "hcidump -x" on the Linux side to see what is going on.

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
