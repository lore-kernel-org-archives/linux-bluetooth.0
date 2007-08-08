Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <b5c34db00708080157i4840627al1ac38b8ed3840631@mail.gmail.com>
Date: Wed, 8 Aug 2007 14:27:20 +0530
From: "umamahesh yelchuru venkata" <umeshyv@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1186561071.20129.85.camel@violet>
MIME-Version: 1.0
References: <b5c34db00708072235j3954de14icb69e75bde3d7b72@mail.gmail.com>
	<1186561071.20129.85.camel@violet>
Subject: Re: [Bluez-users] bluez-utils and bluez-libs
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0341954123=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0341954123==
Content-Type: multipart/alternative;
	boundary="----=_Part_59102_27735414.1186563440375"

------=_Part_59102_27735414.1186563440375
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,
Thanks for your reply.Can you guide how to proceed, i use linux-2.6.11 for
MIPS architecture(Au1200 processor) shall i use some other version will it
help and can you verify whether my configuration and compilation is
correct.waiting for your kind reply.

Regards
Umesh

On 8/8/07, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi,
>
> >    I am working on Au1200 processor and i use linux-2.6.11 and now i
> > am trying USB Bluetooth in it .I need to compile bluetooth libraries
> > and bluetooth utils for it.I downloaded the following files,
> > bluez-libs-3.13.tar.gz
> >
> > bluez-utils-3.13.tar.gz
> >
> > I compile the library as follows,
> > ./configure --host=mipsel --prefix=/usr --enable-shared=no
> > --enable-static=yes
> > make
> > make install DESTDIR=$PWD/bluez1
> >
> > it compiled and next to compile bluez-utils
> >
> > ./configure \
> > --host=mipsel \
> > --with-bluez=$PWD/../bluez-libs-2.25/install/usr \
> > CPPFLAGS="-DLINUX" \
> > LDFLAGS="-Wl,-elf2flt"
> >
> > then make
> >
> > following are the errors ,
> >
> > make[3]: Entering directory
> > `/home/busybox/bluez/bluez-utils-3.13/hcid'
> > gcc -DHAVE_CONFIG_H -I. -I.. -I../common -I../sdpd -DLINUX
> > -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include
> > -DDBUS_API_SUBJECT_TO_CHANGE -I../eglib -Wall -O2 -D_FORTIFY_SOURCE=2
> > -MT device.o -MD -MP -MF .deps/device.Tpo -c -o device.o device.c
> > device.c: In function 'start_device':
> > device.c:271: error: 'LMP_PAUSE_ENC' undeclared (first use in this
> > function)
> > device.c:271: error: (Each undeclared identifier is reported only once
> > device.c:271: error: for each function it appears in.)
> > device.c:277: error: 'LMP_NFLUSH_PKTS' undeclared (first use in this
> > function)
> > device.c:280: error: 'LMP_LSTO' undeclared (first use in this
> > function)
> > make[3]: *** [device.o] Error 1
> > make[3]: Leaving directory `/home/busybox/bluez/bluez-utils-3.13/hcid'
> > make[2]: *** [all] Error 2
> > make[2]: Leaving directory `/home/busybox/bluez/bluez-utils-3.13/hcid'
> > make[1]: *** [all-recursive] Error 1
> > make[1]: Leaving directory `/home/busybox/bluez/bluez-utils-3.13'
> > make: *** [all] Error 2
> >
> > could anyone tell me where am going wrong.
>
> your includes are screwed up. You need to make sure it uses the headers
> of bluez-utils-3.13 and not some older ones installed one your system.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems?  Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now >>  http://get.splunk.com/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_59102_27735414.1186563440375
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,<br>Thanks for your reply.Can you guide how to proceed, i use linux-2.6.11 for MIPS architecture(Au1200 processor) shall i use some other version will it help and can you verify whether my configuration and compilation is 
correct.waiting for your kind reply.<br><br>Regards<br>Umesh<br><br><div><span class="gmail_quote">On 8/8/07, <b class="gmail_sendername">Marcel Holtmann</b> &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>
&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi,<br><br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;I am working on Au1200 processor and i use linux-2.6.11
 and now i<br>&gt; am trying USB Bluetooth in it .I need to compile bluetooth libraries<br>&gt; and bluetooth utils for it.I downloaded the following files,<br>&gt; bluez-libs-3.13.tar.gz<br>&gt;<br>&gt; bluez-utils-3.13.tar.gz
