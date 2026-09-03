Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4BA34EF04
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 21:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788470709; cv=none; b=W8+iXTLf2k3nRQ2nEDCvyB+t6RzW8sdVomGuZEylTKZsaiQq3UvoGr7Pxw62bhax0FdZ6aFk1ry7UqkrQAnQewFZKm4Lsi02bCgX0X90eN7Z6hkwfbAxJNvzB813mHuvErcROAjHGLx3HejNJ51kl5LuVE3Tfq3CDacDLD8p4vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788470709; c=relaxed/simple;
	bh=RqKKnysXB9F0wj01rdz95QuyV2G3yiYVXTDnoeXRdJc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hNYXCK8orpBIQJZ6P38Q8rzikbmWQQ0BdTNN3Eq2P0qC3gdyI2FJoa+LvvES5HJgaIvRTgdK559LG5VT9icx6idhzye0LxvEQpV9cNlfFXlVwwD20NLUrTCEOygdvHV2aioKykwUMXWs96rVlbF2v5KAX4UVsiLdV1Lxpc0ttpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Su62TLL6; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Su62TLL6"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92ed3993c1eso18072485a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 14:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788470707; x=1789075507; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KMx/l7QVtt9ruiQJRjTLZHuVuhN4da6q/Ch8uezbEX4=;
        b=Su62TLL6ZTzEXVzjSHSdoscdwavxl6I51Nd4acCl13gRMl6uRf8l25bjVs/13lWMm+
         M8TL4rIEf9M7PP36cU+m8L/RVbq1q0ZS8FnsEnsU2SigAIMpszZfPczR7O8/p+VQPiPk
         +LTjMo36KXRjOn9fqyijhvMhGNwPASQJ8fFhD0m8et4iU0Kd5nFxSj7cetHraCsCP6nR
         FKP0ZP3tXStrj17O93A/xV/778CbQgaU6w9ANoGhpvDO2PawXeg2tSaZbCgIk/1U/Y2G
         GEYN929UIHXNImk4G32tx/HpLguMxZvdHVBo45Y8W5UW+kYLbv5Qs6r3DNi9x+Wd9J9H
         n23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788470707; x=1789075507;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KMx/l7QVtt9ruiQJRjTLZHuVuhN4da6q/Ch8uezbEX4=;
        b=h3Zhz/g53QDwLcpZQXYLR32XfWx+8Eh4KMCPpJgdadB/ICVX4eXoQBOYV9an3h0YGj
         /EXmOlBO669/Pw9KulhVKMpLUfZXk7+SfrJQFHSml0eqR1kqb6s8//ePJl5twLaP73mb
         4lQlg8RWIUpcqlOrrSaNmnJIk1Bp1zChlpB+iwX39yOI8u0Lh56hiQIy6THIHJ+q1COk
         d33UVn7wknehQSgXkQY4Sov8xU+3rTVY4xSvtj3gigYtuxvikDglFPNrHIRc7hEGeG8O
         ZltlXDBEfu/iyK1lhswwjUQ0GSpNx5bxhEFxY57Y3+hP/bbWj+Y28C0ZR8MhBxRZapL1
         ZbhQ==
X-Gm-Message-State: AFuF++mz7be3MfrvwljQBPAIgJWM00QszH0VIoOPOTkXX16w+BF5tjCe
	ZR+2LXm3fEkkMauVvbhJWRf2mepSJJX3W8qniRqmrBe9LPuWDROeHOUUC4AnyIxs
X-Gm-Gg: AYBFou2AJD6TJ83ygc5EEbtUMpTsIOH9F3bTxMny/xwXmNdVP1X5TV/PxvNlp3+Spik
	BKgBBaKzHVPDYUb5gEAw3BuSTNwPqA3cux2Q+U4P7MPXZlK5sS5h48NmLXYshAm8yecvA0908qf
	0IGVr8PxTMiIZPk6uxai8QwSo1rrthGmfuNNywOgbKCUI3di0lVVWuNO7EYvkXxl6IsWmmXNack
	22p9pqHtbQms314S6pXZMaHNngA2ltKiH6bRzxpo6UtDatxKeYLewDxW90/iVf9fqyWj+a2BAfo
	v7SlYRRb4ZetiYmZV4OfIcpMXABKs/EiH811CuD4MxdI5Rl4JkgpOiLE0kkvEq8wX/e8Jft6Ev0
	rr4I8biWUorQRy2Xsof3NVaZeU1OQl7jy1u4VtuICyrPs0gynX4Vzj+IrEYxbXwigNkuKv6A0BW
	1Brq4QanASbhKyd7GmO1Obzs/ZWkJp2Obtpmwl+3SkG4QQxQWHx99/b3BWl3nwSfrDV6M=
X-Received: by 2002:a05:620a:700a:b0:939:820:2e71 with SMTP id af79cd13be357-939804ec794mr160608285a.33.1788470701873;
        Thu, 03 Sep 2026 14:25:01 -0700 (PDT)
Received: from [172.17.0.2] ([52.150.30.130])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397fb70fbdsm58601285a.32.2026.09.03.14.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 14:25:01 -0700 (PDT)
Message-ID: <6a99e5ad.26598079.2ab5f7.1078@mx.google.com>
Date: Thu, 03 Sep 2026 14:25:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4558918377787066138=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vladimirkondratyev2@gmail.com
Subject: RE: [v4] Bluetooth: btintel_pcie: fix stale cache in set_dxstate fallback check
In-Reply-To: <20260903192245.135310-2-vladimirkondratyev2@gmail.com>
References: <20260903192245.135310-2-vladimirkondratyev2@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4558918377787066138==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1157358

---Test result---

Test Summary:
CheckPatch                    PASS      0.98 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      26.26 seconds
CheckAllWarning               PASS      28.62 seconds
CheckSparse                   PASS      27.10 seconds
BuildKernel32                 PASS      24.99 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      461.42 seconds
IncrementalBuild              PASS      24.42 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/699

---
Regards,
Linux Bluetooth


--===============4558918377787066138==--
