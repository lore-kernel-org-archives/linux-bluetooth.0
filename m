Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38353BF699
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 15:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782142523; cv=pass; b=HkFwRk1reajsC6YrgstRxiXokss62rz15qeoR52oVXkw9icn+hqWYjYiWqJ6wTSKgRcYKswWkrT0a+CIKt9mVj7pi6rpm3g8vCS051iFeYaGWg6LxzSjM+arOG8aWCaPB/ezjqTxhGrj71fFl+rWS8uaA3+RYd30nJG2WMvGVVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782142523; c=relaxed/simple;
	bh=5OCGKPyrQcnRpkWX0WedQu6uHAkVuPmEI/fEX9pGYvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h6YxcPbhAB8NRNv2z7fPOzNB5lAZdQObyP+kOXegc7QflcpUj25Suun47jJWfX3UARphc2CoZSrYtaBTqiByb3WLkQxW8lrkDTS9/PNNdcCJFDd/jidZukMiqtd+CkCAPFUyZ/TeYGydeh+3GDY3/UnpGJBf596bYDqUS4QCcRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BP8D5q7Q; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BP8D5q7Q"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-662dd616cdbso4651197d50.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 08:35:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782142521; cv=none;
        d=google.com; s=arc-20240605;
        b=BD6Oq4XjsrPxcAujyzPZ9wfIzFQO0nwtISIF+rMD4kW8bf+DUO45KeDksz2lhkJxFR
         O6P263a6Q9wDAyPDGY806QXYwRVDF8bh35DhZH5DqV587aNAlK2Jq+hmJ/lEKZrygIZt
         VKQeAY+HNyqQOtN7GBawZ/YgamVCow8nXuhrjFWIk/+uXKcHz7cgN0CHq4yg6Rw+TGNH
         3Rdo2oRPfmHgrd+Wn0tEBT4OK1vZ/wtHPHoDJdKRugiEI4vKOy09ZibClf1+u+PAqlQe
         RaHQ1LAwUDChkGlnnae40J8q0G+7N9hj0u45lXEDLSn6Z6SAZdcNZt6zjXwD9zOWJ248
         1PXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9lW9Qh0iORARavHIyVNPtLhkXeZSz2NoMcvEmgnoHpA=;
        fh=oCNJDrcV/UdwQjvAZaf7zt0XodYIIXOz6Bm0ICRaqvw=;
        b=i207S3NiWMyrH6ahR0rB2M21+suico9eR9i4d5/XXWTBoUlPcCMBJvM/3nRhLxEmh4
         9A3NHW9nT0HPCgH4ejLotlPC0BcK+V7Wom13zZgI4K/fkMMfVW6HO4TFm4U6NnSHu6G+
         /WQwJ/ID9X3MNO2PRFnt9miyfRjMPQWwhEUlpThLZ/W4Ew9qyjwTJv+L4N0ils7wU8+F
         01UKz5BxEJIHvxJI/PpEI3Er3n+AQ+gi3vc+hzT0jgjabqm7uhw85ZNAyMyTZIvmTpOt
         jKGEYAxqHJi5/WYaZQtSafXT7yoXSlXl2ffIj+nZlduAKOBOz4vpVGmJvztGGWTITrk/
         vYCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782142521; x=1782747321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9lW9Qh0iORARavHIyVNPtLhkXeZSz2NoMcvEmgnoHpA=;
        b=BP8D5q7QAFXc2dU6kSAWX8FJpNws7BxjJmgj6Yugkgcqx6DHdc4/9j+cyF7kwgSlGO
         UunqtejmT8WCLSPXh2eWiV6kkn2b5sN6p1u2wlYorPcRUs/LAiQVlgWdvp6u0DZOFQVg
         KbC2eCi0ScEaevkhDKSMnfGbGHTRcWLOMf4pQPJsm0Tl33Z4zxf/SdKvlgOfBkZHzoo0
         cLX4395WZE3YSKscaHHshOVwjXYlzKQZA+YowMjq9jAA2QceNwtZZ2DEHMmSzIUGPAyQ
         UojP0XpgoJviHdryKy2kogdNJjrYnp3xYBIznvXcFk8rJJiCHCeBttswkAOcXD22NKcv
         +v7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782142521; x=1782747321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9lW9Qh0iORARavHIyVNPtLhkXeZSz2NoMcvEmgnoHpA=;
        b=bzDwmZft17Th3Y67y4fJXyCFaeEbWO9RQjN8FxbWAkR2ptysqHqZN4wH9XvOulha/Q
         dapUdk5LzjpYvYLUGtgZcX7iJnTG6ewtK7gtRWVI3KUbZtQd1XK9aV1jOY5FR2qxv4Au
         6yuq8BCu1wi4Tn16AlLA7hZpOi7n3CqMqagT4LrITEmbhna8cOdKuYxVMci7VYD0hIYa
         KsG41mQ9lu0tBOqYKTZWpMPdH/F4OVvSvQu7X89ZxSBtKVVcGQg2e4BJbGCuNXtnyScl
         egEFcUkCcmX+unDX1O7gVqPtcGQAqkm1ssrZYCUyrTk0rWjodi1gpCrk53y9pAng/MaR
         YrHg==
