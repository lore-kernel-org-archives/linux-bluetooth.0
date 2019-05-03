Return-Path: <SRS0=8q+o=TD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F449C43219
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 May 2019 10:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 353872075E
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 May 2019 10:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BoxC7tcq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfECKSZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 May 2019 06:18:25 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43898 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfECKSZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 May 2019 06:18:25 -0400
Received: by mail-oi1-f196.google.com with SMTP id j9so3263702oie.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 May 2019 03:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mJu2NKePuEBxR7ebkujBS5HK/cSfC9mht0DG+01IClw=;
        b=BoxC7tcqi5qIuiiILy5ej4QCEw6EjOxPRBGPztUz68z6m+kMChPusKhu25CLjQDamS
         5lOxcPqG+HcyrCVOxGOMIPU6Mmv2kV3S/I1/BhNf9mDBVIHZL/HrTCP3OCwiMYnqLGZY
         2/4yKNqAfnuJDbh0Gpxy/XcOXNjKUTwxFJLZqom951+m/Mkp9WBupmPFiy9LgPMGuLZD
         CWFoZASmRgZFZifqD70shRmF9jrwPyWeNf2LbbbySvh+AoyMv5feXAV07r3eomPfWItV
         hMCO6h8oyL1rzNOAciTuOIwxOd+1OCp+MSHq1Mr8LUmtCgskaoUoimWRdJgogT4SKR/t
         Wj9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mJu2NKePuEBxR7ebkujBS5HK/cSfC9mht0DG+01IClw=;
        b=Lr4Dvz0CDGfdG5kPKZmDbXvRzBbX/rL+HHU6zuz/X5x1nD0gjwqzFibZGKDKgsJPqT
         OJ7YURrV1LZ3ZGq3cKv00NcS/b0gWSp1FH1wZ1JgY9PUWnWLhrxm8b26aLEBSuL2402q
         BTgx+Xu1Q+Qytny9oAZBHRQQQ+WQ+C6J92iLr+7MY9O/K9BbniM1VwF+tSLp4yklBOYi
         bRtvoDYCcSjO8I4PR23mZcG5BlZrPGUhB+4EzTBERIhb290UHLayxKzG5pfBXEe/LzTy
         jO8Fsqm02mZzzZwmezAPpD/bhKoU3csJu1cf8ycSMg6oHfrQposcVYvqaf9Mn/DBd8bJ
         S4jg==
X-Gm-Message-State: APjAAAViD+cXRCmblKpwafKZUDv1+4fNWUtDoO61kBkEIBVu2YEqOtjc
        qCzUPyBS8AVn5EyfHegUu2V/ZjGUCFoFEq9bF3A=
X-Google-Smtp-Source: APXvYqx3wMWVlQzaMXcMGyRI442RqlSQZwkChr22y/xVQtwFVuPV2ap9hDmimL+j/kblKDXXzFhwvZnVStkWj1XB3TQ=
X-Received: by 2002:aca:ab91:: with SMTP id u139mr5407067oie.21.1556878704220;
 Fri, 03 May 2019 03:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190424083921.15679-1-luiz.dentz@gmail.com> <CABBYNZLcpo_Dx3X9pmKGeqSNFDLKZAqd==6wL5qcthGiqg-EeA@mail.gmail.com>
 <20190424165721.fs7ylixjscqjmqmb@pali> <20190503100705.dsb6svexse3mhldd@pali>
In-Reply-To: <20190503100705.dsb6svexse3mhldd@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 3 May 2019 13:18:10 +0300
Message-ID: <CABBYNZLXektdnPLxq9uCNKGoS417jwi5C2q4eV0TecP1+naOfA@mail.gmail.com>
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

