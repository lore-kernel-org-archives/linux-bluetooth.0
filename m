Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5443DD537
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 20:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790366733; cv=none; b=APjLSgKw6aG5n+EoufdU4NJseL0Dx/d1i8RgeDY9UHZVnsNTQMN2dFHV/cojwJaJBiqWnlJGEVviCdBN6q5D+c6YDSoJh1i9GnfncP0xeRudvt3+QhyYrF3+Hrd+ApafZfnIXxI0wRNI7gK2u5F1/s4hvLuklPMKlVJ1LAzhmGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790366733; c=relaxed/simple;
	bh=KfEhvp6Nq/zpmr6uSlAB8SpDpKq3M8Bzbie685Wkh50=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bqod4QpDg3yn+uYLU36yZEMxFb73Qa/z1zI+LOa54R0+l1YwKKjsjQ8g2KPghTDXy8NDGDX+cMVDX+9RF901l3ceqCtV909ufOAYRSboqaBVqisw0cV80c+/UYKy+KteSDrVsuSBq8iZrivWkZ0acyCzCXiR/iOorgdHRJolmoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8minRRq; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8minRRq"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93910c9ff1cso117360085a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 13:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790366731; x=1790971531; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CMmLJzj9NdMvpF8IDbN6CWX3PZ4ncjLuku8yVDZ8ZV0=;
        b=P8minRRq3TfBCypvkmYE7RaKgiQPpnPXsdzsnkr1+A81QvUTyWZCtLAZxnoijKqm2g
         1lSktDt+JboxEtiGy2y+JCOCzxu0kpHjkosRLRMgGq4CA4XxrRjoT9AyTOBLAYMHBcbr
         1oCKQ+7IQHmTSinJ8I67quA++4DoNaPLN+4Z7IB50tSgt6W+UgXBP0B5PTEsOGriySii
         MM7syxt2w4QEEnm4HRpzwWcoQ8JCNRMZXam/h6bcjF9cVvhVx1A2bv7E+kS7272JW4o3
         pK35KQwQpuTUmrldXEQrZ6HCcnQsYRsxKiydgC7TNN+pHdDyXjbTYANj5FAHaoaxt2V0
         HwhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790366731; x=1790971531;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CMmLJzj9NdMvpF8IDbN6CWX3PZ4ncjLuku8yVDZ8ZV0=;
        b=WmrmuDWgmlzH69Uas69NIz9q7MLNbByQO5A/9MaOn4dH9iIt+KYX4hZcns24vBl8GA
         AlDGNJF09yofDXnbzbZZxA7YsN+Hr2ewDbvMUHRW8Gh2JjCU3uoyh7GlRwgpm+xUQRzA
         mKFWPsM/4XmP2KhlHaXYAXrvBbjdWX7v6swgvjT75QjH3ix55MSkEeUxBoXuk+sJQ52r
         GFsVyLNbxe+uj2s78YVSe+eMiQIDjEQQqy8liC9Jf4h8GTAgDGANyJ4Fg2T4oVWu6e1B
         EW3gosZ9ocJC/EzNO+tGbiXmHqUOh0upCJ7cUY5c84S0jjys5Cjf21qmmzynC+goRhSJ
         safQ==
X-Gm-Message-State: AFuF++koWxxAu5YgaKr8IGREG6E+Gto73iKESCKe01vweAAtjhLXS2As
	oVQmlCpAnFib1foTAzPMy1E+W5R8lH/YoSLyBsEA1fiL72uKK+C3Euh2al5CRcqH
X-Gm-Gg: AYBFou3RczhXP40RlL/caBuGMOdcLZ5u8iu3H7lWBH/1taF5gm3fgAkeVbWGunP0t0R
	7NWJC4m2tyHl2FXs2aSJWuh2yvCdL6iD1vnDQI+R7Nv6D0c8789/sGCgxMU8vJb4FN6mzlNb8Qi
	HCzWSqCj0K4DPX6xVbd2wb3i+OHp2RdlDC3s55XOdPuXtSOFG1W/20BJ83OsV5kM4IXMpL8Eneb
	IjFVI1+TyaG7DG7Y6Mhs+7jXskfgLPTd3fR4LeOCyRREMwkDdx2kN1ofMmB8TO35qqOXWJvDfza
	nT/6YEBSO4CAF6sv91qGXMtuIFSamZRI+kG9Mt7vaTzYY0KOVuu4j5DNCGpyrWu0wO9E3sPkM6I
	44B19grXiGQjxj8tMKuflsqiZRVuY3ECGVXopFOCKqm0T5O+3KPuqx0VLDiMpHxnm1D7rf6N1qt
	wvLEKUIlozYV2g3tSW8oaCeoARzUJWDKmInIH5wwHzel2yFEUkNuNtCZGDMmOVJXAiqG8VYQDuC
	uMLziQj2ZYCziDZgw==
X-Received: by 2002:a05:620a:6493:b0:93b:d7a3:45cd with SMTP id af79cd13be357-93c43d16b41mr614765985a.54.1790366730618;
        Fri, 25 Sep 2026 13:05:30 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.119.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9143d30b437sm12226966d6.38.2026.09.25.13.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 13:05:30 -0700 (PDT)
Message-ID: <6ab6d40a.24b1303d.6ecec.01f5@mx.google.com>
Date: Fri, 25 Sep 2026 13:05:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1830692294977297446=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ooonea@gmail.com
Subject: RE: [BlueZ,1/2] input: Reset report map state on detach
In-Reply-To: <CACmoRBYhQg2kAp04fFeNyArgQRoMHpBwpNX3b0-1knp6RiLpWw@mail.gmail.com>
References: <CACmoRBYhQg2kAp04fFeNyArgQRoMHpBwpNX3b0-1knp6RiLpWw@mail.gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1830692294977297446==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1173956/

---Test result---

Test Summary:
CheckPatch                    PASS      6.93 seconds
GitLint                       FAIL      0.73 seconds
BuildEll                      PASS      20.05 seconds
BluezMake                     PASS      389.15 seconds
MakeCheck                     PASS      14.40 seconds
MakeDistcheck                 PASS      148.33 seconds
CheckValgrind                 PASS      238.68 seconds
CheckSmatch                   PASS      293.29 seconds
bluezmakeextell               PASS      97.60 seconds
TestFunctional                PASS      1109.69 seconds
IncrementalBuild              PASS      397.03 seconds
ScanBuild                     PASS      1146.09 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,2/2] unit: Test HoG report map reads after reconnect

45: B3 Line contains hard tab characters (\t): ">  	}"
47: B3 Line contains hard tab characters (\t): ">  	queue_remove_all(hog->gatt_op, cancel_gatt_req, hog, destroy_gatt_req);"
48: B3 Line contains hard tab characters (\t): "> +	hog->report_map_id = 0;"
49: B3 Line contains hard tab characters (\t): ">  	g_attrib_unref(hog->attrib);"
50: B3 Line contains hard tab characters (\t): ">  	hog->attrib = NULL;"


https://github.com/bluez/bluez/pull/2590

---
Regards,
Linux Bluetooth


--===============1830692294977297446==--
