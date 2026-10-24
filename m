Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792825421;
	b=WIIe054CdzyzdJUaKXg69VDXMYUhUThnysv4ehTG8tV5E7ShbvW+ru2fmE/3nRjHnOec
	 Wm/2t37P9emRpgD8w1PvDLwxQjqaduPULz47HmLQ0wUwc+OJ+/ZrkhJBXpnV8uK8/i942
	 +etUTtj+fhfg1sJ8XfaW3KurClMKK6YlUtpK7nBN0NUPunidqa6ndE32IUMUkxpXaxlzH
	 XidWTNC+p3DdvbgblZqUVu3l0O9gEUaRJFWPKuCnoms7+dI85sRoE2laavQk4BedPhVaR
	 IDaNpkpczZn/fJXOa5tVUrI/OQbAVXAeN77Qs+1Snx0mSYBPjyqhA5otP5T1KSUGyGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792825421;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=ha9mNqJRAj6za7cAI8C2Y5WCJwNWb+5t5YQFkU9ULI4=;
	b=L2PUuWOkxHMEnqKguB9Ejxw3YNuHoh16q1ZYk2z3RI1nHCbWn9U7+rvMyt1Oz3nZaMoF
	 6f7Qp1sXvry8GLEG+f7QxVtpcsWHRVy32/RzrdlE5gZkC2DYIY+n/pjSzAIGneRAW42z+
	 UxfkvrnpCtXxe98sny/x4/tSYtWsIVX3kzjhmE5R8ATvWTWUZB2TrX9/QuPdj+MvyiRNC
	 /DaXzgAnY4KJWpKAuY5zlbUoDNrIKBlmSHviojVriXucsWlC78SXp4LhFRSOp8TqQ1FOp
	 JfgygxS4E4zURHmWShqewVA/n9UaT/6ANR5I3d+nDFVoQvN7a8wyIzj+kIE6YXtVRCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TOI4d4Wb;
	arc=none smtp.remote-ip=209.85.210.50
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DCA606A31A
	for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 07:03:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58DCA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TOI4d4Wb
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-8490a7d6696so858149a34.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 00:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792825420; x=1793430220; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ha9mNqJRAj6za7cAI8C2Y5WCJwNWb+5t5YQFkU9ULI4=;
        b=TOI4d4WbPKYbzdzzluJpfR3kXQYHKAkCJnAnC/8U/Onjhr6oM2+0aWEE9rU8gLscBa
         9zlmIsmYuls3zZrMrXcS+pvNH5e6f2XjLMwIKJrNO3mzsA2xdYEmupsvDe2onHVxHxMs
         KkIO45sBtXjaJ3weESgg16p1dhgmlWSTfpk8BUQL340L5/HcI98NVQ4w7LOmlT6F2KZ1
         4JgI2e/Z55DRhyCuEbmihoNtTwUflbYy0mpmj2UsTxNVt3m6uCsEMXTwurPqA4NN6ptL
         IeKmGgq3c0VcMlcI+hFimjNHuK0XO9hRs7ydgHfXjhHKxsL3HGKNNqB0+Bj1tmjn8Ho2
         OMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792825420; x=1793430220;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ha9mNqJRAj6za7cAI8C2Y5WCJwNWb+5t5YQFkU9ULI4=;
        b=vzv8hXPdwbCApU7T+g0atCQGDqJxf/ZO1r81kGzaFXG2tB2bxhbjSMwYAZu16FGlcT
         B8DsKR7UjMqqbCq/G8WJSf32FzzBVxivU+bWQV1mEoblq+SenuwUW4ppMy5JgDFF1tlc
         t1P84p3R32G8gkPTO9FLolCQjcZvJrevOQXjqNhzgvfgdFvyShiu9kTVXqzQ7YrPGvA+
         3mSrA4IDiVFtUx4fkkH6uV9hjK1gSADLCA7g9umiqOGWsMozOsz/cUPgWupArbYEInrb
         rh0T/+m8CwL6379Mx2Rd2AXuRxWGSTbKqnu++NvHlVLp23jiCSy/z+GNFoz6uaPGptLX
         eLlg==
