Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793176011;
	b=24o3+SZMKu4Zu0WpLHK2t1T2VW31+K3IyhjiTZwwoFOcEFmXXWrJ2ZjORIaZ8a5QnHWw
	 5q7W9ribTRKRYebaF7z6cyX/3+OijMgolDP1DE0G+sdatl119e18kkxKjMEfYi8h+Z6kD
	 22nh9htnxYpzawIo9qOKzLpBNGepHxUFFdYU3B3qPlBawZ6hB6DGohtOXpuXzNYKZmeRu
	 j7bowItYyuWDusl6X8vBu0b2aQQ6VjZy+6Fve8iBeBUbMUP0JfdAi0EzOXlZMHrPzQKam
	 e08Fhnf8RiHDmwwcpL4uAU7tGAlik2vMp8S1laSlH+4VkqNSrzZrgXc7VT69ndcnbZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793176011;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=evEeFw2Dv1ZnHVE0M9lFNQsY/v/OxE7VNwzFktPz1ZQ=;
	b=BvQSRsTO8rl/aP43s3xkcK7CJ8Nx6LUl5JsJtZHTNYTsJZCpfeEOhqBqi2zwwpb9ndg6
	 rXKtBE21tV2CtQH5S+s5UbqM4vaWZwdr+G5NbsIg7Df6ew6DeSqKaBLD1xYdBy+v6bUJo
	 EBVsrvLYxRq4KPUZ/132USCY24+IBZHuF268SrYdCe2lDCBVWmC6aw80v3bnxThRoFW63
	 VTmxV5bGu1OlHzWpn6RO4TPvFMwjlbqouWbG+TkQzBKK48ruU5YzSHGNZiNg1XrkrUYDL
	 X2k8t47/zxQo5zNgdMC+N1ibV97S98qdvi6b1WBCYraOs0f4Sil37XPwuVhEpNbnjHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oPpbw+7T;
	arc=none smtp.remote-ip=209.85.167.179
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FD3606A31D
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 08:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14FD3606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oPpbw+7T
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4ed6d69bdfaso453042b6e.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 01:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793176010; x=1793780810; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=evEeFw2Dv1ZnHVE0M9lFNQsY/v/OxE7VNwzFktPz1ZQ=;
        b=oPpbw+7TrOFXHLdCHPAIXbk5+0mhEv8OhYg8XtKwbopwlqkSmyERGjLv6g6X6m1KUw
         mTkCGfReh6ZH1jGAcrjco2ybSedHtdCRw0Qo+NlgMI2KRaJrmf+a5XsDxXltu05uiJ11
         6Z2wJsGbSdoX/+YjK4L/u7JNmB/cSkqPHm4GnCnck18yxWWRkPk2oI6PYKJ4R3XJ8bN3
         rtNXaeq64aj8DaPBCaAWANSDg51X5rixyjihmr6k4efAXUfV04/QlitHtkqLMgZiEeBQ
         BsKtI4DdSnno8iZqn74gGbv28t5YuE+akXJ8zMX/7iNc4hUrNyL022bFsv5FqdI/KCta
         Z/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793176010; x=1793780810;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=evEeFw2Dv1ZnHVE0M9lFNQsY/v/OxE7VNwzFktPz1ZQ=;
        b=loQ+/+EN2CWg0DPfiEiU9BRRy5lXweDyY7aLDORmSZUVOFcc3YkykTEruK5SKfIv55
         IakI9gwJuXnUOB9KkSb8du4K/oRe+4ACSxKJo1/3cVoU9oyxwPkvKHeQezD6L7XizmpV
         2K2wofQMoSowklYlgAnWtRNOOVMDBST2ZKOprCgtL2Z/bOmysmzms66ZkeCEJ1KvoeWB
         N3nMGG+iSf0c7bPzrp3JAc3qL2Vhbzy4XPqDhSgnH+QovrBDfq3yoHpbDdnUGXsnc8yJ
         eGtMC9uf3aNINGbkqMmHkGCjdKkQGo2y/Y306bR7VPpzPLIkm5jPxfKQhLe+me8QZacA
         wF5A==
X-Gm-Message-State: AFq9FYKS38bvH+I7OoaIC9jd2+6dlQfkpqIEh7Yz7ZwtY8E5nDJPYl2e
	xOuK+pG23SsJnP+j2/lQmmBYNpaC6o73MUm9G80SOoNK5ixzoVvjoMyi7b3NTw==
X-Gm-Gg: AYBFou0h9O+M6GoUNtDE5ZpeGh6WuT9jaPwAOYPpuLrI1Pe3oHxIAaAQXX69/gOaHYM
	NEsIaOfDxhsX3NwLIRfMKc625nme4s1DyrHspQ/jVGQAFCSJeiYP0AahO8+Dv/N6FXCVU9h8Rg1
	D0kVqxJopIPik7ZR3dOlKmaRAGKV/Q16v5Iy4HjHGrepuMqgRwhNSNHKJrdtZh2x2os2sIdluhp
	aHdxQG0Ff4FW5SmOx0tKkF6Lwmc8eykWyONIsn7z4HNXQjaBRq5YPZ92/t1cUoN/dmdBdQ8rY4J
	Cf9fz+MOua60RBcAaB7w1LI6fJ45fcKpZ0FIxBRKYVP3Gdj12chpFOwsX0zl/oACcdCb/hadMuY
	uLYYIqo/IdH1LTIQ8fHmURF1BsuBLiJaQgSnMmN+PhXG+fd6rw0YmolV/DgYpp4InONUvuGp/NN
	yumg0lPjF7plRynGImVIp3/kAVdrVyOzQuB+bxS0JGTjLrzP9HvBIhWQM+tMR+4yh5yOsVs/4tE
	XQRWHu7srvpOooDVqKBioxAn5CJOt8YRn++IbYyEfqJgPDqSYkSd0gztA4r0DoERyIolxo70+yn
	6XZBVeZsk3U=
X-Received: by 2002:a05:6808:c2c6:b0:4f4:d7:b15b with SMTP id 5614622812f47-5637ed08b0fmr1108870b6e.4.1793176009950;
        Wed, 28 Oct 2026 01:26:49 -0700 (PDT)
Received: from [172.17.0.2] ([172.212.136.241])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a8b74c0a7fsm1885932fac.2.2026.10.28.01.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 01:26:49 -0700 (PDT)
Message-ID: <6ae1b1c9.051c5103.300658.6e16@mx.google.com>
Date: Wed, 28 Oct 2026 01:26:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8371172479771016299=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: shared/asha: prime volume before starting audio
In-Reply-To: <20261013034613.516771-1-cochcoder@proton.me>
References: <20261013034613.516771-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8371172479771016299==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       shared/asha: prime volume before starting audio
   Pull Request: https://github.com/bluez/bluez/pull/2665
   Created:      2026-10-13 04:00:16+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============8371172479771016299==--
