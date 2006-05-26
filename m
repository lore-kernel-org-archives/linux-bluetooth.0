Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <fe0a97c20605252311k20a25dffyfb37603a5d322d6f@mail.gmail.com>
From: "Sowmya Gattupalli" <sowmya.gattupalli@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] LInux Bluetooth and Audio (OSS) interface
In-Reply-To: <447696EC.4080804@xmission.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_49643_7825380.1148623870104"
References: <c4cf8c660605252058n622d6dfak5ad964349551d662@mail.gmail.com>
	 <447696EC.4080804@xmission.com>
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
Date: Fri, 26 May 2006 11:41:10 +0530

------=_Part_49643_7825380.1148623870104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

But Brad.... incase we write the OSS Api dependency in btsco we need not
have to upgrade the kernel to have kernel with inbuilt ALSA drivers..... I
feel this is the advantage we are filling up with SCO amd OSS appln incase
if we have to.... isn't it??

On 5/26/06, Brad Midgley <bmidgley@xmission.com> wrote:
>
> Timmy
>
> Maybe you could rewrite btsco.c (the userspace daemon) so it only uses
> oss interfaces to the kernel. Hmm... the hooks may not all be there
> however. If it could be done, the kernel mod wouldn't really have to
> change since you can use alsa-oss-emulation.
>
> There are a lot of directions we could take this. Pure oss isn't one of
> the most promising.
>
> I think an interesting option is gstreamer drivers entirely in
> userspace. That should embed more easily which is one big strike against
> alsa. gst events might cover the complexity we have now in interacting
> with a daemon.
>
> Brad
>
> >    I am a newbie to bluetooth. It seems that there are no integration
> > on linux bluetooth (SCO link) and audio (OSS) interface, so that there
> > are no standard API for the user mode audio applications when using or
> > not using bluetooth handset.
> >   Bluetooth-alsa seems to be something like that, but it focuses on
> > Bluetooth + ALSA, I am not sure whether it is a good starting point.
> >
> >   Can anyone give me some advice on how to provide an uniform
> > interface for user mode audio applications ? Since it could be
> > paintful for user mode audio applications to use SCO socket interface
> > directly and handle the details for bluetooth handset.
> >
> >   Thanks,
> >
> > Timmy
> >
> >
> > -------------------------------------------------------
> > All the advantages of Linux Managed Hosting--Without the Cost and Risk!
> > Fully trained technicians. The highest number of Red Hat certifications
> in
> > the hosting industry. Fanatical Support. Click to learn more
> > http://sel.as-us.falkag.net/sel?cmd=3Dk&kid=107521&bid$8729&dat=121642
> > _______________________________________________
> > Bluez-devel mailing list
> > Bluez-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>
>
> -------------------------------------------------------
> All the advantages of Linux Managed Hosting--Without the Cost and Risk!
> Fully trained technicians. The highest number of Red Hat certifications i=
n
> the hosting industry. Fanatical Support. Click to learn more
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D107521&bid=3D248729&dat=
=3D121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_49643_7825380.1148623870104
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

But Brad.... incase we write the OSS Api dependency in btsco we need not ha=
ve to upgrade the kernel to have kernel with inbuilt ALSA drivers..... I fe=
el this is the advantage we are filling up with SCO amd OSS appln incase if=
 we have to.... isn't it??
<br><br><div><span class=3D"gmail_quote">On 5/26/06, <b class=3D"gmail_send=
ername">Brad Midgley</b> &lt;<a href=3D"mailto:bmidgley@xmission.com">bmidg=
ley@xmission.com</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" sty=
le=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex;=
 padding-left: 1ex;">
Timmy<br><br>Maybe you could rewrite btsco.c (the userspace daemon) so it o=
nly uses<br>oss interfaces to the kernel. Hmm... the hooks may not all be t=
here<br>however. If it could be done, the kernel mod wouldn't really have t=
o
<br>change since you can use alsa-oss-emulation.<br><br>There are a lot of =
directions we could take this. Pure oss isn't one of<br>the most promising.=
<br><br>I think an interesting option is gstreamer drivers entirely in<br>
userspace. That should embed more easily which is one big strike against<br=
>alsa. gst events might cover the complexity we have now in interacting<br>=
with a daemon.<br><br>Brad<br><br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;I am a newbie=
 to bluetooth. It seems that there are no integration
<br>&gt; on linux bluetooth (SCO link) and audio (OSS) interface, so that t=
here<br>&gt; are no standard API for the user mode audio applications when =
using or<br>&gt; not using bluetooth handset.<br>&gt;&nbsp;&nbsp; Bluetooth=
-alsa seems to be something like that, but it focuses on
<br>&gt; Bluetooth + ALSA, I am not sure whether it is a good starting poin=
t.<br>&gt;<br>&gt;&nbsp;&nbsp; Can anyone give me some advice on how to pro=
vide an uniform<br>&gt; interface for user mode audio applications ? Since =
it could be
<br>&gt; paintful for user mode audio applications to use SCO socket interf=
ace<br>&gt; directly and handle the details for bluetooth handset.<br>&gt;<=
br>&gt;&nbsp;&nbsp; Thanks,<br>&gt;<br>&gt; Timmy<br>&gt;<br>&gt;<br>&gt; -=
------------------------------------------------------
<br>&gt; All the advantages of Linux Managed Hosting--Without the Cost and =
Risk!<br>&gt; Fully trained technicians. The highest number of Red Hat cert=
ifications in<br>&gt; the hosting industry. Fanatical Support. Click to lea=
rn more
<br>&gt; <a href=3D"http://sel.as-us.falkag.net/sel?cmd=3Dk&amp;kid=107521&=
amp;bid$8729&amp;dat=121642">http://sel.as-us.falkag.net/sel?cmd=3Dk&amp;ki=
d=107521&amp;bid$8729&amp;dat=121642</a><br>&gt; __________________________=
_____________________
<br>&gt; Bluez-devel mailing list<br>&gt; <a href=3D"mailto:Bluez-devel@lis=
ts.sourceforge.net">Bluez-devel@lists.sourceforge.net</a><br>&gt; <a href=
=3D"https://lists.sourceforge.net/lists/listinfo/bluez-devel">https://lists=
.sourceforge.net/lists/listinfo/bluez-devel
</a><br><br><br><br>-------------------------------------------------------=
<br>All the advantages of Linux Managed Hosting--Without the Cost and Risk!=
<br>Fully trained technicians. The highest number of Red Hat certifications=
 in
<br>the hosting industry. Fanatical Support. Click to learn more<br><a href=
=3D"http://sel.as-us.falkag.net/sel?cmd=3Dlnk&amp;kid=3D107521&amp;bid=3D24=
8729&amp;dat=3D121642">http://sel.as-us.falkag.net/sel?cmd=3Dlnk&amp;kid=3D=
107521&amp;bid=3D248729&amp;dat=3D121642
</a><br>_______________________________________________<br>Bluez-devel mail=
ing list<br><a href=3D"mailto:Bluez-devel@lists.sourceforge.net">Bluez-deve=
l@lists.sourceforge.net</a><br><a href=3D"https://lists.sourceforge.net/lis=
ts/listinfo/bluez-devel">
https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockquot=
e></div><br>

------=_Part_49643_7825380.1148623870104--


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
