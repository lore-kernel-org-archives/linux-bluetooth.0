Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] rfcomm socket and rfcomm tty
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41D8F10B.5050207@avantwave.com>
References: <41D12158.6020206@avantwave.com>
	 <1104315958.6319.13.camel@notepaq>  <41D3600B.8000702@avantwave.com>
	 <1104604967.4253.4.camel@pegasus>  <41D8F10B.5050207@avantwave.com>
Content-Type: text/plain
Message-Id: <1104745873.8894.44.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 03 Jan 2005 10:51:13 +0100

Hi Mike,

>     Is it mean that rfcomm socket can not connect to a rfcomm tty?
>     If the answer is yes, Does it mean that all program base on bluez 
> should use rfcomm tty to connect to bluetooth Serial Port profile?

you can use RFCOMM socket or RFCOMM TTY to connect to the serial port
profile. Nothing matters and actually you can convert a socket into a
TTY if it is needed later. However if you don't need a TTY for legacy
reasons then always use the RFCOMM socket, because this will be much
cleaner and easier.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
