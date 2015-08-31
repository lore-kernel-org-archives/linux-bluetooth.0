Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
References: <CAEZxfGP=P-5J_CFkwN6u=b+au7FcELCbXU_SSzomraFCC6UK9w@mail.gmail.com>
 <7D13E5DD-914F-4E8B-8724-0E40B604DD36@holtmann.org>
In-Reply-To: <7D13E5DD-914F-4E8B-8724-0E40B604DD36@holtmann.org>
From: =?UTF-8?Q?Fran=C3=A7ois_Beaufort?= <beaufort.francois@gmail.com>
Date: Mon, 31 Aug 2015 12:06:23 +0000
Message-ID: <CAEZxfGPBG-RAJ-VWMh7Cg7c6yEReJ-vJ4Vt6HKHrMLWNHYyM9g@mail.gmail.com>
Subject: Re: Bluez 5.33 won't connect to advertising Nexus 6
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: multipart/alternative; boundary=047d7b343642b1caab051e9a4314
List-ID: <linux-bluetooth.vger.kernel.org>

--047d7b343642b1caab051e9a4314
Content-Type: text/plain; charset=UTF-8

Hello Marcel,
Thank you for this insightful answers.

You're probably right about firmware issues as Chromebook A (working) has
Qualcomm Atheros, Inc. BT chip while Chromebook B (non-working) has
Broadcom BT chip.

I'll focus on the firmware side then and let you know my findings
eventually.

On Thu, Aug 27, 2015 at 9:55 PM Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Francois,
>
> > Bluez 5.33 allows me to connect to my Nexus 6 on chromebook A but not
> > chromebook B. Here's the full steps to reproduce the issue:
> >
> > 1. Install
> https://play.google.com/store/apps/details?id=io.github.webbluetoothcg.bletestperipheral
> > on Nexus 6
> > 2. Run it and advertise Battery Service
> > 3. Open Chrome OS Shell bluetooth console [Ctrl] + [Alt] + T and:
> > crosh> bt_console
> > 4. Scan for devices until Nexus 6 appears and turn it off.
> > [bluetooth]# scan on
> > [bluetooth]# scan off
> > 5. Connect to Nexus 6 wit the appropriate BT address:
> > [bluetooth]# connect 63:7B:C2:07:EF:AD
> > Attempting to connect to 63:7B:C2:07:EF:AD
> >
> > If you're lucky, you'll see "Connection successful".
> > If not, you'll get "Failed to connect: org.bluez.Error.Failed"
> >
> > More background at
> > https://code.google.com/p/chromium/issues/detail?id=508541#c15
> >
> > I'd like to figure out what is happening behind the scenes there.
> > Here's a btsnoop.log file in case it
> > helps:https://www.cloudshark.org/captures/dcb775e24f91
>
> try an info on the bluetooth console and it should tell you what chip you
> have locally on your Chromebook and compare them with each other. If you
> want to do that in a real terminal, hciconfig -a please.
>
> For me this looks pretty much like a firmware issue. You could use an
> over-air-analyzer like Ellisys to really see why the connection does not
> establish.
>
> However since you are running this against the Nexus 6 with
> multi-advertising Broadcom specific vendor feature, you are moving into
> territory that is actually not covered by a Bluetooth standard and its
> qualification testing. So I would blame whoever insisted on relying on
> vendor stuff for Android LE peripheral mode.
>
> It could be also if this is really Broadcom vs Broadcom on both sides,
> that the firmware tries to outsmart itself ;)
>
> Regards
>
> Marcel
>
>

--047d7b343642b1caab051e9a4314
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello Marcel,<div>Thank you for this insightful answers.</=
div><div><br></div><div>You&#39;re probably right about firmware issues as =
Chromebook A (working) has Qualcomm Atheros, Inc. BT chip while Chromebook =
B (non-working) has Broadcom BT chip.</div><div><br></div>I&#39;ll focus on=
 the firmware side then and let you know my findings eventually.<div><br><d=
iv class=3D"gmail_quote"><div dir=3D"ltr">On Thu, Aug 27, 2015 at 9:55 PM M=
arcel Holtmann &lt;<a href=3D"mailto:marcel@holtmann.org" target=3D"_blank"=
>marcel@holtmann.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>Hi Francois,<br>
<br>
&gt; Bluez 5.33 allows me to connect to my Nexus 6 on chromebook A but not<=
br>
&gt; chromebook B. Here&#39;s the full steps to reproduce the issue:<br>
&gt;<br>
&gt; 1. Install <a href=3D"https://play.google.com/store/apps/details?id=3D=
io.github.webbluetoothcg.bletestperipheral" rel=3D"noreferrer" target=3D"_b=
lank">https://play.google.com/store/apps/details?id=3Dio.github.webbluetoot=
hcg.bletestperipheral</a><br>
&gt; on Nexus 6<br>
&gt; 2. Run it and advertise Battery Service<br>
&gt; 3. Open Chrome OS Shell bluetooth console [Ctrl] + [Alt] + T and:<br>
&gt; crosh&gt; bt_console<br>
&gt; 4. Scan for devices until Nexus 6 appears and turn it off.<br>
&gt; [bluetooth]# scan on<br>
&gt; [bluetooth]# scan off<br>
&gt; 5. Connect to Nexus 6 wit the appropriate BT address:<br>
&gt; [bluetooth]# connect 63:7B:C2:07:EF:AD<br>
&gt; Attempting to connect to 63:7B:C2:07:EF:AD<br>
&gt;<br>
&gt; If you&#39;re lucky, you&#39;ll see &quot;Connection successful&quot;.=
<br>
&gt; If not, you&#39;ll get &quot;Failed to connect: org.bluez.Error.Failed=
&quot;<br>
&gt;<br>
&gt; More background at<br>
&gt; <a href=3D"https://code.google.com/p/chromium/issues/detail?id=3D50854=
1#c15" rel=3D"noreferrer" target=3D"_blank">https://code.google.com/p/chrom=
ium/issues/detail?id=3D508541#c15</a><br>
&gt;<br>
&gt; I&#39;d like to figure out what is happening behind the scenes there.<=
br>
&gt; Here&#39;s a btsnoop.log file in case it<br>
&gt; helps:<a href=3D"https://www.cloudshark.org/captures/dcb775e24f91" rel=
=3D"noreferrer" target=3D"_blank">https://www.cloudshark.org/captures/dcb77=
5e24f91</a><br>
<br>
try an info on the bluetooth console and it should tell you what chip you h=
ave locally on your Chromebook and compare them with each other. If you wan=
t to do that in a real terminal, hciconfig -a please.<br>
<br>
For me this looks pretty much like a firmware issue. You could use an over-=
air-analyzer like Ellisys to really see why the connection does not establi=
sh.<br>
<br>
However since you are running this against the Nexus 6 with multi-advertisi=
ng Broadcom specific vendor feature, you are moving into territory that is =
actually not covered by a Bluetooth standard and its qualification testing.=
 So I would blame whoever insisted on relying on vendor stuff for Android L=
E peripheral mode.<br>
<br>
It could be also if this is really Broadcom vs Broadcom on both sides, that=
 the firmware tries to outsmart itself ;)<br>
<br>
Regards<br>
<br>
Marcel<br>
<br>
</blockquote></div></div></div>

--047d7b343642b1caab051e9a4314--
