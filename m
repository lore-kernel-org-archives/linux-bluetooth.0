Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEFE4C10C9
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 17:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791826950; cv=none; b=GUul+jgbFF9fGNyLxlA6T28KvjzuZiAxWTaQBBWFWHY+lPg89CqKt3TzDRB4m+Z9AxXKLLorhmUtRAv/4eJh7Gq8JTvZB4UB8qYmI8zFuaiv0hw+bmVvnqyLiWiC8I0Cgod1Fmlyzmc5TRyGlIjyFOFJdJuhiYQ1q6l1TT8NMk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791826950; c=relaxed/simple;
	bh=VoacdG2ykV2iuinuobFkoMM2fhYIg1vcfaA0N6V5F/4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gVBHjTJ4cua0/skPD/encQEEKJhj645MCwgzCmmzihQngPN6YRCX/6GrqETVddTz05ZGOPrmFgwt85OrZQEg6anyJ1jmfJq3GvuQnKckHNfqRRRB45K8Jm4Kd29TKmAGqLFoe7BqVhlfhWEn8SVfy5Pmhi2GGhZO6InezynNLKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m7b0ZO1U; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7b0ZO1U"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-33e6279a1d7so494523eec.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 10:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791826948; x=1792431748; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UFeyw4j+Edk1WYjuefPI6LDCN1odyAyFrpHKTyUfv98=;
        b=m7b0ZO1UFgDHw38M2zK3sbK/8SNBNUNQLzbGnaEPyY2c2tEX34UxdmxYGbjaYlPoSO
         +PsBUZNvuEvTrTavoVqDwiUOjLH+AbB19MirXOcThSsdqocRTPFDtt9+XzoII33Zd92S
         +qlRzRUg5hCX+/Vgb6akFjH4/BZDoCpKZpbtcmTNoUr1FvD4gtjj0TW6qINlvnmwsEeg
         z/R8AtfkFbnQ4b+HvgSslld1gzBKU75092N8k/adfyogmQRYCvtr1ilZ0VYuZ9LmkQ50
         YEKIZM3JEWjKUv4e3/QDKDYFuS89UH/ivS2O5udgNtEn73A+NoJFdzZTBKu6bN4wtcCz
         K4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791826948; x=1792431748;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UFeyw4j+Edk1WYjuefPI6LDCN1odyAyFrpHKTyUfv98=;
        b=T+rL32xOg7c0FlH/HxJW50Jf1XaxyDeJzhvHfw6Gb0z9cWV6K07xJlJi/0OSO/YzMT
         ooLrrbMFO/qUbP4W0QTk75//WZJAxUk1WwbPJ3Coc5JX37P0ksrhKaA/6sF8xEZZBvZA
         7Vx7asd2S6gqfc1kcZxL4MklMWScxvLGyfRVZrRdAMMTf6n8yV/y9nNCDzabzZaFp001
         8+Hg4mcKo9xCnh9A9H0K+BFnur6sBWr3Y+2a8Ux9TUdnvdn9gr1yxJRPPk+wxrElO2pk
         7W4Vx3sRFjOWB4MA+2dhCrqw9YIlVQD/7UD541O0iRbsLAaNbAnbmtowpFvMxC2kHuRf
         kH+g==
X-Gm-Message-State: AFq9FYKiTa+ub66cWjTWzaNVg9o6jYIwrovqwKvAqygupC3YotqzXbTG
	bbfj5lNmNQWG3UvWG2eqayTVhyC7Zpef97C862AvACvne/g/R+haqxTfH4XPtg==
X-Gm-Gg: AYBFou20x+FLO1vCQL3GyW96ZWeKUA7lcSbRbU1FWnHa8uyD5QuF9O9A12ZeD54qzXn
	JMkllGr9nQ2QgC6w9REVf01YLf0bAy7lFDQ3u2EuswccJPMP2kwWwwy06q+aCeKHUY4hM+Littd
	wo6yyiFHoqaUkMoUuEIcjKRkyXAgIGYNYKj4rtgh+iOzyWFsMIz5YjZEWO2QRCp6mdjnSIq04Xk
	uHDjLqD71OzgJn9cuNCjHzTxvtN1CtSLk3KboVSVeOljC51x/XvfwHTFT4Ih7g/dkyQQbeYIncD
	62sj+LaAtcKjChvNq/PI4ZnAtQKVnK/smwS/l3jOou5g9s5g6eSnTpscMcQEjvR+i/RaKEbPh8Q
	KZdXvD8KgbX1uI7a9JMUDDLrFN+JIU7IMuysVxvRpL3TdeT204RjlKQlL+LfJ5ukovsvUT5PyUG
	kjAL6qc/H4lnqQUP1iGB3/kMGhTH4ze/rV72+LVON6UqdB2Ue7h3heQLwUG3RVCNDc09LM/+lTf
	Z5uwfRe
X-Received: by 2002:a05:701b:4306:20b0:154:e9d2:d741 with SMTP id a92af1059eb24-16a6187e53bmr13579101c88.8.1791826947468;
        Mon, 12 Oct 2026 10:42:27 -0700 (PDT)
Received: from [172.17.0.2] ([172.185.167.120])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a442956asm39329697c88.16.2026.10.12.10.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 10:42:22 -0700 (PDT)
Message-ID: <6acd1bfe.a0fc269c.cb107.72e1@mx.google.com>
Date: Mon, 12 Oct 2026 10:42:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5149959778171455608=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: MGMT: Allow connection rate request as peripheral
In-Reply-To: <20261012152803.66542-1-luiz.dentz@gmail.com>
References: <20261012152803.66542-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5149959778171455608==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1184009/

---Test result---

Test Summary:
CheckPatch                    PASS      0.68 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.35 seconds
GitLint                       PASS      0.22 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      30.97 seconds
CheckAllWarning               PASS      35.09 seconds
CheckSparse                   PASS      36.93 seconds
BuildKernel32                 PASS      30.21 seconds
CheckKernelLLVM               PASS      34.55 seconds
TestRunnerSetup               PASS      816.63 seconds
TestRunner_mgmt-tester        PASS      61.31 seconds
TestRunner_mesh-tester        PASS      5.45 seconds
IncrementalBuild              PASS      29.04 seconds



https://github.com/bluez/bluetooth-next/pull/905

---
Regards,
Linux Bluetooth


--===============5149959778171455608==--
