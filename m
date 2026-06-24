Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC79C5C613
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jun 2026 05:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782278347; cv=none; b=Dr6MAAa5HEmVJdOQ4uK63MXnIko643zhUvTFov+VQ3NItG0T3KKQgpOl7euWvPfDWsEMWGOuypSoNs+XgNTnbir76gXUb3bFukQgulwp4+tZqQcHB3f6m138pJWv2bNOQLbjnT1jaKNZuWLtVGZTr2SSa8l1XXtQ7nGHaOrew0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782278347; c=relaxed/simple;
	bh=87Tl8ALJ/wMfV0dZ3OAbg5EihyHZgPwas58HNwuDefg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ko5zUFiJICdp3u6RaWPwUl1qAgnYEmMCWUqsAXiZDc2/80qs6w51ZikB5Ng/tjmGoOeQIzJoNrIsin5uk2y9PE2gvp2fWwu3+fEK4/7/HGuf4jTrDpVhxDfs1UhoyB6b7RJLVnSZgbUZIpTswlrijyxTvuWwNROlCDoRAAahRzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ar1ia+SJ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ar1ia+SJ"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8422f395a4aso469939b3a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 22:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1782278345; x=1782883145; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wwH4JKRwdgPVqXhvs8JvCENushgrOY1a28q/t+owUbc=;
        b=Ar1ia+SJOuOROPM9NUVjbiJyCgiC3cqN6T7EwU0pBSeSQLCnjMxbrXgpo3HC32prdM
         Y3OoyLZkEyNlHO/H3FG9g4lLOHJhJPUXPrhLgemuvSK+H0j2LidSpxusIM/JGyWu+5Qh
         +Y4nHq564fsq36L1GhTIZZZrn+kmeYCWHUUhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782278345; x=1782883145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wwH4JKRwdgPVqXhvs8JvCENushgrOY1a28q/t+owUbc=;
        b=ihK2/zdm0KXYM/yh1uVShaf1xKdRB6zbJCUeUjRo+BL4uEO5oWlafhATUyM8FJKPnj
         mBHCD2RRK68Mugmb79/aIRlocqlmrqo5mTKFAhJPFc1DoQYDWMfqyHYTMfPmWPaZ9jwr
         s7YSdCX5z+Pyi6drQwmTwez0r7uE51hXQziFO4648rEBrhbCrt5J9wZiQQIBUb7hL8AE
         25xnwIZLXuG1SuuiaTDFdGIkE5OEllnm99Qemx19W398QRYY5EX5UjrriEUfVWqF68pA
         DaPDq7iahTVOso1sHFEOUNe1C2pOWJ3ZkhEeo4LxPC3JvCnCVcWDlXeKAg++9ub9XXTo
         ymCA==
X-Forwarded-Encrypted: i=1; AFNElJ9SA3njcv2Je0Sq0v0f+5tgf2AFoPXZ8JrBlW9epCg9ekPIR7ipx2AcpDTfsaUmZMNNK5fw3GTtmuWhh2VeFlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YysgE79hiTlpgjtLOcxjB79dg8fFU9C7E/st809fwmKtgLTF9tl
	G74ls1ngg+6XZJpTD8PV4yRInGQWbKzgkznEnxwn6gGsmOuuvwvnmW+QqwrLRoGmrPKjNEH+bi+
	fZst/QA==
X-Gm-Gg: AfdE7cn1ZnMcJxgfXipemdrYTr05JW4atwWJix9DqymhfedRF/KyoaaXLqCq20aMWtH
	u9ADHZMyDn3vKiC5sUNo4XO6bN5naewdVUv/+188txy4mNdhN98Elt15GOgtpRwcr2JJnfG1hp7
	ySaZ7ZnmJLuYYWFwPDukVI5NvZdmKzEOR+J+YWD/nqSQOAK/ou57QLEruCnqAxPQk+LccMfMT3Y
	JzhzdY6eB66n+5/4IPYyPI3/NZs1zsZrhvyNDI/jJSCthdadjj+93aAkZ0Jk7zqIuRZ5IkdfJwV
	zYp/+mTZ/S7FK+c4bPNplca8oS8r7JZJsTfgsNiVIyXXgELTbFCnCs8PBu++ITcou5dJNVZRo1L
	lKuV8fF46t/E2msoumB1e62ntpaDgJvSseT/nAew+Z9vRQZ7g3cvd2LQbjmTWszS2VrhhHjvMy1
	66NKfCta59Bcfx4SnUVDBgnkXH75Xda4Hv9nd5EwHS/kQC11k/zNnN
X-Received: by 2002:a05:6a00:859d:b0:842:dd4:d9e2 with SMTP id d2e1a72fcca58-84591a1946amr5158854b3a.0.1782278345062;
        Tue, 23 Jun 2026 22:19:05 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:1287:5d13:b2d6:c6ab])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a4127bd0sm894643b3a.53.2026.06.23.22.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 22:19:04 -0700 (PDT)
Date: Wed, 24 Jun 2026 14:19:00 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Sean Wang <sean.wang@mediatek.com>
Cc: Tomasz Figa <tfiga@chromium.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v4 0/2] Bluetooth: btmtksdio: teardown fixes
Message-ID: <ajtoXTaBEMSyGADX@google.com>
References: <20260618031338.1011410-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618031338.1011410-1-senozhatsky@chromium.org>

On (26/06/18 12:13), Sergey Senozhatsky wrote:
> This fixes several teardown issues:
> 
>      INFO: task kworker/u17:0:189 blocked for more than 122 seconds.
>      __cancel_work_timer+0x3f4/0x460
>      cancel_work_sync+0x1c/0x2c
>      btmtksdio_flush+0x2c/0x40
>      hci_dev_open_sync+0x10c4/0x2190
>      [..]
> 
> close/flush can deadlock when run concurrently with btmtksdio_txrx_work().
> In addition btmtksdio_txrx_work() re-enables interrupts regardless of
> close/flush being executed on another CPU.
> 
> v3 -> v4:
> - fix commit message linter warnings/errors (tabs, subject line over 80
>   chars).
> 
> Sergey Senozhatsky (2):
>   Bluetooth: btmtksdio: test for BUS IO errors in btmtksdio_txrx_work()
>   Bluetooth: btmtksdio: call cancel_work_sync() out of host lock scope

Do the patches look good enough to pick up?
