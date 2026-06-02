Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97E12765DF
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 21:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780436363; cv=none; b=jaOS2znFUnLZjS3rGlwGAZe5F8Z9HH4xEwHoqstAal6w5wnG/uWDdgX1C2TWS/F7FsSdAFdgAvbQmjKvqaFgpO2zg2qOBySJriD0ZrCVUre/kBWKkT8bDz2Sm+GHRrhmIlAjW4jzOh+ZEHX2bPdwkXGmfsz+M5vhm401jNCwIIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780436363; c=relaxed/simple;
	bh=T0YNkx2SkmoVqkFkvNnml9yIGuSCCQWoNXXwQO7xJnM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NqTYIkMwiIiT6EG6ix0XLZzMBOFx9mW7weQKcriaFnruDHFh3Lb4dKX1AJf1W1KLSH8WpuBhMLdaJOvn5GDYI44FTf79cScd/WDLph4Tl8lCrs26xe1TWmt7swx03giRO/Lkm0xTpsNU45MAoXJhlJh2iPOaG875D3/J20IzTBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQN4rD91; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQN4rD91"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5176bbb9384so12233761cf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jun 2026 14:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780436362; x=1781041162; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T0YNkx2SkmoVqkFkvNnml9yIGuSCCQWoNXXwQO7xJnM=;
        b=FQN4rD91WxqeFFWs3PXDsNuu0DXuNmn+Dg6PrYLB00spopPcppBQto3b+0C8IS05+5
         NqUHkMN5us5dfkoC99XU/U9gq6RVGNN1Y4I8N65PilVUe+2vBI1zOFm8MhXNceK+x5G/
         UbI0eRRnR6wsdlB66c7Q1YZ8bMVBk17gjfGEZs+DeHaPnrtlzJmMQq8f2waywD4q7Wjb
         ZWuIV6a89FljtJtyKR6+zr1sUIy6FiQxp00zWlsEMQj2qyYSgPx6d47ebUTMMD4ewhRW
         GMPqkmRVq8Z4yMEg18JS5tozLIAOui3zsnYPaVBvnrZ2OUs2YOxyTJPjvQ6NEaqNsvas
         goqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780436362; x=1781041162;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0YNkx2SkmoVqkFkvNnml9yIGuSCCQWoNXXwQO7xJnM=;
        b=ADJX3/iXoqiy9DhnNWJ+ntFfNlKB+sTDYpJD7j3DZfLK3F9WHSgiRuMKLI6uSZzv0+
         u2RALaqWr+tx4b6qP7C8iIfGCV4Jws/yaHN7gMJkqJN3CJqixcssaugJUHgVLilytBal
         rk1D3ZvCXPnkNXkfnG06b+zJJpyVvxQQdD/CbPWOiMDuQ2MzTZ/Dz/J6scLZg3xhAGY/
         GQQlIm4oUHPRVkYoygoG4HQ0vjB4508bZxOZzdX749icqVnOY7qnAQ4wikW+/MJ1lu6U
         TSTd74erd9WHVVlK3WZw//eC/t8HonZaTN7dpWFUVgbhcagVYSuGWACGp7qS4mg6giuf
         Qa/g==
X-Gm-Message-State: AOJu0YyGAb+G2AepNgybEdo+NZqJc7+IoifGDMO++Vp85ey0h6CEK2ke
	X92EAgEBG+PgdfRhKoSgrgsb9mPsYLUQiT/2t55uDeDkWpVisaxqnFmYo5Vh5w==
X-Gm-Gg: Acq92OG8N0DOlMrtvwiCY2bx2hhpye044bTugPzkgDWZo3cBYYKCp8WX56n+SYSfucB
	dN3kG5vUXiIf3G+dQm2gb99pUqCxnD+hr4P/gLRdgXfd7eUXxLnBwHpsBJzgCYw12KX9fn/tYHG
	UPGRMQOzcQYHloj/b+v7APoNt7FL1JM8EW1K9CzPficTW0TfO5w2YJSG16JwJetiXl27bUbrs/W
	Qh/5qafdo4Hx0K9tg7OKiqWuQjiYjsBK/cJwwrYDVMqg2jf16LFDpDQfN7AlzA9nDG2KQWjXmwm
	V9wu+yXpfZTZnhG9eUJPsbI6M3rGFgDcqqFOXAgvcrUG+4bALJ1ovukjXfCmyi1KkN19qnRlGTf
	/FqeVX/SAsaQV8w7d8gY3mmAQaxldOWsQCAGGsQWw2TgUTsSWmeXapxz6sED1gR0DoDBNDWQd5v
	aKISDtsh3bWMxgtbH0hohjDpN9XGH6Ixdou3mf2V3I
X-Received: by 2002:a05:622a:2616:b0:516:e7d0:73ac with SMTP id d75a77b69052e-5177861fe19mr14151351cf.21.1780436361782;
        Tue, 02 Jun 2026 14:39:21 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.70.165])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775e25c5dsm8532951cf.30.2026.06.02.14.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 14:39:21 -0700 (PDT)
Message-ID: <6a1f4d89.079cc868.cbd1d.f1d9@mx.google.com>
Date: Tue, 02 Jun 2026 14:39:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3035646244616450688=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jaggyaur@gmail.com
Subject: RE: Bluetooth: Fix Use-After-Free in hci_unregister_dev
In-Reply-To: <CACXZaU47FFpcucqfAsVz3nWQL8m6shuEav=bz4-8FL315fZDpA@mail.gmail.com>
References: <CACXZaU47FFpcucqfAsVz3nWQL8m6shuEav=bz4-8FL315fZDpA@mail.gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3035646244616450688==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_core.c:2671
error: net/bluetooth/hci_core.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3035646244616450688==--
