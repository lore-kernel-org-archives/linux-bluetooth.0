Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFC1134CF
	for <linux-bluetooth@vger.kernel.org>; Sat, 17 Oct 2026 21:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792272511; cv=none; b=krrMTVE8vfjTK/GZuIXN02tdelcGO3CDa2t73d8qDDJ0hRlBHr5PO6neCnpa9YppbkavkdbqAHkXx8MdjDUw69nOqdQ/0J4Cec55XdaKsJLSSMZ0ftrwe6wXuxKtMisilY4hrHN6HL4yVkbrKvgaPwUxz55/HXNPRWq69QowEqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792272511; c=relaxed/simple;
	bh=1owAe32p+zC/2I97cPUmihpoJx3GbYUcUu5zXCgVwck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pUBITvXY/vTSk6NsbpQ5DH2kcj0CPvWZbs5IMjFRY5j1rRfni0FEy+wKvNe8YuhcZqRz4X8vsdy9S7XzpldKaiNZFcaa46jj9MfxBovI79beIVBFaxgJA61aAR/6CYrkrgA6Fm9v1wjY3RBfrRrh1kv0hB9S4sEmhpxYBHtP/WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org; spf=pass smtp.mailfrom=californiaopensource.com; dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b=qL2Niw5Q; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b="qL2Niw5Q"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so2012221eec.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 17 Oct 2026 14:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1792272509; x=1792877309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1owAe32p+zC/2I97cPUmihpoJx3GbYUcUu5zXCgVwck=;
        b=qL2Niw5QGkcIV4GiYccEObScF1ZaCpnKk+pSNwc99aVPglt1ZWm6W2Zb/fhR/6XWSE
         aKgdgU4iBx4fTU5Qpafj4zb/HL4XF6Iuc8mDtC45eFFZ1aMjLfnetW1U6qplnHj6jhh4
         lSvKT4c0KzJbNodfs8ZfJcmqpNKGA31yypF/TvWAHMY9FFffpBru8SFtW8F1T+3l3eDC
         /fYPO7qkOMSXp3yzWltFB1k/kG527CeJpWrNxs8vEhG+y02KwF2MBYrni02ZevMgLleU
         E31OJvAoRI3SHj/9J4jl5yU2XM1aq27hMj38pMiE6zvC/VBCAwimSFGwCmOGRkUYRs7b
         regA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792272509; x=1792877309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1owAe32p+zC/2I97cPUmihpoJx3GbYUcUu5zXCgVwck=;
        b=dtoHO0RT9MkSdrcBgo8b5dob3kTiPbt3/fXRIaeiJ82140htrvsmyjWnYRTAbJzYLO
         XjvROfyppKAwKT3Ar7EQb4aezLc7VgS3GGVCENuPWS2UT2Ua/jyum7nYMJWe/cIdl5di
         Y5z9PAi2HDbnQPMfggsqkkVpx9Z0f+MF8eWwNmozC7YmvWwpMEu8bxGaZJjMveGyyS+I
         1aEgd+87N55TmokU6LFslpBDEb4JF3rnxgI+p9d2yzxiksm9LHpgjq1rGumLkY71m6h8
         RvuEiOoRdx3BGc2Dy7SQQsxpVTEqldWcP2ffv8ozscjPuyZNdQOJ2sKJzxfBXIEgmgK9
         Y4HA==
X-Gm-Message-State: AFq9FYJ6Y3rYoGZZXlkWgaBI46s4pLeILQ6nkQ/o8Ig2rHqG2YnFT52l
	Bkpk/YT6OkcocqBlF9VXMZQZBlcNCsL9kl3/5+D1P85+7NTeZSyr85PPCS6c6Zu7sgnLULHhid8
	hSojk+W0=
X-Gm-Gg: AYBFou0MiJjEmduRSRGiaZ+G/iyM+FwtfOvdTsLEGqwv2PpgdifUgmzWH2u6KAyM9Ek
	QLNjtQx1Ve+2+9ubyxhKBordXlX0hidTlZ0RLnOHFt4O2R3RqtKtSat46Xnk6cjLzcsttEDiiWv
	Xqkwb71A/FBIiSyAQfAseYryaULKpv4u9ps+t7pUzLgk5MKrnrEBx0w6R5pExIBtFQSy15xdP59
	Q4XCyCnfgdKXGC0o4e2Bn2Dy05119k62roPAru8AK7F2DYWCk9fjayMGfQlJ5o24gJSz6IVaQhZ
	SuawWDf5oxT9n5YyMvucPpvvzn0i4uqkmQm/KHziZ46AscFXxKfNS2b3rjK9G3C9R+qForY1WXh
	G5TIlmeoA2AOwsmdDatwEX+I1A4n2cCsP7yEnHYFZw9B14L5Y0Oq3z6ySBf4y2NSoCaOQ9j5CG4
	NAYYrsF8NLjG1O7FCR5I3XORamXZBLnxmgWcMmnkLeFq5aqXF7X4Uy6ksXkWpsBYjLEIQP29v9m
	YWhsoCBl/KiDC3Ft+46jvoBmiafHulczmfjipf1CB9yfkZfK34gceT+2dE0b849dyFTpEcVRkhO
	Z5EAnnlP7LR9AHLbHAzXLS5alt9yX1X90FCcjAJJW/5lX4tzFIw=
X-Received: by 2002:a05:693c:808c:b0:353:7e28:9c58 with SMTP id 5a478bee46e88-361a3323b50mr5748953eec.41.1792272509333;
        Sat, 17 Oct 2026 14:28:29 -0700 (PDT)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3608308a87csm31667403eec.28.2026.10.17.14.28.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 17 Oct 2026 14:28:28 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: Re: [PATCH BlueZ] monitor: Fix legacy SCAN_RSP PDU type names
Date: Sat, 17 Oct 2026 14:28:25 -0700
Message-ID: <20261017212825.9690-1-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261002200025.4418-1-kevin@simpleble.org>
References: <20261002200025.4418-1-kevin@simpleble.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Luiz,

Gentle ping on this one. It swaps the two SCAN_RSP labels btmon prints
for legacy advertising reports, so they match Table 7.1 of the Core
specification, and it still applies cleanly to master.

Kevin
