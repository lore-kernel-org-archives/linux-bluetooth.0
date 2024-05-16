Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F977E763
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 12:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715863305; cv=none; b=iAhqA7QC+Qpu0C9SbqeaYkQ/pftNaQIggMkoxP0et8iX27HMIz+798E7SPCEHFhoiZt9pQO2E3LECNiKjh++H6HBagcg7BmhgDROIAQVqgcCpn4MC2UIDAmn5rUW6GYzzlhBbPdwSj9Xesjp5dFZzjs0tp9HRKXD8A4nQ/rySxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715863305; c=relaxed/simple;
	bh=sVv3VAuZDTgCNz8/zyo/ug8zAKvTCdHYECUQGEogLl0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bhoK5Xe3lN6KKINgHZaQQJNC09g3Gjsr++jQZdtkK3AHGynp+SPalucUPlEdjbDJp93+BzkW/wms7nlqnd39d5fvhVZQ98sSxuHvdx2Q/Ow1LKPG1FoTS8Jv1i/+ajyOPvMGy8GQXcX0tP/1QpTDkVyxHfJfI3xpOCTS1CVg7XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVezrPnZ; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVezrPnZ"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-792bdf626beso732442485a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 05:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715863302; x=1716468102; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aUbGt994L1a5nGxNuI+N8aoDf2qqOy8TCAN0xeyVHRU=;
        b=lVezrPnZyv6BLUeMxxtkxM4rpB+Rf1ni4FFYX5UM+g0j51QMSaRLPiFtSjR03T/ELJ
         HbBW6mxA1nCsMfLVtb4LCQeJtaQkjKXCcQfOAGVN16O6cDRWEjDWat6dIx9hUK/w7h/Z
         iFqwnj55Fq6CvSeimS+EEO2FvZ3ATJs+PgejnlofPQShOFyy7N1yKyJVO2jUUgXxtVbq
         n7VKf4TusuUjcNomtqRMBu1ZIaoxUT/tAW1hHi1ziSQU5rvqN9eGWHpvo69pX+ZDwP8L
         zM2CIP9piRFaseSn5os6bT/yBJ/AuM8dsJjosnRsmeQ5jrJC0doKCmrBREiRDVco3Ll2
         4D9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715863302; x=1716468102;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aUbGt994L1a5nGxNuI+N8aoDf2qqOy8TCAN0xeyVHRU=;
        b=IGHVBHNDPTDa10qxty29Upy9mrOjZPDP0EYCSOm6/mf/Xw1CKKCoLDojZt1cDvpnnS
         Cv0DnKPBat0WWrShcttk5XRgrAV3CKHpx3PO3ry12mt3i1AQRoniWP+19GRMBP+Ojl8n
         ZQU9iQqftTe8/1X79ePMAhpMVCgC3YrtBCRa3932Jev/N6UyENREMwDqQf2JF4m4LAum
         XnFxpjoJ/9Vh2GPa2qu4OEOPKT5en5ohuolSBYz22ak+tXzbDq83YbLdtMsTLEsdFNDo
         E7SQ+hejSNPJn9nkkPyrDrV5ZYYUtnCstWyKakbviqOpghk6/efsIGqrc7mCFINeQulO
         d8jQ==
X-Gm-Message-State: AOJu0YwZvi8av1qrWZeY2AA2o9aAgXBF5F7W2owus0VrnztCJQ6xxvT0
	XPC8D93sTd2a0KvCSNvrJidhxZTxu5h1TTbhU9HSgIfzTo9mJiFra3dlUQ==
X-Google-Smtp-Source: AGHT+IGr2zpWD2LufOX+Gv9WbIlq639nLMdBJwcoDO6KVYqr8CHzXu5cHFiiPVCGKaJN7+UOdiQClA==
X-Received: by 2002:a05:620a:3722:b0:78f:108b:68b6 with SMTP id af79cd13be357-792bbdc52fcmr3709649985a.8.1715863302347;
        Thu, 16 May 2024 05:41:42 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.39.240])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df8c1b2f5sm93290841cf.8.2024.05.16.05.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 05:41:41 -0700 (PDT)
Message-ID: <6645ff05.050a0220.0992.e4fe@mx.google.com>
Date: Thu, 16 May 2024 05:41:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5336754554327644361=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: btintel: Refactor btintel_set_ppag()
In-Reply-To: <20240516122436.880999-1-kiran.k@intel.com>
References: <20240516122436.880999-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5336754554327644361==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=853679

---Test result---

Test Summary:
CheckPatch                    PASS      0.80 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      30.21 seconds
CheckAllWarning               PASS      33.26 seconds
CheckSparse                   PASS      38.70 seconds
CheckSmatch                   FAIL      35.43 seconds
BuildKernel32                 PASS      29.21 seconds
TestRunnerSetup               PASS      527.23 seconds
TestRunner_l2cap-tester       PASS      20.41 seconds
TestRunner_iso-tester         PASS      30.76 seconds
TestRunner_bnep-tester        PASS      4.81 seconds
TestRunner_mgmt-tester        PASS      112.80 seconds
TestRunner_rfcomm-tester      PASS      7.38 seconds
TestRunner_sco-tester         PASS      15.02 seconds
TestRunner_ioctl-tester       PASS      7.80 seconds
TestRunner_mesh-tester        PASS      5.84 seconds
TestRunner_smp-tester         PASS      6.90 seconds
TestRunner_userchan-tester    PASS      4.95 seconds
IncrementalBuild              PASS      28.10 seconds

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


---
Regards,
Linux Bluetooth


--===============5336754554327644361==--
