Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795388110;
	b=yyAFRp52lybJ53ac6XkN99c9GTdWMKouW6/tKkgweHwXGXvgdPtsJE7rk5QpRtxvl1HY
	 iJ/bscTJ06W1g+mv4QFi9aUIXMS+5TtLdHBJMkbbG2f8W7D6B4xNwvEbmx9mvsr7YBzS0
	 sw4avb/Zb1ULVye/iuDnN3+9zdvmNdA9CcsmGpf+MBZaz/WfFOa9Vl2d9y/Z+1C+0+cwR
	 mpOIdbz8U1JjaLhk3ID6ow2KRGFrmv7sw3v1/lCpRZKTunCgyN/0UZbaSWPoLC96kkgwd
	 aKrQHtM2y/cL9aWe6i62zRNQpJRr2wkIWVbUmMEEhSdFgnGvWHzlkQoXebJt2tTI2Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795388110;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=4ntunSQ8fOUiGcjwOQIQfb3gyi89E6Rls210d4CZCuc=;
	b=TmH2bzERZDcmzyR8ArsRld8ru3oGbQiRpIvex+yI1G03G1JFjttrpDQLHeZrY5WMKMqI
	 sF6Vk58upSDq5IleP4qQ8DIWa9qGDOc7MUf9pZo2+GKAUk5fCoPt6mwaeHS7QM/VP8cMi
	 /1uTdyQbL7QBdS6jIbREXoyUYqDKiJYsCT0ayWk3pGFKGp2zlR6oYquWA4kaafpF2lG96
	 L6Rqi8V/XwW0Ic5R35ZIZ6WdNrE/64C8chL5MVy7NRGroBZ6HKT9XAh9V8mevuk7H8jhh
	 W+D4lylQFQ1pGKZnow0mzH00sUEbfwEGg7uic/pVOdr9go8/t71EETDjpLRlw/mYHyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZDQSeF4S;
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3274606A31A
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 22:55:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3274606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZDQSeF4S
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-94961ed97bcso308265085a.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 14:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795388109; x=1795992909; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4ntunSQ8fOUiGcjwOQIQfb3gyi89E6Rls210d4CZCuc=;
        b=ZDQSeF4SZsiOaeS6BUc61vdAoJtr8cl+5IyzHEqJjXAXdnRpXhFwbLxvjLw8rmyC8q
         hrkB9EXdBdYlcFGW7k0YwqeJMxl9PoH3cWubx6XUk32bhIQp5jj8j3AjyleZiSTxxp0V
         sMHKmlCywaoqrg9iw+r7RMgW6x6gbqt/Zd+BHg20bGxMKFm3SLVgCAin3S7gPVWe4tNZ
         MBdZXI4exXxRcyhiauqAuQtmoAiA0Hf+Q1aAklvqbeAjW9I9OQgT5/2ubbZR0Nwoa3r+
         98DAtbvsPfkINQscTm7cZWY7aT2IKJbgv4hxlEIOk5G1l3pJsFlM9y36F+Ryyb498/gD
         dohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795388109; x=1795992909;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4ntunSQ8fOUiGcjwOQIQfb3gyi89E6Rls210d4CZCuc=;
        b=ERrhUwQ/4WoDrZSjC9lgB70HZ9syVzeaAGWJptKwf60uypKpQVGFa2KM4Qr6oeT0RR
         kRzz7rkS3IhBi1Eyvhr/HZU+cY52tlnc6xfnm0gWFAQJAaT4j2Ft3RdsqeeXW56WFq4a
         2QRTSVArOI6U/bz7yXnnLulSVvmFFCw0n5TAfA5wQpdI586L1CSVnZHye9ulrUPGU4EG
         MqcEKH6XJqwaeca8fAKRdlEO5rhpC+9e/n1mZsa3ksymaGVYuP6xqBq0sCGr2cVzQ87Z
         M87eU4ZEuov6b9ooN45+QmzOYuyVfB6tIFVq8rId1Di/PdIt10yZOk4JZW621csBcHAc
         bbjw==
