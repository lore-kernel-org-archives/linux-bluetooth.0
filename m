Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D23E366
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Nov 2024 01:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732584014; cv=none; b=FtKA5LCYx4tKIAkvRfqnjiRyIZqsgg6+UbwuKMrmpmN+fli4mKwN581Afs6ZFUigT9KOzAjqK27XH2rtksez7vb1MzAmTnI9jJBBEXLVY+Eql/eeNuZIr8MMBQAg0Hz0VaR+Slzs2UMdnw58sFr5+zqR6KknI24zPs1mIbZYASM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732584014; c=relaxed/simple;
	bh=2emKYNLLPQq3U82U7TM/FjEvWhlGXa2rtzgUdOtB4fE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fgJRb2aA7dOw+XLUi5RRX7ItuxoubeD6OF5v8k1VSh31rT8EMl9AKz3/tX8c/mgcy0rBI3xXK2nYu1SYMnvqNPcu0KV6HPfNB3ebvo2uD0QnizNtu0qzzhvUJpRuV22aDgh/foimdnSnVqZpYez64PhxxTLqOtlZXWY0mowhB7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BK0Kz+Lg; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BK0Kz+Lg"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6ee7a400647so53917177b3.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Nov 2024 17:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732584012; x=1733188812; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KkCMR3ivsxyI6taCFk0g5RmuzQ3bbqk9XcFull5DAnQ=;
        b=BK0Kz+LgwgbXEPsRAHpf5FdJmTdNu9tCev7TDCe4XmQLTaWnrgc3BnVZ6Orx/4ka8x
         ayT8WynpXuQZLAQskuAoAidNCcopBlzP2S3wVT1X8UptmZZ0A+eZXce5nq9cBE7A8W0U
         bSmkxqisO3VCW29iCfb+uLzSutSdndW+bm/Oq8h8/C0EWgif4QE3ObsBX8La1Pl0SXU2
         7vkIJx1Ile7HaLcU8Ns2q7SaQJEqhncKAhGt9s30D5Z+ISrysFw2l6CwIPmYA6mDBCky
         S4lOiWEM0gTTLom/IxEIxrqmSxKLhR8ms6War4Gmc1MypquxUfPyGGSoVelpQzMOBSJx
         o//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732584012; x=1733188812;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KkCMR3ivsxyI6taCFk0g5RmuzQ3bbqk9XcFull5DAnQ=;
        b=u3PehDEdR/rTs9lQVmxZSaGT0VDdH5ikMed5zjkjEv5ebOwOco9z+s+LP0LDiRRgrq
         0JKVGVZxPKo/lhcKTUZl9ehWyLUaV+zfKg6GbF6VrMTkR1cy62OW904QBWYmybnOT1BS
         FIzEcZCEcLZ8sqp11i5a+B9m/S2ts31qtzd144C/qZy27xcrtR3XEaUDeGe0Bk6rOw2K
         0Poo95e8aWHrl7rOv3vVSJ+mNdc7Tre7SV8LYzkuzbWBfg0SVYtUwZ7ugrif33I+XyAM
         fMHqT3T6HXiil6el5D77khbRuLuJBRy9fx1VSKxQna4NyweRnXWNtxBlIcBpkj495jI5
         lOWA==
X-Gm-Message-State: AOJu0YzasYTm3oQjtV0QWXmw4sRCHR7sUP8S5JmwvlF+FNLlWyd2h+D9
	5Sj99iYb4Trgeo1/M6tTMvSpPh5T2XglRqn8nWfn2kVICzqBeePZmGIx7Q==
X-Gm-Gg: ASbGncsUcmc4ilISW9ZeQt+HTAzcWABi/HXxgvtA5ZMv8JyjVeB63YX0SZ43Zf6K87x
	kedfrDc5mNDaMdYNjoLYQrpCxWhdSB1DVrFX7d+CQ/mjk7fcJo9/XD8FKAmoeAyLYOB4B5yImxQ
	QugaXpwxfk6yk7/E5nIZeeK9Pdtor6jNQE4hCVR0XKh1hY1906nSC6k7p371w1oOcXVhU3CYpqb
	n1BOs5CQ8U07BUBu0r0F8NK2z+65wk/xqAU19THQZpaoe6L8mdE+QOt
X-Google-Smtp-Source: AGHT+IFGTIPvu1wYz+DQSWyNSVA6/hYgaFfO3Q0pOzCdrY/zwNNJSjWx+hZQ8X2O7x/LOic7pG+YNQ==
X-Received: by 2002:a05:690c:360c:b0:6ea:e967:81da with SMTP id 00721157ae682-6eee089f1acmr129704587b3.11.1732584012052;
        Mon, 25 Nov 2024 17:20:12 -0800 (PST)
Received: from [172.17.0.2] ([40.76.238.211])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b66fa3706esm104946985a.13.2024.11.25.17.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 17:20:11 -0800 (PST)
Message-ID: <6745224b.050a0220.1e0f94.379e@mx.google.com>
Date: Mon, 25 Nov 2024 17:20:11 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4587513095490536886=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, eadavis@qq.com
Subject: RE: Bluetooth: SCO: remove the redundant sco_conn_put
In-Reply-To: <tencent_10C852E0467D89872ECD2EFCCC9C27D68606@qq.com>
References: <tencent_10C852E0467D89872ECD2EFCCC9C27D68606@qq.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4587513095490536886==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=912374

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.16 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      24.63 seconds
CheckAllWarning               PASS      27.21 seconds
CheckSparse                   WARNING   30.61 seconds
BuildKernel32                 PASS      24.95 seconds
TestRunnerSetup               PASS      437.91 seconds
TestRunner_l2cap-tester       PASS      20.52 seconds
TestRunner_iso-tester         FAIL      26.26 seconds
TestRunner_bnep-tester        PASS      4.87 seconds
TestRunner_mgmt-tester        FAIL      120.55 seconds
TestRunner_rfcomm-tester      PASS      7.66 seconds
TestRunner_sco-tester         PASS      9.54 seconds
TestRunner_ioctl-tester       PASS      8.25 seconds
TestRunner_mesh-tester        PASS      6.12 seconds
TestRunner_smp-tester         PASS      7.15 seconds
TestRunner_userchan-tester    PASS      5.14 seconds
IncrementalBuild              PENDING   0.58 seconds

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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:147:35: warning: array of flexible structures
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
Total: 124, Passed: 120 (96.8%), Failed: 0, Not Run: 4
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 487 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.174 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4587513095490536886==--
