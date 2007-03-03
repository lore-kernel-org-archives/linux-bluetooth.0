Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <00b401c75a7c$6f0a77b0$c301a8c0@Bahubali>
References: <00b401c75a7c$6f0a77b0$c301a8c0@Bahubali>
Date: Sat, 03 Mar 2007 12:36:36 +0100
Message-Id: <1172921796.24446.20.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] undefined reference to `XML_StopParser'
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

Hi Vikram,

> If I ru make && make istall from ..\BlueZ\utils\bluez-utils-3.9. 
> got following error.
> 
>  
> ./common/libhelper.a(sdp-expat.o)(.text+0x227): In function
> `convert_xml_to_sdp_start':
> : undefined reference to `XML_StopParser'
> collect2: ld returned 1 exit status
> make[3]: *** [hcid] Error 1
> make[3]: Leaving directory `/root/vikram/bluez-utils-3.9/hcid'
> make[2]: *** [all] Error 2
> make[2]: Leaving directory `/root/vikram/bluez-utils-3.9/hcid'
> make[1]: *** [all-recursive] Error 1
> make[1]: Leaving directory `/root/vikram/bluez-utils-3.9'
> make: *** [all] Error 2
>  
> if I call configure with --enable-glib
>  
> I am getting following error
>  
> dbus-service.c:765: error: `GKeyFile' undeclared (first use in this
> function)
> dbus-service.c:765: error: (Each undeclared identifier is reported
> only once
> dbus-service.c:765: error: for each function it appears in.)
> dbus-service.c:765: error: `keyfile' undeclared (first use in this
> function)
> dbus-service.c:771: warning: implicit declaration of function
> `g_try_new0'
> dbus-service.c:771: error: syntax error before "struct"
> dbus-service.c:779: warning: implicit declaration of function
> `g_key_file_new'
> dbus-service.c:781: warning: implicit declaration of function
> `g_key_file_load_from_file'
> dbus-service.c:787: warning: implicit declaration of function
> `g_key_file_get_string'
> dbus-service.c:788: warning: assignment makes pointer from integer
> without a cast
> dbus-service.c:796: warning: assignment makes pointer from integer
> without a cast
> dbus-service.c:812: warning: assignment makes pointer from integer
> without a cast
> dbus-service.c:819: warning: implicit declaration of function
> `g_key_file_get_boolean'
> dbus-service.c:828: warning: implicit declaration of function
> `g_key_file_free'
> dbus-service.c: In function `create_external_service':
> dbus-service.c:948: error: syntax error before "struct"
> make[3]: *** [dbus-service.o] Error 1
> make[3]: Leaving directory `/root/vikram/bluez-utils-3.9/hcid'
> make[2]: *** [all] Error 2
> make[2]: Leaving directory `/root/vikram/bluez-utils-3.9/hcid'
> make[1]: *** [all-recursive] Error 1
> make[1]: Leaving directory `/root/vikram/bluez-utils-3.9'
> make: *** [all] Error 2

please show me your full configure call and its output.

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