On Fri, May 3, 2019 at 1:07 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrote=
:
>
> On Wednesday 24 April 2019 18:57:21 Pali Roh=C3=A1r wrote:
> > On Wednesday 24 April 2019 12:42:22 Luiz Augusto von Dentz wrote:
> > > Hi Pali,
> > >
> > > On Wed, Apr 24, 2019 at 11:39 AM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > >
> > > > This stores the last used endpoint whenever it is considered open a=
nd
> > > > then prefer to use it when attempting to reconnect.
> > > > ---
> > > >  profiles/audio/a2dp.c | 104 ++++++++++++++++++++++++++++++++++++--=
----
> > > >  1 file changed, 91 insertions(+), 13 deletions(-)
> > > >
> > > > diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> > > > index 8f141739c..78b02dc84 100644
> > > > --- a/profiles/audio/a2dp.c
> > > > +++ b/profiles/audio/a2dp.c
> > > > @@ -147,6 +147,7 @@ struct a2dp_channel {
> > > >         unsigned int auth_id;
> > > >         struct avdtp *session;
> > > >         struct queue *seps;
> > > > +       struct a2dp_remote_sep *last_used;
> > > >  };
> > > >
> > > >  static GSList *servers =3D NULL;
> > > > @@ -860,6 +861,60 @@ static gboolean open_ind(struct avdtp *session=
, struct avdtp_local_sep *sep,
> > > >         return TRUE;
> > > >  }
> > > >
> > > > +static bool match_remote_sep(const void *data, const void *user_da=
ta)
> > > > +{
> > > > +       const struct a2dp_remote_sep *sep =3D data;
> > > > +       const struct avdtp_remote_sep *rsep =3D user_data;
> > > > +
> > > > +       return sep->sep =3D=3D rsep;
> > > > +}
> > > > +
> > > > +static void store_last_used(struct a2dp_channel *chan,
> > > > +                                       struct avdtp_remote_sep *rs=
ep)
> > > > +{
> > > > +       GKeyFile *key_file;
> > > > +       char filename[PATH_MAX];
> > > > +       char dst_addr[18];
> > > > +       char value[4];
> > > > +       char *data;
> > > > +       size_t len =3D 0;
> > > > +
> > > > +       ba2str(device_get_address(chan->device), dst_addr);
> > > > +
> > > > +       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s",
> > > > +               btd_adapter_get_storage_dir(device_get_adapter(chan=
->device)),
> > > > +               dst_addr);
> > > > +       key_file =3D g_key_file_new();
> > > > +       g_key_file_load_from_file(key_file, filename, 0, NULL);
> > > > +
> > > > +       sprintf(value, "%02hhx", avdtp_get_seid(rsep));
> > > > +
> > > > +       g_key_file_set_string(key_file, "Endpoints", "LastUsed", va=
lue);
> > > > +
> > > > +       data =3D g_key_file_to_data(key_file, &len, NULL);
> > > > +       g_file_set_contents(filename, data, len, NULL);
> > > > +
> > > > +       g_free(data);
> > > > +       g_key_file_free(key_file);
> > > > +}
> > > > +
> > > > +static void update_last_used(struct a2dp_channel *chan,
> > > > +                                               struct avdtp_stream=
 *stream)
