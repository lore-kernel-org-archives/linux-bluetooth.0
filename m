Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57A1191477
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jun 2024 11:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718625461; cv=none; b=RPja4cvMbHTbkbu43hRY4ShJ9/Hnrsma6JKbdNOhvplSr557iAfdEqm+ja2FWqCn3y0jgKeFWcGiy/A8aexuT0LDeotlXRQkPNqVd6/HLRTFl3zCe7KzzxPV3vfS5qGV/68Nl08pzl/qioAu9bA7YXtWn3sI0NfiQ7WJ6uUxHM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718625461; c=relaxed/simple;
	bh=Rf6PBglEuxHqCymJQefj8oxta/slP+vYHlnaxPF8UA4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=TZMmbQsuHbUj3jyu9mso43XkhmOCegt0hCxyTX5MGr6cIfHkXCqiCbNDkTN/uS7f6OUkd8JOdm1Cg6eFBxxQ5W8nfMr4bF+8WojMWiPckrAXIUn+7cDeq6NlbMIjKVW6qoxRiWmlQkqWKMz8cHhGh0mRzk/L5h+5+3sGAAlAoCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXp1HwjD; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXp1HwjD"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dfde5ae0aaeso4384928276.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jun 2024 04:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718625459; x=1719230259; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QRcsLKvc+Bqtp6VOPDsvexvIuPIu4vTqOf4BgTjYwsE=;
        b=RXp1HwjDPiW76WwTJUASfKvGoQJdzUR+iEjahs8pCTrje2CYSmYfuE2ZBzznbafKJz
         6PU7Rr5YOWovg7I2JScmjxVHqXAc1qs4Tw4kyO4UlJZLTvfvEyfSPLJY7VwhMM3L+sW1
         LxaXv2Y/6y9SQF9sC5vfne6kik27UCHGc0bbgcvC3saUFPJZsVM0VVKiAL4OkYFfjnMJ
         wK1ym0XYCnSbaviEX/sSjRuFwEeTLGJUbH9baabcDKYm+9WhRLeG7rVkIkULiQg8LfkO
         c9VVLxUHmbuN0n1+yV5ih5bowBrRvXpI0yNZuVgdcMOsYGqkXCECqavpVvPGPxwkG378
         bkdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718625459; x=1719230259;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QRcsLKvc+Bqtp6VOPDsvexvIuPIu4vTqOf4BgTjYwsE=;
        b=PBdLhaM39q0cB+K23dc1A5gj42lJdn5cMpOt8MYzMuUrKBcn1aBNNx6JcSoA19bDi8
         IYB3qytGoTzMnqIffAplGLN13ua6ZmJC6gjFuQ1oZkvorjdHV8HNfulx9nZKy+ouzbKF
         c3dJwaTtDondWIOigbn5t4UIiQGCVPXqKJt9/WQ6fyHrOMp0DbX3H/du///vL9i9r+Xz
         IuH8jKtRhifu5DHnvMfCDSaACLjswhQ/keARV8fpM0rxj5G46SNQwCL6RytXLOrFoiuq
         QwlWp2+LVnE/yqlNxPge6ig9s7cZqlA2fzqZ4+u2hKHwJiAZ6ljPYONoOlR1TW2Z5k1O
         UOCw==
X-Gm-Message-State: AOJu0YwZwpR7VcQTbUwnZr5ZkqudAsQRBWSWxiIDtrFSFb+HFCS2M6K0
	atSw6iixeFOb45Rw9oT7nqelC69voCgt7qBUxhxdZvZkVGrAOUQ2BcxhGQ==
X-Google-Smtp-Source: AGHT+IFo5Bx3+gf+Mpbu3Fn9v/O+f+eqhcXPQZXs/LQ65ivXyAdQN/HxWXJrLv2pw78PrkYjELSdgg==
X-Received: by 2002:a05:6902:188f:b0:dff:2bca:9984 with SMTP id 3f1490d57ef6-dff2bcaa01dmr6511597276.13.1718625458673;
        Mon, 17 Jun 2024 04:57:38 -0700 (PDT)
Received: from [172.17.0.2] ([20.97.189.29])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441f2fd020csm45637801cf.64.2024.06.17.04.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 04:57:38 -0700 (PDT)
Message-ID: <667024b2.050a0220.b69f7.de01@mx.google.com>
Date: Mon, 17 Jun 2024 04:57:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7467771520430969460=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, eadavis@qq.com
Subject: RE: [v2] Bluetooth: Ignore too large handle values in BIG
In-Reply-To: <tencent_E43E1B2F25E4BA5EBBEC33229E5E1BEB4B08@qq.com>
References: <tencent_E43E1B2F25E4BA5EBBEC33229E5E1BEB4B08@qq.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7467771520430969460==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=862580

---Test result---

Test Summary:
CheckPatch                    FAIL      2.06 seconds
GitLint                       PASS      4.56 seconds
SubjectPrefix                 PASS      0.62 seconds
BuildKernel                   PASS      29.96 seconds
CheckAllWarning               PASS      32.46 seconds
CheckSparse                   WARNING   40.13 seconds
CheckSmatch                   WARNING   102.67 seconds
BuildKernel32                 PASS      28.72 seconds
TestRunnerSetup               PASS      524.19 seconds
TestRunner_l2cap-tester       PASS      18.30 seconds
TestRunner_iso-tester         PASS      35.14 seconds
TestRunner_bnep-tester        PASS      5.30 seconds
TestRunner_mgmt-tester        PASS      111.24 seconds
TestRunner_rfcomm-tester      PASS      7.65 seconds
TestRunner_sco-tester         PASS      12.97 seconds
TestRunner_ioctl-tester       PASS      7.84 seconds
TestRunner_mesh-tester        PASS      5.98 seconds
TestRunner_smp-tester         PASS      6.88 seconds
TestRunner_userchan-tester    PASS      5.01 seconds
IncrementalBuild              PASS      28.44 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2] Bluetooth: Ignore too large handle values in BIG
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#91: 
handle value is belonging to ida id range, otherwise ida will be erroneously

total: 0 errors, 1 warnings, 0 checks, 10 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13700520.patch has style problems, please review.

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


--===============7467771520430969460==--
