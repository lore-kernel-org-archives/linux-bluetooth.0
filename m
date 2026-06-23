Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CAE2D77F5
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 08:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782204965; cv=none; b=AbgOnfYw/52yglTC1I7uugXG68kJa9Di4iJJyCMIsibGKkFewM5EgI50wD3LaNSd5thIKdlKDtenu622pRAdJmtS3zteI0BIgYkeL++2YblyEls7Pvca4O89ku0YgHOgl1tmahOUrpJlx0VbTK1OZ4YfDwNAOafAbB4XFFs/HKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782204965; c=relaxed/simple;
	bh=tMqDaqvWgrY73DBDJIQvMJiYaoK45B0BM6Kqt85d2eM=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hI/UP+8cPdphjfSQ1WsJ8HTNm+vxYJHdGc8fAgQz2su0OMv20sg5oipOW69pcbIt3tzc5rWpA6FgRHzSuNAyochnefKfB/FN2pLQl3MMZeRmNIu+m3vrUs0Hzh3n/Evwnium/iWogugURvsfpbVTCqyDM04MVKAqJxbtcRq3vKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5Fp66rP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5Fp66rP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C361F00ADF
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 08:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782204964;
	bh=XCSDVLs1v5VL0YI6/K4DpzPCqnReN/qAG8qjL5AnhLY=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=j5Fp66rP77vX3M4T3UIKHebUpXYrnzxjMP2H0MCghzQ5Ak9tSpg0hIyNVc91Eg6YS
	 7LVahGe6AELEy+tFRpktai5DpUkQl4A7MBV4eXvTbGGY6Ke5E+Dh7xZzv7RUA+Bg7h
	 uZ7iVKmFYmTmZRF1BZtR8hvCquC8sKObxsJAeFw+Dyh7I+Ar4g5CJi7+vQ1SBlKLwb
	 Ntv0vhSWFpuXTnBNjn2H8tuI/Mf3VJaEBwZc6DyZLYk05Q9HjfqLViruL0LFQZG+9o
	 k7GnkDwVNxw7/Vk+RDrfKb8kyXOxCKNP3mHjcee8ph7qfT6IT9nAnRXqSJnmoXjAeg
	 bhk76TJ4floQA==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-39677c80386so58931231fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 01:56:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+tBvvvT1nOHYZ82AK94gpXYD58qzAMwJuXC/pwJ+xi5AgM2dgami0Rb8bklfRVKYoBSsnLrEBHoY6RRpZy5F4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+edMWpnjT0ZEsc0Y51XNPCe4Z1uBtz0JhSEZFFo9A5CTPh1IT
	iQb3E5LS8j94TCnDKU11XQiFoVLsjW0worvxzVz8UOY9s7yjL4h6Gt2CrrOrJFDLcLCvEG+er8K
	gNmqgazxrzurnUBJA3J+bhZHphzr0Sv87r7Y+n3p8FQ==
X-Received: by 2002:a05:651c:1602:b0:396:a807:bde0 with SMTP id
 38308e7fff4ca-39a2073f5d7mr5324951fa.0.1782204963324; Tue, 23 Jun 2026
 01:56:03 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Jun 2026 04:56:02 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Jun 2026 04:56:02 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260622-bt_bugfix-v1-7-11f936d84e72@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622-bt_bugfix-v1-0-11f936d84e72@oss.qualcomm.com> <20260622-bt_bugfix-v1-7-11f936d84e72@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 04:56:02 -0400
X-Gmail-Original-Message-ID: <CAMRc=MfiuK5kWX_Wof2CFr1Ct0jrc8XsUk6mKi_QAO5vFZzEsw@mail.gmail.com>
X-Gm-Features: AVVi8CdzJIdELBc5-o2D7cK9wimmgXdfGbi7xVd0KOZratMuVCYrA2SqxtTjgFo
Message-ID: <CAMRc=MfiuK5kWX_Wof2CFr1Ct0jrc8XsUk6mKi_QAO5vFZzEsw@mail.gmail.com>
Subject: Re: [PATCH 07/13] Bluetooth: hci_sync: Simplify hci_reset_sync()
To: Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, linux-arm-msm@vger.kernel.org, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Rocky Liao <quic_rjliao@quicinc.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Ben Young Tae Kim <ytkim@qca.qualcomm.com>, Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
	Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jun 2026 16:52:20 +0200, Zijun Hu <zijun.hu@oss.qualcomm.com> said:
> Return err directly instead of using an if/return pattern.
>
> Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
> ---
>  net/bluetooth/hci_sync.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 3be8c3581c6c..fce9f9526cb5 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -3678,10 +3678,8 @@ int hci_reset_sync(struct hci_dev *hdev)
>
>  	err = __hci_cmd_sync_status(hdev, HCI_OP_RESET, 0, NULL,
>  				    HCI_CMD_TIMEOUT);
> -	if (err)
> -		return err;
>
> -	return 0;
> +	return err;
>  }
>
>  static int hci_init0_sync(struct hci_dev *hdev)
>
> --
> 2.34.1
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
