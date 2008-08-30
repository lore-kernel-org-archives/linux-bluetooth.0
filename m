Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <35c90d960808300016t1ea8b8eq638a399e7d04b1e9@mail.gmail.com>
References: <1220050803-30362-1-git-send-email-npelly@google.com>
	<1220086722.7145.33.camel@californication>
	<35c90d960808300016t1ea8b8eq638a399e7d04b1e9@mail.gmail.com>
Date: Sat, 30 Aug 2008 11:28:41 +0200
Message-Id: <1220088521.7145.51.camel@californication>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] Advertise Telephony service class
	when	device offers headset AG or handsfree AG
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Nick,

>         >  src/sdpd-service.c |    2 ++
>         >  1 files changed, 2 insertions(+), 0 deletions(-)
>         >
>         > diff --git a/src/sdpd-service.c b/src/sdpd-service.c
>         > index cf120b8..df9017e 100644
>         > --- a/src/sdpd-service.c
>         > +++ b/src/sdpd-service.c
>         > @@ -125,6 +125,8 @@ static void update_svclass_list(void)
>         >               case INTERCOM_SVCLASS_ID:
>         >               case FAX_SVCLASS_ID:
>         >               case SAP_SVCLASS_ID:
>         > +             case HEADSET_AGW_SVCLASS_ID:
>         > +             case HANDSFREE_AGW_SVCLASS_ID:
>         >                       val |= 0x40;    /* Telephony */
>         >                       break;
>         >               case AUDIO_SOURCE_SVCLASS_ID:
>         
>         
>         do you have a reference to a spec. for this one. The automatic
>         service
>         class adjustment has been done according to the spec.
> 
> I didn't even know there existed a spec for these service classes. I
> thought they were rather arbitrary. But it certainly makes sense that
> if offer headset or handsfree audio gateway you are a telephone.

you wish, but it doesn't work this way. Every profile spec. clearly
states which service classes have to enabled for every role. Like it
clearly shows how the SDP record has to look.

I spent quite some time getting this done so no developer has to worry
about service classes anymore. So I really need the reference from the
headset and hansfree specs. before I touch this.

Regards

Marcel



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
