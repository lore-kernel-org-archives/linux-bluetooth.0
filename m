Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Problems with InputStream and OutputStream
From: Marcel Holtmann <marcel@holtmann.org>
To: Johannes <lintner@c-lab.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <41342BF8.2040703@c-lab.de>
References: <1324.1093866265@www49.gmx.net>
	 <1093867195.5620.16.camel@pegasus>  <41331EBB.9000606@gmx.de>
	 <1093869614.5620.24.camel@pegasus>  <41342BF8.2040703@c-lab.de>
Content-Type: text/plain
Message-Id: <1093947830.5620.114.camel@pegasus>
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
Date: Tue, 31 Aug 2004 12:23:50 +0200

Hi Johannes,

> the BTMidServ runs on the Linux side as the server.

I thought you use some C code for the server. I am not a Java expert and
actually I don't have fun reading Java source code.

>     gotland:~# hcitool info 00:02:72:80:B1:6F
>     Device is not available or not connected.

You must fill in the BD_ADDR of your phone.

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
