Received: from mail-pz2-f25.google.com (mail-pz2-f25.google.com [74.125.228.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890623DA7C8
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 23:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790034476; cv=none; b=MZ9HsHE/OusEyhYuxXBjMBfuBew5yOsGbAPQiSeW2Lam+ggD90SHmHCNnqI8l3LJ/2IVyLl+PHcmJYOVD4rAP8ylPtg5y0BZBsuwwsXDtBg1i3pd7LjI3ELcsgrSQ9qU0iLPTnj9UdeIrXm5nyGXbQNugArxTxk8yZD+wOan/uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790034476; c=relaxed/simple;
	bh=qHv5aIiUI8wb7IyESOPhBKrWNwdhPh0jnes6ZQA8ZhA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Jt0OVA5wwRuTQpmzlF+aKVz6/3l6J+COWUtjYWg6lkNxfdyVcy6QCoBjD5LmnpdqvZnefUtrH/ioGAgR/F/h3JDlF7FDCxWrZqciuMYx8lZgk0Uw7MVJkLFhAWmdBrrDXQuSxQeFXR1BxoNKSsJcrmohpnhNPFYd/gUz7EZwt9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d88Guffp; arc=none smtp.client-ip=74.125.228.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d88Guffp"
Received: by mail-pz2-f25.google.com with SMTP id 41be03b00d2f7-cc1cebad4aeso2766629a12.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 16:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790034475; x=1790639275; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cV2ZMGdViUrEkrPjaynRNqlh2b1pXBf32LK6cPcWVZE=;
        b=d88Guffp6/axHqM+Z8BhyhiQfaSi/pqlhmOEp+z3tkRLMokAviYbr+ZZGGAUxUcFLa
         ePjuf6OYNJ0RtCcN+9DsScvZBrxInbswCG7GfLn11qiKyHdqgv8LkJfKd3qtZdKqw2rH
         /EePGYbhS1jfU4cGE4wBdPoLJULRsWQqil60xCWuaYO/FGEFCx09rFGNYzYLbCrjLyV9
         btdLJjRfDSFoNAP2khDwHJtflfBFxZCsJc97W3bKMCGKtgfCPl7rQ7LptxsH+QbYCGW9
         Tz1i0Iv8yNDmL657RD+WRBURz/av+8KJeStsgg1XkLTpIzEz8Yivj15MCUsTaUIInHrx
         +1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790034475; x=1790639275;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cV2ZMGdViUrEkrPjaynRNqlh2b1pXBf32LK6cPcWVZE=;
        b=xgrFXNpU5Vg3kVn9ZVz2RdjocrhNdkJub9H5hJD8WyOSCxRrw+XhePiNeB7TX5SNaO
         1Jys3FSVQIKWA+RD7jGssGVP8HwJiwTYPakEiEA/8jIctVB7e4nM0LqPJ6ixRPMkj3jp
         3qDEGHQ0DHykUZFDCxaKuCGnbAuKcYlYeplJTyk6UHoET7zrJj/a1IqWcikQ9Y96KdL+
         AHzEDzlFbRMiW6mmRzGy3oqLJ3oJflnbjHqXkkMqLg7X3MkUpFRwwvzyHFABGhBhox2A
         xlUjlHqMjGNeW22SON9DFwXbR9viRzeFfm6ZZ/yzDU6R2fwK1YDYfwCaO7Y4b63qiQ2K
         uiFA==
X-Gm-Message-State: AFuF++lEaJZKbcCoxDueCPZkrEMqDk80+brN/XzDBXeP/smwQGcwPm+P
	lrS1KY6VeADAfXSb/twOdafgu8k024dfUkGMl0SSe8MqsUxOrHxsrZyNrkvONZs2
X-Gm-Gg: AYBFou3a6meK73szSIpATs1qw8iK0T16WTfaPHJBMtSCjJbYR0ysUKNEGj4iwgHxjQb
	qmBD7BLW/jXxuQLBV/MexGGeA/bEmtfPBX+NHpmv8f5MgFLCDv/Gut9rhOmXWemKDl867TgTi4x
	sAIdrRx6TOsB0e17POhZrjvCSA981tnmFQyTnrp76UW7Da6wniOy+LRN9Dg6UbKtsPaFIMv60ak
	XZlUsL4C9/PpAiFaJQznQzYwYbUKeCN6ng4uz729R8Kv1uj88JCyGUBW/xjOumK4ZcBdzJm8CR3
	mvH3K3J6vFQsEDinZpJmKa4fNAbmocpU2TfeZtYbatQSizDSdjSo4smpDCgI6Yvyq21Z/jUmV+X
	tPj8Wk1KbFZp0LaOjOIiQuvLWtWxMHzJR5awfzrMetJ30MFn73rGLA7Aw5XytI9uxherc2Pw9cs
	6YfhizZfyKd0jctNfVM0xBQHNB9a0f5c1HdLfWrUSGiBBVDpjZ4S0mWhOJhyNoFvh+DJu6RteC0
	Qgkv6s=
X-Received: by 2002:a05:6a20:9c17:b0:3dd:a006:7b32 with SMTP id adf61e73a8af0-3dda0067bd5mr13364728637.49.1790034474761;
        Mon, 21 Sep 2026 16:47:54 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.201.165])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f29d88afsm209120c88.4.2026.09.21.16.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 16:47:54 -0700 (PDT)
Message-ID: <6ab1c22a.acba1091.105913.ef7e@mx.google.com>
Date: Mon, 21 Sep 2026 16:47:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1170311927815624734=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Add true wireless BAP broadcast tests
In-Reply-To: <20260921210123.3690449-2-luiz.dentz@gmail.com>
References: <20260921210123.3690449-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1170311927815624734==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1170704/

---Test result---

Test Summary:
CheckPatch                    FAIL      2.26 seconds
GitLint                       PASS      1.60 seconds
BuildEll                      PASS      19.44 seconds
BluezMake                     PASS      378.74 seconds
MakeCheck                     PASS      14.45 seconds
MakeDistcheck                 PASS      139.15 seconds
CheckValgrind                 PASS      230.87 seconds
CheckSmatch                   PASS      290.42 seconds
bluezmakeextell               PASS      94.60 seconds
TestFunctional                PASS      1127.27 seconds
IncrementalBuild              PASS      383.55 seconds
ScanBuild                     PASS      1115.84 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v1,5/6] client: connect a device that is already paired
ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#125: FILE: client/main.c:2071:
+static const char *proxy_address(GDBusProxy *proxy);
                                             ^

/home/runner/work/bluez/bluez/src/patch/14836574.patch total: 1 errors, 0 warnings, 81 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14836574.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2560

---
Regards,
Linux Bluetooth


--===============1170311927815624734==--
