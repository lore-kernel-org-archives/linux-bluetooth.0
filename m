Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17B2247282
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jun 2025 09:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751275944; cv=none; b=Pu/Pey2oAeK+viwXkJ7eKMOHEodv0blS/tTeN5f520ZWd2by88g/O6PQg+HzzWIapkj41L3kNCFxt8hkQQ4tsGSJDtHw73wy1F9IovIZ7/b7lkYyFYPxBMUBeLOMhi51KPIRg52oM4BXoBIDzAGpVmHqcz+RlX1BqvWxi9RPsNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751275944; c=relaxed/simple;
	bh=kteKFC/Z5rtQ+pYi2aGEPwHJiKcXdbSR2/ACuMgInAs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SKw6UmcSMyE96OJLq9aGoY0TSq9dj8/N2P22C5YAyc+6NAGa/ikPT6FqoMkmpVgBuo13jK1sGtDFcxAe3SBLRku7PYuiz/MPpO0/xIsshDIcJCo65xwxyvE4knlT0QFIVMxY5+sw/GFOxnoUDDNgb9vjRpkB8pFzsZPK4j+Ij28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYZMjfWn; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYZMjfWn"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7d3f1bd7121so177568085a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jun 2025 02:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751275941; x=1751880741; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=opoyHHoJvCmKPlTtUSIOy6V2M5AGVZAK3IbfiKVt6gU=;
        b=YYZMjfWn2AZHIO3uVLP35R1vvLRdae57n6zKCHNV+6Ntz7y3ccg+0LE690yzfRJQxo
         edA0CB1SUol/o911AbfNm4OYGyCBDbT7zqw0dV1UqNLTFlOurBwqAqfYXrJNhePCvM6y
         8e4646M7exE/pqRt/G6iEtYd1K3SM9QF9+P3ExvtdguunfGjNdIpEw2hd1AnEq3bFZvY
         9TjPuixermDCbSeLIXj/EjNYcUAUwDyi++PFLOrxoFMrPjF6/hult+12o/omjq8KlUvz
         bgxa1YHPBjwvo7C04y1wNdRjBsJAMjjKwt7lez2ITVbI3mDoUEupSfZYZtbI8WlNeSb4
         CZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751275941; x=1751880741;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=opoyHHoJvCmKPlTtUSIOy6V2M5AGVZAK3IbfiKVt6gU=;
        b=N12kXFazYVMSxUrp8Op66IHi8bBGKwm9B93fwY+SXu5m5DPuJb1qfqaOhSWpUsGEkh
         kR4sNjRQZGG7a42Lo1FdJYZcREbtFb3Tg8ac5ZW3mJOEoSDe8wiJ1+q1kgPh+YECdEyP
         t9j01GqpuGr8Bsnp59bGNnZL3zu0cJxgwNIsrcqBQ9rm6Zf5OEyjU1d/GIa8jIWa4W1X
         xg2kshjT7ZkRtGdcRuwPnh4nwE3OlN/PDXVpbu+D5MW7rXR6ZvZKr0NK4sVbqHgiNfqe
         heBO4+Xpu+Tp0KYe/74MdaRbb17OdetuddW9etbPC5DdSqgOcSOOzCHkOlagKhFlDz4g
         vZJw==
X-Gm-Message-State: AOJu0YyTizhh0iqFW12Sl0GyJlEM02UXjWtTiiQzTDMJx7+rva3hWtZj
	2cNtl5OIJgOKDCMYX1RSxye9qc8PmNqYLVAPb6Aja7OCoG3tFyGAcSXFQTrCqV79
X-Gm-Gg: ASbGnct1L5XOmJfW7CqhuXzX6m7/lv0rvIX/pPB348v4Rpj2mTqHRkoFC4S/jVYIsAc
	iNp5gI0qlYEMt5hAJstu2KgWBjt5PzEEoGYwSEIC3jx+kVYRwMJNFNbKM/D05sGwZwstuot+7VI
	Ta/i+s75R3iM/kQ0Muic2LiE+YpgaHfdhNfHzdqXm8XrkYCqWvaB0HjPGG6+dripxX/excDpftm
	ARg26by2Ni1LsLQu0Byadusp8iZhW1uJJRryx7LgNMfMtad8vGjmvVQroPJ+1BjPC+fRAODCo+x
	T0PT+4XrY9B7QGamEXgmrGvdl5PvRh84Rm8xuwbflQ5W02sq+R7vuoRj/v5eJUflHywfXaw=
X-Google-Smtp-Source: AGHT+IEQAcRnMAkDaT/LHJBIGOaGb+D4KS1lE6fHonlAb+3VhW91AeUnO83GLB03wJb1+njUlmRNdw==
X-Received: by 2002:a05:620a:1727:b0:7d4:5a4a:ceb1 with SMTP id af79cd13be357-7d45a4ad1e7mr591005885a.47.1751275941214;
        Mon, 30 Jun 2025 02:32:21 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.205.237])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d44317f761sm567803085a.48.2025.06.30.02.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 02:32:20 -0700 (PDT)
Message-ID: <686259a4.050a0220.504c6.ddbf@mx.google.com>
Date: Mon, 30 Jun 2025 02:32:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9178407999188865567=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yang.li@amlogic.com
Subject: RE: bap for big sync lost
In-Reply-To: <20250630-bap_for_big_sync_lost-v2-1-1491b608cda5@amlogic.com>
References: <20250630-bap_for_big_sync_lost-v2-1-1491b608cda5@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9178407999188865567==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=977201

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.24 seconds
BuildEll                      PASS      20.40 seconds
BluezMake                     PASS      2764.01 seconds
MakeCheck                     PASS      20.08 seconds
MakeDistcheck                 PASS      200.91 seconds
CheckValgrind                 PASS      278.87 seconds
CheckSmatch                   WARNING   307.37 seconds
bluezmakeextell               PASS      129.98 seconds
IncrementalBuild              PENDING   0.24 seconds
ScanBuild                     PASS      911.84 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============9178407999188865567==--
