Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795554182;
	b=f3VqorcXqz2pHvUU8LbJVgooXQAkRAq7nIudslNwVGJpRzQC1xi/Rq8IMPn4wWaVdl9W
	 +rsdpMGcmU1zX2SX5GrnHW9VdLfVrdJSLnsWmPocbIq2S9XS5AB3eiYqSArjfU96vJkBz
	 vOQxYbvXDhmlDhgKoMoq6o6M+S27sOlBc9PzbAevg1O3dpuQC/De5pSsnuM0yOrkQi/C5
	 eXdqSB8pe4VYJBDo1p0aSAoXN7IWf68Nwnq9LijrZCnNWi7aFs/UNeLMfeAXjYMDhXTto
	 /KPUyJnkM89zXKPDwR67cQQGmVXgd8HJNv8WcK3T5lB5sdwJwO0vMmt9DLyv6cneUJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795554182;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=4i3BoUjYn8z2/y9wfqFLOgZ/h99rVkertSH26zsYFYI=;
	b=MHYZOZMXDt4YgvYrFiioTGmTM9HR29kzEjndFLrd9uQTqgOAqqjk5nETL0CpQ7kQgZgD
	 xS2uiWN/t/L5VjD9IAVxDxWwIHdn9LRgI58AVEUpG2IRqtoSQPgsULstpZHrivFoxZhHO
	 2fktguZWbpIeFU0NtZYDDf+wOVszth2gqqzF23Q216Tq77J+IPRpX8ngKTdkDhDHfzxDg
	 diiUmOTz9+2gRxaoqlKqa7oW11dFa35s+EWbtDKcH1v3LvPR1lto7wnC5fsaQ9lgAkbgi
	 H05wQR4vOgd+3txYGBm0M8HEhx/LtfjkgVpbSCeibIjnDlerYcD8bC1KIWF3UpapN6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qIV9JhUO;
	arc=none smtp.remote-ip=209.85.222.172
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F32606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 21:03:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11F32606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qIV9JhUO
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-930c0f9c1b1so523981185a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 13:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795554181; x=1796158981; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4i3BoUjYn8z2/y9wfqFLOgZ/h99rVkertSH26zsYFYI=;
        b=qIV9JhUOqVc7jrOq+GaRAPlA1aSrWGf9gioGLOCfX1DAspqS3fFr6hiD+5gLxbKtCP
         kPdQfxooHYgJ6ZUVrr1S1WQGukC5vAa8sYFTfPq6/X4ufwDPCq9iwbF/dmId6WxVRI+H
         ONL4wcl0VOp8HZa1kiHyZ8k3YwWER4yHfgb7/buLR8yCNdz1iyNyp9shb2WGuXZQmHGn
         a20/BiGFfCT/+wghDVNxZIgMsUl5NTG82uVeldIioGCPwY3LrtbDwFnOO/IyQpUd1jGW
         KljvSug5xpOH9rD9Lkwgm2XfLeYbacINQe4XdujMaQska91mcGt2HaKJuiLS/sUmp95H
         4QzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795554181; x=1796158981;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4i3BoUjYn8z2/y9wfqFLOgZ/h99rVkertSH26zsYFYI=;
        b=TcU9JU+5iUOvvMpAZqX0Y+BwjJjVnD3/+2miaOZbl6cd6+lQMl2rFAzVQEs4S+hzGv
         tsGNuPoZvOzHfxkZdI0qtmlxbh4RcgVLCfjxDf5dFXKI+0kcml8SM1lz31IdhBg1HBGb
         N8rhm2e5jC2ZoJbzGKCTXC05WxasIdkAx9BBmTQvfrB7WGe2R4PZ4zDXNc9xqouvyCS0
         UNNp4HZ4jPogchaiid2S/A4Qv/rdVbro0bNmZXIJODVbV1L2AWPwvb/FtN64eilfhgAv
         RNmtxdF6GJ7u4NMwfFyGLj6hv19+DePZ6TQ5FGsVZhPe8+pCKZrpqCmCdY8NYcohW+C3
         49Yg==
X-Gm-Message-State: APuU4Z/B8FBFQlf3R/xvx7wdWwxxj3qagyueHjH2JKHCVOQ6JfBoGnc7
	XlOEfYO1CKGxP2GmbtHkpgr+GqCPTYyafhXNf0vKfy9E9qj1QVFrICkIh6OTig==
X-Gm-Gg: AZFdTZfFyt+NsFQ3aijEzIDdtBMEUB0LPGbRE6vbbSB/H3jrJb39R9Z3sKKCDMtnlbA
	maEvbxZv762DCpDrBp+E9QGuOR/O9vrKl1/lzqQAsziWSN5gBzxTzr5FMKod9p0Dlmvg0LdA2Qf
	Y5ZSQzcsgfX9SXvVZe85t/5ggWTskOV6vThtDy5L5I3MzwRXNmJTXGIccH4jMVDwgiyiV4wRIMD
	WR1DWFEMt46iDxhjxRAH2m0GC5sEYpRols/u3+8j1eE0LYCAC0BREtROnnuplOrXlqPCF0JUtis
	3I0VpA8pwMDxVEZeyUfnjgz9OmxuUvLU8H6SIvbG9G9PBqH5q7fNrd0u0RVf3ylj8xvDIIZbcCz
	LuG+JHDqLJ1T8yULk+ymb6jAOqJJY+kXYkVDItozqR6JJv0nG2OkyGH3s5swM4MnlGqLy9PlAor
	KF4Mix3JOz2qpumwCbCl13El2ThqSkFDe0X+hrpl0FzXnDuieDh2XAhN/Re5Q/mkoZy0PtoE/xo
	G1+nfP2hdeAVTKUopJdq7yINf7QrdxXjLphszw0AQArkDrsvUgm2UPUutbnPeY=
X-Received: by 2002:a05:620a:271a:b0:949:7497:7c10 with SMTP id af79cd13be357-949bab4f31fmr2791767385a.57.1795554180822;
        Tue, 24 Nov 2026 13:03:00 -0800 (PST)
Received: from [172.17.0.2] ([4.227.170.143])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb3ba04bsm1157723385a.24.2026.11.24.13.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 13:03:00 -0800 (PST)
Message-ID: <6b05fb84.3da936b0.51f03.95d2@mx.google.com>
Date: Tue, 24 Nov 2026 13:03:00 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3196024650934258561=="
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
Subject: RE: AVRCP browsing fixes
In-Reply-To: <20261124121904.3267700-2-simon.mikuda@streamunlimited.com>
References: <20261124121904.3267700-2-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3196024650934258561==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1220797/

---Test result---

Test Summary:
CheckPatch                    PASS      5.04 seconds
GitLint                       PASS      3.41 seconds
BuildEll                      PASS      20.69 seconds
BluezMake                     PASS      315.69 seconds
MakeCheck                     PASS      14.55 seconds
MakeDistcheck                 PASS      147.44 seconds
CheckValgrind                 PASS      351.41 seconds
CheckSmatch                   PASS      317.95 seconds
bluezmakeextell               PASS      100.89 seconds
TestFunctional                PASS      1228.97 seconds
IncrementalBuild              PASS      349.10 seconds
ScanBuild                     PASS      1196.19 seconds



https://github.com/bluez/bluez/pull/2899

---
Regards,
Linux Bluetooth


--===============3196024650934258561==--
