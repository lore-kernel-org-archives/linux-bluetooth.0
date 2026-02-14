Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8902857FA
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Feb 2026 22:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771108798; cv=none; b=Ek9sfN5uSI7D+9Dz/q505Sylui07qo2VxWGBwElkX2Z1otlWJqHhsZeCeCFJ2xDAZjnX8WXy+S04NDEK02UOyO3cm6EvE7ricmXYJriwfhcS99GvAHLUg9mVanfTyDVb700v3f0aMZg+1mnw5L/4XiWi+NP85cVLufcQWmO8Ci4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771108798; c=relaxed/simple;
	bh=tOVRFBCKuG7JZhXvffE8/hvbbOPmTpzS2hUzA3dIQPU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qL6BdPv9kgc3KfrJjSDeQyrx6jto5UwVnDt+AU5rznMCBo4S/wKlrMWEMhR7+fnr7WxR0QReqShtYuPh+fRVD0Yveq0H+EGgSNFuWJZ3iN4Lr0XyY2tZSl00xvXfdmYyGypALypVaKLjh6K2GhmgqFdkAbx60sw3lOxQ8sw1plo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZiCwX47Q; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZiCwX47Q"
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-7d1890f7ee4so1247904a34.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Feb 2026 14:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771108795; x=1771713595; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DZa8cTx3zrWsBqtJAhzmHCUpV8uy/UpEr2YvmLKXz7k=;
        b=ZiCwX47QIO5rRY9CeQmnluChD4568CPFen3Gd8K80qBFlVd+SOg8QKm5VgyhSSRV1T
         e0r31jNrZep5q3fdkmNJvBFKj62W/FhgOgWTC3vPr5nKlXx+E8uohaa52Er7VXXLOQ59
         c6tQgoZ/SCQGOs2UceLT+O28zDBIv1zMM/PtMkxGaDZsSPRl6smO5qrtxA38ey9OLQ80
         Av+hbPrDwEJLIQ5aWm9O+Fkup5e8ZP64a9blufi9zgXpnS/dBVg5XG6JrXJYO+7s3Itv
         Ky25dnx4VWmWjEH2bdm0fjLURRRQJJuiQ5mTQkElPDszLozORLy2369Qk0WJMxxZJQST
         kQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771108795; x=1771713595;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZa8cTx3zrWsBqtJAhzmHCUpV8uy/UpEr2YvmLKXz7k=;
        b=lvfcEr0iVde2W62kKMRNHrue0d+ARls0HYIMs79MHPNCTizgHQRKDN1G2Ol+X5Hn/q
         HaCnobWspCSM39E4p8Ov1JY6bsl/SiPlavkNKyVX5l/aKbMVwnsLNQHv8ByGfxmX7gM/
         d7iVuumKvH5HdxgHKJWl/rPSknuUD2m/9j8LFqYgu3EUJH6xMooq5zMTrOgzo4+K6pIv
         I/NWGKVwV1DJ/wRP86belVuBgbxe/ailmuAAoqrARXiLz9WqmCaJAvR9cKkjKw8TBIkI
         7k9q3uTLub1kArS/ZslabOoiqF9Hz4cz4BS1UiKwvn5HMhlqIyp2AmmJiBd/zyGhjVrP
         u6Gg==
X-Gm-Message-State: AOJu0YydOLkvMT8z6KYjoyiYnAdA/iHmOrNIHFD9K+/p/yUia+r7FP57
	PewVar9N7xwAN0uZAAH/H3p1ZdVXSF1/NdLElLXpvq4wxYFspEbQM9LTFqwIA+eu
X-Gm-Gg: AZuq6aIddIoTah6IOqrw/UWObcdmbpjEsuz9gX3BqOOL0Tql3rjVG4JJCQySOOl6KKr
	4rcnyb3oxFIzClEFBMb6LmqpiWm0q3b9MZxTwKE7eY2jfV6wYiwUKO9YWiW4D1p1HKo24Ejqhap
	g2W+bZ1RoadUqqVWgDQjRgmvZ3vPXaRQbJHGx0RElJ2UJKamL/RXh35glIowC+mKnWeiKir29t4
	5fVnSSJRayPMaQfWAM7LTrvZj7uMywDaHr+75tBDk2nde+KsvYD19rzDKTbEikR7RvtguFvw1xS
	yA2nTRHgZR5Znl73D2ji1+gyI5aEpwspn/bVTmjMPsZqsl7q82VtUYp2lb07GNqZYai/KXwj5/W
	OlKlFWrXLEhBZhiKkrx095j3eGW7ql15Ozzsmu6DegRyXJr0i/Fbo+H7WZ5FWOZ+E8Af0rCmfCW
	tx2rRFS1nncIs5sTZvSKzpz7xRGxRy
X-Received: by 2002:a05:6830:6213:b0:7cf:d6d3:df0b with SMTP id 46e09a7af769-7d4c319fb50mr3613962a34.21.1771108795463;
        Sat, 14 Feb 2026 14:39:55 -0800 (PST)
Received: from [172.17.0.2] ([132.196.83.34])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4a7530d08sm9278509a34.2.2026.02.14.14.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 14:39:55 -0800 (PST)
Message-ID: <6990f9bb.9d0a0220.e15b6.df82@mx.google.com>
Date: Sat, 14 Feb 2026 14:39:55 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2992027714508451708=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, edo@akse.cloud
Subject: RE: Bluetooth: btusb: Add support for 2c4e:0115 (Mercusys MA530)
In-Reply-To: <20260214215815.26248-1-edo@akse.cloud>
References: <20260214215815.26248-1-edo@akse.cloud>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2992027714508451708==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1054221

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.28 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      26.04 seconds
CheckAllWarning               PASS      28.83 seconds
CheckSparse                   WARNING   32.52 seconds
BuildKernel32                 PASS      25.27 seconds
TestRunnerSetup               PASS      564.13 seconds
TestRunner_l2cap-tester       PASS      31.05 seconds
TestRunner_iso-tester         PASS      99.38 seconds
TestRunner_bnep-tester        PASS      6.43 seconds
TestRunner_mgmt-tester        FAIL      126.39 seconds
TestRunner_rfcomm-tester      PASS      9.51 seconds
TestRunner_sco-tester         FAIL      14.84 seconds
TestRunner_ioctl-tester       PASS      10.24 seconds
TestRunner_mesh-tester        FAIL      12.50 seconds
TestRunner_smp-tester         PASS      8.72 seconds
TestRunner_userchan-tester    PASS      6.74 seconds
IncrementalBuild              PENDING   0.62 seconds

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
Mesh - Send cancel - 1                               Timed out    2.651 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2992027714508451708==--
