Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592F622097
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Sep 2025 14:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686528; cv=none; b=LwhkMp1H5lBr0dJ9ImWZqxWNDJyB/8L0Vl8D1BVqqeNpqGqKPlOa5YkTASwJUmPWpCDYE9oOGyLB3DDVOK/xDsvxme+2sosRGZlEh45k/lKdsfSMjdCdoRZqBAQBP6AYbS1CLxWE18wuF+kS7iMo2T7dK5PF805d71l9eMAL8zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686528; c=relaxed/simple;
	bh=Nz+VXPKDLv1w916pdvHWEP/xAafz7DYwjqhW/UHbF8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BP1Uji2edRD2GupxKeDDIyFnNT/jCuqhRTIbj9f9540Cln4n33b1s6jrcVpTeI69D9xNZtnCrOtT8tl3+vZ6jf/QR1GYqnX7iQGs1efhyPg7TBrnlvuYZ3d+S4vU5rbwykE5jABJ5tAJvj72i5SVUZ0FvvOfN1rJatyvLtjUtZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vqs80Efi; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vqs80Efi"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3523422a785so4694501fa.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Sep 2025 07:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757686524; x=1758291324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbn2zHCby2ZTAGIaiXAPRSGjg14NbjjGlAPCiQ/gldc=;
        b=Vqs80EfiCDDLGkgoRIUhuqU/fRIteXfcAzb6VZSAI59bRVK98sCxX6S3BqQgSwtwZW
         awlTyEINYpZNPw/fIDw+RlGXNCX9Zw8D0KvnQOf0YiZGTjSx5J3O8vDMIOh99ktN4xmd
         6SdDOxFB9hPqKGxrHNgUtKQxhgZTLBasKN++hXgz/Eps+LgEgiaAFI7W30qzgwPcOn8O
         gn4S7l5+r6GCvbB0ERoLkdHBaPOQWvFfb2YfZUnT8revy+TaTeQM1zXSgaZfbg8tF/X6
         aUXX0ZQHzn60qR0nRcNMqJuoAytILyvB11Mvs1thKiqSvSK5/QMp6YryA4tiY9xqAgrx
         L9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757686524; x=1758291324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sbn2zHCby2ZTAGIaiXAPRSGjg14NbjjGlAPCiQ/gldc=;
        b=KbsOlhjZhgxoTDH8fc9HWhnm549EOI7UhnUuRhkceoevGoj4/Un0nOlrmIq01Y1Hxf
         U54wfebW8fs5lMrVvQFOGd5f5UUw+mjUhqvl4awBmGmm7wThzTcu7Yelo09QXSdS+fpH
         x2w+pO1h52M11NmcmwQp8vUM2ByyYc19SNCCvFpfuv0VC37pXIVlzFlwsXb4MdbdqN6v
         PT+Q7+VXF4/O0Pm3Ba7j8pCyE9r6i9ITAFPhU4/8aDoBhLhqZb1Uo2idQugUglvemcm6
         RIL6CUySPiXp8fJfXG99s6FHI1KMGyhv2zc63GC2GHBHYNR7e0jjjdUBySprMoSVvdD+
         EK6w==
X-Gm-Message-State: AOJu0Yxgu6WRE9mf8LDCrnQ8m4JEa9NDUnbMctfprnk5pHFnWzFZaAnV
	I7Z5+lQfQ6Ucm04iNgx5n2CovG98OXC2HeEkuahWxQ6StqdfpXW4LRHW0e+dfB0gBF5BvLqiAFP
	CI53hwnnlWAxe8N5BfWobXNs7LnHuEoqzyw==
X-Gm-Gg: ASbGncsmskAYBx8oH6mfrJiStGrwJvljUksGn2aDja4W058QVB7yxzJ0jdj0MA2yqGa
	EYBszzCDJscbRrFgcNDNAxfdxioftldVeSYaL8c2rZRmoQOHab+X+ICP4iLH/UUNWIXODxHLqiR
	Mbu44Ej8QC9wasx8qbrpoZBnp1cZwh9fc8J2jrC36q7fjdE4sYBbKqVzLN+YfYUTTE/evQCN5nP
	lB0E0F/0bL6eU9kTv1RyVivHS6Ob+zkDImdv+CauGKHNKy+4y3dAaC/
X-Google-Smtp-Source: AGHT+IHpxFQUc54DU3N/WMOoQ8n2jLLRILgfuCoXVRrZ9ZdJ7fKZhqC1ZfmTm6h4jKp6MVhWSALGus38/L6eQSVRF9Y=
X-Received: by 2002:a2e:b890:0:b0:352:fe85:b70b with SMTP id
 38308e7fff4ca-352fe85bd4cmr3319031fa.1.1757686524040; Fri, 12 Sep 2025
 07:15:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912103550.49240-1-andreas.glinserer@canonical.com>
