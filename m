Return-Path: <SRS0=UcDi=S3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C003C10F03
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Apr 2019 08:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE350217D7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Apr 2019 08:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="us9vRrlY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbfDYIAW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:00:22 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41104 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbfDYIAW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Apr 2019 04:00:22 -0400
Received: by mail-ot1-f66.google.com with SMTP id g8so4657868otk.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Apr 2019 01:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mF3xaO74VhX4XyzAXuNHB000X4Ka8Teh3SvThqR7zk4=;
        b=us9vRrlYJw4167SRLx09xMVWOLiRt0wFL9fPEZGzjLZYql7lIWl8bfa+KxMWzRjxYW
         2Cd2VQ9zmT2ZByD5o09+Do7lCd2zhJC9DO2SM02XHaWc8p5lWaPu1CSeld7xTzRULiNO
         roFp7ZsuxfwbmTGw7qiWFtTA1AL/trFRjm2j9FPdE49mRL8SpC8xB8HsvsX3GlBKqHfl
         V42r4tEvzLuJZwgPOWgew7PMaYzPZXKJn49UtCbjm52jKz60Z1tkJJsR0uP+mJojSV9x
         5mCLMW3SMDurK5/YwZY/ihkehCAwOgJtYbRQ3XK8YRMXePzQ6x+NP19IM8ikEC3yWIaI
         Bebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mF3xaO74VhX4XyzAXuNHB000X4Ka8Teh3SvThqR7zk4=;
        b=lYlhHYBKIYbvbGkw9T2i/mMdLYwg92yXHd29MybDn98TKfSm7nONgM715v1e514FNc
         9c8/6Ze55dA1bEowgBHyvYtdZX7IF51PBIBCEMbwwH7MbGGC15e5szdKNvV8Fd0KQYM/
         APxlSbGpGMthPyUgEkiIaX6GYqvSJpEZRLB1M6MTb2x0FmPfTj1JV2vTi3Uskhlcr7r8
         xZOMCDAYJf6+zMNgRz7GLKKqBysGgTo6Oq24uQGvxzEn7OjLh83wcJhj7F3VRRP6Yu6/
         igTYH88erF42LdeHmmee9VDn3+ekS7ONMXBz52jhuM6tSKkmWX0r1va7++GusulQA1Cg
         kyIw==
X-Gm-Message-State: APjAAAWuiROE27WDYgjL+hNKqoifR37bjyo/8uJJr9ltJDhqceEllzPW
        cHjuSeux7dDlp8+3YaqDlHFsoGqnJjBdc+OPLQDxVoff
X-Google-Smtp-Source: APXvYqxQZJYu0xiY1x8lFM/txgF+jteuIABVPMOhTkQ5bQERLc5sujy7jFLky9qHLs12GoERp1TmvJyE6Cwv3WgKMis=
X-Received: by 2002:a9d:53cc:: with SMTP id i12mr1749909oth.242.1556179221020;
 Thu, 25 Apr 2019 01:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190424083921.15679-1-luiz.dentz@gmail.com> <CABBYNZLcpo_Dx3X9pmKGeqSNFDLKZAqd==6wL5qcthGiqg-EeA@mail.gmail.com>
 <20190424165721.fs7ylixjscqjmqmb@pali>
