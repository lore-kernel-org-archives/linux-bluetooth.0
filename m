Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA6D6F06B
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Nov 2024 18:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732214242; cv=none; b=ViNaYTxjDmSuHK2OGXOI0qQRRQy+PasBZVMWm4PuZsrka0SF3H8cF3zmmPic25iPgZ9LmD8MAXP+zcUjrcUdKn8tljzAaTtLw/l5FzSBtHEnpw+2JeocR73Srct65vc7QAw6TBBnel5XmeQG8eUxF7kqs1h0FZblfTFnG+4IQAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732214242; c=relaxed/simple;
	bh=1iVO0fDlWbIbDUVYwbxNVzFaPBQVRg1MCl1udRoZeRg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=P3M+cR1F2/2wV1U7SJl80nSxU5PEn7mZ+fBRjr9WTvxiT1M1RgGbvTQLo3Sv3MagycYUOKO0SfgKEoxoRCl75lYCJzzD1fLEf3ElfCnzamRo8hqLu4v/W0juBvikxi3rmtO1znnE204O8WwNGg1a6zmROcg5Ri0qD9wN314YtFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbOXUTA8; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbOXUTA8"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7f46d5d1ad5so1072279a12.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Nov 2024 10:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732214240; x=1732819040; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2SW4CxyStfJyomRlmbJwIYrLbwwIiDg3YZYk/a/KdNc=;
        b=lbOXUTA8Jbz6IOU205QYRlyaEZwbq7k3+h8gpT/LY9KLTCD8AzB7UH/+coY4tgw55s
         N9YfDRQV83fm7vnSrCX6Id6NDMZkNleSoW8foQCjjpVaUSROc8cj9sjn+31IbsnkRUsD
         4uNwANXEObNrSqsqpRtXFNdGcWlQ7wKO/xmnFDgg26/ijOwCU+8GWhr7tNkasORJrwY/
         NBzvHUBA1Tk8NFxrSlspZdXW2FjbXwpk6tU7AqbqZ3jkALJYQz/cEWFsIlHIyTc63baS
         4gP4FW7/PMnP5AfCW9XiQTkfybigv/QRpl5fnfpDtnWBS/uNfO8dzfG2llge+1SRUY7Q
         E2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732214240; x=1732819040;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2SW4CxyStfJyomRlmbJwIYrLbwwIiDg3YZYk/a/KdNc=;
        b=iJDGbP8EYmssfAtZk1iwW3o2+zmpujrAZ6zujjbC1OR5cIdvoiGZqvuu2IybxuGt56
         N1HXYXIisyqbMYn6VNafCpANK2He84ns/ObSemaeZhL0jWoFci5GrZZC9smrZZxvqF/p
         ahgUy91poZUOGpZQp7la4zAlbqrmrXuJIVayiRDdIzueSe4Xg2dtNLWzIHfuZIM3+/mp
         t2RaO88gLDC+s67Cpe3wy65dTvRK8Xj6EEaOc5jJUBYvX0kXNcFIa3wwQ6/Zpvhiy62n
         /UCpzOcpzlcdYag+XRPDQas7yEeCGn6FY0c4cKgi6mNSPuVUGnVAX0jiYmBfBr0XXmWK
         Drug==
X-Gm-Message-State: AOJu0YzpudwvrRQCwcSl8WWE3FYf9iBBlD/IxgRJVU01tQAIpST2TDQN
	9298lK2/WZklEgNDcR4DkXpGimmBJ0WMxJV9h+yGFobnfRsMOYHpNA1O8A==
X-Gm-Gg: ASbGncsPT6KEBf9j9uaMFWsMXqewC4KbegBq+Y4awzEv7woHm7RZ7KhKH2FBI9ry7Id
	70CtSXGY+4LumlO/H1tk8Bx1bJjgIKD6z2NaLP+eRsQ83JW/2ut0VXLTt2N+gDi87nHUsCcC8XH
	YUaiSlh/+VOce+MXtx9avxcpiPA8dhMSD4eruxVZsDCNo6hj2gshFbgsTIbXRYqEENP15eGCRrx
	pftTzMTrTxJqlBi/TnNPX84x978oMfG+VHiyfgYCxOWDDaGDrd2XKBd
X-Google-Smtp-Source: AGHT+IErFutq72cvl+VprdPsrLp1ZOD9cxf1/18b04JMW5OAxig2E4GiW9Tt2oBFsqhrGBNIWe2gOQ==
X-Received: by 2002:a05:6a21:2d86:b0:1db:f099:13b9 with SMTP id adf61e73a8af0-1ddb10e31b4mr10789385637.43.1732214240080;
        Thu, 21 Nov 2024 10:37:20 -0800 (PST)
Received: from [172.17.0.2] ([13.83.123.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc3f62ddsm65972a12.70.2024.11.21.10.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 10:37:19 -0800 (PST)
Message-ID: <673f7ddf.650a0220.48000.09f7@mx.google.com>
Date: Thu, 21 Nov 2024 10:37:19 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7506609469628438845=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, greyxor@protonmail.com
Subject: RE: Bluetooth: btusb: Add one more ID 0x0489:0xe10a for Qualcomm WCN785x
In-Reply-To: <20241121180742.156230-1-greyxor@protonmail.com>
References: <20241121180742.156230-1-greyxor@protonmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7506609469628438845==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=911572

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.27 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      24.32 seconds
CheckAllWarning               PASS      26.92 seconds
CheckSparse                   PASS      30.44 seconds
BuildKernel32                 PASS      24.15 seconds
TestRunnerSetup               PASS      439.89 seconds
TestRunner_l2cap-tester       PASS      20.80 seconds
TestRunner_iso-tester         FAIL      35.00 seconds
TestRunner_bnep-tester        PASS      4.80 seconds
TestRunner_mgmt-tester        PASS      122.11 seconds
TestRunner_rfcomm-tester      PASS      8.89 seconds
TestRunner_sco-tester         PASS      11.40 seconds
TestRunner_ioctl-tester       PASS      8.15 seconds
TestRunner_mesh-tester        PASS      6.03 seconds
TestRunner_smp-tester         PASS      6.94 seconds
TestRunner_userchan-tester    PASS      4.93 seconds
IncrementalBuild              PENDING   0.70 seconds

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
WARNING: possible circular locking dependency detected
Total: 124, Passed: 120 (96.8%), Failed: 0, Not Run: 4
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7506609469628438845==--
