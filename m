Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75824F85D9
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 14:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789740193; cv=none; b=l3VWfRJDdpO3h7AYKIdrrT/zryjS/29Xb/iNkDJ/fS3ItTKubOgl+SzROhD8TxHK+YeOcESi5pHBa8voBOL6mbhif1Wje6+paQw8ptnRVJTFYatt9YA0LuObTb/irt6eKKVSNvpyCjpkDCcu6USn2mW+w584d4EyPgg6GRVpMak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789740193; c=relaxed/simple;
	bh=TtTazJu50jA//PC14UTMBWJ/zYy687s+fK9iKvZzVsc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mbiZm81RjVQ+abSnUgHauKg5ubSwDulMnkf7GkIGyBJRctY4wodQY7QdivPV38kvwbMWHnowR3/kN8oVfxzPhaR8F8dcGjE+6Ip4TzoLRZMHsMU6WMlFNeniEhPKlBcHNgKCQDEON81tqotvk15ulSRyiMyVATL+zXyujWSvcI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJKMZpZH; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJKMZpZH"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-939109fafddso52373285a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 07:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789740190; x=1790344990; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YSi91eoQrwZl+MiliNXOc86RBLuUL1M1xJlwHDYZv4I=;
        b=gJKMZpZHgkgNq0ymbZXo+CAzC6v9rJfttVJ+f8W+9v8c9QJfUTcQ349UEldkiLqnso
         ouFcTTAtWOYXg6fXGLq05YuBMW557K+ALFwfv2dKd9FTiX7AMYElkRBp+NocYRihtGT7
         pBmS0p8+txPdolcpqvtZuWIxgId6SlIBliry5u7Aej9Y8OYG9MO2SGIUb28gvL90wiFC
         fxS//Fstn/2Mm05EWTy27O/LDK8lYnnZviZ1cNrpGlD2cuSoEaAnGn7x8hvCR1TQmTQb
         BqqBUstYTsB2NWnD9YCeixsGwCoR+OXbm9WAOSFXH63vv2w/RRCcH2Evkar+zYeShKNw
         /qyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789740190; x=1790344990;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YSi91eoQrwZl+MiliNXOc86RBLuUL1M1xJlwHDYZv4I=;
        b=Vbf5OXkGYTKYh+qU7aTMNLjeFIGPMvw69JRKivK9Dhfkn6pX/Ed3eeBAB3o0R0Nhjn
         RyQkMT+VU/mNCDAIW+/o5342focDkQ3+YmRMYjIhn2VrWACa4uw0VQd+aI6PBaTm8ZsP
         cn0tHXT6jpn6Mm70WZHvQD0g6u8xubqYLTMcQLCfrfcI4lPFMF4+CdNwhppYV0Vq/gEf
         T3e4XDJt6C4Rg34q9PHjtzvqa/7amb2Mbz7tn/jQeRbzUhlw93fKUDwNWvHoh+DEcuOk
         CVxz/ug1vP/7y0i/umnCsH/MyoyaziG/9ILPL00hSeeVAAVlbmzPdg6sYvzXgh03aJWo
         QW+w==
X-Gm-Message-State: AFuF++k6h3xnX8Y76+ai3/cpEmWEzzMq31o4rA+U6yrY55hkl+TF/7IE
	m0g9axaLnSZMyV8GLliqWJnyDFOoo+9f/Too/s+tziuCqPC5Yxjt0D20YB7how==
X-Gm-Gg: AYBFou0y3GUcAv+dnj7zZ+EVy9jw1dTAvBoal3CESwx0Q8Ds7/fMx/Ku9tp4EcmKrqO
	ftrxsL+FNJm996mIMg8ifc5jMg+JYvkp25m+ldlXQFjIT6iOzN+HCpEh4aO5AWjg3+e4CPr4xWq
	xld0JRXAj1wVbYWHH6szZOq/bDDIJdGuvVJDdLDvOJ7j/gbwCQfAqrNyLOVlcCCGanreFCmoN3V
	53DkBN4RNDoJGvZiLHZkB8xQsBpTEVvMAEpd6JP/zMFu+SaF8xrXwAaM8WnyTWxQVvhDtPUUVz8
	5zfM4/kcDjF8MUcS/SIJCWGsLenV5AfX6D+10HiKl0+1cRn0TV5VAtrRO7EUSOqUqW8hZlxadYe
	m9g+zXTPvRdfuR9nX+5xDw0EuBzYIgu/lBqB1oNILc9PFc5QKxgCLmfCgvdseeukRU7kjorwvXk
	stuaICj1cZ09j1MR4a8vhf6cFBGFyT6cpH/y/N+GUZmMz6XqlA6dm6LX8q8d45pU8x4YfrnsxdX
	hDnIg==
X-Received: by 2002:a05:620a:1a01:b0:93a:2e4d:9f52 with SMTP id af79cd13be357-93bdc6a1399mr371612585a.19.1789740190289;
        Fri, 18 Sep 2026 07:03:10 -0700 (PDT)
Received: from [172.17.0.2] ([20.127.247.38])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93be0ecd455sm144047785a.29.2026.09.18.07.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 07:03:09 -0700 (PDT)
Message-ID: <6aad449d.b41fd234.46d10.7f66@mx.google.com>
Date: Fri, 18 Sep 2026 07:03:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5464793765843931288=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,1/3] doc/qualification: Add PICS and howto for the BAP qualification
In-Reply-To: <20260903085716.741578-1-frederic.danis@collabora.com>
References: <20260903085716.741578-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5464793765843931288==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [BlueZ,1/3] doc/qualification: Add PICS and howto for the BAP qualification
   Pull Request: https://github.com/bluez/bluez/pull/2477
   Created:      2026-09-03 11:12:57+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============5464793765843931288==--