In-Reply-To: <20190424165721.fs7ylixjscqjmqmb@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 25 Apr 2019 11:00:07 +0300
Message-ID: <CABBYNZL=8sigG=Sg-0ZdJSCd6KvW1OEAzS0uxTDcFD_fiRUmLw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] a2dp: Store last used endpoint
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Wed, Apr 24, 2019 at 7:57 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrot=
e:
>
> On Wednesday 24 April 2019 12:42:22 Luiz Augusto von Dentz wrote:
> > Hi Pali,
> >
> > On Wed, Apr 24, 2019 at 11:39 AM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > >
> > > This stores the last used endpoint whenever it is considered open and
> > > then prefer to use it when attempting to reconnect.
> > > ---
> > >  profiles/audio/a2dp.c | 104 ++++++++++++++++++++++++++++++++++++----=
--
> > >  1 file changed, 91 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> > > index 8f141739c..78b02dc84 100644
> > > --- a/profiles/audio/a2dp.c
> > > +++ b/profiles/audio/a2dp.c
> > > @@ -147,6 +147,7 @@ struct a2dp_channel {
> > >         unsigned int auth_id;
> > >         struct avdtp *session;
> > >         struct queue *seps;
> > > +       struct a2dp_remote_sep *last_used;
> > >  };
> > >
> > >  static GSList *servers =3D NULL;
> > > @@ -860,6 +861,60 @@ static gboolean open_ind(struct avdtp *session, =
struct avdtp_local_sep *sep,
> > >         return TRUE;
> > >  }
> > >
> > > +static bool match_remote_sep(const void *data, const void *user_data=
)
> > > +{
> > > +       const struct a2dp_remote_sep *sep =3D data;
> > > +       const struct avdtp_remote_sep *rsep =3D user_data;
> > > +
> > > +       return sep->sep =3D=3D rsep;
> > > +}
> > > +
> > > +static void store_last_used(struct a2dp_channel *chan,
> > > +                                       struct avdtp_remote_sep *rsep=
)
> > > +{
> > > +       GKeyFile *key_file;
> > > +       char filename[PATH_MAX];
> > > +       char dst_addr[18];
> > > +       char value[4];
> > > +       char *data;
> > > +       size_t len =3D 0;
> > > +
> > > +       ba2str(device_get_address(chan->device), dst_addr);
> > > +
> > > +       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s",
> > > +               btd_adapter_get_storage_dir(device_get_adapter(chan->=
device)),
> > > +               dst_addr);
> > > +       key_file =3D g_key_file_new();
> > > +       g_key_file_load_from_file(key_file, filename, 0, NULL);
> > > +
> > > +       sprintf(value, "%02hhx", avdtp_get_seid(rsep));
> > > +
> > > +       g_key_file_set_string(key_file, "Endpoints", "LastUsed", valu=
e);
> > > +
> > > +       data =3D g_key_file_to_data(key_file, &len, NULL);
> > > +       g_file_set_contents(filename, data, len, NULL);
> > > +
> > > +       g_free(data);
> > > +       g_key_file_free(key_file);
> > > +}
> > > +
> > > +static void update_last_used(struct a2dp_channel *chan,
> > > +                                               struct avdtp_stream *=
stream)
> > > +{
> > > +       struct avdtp_remote_sep *rsep;
> > > +       struct a2dp_remote_sep *sep;
> > > +
> > > +       rsep =3D avdtp_stream_get_remote_sep(stream);
> > > +
> > > +       /* Update last used */
> > > +       sep =3D queue_find(chan->seps, match_remote_sep, rsep);
> > > +       if (chan->last_used =3D=3D sep)
> > > +               return;
> > > +
> > > +       chan->last_used =3D sep;
> > > +       store_last_used(chan, rsep);
> > > +}
> > > +
> > >  static void open_cfm(struct avdtp *session, struct avdtp_local_sep *=
sep,
> > >                         struct avdtp_stream *stream, struct avdtp_err=
or *err,
> > >                         void *user_data)
> > > @@ -884,7 +939,8 @@ static void open_cfm(struct avdtp *session, struc=
t avdtp_local_sep *sep,
> > >                 setup->err =3D err;
> > >                 if (setup->start)
> > >                         finalize_resume(setup);
> > > -       }
> > > +       } else if (setup->chan)
> > > +               update_last_used(setup->chan, stream);
> > >
> > >         finalize_config(setup);
> > >
> > > @@ -1077,14 +1133,6 @@ static gboolean close_ind(struct avdtp *sessio=
n, struct avdtp_local_sep *sep,
> > >         return TRUE;
> > >  }
> > >
> > > -static bool match_remote_sep(const void *data, const void *user_data=
)
> > > -{
> > > -       const struct a2dp_remote_sep *sep =3D data;
> > > -       const struct avdtp_remote_sep *rsep =3D user_data;
> > > -
> > > -       return sep->sep =3D=3D rsep;
> > > -}
> > > -
> > >  static struct a2dp_remote_sep *find_remote_sep(struct a2dp_channel *=
chan,
> > >                                                 struct a2dp_sep *sep)
> > >  {
> > > @@ -1791,19 +1839,28 @@ done:
> > >         queue_push_tail(chan->seps, sep);
> > >  }
> > >
> > > +static bool match_seid(const void *data, const void *user_data)
> > > +{
> > > +       const struct a2dp_remote_sep *sep =3D data;
> > > +       const uint8_t *seid =3D user_data;
> > > +
> > > +       return avdtp_get_seid(sep->sep) =3D=3D *seid;
> > > +}
> > > +
> > >  static void load_remote_sep(struct a2dp_channel *chan, GKeyFile *key=
_file,
> > >                                                                 char =
**seids)
> > >  {
> > >         struct avdtp_remote_sep *sep;
> > > +       uint8_t seid;
> > > +       char *value;
> > >
> > >         if (!seids)
> > >                 return;
> > >
> > >         for (; *seids; seids++) {
> > > -               uint8_t seid;
> > >                 uint8_t type;
> > >                 uint8_t codec;
> > > -               char *value, caps[256];
> > > +               char caps[256];
> > >                 uint8_t data[128];
> > >                 int i, size;
> > >                 GSList *l =3D NULL;
> > > @@ -1847,6 +1904,15 @@ static void load_remote_sep(struct a2dp_channe=
l *chan, GKeyFile *key_file,
> > >
> > >                 register_remote_sep(sep, chan);
> > >         }
> > > +
> > > +       value =3D g_key_file_get_string(key_file, "Endpoints", "LastU=
sed", NULL);
> > > +       if (!value)
> > > +               return;
> > > +
> > > +       if (sscanf(value, "%02hhx", &seid) !=3D 1)
> > > +               return;
> > > +
> > > +       chan->last_used =3D queue_find(chan->seps, match_seid, &seid)=
;
> > >  }
> > >
> > >  static void load_remote_seps(struct a2dp_channel *chan)
> > > @@ -2355,8 +2421,12 @@ done:
> > >  static struct a2dp_sep *a2dp_find_sep(struct avdtp *session, GSList =
*list,
> > >                                         const char *sender)
> > >  {
> > > +       struct a2dp_sep *first =3D NULL;
> > > +       struct a2dp_channel *chan =3D find_channel(session);
> > > +
> > >         for (; list; list =3D list->next) {
> > >                 struct a2dp_sep *sep =3D list->data;
> > > +               struct avdtp_remote_sep *rsep;
> > >
> > >                 /* Use sender's endpoint if available */
> > >                 if (sender) {
> > > @@ -2370,14 +2440,22 @@ static struct a2dp_sep *a2dp_find_sep(struct =
avdtp *session, GSList *list,
> > >                                 continue;
> > >                 }
> > >
> > > -               if (avdtp_find_remote_sep(session, sep->lsep) =3D=3D =
NULL)
> > > +               rsep =3D avdtp_find_remote_sep(session, sep->lsep);
> > > +               if (!rsep)
> > >                         continue;
> > >
> > > +               /* Locate last used if set */
> > > +               if (chan->last_used) {
> > > +                       if (chan->last_used->sep =3D=3D rsep)
> > > +                               return sep;
> > > +                       first =3D sep;
> > > +               }
> > > +
> > >                 return sep;
> > >
> > >         }
> > >
> > > -       return NULL;
> > > +       return first;
> > >  }
> > >
> > >  static struct a2dp_sep *a2dp_select_sep(struct avdtp *session, uint8=
_t type,
> > > --
> > > 2.20.1
> >
> > Can you give this a try, it should make the daemon remember what was
> > the last endpoint used (locally the remote selection we cannot really
> > control).
>
> Great, I will try it. Remote selection is done by remote device so this
> really cannot be controlled.
>
> I have there another suggestion for improvement. bluez support
> registering more endpoints for one codec. I'm going to use it for
> registering one SBC endpoint with fixed bitpool as UHQ profile and
> another with lower bitpool values. To distinguish in pulseaudio between
> low and high quality of SBC. Seems that bluez sometimes try to only
> select only one endpoint, even there are more and do not try another if
> first one selection fails (e.g. because remote capability of bitpool is
> too low and our local selection needs higher). Could be bluez modified
> to try another local endpoint if there are more registered until some
> accept capabilities?

Well that was actually one of the reason Ive recommended not
registering more than one endpoint for the same codec, we should
perhaps fix that since those endpoints can belong to different
processes but if we do insist to have PA with multiple SBC endpoints
that means it would not be backward compatible since it may try to
configure with UHQ as it should be higher priority, besides having a
higher fixed range means we can no longer reduce the quality at
runtime, but perhaps there is a way to make it work if PA detects it
has multiple endpoints that could be used it could just switch to
normal quality if UHQ cannot be used, this is actually beneficial in
terms of latency as well since we don't have extra D-Bus round trips
asking different endpoints.


--=20
Luiz Augusto von Dentz
