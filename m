Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206AA33CEA7
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 18:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774464234; cv=pass; b=XxREUAuxOdLCSIRJVfpFUnl8mTYHN+HlSn9y3WKPBXwb7taOkkQhaCEfLl2iRHlhjtz4Qx18VgLIpGB2cQWXTB7RhQ93DNK3XcppPUM5Qc/stywoxDMlSlz6gsJb4HtgRPy4htIBlhDFmzL3P2rB0rm1WYuC3xopJOSDbixJcUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774464234; c=relaxed/simple;
	bh=tRWXupyAnkrdDiCOyBDQlENrRuAyAF6U975jeMxjJAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B2+YVIz9RGdq8J5FLrRyT79CZF5RJng+g7OPYHEsrQ4Zm2kkEWubBA+or6uyteBGeqc2QQxsLxg12q2RlCFecaEaeZRICBQToa4P1YVVLf+9OhREI83Vlh3BzBRS59n8trIDr01JVJUWUitzVVZT/aCeuaqLRVLANuxZu9RtinI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yht1fsaQ; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yht1fsaQ"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64ad9fabd08so238267d50.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 11:43:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774464231; cv=none;
        d=google.com; s=arc-20240605;
        b=fIEd3h/STCHOdKKA8ALhkYH/f+x6qIWFmhXCUnPE5P4xAUlbxjdceFtGJRXFP/3A/2
         XVgWAaEwv37j3/rm6F1YPCm8PGip3fXPvW6+sVijR5ry/BlTvgPm2pxH7u8QToz9L7o2
         9+H/FJX/JItIue6phlUuPcW7g1uGUy4c5n+QnfcK6s3TNQ7ufO6D044E2jP97ZbsrTnn
         CEPWenYiyvBGGDcPfCiaF6cbkD+eMl8D0jTNIW9xeH6WApBT5lAGH9czS8jitpIBSl3d
         jWGpG3zx5gRUikadtFBiV4rzk+PkVChP1SdofJSBbtMT+LZLrWKJewSDXU1Jloh8fQIP
         PMIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dN1kBBKzxmgeIThh3bMamBA1c4QwAXikCkkRxWJ/chI=;
        fh=fAVvqa29TMCSLQ1BWo+IkeTh9vOt2h2EvlnFWIq0DOI=;
        b=hpiM7MheSPDtSTf2WkmAjsMF7DuiDwT6A0SPcwUfGO8RHx4G63OWUxvwki5eJpClqu
         EjhDn++76yRixp6apvtkdRlX4NHat/1RTkaBD8fZPmhS5p8Y2uSbrHlQyMOSmuwn3I6Y
         bUhLojOk8lgUXRvuQP1mu1hLBHnEoCGmlc3kLvqp8/Sq9r2KtqfXDfzII6L1Y92JKOLy
         RmU22lWvj/0qpe+iz9LrjXqGkVEZgOaq9IK0K7K592GC1YdEPfshZ/92OU9jxFLWs6LT
         BitSZkBcHbTnCRXSMDuY3fWxlpc0sqid3J9rkrlVs8aGvyY00XZaZpcCZjcald49ivH/
         RUhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774464231; x=1775069031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dN1kBBKzxmgeIThh3bMamBA1c4QwAXikCkkRxWJ/chI=;
        b=Yht1fsaQvUREF+KgOq9jG/4iOf6KL7KJ1kuokBGAtzw2VOR0rAyVJWzgw8BuIsIPsm
         EmIwC5QLEp371sA7l8y9y3Eb4g/Dofhb56EViA4L65rg4vusjeK7Md3TS2JgqAoILtbt
         UhI/jBvqHhhlOR9z1b8UQd34EGNcYoZAf0aKIaM1zKbwuuedes3f6X3wA1HraRAV1Spo
         8cVgTQh+KfAm5g6u61ruvGCdvPr6Sb0mUSqsonwy+mfMxzoNSRk6h9gO7FJBqNEJnkYu
         QIj8w0H3bJC7z3dGmWPEf4Yi70Nn/I29I8hwuUMR1oZNUByhPawV3Ud32c3Et/ebm2B8
         o9uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774464231; x=1775069031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dN1kBBKzxmgeIThh3bMamBA1c4QwAXikCkkRxWJ/chI=;
        b=UJXsFEPyEbu1EnmOh6BofAkvKhOFzs1cQiYUrs02Ky6aL2BCMkvliC4gqZxCII908f
         sAbvCthoSHtrHIqyvusz3bbjtJEwBB3WwfjuhcWQ7WkC1b9eE3iPAmbm7XI+h5m/ojK9
         lOJCkLJTgHoZ7+QhUl6uMZUbrogn4pIvmcEr00SzuN0Xf0iUE/ysZ4oTM0FBq5GbB0w6
         FdjdHlV9W/i+4SuFxJb5aliZrGC3U3oiwXW/aokjZR8vKiVwDo6KES8hnkVdOsxjLt1+
         xshyyFTp2qV97zjr148kGTOGwA5u4amSiAQPNS0EeqPcTUFuxudCDciIG+YJClB1nH0t
         ZOsg==
X-Gm-Message-State: AOJu0YxM9rnmlzSojYE1q0oWOPnWAN3MfsF5iXDjZ+SnxqVyEe3WUIJ2
	eKqXbKZiqpH5r9ynbOsctYbOnkW6Va3fhnVog6wMQ2b4ea6CNvsicqM2VHgPb4LsoZOjUjVgJ6t
	wNKZfBcfd8qte7cgfelHcsDVsDcL4+VA=
