Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0668224E4A1
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 14:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782830633; cv=none; b=kDp32ZU3nSDWwurGJy9z+HZBNQ9VdOcrhiZLhvkIGOxcqxmaAM5Njp7CnueW6n2FB1U5vLHRh5l8k1AbkJ7pGVKbJ+p24cyy0RJJRSsFSkTtXAnytMMYEKrXzmmkYLOpVwoY6cMqZSYxfgs7d5rJmQqJNQu5tZQvdGpdrjlJ/Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782830633; c=relaxed/simple;
	bh=qpeseQp59dvQQ0ooe+UW2+l1fvlqNH7RS/1FWS5IKpU=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tENQrvrVCJ2XXpjCQK7F8oWY06GvXTWcK1Roi/pfVqdZ7xQq6zDLOeSPQc7rOoW1U/ogA8yO7NMwSZysjWuQKrfHx0VrDyM5ZeG7s00epXdac5v9VkdsfYNZRZyL9K3WZYOpuoYQjhKNNUWRuIT8NfgZwBaDtFxA0ZJxPAiUR1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rv3vQ1kG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rv3vQ1kG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9FF71F00A3A
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 14:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782830631;
	bh=MWgqL4Q5HMM/wY0dJqa72d3dmGGWeJtoQeyqL+l/mHo=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=Rv3vQ1kGTiT4hZknb84sZNeMfoSVn1+L25N83pneo3w6QaI4EjqKsE6bBSTYSZrIU
	 o9HGM/BYdsze9fR2EuYvdLzFxO6CpgiWNph8DwGvgUDxJrs3CEx65YbIYoxQh6U/vc
	 IbLcrd427UIs9NkJ1xx/Kt9xIu/NiwtLCvguFD17IofOKOey3UxhI8Fj9BykgIgV6j
	 w3hYiOjkjNRLc6PBtjPJL1LQu2xZHkDB2DP0YkbY6X0zg12aCM+BGqYVJCoftuNaKY
	 yhosx+wfJTT33/3gaeXu/zTjwoXxnD6/fABkT9eMtDl1UqqZhEoxU0MKKL13ziNoyA
	 VibvqZmncwSNg==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-39b14cf91b9so12958921fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 07:43:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoriY2GKvFRCcfgaIBqRWSzxes4v9MgW0pa5pdD8VBYrJV/LXelo05Toknpa6EMmm1t1qDeCxCqPpnmjk+Oquo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC45JxoZOwsB1DLCwLZzqsinQBPm/TiuTHgnA4qYkhbAZjqSpO
	p8UjJIVHSdlepdKURS6WY95nTL3H0fJd6dgHqegfV2BNmippfyXhGUj3LMZ5gvsmHqImZN5TKUI
	dvHhClSJboiAAcbHcfenfjh21nj6Y6p7vhAP9dzA/2g==
X-Received: by 2002:a2e:a583:0:b0:39a:cfe8:dcbd with SMTP id
 38308e7fff4ca-39b1de46111mr10193951fa.30.1782830630565; Tue, 30 Jun 2026
 07:43:50 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 30 Jun 2026 07:43:49 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 30 Jun 2026 07:43:49 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260625-bt_bugfix-v2-10-93396a6f7d5e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625-bt_bugfix-v2-0-93396a6f7d5e@oss.qualcomm.com> <20260625-bt_bugfix-v2-10-93396a6f7d5e@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 07:43:49 -0700
X-Gmail-Original-Message-ID: <CAMRc=MfppsRM3Hgc19Lo802a9q8F3bhtpWEJWYaGx3EhMN=SUw@mail.gmail.com>
X-Gm-Features: AVVi8Cd-5lG2ghbwyHrUALRHfNv8luAp3awpnNvrT8xBYuoVE17qtZWxapNEHoA
Message-ID: <CAMRc=MfppsRM3Hgc19Lo802a9q8F3bhtpWEJWYaGx3EhMN=SUw@mail.gmail.com>
Subject: Re: [PATCH v2 10/12] Bluetooth: hci_event: Log error for HCI reset
 status error in hci_cc_reset()
To: Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Rocky Liao <quic_rjliao@quicinc.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Ben Young Tae Kim <ytkim@qca.qualcomm.com>, Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
	Matthias Kaehlcke <mka@chromium.org>, Tim Jiang <quic_tjiang@quicinc.com>, 
	Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jun 2026 07:19:55 +0200, Zijun Hu <zijun.hu@oss.qualcomm.com> said:
> HCI_Reset is a critical command, but hci_cc_reset() uses bt_dev_dbg()
> to log it, so a non-zero error status response may not be noticed.
>
> Fix by using bt_dev_err() when a status error occurs.
>
> Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
> ---
>  net/bluetooth/hci_event.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index b6d963ce26d0..a90d2c6a6e59 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -269,7 +269,10 @@ static u8 hci_cc_reset(struct hci_dev *hdev, void *data, struct sk_buff *skb)
>  {
>  	struct hci_ev_status *rp = data;
>
> -	bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
> +	if (rp->status)
> +		bt_dev_err(hdev, "HCI reset failed (status 0x%2.2x)", rp->status);
> +	else
> +		bt_dev_dbg(hdev, "HCI reset succeeded");
>
>  	clear_bit(HCI_RESET, &hdev->flags);
>
>
> --
> 2.34.1
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
