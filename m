Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADA0175A9A
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 09:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782205425; cv=none; b=u2j95UvIdkjZ0FDN2bKcH5L6mBU+iMiA6X7tCT661YruPW0slo8LJCCS2olH5XeAMMju5zOt+0DiNb977lSCoI0Qxdr2OlVYzYjJ1qs/+QLZlSfKtFigHggmE7KUDR98KQEnq0LG1G1MzeTjOMneu4++J7bkqmCVdxUG6S20OQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782205425; c=relaxed/simple;
	bh=pT3yi3oXbWdj6Gtbsf6AMtfsoW+ZyoWZR8DMmRApHoI=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r9IhsLSOwbINnG2dxUbbzeMkHxcncwTNX6ZnSDF0y9eVX3pblR7y778YA1UMuBzDV6KFP+2HbCgawCoyS0MMrs9J8V77WxXa7D1VEomutwGCc0gjBIADDvIE0PLPeCEtB3fSFc2V8RZfqnt8R+ytUdcyNoEQ2ZLOcsA4j22r+aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4+MP/6z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4+MP/6z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 623CE1F00A3A
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 09:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782205423;
	bh=pT3yi3oXbWdj6Gtbsf6AMtfsoW+ZyoWZR8DMmRApHoI=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=I4+MP/6zFs4LZHsEygAe80rzfLOmfUf35qPG9UNUlK+kSEsXeHr9cUyk9n52xAyGn
	 xn1BEOVk/ZQzTx3EXVqWo5o5VM0dCHCvMmEELNIduOFYGeVTWG/UX0e6TaOUZVO0Od
	 P//BV7RaV53HKZY6nvd9uAMJLjvvabSoRJGTGZ9qX7E36N7cJrB1syc3f0xGEmfo3j
	 8oQ9Bm0ZgkKJNIO0MAhWVC8Ztme5BstOOiak2XErAvLaFXj1HBqmQKWvA+pX0NbfQ4
	 L1e6HwuoBCOQq2kaQQNjNa9t5FjABcdOrcU6C51JpG5D8vZo1biyhThLLeY2qEW4wt
	 C818BFboM7KkA==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-396669329fbso5757771fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 02:03:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+GawlqzTdO9srgNtNyvKuLYiEoKst8XOhVqw5Br7BS/d/hZaKUL6MxwTNlnbU6QqGOmsHlOPjdY8clWmkiQAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBqa4pRlaK2J1FbFgKHzy2Gd807yW3mfI8oaf0gNHk8yUaGwUC
	fX6j+vFm5qDO4dlPCIwV98+ucsGKb03e2hZ+UFeinytOSODh4A18+k8DNOTRKB0zgvLXQPvitZI
	e3gyui9mJE0XJHyaGwwylYjL3WlFFC96ZX1X/6kajBA==
X-Received: by 2002:a2e:be9c:0:b0:38e:8c66:c02e with SMTP id
 38308e7fff4ca-399c53c2fd3mr6652711fa.4.1782205421991; Tue, 23 Jun 2026
 02:03:41 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Jun 2026 05:03:40 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Jun 2026 05:03:39 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260622-bt_bugfix-v1-12-11f936d84e72@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622-bt_bugfix-v1-0-11f936d84e72@oss.qualcomm.com> <20260622-bt_bugfix-v1-12-11f936d84e72@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 05:03:39 -0400
X-Gmail-Original-Message-ID: <CAMRc=MemaY=ON2q-Cuzis0sZ9WfqjvBsFzxxCYRZrXeFPNJ0_w@mail.gmail.com>
X-Gm-Features: AVVi8Cd8xQgQy3OWP4JRXsOZj-DF64dfu775AJsANd7-NHT4tRCUvnXeggQTM30
Message-ID: <CAMRc=MemaY=ON2q-Cuzis0sZ9WfqjvBsFzxxCYRZrXeFPNJ0_w@mail.gmail.com>
Subject: Re: [PATCH 12/13] Bluetooth: btqca: Fix undetected error HCI status
 in qca_send_reset()
To: Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, linux-arm-msm@vger.kernel.org, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Rocky Liao <quic_rjliao@quicinc.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Ben Young Tae Kim <ytkim@qca.qualcomm.com>, Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
	Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jun 2026 16:52:25 +0200, Zijun Hu <zijun.hu@oss.qualcomm.com> said:
> qca_send_reset() uses __hci_cmd_sync() which returns an skb but never
> reads the HCI status byte from skb->data[0], so a non-zero error status
> returned by the controller is silently ignored.
>
> Fix by replacing qca_send_reset() with __hci_reset_sync() which
> properly extracts and converts the HCI status byte to a negative errno.
>
> Fixes: 83e81961ff7e ("Bluetooth: btqca: Introduce generic QCA ROME support")
> Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
> ---

I think the fix should go in the front of the series. Even if it requires the
new function.

Bart
