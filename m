Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792866068;
	b=anoEbDgccxoIuIxJgtyL+5538LuSTxtvB+lHlEvK72U0AQ9tEXRdHRmD9a2fDzeD1Xdh
	 nscAgApDitKgktqxk3OqCqx1K4ckgyxf/Zvbn/Mn7hNVf+dgx4RRhrDnTLiQmHWltJMDc
	 AObeyIcbCaP97WGQgO7Oa8FGQi5LJhmRWXalZmQTh2azxLH2dAL7Jx7f+6Nzxt03kIQYT
	 43EPvFbdD6gYRorOB5fq4//LwbsNODhshInWd6UBKdRSKx1jA3MsG4u6NZhs8nGDRs54+
	 Hu+TdxroDtUM6HshguhnPSEwSf7yg+p4iPucar87amprD+eBrBPYXk2wPh4Z2DKPepw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792866068;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=R4AuWv00qlLE5eGm1SoKOaDdSBzc5kYXpfl3EVz0O1M=;
	b=l+ik9rldzeMZiiZf3KcCDuBf38JrXQit0/qpDspfDZ8Bz8IROSdWodxJllawYx3uNObk
	 8Y6p1NJMDfjzEWpTc0tluYfxN/ECV9Q7cFO98+sqGqqPCUsioRf9im0cOu07rFxRVjmmy
	 a9M0Qvr7UNqdUJiJSrxGzgBV3wI47lXfYlRfmv+Jk/o+VbBqAOYXZdrepa+QNigy9oI9I
	 wFPfNguH+k5b6sS2WBo6KR67M2uCb6u4eioF+SGGl2XNZ825ZBY/ymyV3hC8cBMe08Ff4
	 zs79Vjfm9BSObusBlVlkVdB25/JMKEwmZ3A0V8ssbDAk5dq8I7+5l3qyKXGeLSnJvUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gyh8DYWl;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB505606A31A
	for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 18:21:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB505606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gyh8DYWl
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e608cd460eso11173965ad.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 11:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792866067; x=1793470867; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=R4AuWv00qlLE5eGm1SoKOaDdSBzc5kYXpfl3EVz0O1M=;
        b=gyh8DYWl/QZRJCs96t9l/jz/PWmrZAuSqCns6kMf4RKKlAVGE9MlFXyqYV9HCfLfmT
         hNvASItuhUf2/o0wlzVFrW+ltV1Q0KHQzfQ8EI4syIilhsNHK90xbP/60ytiWA29Txox
         ONGGLyWnzEcpDlj8Ur+n03Zu6umIxsyVGVOJHysaE+jqg+uN/67zh8q4JBH6/BxCum9P
         fFtiTMU/ukAqkkWK0fgH8TTBI9qTUXxFZCgINuyW4Awauccht0Y4LTyQ3eXp51gSYDel
         m6/keOhCESHMM7F0vl+UTqn2UrC3mKnmQCQFbmhmsw37fgObnKATFxjqBTKL/JM84qDk
         b9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792866067; x=1793470867;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=R4AuWv00qlLE5eGm1SoKOaDdSBzc5kYXpfl3EVz0O1M=;
        b=HWrYWOGw3z+tbelFgt86ORnxsH7AT/o2Q2+OrcJuqOLHxDsbrBu6aZekvYjVcyS1kg
         mDA5Ys8z7/9UE3hz1JAxP/RoLerhie8YM4FfqdgZlnbBX3BLUoynfLMZMkWPBwPEzdPO
         lHDmIKoNwNp0lnIj/iMLjVxg8CZqlxwEhEtKNUprzE4zGIsjYPdJvpkPO2QTVwAah5d0
         TQ4Xqg2jzj8yMG45Ij0eDJMbnEsL5ac0HH6vf5W6O7/5lJBamGzQHcS1D7P2QiSDoNcL
         odfL+nx5NuBrqs9diHzmGTc8nwrt5LWZA63RZnNhOd/vIrzygaLunL5SloSzJq2RHiCw
         tz2Q==
