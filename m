Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <6297d67c0605012201o52a1bb75u4622552cae9841f4@mail.gmail.com>
From: "Mayank Batra" <mayankbatra@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Motorola HT820 audio fidelity
In-Reply-To: <4456E4DF.5000601@xmission.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_5186_3576316.1146546108610"
References: <1146183877.13358.7.camel@pc7.dolda2000.com>
	 <445189C8.6060602@xmission.com>
	 <1146492165.13358.16.camel@pc7.dolda2000.com>
	 <44561FB6.5000306@xmission.com>
	 <6297d67c0605012039x618add3bq2b29b9ad584c609e@mail.gmail.com>
	 <4456E4DF.5000601@xmission.com>
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
Date: Tue, 2 May 2006 10:31:48 +0530

------=_Part_5186_3576316.1146546108610
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Brad,

The simplest approach would be to analyse all SEPs from the sink and if we
find an MP3 SEP, we can very well send the mp3 we receive from mpg123,
otherwise use the SBC codec.

Actually somewhere in the command line arguments we can take an input from
the user which codec does he prefer.

So if he writes something like:
a2play -c mp3
(Where -c is for the codec)
This should first try searching mp3 on the sink.
If not found, it should try SBC (which is of course mandatory and should be
found)

Whereas if he writes something like:
a2play -c sbc

This will straight away connect on SBC SEP.


Mayank


On 5/2/06, Brad Midgley <bmidgley@xmission.com> wrote:
>
> Mayank
>
> >
> http://www.assisttechnology.co.uk/documents/Sonorix_Bluetooth_Headset-Pam=
phlet.pdf
>
> Nice find.
>
> It brings up an interesting challenge. When using this headset, the
> driver should have access to the encoded audio so it can choose whether
> it's appropriate to decode the stream and then encode it in sbc or if it
> can pass the stream as-is to the set. I'll bet a gst bin could be
> constructed that would configure its elements accordingly for the input
> type and the headset caps.
>
> iirc, a2play assumes the first codec reported from the set is sbc. we
> should test it with the sonorix if somebody here has it to make sure we
> handle multiple codec capabilities properly.
>
> A bit of good news. It takes a couple of tries to get gxine to talk to
> my a2dp headset via the newly working plugin, but once it works the
> audio is very close to being in sync with the video and it is pretty
> solid for the duration of playing some video.
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

------=_Part_5186_3576316.1146546108610
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Brad,</div>
<div>&nbsp;</div>
<div>The simplest approach would be to analyse all SEPs from the sink and i=
f we find an MP3 SEP, we can very well send the mp3 we receive from mpg123,=
 otherwise use the SBC codec.</div>
<div>&nbsp;</div>
<div>Actually somewhere in the command line arguments we can take an input =
from the user which codec does he prefer.</div>
<div>&nbsp;</div>
<div>So if he writes something like:</div>
<div>a2play -c mp3</div>
<div>(Where -c is for the codec)</div>
<div>This should first try searching mp3 on the sink.</div>
<div>If not found, it should try SBC (which is of course mandatory and shou=
ld be found)</div>
<div>&nbsp;</div>
<div>Whereas if he writes something like:</div>
<div>a2play -c sbc</div>
<div>&nbsp;</div>
<div>This will straight away connect on SBC SEP.</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>Mayank<br><br>&nbsp;</div>
<div><span class=3D"gmail_quote">On 5/2/06, <b class=3D"gmail_sendername">B=
rad Midgley</b> &lt;<a href=3D"mailto:bmidgley@xmission.com">bmidgley@xmiss=
ion.com</a>&gt; wrote:</span>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Mayank<br><br>&gt; <a href=3D"ht=
tp://www.assisttechnology.co.uk/documents/Sonorix_Bluetooth_Headset-Pamphle=
t.pdf">
http://www.assisttechnology.co.uk/documents/Sonorix_Bluetooth_Headset-Pamph=
let.pdf</a><br><br>Nice find.<br><br>It brings up an interesting challenge.=
 When using this headset, the<br>driver should have access to the encoded a=
udio so it can choose whether
<br>it's appropriate to decode the stream and then encode it in sbc or if i=
t<br>can pass the stream as-is to the set. I'll bet a gst bin could be<br>c=
onstructed that would configure its elements accordingly for the input<br>
type and the headset caps.<br><br>iirc, a2play assumes the first codec repo=
rted from the set is sbc. we<br>should test it with the sonorix if somebody=
 here has it to make sure we<br>handle multiple codec capabilities properly=
.
<br><br>A bit of good news. It takes a couple of tries to get gxine to talk=
 to<br>my a2dp headset via the newly working plugin, but once it works the<=
br>audio is very close to being in sync with the video and it is pretty
<br>solid for the duration of playing some video.<br><br>Brad<br><br><br>--=
-----------------------------------------------------<br>Using Tomcat but n=
eed to do more? Need to support web services, security?<br>Get stuff done q=
uickly with pre-integrated technology to make your job easier
<br>Download IBM WebSphere Application Server v.1.0.1 based on Apache Geron=
imo<br><a href=3D"http://sel.as-us.falkag.net/sel?cmd=3Dlnk&amp;kid=3D12070=
9&amp;bid=3D263057&amp;dat=3D121642">http://sel.as-us.falkag.net/sel?cmd=3D=
lnk&amp;kid=3D120709&amp;bid=3D263057&amp;dat=3D121642
</a><br>_______________________________________________<br>Bluez-devel mail=
ing list<br><a href=3D"mailto:Bluez-devel@lists.sourceforge.net">Bluez-deve=
l@lists.sourceforge.net</a><br><a href=3D"https://lists.sourceforge.net/lis=
ts/listinfo/bluez-devel">
https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockquot=
e></div><br>

------=_Part_5186_3576316.1146546108610--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
