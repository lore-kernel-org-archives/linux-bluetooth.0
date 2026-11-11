Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794421378;
	b=fWW1PzQkiyy29rPVo+0QvxYXef+WHFfnKYny/wAcsrDQrpN7UlwkXPVEWj6gZgcg7tjw
	 UoGK5LULR+izC1x6LXheOMnhtBEjkkM/vcKDMKchs+SGs3H1XUfWvyzINLtrxV/T/oTZE
	 nr+Dv41YdHfy8FOPzT8j9wfCu4Rww9whWk8Vs3fhBGwRbQb16zPprxzdU/Z2xsPFiFK/X
	 DD3WJhKczE6KkaENChw3e0D3uVi1QUPg5ZGFBKeoS3cPpg+fz8BBZSqIEfS3+ylxgaw6a
	 1e4nELtXRbERDsaEdMOuuIcJGJAgAnTFDOS9qr2fuWPkzl2qfP1NUmykoHu2cHBCeTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794421378;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=bBfjlO8hViYBB7rmWosPiwHmreGuDovZij0z6LtFiK4=;
	b=NS6g/eFjcWDmhZaMm5nlCkBh/nZ2I9PSf9RaHmeK4cashdUfYrNi9UeMXWglkyQEW8vO
	 BNnMqs6/+DCRjvZ5gXK/XgBdWV0R0Dr35EZpZ8EaqUzxM2R8jnT/jlaPG+WP7XC7Fu0Oc
	 mkU4uN4WtTRSotWwdSoqxzHeMiSBXVwBABZfLW2sSarLzEPxKyWwR4xE9p0x9TQ0dmdX2
	 blRIp4cJDJHw3qLmi2RkjLmbK2VoVSCgKqOHMdWArPNMhHdg9n86sgO8BZt2ZzOqulLbs
	 DHkriyHpgHsYnVj33rZYLPXhPcy5ui6MROBzjnT03O6qy6ISEh7dOpvLhVWd226ynUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XcvahmEv;
	arc=none smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D19606A897
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 18:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68D19606A897
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XcvahmEv
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8b33de9d2b1so28427557b3.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 10:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794421377; x=1795026177; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bBfjlO8hViYBB7rmWosPiwHmreGuDovZij0z6LtFiK4=;
        b=XcvahmEvg+c9svH5jgQz+37mvTafHL0nRpYSXbJ7mEJ+0uYlZA1KuvGmu+ay1lp8hA
         o9XQ2YvaqBXx2wKpzz3SBLre4o/wx/upWkRv8MaRmVumQqSYif1sIQQOskzQtSc2NDYQ
         2lZ74rHjt3zLSEWoC1ZAWUti2txJgm/Quy8g19h9l84qP/ql4mjXacLBdojO/pwLeshk
         RnS82bU8NwLysPrbae3IwuLTHTua8xY2zgekEKXocyYssIdWJq86dHY4oQ7QGfOO5Jia
         f8A/BW2xTOgYYcrcMcDUGR/p2dNO17759az6NRoNhmop7LpsOw8IuBpUoWOv2SiWQZZl
         A5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794421377; x=1795026177;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bBfjlO8hViYBB7rmWosPiwHmreGuDovZij0z6LtFiK4=;
        b=wvHug6Jg05/stF4IkQsYLWiGoQcznlCREKCALBRtcQSP/vr8F2XrfKiOFewR3EkCIR
         2vX1WpjY8m2ih3j1Leaf8ZpXJ6NRM8GNU4I2Qztp/tkz6uD+YnmyX0nnp+wjBU6WikDg
         VeTcBoQDWGlk2E/jNKzZRaIgVOW3ogNbRo4IV2tY3GmUuLr4FTD93+Lvu1mRqF0XgbFD
         cyABcg+x8hvQotN2bRZRW0UEUz4rwfqKamEjQ8NEqM2Y3kqdOLicWzTgmslvJFOdY54E
         p7NdIXINfIdrYjmMFL9WGyhnJ1hHbkyWmv3KWYRCrqMvoMlo7qdgbw14MRyyB8u8p1Ra
         Wy6g==
