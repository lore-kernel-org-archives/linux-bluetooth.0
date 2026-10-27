Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793133012;
	b=DfWh0374ngpxsCD0zAg6xd0jYyxhUS9GujLHQjZPHrz6Wc6jDiQbu9iqMRz0vFBQFCPG
	 uSn3KDDggYh2DejZIwDSbZZl0KWK7ddf5JN63/CoANMCbz39UrSBY7XP5T4H6eJUblpQo
	 qaSLPc4qfFayaNIkVqWCckE3dfSxTpIm8XK8UkKUwqHvvBOXs/4fe5Ydo0jefyk46k0rk
	 e7miJ57WE2PImrvW8Dal4XoFEn3EdkPBqghFLlE/fZ+t71Dbz2feZfobvCKeTaQWAhZhi
	 zgArXQEq9EH0VZ4eeF6hnDyG8qlOIkeonFIHKllg6H3/i3S0mqKL7jQLOgLWBJWazjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793133012;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=1YKDTXeJ0OlkzaJ348qGGePS79p1nGhqed1qWui+Osg=;
	b=OaSTjv1Kxn0z/YrRI26pc2qOv5Tawr+Wmtb+WzvkJFqIXOIdpbSVhLfI6PxzeUlrkCHg
	 RZi39L8gHYOPLOjjQzYh3ubkwi6OFFG1nGmYsQxlf0sXrd/u4kc24hRxT67Y7V9IP+01c
	 yl26gqas9iOYdxYf9wdXclNJ1kTv3yvsmyJF0E4UkNVIy39dIv3gWCINz3m87TW4SF4HN
	 EvnpUYW45An0xTu9SynfkatI7iZKv36ZXeB06bbvJbvpwyyu/acZUNtNLUcheGGVbxcP6
	 o0IJYFpKP3GnjiTDrxeYNI8mT8HByufN2lg7OeDCg+FfPzST5MK3ktN0UAcYck0VS8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fwlm51c5;
	arc=none smtp.remote-ip=209.85.222.179
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7820606A90D
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 20:30:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7820606A90D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fwlm51c5
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-930c0f9c1b1so17538685a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 13:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793133011; x=1793737811; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1YKDTXeJ0OlkzaJ348qGGePS79p1nGhqed1qWui+Osg=;
        b=fwlm51c5bxA5JaZ3zqqm6ZhhF5pvxH4TbRen8QInpV55M8f5Ivc8dGGxMiSZqoi9yb
         CQfRCjoAND0M0OzIjnJC/2WMYs2MBC7ErStbebYl6bmW1O+zAiPWVB+G4Ft+Ob7wbMuJ
         rzd9PsWE3RuGT/oTH+ntC/1IfLspUfTa5H5DYYl+zHImZ6nFuECjZwb8mHfInISq9F/S
         TW8nsrByCOmxqUQWuxbgFPOVVI+IzWL/ktcIr0uCz4OHGajynhIKde3rqm3Gd55KQ5or
         AjRLeMYRZjrfsrzxgBjDtVaC6GOO5m/36gs1sryySSF4ICcleu5FQ15oAm1FJch/fEnK
         fY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793133011; x=1793737811;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1YKDTXeJ0OlkzaJ348qGGePS79p1nGhqed1qWui+Osg=;
        b=NVYX9CGmwTwZq9LacmEDzkKIEdlx7YtOsbNDmmVEN9MEuTQ8QEPr0v+axG6E6RsO+9
         VR4EYwbhNDVuYH1ZoGhFdrq1H04lltiTQbS6Z9dxq1eBYNzP40jAMf8TlgP00e0nYUNh
         OohCGXEcCO5oO4gaBFx1mlndBCcqKRZHzM0UQiXQy7kvVeBQ3oAMATExM/2ug/gtPAs7
         XOgdaF9bT6746DSx4ADBY57n89z8ptO5KiJCFj9MEA+V4T6pxCv+wYp69cxp2GS673Ac
         wNdhvDBEGXURUuYkQua5vhefFBu1o9Syc2lFrWpo6enEEI0rISkMjjYRp+oYwcl1/Z2y
         JetA==
X-Gm-Message-State: AFq9FYJhcgrRJjIviK0u+0TtAjnUotIpGiTIMBxizPwwBo3yeTDpzWgL
	gdIZhdZHBKyXBAso/RYXcUF0J5mJwMkdDmZZKx94h+0jkdVi46gMqHzHwDR3bg==
X-Gm-Gg: AYBFou0sl1uIZTlheZULGyiHXqXOOI/5XPTEt1MoQ62tMAu1jMnDpr/07ge7s7CIMsy
	3w5GpzC/ykitFGxC7IQT/PhsqBG87g/Qc5UmPrTbFJozzNiYYHoZ9DgpuBAjhjxKwvZrCCMDCoI
	CkpiSaF3iyy4+VPbjviaO/ljLzH7KfXZ9MgnP4vUhKezjT7HaeZ1dHWKTy4GWDw6yLgmaAqqoud
	G+JGs9NvDMiOX9Unjjwc8cfWC8d8KlcqEQJtsINvLKpDdYWm2zXbL7x1HjGcnJ7JoHCS/PnvYLQ
	+I/uXLYecH9EMgT3VI3YaxqNUEBzSOSszlzUyi/t14eol2IaaMNgoE6XKCAGbELw4Qh6nyGiZSe
	yJArEpjVxujE8JX56Yx5ctAaXtzW2jmCd2hfp1LpmaCyRW2qtmGY35v50udYLaSJjAQv/TEFdJj
	XsmW9uKyRcoQIup4ytmrR8DHVLFowm9+5y4F6JgPPoxlzx2augUT1nJpheYarU5zM6SUyKSFNIU
	cQyQL7lBeQl5KOcrJHyLf0rPtBqXgRauuI8ML/U77AkuLziaOgM9xees08M1ZkV
X-Received: by 2002:a05:620a:d8a:b0:93f:2ab9:729e with SMTP id af79cd13be357-94408a6949fmr15839985a.21.1793133010648;
        Tue, 27 Oct 2026 13:30:10 -0700 (PDT)
Received: from [172.17.0.2] ([52.224.247.167])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f078a762sm1069368285a.30.2026.10.27.13.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 13:30:10 -0700 (PDT)
Message-ID: <6ae109d2.e20a777d.8d4ed.0cef@mx.google.com>
Date: Tue, 27 Oct 2026 13:30:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2480814983215693990=="
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
To: linux-bluetooth@vger.kernel.org, kevin@simpleble.org
Subject: RE: adapter: Fix Discovering staying true after a rejected stop
In-Reply-To: <20261027160852.54689-1-kevin@simpleble.org>
References: <20261027160852.54689-1-kevin@simpleble.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2480814983215693990==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1194777/

---Test result---

Test Summary:
CheckPatch                    PASS      0.50 seconds
GitLint                       PASS      0.35 seconds
BuildEll                      PASS      20.88 seconds
BluezMake                     PASS      305.85 seconds
CheckSmatch                   PASS      315.84 seconds
bluezmakeextell               PASS      102.07 seconds
TestFunctional                PASS      1164.26 seconds
IncrementalBuild              PASS      313.31 seconds
ScanBuild                     PASS      1169.73 seconds



https://github.com/bluez/bluez/pull/2723

---
Regards,
Linux Bluetooth


--===============2480814983215693990==--
