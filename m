Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D272DCBF8
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 17:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786124037; cv=none; b=LFzMafcFHVaJNYmzMoCrkuiwCXJAcPm7ZdM6eYWeLOsAnzILiQAiHj3Di8C2y9PG7gNpfsETyXccl+NDTqFLXKCG4iZ3Kkavm3evIJCdDqkJ502e0ITwbDXKwmdhNhr3CkaiyZHHPoyv7d+SGexV3A3IgQDeowAEsrKZEhu04sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786124037; c=relaxed/simple;
	bh=jbpCWr66/kNOUoE/1GEAMQQQTzMvFSTyEnQ6Cfsn8Qc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=aXrUuP1P3hHY9CVjEfjjL0XzsQ++fr/fb7qbU10cguPrzUsTV1EH17WQeEfAG3P9jOPKr53MyOivX2NmcfUhQ8tsf/TXvjv5yqQ4EFr6tkMUTkOUbEXliR7XkEzXWHhE2829KZqlWpUT0HoQxtkMQVkYqWx3xHfqDxO4SsvRoFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghPMVrev; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghPMVrev"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c9b373d5af0so2957526a12.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Aug 2026 10:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786124035; x=1786728835; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jbpCWr66/kNOUoE/1GEAMQQQTzMvFSTyEnQ6Cfsn8Qc=;
        b=ghPMVrevgzvxzblhvHyJnRpr3ALTe4P4UC0GtS+E4nIwpDXiB6k/wTMyLlPlfpwS/N
         EZcjIasR2DGnAx9CPv43ZLZM5X1gMwgP/ohdcSLQNdrvkvGCdZx12CSsrjEwPSMsfKeE
         n1Von2QwdgVdtBW+1DQo25YeaAJavnfDD3uFkz9EP11QOT3zInSj6H3VNUHY+3CEW4/D
         AbhYD0QzHrmdyiSMKJaTH87qSo8QK80nRtCrAaCbwpuG0JgurV6LfL9zgDKiSnfSqRGt
         3liMavZeuNiOY01pZ0fBG84CWK8NNLiXHfXxA7EoDBDIE3d21o3MsaAoKqGLaN6Zi1Pt
         BXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786124035; x=1786728835;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jbpCWr66/kNOUoE/1GEAMQQQTzMvFSTyEnQ6Cfsn8Qc=;
        b=S0FeU5ekQDBQl4dqd3wBBOTWSEmWnstQJ3uVL3Kho8lbgTcyvlXSfkLPX00hruNjsR
         h9p2BYjF91VmrMfY+V+LzIRVzjiWV7RbMAeQy+Zw7fQiFdIGj7O3lMytnrL47n9k2T+Z
         BdmJ88C3Kz9KBjrDGyWden3aH0DuaEc4joo5dvkjWPGrKbOYMIQj7yHsH849nOjfOcEr
         mjogfPgvZ1HwUmCCpJjv6tIqJSaXOB5t29u5DdSQkvZkd/LfwMjAxhc7aV6iTWJKGS4p
         R7ehLbUgA60kBGyhF8MhcX12EIIAxHiscOWJNMvC5sgPkURqEYXS7NhBbz8qdoKae7Mi
         P2gg==
X-Gm-Message-State: AOJu0YyvexuBsm8LoqJxcQOVej9yISDDYYzhZBf/nFP3WKhyiY+tYOai
	vJ5ReHPjTty5B3IBlN66dhe2AE7TCzjsKjPIn4cGruXmtCoO8yf/qBBC3BvHJk3E
X-Gm-Gg: AR+sD11AMo1UZ9lPp/3i+0DDA9BvmJL68Ue1btAKvXHsafDIG7gO53YOx9UFbFO4kql
	E9fT7cf9QMC54EPsfDZxs/se91vqLvMpRT0Ge0KmAuvrr6PNHbqYsA/V2vCLwbxczHWwmY61eB/
	v8pOMP2Km61OJl/Nhn6F6IHRTcXnlrup1GiiIdtZERTx+wRQBaWslxmrYFndk8uMueyX4R/Nax3
	Zz04prIYuQNENOAfe56IatyfoC+ZLGlsy7jWatTunau6X5wrRydP3+Y2/874lxFuOkzIgZF9Ve2
	2ElfzofCXW8cklYL71kOzWUfbG1WWAbCrkcoMT3PMY9/sxBu5vdqJOQWginRnob8I8/pQQYG2U3
	fC9QNu6AG2ukxP0j3dJSTFnE6KJtTq3HYlFa7sdq5bzkyRCgqa+q7GaMeUle/95g30dcmb2MecA
	rL4Z4jtw5X98n+QUSw5l7QN5voZ6JomQ6gPNc8wQqmpS08cTZir/VLqRjiK1+4nf7xFdefziGVE
	gE=
X-Received: by 2002:a05:6a20:a11a:b0:3bf:6237:4d3f with SMTP id adf61e73a8af0-3cbce8dd448mr2153153637.18.1786124034675;
        Fri, 07 Aug 2026 10:33:54 -0700 (PDT)
Received: from [172.17.0.2] ([40.81.6.241])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315be8d60f4sm9736482eec.13.2026.08.07.10.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 10:33:54 -0700 (PDT)
Message-ID: <6a761702.6c5720b3.b2c5.75b1@mx.google.com>
Date: Fri, 07 Aug 2026 10:33:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4576899861712768468=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, enjou1224z@gmail.com
Subject: RE: Bluetooth: msft: fix vendor event use-after-free during open
In-Reply-To: <ea4efa51cc3be16d3eb7726fe5486f0be6c47907.1786092373.git.edragain@163.com>
References: <ea4efa51cc3be16d3eb7726fe5486f0be6c47907.1786092373.git.edragain@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4576899861712768468==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/msft.c:166
error: net/bluetooth/msft.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4576899861712768468==--
