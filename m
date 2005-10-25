Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <ef9938ec0510250753o413a29f4ge285f040afaa3614@mail.gmail.com>
From: Albert Huang <ashuang@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Link Quality between 2 Bluetooth USB Dongles
In-Reply-To: <1130230152.7840.42.camel@blade>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_7761_5874150.1130252029372"
References: <94e407f00510240734x12c64714qc791a991ddcd1426@mail.gmail.com>
	 <1130164983.19317.54.camel@blade>
	 <94e407f00510240944k24a3f4f1re75377a1bffb8a7@mail.gmail.com>
	 <1130174344.7840.2.camel@blade>
	 <94e407f00510242335r6312f167w909fdbff18069ef8@mail.gmail.com>
	 <1130230152.7840.42.camel@blade>
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
Date: Tue, 25 Oct 2005 10:53:49 -0400

------=_Part_7761_5874150.1130252029372
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

You may want to think twice about embarking on this project. A number of
researchers have tried this before without much success. See here, for
example:

http://anil.recoil.org/papers/2005-ubicomp-bluetooth.pdf

A Study of Bluetooth Propagation Using
Accurate Indoor Location Mapping

Abstract. The ubiquitous computing community has widely researched
the use of 802.11 for the purpose of location inference. Meanwhile,
Bluetooth
is increasingly widely deployed due to its low power consumption
and cost. This paper describes a study of Bluetooth radio propagation
using an accurate indoor location system to conduct fine-grained signal
strength surveys. We discuss practical problems and requirements encountere=
d
setting up the infrastructure using the ultrasonic Active Bat
indoor location system, and limitations of the commodity Bluetooth devices
used.We conclude that Bluetooth is poorly suited to the purpose of
fine-grained, low latency location inference due to specification and
hardware
limitations, and note that the movement speed of mobile devices is
an important factor in calculating available bandwidth. We publish our
data sets of signal strength samples for the community to freely use in
future research.

Good luck to you if you still persist.

-albert

On 10/25/05, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Arpit,
>
> > these chips are Broadcom based. So you must ask them how they
> > implemented the link quality value.
> >
> > How is the implementation vendor specific?Does it mean that some
> > vendors don't support Link Quality?Or does it mean that there are
> > other ways of getting the LQ value?
>
> the link quality value is vendor specific. Every manufacturer can
> implement it as they like. Read the specification for details.
>
> > Check "hciconfig hci0 features" if they support "Inquiry with RSSI".
> > [root@175-214 ~]# hciconfig hci0 features
> > hci0: Type: USB
> > BD Address: 00:10:60:B3:2C:F7 ACL MTU: 377:10 SCO MTU: 16:0
> > Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
> > <3-slot packets> <5-slot packets> <encryption> <slot
> > offset>
> > <timing accuracy> <role switch> <hold mode> <sniff
> > mode>
> > <RSSI> <channel quality> <SCO link> <HV2 packets>
> > <HV3 packets> <u-law log> <A-law log> <CVSD> <power
> > control>
> > <transparent SCO> <enhanced iscan> <interlaced iscan>
> > <interlaced pscan> <AFH cap. slave> <AFH cap. master>
> >
> > Well looks like it does support RSSI...but RSSI values change
> > abruptly..for the same distance the RSSI might be -9 and the after ten
> > seconds its -2 so I can't use RSSI.
>
> But they don't support "Inquiry with RSSI" which might be more usable.
> However ask Broadcom why this is so?
>
> > Do you suggest I try the LQ value with some other bluetooth
> > adaptors?Any idea as to which model would support the link quality
> > feature?
>
> The link quality is supported by every Bluetooth chip, but what this
> value means is up to the manufacturer. Read the specification to
> understand what this means.
>
> Get yourself two CSR based dongles and try again.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by the JBoss Inc.
> Get Certified Today * Register for a JBoss Training Course
> Free Certification Exam for All Training Attendees Through End of 2005
> Visit http://www.jboss.com/services/certification for more information
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_7761_5874150.1130252029372
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

