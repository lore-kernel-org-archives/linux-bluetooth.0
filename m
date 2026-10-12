Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD864F85B1
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 21:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791840706; cv=pass; b=aZbmYOnoaSQ9nt5+jCRyrG68JQMFEwCXRgSXGeKj4b09CadeWlo7sByiwihwVbVQOCplQnTXbr71kd9gXHpxTreXKeJYbpRc6QPeaeerchE1g/BtHa9BTx7L0MHRokKZQnOz7feKYNF/HPP8nv5w4Rpk9ncmUuMNhy53vsWjkkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791840706; c=relaxed/simple;
	bh=+CDRMpq7TQ7+885rDGn4QaSoeA1LC9gClHzyHtXbWS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fHnywwTZYB7617f45I/DzmNLFGZ+CPj7ElA1CvBZtblWGJ9JsT2qTMnFljaUhttZTx2qF+ZDj8wE5QOuvYjK1iJ+EVUXPKZdja17DxTEm+Lkfs4bl1xtyORVWZrZDojTXOgyOj5SHPrrlFyTa/YTaGSesrl9vfvY/rb8A6FWmnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IN5FRkWB; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IN5FRkWB"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8ac551be4d3so17076167b3.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 14:31:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791840704; cv=none;
        d=google.com; s=arc-20260327;
        b=Dfc1kIp7McgR0e0QdsUh5P3Xy+ESzg3xQjnH6L7OUB1b1qNITDl5fDjQ3HVLYFA1UI
         pHB7tF2u5aUwzDwGlS15u55y+YTCmAW6gBwPLDD3IeUqlQkn2uMl4/vMruhglW024OK1
         3mKHvaOBLZeYZmX6euBeTsWO5+5eoVKGwqwF1pfAcmEgsmRuRvHAnV2Ty52L01ywe+zB
         cRQnZs2DcMyf4tT/u960DL2gMt9gg+V0XJLEWzBUBkuieKRXC9uw7D+vfK61bJgrau94
         qfp2E5LLwLW0fZxuabVVJF7iB5UyWbpGbSZ0n/F8aVx/i8BsZraU0qFEJ2Wx5WjGzAdt
         Togg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uAyLqFXUp6xJy6kawON3dU5VgBD1EXJDs89eu0sDKtg=;
        fh=fAVvqa29TMCSLQ1BWo+IkeTh9vOt2h2EvlnFWIq0DOI=;
        b=cZmQB+TFQYak6/HSoEnhVUjYQL5q8bBZyWYj5CNhB+OSlXS+y5Fqrs3RicqaDnKSIs
         lcK2yP/Ic2bX3ovzDVKskokICGB3DGtUxxRJ83eKqiLqIP3DTg8USCovBWHc42XtDgDw
         b9hqu7Jb4mvjcTGmiVc4AhJtUdY21LOE8AUHDKSXUQwVyp8G7zMCqvNuByB8JiL2pmfN
         P7THFdqBqa22VwFGo8n7MNK/1SxkuubTAK9Qbsuh/8cq8jT+mY4OXEUNrtHHJ+o+C+Zy
         4VHTAbrn0hhgwWSA3o6sXtzivhtgRuHJ1LHHW0XiDB6UqvxAOgFp34LdtAuayIXmtzE6
         vdhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791840704; x=1792445504; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uAyLqFXUp6xJy6kawON3dU5VgBD1EXJDs89eu0sDKtg=;
        b=IN5FRkWB8Szy7LZln0gc7bRf0dd1UfxRXJs/TQ/QfAjkiMQF8Hsr/gKn60j6kK9HV5
         46WX0Pve0aM9i6yVELuaRG63NQLb4XAvgLVSy/in6pNgdR5ssJFq48Z7cPTmLsKZ2m1G
         lfyijTfz+5eZQdS9WAB239B7EytU21puIFBgYo40f4fmMEUVS022wyIwzagriLJE81VT
         5oslSYaR0OB+ec5VwxbeZ+4oCUSerVykd6WTGIHrjXrabEt0SkV1wa3ADFNxk60v2GAg
         0HrrAx/OmPjwE/Ti7typkq3ubsw6xG0Ds5MEQ9YG1Xzz4vQeImUdFeuFbdQDe02HhxQ0
         3Vdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791840704; x=1792445504;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uAyLqFXUp6xJy6kawON3dU5VgBD1EXJDs89eu0sDKtg=;
        b=daOkGm3rUlhPpYJRCMfKKbBMkrGndeAFk5FveFnZWLX4wBmsLCdy2WkbAXausaCJsn
         xEw/vZanbECygFAbWcBRXsrLOdFjYKHSV2tHAkMC/JIecCt3ViuFSbSne1Ifkic/fx6R
         yMHBbDVO7k7+xmz1U1BIgoa+gSjJwqf2E+vr9LPGwyI3++f8bwdZIjycodTFbNe7GvRH
         5J9/rfp51Y7QZ5SdWxUhNYpDM3MPxFwaI9ih5IWV1lK4iTjUBBTLwXuffXea1FoqvjAI
         XIKZX4l73vLBr8jh85Z7qNOSM2/L3I8uodAin4y/PqqLFmlEDvs5m3entY4M7zBFNET2
         tzNQ==
