Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B401394
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Feb 2024 01:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708305434; cv=none; b=N8gLp7h5fnL7RID23llywodTwAWX1CM+OVAmvxFpDfw/4ofM6+xKAdsxAzFrF9IJ4+0VwoCVkpCWAEOozJK9H/p9r9O0NExidPWfVmVKUh65OHzW7ihMsM6nx2ShxaG9EV0xqboGQ2H8Pa+koBkS6bTqqtNXEb9sZ8Sukeqm1+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708305434; c=relaxed/simple;
	bh=aadPJat/aV0qssEXBjSbmTEWDUUCnlGLgWiZ9Emr+LY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=WsFIAptOP3DMtkjDyJMyBz3J/IPgjIPl64bXNeXMtb2pkXInDDuwwkl7U2vW54SInZPNSs/FXvprMLCVZtyF2PCw5frf66LqjTHUiCI50EpVqqhuE25ial6QOgVPp32bAiWuHdGQmcsdZ8JeFzyXh1I3P6DmdFds6iWN1e7Ce0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d228a132acso20658431fa.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 18 Feb 2024 17:17:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708305431; x=1708910231;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bnDIzKAAHqUE99uGMy3LM2/SDBhUgCs7WwrNAcRvmtM=;
        b=nwza1rKx/Q7EGzvGE3ME+6MzSZ0bSpu8s2LLCbX8vYr8yUEALnpuqFxQyWCMKc09Cx
         X5xS7dlFS/mCa95BzIhNjeMa4mkMB5o3wyUv8q/Rq/YZXUxWCb44loc88Y6ko/oaXXSH
         A6xX8powQ7i8HKPB5GHfmqU4vpm+xpKCKMBwf/l3uFdJ1WlF/aBxcuufre2iUR+wdAKs
         kSOBGuclGjqaQu23G3Vb3D/gclvVi82wsOohXAqFcHuOm4I4h1ZH6pEt64vkjSfUF90B
         qapXGxoVT0l/JX37IdxG6XzWtv+JUq9Q/V1/T82Y6sKGVd/KHcgu3sj+ZxhqTrGNK6Z3
         uyYw==
X-Forwarded-Encrypted: i=1; AJvYcCXMiTui22ZvvODF10A0ak4flpcwtSeFTLNi83Wf9bf5/jNoT3qtR06jPXisrq0KL4qdC+hX/6vkHwjIboD/bEGHW+N+2p4iJdGDR280AYh1
X-Gm-Message-State: AOJu0YzXyufKvWz6lfX6iOxNtmxfnV31S1T2ZzuG5TJCeWtL2pCc7q4y
	M6HEHXL9igF8+mrxXeMmot1J18k9Zr9uWDfuyBtqzdibBl3wl0gOzJFlEAP9y8owvQ==
X-Google-Smtp-Source: AGHT+IF4G97EHyvXySS9/7qoUGC5wTXeCEf0ZXoRFyNYOt92bPHuZ+uM3knVGL36sc2QCrm7OlCEgg==
X-Received: by 2002:a05:6512:1146:b0:512:b437:4b06 with SMTP id m6-20020a056512114600b00512b4374b06mr330743lfg.67.1708305430899;
        Sun, 18 Feb 2024 17:17:10 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id x8-20020ac24888000000b00511ad6f50a4sm712089lfc.159.2024.02.18.17.17.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Feb 2024 17:17:10 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-512ab55fde6so1172778e87.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 18 Feb 2024 17:17:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXF2b+j9ppRjadlpxpmXkXS0CPygpx+Qq65yW3hIsszMVHQCfeEq8X265BBra5+A3mWi/5nwzoNcdk7MMOZMvwYKgDYjYuqKwVKZDkhN+/p
X-Received: by 2002:a05:6512:2820:b0:512:88d9:93e4 with SMTP id
 cf32-20020a056512282000b0051288d993e4mt6920153lfb.15.1708305430452; Sun, 18
 Feb 2024 17:17:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209070443.3617790-1-iam@sung-woo.kim>
In-Reply-To: <20240209070443.3617790-1-iam@sung-woo.kim>
From: Sungwoo Kim <iam@sung-woo.kim>
Date: Sun, 18 Feb 2024 20:16:42 -0500
X-Gmail-Original-Message-ID: <CAJNyHpJo4D+JxCJRB30eMisux_thO1eJHf0SDsRFQMubdQSkVg@mail.gmail.com>
Message-ID: <CAJNyHpJo4D+JxCJRB30eMisux_thO1eJHf0SDsRFQMubdQSkVg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: add missing checks in state transitions
Cc: daveti@purdue.edu, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, could I ask for comments on this?

On Fri, Feb 9, 2024 at 2:06=E2=80=AFAM Sungwoo Kim <iam@sung-woo.kim> wrote=
:
>
> When an l2cap channel receives L2CAP_CONN_RSP, it revives from BT_DISCONN
> to BT_CONFIG or BT_CONNECTED.
> It is very weird, violates the specification, and I cannot see any real
> usecase for this.
> Similar to this, the L2cap channel has six illegal state transitions:
>
> 1. BT_CONNECT2 -> BT_CONFIG by L2CAP_CONN_RSP
> 2. BT_CONNECT2 -> BT_CONNECTED by L2CAP_CONF_RSP
> 3. BT_CONNECT2 -> BT_DISCONN by L2CAP_CONF_RSP
> 4. BT_CONNECTED -> BT_CONFIG by L2CAP_CONN_RSP
> 5. BT_DISCONN -> BT_CONFIG by L2CAP_CONN_RSP
> 6. BT_DISCONN -> BT_CONNECTED by L2CAP_CONN_RSP
>
> This patch fixes 2, 3, 5, and 6 by adding checks.
> For 1 and 4, I will make an RFC for as it requires some refactoring.
>
> The detaild logs are described in here:
> https://lore.kernel.org/lkml/CAJNyHpKpDdps4=3DQHZ77zu4jfY-NNBcGUrw6UwjuBK=
fpuSuE__g@mail.gmail.com/
>
> Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
> ---
>  net/bluetooth/l2cap_core.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 60298975d..c5fa2b683 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -4339,6 +4339,14 @@ static int l2cap_connect_create_rsp(struct l2cap_c=
onn *conn,
>
>         l2cap_chan_lock(chan);
>
> +       switch (chan->state) {
> +       case BT_CLOSED:
> +       case BT_DISCONN:
> +               l2cap_chan_unlock(chan);
> +               l2cap_chan_put(chan);
> +               goto unlock;
> +       }
> +
>         switch (result) {
>         case L2CAP_CR_SUCCESS:
>                 if (__l2cap_get_chan_by_dcid(conn, dcid)) {
> @@ -4552,6 +4560,14 @@ static inline int l2cap_config_rsp(struct l2cap_co=
nn *conn,
>         if (!chan)
>                 return 0;
>
> +       switch (chan->state) {
> +       case BT_CLOSED:
> +       case BT_CONNECT:
> +       case BT_CONNECT2:
> +       case BT_DISCONN:
> +               goto done;
> +       }
> +
>         switch (result) {
>         case L2CAP_CONF_SUCCESS:
>                 l2cap_conf_rfc_get(chan, rsp->data, len);
> --
> 2.25.1
>
