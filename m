Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com [209.85.160.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D074191484
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 18:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769537583; cv=none; b=OOkwqk2PPs0Gzj3cS8TfW7ZCHbh/ILo+Gi4dB/Z2MQCmVMpehMHT/qVO5teIf6L+MekGPIh52bo41L83ts3SeEvZr/KCBPThP5WiEYGp3Gqj2k7T30hv3qWqvnI5iblw0aQkqTDTvnqgCn0rlUHzmb7Ge+v0hMf/BXj/tbIYE58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769537583; c=relaxed/simple;
	bh=pjJ1q8sBS5zv9pTD20jfO7WyB43Yki/y6gx4vJ2UEU0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Ve0LxJG8ZDFd79My7tsi0gveVBwBeZvD3t0Hv1tKFXnFI2YVbB1xlz08gHZiD4S0gSDJap0oUSvGYmAzDnGKZ2KvthZTds0bZsR2fyqU2zBdBVNSM5cNgMDaQIFgP8PhcHVuOeDikBDrP3pg+F6mNpQgia45sjsO6dzGSgAc5/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRRfHcgw; arc=none smtp.client-ip=209.85.160.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRRfHcgw"
Received: by mail-qt1-f194.google.com with SMTP id d75a77b69052e-5014f383df6so51202841cf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 10:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769537581; x=1770142381; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gPrq6uwx0L87mXOmnWEMrNfO4Vw2kYb9nlsOKml8rNM=;
        b=HRRfHcgw2IwxNWMbx8OWM9qnidM4v5hGu8jcCbleOHdoKT+AiEEIKKNi/AI+WO2BQF
         LTMCr/2f5lPgKFjulggnq0AyH64X4NMwVPlg8H7JlOhtDH5shAP7CXIl82lVhoFvkHpD
         tZy0vZcMZuqsoIZCBd/T/iv4k0zeWkFWeGaB/iW3ACuopz/HEq6t8lri6x/MNuP6Icov
         qHeFNBHXOGGFFUMnlCwStpZ+W0GOoPEx0i6wD8gxE5uwNhBecIj36qHAgaYVEx6wzfui
         PMSeOFjEtCBVzsu8CU0k+4H7jlnQe+bnVktpkTCaFM0aD34F3Cap60WKlQJh4qw+p1PV
         bEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769537581; x=1770142381;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gPrq6uwx0L87mXOmnWEMrNfO4Vw2kYb9nlsOKml8rNM=;
        b=j51wKrO2Z60I6B/h5HKtAYnO295I56GYjDJ3cDz8/BhNUp6ECuHuhPS1rFbfyieNpm
         eNMp1dLNh0Ohgur8h6W++ZZC50N8iQimC6h2DjedJlr1L3cTSiQ06iAJqFsVKUCnXmhH
         0Hk4gYn7HtWmXyHg93RuWBe6wboDC4cFacz9dKm4jEG0hFYXC3cwE6/S88aHYRss451A
         ldiYz/uesmymLRkevdQWB54SD58zF6ux1TnkfvrmI1VV1cngZSdksLMGmZXwsUQ9QL/3
         1aK50ljEkpnKkdFrRpoZJzYDWF7uuboF+r+zC9CtkF3KRrwzBqNW61yBxp4/iA9DOmRw
         dJBg==
X-Gm-Message-State: AOJu0YyfypBmK8vwkjGOXmYsB/1k1hRA2GXJZIe/5+ekheh0oIzJzdTf
	5IL1eXfluDYiZWHnb274xazvvUHJi80Yf4Y06JI2lpmMwqp2BX+lQaCPD8oR3Hbr
X-Gm-Gg: AZuq6aJMQpY0v87qmsply1tzTGinrD46Tv1M3apSVkDvBclmEdUGcFcfWeNlB5mVy2/
	/mAHBNUFRPjWskz4BWekA2HEakYD0nKXN5gU3y+vb26LP2oyGZJr4hPbhL4Kzq5DDaY1NgoqO+J
	XH4D8qvYTvlPtql/VGNDHRVe9ZiUPCmEvRjXolXdw39gvKLdrPEh1LuXN47A89KMgtKqcB+ENBT
	qHg2IwDl5S0cehVrNvoEtaQKSvwKOwv3xuRzo82/5vTqT5E86/ck7dzmdfRmozA5sYYLug9vL4c
	Vb5RMKUDmcBs751urkBKG0FUe9chdZGON+whAl15MRtvBBMAo91FVaTKLwbMEGLp9jrbFltJQeA
	671A/ub2MMBEQ1E8Jp5v217V0w7kKMFP/f5URiO6dQbNMcPiqR84EoeEaL4OVdcg5nZxBWqZYlC
	Oe1ZOD+TJe2+nsVLiB
X-Received: by 2002:a05:622a:284:b0:4ff:b2bf:ac05 with SMTP id d75a77b69052e-5032fa1a886mr35283771cf.55.1769537580863;
        Tue, 27 Jan 2026 10:13:00 -0800 (PST)
Received: from [172.17.0.2] ([20.161.70.166])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-503374706casm750131cf.11.2026.01.27.10.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 10:13:00 -0800 (PST)
Message-ID: <6979002c.c80a0220.387567.09d1@mx.google.com>
Date: Tue, 27 Jan 2026 10:13:00 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5408921410278767913=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] doc/qualification: Add PICS and howto for the AVDTP qualification
In-Reply-To: <20260127170652.150403-1-frederic.danis@collabora.com>
References: <20260127170652.150403-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5408921410278767913==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1047690

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.33 seconds
BuildEll                      PASS      20.29 seconds
BluezMake                     PASS      640.00 seconds
MakeCheck                     PASS      18.25 seconds
MakeDistcheck                 PASS      242.54 seconds
CheckValgrind                 PASS      294.21 seconds
CheckSmatch                   PASS      349.97 seconds
bluezmakeextell               PASS      182.11 seconds
IncrementalBuild              PENDING   0.34 seconds
ScanBuild                     PASS      1021.61 seconds

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



---
Regards,
Linux Bluetooth


--===============5408921410278767913==--
