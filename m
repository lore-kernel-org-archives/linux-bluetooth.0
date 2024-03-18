Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF3A39AEB
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Mar 2024 13:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710767416; cv=none; b=EnvxrLpOw1lm2XuXd6wKDtrKIt5KT5LMyZtmVf8CW3l9MmifjhmcnUHbYygQ/QpiMmN9rueILnhenSfHLAXhBECiD9UXodvzHHJroZxbmoMlmdmy9zY0ed63U088Ccjl+/fwaYh6/Ux6g7ILakz2I5qoSRckGluWlMHW/xIkocM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710767416; c=relaxed/simple;
	bh=BNZoW/l85RhsHZOlCnzsWgcVgjk62nbvzLqt1CICCuk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=st9rmLXfIXHhm9svLhUPQnmeYTzWaeuuaignBFMeFgXUBEzKuw1sSGx6qY0jMKCgkgQcV9mCtRy6gcjQL2dzmnAAm+eGc0XVLRDzx1E6hqFYkf1OfyBB6rjWDWrbIJeH2BtigXJV44Nf2UPOpYdD2Ajb4q38oERDL9o/+q+3cDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H7WFMUJV; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7WFMUJV"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5d81b08d6f2so3446218a12.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Mar 2024 06:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710767414; x=1711372214; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KBB2mDNHft6WAWGr/bbVUvS52SAjS0plpn1IgpvCT50=;
        b=H7WFMUJVmhAe0Hpg+MdxmPJyoZlRQwAn51hV21IkEtt1XNfJVgNrATYT+hEWkoASDg
         L0Aj5CGcJ3kGCDbxWW15P6Y6TNmbOLqMxLXQGyMCE6RzzDTgVh6f+c3TWHhJlo5Jo/Qs
         iVcbCS2bgthVVwkKImyqouDhLoo/0siWznA4s7HenVNgayfy00MvPOF+6zOTS8pXAdHR
         4rs3S0QoJsR4DOb9zdNfglqFKJQOci9msrprktD+GQwQMxDRA1UEldOoahSBsqKSXyW/
         VQC8TfTridJ6noClBTtAL01s5KKRDtrx33/yQx3jPdZeBFh6x4qI7vSvB6NjSmfhsnhF
         RqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710767414; x=1711372214;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KBB2mDNHft6WAWGr/bbVUvS52SAjS0plpn1IgpvCT50=;
        b=ZXAOQ47/hpVSwSASUvwrIeY7kPCHRxuvHH3QiYYCx8Kn0Haz0obIMzJlsdZ3vlHTSx
         nTxJvbxM7GOL0EqkN7PA6jNu7gufM4d171M417CvEnqjbSA6n4QY7feOh1k/WkLospWM
         4rORvWLzJhK4hqjVLFEihJAHHfCA19UirPq4TEgchw4nwgU1Uis8u3H0CGAeiKB81ZC0
         vlP4s3wvk37QMGy0SFOzHc99CvqAgdmv9qqxdynb9we3j9bf/x1PR2ammxSpj64Om888
         ycfJ3WqsVt/U+RddLiGplniP6yaYBgQZT8I+kzz0dcCVLuCxTJsGowoZ0ZpZtdnmdF8W
         4beQ==
X-Gm-Message-State: AOJu0YxyVLX0OWpUdl44lsiCkcTbe7EL9joeLuaGZ0JGUbQ0YKE8CAzK
	EcppbBfofNnZ0vVOwQwuHn9VbRHXqnPkxKIaOksIw8FSnB/NxnG+yyUlnqUA
X-Google-Smtp-Source: AGHT+IH8rzY1Ei1zdMhcOrT27c5Dmsr7uu5U/8YgGc0Q8JhbRoJJW3cpt9ONlpDXkhl52HSEet7DOA==
X-Received: by 2002:a17:90a:b109:b0:29d:f7d2:ccc8 with SMTP id z9-20020a17090ab10900b0029df7d2ccc8mr8271778pjq.0.1710767413640;
        Mon, 18 Mar 2024 06:10:13 -0700 (PDT)
Received: from [172.17.0.2] ([4.227.114.106])
        by smtp.gmail.com with ESMTPSA id nc16-20020a17090b37d000b0029bb5a95a3csm7566738pjb.55.2024.03.18.06.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 06:10:13 -0700 (PDT)
Message-ID: <65f83d35.170a0220.97814.3479@mx.google.com>
Date: Mon, 18 Mar 2024 06:10:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8113065905161292658=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mahesh.talewad@nxp.com
Subject: RE: LE Create Connection command timeout changed to 20 secs
In-Reply-To: <20240318123712.9729-2-mahesh.talewad@nxp.com>
References: <20240318123712.9729-2-mahesh.talewad@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8113065905161292658==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=836066

---Test result---

Test Summary:
CheckPatch                    PASS      0.49 seconds
GitLint                       FAIL      0.47 seconds
SubjectPrefix                 FAIL      0.32 seconds
BuildKernel                   PASS      27.83 seconds
CheckAllWarning               PASS      32.20 seconds
CheckSparse                   WARNING   36.11 seconds
CheckSmatch                   WARNING   98.74 seconds
BuildKernel32                 PASS      27.90 seconds
TestRunnerSetup               PASS      517.55 seconds
TestRunner_l2cap-tester       PASS      22.12 seconds
TestRunner_iso-tester         FAIL      32.70 seconds
TestRunner_bnep-tester        PASS      4.71 seconds
TestRunner_mgmt-tester        FAIL      111.33 seconds
TestRunner_rfcomm-tester      PASS      7.35 seconds
TestRunner_sco-tester         PASS      12.96 seconds
TestRunner_ioctl-tester       PASS      7.75 seconds
TestRunner_mesh-tester        PASS      5.79 seconds
TestRunner_smp-tester         PASS      6.99 seconds
TestRunner_userchan-tester    PASS      4.93 seconds
IncrementalBuild              PASS      26.30 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1,1/1] LE Create Connection command timeout increased to 20 secs from 4 secs

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (84>80): "[BlueZ,v1,1/1] LE Create Connection command timeout increased to 20 secs from 4 secs"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 117, Passed: 116 (99.1%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect2 Suspend - Success                       Failed       4.211 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.173 seconds


---
Regards,
Linux Bluetooth


--===============8113065905161292658==--
