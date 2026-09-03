Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F55305693
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 01:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788400543; cv=none; b=HRNFx4MVWKOb6YlII0uJOAmIC/gXxiwmuzl2m90J3rM0Hv+wHVHB+DusJNyv7KoO13XFGm/rw+wvPrlypiyViwp8dljNGlfiMiIi6PMYhWUriMW9rFwr4S94KKo25fH7haBx1AEJPzm30Xi8OfrWHDNB+bxVPfXHg0Sd/RlxEhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788400543; c=relaxed/simple;
	bh=nOUO8mlw/f5Z4bc+p5Nf4v1sqSITYkMO/vkD5RSSxi0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=F7ulzx1DCWfWlbWHJU34UdRjUJmbpDIHiOJnlvo3DDBvo/cORffXXG9RrdwQpPzWrpNxXMn4hkLJeVJH5vImgDsOKvYs6Gv73tAKDf0V3icdWakO+QxFBOYtztXtO8MYvcy9UKhm+DVGJyAKHE9z8UqaQ7B6uT4rZhY4UNbdPuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Co9D+trP; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Co9D+trP"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d53197d8b5so16450075ad.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Sep 2026 18:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788400542; x=1789005342; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CXgfnd+3ipsjJceohXUKxG85kxYY7B2l7eiibKwFvRU=;
        b=Co9D+trPEwz0qYR25Dn5LIEk/zHWjFVj6cnKkqtdQ7BV+p8a91puy346vKdmtr/SrE
         mWte+iHK2J7a9Ydekgt3JsAsMKRJbj01w2QLI2eFoiHIntKpKQ+MDFQV1SqBxzueg9S7
         D5pXyG6j3no9jptbqml3Rlbswb0xufpyk+DxWDoaAda/76uHlTU46S8lBHMrm4yQAd+Y
         OUKk0/Xq+67q5qPmoxqJPt7JjpAZcg/Xcmn5tcuyU65ZDo0OBYs9/7An1GNJfw0lvqaQ
         O2nbuHo3jZ0S+7Xg/osJ93S+lB9euD0vNVs4lRvC/3xnb3zO5M6TVcJnUW32ryC28UIo
         3crw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788400542; x=1789005342;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CXgfnd+3ipsjJceohXUKxG85kxYY7B2l7eiibKwFvRU=;
        b=rpZ4HOErEOzru42wJyXQWKihHxFzP8SOohDEF8ILDlpUYy08dRSyPjWqXG85UNoipp
         pyXlEOGlBhZqi+9LF2f4uah2WUz7UfXItmqK8qW9R7rlYTY8dIUBlD9xaH/stq9mtU7W
         z0MLS2rNapI+JPfkMLe+WCkrVgVcLqnjgJMX/rmc7nZihEgY1sjVtNiP7ofcSV5TRudW
         gnEACa18BEZlXzQ1QyAteN1waooL02WNpQmbuuccb76KLgHpwDJyqSwv67ng0ypldtKV
         vUwoBbLHHQlXfXsfFzppc0xdpRGUOBAKQZ9lXWrtr12JrLbc0MNNb9yTmv6NrHSkd5HL
         W0hQ==
X-Gm-Message-State: AFuF++l7syPG19+XNX68qjm1h+RyOTvE13ukrO68/n9y6lDZIpw7zU26
	wS635Z12oiVhb93VDjgFYJjCzCR8yllZTmomTJ/zP4vKtzqMZu7APZC7Gch70Q==
X-Gm-Gg: AYBFou1NjT2boxzozwhbAIOihVOosldHZ4meYzRYCgJxevPzobG7YnkwJYSyyZjTTqY
	c42XiiVtlls5N3DIexHsMzU0LmoIy0S3t1QMFUvcOPDu/r075ZbjOtE8GsC91WfLGxhJUaJ0Sbx
	Qn4dx57E9gf93YXHU2vnI5c2ExvzuxZs1bMZJTbNChAGwnR5yjPC4w93dlxhrVpv8SXkK3aK2R4
	tSpIUG7cYy0cSMkFg03qPp3Xmmv+k5DK5NpwL/4i5+btL4EghiL6ysqTIlqxFRTrg6NLtRDdIOr
	PIR9LNNUAmZR9yjPTEfyrMAA8vT2WL4LDGMbqRw+D6zSd5+msUdC3FcpwcIofBa5Fj+XxySJqku
	dRdMn0LiOrB5ey8Misa0IbQ6F75xUnDzbHe2SITzBw1EkUTg8QwLcUIF3UWrRf6HReDWjf4XafB
	BF/gu5BNSKhU3YQ+WRwnVgJj8NU+wC9LFP17EK0EPbnhi7iNxnkHdxyip0sC0k+UvTkGg=
X-Received: by 2002:a17:903:2286:b0:2d7:f0:896b with SMTP id d9443c01a7336-2daec71f0cemr116658425ad.13.1788400541786;
        Wed, 02 Sep 2026 18:55:41 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.109.200])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3325534d580sm1752807eec.8.2026.09.02.18.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 18:55:41 -0700 (PDT)
Message-ID: <6a98d39d.fe89a83f.17deba.71a7@mx.google.com>
Date: Wed, 02 Sep 2026 18:55:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3756470502433609022=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mikhail.v.gavrilov@gmail.com
Subject: RE: Bluetooth: RFCOMM: defer security confirmation to krfcommd
In-Reply-To: <20260902235132.453044-1-mikhail.v.gavrilov@gmail.com>
References: <20260902235132.453044-1-mikhail.v.gavrilov@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3756470502433609022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1156570

---Test result---

Test Summary:
CheckPatch                    PASS      0.68 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       FAIL      0.26 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      25.32 seconds
CheckAllWarning               PASS      27.59 seconds
CheckSparse                   PASS      26.32 seconds
BuildKernel32                 PASS      24.83 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      463.47 seconds
TestRunner_rfcomm-tester      PASS      26.17 seconds
IncrementalBuild              PASS      24.25 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: RFCOMM: defer security confirmation to krfcommd

85: B3 Line contains hard tab characters (\t): "	unsigned short	rc_family;"
86: B3 Line contains hard tab characters (\t): "	uint8_t		rc_bdaddr[6];	/* little endian */"
87: B3 Line contains hard tab characters (\t): "	uint8_t		rc_channel;"
92: B3 Line contains hard tab characters (\t): "	struct sockaddr_rc addr = { .rc_family = AF_BLUETOOTH,"
93: B3 Line contains hard tab characters (\t): "				    .rc_channel = 1 };"
94: B3 Line contains hard tab characters (\t): "	int fd = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);"
96: B3 Line contains hard tab characters (\t): "	memcpy(addr.rc_bdaddr, "\x55\x44\x33\x22\x11\x00", 6);"
97: B3 Line contains hard tab characters (\t): "	connect(fd, (struct sockaddr *)&addr, sizeof(addr));"
98: B3 Line contains hard tab characters (\t): "	close(fd);"
99: B3 Line contains hard tab characters (\t): "	return 0;"
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/693

---
Regards,
Linux Bluetooth


--===============3756470502433609022==--
