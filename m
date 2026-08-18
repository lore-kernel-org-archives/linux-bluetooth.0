Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922353DB630
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 18:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787076125; cv=pass; b=pKEeq9ozWw16HPN3Fo4CgSp98KqpgQQu5om1OpVAobWBcTDvNeGlPPgi/IREm1ls2rLkuSM3kfzBrUIC4PaI/Y8G8Ti4e009pmWgWpYLOBKKzbeVPkvC1R1pgViKJl3yavsxZ7zJ3630J9KS4Jlp+Oe26AxHlgL8JueqT4QoNiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787076125; c=relaxed/simple;
	bh=IgBGeJCDKiYKLE0gQ0v9DR22201l/v7euRFWqtsNNyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZjkaU9s3LtQ5uBWvHswmoJWXMTEyW0EAWU7NrH8Jt37vuXKl/eZZMi0giVDB4pTyBKy6duF05AonKNmcmwNiQZU0Ag3i4vwFKIQANM6NPbELaWh8Q/pPXWVeP7EQiAeDq/EZ2Ip0bQmcxjVsq2yRAlttfW223mZ5DDGjAOx9jBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DIfzexSO; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIfzexSO"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-836ce5d6e85so3227397b3.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 11:02:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787076122; cv=none;
        d=google.com; s=arc-20260327;
        b=qoVMZpHptqC80Q9Prmjmui/LtEn7yl819cysAa8hVTm4dcG7O0GrWcO04jnWfBexjE
         VFSFKSdhCuW7AupeaeXagClK4PPb0Nayo2BJcdR5VEXGKX1EbW5vWwTwKZxkN3KQj1Dw
         pSnyw07aFeMIVdR8q7uPcyvSbJyoUtU6UNVT3bAmrM2aE2yQcC3W+LBbXmCOo50sazYu
         cZP8ZOg/R9yWOsmGY/tGuFVup1jmxXtA4V7mWj/KVfJRl2fnTJD8/6bF+NAz8ST/h6Ex
         cvUU4BPp98rIfxTqp6peTMd2LrUOOGzAEHTiw4i58iBnAjXMWipctsMIUmG608BRrKqq
         ZTyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JnRPUTV0z7CVyIrMTRkfaLJ+Iek7vpJVoTQfaBHHeDA=;
        fh=wOLdHjzt0df77H1A1+1nCfgPcFF1t+TagxUjFoo5STU=;
        b=NEzQnO6RcwVWLanxFbBglyer4W7/J/OUqqmGJ0FT38TRSOQnKXGpOaU+HtHHJAbMaz
         BlhDZy7hezYePoaYVprM00P4KINclCKSuddeTNpucEv+4v7YKQ0xPx+Yhizlqblzo9L1
         gCCPJbR2zcQGrrLT5ZPrHGqN7/pTuxPrbmjhIRldUwEF+00atfVf6n1t8owMNJCq0+3H
         D/Br7YFSAznwJ56DZhedy4FLXElSppVLDydHZfeLtLfsKZakbZjelHswFpCYNXh/UMiv
         EjiiARirQQEMv994MsuOLEjedHo3W4fQvr/h+ODkDLvMIxHPVibnuPZv+clhTIKbvNtD
         XwNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787076122; x=1787680922; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JnRPUTV0z7CVyIrMTRkfaLJ+Iek7vpJVoTQfaBHHeDA=;
        b=DIfzexSOYLQlik42YYH/zhzOl9u6/O5H/X8M4FfRYipyTqsaBGpqGKqxJKAbFBqJ8g
         8EQBeaSrw+alMuxq2SeL+yfB6hifbqg5pFg1eafwKHy94SBi5WNz/nwDIsnQLbfMzLNX
         qZS4TZ56sDZAI9MW29lgTdGUE4aumNRQf5CIPEhojPsy47Yu9VJ7lqM4WZnk1IXCWYHL
         7piiWKw1TTP0WPsJ0IVbWrBJ7F9u9QCBMcrKa6rFT9Ukj7jEhsI7cNJzEdMwehzBu7wA
         svSvlQXTFnRfOXVb0NAIWZmEbm6eMeR9Z188N+5NxZ8RLNMUq+YQUyPJJG7w2Mju7YFF
         DGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787076122; x=1787680922;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JnRPUTV0z7CVyIrMTRkfaLJ+Iek7vpJVoTQfaBHHeDA=;
        b=j848w3ABW8pQw901UnuT7+vxbp2U+GgD616ZoFwCuqrHoya8n+k+o3csVuMi69VifH
         dVIqT/CE/8Byfy8QeRTv2GAt5tSn2/W22i/+efUY7WBAVF8kckd6y3YJXtnmJJYXTREA
         ZzMFgikO04+af53FbwAXvnfxmKBPDaZ6WScWBCxywt9rw5jJh2CFZN7S4N5ddxPOrZri
         PClWXUbQPBY1PR310Aigs1kYL39J90ieO3p0kKxTNpz3mFjUddguz3k/U79R3zfsuahd
         AJf9Ret5su7/enD4YxZQZc3pMVbMUiOAKjbQS+0Hvi+7XJnpA38TJCAZMmeUYQXmG7PA
         lWaQ==
