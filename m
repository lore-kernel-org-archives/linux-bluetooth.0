Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80D531A553
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Aug 2025 17:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756229601; cv=none; b=BSANZEyvMuaikfzjHCdmN1WNwtUdC2rIAlr2Sg9hFRgG69VlZLkGnMzVlui60XJcm7cxHoaYSze9fqhrGpxdJOFlgpmSSabZwXOnJPj+m09nI8V+6aYH8C/aCimv+mPOtLfIhjzrrK4zj7EBqcitce8Lmhque7EyMjuFoPWzOvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756229601; c=relaxed/simple;
	bh=R6f1riWhkgC4aqkXjdETseFG2ZQmt3f5VzeC8LfWOxY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tqKyDIWnMgNDO+XkezpFYP4B7n/8nx+oejdoI/TxdZN4nKpxS2d+QbyF7XSnw9DCRlDlDyDRNhxZew/Eg715pdOUincSieHFAX6Or7yFuxyJTKEsrw+EEfweRW5j86D51CWrhzWyfenXvoE1DbmP2ze6yttBuP28LMrx4Ls3aeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOdh9L3T; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOdh9L3T"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-70ddadde48fso4492066d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Aug 2025 10:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756229595; x=1756834395; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cMHKNofURiK2Y9xnZkSw+33et0GeCdDs3XWdeU/vL4k=;
        b=JOdh9L3Tji1BlObhAs0OC+lDVJxSgqJSS697hS7u6ThcLw+3JbqloCIXBFxcjUcgB6
         tOfOzCfmbvN7RksXLv0euuxAuFnvvUH7+RpxMCRuNpQxKWxMOrskZHiK3Th7OgPC41/S
         Y30aEhdxH/0RV5mqYt6h7l3mHTZy5yBAP0lTRLP8eAJ++WuOH0luvuIi5GheH42P6Stt
         QijN2puAQuNidCcAc0Z7tPXGokM2lENCkng6w7cr41ZoIyYg6GwkK+HkQNqxYHYkQtsL
         +XcfyHSpIhs8tT4j4aOxifuMaXR7IMvMb5qj32zO0VNkIE9sicMtjjy+UbHmrjl1jbOa
         rwHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756229595; x=1756834395;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cMHKNofURiK2Y9xnZkSw+33et0GeCdDs3XWdeU/vL4k=;
        b=I5LI9LQl5Jr8QI75F7wkYfGGw5Mx22TKfMlq23YIoE1cnLTZKs/bJkQKfqeuPAIwMR
         ZOhVRjmQqwOXLBF9riQhPmTSLiTckKu/x6vbDNdkqq7GHSE0R2R+Tt+qtvcIe3M12XN8
         5BN39H3/kED0kEH9MRmBxuMT81bnyDFPbE6rZZtZo72LjdzNGuG2Q85EpGo92PjEsYX7
         7/4twkBfXlyKnVCEu/g+6+z2lJgFS0SkFl09Rt6EHY/LX7QSpOrCb3D4nsipZMkwZi8R
         bjoKdRdYMXRz0u9yxgk6znbYXw8dgZ65nQJIEG5NGClNdoZqKCwbn7Wgh1IT7+sCwEBn
         u4gA==
X-Gm-Message-State: AOJu0Ywja08KOjLwNiLeDAzpjutXy4kiUNnYfQ/5ZbXd7RsSNZidCWa7
	vF1xJXK6LVNfSHkzD7K/3d/v1UBUI8c9b+8OuklF5DDjteR6pyBkyb7CYvt0ww==
X-Gm-Gg: ASbGncvD/C0j3VXUzDm+VnP5oiqCVoQSMlPqbiavNzu2VI0L3+E2V1YZpxZCDH2T7kB
	EbYvkgOO0xdV06TLV0mt28ZBg4hxKYYw6mKkGX7u4+uPOKgeo7zwIcmjgamvaderz3bYljmbVbu
	idZdw/FhPkGcKgsHMMmvJr14rJ2wnPsBSDAW8RA5NorS0Lkdi8e/nSKPlS/detq15NgxS6BjWuW
	IB+exclA21+XuA20rWrWYRZG2vEtnixNi27j3Muv/P67IXipVp1k9LlncjU3f0N68UqYUxIzXv3
	6W7ufRXf+DN2ARzH3zf/OfhiUE2/vxNOGU71skXWQKlWwAc3curGGfQxUpl66bytUi4FM8X24DW
	oRx0mQG2b/6TTCOBkbpWTPwo9UwcH6Xd2I+HJIDo=
X-Google-Smtp-Source: AGHT+IFzpX39WWdoIWLRgpsoSa7Ykw2ArBvLmhCyyrVipES9/th6adsaA/t1MRPhYL+Og+IO1cXwlg==
X-Received: by 2002:a05:6214:2425:b0:70d:881a:e14d with SMTP id 6a1803df08f44-70d97107d0amr248336366d6.28.1756229595075;
        Tue, 26 Aug 2025 10:33:15 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.28.180])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70dc5649acesm32826636d6.74.2025.08.26.10.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 10:33:14 -0700 (PDT)
Message-ID: <68adefda.050a0220.bd6c9.d917@mx.google.com>
Date: Tue, 26 Aug 2025 10:33:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5692175637931367267=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, arkadiusz.bokowy@gmail.com
Subject: RE: [v2] Bluetooth: btusb: Check for unexpected bytes when defragmenting HCI frames
In-Reply-To: <20250826170314.352122-1-arkadiusz.bokowy@gmail.com>
References: <20250826170314.352122-1-arkadiusz.bokowy@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5692175637931367267==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=995751

---Test result---

Test Summary:
CheckPatch                    PENDING   0.40 seconds
GitLint                       PENDING   0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.21 seconds
CheckAllWarning               PASS      27.02 seconds
CheckSparse                   PASS      30.51 seconds
BuildKernel32                 PASS      26.64 seconds
TestRunnerSetup               PASS      476.15 seconds
TestRunner_l2cap-tester       PASS      25.01 seconds
TestRunner_iso-tester         PASS      39.20 seconds
TestRunner_bnep-tester        PASS      6.03 seconds
TestRunner_mgmt-tester        FAIL      128.12 seconds
TestRunner_rfcomm-tester      PASS      9.40 seconds
TestRunner_sco-tester         PASS      14.88 seconds
TestRunner_ioctl-tester       PASS      10.20 seconds
TestRunner_mesh-tester        FAIL      11.44 seconds
TestRunner_smp-tester         PASS      8.71 seconds
TestRunner_userchan-tester    PASS      6.29 seconds
IncrementalBuild              PENDING   0.90 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.102 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.222 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.032 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5692175637931367267==--
