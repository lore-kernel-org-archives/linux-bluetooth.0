Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Connect Error - Function not implemented
From: Marcel Holtmann <marcel@holtmann.org>
To: George <george.news@gmx.net>
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <6.1.2.0.2.20040902194629.053ab320@luna.tlmat.unican.es>
References: <6.1.2.0.2.20040902194629.053ab320@luna.tlmat.unican.es>
Content-Type: text/plain
Message-Id: <1094459161.5145.12.camel@notepaq>
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
Date: Mon, 06 Sep 2004 10:26:01 +0200

Hi George,

> I'm developing under kernel 2.4.21 an application that involves dealing 
> with bluetooth devices.
> In order to make the application I have taken part of the code of the pand 
> (it's opensource great!!!). My application is very similar to that. It's a 
> daemon that firstly look for Bluetooth devices, if any found it tries to 
> establish a bnep connection and then it runs as a server in order to be 
> able to attend connection request. As you can see it's more or less all the 
> stuff in pand. I have also automate the bridge creation, ...
> 
> Well I have been checking the correct behaviour by running my application 
> and then connecting using pand. This way everything works ok.
> 
> However when running my application on two PC I get the following error 
> from the connect statement: Function not implemented (38)
> Then if I try again with pand I still get the error.
> 
> What is the reason for this error?

check your role switch and master/slave settings and make sure that you
are not using security mode 3.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