X-Forwarded-Encrypted: i=1; AHgh+RoX/TCLGqcwWQ7pVtFfHK3sGGeRkLp/hEOVxdBjZM+ulQaNzhqfhfZp5aC/u8oH4MeEQViejlVYFHHWfzSO5qI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYj4HlDfLWP2uv7cifi+z3hXlPzzsFV5qaGbaXrilL03uO9r4o
	PZUK4KDFfvnnAZg+JC4igZEvyYpGTuPardwJ6KunnZmUDcE01wroA2ox+rpcpayApW9NVwfWUrD
	uOAa/Y27i/1ocv7ocM1+2vK01rO12o+4=
X-Gm-Gg: AR+sD11PlLdeIyyQB/c0MYGSALtI7SOh3YCdzNyeZp4pbcY5LR43ieUMLz1vSjX6aR7
	W6lQkIZy8zvpF+480HGqJUIO8btXCKorP+lzJIEBt1/phlAYYvKS1+YM61j+GaQEgSRMzcWWyQI
	ZcyoV7vB1hNPX5wgQad2GlFnvMNJ8F2AwnZUPxy5K/29J4+Xbx0ap4mk5HpCcCL5Og0jMVSs8xX
	3c0Vf6PEN63DTu+FQAYsCbW6QSQ9ZEK2mF4h2A1qxzM/bJ5ub518YGmb3YkKP+s4be0VvZBuKDo
	B4gxJmTtq7Vo4igxpK5fCrkRC6fEfXCGXWkRqkXPoQB3tbRtVteFlKnaOW1IzxSHdkWC99BuEqG
	bSJ5z4PhQ+hZOkrKCSqfDcUK+SRjN4Vc=
X-Received: by 2002:a05:690c:7003:b0:80b:9114:3b85 with SMTP id
 00721157ae682-83706f4684bmr152551277b3.0.1787076122204; Tue, 18 Aug 2026
 11:02:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817205017.56524-1-johannes.goede@oss.qualcomm.com> <20260817205017.56524-2-johannes.goede@oss.qualcomm.com>
In-Reply-To: <20260817205017.56524-2-johannes.goede@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 18 Aug 2026 14:01:51 -0400
X-Gm-Features: AcwNN1VwTn1hJ-am2OMW-FOMoM3ME9dN1GaV9yIHvOeEU0lqJnAdL3_Oyb6_pDY
Message-ID: <CABBYNZ+Bhhx3rtq8i_FGu2a_oFyWquo_gTRcmPyM6HcFC3pkVg@mail.gmail.com>
Subject: Re: [PATCH 2/2] Bluetooth: hci_core: Handle skb_clone() failure in hci_send_cmd_sync()
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Ibrahim Abdelkader <iabdelka@qti.qualcomm.com>, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hans, Ibrahim,

On Mon, Aug 17, 2026 at 4:50=E2=80=AFPM Hans de Goede
<johannes.goede@oss.qualcomm.com> wrote:
>
> From: Ibrahim Abdelkader <iabdelka@qti.qualcomm.com>
>
> hci_send_cmd_sync() does not handle the second skb_clone() failure as it
> does the first one. At that point the command has already been sent and
> HCI_CMD_PENDING is set, so an allocation failure leaves the flag set with
> req_skb NULL. The response then matches nothing and the caller blocks for
> HCI_INIT_TIMEOUT before getting -ETIMEDOUT, reporting a memory shortage a=
s
> a controller timeout.
>
> Clear the flag, cancel the pending request with -ENOMEM so the caller fai=
ls
> immediately instead of waiting out the timeout, and return -ENOMEM so
> hci_cmd_work() does not arm cmd_timer for a request that no longer exists=
.
>
> Clearing HCI_CMD_PENDING here is safe: all code touching that flag runs
> from hdev->workqueue, which is an ordered workqueue, so those paths are
> serialised and cannot race. The one exception is the cleanup added by
> commit ed516e3f1aa6 ("Bluetooth: hci_sync: Clear HCI_CMD_PENDING when
> dropping the last request"), which runs on hci_dev_open_sync() failure an=
d
> from hci_dev_close_sync(), and the workqueue is stopped before that runs.
>
> Fixes: 2615fd9a7c25 ("Bluetooth: hci_sync: Fix overwriting request callba=
ck")
> Signed-off-by: Ibrahim Abdelkader <iabdelka@qti.qualcomm.com>
> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
> ---
>  net/bluetooth/hci_core.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 8aeb3024428b..9585b42e7970 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -4092,6 +4092,11 @@ static int hci_send_cmd_sync(struct hci_dev *hdev,=
 struct sk_buff *skb)
>             !hci_dev_test_and_set_flag(hdev, HCI_CMD_PENDING)) {
>                 kfree_skb(hdev->req_skb);
>                 hdev->req_skb =3D skb_clone(hdev->sent_cmd, GFP_KERNEL);
> +               if (!hdev->req_skb) {
> +                       hci_dev_clear_flag(hdev, HCI_CMD_PENDING);
> +                       hci_cmd_sync_cancel_sync(hdev, ENOMEM);
> +                       err =3D -ENOMEM;
> +               }

Sashiko flagged a problem with this change:

https://sashiko.dev/#/patchset/20260817205017.56524-1-johannes.goede%40oss.=
qualcomm.com

Im with the opinion that this shouldn't cancel the request, because at
this point it may already been sent to the hardware so maybe we should
flag it somehow that req_skb wasn't able to be allocated, or something
like that, but the command is still outstanding.

>         }
>
>         return err;
> --
> 2.55.0
>


--=20
Luiz Augusto von Dentz
