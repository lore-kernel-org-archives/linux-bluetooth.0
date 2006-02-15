Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <d6db2b820602150319o1a15fea8ib7d00796d0b9d814@mail.gmail.com>
From: michael grosman <michaelg100@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] hciconfig doesn't come up
In-Reply-To: <1139993269.26072.25.camel@localhost>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_8546_14673737.1140002357649"
References: <d6db2b820602131319u1658f2fn40823df3c623c500@mail.gmail.com>
	 <1139993269.26072.25.camel@localhost>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 15 Feb 2006 13:19:17 +0200

------=_Part_8546_14673737.1140002357649
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 2/15/06, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Michael,


Hi Marcel,

> We would like to setup BT communication on embedded MIPS-processor
> > Broadcom card with Linux 2.4.20 (patched by patch no.18 of M.Holtman).
> > Kernel contained USB support, HID support and BlueTooth support (on
> > all layers).
> > On this card we're using USB-PCI host-controller of Philips
> > (ISP1562ES1).
> > We are using Bluez-2.24 library and utils. We also use the library for
> > userspace-kernelspace USB translation (libusb-0.1.so.4.4.3).
>
> the 2.4 kernel series are no longer supported and actually the USB part
> of these kernels might be buggy, too.


This kernel "slightly" patched by Broadcom (for example, USB 2.0 support
downgraded from 2.4.26, etc.), so it is not "really" 2.4.20, but you're
right, it's still might be buggy...

> We are using CSR based BT dongle with the following description:
> > >T:  Bus=3D02 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D01 Dev#=3D  5 Spd=3D12=
  MxCh=3D 0>
> > >D:  Ver=3D 1.10 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D =
 1
> > >P:  Vendor=3D0a12 ProdID=3D0001 Rev=3D 11.20
> > (as we saw in the supported products list, it is supported.)
>
> It is fully supported. What build id is this? I know that the Rev equals
> the build id, but I always forget how to convert it.


I gues that you are you refering to the build ID of the BT dongle firmware.
Is there a way to "pull" it from the device?


> ># ps -aux
> > >  PID  Uid     Stat Command
> > >    1 0         S    init noinitrd
> > >    2 0         S    [keventd]
> > >    3 0         S    [ksoftirqd_CPU0]
> > >    4 0         S    [kswapd]
> > >    5 0         S    [bdflush]
> > >    6 0         S    [kupdated]
> > >    7 0         S    [mtdblockd]
> > >   15 0         S    /usr/sbin/dnsmasq
> > >   24 0         S    /usr/sbin/diag
> > >   25 0         S    /bin/sh
> > >   35 0         S    [khubd]
> > >   63 0         S    [krfcommd]
> > >   77 0         S    hcid: processing events
> > >   80 0         S    sdpd
> > >  104 0         S    hcid: processing events
> > >  108 0         S    hcid: hci0 init
> > >  111 0         S    /usr/sbin/hidd --server
> > >  124 0         R    ps -aux
>
> Make sure only one hcid is running at a time.


We checked with single hcid and there is no difference in the behaviour.

> The problem is that hciconfig doesn't come up:
> > ># hciconfig
> > >hci0:   Type: USB
> > >        BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0
> > >        DOWN
> > >        RX bytes:20 acl:0 sco:0 events:2 errors:0
> > >        TX bytes:9 acl:0 sco:0 commands:3 errors:0
> >
> > When we're trying to wake it up, it failed on timeout:
> > ># hciconfig hci0 up
> > >Can't init device hci0: Connection timed out (145)
> > We received the same timeout reply for version, revision and commands
> > requests.
> > We received the following reply for features request (# hciconfig hci0
> > features)
> > hci0:   Type: USB
> >         BD Address: 00:00:00:00:00:00 ACL MTU: 192:8 SCO MTU: 64:8
> >         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
> >                 <3-slot packets> <5-slot packets> <encryption> <slot
> > offset>
> >                 <timing accuracy> <role switch> <hold mode> <sniff
> > mode>
> >                 <park state> <RSSI> <channel quality> <SCO link> <HV2
> > packets>
> >                 <HV3 packets> <u-law log> <A-law log> <CVSD> <paging
> > scheme>
> >                 <power control> <transparent SCO>
> >
> > When we're trying to do the same actions on PC with Linux 2.6.12
> > (using the same USB-PCI card and BT dongle), the only difference that
> > after "hciconfig up" it returns the BD address and UP state. Following
> > that all hcitool, sdptool, l2ping etc. services worked ok and we could
> > establish BT communication.
>
> Why don't try to use a decent 2.6 kernel for embedded board? This will
> make all things a lot easier.


