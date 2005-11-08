Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] C Program for Getting Link Quality
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <94e407f00511080958j74841800k45532fdbd149e9cd@mail.gmail.com>
References: <94e407f00511080131u11f01d79x65d05cfe47ccbb7@mail.gmail.com>
	 <1131454195.5824.161.camel@blade>
	 <94e407f00511080958j74841800k45532fdbd149e9cd@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1131473837.5544.4.camel@blade>
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
Date: Tue, 08 Nov 2005 19:17:17 +0100

Hi Arpit,

> I did a yum update bluez*.
> 
> The verion I'm using is:
> 
> [root@174-15 bluetooth]# ls -l
> total 116
> -rw-r--r--  1 root root  3607 Mar  2  2005 bluetooth.h
> 
> On including sys/socket.h..the error is the same:

maybe <sys/ioctl.h> is also missing.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
