Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BCD16D4C7
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jul 2024 15:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719848573; cv=none; b=X9Gjl32Q3fmYYvw23v2BA4CxBsHK+uNz21JNNbptv+RCy5k+9kegcFKSpkRj6VhYPJg5wAJKdLuMi/d8tV9Zw8yGFLkAtWuUcFrC8ortM7HU9GOFTolpQtfVeIjsdZ8Qxpvd4O/K+tL4TwqnovLzy81MsbVj40kqJS4bs3zrxss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719848573; c=relaxed/simple;
	bh=Xyk5u6OMZLzGixgZJCauLS6vEIrhOR345kBCrcFPRO0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fmqsbm2umMIIufbmzt+lrDQS0XDxojSRRJ+RDAHd2vginJYsBqnr1IwdMHvXTsZh2qrNpF8DgucPjlne/633CYEGNHPzodWNugELGuI+htuKnUhDB2jjTNP1FoARj4jM87F6iAqvHDFITUad20GG+4+yIP8ucErU2KqFm2PUkMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DabPU4R0; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DabPU4R0"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6b5932383e0so34165046d6.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jul 2024 08:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719848571; x=1720453371; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g0pJWTKBzhcfeeFZqO98GKHX+Ttes0oqIWUFto4MIAY=;
        b=DabPU4R0O5RKGATmWeitpTt5LcD8Etj2DjiZBlH4BXg8gjzUfXv+Jj2e/+TykJBFTO
         2ZGYiTW1+BgASC45JGfXMbxwTqnKbMoPrmuk19JVUC9BwyMIy/SZXWCEfDEm2Opf4RrP
         lPNjKjKL65AfZlP+gbaegX+Nh2CzOqul82o5YqKfSa6exESs3TQSl1Q8paeaF6hAUtlB
         F9W1N8iuCfH3DCn9XUyZwqnH6ogFZgP8s+RCPsZbo34ag0Wgj52gBSR/GTwg08Lj8gU8
         C9/s9l7jam9olvR6Gw8VVIMsRSXqP9ZbbUwF4N/iktajMo67bMNeD69mkI+u2WaK5gCc
         lqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719848571; x=1720453371;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g0pJWTKBzhcfeeFZqO98GKHX+Ttes0oqIWUFto4MIAY=;
        b=a1C/M40HdeLmTiGZv83XFphS2JdrGsonqE7SCqt+o4xVFn8iH0ZNIwR2B+4u/5VvzW
         z66Yv2LqnLAd6KQBXO618v1ZhMdf3OUWdcz1LrgCA59qRSayGkqMujA5nJTEImHZ5wvZ
         gEN9ZsRX+YE/sMU7xr0QpQX6psT5QC6KmMsOdFm0D2v9p3KJS3x3dVMAR3nVU82Si5MD
         HSDyb5j4Nrvu6U0S24C+sZDn0GDy6s1IZCIPxrDZyoQDN/qbF6moEn5XfGy7XTgeX0qX
         P1fxRfO0tAh50I3ziM3O96ec9O+1QRCcmXTA3ayoAxPTSJ9TmKnTARAqX7Ri1oLBFOIS
         W1mA==
X-Gm-Message-State: AOJu0YwgqBWkyj2dizQGYC4ym7DOljMbgsuOSWlc4eGIAv/kmOfGGUcG
	oD7XolYkl8qCvMDRp7r6KtT2FdW9t15/0iKDdIqlWBGtAJd0HLwEjV30Zg==
X-Google-Smtp-Source: AGHT+IHtSD1WUBkvbfrttOZmeb9ugZFIywqxUFIK3y3dXsb/ssQMoGpSYnPmiNBtuYQHYjfhCmglkA==
X-Received: by 2002:ad4:5744:0:b0:6b5:1897:f00e with SMTP id 6a1803df08f44-6b5a54361a6mr183153276d6.17.1719848570795;
        Mon, 01 Jul 2024 08:42:50 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.199.109])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e609b9asm33917136d6.106.2024.07.01.08.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 08:42:50 -0700 (PDT)
Message-ID: <6682ce7a.050a0220.5275d.dda2@mx.google.com>
Date: Mon, 01 Jul 2024 08:42:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2885498988373741733=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: [BlueZ,v1] shared/shell: add a check for NULL in bt_shell_init()
In-Reply-To: <20240701134401.205121-1-r.smirnov@omp.ru>
References: <20240701134401.205121-1-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2885498988373741733==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=867152

---Test result---

Test Summary:
CheckPatch                    PASS      0.42 seconds
GitLint                       PASS      0.28 seconds
BuildEll                      PASS      25.26 seconds
BluezMake                     PASS      1808.72 seconds
MakeCheck                     PASS      13.37 seconds
MakeDistcheck                 PASS      183.37 seconds
CheckValgrind                 PASS      255.21 seconds
CheckSmatch                   WARNING   359.93 seconds
bluezmakeextell               PASS      121.69 seconds
IncrementalBuild              PASS      1522.89 seconds
ScanBuild                     PASS      997.55 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):


---
Regards,
Linux Bluetooth


--===============2885498988373741733==--
