Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299A5385514
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Apr 2026 14:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776521207; cv=none; b=RnY0FFebw+oDf7aZnGge/J/yggZm6V07AqdiVZecQzDRpHuTknrfHLNeSXCGUgW4NhKJA0/FjmwmsEF0WuLPRgfAsYVQKVQMZAUNOfkbBfEhuUViHnrJ1ef+FcfP7aKltQXrVox7/gKFz+EtUBMIeCgFQ0726zKOAgpunUynLJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776521207; c=relaxed/simple;
	bh=AiUC+ZIDpGwHLXMrY+x+sqQpEeYBn7lDVlVSM3XLsQQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Coz1L8Bha23Aa3BMEOOw6/61H+8l//xkvYFO95krnvBqpUDYn1La7IL0uarRF0ulTSilVwZGveOSHPop2B95zFi3dayr8Z+9ElHiNj4STF2VLc3KAhBjnJU0ChKtzRiVdNx+rsV96s46YkH/8R1QLvUy7BOe42EmeUizuJtdBIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYlPg16f; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYlPg16f"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so3323175eec.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 18 Apr 2026 07:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776521204; x=1777126004; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AiUC+ZIDpGwHLXMrY+x+sqQpEeYBn7lDVlVSM3XLsQQ=;
        b=IYlPg16fpE5iyMBn78kYdhiM3J8a6pB6JPjWSYn6AfkEf5s2OkIWQsZJVUKpZgkaBu
         j7XI48DUTrlTvphBecuVoDFUzs37jWxLWwkij7IjiwA4TEsD7tx3UrcLC+cb1VsUuTpq
         aTEVeHlJegd39Z7A161mR8QrQS0/QqmaEf8RDBP7qSBBN3GHR4gnkr9+qsaA02jCO2Q0
         PMsXw68l2mE/E7s5bwOO4OjiJGUARoy+eFh7t38nTFto+WutyWdzoVfjz0kapntUZfXI
         yInAsBlCJVj0Ma4LEwOkPl7AFwMg6Sxq5gTmOyvrKvFi9bqdwu7jDw78GsspoV+U/EH+
         bbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776521204; x=1777126004;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AiUC+ZIDpGwHLXMrY+x+sqQpEeYBn7lDVlVSM3XLsQQ=;
        b=SfilO2AFgNYAq9J0pfpf3onu3bCo97c78mtdlksskGMmCPj7Tf8rXWGt3Vi5W8gOqa
         FVnU+YNLsBCOTI32WaC5gIrZbBdBuWXBhlWMwQ+enx+auI1mBcODopllSHDftWkOd9ka
         yEJwtPHcuoDpHrvhAdDfX8kTPjPLz1IdWI6xz2PZC+T7pxbry68+bFfg/dbEJAWFcleO
         c1i1F3noYXbJMBbuHBxZ23eetWrGVJH8SHhYTLwFpRmC7A2TKvmP0EkEOoy7Xppk/UWE
         ZyURHalPLqo1HhCQHTWl6cy1cTzs7TT7qxgmj05SwNTruXSel+JKPygexDNup+glnSi8
         Ei6Q==
X-Gm-Message-State: AOJu0YwBo0Cr6j7D/hx7JYa1vitqBRGuI+WmplBSqZr7FGxl71stlvP0
	lKihxK5+EVHx3+o7/9kd69EYtSAgngdGKtIemCRWBTFxpa85JFtyaCLxBsIkvA==
X-Gm-Gg: AeBDievcJq5OmbXTXdkQFiz5har16mH07ITlOgzxcH8kmWZSvzKdNboNPI5suxPur5P
	3mEeoyds4Nq0Y2pG+elCoZgTOJJAE3F0gobtUD+jyFCKZIX1ipGBhmrWHc1vbba9LEsDYJHGzZe
	DTqhDMzzKU0kY5xY5maR5jNOirvJyqei+zDRtErEWWmlCz5MQ7pgW5vRRGEEZwEF5X37BEurXDg
	FyPZ9zNamdyj1Y2Z1cRuXSqeH6CQBvis1aWK85Y2A5/0sJCC+IQ+CiRleGDrE/6fxydtnipGPhz
	63DiL0jLAn4l4rMXAvpTNssirqnUdZ2t3nafrhYy59YLYzMa31R17DJdRuH6e/LgTNQuCg+m8TE
	j2NuMzHiVrnygY5QpD61f4L9TxIMowvxnLe2Sob9M1YZQmw5XZeiGgih3UmsmfsAwTlbfqZcBar
	MxLi0BKYZ+fSVZMuBSGXHZtFymUBP+XBFC/zGunpt74XtsY3Ndq2SQ
X-Received: by 2002:a05:7300:dc05:b0:2dd:6937:79bc with SMTP id 5a478bee46e88-2e46519e36dmr3805649eec.6.1776521203710;
        Sat, 18 Apr 2026 07:06:43 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.123.128])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ab8b89csm6650913eec.12.2026.04.18.07.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 07:06:43 -0700 (PDT)
Message-ID: <69e38ff3.050a0220.5500e.bc0a@mx.google.com>
Date: Sat, 18 Apr 2026 07:06:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2783499887281075418=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, condorachest@gmail.com
Subject: RE: adapter: add DisableDiscoveryOnConnect option for combo chip coexistence
In-Reply-To: <20260418132740.235614-1-condorachest@gmail.com>
References: <20260418132740.235614-1-condorachest@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2783499887281075418==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: client/mgmt.c:67
error: client/mgmt.c: patch does not apply
error: patch failed: mesh/prov-initiator.c:18
error: mesh/prov-initiator.c: patch does not apply
error: patch failed: src/device.c:72
error: src/device.c: patch does not apply
error: patch failed: src/gatt-database.c:54
error: src/gatt-database.c: patch does not apply
error: patch failed: src/shared/gatt-client.c:25
error: src/shared/gatt-client.c: patch does not apply
error: patch failed: src/shared/gatt-helpers.c:20
error: src/shared/gatt-helpers.c: patch does not apply
error: patch failed: src/shared/ringbuf.c:21
error: src/shared/ringbuf.c: patch does not apply
error: patch failed: src/shared/uhid.c:26
error: src/shared/uhid.c: patch does not apply
error: patch failed: src/shared/vcp.h:23
error: src/shared/vcp.h: patch does not apply
error: patch failed: tools/advtest.c:39
error: tools/advtest.c: patch does not apply
error: patch failed: tools/btgatt-server.c:48
error: tools/btgatt-server.c: patch does not apply
error: patch failed: tools/hcitool.c:34
error: tools/hcitool.c: patch does not apply
error: patch failed: tools/parser/rfcomm.h:33
error: tools/parser/rfcomm.h: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2783499887281075418==--
