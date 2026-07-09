Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74CD37205C
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 13:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783604779; cv=pass; b=GPo1cHlUTuhDH+2uyjB8z7SvY5tvd0WuxtE+Qw3j7ekKswmgh2mP1jRJ3RsIux6UVM0gDiqEc8FB4DT4iXQ1A0Wy7tUQ27tPgPMW2U5ZxWWVB+mmRtwMEClKDPdzIUFtSulpX4p3jDIiEeWdV7u6UINTLUMzFmD5F8TfdOJXrWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783604779; c=relaxed/simple;
	bh=RMbVu+fxaVZsZomZVTtq38AHoy7C26AVGzbg+senexU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ddIvIYi9o3TG14VVoBJ48CRoGv5UFPA7zTk/agTUBOqwRt+vYk0E5ZzSv9eayRmwOqu8s8Xbpiajr9tntP125j5ZL1Vv52PMkM/xTkpG/SO0nLbTwLLh4xY1HVDLPsyxXb5ZwD0DlMRhShQx96rfiuLwc8nIzVn1xRwguXlMFpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2LlrCtX; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2LlrCtX"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-667bae10ba3so535884d50.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jul 2026 06:46:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783604776; cv=none;
        d=google.com; s=arc-20260327;
        b=qHzAvX1gWYEYG93hL0mjy8ds084QIHCJ6gJwtoIcC9LGgUokJPmXq4vE4Kp/GBsKBQ
         lxUr0HVSLyJ9/Y5f3ZJfGwQNdJO03Fc/ArhTu6Z2mC8TfbkURymMhzSMX9VIWrHdZMlR
         +APtdO9zGlwU0l2TpksIuVHn+C9fT+bDmCuR3DRhvXeqSzTgtfzEgoKc9knEqQ17LKdM
         nPf5KJczMeh3IGxN/SwHwNluFfovJZOgsb5yuQZX3Z4ycmiBDmiyBky0gpDr3K+RJic2
         OF+qF4rfleAmjoPYOzzAHBlDgePBgWNEEtdTL9s2go826l23GgVS5EIKpzZiI5Gnzt+w
         64vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l1NeMaGVhmRUTU25HGvUarIMaGGLRefoRei9QxPnGy4=;
        fh=DHIcuCE0V2SUSPR+iPoT/Zu2VFyYRAv/ElxsWgQ9D8s=;
        b=d0DXLbq4QUHZ5d1C/1Sa3//dbOj7UFGNfLqJCLiR3Gfdxr+ZS+xyB0t3Thb0AoE56k
         ePZTghsxuXr2xkU5Lo75hm5sYkB09+TgqEfsvH/YwUNM0TyGjfxGVYBI1hU+WzRU8Ccz
         ADUIRxoikTUVWsO5Ic4RRdHHl30fXTpIIgoKlGVqQejdK1HdfhARGutO0+v/bl4N1hFL
         lognXD+H03jFRwYbBYyNOizHbHZ9cnYemy5pIZ1gKY+JaqbYviP6NWlyFcLADQoOcLjM
         oPcDL/Me5Qrx5bq0j+PgqfEpoBL1C2rYcshqbPXpLCgb8EBvV+6+IeWXJJn7i54Jt2hl
         8/gQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783604776; x=1784209576; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l1NeMaGVhmRUTU25HGvUarIMaGGLRefoRei9QxPnGy4=;
        b=F2LlrCtXi8jPlt+rdqgsBbCI9T24/gO9NYfTfwwUD4Pa9LjP4CzpHjhsZ6WWTYRyp5
         s19DPrNLDtyQmNjxzljDrBvIqj1ZSbdgyDkx5qPEVGOJwXA4/u5Wvh/8aTkAhyD8c0/y
         P+1bOqVFGSmpfBAN061ELiJ6alR+KjTPvj4iNQnykNiIt/V5cz9gdoIVS7LJlQ7JeT4E
         44+R5DWnP2tAe6QYyf+jEuvMvNkVuWLpvHNZ+a3x3efoJnbcPIDm91O7sR8tALNYg/lb
         GKmWxiuu9y6cV7mQmUz9OcyBo7Wc4V1Crp/AbnSSTyBHMeDbRgK91g3zqzz5LE7LHmWU
         J0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783604776; x=1784209576;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l1NeMaGVhmRUTU25HGvUarIMaGGLRefoRei9QxPnGy4=;
        b=aC2W9bxZhr5Zu9zIr2xZs1Kp1lwFB0s5i8bfRrhZHNDO3Su09Wswh84O6/CZGbnr6k
         viEfb7JB023XSMtxbksR/XA6ChVtm1hW8KWOYp0aWnGA7SqSpppdAfC1RhZM4l/YWKk6
         LaJPsNVmDQvCq3a36+uKCR8b3ozLMdZ0vEqYFQ0MFGcdNq3NYVkCoQPOWbGt+meNQVVm
         5+kJpDy3eRJPqXYGPTKKGC3cqP9jaDZU7/KRhKeapWiYoNsdOnfTwGyVoTHhdnrCV9qR
         CRd9zLC/NALOV5/XH6V5h2zEKL8xib+EZTWijzpu2LzxgQQnMJcjca7QAhW6+AOwOmH2
         FtgA==