In-Reply-To: <20250912103550.49240-1-andreas.glinserer@canonical.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 12 Sep 2025 10:15:11 -0400
X-Gm-Features: Ac12FXx96mltm-yi96p7lAsP09ZqQCAIWWDODYINtV2TMYMkPim9iE1cy7Yd3mI
Message-ID: <CABBYNZLnZ_E93uf5ReLQzgXsny8O6QmOcSj=ci5O_0Xtb-UdUQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] src/adapter: add timeout for missing discovery
To: Andreas Glinserer <andreas.glinserer@canonical.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

On Fri, Sep 12, 2025 at 6:36=E2=80=AFAM Andreas Glinserer
<andreas.glinserer@canonical.com> wrote:
>
> Add a timeout to detect when the controller stops sending discovery
> events. Without this, the system silently discovering new devices
> and the scan list gradually empties due to DEFAULT_TEMPORARY_TIMEOUT.
>
> When the timeout triggers, issue MGMT_OP_STOP_DISCOVERY to restart the
> event loop and resume discovery.

I'm not really sure how sending stop would make any difference?

>
> Link: https://github.com/bluez/bluez/issues/1554

The bug mentioned BlueZ version 1.72?, well I guess that is 4.72 which
is very old, have you tried with something more recent?

> ---
>  src/adapter.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index dc5ba65d7..1ec665c73 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -342,6 +342,7 @@ struct btd_adapter {
>
>         struct queue *exp_pending;
>         struct queue *exps;
> +       unsigned int last_discovery_timeout_id;         /* Timeout for di=
scovery stop if no cb is coming */
>  };
>
>  static char *adapter_power_state_str(uint32_t power_state)
> @@ -1727,6 +1728,11 @@ static void discovery_cleanup(struct btd_adapter *=
adapter, int timeout)
>                 adapter->discovery_idle_timeout =3D 0;
>         }
>
> +       if (adapter->last_discovery_timeout_id > 0) {
> +               timeout_remove(adapter->last_discovery_timeout_id);
> +               adapter->last_discovery_timeout_id =3D 0;
> +       }
> +
>         g_slist_free_full(adapter->discovery_found,
>                                                 invalidate_rssi_and_tx_po=
wer);
>         adapter->discovery_found =3D NULL;
> @@ -1833,6 +1839,8 @@ static struct discovery_client *discovery_complete(=
struct btd_adapter *adapter,
>         return client;
>  }
>
> +static bool time_since_last_discovery_cb(gpointer user_data);
> +
>  static void start_discovery_complete(uint8_t status, uint16_t length,
>                                         const void *param, void *user_dat=
a)
>  {
> @@ -1900,6 +1908,20 @@ static void start_discovery_complete(uint8_t statu=
s, uint16_t length,
>         trigger_start_discovery(adapter, IDLE_DISCOV_TIMEOUT * 2);
>  }
>
> +static bool time_since_last_discovery_cb(gpointer user_data)
> +{
> +       struct btd_adapter *adapter =3D user_data;
> +       struct mgmt_cp_start_discovery cp;
> +       DBG("");
> +       cp.type =3D  get_scan_type(adapter);
> +
> +       mgmt_send(adapter->mgmt, MGMT_OP_STOP_DISCOVERY,
> +               adapter->dev_id, sizeof(cp), &cp,
> +               NULL, NULL, NULL);
> +
> +       return FALSE;
> +}
> +
>  static bool start_discovery_timeout(gpointer user_data)
>  {
>         struct btd_adapter *adapter =3D user_data;
> @@ -1909,6 +1931,9 @@ static bool start_discovery_timeout(gpointer user_d=
ata)
>         DBG("");
>
>         adapter->discovery_idle_timeout =3D 0;
> +       adapter->last_discovery_timeout_id =3D timeout_add_seconds(
> +               IDLE_DISCOV_TIMEOUT * 3, time_since_last_discovery_cb,
> +               adapter, NULL);
>
>         /* If we're doing filtered discovery, it must be quickly restarte=
d */
>         adapter->no_scan_restart_delay =3D !!adapter->current_discovery_f=
ilter;
> @@ -2009,6 +2034,11 @@ static void trigger_start_discovery(struct btd_ada=
pter *adapter, guint delay)
>         if (!btd_adapter_get_powered(adapter))
>                 return;
>
> +       if (adapter->last_discovery_timeout_id > 0) {
> +               timeout_remove(adapter->last_discovery_timeout_id);
> +               adapter->last_discovery_timeout_id =3D 0;
> +       }
> +
>         adapter->discovery_idle_timeout =3D timeout_add_seconds(delay,
>                                         start_discovery_timeout, adapter,=
 NULL);
>  }
> @@ -2053,6 +2083,11 @@ static void suspend_discovery(struct btd_adapter *=
adapter)
>                 adapter->discovery_idle_timeout =3D 0;
>         }
>
> +       if (adapter->last_discovery_timeout_id > 0) {
> +               timeout_remove(adapter->last_discovery_timeout_id);
> +               adapter->last_discovery_timeout_id =3D 0;
> +       }
> +
>         if (adapter->discovery_enable =3D=3D 0x00)
>                 return;
>
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
