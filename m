Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794346233;
	b=3DFMgvXw8RrGexe8fHElyth7zT34YyRMFa0w9N1haRkqTILzH7PPv3U9ZJHtowAU2Ryb
	 v7cIAJ7CYtO1XdkkfQuUmE0dPwq6xM2TJZCFmQUh5TGc7oe9BSc27W03/J2zfASkIx82N
	 h/BMTf7U3qSehFv3fIsZBMdWo38HSrIoAS1qw5VeBPoAkNSjRghVVuSS9zTEYNa9/xtA9
	 VtBMg/SIowhyxA1p7/p1ok1gik4xvjTCYx+MQnVIJnvKjya1mDTDWMrF82juLoAzQIpT3
	 z7Yt8a4ieK6GGl2IQ6X7dTVIRXq4ybLVZcosR4U82+vESfi8L4PQWIi46Dvf6PZOyJA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794346233;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=XByXhRE2fE6AqWKvOVJqEyHNpge3Qnex3l9toGmHYO0=;
	b=ADsfo+XpNGI8gYOEYX9PHfEFD+rOurhPgxgJVHZjj4tjCT8Me9thohQhOzClS5xOxcsi
	 eGKfHnmdEBSVzUbUfpyVWPK2kUtz/GuaSzjX6rjEVZ80icwsOTCtHrecm2mTcCXx/wvQU
	 NhmpDeOSlIVm7iGYzESER8qhhBrZBSaWS2mnIte1JE4z0Dj4nSEeAiO6MLUDiEJrP9RwQ
	 7M19P8m5k8lvu3cahKOentHyw6JdNdjgJILMHlY1oY0sHKRFLQvNwId17DCdf70bQjjaz
	 I2SeN1ukVKavck/l/UzgCHy5DmadsHl+67PfvAo9jq45oGfCBqF5fZigKtQvsMObseg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="uahZ/yf7";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.52
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F6F606A31C
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 21:30:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7F6F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uahZ/yf7
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-67c2c2ac1c3so3865357d50.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 13:30:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794346232; cv=none;
        d=google.com; s=arc-20260327;
        b=DlGdITvWily3b5dcZi4fveYccj5GZwnPZhpR//rP0a0Nl4ThQN1DujZ3jreQhlnko8
         sYZEDBdzLX+HtanVkK6/ZShz2j/DGOWnNCQivd6pNNgCONkQ3dhmEEFhDN6pSQ6hhn4r
         oPoD+kyPEJtCCRRcrxIn3vI2TvosZAO5gS6xZUr5Zro77Js378t0menqJwilA+atRo70
         0GTeKbMmKL4XTypSRZ71iKaenNtJT4NtiilT09qBxNsyqndZnvCapRJYqmXIkGVzricU
         2ZjFg7cv2AncS1ygEQ2nkWPapXh4vIKcTHlUS7ODYo6C7zzw1ERuuKkPzDQQPB0/a02j
         Wf3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XByXhRE2fE6AqWKvOVJqEyHNpge3Qnex3l9toGmHYO0=;
        fh=LUWgbrUuhMtahyXO6QT454ErJE9yEFx36d0SI3GxXhQ=;
        b=MLnUjbutKvbVa7mXQKmUQFSTTjnXC7dpgDI4Rm7AQdiI3W5EJjsAkWZxo/JmPG5Zw2
         uj6IPRXTkjC379Vco/Q3mDJmPJtFTyUrnWkAEPSbTTRlJjWnWysVd1sdQL6BE99rqQ8G
         C/bsyOtlyoOWpZ7Zlq0fY5R2Z2laEpB5MkuF/TKn7uUmsixcS6UvG8cSHoiWTA1c12RR
         oo0QyD1xNH2QKuaMaa3NOTMs+OWxnMjkCxXHLGQ1IT13DNH/rMcQiSqR+eHA+fpXd0er
         r8WShSb/Zw7pzm28p/PWbDeVUCo+PowDOi2JaEAMIk1rtzP02MDE46xtNvry2F/KRHOH
         3TdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794346232; x=1794951032; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XByXhRE2fE6AqWKvOVJqEyHNpge3Qnex3l9toGmHYO0=;
        b=uahZ/yf7gen+C3eppNwLJV9ghc2fxEL6FM6UOKmee8Z27bAsxlWQHi7HDMKsY1jIUz
         gD5K57QX/MsSQ+vLVHjOOWQMAQSUH3FHzJADMkig/nlPs/CRWgasptBt3qUJnWhTIPb8
         td3Ambbfnv8NRiL9B2wX1VR6O8ghBBosXe0KQXwQ358UcAGjc5Ix5bDKDxGpSVo4AISq
         YJZHwNgX7+eT7DPGlv5Zs2KQ0XxbltqtQaXwsnTt+JaRK9vWMfrFV0fkcA4hYG8qTrnb
         b+8PCWOWg31qqP7UXxzEupQ1R9se1PlWhW62P9dGG8ufbXgLiT6IJiptORd95XQyguox
         JIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794346232; x=1794951032;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XByXhRE2fE6AqWKvOVJqEyHNpge3Qnex3l9toGmHYO0=;
        b=sVYXJLniupDkAhQtgRDxaxpOYFmR8ajsNL/4KB59TCQh3P/+KD+tWxfniolgo3mzqf
         NfQxUxXwk0WdG3a7pJgaJgDhdyYMVb0m1gxuoXPRWwjwV09Tr1jrC9t/K+9B0b1evYCu
         bJnEN22MthI1P96YL24z0afUmdHNWXFtLS8HiokN6/BdNy2fZHgHsoqiKQ/ysQdJf9vh
         2vzzjjzWnfKgYS33yBcAxBLYfUD9poypUiq7jZOYXhlx8HSiNPaLIyqFQSww6rx824TR
         fBrbkaoFFlGuf0UzK9BQJeWWe5AXM8reL4N6yNIJDTxj0C/64P44EuthgKF192CcGWib
         +vwA==
