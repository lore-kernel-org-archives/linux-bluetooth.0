Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC562907
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 09:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713261415; cv=none; b=IGZi4bT2dlGYRruG6ciHP3KFQVn5TaZvnl9AvProbRosGDJ2IH4P1eKcVtIWQ8JM9YRmNKua3CwEez2uUj3sn0U6qc72NQTo+j9MKE8XKWg3XD21ZREH3H4NWS6+nVPtnzEwQUxlTag9lHqv+BG9wd0VnCUXo/DynBfBjruroPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713261415; c=relaxed/simple;
	bh=SVNHvzKUsvi9AJgtfd2tQgktRjV5yh1342nZTSRF8rk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZTGpFxrTdcnANnc0ILwjouDGnHY5tnkAS2z3iWVTZHHWu8T+gj2GB5TZfuyonQdRA0CC6L983ZSxocIgkK/s09ikTzA6WKZkP3Yk/rzloS2Sz/jve3W7KqQXbScNXxEsjdNtheQdeNSJxfialUffsh0IddKFl/pCtt1vDQZEx5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6IIvXjl; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6IIvXjl"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78d555254b7so338209485a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 02:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713261412; x=1713866212; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0WyJjHkOUbyV6gz1CeEJChQYzXcAc0hRmLIITOfdQLE=;
        b=M6IIvXjlP+iIKmWLMLSe6HfqfeMgweXdQH3kuojvkYQdhWk66DaphmPQhimNatmPRR
         QLJiztQV0bMxfYCUVvyjAcBLA/38HCaGLn1mq4fFYqKblxNmbzgYT31X7z3+9wNNa5vk
         q7ZLSn1ZU2QSOCHYZ8s3XV4LaZNnWiXBx0sWQTWAGFlx3GVgYI9QrA9cJz2S+42D6bvE
         EeG4c+dgbEISU/2nI7pkUHfBi9rATTVwG/43lNHvjfbrIz9y0kPqn8YInIbC5ueqkusL
         jv9KCTWrf7u6lSpsDGMsIiNz9d1jEOtxJd8SusRcc2LzMKglSoV7GBj58DKCuieCu2fJ
         qILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713261412; x=1713866212;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0WyJjHkOUbyV6gz1CeEJChQYzXcAc0hRmLIITOfdQLE=;
        b=sMtnDGc1bl7uxY0RELJNYz0XF8d9zaBm9z0QrZ1vC6SiJnwUtHT+gGw2FS6fPwIQZG
         5e0z4k9lHcyxnelN+zO3ugImS020owZqMtg7oxVt+iL9hw/8QCPY8xmRjbVf25yLxiRx
         3pSC6GX7FbRU1bhZHY9STXef3ODVo++SKu+14r/jQ1OjTtWPYj+1W7RWoAfgGY9ZJ7X1
         9bi+K9rrn7tDQbnO9O7ea6/daD6ER8ba49ZnZABjdT2YXlvkH+e+D831G056g/vLc3nk
         Hvj5rC7jhxiK8eUC0V01r6mzxDAgDEBQitnvW28/64pXv3mgIbxyxUQK8KktRNxHeRtz
         HE/g==
X-Gm-Message-State: AOJu0YygsUMynFt2OfgUeHj0zqd3y4kRpegbWt1v2oZxDhJgRPKTiNP+
	ji6cQ8aUVuwj1TS4EY6w/9RgXYc9r/zBu6WMaZ1nqBeqStvnA9FXLwHTAw==
X-Google-Smtp-Source: AGHT+IHaSQtuCP6ysUPttcr+3uqL4Ou5cFdlqCBAxxmR1ftmM6zzPZt0T6cSNVXTjlqpekmb2N5F+A==
X-Received: by 2002:a05:620a:1924:b0:78d:5d7c:9896 with SMTP id bj36-20020a05620a192400b0078d5d7c9896mr3620220qkb.36.1713261412528;
        Tue, 16 Apr 2024 02:56:52 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.89.129])
        by smtp.gmail.com with ESMTPSA id gs15-20020a056214226f00b0069942a53f46sm4454168qvb.53.2024.04.16.02.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 02:56:52 -0700 (PDT)
Message-ID: <661e4b64.050a0220.a88ce.9d1a@mx.google.com>
Date: Tue, 16 Apr 2024 02:56:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8194954117138381985=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, johan+linaro@kernel.org
Subject: RE: Bluetooth: qca: fix invalid device address check
In-Reply-To: <20240416091509.19995-1-johan+linaro@kernel.org>
References: <20240416091509.19995-1-johan+linaro@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8194954117138381985==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=844980

---Test result---

Test Summary:
CheckPatch                    FAIL      1.22 seconds
GitLint                       FAIL      0.50 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      30.99 seconds
CheckAllWarning               PASS      33.15 seconds
CheckSparse                   PASS      39.27 seconds
CheckSmatch                   FAIL      35.66 seconds
BuildKernel32                 PASS      29.47 seconds
TestRunnerSetup               PASS      531.53 seconds
TestRunner_l2cap-tester       PASS      20.80 seconds
TestRunner_iso-tester         PASS      31.43 seconds
TestRunner_bnep-tester        PASS      4.94 seconds
TestRunner_mgmt-tester        PASS      112.59 seconds
TestRunner_rfcomm-tester      PASS      7.62 seconds
TestRunner_sco-tester         PASS      15.30 seconds
TestRunner_ioctl-tester       PASS      7.89 seconds
TestRunner_mesh-tester        PASS      6.04 seconds
TestRunner_smp-tester         PASS      7.04 seconds
TestRunner_userchan-tester    PASS      5.12 seconds
IncrementalBuild              PASS      28.25 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: qca: fix invalid device address check
WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#85: 
Reported-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Link: https://lore.kernel.org/r/124a7d54-5a18-4be7-9a76-a12017f6cce5@quicinc.com/

total: 0 errors, 1 warnings, 64 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13631544.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: qca: fix invalid device address check

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
23: B1 Line exceeds max length (81>80): "Link: https://lore.kernel.org/r/124a7d54-5a18-4be7-9a76-a12017f6cce5@quicinc.com/"
24: B3 Line contains hard tab characters (\t): "Cc: stable@vger.kernel.org	# 6.5"
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


--===============8194954117138381985==--
