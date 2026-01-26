Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4218A227B94
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 16:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769446173; cv=none; b=XV2D0NQcfvLZ3NLjv9XwUrc5iE4AEVb3ix+lkC5wGQ5edTGLH9qd75W6Ek78AoBNYzwJuRgQZ0viwi7x4CeowJdYnJ6i+ZmC+6QnxIgt+aIMcYY/swBdqlGxiaAfEtThzasJhvCx/v/td+LxM8JfveMu2MUMfXCZEoZKU7YXj8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769446173; c=relaxed/simple;
	bh=iEPk09Nf+MYe63V0TXgAZqsL8La1FKdkpmiSSYy2KTU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dsCkwwsAT8oTLpgfAxM9KlrxE853c7YDENniXpiK/vBaOJMNrhXiga7+J559I6XsYdeINDc1sHqRlfnI9LBDAWhURE+r+BB86/QGi0vD9d2NusBkzzRxoqwY8096NCopyTa5jADJfw/we5owmyTgk3fZWXmbYcu9jcWnGny9cEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bkqXdIez; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkqXdIez"
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-1249b9f5703so392278c88.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 08:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769446168; x=1770050968; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p1Fx7VYmmty6HU7gti+h+2a+WM1WgpkLvhSQYbkULp0=;
        b=bkqXdIezsorA0AXl54m4geT3kasRYL5Vi58Tw1adEZDmpE2hDa6dhi+GcQRcfflMqJ
         taF9Ee0js64MVX5H/HmrNmKVeSZSf0Z2W+aSur5/wgEqcwh7e9fZ7apd8GTJ6ZLEdMY5
         bSF1SIv1qymt/zU7raygz13yLlEOVvT3cOuvFZj/sNoz5OC6kzi5qbc753oVvlDslklS
         046ews4WvsfnaBKZdIJtd28vgJWfTBOnrWyhiPFd8tq6q2xB0kNnGTjr3c94GqpJCjl1
         tH54kLagaSkmQZmzpj/noJokENROPF9/NQsykv3kvcFdeRjEo4Nm4MvOXCnrJrGx1jhd
         NTiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769446168; x=1770050968;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1Fx7VYmmty6HU7gti+h+2a+WM1WgpkLvhSQYbkULp0=;
        b=HWv2TaHPs/c0Au7vEcIpqXBgRNwaXiZ7tava2u5xhTL30WGeTPg43lGNUQCrduJB0W
         4b/WmDI1shUAGJ3hBVKM1BZR7xTdrbpigl4R909gGIX0yR7IojeiYN8phfUgfx2TKUw7
         WzeL5OysxVJFl2sP1B4n5TY/sCHSjXgElDPeITabN/y1j4pu/a3vUYPhl1D+QEsj3g29
         yTurpaG4fIgl4msZjPwjDlAAbwos3KU82PHlhlcUdrM180YSYxJsn8FL2Zml8PQFZDIZ
         D1AWwTjb3uUzE5FR/Rw+KFPFKPeBedDIrOomgGW7z9TrB1OOXgilt7VzczwRHeYYTt9P
         HVtQ==
X-Gm-Message-State: AOJu0Yytcc2JoA9HlpxVp8DJFmEzgt/ysJ6kVxaZLqlTmULaewQ1/Ima
	RtF8TEEyxYZlqiBHMAU7zqsxSVqrmdIMhFh62nmKIxOUte/wWXnzrZ6l1YIUIdEj
X-Gm-Gg: AZuq6aIfRjmFWmFWJF1AcJJRoDfvfWVByqe3HPxqPZMQjkU1dhdjrnU/0S/N3+OOYm3
	unJv3VsA9EL2OMQ4whH47/yWNtAjGTC+B27OaSfm03IaHGltfZHCwuWAYTP1+tmytnjGV3T42Lo
	0knjerHF1Zm2k4F4IKhh2hm19pApVszdPElsNZzFfDbJMv4hcoslAPsltGo/tLPhj+qY4cvCsEP
	30MypyjTjbc4wakTt4A0l68s1FodY4Qr1jk5xA17hUe4LRBbN1GtMFkG2U7A6QlO5l8XUA1/Gts
	DofiG9qxnmq0an9vUbn7t6ROQtFfJymbLgB2gwqqfXgKj8h7gmi1ZMqrGocmrbmVST6/IZjg7wW
	LoQ3miP5tv4H/1S8C+OM0u/0JYfaRf3h9735rwiiAwcG7ObOUFo1tH8bR1uCoYT3X5htdZH8LU+
	rJabiJz6QtqWPaPQ==
X-Received: by 2002:a05:7300:cc1b:b0:2b7:1abc:a6eb with SMTP id 5a478bee46e88-2b764218a16mr2431458eec.7.1769446168057;
        Mon, 26 Jan 2026 08:49:28 -0800 (PST)
Received: from [172.17.0.2] ([68.220.63.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73aa2a3c0sm13848566eec.31.2026.01.26.08.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 08:49:27 -0800 (PST)
Message-ID: <69779b17.050a0220.337f70.70c4@mx.google.com>
Date: Mon, 26 Jan 2026 08:49:27 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0455035144216606278=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mengshi.wu@oss.qualcomm.com
Subject: RE: Bluetooth: hci_qca: Refactor HFP hardware offload capability handling
In-Reply-To: <20260126162444.4194293-2-mengshi.wu@oss.qualcomm.com>
References: <20260126162444.4194293-2-mengshi.wu@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0455035144216606278==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1047176

---Test result---

Test Summary:
CheckPatch                    PENDING   0.45 seconds
GitLint                       PENDING   0.47 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.26 seconds
CheckAllWarning               PASS      27.50 seconds
CheckSparse                   PASS      31.06 seconds
BuildKernel32                 PASS      24.66 seconds
TestRunnerSetup               PASS      550.08 seconds
TestRunner_l2cap-tester       PASS      28.06 seconds
TestRunner_iso-tester         PASS      67.01 seconds
TestRunner_bnep-tester        PASS      6.11 seconds
TestRunner_mgmt-tester        FAIL      117.00 seconds
TestRunner_rfcomm-tester      PASS      9.27 seconds
TestRunner_sco-tester         FAIL      14.41 seconds
TestRunner_ioctl-tester       PASS      9.96 seconds
TestRunner_mesh-tester        FAIL      12.55 seconds
TestRunner_smp-tester         PASS      8.55 seconds
TestRunner_userchan-tester    PASS      6.54 seconds
IncrementalBuild              PENDING   0.95 seconds

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
Total: 494, Passed: 488 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.105 seconds
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.182 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.776 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0455035144216606278==--
