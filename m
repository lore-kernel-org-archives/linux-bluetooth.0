Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794152193;
	b=OrBiUCOWS9qR5rYYofzOTINe9Mfj+o5wxegp7WnwqL1UWY86GMuNkkX+Sody3NeYxLXj
	 9Fvr1vldw8cBSu27Tehj6qrErF0UR39meZH9laciWz7QQZ8oKfVjxyq3+7O0zFjD1JJgk
	 f/hcTWJR8WUmqLexO5HT1RwouVJu1GKVJNL5cWzRPRbP/xwvt+fuAG2V5yRK+P1bVUNRJ
	 +XDYDJSEhmxzbt2m9MCbKoB3ueqORdobLtgTtWgDa25r+n9MQQWbaQhxELyisWJmaWX7c
	 2DqExfnodzRtQparY8x7g0M76xaj9JExOkJNvOH6Q7NVE5s2OEvVhyQi8/A3KWWHOsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794152193;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=A2aQn8c/jtpwoXTrtsDeEeIQJkzRLiPE4kZYrKVdDSY=;
	b=syGIEuz2cU8Ysrotq+cLdIXh/G/MeMk2+QTeDFVy1s+Kpq17U0Mxq+y70vN8WV0/cYpS
	 jOP6rvai7/D7k9wt/5Gxzs2a8u59nclpzfqUmPwUNbtqvH0hN8sXjEymeouPw4W0u6Hth
	 qDecAupkuSqowMwNdK6AG6HdWMYj22CLcVaJ8T3XVb/S2g9zmtpB/BoF0G1ouu2mk3snJ
	 pg7FkQ/LjnUxlrNMCjZCETy10IUuX3lX47zVfZ7UluiijoLv2jJpKVP6oo04RHcxAfG2y
	 9JZIJ8AFTuOxfi0ipe9A+IEMCG9AnIoM/5m/Qg9qVJ5x5DS/9BehnEecqBQHSqfh59Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mxpr9p5S;
	arc=none smtp.remote-ip=209.85.222.175
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368D0606A31C
	for <linux-bluetooth@vger.kernel.org>; Sun,  8 Nov 2026 15:36:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 368D0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mxpr9p5S
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-945ae2daa68so14756285a.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 08 Nov 2026 07:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794152192; x=1794756992; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=A2aQn8c/jtpwoXTrtsDeEeIQJkzRLiPE4kZYrKVdDSY=;
        b=mxpr9p5SDYD+SztphOtr0Nvl10FNsfc8rS4T6beEvtTiL0mzbh7Vv1zJC7tAf2kxfO
         GIG99aPlzmYf8wYv8Axmfqi2nvrXE/gsQPjTlwajV697cGHuMfwMuzW8X6ynjsEMSInJ
         BjfsAfnZtnctU+SI7aQ8//6tIB/5ArB1zecA32/YUUN91K24VBp33NNOiYzLchcSMKfn
         lmkSu0uK1w7oP6ekPzhX62ciVkMQLqJLc4Y3metlaz45PyODbxd3K0qNprykZ/YWsn15
         tAvIeMzmG/nj8U6ONkDE7ebO3tl8NuxANIynrVDIg17LDMkMl9bK8FKfFESKzMIsOTuX
         ru3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794152192; x=1794756992;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=A2aQn8c/jtpwoXTrtsDeEeIQJkzRLiPE4kZYrKVdDSY=;
        b=HV31IPfT10dQl42aJWFgktIg50h5uKOXJdXzQ0bX1PHdE9/fvrU0sDYA4Kp9icniza
         +7YkjiGWRXeEY4PYuqLi4FNDpaD2JtHZS57IM5jaX2uHwOwfNEjX9JsXtpR86NKc4Snw
         +XY8HUt4Yl13ApiDPzuCwFPLyrxqwjSHTSH0J21vX+CVVZaRGn1vNurV8lq9ExFHB0n0
         3NA47/x2Dju/pQhM/fuNFLn2elPoiweHsC8EW9kW8JoYGPcliINuO6FF+bTZJ+/BoMFs
         Msp3fVZacz40xJMi6PlI/SN5KlGJrdIhO0BFdFZjBRpDSuIv7Gr8dOcwLK3kOY0t6uWI
         uwxQ==
X-Gm-Message-State: APuU4Z+kGVSKRFUc2hc9jHyjJL3Hkb2DUELvAsg5I2/JaBId8Ox3DyYQ
	gqrSOAhdk9aIJVcfKgU5c5qHvKJWNf4SL4ZPRwT0TVecajhc0uX7kS8qtFLR7g==
X-Gm-Gg: AYBFou0f0aNULyb60jRD6FwD6+ZddgQh5Y3k4J0vWUkAPyIcPD1zLWDTWXN4wImoklv
	lAH8lN0p83mkT9jtfJzIl+DKNXyFkNkNZkhXE6DO0dww3azOMA197mkV0UhjeECk1OlVwXRzaaH
	Gdup+EOCrALmXMWeZOu0ZnBiDtRrT5OcBWk1IAk76ekcmp/JWGwQ8DIubCRuiLy1dGyXmMLLQdA
	xS2AFmZYLIOQ3y19JsR4VuMn5WI9Xkj7fEhdFHVzvQQLOqdI+umF7IyOu/+/4q7BRKVbrvuI4x+
	va6KvmuDfSBNBN6BnvdYNPJotWPULCh7k6fzQsKsdDlA5P6fBXT9rjFMgK8fWo4i3/stAlqqK7a
	8NKmNZqx6TUo/gRHGq8/s1bwf0pTcYNdZOmHv5f7S/bZM5+gq+z+oZoCo2ypGMeFYwXs4T5skTD
	YvSqapKvKIWa1h0pc7Sr8oZp7rQleMaMiDkeTXDm4pDgmtgTxj3z+lqUK3bAuNZLtFEjINrRdUz
	Ts2ti7W898K7CpcE2V+NWaRoqCZqUpjFEYY4RpWbx3SHv3S81vXa2vuQ6TKPg==
X-Received: by 2002:a05:620a:838b:b0:945:f5c0:a630 with SMTP id af79cd13be357-947842bed6cmr202287085a.40.1794152192062;
        Sun, 08 Nov 2026 07:36:32 -0800 (PST)
Received: from [172.17.0.2] ([20.96.174.83])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94782dbd37dsm233131485a.31.2026.11.08.07.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 07:36:31 -0800 (PST)
Message-ID: <6af096ff.27a8fa0c.343e5.e978@mx.google.com>
Date: Sun, 08 Nov 2026 07:36:31 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1559972889021252322=="
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
To: linux-bluetooth@vger.kernel.org, aluvala.sai.teja@intel.com
Subject: RE: [v2] Bluetooth: btintel: Add UEFI standalone static SAR support
In-Reply-To: <20261108093656.3857961-1-aluvala.sai.teja@intel.com>
References: <20261108093656.3857961-1-aluvala.sai.teja@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1559972889021252322==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1205289/

---Test result---

Test Summary:
CheckPatch                    PASS      0.77 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      6.36 seconds
GitLint                       PASS      0.94 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.01 seconds
CheckAllWarning               PASS      27.90 seconds
CheckSparse                   PASS      29.71 seconds
BuildKernel32                 PASS      24.93 seconds
CheckKernelLLVM               PASS      25.29 seconds
TestRunnerSetup               PASS      566.79 seconds
IncrementalBuild              PASS      23.17 seconds



https://github.com/bluez/bluetooth-next/pull/1089

---
Regards,
Linux Bluetooth


--===============1559972889021252322==--
