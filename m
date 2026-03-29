Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FCE378813
	for <linux-bluetooth@vger.kernel.org>; Sun, 29 Mar 2026 13:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774791258; cv=none; b=QU+gNbTN3vwljLwBiSgk1cDCCYKspLlUdZ2LoSa7mNXusTqjRxhCGo5uQQWj/cHtbBqMsdldcaVQAvKTv5yk6SlypFCDRgneLpNJPjzOIMY3thcjHWqSMaPttPNMXB747ytsvs9wk6vAa1l/WOtFR0dWBhFHnLzT4TFD55K/cn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774791258; c=relaxed/simple;
	bh=AfKe+Ehi5LRfLXpC7YQXSm58/KaiclsCNdK9TD5mCok=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=JjQh7JUUThbLTzNXSRPO2CWvMk/9ReqRUQbxNllgeRyEwTPQGDt8kE7Bs/GZ3vUfFTpLu4OMFGPrgQTC1SUMZbsxQ7vuJFsDT9zaci98899gj/4HvKH9kOWwjZV+u1YpXKM8R9AWRdOxxOMQ7a6csebNm3DaBDySVIaV9EL1ZIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5qK+RJq; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5qK+RJq"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cd7284782dso223163785a.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 29 Mar 2026 06:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774791256; x=1775396056; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Rg04liEey79kZk+owEofQg1QwGCoISp7eLK3niEX/Xg=;
        b=R5qK+RJqVHM5YWd+rlToMdUvpRwwn5AycVSjhyEX1/XOTFdLGodfwpqnH/CwhRiJ66
         8fIRpu2tjDCRol1SPI4PYSl10JRMD3/av7Z+m8M7GT+fV+BTA7/blp1SFZUW4QY/isN4
         4Byj1wWcfIB+M+y4zZEoCbgshzQxd4XQQv0HhOXenDHLaibkqP4ym8C87RdBjWLljUOO
         mmPPLQ8vpQDUbEFFT0omwbMPZ0bxyzwXqk+k8z+1Pj+dzf2pYTeZvBdZeserV+hFb3N/
         KZJfNzuSSX5p9/M2fHLRPsOazDtquztm9yeZ8N9VACvU8e+aMZBzo6gnFmVg4RHtoFES
         UT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774791256; x=1775396056;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rg04liEey79kZk+owEofQg1QwGCoISp7eLK3niEX/Xg=;
        b=UQtOHMLqrbaX7tBwOqt9uH/dAF8i/4pIxiVMnoIsvbpKrqLFlmmFnb9e9hxYRzypdu
         Nu5tJI7FH5yc0+B9UoFwcJY+8CzYR8v9x53VI+iDFnEfzidr80MiDizJrxexJMSryvxL
         T6XffyMzj5AZ01LGz5B0BlI3fxGmIR3jQctKChgZDO+L9lOCDcQngGxc7ws1FBPl790J
         9fl5OD2tuZbBP8NI7jH7dcrzcuxv+jNa+ezG0/ByrVCmEmqL3mwj9ZBH1I4w8Mwy4AHa
         45fIaiDwQ1UDEXwckKarwSkD96QyH6fB93qa+JIMNYEQIzGCNjQ59zNgZqdTJx86buld
         WQVQ==
X-Gm-Message-State: AOJu0YzpBvz0YeJ78h7HVB/KoFmEG/gO669i8e7BejzUBh/f0pgB5EGm
	lVjH4m08/fwPSDrGJ874Cg1GOKEPhxlpAE06fbhgQSM2zh4Ko1TUQ1qhLuxlpQ==
X-Gm-Gg: ATEYQzy7TDgYyG4Qpw9iGegKn9t/6fU/2qh0XpE0Ss+nMQ+0AOZLXQ3UyWGS/3Ta4Tp
	o+xCHSinJG7M0XOpDG3WB0JCR1N3jiNLBroViHZ7dggWl4EMaMYqz16NqvdkDF78bz1DKucbt2C
	rfeo9sz6BIcRlfOum0FdWtErUpOnFBHujNaOQKfc1o4L3HJmakEA1FTMGgUqUILyESlHbdU2jtK
	AlQA2YsczL4sSn2EVbZfcoWUOqXYDIHEpTvxut1eRj8gLgitl5QCp70paZmAUv/5hKGLVzDZcPD
	mrECvtmyEAPTSO6fuw6pp2n1nYgLllozfPK5S/mA4QXZ6/uxwHSuNElnbUqAIv7ihjXsziKTmpr
	P8V/Yd5mbYHhc6jLajMYd1KJSdbEywrBSPXsh1KslXVQ6a3Fal6N6iVbbSDIwlvu6huufcUGj0Y
	KGs5JfQ3Dobqmx/WYdhsrA8WNcZsQhhA==
X-Received: by 2002:a05:620a:710b:b0:8cf:c877:ed1d with SMTP id af79cd13be357-8d01c84422bmr1207305085a.69.1774791255563;
        Sun, 29 Mar 2026 06:34:15 -0700 (PDT)
Received: from [172.17.0.2] ([68.154.116.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d02803f694sm382018485a.29.2026.03.29.06.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 06:34:15 -0700 (PDT)
Message-ID: <69c92a57.e90a0220.178c5f.b609@mx.google.com>
Date: Sun, 29 Mar 2026 06:34:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8688326274319060562=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] iso-tester: fix missing clear of io_id in callbacks
In-Reply-To: <9d365c7dcabe381552d97a347aefd5a038716434.1774786982.git.pav@iki.fi>
References: <9d365c7dcabe381552d97a347aefd5a038716434.1774786982.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8688326274319060562==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1074168

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.28 seconds
BuildEll                      PASS      20.10 seconds
BluezMake                     PASS      629.26 seconds
MakeCheck                     PASS      18.79 seconds
MakeDistcheck                 PASS      244.71 seconds
CheckValgrind                 PASS      289.19 seconds
CheckSmatch                   PASS      344.77 seconds
bluezmakeextell               PASS      180.22 seconds
IncrementalBuild              PENDING   0.25 seconds
ScanBuild                     PASS      1003.77 seconds

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
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



https://github.com/bluez/bluez/pull/1993/checks

---
Regards,
Linux Bluetooth


--===============8688326274319060562==--
