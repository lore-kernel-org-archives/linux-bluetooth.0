Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36003387346
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 21:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791838992; cv=pass; b=fe6Y9VF4zeXUYoEXe7lVjyhx6c6OvsffkGP8mnt1kG142pUT+yStfISUzW+5mQGsNRi3PRbgSWrvOOTf8aEV/vaPNY9A0v4O2a94Qb/lyVKdy+zWAVehZW4wP7Pt6EZGLIwoT5wMRcCXNw76WKc6kntVFAydybsCD3KMvo82ihQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791838992; c=relaxed/simple;
	bh=kLt+uPGyNO0H1QzZrKHjRzC2O2Hw72D2+bD4EI0h2xo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fmh1uep+Fvjaenoypj+NFwxti1rfgm1Pk6WP+XBlgsPtT8jy67a1RnQmwpLiWRJ0MOWc8VMnEa+8dUKdzw9kqpoxcG+QZSmVB2x+PZpHr4uYrkSA7LGO8rKEsTIiUHt+EqfSlIcNBVoTYzPwv0w7uMTUW5SgUrjhnuEWX8vYEhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=NANLxa6n; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="NANLxa6n"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4j3VL00V3wz49Pxq;
	Tue, 13 Oct 2026 00:03:04 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1791838984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C6PqHHtQfqGIMzJnEjCPIi6oAnYUJ0ifHcXpcc4nnL8=;
	b=NANLxa6nL2ivBROj9LtDhhM95XnGUBvx+iXsIMYXmkML2nVbv+va16h2zKBfvhO0Mx/I+s
	TxeC8Ou3yGnprYbj8DGB5h98OhkK+3iaF8ch5q90trUfQS5dXAiJUS8TEUzGxFEwxUnn6D
	qDO5zNbN30QRAblDY2GcE0sQkezbswpWVyPN4Tt1FmiXvkc0RNTpudtKDKpK8JKX781EoR
	5SI4+fknqj6AZVHFokWoDeqVZNzydbLdbxyyKgQw95cdTisICmYP3hjMJ6pgJOvZCGRvci
	7GRr8LtS+qsHgwRYL4TajBJpBfE/3iN9/20+8Rz/A6Op+002u9feNrKBdLuLIQ==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1791838984;
	b=QL0o+FUXKekx2FogE+MYwOiM4yoLcUil0vVBpqDJLaHVNj1mP61F7FNrAWxfC1GcT2YJ+i
	78Md0PC738zVkEguh9CN5ioODt+WQQhr87ow6FUdG/AD7BhRFEZzn00SL6WBJM6gWmwolP
	Xr2TMt+82pYNCUtx1CRsELFU+YwtHvbQxcHtYKXPltTqbqLhzJ3NfTu8gMuA+kfI1gKdfi
	lJ7iuQKDVsGmlJnq0hPiYpcXW6G+d9kcYyfS5uSaGlVIUobT0H5F2zLdMrSx4Fck9JSukU
	3T8prmzD0Vj7Gnn0EEUjbNAY1Pwo+4pkhHYzc8G1bLqAVk0YgyZ6VkVioT2vCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1791838984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C6PqHHtQfqGIMzJnEjCPIi6oAnYUJ0ifHcXpcc4nnL8=;
	b=XBL7vxkwcQbnUGX0qHWchXVgqHsykcPWsLijjgsxBZAIGeb3c1T8qikvZsafCVLCMEmg8Z
	Rv1QL9RzNXweLNNZv8gaUJx9fkyvoXlSx+coT8wEG8nnCKv0MQMRqp9hPvZCE6zv+DepBv
	FAv/SJ0ZiQrM2CaJoO8ugPqTFo+H2+p7aMCew6aBmeabcjyH9QpMx8KGRD+KgwxYExDoSi
	js9Z2RGBHC0+4YaVztYh1ob5kjv8+jI2dIX28nOPtinqFumt5pBcQO7iMdfC1gUD/kFNvs
	GCOgKERBseBdb76t1NiP3sZh1HA1Non3vRQmy4bIwpGE7niXWFeeKvNp0yll0w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <b53d70bf145c695372877b862299df3a49a830f2.camel@iki.fi>
