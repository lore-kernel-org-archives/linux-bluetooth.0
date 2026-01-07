Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D17350297
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jan 2026 14:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767797290; cv=none; b=NeDMORSAJXriJtpjUIHMpgp2O5eGmud/CnkYaqvv7aZvVL6ZSTTa8lmxMO4716oOXqaCWEQFqp2ammoH8Yfpj9JlMkwTBKEsxaXXgV+t/9Bzisf+jFSUG24BihbboYX/JiB5DTBMNwZR9JjmaomABvh4LAAKt6bCuO6XPwymjfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767797290; c=relaxed/simple;
	bh=jqVFVwjXEGeJeMYSRDQgHFAdPRrb+aDpKucKTx2DPXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lvkt0xl5nZs/VvEYx83MglG9wLwzOUn475sMORbwqvN7tK8eXgT4xvFGF5YWd4n9hXS6vXeaSr6sD7M5wW/AMeG/y5X9nHXlWWBihTbC2So6af3KQ6657YC94vLuuv7vypkwivKcA3IDB4QqMpPiI4+ChOmSEv/nGjKWQGyYDq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDBPu0yU; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDBPu0yU"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-78e7ba9fc29so24628927b3.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Jan 2026 06:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767797288; x=1768402088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGxpR1Egec65BiyhYoiU7hHXukKj3jVU+l6UVvpYxhQ=;
        b=LDBPu0yUx2IuEp6lVjswHqBS4BPc5x5HBCohQ/+RvWwSlL3qgzPe5cPAjV64avULrB
         +ETz2w9qQOgITC9Kci+TFDc99WIQ23zFsebyXU5uE2FjstUjiSlOc7l8U4K4TJyWCJNy
         hIzumd+T2+tHISXH9cVme3jmR4BEB5d+VoaBuegV2Qb4MIJDBxG1kTm9mOW/jH/AK4ou
         PEbMGWcxNeFHpx6E6PCWO/6oOVseYYpQUm9/3EEpmBlwIrlO4Li+ImI4NoFicjKBkoOI
         eU5zImS0TN2+BOxBaXR2zb8ozHK6noG2yHsW8x+7zEc6XWS3DAD0NIta3fcjUweo6sy8
         enrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767797288; x=1768402088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bGxpR1Egec65BiyhYoiU7hHXukKj3jVU+l6UVvpYxhQ=;
        b=NBb06w6A3Euw4mFzT1EXf36QzPNCQp05dsvF0Ca6fo7iIzEqCnh73hFiQiRNxzhT5n
         ggwKezTToN0Spax/Mp5pVbMKCrjLwBcjg5KwMcyHPr6oUZgzG4lCESVshMlSAgbPc5gJ
         hO9ur08dwST9kdwLgu8N3G7qNbo+Tq9oNPGszmt0lp1h6jZHliUgWFloCtQMWgqiRtde
         iKKSKWK2agfi94OaYF8a7eJNeRtcNPr43ELiSLPQfP1Pd0bi/c37g4WaEmtitWxS9eLl
         qBVH1jy32LjmKHMUnMFfBGf8Xz3SiRwTHYcCLHnqySo5ZzWMGfj1vP2oQ+vFhsxeNHA/
         ffsA==
X-Gm-Message-State: AOJu0YzMb7qp5ZweCXQSfLnX/IYTCKDKlnYgxSed87o9kPRnLgsCTGVg
	Ded9GeuSFww4kin14ANXY7UTlNSdoKv9yWZ5jz69n7VpRODUIBRI6e8PrhNO7GLTykcVIdnoFe1
	+qlXZhC9qjavM+KNDMdn8tIM78k31HBo=
X-Gm-Gg: AY/fxX5JYYhw6FVNVbPT4CEQcqX7zOP1VemKl8ePYo9BpHWC1SMwP2IUEJiAzbmmyBG
	YTegZNpzlUyW92IrYqVM571VBMiKWAocYDMJxvRTQAfij7bQk7tkcK4mpL6hpA6AubnzMUnTc/M
	GGhKVaTTIIl6nQTbNFbhjo436vwDLtuT2c4eon0Xap/bxlAY0DtQmzYmnrNg2pEBgq8s56Kps6E
	kjNXgk3zMMff4qiuSb0lTWSLn1R1QepNRwuEB9Fn5UR0NL2Vf7+vb6BKxUqKOZM/r0nLANspazk
	Wdu3uno4RjYPUZtPp3/bYzucMIH0VvBrHSYHqFdGYbyfs009GbfSj2rA1w==
X-Google-Smtp-Source: AGHT+IH3aNCzG59JljbV/j2Im55EwKCWNIPs+Yewt3z1y23N77lH3754Nd7Saejg/3ZogPgDPsjST6GbPGPgYyBkSUk=
X-Received: by 2002:a53:cd4d:0:b0:63f:ad02:8e2 with SMTP id
 956f58d0204a3-64716bda129mr1823652d50.31.1767797288259; Wed, 07 Jan 2026
 06:48:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107024820.1722270-1-lilinmao@kylinos.cn>
In-Reply-To: <20260107024820.1722270-1-lilinmao@kylinos.cn>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 7 Jan 2026 09:47:57 -0500
X-Gm-Features: AQt7F2pwd4eHtzBipDhAm7DM7xV68V7-SuA0y417hI7b9WxSNb2nvkt6nz4QKlM
Message-ID: <CABBYNZ+Zq2HYsfGbOi7V=pnV1GczSv6--rMEbi+=yCXE4p+-6g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Reject autosuspend if HCI inquiry or LE
 scan is active
To: Linmao Li <lilinmao@kylinos.cn>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linmao,

On Tue, Jan 6, 2026 at 9:48=E2=80=AFPM Linmao Li <lilinmao@kylinos.cn> wrot=
e:
>
> If USB autosuspend occurs while BR/EDR inquiry or LE scan is active,
> the ongoing HCI operation may not complete successfully. On some
> devices, this can leave discovery.state stuck in DISCOVERY_FINDING.
>
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
> ---
>  drivers/bluetooth/btusb.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index ded09e94d296..885c3d8c0a10 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -4469,10 +4469,13 @@ static int btusb_suspend(struct usb_interface *in=
tf, pm_message_t message)
>
>         BT_DBG("intf %p", intf);
>
> -       /* Don't auto-suspend if there are connections; external suspend =
calls
> -        * shall never fail.
> +       /* Don't auto-suspend if there are connections or HCI operations =
in
> +        * progress; external suspend calls shall never fail.
>          */
> -       if (PMSG_IS_AUTO(message) && hci_conn_count(data->hdev))
> +       if (PMSG_IS_AUTO(message) &&
> +           (hci_conn_count(data->hdev) ||
> +           test_bit(HCI_INQUIRY, &data->hdev->flags) ||
> +           hci_dev_test_flag(data->hdev, HCI_LE_SCAN)))

We shall probably use hci_discovery_active instead of testing
individual bits like above.

>                 return -EBUSY;
>
>         if (data->suspend_count++)
> --
> 2.25.1
>


--=20
Luiz Augusto von Dentz
