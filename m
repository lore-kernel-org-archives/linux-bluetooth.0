Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20130311184300.GA22451@joana>
References: <1362927903-7975-1-git-send-email-d3m3vilurr@gmail.com> <20130311184300.GA22451@joana>
From: d3m3vilurr <d3m3vilurr@gmail.com>
Date: Tue, 12 Mar 2013 04:45:36 +0900
Message-ID: <CAGGD0Fv2e6R2=f4mozBXahCq17vN7ShbfA6Ng+wHv5jv6LmYiA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth device 0cf3:3008 should map AR 3012
To: Gustavo Padovan <gustavo@padovan.org>, Sunguk Lee <d3m3vilurr@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary=f46d044787c9ed8ad904d7ab6b15
List-ID: <linux-bluetooth.vger.kernel.org>

--f46d044787c9ed8ad904d7ab6b15
Content-Type: text/plain; charset=ISO-8859-1

Hi Gustave,

On Tue, Mar 12, 2013 at 3:43 AM, Gustavo Padovan <gustavo@padovan.org>wrote:

> Hi Sunguk,
>
> * Sunguk Lee <d3m3vilurr@gmail.com> [2013-03-11 00:05:03 +0900]:
>
> > T:  Bus=01 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  3 Spd=12   MxCh= 0
> > D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> > P:  Vendor=0cf3 ProdID=3008 Rev= 0.01
> > S:  Manufacturer=Atheros Communications
> > S:  Product=Bluetooth USB Host Controller
> > S:  SerialNumber=Alaska Day 2006
> > C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> > I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> > E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> > E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> > E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> > I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> > I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> > I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> > I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> > I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> > I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> >
> > Signed-off-by: Sunguk Lee <d3m3vilurr@gmail.com>
> > ---
> >  drivers/bluetooth/ath3k.c |    2 ++
> >  drivers/bluetooth/btusb.c |    1 +
> >  2 files changed, 3 insertions(+)
>
> This patches looks good, but it needs to be rebased against latest
> bluetooth.git tree. You can get this tree at
>
> http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth.git
>
>         Gustavo
>

Rebase linux-bluetooth tree and resend patch :)

thx

Sunguk, Lee

--f46d044787c9ed8ad904d7ab6b15
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Gustave,<div><br></div><div><div class=3D"gmail_quote">On Tue, Mar 12, 2=
013 at 3:43 AM, Gustavo Padovan <span dir=3D"ltr">&lt;<a href=3D"mailto:gus=
tavo@padovan.org" target=3D"_blank">gustavo@padovan.org</a>&gt;</span> wrot=
e:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi Sunguk,<br>
<br>
* Sunguk Lee &lt;<a href=3D"mailto:d3m3vilurr@gmail.com">d3m3vilurr@gmail.c=
om</a>&gt; [2013-03-11 00:05:03 +0900]:<br>
<div><div class=3D"h5"><br>
&gt; T: =A0Bus=3D01 Lev=3D02 Prnt=3D02 Port=3D00 Cnt=3D01 Dev#=3D =A03 Spd=
=3D12 =A0 MxCh=3D 0<br>
&gt; D: =A0Ver=3D 1.10 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=
=3D =A01<br>
&gt; P: =A0Vendor=3D0cf3 ProdID=3D3008 Rev=3D 0.01<br>
&gt; S: =A0Manufacturer=3DAtheros Communications<br>
&gt; S: =A0Product=3DBluetooth USB Host Controller<br>
&gt; S: =A0SerialNumber=3DAlaska Day 2006<br>
&gt; C:* #Ifs=3D 2 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA<br>
&gt; I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Dri=
ver=3Dbtusb<br>
&gt; E: =A0Ad=3D81(I) Atr=3D03(Int.) MxPS=3D =A016 Ivl=3D1ms<br>
&gt; E: =A0Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D =A064 Ivl=3D0ms<br>
&gt; E: =A0Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D =A064 Ivl=3D0ms<br>
&gt; I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Dri=
ver=3Dbtusb<br>
&gt; E: =A0Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D =A0 0 Ivl=3D1ms<br>
&gt; E: =A0Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D =A0 0 Ivl=3D1ms<br>
&gt; I: =A0If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 D=
river=3Dbtusb<br>
&gt; E: =A0Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D =A0 9 Ivl=3D1ms<br>
&gt; E: =A0Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D =A0 9 Ivl=3D1ms<br>
&gt; I: =A0If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 D=
river=3Dbtusb<br>
&gt; E: =A0Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D =A017 Ivl=3D1ms<br>
&gt; E: =A0Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D =A017 Ivl=3D1ms<br>
&gt; I: =A0If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 D=
river=3Dbtusb<br>
&gt; E: =A0Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D =A025 Ivl=3D1ms<br>
&gt; E: =A0Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D =A025 Ivl=3D1ms<br>
&gt; I: =A0If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 D=
river=3Dbtusb<br>
&gt; E: =A0Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D =A033 Ivl=3D1ms<br>
&gt; E: =A0Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D =A033 Ivl=3D1ms<br>
&gt; I: =A0If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 D=
river=3Dbtusb<br>
&gt; E: =A0Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D =A049 Ivl=3D1ms<br>
&gt; E: =A0Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D =A049 Ivl=3D1ms<br>
&gt;<br>
&gt; Signed-off-by: Sunguk Lee &lt;<a href=3D"mailto:d3m3vilurr@gmail.com">=
d3m3vilurr@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; =A0drivers/bluetooth/ath3k.c | =A0 =A02 ++<br>
&gt; =A0drivers/bluetooth/btusb.c | =A0 =A01 +<br>
&gt; =A02 files changed, 3 insertions(+)<br>
<br>
</div></div>This patches looks good, but it needs to be rebased against lat=
est<br>
bluetooth.git tree. You can get this tree at<br>
<br>
<a href=3D"http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth.=
git" target=3D"_blank">http://git.kernel.org/cgit/linux/kernel/git/bluetoot=
h/bluetooth.git</a><br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
=A0 =A0 =A0 =A0 Gustavo<br>
</font></span></blockquote></div><div><br></div><div>Rebase linux-bluetooth=
 tree and resend patch :)</div><div><br></div><div>thx</div><div><br></div>=
<div>Sunguk, Lee</div></div><div><br></div>

--f46d044787c9ed8ad904d7ab6b15--
