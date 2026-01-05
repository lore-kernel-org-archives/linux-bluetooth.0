Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E52626F28A
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Jan 2026 21:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767647265; cv=none; b=D3gA1JjgPLgUpXxflSnsjlt1j3ixSdA0/e4exc0+75ODYEb0dQcb9mk/NAqBbXTHXTzMkxnikJuZMYvFdGSLKfSS32N7FR7AeFC+fKl1TNtOwuGcJrWSm6lN+1uTI21TF+TE0myS02CmoipcJr6I/2zi46vp3UuGm1pDIBV+Y8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767647265; c=relaxed/simple;
	bh=lVLuD7Uet/5pCxX8TjnXlFXEYfAwVctX3Rr0NDsPxhw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tWvC+8BdFVviG++DiSfdrTANOhUIctPzndPkiHEYiW956kGmq35+Ke3DhQfUo+pNFMpqya4ODDKdTNtcZc8T4wOVZkFl8/KnQUDcVus5q5xYwqj3llXY8hpsvIlX1me/t8pEygIh49zM/layeqZ5ZVdVJH2+Vv3BPSD+IlOMnkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqcT+rh8; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqcT+rh8"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2a0f3f74587so4219325ad.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Jan 2026 13:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767647263; x=1768252063; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=05/feDYAL1rm3+f8MF9PZrE9sv9pmc1nYBXEqrXneH8=;
        b=jqcT+rh8225GvufFiDcgO0zPyDptFx0vyd2Ex+t4B/FhomJE0VrjwpVt63gYwnlrHj
         P42or4eczdLsBWu9pQnpNib9m7PVJwu2kWSgofOvgpIEofK1aKcKdG7s/VeOfuW9fdv6
         x+OoPi+2WKGKO1ExW6KZEAJ0xFp4q6ntHEwF0dd1jTKm876quEW1A7WJOW3BtLVc6frQ
         lBSwcS0Idh1c4OwjpslH9hcY8urAjy0ThEHg3WVo3TGfDYrPle7I30DTgd/XpB1BMO+E
         n3XnMd6I/G8d8CH00/cOvmcScWUkY8jN/MedVYXGZ6s1JucJvyegdWFPgUAH4o/WiUDa
         frKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767647263; x=1768252063;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=05/feDYAL1rm3+f8MF9PZrE9sv9pmc1nYBXEqrXneH8=;
        b=tBA4VHKMZqPOa5RkRqIsgwqjNh/Hn0Czwgax4TbqbeHSgzOZxAlXpZ53oEXoIQrVjU
         tMHQTggclBhVW6xvHBSQJI+qHcKJFWiJmfD+zepzuYHwYH9q4p+mn8+SQfyrNEbn3Y8D
         oUZyrjNuiBUZK+XkSix2qxPm69jWfzbwbuoNP3SnPGzEpFeb6gHRMvs32cqbcPE/PKsx
         CWybwYBzIMkik9SPVRWXqdNhAzaxlWU5aJmppXLGw0SSjw465BvenZDWKqrNstD4q9PU
         bdWTR0hCykEdBoUytXSbfT4hzljfBAobYLMZ+OCTBfoWByb+v2ghOdt0PCdVkyzAbgQE
         I0zQ==
X-Gm-Message-State: AOJu0YwgH/8sziUBeNUM4+wvlyOXEuMxMYWwENSdf4+e35bIWusds2K6
	WRT35TSCe76jVC7CXWDgY464cFTJI1OSGlFVeKO0ddh148xrRuGS4FcXQJiE1ZUQ
X-Gm-Gg: AY/fxX4rWeuz+eyeijd6CgdyZhroTo6mnXfnAuBNzZBBPlNJZfcf5a2cgIhzLD8OwR2
	g9/ihSbQVEL3EqjNyP6un3kwGkKrOgystn+Qq1QeJOZnX4nByuypYIEkS/BQUdGo6MrExMO/1Qu
	rDY8KNtSOq1iwiw9l0jTnxiW0IdP0fJYFc0SbXK6d2Qp+s761egtRJ8XRnPDRX77C4Hef/IKAGg
	Hbt47pDKGAPCUZoUFi9uC/ErbqcluVgJb+CUAm/ZbpHrawA7hcX16J33s7PdZV+MT5jWopQtUnO
	4xIdBUo4gmjVOKv+EJS5ukXTx7wQKaGQR+Xo9c0byiwb4mKwHEMBbC4j+wDClWyB+7RhGWJT0xT
	SAq8PO8ZSOR4k/MbRbPRcpS0GDGngf4CJ64/L4EjfdHcgU8A1z/Ik/63g0/uQjB9/lYAqAaMmVP
	kt24jmcSrHv3M+CP7l
X-Google-Smtp-Source: AGHT+IHuaXxUE9PYD1sgaB4l8TJxNuNetY89PG0mNrbJbrzLvgo8IzAYDC5Jpyare2NXw2r56imALg==
X-Received: by 2002:a05:7301:644c:b0:2b0:4ae9:efb9 with SMTP id 5a478bee46e88-2b16f97e55amr498216eec.43.1767647263294;
        Mon, 05 Jan 2026 13:07:43 -0800 (PST)
Received: from [172.17.0.2] ([68.220.60.228])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1707b3c44sm423019eec.28.2026.01.05.13.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 13:07:42 -0800 (PST)
Message-ID: <695c281e.050a0220.19a744.23d2@mx.google.com>
Date: Mon, 05 Jan 2026 13:07:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1841170064931094754=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: Fix using PHYs bitfields as PHY value
In-Reply-To: <20260105204426.3034176-1-luiz.dentz@gmail.com>
References: <20260105204426.3034176-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1841170064931094754==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1038689

---Test result---

Test Summary:
CheckPatch                    PENDING   0.52 seconds
GitLint                       PENDING   0.45 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      25.88 seconds
CheckAllWarning               PASS      28.10 seconds
CheckSparse                   WARNING   31.23 seconds
BuildKernel32                 PASS      25.37 seconds
TestRunnerSetup               PASS      556.80 seconds
TestRunner_l2cap-tester       PASS      28.50 seconds
TestRunner_iso-tester         PASS      68.04 seconds
TestRunner_bnep-tester        PASS      6.40 seconds
TestRunner_mgmt-tester        FAIL      115.43 seconds
TestRunner_rfcomm-tester      PASS      9.52 seconds
TestRunner_sco-tester         FAIL      14.80 seconds
TestRunner_ioctl-tester       PASS      10.30 seconds
TestRunner_mesh-tester        FAIL      13.73 seconds
TestRunner_smp-tester         PASS      11.15 seconds
TestRunner_userchan-tester    PASS      6.77 seconds
IncrementalBuild              PENDING   1.07 seconds

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
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.104 seconds
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
Mesh - Send cancel - 1                               Timed out    1.821 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1841170064931094754==--
