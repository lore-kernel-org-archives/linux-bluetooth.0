Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795387631;
	b=qLnxVl8vawXTJTdkMKUESbQVg3I9S/QlLxh6p1QdJbqMYwF3HqsKOjaqRQDGh5A9nSbY
	 Td9FiyrA+vVObLA3D8O2JZ4QXY6T0P0GYQYNewdIS41MVWbfIAf7xZXg1jKg7V7kyB0x3
	 ulEJwmuC7mvufO7vBOlJ4XzoRaOupoNCJ50/j5/q6vXTcAZgFJb7HgglyBgszAfV6Jnsk
	 WIIZoVTlP6WJxr8y62pGqDJi8XS1Em6A/siJAkuRTwxrbRc7HtvREOFGdstE5lam4L8JO
	 Rl57O0JiQyM0SAX/sFWJ7xaTD8lZHARPexA3lTRxS3QMSSdkHQte3tED1c/oZgF6Hcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795387631;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=icu97Exo02pVXFvsv/IIbx/21IDbDjbI1PHQK2YA2OU=;
	b=WSQnJXVnaH0WZ2TFUzabZLVccYYUTaXzuczOhAOiPxO40V1OgwUJoXamMjgzlW7rzlnO
	 XIBCredbHMNH5xCpAUzOpqRM2aGOVyakKdRQ5Md65Opw94mTXd93F7UIe+xlvD6JH8fwe
	 9lN43S3Vw4N8RGFlcddrWzWiIPzBGyJmynrVssq0lGX3h+bAxHJdWS1ANix6a5xJROmXr
	 OC95u60PMX8wvSp6g8vtzkjd8A/jbS5fLyIgw2yH9VsIJc/7rU+C1HP6w/wu+sYjeSh+L
	 5whuDejy+ST3h58ylB5fQYSHa+cCu50z4dL0nybETOD0wOm3qNxSlSpGC+NGdjXJByA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IKvFOlj5;
	arc=none smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550C8606A31A
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 22:47:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 550C8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IKvFOlj5
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-55d2f5f1e26so32523571cf.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 14:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795387630; x=1795992430; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=icu97Exo02pVXFvsv/IIbx/21IDbDjbI1PHQK2YA2OU=;
        b=IKvFOlj5q0tMFvcJLIprH5E3BouiiteMV4zx4tzdJLudrpuFtx65Hb+1YTg4+jtvKQ
         9ScNfYASBE6J5iTq5dcNjeP9attdE9afTnFfi0ad+o25mAZQXYvJK+lu1+0KTpZiWf82
         MdIUTeKbLhRL+7jJulem0D3St9g55EkIegynx58uOzquEwe247NqGeNlmGxLBHSMN4kU
         sbGAPpyW+Jr+37Eby1X1+SSYTSQp0VSJnu9meOlObWcMug1pH71nocASUTHFtXG8gkF9
         KBiIncFHS6Co4yC8Bqk0FA9UaNikLQMjIE526olFLrg4e4IacWUihEo2ZMzp5o1LWtOn
         9cKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795387630; x=1795992430;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=icu97Exo02pVXFvsv/IIbx/21IDbDjbI1PHQK2YA2OU=;
        b=BV4NLBQpkVYRJJ81EtWuzCf73lqJ+JmOwCH4CZ/HXWCJ7vtQeDb1SdAdDDXSXCVRJM
         cAcWF+8aFHz0fOV65tXYqU57aTK/goOfOnqJqJw6v1JE0AN36D5Ta9lMITkdYIzEZrid
         SkL80k4ZJgabHzmbxB2sv8xVLhmFT8eiK7s9ffrxr0KOzQS3WyY+NPdMs5M6z72Nop6t
         pPcyq3thlhK5G6iIvxrR8t9wfO8/nev6nn2L/WxMYZJn2+bCXdH0wtSuoQfQoyjvixq7
         vcVG9axVD+o22YHH17dhOnkw13/Ye51BNS435MSjuiyZbXUje39idUN6C4xBv276VszZ
         7liA==
