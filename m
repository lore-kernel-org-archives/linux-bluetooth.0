Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794394075;
	b=TnodOAhJuRox4yXyhgxif2GG1Wa/b0ipQGH8eK1aUBRBz8RIAklKS7j0cmDTbVdRi3ZF
	 EQ3VaKwW0I4KUZNrlXn3ywwYglJQkXD8IFaM9Icc/x4qG8VI+I0RegT0puSOsV8IgvXfC
	 qu6H/Vp58gw2glsWlJMS/6EjrbAfdgrmfLU+ybTVa/nJTXSlBJQJynxBRjSPZXMRQnRxB
	 S0eyizhwMWvLVnb3msn/ctF9Sx6ZZ05kJXMvwJXjSwZyGvr2JUQqEoTnu6zWk/QUzV8lS
	 yh5LHry2F4Lwxd37fYgooV/oZZUleBg3kjeQp3X96sU/jT0eApkl2rKf+05BtCQUDrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794394075;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=dt1/UJE78Nsd0h1APiKX4PRYEudCTKqPpLQVt0q8LOs=;
	b=KCcjZyD80hkzkvTcxMXm6pxxu4BBPMnp+SFnN3A/wncwpvfZqKyY8G9a71AD/x3NrpsT
	 D0c/QS2MKv4r90FYLei3zT0x7DreI1auccz4hCMAojfxrsL6AIbVN5rpyBQYL5Fb6JaTK
	 c2QgqOlSbCi6zNyOUA+lRMQJJprVAg3ZzmS+qcAidpObmGH4arvbLUba1nTayTMkA/wki
	 u/qcVTrA5wXKJzV2WEBPtwCiWOb9/kUmjaFoy155+2hw8ls10F5jbNduaa0mDHtbF33Yj
	 isxbbMaOed295axPEXTQ77aD676WG6maHv0nFW8Pk7Yy880pehMvxIXQKAL5KvO8mWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="H/aN3gwh";
	arc=none smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34AB606A321
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 10:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F34AB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H/aN3gwh
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-91c1f548f87so39558876d6.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 02:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794394074; x=1794998874; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dt1/UJE78Nsd0h1APiKX4PRYEudCTKqPpLQVt0q8LOs=;
        b=H/aN3gwhc+gVTmeysYk1r5jvirQJHKCcf40xXY06JxMUKHfBBDV0SXCHYmOSW3ZL0Z
         u1KpgQp0CrxWu1mFWS7SgyhDMr928A+afdeuPqBrLxQYDKswEleYKTbGeRzsDIWXlevg
         X4F6K+l5Dqp4ZjhehSKV9ymUw856d/zIVbjhhbwQhDucSwTPYt0IO79k0VJuPx43i2SB
         mt0n62eeQ4N9SR/ySnnsyjrckzRaX6coUXVFjPh9lrkA69N59precYYDoHTmbTnhnIUz
         sHrPT5U98TXlPNjO2MlXmy1qDQP+kzi8vJEOukNm1O0h10jkByl+eavu+6PJjJQ2iqd2
         qrmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794394074; x=1794998874;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dt1/UJE78Nsd0h1APiKX4PRYEudCTKqPpLQVt0q8LOs=;
        b=RSRKdjme0oT609C8FCkfRNoADpMyfiy/fUegxtiO0EBT6FmlEBPvj5/Uk9r3ajXBDi
         /Quy/IX6TjiczPwLehJafsmXheSgHSGdG6XElpso4W+LZrHrRrx2mFWT4U9pQVnRDTM0
         g9em021sSb624sEFR7lFho+nOYs0jlOZ92of30eIPBCURh+apPkd9TlT8dTSxSTL56Gl
         TvWC8jIayi7obeTC4MHEvJMIJnM6yGexGpJJKesvNXf9Zd32laiZlJSV5bm0N5ojuKuE
         8JeI8+WAKnAl/MB0usCzBUazLMz5TVYLOMbJX+j6O5aEBkwuA7RBuzuReAYPGkeSRYQq
         Qy+Q==
