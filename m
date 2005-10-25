Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <94e407f00510242335r6312f167w909fdbff18069ef8@mail.gmail.com>
From: Arpit Rai <whalesurf@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Link Quality between 2 Bluetooth USB Dongles
In-Reply-To: <1130174344.7840.2.camel@blade>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_7443_32346739.1130222112200"
References: <94e407f00510240734x12c64714qc791a991ddcd1426@mail.gmail.com>
	 <1130164983.19317.54.camel@blade>
	 <94e407f00510240944k24a3f4f1re75377a1bffb8a7@mail.gmail.com>
	 <1130174344.7840.2.camel@blade>
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
Date: Tue, 25 Oct 2005 14:35:12 +0800

------=_Part_7443_32346739.1130222112200
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel
 these chips are Broadcom based. So you must ask them how they
implemented the link quality value.
How is the implementation vendor specific?Does it mean that some vendors
don't support Link Quality?Or does it mean that there are other ways of
getting the LQ value?
 Check "hciconfig hci0 features" if they support "Inquiry with RSSI".
[root@175-214 ~]# hciconfig hci0 features
hci0: Type: USB
BD Address: 00:10:60:B3:2C:F7 ACL MTU: 377:10 SCO MTU: 16:0
Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
<3-slot packets> <5-slot packets> <encryption> <slot offset>
<timing accuracy> <role switch> <hold mode> <sniff mode>
<RSSI> <channel quality> <SCO link> <HV2 packets>
<HV3 packets> <u-law log> <A-law log> <CVSD> <power control>
<transparent SCO> <enhanced iscan> <interlaced iscan>
<interlaced pscan> <AFH cap. slave> <AFH cap. master>
 Well looks like it does support RSSI...but RSSI values change abruptly..fo=
r
the same distance the RSSI might be -9 and the after ten seconds its -2 so =
I
can't use RSSI.
 Do you suggest I try the LQ value with some other bluetooth adaptors?Any
idea as to which model would support the link quality feature?
 Regards
Arpit

 On 10/25/05, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Arpit,
>
> > [root@174-242 ~]# hciconfig hci0 version
> > hci0: Type: USB
> > BD Address: 00:10:60:B3:2C:F7 ACL MTU: 377:10 SCO MTU: 16:0
> > HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver:
> > 0x309
> > Manufacturer: Broadcom Corporation (15)
>
> these chips are Broadcom based. So you must ask them how they
> implemented the link quality value.
>
> Check "hciconfig hci0 features" if they support "Inquiry with RSSI".
>
> > What is the HCI build version in this case?And how does this help me?
>
> The build id is only valid for CSR chips. It is not fully clear how
> Broadcom encodes this.
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

------=_Part_7443_32346739.1130222112200
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Hi Marcel</div>
<div>&nbsp;</div>
<div><font color=3D"#6600cc"><font color=3D"#cc33cc">these chips are Broadc=
om based. So you must ask them how they<br>implemented the link quality val=
ue.</font><br></font></div>
<div>How is the implementation vendor specific?Does it mean that some vendo=
rs don't support Link Quality?Or does it mean that there are other ways of =
getting the LQ value?</div>
<div>&nbsp;</div>
<div><font color=3D"#cc33cc">Check &quot;hciconfig hci0 features&quot; if t=
hey support &quot;Inquiry with RSSI&quot;.<br></font><font size=3D"2">[root=
@175-214 ~]# hciconfig hci0 features<br>hci0:&nbsp;&nbsp; Type: USB<br>&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:10:60:B3:2C:F7 ACL MT=
U: 377:10 SCO MTU: 16:0
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xff 0xfe 0x0d 0x3=
8 0x08 0x08 0x00 0x00<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;3-slot packets&gt; &lt;5-slot =
packets&gt; &lt;encryption&gt; &lt;slot offset&gt;<br>&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;t=
iming accuracy&gt; &lt;role switch&gt; &lt;hold mode&gt; &lt;sniff mode&gt;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &lt;RSSI&gt; &lt;channel quality&gt; &lt;SCO link&gt; &=
lt;HV2 packets&gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;HV3 packets&gt; &lt;u-law log&gt;=
 &lt;A-law log&gt; &lt;CVSD&gt; &lt;power control&gt;<br>&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &l=
t;transparent SCO&gt; &lt;enhanced iscan&gt; &lt;interlaced iscan&gt;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &lt;interlaced pscan&gt; &lt;AFH cap. slave&gt; &lt;AFH=
 cap. master&gt;</font></div>
<div><font size=3D"2"></font>&nbsp;</div>
<div><font size=3D"2">Well looks like it does support RSSI...but RSSI value=
s change abruptly..for the same distance the RSSI might be -9 and the after=
 ten seconds its -2 so I can't use RSSI.</font></div>
<div><font size=3D"2"></font>&nbsp;</div>
<div><font size=3D"2">Do you suggest I try the LQ value with some other blu=
etooth adaptors?Any idea as to which model would support the link quality f=
eature?</font></div>
<div><font size=3D"2"></font>&nbsp;</div>
<div><font size=3D"2">Regards</font></div>
<div><font size=3D"2">Arpit</font></div>
<div><br>&nbsp;</div>
<div><span class=3D"gmail_quote">On 10/25/05, <b class=3D"gmail_sendername"=
>Marcel Holtmann</b> &lt;<a href=3D"mailto:marcel@holtmann.org">marcel@holt=
mann.org</a>&gt; wrote:</span>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hi Arpit,<br><br>&gt; [root@174-=
242 ~]# hciconfig hci0 version<br>&gt; hci0:&nbsp;&nbsp; Type: USB<br>&gt;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;BD Address: 00:10:60:B3:2C:F=
7 ACL MTU: 377:10 SCO MTU: 16:0
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;HCI Ver: 1.2 (0x2) =
HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver:<br>&gt; 0x309<br>&gt;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Manufacturer: Broadcom Corporation (1=
5)<br><br>these chips are Broadcom based. So you must ask them how they<br>=
implemented the link quality value.
<br><br>Check &quot;hciconfig hci0 features&quot; if they support &quot;Inq=
uiry with RSSI&quot;.<br><br>&gt; What is the HCI build version in this cas=
e?And how does this help me?<br><br>The build id is only valid for CSR chip=
s. It is not fully clear how
<br>Broadcom encodes this.<br><br>Regards<br><br>Marcel<br><br><br><br><br>=
-------------------------------------------------------<br>This SF.Net emai=
l is sponsored by the JBoss Inc.<br>Get Certified Today * Register for a JB=
oss Training Course
<br>Free Certification Exam for All Training Attendees Through End of 2005<=
br>Visit <a href=3D"http://www.jboss.com/services/certification">http://www=
.jboss.com/services/certification</a> for more information<br>_____________=
__________________________________
<br>Bluez-users mailing list<br><a href=3D"mailto:Bluez-users@lists.sourcef=
orge.net">Bluez-users@lists.sourceforge.net</a><br><a href=3D"https://lists=
.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/=
lists/listinfo/bluez-users
</a><br></blockquote></div><br>

------=_Part_7443_32346739.1130222112200--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
