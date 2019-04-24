Return-Path: <SRS0=Tr5+=S2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71611C282CE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Apr 2019 16:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3375C206A3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Apr 2019 16:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/8PWvoo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733032AbfDXQ50 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:57:26 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52618 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732995AbfDXQ50 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Apr 2019 12:57:26 -0400
Received: by mail-wm1-f68.google.com with SMTP id j13so5590672wmh.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2019 09:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F9w8XnJJ3fTHudMNbjMEoAgkMo5TBNjK5jYx9yS8D7c=;
        b=J/8PWvooqGhRxDrY6UaIEesvjw4LKC6x8OhJoqoDPIt5aOf/VIM39D2/2C0vlb2zEV
         9CHfJXBA/SoKAFYo6T+EGtvK/BXhr8ChZJoXdxh8AoSIfIcLQic0L21TBc92HcFNZhlk
         tNA7KDbJDpnvOa/Nsn0ajB3TuccClG5qc8lPs5Lhbm0ucvIb6vIEpzVA3P0YyIHVGmCp
         roOJDMx5XGG9CsWE/tXX2ytizeateVFWpZDcqI1gOvLei2VkDSqo0ozKDIeABtJUUPeo
         +z5bNcdSIkHsvpfZfByJIgSkUBA773Ws+6zrGLHzUJeaNY/wm4Dl9pz/m0GM/6eGvU4Q
         EFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F9w8XnJJ3fTHudMNbjMEoAgkMo5TBNjK5jYx9yS8D7c=;
        b=D47AiRqzkSfMsFLEqwTnEVK3DIJe27OtthWGWH5Z74+qAiqDhSKwCKQbp5ddhTBb3+
         tc/aQGH3WUlHOrYtPvRkIXumA5jnWyJ3SucL5dQkf/kquMvGCQSe8ySMBVvwxGqVw3Wc
         P5ajoXhhgFm7/LBAWxnA+A+kFo7cVb8Zl7Y3+lDIyat1iX6qHYZIw+jUI1XbxadJ9hwR
         EhHzxBLqHOQMcJebsdHCgCpNmmMwK77edjEZbaKat/TMiODdelu0HwOXUEXQmfyosD+K
         ylVJ3+14iPej13IBXiUYOuw03cfuIdPL3BRXIghoRvOi5DiUmM5NwwnMQp06uFsmTGRM
         w6zA==
X-Gm-Message-State: APjAAAUdGjCo8l8M+7wfApQ62TlGtPsBlKMnQfLPSv0T5OYX71NfCzf7
        qS1T8Zt9TTh9zUNjeLGL48U=
X-Google-Smtp-Source: APXvYqyjDTBJ77I0vQ7K+GH4ayBqQxXjphxeJ1jfIKbhDzL8KubCkeiJTwEC2G4flkApKqCcKh0NNg==
X-Received: by 2002:a1c:9609:: with SMTP id y9mr23353wmd.27.1556125044062;
        Wed, 24 Apr 2019 09:57:24 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id o6sm39350388wre.60.2019.04.24.09.57.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 09:57:22 -0700 (PDT)
Date:   Wed, 24 Apr 2019 18:57:21 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 1/2] a2dp: Store last used endpoint
Message-ID: <20190424165721.fs7ylixjscqjmqmb@pali>
References: <20190424083921.15679-1-luiz.dentz@gmail.com>
 <CABBYNZLcpo_Dx3X9pmKGeqSNFDLKZAqd==6wL5qcthGiqg-EeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="o5txktzydoxs7sbz"
