Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9C63C9EE7
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 06:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779085003; cv=none; b=nZOMRT6JrMCKBIPHz0LMkEhtjyNt8SnC/67OUJSy8cKhbPvZTPnbgrlZMCQ+GoxY8SoyVI0LT9diSDGOLHRhIW2SUvR17cte8D8eM0JiXnkoPFJdSDvxPfKocfiHpKAOCHCTVPy0pP/keS3uslj+mURS9SR9zkjWniSodbITLxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779085003; c=relaxed/simple;
	bh=oCARYOm4OCxG9N7+slPEIjcnaODusv33U8XfEBcXhIw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=i6ydwxUPLnr50y1PzJoPq1OFrPOwqM5vdAwJGGiAuWBt13H7UmDKMV88HH77nTmv/xfXVpY6SE5Ye6CJjxIjxoJujeR3971F69ubejW/bLLesvk8QL3H8jSLt8+TsC/piDgFJZPcYTw06ICrQY2Dw4oVXr3eQpu+C+YQvphrkY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oCw/jKng; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oCw/jKng"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-9144163319fso71647885a.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 May 2026 23:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779084997; x=1779689797; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f5ox/ouKSHPaLy8enUd0pii/8wvtBgKRpaPTUF49ZbA=;
        b=oCw/jKngl8iIGxjfYiiaMDi2QKKSolz/THrRveukH9tXpi8eoSifwx6IyfJMJVSR76
         W+D6hh1AXKufWm1uP2olnb4g90zT7P+u5uTDU04EDZNzMr3+osLx/dqYsz8px1ih0c71
         HoYO9PRID6L4Av6TAYHVRQRfOtk2uawwpQqZmPjkVdgZX/31JvfBJIMRuI7xCAfeI6Qt
         8oXZ5DGv9wPGRfqKR+OJ1xaEBMvzMb1LhFAHDOY0p5Pini3zUyGpjsrdMS4GbjAweBxc
         8EaRES29dHqbPxRhrkxkfn9lQTHNOjmylTBrY/v7g8X0b3IVBQYlA1Kj/249oN7xc7J1
         oMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779084997; x=1779689797;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5ox/ouKSHPaLy8enUd0pii/8wvtBgKRpaPTUF49ZbA=;
        b=iQfX3EGm26tVMGyGiAqUywNPnNR/3vcth8lb+leC5Tjzcia5eA0Pd8kzeFZNqnQR16
         thx2fcl0G4y05L02wunB4oGBaDYV2om1qs12WFw/QjfPq6qAF26QSf+ffO6z4QEbTS30
         BreXJaRiw+8tu1QNlN8SdcdiFZ3XrW9q9itTTobrqDk5bT74tuirBa8qmL/1Aq1ovVjk
         VHvkaqr1/Gl0BXr9EHF2dgKuVaGMN6LNZsf7t6KHD0AYeikQd2IUlOVc5GG6jD9GPJzO
         p3YejjPb6ciJuV6OAonjVywFSPDw9ria1nCPqBvYdKAcNaBb3/WsG2j36+mIw04uUbhM
         3zQQ==
X-Gm-Message-State: AOJu0YzIn1GOBeOwH4vCapqZOSobUZuVZI+0Nk/ENxPRmzlZyZtE45AC
	V+DECW6xOFvqToIjp6SwRFhOEEBz3YYmnPi9svbJFBgpztkle+skOVv0bz2pyA==
X-Gm-Gg: Acq92OFlXBdq8pk0CmXhOJhYBDtU710C84B8mzB77h0nXA1xl8yZGUDOmHGPWCkMj5F
	K6okB21Hu1g8XT4Wa9MD6oZuuwLO3CMMjNpPwjm2tyU3uxgDYzeKd8zGJvo3Nl8j4ujNQjWDp3C
	b3dG1QU7wPWYh1kEaTq2CHz9JOXpQdIqbN6xZbrJShSbDz4LJb+bzCW8mgAjqLO93QoTjPOrMp5
	QlynkZAiSH8xEDymUtfo4SZD5zxVJU25iUoirXwC148+5VyXxerSfgx+7SiByO8Go54FmGxJRgs
	N2rFG9EZSZ7sNgdoahcWt5irrRTA111R99dysp/ExhKcy6uzIA0IoVw94Xwielue0xDJARTrzTw
	1w5+Q/kiFlhqDgR73RM+REJrB3wH4DtJzhepDje4iUSsBwaAa730YqY5uU12Ztle5GMYehz5h75
	eVwttyqo6pTkj6avFU1Q0kWsGczX3XtQ==
