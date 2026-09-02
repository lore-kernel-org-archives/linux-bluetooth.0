Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88964A99CB
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2026 15:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364228; cv=none; b=N6B+ddLri4JBJhHiFgdNSySpxYlf/ZarEaat/XjrV06Zins0FunKeiIIytvPewOUncbJZIsW7VVWCDBlYEXH1REgiTw7VVyp5iCLcWYSUjachZxecjXGO7uOeR2Xud6AAfXpofRqgyZPk0zBL7WDtP6BVzLAgeZO2vd+4duAK3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364228; c=relaxed/simple;
	bh=yIOOygTdTCnxn1/2W0WEFw2h1GRuPZjxRHJ0Iv3iffE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dA9T+N4X+nyagh5J2J817TByJ0TiscwTrFtef0rrXKgimmw6O2MVNFtChO7lxTOzX9yJdDnZEsiX+OhJBg/7c2AHQiAfntfqctSniqZ+klq8rY03NiJkgSwAqrL9hzEMQWseRyHkdx3XEvXH5UJMVEl6W+S58UgfwQNErgpV5DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhRChCoh; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhRChCoh"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-90cbff85fa9so13210016d6.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Sep 2026 08:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788364225; x=1788969025; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qQfnO+ygqnXLe3U8lgJ7LbeAKEaihbAdKatN+qp6bh0=;
        b=EhRChCohBrb5oOtHxe8XR2l/ejwHpkq2aErMfUbFT0/bKiohPbRr1hglS1wc5dJod6
         R/K9oIAroiEidptKVgc7DXuq1J44zRjxbekbtJSfEV0g4CPA/kC+kp1IDqYQonjDimNA
         WdW0uA9OCM/X9qNRmBwYzUNVrM/ZSI9D0QkZL4s8KxqxbJiT4YGIOIWm1DpA9sRzNCJg
         dzzUwR1k14dE0Ctb/tl8si++ospVzhZNEEpwKsWfGxp69kxsONg89fjhyATkzR9rt2/x
         Q1m6WwOG9uFlpx1XOc00W2ODFr4HzePv2INVfN1XCG5waFXW2ZSAk2shIL96YfVuoeiC
         GguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788364225; x=1788969025;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qQfnO+ygqnXLe3U8lgJ7LbeAKEaihbAdKatN+qp6bh0=;
        b=AO8JxW43jvn0ieG/NQ4260FwN9lA8c2uksb8Po0GFYSI0XHEwRvG8ZEvmR3vT/8d+J
         uWJMPOnibsh1xpVH0QsO8rUjqnRKO7JNNt4KMi/zaMvV7aV4HZncoFcngdphCBxyT9a3
         gd9qNkWxCKmxR2hyd8lswGa3fs5+drkvq0Wy76YB6Z0VY6BRWcvCIamJbm223RKYiQJL
         /K8610LCACmrJh/oIM0ShNqSgnLCLQapApL3qJ2xdimYk6TjWuWn4zoAjnHZRoDoST/H
         jTgevSvOaFbJz5hHNb20g9js82XyFa1s7M3uriQY2DiAYQpbd9Gm3c+84qZ8buWXwcR5
         HgJA==
X-Gm-Message-State: AFuF++nOFLxqB98qu6zfK3HDsB1NCZwR6v3HdDeUbCTbUD27eYECRG5Z
	//SAzBRNDHCJHg3JcHKKeZh+GusEscxcfKl7Paug5sWRGKrnb66QUcA7KDD11A==
X-Gm-Gg: AYBFou2vDdVhQMKzzjf32P2WXHrCXojtbA4P7mmjrP025DHzTW3IlsNBTouLniN/3zJ
	yMm96dIs+xFnlxMuxfGO8LjOzhvDXILrDzlTDHloDfiYZvqt0SP3sVQ1biCibXYsNFNuDCOyLCg
	/vKOqsD1o77MAand3804523OutDwFBJ7k3myiiHNoBfp3lnGaXuCXcWNl7c1YBymJuiQApcaeCk
	U4w6uPDQ7f2ydzYwMjJMpLbD9HVZnUlYaOb6qfJpo4Ys0nWxqy1CfVkZnLvrZHy7g22ySpCIRcv
	+e6orWcq7apw3/TzYSVOcE3GioaVvBP4fGGT92xZD6pmgrIC+zm7SbfVd8o9jl3agLx7HxpzWlE
	esoHq4xhqM84wUUVmp0WAS1CLAGqA3u3N5XqPmeOK3x7WkAHghEisHeB9osoC/0incuYQYosBq0
	R26Fds4gp4N9ngXlbk1J12wHJEbB5ib4VLoeKVLzYx/AxDKpIqnxgTvZSUuC80EYSoHDk=
X-Received: by 2002:a05:6214:2123:b0:90e:9408:2fc5 with SMTP id 6a1803df08f44-90ebb004945mr76833646d6.5.1788364224954;
        Wed, 02 Sep 2026 08:50:24 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.45.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9eec85a0sm20960096d6.29.2026.09.02.08.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 08:50:24 -0700 (PDT)
Message-ID: <6a9845c0.63a458f8.298db9.4e99@mx.google.com>
Date: Wed, 02 Sep 2026 08:50:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7800773516433508246=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1,1/2] Bluetooth: btintel_pcie: validate packet_len before skb_put_data
In-Reply-To: <20260902131830.35502-1-kiran.k@intel.com>
References: <20260902131830.35502-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7800773516433508246==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1156173

---Test result---

Test Summary:
CheckPatch                    PASS      1.47 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.68 seconds
SubjectPrefix                 PASS      0.26 seconds
BuildKernel                   PASS      26.76 seconds
CheckAllWarning               PASS      28.91 seconds
CheckSparse                   PASS      27.68 seconds
BuildKernel32                 PASS      25.35 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      472.42 seconds
IncrementalBuild              PASS      26.78 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/687

---
Regards,
Linux Bluetooth


--===============7800773516433508246==--
