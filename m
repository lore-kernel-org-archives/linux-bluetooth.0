Return-Path: <bluez-users-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Fri, 23 Feb 2007 10:07:04 +0100
Message-ID: <7FEBB30F0CE41B419B38295024A58EE3A10D48@oxygen.mail.telnet.tunis>
From: "Asma Tebessi" <asma.tebessi@telnet.com.tn>
To: "Asma Tebessi" <asma.tebessi@telnet.com.tn>
Cc: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] RE :  RE : modprobe snd-bt-sco
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0175166785=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============0175166785==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7572A.0B9F7FD6"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7572A.0B9F7FD6
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all,=20

I still have the same problem, I cannot modprobe snd-bt-sco. Here what =
I've got when compiling the btsco-0.5 :


[root@ws12 btsco-0.5]# cd kernel/

[root@ws12 kernel]# make
make[1]: Entering directory `/usr/src/linux-2.6.12-12mdk'
  Building modules, stage 2.
  MODPOST
*** Warning: "snd_hidden_kmalloc" =
[/root/confhandsfree/btsco-0.5/kernel/snd-bt-sco.ko] undefined!
*** Warning: "snd_verbose_printk" =
[/root/confhandsfree/btsco-0.5/kernel/snd-bt-sco.ko] undefined!
*** Warning: "snd_hidden_kfree" =
[/root/confhandsfree/btsco-0.5/kernel/snd-bt-sco.ko] undefined!
make[1]: Leaving directory `/usr/src/linux-2.6.12-12mdk'

[root@ws12 kernel]# make install
make[1]: Entering directory `/usr/src/linux-2.6.12-12mdk'
  INSTALL /root/confhandsfree/btsco-0.5/kernel/snd-bt-sco.ko
make[1]: Leaving directory `/usr/src/linux-2.6.12-12mdk'

[root@ws12 kernel]# depmod -eav | grep snd-bt-sco
/lib/modules/2.6.12-12mdk/extra/snd-bt-sco.ko needs "snd_ctl_add": =
/lib/modules/2.6.12-12mdk/kernel/sound/core/snd.ko.gz
/lib/modules/2.6.12-12mdk/extra/snd-bt-sco.ko needs "snd_pcm_new": =
/lib/modules/2.6.12-12mdk/kernel/sound/core/snd-pcm.ko.gz
/lib/modules/2.6.12-12mdk/extra/snd-bt-sco.ko needs "snd_card_register": =
/lib/modules/2.6.12-12mdk/kernel/sound/core/snd.ko.g
z
/lib/modules/2.6.12-12mdk/extra/snd-bt-sco.ko needs "snd_card_free": =
/lib/modules/2.6.12-12mdk/kernel/sound/core/snd.ko.gz
/lib/modules/2.6.12-12mdk/extra/snd-bt-sco.ko needs "snd_ctl_new1": =
/lib/modules/2.6.12-12mdk/kernel/sound/core/snd.ko.gz
/lib/modules/2.6.12-12mdk/extra/snd-bt-sco.ko needs "snd_card_new": =
/lib/modules/2.6.12-12mdk/kernel/sound/core/snd.ko.gz
/lib/modules/2.6.12-12mdk/extra/snd-bt-sco.ko needs "snd_pcm_lib_ioctl": =
/lib/modules/2.6.12-12mdk/kernel/sound/core/snd-pcm.
ko.gz
/lib/modules/2.6.12-12mdk/extra/snd-bt-sco.ko needs "snd_hwdep_new": =
/lib/modules/2.6.12-12mdk/kernel/sound/core/snd-hwdep.ko
.gz
/lib/modules/2.6.12-12mdk/extra/snd-bt-sco.ko needs "snd_ctl_notify": =
/lib/modules/2.6.12-12mdk/kernel/sound/core/snd.ko.gz
/lib/modules/2.6.12-12mdk/extra/snd-bt-sco.ko needs "snd_malloc_pages": =
/lib/modules/2.6.12-12mdk/kernel/sound/core/snd-page-
alloc.ko.gz
/lib/modules/2.6.12-12mdk/extra/snd-bt-sco.ko needs "snd_pcm_set_ops": =
/lib/modules/2.6.12-12mdk/kernel/sound/core/snd-pcm.ko
.gz
/lib/modules/2.6.12-12mdk/extra/snd-bt-sco.ko needs =
"snd_pcm_period_elapsed": =
/lib/modules/2.6.12-12mdk/kernel/sound/core/snd
-pcm.ko.gz
/lib/modules/2.6.12-12mdk/extra/snd-bt-sco.ko needs "snd_free_pages": =
/lib/modules/2.6.12-12mdk/kernel/sound/core/snd-page-al
loc.ko.gz
/lib/modules/2.6.12-12mdk/extra/snd-bt-sco.ko needs =
"snd_pcm_format_width": =
/lib/modules/2.6.12-12mdk/kernel/sound/core/snd-p
cm.ko.gz

