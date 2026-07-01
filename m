Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052A837DAD5
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2026 16:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782924682; cv=none; b=peyAEHEdktnTMYTjBmFpGHdhjZwUZdJe1Q6yTcmRqGeWVoyaz7RzV6YrhtSdvB3bLPxahV3UmkwipfhCt9yG5JT0tVsuRLiarhdl1nNQKsDj9unTLgs+RpNx0RveXA3iuD9HjQEmJlaYGjw4Cv6zdOJJaHLGgYV1pg3iaOAHhdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782924682; c=relaxed/simple;
	bh=eeRUddUqurW6yziCan8hnEaN+XCcYL78wu1skhk0yUw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FVUdgx32DaLwVO4Tepslvp0asvD8s70g0ia/oqkQNWZM9AcyUiqda4Bt2eYJEwp72A5GHEWVrNKhmIhM2141mQJpwcwxBOLKmC3CZttrZKfOOJUCHohccquirzmu7NiubbeEg5otbvcs/jBwiNY9fKD9vsvJq2bTe6wke+FSOIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFOMOVLx; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFOMOVLx"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92e55b62640so49665285a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2026 09:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782924680; x=1783529480; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHueJh76d0arrV63OwCzRnFsSCjeLuNDsB80mpImbAA=;
        b=VFOMOVLxKc15bTbvt3wC6LD3PiHoPKW+brgLSmrCzHQtWIP0yJQJZZEWUZJshQREi0
         9mpgep2Sr+OT/tEEP4ad49taPYBld9uwenYdO7uL4hgTWrDTV/ZMfAqkCh5/9iuyvYQb
         NDtcJCcrLFjLMMNytgpoGYTfQiDEXahwk8BHWbV6EkWrc5cjK7rFidKQh1twJESiGmmg
         mpHAquIfNU4IXVTz9ztUWx3aXSLEpAoOqmnFDaOnKII6CgkM9vVjlgPMYLKq2Qc4X+fN
         2t9V08kEB0XwzK/74vqMrk/kuUQjwybNAavWHp5IX+3aTUKI/3acI+dOLgFoczRrZdzu
         i1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782924680; x=1783529480;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHueJh76d0arrV63OwCzRnFsSCjeLuNDsB80mpImbAA=;
        b=fMMKi3IOFJ+nzjlIX+3qQfBPth5hG6MgdaGUs6zQn1f8g05JMo1bbsjzZsR5psSBeY
         A85AqQ9zGBXYB9xCUFyR/SstZqgbRrKMTdAhboITkhcmme4yjb8YWpaZg9Ab4ROvW/8U
         pO/p+bVvea1fmcDJe87QQSwlh9oK1HX0aITBzMG3z1EKtVS4hfGDosFJW6HfmYiS7Bgm
         COwuwYoQcsVwjDuvJ1D0JrapzwJeUOZO9TtcUQZyVQU21XgjfQSB+RoYGHxo0u6KBUic
         9SCVn/UNuEbUYHFlK7GHwXRNdUGU/M/ZLQMG6PhCX+TGYXaFujKw75zepX0M8RA2x5kw
         af7w==
X-Gm-Message-State: AOJu0Yx0Hi2BLWAiYhtNXb0LAmKRSdmc67ELckkYh0YYoEjf6hMsNMpe
	BXVn/gl0pULhHB4JXPTwALN9Zs+AWj5i6BVW3VoPzOelcZP5PmhND+wpNuNzyA==
X-Gm-Gg: AfdE7cmLCMwK3RDW4xpvF1K+dkwAU3MD7xcIjHg2QZnN55x9eiEiWMbD/ga7yUyJJj7
	A9N1n7UuZtZ8V4mfMXEpFg5z9EssJsoqk/PdCOU/n9JSxK32sDN2l0xBDh8jeAJZE/S7oZQ1kgd
	uIy9YxpveM6G/lMqUooHzx6km6XMof6nBQBk27OufM5ZSJgoMx3RqHeigItx17WATwPxFv59TUU
	LuLtt3VlU01xWB3ZT+il5bpwpjZV2ES2wPX61GZwfUVLBpc/Y4F+CbPn4koIO9v/VuONxO/p+GI
	QepyHV/p9WskA/FY3hKpU4eS1aMY8DaSu23/iFZpaPuhYSXajjS3zCyfFc0KIA0lvN+2lL3yMLv
	qAdsqGa5bglEC8uYYOuxQVb1PtQUJYOlwnaYJHkpWq2jru0/SsPCZ4zcL2LaKDmLYo0DzNPVzZ1
	V1hooUQ7RsKVxBWVKDGys+
X-Received: by 2002:a05:620a:46a6:b0:916:436:1fa3 with SMTP id af79cd13be357-92e782c62f8mr337676885a.37.1782924679854;
        Wed, 01 Jul 2026 09:51:19 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.249.148])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e6234dc50sm599141285a.39.2026.07.01.09.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:51:19 -0700 (PDT)
Message-ID: <6a454587.62b4ec9b.bf9cc.1b5e@mx.google.com>
Date: Wed, 01 Jul 2026 09:51:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6260555682768200631=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, bestswngs@gmail.com
Subject: RE: [v2] Bluetooth: bpa10x: avoid OOB read of revision string in bpa10x_setup()
In-Reply-To: <20260701160614.3160448-1-bestswngs@gmail.com>
References: <20260701160614.3160448-1-bestswngs@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6260555682768200631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1119978

---Test result---

Test Summary:
CheckPatch                    FAIL      0.72 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       FAIL      0.33 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      26.88 seconds
CheckAllWarning               PASS      29.51 seconds
CheckSparse                   PASS      28.62 seconds
BuildKernel32                 PASS      25.87 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      502.45 seconds
IncrementalBuild              PASS      25.39 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2] Bluetooth: bpa10x: avoid OOB read of revision string in bpa10x_setup()
WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#121: 
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-4-8

total: 0 errors, 1 warnings, 15 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14657103.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: bpa10x: avoid OOB read of revision string in bpa10x_setup()

7: B3 Line contains hard tab characters (\t): "	bt_dev_info(hdev, "%s", (char *)(skb->data + 1));"
8: B3 Line contains hard tab characters (\t): "	hci_set_fw_info(hdev, "%s", skb->data + 1);"
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/383

---
Regards,
Linux Bluetooth


--===============6260555682768200631==--