X-Gm-Message-State: APuU4Z/eQEvCotcu30Wf8G/wDMF9krqEqhpunaApxWMlvKTn3lSVCAhE
	peASkRmOHQuCXfUzt8/vwkGjGs4Dm0zzeEq0f+B372tdTrdIyjw2vm1Xo/7qle7w
X-Gm-Gg: AZFdTZdRkQ502IGSPFmzq5shXyQmvioaNQmjGbOULnq5tt3IakfWSrxB9xVmT+gqzyK
	RUG5VqeoaMkt8tLLdqynvMEDYhzFWHxIp5nTJwCEJNABi2gHVW3i1321WTD/h7ivFHp01wLll3c
	rt7WSgN+IhoB0aHUzxBA4FORdEciJAgOgYcf+g0ZIZbj6mPZjIEMcByqfZF90k8OedSmfp/mTCD
	H6ZV2VPxclROiDAMBqcxfZkiYkImuT56l7d9FlpqX76ihclpm4jQddnwdqQTM+kvZHyAq3AJyPB
	aJp4/4JsiCw05NJGNEn50m0+8fApGt3Er00njjQQLtyynsD6DmsY0+5mo9MN4aP0FL13vJ/DmZ4
	JqsfkCbwsO36Pp2aMfRUG6ZWXP4Jdd15CVg6Ip40dsLVKOabyL1b+FR0XXxqE7T+Mq1efa9twov
	gGSyyrAipOeKIxyT1IdFDoHVDH0bUpqiLAyRpH3L+Hx2vp95ZDnK7WtrYTE8PvxGVbaHmCrr3PJ
	ooKkykPQaapq+ieje+CkzToejfv2W7MFc/7IfNRey4X5ZFiqaPD/ic/3PAgGbBjlD0dl5S8URig
	lch9jUGtbXTWppWvQD0qGczhsxr9Eb8=
X-Received: by 2002:a05:622a:98d:b0:55b:ba5b:c60f with SMTP id d75a77b69052e-55d76ac73e9mr161770611cf.64.1795387630199;
        Sun, 22 Nov 2026 14:47:10 -0800 (PST)
Received: from [172.17.0.2] (ec2-3-41-210-138.compute-1.amazonaws.com. [3.41.210.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349b50besm87653026d6.9.2026.11.22.14.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 14:47:09 -0800 (PST)
Message-ID: <6b0370ed.7359ca03.8f69f.4860@mx.google.com>
Date: Sun, 22 Nov 2026 14:47:09 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8944529162777061605=="
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
Subject: RE: Bluetooth: hci_sync: Don't filter duplicates while a PA sync is pending
In-Reply-To: <20261122201328.2852883-1-simon.mikuda@streamunlimited.com>
References: <20261122201328.2852883-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8944529162777061605==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1218948/

---Test result---

Test Summary:
CheckPatch                    PASS      0.58 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      21.45 seconds
CheckAllWarning               PASS      24.62 seconds
CheckSparse                   PASS      26.05 seconds
BuildKernel32                 PASS      21.38 seconds
CheckKernelLLVM               PASS      22.03 seconds
TestRunnerSetup               PASS      497.75 seconds
TestRunner_l2cap-tester       PASS      14.24 seconds
TestRunner_iso-tester         PASS      11.88 seconds
TestRunner_bnep-tester        PASS      3.20 seconds
TestRunner_mgmt-tester        PASS      85.27 seconds
TestRunner_rfcomm-tester      PASS      4.44 seconds
TestRunner_sco-tester         PASS      5.49 seconds
TestRunner_ioctl-tester       PASS      4.54 seconds
TestRunner_mesh-tester        FAIL      3.45 seconds
TestRunner_smp-tester         PASS      4.37 seconds
TestRunner_userchan-tester    PASS      3.23 seconds
TestRunner_6lowpan-tester     PASS      4.40 seconds
IncrementalBuild              PASS      19.38 seconds

Details
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 2                               Failed       0.023 seconds


https://github.com/bluez/bluetooth-next/pull/1193

---
Regards,
Linux Bluetooth


--===============8944529162777061605==--
