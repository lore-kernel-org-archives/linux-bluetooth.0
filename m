Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06C9195FE0
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 18:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720636777; cv=none; b=sQbHUqX0X3Nn+SbdwMqLAuDDhq2Tw90IFk3HfB/bZnGjix5Xj8HxWMIDTOqqHTS6yuXgUUmnDa6yO9uEWjcS8eI7od9mfqGxuwFbKY5KybPlwcxSYqFP96Le/Ji2/GphDLgUXJydfKzXIR6IuNTKgpcBKn1uEYTlN9SDLzdCoaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720636777; c=relaxed/simple;
	bh=aPr2FIbzUWaB+Q4K69owc7LdrFzr33PxUGuqt36+NHw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=h/CN4MXonY2faN10emCYPrQbRWF44UXp+5grI27hRxNqUN8cBEaOHFOEae3ME3UnJ3siGLuLFZXIcRKefhJ5gqV2Wts6w10hTdToYGnLlDCX6Twlifxt3E7sqRYlRhElvIhI9nuk9UJig+ynMFC0UR/ydy4EX3WMWAYZq4ZNLKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHjtpEtC; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHjtpEtC"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3d92d1a5222so79484b6e.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 11:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720636774; x=1721241574; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZN6mp9jA8iSU8fqvwCRZbMeA48Z2xrn8kvX7LyZ2tXI=;
        b=PHjtpEtCaE6oDDQUeaiGzAN/RdLJb5dbWeIDkYhg6PjuH1AmGrghXK5qvsZnK0yVtL
         rykW6BeE2Q1jj5JrU3899gn8uKyagAFNlzif+yKSDM04EsNo/Cq1VJCZv4KWtxxVRj3J
         +H9betDA8V9Z92Bugf8c1aAqkS2+3IzzcXTyrgixEUN0zkoySWTwIkgjAgVTcp75q9Q7
         c5s0qQ3RJ4CFYiOCXxVEct2qPzZPuiJiPZkO8LKoS4yv6jfLHmiUfdHRtbP9Tx4myNKG
         8h9+KjKOmWc1x11e5j6ZMSO6v7E2b0C86qib1XJWK3cxQd1POmik2vEtZzo/oe/9xJcH
         vZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720636774; x=1721241574;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZN6mp9jA8iSU8fqvwCRZbMeA48Z2xrn8kvX7LyZ2tXI=;
        b=udthtpI6uV1D6uifi8siiozz3v8VslPptPntzTzMPF3UxbOF8BkorcmBj/nkQIpqwS
         j1vCEpp9838m+TTYm5EdgY5GM/H4LVa55uHEsnZpJ69ndfe4xLADU9ZpLFYmLSh94Tcl
         FAo1caOhHTHq6Oi0jeCDccxXpyvbM7ZQgJSoCyaZ9AqRk1UO1JFWKrO9aoUSMDUIbFIW
         Bi3CnR3gQrN8OLw1fYBfIIue3SHV+HOvJhogJ7dYVpWnlZNeVG/XBSAV6ddrGdhzg9eU
         fc3EdchOI3fFOwNVzn/FCsex/zLrSgupVr54zqaLUPm1jyfBUnsOJ2nsXdluxTsOKSgp
         ATdQ==
X-Gm-Message-State: AOJu0Ywcz8AQyJ+sHs3e/a+fn66vKPvWKeqSZ5+0NVFSaGMx4Ql7pFVc
	oqGeDoskM00XblUisVORdQtDgCpkdvSQCdIEPM1wXq6f6hcyZF5sj9KENg==
X-Google-Smtp-Source: AGHT+IE5pbycKFfDAagnWUDJHDufNwlINZGz25NodEq3H6vWzpD/BF2gGP9lG+k0K4sdAWus9y9AUw==
X-Received: by 2002:a05:6808:19a5:b0:3d5:1f50:188b with SMTP id 5614622812f47-3d93c01e103mr6278812b6e.23.1720636774448;
        Wed, 10 Jul 2024 11:39:34 -0700 (PDT)
Received: from [172.17.0.2] ([20.49.55.105])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9bf918csm22623551cf.84.2024.07.10.11.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 11:39:34 -0700 (PDT)
Message-ID: <668ed566.c80a0220.3d4e.9fd6@mx.google.com>
Date: Wed, 10 Jul 2024 11:39:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0723780359180074776=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nathan@kernel.org
Subject: RE: [bluetooth-next] Bluetooth: btmtk: Mark all stub functions as inline
In-Reply-To: <20240710-btmtk-add-missing-inline-to-stubs-v1-1-ba33143ee148@kernel.org>
References: <20240710-btmtk-add-missing-inline-to-stubs-v1-1-ba33143ee148@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0723780359180074776==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=870196

---Test result---

Test Summary:
CheckPatch                    FAIL      0.94 seconds
GitLint                       FAIL      0.51 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      29.74 seconds
CheckAllWarning               PASS      32.05 seconds
CheckSparse                   PASS      37.44 seconds
CheckSmatch                   PASS      102.44 seconds
BuildKernel32                 PASS      28.64 seconds
TestRunnerSetup               PASS      523.92 seconds
TestRunner_l2cap-tester       PASS      23.87 seconds
TestRunner_iso-tester         PASS      30.35 seconds
TestRunner_bnep-tester        PASS      4.75 seconds
TestRunner_mgmt-tester        PASS      112.49 seconds
TestRunner_rfcomm-tester      PASS      7.41 seconds
TestRunner_sco-tester         PASS      17.03 seconds
TestRunner_ioctl-tester       PASS      7.83 seconds
TestRunner_mesh-tester        PASS      5.94 seconds
TestRunner_smp-tester         PASS      6.91 seconds
TestRunner_userchan-tester    PASS      5.17 seconds
IncrementalBuild              PASS      27.66 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[bluetooth-next] Bluetooth: btmtk: Mark all stub functions as inline
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#79: 
    254 | static void btmtk_fw_get_filename(char *buf, size_t size, u32 dev_id,

total: 0 errors, 1 warnings, 91 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13729552.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[bluetooth-next] Bluetooth: btmtk: Mark all stub functions as inline

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
8: B1 Line exceeds max length (109>80): "  drivers/bluetooth/btmtk.h:254:13: warning: 'btmtk_fw_get_filename' defined but not used [-Wunused-function]"
11: B1 Line exceeds max length (110>80): "  drivers/bluetooth/btmtk.h:249:12: warning: 'btmtk_process_coredump' defined but not used [-Wunused-function]"
12: B1 Line exceeds max length (86>80): "    249 | static int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb)"
14: B1 Line exceeds max length (111>80): "  drivers/bluetooth/btmtk.h:243:12: warning: 'btmtk_register_coredump' defined but not used [-Wunused-function]"
15: B1 Line exceeds max length (84>80): "    243 | static int btmtk_register_coredump(struct hci_dev *hdev, const char *name,"
17: B1 Line exceeds max length (108>80): "  drivers/bluetooth/btmtk.h:233:12: warning: 'btmtk_setup_firmware' defined but not used [-Wunused-function]"
18: B1 Line exceeds max length (83>80): "    233 | static int btmtk_setup_firmware(struct hci_dev *hdev, const char *fwname,"
20: B1 Line exceeds max length (113>80): "  drivers/bluetooth/btmtk.h:227:12: warning: 'btmtk_setup_firmware_79xx' defined but not used [-Wunused-function]"
21: B1 Line exceeds max length (88>80): "    227 | static int btmtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname,"


---
Regards,
Linux Bluetooth


--===============0723780359180074776==--
