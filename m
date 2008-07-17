Return-Path: <cyrus@holtmann.org>
Message-ID: <f8a8efe40807170549h2b13fffdy3913b6175742c702@mail.gmail.com>
Date: Thu, 17 Jul 2008 14:49:46 +0200
From: Mateusz <m.patelak@gmail.com>
To: Sam <rotisseriecat@gmail.com>
Subject: Re: bluez-utils compilation error.
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <a1d1ffe0807170424r7ae9fa84pa55a504432a8e70e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <a1d1ffe0807170424r7ae9fa84pa55a504432a8e70e@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I had the same problem, here is a solution I got from the #bluez IRC.

You have to compile and install the bluez-libs first. Remember to run
the configure script with prober --prefix option set to path of your
system's lib directory (eg. /usr/lib).

Configure bluez-utils with the same prefix option. Compile and install.

Hope it helps,
Mateusz


2008/7/17 Sam <rotisseriecat@gmail.com>:
> Hello. I'm having a bit of trouble compiling bluez-utils using the
> .tar.gz source. I need to run this configuration to enable all the
> tools (dfutool, etc.)
>
> Here's a pastebin of the bash: http://pastebin.ca/1073779
>
> make[2]: Entering directory `/home/g/Desktop/bluez/bluez-utils-3.36/hcid'
> make  all-am
> make[3]: Entering directory `/home/g/Desktop/bluez/bluez-utils-3.36/hcid'
> gcc -DHAVE_CONFIG_H -I. -I.. -I../common -I../sdpd
> -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include -I../eglib
> -I../gdbus -DPLUGINDIR=\""/g/lib/bluetooth/plugins"\" -Wall -O2
> -D_FORTIFY_SOURCE=2 -fPIE -MT security.o -MD -MP -MF
> .deps/security.Tpo -c -o security.o security.c
> security.c: In function 'link_key_request':
> security.c:279: error: storage size of 'req' isn't known
> security.c:291: error: 'HCIGETAUTHINFO' undeclared (first use in this function)
> security.c:291: error: (Each undeclared identifier is reported only once
> security.c:291: error: for each function it appears in.)
> security.c:279: warning: unused variable 'req'
> make[3]: *** [security.o] Error 1
> make[3]: Leaving directory `/home/g/Desktop/bluez/bluez-utils-3.36/hcid'
> make[2]: *** [all] Error 2
> make[2]: Leaving directory `/home/g/Desktop/bluez/bluez-utils-3.36/hcid'
> make[1]: *** [all-recursive] Error 1
> make[1]: Leaving directory `/home/g/Desktop/bluez/bluez-utils-3.36'
> make: *** [all] Error 2
>
> Any thoughts on what might be the trouble would be greatly
> appreciated.  Is it possible to find a .deb package of bluez-utils
> with all the tools enabled?
>
> Thank you,
>
> Sam
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
