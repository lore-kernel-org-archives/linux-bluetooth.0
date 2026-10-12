Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7D7488D92
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 20:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791837620; cv=pass; b=k5UeRao+N0gZQtcbyIdZ/bo79aZxYvi1aH+5tuZSsCd/il/jWF50ZYpLD7nkvOO6cNKJcn6o1T3a3SjSiZPGFGulc7eHAuLUs3VNlXoCS2IcRmoP0utrmctASZNE6JqRNcT4Fa8nc5bEDYH3mshJbvZWoYfDiR2oSdg3ts/fVI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791837620; c=relaxed/simple;
	bh=MS7NZgJcdQW8UzXRXGk/ULxUh1hMhneh+YZjf2CyXA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fm+bG5WTKDHCKLNbRXIZ+5Z+y2wHEoeyDwY18ycafdtZQUk61q5C9DzTWBsXT8kTsBYOes8vN/l7I+tYnwmxYAt85x20m2Pd37ebYsL9vszCaBXneVYxCo2KcTGVK4CQLmMTDXtLvMMX9TRUN8IvmZTvz4201pT7I/0DZvMIybU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pyx/6T91; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pyx/6T91"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-677b5148acaso1972014d50.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 13:40:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791837617; cv=none;
        d=google.com; s=arc-20260327;
        b=BOqWp0gcXr4wY2tY/fpYWHdw/FD+8tyo1YrBnYHyyrC78bKhJbQYyWK/3X0eGFs+kP
         cDSVZpfUvUsz3bhT/tH1ylGSKCILNoz6E9nNz9oc2t3ajYL2EmiVsCRlJmzWEllRGLlb
         NmwYHndfCbDSZutO7aAIveEs/OMHOBmJH4q3kzipvLRXDqgU77XmEjrbq3sVA7YcH/ZP
         LUM3AWfTwE+BFmtkMn+ZwZ8b1mEBu47vJq7hi59PvzjPiamb+8rp2JTpbF16iK+smugz
         xhaK/yu4kVr0+yIk7Irpfm8wbJJiXJBZ62uNZ5FE1pbQLuBMaWSenweSt0gkSUqb+0zH
         CNcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1avs404Cm+fSmHJIktsXoinU91W+sCqP3QzXmzm3v8A=;
        fh=fAVvqa29TMCSLQ1BWo+IkeTh9vOt2h2EvlnFWIq0DOI=;
        b=QXNLrhwuf68gUFb2It9W4/bLiQ4yPqBdAgxqWsh8iPkbrmds/odybevfvOUozJvme5
         wtdyPKObAvT9KypT/76HU/bvJ4I9Vb6uPm/UejZC2gL2FzbC7IqAdDr8HXyn5BRTwiVm
         I6YAuaZCMzA7lErNUxvp+oBofdGRAEv79lxPvEQ0wEzfIFiMRHb2LvRkBFEwMbyA3cye
         tM24cqiXTJYw57GSERLW/8aJRor+KSCMdkKSjQZJGBlNCrycciJxfLWCprat3vG4sMj+
         6ostOQKZD0TICq1Ce+bIGEohRk4Tnp0oj7avjYkPp/W5rxKyXLLBzIdCpswW0iaaFrTP
         DRxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791837617; x=1792442417; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1avs404Cm+fSmHJIktsXoinU91W+sCqP3QzXmzm3v8A=;
        b=pyx/6T91KFpd5PMJD4E6DZXOFQiHKhqSedHOQdN5ED6BOdtl5UaNt8rnpI+FP8LxNa
         udTYqZ82Eg1TspnHHnjzoqxLutmUBt5cBPHmIJiImwGt/BGRo9HibynildmQgyb1LawJ
         q4zAhGTTTZHi7RRni47Z70fBxciq2jiaoZB5A4yXwWUZd5edb+csulR6NbHBr1wC9weu
         hZVySYDvLC/PGX6YVRL+dJ5yEIo+cyvGNlcS/Y79U9ybuO2aKplBdwLI8pFskhv2N3xO
         Wg3x6CZMMLONF2qCUrLQRbBOkQN8U0X9CgotphSdnsL+4G9S8cXF1p1wWrQBjwJGbvS9
         YdgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791837617; x=1792442417;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1avs404Cm+fSmHJIktsXoinU91W+sCqP3QzXmzm3v8A=;
        b=MprXbdrLTwQlu4VetJUbGs/8vLwk3fPrPAC+bWgDg6D/HxKSWqi1Pv9n8vydc/Tual
         Yyu/DvQj81I/wujan7duP5HW4B+2oYgQ6r3U/fP7oItxgb1lGOqno9Bq1bYxsee+bMMx
         hEb+1MDbjOZrq657qig1nPEjswUAOBTn0n8ZEQ8HX96XEYk4uv/gbTRSnq6/uqkt9rZF
         EpvyN7LjEPHSHr92C4rJ9i880DVo3gGgrXW8IiiOknNE5/vg/Ud1T/TjslZaS9gFqx9E
         STpBZm+3Guq462I6+NW1KM7qYHBGW4qQsjmWbJvwUFqkLt5ZfsJH15ru3jDScFUfLKJv
         /Xeg==