X-Gm-Message-State: APuU4Z9o9W0wF5dgIsEIHzAr9dRXck7rA37lZu5XKBsja9j0wRQJ4EJc
	RHEMiY3jQa6Eae6Rof3Rna9Jsv5l7EICRpESgEb4AQEXLmXDPKFSSPgCSRXkNg==
X-Gm-Gg: AYBFou2EclOOD5Ffqrao1GRRr2azBU8Z/fTjDJFRN3taKiAdfi6hWQMvEkVySGl0pf/
	Q2ZERvY0v8RVKoX/aXM50KvPRgOGc0sc6tyo+1ujXlNOE/p2MMWS0z0aDxDQ5PHVuNZOcfrORrM
	shJJgQxcj47e6nFpcwUP2w2tuhbbtTPGA9n6QMTBuj5QtDJQPHqPXoHWMhiRVIs+MBqzBaQqTEa
	JFlUEXGY2neLV4zDTb7kOgmZjyVkw7KG8EW3syqIji6IzZ4SOa8YVzUGX42XDbpxvwi8C6rm51R
	Pjxzjey4PxHism5VElDBABMLaGauXtIV3XNziYGY6o3mXIpIFg6dzvbwIj3iylu5em5Ysor+KkD
	Tb/0lbcioSW5BwMWuXpV8ivxADGMPmooFnCmeu0uoCxDUancKWVbV3qloet82VBkuKniBPyUpa0
	CDl1Zx41BE7W0Xrx5AijBw6BeWzgGyfbNMIfOxO+6zuYEUuAFiC/iipPE0NLwIQ6sX2Bf+OrGeg
	YA3OvPBMI5hhC3QtzMQ9nQVYUB/d18PC/8EqW6mj2kmmB8j8GbXCZi2zXuxeppD
X-Received: by 2002:a05:6214:4a82:b0:91e:c0f5:2c3f with SMTP id 6a1803df08f44-91f04001ca4mr31103526d6.10.1794394073708;
        Wed, 11 Nov 2026 02:47:53 -0800 (PST)
Received: from [172.17.0.2] ([48.217.147.163])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f046e418fsm17184606d6.38.2026.11.11.02.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 02:47:53 -0800 (PST)
Message-ID: <6af447d9.72406e04.244964.7e9d@mx.google.com>
Date: Wed, 11 Nov 2026 02:47:53 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7348066374705438460=="
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
To: linux-bluetooth@vger.kernel.org, frederic.mahe@cirad.fr
Subject: RE: Bluetooth for the RTL8852BS on BPI-F3
In-Reply-To: <20261111094557.443481-2-frederic.mahe@cirad.fr>
References: <20261111094557.443481-2-frederic.mahe@cirad.fr>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7348066374705438460==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1208172/

---Test result---

Test Summary:
CheckPatch                    PASS      3.16 seconds
VerifyFixes                   PASS      0.19 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.72 seconds
SubjectPrefix                 FAIL      2.07 seconds
BuildKernel                   PASS      31.26 seconds
CheckAllWarning               PASS      35.70 seconds
CheckSparse                   PASS      38.72 seconds
BuildKernel32                 PASS      31.87 seconds
CheckKernelLLVM               PASS      44.79 seconds
TestRunnerSetup               PASS      757.58 seconds
TestRunner_l2cap-tester       PASS      13.58 seconds
TestRunner_iso-tester         PASS      13.04 seconds
TestRunner_bnep-tester        PASS      3.20 seconds
TestRunner_mgmt-tester        PASS      90.32 seconds
TestRunner_rfcomm-tester      PASS      5.73 seconds
TestRunner_sco-tester         PASS      6.18 seconds
TestRunner_ioctl-tester       PASS      17.20 seconds
TestRunner_mesh-tester        PASS      7.54 seconds
TestRunner_smp-tester         PASS      7.40 seconds
TestRunner_userchan-tester    PASS      4.28 seconds
TestRunner_6lowpan-tester     PASS      4.58 seconds
IncrementalBuild              PASS      30.54 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject


https://github.com/bluez/bluetooth-next/pull/1110

---
Regards,
Linux Bluetooth


--===============7348066374705438460==--
