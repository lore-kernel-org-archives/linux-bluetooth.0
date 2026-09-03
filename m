Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D553B41E6DF
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 12:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788437142; cv=none; b=UW2M/J2t3n3eR4ElhsqSZC6JQVl6YyPzQ3vdsn/d+GIvhdxC7kapSrRqmsCWL2oUoAfgaj5XSWI5fhp+LvmLsRR7MChsBnKwGLda5VRTx7LZP/1M8XUNEInSRznH4JpCyBhpr1YcNVIJa5iCOq8LVlwdPw9887kDPJA3Sw4M/9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788437142; c=relaxed/simple;
	bh=HWf5dA2H4mtskyItfm07ixfmfeX5DQrZ+wmYSwMDEiI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=sRyFHSz1ixl55sgiEqotC/g8cKB+UGccLxkvJOtGZZqH4n9pCf7FGheDGdXVWY4gXsLFh/XLTcCyFT3l/7Z02dqDk/USU9AsckYM8AYZ92zOnqghHNFGH082/vBZkCkmh+ynLuGQxlU1f9Ebr10kbqcxXaK8OaGbZqbvqHmVIoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYmCDQzg; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYmCDQzg"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc1cbb64a1fso2464185a12.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 05:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788437140; x=1789041940; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DCCRoimZDGEeyMiGdI4JXLID6xsRwYjW+oUTimTzDrQ=;
        b=FYmCDQzgw4m38lBN3Nosvag2fw/IovmwdT4pBQvon17nWgst2TBmPe8erDFNtwxqG1
         mybxxWAjFMCgifGFqD11+knMdujvLT9Wmr2T3xkTgjeJDcz6oKUAPEyl4IB/3Bw0nz1R
         G9P2ByXs7IuYkOI/FWxoYtvNqmGP4eAO/5oeIl9DDhXfbalDKYPAuecUFZlwIATHrDvC
         gmZmI9geI17kjzLRRjcnb3LUoEdV6DRseftwzM56jGz1wnH3HxhQWemudkzGROEJs7dH
         VPmd1FAPd68WgzxhLKhryi9qd7TDX6CWc84PSQOusSlpiRDxU8RqlobhyODP213bZfI5
         2O8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788437140; x=1789041940;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DCCRoimZDGEeyMiGdI4JXLID6xsRwYjW+oUTimTzDrQ=;
        b=lLLNHv9pkSFWVM4+mocMKnMewTFPEfp0f2gv3XMAjFB3sqy1cXZc5PVP6ecokD+dl8
         UeXTGGKTypSiAD24zgO0oyE5sLDqkkJUtR6MUCNTUEH9vBb6CQlz4W1GiHEDv5Ot0bLF
         VivxRtY8ASuZfiWfhlyW1tEF3EUJhKZDtAMVfAyYFMSxaF7tWR0/4PCbIl6xFPXOyHIj
         rBVb7SeURCe7IJ1020ASR/ZDj8crDtDdO9Yj0VsXQM4GZSNk5DwC0ju2ahIquYEMRoTw
         7XxIZlqkX3kqtBi+Zk3HMCj+622fmaJmrhAIUYhTOJKOSnyJT9lIkKS4N9BBAYXaItCZ
         n7dw==
X-Gm-Message-State: AFuF++kuxlS36EmfkznwIHE9W+aCbl8+suJlFa4PU+ViOsCELGXUvInG
	jBZshyyNUit5OM8Z0YPWjH7TcAhJoK3XeQv8p1Xum5VjCJ+FoFDwnyEWw/UriQ==
X-Gm-Gg: AYBFou3UX7mQpmxxt3FyCTKFp7gCXbvhp6nuTSTvCVWjSJ4iArZEpru7CMdUF2IQmv/
	8/hFgpKGYOUbqtmwEbobaLP+OmSgcZy79K93+F7wRidbP5/yrQhPhI7Nk3T858Td/D1jydyYbjW
	xoTou9n6+W/zdTey4pFhTv6tlG9raq1cOknpSIVkMrYJRQB53wZHPEhkseGuo3JcJeMylJrvfG4
	7LRmR/HhO4hmI0ZT3QFoDlJRjr1pojqh5nP6rK9iR0btnVA1fIThzf8Xt3UR7AljKffNTzUf/sU
	ujIzmSh65glrtcq0UG0VbbxYQF/oC96Pv8jx7Nv8RxNMEHPFT9jz44eP0JhwSZrf0brp5crVHD6
	PVNrRQInURfIs7l6P8UowxRiqQvbrgy+FM5eWIObqo6R9YRGumMLGMcj1RsOKr20Y10pI3Q29Mm
	/FYfJEQNv/tFha60Scpd9poq0HkCLFeSmri5YN79w6lBBPY48q00Af+ExGUfsXTXrBYMHU
X-Received: by 2002:a17:90b:5109:b0:399:e97:8d5a with SMTP id 98e67ed59e1d1-39aee152d79mr19140595a91.25.1788437139891;
        Thu, 03 Sep 2026 05:05:39 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.244.184])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3325592d9c5sm6601933eec.11.2026.09.03.05.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 05:05:39 -0700 (PDT)
Message-ID: <6a996293.541ea9c2.268a14.2e05@mx.google.com>
Date: Thu, 03 Sep 2026 05:05:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2717574514982402229=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,1/2] doc/qualification: Add ASCS PICS file
In-Reply-To: <20260903072948.719744-1-frederic.danis@collabora.com>
References: <20260903072948.719744-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2717574514982402229==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1156754

---Test result---

Test Summary:
CheckPatch                    PASS      1.10 seconds
GitLint                       PASS      0.43 seconds
BuildEll                      PASS      20.51 seconds
BluezMake                     PASS      619.69 seconds
MakeCheck                     PASS      18.92 seconds
MakeDistcheck                 PASS      161.07 seconds
CheckValgrind                 PASS      233.78 seconds
CheckSmatch                   PASS      316.26 seconds
bluezmakeextell               PASS      103.30 seconds
IncrementalBuild              PASS      609.88 seconds
ScanBuild                     PASS      1004.99 seconds



https://github.com/bluez/bluez/pull/2476

---
Regards,
Linux Bluetooth


--===============2717574514982402229==--
