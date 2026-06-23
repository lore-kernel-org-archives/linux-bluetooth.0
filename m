Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E714175A9A
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 09:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782205475; cv=none; b=A0t+NEH46waIh5G5C6xvDuZwwOKcTIH3zNoglhsP4/UQUoUaoGxt7hqwi9EVg9fOIs1/aQZ1+hWBLbQJJt0KIUM3okbjxU7+KBCAhAeY/Z/DPhSwPurAGRQIvxOrUKaU8CZTS3Ga082/0Ky5oWy8fo8bkR7S3mc67gP192ob7gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782205475; c=relaxed/simple;
	bh=yuh0Klyj0pxq9kKU5f2K6hyi4u3IEmjnDUmrZZz8nhU=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ChQK+6ry6lCbI08Is5De8PXs5EAzfRWoinVCRimZ/hUyQTJqj7SGG+NmRF1fYWhBKHRMEcXse7umW4AhACR+6/o+VxrD4UZEVvoqDneJnq/Mb6nGjTf59ev1ZtNC4jrhACDbC+HseNDYXLLnJsuG9+orPFf72vMEiZwivAEE/fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ExDb65EQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ExDb65EQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B4D1F00A3E
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 09:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782205474;
	bh=iEV7XixjZN1bJufvnOqMtI6bG7F35z7asYVB9PNz9CQ=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=ExDb65EQN7XDXOvPyYeCM/iGaLa/GuwZXYEX7rjMX6tcp/YLRT5hvbMxUyWuLGh9i
	 FQ9wEGt8yncITa3LjgHJvtWekoKhxx/plOdf4YSO4AMde/rCuWcK0h/lUMDTR0jGBM
	 Q8Y0n9Mt5g5AZ4ZsptDcxquo6fodhhyi/vrlYuGAyqm+7BvVtuW4z3fz7GxfniE0+P
	 cOvKUw4qY8aP2+rJ6f47d88GoXw5POmv04MbV+L/DBvPf313Py4rMeA6YLeM+sE5Ez
	 5i+rFJH+h+xqyVYp+iZS+BK3/2vqCxgvgWXjDxvFVDuA7o9xcC66VR/fi2Nplw909j
	 24xpocYfLXhUQ==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-39657d28132so44292421fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 02:04:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+6LHtWb8bnSUl0pFIPXc17C50Q2TxtmjWxsznAcN6cr1XADGVLKUhx+iKgg0GYG1spNg5mSv/u4HwTUeHwGYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YymL9ISlYBowokT5m4Q7bZZsh64jpNjtSFDfc1bLawR+pXTXSJr
	JE3QAXYTF5Bt7zaI69+3zFEMcyXfiSJ21ZdvPPBYhJWqqwyFtHqot1xc3/MMA/lo3JZ5mkCuXxL
	OOIkhq6sRUaofse8pHvqS4pYEvbd25+aXkKJLXNPo5A==
X-Received: by 2002:a05:6512:1412:b0:5aa:6585:1b99 with SMTP id
 2adb3069b0e04-5ae3e5098a0mr455431e87.23.1782205473013; Tue, 23 Jun 2026
 02:04:33 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Jun 2026 05:04:31 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Jun 2026 05:04:31 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260622-bt_bugfix-v1-13-11f936d84e72@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622-bt_bugfix-v1-0-11f936d84e72@oss.qualcomm.com> <20260622-bt_bugfix-v1-13-11f936d84e72@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 05:04:31 -0400
X-Gmail-Original-Message-ID: <CAMRc=Mc_hjCPe+aLQhK-ProNuh=4-43mPqqmQNQ81Lu4Do=fGA@mail.gmail.com>
X-Gm-Features: AVVi8Cc8GWmX67wsSbP24McGlkKaiR0DRKPB5Xk2fBzVk3uFY5WxGc5g0orBrUA
Message-ID: <CAMRc=Mc_hjCPe+aLQhK-ProNuh=4-43mPqqmQNQ81Lu4Do=fGA@mail.gmail.com>
Subject: Re: [PATCH 13/13] Bluetooth: btqca: Fix qca_set_bdaddr() using wrong
 HCI event type
To: Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, linux-arm-msm@vger.kernel.org, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Rocky Liao <quic_rjliao@quicinc.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Ben Young Tae Kim <ytkim@qca.qualcomm.com>, Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
	Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jun 2026 16:52:26 +0200, Zijun Hu <zijun.hu@oss.qualcomm.com> said:
> EDL_WRITE_BD_ADDR_OPCODE (0xFC14) returns a command complete event,
> not a VSE, but qca_set_bdaddr() waits for HCI_EV_VENDOR.
>
> Fix by passing 0 as the event parameter to __hci_cmd_sync_ev() to
> wait for the command complete event instead.
>
> Fixes: 5c0a1001c8be ("Bluetooth: hci_qca: Add helper to set device address")
> Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
> ---
>  drivers/bluetooth/btqca.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index 875216e15603..f3487de813c2 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -1011,8 +1011,7 @@ int qca_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
>  	baswap(&bdaddr_swapped, bdaddr);
>
>  	skb = __hci_cmd_sync_ev(hdev, EDL_WRITE_BD_ADDR_OPCODE, 6,
> -				&bdaddr_swapped, HCI_EV_VENDOR,
> -				HCI_INIT_TIMEOUT);
> +				&bdaddr_swapped, 0, HCI_INIT_TIMEOUT);
>  	if (IS_ERR(skb)) {
>  		err = PTR_ERR(skb);
>  		bt_dev_err(hdev, "QCA Change address cmd failed (%d)", err);
>
> --
> 2.34.1
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Looks good but should go in the front of the series and land upstream earlier.

Bart
