Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9CA18AE3
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 00:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784851279; cv=none; b=G1VOIdACkmACxvRWe1yQWeIXBj0xQ9EuSJvZP1RuP1D45KF++LZNlzWSdVFnY4OgkT+IjaFv/Q05SWXkuhZxc0UHuaaKqVqqohuiYqcXxyq57+tACnmURj9amDiPrBCpOem0cfoEBisgVZKHW4T1TIcy7NgXSHiXiDHigSo+px0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784851279; c=relaxed/simple;
	bh=8ZMp6tVXob0AiNHs/Byci2tQIPbyu46/rnF/G3Sn4r8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SjDhovY10Tg1AISES/dVdEOWsVZu704DPl+NKOEXe/3UZTzb8BsmN23U8+xsU9FFuh/PRDiDR6RuXPROw2jISosfmmbBeCpg7c63cjFEY0X18cbRF0+IgqLPP3H96UuJ+hzEaFdstxq2VJ4KswVo8Cax7Y8v1ZGQFwyyXgqIpQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pjmk29Lc; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pjmk29Lc"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92e5c92c389so97629185a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 17:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784851277; x=1785456077; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zFWuZ86LJsEfIN+bMJTKLHl+ihxz5c9uq70AAOfLZ2I=;
        b=pjmk29Lc1uc0ulkmkrFOG4JOvOgIJvfaEkVWE/vVdYs6baafuEa6moeSTl3xtCpIkF
         oTeWj3n7hkrGYL/ojGt5CeHTgOXLHz3DRVGw63/dQlCzEji594Q1rumPl3ugL7+Q6ANA
         vg78p0oQ5QYxTLxl+rwkMYQwjuIF/eZjbN5PZqNdyDL9pG5vOTHe39+9bxN5mBDozpOU
         BFxcxnPnvG89aNasf/WPRiL0hF0wSzna3sJZaEbymUBa4XdQRx/WBhdrt4agGpyB08dK
         iS4p2DrH50NC1IBRdSVEDpJ8YlGGQ3uCWKLlmdlFJxF17DSaXtTxEBRpYUdQLB+7zEzY
         6CRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784851277; x=1785456077;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zFWuZ86LJsEfIN+bMJTKLHl+ihxz5c9uq70AAOfLZ2I=;
        b=KyxUeXbICp45DljjWRdRRbk2aQLIhWv611RyGciESfwBT7Y1OKJLPZeH7+/Y+gLgri
         3gSgY3Vre9aWidRyUBRRR6YAaBOfqQIUJyCUWmiVLVgfPOmmpPOxWupyC4cGt8kMjYcM
         i9n2a1YO4OZe+Cc1p0JMbkExrc/0S5oWxfKgrvQuBZ7umoBWifygvPxjtP/XBHS+/5bI
         BVeYKyxaYdUH/1QAGlOjQ4hGHBHjrABP4yxgJkoBHxt8IFLyBwllgjhvFkdo8h38VYzV
         r3qEaO/NhUE6u9KKB1JqaTbdthQS74GZnUFZXCo8LIQU3o3YNNjD1ChtJRvQP/pjzBRc
         vvfQ==
X-Gm-Message-State: AOJu0YzzyEQtdifxLVrZnBaen9pFngzQMPCi+ZqLVwuemomYnD/KB39g
	aXadoayqnwYB2M9F4t5GEGmLuKRCSaTNkBwqQAqwc4ZK0ooBGIvN0aKAZIgh3Q==
X-Gm-Gg: AR+sD13zOBZs4Ka5Y+EUhCaBFhKzuPzk7oD7JaS4/YdA9dpnFtMKl/uEVJCrU7f7QqE
	CdC3JUbd/zlyOPzWQRWZdw5WUkLF0Ws7VCSPmiGInVGAzBEggZHmVZLdJqKWk8uty+9dYhgLIbd
	JJ5w1eRFbod7pYyQDf4mhwE9ZqaErPH/8S/Am+eOzzhSesfJs+t9h1qF130R9EwYHbLJaOz/Nyz
	usLqSB/3n/Gr5TpoAnqZzaZaW4CfzCk0nbOlZ/+fjbLufHC5AOqn7jF6YcX5pu86SU/ak1O77dW
	S+NJQ8NUrNFWdhe/bHm6ToTfhh3OmidKQT2G/1td/WMvhvSm614UsUrtuuEeV0tk0NEdjPGUsOx
	QHtR577ucq9KgqY0SX01UY5EGL31SzGK7D43zfEYtqhdaUOAw0npecb0q4gpzm/en2kjXbtOfro
	yyN9EVPfQCWz0nmmAvqlwH
X-Received: by 2002:a05:620a:7117:b0:92e:9cb3:3f71 with SMTP id af79cd13be357-93103895366mr602401585a.36.1784851277361;
        Thu, 23 Jul 2026 17:01:17 -0700 (PDT)
Received: from [172.17.0.2] ([57.151.122.146])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930f68a8b16sm534609285a.12.2026.07.23.17.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 17:01:16 -0700 (PDT)
Message-ID: <6a62ab4c.5cacff2a.cfceb.0419@mx.google.com>
Date: Thu, 23 Jul 2026 17:01:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2983884683554318127=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, qwe.aldo@gmail.com
Subject: RE: [v2] Bluetooth: SCO: give the socket its own sco_conn reference
In-Reply-To: <20260723232902.792805-1-qwe.aldo@gmail.com>
References: <20260723232902.792805-1-qwe.aldo@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2983884683554318127==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1133573

---Test result---

Test Summary:
CheckPatch                    PASS      0.75 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.15 seconds
BuildKernel                   PASS      25.23 seconds
CheckAllWarning               PASS      28.01 seconds
CheckSparse                   PASS      26.67 seconds
BuildKernel32                 PASS      24.81 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      461.05 seconds
TestRunner_sco-tester         PASS      31.22 seconds
IncrementalBuild              PASS      24.43 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/486

---
Regards,
Linux Bluetooth


--===============2983884683554318127==--
