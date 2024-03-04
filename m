Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1366846B9A
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Mar 2024 15:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709566492; cv=none; b=CoYhyd60ix8Ft2WWaVd5mYF0TjRCot030zkqgOOwqr6wrb3h5WPZ9moIBks75xfdFgnB8MMEvXpqxYu5RmtSUbpJN5daJm5V3F8/UdYyAUR+qIbdMKdEz7WOYCsL+v3LmN2oqZ/5cLrljczivxrRP7hABQtGfAFO8elygxcFF8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709566492; c=relaxed/simple;
	bh=Qcehv+rAW6e12IVs9AW2G45cgp6+tL8WIzA2t/sRN9g=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NVOb8+DSir3rFyDBr36ahis0NTMT6SUMuOzoGMr1g9uZMmtbQkC5z6CwPzhg15dwNfKMEKmhUh1xtfBQYWc6RIGC9+kLmUcGBqcr49Cahz3RRmdOyw5J09B70AP0fUhiIrFlQflBi5ncrIwTYY3eTkeWCxPL3L3osNW818O2pPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pu9/JVvx; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pu9/JVvx"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e57a3bf411so2640595b3a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Mar 2024 07:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709566490; x=1710171290; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VUX2oQTo7btVEl0tCnZr53eIp7uFUIsXMc2q9ScWZik=;
        b=Pu9/JVvxRcck3T+bARk4AGN6VyNgbGd3VqYovr2Ln4l+Ar6bONEDGR9lUjaL8uicBB
         KqhYD2kxcKAcWaFoVopK5AToSP0XtiBerp1shdVORRmSJLsaTPRElu6kVtznV5catdAy
         qxzwmdPKU7Gjg53Xc+fQM1TuowCKzmGt38ay8je/Wx3v6w8+KJAsjVNNIgVw0WWo9lcU
         q0ZHMtH8N/kcDd9OGNTwQK8VTvDTmgeBCz9NcuYoF+I8bw/lHXcIumqrxGfDqak5T8Zp
         XrVGeII0NA24EvzAKBcpNeMsnXpSo/rJXhZhP86/47kwfTS9voqhEzqcqeIjYXrsbHtv
         whmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709566490; x=1710171290;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VUX2oQTo7btVEl0tCnZr53eIp7uFUIsXMc2q9ScWZik=;
        b=YgBp0a1kCxmiEqdCs4YI0naD23CeOL4bfl5iKL+WpqoFe/+4FJpJdmbreZKQLzw7nJ
         35jzQi5JA2Dk6VF/tqXUbEOvBz3XKvEHAnAl0/qQyVGnISKmfHhbePSo1Wm28xO9vgQY
         14+EB8l9CWdg3LWr15lQlkHoU049QDvKA2XQngbRgx9NkAoep71Zk5QNUuzM1bF8jXvV
         BTrLuQADkjKhNpDLeI3JLpPGQloemkse41yobrFyJzrhLeYh7mXGMS9qF1IVnaaGkMgu
         JFf3cgwx0LowcYOe0GDjf3dVrLHX4b+uVbM57T2UWKE/DDW2AT73qMVFchPNX5+pQYAB
         5GeA==
X-Gm-Message-State: AOJu0YzK/HRGkOa24zVYs5SPhs5o3pTCoR9zcmP9r/GsYGr6gBMNsZCv
	ZHwZpJP1unQYNXauR8iDzZJoEOiudujRuAbGnn+YZQny1Qhxp+FKTSFSj970
X-Google-Smtp-Source: AGHT+IFHYvwbcm92YpKV7/oLQeKAbhrY65tMo1DUKrOrzdF29iIxqtjbfh79xVB/t0qIJs97cZ90Rw==
X-Received: by 2002:a17:902:e549:b0:1dc:7ead:d47b with SMTP id n9-20020a170902e54900b001dc7eadd47bmr12281694plf.24.1709566490074;
        Mon, 04 Mar 2024 07:34:50 -0800 (PST)
Received: from [172.17.0.2] ([20.172.5.84])
        by smtp.gmail.com with ESMTPSA id km12-20020a17090327cc00b001db83d42322sm8677681plb.185.2024.03.04.07.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 07:34:49 -0800 (PST)
Message-ID: <65e5ea19.170a0220.c7894.1e65@mx.google.com>
Date: Mon, 04 Mar 2024 07:34:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2978560281981412446=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, peter.tsao@mediatek.com
Subject: RE: Bluetooth: btusb: Add support Mediatek MT7920
In-Reply-To: <20240304144844.2042-1-peter.tsao@mediatek.com>
References: <20240304144844.2042-1-peter.tsao@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2978560281981412446==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=832126

---Test result---

Test Summary:
CheckPatch                    PASS      0.52 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      28.10 seconds
CheckAllWarning               PASS      30.80 seconds
CheckSparse                   PASS      36.71 seconds
CheckSmatch                   PASS      101.59 seconds
BuildKernel32                 PASS      27.65 seconds
TestRunnerSetup               PASS      505.81 seconds
TestRunner_l2cap-tester       PASS      18.28 seconds
TestRunner_iso-tester         PASS      99.47 seconds
TestRunner_bnep-tester        PASS      4.79 seconds
TestRunner_mgmt-tester        FAIL      112.18 seconds
TestRunner_rfcomm-tester      PASS      7.47 seconds
TestRunner_sco-tester         PASS      15.03 seconds
TestRunner_ioctl-tester       PASS      7.97 seconds
TestRunner_mesh-tester        PASS      5.96 seconds
TestRunner_smp-tester         PASS      6.87 seconds
TestRunner_userchan-tester    PASS      5.03 seconds
IncrementalBuild              PASS      26.49 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 7 (AL is full)               Failed       0.201 seconds


---
Regards,
Linux Bluetooth


--===============2978560281981412446==--