X-Gm-Message-State: AFq9FYJn7M4JBK/vPir30qFT91d/mS7Zy0PEl7oZBqPvNWtpiecNYAzp
	dZados1fJKx23gvZqWqbmrjgdgw2/p7E1aA8aIIT+VRxnkM+UhyEf13khbG1i5aJPBdR6KC0nxU
	pTGfYRMKFB1iqe0USXtVBpc7NVEwMtDA=
X-Gm-Gg: AYBFou3MPgeTAAjmUPB/yKlivfQZJ73fyC7vGdwRKu8fyx15XTQtnC1DaQtIowUztiP
	IaE7I6NxUFavm0yrj4FtY988aUDzWtFqtf8JnfBXbteuO/QMmll5aseL/sWZJFIigNA3V/F9Ncw
	/KzKhWcIrttj9WW36pPlmmyGAQF2sw9YkVoGRkCbJMiM9kAnJpQDiYyKG5dAR+J2ViOny5k7gLT
	KJ8496SSSwgcCTE9uqQYuWWXBUMz3Sv3Hwvg/PRmarxyAh8D7fqK+A+rWAiyOZi8V0KEeKjpi5f
	NXHdCxtoQ7gy4gTCvWjwAMKH6tb6v0U4KM+Vz9cxbIPHAtsy4aoDFTBh36QB3CH2ug3ZDsrTRWD
	ubVrlPAI968daRJPXfo39LTwiX2g1lG+2SCaz+m22uA==
X-Received: by 2002:a05:690e:bc7:b0:677:ba7e:a21a with SMTP id
 956f58d0204a3-67935f1c410mr2930275d50.19.1791837617035; Mon, 12 Oct 2026
 13:40:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1791750393.git.pav@iki.fi> <5b5a8c1ebfe761606affcca1437c8a352fa0502a.1791750393.git.pav@iki.fi>
 <CABBYNZJ94rHYZ74GLyX7O4oTAbsWYSMccx6bzpods+BAQ=BwVA@mail.gmail.com> <6af116de4d8058516e11d789280fbf5bf2efeebb.camel@iki.fi>
