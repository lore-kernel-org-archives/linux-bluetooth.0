Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <00b101c77295$74ada8a0$8935c70a@dlh.st.com>
References: <00b101c77295$74ada8a0$8935c70a@dlh.st.com>
Date: Sat, 31 Mar 2007 15:47:40 +0200
Message-Id: <1175348860.5815.259.camel@violet>
Mime-Version: 1.0
Cc: bluez-users@lists.sf.net
Subject: Re: [Bluez-users] XML_StopParser undefined reference-
	compilation	error bluez-utils-3.9
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Sumeet,

> I am getting a compiler error while building bluez-utils-3.9. 
> The log is here:-
> 
> make[3]: Entering directory `/home/vsumeet/bluez/3.9/bluez-utils-3.9/hcid'
> /bin/sh ../libtool --tag=CC --mode=link gcc -I/usr/local/include  
> -I/usr/local/include/dbus-1.0 -I/usr/local/lib/dbus-1.0/include  
> -DDBUS_API_SUBJECT_TO_CHANGE -I../eglib -Wall -O2 -D_FORTIFY_SOURCE=2   -o hcid
>  main.o libhciserver.a ../sdpd/libsdpserver.a ../common/libhelper.a 
> ../eglib/libeglib.la -L/usr/local/lib -ldbus-1   -L/usr/local/lib -lbluetooth  
> -lexpat
> gcc -I/usr/local/include -I/usr/local/include/dbus-1.0
> -I/usr/local/lib/dbus-1.0/include -DDBUS_API_SUBJECT_TO_CHANGE -I../eglib 
> -Wall -O2 -D_FORTIFY_SOURCE=2 -o hcid main.o  libhciserver.a ../sdpd/libsdpserver.a
> ../common/libhelper.a ../eglib/.libs/libeglib.a -L/usr/local/lib
> /usr/local/lib/libdbus-1.so -lnsl /usr/local/lib/libbluetooth.so 
> /usr/lib/libexpat.so   -Wl,--rpath -Wl,/usr/local/lib -Wl,--rpath -Wl,/usr/local/lib
> ../common/libhelper.a(sdp-expat.o)(.text+0x227): In function
> `convert_xml_to_sdp_start':
> : undefined reference to `XML_StopParser' 
> collect2: ld returned 1 exit status
> make[3]: *** [hcid] Error 1
> make[3]: Leaving directory `/home/vsumeet/bluez/3.9/bluez-utils-3.9/hcid'
> make[2]: *** [all] Error 2
> make[2]: Leaving directory `/home/vsumeet/bluez/3.9/bluez- utils-3.9/hcid'
> make[1]: *** [all-recursive] Error 1
> make[1]: Leaving directory `/home/vsumeet/bluez/3.9/bluez-utils-3.9'
> make: *** [all] Error 2
> 
> I have checked the expat library is present. 
> The version is libexpat.so.0.5.0
> Do you know why is it not able to link?

I have no idea. It works perfectly fine for me. However you can use
--disable-expat to compile it without XML support. In this case the
D-Bus methods that take XML as input will be disabled.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
