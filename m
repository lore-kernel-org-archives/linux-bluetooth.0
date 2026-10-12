Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF44148A8D9
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 20:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791836672; cv=pass; b=FeWHSQlPK+o1QPSofs+0yrEX+9g1Inw/t6Np9A+isYNBXibP0IjU8XdB/veuTfLDLdVv5QeGiwzrC8ZaAdUroH84XIVkwgaStFj//U7YKDVkh+yi0UMFg3Mol9ssTiqPAyuRDHePNqcnnhW35D3823s7DCd7yZiWIgNNtsQpIbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791836672; c=relaxed/simple;
	bh=vYzpqBRyOQ9ubaUWNOUDicDUite+Re+k5prkOd2GMWI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VWkthHrkt3XcgvgZ8+8nIRVLRxVSgN4v0gWI0vY8PKdLiX0fVLtIcogn8Kyq255p585g+39xC3sD7H9PnY681FY3Z1k0x2vVd1aMEfe095mY0lZkAAVmSPttPHoj8hBgOjylAZZtrPehZ9NlcnC0xJNp0aCb2dyMCPVwsFXkI2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=BV7i0MxF; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="BV7i0MxF"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4j3TTK5rGKz49Q5W;
	Mon, 12 Oct 2026 23:24:21 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1791836662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gd16aSD6XaQMfWNhMatFewl/BanUeyGTzUHOMTe16UY=;
	b=BV7i0MxFhz61NMGRpxa0aq53mg+kt6q2cXJnS8ygyJkTZkzmLvqr9LXkfzwvXVxx5fTJdC
	pOaHbfEA8OQTjSp3/7XSzafSzgQfcLhKY6ZSnjj0HtErkK/HFQppQ/OdyOrPI4Us4G/5jV
	xemzGbRxNwWyiW0/i21l99PxWNR+mCsYCo6aI0Iq9ZOum3MYMNPt2D8rl/QR8/fY/rLoE7
	MmUAHBf8ZyYJX3W0o/arc405hmZeAMOLbFJ8+A6cjOaupOyyQ0Awj8XKDq/p2gRKE8H/ZL
	IggXFIUPq7qo8PK9UQaeN2bijfH+1DiwmEw6tIIz2DzENVm7EOV3YAWyv6L5zQ==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1791836662;
	b=XpZatz5/PJzW+eK4f9bv57/mGIs18hVxT5ot3s1C5vB5Y+ZOc+8+UbvCrEOn1HTzdHSEQQ
	mp8pzzz5IfOe+w8754RuqDk49S6SxOTdRF9ZGsQOA+PKRFtneCPDuPk4jz5aFbcOYG0HWR
	hvUAyhxHcIwDRQsBy+taazCssoM4nduVl7QJHTfpWW1+xIbNccnLLnvGt/sq3TI7lnGATC
	LW30uK9y2RQUGeqwKpoIWmfgsJywMVQ1zZJ/jbiy4216PKzHFAZS4PAx636Tpkx7RHn7Gl
	GtTK9TUHTbTIv0APAYln4KYZM8tYnHJ+/buXSsQ7vsLy8Z+QsgG49/WpF4rJSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1791836662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gd16aSD6XaQMfWNhMatFewl/BanUeyGTzUHOMTe16UY=;
	b=SSoY9v6nOKE2YLCaCGl9/PPpP8HTOv/G2f/wiRpCBZ5aDyY0XLKdXGorcmRHV95mCeN5AI
	AhT4Bb0xguqeT+XBQzUpZmql+ffi9swP2Lmh0cgRA5D2ogixOnjlv0eyy1fLlGw/Jc3021
	kN5FD6zqTC5YOdAKvxdbJswx2SvS0O53V7xq54h6wrS6koiJkXIUiXBIcHzJ0W+AUBWPur
	6LKZlMd+0/kk+3oW2+NDiSvY4igF7gKJaqcuVPJD/hGd6OQKalsMH+JXcF/lxlxDCoMbLB
	5udeaUKQ4TTFMfRz2YiCSBu1etxgA9NDShH7Qf6iooQJfDiGQSZPVfXlCMSK0A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <6af116de4d8058516e11d789280fbf5bf2efeebb.camel@iki.fi>
Subject: Re: [PATCH BlueZ 5/5] bass: wait for PAST listener readiness
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 12 Oct 2026 23:24:20 +0300
In-Reply-To: <CABBYNZJ94rHYZ74GLyX7O4oTAbsWYSMccx6bzpods+BAQ=BwVA@mail.gmail.com>
References: <cover.1791750393.git.pav@iki.fi>
	 <5b5a8c1ebfe761606affcca1437c8a352fa0502a.1791750393.git.pav@iki.fi>
	 <CABBYNZJ94rHYZ74GLyX7O4oTAbsWYSMccx6bzpods+BAQ=BwVA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Luiz,