X-Gm-Message-State: APuU4Z8smheQUheV+4VHYahL2k6VyLoxJKcq6S/pQxN5CJ1529OsdFDI
	LVjFDOIk8WXTeK9MQMEH1xw3rKTPe3bYLD86wWkqTQYGvxi9miaTJZK63HN4Aw==
X-Gm-Gg: AYBFou1iGZU3hP5chyz2/NQQRNwbb7Qmy4+eEaxnYIsM0eHSm0jKbqVOYkUyCENruII
	bxJDSfW/3QOiFO217E8Wi96QTOIavXWnJKOPIjQ/9PZHweie4D+UhXiFarTm911gWMOq01zRnG7
	CgI/ppz2QGRL98xe1cLa34Bk/rEnPgcNDx9Cc6zf2ZBubFGHkFcCZC+cKFHTmr29ZvXPkEawxJ1
	xzsdZBq7rYowsv3iQTm6+l27W5fIO6Kb/JTAxIuHqG6XMj7IAWCEKr34IHu/IVWRA7YUlDzrwqJ
	nLJd4IACJ7ADf30XfBaDX5cFP4zN6jfTtlWl3GM7RIeTAiZWkDE8OdvQVijl3+ClYU9UrcaZyVZ
	nzwNFwOkerhZGxLp3A4t9XuyJa07k/ETtx+ZOhJWWxB9SW07LYeq2T4QAVfGHAm3csnFthwxYC/
	zw90PsXN+i95pmvQV5Tb8DJlroxnCbbLbwfG1jnwzueyhbG/wGO8XDZIqzffvlUM1T3S+r+Irkf
	t5VGmfMMi38abnls1JOmhNy9uNjQp74BJuvukFXNKLiGzotfGSIMnLqE4TPrEA=
X-Received: by 2002:a05:690c:a:b0:8b3:4f53:91d3 with SMTP id 00721157ae682-8b3a7e00428mr23144547b3.2.1794421377348;
        Wed, 11 Nov 2026 10:22:57 -0800 (PST)
Received: from [172.17.0.2] ([51.57.160.116])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b39324bf79sm50449017b3.2.2026.11.11.10.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 10:22:57 -0800 (PST)
Message-ID: <6af4b281.f7170636.3c3d20.3788@mx.google.com>
Date: Wed, 11 Nov 2026 10:22:57 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3754639224287337585=="
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
To: linux-bluetooth@vger.kernel.org, dev@deq.rocks
Subject: RE: Bluetooth: hci_bcm4377: resume after ACPI S3 and ASPM
In-Reply-To: <20261111120248.21062-2-dev@deq.rocks>
References: <20261111120248.21062-2-dev@deq.rocks>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3754639224287337585==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1208302/

---Test result---

Test Summary:
CheckPatch                    PASS      2.07 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       FAIL      0.97 seconds
SubjectPrefix                 PASS      0.37 seconds
BuildKernel                   PASS      29.34 seconds
CheckAllWarning               PASS      34.19 seconds
CheckSparse                   PASS      35.98 seconds
BuildKernel32                 PASS      28.97 seconds
CheckKernelLLVM               PASS      29.41 seconds
TestRunnerSetup               PASS      705.85 seconds
IncrementalBuild              PASS      31.45 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2,1/3] Bluetooth: hci_bcm4377: treat only negative hci_register_dev() returns as errors

1: T1 Title exceeds max length (89>80): "[v2,1/3] Bluetooth: hci_bcm4377: treat only negative hci_register_dev() returns as errors"


https://github.com/bluez/bluetooth-next/pull/1111

---
Regards,
Linux Bluetooth


--===============3754639224287337585==--
