Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: soraberri <421246@posta.unizar.es>
Message-ID: <cq6fnu$o0n$1@sea.gmane.org>
References: <cq6cqd$fs2$1@sea.gmane.org> <1103542976.29892.92.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
In-Reply-To: <1103542976.29892.92.camel@pegasus>
Subject: [Bluez-devel] Re: learning the basics
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
Date: Mon, 20 Dec 2004 13:14:12 +0100

Marcel Holtmann wrote:
> Hi,
> 
> 
>>This morning, in an attempt of auto-encourage myself, I thougth I was 
>>going to be able to compile the l2test application by my own, only from 
>>the l2test.c source and having all the required libraries properly 
>>installed... Of course I couldn't (crying). My fatal sin is that I'm 
>>learning programming, communications, bluetooth and Linux, all the same 
>>time, and all the same way (you can see that way). I hope don't bother 
>>you trying to justify myself of asking the following question:
>>
>>¿Could you give me some ligth in the points to consider while compiling 
>>a user-made source like the l2test application? I want to do this way 
>>only for learning pourposes, in order to glimpse a bit the whole picture.
>>I'm getting errors of type "undefined references" like the following
>>
>>linking l2captest (libtool)
>>linking l2captest (gcc)
>>/home/soraberri/Desarrollo/estudioC/l2captest/src/l2captest.c:222: 
>>undefined reference to `strtoba'
>>l2captest.o(.text+0x680):/home/soraberri/Desarrollo/estudioC/l2captest/src/l2captest.c:222: 
>>undefined reference to `baswap'
>>/home/soraberri/Desarrollo/estudioC/l2captest/src/l2captest.c:328: 
>>undefined reference to `baswap'
>>l2captest.o(.text+0xb54):/home/soraberri/Desarrollo/estudioC/l2captest/src/l2captest.c:329: 
>>undefined reference to `batostr'
>>/home/soraberri/Desarrollo/estudioC/l2captest/src/l2captest.c:643: 
>>undefined reference to `hci_devba'
>>l2captest.o(.text+0x14df):/home/soraberri/Desarrollo/estudioC/l2captest/src/l2captest.c:645: 
>>undefined reference to `str2ba'
>>*** Exited with status: 2 ***
>>
>>Theese functions are defined in bluetooth.h as you know. I thougth I 
>>should link with the -L /lib/modules/2.6.9-1.667/kernel/net/bluetooth/ 
>>flag, but there is the same output.
> 
> 
> don't link anything against any kernel stuff from userspace. This will
> never work. I don't understand why don't you use --enable-test from the
> bluez-utils configure script. However what you are searching for is:
> 
> 	gcc l2captest.c -o l2captest -lbluetooth
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now. 
> http://productguide.itmanagersjournal.com/

Hi Marcel
Yes, I appreciate very much your answer. You've solved the whole of my 
actual doubts. You said you didn't understand why I don't just use 
--enable-test from the bluez-utils configure script. Well that's easy: 
because I didn't know about the possibility. Anyway, it's helpful for me 
  in order to learn.
Thanks Marcel



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
