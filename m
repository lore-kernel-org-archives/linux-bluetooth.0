Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BE439FFC
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jan 2024 16:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d98OVYiv"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3608cfa5ce6so12158805ab.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jan 2024 08:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704819060; x=1705423860; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uV5MEnsTPvblCSpnlyxwVtt9fk763n7/MDrWTIfZnok=;
        b=d98OVYivllbnDuKnYQ2IRawOBiPUDUUCI8BkXAlC0/zoODQ46L+sHVPO4eUZo4wpAK
         HRuKsEvnSPerUfpNfnToo47LtHj9b2Ad6KtimED8MdzJ49eYnvl6rTNR2vyOARaKf9D9
         6vp+kWqvUUj3PiFJ7/SMYPKrqVVE/a6KuVkAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704819060; x=1705423860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uV5MEnsTPvblCSpnlyxwVtt9fk763n7/MDrWTIfZnok=;
        b=j97KOHsO1vjJHoO/ESsaVA3HkmqqZEKxC0avx0lp/bewKzpuRgUC8u37Wzk8iGAthH
         rOSVx2djwTfdCIV/ItN4l8PAsKbHYsQDdtue6kPwHpG5MLpZUYqlhemRreTB+UAKzSky
         LhUlikOnQZAL6utbC3obphnk9iFVvp2qExKdPMw+b6bVzKpUIC2ogFB7PnEYWeUPhEuo
         RbezR66J/Dzoonmo6Lz0MDBysNfiA4i1E7dkKj6cgzXltoJIxW4x3bkL1oSYMlFfOISA
         9x0lc13e1P+T8TfJK5oiM4Km1yV+wOj01aLl1D1xGb1FmXPL4fSrFw3JQjJHoO3Kc6T0
         yeaQ==
X-Gm-Message-State: AOJu0Yxn/5nAxvHS08l1EPcPjf3OSJ4Q+K59uJ8p5oUmNNBpKsOkb3B9
	gF3DJpl6oNakLvMQDEVWqlS7OuaSKcWz
X-Google-Smtp-Source: AGHT+IHlU8waFtg4YB7aQ65CXpn+4z/PCbvQeBpftavO899tUFqMDX2wxm5vCuDdVh2D10JRxrXaZA==
X-Received: by 2002:a92:ca09:0:b0:360:7c05:e479 with SMTP id j9-20020a92ca09000000b003607c05e479mr9251232ils.47.1704819059849;
        Tue, 09 Jan 2024 08:50:59 -0800 (PST)
Received: from localhost (110.41.72.34.bc.googleusercontent.com. [34.72.41.110])
        by smtp.gmail.com with UTF8SMTPSA id t12-20020a92c90c000000b003607ff64574sm689592ilp.64.2024.01.09.08.50.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 08:50:59 -0800 (PST)
Date: Tue, 9 Jan 2024 16:50:59 +0000
From: Matthias Kaehlcke <mka@chromium.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
	Doug Anderson <dianders@google.com>,
	Stephen Boyd <swboyd@google.com>
Subject: Re: [PATCH] Bluetooth: qca: fix device-address endianness
Message-ID: <ZZ15c1HUQIH2cY5o@google.com>
References: <20231227180306.6319-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231227180306.6319-1-johan+linaro@kernel.org>

Hi Johan,

On Wed, Dec 27, 2023 at 07:03:06PM +0100, Johan Hovold wrote:
> The WCN6855 firmware on the Lenovo ThinkPad X13s expects the Bluetooth
> device address in MSB order when setting it using the
> EDL_WRITE_BD_ADDR_OPCODE command.
> 
> Presumably, this is the case for all non-ROME devices which all use the
> EDL_WRITE_BD_ADDR_OPCODE command for this (unlike the ROME devices which
> use a different command and expect the address in LSB order).
> 
> Reverse the little-endian address before setting it to make sure that
> the address can be configured using tools like btmgmt or using the
> 'local-bd-address' devicetree property.
> 
> Note that this can potentially break systems with boot firmware which
> has started relying on the broken behaviour and is incorrectly passing
> the address via devicetree in MSB order.

We should not break existing devices. Their byte order for
'local-bd-address' may not adhere to the 'spec', however in practice
it is the correct format for existing kernels.

I suggest adding a quirk like 'local-bd-address-msb-quirk' or
'qcom,local-bd-address-msb-quirk' to make sure existing devices keep
working properly.

Thanks

Matthias

> 
> Fixes: 5c0a1001c8be ("Bluetooth: hci_qca: Add helper to set device address")
> Cc: stable@vger.kernel.org      # 5.1
> Cc: Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
> 
> Hi Qualcomm people,
> 
> Could you please verify with your documentation that all non-ROME
> devices expect the address provided in the EDL_WRITE_BD_ADDR_OPCODE
> command in MSB order?
> 
> I assume this is not something that anyone would change between firmware
> revisions, but if that turns out to be the case, we'd need to reverse
> the address based on firmware revision or similar.
> 
> Johan
> 
> 
>  drivers/bluetooth/btqca.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index fdb0fae88d1c..29035daf21bc 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -826,11 +826,15 @@ EXPORT_SYMBOL_GPL(qca_uart_setup);
>  
>  int qca_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
>  {
> +	bdaddr_t bdaddr_swapped;
>  	struct sk_buff *skb;
>  	int err;
>  
> -	skb = __hci_cmd_sync_ev(hdev, EDL_WRITE_BD_ADDR_OPCODE, 6, bdaddr,
> -				HCI_EV_VENDOR, HCI_INIT_TIMEOUT);
> +	baswap(&bdaddr_swapped, bdaddr);
> +
> +	skb = __hci_cmd_sync_ev(hdev, EDL_WRITE_BD_ADDR_OPCODE, 6,
> +				&bdaddr_swapped, HCI_EV_VENDOR,
> +				HCI_INIT_TIMEOUT);
>  	if (IS_ERR(skb)) {
>  		err = PTR_ERR(skb);
>  		bt_dev_err(hdev, "QCA Change address cmd failed (%d)", err);
> -- 
> 2.41.0
> 
