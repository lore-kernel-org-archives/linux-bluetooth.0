Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABB17347D
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 22:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721948286; cv=none; b=Yufs87TbHxciUtJ3WrNmRagPqvOdRN+rWUBf3Ucm0JBNrFlSV5jMd/7MuuR/9tjxj5jKLntpEkI7wgSn6vi4ZNl2roR4NbO8W3xqc56mAsiJqduo20I0dOGih0P7BiMhVq5OovS7IGygDp07vsRHIbDEF8H31lkhf5EmQfqStIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721948286; c=relaxed/simple;
	bh=C254EkqQhB55mUMEkxXVHKGZOd5kiQHDZIs3gdHHsDY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=owzK02BwQf7YAgDg7rYbYpX9lihYscasBeaAF5IY2M2uvqrRaZul0GpG+FwT7VKMFfzahNHb3uMHtVaJydgk8jvFZc73mlYc4geC3hTEzVjIyM5RE5PqxKmRuqzzyDnuF6HdtmUlUTtnUbfNVKckLmQV7a1aHzsayXd6ATjlCBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VbgxZoE4; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbgxZoE4"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fc4fccdd78so501595ad.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 15:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721948284; x=1722553084; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qNz0ldQ5BL69VzWUMiNkvkryiHtL8NW1mR3ZrHIE60s=;
        b=VbgxZoE4tStCcMtSKLNAjf7HqmnU0xtxPQ6edkBdAEXIZOZxecJSB0gFZhPUPSHVRK
         CeXH78ugT3/JPTMSKGY2RPHqvtfLOqHq0+GLZrX0G2dUBCqYQBT2cXRSnIiKQzqw9Fsn
         sNQxasurPRrZzBC8GxRbWhasvDnP38E0Q4mo6KLNOV1IM7V4LFA0aAt6Ss7zK3xJG9mI
         WJ9H9Pqbe+if2XO9td1NYYYUIvs28zBAReg5zGeBz/4/cbiBm0bLDq50AY34jIBO7c4r
         oxtQpnWHA4noqdUFUnz05iZrpPrrE+d1wgleVOfu5LhcNRWG7jJc54pcWUMuODbWMI5/
         eKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721948284; x=1722553084;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qNz0ldQ5BL69VzWUMiNkvkryiHtL8NW1mR3ZrHIE60s=;
        b=WYCmBVMtwJ3qf+YPWK+umDzFbGJYMnwWsApIV/ezAEh4q6FoPRXuoSVm676D9MyEcG
         a1CApTM9Gq3b6SQ42h2jaZJLHX+F5H6tTu8W1jERJMZCYFwRz1iCL+WgQYzZR14WjX+Q
         zF0hkSHC98D4cfEOeWzVuO32y4j3vodILS1gZNvYHDvjwpcli62nrZBHXXl+Z+kbYjSJ
         Kg3YlObTyL8kXoTKNPQvFEex8tXNg5GI6f4vO2SeVpbV+nEylI17WbUoIYvod2P+37oA
         iGXqgZD2R31vjfWc1NRF+IbviOBfVaB3X58x4pe4LsBnvScC6vWnq211knXmzLoYVypF
         te0w==
X-Gm-Message-State: AOJu0YxeLa0LMmwXHyuQJMBZl+uuezhHzL0+2p54Sw/XjBlp5miaIXQF
	MXf3znNZ92xOYKYTOFGQa9xSeZcDH5ZwTBAycD/pIa2V5EH8BcazHDD0xA==
X-Google-Smtp-Source: AGHT+IHluhUpHExSbyxWKakpQElxs41Tz6xzxCMWfqVyE3egNbrELOrIl5lr+51xv3eXlACKv7dntg==
X-Received: by 2002:a17:902:f54c:b0:1fd:a264:9433 with SMTP id d9443c01a7336-1fed389fb66mr53685465ad.29.1721948284262;
        Thu, 25 Jul 2024 15:58:04 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.38.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f1ae9dsm19436265ad.188.2024.07.25.15.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 15:58:04 -0700 (PDT)
Message-ID: <66a2d87c.170a0220.dd2ba.5f7e@mx.google.com>
Date: Thu, 25 Jul 2024 15:58:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2863274545107090401=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: hci_event: Fix setting DISCOVERY_FINDING for passive scanning
In-Reply-To: <20240725223451.3208825-1-luiz.dentz@gmail.com>
References: <20240725223451.3208825-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2863274545107090401==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=873942

---Test result---

Test Summary:
CheckPatch                    PASS      0.64 seconds
GitLint                       PASS      0.20 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      29.40 seconds
CheckAllWarning               PASS      31.84 seconds
CheckSparse                   WARNING   37.32 seconds
CheckSmatch                   WARNING   101.61 seconds
BuildKernel32                 PASS      28.20 seconds
TestRunnerSetup               PASS      520.51 seconds
TestRunner_l2cap-tester       PASS      21.92 seconds
TestRunner_iso-tester         PASS      34.54 seconds
TestRunner_bnep-tester        PASS      4.92 seconds
TestRunner_mgmt-tester        PASS      112.59 seconds
TestRunner_rfcomm-tester      PASS      7.79 seconds
TestRunner_sco-tester         PASS      15.17 seconds
TestRunner_ioctl-tester       PASS      7.99 seconds
TestRunner_mesh-tester        FAIL      6.23 seconds
TestRunner_smp-tester         PASS      6.93 seconds
TestRunner_userchan-tester    PASS      5.08 seconds
IncrementalBuild              PASS      27.08 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 2                               Failed       0.095 seconds


---
Regards,
Linux Bluetooth


--===============2863274545107090401==--