X-Gm-Message-State: APuU4Z+EWk467nb25tuWeXP6Ad0WxAfgxv8SN/3H2r65nw/E7Ib5bu47
	VkWvyiz/FXJajZ6gpCO31neZ/6N8TvKY7ZFa31H0b0zlrbSOKgb0WLXi1VJn+pCE8cP6J4dAPSi
	I9DsqnFIt0YF0KpdBAPwXLvX1zg2TLyI=
X-Gm-Gg: AYBFou2ZAnC9w54M8KTMzym1nlD8CtBb+eekKP1w0Qg7rL5WYAOgR0u/0CUNc+nN9lj
	mojWwlYwcryNmkFFYFcEhFcWvS1Jy5SgZWlO1uLPM7Mz4EgSZ4uPnGu+tOphRjesm6PfTij2BX8
	ekp/o1lR9O8/TDcBaQb247LA6IlQNrmPX+I+oEUl6giaXQXA+U+s7W/0eo8E9Mzl/zcLjOXxCLp
	6emTMyBTAzlSe1kApXXfRW1Vc4lXC6pKj+6/r6cjIpM6tgahj9TgQepqGcaosgHzbk0YMWNB224
	oipcUU1pCQm9rwks/ZKyWu1/d8kgjl/1rjzp3JVPBA5E1LvHD/SdJ5TqI2+xD0eaJouFVyMW14B
	6LlgattYhRR/HlIQUJ/8DA4OfTqhgv2qq9iDfsprv+YVDXvcKZKXKmfq8EjWDlviMg8k21Eac5X
	WfMjjSpCDgCq3yJYR53AmeXf1AQrkjGtmji41ZV+yERXM93pZsqNENk3XY
X-Received: by 2002:a05:690e:47da:20b0:679:a183:27e4 with SMTP id
 956f58d0204a3-67c67fd62b1mr325967d50.76.1794346231750; Tue, 10 Nov 2026
 13:30:31 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028133243.262314-1-cochcoder@proton.me> <20261107014841.1452698-1-cochcoder@proton.me>
 <20261107024655.1481992-1-cochcoder@proton.me>
In-Reply-To: <20261107024655.1481992-1-cochcoder@proton.me>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 10 Nov 2026 16:30:20 -0500
X-Gm-Features: AclHuK-zU-SsG7w97oReFZIN1AqK-Dxg2tYp_rKFkBE4u5AKPtUbEQ6qvC2UvP0
Message-ID: <CABBYNZ+U6C8aWRXcOuQzZeE_JvTcXiYK57dO0fBKMOeZ6U40Jg@mail.gmail.com>
Subject: Re: [RFC PATCH v3] asha: Defer BR/EDR inquiry while streaming
To: Kyle Pepper <cochcoder@proton.me>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arun,