In-Reply-To: <6af116de4d8058516e11d789280fbf5bf2efeebb.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 12 Oct 2026 16:40:04 -0400
X-Gm-Features: AclHuK_bRIAY3N3P0RA6TlI1UnkAT7uosTskujz3MtyT2ZHwFaosG5LFWcvzA84
Message-ID: <CABBYNZJrQu=eqgRdu1Vq=VFF4fjdi-aCK07f464P4YUY-ou-9A@mail.gmail.com>
Subject: Re: [PATCH BlueZ 5/5] bass: wait for PAST listener readiness
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Mon, Oct 12, 2026 at 4:24=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi Luiz,
>
> ma, 2026-10-12 kello 15:58 -0400, Luiz Augusto von Dentz kirjoitti:
> > On Sun, Oct 11, 2026 at 4:42=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wro=
te:
> > >
> > > Defer SYNC_INFO_RE until the PA sync listener signals POLLOUT, so the
> > > Assistant cannot start PAST before receiver setup completes.
> > >
> > > Check kernel support via BT_ISO_PAST_POLLOUT, otherwise skip waiting.
> > >
> > > Fixes test_bass_past_transport_* test failures.
> > >
> > > Assisted-by: LLM
> > > ---
> > >  profiles/audio/bass.c | 66 ++++++++++++++++++++++++++++++++++++++---=
--
> > >  1 file changed, 59 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
> > > index fd05195f3..90e758c08 100644
> > > --- a/profiles/audio/bass.c
> > > +++ b/profiles/audio/bass.c
> > > @@ -146,7 +146,9 @@ struct bass_delegator {
> > >         struct queue *bcode_reqs;
> > >         struct queue *setups;
> > >         unsigned int io_id;
> > > +       unsigned int io_ready_id;
> > >         GIOChannel *io;
> > > +       bool past;
> > >  };
> > >
> > >  struct bass_setup {
> > > @@ -751,6 +753,11 @@ static void confirm_cb(GIOChannel *io, void *use=
r_data)
> > >
> > >         DBG("");
> > >
> > > +       if (dg->io_ready_id) {
> > > +               g_source_remove(dg->io_ready_id);
> > > +               dg->io_ready_id =3D 0;
> > > +       }
> > > +
> > >         /* Close the listen io */
> > >         g_io_channel_shutdown(dg->io, TRUE, NULL);
> > >         g_io_channel_unref(dg->io);
> > > @@ -1528,11 +1535,28 @@ static bool delegator_match_device(const void=
 *data, const void *match_data)
> > >         return dg->device =3D=3D device;
> > >  }
> > >
> > > +static gboolean pa_sync_ready_cb(GIOChannel *io, GIOCondition cond,
> > > +                                                       gpointer user=
_data)
> > > +{
> > > +       struct bass_delegator *dg =3D user_data;
> > > +
> > > +       dg->io_ready_id =3D 0;
> > > +
> > > +       if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL))
> > > +               return FALSE;
> > > +
> > > +       bt_bass_set_pa_sync(dg->src, BT_BASS_SYNC_INFO_RE);
> > > +
> > > +       return FALSE;
> > > +}
> > > +
> > >  static void delegator_attach(struct bt_bap *bap, struct btd_device *=
device,
> > >                                 struct btd_service *service)
> > >  {
> > >         struct bass_delegator *dg;
> > >         GError *err =3D NULL;
> > > +       socklen_t len;
> > > +       int sk, past_pollout;
> > >
> > >         dg =3D queue_find(delegators, delegator_match_device, device)=
;
> > >         if (!dg)
> > > @@ -1570,6 +1594,30 @@ static void delegator_attach(struct bt_bap *ba=
p, struct btd_device *device,
> > >
> > >         /* Take ownership for the service by setting the user data. *=
/
> > >         btd_service_set_user_data(service, dg);
> > > +
> > > +       if (!dg->past)
> > > +               return;
> > > +
> > > +       sk =3D g_io_channel_unix_get_fd(dg->io);
> > > +       len =3D sizeof(past_pollout);
> > > +
> > > +       if (getsockopt(sk, SOL_BLUETOOTH, BT_ISO_PAST_POLLOUT,
> > > +                                               &past_pollout, &len) =
< 0) {
> > > +               if (errno !=3D ENOPROTOOPT) {
> > > +                       error("Unable to query PAST readiness support=
: %s",
> > > +                                                       strerror(errn=
o));
> > > +                       return;
> > > +               }
> > > +
> > > +               past_pollout =3D 0;
> > > +       }
> >
> > While I agree it needs fixing since not only it can create problem for
> > testing but it may be possible to hit this over the air as well, the
> > solution though is a little bitter to my taste, perhaps we could use
> > to indicate when HCI_OP_LE_PAST_PARAMS has been completed (with
> > status=3D0) then we notify with flags changed. If that is still a littl=
e
> > too much perhaps we can issue right away when setting upon receiving
> > MGMT_OP_SET_DEVICE_FLAGS(HCI_CONN_FLAG_PAST) and somehow makeup for
> > the qos arguments if conn->iso_qos is not set yet, either way that
> > should gate the response of BT_BASS_SYNC_INFO_RE by indicating
> > HCI_CONN_FLAG_PAST is actually programmed in the controller via
> > HCI_OP_LE_PAST_PARAMS.
>
> Note the issue is not only waiting for HCI_OP_LE_PAST_PARAMS, but also
> closing the race window before hdev->req_skb gets assigned, otherwise
> it appears the hci_sync wait could miss early event and end up in
> create_pa_complete() with error.
>
> We could ignore this as too small window (-> drop patch 1), but I'm not
> certain it's impossible to hit, and LLMs will be complaining.
>
> IIUC you would rather signal readiness via MGMT than mess with poll(),
> via eg. new MGMT device flags bit + inform bluetoothd via change
> event? Controller settings would also allow backward-compatibility
> detection.
>
> So: Keep patch 1 + signal PAST readiness via device flags bit?

But for 1 to happen after we change to wait for the MGMT event that
would mean the peer had sent ahead of receiving BT_BASS_SYNC_INFO_RE?
We shall be waiting already once the MGMT signal trigger and we
respond with BT_BASS_SYNC_INFO_RE, perhaps Im not understanding the
race here, is that still about HCI_EV_LE_PAST_RECEIVED so we only do
the MGMT event while waiting it?

> > > +       if (past_pollout)
> > > +               dg->io_ready_id =3D g_io_add_watch(dg->io,
> > > +                               G_IO_OUT | G_IO_ERR | G_IO_HUP | G_IO=
_NVAL,
> > > +                               pa_sync_ready_cb, dg);
> > > +       else
> > > +               bt_bass_set_pa_sync(dg->src, BT_BASS_SYNC_INFO_RE);
> > >  }
> > >
> > >  static void bap_attached(struct bt_bap *bap, void *user_data)
> > > @@ -1645,6 +1693,9 @@ static void delegator_free(struct bass_delegato=
r *dg)
> > >         if (dg->io_id)
> > >                 g_source_remove(dg->io_id);
> > >
> > > +       if (dg->io_ready_id)
> > > +               g_source_remove(dg->io_ready_id);
> > > +
> > >         if (dg->io) {
> > >                 g_io_channel_shutdown(dg->io, TRUE, NULL);
> > >                 g_io_channel_unref(dg->io);
> > > @@ -1906,7 +1957,7 @@ static void bass_detached(struct bt_bass *bass,=
 void *user_data)
> > >
> > >  static struct bass_delegator *
> > >  bass_delegator_new(struct btd_device *device, struct bt_bcast_src *s=
rc,
> > > -                       uint8_t sid)
> > > +                       uint8_t sid, bool past)
> > >  {
> > >         struct bass_delegator *dg;
> > >
> > > @@ -1917,6 +1968,7 @@ bass_delegator_new(struct btd_device *device, s=
truct bt_bcast_src *src,
> > >         dg->device =3D device;
> > >         dg->src =3D src;
> > >         dg->sid =3D sid;
> > > +       dg->past =3D past;
> > >         dg->bcode_reqs =3D queue_new();
> > >         dg->setups =3D queue_new();
> > >
> > > @@ -1945,6 +1997,7 @@ static int handle_add_src_req(struct bt_bcast_s=
rc *bcast_src,
> > >         struct btd_adapter *adapter =3D device_get_adapter(data->devi=
ce);
> > >         struct btd_device *device;
> > >         struct bass_delegator *dg;
> > > +       bool past =3D false;
> > >
> > >         /* Detect if PAST can be used then it can be used as destinat=
ion since
> > >          * PAST Receiver uses the ACL connection itself.
> > > @@ -1957,6 +2010,7 @@ static int handle_add_src_req(struct bt_bcast_s=
rc *bcast_src,
> > >                 if (btd_adapter_has_settings(data->adapter,
> > >                                                 MGMT_SETTING_PAST_REC=
EIVER)) {
> > >                         device_set_past_support(data->device, true);
> > > +                       past =3D true;
> > >                         device =3D data->device;
> > >                         goto done;
> > >                 }
> > > @@ -1980,16 +2034,14 @@ done:
> > >          * autonomously probed inside BAP.
> > >          */
> > >         if (!btd_device_get_service(device, BCAAS_UUID_STR)) {
> > > -               dg =3D bass_delegator_new(device, bcast_src, params->=
sid);
> > > +               dg =3D bass_delegator_new(device, bcast_src, params->=
sid, past);
> > >                 if (!dg)
> > >                         return -ENOMEM;
> > > +
> > > +               if (past)
> > > +                       return 0;
> > >         }
> > >
> > > -       /* Set PA sync state, this has to be done after probing other=
wise there
> > > -        * is a race where the remote may receive BT_BASS_SYNC_INFO_R=
E and start
> > > -        * PAST before the kernel has sent PAST Parameter command tha=
t enables
> > > -        * receiving it.
> > > -        */
> > >         if (params->pa_sync =3D=3D PA_SYNC_PAST) {
> > >                 if (btd_adapter_has_settings(data->adapter,
> > >                                                 MGMT_SETTING_PAST_REC=
EIVER))
> > > --
> > > 2.56.0
> > >
> > >
> >
>
> --
> Pauli Virtanen



--=20
Luiz Augusto von Dentz
