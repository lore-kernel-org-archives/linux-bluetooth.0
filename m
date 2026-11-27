Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795788147;
	b=T7mxzMq4IVqU/nmQ5640bds/4UrtoH8hOyFJCpqtO4ZNMK4YVpQ7pVtuzGeG+7RaZU+s
	 bO1URXkEbhvV+A2W+Eo2AvVOgHAzpmYnk+zrPjMalY0HlVjcs5k+h6KBjapt4qiid0BXh
	 GtBa3HApYJl+m/HCwZOZByR69HpAH1loku8Qxjo6aMD8VE0wXPl/3/5l9ZRZlIHSavDqP
	 R8i2Z6MbLD6MAmAg/kRHUglKCS/EFE239GQnm7kqfOjCZALtTV477W+Vzw/tea5jNLtHr
	 39YA+NUdKZXLDf0XOZxAwJvRcl+FnA9dqbHAhtSsDWj6EFPAVYPihJpTDAUUdOvfI1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795788147;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=U8/9oIG+8sAQkd9NKPh01lLwLEjZ+7d2i4X8779Mvh8=;
	b=aRAMeJutjn9aM5NP8sNeALnW855vmmZgzL28fAkU3iUpTwZlf/EGxNr4MJwKKP8IbTfq
	 FylkUoX7ltrYZdAO+MFWn8BfX4LSlIc6dM9bUJExo1pVx+xtwusjs+wsLa+JcLTr7gYuT
	 zKl7qpmTxyW6KAtXkbutCBHgcJrqISwhSCJrl3fjpYdj3xbk5N7gjjTe/B2oa41UqoJMn
	 T4RZsY0y6f0+kKANBTRVPcnQM5Cx9I68DWGqdSWTQlNxDsRbQZqfxeRnhQ/nXcEtKM31u
	 mU/rlLsVZnT06yVyCJAt5GFWtY+qXv1TAgNo9jZo7cTuQ7NUikpKYEt2v0sr/SBX4tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ocOcG0la;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B242606A33F
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 14:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B242606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ocOcG0la
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3b54096b2d0so227152a91.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 06:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795788146; x=1796392946; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=U8/9oIG+8sAQkd9NKPh01lLwLEjZ+7d2i4X8779Mvh8=;
        b=ocOcG0laWamqXte75VBu2Bl8SVIbTOoreNNpbg6p7MG6VDXU8ybmJwDjmK4oHYQVvl
         QVxaweuJGjC6UMg09lU90PW17WGtij8YrskGdEpavWhf+zZGVSO2Ls+ZI2ntB4rbDnYN
         e2JcaQkY5aYdobyAFQJcIwn5IGZGWYsml2LAi0ZhV14gmQPery/qLQOEQa0zoMtmnJlq
         fYkxPqVtHJkpFkPKj7c4cJTya9zpQnnUV12THyL9fcQXLF3bxr/MuzpxutYAqKHk7WON
         YFnkwQ4L/uu98ErRS7f6rIBVpKGEJf8AnrfO5Ezn6Z0pFNIYiofT6EtyagILkMh7+YTt
         ETCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795788146; x=1796392946;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=U8/9oIG+8sAQkd9NKPh01lLwLEjZ+7d2i4X8779Mvh8=;
        b=J/r76DxDm9aSKhYv76lI17rSTcdOwV0yZc5I7j6ivzsfFoFa0LRhpZUJpUp8Uok0Gf
         WiwKNzujrwxE2M/wxJWBTKh6i9Dmve39C7MQRNoGYyA8gpD3H2pVGgWjZXYCghIK8GBf
         uweCfhzt9GDorrr+rh3wYmWaAPkVhw+5Y8e1P5yych+vW8TpHcJGvuhkThvZnsdtAvZd
         sdmbnXNW8Sg+towIbUgGs0vORWo1kM3Tsn1sXgEBvfsxGfJzjXkS7xuJJ+80QrxOxn7j
         UEMDV0+PKz5YCpUA00Z29D5mkc9NlUDF9bSqPT7caVSvNGeZWIamrOX/yptdw5eQ5JSq
         oMYg==
X-Gm-Message-State: APuU4Z9CSSppFTYvmrwGAdfuYYOaGpjIMn1Af+FecpLh8HkWJKOESreG
	BWHrSknwo4U+iNkCjrHl97Db5duk1OaX5y+2tPXU5lyRKucuV3FYGkLADAtXCw==
X-Gm-Gg: AZFdTZcMJ01hK0yScEzyZRsNUN753PxahBBS4mZN70WxNUv75adk8f7R0EgKaiEJ1QM
	7BsmixTyF2n5KURsS85mUnstwAaTEhC1mU+8E+TL6zIsE6zEqhIY8lsgFinDWFFDPcu25RqOEzr
	apXMoQD8cS1u9/mJCDGCN8BwqCLHu/m9sUV36QsIX1PCIDXf4YkNnzkJkA730F1QWBWpwalJdRS
	zrsBUUNHx8JF82+P4IIpZkLhjb7Hc/of9rFdbgURcxEt95bVyTxv5/4dcBPMlary3HbCulOiShG
	EhaFiv/jPOMGhsB8ulNp0rC9VzH/HNONIwtyb4T0Rll3xKUkw8IX5zcdBe6ziQT5RfT4tZD/MdS
	lMDeWYxzkczYoVBBKzoCwE5b/8JaZNarKkfSjx2QEQLh1hAhJYYzAJ7sf6vcJDJ3WCP0cM6gZHm
	dYcWa2cnUtAjSD23ayGSRkZmZTMaArEtJ7NVXU2SlLvaSaxAtJbpvg7G2SO+t5NsyjTAEGY3bBU
	cU29496rAyJRAKROU0261rysvS0MVYdKV4amcBtegSn7rSExHq6qNRo3CjUNNXI+ZaFlD2ZFnEs
	Yij5RrMB
X-Received: by 2002:a17:90b:5546:b0:3b4:c66d:2633 with SMTP id 98e67ed59e1d1-3b4c66d280emr14874945a91.62.1795788145548;
        Fri, 27 Nov 2026 06:02:25 -0800 (PST)
Received: from [172.17.0.2] ([20.125.55.145])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b4afeaaa84sm22597707a91.10.2026.11.27.06.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 06:02:25 -0800 (PST)
Message-ID: <6b098d71.90a8eaaf.2f6f2.b3e1@mx.google.com>
Date: Fri, 27 Nov 2026 06:02:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8138747986679100023=="
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
To: linux-bluetooth@vger.kernel.org, chandrashekar.devegowda@intel.com
Subject: RE: [v3] Bluetooth: btintel_pcie: Add support for paging over DRAM
In-Reply-To: <20261127132114.3481678-1-chandrashekar.devegowda@intel.com>
References: <20261127132114.3481678-1-chandrashekar.devegowda@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8138747986679100023==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1224490/

---Test result---

Test Summary:
CheckPatch                    PASS      0.91 seconds
VerifyFixes                   PASS      0.06 seconds
VerifySignedoff               PASS      0.06 seconds
GitLint                       PASS      0.20 seconds
SubjectPrefix                 PASS      0.05 seconds
BuildKernel                   PASS      31.23 seconds
CheckAllWarning               PASS      35.20 seconds
CheckSparse                   PASS      37.58 seconds
BuildKernel32                 PASS      31.33 seconds
CheckKernelLLVM               PASS      35.08 seconds
TestRunnerSetup               PASS      757.36 seconds
IncrementalBuild              PASS      29.62 seconds



https://github.com/bluez/bluetooth-next/pull/1244

---
Regards,
Linux Bluetooth


--===============8138747986679100023==--
