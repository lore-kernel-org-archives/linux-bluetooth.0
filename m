Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795546654;
	b=T9o/JSUShG1w4IXgbQ6t0G4rOZTpRME1qb4pyD6XQXBj9v7qujbymzGOLL+StBIWH6JP
	 tTiABJhXkyTWp0Zdm75+9+15ppdJ09nC9DuAoZKPnoa+H2utDCKjkn8riTmDT2eMJgHlW
	 L+sKekaslf3QozYKMvGLYnO3R7kMpGd0GFMG8HKX2ZtB1GWSrE9/On0Pn2n12qUd6FNsp
	 l+Xkpi7L4N0LWCkWTAJnLq2uEYEsB7zl9Ve5ucR/z12rdjPsW4xdzHnblxkiVEl6OwQH+
	 TBrMLeT7xNP8NZn04JwNK042NI4GCHeXnMJcCecdhvtdYKX+6Sl73iLJ+Tuajf1/Kfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795546654;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=0uOn3x/8xwhxKHxu2esIA5GPDGwp5S7v3+lBJMYRsz4=;
	b=z6qCA0buG50LhLhEmhZHr5yjxuI2rRVr0PrXpaWcabt8I1sdqyGaDcfDS3KYEJYZRE7z
	 A54oLVC7LPpwh1gCbS58GbtEFP/VZ3UGVpzy5gPxi4Pnw4vUsX7kRVOO+TFRd4gjYuKa1
	 c/jHwBu+O4mg+H9dSCvskHN8o2Av6GKfIuPtUu8X81fdyAYZrFmkDrDdSkp9XrsyXP3aV
	 eEzW3ViAyVntrDxEPdb4cRqf/0++jUoIbGbY7R0u6cqH+Nc2X9Fh9RmlVjSh9xSG6vhE7
	 XHwCHXnX36JAoiVR7PWscQA2+pKHwqculq33r0mpnwXy1EDiSMD+hR3eLfgwi1jsO2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=An84VfK8;
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54658606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 18:57:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54658606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=An84VfK8
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-94961b68685so416897885a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 10:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795546653; x=1796151453; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0uOn3x/8xwhxKHxu2esIA5GPDGwp5S7v3+lBJMYRsz4=;
        b=An84VfK8AfT1URBJYQazaS09JRjX3CaGCb6YRwknA8O4GjiQZNVdXzFGX/mJRzTXr/
         H+nUvIg0Q1hT0fbEXz/2w1oi0LRuTZACP1vUDvyBA2ooI2MPG/anwIFa5rrMhLkiOjkF
         df0i29ZmeZ9XqdkL1yC2BXvy4GV2agkJttUUNF8e0CkBBiXlc6EA9TfWMkznVfKyeTn7
         2WnRImUuWhsauSz/QzZgcGHO9sRqKWsIbiJ+WdrHEOmohFv1BPHKFwCYiJ3NybGpKkCe
         6rZSHMcN5SUlaj0QJATD7AHA1580E99MlSj5WGpK/s8AX0+fWAwqffHlFCHkZohyiy0Z
         6hLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795546653; x=1796151453;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0uOn3x/8xwhxKHxu2esIA5GPDGwp5S7v3+lBJMYRsz4=;
        b=JcrSR2ZUMckt/AWoF7r5vTZpE0sPoYiMIsKAr0Oc3whhpHTRAsVZFUnxrcl3ZAnQZG
         zAq6OHXVTsO+O4roKl1sNZiGm4wCRREaSXxEJkumqr21uUGYphFig7UNyU4Ca5fsJTzC
         BgvfR/izDVQxxphVefl3QNqHErTDolvzuadvKYci/c8p1KWP2KlidNDNWjSfPj1xrsk7
         FXzb/6jPr9JJQNhbtD8Dz0/fAnHbzTgxXhQ0/2u+ElUxetqwkjjyWde7NAexiwz35TZs
         T5PXbUArOEaX01lIAftK/K6ggYodO5EH0WNw3dRrWLBuBYjIVFA/+KLJ2FM8jscxBlUk
         /kbQ==
X-Gm-Message-State: APuU4Z+jekxXFH/+zxVa4TfLgSdQmoOm33aWCTw105wOO/WiZhnN1jWL
	mXEssrmr39dSF7s2oHlaYobrcnw2Psrt8Mztz55iim/OEhlEpVk6bn/lDykjIw==
