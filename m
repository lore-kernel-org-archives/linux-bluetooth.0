Return-Path: <cyrus@holtmann.org>
Message-ID: <35c90d960808300016t1ea8b8eq638a399e7d04b1e9@mail.gmail.com>
Date: Sat, 30 Aug 2008 00:16:07 -0700
From: "Nick Pelly" <npelly@google.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1220086722.7145.33.camel@californication>
MIME-Version: 1.0
References: <1220050803-30362-1-git-send-email-npelly@google.com>
	<1220086722.7145.33.camel@californication>
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
Content-Type: multipart/mixed; boundary="===============0065486289=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0065486289==
Content-Type: multipart/alternative;
	boundary="----=_Part_39414_2959842.1220080567538"

------=_Part_39414_2959842.1220080567538
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sat, Aug 30, 2008 at 1:58 AM, Marcel Holtmann <marcel@holtmann.org>wrote:

> Hi Nick,
>
> >  src/sdpd-service.c |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> >
> > diff --git a/src/sdpd-service.c b/src/sdpd-service.c
> > index cf120b8..df9017e 100644
> > --- a/src/sdpd-service.c
> > +++ b/src/sdpd-service.c
> > @@ -125,6 +125,8 @@ static void update_svclass_list(void)
> >               case INTERCOM_SVCLASS_ID:
> >               case FAX_SVCLASS_ID:
> >               case SAP_SVCLASS_ID:
> > +             case HEADSET_AGW_SVCLASS_ID:
> > +             case HANDSFREE_AGW_SVCLASS_ID:
> >                       val |= 0x40;    /* Telephony */
> >                       break;
> >               case AUDIO_SOURCE_SVCLASS_ID:
>
> do you have a reference to a spec. for this one. The automatic service
> class adjustment has been done according to the spec.


I didn't even know there existed a spec for these service classes. I thought
they were rather arbitrary. But it certainly makes sense that if offer
headset or handsfree audio gateway you are a telephone.


I could have
> missed one or two, but I am quite sure I didn't. So while it looks okay,
> we have to make sure that we didn't violate the specs.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> This SF.Net email is sponsored by the Moblin Your Move Developer's
> challenge
> Build the coolest Linux based applications with Moblin SDK & win great
> prizes
> Grand prize is a trip for two to an Open Source event anywhere in the world
> http://moblin-contest.org/redirect.php?banner_id=100&url=/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_39414_2959842.1220080567538
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr"><br><br><div class="gmail_quote">On Sat, Aug 30, 2008 at 1:58 AM, Marcel Holtmann <span dir="ltr">&lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt;</span> wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Nick,<br>
<div><div></div><div class="Wj3C7c"><br>
&gt; &nbsp;src/sdpd-service.c | &nbsp; &nbsp;2 ++<br>
&gt; &nbsp;1 files changed, 2 insertions(+), 0 deletions(-)<br>
&gt;<br>
&gt; diff --git a/src/sdpd-service.c b/src/sdpd-service.c<br>
&gt; index cf120b8..df9017e 100644<br>
&gt; --- a/src/sdpd-service.c<br>
&gt; +++ b/src/sdpd-service.c<br>
&gt; @@ -125,6 +125,8 @@ static void update_svclass_list(void)<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; case INTERCOM_SVCLASS_ID:<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; case FAX_SVCLASS_ID:<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; case SAP_SVCLASS_ID:<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; case HEADSET_AGW_SVCLASS_ID:<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; case HANDSFREE_AGW_SVCLASS_ID:<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; val |= 0x40; &nbsp; &nbsp;/* Telephony */<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; break;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; case AUDIO_SOURCE_SVCLASS_ID:<br>
<br>
</div></div>do you have a reference to a spec. for this one. The automatic service<br>
class adjustment has been done according to the spec.</blockquote><div><br>I didn&#39;t even know there existed a spec for these service classes. I thought they were rather arbitrary. But it certainly makes sense that if offer headset or handsfree audio gateway you are a telephone.<br>
<br><br></div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"> I could have<br>
missed one or two, but I am quite sure I didn&#39;t. So while it looks okay,<br>
we have to make sure that we didn&#39;t violate the specs.<br>
<br>
Regards<br>
<br>
Marcel<br>
<br>
<br>
<br>
-------------------------------------------------------------------------<br>
This SF.Net email is sponsored by the Moblin Your Move Developer&#39;s challenge<br>
Build the coolest Linux based applications with Moblin SDK &amp; win great prizes<br>
Grand prize is a trip for two to an Open Source event anywhere in the world<br>
<a href="http://moblin-contest.org/redirect.php?banner_id=100&amp;url=/" target="_blank">http://moblin-contest.org/redirect.php?banner_id=100&amp;url=/</a><br>
_______________________________________________<br>
Bluez-devel mailing list<br>
<a href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a><br>
<a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel" target="_blank">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br>
</blockquote></div><br></div>

------=_Part_39414_2959842.1220080567538--


--===============0065486289==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============0065486289==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0065486289==--