X-Gm-Message-State: APuU4Z/lGBQcdrwvlmBjI69V0E91xmCldzPDU7XK7KCps4mxAaYMj1km
	FmtbigtwBggPGK1rE/qkFd9VIvaDXDnKnSaZI28ge4DlDsg9q2wrVgvOaL3SBsNf
X-Gm-Gg: AZFdTZeKEcE7XsnqOjCJCYqclXQJkYghT+IIFnq7FBMCI2BN8J37TOFxH9O/miir9Ta
	v+9RXzd6AK/y5zBi4F6hzGBijbfLo0BRYfceZr8D0sJr6Fl9i0Pcx0lk8V9lX/50hqnvU0eR5TX
	L01P4mzuF4Rg4QVkPOtNiMJXPrrx9IoAHTASaF3kzt7R3HKY4B6ng0mPjAJSveJF1ZMbUdBMb5Y
	aKsGu6uhmY7fSntKDQKwhww0zVmQwGzGxQ7kK2qptupkHlEna60fh7JBiiscY9bdfs6Uz6+WokW
	l8dloSt/kN2KQqvWPISQP/yLJn/fwdsAChvGbcOnwMKyte8gZ3tsEBnW50CA5qlUu7n+cLZcWfw
	rQ2Y5b2NKYclHu/6jhMG9SkulnIJgZoRY1N/LG1yeNQ2lsbkEFbIYtTCVC7FZHYwbXeCtCMib2n
	4X0soBJE0ccaOc9z5htP/3HnLqLxJGNjFWRqzZnGnLpsM6s4VoVYZZj6Ky5x6nshU4aeB62Z3E+
	qpV4zUcmpwG529/4Rcv4ZBeAKKhmzTMya4tezeFIEquj2FXmZSokt2HMH0uAe8m
X-Received: by 2002:a05:620a:6609:b0:93c:664e:e212 with SMTP id af79cd13be357-949ba9e83d2mr1478414385a.32.1795388108871;
        Sun, 22 Nov 2026 14:55:08 -0800 (PST)
Received: from [172.17.0.2] ([74.235.102.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb38322csm683150185a.17.2026.11.22.14.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 14:55:08 -0800 (PST)
Message-ID: <6b0372cc.154b9e68.25e3e4.97ee@mx.google.com>
Date: Sun, 22 Nov 2026 14:55:08 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6257032874515094496=="
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
Subject: RE: Bluetooth: lib: Map Connection Failed to be Established to ETIMEDOUT
In-Reply-To: <20261122200947.2780757-1-simon.mikuda@streamunlimited.com>
References: <20261122200947.2780757-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6257032874515094496==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1218946/

---Test result---

Test Summary:
CheckPatch                    PASS      0.76 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      32.33 seconds
CheckAllWarning               PASS      36.59 seconds
CheckSparse                   PASS      38.80 seconds
BuildKernel32                 PASS      32.27 seconds
CheckKernelLLVM               PASS      35.25 seconds
TestRunnerSetup               PASS      760.56 seconds
TestRunner_l2cap-tester       PASS      15.04 seconds
TestRunner_iso-tester         FAIL      17.17 seconds
TestRunner_bnep-tester        PASS      3.20 seconds
TestRunner_mgmt-tester        PASS      89.94 seconds
TestRunner_rfcomm-tester      PASS      4.55 seconds
TestRunner_sco-tester         PASS      5.68 seconds
TestRunner_ioctl-tester       PASS      4.71 seconds
TestRunner_mesh-tester        PASS      4.60 seconds
TestRunner_smp-tester         PASS      4.41 seconds
TestRunner_userchan-tester    PASS      3.26 seconds
TestRunner_6lowpan-tester     PASS      4.46 seconds
IncrementalBuild              PASS      29.53 seconds

Details
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 213, Passed: 212 (99.5%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect - Reject                                 Failed       0.042 seconds


https://github.com/bluez/bluetooth-next/pull/1191

---
Regards,
Linux Bluetooth


--===============6257032874515094496==--
