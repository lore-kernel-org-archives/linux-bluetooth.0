Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C089D29CB5C
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 May 2025 19:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747940870; cv=none; b=VY2MTH/8hoJ+pR+67ckPbu3O2/t09ZiGBjU2pBTp5j4f8vY3byp/qq5w1EomCvDMFZgEju2vfkyrgSjDEWwQifiBH6DuKyP67v/2A+96b7x3nI6QN3ZWbMZ9GDthxSNo5vrld3oYJX26N7IDmlsdi26JXwpkJSs+iy12Z2xrThI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747940870; c=relaxed/simple;
	bh=iOZWnqfhD+jPR0vjOW6SjYM9n0CPWyjKoRMZrATKxos=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=isKj8PNg4Li3FjUnLHpiW/OZLvYDrjXJEiA7pyfl9uvVtB82/oScW1is/tLlfkRwiefRMdFFiPxrZE67FAfyh/q7La0HCvITlGEDX9oy6Upuzn/xbO4mo6GNYZhtUsyqYeU6v7CxuH9rJRRvGO1OLeRfPP1MQvMpMZ5kaUhxdlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mfsu8UIz; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfsu8UIz"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c5e1b40f68so988876285a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 May 2025 12:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747940867; x=1748545667; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K36m1ZiKh2f67lsz71itOmOTNRIC9SP4jkgGk4e+q7E=;
        b=mfsu8UIzhJJdrqFXrT1xx/FoxFNyDbgjrOIvD36pWIw8e04MhOav0CK39pH0IxgxL8
         DCtFd3sZ5+tIosTsDJYbuqXVS4EW8FCIm2TWsDOasfWN79seDectyrYhe1D3a5rGg/xw
         eWaupa/U2QfGEOQ4jZyLmZ2CTqFCUhfASi3maMl5PWSet96U4fJrMd+ItAkFYEzquKfG
         eF978EB5/OvequjSB06hmO3SzSrO+0RQIVhDufrnUNw3N64e5GQfn2QXCjysTiUVjsZx
         6v05QkNh0RcGBjAgHaS+XoPJ5fP9HvCxqZCNMIQCiaegIi8RNCtUi2I3EQD8IXMdNPuI
         dK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747940867; x=1748545667;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K36m1ZiKh2f67lsz71itOmOTNRIC9SP4jkgGk4e+q7E=;
        b=eQpcs/C5sbvIxw9rXaSfTisp7Yw9EL4Thh+sXACKwr8IzCt/64+fDHT6Ylenf3EkVD
         g+ABKb5On8K9N3GuD/x7kBNwktPEQQvadAgjJhB/89YUcGVfSj6LiPby6MS0oXu23BeF
         XhWMDYb0OBCMfTeGRxLEW/G2HqIjlWcChjNW0OrpMBnVBMsVZMnHKK+T1mwrDccLV1zW
         zw/VGoLmEBUU/UdYGIUBApkEm030B3q3T3wEWvpcv4PCa0kaADATbOUO/QjYZeZ0xKRG
         QplzJCYjTZ1NdfwFY3kEuo8FCdioav/HpY5PLFGY4zq5NkTTw90NSH5UA8Zr/T1RGjnw
         do3w==
X-Gm-Message-State: AOJu0YxcnowEcr47wIV/Slp+bzYDC8+0/JH8OMRZv6Yt5mftKmo3kEiZ
	gopaMT2kWVHSoX9Cl9Nca0TGVGiaXBTOkkPRJMwdxQnTB5xgIQNfaZZi7doiyQ==
X-Gm-Gg: ASbGncu94Uk6ORYCWZ51wTIZk8WW/9tjS+2/tM0z5wttocQ+dtpD1UmWv62m+GIROZv
	Lm/zBHalf/qHZTdoJRAtrwlp+0zmACV4IbKntmiMoXlcCXS88sT9xg/fphbOSQhEgd3+AIN9oKB
	uAxaumjNs57YR9TpgKjSXUimFipfAGnLxbVMdERdB1UevX/VoJ/zBoAWIXLXFEkvF1Hj/3G3pTM
	KjF6TRcst/sKiqiBOyzE0Cs87HUBjWTnqjIVbBA9a5osh5K5GjWvYtKi+4eJt7mrWacMz7PvmuR
	7Aoikum46BU62s7QKJENcFIXkSomSJfjwO1dtNStU7I1ucRazxTmtfBhRw==
X-Google-Smtp-Source: AGHT+IF6T1oDHQbzA9PBQkHM38PJfBmkYo07iAjs5KFX7Wyw0iOtbn8SgRGXSaLy3Xh+XNIwVHErXQ==
X-Received: by 2002:a05:620a:2552:b0:7cd:27e7:48c1 with SMTP id af79cd13be357-7cee323604bmr13746185a.48.1747940867364;
        Thu, 22 May 2025 12:07:47 -0700 (PDT)
Received: from [172.17.0.2] ([4.227.173.177])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd467eeac0sm1064313785a.62.2025.05.22.12.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 12:07:47 -0700 (PDT)
Message-ID: <682f7603.050a0220.3d9ab9.a1a1@mx.google.com>
Date: Thu, 22 May 2025 12:07:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0665525307170341921=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dmantipov@yandex.ru
Subject: RE: Bluetooth: MGMT: reject malformed HCI_CMD_SYNC commands
In-Reply-To: <20250522181602.908248-1-dmantipov@yandex.ru>
References: <20250522181602.908248-1-dmantipov@yandex.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0665525307170341921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=965515

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.24 seconds
SubjectPrefix                 PASS      0.24 seconds
BuildKernel                   PASS      24.63 seconds
CheckAllWarning               PASS      26.99 seconds
CheckSparse                   PASS      30.10 seconds
BuildKernel32                 PASS      24.20 seconds
TestRunnerSetup               PASS      456.42 seconds
TestRunner_l2cap-tester       PASS      25.30 seconds
TestRunner_iso-tester         PASS      39.65 seconds
TestRunner_bnep-tester        PASS      5.86 seconds
TestRunner_mgmt-tester        FAIL      131.82 seconds
TestRunner_rfcomm-tester      PASS      9.29 seconds
TestRunner_sco-tester         PASS      14.75 seconds
TestRunner_ioctl-tester       PASS      10.15 seconds
TestRunner_mesh-tester        PASS      7.26 seconds
TestRunner_smp-tester         PASS      8.69 seconds
TestRunner_userchan-tester    PASS      6.13 seconds
IncrementalBuild              PENDING   0.76 seconds

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
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.215 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.170 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0665525307170341921==--
