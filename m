Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795373263;
	b=l8KOYFM28jDpNdFI/7ahXjdvCYGu8+msPs2uS29FaUO/+NGdInD0m0Ofx04TFkH7k9cF
	 ac+FcReJHVWrBJp0Tj56A79tA2SWeEW5LB1Td3qrZo4pw1WDpXv/xa08a5uYAAJwbsvix
	 KhPVmUWLN23ldfrciAyqyBM1vJQ4UeKB5IUH5DNnS6sC7YZEin+O/qCOV/iVG3FQgKgsy
	 Gl53toJt1wR/XOIMf4QdVJ6bY3vmx2/Qo7UgszYAxIK6rkRxwslRkm14QOho9qLI/5RWB
	 8pZ4SH+F9CGuhKEGbz4y2R+di1Q4mrGE+LENYPpTnPAqxpyqDo+uAkDAB+MYPhG87lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795373263;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=FRMoYjssk45H8wMhBV/GNkYOBCHQYdgRtKp6eXPuD7s=;
	b=daljnnd/N6y7ToE8r3rAAobcloTIblZlKF6rcEC1gKQY/xtnNqlQYUhinIIviJR3pHqW
	 jR8GAkPUSMYLRfj4XmvvCU2DPUvM9kyUS53cc8t1f4ibRM31K+Fmu/8pssQmWShzqc02I
	 WwnHWH8jsVnQN7v4RpT2gynznyo193LMJ1rUkniagiI62oaHz1TQLaCoh2H2bD6UEDDEc
	 tOckZcefR3g9TxaSaHin0j0rhyfFaiGynBUkRXZWqhYAT73QtpfzmpitH87wSnDvUY7nN
	 feytpX5NOYi74L9jrWYeNO/nOW4yWFSr8tP6NnOoE0LBPp6BZj7UZyc90TeCDbi7uDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="M/0vAVQ7";
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB09F606A320
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 18:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB09F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M/0vAVQ7
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b3d4d3bba3so1267185a91.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 10:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795373262; x=1795978062; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FRMoYjssk45H8wMhBV/GNkYOBCHQYdgRtKp6eXPuD7s=;
        b=M/0vAVQ7+lrkSwrC5Kq1jmyB6GtyboLeD5ihvvl0WMMBPSKJtGGA3SvmdaVTnIQdEp
         rV5SBPeWYxcTbuDo9i5Kfdris+dyoXVqhFWdPYuKx4Z1B89HnX96Laey+sPMR4mz8LNF
         UUBWD3NG2BCPftiwOUzlX6JVccjAyufulpPnxaS/+1bnMW+UShoqvLg6kNXFynJQ7P5S
         rGVNiJdVEWbtZN2amsL+LYJCKMYGfEy8PGIdMm7MRhbHsALrH6vDUQJdDlnblHy90et0
         6Bl/rMJ3Q9j3SS37vqNn42T85sjuVoCRyaJGfF6NbuupuUtddz8RikWr16NK0wPLtzsB
         dCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795373262; x=1795978062;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FRMoYjssk45H8wMhBV/GNkYOBCHQYdgRtKp6eXPuD7s=;
        b=xh3+LV3iwGBxwdq9vTGLrLffNeOZzWacaPsiudnhCJeIRkPB7d6MR+v6hsJOfM2QwM
         /e3xi+sijLtWTWIh8qkOs1APsVW8U8eQokrTdbSMwbhhL/sx+bwx3Yx2Y2yMDvXKddyT
         QXae6kd5GONavledRWe2lkL+e0dR3syStXSP9GMq4gGJrIDAxQi91qwOP23TkuhZXoNm
         6UialeHjFj0mWaE5EVgKYQPYM8HvW4wztLV88b7BMriRV3v+Cu9EiQSyMEnwPGPK1X/u
         KfC8Ds74Ny57x4EEiiGkOOChwWLj0M4vXGMdlvAceQQZRgjyFEGcn2bFgRVpywtFi3o6
         JKCw==
X-Gm-Message-State: APuU4Z+q21ZGz3+wzUpz7A1pkP7JhdJShaLqph4gAlV/qCU8y3zIpzVh
	qyUex22B6WPA7YFkCnK9bgUqP0vFqFXOY3ChsawsHRmndMdl8XK8ah4LLY4AuM30
X-Gm-Gg: AZFdTZf3z5naGfNv1K1fata+z7Nn2hPTi0I0A9mCw7nF0YzRlKoJ3RzAukBkbxGcevS
	PYzuvOFd0WOEsYIlO0kXf03jX/E4jNyce557kqzs2Lf9pQlPi407iuHR4cKPYGIOjkFO6b6RNHv
	mTkzNFtOVudstEDU49G8wN0N3jXBYL3+tEuksH6zJSu7dcfd+zM3Y72g6R/4bFGPLxV4R9mTnwY
	p9N+DKIALilfDXdCXWjcwy6lkLX3tF4XUWBAAGQrGNBNFOeevXzMcchVT7v2Ql+3qEy3porKoQk
	zoZxQw0KygUf4BXl8MSl3/W0qeEpOLmI1LKXDVV6xvKNhFAFOiTY8Z3hc5vDVQpPuH3BlwdTYjv
	Zs9YG66xt5EUkFgK7jDBkmr/KM2nNnfM+iAIzUcO/h7SdxyohS4XxsWrJ4zxOte/AUWAvhSduqk
	mfIBTtq0AEdMCZrAsg4ziUJjPUFrpTG71w33rZN6sq8A8KNDxX0PPe55xMT2gr20BVdqDFTGYnn
	tX/6EpHocc9gLkxdagIOqjGGSkP1i550q8p4KbuiSvxPt0WJG301W7fGWD9nF0=
X-Received: by 2002:a17:90b:4cd0:b0:3ab:36c4:b4ff with SMTP id 98e67ed59e1d1-3b41c925a85mr8964558a91.24.1795373262021;
        Sun, 22 Nov 2026 10:47:42 -0800 (PST)
Received: from [172.17.0.2] ([20.3.238.149])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0b52dsm15108404a91.5.2026.11.22.10.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 10:47:41 -0800 (PST)
Message-ID: <6b0338cd.408d4ce3.21a899.b64a@mx.google.com>
Date: Sun, 22 Nov 2026 10:47:41 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2910640300907297083=="
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
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [BlueZ] advertising: Refresh only advertisements that depend on discoverable
In-Reply-To: <20261122103136.620031-1-simon.mikuda@streamunlimited.com>
References: <20261122103136.620031-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2910640300907297083==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1218566/

---Test result---

Test Summary:
CheckPatch                    PASS      0.31 seconds
GitLint                       PASS      0.22 seconds
BuildEll                      PASS      20.39 seconds
BluezMake                     PASS      312.91 seconds
CheckSmatch                   WARNING   318.49 seconds
bluezmakeextell               PASS      100.52 seconds
TestFunctional                PASS      1233.40 seconds
IncrementalBuild              PASS      313.26 seconds
ScanBuild                     PASS      1196.06 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/advertising.c: note: in included file:./src/shared/mgmt.h:95:25: error: redefinition of unsigned int enum mgmt_io_capabilitysrc/advertising.c: note: in included file:./src/shared/mgmt.h:95:25: error: redefinition of unsigned int enum mgmt_io_capability


https://github.com/bluez/bluez/pull/2865

---
Regards,
Linux Bluetooth


--===============2910640300907297083==--
