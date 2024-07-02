Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7D61CCCB5
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 19:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719950390; cv=none; b=WYoVBsYKAinLMz4bZsjFZpudy4zclxWcKSp+sGiiOsFKvP9v8D/YOd0H9xDgpJ16Coyd1GmPw7UPx6SSR+Ei2f6ZcK89xrDL2L16+qmMAlageqkU6JXOpeoL6vRZJpRglxqV5Zz2QaiDKW7aZpsH7YnlRvgBHuAvdRuYkr6C9Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719950390; c=relaxed/simple;
	bh=A4nXR+xqFGpcMDW1IY/ImjjkaQj3eGLkcgIvRd31pAk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fOOtZzFJHCdoYu3YV1v6zN0u/I8Vk1Z8OeoMjqxl+Hzt0cIPe3yD0a/iy1P+854w5PKBWoUoc3cQsBs2XpX+0u4IesTcvhKdq5wryiwMN4mQ/fyCC/g57y3Kq7CqrifSkjo3D3ZVDju0Tt3FfLugulBAiRwlkIhLnpI72ceJFfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFw8Kqf7; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFw8Kqf7"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-706680d3a25so3274177b3a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jul 2024 12:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719950388; x=1720555188; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=roukTMe0FdSJUP0ehPBZZmM922FE23JOLmWGsRa2vxA=;
        b=bFw8Kqf7lGhwe2MDeqggHx8SkJKIkSoWJfsKkOdUqLr9CPxECU9GL0iECct62I+olN
         byceG/oaOsTRTF3seO3jepTe7Elr7HDVsJ4hAvkYm73eIKz7t6oN5OVcnpASe1oQkA+3
         hRwS9rY8j1kjU9sWWjUHJ42gMqqiGXgGTXJ35NqGVGXAjY4De8M5cqqeqg4wJwCY7een
         +JYbyOaXfYy5AxScbehTYPak5m9z/hFzFDIfBy1SGDufhtaauDjO7mS7W2Vf0ANOi4O5
         +zaHlfHNPgCcYrVLg7TffyFWkYUJmyX8yQvaGjpRGrGB84q0RctH3J/AC9ydS6rRoVd5
         td6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719950388; x=1720555188;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=roukTMe0FdSJUP0ehPBZZmM922FE23JOLmWGsRa2vxA=;
        b=qmWWr4A4GzcpSivHFGkp2f5MZJ4QdQvayQmvJflTptKqkzfq93DABTpupFKoyL8g/9
         6ghNPxvcCLTBG8d4XvJfPemqi1rAEQXFFaXhnKTaYySX/QtChmduC9IReFKp1/m2ZsOz
         2mW9LQKmbPyMKvSM1EdP9zuF3WgY+YVTzavoyeXSLFud8iH2/QDIy37Emz7+dWAMlovb
         s2RcRWHi/UP7JZKjpBIh3tfEjpswy+qCHoRnd0Xqut8CJdTcoD19IlZgsg/7ZjTnoQ0o
         A6ecPeou5cIw6zzuj252hGCUaq52cBioDET91lyliUz070BVzNPqlNPMYjiXOv/iIKX1
         YQsg==
X-Gm-Message-State: AOJu0YzB7za31E+x4eLr6V04CMx/e2vU/5E6ydgP4uMxCC+aPrMloone
	NgSAjzAYrMW/6Sf5Aq/FSzoHJzq+h3xyTNYY24xYcDSJGo5J+W6ZluZpUA==
X-Google-Smtp-Source: AGHT+IEjBQhT9uRO77uH71Ob3/erJPo0h/8vrqIXAniy1LqWQV8QNdAbMT5bRqPjaafbsAt+8h7SEQ==
X-Received: by 2002:a05:6a20:258f:b0:1bd:18ee:f141 with SMTP id adf61e73a8af0-1bef611b9b9mr9190263637.4.1719950387993;
        Tue, 02 Jul 2024 12:59:47 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.38.45])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70803ecfbdesm8936730b3a.105.2024.07.02.12.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 12:59:47 -0700 (PDT)
Message-ID: <66845c33.050a0220.62920.190b@mx.google.com>
Date: Tue, 02 Jul 2024 12:59:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0977156019709358387=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/5] Bluetooth: hci_core: Remove usage of hci_req_sync
In-Reply-To: <20240702191157.1722089-1-luiz.dentz@gmail.com>
References: <20240702191157.1722089-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0977156019709358387==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=867689

---Test result---

Test Summary:
CheckPatch                    FAIL      5.53 seconds
GitLint                       PASS      0.99 seconds
SubjectPrefix                 PASS      0.38 seconds
BuildKernel                   PASS      30.22 seconds
CheckAllWarning               PASS      33.19 seconds
CheckSparse                   WARNING   58.46 seconds
CheckSmatch                   WARNING   105.44 seconds
BuildKernel32                 PASS      29.48 seconds
TestRunnerSetup               PASS      536.15 seconds
TestRunner_l2cap-tester       PASS      20.33 seconds
TestRunner_iso-tester         PASS      39.70 seconds
TestRunner_bnep-tester        PASS      4.87 seconds
TestRunner_mgmt-tester        PASS      110.65 seconds
TestRunner_rfcomm-tester      PASS      17.25 seconds
TestRunner_sco-tester         PASS      15.07 seconds
TestRunner_ioctl-tester       PASS      8.06 seconds
TestRunner_mesh-tester        PASS      5.97 seconds
TestRunner_smp-tester         PASS      7.14 seconds
TestRunner_userchan-tester    PASS      5.06 seconds
IncrementalBuild              PASS      108.20 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2,5/5] Bluetooth: Remove hci_request.{c,h}
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#192: 
deleted file mode 100644

total: 0 errors, 1 warnings, 0 checks, 61 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13720181.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


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


---
Regards,
Linux Bluetooth


--===============0977156019709358387==--