X-Received: by 2002:a05:620a:2846:b0:8cf:eb1c:57c4 with SMTP id af79cd13be357-911cef04901mr1995044285a.45.1779084997130;
        Sun, 17 May 2026 23:16:37 -0700 (PDT)
Received: from [172.17.0.2] ([68.154.116.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bc83f926sm1412108185a.30.2026.05.17.23.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 23:16:36 -0700 (PDT)
Message-ID: <6a0aaec4.1fd2fdbd.247711.f630@mx.google.com>
Date: Sun, 17 May 2026 23:16:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4141741848638510821=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, w15303746062@163.com
Subject: RE: [v9] Bluetooth: hci_uart: fix UAFs and race conditions in close and init paths
In-Reply-To: <20260518024949.439299-1-w15303746062@163.com>
References: <20260518024949.439299-1-w15303746062@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4141741848638510821==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1096260

---Test result---

Test Summary:
CheckPatch                    PASS      0.75 seconds
GitLint                       FAIL      0.33 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.77 seconds
CheckAllWarning               PASS      28.71 seconds
CheckSparse                   PASS      27.21 seconds
BuildKernel32                 PASS      25.26 seconds
TestRunnerSetup               PASS      532.29 seconds
IncrementalBuild              PASS      25.10 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v9] Bluetooth: hci_uart: fix UAFs and race conditions in close and init paths

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
54: B1 Line exceeds max length (398>80): "- Addressed a critical flaw identified in v8 where premature cancellation of write_work allowed active protocol timers to immediately reschedule it. The teardown sequence in hci_uart_tty_close() now strictly clears HCI_UART_PROTO_READY *before* calling cancel_work_sync(&hu->write_work). This permanently locks out hci_uart_tx_wakeup(), completely resolving the lingering UAF and double-free races."
55: B1 Line exceeds max length (170>80): "- Documented that skipping hu->proto->flush() via early flag clearance is intrinsically safe, as hu->proto->close() executes subsequently to purge all unacked/rel queues."
58: B1 Line exceeds max length (122>80): "- Corrected the teardown sequence in hci_uart_tty_close() by unconditionally canceling write_work BEFORE hci_uart_close()."
59: B1 Line exceeds max length (182>80): "- Moved hu->hdev->stat.byte_rx increment inside the proto_lock read-side critical section in hci_uart_tty_receive() to prevent read-side UAF against concurrent registration failures."
60: B1 Line exceeds max length (190>80): "- Added cancel_work_sync(&hu->write_work) inside hci_uart_close() to eliminate the race condition between write_work and hci_uart_flush() when the interface is brought down via the HCI core."
63: B1 Line exceeds max length (133>80): "- Reverted disable_work_sync() back to cancel_work_sync() across all error and close paths to preserve user-space retry capabilities."
64: B1 Line exceeds max length (142>80): "- Synchronized workqueue teardown safely by atomically clearing PROTO_READY / PROTO_INIT under proto_lock prior to calling cancel_work_sync()."
65: B1 Line exceeds max length (142>80): "- Fixed a Use-After-Free (UAF) vulnerability in the teardown sequence by relocating hu->proto->close(hu) strictly prior to hci_free_dev(hdev)."
66: B1 Line exceeds max length (151>80): "- Added cancel_work_sync(&hu->init_ready) at the very beginning of hci_uart_tty_close() to serialize teardown against active asynchronous registration."
69: B1 Line exceeds max length (130>80): "- Fixed missing `hu->proto_lock` write lock in hci_uart_init_work() error path to prevent race with readers (reported by Sashiko)."
70: B1 Line exceeds max length (143>80): "- Added disable_work_sync() instead of cancel_work_sync() for `hu->write_work` in hci_uart_init_work() and hci_uart_register_dev() error paths."
73: B2 Line has trailing whitespace: "- Relocated disable_work_sync() to the very top of hci_uart_tty_close(), "
74: B1 Line exceeds max length (85>80): "  before hci_uart_close(), to ensure no new work is submitted during device teardown."
77: B2 Line has trailing whitespace: "- Adopted Luiz's suggestion to use disable_work_sync() instead of "


https://github.com/bluez/bluetooth-next/pull/209

---
Regards,
Linux Bluetooth


--===============4141741848638510821==--
