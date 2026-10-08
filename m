Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093003D47C3
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 07:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791446223; cv=none; b=kFHH31F4csyABmqVgKtxhw+LMsaJdvXXdjyO23A6dfOCQzQQbQTQL2OznzF3V70xyx8mUWTzdk9JpL20ibRsRjc0AMoECyEsYZyr+mcSwVmUmoro/1Qbr8ue5moUTARP99bnaluA9cEq2iL7uqZ8/xmGQ8MLLocCaHoj9MBj1I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791446223; c=relaxed/simple;
	bh=H6I630vxbQByYsuaU9/JrQzydh79zzENvp/WfhKlcA4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=s23mJvJZp3XZVGdSrDAweFlNn+rO72W9fvlqKr9ySgBSx09T8NPgCqNUybdqzAl/XSruuCvR4dhiibco6t1nJ0MUIe8lc5SCArMG+pb0UdmORtlpBZon+p74qWXaZrVOl8wbMU8ZcHrOqE6i8wj3EeOZ0wm4duzb7WouHL2AF2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOSvtzba; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOSvtzba"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3a4b9732d5aso2471557a91.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Oct 2026 00:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791446221; x=1792051021; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4cSxBKCEtVDCXxgYQ5M53m/LRc4nVEp+fpXyoSQywhI=;
        b=jOSvtzba/Tfchh/6sqANGY8Ibx56mjmjdXcSEBPo4TDQqHzUcSRzD1jaEfa7qD09a1
         +4MrIytwGXVNoz2PY9AVP4/HeoUhPquzoXV8nHMmq2ULmAyrXqJ2/guRHC5MNOgQc8gS
         33B4zIG/HZBtgGluSBVuvlO49RxC10AkQHyzgMIjtkUG6Hl6Lhh7HcRl/r0lt/4U6Ku7
         hdJYGmZ9LkfUxkuz3MudTGnc2+s2JKY8sQ/40ACgZ5/gELxt7jmaIOFC8/ofllmmSvcL
         cyCtKDww7KIUxIttiEmWurFhDJM0SZyVMZFPQdO45ziojpOXRyYmyXjfzZWJSNZla1KF
         1O4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791446221; x=1792051021;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4cSxBKCEtVDCXxgYQ5M53m/LRc4nVEp+fpXyoSQywhI=;
        b=V1paD6Rv0LpAncb0heTltYjPnu+CAOayxN588yGdfpag09HpxtCK3gps0cVdiQU/JD
         gjYsY2qMGSOrwSYZoYI88MEV9itUBxBiE4eGNhE+nReA0cgILJrs36o9CNTqWI4eRwYn
         m9jAqyHtZZCBruZcN1zMVL5NUJC27zFrm3SsdVbVrmOL/u5r0T3DH55fB+EGBZ328imG
         4PiItqW+8pQ6KtlbKUxT/Acz3xbTQ2JKOp0rNUvVNZR3Gs2WfW7RFar0SynWsP8XU57Y
         u0EwWKzE6cd+JWr7IdrrFSL+qD1Daeqkh+5KPtcy5wA1MWQp08VIzZQyEEq4UKU6eq8e
         09tg==
X-Gm-Message-State: AFq9FYKfMexWcDTw+MGGRtNKnZVkptea5lt38paW2AUEEh7YI91MHTug
	qxLRoeUE00dBxzyEylPKt7QOc4Ph5zVtR6oIQXK4aveDx16ioWviUMhEj4PYOUYu
X-Gm-Gg: AYBFou0KxEUpDyfMy39JxSEK1mRf+RAAgcCXJLH3hLwXPhNztUsQ2hQlMwEOJloXt7n
	2+m8Ruyxnj9T1QChZcoLYUaLhLhSntai7he2BTz1LbhCcbPU2qpSdhYMGAQtbY0qEMBgSlK1CHZ
	C8UEMQQU9IRCXyiQKQ3GVmwP6xL418gkjOWK9O2s9WFo7j3k4dG+gBZkb4yd0QRRbryFSaKFYpt
	9MYIdqN4c8We/gRqMH+clr0mXg1yGzQixyvSsa9eWNlgPcEzaIixosVeH1x0D/otJrAmEctJ1rt
	Vj8oaCI1wuU5q7rmGwproM8vJSHcDmQh9y/hMRjauUk7hSFyq3Dz2QH7W63f54nIp8NmykXH+2H
	QtfO+FkBHuJumJCOlp/Sxt9kxUTCiB5DuszypRAlyKLn6qb6OxLMQxZjxJB4Pp4xfGP8R2GOYvh
	/f48/oVXsrD3adivok/UTzegc9gveQOZfurRdGo7JU+bxLuAl1Hf63AxOJFt4rw1qDhR5QOsCuw
	sCKcg==
X-Received: by 2002:a17:90b:582b:b0:3ab:f38:2b46 with SMTP id 98e67ed59e1d1-3ab0f385364mr272372a91.35.1791446221269;
        Thu, 08 Oct 2026 00:57:01 -0700 (PDT)
Received: from [172.17.0.2] ([4.154.135.145])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a9ff8d5896sm3120085a91.12.2026.10.08.00.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 00:57:00 -0700 (PDT)
Message-ID: <6ac74ccc.969afe5a.73c66.f664@mx.google.com>
Date: Thu, 08 Oct 2026 00:57:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2897242171845932385=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dungvn2345@gmail.com
Subject: RE: Bluetooth: 6lowpan: Pin module for 6lowpan_control debugfs file
In-Reply-To: <20261008051129.508322-1-dungvn2345@gmail.com>
References: <20261008051129.508322-1-dungvn2345@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2897242171845932385==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1181259/

---Test result---

Test Summary:
CheckPatch                    PASS      0.54 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.18 seconds
SubjectPrefix                 PASS      0.15 seconds
BuildKernel                   PASS      17.44 seconds
CheckAllWarning               PASS      20.27 seconds
CheckSparse                   PASS      21.86 seconds
BuildKernel32                 PASS      17.87 seconds
CheckKernelLLVM               PASS      19.16 seconds
TestRunnerSetup               PASS      435.12 seconds
TestRunner_6lowpan-tester     PASS      6.95 seconds
IncrementalBuild              PASS      17.61 seconds



https://github.com/bluez/bluetooth-next/pull/884

---
Regards,
Linux Bluetooth


--===============2897242171845932385==--
