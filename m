Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] RE: Recent CSR BlueCore2 firmware
From: Marcel Holtmann <marcel@holtmann.org>
To: "Rybalkin, Albert" <Albert.Rybalkin@Fiserv.com>
Cc: "'bluez-devel@lists.sourceforge.net'" <bluez-devel@lists.sourceforge.net>,
   "'albertr@iral.com'" <albertr@iral.com>
In-Reply-To: <CF8C38B8FA1ED511A92400508BE37F0B0A961D3B@exchange_corp.bhcsecurities.COM>
References: 
	 <CF8C38B8FA1ED511A92400508BE37F0B0A961D3B@exchange_corp.bhcsecurities.COM>
Content-Type: text/plain
Message-Id: <1082730057.23959.110.camel@pegasus>
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
Date: Fri, 23 Apr 2004 16:20:57 +0200

Hi Albert,

> Well, I guess it wouldn't be hard to figure out that I don't 
> "have the right permissions"...

I guessed that, but you can't ask other people than the guys from CSR to
send you this tool ;)

> Anyway, is there any way to get a hold of PSTool besides paying
> mega-bucks to CSR for their BlueSuite/BlueLab SDKs? All I need is
> to be able to change persistent store settings in my
> BlueCore2-external
> module (which I've already paid for).

Actually you can use Linux and BlueZ to change every PS key. There is no
real utility like the PS tool from CSR, but with some coding experience
this is also possible. I personally don't provide a way of changing the
PS keys with any of the BlueZ utilities, because it is easy to set your
module into a non working state. Actually it is not really hard to write
a PS tool for Linux/BlueZ, but someone has to do it. If you expect me to
do it then you must found somebody who pays me for doing it, because
otherwise I won't find time for it.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