You may want to think twice about embarking on this project.&nbsp; A
number of researchers have tried this before without much
success.&nbsp; See here, for example:<br><br>
<a href=3D"http://anil.recoil.org/papers/2005-ubicomp-bluetooth.pdf">http:/=
/anil.recoil.org/papers/2005-ubicomp-bluetooth.pdf</a><br>
<br>
A Study of Bluetooth Propagation Using<br>
Accurate Indoor Location Mapping<br>
<br>
Abstract. The ubiquitous computing community has widely researched<br>
the use of 802.11 for the purpose of location inference. Meanwhile, Bluetoo=
th<br>
is increasingly widely deployed due to its low power consumption<br>
and cost. This paper describes a study of Bluetooth radio propagation<br>
using an accurate indoor location system to conduct fine-grained signal<br>
strength surveys. We discuss practical problems and requirements encountere=
d<br>
setting up the infrastructure using the ultrasonic Active Bat<br>
indoor location system, and limitations of the commodity Bluetooth devices<=
br>
used.We conclude that Bluetooth is poorly suited to the purpose of<br>
fine-grained, low latency location inference due to specification and hardw=
are<br>
limitations, and note that the movement speed of mobile devices is<br>
an important factor in calculating available bandwidth. We publish our<br>
data sets of signal strength samples for the community to freely use in<br>
future research.<br>
<br>
Good luck to you if you still persist.<br>
<br>
-albert<br>
<br><div><span class=3D"gmail_quote">On 10/25/05, <b class=3D"gmail_sendern=
ame">Marcel Holtmann</b> &lt;<a href=3D"mailto:marcel@holtmann.org">marcel@=
holtmann.org</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=
=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; p=
adding-left: 1ex;">
Hi Arpit,<br><br>&gt; these chips are Broadcom based. So you must ask them =
how they<br>&gt; implemented the link quality value.<br>&gt;<br>&gt; How is=
 the implementation vendor specific?Does it mean that some<br>&gt; vendors =
don't support Link Quality?Or does it mean that there are
<br>&gt; other ways of getting the LQ value?<br><br>the link quality value =
is vendor specific. Every manufacturer can<br>implement it as they like. Re=
ad the specification for details.<br><br>&gt; Check &quot;hciconfig hci0 fe=
atures&quot; if they support &quot;Inquiry with RSSI&quot;.
<br>&gt; [root@175-214 ~]# hciconfig hci0 features<br>&gt; hci0:&nbsp;&nbsp=
; Type: USB<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Addr=
ess: 00:10:60:B3:2C:F7 ACL MTU: 377:10 SCO MTU: 16:0<br>&gt;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0=
x00 0x00<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;
&lt;3-slot packets&gt; &lt;5-slot packets&gt; &lt;encryption&gt;
&lt;slot<br>&gt; offset&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&lt;timing accuracy&gt; &lt;role switch&gt; &lt;hold mode&gt; &lt;sniff<br>=
&gt; mode&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&lt;RSSI&gt; &lt;channel quality&gt; &lt;SCO link&gt; &lt;HV2
packets&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&lt;HV3 packets&gt; &lt;u-law log&gt; &lt;A-law log&gt; &lt;CVSD&gt;
&lt;power<br>&gt; control&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&lt;transparent SCO&gt; &lt;enhanced iscan&gt; &lt;interlaced iscan&gt;<br>=
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;
&lt;interlaced pscan&gt; &lt;AFH cap. slave&gt; &lt;AFH cap. master&gt;<br>=
&gt;<br>&gt; Well looks like it does support RSSI...but RSSI values change<=
br>&gt; abruptly..for the same distance the RSSI might be -9 and the after =
ten
<br>&gt; seconds its -2 so I can't use RSSI.<br><br>But they don't support =
&quot;Inquiry with RSSI&quot; which might be more usable.<br>However ask Br=
oadcom why this is so?<br><br>&gt; Do you suggest I try the LQ value with s=
ome other bluetooth
<br>&gt; adaptors?Any idea as to which model would support the link quality=
<br>&gt; feature?<br><br>The link quality is supported by every Bluetooth c=
hip, but what this<br>value means is up to the manufacturer. Read the speci=
fication to
<br>understand what this means.<br><br>Get yourself two CSR based dongles a=
nd try again.<br><br>Regards<br><br>Marcel<br><br><br><br><br>-------------=
------------------------------------------<br>This SF.Net email is sponsore=
d by the JBoss Inc.
<br>Get Certified Today * Register for a JBoss Training Course<br>Free Cert=
ification Exam for All Training Attendees Through End of 2005<br>Visit <a h=
ref=3D"http://www.jboss.com/services/certification">http://www.jboss.com/se=
rvices/certification
</a> for more information<br>______________________________________________=
_<br>Bluez-users mailing list<br><a href=3D"mailto:Bluez-users@lists.source=
forge.net">Bluez-users@lists.sourceforge.net</a><br><a href=3D"https://list=
s.sourceforge.net/lists/listinfo/bluez-users">
https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br></blockquot=
e></div><br>

------=_Part_7761_5874150.1130252029372--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
