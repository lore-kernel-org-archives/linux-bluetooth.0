Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549F628BA86
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 08:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752136842; cv=none; b=BhbWw0Mvxxk6L4qMM6/Dz9w8Oy9DMpkQ+Mdj3oRIwSTJ7062HuYPtuLkujfFM6sVcL3wRdtVbyyXCJlAg8essKJYpRs0tAtlamqO1iVxRmr8iRbMF4kyzhpqFCi13PQ1XOfz5cnoxLI+txb3O8XByepx0gzH5FxuHJVGkzKMBIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752136842; c=relaxed/simple;
	bh=AyMvPJ9tF9U/PM+U07mfYs3hH7ATRV90oFP2PkSbwNw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=En5/J7YvsSLtuWw5Z6/n+yCtXQdHIiugtUO9IBFLbZ6iA8dcWuyZYM2e0sdKVwcCp0EgJ//RWg3k5YXTFm5x8iSbbnVRujYwnYKZqsyPw5iWBssUO7cLWxD/5xqP94jBgqPYXngfALm3Sx1O9Yi69Vz7RB4lzUuq0pdMzkBiYmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dpVPQQsk; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpVPQQsk"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6facacf521eso6456816d6.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 01:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752136840; x=1752741640; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cOZNQ8ddEYjJIxYIv9/RTV/QrzwhHGhuFoT8qcCbhac=;
        b=dpVPQQskrME6Td39LpJRVmCfrLqllOpBE6TgMXkK7DGeLuP1b7T79ZsxVwEa0a6Efb
         j2EIxhrHqrjwOjAbmwIsTbiL3z3vFeAKcOU/Ay1XK6AP498kBBTg9Q7PoSoxRIVwomg4
         2MvH99nBtTVW9bnsSEo8L/i8Qqfftlg9EMMqqzv3p14GgLQFD6uNFJYtOLJ2JH34J9uM
         vQldf0t5FKV4oM8woHZrUSZp5GEJDd1pe2k+upMf9nT3y4R8rx6Nsso5SGhcroC0KKXR
         S3bjnAxYUF4APwi8HIWuQhyRzb080taGd51Ug70haRbm6NWl0bOPHSBGwLxRpmKzf6ty
         IuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752136840; x=1752741640;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cOZNQ8ddEYjJIxYIv9/RTV/QrzwhHGhuFoT8qcCbhac=;
        b=CHWF31mdnKy3AxvAYiIQ3anjQx8N7Lpe5LSUVqYH27k1gi0EAp5Tcg21jKxOKNJ/QN
         NgM+jBC8e5b6Wctw8bev02kjgPd+M8W1UXEBgmp8sdHqiwLpDwlvw6tpWHlw7Lv6TD8D
         CgrL3iTn3rQ+T2XD5aV+FUhCgPwH1qpgr39j2kKdE0V1Oxd/gNTq+EOkU01T8Dyhy3PC
         M1FZUSsYSAbuVyl/R0PlSpECk5DpYEbBEyX/2TKIrNoEfuDUCx0hOxMGQzxHy8J07VGL
         pcJDtOf58xtjJm448pdCbQN8jEpOJ7GiIdmWznVF/iHALEQIfEprs+hx2F5eMs27waVs
         TXFA==
X-Gm-Message-State: AOJu0Yz29/UaRoqokZ69gXBYU6QxrfUA9f+tAleih6cADGFMw1NcPTIm
	7Xgm6ShmDmbQxsUjJJwmcxoZ5SASXru7bSh3YCL12VT2gm4DWRbGQsWxmgj9pQ==
X-Gm-Gg: ASbGncsGjnYkMvDgCPYZpOQ8v0YNsu1ax17aLlLjILYAu6kiUDMkF7CrECuAvbAhnnD
	jqHPzfiGsWBMY7kI1VBXq/GLdG85Ir8FyT4tHuVkJ7/Zjy+rk+H7ZHOWTTbpsIfnYWi+U1HQzTu
	/VarK2NiwDfCjK3bx/o8q5xZAYmHlyIrinorYFJYWsYgRXlgzu6sWGlY867EcDOOHwjPrkWV8fx
	05caQYlzNwoKI7cbr49S4LtLeFUIXmbHwGrj9pB0F7DA4aC493NTTPzA+sYNy9aTe4fZzdwkJcD
	2I1cDY7tb7WviMeh01Ep2iiHPhVDMK70zOBxz1o1ew30ai+R3ywFc2FIoj6GqSPmkb16
X-Google-Smtp-Source: AGHT+IHV62QqQ++hDIghOM1cUM3cVKwRQBDKEElNzwi3wWNVtrwjgDtwP5HARKZANcjIOq91/kascg==
X-Received: by 2002:a05:6214:3c98:b0:702:d3c8:5c1d with SMTP id 6a1803df08f44-7048b6e8436mr79708316d6.0.1752136839770;
        Thu, 10 Jul 2025 01:40:39 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.27.28])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704979b4187sm6498516d6.26.2025.07.10.01.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 01:40:39 -0700 (PDT)
Message-ID: <686f7c87.d40a0220.a58f6.0f65@mx.google.com>
Date: Thu, 10 Jul 2025 01:40:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4299882989485292250=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, wangyuli@uniontech.com
Subject: RE: Bluetooth: btusb: Add RTL8852BE device 0x13d3:0x3618
In-Reply-To: <43D87E237D082F39+20250710080548.180268-1-wangyuli@uniontech.com>
References: <43D87E237D082F39+20250710080548.180268-1-wangyuli@uniontech.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4299882989485292250==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=980900

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      24.05 seconds
CheckAllWarning               PASS      26.18 seconds
CheckSparse                   PASS      29.34 seconds
BuildKernel32                 PASS      23.97 seconds
TestRunnerSetup               PASS      461.78 seconds
TestRunner_l2cap-tester       PASS      25.01 seconds
TestRunner_iso-tester         PASS      37.42 seconds
TestRunner_bnep-tester        PASS      5.84 seconds
TestRunner_mgmt-tester        FAIL      131.28 seconds
TestRunner_rfcomm-tester      PASS      9.48 seconds
TestRunner_sco-tester         PASS      14.59 seconds
TestRunner_ioctl-tester       PASS      9.82 seconds
TestRunner_mesh-tester        FAIL      11.42 seconds
TestRunner_smp-tester         PASS      8.42 seconds
TestRunner_userchan-tester    PASS      6.17 seconds
IncrementalBuild              PENDING   1.02 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.175 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.048 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4299882989485292250==--