> > > > +{
> > > > +       struct avdtp_remote_sep *rsep;
> > > > +       struct a2dp_remote_sep *sep;
> > > > +
> > > > +       rsep =3D avdtp_stream_get_remote_sep(stream);
> > > > +
> > > > +       /* Update last used */
> > > > +       sep =3D queue_find(chan->seps, match_remote_sep, rsep);
> > > > +       if (chan->last_used =3D=3D sep)
> > > > +               return;
> > > > +
> > > > +       chan->last_used =3D sep;
> > > > +       store_last_used(chan, rsep);
> > > > +}
> > > > +
> > > >  static void open_cfm(struct avdtp *session, struct avdtp_local_sep=
 *sep,
> > > >                         struct avdtp_stream *stream, struct avdtp_e=
rror *err,
> > > >                         void *user_data)
> > > > @@ -884,7 +939,8 @@ static void open_cfm(struct avdtp *session, str=
uct avdtp_local_sep *sep,
> > > >                 setup->err =3D err;
> > > >                 if (setup->start)
> > > >                         finalize_resume(setup);
> > > > -       }
> > > > +       } else if (setup->chan)
> > > > +               update_last_used(setup->chan, stream);
> > > >
> > > >         finalize_config(setup);
> > > >
> > > > @@ -1077,14 +1133,6 @@ static gboolean close_ind(struct avdtp *sess=
ion, struct avdtp_local_sep *sep,
> > > >         return TRUE;
> > > >  }
> > > >
> > > > -static bool match_remote_sep(const void *data, const void *user_da=
ta)
> > > > -{
> > > > -       const struct a2dp_remote_sep *sep =3D data;
> > > > -       const struct avdtp_remote_sep *rsep =3D user_data;
> > > > -
> > > > -       return sep->sep =3D=3D rsep;
> > > > -}
> > > > -
> > > >  static struct a2dp_remote_sep *find_remote_sep(struct a2dp_channel=
 *chan,
> > > >                                                 struct a2dp_sep *se=
p)
> > > >  {
> > > > @@ -1791,19 +1839,28 @@ done:
> > > >         queue_push_tail(chan->seps, sep);
> > > >  }
> > > >
> > > > +static bool match_seid(const void *data, const void *user_data)
> > > > +{
> > > > +       const struct a2dp_remote_sep *sep =3D data;
> > > > +       const uint8_t *seid =3D user_data;
> > > > +
> > > > +       return avdtp_get_seid(sep->sep) =3D=3D *seid;
> > > > +}
> > > > +
> > > >  static void load_remote_sep(struct a2dp_channel *chan, GKeyFile *k=
ey_file,
> > > >                                                                 cha=
r **seids)
> > > >  {
> > > >         struct avdtp_remote_sep *sep;
> > > > +       uint8_t seid;
> > > > +       char *value;
> > > >
> > > >         if (!seids)
> > > >                 return;
> > > >
> > > >         for (; *seids; seids++) {
> > > > -               uint8_t seid;
> > > >                 uint8_t type;
> > > >                 uint8_t codec;
> > > > -               char *value, caps[256];
> > > > +               char caps[256];
> > > >                 uint8_t data[128];
> > > >                 int i, size;
> > > >                 GSList *l =3D NULL;
> > > > @@ -1847,6 +1904,15 @@ static void load_remote_sep(struct a2dp_chan=
nel *chan, GKeyFile *key_file,
> > > >
> > > >                 register_remote_sep(sep, chan);
> > > >         }
> > > > +
> > > > +       value =3D g_key_file_get_string(key_file, "Endpoints", "Las=
tUsed", NULL);
> > > > +       if (!value)
> > > > +               return;
> > > > +
> > > > +       if (sscanf(value, "%02hhx", &seid) !=3D 1)
> > > > +               return;
> > > > +
> > > > +       chan->last_used =3D queue_find(chan->seps, match_seid, &sei=
d);
> > > >  }
> > > >
> > > >  static void load_remote_seps(struct a2dp_channel *chan)
> > > > @@ -2355,8 +2421,12 @@ done:
> > > >  static struct a2dp_sep *a2dp_find_sep(struct avdtp *session, GSLis=
t *list,
> > > >                                         const char *sender)
> > > >  {
> > > > +       struct a2dp_sep *first =3D NULL;
> > > > +       struct a2dp_channel *chan =3D find_channel(session);
> > > > +
> > > >         for (; list; list =3D list->next) {
> > > >                 struct a2dp_sep *sep =3D list->data;
> > > > +               struct avdtp_remote_sep *rsep;
> > > >
> > > >                 /* Use sender's endpoint if available */
> > > >                 if (sender) {
> > > > @@ -2370,14 +2440,22 @@ static struct a2dp_sep *a2dp_find_sep(struc=
t avdtp *session, GSList *list,
> > > >                                 continue;
> > > >                 }
> > > >
> > > > -               if (avdtp_find_remote_sep(session, sep->lsep) =3D=
=3D NULL)
> > > > +               rsep =3D avdtp_find_remote_sep(session, sep->lsep);
> > > > +               if (!rsep)
> > > >                         continue;
> > > >
> > > > +               /* Locate last used if set */
> > > > +               if (chan->last_used) {
> > > > +                       if (chan->last_used->sep =3D=3D rsep)
> > > > +                               return sep;
> > > > +                       first =3D sep;
> > > > +               }
> > > > +
> > > >                 return sep;
> > > >
> > > >         }
> > > >
> > > > -       return NULL;
> > > > +       return first;
> > > >  }
> > > >
> > > >  static struct a2dp_sep *a2dp_select_sep(struct avdtp *session, uin=
t8_t type,
> > > > --
> > > > 2.20.1
> > >
> > > Can you give this a try, it should make the daemon remember what was
> > > the last endpoint used (locally the remote selection we cannot really
> > > control).
> >
> > Great, I will try it.
>
> Now I run 'sudo grep LastUsed -r /var/lib/bluetooth/' and see that this
> properly is stored only for one device. So seems that bluetoothd does
> not always stores LastUsed information.
>
> E.g. when I called and successfully connected device via command
>
> $ qdbus --system org.bluez /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX org.blue=
z.Device1.ConnectProfile 0000110a-0000-1000-8000-00805f9b34fb
>
> and later disconnected, I have not found anything via above grep.

Is this with the latest set? Were there any failures in the configuration?

(note that you need su/root to list /var/lib/bluetooth/)
/var/lib/bluetooth/B8:8A:60:D8:17:D7/cache/08:DF:1F:D9:2A:93:43:LastUsed=3D=
01
/var/lib/bluetooth/B8:8A:60:D8:17:D7/cache/B4:CD:27:F0:8D:0A:60:LastUsed=3D=
04
/var/lib/bluetooth/B8:8A:60:D8:17:D7/cache/94:20:53:2E:08:CE:24:LastUsed=3D=
05

--=20
Luiz Augusto von Dentz
