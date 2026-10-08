Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374E54E237D
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 15:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791473229; cv=none; b=VUOersdIUiObcnVVZAZYlcX1Y4+Kot7An1uUdKZp3o9IKybzHg5NpxgbJ86e9vu2BTc6cpQN07s6mmhswKusyza+5qXEXfQy4lYjxsx6tjTfNJf8TVAfHTBGioEoA0nx3LpQ2c8Zu36MD9R1arCJRAzGths7LQvRli+yUFdeZ84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791473229; c=relaxed/simple;
	bh=gs2kHcu1oq+sNG5Ox2wkgrb4oewF2SJ1Ly9wU3B7638=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Ub6UdCmWUXgFjuMBtOhi9D4NGRFZ9YbdL9OWdZbS+SCVw/YV4eE3Si+vWfo7wS9MRgOxDonx8y/X60SxwXh3aaII2VtPSs5KeTukT0lLXoTUFTJq4ZLZkWmyEBW57nXuThQzqKBAviTYSSDziwwrJQ+f60+xTRAVMEZfVub6tBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhY/GOqS; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhY/GOqS"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-914411dd7ecso10650856d6.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Oct 2026 08:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791473218; x=1792078018; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Sffb2MtIX7tWFGIAPQQLLH22Us16EUWsp6C4S3Qq0tg=;
        b=BhY/GOqSyC1F89fH/S5YXc9vfBJWgduM0a1DIjCfjxEb/tT+8K0C/wGF/n8ms3mHi6
         y6TRcUDyDipTPARAsOCxapxylWQbiraC5LbXUZbeMZU099rfRFcVef9mDYjuQFt1Wtu5
         1YhbbZKIJd9jiBf8XxGBjkbsN1xJBa0lp8+RpkmcieJBBgv2OyNbCeT8VtRKXwnn96mI
         xAbm5ATyC/mKGx7Bl2nKW4AOrx+fw9qXvedvJhKDWFNQw4edLRYQ1kgH5H+v7reAdXZN
         DLHYEVcQfb+ET3oK8/fuUPAr3I5hiB9wkx+kfAfj+8ypCbZp763QyUBcsG0HhIPRiZHy
         LjFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791473218; x=1792078018;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Sffb2MtIX7tWFGIAPQQLLH22Us16EUWsp6C4S3Qq0tg=;
        b=k236URQAKN0oQ78vf0g4WntzcKd2XUzd0k9lJyraqQebgkK7qNMleT3yNxd8EVV4Gm
         mNYGnj8wEf6A5xRURcdQdUT2k+WK+qOJ+mmR0eMydvznZYn1UJkJywOCgPlDOr+OJ/sL
         /V3BZKtLkd1NZPHs6tMtduyUGbvWS+hH7imvulPugne4TWyIMpIe3EPDExfdl3vYcAhL
         WKvB2ZHEBk1y6630kVngESrQfkLbiqkxP1CLTAQmdJLCvaa8wX9gjX/qqmVSANc7qbJr
         E0Yovqofail6EbWzlh21YmjX6/nF4UEqUQxMB8O83rR8E2YhV1HlJOHSjk5DH+Z//5Oy
         OsAw==
X-Gm-Message-State: AFuF++koLkxSNjN73d2dWohw3kFSzzFWWE90LA2vAjpBjMlvBd7iUxEA
	IV0KO9/5PQOh2iM5xvMqAB9wFOBJmzbN10UIhVsaZF+ynnZKPCld4xbb8PzSXA==
X-Gm-Gg: AYBFou3TUrP/wWdd69JaXqfo2sgQhiAAuSPkmCHvj5Fl9JnRlcwWYbjxi+/CcJ4bcaE
	5aSh2W4pWz0/hqhgoiITTyS3NTS+qT3FRnaQM00J/boleI/gmiTVFT551fa5ApHaRKWLOA2kisq
	sIKi6KBIsIEyhCXqy0CoE/VDEhwJIZDB+IPuE7UYL8yjENWBa+mfGdwy1g2Wdn36KpUK6t2nJ7q
	5hLl4qpwjoDg7iJQ/yrxt/sAPwZ7o0KTZ7Mwm8Ns+f9XIRUPNP/cjZLk/c+rKmjBpBOFZqqg+le
	KgiXPY6M/iIU7fHfRQh26xaPsY1bBP9ejU9PTy8nebMkRCq9mv7tMxtss64SrTHgRXb84PS/frg
	YoKRBxfd0M7BZgMA5K/44d9McO1XpHL8EVCkRV8BC2w26Gfz/LAXHJ/pUmL0U/kSlTBL19JpChC
	EqAY4MLTPaV1b6raQp94Ii304oo3SbcPviG+I6MqdKCPZKV8JxUsiDXeyTXveGCvfGQV2/Uvh5k
	bRXCg==
X-Received: by 2002:a05:6214:c23:b0:919:952e:fd7f with SMTP id 6a1803df08f44-919aa9aa95bmr47978466d6.30.1791473217900;
        Thu, 08 Oct 2026 08:26:57 -0700 (PDT)
Received: from [172.17.0.2] ([172.174.165.9])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91996cb9f4csm48476216d6.12.2026.10.08.08.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 08:26:55 -0700 (PDT)
Message-ID: <6ac7b63f.33ea1a9e.e076a.cedd@mx.google.com>
Date: Thu, 08 Oct 2026 08:26:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3492617040456869475=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v4,1/2] Bluetooth: btintel: Zero version data before parsing TLVs
In-Reply-To: <20261008140602.2623464-1-kiran.k@intel.com>
References: <20261008140602.2623464-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3492617040456869475==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1181659/

---Test result---

Test Summary:
CheckPatch                    PASS      1.76 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       FAIL      0.67 seconds
SubjectPrefix                 PASS      0.24 seconds
BuildKernel                   PASS      30.00 seconds
CheckAllWarning               PASS      34.53 seconds
CheckSparse                   PASS      37.04 seconds
BuildKernel32                 PASS      29.78 seconds
CheckKernelLLVM               PASS      35.80 seconds
TestRunnerSetup               PASS      785.35 seconds
IncrementalBuild              PASS      31.58 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v4,2/2] Bluetooth: btintel: load unlocker.sfi to allow unsigned firmware

35: B1 Line exceeds max length (82>80): "[  414.150089] Bluetooth: hci0: Firmware timestamp 2026.39 buildtype 3 build 86921"


https://github.com/bluez/bluetooth-next/pull/888

---
Regards,
Linux Bluetooth


--===============3492617040456869475==--
