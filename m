Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2932286A1
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Feb 2025 00:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739752858; cv=none; b=oi3eGISSO2zgvQjfLqgJBKtjK0a6E8U4J3MdlP1WRGoXPLovb7MURNFPw179BhdDjKajLaUldWZaLOj0jCc77p0qu12C1AwCuz8NFPek7/dzqDLFIORiJUMXDpjXZuFLBTJSyKScRANMoCqFf28eQ42RX6Ttdy+xgyQp9fAl50U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739752858; c=relaxed/simple;
	bh=VP88tVjGFUz2xXhw248F15t6bV2Dtb3FpAxcTyu+dpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XU/xXy/1ChnVfR1elWr/yQMw1k0ibA+H06AfR5sxIRuT+BZU7inlGl9HmbRsM0uQ3CUGx/P//75wn1kwCPO3z6qLaBV9CofFm7QUDW/BEHb5cxOZ69xzo8wcjRWxngvSbxefo1yH0/OXlXdpdrlK7hGAHVF1XOM+QbUflTalBto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=eGFM9ojn; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="eGFM9ojn"
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A03313F2BC
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Feb 2025 00:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1739752854;
	bh=47VWApMddME6n7729BSWTK2/mvuv99AvhCZBYLgXjOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=eGFM9ojnVtI2yJ9EjKKH34ss2KS2HOdM0QWZ27g6E1Hvce3I/BWaj+MqNHbzICvVU
	 j/oaB+ogpd+LjthaUNZhjydk7AEeXeTlDsk9JscX+4kYv7sW5iCkGedHEGxe4HnmjF
	 QdIKLjbju9v17P/5gKqRMWDtv4h/60GIETp+x+ZiiY8srDtqmNiHGXFF3X+cNCYWWt
	 U99zNZcpfhoyf7DTuzhoOYMo5/JxFmInilTaLyGG6eCOgKDfj0EksvNABM2pMoTsaB
	 AhW18XFBAaF8gtxXOc6vbIOOpR+G48sECtQcajVwZPMjrAxM0a0DbHSxVw11tPr8DH
	 L1+fUM1NiiZtw==
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-22112e86501so19081205ad.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 16 Feb 2025 16:40:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739752853; x=1740357653;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47VWApMddME6n7729BSWTK2/mvuv99AvhCZBYLgXjOo=;
        b=D11xE8LECSPFTBRbRuglh+2So+bvB/7MwuY17OnqyuZsvP1DhSG/inbjgxLol6P454
         C1fqGzWjf980vLh/gsOFjZpNsxKq75nvUwQ89YT/++iXU1U/kfkkvbe6O1jC2macteMZ
         ju7cSTgPP9ICyIWkFHSbKLT/SlWEseskXA2epibWik6OXfjYy37vTyWIJCzuhxoIjXkB
         huzgVaRKaSwRKu8CS/ReQapqGkVTK161QEButPK/HUYUD2pThBLDz5rsrfvyENXg+qPJ
         vkb5SSKSn12YCQBZSH9t/y7s4Rv8d6VXEnsTF3VQgdcbcUaQVM7fqyPqlaSsIBjJLIci
         x6RQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7ZBe2SlZHO+XbMsyQK0xdofImacUPo+a3WpExjX7sts6OKFd2MTkm7xYZg7r9KTy7PQQREXelf/hcQxUaHOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvMIpKlfLZQd++Std3p8sxmy1ghTPSQUHFTxPIW9LvF0kpKMWC
	mAUfd/uiUvCDJEbHZ8c0fo7Ew34mDFAEtCseh2aGFiDz3lPjWP7vv1H96rJdgTOxXZbeeFg6bmG
	XiMWQvQi5PkjIkxtd1FVGXD3ThbQlZwayusFlebBseP3XN3LSzz3tS9tQUdXqZVqX5lqd+Ctp8F
	no5StIPQ==
