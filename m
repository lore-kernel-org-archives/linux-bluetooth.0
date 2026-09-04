Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B494F30D5
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 17:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788541656; cv=none; b=LpE8JlrFOp2xUcK1x75icADOGDb3RXGjqUxEXivaLT3UaiAbCj+Z2pIxgFfRbrf6fj5u2ABZCu7APIim9MFMn8LpEQU7KNm2L14ad+Ear7kdFBDgWa/A6t5lrVYBvbPUt6GZoE0r52ioYeHzSgxVrF6dZPoqBu4azgOXLIjAYdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788541656; c=relaxed/simple;
	bh=OU6zLT6cAdAtkjGovN0fzEAiTpDLLTdbu0rAoHoUBbc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WZ0uPF4CylXTwHQHmIe006UA4xAzhrMAeQB3Bnb0vQLe85GkCYCsEhCluTC56F3RDUGXMZvCOvCBKomlrKo1BqkWeEVXi9B0y+vQ6iMcBdWQVX3TSRLeg/pjX5fkMf+nCeOk6xx091vJ3pbzihTLnsddq39AcFfPO+3YDHkeEEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZ0rs4kY; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZ0rs4kY"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-939094306b0so102319485a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Sep 2026 10:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788541653; x=1789146453; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OU6zLT6cAdAtkjGovN0fzEAiTpDLLTdbu0rAoHoUBbc=;
        b=LZ0rs4kYRKfkC6bN5x5219++kcr+iMg7hlQCBZ8kY3BnvImBaFTQSJ3Tdm7Wc71Qun
         9aT+NzqQKtSiGir55K28ZcLNJoMrOAn+SkkP+bZQdxjlHpsQCfReKDHIXBvIYi2Z7WOj
         fDmzxmj7lqpTxSnJJjV5XMFmTLsh3DSjGktaXJbK8lFCD5kIetUvKG5IAXVbYLkcJJLg
         KMrNfkFikRQew1uCoAF4R+luT0CwkIHXTOb8P04nlyndWiz2x3ZvQ6y2bih+HQ0aVSa2
         rcRzpIGFjFJor+jtmmHecFP3xol+69aLkwjAreEHq1uTxER+rX/Vd0az70PC9dVnum17
         gqpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788541653; x=1789146453;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OU6zLT6cAdAtkjGovN0fzEAiTpDLLTdbu0rAoHoUBbc=;
        b=ny4/mXyVBXG+SzaVrVWC4PucrCuc68Z5YVTyKp8YmdTvkDASEa5fGiHl6hqe4VhIIH
         vbjMMLVoEIzfP8lxlIg4z9sfAMCrUIFyZlnYG1iRPA7MsDoA+W0/MgHNQ2JerzVgHFMh
         Uv8hVqQEK2Rz6LOaGU7VvCyV+j3s+Y/SWFARReJdb0/5LWWcWDescGY1jGT2Dzz4mOz5
         SYA6va0wh6Hp13K7yKeYgXilcGsJtrWbDCqSzROraESHzVS7AQpxRMiX0gmNiKtqgml6
         7G3KPJpRSx59JDn31G7COtq+6SAGKvxnlm6TAhf0q582mn9PEpXFWQibsvWCiptrP82c
         nBpA==
X-Gm-Message-State: AFuF++kApdvrYpDdTSx6bfCnMIIxEHam4L5waQiEQlb0/SRycS18F+/l
	TpUDCgeu3HAIkk1sMeV2C4xq73Xxliw1vuDeSMqq+CTWGsNtjerTaIzuP3Fxmw==
X-Gm-Gg: AYBFou3sBV9E004Il5OdnIk9QJFUrIztUnE/TdDlinjXBQFm8wbT1x8ha6HmP4V4UTv
	pABuHDOW5pG+c44s+7TzcUXNQqLFLvonlALQw/+G7PVI+In3Zurzfpamt7b02oId/CwxkPK0X3J
	zxns9abqsiXWtQIDX9ae5eXmbDuMGmYoONr5U+KnMsDQEOMwQE85iTRmKWz0S4YlFstzHCtp9VV
	FsOAjKBWOiK/Y2AV6WQK737GOMs4CsAGOxD2Q3vr37QtVnHDw5v1c+gLDGEai09aa7UJWF1JhUY
	fAHq24Yxa0tfm+dY5YvL/crXIvZBGIgPv/Obu2mY3zTa5bAuaZfu72kTXDROre4eiwCZGKXfi1P
	VC1rNI9hcZtubLVl6/h0ePt8nAQh7H49P335BlOTp29Oml58kDyOVrYyIE9LJRbteiiEC+EizYT
	GKspgbBytQtLJSX+A7VOsj/HONvbY6t7LJICutYprFEPknuJM5seN+aT4qql1HKeDeY9+B
X-Received: by 2002:a05:620a:4708:b0:939:6cd7:9706 with SMTP id af79cd13be357-9398037c2a0mr644954385a.21.1788541653398;
        Fri, 04 Sep 2026 10:07:33 -0700 (PDT)
Received: from [172.17.0.2] ([74.235.134.161])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397f9ee9fbsm260595985a.1.2026.09.04.10.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 10:07:32 -0700 (PDT)
Message-ID: <6a9afad4.27211789.12030e.c029@mx.google.com>
Date: Fri, 04 Sep 2026 10:07:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9079685338262713504=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, proxy-alt@proxy-alt.dev
Subject: RE: [BlueZ,v2] shared/gatt-client: confirm a synthesized CCC handle before writing to it
In-Reply-To: <20260904162108.56154-1-proxy-alt@proxy-alt.dev>
References: <20260904162108.56154-1-proxy-alt@proxy-alt.dev>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9079685338262713504==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: src/shared/gatt-client.c:116
error: src/shared/gatt-client.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============9079685338262713504==--
