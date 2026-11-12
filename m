Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794519747;
	b=PITYyHypLlLMkRRgEuucgWy+K+5fHmGYD2E2W0yfbN8NHSVAgjs700Sy033vnHzPrNHq
	 m3PvNCS1b2hm4OX0zJV7AnCw2TYe8TQNwl1Md/H5a3qkokrYef0BAwcvz/WzQ23+6204/
	 sNHIuBboEdqvUGGWUbmjw5zm5VAgTa9dzc5Yf33GbP+0T5SZ4Oj/Qf/EXb5w+icd9N5jU
	 guCHBuAJ1tKaNnYcxeKPbksPx/pU2ZknElOy7shSWI8ZdfFriuCHaUuiRaf1VJHyWSJ9R
	 k82mGita1+r9OIzXAgX/skbV2A48zp0+giQwUkj93kH8VXSoc4++WDh/roGfm+MIvxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794519747;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=9IcyXbdUhoLM9AX2gltsWZGtMspy7VkVz1qCGqgjj5s=;
	b=elVua/iqAubHoYwDrSiuzxUpyU03DLlAWvfGYJQkWTy+muX09mYFu6uADA1wxuniwySG
	 OvcVBnr7O5ribP6uEEg+U0y+ANkKzbF379YaCXUE/f666Y45mtODK5M1+VqSeL2zZmV4w
	 nTOmGvioqspHB7DcRlc0gN/4OqfgbjX5lNXY0PdqwACg1pW3IGpINCwvfJ+ZNAxz9x1VV
	 bjwRK1siBWfZFcK4PDPp3XRPSgk6V8EvPQyKIJ3CsbGRKLbTFfiBpGsxIjgcVfqJNZoHe
	 NTWXYUot6ps2ZWPYQ6x/9En2deQouBKv8mnlxPwCR4FuAyK+yuHJKhxC/TLxM6ULSAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=KLfnPggX;
	arc=none smtp.remote-ip=109.224.244.17
Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983ED606A327
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 21:42:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 983ED606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=KLfnPggX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1794519743; x=1794778943;
	bh=9IcyXbdUhoLM9AX2gltsWZGtMspy7VkVz1qCGqgjj5s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=KLfnPggXmvJh+EBFsv2FjrSeinQguOwEDhzBeARYb3g2f5jPgu210kbviJIsMtV9T
	 ipNge2mtOWeu2OKmQd0p3ev4+fB0Po4yL1+yt09SjPnSU5WaAF44JM8s3a7O4R0i4k
	 LNn/lJr6McVlU4YlCpBEwxTbg5UIzO1KLAgR3UTrm3uTf2AaIiVLe0iN/+wipJfZpI
	 qU4pmEPJdPjmsJ70a5ac+pJ3yOBfCDV30rEnyuMW1SmKrJH5wHg8ZqMOb/tB2HaUfC
	 0taFyIY0hWHrkCsGuWZiNAjM0ThB1CdNxh7kdrPFEXbU5g0LsYwSEQW8Lvti/axd5f
	 Q6VBjN/j5a2Yg==
Date: Thu, 12 Nov 2026 21:42:17 +0000
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
From: cochcoder <cochcoder@proton.me>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: Re: [RFC PATCH v3] asha: Defer BR/EDR inquiry while streaming
Message-ID: <rNJ1WcibKCaCy6uFxRuBzmB_s2x_MfnWijHpsutNOn4LS7jMxr3lZCUVHV5nOQ7bTC_Gsb8m8uIrU9HsY9t5sX6OrsZVF53NIp5m_HMGOWo=@proton.me>
In-Reply-To: <CABBYNZ+U6C8aWRXcOuQzZeE_JvTcXiYK57dO0fBKMOeZ6U40Jg@mail.gmail.com>
References: <20261028133243.262314-1-cochcoder@proton.me> <20261107014841.1452698-1-cochcoder@proton.me> <20261107024655.1481992-1-cochcoder@proton.me> <CABBYNZ+U6C8aWRXcOuQzZeE_JvTcXiYK57dO0fBKMOeZ6U40Jg@mail.gmail.com>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 827763c9eff8427b791698092b4de6af068e21f3
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,=20

Thanks for the reviewing this. Please consider this patch withdrawn.

This was an early experiment I was messing around with from before I
had a working ASHA stream, and I forgot to withdraw it later.=20
My current stack is streaming successfully without it.=20

Sorry for the confusion,
Kyle Pepper



On Tuesday, November 10th, 2026 at 4:30 PM, Luiz Augusto von Dentz <luiz.de=
ntz@gmail.com> wrote:

> Hi Arun,
>=20
> On Fri, Nov 6, 2026 at 9:47=E2=80=AFPM Kyle Pepper <cochcoder@proton.me> =
wrote:
> >
> > Defer BR/EDR inquiry while ASHA streams are active. Keep LE discovery
> > available and preserve client filters for restoration after audio stops=
.
> > Return Busy if a new request leaves no permitted scan type. Recheck
> > pending discovery starts when audio changes.
> >
> > Release the stream count when START cannot be queued or its callback
> > reports failure, so a failed acquisition cannot keep inquiry suppressed=
.
> >
> > Assisted-by: OpenCode:gpt-6.1-sol
> > Assisted-by: Codex:gpt-6
> > ---
> > v3: Wrap the unref call and shorten a comment to meet the
> > 80-column limit. No behavior changes from v2.
> >
> > Previous version:
> > https://lore.kernel.org/linux-bluetooth/20261107014841.1452698-1-cochco=
der@proton.me/
> >
> > v2 CI: CheckPatch failed on these two long lines; the other
> > 11 checks passed. Native MGMT/client arbitration and isolated
> > hardware validation remain open.
> >
> >  profiles/audio/asha.c | 47 ++++++++++++++++++++++++---
> >  src/adapter.c         | 75 ++++++++++++++++++++++++++++++++++++++++---
> >  src/adapter.h         |  4 +++
> >  3 files changed, 117 insertions(+), 9 deletions(-)
> >
> > diff --git a/profiles/audio/asha.c b/profiles/audio/asha.c
> > index 8e625fdca3..d1fcddbcee 100644
> > --- a/profiles/audio/asha.c
> > +++ b/profiles/audio/asha.c
> > @@ -60,8 +60,36 @@ struct bt_asha_device {
> >         uint16_t imtu, omtu;
> >
> >         unsigned int resume_id;
> > +       bool streaming_counted;
> > +       bt_asha_cb_t start_cb;
> > +       void *start_cb_data;
> >  };
> >
> > +static void asha_set_streaming(struct bt_asha_device *asha_dev, bool s=
treaming)
> > +{
> > +       if (streaming =3D=3D asha_dev->streaming_counted)
> > +               return;
> > +
> > +       if (streaming)
> > +               btd_adapter_le_audio_ref(device_get_adapter(asha_dev->d=
evice));
> > +       else
> > +               btd_adapter_le_audio_unref(
> > +                                       device_get_adapter(asha_dev->de=
vice));
> > +
> > +       asha_dev->streaming_counted =3D streaming;
> > +}
> > +
> > +static void asha_start_cb(int status, void *user_data)
> > +{
> > +       struct bt_asha_device *asha_dev =3D user_data;
> > +
> > +       if (status)
> > +               asha_set_streaming(asha_dev, false);
> > +
> > +       if (asha_dev->start_cb)
> > +               asha_dev->start_cb(status, asha_dev->start_cb_data);
> > +}
> > +
> >  static char *make_endpoint_path(struct bt_asha_device *asha_dev)
> >  {
> >         char *path;
> > @@ -91,6 +119,7 @@ static void connect_cb(GIOChannel *io, GError *err, =
gpointer user_data)
> >
> >         if (err) {
> >                 error("%s", err->message);
> > +               asha_set_streaming(asha_dev, false);
> >                 return;
> >         }
> >
> > @@ -107,8 +136,11 @@ static void connect_cb(GIOChannel *io, GError *err=
, gpointer user_data)
> >
> >         asha_dev->io =3D io;
> >
> > -       bt_asha_start(asha_dev->asha, conn_data->cb,
> > -                                       conn_data->cb_user_data);
> > +       asha_dev->start_cb =3D conn_data->cb;
> > +       asha_dev->start_cb_data =3D conn_data->cb_user_data;
> > +
> > +       if (bt_asha_start(asha_dev->asha, asha_start_cb, asha_dev))
> > +               asha_set_streaming(asha_dev, false);
> >  }
> >
> >  static int asha_connect_socket(struct bt_asha_device *asha_dev,
> > @@ -171,12 +203,15 @@ unsigned int bt_asha_device_start(struct bt_asha_=
device *asha_dev,
> >
> >         if (ret < 0)
> >                 return 0;
> > -       else
> > -               return (++asha_dev->resume_id);
> > +
> > +       asha_set_streaming(asha_dev, true);
> > +       return (++asha_dev->resume_id);
> >  }
> >
> >  unsigned int bt_asha_device_stop(struct bt_asha_device *asha_dev)
> >  {
> > +       asha_set_streaming(asha_dev, false);
> > +
> >         bt_asha_stop(asha_dev->asha);
> >
> >         if (asha_dev->io) {
> > @@ -190,6 +225,8 @@ unsigned int bt_asha_device_stop(struct bt_asha_dev=
ice *asha_dev)
> >
> >  void bt_asha_device_state_reset(struct bt_asha_device *asha_dev)
> >  {
> > +       asha_set_streaming(asha_dev, false);
> > +
> >         if (asha_dev->io) {
> >                 g_io_channel_shutdown(asha_dev->io, TRUE, NULL);
> >                 g_io_channel_unref(asha_dev->io);
> > @@ -371,6 +408,8 @@ static void asha_source_device_remove(struct btd_se=
rvice *service)
> >                 return;
> >         }
> >
> > +       asha_set_streaming(asha_dev, false);
> > +
> >         bt_asha_free(asha_dev->asha);
> >         g_free(asha_dev);
> >  }
> > diff --git a/src/adapter.c b/src/adapter.c
> > index 6588a6e2bd..16a0920923 100644
> > --- a/src/adapter.c
> > +++ b/src/adapter.c
> > @@ -304,6 +304,7 @@ struct btd_adapter {
> >                                          * without delay */
> >         uint8_t discovery_type;         /* current active discovery typ=
e */
> >         uint8_t discovery_enable;       /* discovery enabled/disabled *=
/
> > +       unsigned int le_audio_active;   /* Active ASHA streams */
> >         bool discovery_suspended;       /* discovery has been suspended=
 */
> >         bool discovery_discoverable;    /* discoverable while discoveri=
ng */
> >         GSList *discovery_list;         /* list of discovery clients */
> > @@ -1886,6 +1887,8 @@ static void discovery_remove(struct discovery_cli=
ent *client)
> >  }
> >
> >  static void trigger_start_discovery(struct btd_adapter *adapter, guint=
 delay);
> > +static int update_discovery_filter(struct btd_adapter *adapter);
> > +static uint8_t discovery_scan_type(struct btd_adapter *adapter);
> >
> >  static struct discovery_client *discovery_complete(struct btd_adapter =
*adapter,
> >                                                 uint8_t status)
> > @@ -1964,6 +1967,11 @@ static void start_discovery_complete(uint8_t sta=
tus, uint16_t length,
> >
> >                 discovery_complete(adapter, status);
> >
> > +               /* Audio or filters may change while START is pending. =
*/
> > +               if (!adapter->discovery_suspended &&
> > +                   adapter->discovery_type !=3D discovery_scan_type(ad=
apter))
> > +                       trigger_start_discovery(adapter, 0);
> > +
> >                 if (adapter->discovering)
> >                         return;
> >
> > @@ -1987,23 +1995,39 @@ static void start_discovery_complete(uint8_t st=
atus, uint16_t length,
> >         trigger_start_discovery(adapter, IDLE_DISCOV_TIMEOUT * 2);
> >  }
> >
> > +static uint8_t discovery_scan_type(struct btd_adapter *adapter)
> > +{
> > +       uint8_t type =3D adapter->current_discovery_filter ?
> > +                               adapter->current_discovery_filter->type=
 :
> > +                               get_scan_type(adapter);
> > +
> > +       if (adapter->le_audio_active)
> > +               type &=3D ~SCAN_TYPE_BREDR;
> > +
> > +       return type;
> > +}
> > +
> >  static bool start_discovery_timeout(gpointer user_data)
> >  {
> >         struct btd_adapter *adapter =3D user_data;
> >         struct mgmt_cp_start_service_discovery *sd_cp;
> > +       size_t sd_len;
> >         uint8_t new_type;
> >
> >         DBG("");
> >
> >         adapter->discovery_idle_timeout =3D 0;
> >
> > +       if (!adapter->discovery_list || adapter->discovery_suspended)
> > +               return FALSE;
> > +
> >         /* If we're doing filtered discovery, it must be quickly restar=
ted */
> >         adapter->no_scan_restart_delay =3D !!adapter->current_discovery=
_filter;
> >
> >         DBG("adapter->current_discovery_filter =3D=3D %d",
> >             !!adapter->current_discovery_filter);
> >
> > -       new_type =3D get_scan_type(adapter);
> > +       new_type =3D discovery_scan_type(adapter);
> >
> >         if (adapter->discovery_enable =3D=3D 0x01) {
> >                 struct mgmt_cp_stop_discovery cp;
> > @@ -2047,11 +2071,27 @@ static bool start_discovery_timeout(gpointer us=
er_data)
> >
> >         }
> >
> > +       if (!new_type) {
> > +               struct discovery_client *client;
> > +
> > +               /* Reject new requests; keep sessions until audio stops=
. */
> > +               client =3D discovery_complete(adapter, MGMT_STATUS_BUSY=
);
> > +               if (client) {
> > +                       discovery_remove(client);
> > +
> > +                       if (adapter->discovery_list)
> > +                               update_discovery_filter(adapter);
> > +               }
> > +
> > +               return FALSE;
> > +       }
> > +
> >         /* Regular discovery is required */
> >         if (!adapter->current_discovery_filter) {
> >                 struct mgmt_cp_start_discovery cp;
> >
> >                 cp.type =3D new_type;
> > +
> >                 mgmt_send(adapter->mgmt, MGMT_OP_START_DISCOVERY,
> >                                         adapter->dev_id, sizeof(cp), &c=
p,
> >                                         start_discovery_complete, adapt=
er,
> > @@ -2060,18 +2100,25 @@ static bool start_discovery_timeout(gpointer us=
er_data)
> >                 return FALSE;
> >         }
> >
> > -       /* Filtered discovery is required */
> > -       sd_cp =3D adapter->current_discovery_filter;
> > +       /* Keep the requested filter intact for when audio stops. */
> > +       sd_len =3D sizeof(*sd_cp) +
> > +               btohs(adapter->current_discovery_filter->uuid_count) * =
16;
> > +       sd_cp =3D util_memdup(adapter->current_discovery_filter, sd_len=
);
> > +       if (!sd_cp)
> > +               return FALSE;
> > +
> > +       sd_cp->type =3D new_type;
> >
> >         DBG("sending MGMT_OP_START_SERVICE_DISCOVERY %d, %d, %d",
> >                                 sd_cp->rssi, sd_cp->type,
> >                                 btohs(sd_cp->uuid_count));
> >
> >         mgmt_send(adapter->mgmt, MGMT_OP_START_SERVICE_DISCOVERY,
> > -                 adapter->dev_id, sizeof(*sd_cp) +
> > -                 btohs(sd_cp->uuid_count) * 16,
> > +                 adapter->dev_id, sd_len,
> >                   sd_cp, start_discovery_complete, adapter, NULL);
> >
> > +       free(sd_cp);
> > +
> >         return FALSE;
> >  }
> >
> > @@ -6358,6 +6405,24 @@ struct btd_adapter *btd_adapter_ref(struct btd_a=
dapter *adapter)
> >         return adapter;
> >  }
> >
> > +void btd_adapter_le_audio_ref(struct btd_adapter *adapter)
> > +{
> > +       if (adapter->le_audio_active++)
> > +               return;
> > +
> > +       if (adapter->discovery_list && !adapter->discovery_suspended)
> > +               trigger_start_discovery(adapter, 0);
> > +}
> > +
> > +void btd_adapter_le_audio_unref(struct btd_adapter *adapter)
> > +{
> > +       if (!adapter->le_audio_active || --adapter->le_audio_active)
> > +               return;
> > +
> > +       if (adapter->discovery_list && !adapter->discovery_suspended)
> > +               trigger_start_discovery(adapter, 0);
> > +}
> > +
> >  void btd_adapter_unref(struct btd_adapter *adapter)
> >  {
> >         if (__sync_sub_and_fetch(&adapter->ref_count, 1))
> > diff --git a/src/adapter.h b/src/adapter.h
> > index 583168f4bc..d5cda2d96b 100644
> > --- a/src/adapter.h
> > +++ b/src/adapter.h
> > @@ -119,6 +119,10 @@ bool btd_adapter_uuid_is_allowed(struct btd_adapte=
r *adapter, const char *uuid);
> >  struct btd_adapter *btd_adapter_ref(struct btd_adapter *adapter);
> >  void btd_adapter_unref(struct btd_adapter *adapter);
> >
> > +/* Defer BR/EDR discovery while ASHA streams are active. */
> > +void btd_adapter_le_audio_ref(struct btd_adapter *adapter);
> > +void btd_adapter_le_audio_unref(struct btd_adapter *adapter);
>=20
> Ok, I don't think I agree with this design. First, what does BR/EDR
> have to do with ASHA streams? I thought ASHA was LE only, and then the
> naming says le_audio_ref? ASHA is not LE Audio. If we want to express
> conflicts, that needs to be part of the driver resolving logic at the
> core so it doesn't probe conflicting drivers.
>=20
> >  void btd_adapter_set_class(struct btd_adapter *adapter, uint8_t major,
> >                                                         uint8_t minor);
> >  int btd_adapter_set_name(struct btd_adapter *adapter, const char *name=
);
> >
> > base-commit: a8067198717b38391ca183ed7f41a69ec4b81b6e
> > --
> > 2.56.0
> >
> >
>=20
>=20
> --
> Luiz Augusto von Dentz
> 