X-Gm-Message-State: AFq9FYII95annQWLYiIOY7GrZ8QyXX8dgEX+0VINqJFA7mRRkIrWf6s+
	6fQnPPneZw5/MIxgXxuPGoKPha6FA2tQZtIstNEcDZZaaNwWINvuHXCHND0cCQ==
X-Gm-Gg: AYBFou3lrDcQ/E6pGj4S1us8adQCWefEkOqLz+4dVLysD0/66oCvXhGJ46KPWbZxOOn
	7RosFZLu/KGOLAF3EVPTTygjHKa961NV4WXytNnhrEbhwedfpIYyech4iINvBUBWiL7S9iUz7vs
	c2CEehFuuxVkrIbyPa5Pty9nAwn4R7436pP1mAgu2k5+iEGVXoq26U+fUadZriDiCl8Y05nFBFM
	1d8gngrWm0MPifC/iHyyuYfw2lRwUKctnxixgAd4jqXbV4M23WoIct31hn8jO80QzV/YrZ6Tqm3
	3RhbEPZN7j2Z/6bG2Fd9MJ+4DQYZmzg/PDnTvmwsv+r5TS6UVjnkKo+E8RKT2tIbQYFuklEUJfz
	G6xG7qEqcr1PvqhMxm+51HvcKx+XmqCbR9hF8eHbKYtwAD6T1eQOXSLYGszRf0i/xgw5PQmYQ8b
	6OaqmgY+sfLfNmYRqPswXsZO0m9Cnelfv1Qc6aDWIqrp3JKg5FBoweVcucq/QsXXDB+TH69G0Pe
	pcJPm59JJONKNH68nPYi7qT+nIE2tZadyw0acUOweZ+kHXAFb6IOKXlqc5gEMFyCTyXwen6k0Mh
	32LYxlzq
X-Received: by 2002:a17:903:1a26:b0:2e5:70cd:b606 with SMTP id d9443c01a7336-2ea9c7fb1a8mr21327065ad.56.1792866066928;
        Sat, 24 Oct 2026 11:21:06 -0700 (PDT)
Received: from [172.17.0.2] ([20.83.205.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b14da87sm5817095ad.34.2026.10.24.11.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 11:21:06 -0700 (PDT)
Message-ID: <6adcf712.4e319b98.12fe84.f542@mx.google.com>
Date: Sat, 24 Oct 2026 11:21:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5202814081886261285=="
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
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: Bluetooth: vhci: Flush suspend work after removing debugfs
In-Reply-To: <pm-bluetooth-objects-candidate-0146-v7-4a901c7fb65111f006fe@gmail.com>
References: <pm-bluetooth-objects-candidate-0146-v7-4a901c7fb65111f006fe@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5202814081886261285==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1192718/

---Test result---

Test Summary:
CheckPatch                    PASS      0.49 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.20 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      21.97 seconds
CheckAllWarning               PASS      25.61 seconds
CheckSparse                   PASS      27.64 seconds
BuildKernel32                 PASS      22.67 seconds
CheckKernelLLVM               PASS      25.76 seconds
TestRunnerSetup               PASS      518.06 seconds
TestRunner_l2cap-tester       PASS      13.44 seconds
TestRunner_iso-tester         PASS      9.45 seconds
TestRunner_bnep-tester        PASS      2.77 seconds
TestRunner_mgmt-tester        PASS      83.42 seconds
TestRunner_rfcomm-tester      PASS      4.03 seconds
TestRunner_sco-tester         PASS      5.20 seconds
TestRunner_ioctl-tester       PASS      4.20 seconds
TestRunner_mesh-tester        PASS      5.10 seconds
TestRunner_smp-tester         PASS      3.97 seconds
TestRunner_userchan-tester    PASS      2.99 seconds
TestRunner_6lowpan-tester     PASS      3.98 seconds
IncrementalBuild              PASS      23.37 seconds



https://github.com/bluez/bluetooth-next/pull/999

---
Regards,
Linux Bluetooth


--===============5202814081886261285==--
