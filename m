Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluez-utils2: Bluetooth header files not found
From: Marcel Holtmann <marcel@holtmann.org>
To: Pierre N <pierren@mac.com>
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <1082711899.23022.10.camel@localhost>
References: <1082711899.23022.10.camel@localhost>
Content-Type: text/plain
Message-Id: <1082721025.1843.1.camel@merlin>
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
Date: Fri, 23 Apr 2004 13:50:26 +0200

Hi Pierre,

> Trying to compile bluez-utils2 out from CVS. I get this error message on
> ./configure:
> 
> checking for unistd.h... yes
> checking bluetooth/bluetooth.h usability... no
> checking bluetooth/bluetooth.h presence... no
> checking for bluetooth/bluetooth.h... no
> configure: error: Bluetooth header files not found
> 
> I tried ./configure --without-bluetooth
> ./configure --with-bluetooth=/usr/src/kernel-headers-2.4.22 I always get
> the same error message.
> 
> Using 2.4.22 on powerpc. What else do you guys need?

you must not specify the path of the kernel includes, because userspace
programs should never include kernel header files. It is the prefix of
your previous installed libs2 from CVS.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
