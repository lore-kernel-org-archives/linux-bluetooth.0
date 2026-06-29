Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87089386C39
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 18:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782757601; cv=none; b=eoaAiZ3oPnxWaPcrbqJGhgNGPwo0ZzK4fTM844JSwxPpIn6JlhWcmg6+54rc0VFazJg8LuGkDb5q+BANBNeNf80791hJjrZzPi0E4q1ntbzkzh47VcoL28eCNH23Z/4rSSyjijUcxx1uNEyY9S/EPEuH5amzxdcdQ+pbZB7I+1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782757601; c=relaxed/simple;
	bh=4iCew3csVDxFYU4kVKM2mZexCDFRMSIqrzEiWyIU0FQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Yz4sqa06S49hfA3JvveBt3qUSujCVy46jzoQFAu2nxwSwAr893MY9tNBH2Vs+MtG4SabwdzrbyDsfmBPFudVBl4UxDUA3ds11K5qClES7dj3eDDJEpiwGkxooPEeQSb74TetdH6bqPADxovRmxueMCJ0kBW7kdBS0GpyFjM474I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6HcTOOu; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6HcTOOu"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-30c944aacbaso3599418eec.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 11:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782757599; x=1783362399; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dcxHUeyoCx2XLkyp6N3TBw6VG6z03s8Icg11YJdosm0=;
        b=Y6HcTOOu5/44fLUGlqTunf8wfV0WwuVWB7w9nFO6ORXAV9lBzuq1ZSM7D1zKI/5Cou
         3597NQC84jP1OvWZ5vUHj8jhcokmIXsCOZmRNVJUYcmh4nQXloMTWhV5gXWkPYFMj8FO
         MD7JqzdbHkLsLx59Lddjy5DWSeswPtuHpga94yNLIaw/1uZiExFioJvtQ8ZBBfXaBZam
         RCarUK067i2ZKIu7d8N8zayQA6DHFrkD1AZDmcoAbzzdeH4wvyAn9wbgbWigWKIO2bp+
         223vk8wJFPRgcIWsFRXbAyDU2sGkZQpHDxqkj18BIt1ozGCze2YhCEfwnF0tLpC9RXjR
         TsyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782757599; x=1783362399;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dcxHUeyoCx2XLkyp6N3TBw6VG6z03s8Icg11YJdosm0=;
        b=YzKMzymE0zT4TLb1Xp+ZdVWMGtlR/Z1ly5sFxqlGfm/nv4onsoVf+dwvuP2o7e9A0f
         csrqmzw5HNMF0oCnzsuHHHRMfBKuXoMJdHijdn/46TVH2tH8p50Z9Sc6hLmBHXXvG4J1
         DdSvSXBNxevDYKqzFZ4UAbasfTkLTWkdenhw660Q+8lt4ZOvc2cbp1CmLcjzmNZdEG9e
         Kt9edsIyfW5d0sIARmbpFApqOkB8aRt2g2Pr7LZ1/EuToaJETvftj9cuEuyhkOfDAZ0B
         qLVGcrmq2F6SZT7eftzqOovSiSGHwmiR2JGoDUmCiRPYUWoBlzRhgNlCfsuHXOOvM7lV
         recg==
X-Gm-Message-State: AOJu0YyxZi1tCfL+0xIwQm0Wh+Ty1qzK/HeP819GTIcMxAA4EpLGm9WU
	2ePjgFiZzmC2D9YanUsTUhzzHAVyxDj4TCLs07PIpFGxWGIaivq1JNaebIhuZg==
X-Gm-Gg: AfdE7cntNfC6nocI1prRsXg29+un56nHgJtbqAo2VKEhoYvN2/21Q9cyajRRFQSFZ9q
	0FO6OTF6TxXwr8Y43+scQ6slJhjZo4uUsTy0r0ZdYyC997h4UGj21v/a7f6phEJfmoWTnTvGe4I
	375mcJ0bFPlMQ8RSTzBf+uXe7SFXVE+Ql8nWjT1kpOdNtMv/njoXnqyUD0Y0J84akTk2eogqlB4
	13Y2SSfc14tx6u885EbFj/PZglP3rfvBD4N6ObisxVPdfM9HBwFRvlEb090tZlnARxCWEX5TBNu
	IJVUUCAZsVRZ4hYS0rVZzChXXxRhjckQoBxpmFeonNuDk2J8GavNCmLgVUd51UAyiVmtArUIAIm
	zj35rS7h358t2BvybyeZ4Wb9QDPW7czHStJtV0c22Jixma2s8uB+0V/7T9KaNEav5CAKLW5yhXN
	JSNKhomf81Jx8TM4C2VoY=
X-Received: by 2002:a05:7300:190e:b0:30c:6d2c:2aa7 with SMTP id 5a478bee46e88-30ee144e6e4mr363166eec.20.1782757598621;
        Mon, 29 Jun 2026 11:26:38 -0700 (PDT)
Received: from [172.17.0.2] ([68.220.61.198])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee300e4a7sm110121eec.13.2026.06.29.11.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 11:26:38 -0700 (PDT)
Message-ID: <6a42b8de.ac469dc7.22d7c7.941b@mx.google.com>
Date: Mon, 29 Jun 2026 11:26:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5354481170617866172=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, oss@fourdim.xyz
Subject: RE: Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()
In-Reply-To: <20260629135044.2302753-2-oss@fourdim.xyz>
References: <20260629135044.2302753-2-oss@fourdim.xyz>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5354481170617866172==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1118319

---Test result---

Test Summary:
CheckPatch                    PASS      2.09 seconds
VerifyFixes                   PASS      0.19 seconds
VerifySignedoff               PASS      0.31 seconds
GitLint                       PASS      0.63 seconds
SubjectPrefix                 PASS      0.32 seconds
BuildKernel                   PASS      26.48 seconds
CheckAllWarning               PASS      30.62 seconds
CheckSparse                   PASS      28.76 seconds
BuildKernel32                 PASS      27.10 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      491.57 seconds
TestRunner_l2cap-tester       PASS      56.39 seconds
TestRunner_smp-tester         PASS      22.68 seconds
TestRunner_6lowpan-tester     PASS      22.99 seconds
IncrementalBuild              PASS      26.72 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/370

---
Regards,
Linux Bluetooth


--===============5354481170617866172==--
