Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3DF3E63AD
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 15:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778857951; cv=none; b=rESdpDM7uq2OQXmHydGFfSyBzEJCKFQDuHjZfUsd/zWqOPzDgJVl5yQt2aU5jgGI9kVUgUXIliN8aVR/zAmNgpgGvn3HZKBGiOGYerISOuvK7wBM8/wEC6+diUKHrku9PpSeeK4hhXauInxz5971Z30cB14TYIkDZHYwL053rl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778857951; c=relaxed/simple;
	bh=hr1G/NtSacjkOdGlCTJPGBQQ0o+MbHjBxU14hjaW2+w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=E4OiUICPgBF4NzByPrIcgOZu7s96tBvQFvwIt0v+TOrZEB8f7HxNRFhdu5eW35MtnypCYmcMxSW8QBbmtMrqb5HKAJSRTfIpQ+GStmBqLAVGwg41gXZc2vgTLpyS18ZYmi/OUeg+UD2boL7VB6Q6nJCsC0fN6PM+wPrJPiFN29c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+xRgMzq; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+xRgMzq"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50faf8ed9c5so49439551cf.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 08:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778857949; x=1779462749; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4sV1DGCnFC9tHFk58JfRx1PEFSu04Jx0wCMOwC5/LPo=;
        b=F+xRgMzqsqikL3+Ampx4fnbTHxNje+Gszf7Xtq9dOTy79CoxtIJZo5dlozR1FgcFhO
         0wRrskqSEWJmXT3pldlBPQcm9pV05wYWCGQrepVBxHzV30zyr9n4NoaGwffAkavaZ6QO
         rx0FsgQjpcT5AAbj4eXh/+VgtmaMKdYz7K3iu6p2cTeFiVFuZcbik7+J7pw4E46a4Zpm
         Ls36p46miwDj2rZHvjZ9mi9hTy3DX2WsCO36NXFrtEoT9W5M/+5wUh9BxlHhXTlMtCTF
         xiee8PwyPXCyof1V4OoK00yZD7fGkzkJfYVcdzD6ou4IYLc5wyc95x01fn8e4QtupeYZ
         Eyvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778857949; x=1779462749;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4sV1DGCnFC9tHFk58JfRx1PEFSu04Jx0wCMOwC5/LPo=;
        b=e/JvhGruzoj8cLY/8hPFne0yRePxZupULdjCIyjc12pra6+xFpayPRDMY4GJe9y2LU
         6a8trNjC6bNbLQJfZhtBGWdUixgM3sA2MM0X58xc9niaBoaeN7z2A2oIiUEKoUvWAtvt
         Jcg2LSMDPVKfW/sfHK4/c6UIGsrczu3pIIvnlTzv/1XYLxLF3xhK7CtASEIoIcR4JGEQ
         Yk+ryPGMxhJvn5q1xwWJug5HEzIn4vNrma4/kq2i99y3sd3ybUjNUv8rYUNSlB/tSBUu
         vG0ne3CeL1urjcnzjsBVM2Ir1moYarbpxIRTNoqmIWveZl8oVcYsPKIjb0YfszwJBAeX
         J7Lg==
X-Gm-Message-State: AOJu0Yzstg02m59ktUK0QtGdfJXPPFIWm1Wo/n40crmrJZ3s0bx5Nq1e
	r/B//vinUW9QD+NJQVzUyyKTX6cQTd+TVmMRzk7xUO74kykcVV8wVXyBUI+IWQ==
X-Gm-Gg: Acq92OHlaM5RTbdfYKdsnKmC36ZIbPEudEIG75I6voQXnXb1zTCaWLTJn0e+6JxbNO5
	ObufINHg7oCNQZ0dkM8JHTKmhzEqOEmmanjOxFfBnbiL5WQGjkeXhQGZ65TqtZB7IxJmskIP7zZ
	OZg03jCMPSQA9eIeYhqEij8kreoSuG2BY0+G/9eORR5+/1w6RHuQNVpAZfrOX+uV+GyIKsSby0B
	bG3yDNW1SHeQR2thY8VKSVR3MEXRdlNguA9GUNzEnYd0JANPI8Ioq4LAmPZ3uHNp7e0xyUdx06z
	ei+59eFK3cCun1KKCCwGzLY5813BAw+s0G1vnvhi5c7HunW6iEMJVneYfGSPp2JvZTyS3QVs0Fi
	9tq/NOpDQD8YamaMgMSkoj72WYjGu/vaZzSYW8EoXnnAlEzdtjQdHUzYLBXKkICUGn/Q2o3XQYt
	ICsh6EimEpbJAz+wak0AE/7r0tXRoh
X-Received: by 2002:ac8:57ca:0:b0:50d:89bc:f450 with SMTP id d75a77b69052e-5165a001072mr66819891cf.11.1778857948702;
        Fri, 15 May 2026 08:12:28 -0700 (PDT)
Received: from [172.17.0.2] ([20.51.199.20])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51645688c13sm46279931cf.1.2026.05.15.08.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 08:12:28 -0700 (PDT)
Message-ID: <6a0737dc.a9c3b6c1.280cbf.bae1@mx.google.com>
Date: Fri, 15 May 2026 08:12:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9081658030399234046=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, w15303746062@163.com
Subject: RE: [v4] Bluetooth: hci_uart: fix UAF in hci_uart_tty_close()
In-Reply-To: <20260515140548.393865-1-w15303746062@163.com>
References: <20260515140548.393865-1-w15303746062@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9081658030399234046==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1095463

---Test result---

Test Summary:
CheckPatch                    FAIL      0.78 seconds
GitLint                       FAIL      0.32 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      26.60 seconds
CheckAllWarning               PASS      29.40 seconds
CheckSparse                   PASS      27.88 seconds
BuildKernel32                 PASS      26.18 seconds
TestRunnerSetup               PASS      590.38 seconds
IncrementalBuild              PASS      25.47 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v4] Bluetooth: hci_uart: fix UAF in hci_uart_tty_close()
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#88: 
  ODEBUG: free active (active state 0) object: ffff88804024e870 object type: work_struct hint: hci_uart_write_work+0x0/0x940

total: 0 errors, 1 warnings, 23 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14575010.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v4] Bluetooth: hci_uart: fix UAF in hci_uart_tty_close()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
16: B1 Line exceeds max length (124>80): "  ODEBUG: free active (active state 0) object: ffff88804024e870 object type: work_struct hint: hci_uart_write_work+0x0/0x940"
17: B1 Line exceeds max length (86>80): "  WARNING: CPU: 0 PID: 338273 at lib/debugobjects.c:612 debug_print_object+0x1a2/0x2b0"
56: B2 Line has trailing whitespace: "- Adopted Luiz's suggestion to use disable_work_sync() instead of "


https://github.com/bluez/bluetooth-next/pull/196

---
Regards,
Linux Bluetooth


--===============9081658030399234046==--
