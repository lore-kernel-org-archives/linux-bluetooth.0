Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55C12DECA3
	for <linux-bluetooth@vger.kernel.org>; Sat,  5 Sep 2026 22:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788646262; cv=none; b=Z/RjcyHofZB66h0KDQsbYyCXI9isu8XIYb8pU+4MTeUx9l4FKMXC52vqMBDwn/cCYwyGLXNhvJi8a+mLuGtmzKU+8rSeqVJ+Z7eZLx/qqHKMlujfVZj9hW4ipWVPe45e5mACS9BU2it4pM2DkqwuDFn3k//hbCNtNviZeByc+AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788646262; c=relaxed/simple;
	bh=GeQgR1wwjeoBaYCMtDc0b7rxJkJkt3nc31P83wQgiOU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SlNpDo65c7T1y98v0j1sAM0dNxESBNzqDbC6daU4sABHKAFGJcKjmfYcVB7b0QA6tLJlkHFqiF5s+dhLZix2wH78QF92hPhUMDCp11lLFkoeF5xQXz31fDLOMzzPlGiJ8k9KteTATCWO95i6y0cwHKuWpvZ727BP3lzEEQrE8C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XfOvkf2O; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfOvkf2O"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-90e7fd978beso42408936d6.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 05 Sep 2026 15:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788646259; x=1789251059; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LM4jsHi5/z7OAx6CbcKmcUn44oraH/94HzvLmGgwkM0=;
        b=XfOvkf2OwLYBaJhJDGBbicFzT5GQnFiZiInfmWOIy6f4rn5M4LUR2+MRm+90GenbZC
         YkcuLqW7/MFB+x9pTP1MfzEGcPgaUEVNzMLGxWnSJ1pnphw5/r0beGWHzFYXRwPQV4ip
         wsI5v2nJ5o2tuDTSekbrequv/7OV+vo8DUSBsVB0QDEvfbPmzbgx7dTg+2TE/xt86twD
         gEt76Oo2cGZLpncFRgPtRKW5sFCwsKnLjCtLXXg7zeZQDcKIEMiLKQtv20gmBxjdRO69
         A8yslN7UApFhhdvMNfpg2sGuOf//Je6jlQTR2LjbnWGX8r9NX778YNY07WRrfsI/8NlN
         tZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788646259; x=1789251059;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LM4jsHi5/z7OAx6CbcKmcUn44oraH/94HzvLmGgwkM0=;
        b=j1o/7UfIg3o85gcBwShk0qBvopwAJFgQooHpyihT5rCn7ovOAiQKZBBU2pdq9WYVPy
         RmCuL4AzOvPe4t+Ka4dfMp9eVWmqM7akE++7CH477WdoEliqEBiF3t2+AhGHok7K48c4
         p2r5rnkiEBupJ23dc/8Z5xE140VgVjeu87SPJMHVmFnoMOqifsK8FSUYP4oMKJ1Xye/w
         8rqLixya0hw69N2mbvMF/nCtDcX8E5pht6MoXluJOoo28XRNl5UqqB2pudOrBQzZrVs+
         HvxK0dMZQw5xnFjl8FvmXahm5gzRGLSJIlR4K4JfLVabFs3GTPNHxIjuOyX9Z3Jr6egG
         zuiQ==
X-Gm-Message-State: AFuF++nu/ahKxrAfYzy25FZ5cF+qNbLSOVXOz6WI3gKvfl+eUKl0IkC9
	ewFJQzLATAjKuC4Q55spiFaMNNEQ/DhH+9Jg4f9pfWVP+10nWr1NtqE2msk3rw==
X-Gm-Gg: AYBFou0jEhfVlpBgoLJ3nliWcI+xO1CkMIa4KBz983VgOx8hMPPDY3/jStIDbughb4g
	agOC5cklEopI8C2Ac7wfni6sisPeZtwv7kFMrlUUwiA1txDRZAW2Cn54p1An2qhmWbAJzH4W3fH
	w+B/Sjb9/2Y1CynrgPOTfQ46z/tqKlnUW8dpR+Jx2WAuukUGIf9o12EKPTRmHjSImvwdZrvbSjA
	PEZTAQ47dhxDewn5/GwRPGHc+Ozrp0E77QFgv+VRNrbZHN7qkSmLmit8TLOEnEB/4dd4yCMws2a
	h0QYDqFlAi0+KLfdqwb196KePLpG9PnmrDGzKg7VdDinBEYoIgyawhlrUAaBp3EmxCFEfGnUJPX
	nxZQJUCtCAkjCDU/PMy8r+64Bb5TYhDBBbsqF906n2DvBr1HNHO0eOfBbRz0ZumCH95xERqBCMO
	GfB5VFmy++TytxU/yS8LGsuFVpCFztjbdxcqqgmmyyOv5dYXHqu6aMz1+bsF92B8XqzwrXj99MH
	BIRIZg=
X-Received: by 2002:a05:6214:2489:b0:90e:863a:b1bf with SMTP id 6a1803df08f44-9103f00a27bmr159796836d6.29.1788646259511;
        Sat, 05 Sep 2026 15:10:59 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.225.17])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91040663a87sm55439936d6.19.2026.09.05.15.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 15:10:59 -0700 (PDT)
Message-ID: <6a9c9373.362730bf.25f9f8.ab01@mx.google.com>
Date: Sat, 05 Sep 2026 15:10:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5369668219152870499=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, samuel.alhovuori@gmail.com
Subject: RE: [v2] Bluetooth: btusb: Add device ID for MediaTek MT7925 (13d3:3631)
In-Reply-To: <20260905195746.244134-1-samuel.alhovuori@pm.me>
References: <20260905195746.244134-1-samuel.alhovuori@pm.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5369668219152870499==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1158826

---Test result---

Test Summary:
CheckPatch                    FAIL      0.69 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      27.98 seconds
CheckAllWarning               PASS      31.38 seconds
CheckSparse                   PASS      29.70 seconds
BuildKernel32                 PASS      26.51 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      503.49 seconds
IncrementalBuild              PASS      26.21 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2] Bluetooth: btusb: Add device ID for MediaTek MT7925 (13d3:3631)
WARNING: From:/Signed-off-by: email address mismatch: 'From: Samuel Alhovuori <samuel.alhovuori@gmail.com>' != 'Signed-off-by: Samuel Alhovuori <samuel.alhovuori@pm.me>'

total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14793614.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/710

---
Regards,
Linux Bluetooth


--===============5369668219152870499==--
