Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <347F2184-6CA1-4BCF-AC42-0A9E1FB9F9C9@holtmann.org>
References: <1390595089-5314-1-git-send-email-sebastianchlad@gmail.com>
	<347F2184-6CA1-4BCF-AC42-0A9E1FB9F9C9@holtmann.org>
Date: Fri, 24 Jan 2014 19:03:44 -0500
Message-ID: <CAJCsO8dTQSORkfN8vWB6n-PdSp_=E_A3NoBjf05a3XC5s6ep6g@mail.gmail.com>
Subject: Re: [PATCH] android/pts: Add PTS test results for A2DP
From: Sebastian Chlad <sebastianchlad@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/alternative; boundary=14dae9399ab93e233e04f0c035b2
List-ID: <linux-bluetooth.vger.kernel.org>

--14dae9399ab93e233e04f0c035b2
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On Saturday, January 25, 2014, Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Sebastian,
>
> > ---
> > android/pts-a2dp.txt | 14 +++++++-------
> > 1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/android/pts-a2dp.txt b/android/pts-a2dp.txt
> > index a269ec1..c6eee62 100644
> > --- a/android/pts-a2dp.txt
> > +++ b/android/pts-a2dp.txt
> > @@ -1,7 +1,7 @@
> > PTS test results for A2DP
> >
> > PTS version: 5.0
> > -Tested: --not yet tested--
> > +Tested: 24.01.2014
> >
> > Results:
> > PASS  test passed
> > @@ -15,17 +15,17 @@ Test Name         Result  Notes
> >
> -------------------------------------------------------------------------=
------
> > TC_SRC_CC_BV_09_I     INC
> > TC_SRC_CC_BV_10_I     N/A
> > -TC_SRC_REL_BV_01_I   INC
> > -TC_SRC_REL_BV_02_I   INC
> > -TC_SRC_SET_BV_01_I   INC
> > -TC_SRC_SET_BV_02_I   INC
> > -TC_SRC_SET_BV_03_I   INC
> > +TC_SRC_REL_BV_01_I   PASS
> > +TC_SRC_REL_BV_02_I   PASS
> > +TC_SRC_SET_BV_01_I   PASS
> > +TC_SRC_SET_BV_02_I   PASS
> > +TC_SRC_SET_BV_03_I   PASS
> > TC_SRC_SET_BV_04_I    INC
> > TC_SRC_SET_BV_05_I    INC
> > TC_SRC_SET_BV_06_I    INC
> > TC_SRC_SUS_BV_01_I    INC
> > TC_SRC_SUS_BV_02_I    INC
> > -TC_SRC_SDP_BV_01_I   INC
> > +TC_SRC_SDP_BV_01_I   PASS
> > TC_SRC_AS_BV_01_I     INC
> > =97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=
=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97
>
> can we extend the notes section with some sort of instructions that we
> have to do on the IUT side. Even it is something simple like Play music o=
r
> just wait for incoming connections. This applies to all of out PTS
> documentation of course.
>
> Regards
>
> Marcel


 Sure. I'll keep adding such notes over next couple of weeks.

Br,
Sebastian


--=20
Seb/

--14dae9399ab93e233e04f0c035b2
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

<br>On Saturday, January 25, 2014, Marcel Holtmann &lt;<a href=3D"mailto:ma=
rcel@holtmann.org">marcel@holtmann.org</a>&gt; wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
Hi Sebastian,<br>
<br>
&gt; ---<br>
&gt; android/pts-a2dp.txt | 14 +++++++-------<br>
&gt; 1 file changed, 7 insertions(+), 7 deletions(-)<br>
&gt;<br>
&gt; diff --git a/android/pts-a2dp.txt b/android/pts-a2dp.txt<br>
&gt; index a269ec1..c6eee62 100644<br>
&gt; --- a/android/pts-a2dp.txt<br>
&gt; +++ b/android/pts-a2dp.txt<br>
&gt; @@ -1,7 +1,7 @@<br>
&gt; PTS test results for A2DP<br>
&gt;<br>
&gt; PTS version: 5.0<br>
&gt; -Tested: --not yet tested--<br>
&gt; +Tested: 24.01.2014<br>
&gt;<br>
&gt; Results:<br>
&gt; PASS =A0test passed<br>
&gt; @@ -15,17 +15,17 @@ Test Name =A0 =A0 =A0 =A0 Result =A0Notes<br>
&gt; ----------------------------------------------------------------------=
---------<br>
&gt; TC_SRC_CC_BV_09_I =A0 =A0 INC<br>
&gt; TC_SRC_CC_BV_10_I =A0 =A0 N/A<br>
&gt; -TC_SRC_REL_BV_01_I =A0 INC<br>
&gt; -TC_SRC_REL_BV_02_I =A0 INC<br>
&gt; -TC_SRC_SET_BV_01_I =A0 INC<br>
&gt; -TC_SRC_SET_BV_02_I =A0 INC<br>
&gt; -TC_SRC_SET_BV_03_I =A0 INC<br>
&gt; +TC_SRC_REL_BV_01_I =A0 PASS<br>
&gt; +TC_SRC_REL_BV_02_I =A0 PASS<br>
&gt; +TC_SRC_SET_BV_01_I =A0 PASS<br>
&gt; +TC_SRC_SET_BV_02_I =A0 PASS<br>
&gt; +TC_SRC_SET_BV_03_I =A0 PASS<br>
&gt; TC_SRC_SET_BV_04_I =A0 =A0INC<br>
&gt; TC_SRC_SET_BV_05_I =A0 =A0INC<br>
&gt; TC_SRC_SET_BV_06_I =A0 =A0INC<br>
&gt; TC_SRC_SUS_BV_01_I =A0 =A0INC<br>
&gt; TC_SRC_SUS_BV_02_I =A0 =A0INC<br>
&gt; -TC_SRC_SDP_BV_01_I =A0 INC<br>
&gt; +TC_SRC_SDP_BV_01_I =A0 PASS<br>
&gt; TC_SRC_AS_BV_01_I =A0 =A0 INC<br>
&gt; =97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=
=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97<br>
<br>
can we extend the notes section with some sort of instructions that we have=
 to do on the IUT side. Even it is something simple like Play music or just=
 wait for incoming connections. This applies to all of out PTS documentatio=
n of course.<br>

<br>
Regards<br>
<br>
Marcel</blockquote><div><br></div><div>=A0Sure. I&#39;ll keep adding such n=
otes over next couple of weeks.=A0</div><div><br></div><div>Br,=A0</div><di=
v>Sebastian=A0</div><br><br>-- <br><div dir=3D"ltr">Seb/<br></div><br>

--14dae9399ab93e233e04f0c035b2--
