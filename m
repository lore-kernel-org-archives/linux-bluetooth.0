Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9426529ACC8
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 08:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751963577; cv=none; b=a7nLgVzdhPWDhgeH5zmlEbhIDDA9Fi4VfqjpI96dMr5ButYbas6wG1NgrM/PDaRld/yAzvG+wl1QZJLyUomXUFRnnsHCZjFCJiZtk9Bqxjmf2laKVzoZSn7xgxD6XKMWtt6skhkG9HyjQJ+VwwyWm8AiXuRM+sUjMRE4AG/fmM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751963577; c=relaxed/simple;
	bh=T/v87ClMaTcO4/mFuTy3r4QtGiBlGOSgKlP+lrqjvAc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OUYzDF3SO/yfK+Y4MT8nkevpul5rIeUcX5o8muUiyJnnRSLiYX4hpWgbLo3Z7WOW0Sw4hLQ8bVa+hqZouw1SXRBh7lMcVo2I3nfI0yk8fgdB0+whOP6oSD2jzg14Bf49ZVAq9iEMq2CUbUiFpitqTCsf+w/BevvaaveW2THD8oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYHJjbga; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYHJjbga"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-86cdb330b48so398742339f.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Jul 2025 01:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751963574; x=1752568374; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8K/1dKZ3bqeVIH/8zqLdibtDQOPyN0N7xG9xoTYK5Vg=;
        b=kYHJjbgaryTRiTGDclkdYE6JBOdiUGlm+vwZ4yeEkhsUFK1wSVSV/tMTurpyehmIa6
         q206BlgQPiMJBb30n3dhWyf/Xt+B8OwQE6tOGO9/Le+os9u9ycPR6aChHZybTSH5GJ5T
         nn7OLZe/ocqdglEJGUwORF7wGNXZIaMguoH9WMaxISDS5pMhv1CjCHnFTjM+fcwGU+0/
         IwNJRe2Kbqvoxdl4X9LYuAa/x0Y4w7G7R3eDALRoWI7BfqagaWRqlXkUx0Y6/7QdcGVp
         PKrz1LAt+LSDLuLBkFJPtgYPpC8fbGZ8QDyumr3JFAW+V7BS5FmpVmqOpFfRX72kM/Pb
         noNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751963574; x=1752568374;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8K/1dKZ3bqeVIH/8zqLdibtDQOPyN0N7xG9xoTYK5Vg=;
        b=vK/mQxaBD5YBvIDKZrBFCZc7GzGS4v46N3E5poqokzim8ysMo9zPU7+sZbNEriSEH7
         dTQ7EAgfGX2AryrkElsGh5rc7kOwGqocwQnUwbWtVbmveopZfISYvFBAenJYsnvECqDG
         YOwhNxub7YmLZdc/tL23Osa4pWnUXU2c1JONcCbk4AQ7JwBoiZZfjNdsI2YdDsf8LFwN
         QJa+BBY26ggmRjbO4uWwCDeK8fnkB4e4EwCvIUqE2U60Qk6wbLGFwad5N1tdlPvE93kv
         cDC8v5g+zTh6KsDJl17QC5Aatw3P+pkBvtpVaM+e1HPme3ow9ly2ApgHiufXF+SE4Yx1
         9bsw==
X-Gm-Message-State: AOJu0Yzs5QQPuWO1DX7mv5pCPWDnGQkW969YccbvbVCoRrz7SdoVd1O3
	3NqZOOfMZ1meRxxYxwfnt4/dCmYg6MeqkTLNue9JxEeAFAUc48O4kYzBMvk9/A==
X-Gm-Gg: ASbGncthtixRf/u80am/+xpW+CZgywXnpGmhF2sXlQF3HBPs6kw4X8UUitc56Bi6uDg
	Bqai0VGbjSAIrJNKULJdEm/7UXY1yJfq5AWnLk97uiZEyx+o6Nye28GTDTmcg8cQmNVcvvlpz/V
	QhdG3yu0rOUMXmeZcOTN4NMvu6nvjdvoZ87Re5M8oSGu/mKhRDpFrfxzd4u2Am05HcrTIqKkHM8
	I47J1xAWFcQa4CbTjqff/peovB++ViBjlU1jJK8ajrHiRM4g1UOBEGsXs78A033Zc45/8PkaixB
	loN1iFUOIi01WBUxk9kI20kLS78zzCGUGdPLIwC1rRPVElm1EGnyPfOzGy+tdJ2rrno=
X-Google-Smtp-Source: AGHT+IF2jFLZ6TIyeTFOdV+k6HluGfKkz20qZMW5l0X3lqgPoNNpK0vG/z1xBV+eWuFfjN/W1N9tKw==
X-Received: by 2002:a05:6e02:228f:b0:3dc:79e5:e696 with SMTP id e9e14a558f8ab-3e154e4bdd8mr14657015ab.11.1751963574473;
        Tue, 08 Jul 2025 01:32:54 -0700 (PDT)
Received: from [172.17.0.2] ([52.165.37.46])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-503b5c20329sm2056883173.108.2025.07.08.01.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 01:32:54 -0700 (PDT)
Message-ID: <686cd7b6.050a0220.3b4167.34f8@mx.google.com>
Date: Tue, 08 Jul 2025 01:32:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8916139506474879305=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: audio/avrcp: Fix crash with invalid UTF-8 item name
In-Reply-To: <20250708070822.185375-2-frederic.danis@collabora.com>
References: <20250708070822.185375-2-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8916139506474879305==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=979916

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.28 seconds
BuildEll                      PASS      20.40 seconds
BluezMake                     PASS      2504.14 seconds
MakeCheck                     PASS      19.71 seconds
MakeDistcheck                 PASS      182.72 seconds
CheckValgrind                 PASS      234.41 seconds
CheckSmatch                   PASS      304.83 seconds
bluezmakeextell               PASS      128.08 seconds
IncrementalBuild              PENDING   0.32 seconds
ScanBuild                     PASS      904.29 seconds

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
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8916139506474879305==--
