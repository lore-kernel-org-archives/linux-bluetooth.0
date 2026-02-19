Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5C0306D3F
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 23:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771545455; cv=none; b=LIhTrOp6dJEOoTlUp5T6ieXAuCTx1HvBE584o/YCCZLm1PoHrwKVzniZEga4G5bkOko3pCm9M8yUfMEsovsWyNWr2SSdYaaQgadEs0MExQsdE5kWTaBVDp03XL+tnQIqjIx2TCnHfMwqh4cpN4XvsvT90oGBj0jWh7cEGC3BEk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771545455; c=relaxed/simple;
	bh=6HXTbeRmwEuvUN5wyKUHbnMpWbe8ZZNK+bpGEM61ZOg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=daFm4Dbn5ogt4SFsu5CiKhIV7af2gQhzxF9q5ddurOli1qPIK7BQK5jFdYQioalQrvjUvcO0JkGufSbdiPXvx17iN1Yv7EChUHzcszLlKxkxwdv7Jo9CbNEqekiZEwBWE1skPJp3Ln1wbytP0AK52ScJakOj49xdmAtku/scc3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NIiKi0Lc; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIiKi0Lc"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2bd3b0bc201so3514853eec.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 15:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771545453; x=1772150253; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VIvvVHoaCm6DBzaTBJwco9TvJ2ArM1dJvms8ohjVUfw=;
        b=NIiKi0LcqkppaIyMg6rzArbpF8Hq96oKrIZcSfuIz3jIEhMerirJSzXYOJTAk8UBU4
         hEaQICfRWnPHPwpzDzMLAGAD2rlQ5+1KS432RSFXbWADxbqqO4eQmUOq+jucBbYEy0xT
         VN98vfSaTvdK+m11IYI1Q5nptQSL6RXqD8I7O9CxemF0XfahalsbEIB6sRj0wtfHcQCO
         zJRI7ONthtBGE/l9SIYpxbbRowlNOBv75JlhZhuMrLvZD/HCkDiJ8iwWGb+J247KwzgG
         2CHnj+JQJCVnplhT+SvYGOflrQJjiTixsvvz4afbBKJSupIZX4k2sSpAwW7c/sh7KmC9
         2fWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771545453; x=1772150253;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIvvVHoaCm6DBzaTBJwco9TvJ2ArM1dJvms8ohjVUfw=;
        b=o0NfIMJ9CBUt8OH08KkNeQOkAxStFjImNUvX2dF38+uLlgwZu7dOh/w3b7T6ZvEDaA
         E/6ZKA564onozBAqadoVHp+LWiwIsS+G5h8OgcbKx43G7ABlA5TcwHqSQekdIYWw9mRL
         zV/9Rwnd10/u11Tr072k5HNVc2a0ocAbZLk2cffFadc26qJa0ObZH5mS09DUSUpCtyb/
         UrFpfUSmfUZAYK0scYJFd0qdTxayC8PLlSYw6L9eFtVYLX5KSnLUsJXYOxBGuoVFgIAp
         64eLJeDUxb52rYIELlnrEhjF+M1oY5ASWbfwmwIo2A3nbxaP0pnJL+5r5BnYiEY1rkl1
         2YbA==
X-Gm-Message-State: AOJu0YzRB3xYGuGqXkFdYqb3Y+h701CjCcuLgvH+nyyEp5/1vrq+qIP5
	jZILWEdKnZNS2V5mDChfkzoF5ZmSqf1eoF8IWIIbAF2ASzxympgXVwkL+g0X41tu
