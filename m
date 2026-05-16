Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112BB280335
	for <linux-bluetooth@vger.kernel.org>; Sat, 16 May 2026 09:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778923477; cv=none; b=jqVYaXbsU/QBYXmJwzg30bgqk27cxXttreSXpzp5lfE8WcRZiuzYHTpr6EZGOjn1fD2A8+KFjfSpjCxn3B50vQ0z3bn3UuzD/J/i4P+I05pjxBQ+KKsOfe3jFysmL57l3X/RkzgZcZKHe3S6Tf+hYfoKgCRYSf84PxyBOjApEEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778923477; c=relaxed/simple;
	bh=BxbtFeaiYuWSG5yVtr7odHHTCg/8eQPJRYOyMciXlOI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=K42gN/HRpVvrVOUNrj6HEf0gH2MbAK5DuFkm7HH3QI1FDOWmCzlFW3uAFBkY5m570nkKaTi3sB6DozNhngA5ShjwWqKFEZn2nU3GBt9DSL6qKVUTWsyd9eyrxKMnASHu3our7oqf+SisgWfsW0UCCYnpJ/yPNDvZS8XA9TUbv3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n9mmmA44; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n9mmmA44"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5102582e23eso7353071cf.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 16 May 2026 02:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778923475; x=1779528275; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MYPNMsjKBFhxXWKaOaOoZ4gZf/nDITh8b2ai9Zms7k4=;
        b=n9mmmA44mIc86aACW0i+/gzdTUG4x2ABKdqTN+jHh8xsLtCOPPBJlXJu79dIhK1eEf
         ON3GrOw+VohMQidR+9HWIbryz0wGZC5le5JGms1kXc3cxXA/XCOHiFHUDJxnIZ1TCvQt
         i6j+FMeSgePgwKTaSNyYFFWTKXachAY4nOvEEMsTcQ1VTR8yRhboE+7nDCwCkIPNI6vA
         275tWaZEJpT4cYyd2OnxnN0Iy3g6hmkyVtSiZF7hjEi/rAK75qup9dgE6aS/VqEAK9NV
         R2muGY24Tnqwe+2CD73zT53uEs+hGIzOYqmFwe40TO41APUJlW/IQ0AWdCI8VgYPMC+Y
         7kvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778923475; x=1779528275;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYPNMsjKBFhxXWKaOaOoZ4gZf/nDITh8b2ai9Zms7k4=;
        b=HMuy6ZAeP2SN7UBo8zPTRuAIftICJMZqkWzXdsss6uBlQJsr7V56YOqGN9F9zn7yph
         JCVJNuDKumh/Hh4/WZVynjx/r7TGSR2+XXXr5kDaef6Z0kCCx2waxPYdMSQkPSPbsiy0
         PxE6e3b/ZovCHJiaXmedj7TBsEWH9TnFgL1ybfJsHA90WJeQLHq/grpTVVmqiMuXbVTp
         av+1DgJaLnzG/uRkJM5B/Vif9LwrA5ZO6u2EgyluOgqTtf9VHF8ndRQ49tstRUB1L/uz
         PEiaLQ9/MrWeVvEGE7Sva9cXoVtQRMA6GXShBNOoCNNT564OZYbdrpTJtXxo9MNrwGdu
         vAAA==
X-Gm-Message-State: AOJu0Yy1O2JAkb/I7yQ48UII9zp4PEcYOYMwwpYuvzCLdEqs1VpbSnoF
	vB9XN8kyiZFFDAPjK9n7rkgHOb/XR8+mN0IlA/1uzLM2987+7pt0YB2LZMthGg==
