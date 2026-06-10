Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CA639479B
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 08:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781081501; cv=none; b=qVjmJOnFA+k7gol1M6y9R2Jm163YifhgHb51c1t4TJZCCoiXTDAtnnAKAlQwSixvNn3BsDUe+yoU67G/lrYLWLt5Km2Dlm1KLpZrTM88uhFM5HtnIlQNmIcvP9BNcSCz0yS8Y42Mo01qWe2AVud01T7heSaMM7/dMgZAVAZF4nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781081501; c=relaxed/simple;
	bh=IY1LKt+8Q8+kPGo1Ko3vVJrVGRpB3s0k4zLsCvAhxVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FwP0+zPEszdNUzl8yttGe/18KIRkMTpylD5qoo26fL01TQiP2Aht+F6tnna8FP5Hz0MUsJCAAFwz7w0ZbOXKgHq0CVepxEa8DmEQ3l5AaRl1EuKCS/b7+bzTbu9nvAdjccKK99lhT9Z2Xg55GZ3FHKJjksaSOWF60bhJiz+QZ6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=R6Jjbaf0; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R6Jjbaf0"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36b9d265355so3976824a91.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 01:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781081499; x=1781686299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YZTUwD5334qhMn45Nv6zFjWXwDHnBznaVHmh9fHzOkw=;
        b=R6Jjbaf0vY+5OW3s5bM/pbNmYWvSEwKqfW6i95X9d7ynzhqzgPnoo2XEOUvdSdIX12
         sjphriV99Kt78yH7VRjIg2+lE0BRthJyrmApA/m/t3o0VVOOT6mJloFWCcM/hXXMRjWC
         skosHBFCaSFOCAuKansBON7j133zfEFtGurh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781081499; x=1781686299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZTUwD5334qhMn45Nv6zFjWXwDHnBznaVHmh9fHzOkw=;
        b=ZTseOoKfxtwzbbl8WUYYFAMVgKHG1AZZjn663PmX5RUXYUkd95zkzdYqFIvTSFXoKR
         94fDfO/3698Gt93mCQmaX6OlxN6/+X84Esm03p3XWakG3z9/tOj3g8I/w/MfutuiBQgh
         DGeaCv0i4YzX1mMltDWKCaOG9J7cxazDjEa4sEN47t0V2dtnKihQoEXX6uOLwtewwGrI
         G9DIW5pAMoqQpECYX1qdxWgNVQN+YMJm7woyh9mmByZlvDTWLMI47BMPIU/rHBOt1aJm
         UIEqbnaR7/cCi3SnKufhMouBTalRm9dM6/TmpQ3b3PkpECvWpF476zdsVyx7xMeeA4dF
         Rq/w==
X-Forwarded-Encrypted: i=1; AFNElJ+SVB89RvN5aapUiF/OiSkFP5plJdTF3DWupLNYGevu8J2PHaNgiGSbPTLbX0MAExwjB4VdFVTvc6UseZVx1e8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX1wJM9nCEgYUYYxdRqzjW3moNsq21ZVG3pqIrNhl9cUr68UEt
	y4+Js7N1QcN1Shl2vkyWHZ+aqpAOjEtAkqSdfXUAy6daLYIzWEujdV2h+US7/tEGAg==
X-Gm-Gg: Acq92OFmYsOnN1Dz/uosXSZW6hTGy6gthQedw18DfE2atd5wn8/BslnDxvLnTirLs55
	izfMHWAOzffav839UJjrb1zunpi9sO+xWh4KoMWD2EksZmaiN3jxi4rfEWtW9d6MvLEMncDmZz5
	ZryN2ifuCQ21mid25+/LMrmHw8RdiAAnk4Q1+vWu1LnE96LndVSJPKSbxFAhQvWgVS8Jaj+xBml
	gT6NaGT9+3ZDd7QgeyJLrd8QZzxI/PieafMORc7B+A3hsXyN8jEOB/q+HfbYiG2zh89jApHCt9W
	QNcuIrIOZNs3bYESWdVckAdC/Hqf2OEBQATUhtpVyk29JpmPaIePQpSoa+D3xP1XP9VoYO1Z48j
	mirRZSF80xizW9aM/WD0+sZ097hFIKs3rPR2vyvQLW3bAO6pxWn7h2+a1ez3wr/B/IeepuqTjCQ
	t+DkhvA7z1MaMHpe4xWZm9zkU1/GHawBRfYnLiRIjDmYYjLibrIpmUl/MKOVxu2PXKaPFTrwIw7
	w==
X-Received: by 2002:a17:90b:390e:b0:368:a297:bd3d with SMTP id 98e67ed59e1d1-370ee82f93cmr24837129a91.3.1781081499588;
        Wed, 10 Jun 2026 01:51:39 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:8717:e062:7cab:4cbf])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f70a285a1sm21900817a91.9.2026.06.10.01.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:51:39 -0700 (PDT)
Date: Wed, 10 Jun 2026 17:51:35 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Mark-yw Chen <mark-yw.chen@mediatek.com>
Cc: Sean Wang <sean.wang@mediatek.com>, Tomasz Figa <tfiga@chromium.org>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, stable@vger.kernel.org, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] Bluetooth: btmtksdio: fix infinite loop in
 btmtksdio_txrx_work()
Message-ID: <aiklN2uHqmJNemws@google.com>
References: <20260609121329.1262170-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609121329.1262170-1-senozhatsky@chromium.org>

On (26/06/09 21:10), Sergey Senozhatsky wrote:
> Every once in a while we see a hung btmtksdio_flush() task:
> 
>  INFO: task kworker/u17:0:189 blocked for more than 122 seconds.
>  __cancel_work_timer+0x3f4/0x460
>  cancel_work_sync+0x1c/0x2c
>  btmtksdio_flush+0x2c/0x40
>  hci_dev_open_sync+0x10c4/0x2190
>  [..]
> 
> It all boils down to incorrect time_is_before_jiffies() usage in
> btmtksdio_txrx_work().  The btmtksdio_txrx_work() loop is expected
> to be terminated if running for longer than 5*HZ.  However the
> timeout check is twisted:  time_is_before_jiffies(old_jiffies + 5*HZ)
> evaluates to true when old_jiffies + 5*HZ is in the past i.e. when a
> timeout has occurred.  Using OR with time_is_before_jiffies(txrx_timeout)
> means that:
> - before the 5-second timeout: the condition is `int_status || false`,
>   so it loops as long as there are pending interrupts.
> - after the 5-second timeout: the condition becomes `int_status || true`,
>   which is always true.
> 
> When the loop becomes infinite btmtksdio_txrx_work() loop never
> terminates and never releases the SDIO host.
> 
> Fix loop termination condition to actually enforce a 5*HZ timeout.

Please hold off this patch, this change alone might not be enough.
Let us look closer into it, we'll come back you.
