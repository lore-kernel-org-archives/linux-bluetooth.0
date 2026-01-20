Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552ED24729A
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 01:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768872976; cv=none; b=B0rRom4X39XhjhR3S/SbjxYeH3igY0m/Yb58DaGrvwDivPMGJznZMmCik2eZOinOqunl/ezKVoRUrZiXXIGklBkRsLDVKgcgBr6CI4EGrNJfHrP+SgiiI5eDJn39HpRMrAhyiOvDJEC+M2iG1pjKGSh0dU+YDlZcHmc2YN5Lr+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768872976; c=relaxed/simple;
	bh=hSaGqD1LgiXEQ6k5hC1Nt1YqSAxzPESWrFMyBpj0o/M=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FfykAydyGYPf7WRdNQV+mDimItIskl8RERUg45IC5VbWGf+ZdbS/Ca/0To0EfRO6iYlXuHixAf7GPwAzHYXjIxma/MSr8Nq5itgVBZ1scuyJMgUDwbCnL88a3kMkp2kfTWGEJ+iOVbsqxnEamlLez4XtPVVjNAxx5QoD7+w+QQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IL8BIgRW; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IL8BIgRW"
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-7cfd9b898cdso2730198a34.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 17:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768872974; x=1769477774; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cyEZBtbDUxd1SZPKVFgVplfaWyMovrHAX7t3SOdAVVA=;
        b=IL8BIgRWJ7jqvf/gx1pKPpHM0zGpsHObvLyJTrE5nv2MqZTvTD9gzupcXHm0yeZePq
         smQ4XA8g9QEY4rrEcMz6a4oi4QXsnYRBqLkavzPyLrbIbQ76W4oEhd6RNr70Tnw/7eHf
         GO1oCgcAKMdCh3wZkKYxZP92VLI7EA96gJqBwZQEymsRGokIKveQDhp3r1sUbB+H7+HE
         5P9XK9aWNVq14EPpFlYJKOMw2GIVsLSzj/Mlb5SQVccsryfna94sh+GeF6uXpz57Hgcv
         FbPPuUk+1Q8fTkmzJXxxHhEWnlBKnnw6RjLTISU8qT4kiyNiWPbS9Tv8MKDpCGZ72p3W
         dl5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768872974; x=1769477774;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyEZBtbDUxd1SZPKVFgVplfaWyMovrHAX7t3SOdAVVA=;
        b=rU1iNExiMWkkjpuQ799Z6BqVLCDN88r5RBIEQM3U8ST1ALEo8HcP4Mb+PrbQFSvxj3
         b0R0fQ6pIwvCvgO+f7/4UCk5tFWW2XgSwYIerLnUkoJFQcG//NTDV3t/Fp4sEW8Ya/Ze
         yTga6TKFV/6KMkYQykUAajTQ+nPKWaP42VBVt2NONYePOmi+Y93RqnvJW3+m6IlsGJiO
         q76ATAZOGVAOSl96k6qb+fW4JJ9U/WEdOmkG9msos6v6yDj8wIg9Pa8Ff4lTEnJflvLy
         C7WMoeco0zfbg/tRKzUWoZ+Ox3mwZEfNNk3Q4x+DAAGtQuE3VLCS8W3jpRVPQh6eZz7v
         bdVg==
X-Gm-Message-State: AOJu0YzVyPRqTzd5Hntx38Tdeyjk0c4P8r42o6HZFM/YHa9nNmI1T7qj
	FX7SWO4XrAZ9oemXoiBAkuVwSQVJy06qrTJFn/EIWI13BAduYpjHflqlEbeUudJ0
X-Gm-Gg: AY/fxX4mNMwL5I00Dwk+8exdRy78kZza9dB1v21aML7NZPfdq/oC7VA78fYN2Ab5mU2
	BhT99DMX3y731EZdd54Y9WIDgm69uICxj3F/B2gBmSIy9hL1Nk3W1IQfIEXEqKrKnYXQ4sgDGfF
	xneg61UbAC1d6kz7pDM3uzxIrhPdKPoQ2D7xw8Qc0J7NvKr5Sn7Ys/v1FPBbMWRPlO4jx2jk8RN
	LyEtWF2mtsZIQQpJF+J41ul5S35Yh1aj9G8xwppUSwPu3bbXDdZisITkpAdbYGkCHsO/4yW/C5b
	+4US8hyIwa3+ulRwzuMlBepaULV3C/xDf1OmKgVYtqbkXVEfmBW91t2M3IOFRau+w9nXa2vRnLq
	QXUks6ws9mMLPsHUkwvQ9eU/5oKWk6X+MPa6c3QUn6mZfXNk0ZJzXhKbjUE5o1rNB0+yFT9dYGw
	MeCetQ9dBNHuSz8hWp
X-Received: by 2002:a05:6830:927:b0:7cf:d1f0:63e2 with SMTP id 46e09a7af769-7d140ab6b0amr245891a34.19.1768872974018;
        Mon, 19 Jan 2026 17:36:14 -0800 (PST)
Received: from [172.17.0.2] ([52.173.181.17])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfdf28ef93sm7666807a34.15.2026.01.19.17.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 17:36:13 -0800 (PST)
Message-ID: <696edc0d.9d0a0220.9c10e.d65c@mx.google.com>
Date: Mon, 19 Jan 2026 17:36:13 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5420519536332196617=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: [v1] Bluetooth: btusb: MT7922: Add VID/PID 0489/e174
In-Reply-To: <20260120001829.3185977-1-chris.lu@mediatek.com>
References: <20260120001829.3185977-1-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5420519536332196617==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1044384

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.24 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      24.90 seconds
CheckAllWarning               PASS      27.41 seconds
CheckSparse                   PASS      30.44 seconds
BuildKernel32                 PASS      24.66 seconds
TestRunnerSetup               PASS      545.35 seconds
TestRunner_l2cap-tester       FAIL      28.33 seconds
TestRunner_iso-tester         PASS      96.05 seconds
TestRunner_bnep-tester        PASS      10.14 seconds
TestRunner_mgmt-tester        FAIL      116.74 seconds
TestRunner_rfcomm-tester      PASS      9.28 seconds
TestRunner_sco-tester         FAIL      14.30 seconds
TestRunner_ioctl-tester       PASS      9.95 seconds
TestRunner_mesh-tester        FAIL      11.42 seconds
TestRunner_smp-tester         PASS      8.53 seconds
TestRunner_userchan-tester    PASS      6.71 seconds
IncrementalBuild              PENDING   0.63 seconds

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
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 95 (99.0%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Server - Set PHY 1M                     Failed       0.125 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 487 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.105 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.198 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.187 seconds
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
Mesh - Send cancel - 1                               Timed out    1.891 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5420519536332196617==--