X-Gm-Message-State: AFq9FYIPvcRx2iv/6611yVtGOXXhfaZrtXZH3OVxL1ZV63gmgjpPnUEg
	5l8x1DO+i/wOXzAHO8lAbDE0nAXLxruT+uyBzteoLP07KdvlecDxMscYsUil6N+l
X-Gm-Gg: AYBFou2+3JbhtXm8bnphugovKQK9s9KJkcyyF8CIm9WufAe/wFuOf6p2lzftj1GeS22
	oZMQIOU+hfCo88U8XeRVYZl7bw8pPp2fbJe2hZ6tFjRZptXgv+RRF59z0KXoeKApzXT4nz2zCKP
	qJ2wtR9dw3toDH8BuVpeAFZLvTeGWduma0U7xpDA0D8EeiGE9h9Vla5cMFJ4ttlS2ww6YEdoj4y
	9/MaHUlfqKnlFIQ8oSkH46+Xv8QioblQPWzPspVfISosnpuPDEAtR18NMQJ2zWYtlJMakUpIc39
	YTx0A2AnvHiB+EuTpzGMuOAKCVTcU2ye1b0hSYNJzQc55lO6YXAKDFXwVcVJxSX6KRCQjg3HpO+
	KyQX0VOwN5z+8Z1FSamFw0RFgoxq0HFDq/NwukXtuctrcgvWvVyY5ZuZ+idnh3/Aqhes/bO4HNm
	1G1nwcDRgWoypVtmBsNcuQTfHnf5BWZs1nG6tJYpytLBr1FX+kljdcYEbgEub05LS0Ke5WiCsYy
	QyFzieKxa3LapYq5s/epbNq26MHBUqPGxEBEsOVWTlt2/t48Oo+YwvcN8eMFW1A
X-Received: by 2002:a05:6820:408c:b0:6cd:3fbd:1d63 with SMTP id 006d021491bc7-70ba0f7807cmr434762eaf.77.1792825420199;
        Sat, 24 Oct 2026 00:03:40 -0700 (PDT)
Received: from [172.17.0.2] ([135.119.70.128])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-70b9e0417cesm1384933eaf.6.2026.10.24.00.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 00:03:39 -0700 (PDT)
Message-ID: <6adc584b.3ae93811.3319eb.c77f@mx.google.com>
Date: Sat, 24 Oct 2026 00:03:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5010488538737389581=="
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
Subject: RE: [v3] Bluetooth: Create debugfs directory before running selftests
In-Reply-To: <pm-bluetooth-objects-candidate-0188-v11-36d2c5e734fec40a3363@gmail.com>
References: <pm-bluetooth-objects-candidate-0188-v11-36d2c5e734fec40a3363@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5010488538737389581==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1192558/

---Test result---

Test Summary:
CheckPatch                    PASS      0.52 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.25 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      16.83 seconds
CheckAllWarning               PASS      19.43 seconds
CheckSparse                   PASS      21.20 seconds
BuildKernel32                 PASS      17.13 seconds
CheckKernelLLVM               PASS      19.59 seconds
TestRunnerSetup               PASS      382.94 seconds
TestRunner_l2cap-tester       PASS      12.92 seconds
TestRunner_iso-tester         PASS      8.66 seconds
TestRunner_bnep-tester        PASS      2.72 seconds
TestRunner_mgmt-tester        PASS      80.20 seconds
TestRunner_rfcomm-tester      PASS      3.91 seconds
TestRunner_sco-tester         PASS      4.88 seconds
TestRunner_ioctl-tester       PASS      3.96 seconds
TestRunner_mesh-tester        PASS      5.53 seconds
TestRunner_smp-tester         PASS      3.83 seconds
TestRunner_userchan-tester    PASS      3.27 seconds
TestRunner_6lowpan-tester     PASS      3.87 seconds
IncrementalBuild              PASS      17.35 seconds



https://github.com/bluez/bluetooth-next/pull/993

---
Regards,
Linux Bluetooth


--===============5010488538737389581==--
