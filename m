Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] playing with handsfree program
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <pan.2005.01.12.16.28.16.406386@yahoo.com>
References: <pan.2005.01.12.16.28.16.406386@yahoo.com>
Content-Type: text/plain
Message-Id: <1105551836.7961.130.camel@pegasus>
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
Date: Wed, 12 Jan 2005 18:43:56 +0100

Hi Paul,

> I am trying to use handsfree-040326.tar.gz from
> http://140.78.95.100/~vogl/bluez/ to emulate a handsfree device with my
> computer and BT adapter. 
> I recompiled the program and tried to execute it but I receive imediately
> a:
>  ./handsfree test.wav 00:60:57:80:84:71 12
> Voice setting: 0x0060
> Can't connect RFCOMM channel: Invalid argument
> 
> I think it is because of recent changes in bluez-libs and utilities,
> because a " rfcomm connect hci0 MY_BT_ADDR 12 " works just fine.

I am not aware of any change that could cause this error message.

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
