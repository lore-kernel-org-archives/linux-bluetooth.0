Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64264412BF6
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 21:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789420747; cv=none; b=WrQtHqHjzjCZwETJGfszMHX7IvdqkyctQfv+YUE5uC2dyYggk4sdR64PZLwx63Ah6UTisZMujDQZeKj3chPqJ/QS+4RR0rtfvIO0zXeIfV+Tuw/E6trYrTe3BB1WFjhATofLya1eqB729DVMgW1Jih//085cwrVjXwbqpt4U7AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789420747; c=relaxed/simple;
	bh=05RpOsIrqVt/wjII5ktUdDzL6q26UJceIAXEeJKGa+Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=UFAnaa/rqsZCwsc0WafVC1uXc5RaPCeHRJ56FhlQ35mQK3BtDcIK4uIDLm2lRa2Jj8/gxhq1C6LPXRYRhek2hAsWTvnG92rc7uZ07/ZTMikCv+werLSurRFc/CrPrsmbc/isdtrYegPyXXNk9WdT1EzAjWjH1E2X3qAmWQfQhDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kor6QbIE; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kor6QbIE"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4c3304833so1910552a12.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 14:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789420746; x=1790025546; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kigBaj6kUoLmNBsqzc2QZyAXUpvDA5iYBI76UoZlIRk=;
        b=Kor6QbIEYQx4xUy56+a0zWz/HRSGrgXGDqryS52Rry3FLh1POn2mrtflBxlRuU0YY9
         yqHVJ5ocn9hdn0vGGWkQSdaYm0KrEaKNtYK6pEMHNjcSTH3D61/iwzo1bebuCdBDsbn9
         70vg5gIPXwct6C/Hm3FKpw+8xDtpSQdtfjPxl6WteCtKzv9+ydJB2qlGPssrealModOd
         b4e5YkS6F298tgk8GJii60qkPvFaT2d7KPF0eXWfoDl15m/Fm8eeURGAGTprMKCDBcF3
         nwYiAaySK1xsQohY6KJwmzCIuARq3ydD6aw0CZ6InOiB0+KyuuHGGKDxt+H/ujOXZC8A
         TEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789420746; x=1790025546;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kigBaj6kUoLmNBsqzc2QZyAXUpvDA5iYBI76UoZlIRk=;
        b=X4KzC1VlrPndQOfZfBVrZLKxnkRMz4m/xBDA2RkL+ZNwdpFuBrBE1L4LRYGCiwkYw4
         PnIRya+QEVByJ2fv93d7am8lg6QBwYYSkkZsso8bT4Vv6zlYYA2nTg8EiETKKxGH0rFy
         XLuxttPrWDqlIuS/cmI7mhpwSUlKRHDRr9q0lcNvQaE5Pq2E3gIW2P6AViH9rmRCwUzI
         QagiZyQ5ZbeuwvjYnAGWi22uWHb98YvyA1208BLprXyzj6ZLAo7i7zjQc3wc64pwHS1o
         HQHYBwLbRPr3xYnpgP3eMBOAJgsH3AGuZJMnkTEHMS+/UO1kJKrFuUmZ57Q88dz/mpZy
         BibQ==
X-Gm-Message-State: AFuF++nA8557PJofxVNEu0Kf6tZUSGBe26NQU0JmR3nsk+IWtyMG+d/Y
	4mhisCOFYj1xTPR5RPtrcRozRqXjlLyOe+AaygonRWzWWTrOkr0xT2p+lNLoPg==
X-Gm-Gg: AYBFou3VTNog5NBDtlKgiClLp4XaWKHPHLdTgDgGSzEERrjdk8fQW9eBByPco5DA/IP
	Mk6YbIKE52Rd0psZ1DMnP6pKmiZ00eHaWtJJetlGSfDtOdnX7r9AmsdLtDPx7+k3vxsUQQt415V
	Pqd872sc9m6nExUGWV3HoVtIpKyrAgdlGhJdX9Poha5EyBJjEztSmDx/zQA4xBUWWmIBIIKBVnh
	mdu2+j9hVHdxXdcd0nAG1yvSicnuVHeh/bTIMYCv2m8oA1cCAac7Et5MR74j8a+5Dhi6UqDfW14
	YP42JSy6X4TXuVqX26o6GWMpuzF1VpNGqJ2XRr4O4vl/IOhdGP+EuSlLgypi09RipAtIF4V53Sb
	yu4t4a6fTKc73RBvE1rHJWa5Tj0c+XQeHPQwj8B5fRQhtIuAVoS34JrwIMcEKlXUfXEoWbOzbd7
	K2x0NjJfOKxet6FZFq6iLKuc/Kq1fsiy7K0fqCbEIAM+1mbdZcIjlr6v3mvDsoG0x1J7CzCOoW2
	EY=
X-Received: by 2002:a05:6a21:2290:b0:3da:1e7b:ea27 with SMTP id adf61e73a8af0-3db40593307mr9660400637.21.1789420745439;
        Mon, 14 Sep 2026 14:19:05 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.22.40])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4e51449sm24866282eec.5.2026.09.14.14.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 14:19:05 -0700 (PDT)
Message-ID: <6aa864c9.80a95698.2a5156.8cb5@mx.google.com>
Date: Mon, 14 Sep 2026 14:19:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3771772834859504771=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, skokovmaksimevg@gmail.com
Subject: RE: Bluetooth: RFCOMM: free the skb when the DLC has no owner
In-Reply-To: <20260914173044.5249-1-skokovmaksimevg@gmail.com>
References: <20260914173044.5249-1-skokovmaksimevg@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3771772834859504771==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1164791/

---Test result---

Test Summary:
CheckPatch                    PASS      0.52 seconds
VerifyFixes                   PASS      0.29 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       FAIL      0.22 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      26.16 seconds
CheckAllWarning               PASS      30.82 seconds
CheckSparse                   PASS      32.32 seconds
BuildKernel32                 PASS      26.47 seconds
CheckKernelLLVM               PASS      26.83 seconds
TestRunnerSetup               PASS      655.52 seconds
TestRunner_rfcomm-tester      FAIL      10.25 seconds
IncrementalBuild              PASS      26.41 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: RFCOMM: free the skb when the DLC has no owner

44: B2 Line has trailing whitespace: "    "
51: B2 Line has trailing whitespace: "    "
##############################
Test: TestRunner_rfcomm-tester - FAIL
Desc: Run rfcomm-tester with test-runner
Output:
No test result found


https://github.com/bluez/bluetooth-next/pull/767

---
Regards,
Linux Bluetooth


--===============3771772834859504771==--
