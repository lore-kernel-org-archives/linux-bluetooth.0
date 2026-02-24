Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F00A304BDF
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 06:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771916283; cv=none; b=hnhOR+nQTldKQmpgkgy4HETZexAnE6OnrJVJ+AJVzTS340o5I4nlpPjgICDGIkDJ1DELURWUjsFQkMNkLuSPrWmqUBwox79Qj7rM8hUXFqhGtF907U74uIJczflX+a1v3jZQygU1P9raG/GBJ19SnmuXoozJ5CH6jHJvu0LXfcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771916283; c=relaxed/simple;
	bh=gQnx/i1E4Dt+5ybPFY6/vsGpH5T6Pnke6vElZvLPW/Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=r/ilbQRIN1iAPDG4p304Cx2PP0yYe9dq7OVayKTmmU/q6Sg9ypQ98sc7wNzyN0YVWhHcABZpn/Vek5C+orXfeHgw17Gm6ur31YiWhkjo0NQipGj9XIns1DMZ2xnQiqFbciY+Mm1GxJRTmKygoUN/eF6Kp4Y64Cv3IGx+e1bSoV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0Lf+JAN; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0Lf+JAN"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2bd3b0bc201so598794eec.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Feb 2026 22:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771916277; x=1772521077; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IQ6A/kQv/ygupFrJORFJjC1hOiTtIzkWrcTGWSrzy8w=;
        b=c0Lf+JANOlQUBg4D+ZueXraPeNbLWgOCQgc90KCHmfW6mXyHUCamqtHn8Yvkfzu075
         YjezA/QrxkT7e6oA0V8fcqCklybWDqX5QWPmQUjMc3QxXCnQZ7zPgsWeGfdA08iBD+kh
         eMPTBcIUWB6rfrrswBDaFxKt6NRZY3Y3lp7+kbiMWdHTcGUcy0UyukZyirgdrCetIrcr
         /6Aj86FdKEUjqcvSrc9TLaQNcXO3P09HPxXnPEWPZapAYaXbiYclmuiotEtq7e0ObCVi
         FpraudNYsqoN6I852EgiUtHkK5HxrmFkQq7n/7BUXxK/aMo+VlnB+Xn2+3Te6ubAOEmW
         NHpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771916277; x=1772521077;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQ6A/kQv/ygupFrJORFJjC1hOiTtIzkWrcTGWSrzy8w=;
        b=Igx+UXKfcY97sgRxBGwU5kE6epJSJzhNNkuY6oUHsoJsgGGvOHHfVWTivn+I6Qv+ZJ
         CeAz25eytZfhVa9m+WIPy1dgRZgDAk2KadAc3MMdduHaK2XQ3terwY2uiPGFOH+xvzRW
         IOXx4zMUFKA2qbR9r2WQRNduKaqIimhep0eMm1wBM6ZvwWBB/QfrFf7XBxra7g2jDkoN
         P1vSGF9wvvt8LIqn1yLLlODu3OorGgR1vB2i4lcsMx0CZb0Ex4J9Z3CF5pUvyxJNw01k
         B0PevhTMRh2c1KfBKnAi1Dkqv4tBdGzBm8Ad2FPAhdGd5KMs7gkleO1v3zj3ZY7ZLCpC
         jGqg==
X-Gm-Message-State: AOJu0YxdA9A7G3QEwA96VAEzqcUK0j74UTKf+uewKomftzACXcAUyr6J
	rU8kMGUm/N1ozSkp6rqXv/RYpGWn6ewME4MKHTnHoppPwPzIaAdyZ5vI8ENlQMZf
X-Gm-Gg: ATEYQzytGwor7YaTQte35yyR6aWJmSfepf+Oh9rhsoy86bMe8oojrtVXDXufMHBe93w
	3zzH/po6/LWBYJmKQ+MNa8pZxEOmZ8G8hR6RNBgvZLlx70jggyC3t0mDhtzPV5G5zsscUzsnfy1
	Np/4eV4LYNPavvVitdIde/QStWqSVmE3B/TozEPAZfElAcdAIK72BULOPUndu0kNrxv9G5/PQkO
	6RNnZljP+cDHAWolyC+SvEVagb+XYkLM994bPMVxYJBCd8WN9034KAbqxTyjeCJAI2n3OlrcavU
	13JupGwCyB4N2V2EnkK3GJ52dYcJ3YkWYCdVmByZt5KwpLjElfqjqcWfbPYnqWgL4OeqGeET+kF
	rG+7T4oYX80u+zjRz72QPKGCBV71nnHHHUi51bJNNCiA0CcEXvGZJoCZssUY4uvUm3WM4n4vJbn
	qK3R1wRsE8LUaq/O78/mHKpx5jzPBR
