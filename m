Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C02E210E4
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Feb 2024 14:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706884347; cv=none; b=EpNTUQSUH9AfE3jfJSUFWxI7Dk/pWRyZ/NQerJ+mczD7Bnf0BYf7Jmk3AYTH8DE9e46NYOrlYCvelcKhIbhO9NttHSxJYAEyepAKLNkzCnBUvMY1j0NOpzSUKkrZGDSqZ1PHf6oMVMp09WjQbGC54koSMzvtM/uLgX3ALVhe+e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706884347; c=relaxed/simple;
	bh=hsj21j9CduJSLROJxFdo9TLutOVrkWdWB2yZ2k8o+5M=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hmHfTZ3+lJYiXKsZeCKq1mkkBqWO64mb2CI4h3HYCfQgI9X75wZr7hN8I5iEk0F3I/v7sCaqFWT4bOJigdzUs5+JsRxSNiH091neYG91DSOfrjHwyvlmrTHHas3YMaOqw/3ST/iqkqZH9qNIUJ7XDnNLVYytZZOO1KDSNh19mP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wl7btYcY; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wl7btYcY"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5d3907ff128so1842359a12.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Feb 2024 06:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706884341; x=1707489141; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+Q2QkArjIAFMRTCCBhBto/lePKjuNVUQeBc4CMRModI=;
        b=Wl7btYcYlJGH0tBKmdOcHuvMkVGGYZTTNnrLwUAHffjiQlJJwl8Tz/g74KtNbBLwY2
         UBegQzAeMCj9otImQx6yVsuAomTFzeyHBH2rbQjHzT93q83ZIt2eK6mjNGuhN05e3GIU
         Zoi4TsdxjsF1ABZ3Ct//18Shi5jIQucTmwdY4RV4o3l2DCMNFaPC1VOyGLJD+LXOWA7n
         JJWmubk4OoZXMq/VvMh8x940CdhmOVrobG2iG+FNo2Ni3o//u67/wtNmZGYUuyOHH9sh
         dE3FyZ0zSJK7B8JF1pTHPjppO6+7hDT017xvh2lMh62CeAGA64/NhbPRT64Ox6ZfWEIF
         ud/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706884341; x=1707489141;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Q2QkArjIAFMRTCCBhBto/lePKjuNVUQeBc4CMRModI=;
        b=FuTfWCnuQophnOqMX+ynAeljrRynOYmxIuMSWOg83xL3KXDXs1b4jZOreMv1LUt1PB
         OVkVpIM263rtOnLyvTV1wotd2/QLOzaHw4wa0kRZ5EjVXIKZt92tjNCA0A/wIvEf02zT
         qbh+Qr10kg21gsNj1PcgA+MIsryzITROuHiFlAHMu2Kbg5CTeqk4fl7Iu9F+N2Ikze2o
         pXU/nnWFCkPOpWlwOv/9o8wQzKCg3W2aR7JooNdyF9PWZ9Z+/eBLEi/QTONs3rEKueXT
         dnQ5JTol70/3FUZYYmg+i5QM3ezAjFdg/ZKK0q/Bmo67LRw17S42ra1NEoiDCabYD3To
         aQxQ==
X-Gm-Message-State: AOJu0YxfipJNgJFZqRz7xzRC10yrvegtzsl4Owk/4DkqULRyzR4BVska
	YL5GEwNWxayxeoCj9yJtkfEJz0glbLfIVcs5zeUzG4uIDudWYC1LzVIhkZXo
X-Google-Smtp-Source: AGHT+IGMcy6vmLJLSNqPMMZ/4Sn6hr9NFNYrhmRPm/T2xWHtXT7dW9Po5TMNkMqvgqr3fo8X3kr49w==
X-Received: by 2002:a05:6a20:9719:b0:19c:8447:1c41 with SMTP id hr25-20020a056a20971900b0019c84471c41mr7963501pzc.44.1706884340589;
        Fri, 02 Feb 2024 06:32:20 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVA1/Ymj95T2erMBAjvTBPzeITGQQQD3bnDv9Am5ZL7ba1M6DvqNG+3aMPdqSNJzUGIn9EkeWufAdePkNppiSPDmTbbzw==
Received: from [172.17.0.2] ([20.172.29.177])
        by smtp.gmail.com with ESMTPSA id m13-20020a63ed4d000000b005cf9e59477esm1739371pgk.26.2024.02.02.06.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 06:32:20 -0800 (PST)
Message-ID: <65bcfcf4.630a0220.5f704.7412@mx.google.com>
Date: Fri, 02 Feb 2024 06:32:20 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7476445702808922546=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3] Bluetooth: Remove BT_HS
In-Reply-To: <20240202134854.1479497-1-luiz.dentz@gmail.com>
References: <20240202134854.1479497-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7476445702808922546==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=822531

---Test result---

Test Summary:
CheckPatch                    FAIL      2.68 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      27.30 seconds
CheckAllWarning               PASS      30.21 seconds
CheckSparse                   WARNING   35.12 seconds
CheckSmatch                   WARNING   97.21 seconds
BuildKernel32                 PASS      26.49 seconds
TestRunnerSetup               PASS      435.24 seconds
TestRunner_l2cap-tester       PASS      23.13 seconds
TestRunner_iso-tester         PASS      47.32 seconds
TestRunner_bnep-tester        PASS      6.80 seconds
TestRunner_mgmt-tester        FAIL      162.25 seconds
TestRunner_rfcomm-tester      PASS      10.87 seconds
TestRunner_sco-tester         PASS      14.37 seconds
TestRunner_ioctl-tester       PASS      12.03 seconds
TestRunner_mesh-tester        PASS      11.96 seconds
TestRunner_smp-tester         PASS      9.72 seconds
TestRunner_userchan-tester    PASS      7.15 seconds
IncrementalBuild              PASS      25.35 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v3] Bluetooth: Remove BT_HS
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#94: 
https://www.bluetooth.com/blog/new-core-specification-v5-3-feature-enhancements/

WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#263: 
deleted file mode 100644

total: 0 errors, 2 warnings, 0 checks, 1560 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13542909.patch has style problems, please review.

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
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 497, Passed: 486 (97.8%), Failed: 5, Not Run: 6

Failed Test Cases
Read Ext Controller Info 1                           Failed       0.162 seconds
Read Ext Controller Info 2                           Failed       0.192 seconds
Read Ext Controller Info 3                           Failed       0.171 seconds
Read Ext Controller Info 4                           Failed       0.175 seconds
Read Ext Controller Info 5                           Failed       0.198 seconds


---
Regards,
Linux Bluetooth


--===============7476445702808922546==--