X-Gm-Gg: AZFdTZeF8Uciov2VVvCpp7dLLwJaHjtL7KnDKxtZIZ5zhDkC0P6Oo6XKQhJPdcx5j65
	mDEh7wlFlQB5SG7Bg6qVfPmtsxbmaSnKxSo0cA2QAm59SERF6x73sV9drITEBhZtKH9wlyapwlH
	8UT1tglbU/2hFG50PLAHZ1cLk27XsKEP63G+/LQed67I4f+xPRLgg5VZZ+vCdwDcVjnrQIJs85w
	t47Zyullsm3aodb0an4WLTIdrDtWnBxDKEPA9XgxEpVa3LwRtkEj4cqAXettk34VQ7C4/Lprlkw
	S/QtFwl6oQwgZ7YNYKLae4MNShH9AktUfr3jF6LIo/Sdk+ryADfrjO//43oGlp8Fi/pQCVfTIQ7
	W4zE+KYbtiRyaS25EShEz/M4huUEWhSEFJ9oQK/br9kEVYzZ+sJ5ixb8drxNMPbHhVLiAaJAUcV
	asc4M5+TccpNcebYBwHliGIRVCyS80hEs/zH+ngZnVhJ22BvcrzZV52uto9UwP8BTQQs6ZyaWXO
	81u+d+jL1E8J1/cNbCcKXmgNBKkbhB5cma1XxnspKPxNb2N2cNl/Q8qrKZUlco=
X-Received: by 2002:a05:620a:29c8:b0:949:6fd4:3552 with SMTP id af79cd13be357-949baa0b570mr2642967285a.34.1795546653202;
        Tue, 24 Nov 2026 10:57:33 -0800 (PST)
Received: from [172.17.0.2] ([48.217.25.182])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb38319asm1110487085a.16.2026.11.24.10.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 10:57:32 -0800 (PST)
Message-ID: <6b05de1c.a51614f5.20b64f.4bb7@mx.google.com>
Date: Tue, 24 Nov 2026 10:57:32 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8868892680388463091=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [v2,1/3] Bluetooth: hci_conn: Fix BIG cleanup while BISes are still bound
In-Reply-To: <20261124114010.1696510-1-simon.mikuda@streamunlimited.com>
References: <20261124114010.1696510-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8868892680388463091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1220748/

---Test result---

Test Summary:
CheckPatch                    PASS      2.96 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.98 seconds
SubjectPrefix                 PASS      0.35 seconds
BuildKernel                   PASS      31.51 seconds
CheckAllWarning               PASS      35.75 seconds
CheckSparse                   WARNING   39.03 seconds
BuildKernel32                 PASS      31.16 seconds
CheckKernelLLVM               PASS      33.34 seconds
TestRunnerSetup               PASS      764.88 seconds
TestRunner_l2cap-tester       PASS      14.83 seconds
TestRunner_iso-tester         PASS      17.50 seconds
TestRunner_bnep-tester        PASS      3.22 seconds
TestRunner_mgmt-tester        PASS      89.27 seconds
TestRunner_rfcomm-tester      PASS      4.61 seconds
TestRunner_sco-tester         PASS      5.72 seconds
TestRunner_ioctl-tester       PASS      4.71 seconds
TestRunner_mesh-tester        PASS      4.58 seconds
TestRunner_smp-tester         PASS      4.45 seconds
TestRunner_userchan-tester    PASS      3.28 seconds
TestRunner_6lowpan-tester     PASS      4.50 seconds
IncrementalBuild              FAIL      32.57 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: IncrementalBuild - FAIL
Desc: Incremental build with the patches in the series
Output:

error: patch failed: include/net/bluetooth/hci.h:3335
error: include/net/bluetooth/hci.h: patch does not apply
error: patch failed: net/bluetooth/hci_conn.c:769
error: net/bluetooth/hci_conn.c: patch does not apply
error: patch failed: net/bluetooth/hci_sync.c:2320
error: net/bluetooth/hci_sync.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"


https://github.com/bluez/bluetooth-next/pull/1215

---
Regards,
Linux Bluetooth


--===============8868892680388463091==--