Unfortunately, the embedded board supports only 2.4.20 kernel with all its
problematic issues.

> One additional issue. We see in the product list that our dongle is in
> > HCI mode, so we don't have to use hid2hci utility, but for some
> > strange reason it doesn't work in any direction (on both Brodacom and
> > PC).
> > We found that in the list, declared in the file hid2hci.c , this pair
> > "vendor-productID" is defined as HID... It's strange.
>
> You need to have a dongle that actually supports HID proxy. Otherwise
> this tool doesn't do anything.


We deduct from 2.6 that our dongle supports HCI. Tx,

> We see in sources that the socket to AF_BLUETOOTH with BT_PROTOHCI is
> > opened successfully and even some of ioctl's succeeded, but HCIDEVUP
> > did not...
> >
> > May someone hint us, what we did wrong.
> > Should we change something in the "default" hcid.conf (class device or
> > something else)?
> > Or should we make something additional configurations?
> > We don't find nothing extra in the manuals and HOWTOs...
> > How could we fix this HCI connection and move forward in establishing
> > BT communication on the described setup?
>
> Move to a 2.6 kernel, because I think this is a bug inside the USB
> subsystem. However if you don't need SCO support, you might wanna
> disable the ISOC transfers (SCO support) of the hci_usb driver.


Hm...  We indeed won't need any SCO support. HCO is not used although
curently part of the kernel.  How it might influence on our setup?


Regards
>
> Marcel


Thanks for your help, Michael.


-------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log
> files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D103432&bid=3D230486&dat=
=3D121642
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_8546_14673737.1140002357649
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br><br><div><span class=3D"gmail_quote">On 2/15/06, <b class=3D"gmail_send=
ername">Marcel Holtmann</b> &lt;<a href=3D"mailto:marcel@holtmann.org">marc=
el@holtmann.org</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" styl=
e=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; =
padding-left: 1ex;">
Hi Michael,</blockquote><div><br>
Hi Marcel, <br>
</div><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid=
 rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; We=
 would like to setup BT communication on embedded MIPS-processor<br>&gt; Br=
oadcom card with Linux=20
2.4.20 (patched by patch no.18 of M.Holtman).<br>&gt; Kernel contained USB =
support, HID support and BlueTooth support (on<br>&gt; all layers).<br>&gt;=
 On this card we're using USB-PCI host-controller of Philips<br>&gt; (ISP15=
62ES1).
<br>&gt; We are using Bluez-2.24 library and utils. We also use the library=
 for<br>&gt; userspace-kernelspace USB translation (libusb-0.1.so.4.4.3).<b=
r><br>the 2.4 kernel series are no longer supported and actually the USB pa=
rt
<br>of these kernels might be buggy, too.</blockquote><div><br>
This kernel &quot;slightly&quot; patched by Broadcom (for example, USB 2.0
support downgraded from 2.4.26, etc.), so it is not &quot;really&quot; 2.4.=
20,
but you're right, it's still might be buggy...<br>

