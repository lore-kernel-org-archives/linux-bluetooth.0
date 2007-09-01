Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <db972f430709010100m3ac8eea6v12836b4697955133@mail.gmail.com>
Date: Sat, 1 Sep 2007 16:00:52 +0800
From: "Ricky Soh" <rickysoh@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: Re: [Bluez-users] newbie questions on Bluez installation
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0869044588=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0869044588==
Content-Type: multipart/alternative;
	boundary="----=_Part_12363_16640934.1188633652044"

------=_Part_12363_16640934.1188633652044
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I have downloaded and compiled bluez-lib-3.16 using

./configure
make
make install.

Everything went smoothly for the installation.

I did the same for bluez-util-3.16.

The error is at the "make"

How do i make sure i am compiling against the latest lib?

Sorry for asking such a newbie question. Would appreciate your help. Thanks.

Sincerely
Ricky

>Message: 3
>Date: Fri, 31 Aug 2007 16:06:38 +0200
>From: Marcel Holtmann <marcel@holtmann.org>
>Subject: Re: [Bluez-users] newbie questions on Bluez installation
>To: BlueZ users <bluez-users@lists.sourceforge.net>
>Message-ID: <1188569198.13373.92.camel>@violet>
>Content-Type: text/plain

>Hi Ricky,

> I have just downloaded bluez-lib and bluez-utils-3.16 and ported to
> FC6 linux 2.6.18-1.2798.
>
> After i did the ./configure, i did the usual "make" for both. This is
> the error for blue-utils-3.16 :
>
> Entering the directory '/root/bluez-utils-3.16/hci'
> /bin/sh ../libtool --tag=CC   --mode=link gcc -I/usr/include/dbus-1.0
> -I/usr/lib/dbus-1.0/include   -DDBUS_API_SUBJECT_TO_CHANGE -I../eglib
> -Wall -O2 -D_FORTIFY_SOURCE=2   -o hcid main.o
> libhciserver.a ../sdpd/libsdpserver.a ../common/libhelper.a
../eglib/libeglib.la -L/lib -ldbus-1   -lbluetooth   -lexpat
> gcc -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include
> -DDBUS_API_SUBJECT_TO_CHANGE -I../eglib -Wall -O2 -D_FORTIFY_SOURCE=2
> -o hcid main.o
> libhciserver.a ../sdpd/libsdpserver.a ../common/libhelper.a
../eglib/.libs/libeglib.a -L/lib -ldbus-1 /usr/lib/libbluetooth.so
/usr/lib/libexpat.so
> libhciserver.a(device.o): In function `start_adapter':
> device.c:(.text+0x10c1): undefined reference to
> `hci_read_simple_pairing_mode'
> libhciserver.a(dbus-common.o): In function `unregister_sdp_record':
> dbus-common.c:(.text+0x90): undefined reference to
> `sdp_device_record_unregister_binary'

>you are not compiling against the latest bluez-libs.

>Regards

>Marcel

------=_Part_12363_16640934.1188633652044
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>I have downloaded and compiled bluez-lib-3.16 using<br><br>./configure<br>make<br>make install.<br><br>Everything went smoothly for the installation.<br><br>I did the same for bluez-util-3.16.<br><br>The error is at the &quot;make&quot;
<br><br>How do i make sure i am compiling against the latest lib?<br><br>Sorry for asking such a newbie question. Would appreciate your help. Thanks.<br><br>Sincerely<br>Ricky<br><br>&gt;Message: 3<br>&gt;Date: Fri, 31 Aug 2007 16:06:38 +0200
<br>&gt;From: Marcel Holtmann &lt;<a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt;<br>&gt;Subject: Re: [Bluez-users] newbie questions on Bluez installation
<br>&gt;To: BlueZ users &lt;<a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:bluez-users@lists.sourceforge.net">bluez-users@lists.sourceforge.net</a>&gt;<br>&gt;Message-ID: &lt;1188569198.13373.92.camel
<div style="direction: ltr;">&gt;@violet&gt;<br>&gt;Content-Type: text/plain<br><br>&gt;Hi Ricky,<br><br>&gt; I have just downloaded bluez-lib and bluez-utils-3.16 and ported to<br>&gt; FC6 linux 2.6.18-1.2798.<br>&gt;<br>
&gt; After i did the ./configure, i did the usual &quot;make&quot; for both. This is<br>&gt; the error for blue-utils-3.16 :<br>&gt;<br>&gt; Entering the directory &#39;/root/bluez-utils-3.16/hci&#39;<br>&gt; /bin/sh ../libtool --tag=CC &nbsp; --mode=link gcc -I/usr/include/dbus-
1.0<br>&gt; -I/usr/lib/dbus-1.0/include &nbsp; -DDBUS_API_SUBJECT_TO_CHANGE -I../eglib<br>&gt; -Wall -O2 -D_FORTIFY_SOURCE=2 &nbsp; -o hcid main.o<br>&gt; libhciserver.a ../sdpd/libsdpserver.a ../common/libhelper.a ../eglib/libeglib.la -L/lib -ldbus-1 &nbsp; -lbluetooth &nbsp; -lexpat
<br>&gt; gcc -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include<br>&gt; -DDBUS_API_SUBJECT_TO_CHANGE -I../eglib -Wall -O2 -D_FORTIFY_SOURCE=2<br>&gt; -o hcid main.o<br>&gt;
libhciserver.a ../sdpd/libsdpserver.a ../common/libhelper.a
../eglib/.libs/libeglib.a -L/lib -ldbus-1 /usr/lib/libbluetooth.so
/usr/lib/libexpat.so<br>&gt; libhciserver.a(device.o): In function `start_adapter&#39;:<br>&gt; device.c:(.text+0x10c1): undefined reference to<br>&gt; `hci_read_simple_pairing_mode&#39;<br>&gt; libhciserver.a(dbus-common.o
): In function `unregister_sdp_record&#39;:<br>&gt; dbus-common.c:(.text+0x90): undefined reference to<br>&gt; `sdp_device_record_unregister_binary&#39;<br><br>&gt;you are not compiling against the latest bluez-libs.<br><br>
&gt;Regards<br><br>&gt;Marcel</div>

------=_Part_12363_16640934.1188633652044--


--===============0869044588==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============0869044588==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0869044588==--
