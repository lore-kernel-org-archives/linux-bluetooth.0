Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDB618D631
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Aug 2024 14:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722954177; cv=none; b=BsndB8hJrhL22auGSIDaJMIqIm4FJhXqby1HA/6y2Xc7pvNxjKx9OtSaPfTTCKnrXQ0pqsRz/jOaTKKEKkckqNrjk8VxLzvDi4pFRZzNUJ1UyMqkfHpOD/KPwL4IKSrek01yS+dcQYwR49rjxa9v+IltCrOHZA5fdQnTkykRuI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722954177; c=relaxed/simple;
	bh=MPI5AuIV3zV/3b9ObIBVNXxjc3rsC1qJufkfi2isM64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zi+9NgDIOAbtnwpwJFsyaXJ69GVJTZBsM3oDxil4HhEaYgstwvFTDI9GOl8GBTGadtDr91G+3DfyvtL1u15tfX8tafiZCSiNBmfSy9KDSa5SU9fVdnMDv3SBAGId95gj3O/Go+RQ7LZmhSLLZ+kL0shDRxbnFB1Ocfih5IVxLRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWAluUdw; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWAluUdw"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f189a2a841so6824371fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Aug 2024 07:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722954174; x=1723558974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YsnEp4RoRwcDBUYVUZsMtBrvfFnxUKAUCwJqoDGaE0=;
        b=kWAluUdwSMQgdfpdUZT9kuobX9tWFtZmxOJnSgMX0sCSbd6JEjrhjzMudorI+Y+zfG
         wVzwI3pN2FGwKdw122FF/23/JIdCd3tcCQSSlrt69fA5zS4QiV97DkGbOqSzbkikSTNY
         6SW4ZYBjZcLzRovaT71PaT56votm1Qun1F62tidIAc/fZ2mD3w9KAoLkAxd0jEC1Fyq0
         Ms+Wj8zk2Sk5L/HYpNPcpK4n5VBoKW06aicDy6qrML22YxMB38/9eMxFU/47jVQHrLGZ
         9cbda9Uq+O4RLhLqItsMRkZoNCm4mulfFIWHY5OJUqdsL6iBRAQPMmc1V0o1c1qAHg7N
         diIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722954174; x=1723558974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YsnEp4RoRwcDBUYVUZsMtBrvfFnxUKAUCwJqoDGaE0=;
        b=KpCkOsU31cpC/x9ApC8RlrIq6yxb71HNsdpiKhPHsC0Q7h+0HZIxBw8T0vRIxDVTC/
         fZzyVuALCWJn0aM9As6Qez9C8vYtAM/DhOaLP/LfxlCXqpeix+mOAIcD6BgCn81b1/0N
         wf1j6ESa7Vw1xvf/durmQucj7IaciasdDaymd0pkkpXeyk0DSrIsESrKLGEBEUdxN+vn
         Lh9sU68Cdm7mDwzXgI9RYlfFoUoUrGHue/wbMYVaqTRlujaSb1JecV5DUy4R9wFj2YMM
         vZKig9TJvlOxfOndYm6H+h0ooshGYtcWQCN3+vSsnHyID50RDxqdpLh8wSYX8gR/mvTo
         BLwg==
X-Gm-Message-State: AOJu0Yxso8FCYfiRh2Kw0wXYFVGqzn0CfqZivYL10KRDwJIDwlYn3bBR
	Wd+uS2kLC6BdeQ9QJ7+HX6lPdCnsSAPBfVFHBefZ3O8pi7uO6MBDaknTdrqz4io11hWtBmmU4zc
	DK3rQyU2FziwlnCQUuCfStXsGmsqHhGO6
X-Google-Smtp-Source: AGHT+IEXY6eMqKTwkuRd6NIprY/OXJy8xBYzS2AMojccVh9gTJf3oqCo4OniH4gd1DDl8JejbJA+Gyw9pg3Se3zpLbE=
X-Received: by 2002:a2e:9e96:0:b0:2ef:2f37:345b with SMTP id
 38308e7fff4ca-2f15ab0bff6mr95983251fa.30.1722954173311; Tue, 06 Aug 2024
 07:22:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726104326.459668-1-kiran.k@intel.com> <20240726104326.459668-2-kiran.k@intel.com>
In-Reply-To: <20240726104326.459668-2-kiran.k@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 6 Aug 2024 10:22:40 -0400
Message-ID: <CABBYNZLj1ZOrnznuGm6fe+shfB_621SnpwUO3Ay8c-81kNGouQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] Bluetooth: Add tx/rx counters to track iso packets
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com, 
	chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kiran,

On Fri, Jul 26, 2024 at 6:30=E2=80=AFAM Kiran K <kiran.k@intel.com> wrote:
>
> Add counters in hci_dev_stats to track iso tx and rx packets.
>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>  include/net/bluetooth/hci_sock.h | 2 ++
>  net/bluetooth/hci_core.c         | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/include/net/bluetooth/hci_sock.h b/include/net/bluetooth/hci=
_sock.h
> index 13e8cd4414a1..98991a11844a 100644
> --- a/include/net/bluetooth/hci_sock.h
> +++ b/include/net/bluetooth/hci_sock.h
> @@ -101,6 +101,8 @@ struct hci_dev_stats {
>         __u32 acl_rx;
>         __u32 sco_tx;
>         __u32 sco_rx;
> +       __u32 iso_tx;
> +       __u32 iso_rx;
>         __u32 byte_rx;
>         __u32 byte_tx;
>  };
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 8a4ebd93adfc..b0d40b62238b 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -3858,6 +3858,8 @@ static void hci_isodata_packet(struct hci_dev *hdev=
, struct sk_buff *skb)
>         bt_dev_dbg(hdev, "len %d handle 0x%4.4x flags 0x%4.4x", skb->len,
>                    handle, flags);
>
> +       hdev->stat.iso_rx++;
> +
>         hci_dev_lock(hdev);
>         conn =3D hci_conn_hash_lookup_handle(hdev, handle);
>         hci_dev_unlock(hdev);
> --
> 2.40.1

This breaks HCIGETDEVINFO since it changes its size, not really sure
how ioctl-tester pass it but perhaps it is not really checking the
size, anyway that's why Ive left it unchanged since otherwise we have
to break ioctl APIs which are considered deprecated anyway.

--=20
Luiz Augusto von Dentz