X-Received: by 2002:a05:7300:a949:b0:2ba:73db:3e81 with SMTP id 5a478bee46e88-2bd7bd6a424mr4189264eec.33.1771916276609;
        Mon, 23 Feb 2026 22:57:56 -0800 (PST)
Received: from [172.17.0.2] ([128.24.161.86])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7da45537sm6198825eec.7.2026.02.23.22.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 22:57:55 -0800 (PST)
Message-ID: <699d4bf3.050a0220.2bf6cb.a9ae@mx.google.com>
Date: Mon, 23 Feb 2026 22:57:55 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4581573018264933993=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sean.wang@kernel.org
Subject: RE: [v2,1/8] mmc: sdio: add MediaTek MT7902 SDIO device ID
In-Reply-To: <20260224061325.20189-1-sean.wang@kernel.org>
References: <20260224061325.20189-1-sean.wang@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4581573018264933993==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1057030

---Test result---

Test Summary:
CheckPatch                    PENDING   0.40 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 FAIL      0.85 seconds
BuildKernel                   PASS      25.85 seconds
CheckAllWarning               PASS      28.49 seconds
CheckSparse                   WARNING   34.06 seconds
BuildKernel32                 PASS      25.19 seconds
TestRunnerSetup               PASS      563.84 seconds
TestRunner_l2cap-tester       PASS      28.67 seconds
TestRunner_iso-tester         PASS      114.15 seconds
TestRunner_bnep-tester        PASS      6.53 seconds
TestRunner_mgmt-tester        FAIL      115.33 seconds
TestRunner_rfcomm-tester      PASS      9.59 seconds
TestRunner_sco-tester         FAIL      14.79 seconds
TestRunner_ioctl-tester       PASS      10.31 seconds
TestRunner_mesh-tester        FAIL      12.60 seconds
TestRunner_smp-tester         PASS      9.09 seconds
TestRunner_userchan-tester    PASS      6.84 seconds
IncrementalBuild              PENDING   0.50 seconds

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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
drivers/bluetooth/btmtk.c:1508:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1509:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1510:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1511:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1512:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1512:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1513:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1514:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1515:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1516:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1517:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1518:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4671:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4672:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4674:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4675:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4677:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4678:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4680:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4681:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4683:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4684:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4685:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4686:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4686:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4671:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4672:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4674:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4675:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4677:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4678:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4680:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4681:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4683:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4684:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4685:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4686:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4686:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4671:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4672:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4674:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4675:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4677:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4678:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4680:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4681:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4683:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4684:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4685:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4686:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4686:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4671:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4672:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4674:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4675:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4677:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4678:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4680:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4681:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4683:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4684:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4685:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4686:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4686:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4671:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4672:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4674:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4675:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4677:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4678:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4680:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4681:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4683:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4684:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4685:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4686:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4686:1: error: bad constant expressiondrivers/bluetooth/btmtksdio.c:1572:1: error: bad constant expressiondrivers/bluetooth/btmtksdio.c:1573:1: error: bad constant expressiondrivers/bluetooth/btmtksdio.c:1575:1: error: bad constant expressiondrivers/bluetooth/btmtksdio.c:1576:1: error: bad constant expressiondrivers/bluetooth/btmtksdio.c:1577:1: error: bad constant expressiondrivers/bluetooth/btmtksdio.c:1578:1: error: bad constant expressiondrivers/bluetooth/btmtksdio.c:1578:1: error: bad constant expression
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.106 seconds
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
Mesh - Send cancel - 1                               Timed out    2.715 seconds
Mesh - Send cancel - 2                               Timed out    1.991 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4581573018264933993==--
