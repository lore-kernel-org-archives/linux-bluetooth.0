Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33DD3112AB
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 20:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771532375; cv=none; b=KYWeHwkwWgvaz6tOn5AVTkWrTdt8v8PhGpODHM/duS4Ok4g1FS28ezq0ZiN68d9AGSZGxF8x8mVYR6QMM1LI5qZeyjvFwuBhH9HYkSKl0CERjXTiXzMwFCDAF7/v7VbaSJqyTeLfHQb7CkjbBdj/pst5WpvOr5dGFtKwt3/cZbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771532375; c=relaxed/simple;
	bh=Ao/SdRyWlBJp+oS5V/l+SDPwukCI4jnJ+2TztKKGoEg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SYbxFE2hRgPhPtiuV5Bz5DYIDu6cZQ0u8H9en15vriPhFyO5JOA6lp9t2smVSb6a8IYIADdxqcjLkcICmGMs2ppS+2cMMCAmPdyNBV9+rv/d2R3dbkE8NTV2NN+ZhZ+aurOoFy8YF6SDPuWqZJ8/oiedwI+5VrZc21bM22oQJFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zgty+Shb; arc=none smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zgty+Shb"
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-12721cd256bso1491758c88.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 12:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771532373; x=1772137173; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VriSGbAVkz0Ge+grRbFuQGwY0GDCQjumjBAhFdwBpF8=;
        b=Zgty+ShbX/XGsHsPWLmjK0nkOOVc3mG+QUlkJx+7RpUe0x5HnIHbqNvVpPHdwcDmx+
         m1QkCb47sTWuj2DO+gxPH8Lq8QIUa+gjcuf3foiaKTOJuBEipJvNXdhvuDNY+X6EmcL8
         p1Mp1ilSSc/KdCsShtdX04VP/xmIuyLazcQJiLpVmr7qOPywQUSWTeDI1RsE2vhF0FOY
         8Jd2Fh7bkuCnUoTXgt4ZMOgIJRnOjdLAWG4Q8Ltb8+1ww1fIwBPtw/osPXD79PgTsGQ3
         NcMboH/ibc/6VQkxgbZ+pBmJJ/kiDgJB0i7dapDofZFpqxAEYFDlxzNzpEVl5bWzCDz6
         /5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771532373; x=1772137173;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VriSGbAVkz0Ge+grRbFuQGwY0GDCQjumjBAhFdwBpF8=;
        b=Gu7jWJZkiCz4s0HQegxbJnqgTiBjkuPejFTTMb63IpPdUlknsuRfnnFRtJAYyKU+N6
         2Oks9Bo9n7QXP9aV4mc6ibv1mMTYkZw+/CsVny0ewv0gu3ez+W0drRkGX2NJbJpyDuvL
         M4+9DEh++xl5TPlbkPFIwXjfVnu7tdz8mUg+6C6EFVhoFYST+/82Oq0VVHr81yF1YIeZ
         PNsTWuQajq6+PWdza28+tDDSoVlpLx/cB5qdv95gtJ0Cjm54HCkFU6MKPDOkSO30JRk/
         b/oHf56u2MVP3AKsAgUM3BejIAfyhIFjl6Uwc7DZ4mmHLjCOU05TKzBs23oUklegr0ST
         7efw==
X-Gm-Message-State: AOJu0Yys2Ppbr0M0Na3K0zhneqJHavl6FjOht35fLjS2mDisoiftRRda
	uvGK9mS7eB2eRe2AeQH8DwJKRlFrMMUUEQzzehcREReiIz6grcx+25rTWk6wJURY
X-Gm-Gg: AZuq6aIlAQ5Wz2mFitmJ7e3iTf5zPHSyteCvz9uMZD+XZZ88uYH2TA9jQkdRlYkGWBW
	yp6skhEuIhfC+y/tH2c3AdbqXzA+FP+Zz56OSLbtJJbH3RmHZVd2FCwaLQc4l4PE75rotX5DI+n
	ArJXn/unPbVWGdcJ0VipNaTmvIBn9KswZkRz/m998uWgDTig+E9Mrrnlm7UU009ESaC1ozUf50e
	vq7puTVV2WAo9+GnWbVohkqxv+IyXdyeFlWvB5prdzwgxnWiFsz7msq56vYMBBcmnRrv7xF5iKb
	Xc59O7UQrZ81E//Is6xdwKdd8prkFUt0zKH9QgqWFZZuMW+ndwqM2V5mnXFUWiFyCwENIJijEPz
	17/ZjngAIAF5U2cFR16KqrhVuNbeYzCUqDz+wwADsyxVcfxgG/noUkh5jr1y3W9kw9sB2FsWU/P
	gHVkDvK50TmQvtpZs2j9O0Yfe9gGTg
X-Received: by 2002:a05:7022:6192:b0:11b:9386:8264 with SMTP id a92af1059eb24-12741beaa56mr8556982c88.41.1771532373264;
        Thu, 19 Feb 2026 12:19:33 -0800 (PST)
Received: from [172.17.0.2] ([20.169.75.146])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742c63feesm27584641c88.4.2026.02.19.12.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 12:19:32 -0800 (PST)
Message-ID: <69977054.050a0220.6b320.6dd5@mx.google.com>
Date: Thu, 19 Feb 2026 12:19:32 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9058679018600191817=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dylan.eray6@gmail.com
Subject: RE: [v2] Bluetooth: btusb: Add Lite-On 04ca:3807 for MediaTek MT7921
In-Reply-To: <20260219193209.69937-1-dylan.eray6@gmail.com>
References: <20260219193209.69937-1-dylan.eray6@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9058679018600191817==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1055646

---Test result---

Test Summary:
CheckPatch                    PENDING   0.50 seconds
GitLint                       PENDING   0.31 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      29.96 seconds
CheckAllWarning               PASS      32.80 seconds
CheckSparse                   WARNING   37.34 seconds
BuildKernel32                 PASS      29.94 seconds
TestRunnerSetup               PASS      575.93 seconds
TestRunner_l2cap-tester       PASS      28.84 seconds
TestRunner_iso-tester         PASS      107.19 seconds
TestRunner_bnep-tester        PASS      6.48 seconds
TestRunner_mgmt-tester        FAIL      125.64 seconds
TestRunner_rfcomm-tester      PASS      10.47 seconds
TestRunner_sco-tester         FAIL      16.50 seconds
TestRunner_ioctl-tester       PASS      11.71 seconds
TestRunner_mesh-tester        FAIL      12.56 seconds
TestRunner_smp-tester         PASS      10.03 seconds
TestRunner_userchan-tester    PASS      7.62 seconds
IncrementalBuild              PENDING   1.04 seconds

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
drivers/bluetooth/btusb.c:4661:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4662:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4664:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4665:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4667:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4668:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4670:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4671:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4673:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4674:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4675:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4676:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4676:1: error: bad constant expression
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.107 seconds
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
Mesh - Send cancel - 1                               Timed out    2.127 seconds
Mesh - Send cancel - 2                               Timed out    2.000 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============9058679018600191817==--