X-Gm-Message-State: AFq9FYL9log+45PwGgO9Hl0ljsmxLOG2MIgzUdKbD53c+U7370iLnRa1
	JOcEo5orHbGcfRO56eT5rZCDUdSeHvBQ2lwu/mrMaSayjQIkAsw15N1fTGdxU/7vWr0pp6Z9+tA
	Bzh5eHgNN2QZiBpG/6Z0xCoKuBS+WH7k=
X-Gm-Gg: AYBFou3hoNxhbSogcfiXhHRKTecD7QQr3vT5mob+JqstmiP5hBzsYEOE2Q+X7qewDhl
	PIlOTyndmDEyK9N3WlZmsZywIN5ACol7hCSfpl/cqITRIBzHMVS7SGClEuC9/WmgFA0CwAO2CmW
	PTxjtOhYA+LgD/vvkc9MyEQ7EdDBs50+PUbdMh34l3qADdI3/SLI4Yw6Ypk/8s0RDUfgMyVm/8m
	L+0bZ4M+pS+B3xwTk18PsdlQlnIkGb22IURahR/WgfLhSt0oxv3uQRZV0+QZTIMCbRaib0Y0jL5
	C6xRuet9uULcbC3CKgMoAaT3+foOhryrUS0arsge9+DURgZahMzeGS40VXYkgzkLMkWLFwbX3Cm
	q0BkEb6GhhWw9xbA4kk8bQwz5MgjjQ9HZWjYEEKLnaPk=
X-Received: by 2002:a05:690c:ec8:b0:882:b4b2:c49 with SMTP id
 00721157ae682-8b07edbd0afmr38048087b3.18.1791840704024; Mon, 12 Oct 2026
 14:31:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1791750393.git.pav@iki.fi> <5b5a8c1ebfe761606affcca1437c8a352fa0502a.1791750393.git.pav@iki.fi>
 <CABBYNZJ94rHYZ74GLyX7O4oTAbsWYSMccx6bzpods+BAQ=BwVA@mail.gmail.com>
 <6af116de4d8058516e11d789280fbf5bf2efeebb.camel@iki.fi> <CABBYNZJrQu=eqgRdu1Vq=VFF4fjdi-aCK07f464P4YUY-ou-9A@mail.gmail.com>
 <b53d70bf145c695372877b862299df3a49a830f2.camel@iki.fi>
In-Reply-To: <b53d70bf145c695372877b862299df3a49a830f2.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 12 Oct 2026 17:31:32 -0400
X-Gm-Features: AclHuK_CrPKNcUp6PsCa4P3zECJzsxpLPTHlWGB98SQZRMka-8rnibHzJKyHn0U
Message-ID: <CABBYNZJ9cvrG7d+oKL_1vXgEjfJtTnxBHhmVOFna7Rs6bXp1mQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 5/5] bass: wait for PAST listener readiness
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Mon, Oct 12, 2026 at 5:03=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi Luiz,
>
> ma, 2026-10-12 kello 16:40 -0400, Luiz Augusto von Dentz kirjoitti:
> > Hi Pauli,
> >
> > On Mon, Oct 12, 2026 at 4:24=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wro=
te:
> > >
> > > Hi Luiz,
> > >
> > > ma, 2026-10-12 kello 15:58 -0400, Luiz Augusto von Dentz kirjoitti:
> > > > On Sun, Oct 11, 2026 at 4:42=E2=80=AFPM Pauli Virtanen <pav@iki.fi>=
 wrote:
> > > > >
> > > > > Defer SYNC_INFO_RE until the PA sync listener signals POLLOUT, so=
 the
> > > > > Assistant cannot start PAST before receiver setup completes.
> > > > >
> > > > > Check kernel support via BT_ISO_PAST_POLLOUT, otherwise skip wait=
ing.
> > > > >
> > > > > Fixes test_bass_past_transport_* test failures.
> > > > >
> > > > > Assisted-by: LLM
> > > > > ---
> > > > >  profiles/audio/bass.c | 66 +++++++++++++++++++++++++++++++++++++=
+-----
> > > > >  1 file changed, 59 insertions(+), 7 deletions(-)
> > > > >
> > > > > diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
> > > > > index fd05195f3..90e758c08 100644
> > > > > --- a/profiles/audio/bass.c
> > > > > +++ b/profiles/audio/bass.c
> > > > > @@ -146,7 +146,9 @@ struct bass_delegator {
> > > > >         struct queue *bcode_reqs;
> > > > >         struct queue *setups;
> > > > >         unsigned int io_id;
> > > > > +       unsigned int io_ready_id;
> > > > >         GIOChannel *io;
> > > > > +       bool past;
> > > > >  };
> > > > >
> > > > >  struct bass_setup {
> > > > > @@ -751,6 +753,11 @@ static void confirm_cb(GIOChannel *io, void =
*user_data)
> > > > >
> > > > >         DBG("");
> > > > >
> > > > > +       if (dg->io_ready_id) {
> > > > > +               g_source_remove(dg->io_ready_id);
> > > > > +               dg->io_ready_id =3D 0;
> > > > > +       }
> > > > > +
> > > > >         /* Close the listen io */
> > > > >         g_io_channel_shutdown(dg->io, TRUE, NULL);
> > > > >         g_io_channel_unref(dg->io);
> > > > > @@ -1528,11 +1535,28 @@ static bool delegator_match_device(const =
void *data, const void *match_data)
> > > > >         return dg->device =3D=3D device;
> > > > >  }
> > > > >
> > > > > +static gboolean pa_sync_ready_cb(GIOChannel *io, GIOCondition co=
nd,
> > > > > +                                                       gpointer =
user_data)
> > > > > +{
> > > > > +       struct bass_delegator *dg =3D user_data;
> > > > > +
> > > > > +       dg->io_ready_id =3D 0;
> > > > > +
> > > > > +       if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL))
> > > > > +               return FALSE;
> > > > > +
> > > > > +       bt_bass_set_pa_sync(dg->src, BT_BASS_SYNC_INFO_RE);
> > > > > +
> > > > > +       return FALSE;
> > > > > +}
> > > > > +
> > > > >  static void delegator_attach(struct bt_bap *bap, struct btd_devi=
ce *device,
> > > > >                                 struct btd_service *service)
> > > > >  {
> > > > >         struct bass_delegator *dg;
> > > > >         GError *err =3D NULL;
> > > > > +       socklen_t len;
> > > > > +       int sk, past_pollout;
> > > > >
> > > > >         dg =3D queue_find(delegators, delegator_match_device, dev=
ice);
> > > > >         if (!dg)
> > > > > @@ -1570,6 +1594,30 @@ static void delegator_attach(struct bt_bap=
 *bap, struct btd_device *device,
> > > > >
> > > > >         /* Take ownership for the service by setting the user dat=
a. */
> > > > >         btd_service_set_user_data(service, dg);
> > > > > +
> > > > > +       if (!dg->past)
> > > > > +               return;
> > > > > +
> > > > > +       sk =3D g_io_channel_unix_get_fd(dg->io);
> > > > > +       len =3D sizeof(past_pollout);
> > > > > +
> > > > > +       if (getsockopt(sk, SOL_BLUETOOTH, BT_ISO_PAST_POLLOUT,
> > > > > +                                               &past_pollout, &l=
en) < 0) {
> > > > > +               if (errno !=3D ENOPROTOOPT) {
> > > > > +                       error("Unable to query PAST readiness sup=
port: %s",
> > > > > +                                                       strerror(=
errno));
> > > > > +                       return;
> > > > > +               }
> > > > > +
> > > > > +               past_pollout =3D 0;
> > > > > +       }
> > > >
> > > > While I agree it needs fixing since not only it can create problem =
for
> > > > testing but it may be possible to hit this over the air as well, th=
e
> > > > solution though is a little bitter to my taste, perhaps we could us=
e
> > > > to indicate when HCI_OP_LE_PAST_PARAMS has been completed (with
> > > > status=3D0) then we notify with flags changed. If that is still a l=
ittle
> > > > too much perhaps we can issue right away when setting upon receivin=
g
> > > > MGMT_OP_SET_DEVICE_FLAGS(HCI_CONN_FLAG_PAST) and somehow makeup for
> > > > the qos arguments if conn->iso_qos is not set yet, either way that
> > > > should gate the response of BT_BASS_SYNC_INFO_RE by indicating
> > > > HCI_CONN_FLAG_PAST is actually programmed in the controller via
> > > > HCI_OP_LE_PAST_PARAMS.
> > >
> > > Note the issue is not only waiting for HCI_OP_LE_PAST_PARAMS, but als=
o
> > > closing the race window before hdev->req_skb gets assigned, otherwise
> > > it appears the hci_sync wait could miss early event and end up in
> > > create_pa_complete() with error.
> > >
> > > We could ignore this as too small window (-> drop patch 1), but I'm n=
ot
> > > certain it's impossible to hit, and LLMs will be complaining.
> > >
> > > IIUC you would rather signal readiness via MGMT than mess with poll()=
,
> > > via eg. new MGMT device flags bit + inform bluetoothd via change
> > > event? Controller settings would also allow backward-compatibility
> > > detection.
> > >
> > > So: Keep patch 1 + signal PAST readiness via device flags bit?
> >
> > But for 1 to happen after we change to wait for the MGMT event that
> > would mean the peer had sent ahead of receiving BT_BASS_SYNC_INFO_RE?
> > We shall be waiting already once the MGMT signal trigger and we
> > respond with BT_BASS_SYNC_INFO_RE, perhaps Im not understanding the
> > race here, is that still about HCI_EV_LE_PAST_RECEIVED so we only do
> > the MGMT event while waiting it?
>
> 1. HCI_OP_LE_PAST_PARAMS Command Completed -> hci_sync continues
> 2. hci_sync signals userspace via MGMT
>
> 3.1. Userspace sees MGMT signal, sends SYNC_INFO_RE notify to remote
> 3.2. Remote RX notify, execute PAST
> 3.3. Kernel handles HCI_EV_LE_PAST_RECEIVED
> 3.4. Event handler checks hdev->req_skb -> hci_cmd_sync_complete()
>      If hdev->req_skb not set: no hci_sync wakeup
>
> 4.1. hci_sync enters __hci_cmd_sync_status_sk(hdev, HCI_OP_NOP, ...)
> 4.2. hci_req_sync_run sets  bt_cb(skb)->hci.req_complete_skb =3D
>      hci_cmd_sync_complete, then queues hdev->cmd_wrk
> 4.3. cmd_work wakes up, hci_send_cmd_sync() sees HCI_OP_NOP and
>      only sets hdev->req_skb (=3D PAST Received wait starts)
>
> AFAICS the branches 3 and 4 are technically not ordered, so you could
> end up in 3.4 before 4.3 and miss hci_cmd_sync_complete() wakeup.
>
> This race is of course originally spotted by LLM, but I don't currently
> see why it would be impossible, except the required timing is probably
> very unlikely in reality.

I see; branch 3 requires some IO/response that branch 4 lacks, but I
see the point that the lack of ordering could theoretically cause
issues later, making it better to fix now. Patch 1 is not that small,
so it might be worth considering whether we should require the listen
to occur before notifying the MGMT API requiring a ISO socket
operation isn't the cleanest approach, but if we must enforce
ordering, I suppose that's the only way.

>
> > > > > +       if (past_pollout)
> > > > > +               dg->io_ready_id =3D g_io_add_watch(dg->io,
> > > > > +                               G_IO_OUT | G_IO_ERR | G_IO_HUP | =
G_IO_NVAL,
> > > > > +                               pa_sync_ready_cb, dg);
> > > > > +       else
> > > > > +               bt_bass_set_pa_sync(dg->src, BT_BASS_SYNC_INFO_RE=
);
> > > > >  }
> > > > >
> > > > >  static void bap_attached(struct bt_bap *bap, void *user_data)
> > > > > @@ -1645,6 +1693,9 @@ static void delegator_free(struct bass_dele=
gator *dg)
> > > > >         if (dg->io_id)
> > > > >                 g_source_remove(dg->io_id);
> > > > >
> > > > > +       if (dg->io_ready_id)
> > > > > +               g_source_remove(dg->io_ready_id);
> > > > > +
> > > > >         if (dg->io) {
> > > > >                 g_io_channel_shutdown(dg->io, TRUE, NULL);
> > > > >                 g_io_channel_unref(dg->io);
> > > > > @@ -1906,7 +1957,7 @@ static void bass_detached(struct bt_bass *b=
ass, void *user_data)
> > > > >
> > > > >  static struct bass_delegator *
> > > > >  bass_delegator_new(struct btd_device *device, struct bt_bcast_sr=
c *src,
> > > > > -                       uint8_t sid)
> > > > > +                       uint8_t sid, bool past)
> > > > >  {
> > > > >         struct bass_delegator *dg;
> > > > >
> > > > > @@ -1917,6 +1968,7 @@ bass_delegator_new(struct btd_device *devic=
e, struct bt_bcast_src *src,
> > > > >         dg->device =3D device;
> > > > >         dg->src =3D src;
> > > > >         dg->sid =3D sid;
> > > > > +       dg->past =3D past;
> > > > >         dg->bcode_reqs =3D queue_new();
> > > > >         dg->setups =3D queue_new();
> > > > >
> > > > > @@ -1945,6 +1997,7 @@ static int handle_add_src_req(struct bt_bca=
st_src *bcast_src,
> > > > >         struct btd_adapter *adapter =3D device_get_adapter(data->=
device);
> > > > >         struct btd_device *device;
> > > > >         struct bass_delegator *dg;
> > > > > +       bool past =3D false;
> > > > >
> > > > >         /* Detect if PAST can be used then it can be used as dest=
ination since
> > > > >          * PAST Receiver uses the ACL connection itself.
> > > > > @@ -1957,6 +2010,7 @@ static int handle_add_src_req(struct bt_bca=
st_src *bcast_src,
> > > > >                 if (btd_adapter_has_settings(data->adapter,
> > > > >                                                 MGMT_SETTING_PAST=
_RECEIVER)) {
> > > > >                         device_set_past_support(data->device, tru=
e);
> > > > > +                       past =3D true;
> > > > >                         device =3D data->device;
> > > > >                         goto done;
> > > > >                 }
> > > > > @@ -1980,16 +2034,14 @@ done:
> > > > >          * autonomously probed inside BAP.
> > > > >          */
> > > > >         if (!btd_device_get_service(device, BCAAS_UUID_STR)) {
> > > > > -               dg =3D bass_delegator_new(device, bcast_src, para=
ms->sid);
> > > > > +               dg =3D bass_delegator_new(device, bcast_src, para=
ms->sid, past);
> > > > >                 if (!dg)
> > > > >                         return -ENOMEM;
> > > > > +
> > > > > +               if (past)
> > > > > +                       return 0;
> > > > >         }
> > > > >
> > > > > -       /* Set PA sync state, this has to be done after probing o=
therwise there
> > > > > -        * is a race where the remote may receive BT_BASS_SYNC_IN=
FO_RE and start
> > > > > -        * PAST before the kernel has sent PAST Parameter command=
 that enables
> > > > > -        * receiving it.
> > > > > -        */
> > > > >         if (params->pa_sync =3D=3D PA_SYNC_PAST) {
> > > > >                 if (btd_adapter_has_settings(data->adapter,
> > > > >                                                 MGMT_SETTING_PAST=
_RECEIVER))
> > > > > --
> > > > > 2.56.0
> > > > >
> > > > >
> > > >
> > >
> > > --
> > > Pauli Virtanen
> >
> >



--=20
Luiz Augusto von Dentz