[root@ws12 kernel]# modprobe snd-bt-sco
FATAL: Error inserting snd-bt-sco =
(/lib/modules/2.6.12-12mdk/extra/snd-bt-sco.ko): Invalid module format

Even when I make make modules under /usr/src/linux/ I got no error :

[root@ws12 linux]# make modules
  CHK     include/linux/version.h
make[1]: =AB arch/i386/kernel/asm-offsets.s =BB est =E0 jour.
  CHK     include/asm-i386/asm_offsets.h
  Building modules, stage 2.
  MODPOST

Can anyone help me to got the btsco working?? :(=20

Thanks a lot.

------_=_NextPart_001_01C7572A.0B9F7FD6
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7226.0">
<TITLE>RE : [Bluez-users] RE : modprobe snd-bt-sco</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hi all,<BR>
<BR>
I still have the same problem, I cannot modprobe snd-bt-sco. Here what =
I've got when compiling the btsco-0.5 :<BR>
<BR>
<BR>
[root@ws12 btsco-0.5]# cd kernel/<BR>
<BR>
[root@ws12 kernel]# make<BR>
make[1]: Entering directory `/usr/src/linux-2.6.12-12mdk'<BR>
&nbsp; Building modules, stage 2.<BR>
&nbsp; MODPOST<BR>
*** Warning: &quot;snd_hidden_kmalloc&quot; =
[/root/confhandsfree/btsco-0.5/kernel/snd-bt-sco.ko] undefined!<BR>
*** Warning: &quot;snd_verbose_printk&quot; =
[/root/confhandsfree/btsco-0.5/kernel/snd-bt-sco.ko] undefined!<BR>
*** Warning: &quot;snd_hidden_kfree&quot; =
[/root/confhandsfree/btsco-0.5/kernel/snd-bt-sco.ko] undefined!<BR>
make[1]: Leaving directory `/usr/src/linux-2.6.12-12mdk'<BR>
<BR>
[root@ws12 kernel]# make install<BR>
make[1]: Entering directory `/usr/src/linux-2.6.12-12mdk'<BR>
&nbsp; INSTALL /root/confhandsfree/btsco-0.5/kernel/snd-bt-sco.ko<BR>
make[1]: Leaving directory `/usr/src/linux-2.6.12-12mdk'<BR>
<BR>
[root@ws12 kernel]# depmod -eav | grep snd-bt-sco<BR>
/lib/modules/2.6.12-12mdk/extra/snd-bt-sco.ko needs =
&quot;snd_ctl_add&quot;: =
/lib/modules/2.6.12-12mdk/kernel/sound/core/snd.ko.gz<BR>
/lib/modules/2.6.12-12mdk/extra/snd-bt-sco.ko needs =
&quot;snd_pcm_new&quot;: =
/lib/modules/2.6.12-12mdk/kernel/sound/core/snd-pcm.ko.gz<BR>
/lib/modules/2.6.12-12mdk/extra/snd-bt-sco.ko needs =
&quot;snd_card_register&quot;: =
/lib/modules/2.6.12-12mdk/kernel/sound/core/snd.ko.g<BR>
z<BR>
/lib/modules/2.6.12-12mdk/extra/snd-bt-sco.ko needs =
&quot;snd_card_free&quot;: =
/lib/modules/2.6.12-12mdk/kernel/sound/core/snd.ko.gz<BR>
/lib/modules/2.6.12-12mdk/extra/snd-bt-sco.ko needs =
&quot;snd_ctl_new1&quot;: =
/lib/modules/2.6.12-12mdk/kernel/sound/core/snd.ko.gz<BR>
/lib/modules/2.6.12-12mdk/extra/snd-bt-sco.ko needs =
&quot;snd_card_new&quot;: =
/lib/modules/2.6.12-12mdk/kernel/sound/core/snd.ko.gz<BR>
/lib/modules/2.6.12-12mdk/extra/snd-bt-sco.ko needs =
&quot;snd_pcm_lib_ioctl&quot;: =
/lib/modules/2.6.12-12mdk/kernel/sound/core/snd-pcm.<BR>
ko.gz<BR>
/lib/modules/2.6.12-12mdk/extra/snd-bt-sco.ko needs =
&quot;snd_hwdep_new&quot;: =
/lib/modules/2.6.12-12mdk/kernel/sound/core/snd-hwdep.ko<BR>
.gz<BR>
/lib/modules/2.6.12-12mdk/extra/snd-bt-sco.ko needs =
&quot;snd_ctl_notify&quot;: =
/lib/modules/2.6.12-12mdk/kernel/sound/core/snd.ko.gz<BR>
/lib/modules/2.6.12-12mdk/extra/snd-bt-sco.ko needs =
&quot;snd_malloc_pages&quot;: =
/lib/modules/2.6.12-12mdk/kernel/sound/core/snd-page-<BR>
alloc.ko.gz<BR>
/lib/modules/2.6.12-12mdk/extra/snd-bt-sco.ko needs =
&quot;snd_pcm_set_ops&quot;: =
/lib/modules/2.6.12-12mdk/kernel/sound/core/snd-pcm.ko<BR>
.gz<BR>
/lib/modules/2.6.12-12mdk/extra/snd-bt-sco.ko needs =
&quot;snd_pcm_period_elapsed&quot;: =
/lib/modules/2.6.12-12mdk/kernel/sound/core/snd<BR>
-pcm.ko.gz<BR>
/lib/modules/2.6.12-12mdk/extra/snd-bt-sco.ko needs =
&quot;snd_free_pages&quot;: =
/lib/modules/2.6.12-12mdk/kernel/sound/core/snd-page-al<BR>
loc.ko.gz<BR>
/lib/modules/2.6.12-12mdk/extra/snd-bt-sco.ko needs =
&quot;snd_pcm_format_width&quot;: =
/lib/modules/2.6.12-12mdk/kernel/sound/core/snd-p<BR>
cm.ko.gz<BR>
<BR>
[root@ws12 kernel]# modprobe snd-bt-sco<BR>
FATAL: Error inserting snd-bt-sco =
(/lib/modules/2.6.12-12mdk/extra/snd-bt-sco.ko): Invalid module =
format<BR>
<BR>
Even when I make make modules under /usr/src/linux/ I got no error :<BR>
<BR>
[root@ws12 linux]# make modules<BR>
&nbsp; CHK&nbsp;&nbsp;&nbsp;&nbsp; include/linux/version.h<BR>
make[1]: =AB arch/i386/kernel/asm-offsets.s =BB est =E0 jour.<BR>
&nbsp; CHK&nbsp;&nbsp;&nbsp;&nbsp; include/asm-i386/asm_offsets.h<BR>
&nbsp; Building modules, stage 2.<BR>
&nbsp; MODPOST<BR>
<BR>
Can anyone help me to got the btsco working?? :(<BR>
<BR>
Thanks a lot.<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C7572A.0B9F7FD6--


--===============0175166785==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0175166785==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0175166785==--