X-Gm-Gg: ATEYQzwNLMje6jCwZghlWw0bTMNFRIVRpWvl6QkllvfKYzjUc6dK9MBzRYSmR04iJuD
	KMc/NW4ykckHJqi4ui1LkcDH9zGwiA+g2QLUqTUFfv+BqVeOfnOTOqmZSS5Y8SZmVItnCIbKE9G
	44NWUCpqVph5S2ZG0PPHRZ7loGrLrWRcluCdl+REMCdvUr4GZ06P5dE06t8cImDYjQNV1+S+mpY
	7c3TGEhXi6+mQajIksUl8sy+lkl9mFrO/lKJz7a/eNgbgHtZV5gFt8g3DmMkCN2ILA4n7QZeaqC
	p915jfZE1KpFCDOORmU/czbq1s3m24fxzIo6YR/6qpo4+IKzkM43IKQckJN6R2Giajk=
X-Received: by 2002:a05:690e:d8f:b0:64e:ef47:83eb with SMTP id
 956f58d0204a3-64eef478a07mr2462838d50.47.1774464230404; Wed, 25 Mar 2026
 11:43:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f7ccb4a4f9e462a6c1c1ddba8dd1cdcc9456944b.1774459946.git.pav@iki.fi>
 <1eec5447ed02666ef9463bbc96c25971ce9c0d1f.1774459946.git.pav@iki.fi>
In-Reply-To: <1eec5447ed02666ef9463bbc96c25971ce9c0d1f.1774459946.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 25 Mar 2026 14:43:39 -0400
X-Gm-Features: AQROBzA9paxiu4okuMbOjPDS6RefexjlUIKRqrYlXDV1g2oN2MvqYPRl3BHYNTw
Message-ID: <CABBYNZ+aBV2C6NQ=Pv_1ZRhhnntcd46bkOS2gj1sj_X4PoUjjw@mail.gmail.com>
Subject: Re: [PATCH 3/3] Bluetooth: hci_sync: make hci_cmd_sync_run_once
 return -EEXIST if exists
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Wed, Mar 25, 2026 at 1:42=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> hci_cmd_sync_run_once() needs to indicate whether a queue item was
> added, so caller can know if callbacks are called, so it can avoid
> leaking resources.
>
> Change the function to return -EEXIST if queue item already exists.
>
> hci_cmd_sync_run() may run the work immediately. If so, make it behave
> as if item was queued successfully. Change it to call also destroy() and
> return 0.
>
> Modify all callsites vs. the changes.
>
> The only callsite is hci_abort_conn(), and this changes its return
> value. However, its return value is not used except as the return value
> for hci_disconnect(), and nothing uses the return value of
> hci_disconnect(). Hence there should be no behavior change anywhere.
>
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
>  net/bluetooth/hci_conn.c |  4 +++-
>  net/bluetooth/hci_sync.c | 13 ++++++++++---
>  2 files changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index e6393f17576b..8cc2cc58c3f8 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -3077,6 +3077,7 @@ static int abort_conn_sync(struct hci_dev *hdev, vo=
id *data)
>  int hci_abort_conn(struct hci_conn *conn, u8 reason)
>  {
>         struct hci_dev *hdev =3D conn->hdev;
> +       int err;
>
>         /* If abort_reason has already been set it means the connection i=
s
>          * already being aborted so don't attempt to overwrite it.
> @@ -3113,7 +3114,8 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason=
)
>          * as a result to MGMT_OP_DISCONNECT/MGMT_OP_UNPAIR which does
>          * already queue its callback on cmd_sync_work.
>          */
> -       return hci_cmd_sync_run_once(hdev, abort_conn_sync, conn, NULL);
> +       err =3D hci_cmd_sync_run_once(hdev, abort_conn_sync, conn, NULL);
> +       return (err =3D=3D -EEXIST) ? 0 : err;
>  }
>
>  void hci_setup_tx_timestamp(struct sk_buff *skb, size_t key_offset,
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 0b28495197c2..47d902310b19 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -801,8 +801,15 @@ int hci_cmd_sync_run(struct hci_dev *hdev, hci_cmd_s=
ync_work_func_t func,
>                 return -ENETDOWN;
>
>         /* If on cmd_sync_work then run immediately otherwise queue */
> -       if (current_work() =3D=3D &hdev->cmd_sync_work)
> -               return func(hdev, data);
> +       if (current_work() =3D=3D &hdev->cmd_sync_work) {
> +               int err;
> +
> +               err =3D func(hdev, data);
> +               if (destroy)
> +                       destroy(hdev, data, err);

It is probably worth splitting this change into its own commit so we
can add a Fixes: tag and backport it.

> +               return 0;
> +       }
>
>         return hci_cmd_sync_submit(hdev, func, data, destroy);
>  }
> @@ -818,7 +825,7 @@ int hci_cmd_sync_run_once(struct hci_dev *hdev, hci_c=
md_sync_work_func_t func,
>                           void *data, hci_cmd_sync_work_destroy_t destroy=
)
>  {
>         if (hci_cmd_sync_lookup_entry(hdev, func, data, destroy))
> -               return 0;
> +               return -EEXIST;
>
>         return hci_cmd_sync_run(hdev, func, data, destroy);
>  }
> --
> 2.53.0
>
>


--=20
Luiz Augusto von Dentz
