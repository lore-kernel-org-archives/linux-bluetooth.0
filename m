Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025E1221FA0
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 06:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751956950; cv=none; b=QFxQmNNTYXeT+W0EFWAq1Sn11mIYknky7iW9oIStBtrS8ShIl3yNaFEDOaI1SEuFiZRG8TXagOAo1IRTHnL2w4GuNDt+GGb2KRnf0uro6HGctME+IkYXZ3uzKvpSdXMG1LbkqxNMom+w9trJShUwHHYo7l+ptD1A/qBz4mqIFlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751956950; c=relaxed/simple;
	bh=sw9QNsiK041ndKWlMx6GNG1phWh63ppBO4m/UeqjcVM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rTIdykrrXwoWtznRRvVKfw6/rxwzH/E3fLT7PcWCFmGGS03pNN17PNNv/3OAkOgM7U+jjRuMdugF2/L4UEUwXrkpOBbrtph7y0IdvWaXLLE2HhcjzxeN06ypKHwqroHTRYplNCe6GKv8piGB6xazm0J9b95KZMa3WU4qffUddkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gz1IYwzG; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gz1IYwzG"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6fadd3ad18eso42384616d6.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Jul 2025 23:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751956948; x=1752561748; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ouVdN5GC9dVq0k2rCePfLdejnc8cIt0EPblMB2sOWZ4=;
        b=Gz1IYwzG2iVMZEi2qbjIZ+gKlyKXE5MHhkJpFhRrFKi9nNjpEyBXnjRPlKXKQ0Egie
         BM35LRslBpWWGGLLmAHvs3zjJ93Z3GrphepD8AFlUmO/WygtNY58YQCWFMsyJGUqCGLy
         lLkAWdyzzWZSjjhbR/LLH+MzLoq2F6hTbyCqT82tkNeaucEl7Y3sjjEcEhteP+yvB8bP
         aNvwdKGLVZFhgMqvJSVN2yZmwwRldKuPqksvW8J/sH2WdZY2IvAtoBH5vlpVXRooZ2yJ
         FNdYGuHTWXmSRYpzAvwrocfNXKMTZAcuUK91hlLzDQAhyxrJwQYlaFiZ8hwToREcVWKm
         la8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751956948; x=1752561748;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ouVdN5GC9dVq0k2rCePfLdejnc8cIt0EPblMB2sOWZ4=;
        b=NPwYgfETwiDZyStv/CSHF+z1Ty8/Suc4ao3+1CHbg+q4FR8pZ66LrqsEDJ/G3MJ4OD
         nTDjdHf35RCxnpncYzXO0KB6ULIo0Kk0QUOiWTjX/okQcS5u6rJroUcQxuEUSRHkDAW5
         fE2a5037cLpYw+nNBDSH0jp/9L0hPddm6bgf+j1kGFuvwm0OnOj94WF5AIQEqIOmC3sp
         QfNfLismiQnmYi833KOeHRVcGnhWsds7xGt1C8L0wnSDKZHLL/Zln83gUV9orGAz/OLh
         H/zLv1SI90/3j7zYqi+iICbpD7EjELerQq168DnScaL+RjwuGHOS9VlhybNtrgvMlhAw
         x0ug==
X-Gm-Message-State: AOJu0Yy2szhTsEJFzYvhvRzHxrp0yqlxrx4cBlkRyamvrbVtX3RuTWP3
	oN2oesol+OM5ujbG1uUV48c/YAlNwXL5PBiSs9bPO4In6Q8UGlMZChIF+rzBVA==
X-Gm-Gg: ASbGncuiJ9k72n9r6mFLR8JQ34KgUfDOaxv15hMoV0nZq8stBegHHUzOz3aW2ina9wA
	BiSdGUmus+6YBHlzddznS2A+pn6lZ7QGo6mWcJ+ZQcJoGN4a4FaWGZvjpY1kuuvp5QuDAEYUTqQ
	P1zvSlJaQjmm8QdojH68MY6NAybA9qqWRdbPDpysLqridVpVBR/2VQ6uGKDagbnlNepxv1JGMP8
	gLTF/KABdU3XLMYlIgV2Gb+PaZcORwuk+Msbz+pPgfeu6w+6jH4DnGNvIxX2EDwBxmXRPaaowxz
	/hYZobmTHqNxHEd7vD8w8uG5OfT8IdeZWoOqTppCajfwxffSmSLLOCqXKAkBVaEUoJRU
X-Google-Smtp-Source: AGHT+IFSsH/nsC20il3bgex4lCtTU7btUWEp4osxRRoQ47VyW/P6mIifKuD3ZBAdUzuif8gte8R1rA==
X-Received: by 2002:a05:6214:5b81:b0:6fb:3d7:71bb with SMTP id 6a1803df08f44-7047d931790mr22982816d6.1.1751956947540;
        Mon, 07 Jul 2025 23:42:27 -0700 (PDT)
Received: from [172.17.0.2] ([172.191.23.91])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702c4d6043esm70782476d6.113.2025.07.07.23.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 23:42:27 -0700 (PDT)
Message-ID: <686cbdd3.050a0220.7fc6e.8028@mx.google.com>
Date: Mon, 07 Jul 2025 23:42:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0204089966966398520=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ot_zhangchao.zhang@mediatek.com
Subject: RE: Bluetooth: mediatek: add gpio pin to reset bt
In-Reply-To: <20250708060150.27375-2-ot_zhangchao.zhang@mediatek.com>
References: <20250708060150.27375-2-ot_zhangchao.zhang@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0204089966966398520==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=979887

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.28 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      23.87 seconds
CheckAllWarning               PASS      27.16 seconds
CheckSparse                   PASS      29.90 seconds
BuildKernel32                 PASS      24.20 seconds
TestRunnerSetup               PASS      468.14 seconds
TestRunner_l2cap-tester       PASS      25.25 seconds
TestRunner_iso-tester         PASS      40.37 seconds
TestRunner_bnep-tester        PASS      5.98 seconds
TestRunner_mgmt-tester        FAIL      131.94 seconds
TestRunner_rfcomm-tester      PASS      9.26 seconds
TestRunner_sco-tester         PASS      14.84 seconds
TestRunner_ioctl-tester       PASS      10.06 seconds
TestRunner_mesh-tester        FAIL      11.41 seconds
TestRunner_smp-tester         PASS      8.43 seconds
TestRunner_userchan-tester    PASS      6.17 seconds
IncrementalBuild              PENDING   0.70 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.196 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.069 seconds
Mesh - Send cancel - 2                               Timed out    2.001 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0204089966966398520==--
