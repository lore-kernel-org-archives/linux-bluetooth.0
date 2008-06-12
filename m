Return-Path: <cyrus@holtmann.org>
Message-ID: <95bb57cb0806120201i63c7c753m4d72c9ed9138ee8e@mail.gmail.com>
Date: Thu, 12 Jun 2008 11:01:28 +0200
From: "nico bats" <sl1200mk2@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1213190155.17870.28.camel@violet.holtmann.net>
MIME-Version: 1.0
References: <95bb57cb0806110251xe9cc530v80224cfd836aef05@mail.gmail.com>
	<1213190155.17870.28.camel@violet.holtmann.net>
Subject: Re: [Bluez-users] compile on apple
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1096128933=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1096128933==
Content-Type: multipart/alternative;
	boundary="----=_Part_40678_1318446.1213261288889"

------=_Part_40678_1318446.1213261288889
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi,
following this page(
http://wiki.openmoko.org/wiki/User:SNMoore#Patch_to_work_around_byteswap.h_and_endian.h_errors_on_OS_X),
byteswap macro can be re-written and use  <machine/endian.h> as header

maybe it worth the try
++

On Wed, Jun 11, 2008 at 3:15 PM, Marcel Holtmann <marcel@holtmann.org>
wrote:

> Hi Nico,
>
> > i've tried to compile Bluez on macbookpro and came across error:
> >
> > /bin/sh ../libtool --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I.
> > -I.. -I../include    -Wall -O2 -D_FORTIFY_SOURCE=2 -MT bluetooth.lo
> > -MD -MP -MF .deps/bluetooth.Tpo -c -o bluetooth.lo bluetooth.c
> > mkdir .libs
> >  gcc -DHAVE_CONFIG_H -I. -I.. -I../include -Wall -O2
> > -D_FORTIFY_SOURCE=2 -MT bluetooth.lo -MD -MP -MF .deps/bluetooth.Tpo
> > -c bluetooth.c  -fno-common -DPIC -o .libs/bluetooth.o
> > bluetooth.c:35:20: error: malloc.h: No such file or directory
> > In file included from bluetooth.c:39:
> > ../include/bluetooth/bluetooth.h:36:20: error: endian.h: No such file
> > or directory
> > ../include/bluetooth/bluetooth.h:37:22: error: byteswap.h: No such
> > file or directory
> >
> > does macros included in endian.h & byteswap.h can be coded in a
> > portable way ?
>
> I can fix the malloc.h include, because that is not needed, but for the
> others, I have no idea. Maybe or maybe not.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> Check out the new SourceForge.net Marketplace.
> It's the best place to buy or sell services for
> just about anything Open Source.
> http://sourceforge.net/services/buy/index.php
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_40678_1318446.1213261288889
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi,<br>following this page(<a href="http://wiki.openmoko.org/wiki/User:SNMoore#Patch_to_work_around_byteswap.h_and_endian.h_errors_on_OS_X">http://wiki.openmoko.org/wiki/User:SNMoore#Patch_to_work_around_byteswap.h_and_endian.h_errors_on_OS_X</a>), byteswap macro can be re-written and use&nbsp; &lt;machine/endian.h&gt; as header<br>
<br>maybe it worth the try<br>++ <br><br><div class="gmail_quote">On Wed, Jun 11, 2008 at 3:15 PM, Marcel Holtmann &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Nico,<br>
<div><div></div><div class="Wj3C7c"><br>
&gt; i&#39;ve tried to compile Bluez on macbookpro and came across error:<br>
&gt;<br>
&gt; /bin/sh ../libtool --tag=CC &nbsp; --mode=compile gcc -DHAVE_CONFIG_H -I.<br>
&gt; -I.. -I../include &nbsp; &nbsp;-Wall -O2 -D_FORTIFY_SOURCE=2 -MT bluetooth.lo<br>
&gt; -MD -MP -MF .deps/bluetooth.Tpo -c -o bluetooth.lo bluetooth.c<br>
&gt; mkdir .libs<br>
&gt; &nbsp;gcc -DHAVE_CONFIG_H -I. -I.. -I../include -Wall -O2<br>
&gt; -D_FORTIFY_SOURCE=2 -MT bluetooth.lo -MD -MP -MF .deps/bluetooth.Tpo<br>
&gt; -c bluetooth.c &nbsp;-fno-common -DPIC -o .libs/bluetooth.o<br>
&gt; bluetooth.c:35:20: error: malloc.h: No such file or directory<br>
&gt; In file included from bluetooth.c:39:<br>
&gt; ../include/bluetooth/bluetooth.h:36:20: error: endian.h: No such file<br>
&gt; or directory<br>
&gt; ../include/bluetooth/bluetooth.h:37:22: error: byteswap.h: No such<br>
&gt; file or directory<br>
&gt;<br>
&gt; does macros included in endian.h &amp; byteswap.h can be coded in a<br>
&gt; portable way ?<br>
<br>
</div></div>I can fix the malloc.h include, because that is not needed, but for the<br>
others, I have no idea. Maybe or maybe not.<br>
<br>
Regards<br>
<br>
Marcel<br>
<br>
<br>
<br>
-------------------------------------------------------------------------<br>
Check out the new SourceForge.net Marketplace.<br>
It&#39;s the best place to buy or sell services for<br>
just about anything Open Source.<br>
<a href="http://sourceforge.net/services/buy/index.php" target="_blank">http://sourceforge.net/services/buy/index.php</a><br>
_______________________________________________<br>
Bluez-users mailing list<br>
<a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br>
<a href="https://lists.sourceforge.net/lists/listinfo/bluez-users" target="_blank">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br>
</blockquote></div><br>

------=_Part_40678_1318446.1213261288889--


--===============1096128933==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
--===============1096128933==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1096128933==--
