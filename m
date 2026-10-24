Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792881847;
	b=3vq1u6Qx9HQiqX8Hy8Vb0aixtlgi/r793xA+uOUbV19UCtN7mBF++yLM3lrEVyKxwGwy
	 m/vbU17UwcFDq79CCT4jODOpCnGYT2dXULKIOzjw8ikCpKP1YFijPk76k9dLG+DaejNTZ
	 Iy8Wy9xUEW2tqzHcLBLMcx0jADCW+MsReZ4EyXm1HmDA6xRRboWFgZFSRxLbu3q6+Tou1
	 hb043hT+ay2r4bJvy6XP99YCeX5undcsEWoCMiUqIRGCnUopR5pSD9GpSSk3hcwQolyo6
	 OlOGI4K4M2mhOSeJDet34goTwppETVdNOABmSNtf0F1okBLKjA+StyK1QQEt64xu2ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792881847;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=0td6B5EWjhT4e13Q/9nzDIdp/cZdtMVSNN2tk95k7b4=;
	b=RntJ5ghkyP8qSuYojXAdQ7BwTwKwsoTxWNE3wDkD1pROpXxc2pTb5h0g2wIPjlxcVpju
	 GTFD+WbJ6d8Jqovzrc3JBJPEQQ4vFr43GVGkfqVsFHqHGadj4eLbk9jporwpENjOAV+j3
	 KpOmGRP84E4CAt8lGvx1oRBnYszeq8uISALip1HXNx+RibWAk70LroRFnnRoVNCPP9vFi
	 lOjfGyELiNGsUbiLQoTVyxYyfQpbeob84oa9lip/2Mymey6W7zpJUTUVz5lAYgHWLZzSU
	 KMi7xQ272JEPO2uDEqxTxp8geag90LijK39dClGY9ZvyjRMtuYtQgxgjPFTzKtK9w2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C+8XUQaE;
	arc=none smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B16606A31A
	for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 22:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64B16606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C+8XUQaE
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5364d86f7f0so23847601cf.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 15:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792881846; x=1793486646; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0td6B5EWjhT4e13Q/9nzDIdp/cZdtMVSNN2tk95k7b4=;
        b=C+8XUQaEpGZ7ikelR8IolApPDj65nMG1WMFiYOMJeeqgvbC7CW1Bh2dCmOprBFW3J5
         Uukj5fIBNnspGS4gxuD3Ekyo2dMD6FQg5J9DcSjShOtItXuO64JAYZ76Nswc7qQGFCKb
         pw0l9GSX+qwA4kpzmuZ831q6iY/xhG409ioY55c0VCULSC/vIQYmcrpS7N9nPTul2u2P
         tR5slGpRhZygSYrchY5+UynIT0FlnSsXq2nmcRDlhDZ9mLOMPHWAe4mQfpjCVgWya5CB
         wUPZExQhXP3h2lyu5DgGtFZXN4uVF3JVFUh3SxpPsGKubr1Hs2+xFbLfiGuE12owkHAS
         5qLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792881846; x=1793486646;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0td6B5EWjhT4e13Q/9nzDIdp/cZdtMVSNN2tk95k7b4=;
        b=fQn8uuexLj59ofTrm/iHqNRXcIqMJte4DR0L8nYUPHS13Bda2uthO4+UvwTb/Kg9vO
         RzRllnRiYuL14/Ar30MeETgjAXmKCMbKvE22qb1GlfbubyEFBhqepQPanqCMOqz3n6F3
         osycJ6vE8UCpzPckPfcnF+1DBbDe3KMhanbkNtPpaixdG75ZhiVpQKDjaB7tjb5b32X5
         6BT29yg9BuJmynq7H+jwUclkSpeBVprNrkc0ctXA/2MYljqCsRiQnnK8nLPy0OFlFfa+
         D2QgI2dOgbTZIp8j2V6E8rZIymbUyIF4v48A0W/VSvYFB/5DJmLo8FBS5Lrec7caImTi
         qLGQ==
X-Gm-Message-State: AFq9FYKE6bD4ySsWGxInjlY+hb1QGqu4zghajY0wlo44xeRTptrQSfiE
	9WwpKjjasU6EfNOPj2MvK49B7ppfthAf9n88LoQNrsnVLFElo9mmSEJjqG5JSw==
X-Gm-Gg: AYBFou3NYizG+FCOfxTcRBEg8LYq3kyInq+yjTreqFu3FVzCxxvGvkaNtgoW0hDzSfI
	slgmzY/kwed+9l+JOEs7vuU8x+sFkk8ppyXW+TrTuVAGz/wFbysT0XPzbi7+WC8HbTUcn6ZEHIx
	CouAomHj3WQWfyHinbjWV6t9kD58UKncHXPUz/qH6jaL3O9sKvCDwGYSTkKRKKvxHLwxMhAzGvu
	dgTdF9Yx40YzB9N7tXOS1yCPlB7RMAQAen1SUuwfpdI6zA5SJRp5oOlUEsheTwE8DRR/muqGFc+
	VUJidsULweVlbIVM02Ig7K/ZCm8yfd5O1arMhfqwbuytDB7HMeSwazUeLq3Coi7H4fi2uS9D2rL
	RsduRL5Nc5KMuKT/xBfDa9yuSh54TWOERFEUM57gQ4RueGuyailhNPyYNoq6Xt6wgz4R6Wp3mKK
	pm0l9ileNDUH0w5vYbPOoWhQQEkfh5W+UJagntNIkx5gi+KhLXRWyAkFzpARPnKM4uFjgORS0rp
	BDYoVLbDYwQoYqsOA/qNi5SXIQZULi9MZIaFg2DULNoHRSALeBI/6mdO+jrMB1C
X-Received: by 2002:a05:622a:a16:b0:536:3d24:7b9 with SMTP id d75a77b69052e-5383b5dd871mr43863931cf.15.1792881846358;
        Sat, 24 Oct 2026 15:44:06 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.192.247])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-538394c565esm23649441cf.6.2026.10.24.15.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 15:44:05 -0700 (PDT)
Message-ID: <6add34b5.b7d948ac.2583b6.884b@mx.google.com>
Date: Sat, 24 Oct 2026 15:44:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6728118353769413052=="
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
To: linux-bluetooth@vger.kernel.org, tristmd@gmail.com
Subject: RE: Bluetooth: btintel: validate PPAG table element types
In-Reply-To: <20261024205942.4056250-1-tristmd@gmail.com>
References: <20261024205942.4056250-1-tristmd@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6728118353769413052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1192798/

---Test result---

Test Summary:
CheckPatch                    PASS      2.51 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      30.28 seconds
CheckAllWarning               PASS      34.34 seconds
CheckSparse                   PASS      37.16 seconds
BuildKernel32                 PASS      30.12 seconds
CheckKernelLLVM               PASS      36.49 seconds
TestRunnerSetup               PASS      713.10 seconds
IncrementalBuild              PASS      27.82 seconds



https://github.com/bluez/bluetooth-next/pull/1001

---
Regards,
Linux Bluetooth


--===============6728118353769413052==--
