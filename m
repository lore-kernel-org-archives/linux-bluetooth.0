Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55432213E9E
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Mar 2025 15:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741275037; cv=none; b=HE2OXlXKt25PCEHdzqVLeAkFgetPagXPsZmCT1fNQTO/Im8amdkk7IulJ9G2GMlzAKs23p2qGRyAZuxv5FmShOb58C8RnrdO9jlJ5tDqH8Q/AzYpGv3ORO9CIceANDVDGXbqy87v0ao/5jC4mrrXDkXBwwqr8j8+fFKY3I7pGq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741275037; c=relaxed/simple;
	bh=pyLJpR7peyTXQEIa1NqkvFFGoT0NVWTptWjHyPuIU5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IinB6Ct5lt71pDVbW+YQEDn88B5eKBSVFt9YMQLkkJh2OY9GMNcOeVO+wnmcgL8Pi0+zuaDbVrTinZB8CHV3kdjdykOcxFp/IHqAhTzzy+z6QSZZYmf16Vc5GDhI46BTpfvZcOZVvEvpc+GrHP1NYSIRs2I9sHNGbBXUUe+RIFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G/5PkE30; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G/5PkE30"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-60018b29f51so515455eaf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Mar 2025 07:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741275034; x=1741879834; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sNQBMMRurtTMZcGexPMcCrxPkfGTs27WGkh0+nCXqaQ=;
        b=G/5PkE30c7cWkGushzgN7wSveOWz0SndRjYy1kbwB6rwHClaohFZ1xxVCQteXp1/KY
         BUapkBUk823ubTBZycMMSO2etpNGpHH9ZzeU80BwjLfEfWjtfSaW+SNqDnMOhqiGgUjX
         bhvS/A7cJvoaIPhElOInzr6LPN9FImMDmX1Gp9wfrDKqD+etHyd27LKQaH2hTcZpvCjr
         +rZ5n/t/cNnEtz4uV3lOrh4n1c6s4n+HKNIxJY9PYouMCN4Rj0a0CSTl6X/5fqVYPwvE
         1WS9Xhh12I4hTmIpGuMJVzDeWSdnP/ez/DxX48t/6ickqnwsHw03jjVZlhY0h5do679m
         WoIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741275034; x=1741879834;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sNQBMMRurtTMZcGexPMcCrxPkfGTs27WGkh0+nCXqaQ=;
        b=iplzqa6sK2kLQ1FgS/p2L5TKAc194LVjpDq2TMBA9xe2VoR0vlnsJost5/JBrk9a7S
         Lcqm6dxgQAA+s26QAi5l6Rz8NGbM49GSuXw4thUb6RsJR9AsIBz9zF+xu4Y5Wxu3dExf
         WV+ljH/hHpIKdGuMBEGdHn1naIsPZwlNGDs2qVpDpIpVPUL3ucQMkUdRnB0j+LPo6dyp
         ADnNGjqQR09pK3f93aMGXOWvlTVYwCugrtXzWujOFBmP2xg4GHZ7lfBZ2jjck8U3hOuf
         0jZUENafWWayxCXTCxfIC9gvRdhdOfKXy3SNXAWmEEudCzFWMEgDTyg6LdKWlfzRikb4
         P0Rg==
X-Forwarded-Encrypted: i=1; AJvYcCW+L6sQvurJHAyleeOJw1Ud9/H6SOWRWhR+lBmCq3o6A1EF8ziJR21uCb9RifJa+pDPEXRAo3pOv+r6vYhQM+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY0IWlWI5Aa1cNsUhVoH5cv7MNX1IDm7vj9upVoUstTFd9vX6a
	0eoUURfTn7TRjbBclXfm0IILvfbWLxLS8SQYaaixJ2NGa8RpMWsN2I66ReVYyC2mHSfRcmS4hIz
	RwVIeOdVgC5gGPIdCaf0G3fJBAorQJqfnKbFGqw==
X-Gm-Gg: ASbGncsl3TfK+DIvs2aIcBbZK6jpXfbZwoCZvDvNiH/qHDIPJ2658CGmOS6gkVm5cUX
	zXiUCzI2e1iJbkxc3J1A0vvaMFCZchaC4pFkYab/zQ1eLVDNEtFvbOGdu46xOxr+MV9Rksvod4f
	IIq59rbmTAJL7vpyiPXUkGQ8OrnQc+6O2eImHQP4B9e/SSZcYkEkFjIMj/