<br>
</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb=
(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; We are=
 using CSR based BT dongle with the following description:<br>&gt; &gt;T:&n=
bsp;&nbsp;Bus=3D02 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D01 Dev#=3D&nbsp;&nbsp=
;5 Spd=3D12&nbsp;&nbsp;MxCh=3D 0&gt;
<br>&gt; &gt;D:&nbsp;&nbsp;Ver=3D 1.10 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 M=
xPS=3D64 #Cfgs=3D&nbsp;&nbsp;1<br>&gt; &gt;P:&nbsp;&nbsp;Vendor=3D0a12 Prod=
ID=3D0001 Rev=3D 11.20<br>&gt; (as we saw in the supported products list, i=
t is supported.)<br><br>It is fully supported. What build id is this? I kno=
w that the Rev equals
<br>the build id, but I always forget how to convert it.</blockquote><div><=
br>
I gues that you are you refering to the build ID of the BT dongle firmware.=
 Is there a way to &quot;pull&quot; it from the device?<br>

<br>
</div><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid=
 rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; &g=
t;# ps -aux<br>&gt; &gt;&nbsp;&nbsp;PID&nbsp;&nbsp;Uid&nbsp;&nbsp;&nbsp;&nb=
sp; Stat Command<br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;1 0&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp;&nbsp;init noinitrd
<br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;2 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp;&nbsp;[keventd]<br>&gt; &gt;&nbsp;&nbsp;&n=
bsp;&nbsp;3 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;=
&nbsp;&nbsp;[ksoftirqd_CPU0]<br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;4 0&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp;&nbsp;[kswapd]=
<br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;5 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp;&nbsp;[bdflush]<br>&gt; &gt;&nbsp;&nbsp;&n=
bsp;&nbsp;6 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;=
&nbsp;&nbsp;[kupdated]
<br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;7 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp;&nbsp;[mtdblockd]<br>&gt; &gt;&nbsp;&nbsp;=
 15 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp;&n=
bsp;/usr/sbin/dnsmasq<br>&gt; &gt;&nbsp;&nbsp; 24 0&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp;&nbsp;/usr/sbin/diag<br>&gt; &g=
t;&nbsp;&nbsp; 25 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S&nbsp;=
&nbsp;&nbsp;&nbsp;/bin/sh<br>&gt; &gt;&nbsp;&nbsp; 35 0&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp;&nbsp;[khubd]
<br>&gt; &gt;&nbsp;&nbsp; 63 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; S&nbsp;&nbsp;&nbsp;&nbsp;[krfcommd]<br>&gt; &gt;&nbsp;&nbsp; 77 0&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp;&nbsp;hcid: p=
rocessing events<br>&gt; &gt;&nbsp;&nbsp; 80 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp;&nbsp;sdpd<br>&gt; &gt;&nbsp;&nbsp;1=
04 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp;&nb=
sp;hcid: processing events<br>&gt; &gt;&nbsp;&nbsp;108 0&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp;&nbsp;hcid: hci0 init
<br>&gt; &gt;&nbsp;&nbsp;111 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; S&nbsp;&nbsp;&nbsp;&nbsp;/usr/sbin/hidd --server<br>&gt; &gt;&nbsp;&nbs=
p;124 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; R&nbsp;&nbsp;&nbsp;=
&nbsp;ps -aux<br><br>Make sure only one hcid is running at a time.</blockqu=
ote><div><br>
We checked with single hcid and there is no difference in the behaviour. <b=
r>
<br>
</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb=
(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; The pr=
oblem is that hciconfig doesn't come up:<br>&gt; &gt;# hciconfig<br>&gt; &g=
t;hci0:&nbsp;&nbsp; Type: USB
<br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;BD Address: 00=
:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0<br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;DOWN<br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;RX bytes:20 acl:0 sco:0 events:2 errors:0<br>&gt; &gt;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;TX bytes:9 acl:0 sco:0 commands=
:3 errors:0
<br>&gt;<br>&gt; When we're trying to wake it up, it failed on timeout:<br>=
&gt; &gt;# hciconfig hci0 up<br>&gt; &gt;Can't init device hci0: Connection=
 timed out (145)<br>&gt; We received the same timeout reply for version, re=
vision and commands
<br>&gt; requests.<br>&gt; We received the following reply for features req=
uest (# hciconfig hci0<br>&gt; features)<br>&gt; hci0:&nbsp;&nbsp; Type: US=
B<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:00=
:00:00:00:00 ACL MTU: 192:8 SCO MTU: 64:8<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&lt;3-slot packets&gt; &lt;5-slot packets&gt; &lt;encryption&gt;
&lt;slot<br>&gt; offset&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&lt;timing accuracy&gt; &lt;role switch&gt; &lt;hold mode&gt; &lt;sniff<br>=
&gt; mode&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&lt;park state&gt; &lt;RSSI&gt; &lt;channel quality&gt; &lt;SCO
link&gt; &lt;HV2<br>&gt; packets&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&lt;HV3 packets&gt; &lt;u-law log&gt; &lt;A-law log&gt; &lt;CVSD&gt;
&lt;paging<br>&gt; scheme&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&lt;power control&gt; &lt;transparent SCO&gt;<br>&gt;<br>&gt; When we're tr=
ying to do the same actions on PC with Linux 2.6.12<br>&gt; (using the same=
 USB-PCI card and BT dongle), the only difference that<br>&gt; after &quot;=
hciconfig up&quot; it returns the BD address and UP state. Following
<br>&gt; that all hcitool, sdptool, l2ping etc. services worked ok and we c=
ould<br>&gt; establish BT communication.<br><br>Why don't try to use a dece=
nt 2.6 kernel for embedded board? This will<br>make all things a lot easier=
.
</blockquote><div><br>
Unfortunately, the embedded board supports only 2.4.20 kernel with all its =
problematic issues. &nbsp;
<br>
<br>
</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb=
(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; One ad=
ditional issue. We see in the product list that our dongle is in<br>&gt; HC=
I mode, so we don't have to use hid2hci utility, but for some
<br>&gt; strange reason it doesn't work in any direction (on both Brodacom =
and<br>&gt; PC).<br>&gt; We found that in the list, declared in the file hi=
d2hci.c , this pair<br>&gt; &quot;vendor-productID&quot; is defined as HID.=
.. It's strange.
<br><br>You need to have a dongle that actually supports HID proxy. Otherwi=
se<br>this tool doesn't do anything.</blockquote><div><br>
We deduct from 2.6 that our dongle supports HCI. Tx,
<br>
</div><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid=
 rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; We=
 see in sources that the socket to AF_BLUETOOTH with BT_PROTOHCI is<br>&gt;=
 opened successfully and even some of ioctl's succeeded, but HCIDEVUP
<br>&gt; did not...<br>&gt;<br>&gt; May someone hint us, what we did wrong.=
<br>&gt; Should we change something in the &quot;default&quot; hcid.conf (c=
lass device or<br>&gt; something else)?<br>&gt; Or should we make something=
 additional configurations?
<br>&gt; We don't find nothing extra in the manuals and HOWTOs...<br>&gt; H=
ow could we fix this HCI connection and move forward in establishing<br>&gt=
; BT communication on the described setup?<br><br>Move to a 2.6 kernel, bec=
ause I think this is a bug inside the USB
<br>subsystem. However if you don't need SCO support, you might wanna<br>di=
sable the ISOC transfers (SCO support) of the hci_usb driver.</blockquote><=
div><br>
Hm...&nbsp; We indeed won't need any SCO support. HCO is not used
although curently part of the kernel.&nbsp; How it might influence on
our setup?<br>
<br>

</div><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid=
 rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Regards=
<br><br>Marcel</blockquote><div><br>
Thanks for your help, Michael.<br>
&nbsp;<br>
</div><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid=
 rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">-------=
------------------------------------------------<br>This SF.net email is sp=
onsored by: Splunk Inc. Do you grep through log files
<br>for problems?&nbsp;&nbsp;Stop!&nbsp;&nbsp;Download the new AJAX search =
engine that makes<br>searching your log files as easy as surfing the&nbsp;&=
nbsp;web.&nbsp;&nbsp;DOWNLOAD SPLUNK!<br><a href=3D"http://sel.as-us.falkag=
.net/sel?cmd=3Dlnk&amp;kid=3D103432&amp;bid=3D230486&amp;dat=3D121642">
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&amp;kid=3D103432&amp;bid=3D230486=
&amp;dat=3D121642</a><br>_______________________________________________<br=
>Bluez-users mailing list<br><a href=3D"mailto:Bluez-users@lists.sourceforg=
e.net">
Bluez-users@lists.sourceforge.net</a><br><a href=3D"https://lists.sourcefor=
ge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/list=
info/bluez-users</a><br></blockquote></div><br>

------=_Part_8546_14673737.1140002357649--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