X-Gm-Gg: Acq92OEtSgS+EIy5AgYIZeaYFoSjueTzeD92XW3iuVKPv6GrNM2F9kYhnKhB7sofTTc
	TZhjBBOMlay5Vx+AAD/M0HiS0pjwWlXYkHWo0ER6noihrTz/CKwytaYZdorb6D/TeQjbuI2duRK
	sjOFdqVDUcVgAw5ZOOGGqcMw6zUCmngum0VQHGGm2vzbMEfoeLQGgl8/9PRRM7k6ZyuTKrgPBCK
	InfNCarnAfaD606uclSf1LSfH/G06KlNKCFngxSrCw4hCSILVY+hTHjP7iF29o5rBUMO74dKSZU
	5M7vjc8KTk1JyM+JYc/teBeiiHfEdiHqwq1SkDiKsNvVfZrOWmoyoknBjJ/442040GlqWrUZjSc
	bcbC4QrhIWk31GBWKmsbJzdMrvk/I8TchAlap0CUJZ0yu1EoA/N26BQyYEiinDRbeCyypRT6YkW
	YsChRmgDq2sPq6qZ/Scw3pGN6etMbP2w==
X-Received: by 2002:a05:622a:6bcd:b0:50f:c36a:381a with SMTP id d75a77b69052e-5165a26a99emr82231821cf.55.1778923474721;
        Sat, 16 May 2026 02:24:34 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.45.116])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516514e0b91sm57596131cf.15.2026.05.16.02.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 02:24:34 -0700 (PDT)
Message-ID: <6a0837d2.883ba7c5.6fcc0.2dd1@mx.google.com>
Date: Sat, 16 May 2026 02:24:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2463555413506723021=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, w15303746062@163.com
Subject: RE: [v7] Bluetooth: hci_uart: fix UAFs and race conditions in close and init paths
In-Reply-To: <20260516084727.420032-1-w15303746062@163.com>
References: <20260516084727.420032-1-w15303746062@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2463555413506723021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1095781

---Test result---

Test Summary:
CheckPatch                    PASS      0.73 seconds
GitLint                       FAIL      0.31 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.28 seconds
CheckAllWarning               PASS      27.92 seconds
CheckSparse                   PASS      26.77 seconds
BuildKernel32                 PASS      24.49 seconds
TestRunnerSetup               PASS      525.15 seconds
IncrementalBuild              PASS      24.75 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v7] Bluetooth: hci_uart: fix UAFs and race conditions in close and init paths

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
41: B1 Line exceeds max length (223>80): "- Reverted disable_work_sync() back to cancel_work_sync() across all error and close paths to preserve user-space retry capabilities, addressing the regression introduced in v4/v6 where work items were permanently disabled."
42: B1 Line exceeds max length (184>80): "- Synchronized workqueue teardown safely by atomically clearing PROTO_READY / PROTO_INIT under proto_lock prior to calling cancel_work_sync(), preventing any concurrent work requeuing."
43: B1 Line exceeds max length (230>80): "- Fixed a Use-After-Free (UAF) vulnerability in the teardown sequence by relocating hu->proto->close(hu) strictly prior to hci_free_dev(hdev) in all close and error paths, ensuring vendor specific callbacks safely access hu->hdev."
44: B1 Line exceeds max length (190>80): "- Added cancel_work_sync(&hu->init_ready) at the very beginning of hci_uart_tty_close() to serialize teardown against active asynchronous registration, eliminating race-induced double-frees."
47: B1 Line exceeds max length (130>80): "- Fixed missing `hu->proto_lock` write lock in hci_uart_init_work() error path to prevent race with readers (reported by Sashiko)."
48: B1 Line exceeds max length (239>80): "- Added disable_work_sync() instead of cancel_work_sync() for `hu->write_work` in hci_uart_init_work() and hci_uart_register_dev() error paths to completely block any concurrent re-queuing window before hdev is freed (reported by Sashiko)."
51: B2 Line has trailing whitespace: "- Relocated disable_work_sync() to the very top of hci_uart_tty_close(), "
52: B1 Line exceeds max length (85>80): "  before hci_uart_close(), to ensure no new work is submitted during device teardown."
55: B2 Line has trailing whitespace: "- Adopted Luiz's suggestion to use disable_work_sync() instead of "


https://github.com/bluez/bluetooth-next/pull/201

---
Regards,
Linux Bluetooth


--===============2463555413506723021==--
