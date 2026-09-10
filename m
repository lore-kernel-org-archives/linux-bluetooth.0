Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B364457D20A
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 18:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789064926; cv=none; b=deabpsfiuubvcchuYQ3/0Ff0g8rhB6GI9HH3Os9BYxtVldSsweStl0V2GVz3OwBePZCyAvcIlPxggYCjdQMNcUGp/1n86tbqWJzkm0XuAHQCmmWDvQFR9Qf9+MYDN40X72V3CxyA3nQO7gXyPycInpB8eOhU3oYPMFY4PyaAiFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789064926; c=relaxed/simple;
	bh=TiGm4ggPvHjMVrgQsAy8MmRVGWTtW3F9n2QXKss4Xf8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=H+FKghQYNnGJ7mthDwIZZmpwD7+A3jvlkzK4+E17E2eyPc6EDW8bsc+PNKbtIts6Ko6kOl9v0jAky/nnXSBPYOFx4V5jYIeRnkp5tGYBXNDLEH2ezQlN9gncGjpzw5KR2kvZTVcTr00v713EdBVlT6byQtEnR+AR5VO5dHRW6Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVbmlX8n; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVbmlX8n"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-46fdd5884d0so35662fac.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 11:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789064914; x=1789669714; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CY4R3tH/q9oEU4BspC08vComkkAMUI7+mORcP/tBRT8=;
        b=SVbmlX8nQ6PVhyPyTxTIEFeuNE437NhXyT0qlmBGZ10nW/t3A94HJqUGFOCV78DwLv
         IBGEauGN/SCmd/AmA+79gqFQIhiSQHPpVZvV9chkQgvQmgyXEDlA5enuTk5On2jPSu1h
         Z7ED34FfiG17VJuQz355ykhj4Vf/u1UweACrjLpD6rF2WLEFrC10P1PDAmhSR3EdEY6w
         7pRQpgUFYpSDbjaHXpCKyI7RGNEH/kkyjc5V+4YglR2cgu04UZxufBQnv4Y3LMAYIpH4
         uNPz0Ok1G1f7KRrkUtVSRQDYbJuWAyu+WOcYOM8Pdd5l+qJarrF6ySEjE+RS5oo+f+jh
         ce4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789064914; x=1789669714;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CY4R3tH/q9oEU4BspC08vComkkAMUI7+mORcP/tBRT8=;
        b=M+ai34H/cu98SNttDTwigORwnE87OYxX9bygLABLySsC9kC/nG7ZqdasoMM2Z8capr
         W/9CTnVTFV36LpMiJ0Pi8TkiVWX5m04tEU3ZAv0Tq0w6XNMdvzzs1jKxiBzizNc8K39K
         bPtprKOzvjDIVT8DKpk1m2sloX1/MKFD6CqekticsiGPUngTRxpWuHaE7uu6DQPawMds
         Z6knnQLufe2TndH5lCnv656yB1VFKnedDzNVjdxkfKF+17kvmgd5iRPJcFeK06iwdWHS
         dIawE08KFVWZjvT4KwcJLKfcOzxqj9aSZGSZR0ypUxUImnc7G4Aho7hQ/PvZ2PPJw6c8
         B/cA==
X-Gm-Message-State: AFuF++mPyEwNIr8lIrQgIQshyBa4QJaOx9tnXjz3/6IyyO9YvAEG/xHZ
	GwIEA5lTXv+7d4ItNrmmOGsf8yH85U4PFar8E0h4cDjX8Vp1dGky14Omq+7bFg==
X-Gm-Gg: AYBFou3luQA3NRVQNZjtgVrJA1DGl1ii1lDsf9jh/tcYPQ1v/7r5emz8veM4rfjh+R+
	VYE86BohOPfOvqOMXxQ1dJKSgfwq0L5F6xAIxIdlFUYCkZ+785yMdUHKSup1h6B21IeYOgy8DQ3
	Xwv2XlsLhRzmceOCB+DlWcVUJS/q1azPae4wTspEEAYd+ru2SlqW1v76OeCEp8vYgSTC868Q9af
	8N12dRdyKOFYUYEtNX02G1xw0/wIAtCJLHH7U2cdeEf+J7fSoEXrjiH+6P26Shrenp1JNnXgIXb
	Reb/ZZ/EUWYIuICXy4TNDhDdxSSxGxsmizmWnwvIoB06I9TztW1B3JjcjWy8qQnp1TI3t67yFwE
	EbrXxmB0LsR4wsvD53wQ1AzvurOS/iwnMOQlHzgspT/OOy5Wg+g2UCXY4jLobk9NyyAFtmJWCA/
	5MTg5J+hNTnfZXSEkl3ofpy1JWpotpguyU2QHZX2Vji2UvKQZbhqDQfVnPnS2JI52ufUc8Y+C0b
	fkWrA==
X-Received: by 2002:a05:6870:c2aa:b0:475:e0a7:9f35 with SMTP id 586e51a60fabf-47de9974eddmr183565fac.35.1789064914430;
        Thu, 10 Sep 2026 11:28:34 -0700 (PDT)
Received: from [172.17.0.2] ([52.242.243.97])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-475543f5ac5sm20351739fac.8.2026.09.10.11.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:28:33 -0700 (PDT)
Message-ID: <6aa2f6d1.8ecdf604.14c3a2.da00@mx.google.com>
Date: Thu, 10 Sep 2026 11:28:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6845865692519374354=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Add functional tests for A2DP and BAP
In-Reply-To: <20260909192308.1306567-2-luiz.dentz@gmail.com>
References: <20260909192308.1306567-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6845865692519374354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1161557/

---Test result---

Test Summary:
CheckPatch                    PASS      4.46 seconds
GitLint                       FAIL      3.25 seconds
BuildEll                      PASS      19.50 seconds
BluezMake                     PASS      369.07 seconds
MakeCheck                     PASS      14.09 seconds
MakeDistcheck                 PASS      141.29 seconds
CheckValgrind                 PASS      230.79 seconds
CheckSmatch                   PASS      283.43 seconds
bluezmakeextell               PASS      92.19 seconds
IncrementalBuild              PASS      432.57 seconds
ScanBuild                     PASS      1019.97 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1,12/12] bap: reuse the PA sync established to discover a Broadcast Source

1: T1 Title exceeds max length (82>80): "[BlueZ,v1,12/12] bap: reuse the PA sync established to discover a Broadcast Source"


https://github.com/bluez/bluez/pull/2516

---
Regards,
Linux Bluetooth


--===============6845865692519374354==--
