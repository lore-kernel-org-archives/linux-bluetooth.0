Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7982175A7F
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Mar 2026 04:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773030049; cv=none; b=kg2nL3OqhFSBeTKaxEMRcMGAIihKcPV5ISBBS4a+ryxWmJXwMHocuCIUTCk0y2bKx+F9WTxHzNzoaU2Gpx956IgqO+nI9ZufCovkKM0HvNv8NzeKCYLcDd4VJxuTGhvng4chJBwjx1GL0Qd1uXFTTvAX4NfOCBWztILYnRUGK/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773030049; c=relaxed/simple;
	bh=K1bvZIKUQ86lVEjKeF2D6+7vRd5IMwB10Rkqn/6A4Go=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=JvMR8K/MYlAa1HOqBKY2kjedWw5BsSjrCHr1Q1WH12/KtWHyECpTGG3rOX8FtWIgo/N7NOXYKTaM9C2hdKdjYS2O04aUOCQPaoPf5v8Tlw86Q7Ir2bNSkflJzRVnGDVo1Y6+sUJ9GynSH4Z/0eMcJcB4OfH/Q1M8aL5feDV3j8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nl9bE3OF; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nl9bE3OF"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12732165d1eso12102362c88.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 08 Mar 2026 21:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773030047; x=1773634847; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EVo+Q604zS2e6ygHwxQAwyuzsvFZ5irCHJwjUKnGjGI=;
        b=Nl9bE3OFI8yOzJnvh/ottmrbXkTy/liFizQkASopvtBw2iYTR0MfQByRTuJP229iEQ
         SnjyNs6qe6SF9EEDmHV22odtBhdAf03hhQ/uA+BOhbmXYiNVQk1kN39N31rbo0wMWPBK
         IiXbA/lPSGIXDlg7QMYreCYI8ZLdQuo6XtA1DN3Gx7ZCsME78KlZdpy/pkwC2i/rATWA
         FTsDQc+vRU4hyGqT6HSjsowJBsvG5z0Mk5Y5amNxK81n+k+ZAHoYQPeVOQyeA6YsYamB
         Qpfujbbwf8O03yw329t4eF4m1VBx4StQYRdk3TMNAnSMJlVbl6ySlZ4SL9b2E7UN3L9D
         yp8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773030047; x=1773634847;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EVo+Q604zS2e6ygHwxQAwyuzsvFZ5irCHJwjUKnGjGI=;
        b=QcfXYpQ2WJOorkPH8LIAoSefPyRvEjUNv4hxoqrcTRHbK+W6XvXAmqt7SIKdIkQ3yN
         XkKB9qNjR3CvJbmb5yy2k3HFlx+gqNxmW5RmoFh+23D1HdXJhfqGxmB9KPmsDAcVi6kg
         vMxE4WupMvA26FF0UJx+AY+8PJwWvgYo0xVs3iD9NJvtrHf6a1+bGY6e5kc2NmDctzDn
         JQgV32rMMffSjJzZWS/XFjdz4aUV5hiqY3BS8TI9u2m4Vje2j9lGmwVG6h9Wa8spOcTG
         /nNp+gQThwwWqSW6Ap64lFHeyg2+0eKITwUUhiGNN/J9VCFSxvp8xIIouEsSfrAsqrUt
         hy4A==
X-Gm-Message-State: AOJu0YzECgyNYtcBp4t/N0piDqUGQCfFsb2Vsexzv+ZIV62bvPt8e2el
	a5jKq6CtSjrLy+ImY/+dENIQJzTYYPU70cCqJZ/XLxlxKglwQlaFhlSlPt340w==
X-Gm-Gg: ATEYQzwtIXwLrwI6YHEtSY5lGkDRpxkRZS5gnNfPWLtwvLi7VN7ebAT7t4Bq5kWPjeP
	lTIvRnea6diwb0Xq5zZva/L76qIMGw8zVHln5rt7AbRaFGiwBbfFXsYrkZLfWtYSdycztELAWIi
	DV/uYn4Tyj5QF/AQIoQ8RW5kBFajKJahIf38DebzdEO4bY/JdCNMiJNkb5y9BHHJSLJuWeSy+tD
	NzCavOTBZGwiBv+bUNkzq0xTkj2r6Ae0zO2WnkjWGa+htE8nhSKOvKMy+QaWFCOuvJljGRH0b+6
	z/ZATyzm/0ThH28cd+G+jaByPJZN8oHknkjny+uAY+BpmCSVzkAtpLGKZcPi+l/3hk7zFVWaqr7
	WMXJiNaYmdtGgXFYlvy1DCUj4aVlSOfgZnfQ7vnR4T+pYt8Zn3raxojP6Xzys2qAVMU5UUYOm4d
	PLEQk0JH6saWYdyyRmRN7bBWenme1yFzk=
X-Received: by 2002:a05:7300:72cd:b0:2be:723:a9b0 with SMTP id 5a478bee46e88-2be4de65248mr3376436eec.5.1773030047267;
        Sun, 08 Mar 2026 21:20:47 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.209.181])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f80d72esm8551246eec.4.2026.03.08.21.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 21:20:46 -0700 (PDT)
Message-ID: <69ae4a9e.050a0220.26b1ba.9e23@mx.google.com>
Date: Sun, 08 Mar 2026 21:20:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5887306275442739950=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: [v1] Bluetooth: btusb: MT7925: Add VID/PID 0e8d/8c38
In-Reply-To: <20260309025811.3329190-1-chris.lu@mediatek.com>
References: <20260309025811.3329190-1-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5887306275442739950==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1063386

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      27.78 seconds
CheckAllWarning               PASS      28.68 seconds
CheckSparse                   WARNING   32.36 seconds
BuildKernel32                 PASS      25.57 seconds
TestRunnerSetup               PASS      565.48 seconds
TestRunner_l2cap-tester       PASS      29.35 seconds
TestRunner_iso-tester         PASS      86.68 seconds
TestRunner_bnep-tester        PASS      6.37 seconds
TestRunner_mgmt-tester        FAIL      125.19 seconds
TestRunner_rfcomm-tester      PASS      9.52 seconds
TestRunner_sco-tester         FAIL      14.50 seconds
TestRunner_ioctl-tester       PASS      10.36 seconds
TestRunner_mesh-tester        FAIL      12.40 seconds
TestRunner_smp-tester         PASS      8.68 seconds
TestRunner_userchan-tester    PASS      6.84 seconds
IncrementalBuild              PENDING   0.61 seconds

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
drivers/bluetooth/btusb.c:4673:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4674:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4676:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4677:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4679:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4680:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4682:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4683:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4685:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4686:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4687:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4688:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4688:1: error: bad constant expression
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.108 seconds
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
Mesh - Send cancel - 1                               Timed out    2.736 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5887306275442739950==--
