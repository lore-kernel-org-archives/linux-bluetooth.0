Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8416A002
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 17:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707931604; cv=none; b=YnvY8EYMkkmRqFc+410SpSJbrC0KAvIWUV2rrZPtoz7UaPCBUGpQoh9MP8blEWm/22rbTG0GimFkZtn3gUZ7tF/qnLI4d7CbjH7dP1iVpCAdX2Nw2zxuI2iQVm1qArhlxKEj5Dnxth2wEkdscz5Xdkdsrr0ms6w7Pa3NTpl8JDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707931604; c=relaxed/simple;
	bh=24fTNL1ZsOBio9LMO0PVWnApTM153ghXZSwT8sHqu/0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=S4oaP/l4c7YRHykNLDVnXXfjmZpCwx8tW08IECs0PeDpu1YK+55u2Yct9SGInt3L/Z+tx5JEwdGIS5quAOAHAZwm27g4gBYs3NJ2bPRAzaDdri87PtZZFBfwJd5Skary/aurvbD2cZGK3ny7htCNgfzRD/7h9eQdCl2lEpB5dW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pk2jRkFF; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pk2jRkFF"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7872bc61fcbso49559785a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 09:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707931601; x=1708536401; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NvwJrmTolMaVySlOz6rX97MVL3veoZBypAl9sAmRF/0=;
        b=Pk2jRkFFY7REqvRdXxmdZQN7c7TmPUN51+QC8eBJ0Be0H6dIX/5aWsR4yAwIiW+bch
         yNzlirViOrvnnXS6JCUPU25DeIuuG8OrnTelVJKQGda6Xbmt2woxx7DODz7lonKNtlN8
         D5mI5kx/9pAV2r4tm7QLwod/atAGVMiOR2oh1Bf7D9vjmGMvmOvCmTfp2XHU8hU2oCX0
         or4KUnQYgEEFqgU63/t9nDMzVZsDqOS2dUdsthn3ehAuQWMzmhe3INp4gFss8qMCVs4Q
         2P8To5XOV/azAWSulhejmuL2qTW31y06QlHn6P8QOBwIat0/QBVBvfAsKs8BgoNs8ejV
         J0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707931601; x=1708536401;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NvwJrmTolMaVySlOz6rX97MVL3veoZBypAl9sAmRF/0=;
        b=QlWX1bz9UHnbfC/ueuuwNx0EdBLY3exDgPzKYg6Q2icjz3+2AR52Omg7bymM3Qlkwz
         3Ba8emM7K2+B8CCqzka+1DTd5ubxPOC+IR7aR1tCc9973wnuE0lwvKKehnAckwIbL3wM
         g5KHeLkKx5yzg7/znYWxhjD5UdCmPEV0iM2PQUujz+v9DGTgmukmJe9EKtGU5xIbJQgv
         w0AnwJK7YArW4FebZ7K1R4DvD4K5KKiHaAw6x7995vf8ahRiHzbvGuXJomJdy80Uv650
         ltTf/OMamk3Ms5I2BVPvYsjxaH7aiDiIIBII4LxDyxy3qj6UierjNi86N8sc8IgjcuJK
         xXyQ==
X-Gm-Message-State: AOJu0YxquSL2q9Spi4QAaJjGHj9DOuMKvLCrMmiTQMqYdGPkxnpI7tG1
	2UTEI/0M4Z1b9NJotm09eKiClJS+q8WXcTSdHIyI6qUCirP7ixzXtCNeoUbt
X-Google-Smtp-Source: AGHT+IHH2w1ppe2Yl8XUVYnfvlw3Aze/+DfBLMrrEXKgSjKgE8yy1dFXh21N5Pgd9TA0ByrWcxja4A==
X-Received: by 2002:a05:620a:2950:b0:787:1890:7f2e with SMTP id n16-20020a05620a295000b0078718907f2emr4324062qkp.63.1707931601692;
        Wed, 14 Feb 2024 09:26:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV/tnuJxxem8S6/viCVaHvs9ABLw7p5V0D4CMwCPcpm+yaK2QDE2d0QMz2TDaT8ThCtXCJr9/yeYEWFirSQEyAMNRfHiukhRw==
Received: from [172.17.0.2] ([20.81.159.205])
        by smtp.gmail.com with ESMTPSA id vu27-20020a05620a561b00b007872acdc390sm658850qkn.9.2024.02.14.09.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 09:26:41 -0800 (PST)
Message-ID: <65ccf7d1.050a0220.6df9a.305c@mx.google.com>
Date: Wed, 14 Feb 2024 09:26:41 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4515312371356033023=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, szymon.janc@codecoup.pl
Subject: RE: [1/2] build: Fix typo in external-plugins configure option
In-Reply-To: <20240214153635.156548-1-szymon.janc@codecoup.pl>
References: <20240214153635.156548-1-szymon.janc@codecoup.pl>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4515312371356033023==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=826059

---Test result---

Test Summary:
CheckPatch                    PASS      0.88 seconds
GitLint                       PASS      0.66 seconds
BuildEll                      PASS      24.99 seconds
BluezMake                     PASS      774.11 seconds
MakeCheck                     PASS      12.04 seconds
MakeDistcheck                 PASS      172.53 seconds
CheckValgrind                 PASS      238.07 seconds
CheckSmatch                   PASS      345.57 seconds
bluezmakeextell               PASS      112.49 seconds
IncrementalBuild              PASS      1430.76 seconds
ScanBuild                     PASS      1048.57 seconds



---
Regards,
Linux Bluetooth


--===============4515312371356033023==--
