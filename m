Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295F22C9D
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2024 10:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712917964; cv=none; b=sY/oWkqExUMGM4aELxy6jcbnfihgqP+EwRti2UkIrs8V3mGuN5DNvAhsIBTTlxKPtRSLqHb/5T1lZsfxgYrY+k568USS8/9WTfSXhp/DSjGapzG4CfHJE3CZpOQ5qKbwMHf+sIKRdrdeFGbguTQnAQN8GhlnlvOBN5c+318szoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712917964; c=relaxed/simple;
	bh=UVIigIyLvPW01u7fYBNt8j7MmkKrjqObMzPGoZt0k60=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cJXyUkqYXHRXV0x50NtwHnRFyGTmZo3jYH2MtrI6AYbenQaDb+WhjZTjhZnGNHkXlHP01vrOcDBJ8EgHA3ReHaV4eEr+mD4AqDKmLgaycVHOSBlwfogCJ5uAM9vNzhyi9MkrQuRJSS+O4imI3V4UY8p1ITza1kjggP867BDrqMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJJAJXaE; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJJAJXaE"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6964b1c529cso5487906d6.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2024 03:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712917962; x=1713522762; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nrq1FunC9Azpt01PxvFBNBQWZB/nhOuCuV8FhaM588g=;
        b=IJJAJXaEQY72KeY1WXBW7/3CaKHncWi7CeXfZ/E+WT9iZpCKfHpMrq8oqJd96Ps0fU
         zg7R6z8h4bQhb7wBsbE2VcmeRXKQpgUhnHmeArMBdrQ2qi0fvxx+VpUugt+9GsI0fMc6
         jF60/HB8YNGnex1tSf0gsvicDFBBjziUFkSfhnYleJQrI2yc4XrYS4NmUHjRhOFFOV6m
         F5K8F5cK/qnZ9DNmfsila6LoYPQYb0qF2Mv3sSiX6WP3zKy3uhhoHnW/XTMeggr6nYkN
         oV9oqt+AtFbpjqksqFXgDJTUyeZm/e6mqGNrtLqojfoBB61VsIhxJWqFXCf9r9b0y2IM
         bFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712917962; x=1713522762;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nrq1FunC9Azpt01PxvFBNBQWZB/nhOuCuV8FhaM588g=;
        b=dDXuaq4uueyavNoaxu22tmGb6bN6iuqQpCqbN38xtPiYo3mjXQlvw9eRrTBlwYlx7n
         +SwKLBabcI4X1FtV8zQ13ds8oNvlT449kzNoiRJGCgb5L0gFZxGI/8dkEQ2CHbIEeK3p
         Yx8iExGRHaJbutzSVmdU9azvhJR0QdURpzqn9xepnfjh7jGpoLI4UWOFDqaTk01C+BGT
         v1lp/BRvLoqIi+eHyQC3RpdxjbFiXR+KoyMF/euZY96gSRj9AK/dL2FG5PSTQMU3EFlu
         DeCHqaMI3mkr+EhM1RIm2zLGMeCUd/eAA2kBTcc5rz7JyrZlD0VQ5SPnT7D5KclfqKji
         Ut7A==
X-Gm-Message-State: AOJu0YwkIoBQkJQHiPo85AsStwgmZxODKQGR66nIMGt0jBUYR6IqZ29f
	8k4sBVaJAsQVtwOt0BYrKmMs9GAkn+hr+ZjSupk0ZvQL/SErvceNxCLsnw==
X-Google-Smtp-Source: AGHT+IGGvWvYldy9r6K/E/9z/DqTVxEbTP8+KuZW6s0u3rp7DwFgfdYROaqzrDdI5Ur+kj0ipGL0dg==
X-Received: by 2002:a0c:c20e:0:b0:69b:901:b076 with SMTP id l14-20020a0cc20e000000b0069b0901b076mr2347764qvh.9.1712917961949;
        Fri, 12 Apr 2024 03:32:41 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.38.39])
        by smtp.gmail.com with ESMTPSA id u7-20020a0cdd07000000b00690c9256676sm2147846qvk.49.2024.04.12.03.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 03:32:41 -0700 (PDT)
Message-ID: <66190dc9.0c0a0220.91b1e.4c3c@mx.google.com>
Date: Fri, 12 Apr 2024 03:32:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6358378980592633497=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hao.qin@mediatek.com
Subject: RE: Bluetooth: btusb: mediatek: Support auto revert for MT7922
In-Reply-To: <20240412095713.25641-1-hao.qin@mediatek.com>
References: <20240412095713.25641-1-hao.qin@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6358378980592633497==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=843968

---Test result---

Test Summary:
CheckPatch                    PASS      0.65 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      30.20 seconds
CheckAllWarning               PASS      32.67 seconds
CheckSparse                   PASS      37.98 seconds
CheckSmatch                   FAIL      34.57 seconds
BuildKernel32                 PASS      28.89 seconds
TestRunnerSetup               PASS      520.17 seconds
TestRunner_l2cap-tester       PASS      18.41 seconds
TestRunner_iso-tester         PASS      31.10 seconds
TestRunner_bnep-tester        PASS      4.85 seconds
TestRunner_mgmt-tester        FAIL      111.40 seconds
TestRunner_rfcomm-tester      PASS      7.44 seconds
TestRunner_sco-tester         PASS      15.13 seconds
TestRunner_ioctl-tester       PASS      7.83 seconds
TestRunner_mesh-tester        PASS      6.05 seconds
TestRunner_smp-tester         PASS      6.88 seconds
TestRunner_userchan-tester    PASS      6.20 seconds
IncrementalBuild              PASS      28.97 seconds

Details
##############################
Test: CheckSmatch - FAIL
Desc: Run smatch tool with source
Output:

Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: net/bluetooth/hci_core.o] Error 139
make[4]: *** Deleting file 'net/bluetooth/hci_core.o'
make[3]: *** [scripts/Makefile.build:485: net/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: net] Error 2
make[2]: *** Waiting for unfinished jobs....
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bcm203x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bcm203x.o'
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Remove Device 4 (Disable Adv)           Timed out    1.886 seconds


---
Regards,
Linux Bluetooth


--===============6358378980592633497==--