Subject: Re: [PATCH BlueZ 5/5] bass: wait for PAST listener readiness
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 13 Oct 2026 00:03:03 +0300
In-Reply-To: <CABBYNZJrQu=eqgRdu1Vq=VFF4fjdi-aCK07f464P4YUY-ou-9A@mail.gmail.com>
References: <cover.1791750393.git.pav@iki.fi>
	 <5b5a8c1ebfe761606affcca1437c8a352fa0502a.1791750393.git.pav@iki.fi>
	 <CABBYNZJ94rHYZ74GLyX7O4oTAbsWYSMccx6bzpods+BAQ=BwVA@mail.gmail.com>
	 <6af116de4d8058516e11d789280fbf5bf2efeebb.camel@iki.fi>
	 <CABBYNZJrQu=eqgRdu1Vq=VFF4fjdi-aCK07f464P4YUY-ou-9A@mail.gmail.com>
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

ma, 2026-10-12 kello 16:40 -0400, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Mon, Oct 12, 2026 at 4:24=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote=
:
> >=20
> > Hi Luiz,
> >=20
> > ma, 2026-10-12 kello 15:58 -0400, Luiz Augusto von Dentz kirjoitti:
> > > On Sun, Oct 11, 2026 at 4:42=E2=80=AFPM Pauli Virtanen <pav@iki.fi> w=
rote:
> > > >=20
> > > > Defer SYNC_INFO_RE until the PA sync listener signals POLLOUT, so t=
he
> > > > Assistant cannot start PAST before receiver setup completes.
> > > >=20
> > > > Check kernel support via BT_ISO_PAST_POLLOUT, otherwise skip waitin=
g.
> > > >=20
> > > > Fixes test_bass_past_transport_* test failures.
> > > >=20
> > > > Assisted-by: LLM
> > > > ---
> > > >  profiles/audio/bass.c | 66 ++++++++++++++++++++++++++++++++++++++-=
----
> > > >  1 file changed, 59 insertions(+), 7 deletions(-)
> > > >=20
> > > > diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
> > > > index fd05195f3..90e758c08 100644
> > > > --- a/profiles/audio/bass.c
> > > > +++ b/profiles/audio/bass.c
> > > > @@ -146,7 +146,9 @@ struct bass_delegator {
> > > >         struct queue *bcode_reqs;
> > > >         struct queue *setups;
> > > >         unsigned int io_id;
> > > > +       unsigned int io_ready_id;
> > > >         GIOChannel *io;
> > > > +       bool past;
> > > >  };
> > > >=20
> > > >  struct bass_setup {
> > > > @@ -751,6 +753,11 @@ static void confirm_cb(GIOChannel *io, void *u=
ser_data)
> > > >=20
> > > >         DBG("");
> > > >=20
> > > > +       if (dg->io_ready_id) {
> > > > +               g_source_remove(dg->io_ready_id);
> > > > +               dg->io_ready_id =3D 0;
> > > > +       }
> > > > +
> > > >         /* Close the listen io */
> > > >         g_io_channel_shutdown(dg->io, TRUE, NULL);
> > > >         g_io_channel_unref(dg->io);
> > > > @@ -1528,11 +1535,28 @@ static bool delegator_match_device(const vo=
id *data, const void *match_data)
> > > >         return dg->device =3D=3D device;
> > > >  }
> > > >=20
> > > > +static gboolean pa_sync_ready_cb(GIOChannel *io, GIOCondition cond=
,
> > > > +                                                       gpointer us=
er_data)
> > > > +{
> > > > +       struct bass_delegator *dg =3D user_data;
> > > > +
> > > > +       dg->io_ready_id =3D 0;
> > > > +
> > > > +       if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL))
> > > > +               return FALSE;
> > > > +
> > > > +       bt_bass_set_pa_sync(dg->src, BT_BASS_SYNC_INFO_RE);
> > > > +
> > > > +       return FALSE;
> > > > +}
> > > > +
> > > >  static void delegator_attach(struct bt_bap *bap, struct btd_device=
 *device,
> > > >                                 struct btd_service *service)
> > > >  {
> > > >         struct bass_delegator *dg;
> > > >         GError *err =3D NULL;
> > > > +       socklen_t len;
> > > > +       int sk, past_pollout;
> > > >=20
> > > >         dg =3D queue_find(delegators, delegator_match_device, devic=
e);
> > > >         if (!dg)
> > > > @@ -1570,6 +1594,30 @@ static void delegator_attach(struct bt_bap *=
bap, struct btd_device *device,
> > > >=20
> > > >         /* Take ownership for the service by setting the user data.=
 */
> > > >         btd_service_set_user_data(service, dg);
> > > > +
> > > > +       if (!dg->past)
> > > > +               return;
> > > > +
> > > > +       sk =3D g_io_channel_unix_get_fd(dg->io);
> > > > +       len =3D sizeof(past_pollout);
> > > > +
> > > > +       if (getsockopt(sk, SOL_BLUETOOTH, BT_ISO_PAST_POLLOUT,
> > > > +                                               &past_pollout, &len=
) < 0) {
> > > > +               if (errno !=3D ENOPROTOOPT) {
> > > > +                       error("Unable to query PAST readiness suppo=
rt: %s",
> > > > +                                                       strerror(er=
rno));
> > > > +                       return;
> > > > +               }
> > > > +
> > > > +               past_pollout =3D 0;
> > > > +       }
> > >=20
> > > While I agree it needs fixing since not only it can create problem fo=
r
> > > testing but it may be possible to hit this over the air as well, the
> > > solution though is a little bitter to my taste, perhaps we could use
> > > to indicate when HCI_OP_LE_PAST_PARAMS has been completed (with
> > > status=3D0) then we notify with flags changed. If that is still a lit=
tle
> > > too much perhaps we can issue right away when setting upon receiving
> > > MGMT_OP_SET_DEVICE_FLAGS(HCI_CONN_FLAG_PAST) and somehow makeup for
> > > the qos arguments if conn->iso_qos is not set yet, either way that
> > > should gate the response of BT_BASS_SYNC_INFO_RE by indicating
> > > HCI_CONN_FLAG_PAST is actually programmed in the controller via
> > > HCI_OP_LE_PAST_PARAMS.
> >=20
> > Note the issue is not only waiting for HCI_OP_LE_PAST_PARAMS, but also
> > closing the race window before hdev->req_skb gets assigned, otherwise
> > it appears the hci_sync wait could miss early event and end up in
> > create_pa_complete() with error.
> >=20
> > We could ignore this as too small window (-> drop patch 1), but I'm not
> > certain it's impossible to hit, and LLMs will be complaining.
> >=20
> > IIUC you would rather signal readiness via MGMT than mess with poll(),
> > via eg. new MGMT device flags bit + inform bluetoothd via change
> > event? Controller settings would also allow backward-compatibility
> > detection.
> >=20
> > So: Keep patch 1 + signal PAST readiness via device flags bit?
>=20
> But for 1 to happen after we change to wait for the MGMT event that
> would mean the peer had sent ahead of receiving BT_BASS_SYNC_INFO_RE?
> We shall be waiting already once the MGMT signal trigger and we
> respond with BT_BASS_SYNC_INFO_RE, perhaps Im not understanding the
> race here, is that still about HCI_EV_LE_PAST_RECEIVED so we only do
> the MGMT event while waiting it?

1. HCI_OP_LE_PAST_PARAMS Command Completed -> hci_sync continues
2. hci_sync signals userspace via MGMT

3.1. Userspace sees MGMT signal, sends SYNC_INFO_RE notify to remote
3.2. Remote RX notify, execute PAST
3.3. Kernel handles HCI_EV_LE_PAST_RECEIVED
3.4. Event handler checks hdev->req_skb -> hci_cmd_sync_complete()
     If hdev->req_skb not set: no hci_sync wakeup

4.1. hci_sync enters __hci_cmd_sync_status_sk(hdev, HCI_OP_NOP, ...)
4.2. hci_req_sync_run=C2=A0sets=C2=A0 bt_cb(skb)->hci.req_complete_skb =3D
     hci_cmd_sync_complete, then queues hdev->cmd_wrk
4.3. cmd_work wakes up, hci_send_cmd_sync() sees HCI_OP_NOP and
     only sets hdev->req_skb (=3D PAST Received wait starts)

AFAICS the branches 3 and 4 are technically not ordered, so you could
end up in 3.4 before 4.3 and miss hci_cmd_sync_complete() wakeup.

This race is of course originally spotted by LLM, but I don't currently
see why it would be impossible, except the required timing is probably
very unlikely in reality.

> > > > +       if (past_pollout)
> > > > +               dg->io_ready_id =3D g_io_add_watch(dg->io,
> > > > +                               G_IO_OUT | G_IO_ERR | G_IO_HUP | G_=
IO_NVAL,
> > > > +                               pa_sync_ready_cb, dg);
> > > > +       else
> > > > +               bt_bass_set_pa_sync(dg->src, BT_BASS_SYNC_INFO_RE);
> > > >  }
> > > >=20
> > > >  static void bap_attached(struct bt_bap *bap, void *user_data)
> > > > @@ -1645,6 +1693,9 @@ static void delegator_free(struct bass_delega=
tor *dg)
> > > >         if (dg->io_id)
> > > >                 g_source_remove(dg->io_id);
> > > >=20
> > > > +       if (dg->io_ready_id)
> > > > +               g_source_remove(dg->io_ready_id);
> > > > +
> > > >         if (dg->io) {
> > > >                 g_io_channel_shutdown(dg->io, TRUE, NULL);
> > > >                 g_io_channel_unref(dg->io);
> > > > @@ -1906,7 +1957,7 @@ static void bass_detached(struct bt_bass *bas=
s, void *user_data)
> > > >=20
> > > >  static struct bass_delegator *
> > > >  bass_delegator_new(struct btd_device *device, struct bt_bcast_src =
*src,
> > > > -                       uint8_t sid)
> > > > +                       uint8_t sid, bool past)
> > > >  {
> > > >         struct bass_delegator *dg;
> > > >=20
> > > > @@ -1917,6 +1968,7 @@ bass_delegator_new(struct btd_device *device,=
 struct bt_bcast_src *src,
> > > >         dg->device =3D device;
> > > >         dg->src =3D src;
> > > >         dg->sid =3D sid;
> > > > +       dg->past =3D past;
> > > >         dg->bcode_reqs =3D queue_new();
> > > >         dg->setups =3D queue_new();
> > > >=20
> > > > @@ -1945,6 +1997,7 @@ static int handle_add_src_req(struct bt_bcast=
_src *bcast_src,
> > > >         struct btd_adapter *adapter =3D device_get_adapter(data->de=
vice);
> > > >         struct btd_device *device;
> > > >         struct bass_delegator *dg;
> > > > +       bool past =3D false;
> > > >=20
> > > >         /* Detect if PAST can be used then it can be used as destin=
ation since
> > > >          * PAST Receiver uses the ACL connection itself.
> > > > @@ -1957,6 +2010,7 @@ static int handle_add_src_req(struct bt_bcast=
_src *bcast_src,
> > > >                 if (btd_adapter_has_settings(data->adapter,
> > > >                                                 MGMT_SETTING_PAST_R=
ECEIVER)) {
> > > >                         device_set_past_support(data->device, true)=
;
> > > > +                       past =3D true;
> > > >                         device =3D data->device;
> > > >                         goto done;
> > > >                 }
> > > > @@ -1980,16 +2034,14 @@ done:
> > > >          * autonomously probed inside BAP.
> > > >          */
> > > >         if (!btd_device_get_service(device, BCAAS_UUID_STR)) {
> > > > -               dg =3D bass_delegator_new(device, bcast_src, params=
->sid);
> > > > +               dg =3D bass_delegator_new(device, bcast_src, params=
->sid, past);
> > > >                 if (!dg)
> > > >                         return -ENOMEM;
> > > > +
> > > > +               if (past)
> > > > +                       return 0;
> > > >         }
> > > >=20
> > > > -       /* Set PA sync state, this has to be done after probing oth=
erwise there
> > > > -        * is a race where the remote may receive BT_BASS_SYNC_INFO=
_RE and start
> > > > -        * PAST before the kernel has sent PAST Parameter command t=
hat enables
> > > > -        * receiving it.
> > > > -        */
> > > >         if (params->pa_sync =3D=3D PA_SYNC_PAST) {
> > > >                 if (btd_adapter_has_settings(data->adapter,
> > > >                                                 MGMT_SETTING_PAST_R=
ECEIVER))
> > > > --
> > > > 2.56.0
> > > >=20
> > > >=20
> > >=20
> >=20
> > --
> > Pauli Virtanen
>=20
>=20