<br>&gt;<br>&gt; I compile the library as follows,<br>&gt; ./configure --host=mipsel --prefix=/usr --enable-shared=no<br>&gt; --enable-static=yes<br>&gt; make<br>&gt; make install DESTDIR=$PWD/bluez1<br>&gt;<br>&gt; it compiled and next to compile bluez-utils
<br>&gt;<br>&gt; ./configure \<br>&gt; --host=mipsel \<br>&gt; --with-bluez=$PWD/../bluez-libs-2.25/install/usr \<br>&gt; CPPFLAGS=&quot;-DLINUX&quot; \<br>&gt; LDFLAGS=&quot;-Wl,-elf2flt&quot;<br>&gt;<br>&gt; then make<br>
&gt;<br>&gt; following are the errors ,<br>&gt;<br>&gt; make[3]: Entering directory<br>&gt; `/home/busybox/bluez/bluez-utils-3.13/hcid&#39;<br>&gt; gcc -DHAVE_CONFIG_H -I. -I.. -I../common -I../sdpd -DLINUX<br>&gt; -I/usr/include/dbus-
1.0 -I/usr/lib/dbus-1.0/include<br>&gt; -DDBUS_API_SUBJECT_TO_CHANGE -I../eglib -Wall -O2 -D_FORTIFY_SOURCE=2<br>&gt; -MT device.o -MD -MP -MF .deps/device.Tpo -c -o device.o device.c<br>&gt; device.c: In function &#39;start_device&#39;:
<br>&gt; device.c:271: error: &#39;LMP_PAUSE_ENC&#39; undeclared (first use in this<br>&gt; function)<br>&gt; device.c:271: error: (Each undeclared identifier is reported only once<br>&gt; device.c:271: error: for each function it appears in.)
<br>&gt; device.c:277: error: &#39;LMP_NFLUSH_PKTS&#39; undeclared (first use in this<br>&gt; function)<br>&gt; device.c:280: error: &#39;LMP_LSTO&#39; undeclared (first use in this<br>&gt; function)<br>&gt; make[3]: *** [
device.o] Error 1<br>&gt; make[3]: Leaving directory `/home/busybox/bluez/bluez-utils-3.13/hcid&#39;<br>&gt; make[2]: *** [all] Error 2<br>&gt; make[2]: Leaving directory `/home/busybox/bluez/bluez-utils-3.13/hcid&#39;<br>
&gt; make[1]: *** [all-recursive] Error 1<br>&gt; make[1]: Leaving directory `/home/busybox/bluez/bluez-utils-3.13&#39;<br>&gt; make: *** [all] Error 2<br>&gt;<br>&gt; could anyone tell me where am going wrong.<br><br>your includes are screwed up. You need to make sure it uses the headers
<br>of bluez-utils-3.13 and not some older ones installed one your system.<br><br>Regards<br><br>Marcel<br><br><br><br>-------------------------------------------------------------------------<br>This SF.net email is sponsored by: Splunk Inc.
<br>Still grepping through log files to find problems?&nbsp;&nbsp;Stop.<br>Now Search log events and configuration files using AJAX and a browser.<br>Download your FREE copy of Splunk now &gt;&gt;&nbsp;&nbsp;<a href="http://get.splunk.com/">
http://get.splunk.com/</a><br>_______________________________________________<br>Bluez-users mailing list<br><a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">
https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br></blockquote></div><br>

------=_Part_59102_27735414.1186563440375--


--===============0341954123==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============0341954123==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0341954123==--
