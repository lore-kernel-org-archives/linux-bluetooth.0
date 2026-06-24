Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D09A3C0A07
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jun 2026 14:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782310799; cv=none; b=T3Sgo1eaj0rQaHKDGXKNLEAbxj8TzkVlhAV4rt+nvRPgM9PYVKR5iMRinmTgKrekUAI3102rbLJytlSFK0SDXhn8ekZrzAyrxNEoD+nWHc4W4+1NpsIx5ANGOcVtAPO4l/liLyRCfhmNbgU8pt4OkEvwGmteqLTgDuu4sNHBNIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782310799; c=relaxed/simple;
	bh=3OSxWZcvjAZ8HO0lbXVTIu5uRVd5wCsQFAFM1ZKG+Tw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Xxb5QQYFrgk8pD2ualWvgYwXzMBwwtIB0CIySRyC7aL10UjWfjmRUUAaHywdokSMy6rLWkvV7c2dly36J1XAV6zEb7clbgt6G79qs/YUFa2mXz1mA5H+OHfcW5WKsK+0d7JPeqA5iqeX/NXZJzgyhVyZpYzepFrUgiApMBPpqF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aW7jFzjA; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aW7jFzjA"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-517907feed0so21058511cf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jun 2026 07:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782310797; x=1782915597; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eBs2zKZka1nxSY32XFw96PnrREZlKzGSFH8O2a06rlA=;
        b=aW7jFzjA9IUWLIL5ZcTXfZeiqXJApAreqDubS5pjn+dIfNriQsIvBS3C4zth51w1UB
         4tDpModHHG925bROJDBc5XbeBy1UENeBIQcGA0PzFc0ATCKsoGqCI0Z8JjCbQhXFvadU
         BNGZVjVu3hKbZQA1Q9Ln+zGtJR1D/a0bSKOvLB65rhImp2vtuux5YeFse6/Tvk4ECYJW
         5a7tDhP45vsTg7vnov9IG0+llHsYHkAlFUgLWtl15PpmpqSBinuq4vuVmtZp9uJojwN2
         UV+48eYIei+V0Iii0gI5VVrRoqbdqP+t12mBLjaWtQNugBj9+/Yd9zmSs+p2R1jPwYin
         HR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782310797; x=1782915597;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eBs2zKZka1nxSY32XFw96PnrREZlKzGSFH8O2a06rlA=;
        b=TfmUmTWKg4K3BepLRN/eowr0GhShayL5Y/sHX+/5bR+EGlTumOKSMC02BSIerWEumo
         sddkUVOmra07Wu9AbeAkAfU4XH/PvsdvZcvrUevCsyqazs4FQYIjfKHxvAR7uoIijdIC
         i7+lc2+JTH7EurOXQvGvwvXl01nQfkn4ucU0upXmFC7WweJHnWa9+yrNfL3P8OSjhacg
         oPv4nNAmolE3mZos5JVndfHza6viu6I/IZy4gW1IVB1kpb6b9FilJ/MHtemURrl4VeGc
         exn0yKxqASoGgKM5fz2S1N3IAz7j+/UjE/gtptzCC3ZbU40bcrzL3Iud5p74Ol2+S+wM
         pluw==
X-Gm-Message-State: AOJu0Yw7zTq/r75jOMGRBgHv9WBib2BKKKaHaxMdVf+Xr2sYTw8vPSya
	g9HZ+aZrlqPXewygpsTYTOB26P7xDEtZeHuCLUszlnj2yvCLBXBEhEO23dlC1Q==
X-Gm-Gg: AfdE7cnw2CDu/G4pVdeu2NOS8SgoCr/0443SbWLHvVLG614QzR5zlB9dpYAzvsQdDec
	GQ4LXoUADLnLSwNFCI0aMQE4ZbaXHy3fN7/CM0R6XkYCD5aBit6eRzIo0eUxLAX+cEkM4pvK4jY
	Vn4SKyZzxLiMwf+GKrEVBYS4FEgRZmZHSOcNNUqg49fgRBLprkvoNV2KJnl+Lof3DwqtOnuXpFh
	aGK/ZbVtF2Gygqiufaher/wv6A89T7kfgVe2zcvwdYPo8h9GlJhK0qIQkxkmaYnTpjnpY90d6Hf
	kmXayDLLNr/2TF66IXhO/wlco9QxGoTTsXJEmF0O2FMRU5kedaInPG7ONsTnShOqKw3ZioezMKi
	kfYs4tla/8Q6XYAWYmlfAyPaPs+wfiye9e5SbFW4wE138OuZy7Ymp3QliCu+cxpJviT/zSFF9uG
	Lh6X0GyrE6DWmQnWOtWl7VdQ==
X-Received: by 2002:a05:622a:134f:b0:519:e028:a950 with SMTP id d75a77b69052e-51a6bac02f5mr3729221cf.23.1782310796826;
        Wed, 24 Jun 2026 07:19:56 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.201.245])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a51106a09sm47040571cf.0.2026.06.24.07.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 07:19:56 -0700 (PDT)
Message-ID: <6a3be78c.5c7f968c.45680.b5d5@mx.google.com>
Date: Wed, 24 Jun 2026 07:19:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5338578245777421567=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sammiee5311@gmail.com
Subject: RE: Bluetooth: eir: Fix OOB read in eir_get_service_data()
In-Reply-To: <20260624115439.868817-1-sammiee5311@gmail.com>
References: <20260624115439.868817-1-sammiee5311@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5338578245777421567==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1115877

---Test result---

Test Summary:
CheckPatch                    PASS      1.35 seconds
VerifyFixes                   PASS      0.31 seconds
VerifySignedoff               PASS      0.20 seconds
GitLint                       FAIL      0.71 seconds
SubjectPrefix                 PASS      0.37 seconds
BuildKernel                   PASS      27.00 seconds
CheckAllWarning               PASS      29.24 seconds
CheckSparse                   PASS      27.97 seconds
BuildKernel32                 PASS      25.97 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      574.54 seconds
TestRunner_l2cap-tester       PASS      57.98 seconds
TestRunner_iso-tester         PASS      78.50 seconds
TestRunner_bnep-tester        PASS      18.88 seconds
TestRunner_mgmt-tester        FAIL      209.96 seconds
TestRunner_rfcomm-tester      PASS      25.44 seconds
TestRunner_sco-tester         PASS      32.55 seconds
TestRunner_ioctl-tester       PASS      25.60 seconds
TestRunner_mesh-tester        FAIL      26.07 seconds
TestRunner_smp-tester         PASS      22.95 seconds
TestRunner_userchan-tester    PASS      19.95 seconds
TestRunner_6lowpan-tester     PASS      22.94 seconds
IncrementalBuild              PASS      25.85 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: eir: Fix OOB read in eir_get_service_data()

11: B3 Line contains hard tab characters (\t): "	eir += dlen;"
12: B3 Line contains hard tab characters (\t): "	eir_len -= dlen;"
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.233 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.439 seconds
Mesh - Send cancel - 2                               Timed out    1.991 seconds


https://github.com/bluez/bluetooth-next/pull/347

---
Regards,
Linux Bluetooth


--===============5338578245777421567==--