X-Gm-Gg: ASbGncvnKwGs2N+BXEmqZpKpPVSauUy1aIcTqFEFwvUGdy0EQr2jMJMnFTVNMQYMzeO
	6Y2oP82sE4sJrJy2uOHWz3qAXZM8enIYKuzfLcfQHDlo4BKyMUyr+4sJMeG0Lrl2Eu5YeA3hDOX
	QZLtM+Ose/ScDMdmNe5/XGQdG1TIrm3T+R47BDTTmQ3aNFrg4MO20Fq9oiCUAKEadqAd5eNRXrX
	7YpLXUm9DghybEl8RDIsbYRcgKcfKt4C/3Iq8QZrmfjrC6xcU6738dMhmtyMRZAPgt4OzGaOfjd
	EmwIayp/CuvVVC51/lt6HFjeFBYWgb/tRDyl5Wc7IKX+S5+vH6dYolDEC8A=
X-Received: by 2002:a05:6a21:e8d:b0:1e6:509c:1664 with SMTP id adf61e73a8af0-1ee8cc25d50mr13918089637.39.1739752853198;
        Sun, 16 Feb 2025 16:40:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFScrHC6XdIdbfDrLHwEns3mPcJitW3jb1ZLyXBDYDk0pzUh81zMMmvwYvMQtgSGxYT03IcPQ==
X-Received: by 2002:a05:6a21:e8d:b0:1e6:509c:1664 with SMTP id adf61e73a8af0-1ee8cc25d50mr13918059637.39.1739752852886;
        Sun, 16 Feb 2025 16:40:52 -0800 (PST)
Received: from acelan-precision5470 (118-163-61-247.hinet-ip.hinet.net. [118.163.61.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-732621c4762sm3593444b3a.172.2025.02.16.16.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 16:40:50 -0800 (PST)
Date: Mon, 17 Feb 2025 08:40:45 +0800
From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
To: En-Wei Wu <en-wei.wu@canonical.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, pmenzel@molgen.mpg.de, 
	quic_tjiang@quicinc.com, kuan-ying.lee@canonical.com, anthony.wong@canonical.com
Subject: Re: [PATCH v3 0/2] Bluetooth: btusb: Fix QCA dump packet handling
 and improve SKB safety
Message-ID: <jyxfdjkcwsu6sqmqfuyelhlwsr4dbzxirfloalvklppvu6qmss@tdhoypgttcdc>
Mail-Followup-To: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>, 
	En-Wei Wu <en-wei.wu@canonical.com>, marcel@holtmann.org, luiz.dentz@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, pmenzel@molgen.mpg.de, 
	quic_tjiang@quicinc.com, kuan-ying.lee@canonical.com, anthony.wong@canonical.com
References: <20241205071727.36710-1-en-wei.wu@canonical.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205071727.36710-1-en-wei.wu@canonical.com>

On Thu, Dec 05, 2024 at 03:17:25PM +0800, En-Wei Wu wrote:
> This patch series fixes a NULL pointer dereference in the QCA firmware dump
> handling and improves the safety of SKB buffer handling. The problem occurs
> when processing firmware crash dumps from WCN7851/WCN6855 Bluetooth
> controllers, where incorrect return value handling leads to premature SKB
> freeing and subsequent NULL pointer dereference.
A gentle ping.
Please help to review this patch series.
Thanks.

> 
> The series is split into two parts:
> - Patch 1 fixes the NULL pointer dereference by correcting return value
>   handling and splits dump packet detection into separate ACL and event
>   functions
> - Patch 2 improves SKB safety by using proper buffer access methods and
>   adding state restoration on error paths
> 
> Changes in v3:
> - Use skb_pull_data() for safe packet header access
> - Split dump packet detection into separate ACL and event helpers
> 
> Changes in v2:
> - Fixed typo in the title
> - Re-flowed commit message line to fit 72 characters
> - Added blank line before btusb_recv_acl_qca()
> 
> En-Wei Wu (2):
>   Bluetooth: btusb: avoid NULL pointer dereference in skb_dequeue()
>   Bluetooth: btusb: Improve SKB safety in QCA dump packet handling
> 
>  drivers/bluetooth/btusb.c | 120 +++++++++++++++++++++++---------------
>  1 file changed, 74 insertions(+), 46 deletions(-)
> 
> -- 
> 2.43.0
> 