Content-Disposition: inline
In-Reply-To: <CABBYNZLcpo_Dx3X9pmKGeqSNFDLKZAqd==6wL5qcthGiqg-EeA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--o5txktzydoxs7sbz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wednesday 24 April 2019 12:42:22 Luiz Augusto von Dentz wrote:
> Hi Pali,
>=20
> On Wed, Apr 24, 2019 at 11:39 AM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > This stores the last used endpoint whenever it is considered open and
> > then prefer to use it when attempting to reconnect.
> > ---
> >  profiles/audio/a2dp.c | 104 ++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 91 insertions(+), 13 deletions(-)
> >
> > diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> > index 8f141739c..78b02dc84 100644
> > --- a/profiles/audio/a2dp.c
> > +++ b/profiles/audio/a2dp.c
> > @@ -147,6 +147,7 @@ struct a2dp_channel {
> >         unsigned int auth_id;
> >         struct avdtp *session;
> >         struct queue *seps;
> > +       struct a2dp_remote_sep *last_used;
> >  };
> >
> >  static GSList *servers =3D NULL;
> > @@ -860,6 +861,60 @@ static gboolean open_ind(struct avdtp *session, st=
ruct avdtp_local_sep *sep,
> >         return TRUE;
> >  }
> >
> > +static bool match_remote_sep(const void *data, const void *user_data)
> > +{
> > +       const struct a2dp_remote_sep *sep =3D data;
> > +       const struct avdtp_remote_sep *rsep =3D user_data;
> > +
> > +       return sep->sep =3D=3D rsep;
> > +}
> > +
> > +static void store_last_used(struct a2dp_channel *chan,
> > +                                       struct avdtp_remote_sep *rsep)
> > +{
> > +       GKeyFile *key_file;
> > +       char filename[PATH_MAX];
> > +       char dst_addr[18];
> > +       char value[4];
> > +       char *data;
> > +       size_t len =3D 0;
> > +
> > +       ba2str(device_get_address(chan->device), dst_addr);
> > +
> > +       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s",
> > +               btd_adapter_get_storage_dir(device_get_adapter(chan->de=
vice)),
> > +               dst_addr);
> > +       key_file =3D g_key_file_new();
> > +       g_key_file_load_from_file(key_file, filename, 0, NULL);
> > +
> > +       sprintf(value, "%02hhx", avdtp_get_seid(rsep));
> > +
> > +       g_key_file_set_string(key_file, "Endpoints", "LastUsed", value);
> > +
> > +       data =3D g_key_file_to_data(key_file, &len, NULL);
> > +       g_file_set_contents(filename, data, len, NULL);
> > +
> > +       g_free(data);
> > +       g_key_file_free(key_file);
> > +}
> > +
> > +static void update_last_used(struct a2dp_channel *chan,
> > +                                               struct avdtp_stream *st=
ream)
> > +{
> > +       struct avdtp_remote_sep *rsep;
> > +       struct a2dp_remote_sep *sep;
> > +
> > +       rsep =3D avdtp_stream_get_remote_sep(stream);
> > +
> > +       /* Update last used */
> > +       sep =3D queue_find(chan->seps, match_remote_sep, rsep);
> > +       if (chan->last_used =3D=3D sep)
> > +               return;
> > +
> > +       chan->last_used =3D sep;
> > +       store_last_used(chan, rsep);
> > +}
> > +
> >  static void open_cfm(struct avdtp *session, struct avdtp_local_sep *se=
p,
> >                         struct avdtp_stream *stream, struct avdtp_error=
 *err,
> >                         void *user_data)
> > @@ -884,7 +939,8 @@ static void open_cfm(struct avdtp *session, struct =
avdtp_local_sep *sep,
> >                 setup->err =3D err;
> >                 if (setup->start)
> >                         finalize_resume(setup);
> > -       }
> > +       } else if (setup->chan)
> > +               update_last_used(setup->chan, stream);
> >
> >         finalize_config(setup);
> >
> > @@ -1077,14 +1133,6 @@ static gboolean close_ind(struct avdtp *session,=
 struct avdtp_local_sep *sep,
> >         return TRUE;
> >  }
> >
> > -static bool match_remote_sep(const void *data, const void *user_data)
> > -{
> > -       const struct a2dp_remote_sep *sep =3D data;
> > -       const struct avdtp_remote_sep *rsep =3D user_data;
> > -
> > -       return sep->sep =3D=3D rsep;
> > -}
> > -
> >  static struct a2dp_remote_sep *find_remote_sep(struct a2dp_channel *ch=
an,
> >                                                 struct a2dp_sep *sep)
> >  {
> > @@ -1791,19 +1839,28 @@ done:
> >         queue_push_tail(chan->seps, sep);
> >  }
> >
> > +static bool match_seid(const void *data, const void *user_data)
> > +{
> > +       const struct a2dp_remote_sep *sep =3D data;
> > +       const uint8_t *seid =3D user_data;
> > +
> > +       return avdtp_get_seid(sep->sep) =3D=3D *seid;
> > +}
> > +
> >  static void load_remote_sep(struct a2dp_channel *chan, GKeyFile *key_f=
ile,
> >                                                                 char **=
seids)
> >  {
> >         struct avdtp_remote_sep *sep;
> > +       uint8_t seid;
> > +       char *value;
> >
> >         if (!seids)
> >                 return;
> >
> >         for (; *seids; seids++) {
> > -               uint8_t seid;
> >                 uint8_t type;
> >                 uint8_t codec;
> > -               char *value, caps[256];
> > +               char caps[256];
> >                 uint8_t data[128];
> >                 int i, size;
> >                 GSList *l =3D NULL;
> > @@ -1847,6 +1904,15 @@ static void load_remote_sep(struct a2dp_channel =
*chan, GKeyFile *key_file,
> >
> >                 register_remote_sep(sep, chan);
> >         }
> > +
> > +       value =3D g_key_file_get_string(key_file, "Endpoints", "LastUse=
d", NULL);
> > +       if (!value)
> > +               return;
> > +
> > +       if (sscanf(value, "%02hhx", &seid) !=3D 1)
> > +               return;
> > +
> > +       chan->last_used =3D queue_find(chan->seps, match_seid, &seid);
> >  }
> >
> >  static void load_remote_seps(struct a2dp_channel *chan)
> > @@ -2355,8 +2421,12 @@ done:
> >  static struct a2dp_sep *a2dp_find_sep(struct avdtp *session, GSList *l=
ist,
> >                                         const char *sender)
> >  {
> > +       struct a2dp_sep *first =3D NULL;
> > +       struct a2dp_channel *chan =3D find_channel(session);
> > +
> >         for (; list; list =3D list->next) {
> >                 struct a2dp_sep *sep =3D list->data;
> > +               struct avdtp_remote_sep *rsep;
> >
> >                 /* Use sender's endpoint if available */
> >                 if (sender) {
> > @@ -2370,14 +2440,22 @@ static struct a2dp_sep *a2dp_find_sep(struct av=
dtp *session, GSList *list,
> >                                 continue;
> >                 }
> >
> > -               if (avdtp_find_remote_sep(session, sep->lsep) =3D=3D NU=
LL)
> > +               rsep =3D avdtp_find_remote_sep(session, sep->lsep);
> > +               if (!rsep)
> >                         continue;
> >
> > +               /* Locate last used if set */
> > +               if (chan->last_used) {
> > +                       if (chan->last_used->sep =3D=3D rsep)
> > +                               return sep;
> > +                       first =3D sep;
> > +               }
> > +
> >                 return sep;
> >
> >         }
> >
> > -       return NULL;
> > +       return first;
> >  }
> >
> >  static struct a2dp_sep *a2dp_select_sep(struct avdtp *session, uint8_t=
 type,
> > --
> > 2.20.1
>=20
> Can you give this a try, it should make the daemon remember what was
> the last endpoint used (locally the remote selection we cannot really
> control).

Great, I will try it. Remote selection is done by remote device so this
really cannot be controlled.

I have there another suggestion for improvement. bluez support
registering more endpoints for one codec. I'm going to use it for
registering one SBC endpoint with fixed bitpool as UHQ profile and
another with lower bitpool values. To distinguish in pulseaudio between
low and high quality of SBC. Seems that bluez sometimes try to only
select only one endpoint, even there are more and do not try another if
first one selection fails (e.g. because remote capability of bitpool is
too low and our local selection needs higher). Could be bluez modified
to try another local endpoint if there are more registered until some
accept capabilities?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--o5txktzydoxs7sbz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXMCVbwAKCRCL8Mk9A+RD
UtJGAJ4xgtL6tICkStnAwUxJf9zmOtSuMACgrw2RXipHfeZCxsuDEBJeICkYdhI=
=F7D5
-----END PGP SIGNATURE-----

--o5txktzydoxs7sbz--
