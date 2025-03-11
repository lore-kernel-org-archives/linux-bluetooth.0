Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93BB263F37
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Mar 2025 20:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741725253; cv=none; b=ZhOMCkuwA/ND6RiaT6rUR9EbnAICmSFjYjAgwz6XsCXZRoGmMj8BTqIJ1HXlTlW3U6au1h/BgpcKgIIF+vrt2J2axElSPdaPIdxccJoc3GhKteF6JRWKBzwYLalGhtpQbBDjIW/WXR4S/NA8cBywPujCBlCWiuaYt7Kzh4dn6Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741725253; c=relaxed/simple;
	bh=OrQjJChkwEcxSvA0TLKdXOztfDzZvoCYt+ckkjf8aXI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Uqi3FqoKUT+N1pLAV/O2wyeRFA+CXleoOw/ednywkQ7T0aWMvI2ISEWXiE7dleRUfgACKsoUt8X7tb7irM9mthPFlKPgd2wIEJxiw4FAtBFTje40a8aAQX/7BlFqJ6YmsQxb/z+OxcKI7hGtRgulYd348SXqJmlNwKcrhW+WKL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7Smpxs1; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7Smpxs1"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-476964b2c1dso28438591cf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Mar 2025 13:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741725250; x=1742330050; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Uq6ijKIGUvIw76HWWNaOfvxBRYbbAkkd2tHkFAqMvtQ=;
        b=W7Smpxs1SF8hz3tHcXBSze0YFcsg01YF7CbOjxOoyu0cI4D6i0O1xGG7V8hcM4ylqL
         KVH0pMd5uq2lJiSssT9/h2zb745ORs22Az57haKh4h5dn4657rx5pPYVlJU2GsYYyF74
         D/4CTlScAP95qYCRyN9vgPGJZiQNdoiJ0lod7daxnOMyx/gLeK3zif/tXbaguULKG3uG
         uIZsUd0TkmR9mS/BO9+vJ2p8d9+v0Y07be5//1BlALjBcLEgxKxrCr45jyFmE/Yrg7vO
         nYiIZByM5V8Kq1dZ6nehQjpKomHPheV4FFkTPVSQRAbyAtgy2aWiq44cOvmYd/9o7uGZ
         Z7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741725250; x=1742330050;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uq6ijKIGUvIw76HWWNaOfvxBRYbbAkkd2tHkFAqMvtQ=;
        b=kMiFGsPwB/VOo5O/vezxvfH6MPFqu/x23A2zTBF3o2uPRJQ2rzUyvll66wi1EmiyyD
         HJq5FFdETq2bNiumogu/AwoI6A2V3kOIMH1kFenLal6rc8PfbLmaMpfs/yQpDLWlYsqm
         ju13yyMAQdClssifaEsJFgh8DrjkJL+NT8qLy+Ljzj1tP07V4qnJ9AYFunXYdkru+sLy
         D8dtmu5Kbv/i+kxxgBxtaw5vEr67eMs7U14XSE7pN9qphD2NMWS+Wqr9d2KUMhHva+WV
         VeoY3pwStd2dvOU1JvwmE8BU9wclF8FMO2fMA4Gx4ZQmquvpeI0C6cXKH6jRBPJa0EoH
         lxuw==
X-Gm-Message-State: AOJu0YyPIR00g2MUkXMg0z8DC7s9r9CeQ/lbOQEo0ofCSwCty63FSClR
	PXyTad+FiiPvGfPp20YWTXZA5U+hwKq1RjwrhVUoXhJ5I9Grob59+I/Cyw==
X-Gm-Gg: ASbGnctg9E0bAUmfQ3rQy1knWLUcOdPxT7fKWcnOcLH0ipBNKBloNQ66IpzJ5FwpTWt
	4ZI8QkEFp+L+jNmxH01jEdY0Y42SZwrqlXIsghIWOz8eYtg9gfmhpuQ9tg9bNmsLApUoJxXE/Pr
	7UVqEJsgOBEHZVyzx5HHEoTZ+1jGenaIu8PA9DiXZxjlFH+EEp8zA/S7DuD999r5hjcLeCxdqDF
	2h1Ta7RKck55ARkZ7Wy1kFlKEfZmTZNO1W2vj5OvVoSKBlahe5n5DoVP52HPY8/GKXwgggN12MJ
	2FoyxW/rAW6H9AF/VO6DuRYoRQkbEA/Ro/Cr8jde0ljnbmjwWDbJ
X-Google-Smtp-Source: AGHT+IGuGIWV7VPFSQzyaVS2skRY29YDt/izTMBevWKw5V6cEE6fxzRYLIgsF0l9xmkljaXUsDO1fg==
X-Received: by 2002:ac8:5dd2:0:b0:474:fee1:7915 with SMTP id d75a77b69052e-476109bef47mr307173211cf.31.1741725250280;
        Tue, 11 Mar 2025 13:34:10 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.152.27])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47692c32989sm23030011cf.44.2025.03.11.13.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 13:34:09 -0700 (PDT)
Message-ID: <67d09e41.c80a0220.139d99.a2e3@mx.google.com>
Date: Tue, 11 Mar 2025 13:34:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2878980461585546707=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1,1/2] Bluetooth: hci_core: Enable buffer flow control for SCO/eSCO
In-Reply-To: <20250311195528.41993-1-luiz.dentz@gmail.com>
References: <20250311195528.41993-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2878980461585546707==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=942852

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.19 seconds
SubjectPrefix                 PASS      0.19 seconds
BuildKernel                   PASS      24.38 seconds
CheckAllWarning               PASS      26.74 seconds
CheckSparse                   WARNING   32.92 seconds
BuildKernel32                 PASS      24.00 seconds
TestRunnerSetup               PASS      437.90 seconds
TestRunner_l2cap-tester       PASS      21.71 seconds
TestRunner_iso-tester         PASS      37.67 seconds
TestRunner_bnep-tester        PASS      4.93 seconds
TestRunner_mgmt-tester        FAIL      123.93 seconds
TestRunner_rfcomm-tester      PASS      8.14 seconds
TestRunner_sco-tester         FAIL      19.11 seconds
TestRunner_ioctl-tester       PASS      8.70 seconds
TestRunner_mesh-tester        PASS      6.17 seconds
TestRunner_smp-tester         PASS      7.45 seconds
TestRunner_userchan-tester    PASS      5.09 seconds
IncrementalBuild              PENDING   0.72 seconds

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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.199 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
Total: 19, Passed: 17 (89.5%), Failed: 1, Not Run: 1

Failed Test Cases
SCO CVSD Send - Success                              Timed out    2.547 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2878980461585546707==--