X-Forwarded-Encrypted: i=1; AHgh+RpalD/vgLe5sucxbFw8qb5kVk8/+nK0LLuN6j5lw9Q+p5Xifp+MTgNICcwHzb7KW/akc1YlMO+FxyMCRCxhzEc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7eJd+rNrX5Bs421TGnQkZ603OCW3GpKDG8WgzmBSgO0+tyxlH
	dai08jZ/fY13j3tBgTwqrsN9f3tRmqqgH747fIU9sFUb9UzOR6ZVSLts8bca/l0uHT5qMwtg2my
	h2qyAPPS9d09pMtlG4uuOorMgI9eS4kY=
X-Gm-Gg: AfdE7ckqB6jAbZx6p22DQzAxlozQzPcVBTtsC362AwtOK+YruX5urerdRFnReec8UVk
	0Ew6HXAT0B6iX9zrFOIxD8vwuklRVhAvYB1//ZxYkpzcnsbltqqSDYd1Cbk1oM3K5givb26ldKB
	47EWm6ZmEWrOqayWbOH38RAtlEA3WPtCSBvaklhAnf6AFRpTBxZQnXKTJ/xLZI1ikQF2gIhRnE7
	uDTEjHftwbUQh9VrpcB9EZ8IdLSLTeUmvJGEQIebp2H54JSFeb+XV1+3eqrM0HNPKjEd9up1ZyF
	C8ZZMLd2qTTf0iyLjTsbWQHcXqxqN6H9vj7OTYDnMsPIC4bP4QqEiKsL
X-Received: by 2002:a05:690e:e83:b0:663:9de:2049 with SMTP id
 956f58d0204a3-66309de20f0mr11680467d50.13.1782142520865; Mon, 22 Jun 2026
 08:35:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622-bt_bugfix-v1-0-11f936d84e72@oss.qualcomm.com> <20260622-bt_bugfix-v1-8-11f936d84e72@oss.qualcomm.com>
In-Reply-To: <20260622-bt_bugfix-v1-8-11f936d84e72@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 22 Jun 2026 11:35:08 -0400
X-Gm-Features: AVVi8CeOpIYHL5-TwNBim9QeQWw0S_IkyHa2Yq5HluoguIJRtBcH4I32gcuco4w
Message-ID: <CABBYNZ+z6XcZXejs18fbX-MSFBmaGC0Reoqn549N-8sn==z2Ug@mail.gmail.com>
Subject: Re: [PATCH 08/13] Bluetooth: hci_sync: Fix return value of hci_reset_sync()
To: Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Rocky Liao <quic_rjliao@quicinc.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Ben Young Tae Kim <ytkim@qca.qualcomm.com>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Matthias Kaehlcke <mka@chromium.org>, 
	Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zijun,

On Mon, Jun 22, 2026 at 10:52=E2=80=AFAM Zijun Hu <zijun.hu@oss.qualcomm.co=
m> wrote:
>
> hci_reset_sync() may return positive HCI status byte as-is, but callers
> in the chain hci_reset_sync() -> hci_init0_sync() -> hci_unconf_init_sync=
()
> check errors with < 0, so a positive status is silently ignored.
>
> Fix by converting positive HCI status to a negative errno using
> bt_to_errno().
>
> Fixes: d0b137062b2d ("Bluetooth: hci_sync: Rework init stages")
> Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
> ---
>  net/bluetooth/hci_sync.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index fce9f9526cb5..601d44ef975f 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -3678,8 +3678,10 @@ int hci_reset_sync(struct hci_dev *hdev)
>
>         err =3D __hci_cmd_sync_status(hdev, HCI_OP_RESET, 0, NULL,
>                                     HCI_CMD_TIMEOUT);
> +       if (err < 0)
> +               return err;
>
> -       return err;
> +       return -bt_to_errno(err);
>  }

There seem to be 2 consecutive changes to hci_reset_sync that conflict
with each other, also the expectation should be that positive errors
are HCI errors and negative errors are stack generated ones, so the
callers should really check `err` and not `err < 0`.

>  static int hci_init0_sync(struct hci_dev *hdev)
>
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