X-Gm-Gg: AZuq6aJOK5C4WsRzjCiCYJ9eEG8MZHit/R9Wnv3dTi6p3ZpI9IMfWA7znrvkcReoDlG
	duKyUCS79CMpVY/FpBt8ZNUbwlwfdgQaNH0zlZxVYTB/hSrANY10W6V/sxGMDotoAyXFHQe5KR2
	fDi7l37vJvZFzDDW2O4NY/2NEmX1VkVA8FRvkyQWuAN6gLHmIoSMWO7my/6HJI2/ZTDc1JyQM0d
	0MYsvAispQGcAOWFHtHSsIU+4b40JN8xcru23crpVfLLAHDNdZYPtD/Qds0IQTLA0r+UskAZgia
	JyflHlOwmwymiJ9yFXCxqpZIMOO4p9zJlhNZ1qmNBzQH+oJTir6YjH57Knc3fboqYhdoCBApYUZ
	XSdzbZrrojpnJSh+QDAg866KA2Ounvr/2/dDUnSJUbYRSWGQT0HThPP9GLqz1qR4f0SSqnu5fjn
	jSwvZWizMDw6PsmRjBBlSlh2PXePuRYg==
X-Received: by 2002:a05:693c:374c:b0:2b0:52ac:92fe with SMTP id 5a478bee46e88-2bd5b3c7078mr2385598eec.21.1771545452883;
        Thu, 19 Feb 2026 15:57:32 -0800 (PST)
Received: from [172.17.0.2] ([104.209.10.224])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb66c24esm21487569eec.27.2026.02.19.15.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 15:57:32 -0800 (PST)
Message-ID: <6997a36c.050a0220.cafe.b771@mx.google.com>
Date: Thu, 19 Feb 2026 15:57:32 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3343158045285701355=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sean.wang@kernel.org
Subject: RE: [1/4] mmc: sdio: add MediaTek MT7902 SDIO device ID
In-Reply-To: <20260219231624.8226-1-sean.wang@kernel.org>
References: <20260219231624.8226-1-sean.wang@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3343158045285701355==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1055716

---Test result---

Test Summary:
CheckPatch                    PENDING   0.46 seconds
GitLint                       PENDING   0.42 seconds
SubjectPrefix                 FAIL      0.62 seconds
BuildKernel                   PASS      25.91 seconds
CheckAllWarning               PASS      28.56 seconds
CheckSparse                   WARNING   32.02 seconds
BuildKernel32                 PASS      25.30 seconds
TestRunnerSetup               PASS      565.25 seconds
TestRunner_l2cap-tester       PASS      28.88 seconds
TestRunner_iso-tester         FAIL      67.63 seconds
TestRunner_bnep-tester        PASS      6.52 seconds
TestRunner_mgmt-tester        FAIL      115.89 seconds
TestRunner_rfcomm-tester      PASS      9.56 seconds
TestRunner_sco-tester         FAIL      14.62 seconds
TestRunner_ioctl-tester       PASS      10.54 seconds
TestRunner_mesh-tester        FAIL      12.55 seconds
TestRunner_smp-tester         PASS      8.84 seconds
TestRunner_userchan-tester    PASS      6.77 seconds
IncrementalBuild              PENDING   0.68 seconds

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
drivers/bluetooth/btmtk.c:1508:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1509:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1510:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1511:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1512:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1512:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1513:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1514:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1515:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1516:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1517:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1518:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4660:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4661:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4663:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4664:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4666:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4667:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4669:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4670:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4672:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4673:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4674:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4675:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4675:1: error: bad constant expressiondrivers/bluetooth/btmtksdio.c:1572:1: error: bad constant expressiondrivers/bluetooth/btmtksdio.c:1573:1: error: bad constant expressiondrivers/bluetooth/btmtksdio.c:1575:1: error: bad constant expressiondrivers/bluetooth/btmtksdio.c:1576:1: error: bad constant expressiondrivers/bluetooth/btmtksdio.c:1577:1: error: bad constant expressiondrivers/bluetooth/btmtksdio.c:1578:1: error: bad constant expressiondrivers/bluetooth/btmtksdio.c:1578:1: error: bad constant expression
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in le_read_features_complete+0x7e/0x2b0
Total: 141, Passed: 141 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.110 seconds
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
Mesh - Send cancel - 1                               Timed out    2.687 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3343158045285701355==--