On Fri, Nov 6, 2026 at 9:47=E2=80=AFPM Kyle Pepper <cochcoder@proton.me> wr=
ote:
>
> Defer BR/EDR inquiry while ASHA streams are active. Keep LE discovery
> available and preserve client filters for restoration after audio stops.
> Return Busy if a new request leaves no permitted scan type. Recheck
> pending discovery starts when audio changes.
>
> Release the stream count when START cannot be queued or its callback
> reports failure, so a failed acquisition cannot keep inquiry suppressed.
>
> Assisted-by: OpenCode:gpt-6.1-sol
> Assisted-by: Codex:gpt-6
> ---
> v3: Wrap the unref call and shorten a comment to meet the
> 80-column limit. No behavior changes from v2.
>
> Previous version:
> https://lore.kernel.org/linux-bluetooth/20261107014841.1452698-1-cochcode=
r@proton.me/
>
> v2 CI: CheckPatch failed on these two long lines; the other
> 11 checks passed. Native MGMT/client arbitration and isolated
> hardware validation remain open.
>
>  profiles/audio/asha.c | 47 ++++++++++++++++++++++++---
>  src/adapter.c         | 75 ++++++++++++++++++++++++++++++++++++++++---
>  src/adapter.h         |  4 +++
>  3 files changed, 117 insertions(+), 9 deletions(-)
>
> diff --git a/profiles/audio/asha.c b/profiles/audio/asha.c
> index 8e625fdca3..d1fcddbcee 100644
> --- a/profiles/audio/asha.c
> +++ b/profiles/audio/asha.c
> @@ -60,8 +60,36 @@ struct bt_asha_device {
>         uint16_t imtu, omtu;
>
>         unsigned int resume_id;
> +       bool streaming_counted;
> +       bt_asha_cb_t start_cb;
> +       void *start_cb_data;
>  };
>
> +static void asha_set_streaming(struct bt_asha_device *asha_dev, bool str=
eaming)
> +{
> +       if (streaming =3D=3D asha_dev->streaming_counted)
> +               return;
> +
> +       if (streaming)
> +               btd_adapter_le_audio_ref(device_get_adapter(asha_dev->dev=
ice));
> +       else
> +               btd_adapter_le_audio_unref(
> +                                       device_get_adapter(asha_dev->devi=
ce));
> +
> +       asha_dev->streaming_counted =3D streaming;
> +}
> +
> +static void asha_start_cb(int status, void *user_data)
> +{
> +       struct bt_asha_device *asha_dev =3D user_data;
> +
> +       if (status)
> +               asha_set_streaming(asha_dev, false);
> +
> +       if (asha_dev->start_cb)
> +               asha_dev->start_cb(status, asha_dev->start_cb_data);
> +}
> +
>  static char *make_endpoint_path(struct bt_asha_device *asha_dev)
>  {
>         char *path;
> @@ -91,6 +119,7 @@ static void connect_cb(GIOChannel *io, GError *err, gp=
ointer user_data)
>
>         if (err) {
>                 error("%s", err->message);
> +               asha_set_streaming(asha_dev, false);
>                 return;
>         }
>
> @@ -107,8 +136,11 @@ static void connect_cb(GIOChannel *io, GError *err, =
gpointer user_data)
>
>         asha_dev->io =3D io;
>
> -       bt_asha_start(asha_dev->asha, conn_data->cb,
> -                                       conn_data->cb_user_data);
> +       asha_dev->start_cb =3D conn_data->cb;
> +       asha_dev->start_cb_data =3D conn_data->cb_user_data;
> +
> +       if (bt_asha_start(asha_dev->asha, asha_start_cb, asha_dev))
> +               asha_set_streaming(asha_dev, false);
>  }
>
>  static int asha_connect_socket(struct bt_asha_device *asha_dev,
> @@ -171,12 +203,15 @@ unsigned int bt_asha_device_start(struct bt_asha_de=
vice *asha_dev,
>
>         if (ret < 0)
>                 return 0;
> -       else
> -               return (++asha_dev->resume_id);
> +
> +       asha_set_streaming(asha_dev, true);
> +       return (++asha_dev->resume_id);
>  }
>
>  unsigned int bt_asha_device_stop(struct bt_asha_device *asha_dev)
>  {
> +       asha_set_streaming(asha_dev, false);
> +
>         bt_asha_stop(asha_dev->asha);
>
>         if (asha_dev->io) {
> @@ -190,6 +225,8 @@ unsigned int bt_asha_device_stop(struct bt_asha_devic=
e *asha_dev)
>
>  void bt_asha_device_state_reset(struct bt_asha_device *asha_dev)
>  {
> +       asha_set_streaming(asha_dev, false);
> +
>         if (asha_dev->io) {
>                 g_io_channel_shutdown(asha_dev->io, TRUE, NULL);
>                 g_io_channel_unref(asha_dev->io);
> @@ -371,6 +408,8 @@ static void asha_source_device_remove(struct btd_serv=
ice *service)
>                 return;
>         }
>
> +       asha_set_streaming(asha_dev, false);
> +
>         bt_asha_free(asha_dev->asha);
>         g_free(asha_dev);
>  }
> diff --git a/src/adapter.c b/src/adapter.c
> index 6588a6e2bd..16a0920923 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -304,6 +304,7 @@ struct btd_adapter {
>                                          * without delay */
>         uint8_t discovery_type;         /* current active discovery type =
*/
>         uint8_t discovery_enable;       /* discovery enabled/disabled */
> +       unsigned int le_audio_active;   /* Active ASHA streams */
>         bool discovery_suspended;       /* discovery has been suspended *=
/
>         bool discovery_discoverable;    /* discoverable while discovering=
 */
>         GSList *discovery_list;         /* list of discovery clients */
> @@ -1886,6 +1887,8 @@ static void discovery_remove(struct discovery_clien=
t *client)
>  }
>
>  static void trigger_start_discovery(struct btd_adapter *adapter, guint d=
elay);
> +static int update_discovery_filter(struct btd_adapter *adapter);
> +static uint8_t discovery_scan_type(struct btd_adapter *adapter);
>
>  static struct discovery_client *discovery_complete(struct btd_adapter *a=
dapter,
>                                                 uint8_t status)
> @@ -1964,6 +1967,11 @@ static void start_discovery_complete(uint8_t statu=
s, uint16_t length,
>
>                 discovery_complete(adapter, status);
>
> +               /* Audio or filters may change while START is pending. */
> +               if (!adapter->discovery_suspended &&
> +                   adapter->discovery_type !=3D discovery_scan_type(adap=
ter))
> +                       trigger_start_discovery(adapter, 0);
> +
>                 if (adapter->discovering)
>                         return;
>
> @@ -1987,23 +1995,39 @@ static void start_discovery_complete(uint8_t stat=
us, uint16_t length,
>         trigger_start_discovery(adapter, IDLE_DISCOV_TIMEOUT * 2);
>  }
>
> +static uint8_t discovery_scan_type(struct btd_adapter *adapter)
> +{
> +       uint8_t type =3D adapter->current_discovery_filter ?
> +                               adapter->current_discovery_filter->type :
> +                               get_scan_type(adapter);
> +
> +       if (adapter->le_audio_active)
> +               type &=3D ~SCAN_TYPE_BREDR;
> +
> +       return type;
> +}
> +
>  static bool start_discovery_timeout(gpointer user_data)
>  {
>         struct btd_adapter *adapter =3D user_data;
>         struct mgmt_cp_start_service_discovery *sd_cp;
> +       size_t sd_len;
>         uint8_t new_type;
>
>         DBG("");
>
>         adapter->discovery_idle_timeout =3D 0;
>
> +       if (!adapter->discovery_list || adapter->discovery_suspended)
> +               return FALSE;
> +
>         /* If we're doing filtered discovery, it must be quickly restarte=
d */
>         adapter->no_scan_restart_delay =3D !!adapter->current_discovery_f=
ilter;
>
>         DBG("adapter->current_discovery_filter =3D=3D %d",
>             !!adapter->current_discovery_filter);
>
> -       new_type =3D get_scan_type(adapter);
> +       new_type =3D discovery_scan_type(adapter);
>
>         if (adapter->discovery_enable =3D=3D 0x01) {
>                 struct mgmt_cp_stop_discovery cp;
> @@ -2047,11 +2071,27 @@ static bool start_discovery_timeout(gpointer user=
_data)
>
>         }
>
> +       if (!new_type) {
> +               struct discovery_client *client;
> +
> +               /* Reject new requests; keep sessions until audio stops. =
*/
> +               client =3D discovery_complete(adapter, MGMT_STATUS_BUSY);
> +               if (client) {
> +                       discovery_remove(client);
> +
> +                       if (adapter->discovery_list)
> +                               update_discovery_filter(adapter);
> +               }
> +
> +               return FALSE;
> +       }
> +
>         /* Regular discovery is required */
>         if (!adapter->current_discovery_filter) {
>                 struct mgmt_cp_start_discovery cp;
>
>                 cp.type =3D new_type;
> +
>                 mgmt_send(adapter->mgmt, MGMT_OP_START_DISCOVERY,
>                                         adapter->dev_id, sizeof(cp), &cp,
>                                         start_discovery_complete, adapter=
,
> @@ -2060,18 +2100,25 @@ static bool start_discovery_timeout(gpointer user=
_data)
>                 return FALSE;
>         }
>
> -       /* Filtered discovery is required */
> -       sd_cp =3D adapter->current_discovery_filter;
> +       /* Keep the requested filter intact for when audio stops. */
> +       sd_len =3D sizeof(*sd_cp) +
> +               btohs(adapter->current_discovery_filter->uuid_count) * 16=
;
> +       sd_cp =3D util_memdup(adapter->current_discovery_filter, sd_len);
> +       if (!sd_cp)
> +               return FALSE;
> +
> +       sd_cp->type =3D new_type;
>
>         DBG("sending MGMT_OP_START_SERVICE_DISCOVERY %d, %d, %d",
>                                 sd_cp->rssi, sd_cp->type,
>                                 btohs(sd_cp->uuid_count));
>
>         mgmt_send(adapter->mgmt, MGMT_OP_START_SERVICE_DISCOVERY,
> -                 adapter->dev_id, sizeof(*sd_cp) +
> -                 btohs(sd_cp->uuid_count) * 16,
> +                 adapter->dev_id, sd_len,
>                   sd_cp, start_discovery_complete, adapter, NULL);
>
> +       free(sd_cp);
> +
>         return FALSE;
>  }
>
> @@ -6358,6 +6405,24 @@ struct btd_adapter *btd_adapter_ref(struct btd_ada=
pter *adapter)
>         return adapter;
>  }
>
> +void btd_adapter_le_audio_ref(struct btd_adapter *adapter)
> +{
> +       if (adapter->le_audio_active++)
> +               return;
> +
> +       if (adapter->discovery_list && !adapter->discovery_suspended)
> +               trigger_start_discovery(adapter, 0);
> +}
> +
> +void btd_adapter_le_audio_unref(struct btd_adapter *adapter)
> +{
> +       if (!adapter->le_audio_active || --adapter->le_audio_active)
> +               return;
> +
> +       if (adapter->discovery_list && !adapter->discovery_suspended)
> +               trigger_start_discovery(adapter, 0);
> +}
> +
>  void btd_adapter_unref(struct btd_adapter *adapter)
>  {
>         if (__sync_sub_and_fetch(&adapter->ref_count, 1))
> diff --git a/src/adapter.h b/src/adapter.h
> index 583168f4bc..d5cda2d96b 100644
> --- a/src/adapter.h
> +++ b/src/adapter.h
> @@ -119,6 +119,10 @@ bool btd_adapter_uuid_is_allowed(struct btd_adapter =
*adapter, const char *uuid);
>  struct btd_adapter *btd_adapter_ref(struct btd_adapter *adapter);
>  void btd_adapter_unref(struct btd_adapter *adapter);
>
> +/* Defer BR/EDR discovery while ASHA streams are active. */
> +void btd_adapter_le_audio_ref(struct btd_adapter *adapter);
> +void btd_adapter_le_audio_unref(struct btd_adapter *adapter);

Ok, I don't think I agree with this design. First, what does BR/EDR
have to do with ASHA streams? I thought ASHA was LE only, and then the
naming says le_audio_ref? ASHA is not LE Audio. If we want to express
conflicts, that needs to be part of the driver resolving logic at the
core so it doesn't probe conflicting drivers.

>  void btd_adapter_set_class(struct btd_adapter *adapter, uint8_t major,
>                                                         uint8_t minor);
>  int btd_adapter_set_name(struct btd_adapter *adapter, const char *name);
>
> base-commit: a8067198717b38391ca183ed7f41a69ec4b81b6e
> --
> 2.56.0
>
>


--=20
Luiz Augusto von Dentz