X-Forwarded-Encrypted: i=1; AHgh+Rqs2AwA8HYfETFPmcMOVyUNvMlJte07Ss73So36zHEeFULeNUXoh85vSy8Pj9R8eGf7t5+Z9mXDgJZqq+69VkA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0txDvOu3rUBVnLG835NKkli1x+7ivcXFCMTlNaknvJIEu3Qrb
	0oF0tLERpgaxwCPXja90cc5IThTuhQYvOlklHKO/kLrxjW3MjCcLuCCdsrD1jo9WZaYmDwCWvpZ
	eMLL3QZx/XNc2CBVevxU+nE0ch+g9WiI=
X-Gm-Gg: AfdE7cnoQEvLGJhfQlH0XiGFAfTK+EsEw/e2JjbKXTB0BvjV14rY1lEOYK5o2TNlpAK
	CXmNv/ku1mhIptrBYODv0EwtE47vlPVcWX0TFSl5P98Da8cVWFt0+rdfXgI8pHtgg1oDiuByhE7
	55gYZQOXTYTeCWjlkPxoDjPs1s/R9roBBD/95q2a+7OCQq9TJJl7/dxHBqq/Ns99YSUNjL/BST1
	EOWWQyyvDTuDz6y4GygoS+HGOOPmuRAQrAVYzBVW3KzrGT/MDITViIOj+90apfDISP8fQ9T6kem
	eQcl8EqIhsM2NNBvwaZyyPWQ6JUSWLX/Fm5v8fW2UtjQiLTY8gmLJfG4LP8p/YYmGXELBw==
X-Received: by 2002:a05:690e:d44:b0:667:c30e:5b0e with SMTP id
 956f58d0204a3-667c30e5d4emr21900d50.108.1783604775550; Thu, 09 Jul 2026
 06:46:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708-btusb_prep_qcc2072-v1-0-d835b187fd01@oss.qualcomm.com>
In-Reply-To: <20260708-btusb_prep_qcc2072-v1-0-d835b187fd01@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 9 Jul 2026 09:46:03 -0400
X-Gm-Features: AVVi8CeSzSYr7k9nr3K1HgjzRex5osH8xe1xJp63B_NHqYXLPYlyPh3iuEpID5c
Message-ID: <CABBYNZLYXEAqXrVfCxFtgYEU-gCZariPYiGbk3zES0tQ+4qSAQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] Bluetooth: btusb: Preparation for upcoming Qualcomm
 QCC2072 support
To: Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Zijun Hu <zijun_hu@icloud.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zijun,

On Thu, Jul 9, 2026 at 2:15=E2=80=AFAM Zijun Hu <zijun.hu@oss.qualcomm.com>=
 wrote:
>
> This series collects the btusb and devcoredump changes required by the
> upcoming Qualcomm QCC2072 Bluetooth driver. None of them are QCC2072-
> specific: they refactor btusb into a shape that can host vendor-specific
> source files, and make a few coredump helpers reusable.

I really this not a 'lets redesign btusb because our driver is not
standard Bluetooth Class' kind of thing, we already have hdev->setup
and other callbacks for vendor specific functionality, if you want
more than that perhaps it needs to be become it own driver.

> Posting them as a standalone series because the QCC2072 driver itself is
> larger and will take longer to review. These prerequisites are small and
> self-contained, so they can hopefully be reviewed and merged on their own
> in the meantime.
>
> The series contains:
>  - coredump: a readable state-name helper and a fixed-size dump header,
>    both reused by the vendor driver
>  - btusb: an indirect recv_intr() hook, hci_dev-based recv wrappers, a
>    shared reset-prepare helper, and a split into btusb_main.c so vendor
>    files can be added later
>
> No functional change intended.
>
> Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
> ---
> Zijun Hu (6):
>       Bluetooth: coredump: Introduce and apply hci_devcd_state_name()
>       Bluetooth: coredump: Allow drivers to pad dump header to fixed size
>       Bluetooth: btusb: Add an indirect recv_intr() hook to btusb_data
>       Bluetooth: btusb: Add wrappers btusb_recv_{event,acl}_hdev()
>       Bluetooth: btusb: Add a simple static btusb_prepare_reset()
>       Bluetooth: btusb: Build the driver from multiple source files
>
>  drivers/bluetooth/Makefile                  |  2 ++
>  drivers/bluetooth/{btusb.c =3D> btusb_main.c} | 33 +++++++++++++++++++++=
+---
>  include/net/bluetooth/coredump.h            | 11 +++++++++
>  net/bluetooth/coredump.c                    | 38 ++++++++++++++++++++---=
------
>  4 files changed, 68 insertions(+), 16 deletions(-)
> ---
> base-commit: ca75417ab1793f23b3ddc91869f0809b593d6954
> change-id: 20260708-btusb_prep_qcc2072-23604a4e81d1
>
> Best regards,
> --
> Zijun Hu <zijun.hu@oss.qualcomm.com>
>


--=20
Luiz Augusto von Dentz
