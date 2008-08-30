Return-Path: <cyrus@holtmann.org>
Message-ID: <35c90d960808300037h242dbf5fkd584bf552ed50190@mail.gmail.com>
Date: Sat, 30 Aug 2008 00:37:53 -0700
From: "Nick Pelly" <npelly@google.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1220088521.7145.51.camel@californication>
MIME-Version: 1.0
References: <1220050803-30362-1-git-send-email-npelly@google.com>
	<1220086722.7145.33.camel@californication>
	<35c90d960808300016t1ea8b8eq638a399e7d04b1e9@mail.gmail.com>
	<1220088521.7145.51.camel@californication>
Subject: Re: [Bluez-devel] [PATCH] Advertise Telephony service class when
	device offers headset AG or handsfree AG
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1781657097=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1781657097==
Content-Type: multipart/alternative;
	boundary="----=_Part_39682_32453615.1220081873482"

------=_Part_39682_32453615.1220081873482
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sat, Aug 30, 2008 at 2:28 AM, Marcel Holtmann <marcel@holtmann.org>wrote:

> Hi Nick,
>
> >         >  src/sdpd-service.c |    2 ++
> >         >  1 files changed, 2 insertions(+), 0 deletions(-)
> >         >
> >         > diff --git a/src/sdpd-service.c b/src/sdpd-service.c
> >         > index cf120b8..df9017e 100644
> >         > --- a/src/sdpd-service.c
> >         > +++ b/src/sdpd-service.c
> >         > @@ -125,6 +125,8 @@ static void update_svclass_list(void)
> >         >               case INTERCOM_SVCLASS_ID:
> >         >               case FAX_SVCLASS_ID:
> >         >               case SAP_SVCLASS_ID:
> >         > +             case HEADSET_AGW_SVCLASS_ID:
> >         > +             case HANDSFREE_AGW_SVCLASS_ID:
> >         >                       val |= 0x40;    /* Telephony */
> >         >                       break;
> >         >               case AUDIO_SOURCE_SVCLASS_ID:
> >
> >
> >         do you have a reference to a spec. for this one. The automatic
> >         service
> >         class adjustment has been done according to the spec.
> >
> > I didn't even know there existed a spec for these service classes. I
> > thought they were rather arbitrary. But it certainly makes sense that
> > if offer headset or handsfree audio gateway you are a telephone.
>
> you wish, but it doesn't work this way. Every profile spec. clearly
> states which service classes have to enabled for every role. Like it
> clearly shows how the SDP record has to look.
>
> I spent quite some time getting this done so no developer has to worry
> about service classes anymore. So I really need the reference from the
> headset and hansfree specs. before I touch this.
>
>
So I looked at the headset and handsfree spec, they do not require that AG's
set the telephony bit. sigh.

But I can tell you for a fact that the Nokia 616 carkit will not pair unless
you set the telephony bit. That is what triggered this patch.

We have yet to find a device (and we have tested hundreds now) that is not
compatible because of the telephony bit. It is a safe change to make.

So sure, you can reject the patch on the basis that it is not mandated by
the specification. But if you care about compatibility then it seems like a
good change to make. Especially since you now ignore the service class in
hcid.conf so there is no easy way to override.

Nick

------=_Part_39682_32453615.1220081873482
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr"><br><br><div class="gmail_quote">On Sat, Aug 30, 2008 at 2:28 AM, Marcel Holtmann <span dir="ltr">&lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt;</span> wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d">Hi Nick,<br>
<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; &nbsp;src/sdpd-service.c | &nbsp; &nbsp;2 ++<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; &nbsp;1 files changed, 2 insertions(+), 0 deletions(-)<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; diff --git a/src/sdpd-service.c b/src/sdpd-service.c<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; index cf120b8..df9017e 100644<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; --- a/src/sdpd-service.c<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; +++ b/src/sdpd-service.c<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; @@ -125,6 +125,8 @@ static void update_svclass_list(void)<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; case INTERCOM_SVCLASS_ID:<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; case FAX_SVCLASS_ID:<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; case SAP_SVCLASS_ID:<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; case HEADSET_AGW_SVCLASS_ID:<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; case HANDSFREE_AGW_SVCLASS_ID:<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; val |= 0x40; &nbsp; &nbsp;/* Telephony */<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; break;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; case AUDIO_SOURCE_SVCLASS_ID:<br>
&gt;<br>
&gt;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; do you have a reference to a spec. for this one. The automatic<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; service<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; class adjustment has been done according to the spec.<br>
&gt;<br>
&gt; I didn&#39;t even know there existed a spec for these service classes. I<br>
&gt; thought they were rather arbitrary. But it certainly makes sense that<br>
&gt; if offer headset or handsfree audio gateway you are a telephone.<br>
<br>
</div>you wish, but it doesn&#39;t work this way. Every profile spec. clearly<br>
states which service classes have to enabled for every role. Like it<br>
clearly shows how the SDP record has to look.<br>
<br>
I spent quite some time getting this done so no developer has to worry<br>
about service classes anymore. So I really need the reference from the<br>
headset and hansfree specs. before I touch this.<br>
<div><div></div><div class="Wj3C7c"><br></div></div></blockquote><div><br>So I looked at the headset and handsfree spec, they do not require that AG&#39;s set the telephony bit. sigh.<br><br>But I can tell you for a fact that the Nokia 616 carkit will not pair unless you set the telephony bit. That is what triggered this patch.<br>
<br>We have yet to find a device (and we have tested hundreds now) that is not compatible because of the telephony bit. It is a safe change to make.<br><br>So sure, you can reject the patch on the basis that it is not mandated by the specification. But if you care about compatibility then it seems like a good change to make. Especially since you now ignore the service class in hcid.conf so there is no easy way to override.<br>
<br>Nick<br><br><br><br></div></div></div>

------=_Part_39682_32453615.1220081873482--


--===============1781657097==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============1781657097==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1781657097==--
