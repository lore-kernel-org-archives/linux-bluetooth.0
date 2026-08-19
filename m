Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB573B71DA
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 15:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787152762; cv=none; b=nuVesLORndFQLhoiUTB1/DzWaCyKB2+9NZctHUCaXDEhDUMoDuUDDW90Y7EI68YB+dDoDWc6Vnc15q68LLs+uOYCCOUHqNNp0lWwQw3M5mQqkc5750xSFAf1oAGcpc/+k7XbWtIN0o8Hzlhge2y1PbAmn9i0mP3lKTODtMLDf/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787152762; c=relaxed/simple;
	bh=A8BdXVDercn0v1m0tN2bikYV3+m0fQV/6RL7TU6PB8M=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nkB+MjMQbSUYZtD8NlqTa+jINgV0uuRpTLgeKhUWVNZBA8Y2Iy78Z4eBkI7mHsUanBGwVObQDYMRyK8d6/3c+6OjT/uluDKokA9dYCEs361hjgn6eeSRNIN19npLz6JYgK+Yc49kzrTCoW+phEcBsT7whg0XNqSfaHojGsbRlRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q5H4whmn; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q5H4whmn"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c0c45c580so6878241cf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 08:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787152760; x=1787757560; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8/9a+HYR6i+mR+XjomN/yxEqNknmbVm3BfeWdZq6Pos=;
        b=q5H4whmnYhzq8f5x6R5iWqke0GXHrqDT9VN0TM7vuIBV4/LFVgV5fuCDZRCgMRQ/GK
         p0QH2K7CU/hok0UXueYY/zK2rVmYXLVBMfbCQvI2qPwANfs1Boddo212sSDiIfh7FIi2
         xMMU52KPv6Xp3ljpZtumg/dEIKKndyVixLKFy1hujnw+m5GfNZc/9EmFQHwbw55mBAfh
         MxwHhJ7gUoYUKUMdvau0QVPsJZ8chzeBeaJKBFLkvkEORlHYuxxxRsASFxrd24bB0iW2
         ZxC08Pxf3cV3wV3WU9OSaD20kYQ2Gen2L86+5Hex6NwH4gI8TOo2IqUGe767w8DuP+JL
         sfsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787152760; x=1787757560;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8/9a+HYR6i+mR+XjomN/yxEqNknmbVm3BfeWdZq6Pos=;
        b=JXSCxFBuZw69WZjoNgraKzoQbn18Co8NBnIcgGQgcyyTza/9eUxKDyju4KifFwAGO7
         EjWzETPglmmPrJltzfMLB03+PiB4aRJ9BhuKh3wU0JWjQpsgGhWtFBF/hqkC1Z8zqA0e
         jRwKBrvQASQQxo+oU3BIRUaqfLCnQu32EEE2IIzbG09pcvWhhU6tQW5bK/SHfCneqSjf
         uAnP4w9maCH2RHEesa2VH/nx1XLFViqSVApLd7eVkVU01OJYWZM0aBK34Yi5geYr3lZW
         Bph8MWMneSlLW55MmQM0PpscLAlk4/hawOgb2RhmMkSytC7sHkhoGAbgaGGnPVYBLiMH
         Z8FQ==
X-Gm-Message-State: AOJu0YxqzemvsS6e98VYafs3vQ0iW+K0W9IOd4UqPrYlS9gEzGAK0yBF
	9ehZVm3w927q1RO4DL3UqGEOqgYabby12waKG7EesIMmcHw/1YbxLp7un6RIPQ==
X-Gm-Gg: AR+sD11uJAaY/wM9I/sVklnGImajtZa5ZYYDtnE0r9HcAh/S7OC12HHyiik9KbMHT3y
	HWrRb+26lNHdqhI3yYnDQ1Egc0cmMyXN/+ARjZmREj4RIWS7Ij4Ow3CkoYHZ7jaVEwIGlG+Tc0G
	a6oqeMOhze8CuDChSrDkca85OYYhNDt+dMpBGmRcwW7Ox9mWDYW+IJUvByynhI/Jk/Mb2m8E/E0
	/1df16Z/q3WI60LyJTj0xzR68E/W7oj4ACN9qXUGpNtEYvGVmJBvxATqhTqfJhAzBdFC3uEpB2Q
	nr/DcKfkI/Fpap1CaaJ0KZZbbtjG6xbqdHIWUiKFZVwc/yhxB1r66pQXmRAkiK2puFawqTGgMl2
	HbvbLiWqMFLqh7FucXR24IX7BKbSBx9sKdAlYVl0TxfDqT1JlvXJOymOeLHgjDtos4K6Rsg/PXR
	vfJ++dKES2mDL4lamxVTuq+ee1OCAvvMoaRt6IaIo4eV+9Ndrh5UNCk9UxFfuJK2mhE3QM6g==
X-Received: by 2002:a05:622a:148c:b0:51c:164b:b242 with SMTP id d75a77b69052e-52dd57bfa81mr44617661cf.15.1787152759933;
        Wed, 19 Aug 2026 08:19:19 -0700 (PDT)
Received: from [172.17.0.2] ([172.190.118.184])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52dd86f33aasm12957481cf.17.2026.08.19.08.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 08:19:19 -0700 (PDT)
Message-ID: <6a85c977.f19865d3.3d094.30f3@mx.google.com>
Date: Wed, 19 Aug 2026 08:19:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9171736756813212478=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v2,1/3] Bluetooth: btintel_pcie: parse FW memory addresses via mailbox TLV
In-Reply-To: <20260819143219.22728-1-kiran.k@intel.com>
References: <20260819143219.22728-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9171736756813212478==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1148516

---Test result---

Test Summary:
CheckPatch                    PASS      4.69 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.95 seconds
SubjectPrefix                 PASS      0.37 seconds
BuildKernel                   PASS      27.70 seconds
CheckAllWarning               PASS      30.58 seconds
CheckSparse                   PASS      29.12 seconds
BuildKernel32                 PASS      26.62 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      505.00 seconds
IncrementalBuild              PASS      29.04 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/619

---
Regards,
Linux Bluetooth


--===============9171736756813212478==--
