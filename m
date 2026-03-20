Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B292F363B
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 12:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774008872; cv=none; b=ebW8T28WNLxtnu0mo+91sbKL6f2a6UuZ2iK704H8TpUCsr+e/vvOGgEz79/hT5Bb+gBY/z+xCZJW3PAbKAgjIshD2LePT2aQJJF/eSCK1Tn/w+JuQ9v/f00fr9AKRz/UrvPgQjsoO/VL1Jfb8zBCozlY7Kv6lP43250NLJxl1EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774008872; c=relaxed/simple;
	bh=16a7q+qKi58FAr9yreZT/rEkI53is4RYZNZCHc81A4k=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=AMcBIuEslNHV/SSewbsFQzpyx+0bHulho3hNp7a7R4dppSgfuNKTTywvWMBQOIa7uQ86v+SK+7giOG91h0b4DadWZGFh+aRCrFRzQCfUt9CKRF8/vwH4B2f/nQTAxSn7QrU1VBQoz3dCugj5K0bGmjcsqMkbkH92J+fs8e3N2hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3pd9Ddb; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3pd9Ddb"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d74c1157a4so1404359a34.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 05:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774008870; x=1774613670; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZaGnBf+P1plykUV2x646RrJsVgqysIjKCvfCkj7GR34=;
        b=a3pd9DdbEl7nxOhIPLeT9zQLLbnLRPgXcEDkPth6kucrxWWsPqd9/pv9Jr7k7qRzJe
         xjYqWlac6D1e0XsGteM0JFNNOC8Of21dFbsfxQeJ2Cn1aJThi9UBh5+339HGnD9djRo+
         o0EEwWIexWslOD9l019CjRe/ATUVBIj3HZaM1iyTNT4mcaaeI7zcJD+GNBRv533RPEV7
         U+SE5yMV25/J/U84vJFM0MzwRO0J568ycCOrgzBkUvxx7WrrZtKpzKMOhAOHxK2fEE4S
         kP2RgW8uO0F7Ob64QqkPVFj/DicCzgGVvyfvCLrRnTBfMsMOtuIQ1Ro822UmWxWx8S6V
         QHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774008870; x=1774613670;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZaGnBf+P1plykUV2x646RrJsVgqysIjKCvfCkj7GR34=;
        b=WtGqKGJwQwi4jFsWT121Y10tD5c6LGfFzvNuWEwS7FOLGzUsVQY8L4/R6wDs8f9jtB
         i/ciNom6xATFRcVuz84uoVdmX/6KkfN4hIpA5Gk98h37zn/uHmsXg6XTjpCGitITbfiw
         /ARYEKN8SdD+OL2PA5B82aL75X0WunDrLHzEddQvvblvcmspVFt7WRYOBNl9OGgSmh/l
         CFubE2oqvuZxzAu3m148fDgNRXNRpI2I+4dMG7ZTF8hFUf1goIwAKUf18c8KEvA0TfTW
         wJM9m+JKSktkePf/JU2LALOJvVuFvcsIP3bgfgIauIfMXYyEUJ5zxiAkXNUE2l7JAVuo
         Btbg==
X-Gm-Message-State: AOJu0Yz9xgLlJwtHG7sQoduW6YPUIJ8PbyA2XzwAIxur3wO01hEyRZZf
	X5qa8MTUc2+L48sjZRAP2tl0AfJiZWlKLYSSvaNs+aznqPH/91D3rUNbVwyBcNMa
X-Gm-Gg: ATEYQzxnPFwy2PI1+041z9rwrg4r6tXSAwiZAYee6fm5W/rv6ESDXj1cr6W7HwVolqC
	DI/6Zs5BYylEZG1YqqpNrAtH76mcrtCWusWu0UBwRJsNvcfLPv5BP1fKj2RS5T695bemqhWmFf+
	swUW1a4XqsRmN7TVhzEbaBujqrViifgT+uLUX0U1lzv2tNGu6VJ3z+EikSI+SYDKpWedaruSt9Q
	X/mUJktQJafZzndWqFjibpcBLyEcnR6j452j5srZUx1DVOEWSl4KTwZoflXcjHw9qA9djuaVnfR
	+12MBlAx3SYlwLo7X4lDgI66kdUxbt/91njuWF4xKT3xp8ys2uJpTMejU9YB8PNM67DxvCWWlC1
	o7jZYVcG1fvoKuQUzgR4rIW/TkmYJfFtgWrftz86e2SAgscXiOLzum3Ne3CnSyVUh1uuCtPdP4d
	q56h5eP2YDTUgqOjzQfhLkZkOCQk8rzA==
X-Received: by 2002:a05:6830:81d9:b0:7d7:f66d:9fea with SMTP id 46e09a7af769-7d7f66da0bbmr236179a34.1.1774008869654;
        Fri, 20 Mar 2026 05:14:29 -0700 (PDT)
Received: from [172.17.0.2] ([172.212.164.17])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7eae10537sm2085293a34.22.2026.03.20.05.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 05:14:29 -0700 (PDT)
Message-ID: <69bd3a25.9d0a0220.14ed3a.92ca@mx.google.com>
Date: Fri, 20 Mar 2026 05:14:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7821668662112112300=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, imv4bel@gmail.com
Subject: RE: [v2] Bluetooth: L2CAP: Fix ERTM re-init and zero pdu_len infinite loop
In-Reply-To: <ab0uHv8K_Jri2J6K@v4bel>
References: <ab0uHv8K_Jri2J6K@v4bel>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7821668662112112300==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1069857

---Test result---

Test Summary:
CheckPatch                    PENDING   0.39 seconds
GitLint                       PENDING   0.30 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      26.91 seconds
CheckAllWarning               PASS      29.45 seconds
CheckSparse                   PASS      28.54 seconds
BuildKernel32                 PASS      26.27 seconds
TestRunnerSetup               PASS      584.59 seconds
TestRunner_l2cap-tester       FAIL      29.51 seconds
TestRunner_iso-tester         FAIL      35.89 seconds
TestRunner_bnep-tester        PASS      6.66 seconds
TestRunner_mgmt-tester        FAIL      118.03 seconds
TestRunner_rfcomm-tester      PASS      9.67 seconds
TestRunner_sco-tester         FAIL      14.74 seconds
TestRunner_ioctl-tester       PASS      10.65 seconds
TestRunner_mesh-tester        FAIL      12.67 seconds
TestRunner_smp-tester         PASS      9.00 seconds
TestRunner_userchan-tester    PASS      6.85 seconds
IncrementalBuild              PENDING   0.58 seconds

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
L2CAP BR/EDR Server - Set PHY 2M                     Failed       0.125 seconds
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
Read Exp Feature - Success                           Failed       0.117 seconds
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
Mesh - Send cancel - 1                               Timed out    2.608 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7821668662112112300==--
