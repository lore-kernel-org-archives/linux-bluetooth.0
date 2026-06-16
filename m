Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC1619C54E
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 12:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781614528; cv=none; b=Itb23WnDWuAEXhdBMs6+FjaXN+MlgPT31gttvI9XummRaTiFZi7DRBJRneCBpxM03vaQXTosTTPZtKxR7v78Nfzi3M+B4BzyU4XAWgxEFccBqinPsr6ITo8Ib/wBe3ihHwZkOXAgO/hCWaIaWdatLgExOBKJZ7qwFBpKirxg9t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781614528; c=relaxed/simple;
	bh=q2X4XcPJgm1shKIU74uaMhqxyc91XKzRWz0+5aWf5FI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BcyQyTf2uAkVjFVzZVeIeRQrO88yX919Yss+Y0Pu/902Jupm3IJt22Lr0wV+p71aBtReBBt+vDExi33RuMOOkaGUyemIU3t+WYgv2+IUPbvXikc9ymc4bOZS99GrPJycWu5LUqp7D1cv8aI3NXiCY3pG7/TsBTqgRRE9727y/5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LezUGfaI; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LezUGfaI"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-304d7f31215so4096817eec.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 05:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781614527; x=1782219327; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UzG2HgUAcJItS3iHnOQmr5h6tHL8R1YM5uqUKRZr4k8=;
        b=LezUGfaI8dlf9YSq0WTJmCMQSg7E2HT0sJFdvbtRNiGN1kuwpOry4LYcigIGb94OPQ
         ons46gjrbd6KBn8QCWtoyrFdEFp5DELC+K5VkZdh4XcD0kGrrm3gbH/UOEOm1lshRtw9
         HDWmNwcRstPQ7xAApQblBmfVJNcwsAyR4nb7xGTOp2KoQ6qk1K0aQ1J8q1lqf9+RkdcV
         k0lPFj7FPjilZJJABUrGgHL88Aqa9b1xYBaGQGZbqBJyyxG5k4SWkR8XLpRBZB+dt0Vt
         z3gW6DQJj5OOdfCmAYcCXH85vKeQiYBm40WpMEb/r4oLzd0OXvDZTnPjkIk4y3doC39d
         20Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781614527; x=1782219327;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UzG2HgUAcJItS3iHnOQmr5h6tHL8R1YM5uqUKRZr4k8=;
        b=k8mdxg/oV/Wi4VBKtg5Q7o6J05ibI2vEExKqdcU6c8mS7sg5YjBZqjoFZ9iW87SX+W
         7/O/N5DWk23nzEf3PmamjIwg1oaLmxJ8YPaZLmX1Yh/Gwd/VkRYsHGSiMgQ3ykFaC1SY
         3hX/rifSchCXPCQ4fcSQ7wSfc5wLdspg7dDeueGgN8VcZ0QzHnpjxSoLCza+KOkgLfR3
         AMQe8Kk5bChGIjHGIjMmdh0MHpP+m8Fdn2VBLoGrRXcxBemRzP0D4WeR0MpKMLPSEi2h
         lmvI2AiVLJSjKioJ7a3KYJdulGzPF+4Zns4p87+EY+zJNKNQQT3w3jfVLMkbuBMrFVZd
         JnPA==
X-Gm-Message-State: AOJu0Yyb0/um3TSu4XAiPyEGAZcDCyg0fz/ZFGpjsnFJ4OhYrV5Rr7q3
	rRk5qXq+sJ+4Ae1ajUcQY5tP8hmDeLV5Jt566M7hnCLEBMgTzfZXhNyJLXI7jQ==
X-Gm-Gg: Acq92OFmJqHDrXfcgP2eGyQuR+8WMs9MJvtNwYp3ATEZdDRwzzPGfX/y6xorm1yQo4G
	7XamRFb1ML4a2A3jcI6lyIqVEGcLPFtoYb1dSqcnX6qHzcMezzxWbKaBlrurLd8TxFMt9h8qkO5
	yUuMrysGpKby6oIp21vEHxMbLZCGrVGLSCE0XcavaZNGlvvN+AsHPeV8wgxZmMVwDFKh31iqvbw
	jKEQNtZgn86pGJxDfFl3MNHWWP8OAehkDwu17bPrcNxNGnZsswPlZqJUT0cu7dnzuhxRYamjesu
	FNPMmJa1xyXdHD3La85rt2PNG9vCbZKPkgU0aVlD1G4tPxTkj2uK16zgen25SCnx9ZuM2JL06gs
	0VllOSAXjPnPOipqKujA6IJRbbW3OcowJp1v7P/usEi1lXpVNnLcx1DEIAFx+JqDeEftCKVw58c
	POGTWULaIprpCQNK351wneBKCEmnHO
X-Received: by 2002:a05:7301:608c:b0:304:b93a:5107 with SMTP id 5a478bee46e88-30ba5f152afmr2216117eec.21.1781614526432;
        Tue, 16 Jun 2026 05:55:26 -0700 (PDT)
Received: from [172.17.0.2] ([13.83.42.103])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e48e412sm20392473eec.4.2026.06.16.05.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 05:55:25 -0700 (PDT)
Message-ID: <6a3147bd.9d52a705.34dcf5.fcfd@mx.google.com>
Date: Tue, 16 Jun 2026 05:55:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1804600416213479253=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, naga.akella@oss.qualcomm.com
Subject: RE: Initial Channel Sounding Support for
In-Reply-To: <20260616072245.3700010-2-naga.akella@oss.qualcomm.com>
References: <20260616072245.3700010-2-naga.akella@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1804600416213479253==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1112111

---Test result---

Test Summary:
CheckPatch                    PASS      1.07 seconds
GitLint                       PASS      0.54 seconds
BuildEll                      FAIL      13.99 seconds
BluezMake                     PASS      508.08 seconds
CheckSmatch                   PASS      258.70 seconds
bluezmakeextell               FAIL      5.21 seconds
IncrementalBuild              PASS      549.34 seconds
ScanBuild                     PASS      746.61 seconds

Details
##############################
Test: BuildEll - FAIL
Desc: Build and Install ELL
Output:

writing RSA key
writing RSA key
writing RSA key
writing RSA key
writing RSA key
make[1]: *** [Makefile:3293: unit/ec-cert-server.pem] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1309: all] Error 2
##############################
Test: bluezmakeextell - FAIL
Desc: Build Bluez with External ELL
Output:

configure.ac:21: installing './compile'
configure.ac:36: installing './config.guess'
configure.ac:36: installing './config.sub'
configure.ac:5: installing './install-sh'
configure.ac:5: installing './missing'
Makefile.am: installing './depcomp'
parallel-tests: installing './test-driver'
Package cups was not found in the pkg-config search path.
Perhaps you should add the directory containing `cups.pc'
to the PKG_CONFIG_PATH environment variable
No package 'cups' found
configure: error: Package requirements (ell >= 0.39) were not met:

No package 'ell' found

Consider adjusting the PKG_CONFIG_PATH environment variable if you
installed software in a non-standard prefix.

Alternatively, you may set the environment variables ELL_CFLAGS
and ELL_LIBS to avoid the need to call pkg-config.
See the pkg-config man page for more details.


https://github.com/bluez/bluez/pull/2235

---
Regards,
Linux Bluetooth


--===============1804600416213479253==--
