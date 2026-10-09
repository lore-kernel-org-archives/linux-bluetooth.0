Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D325A4369A
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 02:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791512920; cv=none; b=d0+r/0NTpUlDSybRjYFyH+7Yz6hXgDAfHZZdwPQVLasOu9xA+6mKlKSUYjb25AyPc453F2D/PTEkrru+R2adeG6x5a+0J1vQ3Mqsl0yHxBrjhp7Q2ZxqlDJqWmYViKZnuw81saVSWTaLcUre68iU+Ph/kTCIKuma3SuZO0Eq1UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791512920; c=relaxed/simple;
	bh=JlCzr20TbBz/i6BQv7tIhGOooTyJxuesenHDflIVrmA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nxYsf3wgoum1D/FBiJI3PKV+KoBHDxtXSK3qaJ18s6Qhz82o0Qen8hujeE7muvWYaPoXMra/6eKlB6Mx5twqCE8d0tRZrrIkTudGo09+epPtkb0JTv+Qg8Qblnk8+zlhEvxhlGEpSgULnJRmvpfXVf5JgbNOlZu2S+kLwUffvhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXAFMJbq; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXAFMJbq"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-35154cb9de2so5424278eec.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Oct 2026 19:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791512918; x=1792117718; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8LMUoszAhYFvctYxijCshAZFnNKAyIHpr2Y2m9svsgU=;
        b=fXAFMJbqfQwBhhTvPEuv1ShiOqvTSNDTYpmduwjF/Wa4yaVerTNpJfZf/FB+d0uf0N
         G1UCfrpfNevXiZrxspPE8lr9ygoO7170D0+kUt1IrsWRAQLalG+hLawAzY7AmBm3YHaD
         LPSvYfbwvf8IFbuUUottmc7T9F3zaQcBN4ChXdpG252xehwaahCGi4kiN9Hbfod3GtnD
         clKj1DcmprvuHJ0jM93aJ9Rs2ASHGI+NA0S1L8O6OyEUlmXX0lv+k61UZputrUN+otQj
         BrAEEKcvqg6s/wJP4YPY5QNo5BJ4Kq823XUwyteHgzBvcb789uCsvdsBlpPvm37MZNBr
         G17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791512918; x=1792117718;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8LMUoszAhYFvctYxijCshAZFnNKAyIHpr2Y2m9svsgU=;
        b=Wbvfl9okndpL8WduWrUXh4uDSiE/KNRnjFl7Sf15zY0Jvd6mpFT4gOWT6beA+y2Tcm
         ozHnX3xxJdmp0XMq21Hm1UMsznL2vwL7ab2CsIue5ReYzA/4LaW3gxTNBIFNO2+lgvK0
         Wwsf9WT7BDIp4bqHbLYZu/1ZKODIMnXK2sQJzG+25Bdm8D9dAAeBLAaMw115qVuez6/P
         IQIeK+cUBn374DP1/ctlY2ZVbw9V0ZFzDmsd/k7DMcbdjnxEsZnQjBk0kTCmvzZ3MBm9
         7RljQXK4lymfr7mO8ZtMAk7I9WbH6fAYPhnL9c4bOi1wb/+rGB/n5gT4NXl86cgTSWUe
         1y6w==
X-Gm-Message-State: AFuF++llWbEuFhcf3mqnx8zMQOSNiEfcL9140CdLp1WJMiFE7Ap64ifH
	liDMwJg8N0L+/OndVBfuQwybvJ6EsDSPidiLBQeeEWKNy0la9SYSAwh2vIKaHQ==
X-Gm-Gg: AYBFou1DQM5u8S7h7GqmqRDAhJt6kfxLI6W0Oc/SKXfo0bakhJLl4wz6bvyXT2lT+SS
	4qBAYJkM+NK5rVEh83EK52mJhRWRoMAI/IhI5jQE9elTI4R3Y890M87ghFkhqaW+X5tGxUT6WAZ
	brJVo75xwvBXYY7A14T5p6gkdK1MK6qR+wRFI+CSPCYfO1fWRrC+8XPTxW8AahUa6JZbYEG0CTA
	m7mb3MAaskVGQ6goK2FdMO0mw40fQXkSq9N/d5IX2q97cwrOwtQmNY2Cz5g21Zsz8kLuo7+Oa0D
	Zf0Eg+P5dqfohjvYlg5qJ2gMD5WM3ADTUzNnBHdnVcFlYW3qlF4RxGUcFEHYDAt6BZe1p5LJeGA
	JTJsft3rnQGR5WJemsK7G3aD/x0AmkjpKPznQyHJKhOJtcS7F/jd4DO7SNJNDn5EvK7V14/WaPP
	4KduBl6I3Jfu4rsWxLRhuxSy4LsRjJ9aAADgsxzXoCpkib1EAaHU5/HF3t+8p6NoSJpdqJMxDhQ
	xXuzRg=
X-Received: by 2002:a05:7301:f8e:b0:351:1f6c:2adc with SMTP id 5a478bee46e88-3537e292a3cmr953009eec.35.1791512917565;
        Thu, 08 Oct 2026 19:28:37 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.244.171])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb2fd33sm2061618eec.28.2026.10.08.19.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 19:28:36 -0700 (PDT)
Message-ID: <6ac85154.7d74b517.15ed2.14f1@mx.google.com>
Date: Thu, 08 Oct 2026 19:28:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2479186193262964098=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, enghitalo@gmail.com
Subject: RE: Test links completing after their connection was aborted
In-Reply-To: <20261008215756.2710812-2-enghitalo@gmail.com>
References: <20261008215756.2710812-2-enghitalo@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2479186193262964098==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1181897/

---Test result---

Test Summary:
CheckPatch                    PASS      0.69 seconds
GitLint                       FAIL      0.43 seconds
BuildEll                      PASS      19.21 seconds
BluezMake                     PASS      394.48 seconds
CheckSmatch                   WARNING   290.89 seconds
bluezmakeextell               PASS      92.90 seconds
TestFunctional                PASS      1153.65 seconds
IncrementalBuild              PASS      385.57 seconds
ScanBuild                     PASS      1121.13 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,2/2] tools/l2cap-tester: Add tests closing the socket before the link is up

1: T1 Title exceeds max length (82>80): "[BlueZ,2/2] tools/l2cap-tester: Add tests closing the socket before the link is up"
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
tools/sco-tester.c: note: in included file:./lib/bluetooth/bluetooth.h:232:15: warning: array of flexible structures./lib/bluetooth/bluetooth.h:237:31: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2639

---
Regards,
Linux Bluetooth


--===============2479186193262964098==--