ma, 2026-10-12 kello 15:58 -0400, Luiz Augusto von Dentz kirjoitti:
> On Sun, Oct 11, 2026 at 4:42=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote=
:
> >=20
> > Defer SYNC_INFO_RE until the PA sync listener signals POLLOUT, so the
> > Assistant cannot start PAST before receiver setup completes.
> >=20
> > Check kernel support via BT_ISO_PAST_POLLOUT, otherwise skip waiting.
> >=20
> > Fixes test_bass_past_transport_* test failures.
> >=20
> > Assisted-by: LLM
> > ---
> >  profiles/audio/bass.c | 66 ++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 59 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
> > index fd05195f3..90e758c08 100644
> > --- a/profiles/audio/bass.c
> > +++ b/profiles/audio/bass.c
> > @@ -146,7 +146,9 @@ struct bass_delegator {
> >         struct queue *bcode_reqs;
> >         struct queue *setups;
> >         unsigned int io_id;
> > +       unsigned int io_ready_id;
> >         GIOChannel *io;
> > +       bool past;
> >  };
> >=20
> >  struct bass_setup {
> > @@ -751,6 +753,11 @@ static void confirm_cb(GIOChannel *io, void *user_=
data)
> >=20
> >         DBG("");
> >=20
> > +       if (dg->io_ready_id) {
> > +               g_source_remove(dg->io_ready_id);
> > +               dg->io_ready_id =3D 0;
> > +       }
> > +
> >         /* Close the listen io */
> >         g_io_channel_shutdown(dg->io, TRUE, NULL);
> >         g_io_channel_unref(dg->io);
> > @@ -1528,11 +1535,28 @@ static bool delegator_match_device(const void *=
data, const void *match_data)
> >         return dg->device =3D=3D device;
> >  }
> >=20
> > +static gboolean pa_sync_ready_cb(GIOChannel *io, GIOCondition cond,
> > +                                                       gpointer user_d=
ata)
> > +{
> > +       struct bass_delegator *dg =3D user_data;
> > +
> > +       dg->io_ready_id =3D 0;
> > +
> > +       if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL))
> > +               return FALSE;
> > +
> > +       bt_bass_set_pa_sync(dg->src, BT_BASS_SYNC_INFO_RE);
> > +
> > +       return FALSE;
> > +}
> > +
> >  static void delegator_attach(struct bt_bap *bap, struct btd_device *de=
vice,
> >                                 struct btd_service *service)
> >  {
> >         struct bass_delegator *dg;
> >         GError *err =3D NULL;
> > +       socklen_t len;
> > +       int sk, past_pollout;
> >=20
> >         dg =3D queue_find(delegators, delegator_match_device, device);
> >         if (!dg)
> > @@ -1570,6 +1594,30 @@ static void delegator_attach(struct bt_bap *bap,=
 struct btd_device *device,
> >=20
> >         /* Take ownership for the service by setting the user data. */
> >         btd_service_set_user_data(service, dg);
> > +
> > +       if (!dg->past)
> > +               return;
> > +
> > +       sk =3D g_io_channel_unix_get_fd(dg->io);
> > +       len =3D sizeof(past_pollout);
> > +
> > +       if (getsockopt(sk, SOL_BLUETOOTH, BT_ISO_PAST_POLLOUT,
> > +                                               &past_pollout, &len) < =
0) {
> > +               if (errno !=3D ENOPROTOOPT) {
> > +                       error("Unable to query PAST readiness support: =
%s",
> > +                                                       strerror(errno)=
);
> > +                       return;
> > +               }
> > +
> > +               past_pollout =3D 0;
> > +       }
>=20
> While I agree it needs fixing since not only it can create problem for
> testing but it may be possible to hit this over the air as well, the
> solution though is a little bitter to my taste, perhaps we could use
> to indicate when HCI_OP_LE_PAST_PARAMS has been completed (with
> status=3D0) then we notify with flags changed. If that is still a little
> too much perhaps we can issue right away when setting upon receiving
> MGMT_OP_SET_DEVICE_FLAGS(HCI_CONN_FLAG_PAST) and somehow makeup for
> the qos arguments if conn->iso_qos is not set yet, either way that
> should gate the response of BT_BASS_SYNC_INFO_RE by indicating
> HCI_CONN_FLAG_PAST is actually programmed in the controller via
> HCI_OP_LE_PAST_PARAMS.

Note the issue is not only waiting for HCI_OP_LE_PAST_PARAMS, but also
closing the race window before hdev->req_skb gets assigned, otherwise
it appears the hci_sync wait could miss early event and end up in
create_pa_complete() with error.

We could ignore this as too small window (-> drop patch 1), but I'm not
certain it's impossible to hit, and LLMs will be complaining.

IIUC you would rather signal readiness via MGMT than mess with poll(),
via eg. new MGMT device flags bit + inform bluetoothd via change
event?=C2=A0Controller settings would also allow backward-compatibility
detection.

So: Keep patch 1 + signal PAST readiness via device flags bit?

> > +       if (past_pollout)
> > +               dg->io_ready_id =3D g_io_add_watch(dg->io,
> > +                               G_IO_OUT | G_IO_ERR | G_IO_HUP | G_IO_N=
VAL,
> > +                               pa_sync_ready_cb, dg);
> > +       else
> > +               bt_bass_set_pa_sync(dg->src, BT_BASS_SYNC_INFO_RE);
> >  }
> >=20
> >  static void bap_attached(struct bt_bap *bap, void *user_data)
> > @@ -1645,6 +1693,9 @@ static void delegator_free(struct bass_delegator =
*dg)
> >         if (dg->io_id)
> >                 g_source_remove(dg->io_id);
> >=20
> > +       if (dg->io_ready_id)
> > +               g_source_remove(dg->io_ready_id);
> > +
> >         if (dg->io) {
> >                 g_io_channel_shutdown(dg->io, TRUE, NULL);
> >                 g_io_channel_unref(dg->io);
> > @@ -1906,7 +1957,7 @@ static void bass_detached(struct bt_bass *bass, v=
oid *user_data)
> >=20
> >  static struct bass_delegator *
> >  bass_delegator_new(struct btd_device *device, struct bt_bcast_src *src=
,
> > -                       uint8_t sid)
> > +                       uint8_t sid, bool past)
> >  {
> >         struct bass_delegator *dg;
> >=20
> > @@ -1917,6 +1968,7 @@ bass_delegator_new(struct btd_device *device, str=
uct bt_bcast_src *src,
> >         dg->device =3D device;
> >         dg->src =3D src;
> >         dg->sid =3D sid;
> > +       dg->past =3D past;
> >         dg->bcode_reqs =3D queue_new();
> >         dg->setups =3D queue_new();
> >=20
> > @@ -1945,6 +1997,7 @@ static int handle_add_src_req(struct bt_bcast_src=
 *bcast_src,
> >         struct btd_adapter *adapter =3D device_get_adapter(data->device=
);
> >         struct btd_device *device;
> >         struct bass_delegator *dg;
> > +       bool past =3D false;
> >=20
> >         /* Detect if PAST can be used then it can be used as destinatio=
n since
> >          * PAST Receiver uses the ACL connection itself.
> > @@ -1957,6 +2010,7 @@ static int handle_add_src_req(struct bt_bcast_src=
 *bcast_src,
> >                 if (btd_adapter_has_settings(data->adapter,
> >                                                 MGMT_SETTING_PAST_RECEI=
VER)) {
> >                         device_set_past_support(data->device, true);
> > +                       past =3D true;
> >                         device =3D data->device;
> >                         goto done;
> >                 }
> > @@ -1980,16 +2034,14 @@ done:
> >          * autonomously probed inside BAP.
> >          */
> >         if (!btd_device_get_service(device, BCAAS_UUID_STR)) {
> > -               dg =3D bass_delegator_new(device, bcast_src, params->si=
d);
> > +               dg =3D bass_delegator_new(device, bcast_src, params->si=
d, past);
> >                 if (!dg)
> >                         return -ENOMEM;
> > +
> > +               if (past)
> > +                       return 0;
> >         }
> >=20
> > -       /* Set PA sync state, this has to be done after probing otherwi=
se there
> > -        * is a race where the remote may receive BT_BASS_SYNC_INFO_RE =
and start
> > -        * PAST before the kernel has sent PAST Parameter command that =
enables
> > -        * receiving it.
> > -        */
> >         if (params->pa_sync =3D=3D PA_SYNC_PAST) {
> >                 if (btd_adapter_has_settings(data->adapter,
> >                                                 MGMT_SETTING_PAST_RECEI=
VER))
> > --
> > 2.56.0
> >=20
> >=20
>=20

--=20
Pauli Virtanen
