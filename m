Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <000501c5c58c$97724970$0300a8c0@akira>
From: "Sir Graham" <sirgraham@endorasoft.es>
To: <bluez-devel@lists.sourceforge.net>
References: <008901c5c523$ab190cc0$0300a8c0@akira> <1128062557.4955.1.camel@localhost.localdomain>
Subject: Re: [Bluez-devel] Problems to compilate a code in Red Hat 9
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
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
Date: Fri, 30 Sep 2005 09:00:07 +0200

Hi Marcel,

Thanks for you answer....

Where can i download bluez-libs development package?

I think red hat haven´t any update of the kernel.....

Best Regards,
Sir Graham.

----- Original Message ----- 
From: "Marcel Holtmann" <marcel@holtmann.org>
To: <bluez-devel@lists.sourceforge.net>
Sent: Friday, September 30, 2005 8:42 AM
Subject: Re: [Bluez-devel] Problems to compilate a code in Red Hat 9


Hi,

> One stupid question...
>
> I Try to compilate your example of bluetooth code but  I have a
> problem:
> (I using Ret HAT 9 with blueZ, the module of bluetooth works perfect).
>
> Well when I try to compilate the coder with the GCC (make command),
> the GCC don´t found the <bluetooth/bluetooth.h>
>
> Can you comment the correct configurate to compilate this?
> I am sure that the problem is for my configuration.
>
> (The BlueZ includes are in my machine
> in /usr/scr/linux-2.4.20-31.9/include/net/bluetooth)

we don't mix kernel headers with userspace headers. Get yourself the
bluez-libs development package and actually the latest 2.6 kernel would
also be a good idea.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
