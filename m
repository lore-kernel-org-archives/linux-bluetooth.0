Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C85279DCE
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 02:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774404311; cv=none; b=NFOjgSI9/29Z06UFzZaJvMK3h8q+FIjPoN++qP4fLrqfPlr+0nqO0wXt7w78QOT7+iCdE4mUXmO6mRthjAMY1eWKTxKp/Pd3LqZ7+FznxSeOkJ4Nzs2F9NhBaBEhbnNWB7w+kqOsP86bvCjmrBPlEbsIOiPP+7R0qsmAK/+bcIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774404311; c=relaxed/simple;
	bh=ZbuSw3fhxeSR62TPcBxDWrvK3a7X/rD36KdMFSSJlPI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Pg69iuAFcWWlHeHvRgmUZy2dtVtcQiHyxfV6tFZUY4pVBvB2uvLfVZgYBHYQL6hzfb8wu0un8MTby5hglMQkljoLsiOPoMPrH/QAs5D40UpKXGOhRYnlo9fZvXlgDHEvLH628HO3DTfU3hZnj04N6aQ1LEhsrzWjaxpzNtjK9wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPmPOe/r; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPmPOe/r"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2c1092cc08cso2220926eec.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2026 19:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774404309; x=1775009109; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=guhhE7BHfNGivodctFO2qvRlWrIsCkJtDiqf7txnWL0=;
        b=gPmPOe/rHoqzq1+wHbIcizAogAl55DbdxvQC89RuGlEhMTFRzwSiNwDIzDyCL+F6Xr
         bEC0r24Pzg9dPPQcmDj/S7e7s8BHVX+qjO4alfnPsnR4CF+uBBjZM/TkRLGvOJyWEH/J
         Wpw5qFS7HSg+MSPwKGUqjewZgAgtkk8Lc4pj0O57fp3CgwzZRRg64g1v4gtflyCc9VDy
         4GPK+rsYIxtlX8+O3PkzFganWrdbnWGWX+3WSlo7Ar6tIZ2MDpwP5BiNZfbk7n7HNb5S
         clXHQx1Ddnyxr8QnSmsTgU2iJ5oowhX0oRvz88hjPO40s8gmQcZ6+x0Fo2kxJvjfY1Oa
         q76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774404309; x=1775009109;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=guhhE7BHfNGivodctFO2qvRlWrIsCkJtDiqf7txnWL0=;
        b=ZGF9W1boNv7IMY37//fT/XGk4eUQAyuBJ9ZQBnylKes0bB4VkiZHDVFO1Ul0TgyC3/
         frZZxJZLtMzWzl7Ocuo6nwD50K6ZlwcvY8v+nLj/UikYaAJowgoQ/pSua9MWX8Pu6MfG
         LN6KBLcNF6LItiWKb3mqBl8WwCJ7UeSiD6Q6AeWkkC9xQAqqmAi4SfabPpUwnIFLvt13
         GBRewPw9mHes7kWo60IYjvii23bFh4s319HXangH/ja+xa4BKrhIFilHlbaDEOEvgsLs
         cRUTyNt7lyKi4MqG2mwKHvFzA4UO44wZZ+5RwMVM31iNrmmzbSOFgu5AT1jCx9Mxt5F0
         KCVQ==
X-Gm-Message-State: AOJu0YxkGERfwfzYg+9f2yv2cWY2hsauhCE/qVPGKRXzean4zEr/bJyH
	9BIaSnleskNFrvHyxxYZyAaxqnOlm3lAY5KNH/quYAzJwg6a0l14Z2i2QOH4Tg==
X-Gm-Gg: ATEYQzwmLkYKr66XUGdREsm7GfvVCeKCPu4wd0TI3kilLiv0qiJEL39ZlrARK8B0o0n
	3XlVDo6qH3XYGZpptvwHEXXJlYYWvklnaqxl7s26xmgjCbhCy0qnNIXoYgqR5bVn8Y19q92s6O/
	cpcQ9eBBxCgeTzFMh5U3pTlsRhr8wUpHx4LYANplu8eA254ksauS0VCPWE5l46/KZwu3cRW5gRs
	VmCNdn7WTYhfTldKb0IVy3mijArzZVsIOTJ66puyoedeSqRyXIPAG3BPdFv5LuoQoj7ZB5/9k7e
	Brx/Xt9XQ6l0ZQM/EpRCB74Mm31fiIPNGQuI3/Y4isT4BaB6ahd9ceAXtwMWhJxDuMEFowGqqCI
	QkUlakLaSDlKOUrPsAXyclhgbg+l7zbbSGGAxc82EvdKG0owWnICw/wgLxQ5sq8SKP1ndv8ALRC
	lKPQPrjtxcRK3VYrxYJfY5i3JPogRR9Q==
X-Received: by 2002:a05:7022:6983:b0:127:9d23:ad43 with SMTP id a92af1059eb24-12a96e423eemr997902c88.1.1774404308505;
        Tue, 24 Mar 2026 19:05:08 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.119.245])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a733b4a99sm12505339c88.1.2026.03.24.19.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 19:05:08 -0700 (PDT)
Message-ID: <69c342d4.050a0220.1f7ebe.376e@mx.google.com>
Date: Tue, 24 Mar 2026 19:05:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3960970549395721212=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pengpeng@iscas.ac.cn
Subject: RE: [v2] Bluetooth: btusb: clamp SCO altsetting table indices
In-Reply-To: <20260325004245.42452-1-pengpeng@iscas.ac.cn>
References: <20260325004245.42452-1-pengpeng@iscas.ac.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3960970549395721212==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1071975

---Test result---

Test Summary:
CheckPatch                    PENDING   0.56 seconds
GitLint                       PENDING   0.35 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      25.33 seconds
CheckAllWarning               PASS      27.89 seconds
CheckSparse                   PASS      26.74 seconds
BuildKernel32                 PASS      24.90 seconds
TestRunnerSetup               PASS      530.75 seconds
TestRunner_l2cap-tester       PASS      27.98 seconds
TestRunner_iso-tester         FAIL      34.82 seconds
TestRunner_bnep-tester        PASS      6.29 seconds
TestRunner_mgmt-tester        FAIL      113.95 seconds
TestRunner_rfcomm-tester      PASS      9.43 seconds
TestRunner_sco-tester         FAIL      14.44 seconds
TestRunner_ioctl-tester       PASS      10.34 seconds
TestRunner_mesh-tester        FAIL      11.43 seconds
TestRunner_smp-tester         PASS      8.66 seconds
TestRunner_userchan-tester    PASS      6.82 seconds
IncrementalBuild              PENDING   0.46 seconds

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
Read Exp Feature - Success                           Failed       0.103 seconds
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
Mesh - Send cancel - 1                               Timed out    1.788 seconds
Mesh - Send cancel - 2                               Timed out    1.992 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3960970549395721212==--