X-Google-Smtp-Source: AGHT+IH4W0yRe4u7K6oiBA8ZPHCttgqzGQ+tvEf5grhz1HVFab5HIeIG6RBvk1m41VxlWCFwvUQmmPKg1pQBl0yspIA=
X-Received: by 2002:a05:6820:2709:b0:5fe:95b5:78c with SMTP id
 006d021491bc7-6003eb2a7b5mr2022562eaf.1.1741275034380; Thu, 06 Mar 2025
 07:30:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227105718.1692639-1-catalin.popescu@leica-geosystems.com> <20250227105718.1692639-2-catalin.popescu@leica-geosystems.com>
In-Reply-To: <20250227105718.1692639-2-catalin.popescu@leica-geosystems.com>
From: Loic Poulain <loic.poulain@linaro.org>
Date: Thu, 6 Mar 2025 16:29:58 +0100
X-Gm-Features: AQ5f1Jq2gqYinafusJfYgm1phirMzxRY-qnbeOTyjPqUfqREkO3jtYUld7G10d4
Message-ID: <CAMZdPi-4rvKfPJ2zQJ8mMOkuJ7SSXk3OePKrFYapFmdw9KZs7g@mail.gmail.com>
Subject: Re: [PATCH next v2 2/2] bluetooth: btnxpuart: implement powerup sequence
To: Catalin Popescu <catalin.popescu@leica-geosystems.com>
Cc: neeraj.sanjaykale@nxp.com, marcel@holtmann.org, luiz.dentz@gmail.com, 
	robh@kernel.org, krzk+dt@kernel.org, linux-bluetooth@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	m.felsch@pengutronix.de, amitkumar.karwar@nxp.com, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

On Thu, 27 Feb 2025 at 11:57, Catalin Popescu
<catalin.popescu@leica-geosystems.com> wrote:
>
> NXP bluetooth chip shares power supply and reset gpio with a WLAN
> chip. Add support for power supply and reset and enforce powerup
> sequence:
> - apply power supply
> - deassert reset/powerdown
>
> Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
> Reviewed-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> ---
> v2:
> - rebase on linux-next tag next-20250227
> - add reviewed-by
[...]
> @@ -1522,6 +1525,7 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
>  {
>         struct hci_dev *hdev;
>         struct btnxpuart_dev *nxpdev;
> +       int err;
>
>         nxpdev = devm_kzalloc(&serdev->dev, sizeof(*nxpdev), GFP_KERNEL);
>         if (!nxpdev)
> @@ -1549,6 +1553,16 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
>
>         crc8_populate_msb(crc8_table, POLYNOMIAL8);
>
> +       nxpdev->pdn = devm_reset_control_get_optional_shared(&serdev->dev, NULL);

Maybe devm_reset_control_get_optional_shared_deasserted could be
useful here instead?




> +       if (IS_ERR(nxpdev->pdn))
> +               return PTR_ERR(nxpdev->pdn);
> +
> +       err = devm_regulator_get_enable(&serdev->dev, "vcc");
> +       if (err) {
> +               dev_err(&serdev->dev, "Failed to enable vcc regulator\n");
> +               return err;
> +       }
> +
>         /* Initialize and register HCI device */
>         hdev = hci_alloc_dev();
>         if (!hdev) {
> @@ -1556,6 +1570,8 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
>                 return -ENOMEM;
>         }
>
> +       reset_control_deassert(nxpdev->pdn);
> +
>         nxpdev->hdev = hdev;
>
>         hdev->bus = HCI_UART;
> @@ -1583,6 +1599,7 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
>         return 0;
>
>  probe_fail:
> +       reset_control_assert(nxpdev->pdn);
>         hci_free_dev(hdev);
>         return -ENODEV;
>  }
> @@ -1609,6 +1626,7 @@ static void nxp_serdev_remove(struct serdev_device *serdev)
>         }
>         ps_cleanup(nxpdev);
>         hci_unregister_dev(hdev);
> +       reset_control_assert(nxpdev->pdn);
>         hci_free_dev(hdev);
>  }
>
> --
> 2.43.0
>
