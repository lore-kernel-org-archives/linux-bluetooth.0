Received: from mail-qk2-f39.google.com (mail-qk2-f39.google.com [74.125.230.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE567334692
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 08:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790757232; cv=none; b=BBEke2QI5QM053b/UNe8+BUbqKyjj7RXhMHsG4F9vLx+2PXzebr5XGAfNp93dVV6RsFcQ/p+MJcsb3zLoeiVe6yb/w6D/d25bwke7Ko8sAwBO/ia7s6TnTlOhOyXmz0GglFoS22WGvBChs4zUcBdva5ncwdcsDj1sVNLLbMsx6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790757232; c=relaxed/simple;
	bh=+IyGm2Y8ahWqvyzSDqDKsW5DOsC07EAr5iL6K0SIFaE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dmS69PyIk4WAXJjSvEoEqmAT+cON2Kszh5h6hKUImXGpvILqWuLuJwvkQdp8mgJDDtucicsuGFQbxT2eMgO5rwQNyZG+WgfPhj68HLomu2KIexI1GRWC8RDI0s4nIg5cZWNRWzPiJcD/MpU80XbqPW3fo4iRMizrZdL9USdNxNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ci/78UoL; arc=none smtp.client-ip=74.125.230.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ci/78UoL"
Received: by mail-qk2-f39.google.com with SMTP id af79cd13be357-939922847efso457388685a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 01:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790757223; x=1791362023; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PszbOSW90R38W7k+N+NC9DiJhjEx4JSYVIV+MNHcmq4=;
        b=Ci/78UoL327OxbfYjE36XNULIocFtj35zru/Zoh0vCzZ+TSAp4psZaPlA7uMukmsRw
         ov9GhN5yyvJNlyCYYbFbrvANDCCkdxXW4jgExZbyFz7Fr1BIkMx9pvfjLoKIXX3h4Dju
         3ap7Qzhbt565YvCzn5Vj2nx+zlGOER0xd0DY/xMuOtf60nXKOH13Ic1Pke8EnD2Hs6qL
         k6PEIfheSu29kfdzo8WATJzp6jTDt+/zP+mGAgX8edxyREskPio3cXazuYRXJB7E+5OJ
         4pJQSO9lHMHomOSq3SLOgSPoBbS50FR7zcbdfQNxHF/MkDjbF0gCawXuvx32tNEBf7At
         pKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790757223; x=1791362023;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PszbOSW90R38W7k+N+NC9DiJhjEx4JSYVIV+MNHcmq4=;
        b=X3quVzBy0t6ofhlxhB1zrtbihqzk6r+CyZv5/n+qjCzVAi9Sm/BKRM48Ic+jOS4/rL
         2K8U8uJ5WeUTjbd+QB9UvUNYvXEVeAivoDYYgd2MiaBJQBkMsN/Nqbkl8qgf+wrNF3MN
         0an5/G0E7UCl7QAZuKNrYbzU93hkzIQO4WnFKeZJ6VcSsVI7w5R1BwQ5iCjwnXppffIM
         8wGVwOzjcxAHG1BCv/XFVef0jjjf5CRy0qKgVOzaUuMImoGaw6tDHF/ryYEetY5K6l7l
         LkJZp86qTjD8nj1+D4i0VqhBzZmLhFpjizrYBXYEwZX4clRbjJLxczMsZmtrldjw5Ppz
         syGw==
X-Gm-Message-State: AFuF++nGiKf8feGobv7p70TjUmjmTQui3hWLdnqflGCAm0hhJYViPyF4
	4P5WiILASyPj3V/6p4x99ImRwAlCWX5/NvNOLSwWQKEox/xtOpx81Jdu7S3J48y0
X-Gm-Gg: AYBFou2/gdZoL5UlADcSdLYsNyE26lvlfBIdl8jT9z1RLMB3HnpJDoREOEpR9XABqsP
	+ah8peycEJ/mD7dbtiat9WGKamAIUs7dKqWxigiZHI8bgzYfV7mg1dSSa6iRD9OYs2e4Vlu97pJ
	ymqPAH4lhWgjGWQHJZVfQrJugzmd5xvwwhPlyy6sLDF9bIa31CYEja5ethrmBIqMj+G7XMrW325
	ZCh+C9tgKIfLlO8cE/jQG1uETZTSspxIP7C54dboXXnpKCJlIG6tNuvuM7fmAgB4D5YGY3DYN3c
	Or8VCMnKcdP8TlHIHmVFMvzZIa+DWxtyknvU7VuFV5vRG1WBKmZ5+/Gxw67O/ePSCeTVVpZpX3+
	BvVZq1q+rrGwmVCQpy27KOXW/PMKCJAugZ4gKErzq7DlelDhVMMNT0SI7xXLBNDVarBqHoFYVf7
	AuQ0eAOCn9ZAy6gqaWScE0Vgfj19lR/HAMCpgL0X1zJdaeOvwK3FpI/kJk8ogl5o6vZr9ZaZLuZ
	Ou1/HI=
X-Received: by 2002:a05:620a:450d:b0:93c:83ab:c875 with SMTP id af79cd13be357-93ca95e7045mr105926585a.4.1790757223287;
        Wed, 30 Sep 2026 01:33:43 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.192.251])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ca807c33dsm66047785a.13.2026.09.30.01.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 01:33:42 -0700 (PDT)
Message-ID: <6abcc966.19f6222c.17e014.7325@mx.google.com>
Date: Wed, 30 Sep 2026 01:33:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3976613421242327285=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, cheng.jiang@oss.qualcomm.com
Subject: RE: ranging: Route CS subevent results by connection and configuration
In-Reply-To: <20260930054528.2258948-1-cheng.jiang@oss.qualcomm.com>
References: <20260930054528.2258948-1-cheng.jiang@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3976613421242327285==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1176540/

---Test result---

Test Summary:
CheckPatch                    PASS      0.92 seconds
GitLint                       PASS      0.35 seconds
BuildEll                      PASS      20.34 seconds
BluezMake                     PASS      381.24 seconds
MakeCheck                     PASS      0.99 seconds
MakeDistcheck                 PASS      141.31 seconds
CheckValgrind                 PASS      146.15 seconds
CheckSmatch                   PASS      291.83 seconds
bluezmakeextell               PASS      95.32 seconds
TestFunctional                PASS      1114.58 seconds
IncrementalBuild              PASS      374.97 seconds
ScanBuild                     PASS      1121.15 seconds



https://github.com/bluez/bluez/pull/2610

---
Regards,
Linux Bluetooth


--===============3976613421242327285==--
