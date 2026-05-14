Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C5B3F4122
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 16:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778774543; cv=none; b=Zqje2Fj7YmPaWGvG2jdQYyfhJzchpyWyzC6xW8Y15sTz7YeVy25UXNI24OsG2LEC+eqA0+bHJ2bABABaEEpDv12cVCmRiuEoEJsZbrZGjQazFzkZ5Ri/XO6xa1b8DxHDiRcbPZO14Yt4cej72K1UAN4ixF0TluWstrTgffBbnU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778774543; c=relaxed/simple;
	bh=U2cd0bSimJlEw+IHWAiGiPvMQ7D4YcPdd4KrJYBj9SI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nrioVwtBXp0sVReDVyeURg+cY31BbMWbVC1lp4bxxbHjmXOZMXo9HmKRfB20deq0srv+m/jN6TylfWVzkNxuFCAwUVb3nVksaqNI5QTQnSOhig/1q4B0z8qTBxDTwoIrARsOTmtAbHTmSwikwch8Smtx9MQfpFCWVSDv/H8DxWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PU05zUPw; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PU05zUPw"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-30246cfd41aso1420830eec.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 09:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778774541; x=1779379341; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C/y4X45Sl3I2Wvz6l40YQG42CnMRuoDXYhcIRmKGsks=;
        b=PU05zUPw3d5KF06m0Fyd+9/6BQCOvCAgFVahFbHcJ6XtK/k4E/SgVLh5/ugKp3hP5j
         mL4QAqYw5Fki8c1cJHdlxG3jrPyKNUxjk9vh40yhUCAEa+UB3gtbq1asd6fFh6Tl2mOT
         zpuq6ewuFCeaf5AWQvRBJeAqcZV9/1hAJ50SQXnhn1xgv6ogCr6GDUXWscxQSCUeIDTz
         7790KIGYMSPA3mAXMwfjDu0QcHwpeqj9i/6iUBT0Y+XXOAQH+BIiwRUqh/ndR+/Xfua5
         SAO4VMQrwFP4uroJnrhNEOwXGIKlHZy0pWmGcpOZdTXAUCNDgURQ5LGrlOoHQyBPKCFM
         54HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778774541; x=1779379341;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/y4X45Sl3I2Wvz6l40YQG42CnMRuoDXYhcIRmKGsks=;
        b=Itiv+mn+jHtIJk2n18vGFX6h4UhNuW9hs2Y9IqHJ0Te5NT33L2aDbmUJwnpAG8IoWT
         pAlx4VOHsW3mIFFhNp/sqXpIyAfoIsPMyWkFDfCboIfe0rL/LwDHq6fu1alvFlsTk1Yd
         r55qMOguO5ocO80mwsxItWU6Llj8Cqr94DQUEHBYGa9UoNvmKr/iIc7wMLYpCT0EU222
         KGW1QSuxgD9qZ3kn6/apgYo3CM7FslF926T29Dw8vvejrD13j94iYuQLLGTVE3+8FXlr
         6JHClxPeoIP1Q0Y9GX9ulUoQP9Gv1KayUfQ5rhiHdEXIur71fUciKPSPyO1XazXd4VwQ
         gliA==
X-Gm-Message-State: AOJu0YzW2Q3jhkwNxqPpHNgcoCYDgttzRSVKie2HLoIZ6J+APwmM/bCW
	OSdpi5RDeXQq1fRLNVB18BoFrSF48NC8cjeCB+tNzCufSMqRGOzSH8jFLeBtUg==
X-Gm-Gg: Acq92OHfrjT+ExRmvVF8LYzGNbLUqU/Vv+BsUg3Sx3u6ADSLaIZAjax1mebCHpGgasR
	Df6q2RZ3gqPmSTVPx6/l/gVx0VeMfVNZYhyxWUNvHTZQrwEW/cZXnAOQqJ8C5YaMtOHDsq+XErP
	IbbadPmmDQS0Fki56zjZJsKvyZRRXVLlVX9qUoDHF0xrENbDu5SFfTKtt9s1eleUT/OalJu+9R+
	5xj71zQTyBQBt9oAqmzOKAn2u5l22siKOmelMFMBqXj8MCkMCGQJYxysYFqPKrpki3fA7boXMUC
	fHm0H5bdtuZRf7Hv0NxdzKlYGrWmD8TU3qGVS0hwN5Du4BxWmZfOyLkM2CsLr5tTJl4asxMyOX5
	HyzB7jTvjDa9WuSqOEEZVSDYh1BWoynMtyoGxeT91/xcw6XTngheY+mkbhtPSFkDfKnSqWSaFXK
	6M/PoBuox/60LaXYNkdZ0uZrT/aT9JE+M=
X-Received: by 2002:a05:7300:a498:b0:2ed:e12:3773 with SMTP id 5a478bee46e88-303986d6026mr3848eec.35.1778774540522;
        Thu, 14 May 2026 09:02:20 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.244.178])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30296dcc464sm3651760eec.14.2026.05.14.09.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 09:02:20 -0700 (PDT)
Message-ID: <6a05f20c.15ac9087.121d58.9e2a@mx.google.com>
Date: Thu, 14 May 2026 09:02:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0830407181352126051=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: hci_sync: Fix not setting mask for HCI_EVT_LE_ALL_REMOTE_FEATURES_COMPLETE
In-Reply-To: <20260514134224.1396820-1-luiz.dentz@gmail.com>
References: <20260514134224.1396820-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0830407181352126051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1094806

---Test result---

Test Summary:
CheckPatch                    PASS      0.54 seconds
GitLint                       FAIL      0.23 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      27.55 seconds
CheckAllWarning               PASS      30.63 seconds
CheckSparse                   PASS      28.53 seconds
BuildKernel32                 PASS      26.95 seconds
TestRunnerSetup               PASS      583.25 seconds
TestRunner_l2cap-tester       PASS      379.22 seconds
TestRunner_iso-tester         PASS      597.48 seconds
TestRunner_bnep-tester        PASS      18.76 seconds
TestRunner_mgmt-tester        PASS      2022.56 seconds
TestRunner_rfcomm-tester      PASS      63.79 seconds
TestRunner_sco-tester         PASS      141.90 seconds
TestRunner_ioctl-tester       PASS      133.51 seconds
TestRunner_mesh-tester        PASS      59.94 seconds
TestRunner_smp-tester         PASS      18.37 seconds
TestRunner_userchan-tester    PASS      19.42 seconds
TestRunner_6lowpan-tester     PASS      51.16 seconds
IncrementalBuild              PASS      25.05 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v1] Bluetooth: hci_sync: Fix not setting mask for HCI_EVT_LE_ALL_REMOTE_FEATURES_COMPLETE

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (90>80): "[v1] Bluetooth: hci_sync: Fix not setting mask for HCI_EVT_LE_ALL_REMOTE_FEATURES_COMPLETE"


https://github.com/bluez/bluetooth-next/pull/189

---
Regards,
Linux Bluetooth


--===============0830407181352126051==--
