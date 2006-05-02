Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <6297d67c0605012039x618add3bq2b29b9ad584c609e@mail.gmail.com>
From: "Mayank Batra" <mayankbatra@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Motorola HT820 audio fidelity
In-Reply-To: <44561FB6.5000306@xmission.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_3378_2419123.1146541169538"
References: <1146183877.13358.7.camel@pc7.dolda2000.com>
	 <445189C8.6060602@xmission.com>
	 <1146492165.13358.16.camel@pc7.dolda2000.com>
	 <44561FB6.5000306@xmission.com>
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
Date: Tue, 2 May 2006 09:09:29 +0530

------=_Part_3378_2419123.1146541169538
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Brad,

Have a look at the following headset (Sonorix):

http://www.assisttechnology.co.uk/documents/Sonorix_Bluetooth_Headset-Pamph=
let.pdf

It supports both SBC and MP3 codecs.
And it is BT1.2 compliant.

Mayank


On 5/1/06, Brad Midgley <bmidgley@xmission.com> wrote:
>
> Fredrik
>
> >>It doesn't help that we're typically decoding mp3 and reencoding in sbc=
.
> >>Loss is really compounded.
> >
> >
> > Indeed, that seems to be the problem. I was always under the
> > (uninformed) impression that SBC was lossless, but I just tried
> > re-encoding an MP3 to SBC and playing that SBC with sbcenc and sbcdec,
> > and the exact same audio artifacts are showing themselves when I play
> > back to my normal speaker system as through the headphones.
>
> You haven't ruled out our implementation of sbc however. We could have
> problems still. Also, there are also some defaults for encoding that
> although set fairly high are not at the max iirc.
>
> There is/was a reference SBC encoder that is a windows executable
> somewhere at bluetooth.org. Testing with it would let us rule out (or
> implicate) our implementation.
>
> > So, at least it's not a hardware or BT stack problem. Is this an
> > inherent problem in SBC, or is there a way to tune the encoder to
> > compensate? Is it possibly so that a better encoder could be written
> > altogether?
>
> The spec allows us to negotiate a different codec with the headset. SBC
> is the only required codec. fwiw, I've never seen a headset that accepts
> mp3 or others. I should modify a2play to flag these so they would be
> easier to spot.
>
> Brad
>
>
> -------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job
> easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronim=
o
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_3378_2419123.1146541169538
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Brad,</div>
<div>&nbsp;</div>
<div>Have a look at the following headset (Sonorix):</div>
<div>&nbsp;</div>
<div><a href=3D"http://www.assisttechnology.co.uk/documents/Sonorix_Bluetoo=
th_Headset-Pamphlet.pdf">http://www.assisttechnology.co.uk/documents/Sonori=
x_Bluetooth_Headset-Pamphlet.pdf</a></div>
<div>&nbsp;</div>
<div>It supports both SBC and MP3 codecs.</div>
<div>And it is BT1.2 compliant.</div>
<div>&nbsp;</div>
<div>Mayank<br><br>&nbsp;</div>
<div><span class=3D"gmail_quote">On 5/1/06, <b class=3D"gmail_sendername">B=
rad Midgley</b> &lt;<a href=3D"mailto:bmidgley@xmission.com">bmidgley@xmiss=
ion.com</a>&gt; wrote:</span>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Fredrik<br><br>&gt;&gt;It doesn'=
t help that we're typically decoding mp3 and reencoding in sbc.<br>&gt;&gt;=
Loss is really compounded.
<br>&gt;<br>&gt;<br>&gt; Indeed, that seems to be the problem. I was always=
 under the<br>&gt; (uninformed) impression that SBC was lossless, but I jus=
t tried<br>&gt; re-encoding an MP3 to SBC and playing that SBC with sbcenc =
and sbcdec,
<br>&gt; and the exact same audio artifacts are showing themselves when I p=
lay<br>&gt; back to my normal speaker system as through the headphones.<br>=
<br>You haven't ruled out our implementation of sbc however. We could have
<br>problems still. Also, there are also some defaults for encoding that<br=
>although set fairly high are not at the max iirc.<br><br>There is/was a re=
ference SBC encoder that is a windows executable<br>somewhere at <a href=3D=
"http://bluetooth.org">
bluetooth.org</a>. Testing with it would let us rule out (or<br>implicate) =
our implementation.<br><br>&gt; So, at least it's not a hardware or BT stac=
k problem. Is this an<br>&gt; inherent problem in SBC, or is there a way to=
 tune the encoder to
<br>&gt; compensate? Is it possibly so that a better encoder could be writt=
en<br>&gt; altogether?<br><br>The spec allows us to negotiate a different c=
odec with the headset. SBC<br>is the only required codec. fwiw, I've never =
seen a headset that accepts
<br>mp3 or others. I should modify a2play to flag these so they would be<br=
>easier to spot.<br><br>Brad<br><br><br>-----------------------------------=
--------------------<br>Using Tomcat but need to do more? Need to support w=
eb services, security?
<br>Get stuff done quickly with pre-integrated technology to make your job =
easier<br>Download IBM WebSphere Application Server v.1.0.1 based on Apache=
 Geronimo<br><a href=3D"http://sel.as-us.falkag.net/sel?cmd=3Dlnk&amp;kid=
=3D120709&amp;bid=3D263057&amp;dat=3D121642">
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&amp;kid=3D120709&amp;bid=3D263057=
&amp;dat=3D121642</a><br>_______________________________________________<br=
>Bluez-devel mailing list<br><a href=3D"mailto:Bluez-devel@lists.sourceforg=
e.net">
Bluez-devel@lists.sourceforge.net</a><br><a href=3D"https://lists.sourcefor=
ge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/lists/list=
info/bluez-devel</a><br></blockquote></div><br>

------=_Part_3378_2419123.1146541169538--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
