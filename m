Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583ED3DD84F
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jul 2026 09:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330748; cv=none; b=c5OAXF2yHZfXVy2FlXWjFGXz/l1zNpBJaq8c0iu1QSMofXYNd8QurD8pPYXclwkUUkTvKLfXGjbdG/Xy8tikTOn/vKZoj0Q73iH1RpsLMZFighZZ/iNAZsx4jVU7Q/kNZil1/BTCM6K5eCvK6rkv3Coh/0UOgJ+XeYJeznNCIBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330748; c=relaxed/simple;
	bh=tjj25RgufxU6KuRTIAIM9BgP09oA+m3tNlw5wNNhm1c=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GGi3ra4x2MBn7xZ98jbG1zFxoxYl1Jv5z7Ealq6d1fpV7EPu6beLDsT8aZ5jjHVx0ZhanBXR80FxlJ6+SZYCW2zgEuN30+Dca19RbG9j15XlhWj+tOel+HxLH0QgodEnUKy9qHdycQ8QIJBDl7RwN23QG6M761+XLzzoPOSVXRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apwg96QN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apwg96QN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4C61F00A3F
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jul 2026 09:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783330745;
	bh=t3smXmz+g9S5s6nOL9A5gRdNdNFQhP/2jlNjf7pu7kw=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=apwg96QN9jNLCHlyFry/4jBTOIUmRoSHd2YTz9vIomoOv3DOfYKOTrlRLxZr38Ihd
	 mL2pGpIcPLBGLvNphTGuHJUnILgWfahma/QTlfo/aXAWqeFO7r8hgdNOHx/dT9+wgJ
	 lJzn/a2cSpgXjUoc6CS1nHDPzOaVwmZmPSfPO5syJgEOswMYWaTQbfq/JAoEFK6Knc
	 coWD+B8lYUILTUWDplJORFpnpCsDNUc47TThgR4zWKB4Yc24G75164mxR8SG3QTpeD
	 kLIf+sfqsicw12ZDux9ToddSM0azqxRMhUp85y938tWK/zzT/iOS4vPM5tExoQyX7k
	 kLJUv2LYbLePA==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39b2be45e8cso22120351fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jul 2026 02:39:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ro+iXxjYEDEMPL483vRYVvtTzIHGrycJwyQcSF3iJ5QZqo4Pl4kKBtrXuE9kaAfEWw4qSeB5jduGBCOKsCiIDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YymU7ai/iCvorLpJiWfS4rGFNNUMTmkAsY6YY+lHG/rWJP0MUxM
	BJUWz0qB1nMBrW5cbDTRvLtt8CurXmZICP1fLffSJ32FvXyZqhUmI+tM8XmmJzyX+6cjjvRsHsU
	Lh1kMtbPMrY7TC/AUkSrZspw5hm/ycg0ddFmBlxkmFg==
X-Received: by 2002:a2e:bc88:0:b0:39b:53f:bf64 with SMTP id
 38308e7fff4ca-39b53b5a713mr20977171fa.2.1783330743858; Mon, 06 Jul 2026
 02:39:03 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Jul 2026 02:39:01 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Jul 2026 02:39:01 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260704231030.996390-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260704231030.996390-1-xmei5@asu.edu>
Date: Mon, 6 Jul 2026 02:39:01 -0700
X-Gmail-Original-Message-ID: <CAMRc=MdLTt2ibx0dW775_uF0NLxipa+txg2F0AWWZ8Nxbwc+Jg@mail.gmail.com>
X-Gm-Features: AVVi8CcBZjQu7TeoKCfemShsS5r9fiC1gScOu9zl_mhYxvWrfqmRozJfrn2E1eI
Message-ID: <CAMRc=MdLTt2ibx0dW775_uF0NLxipa+txg2F0AWWZ8Nxbwc+Jg@mail.gmail.com>
Subject: Re: [PATCH bluetooth] Bluetooth: qca: fix NVM tag length underflow in
 TLV parser
To: Xiang Mei <xmei5@asu.edu>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Johan Hovold <johan+linaro@kernel.org>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 5 Jul 2026 01:10:30 +0200, Xiang Mei <xmei5@asu.edu> said:
> In the TLV_TYPE_NVM branch of qca_tlv_check_data() the tag loop bound is
> "while (idx < length - sizeof(struct tlv_type_nvm))". "length" is a signed
> int from the firmware TLV header and sizeof(struct tlv_type_nvm) is a
> size_t (12), so "length" is converted to size_t and any firmware-supplied
> "length" < 12 makes the subtraction wrap to a huge value. The loop body
> then reads a 12-byte struct tlv_type_nvm past the end of the short
> vmalloc'd firmware buffer (and the EDL_TAG_ID_* handlers can write past it).
>
> Rewrite the bound as "idx + sizeof(struct tlv_type_nvm) <= length"; both
> operands are non-negative, so it no longer underflows and a "length" too
> small for one record correctly skips the loop.
>
>   BUG: KASAN: vmalloc-out-of-bounds in qca_download_firmware.isra.0 (drivers/bluetooth/btqca.c:421)
>   Read of size 2 at addr ffffc900000e5004 by task kworker/u9:0/52
>   Workqueue: hci0 hci_power_on
>   Call Trace:
>    ...
>    kasan_report (mm/kasan/report.c:595)
>    qca_download_firmware.isra.0 (drivers/bluetooth/btqca.c:421 drivers/bluetooth/btqca.c:617)
>    qca_uart_setup (drivers/bluetooth/btqca.c:948)
>    qca_setup (drivers/bluetooth/hci_qca.c:2029)
>    hci_uart_setup (drivers/bluetooth/hci_ldisc.c:438)
>    hci_dev_open_sync (net/bluetooth/hci_sync.c:5227)
>    hci_power_on (net/bluetooth/hci_core.c:920)
>    process_one_work (kernel/workqueue.c:3322)
>    worker_thread (kernel/workqueue.c:3486)
>    kthread (kernel/kthread.c:436)
>    ret_from_fork (arch/x86/kernel/process.c:158)
>    ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
>
> Fixes: 2e4edfa1e2bd ("Bluetooth: qca: add missing firmware sanity checks")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>  drivers/bluetooth/btqca.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index 04ebe290bc78..10c496eaea2c 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -415,7 +415,7 @@ static int qca_tlv_check_data(struct hci_dev *hdev,
>
>  		idx = 0;
>  		data = tlv->data;
> -		while (idx < length - sizeof(struct tlv_type_nvm)) {
> +		while (idx + sizeof(struct tlv_type_nvm) <= length) {
>  			tlv_nvm = (struct tlv_type_nvm *)(data + idx);
>
>  			tag_id = le16_to_cpu(tlv_nvm->tag_id);
> --
> 2.43.0
>
>

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
