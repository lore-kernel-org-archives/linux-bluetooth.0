Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1C34483A9
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Aug 2026 10:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786012745; cv=none; b=orhXvRD9VUCaeVeOyJfJtCTrIeI03Fh5GNVFy3cgSZoJvfD1InR/9RK7XCyLnUUWp8FZSSFzJPHvKNk5wrZap8Io4QBtH65OBVyw1qccgNTNz4QBlAw24VGP6rbXClZ9h1Q2oBLKLiizCG44aHsvn5/V3qleu0lakJ4no2rc0eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786012745; c=relaxed/simple;
	bh=Myzyp5APA3l8rZ5d9iMfhP2mGhXiEwVZCzJTGOBH9HM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=o8yPR9Ta8jEtvJpxvQ9FhI3fhBcUvALw8gkZcMwuYD64vOTtaj1l5ukScR2dMlUpdwx33d00/JbpeZ1r29o824mhyEOUt01mLm8VVkKybEY2eF9VaphsVUk5/iagUydqkVHU0cyH7JvAE0TmXGvVDzHu+hIYun2bhodHQqvB2Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcvIZvLD; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcvIZvLD"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-caf45fc5202so1853935a12.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Aug 2026 03:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786012743; x=1786617543; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/r9FaPgW17SIZgc3Vu2f1U3Xy9AVaaP4Hn5tl/AOg64=;
        b=hcvIZvLDeUdbGlc0HS/9FuBPW4kDfb4/+9cZpDxGtt8gt5Q1clIf01QT9+ji2CSxu2
         sp9Q5CNNtC4lNT78jiopl2fIQwhGuiCVIwCYkhPFPq8CgtHmlwB7NW2X2+5a76P9+XY/
         586H+okvOsCU4o3AuLNHnxnGLGXVWA2o0XobonFWfKhzo9QPpX5bLhlvt6ZBR/YhNMPI
         Dz2eAOtejDM898AqnDCr+oooJMa99anqWPxAZIT+H+9Smzb5rL4kGKsf+WmGdCWUHlCr
         7xXeq6c9TCBvNLtJlkcXr2yp1cBkaHc5n/JxMkkja8nU9AZqtqV6K9fctGONV5MSZcBz
         izCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786012743; x=1786617543;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/r9FaPgW17SIZgc3Vu2f1U3Xy9AVaaP4Hn5tl/AOg64=;
        b=DsFCRS5xagsHAr7yWFMybW++ZGJ3EIrrWR8D1iYlp0TbJnU28A5u85grnKuw64Er0n
         dxpt+9ObsudBRJvSo/M8r9nlAAoWsdExY/JZWO1C6Mtj197/2Cy5nKRVgVZQKvkVv/fg
         H3pHOoRfFCRetHC1CvAcbCz5faPysYRlMsPItgaSfFC2u8J7tvpjtWFWt8N/g0fuLdAt
         FfmmYA2FHCMETMKPy/aQiLduucFGRV3/fl46OrJ8PF3ZTsx/2VgU2xYk/Jiufh6bEHXH
         sMxqbClpvFj/zpDtsAqdM2cdU/zUo29CFVgfeh10R6VLUeqHZRoJI8tAM4jh6RwZ9XPe
         wDVg==
X-Gm-Message-State: AOJu0YwWKYaJ0rCg6jjED2hKvBEFFHzcRM6lUKHVkfp1kdCR99PhBBMK
	+vw5DkA38/AyOtHPDFKJvc1zAjxz0I5YPfThcr078K+dr/hOn5yvvV9dyjTWtQ==
X-Gm-Gg: AR+sD13UaZZ3nAozavhesntwYdborHhV3MWRpgy4EVi2AgdaTHG/lT6AQDrDOAvGiRT
	B5B7qMY22Syicn6BgjmcXyldwPUsNCpggSM1cAm3X0KFwDux/54l+0X96Tb1AdqcfJQCvaGBx+C
	MB5PqwMnKnbc2uruQXQjw1AhpUs468MfSe/xSTdpiUrn826y2Q0+S7kJWUA+dHUDIF1UtpaKBAS
	vIo6J2eJJ3SeYnkdEli73zr5bNcEDxHGlS46xB52SfOLuKs/ct1iZZypTCQH8seGT+20F7iDCrr
	Wxn8O3T813oW7tc7WSDU95SUK+eX6VG3o/vz8qb90QwBbLqI59ky/v9q7IlvOrpIVJvMEftQpCo
	P0ilBaJGbyJIVoHA8VSFvXISVpAiReWyz1J4UYrPmWcI5mg1vUVXZFjI/C5NhB6t9nIQ7XdEkgu
	4i+Xyrf16MKcPgq1tv6AYgB4i+Ol7VCbzufRdhmmIWgd2TawIwa3PI390psL7/N/OST1k=
X-Received: by 2002:a05:6a20:2587:b0:3c3:84a5:f2be with SMTP id adf61e73a8af0-3cb85df1315mr13083897637.11.1786012742793;
        Thu, 06 Aug 2026 03:39:02 -0700 (PDT)
Received: from [172.17.0.2] ([52.161.51.153])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31586401627sm32020136eec.10.2026.08.06.03.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 03:39:02 -0700 (PDT)
Message-ID: <6a746446.666420a4.2af57e.2445@mx.google.com>
Date: Thu, 06 Aug 2026 03:39:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1224768788296539370=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chenguang.zhao@linux.dev
Subject: RE: [net] net: 6lowpan: fix mismatched comments
In-Reply-To: <20260806091045.1701326-1-chenguang.zhao@linux.dev>
References: <20260806091045.1701326-1-chenguang.zhao@linux.dev>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1224768788296539370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1141343

---Test result---

Test Summary:
CheckPatch                    PASS      0.60 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.26 seconds
SubjectPrefix                 FAIL      0.08 seconds
BuildKernel                   PASS      29.09 seconds
CheckAllWarning               PASS      31.93 seconds
CheckSparse                   PASS      31.47 seconds
BuildKernel32                 PASS      27.65 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      477.43 seconds
TestRunner_l2cap-tester       PASS      67.80 seconds
TestRunner_iso-tester         PASS      94.38 seconds
TestRunner_bnep-tester        PASS      19.07 seconds
TestRunner_mgmt-tester        FAIL      226.21 seconds
TestRunner_rfcomm-tester      PASS      25.07 seconds
TestRunner_sco-tester         PASS      30.98 seconds
TestRunner_ioctl-tester       PASS      26.25 seconds
TestRunner_mesh-tester        FAIL      26.20 seconds
TestRunner_smp-tester         PASS      23.62 seconds
TestRunner_userchan-tester    PASS      21.16 seconds
TestRunner_6lowpan-tester     PASS      24.84 seconds
IncrementalBuild              PASS      24.58 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.263 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.335 seconds
Mesh - Send cancel - 2                               Timed out    1.989 seconds


https://github.com/bluez/bluetooth-next/pull/539

---
Regards,
Linux Bluetooth


--===============1224768788296539370==--
