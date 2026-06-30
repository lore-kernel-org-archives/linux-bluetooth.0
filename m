Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4060B3FE645
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 12:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782822030; cv=none; b=odvuY4MqgVnq2lfa0yeDTMOaS0es7s76NKNZXLmTuSSJojtwqqWCyqWKV6t2q7JxIyriGOTPeo04d2Vv/KcRo/f2Bsz6FQo68vefcl9DyiEnNQ5jY5V7o2eAWNJBGP9qiwhXGtgK49iyPMhO+eT6ByHZVtFiI3VTY2TzOcez+OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782822030; c=relaxed/simple;
	bh=GUoJJC6HpSih8zD63pcYnGfVs18O75iRRKXes00HJKE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=EjZLB3WJEwtKniJ2SHD1BW9YL4CuwHy1vcViMhDmJMINS6C5SYUkCK7Y/esY9SdmLyMG+nwsfH70sXxz+jx66D56299mEZJ988gUKmMrxmXmiHIWbfHiXCam1W2kPdSa4TX3L3/ClKc4lEx5BmERiSNiA9WXdzMGk8zUKL8qXQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWNX7RA/; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWNX7RA/"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8efef6533aaso23622596d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 05:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782822028; x=1783426828; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=juSZ1W7aqSfJN+6PifFoGRRx4TXn9NG3VYza5if+OaI=;
        b=IWNX7RA/LjQx8o6x6ec26v/wjHJ2jGUoDYGLOyVt6xt9Qbg+CkRTmt4jsIS32N27QT
         wXdM9O4XEuB964XtN6CEEcqKjybZGv3ktTRwDMzOxTjhkSoR8Y3X+XyOSW27MWKaNM2+
         fMj2dRrbl+j27yGix338nRplyCrGRPpZksct0288leKYcQffH81VjONc6gT5W4YiFpeH
         W2G3ul7LH3edkhCqkydwsiRskCURzc8I7LJYI4ZDilQZDlrIZfcbZdFznM4Qq2Fiy73f
         TkNipDxk3tUlB4vH0K6VHr6Q3c8PfZUw1qnyX9NBnIU4BXTcFrhaLf+BCjWg41zyEek7
         pz1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782822028; x=1783426828;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=juSZ1W7aqSfJN+6PifFoGRRx4TXn9NG3VYza5if+OaI=;
        b=SLSmMPBVliKb5aNd4hXd1CS7zKtfWh+Dfuilpr5/poBpb4VCr5SITrj4tbC/d26eR3
         69ONvspU3TY2QOQPmIA9u/41lC4UW+LtgSdru2NmuptilOm6c7WLQhWZH90szg4HCRrX
         d0td82vJRedDQ0/y1CVrUDqm9/C2gQtqB2HDEtUHjp2IzdVF+XSbJrA80rtq18Qt0G9p
         mqO5793n6M6zuZFGFMHARN2ynKE5wbdy8RtY/jb2CUkWfBWhkdJx5Ih13LkqRq3YVHqh
         6f3iii/ivw9dQX5SeqO9hb3kwZgZUUObjEb3AyhP8e0x6fJbqqIxU5mHaMSFlqQsHGO8
         gn0g==
X-Gm-Message-State: AOJu0YwKQQPwFpt4a78arz04Pkw3rnatN7wlgUhbkzGb/ingmlh7Iyu6
	4o4xBBt1L11b9j09qSako49IHS8UuiwK+vL2cDuipDlF/qyYB31JbYMzRjLHKQ==
X-Gm-Gg: AfdE7cmfpRGzvtX2rWt9WKMg/Vu43PQJcVVv73kcIY+Xq1x54BkLj+vqrZeGBLwogf7
	5HjN+8xLnJl/tvLVjH0OkPQEJz77mn5nA80UeZJaT/58i9o7kOqeYiFfrpV6Ne25zPpD3qQTgYV
	J5S1mZ4SEBy9Ox3wXXhQfhbSVSCKqnYaXwVHEhR/GdHKewMC4llN21UMIdfXA2ztBgMEBidrmJa
	BE9M588RXFwfLMBucNX2u6j5d52AT+oM8tyybgahWqayWp7GL+rpZYFlRBFZoVkOETigYlHrMek
	sWQqmziqL9kVs4jyzOdT9UdhdJwuokxSZFseKACB4nqZXxdJkO51kvsFlOr8DXzH5WwFcrrwJZZ
	i8tLM8IMJMxWUNtIbxHu6MM4YR7H8o98+Y5/R9NT9AvOB9Ji5g6sB2MmDjakeEJphJOpZ4FBzR+
	hDAB5o1BqP3WCUraDwZxM=
X-Received: by 2002:a05:6214:5d0c:b0:8f2:5a3e:c619 with SMTP id 6a1803df08f44-8f25a3eca00mr22230686d6.4.1782822028214;
        Tue, 30 Jun 2026 05:20:28 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.160.23])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f1a3198136sm21964786d6.15.2026.06.30.05.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 05:20:27 -0700 (PDT)
Message-ID: <6a43b48b.88eacdbc.84acf.6ae5@mx.google.com>
Date: Tue, 30 Jun 2026 05:20:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2367996085942098082=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, naga.akella@oss.qualcomm.com
Subject: RE: RAP: Move CS default settings
In-Reply-To: <20260630101158.2239682-2-naga.akella@oss.qualcomm.com>
References: <20260630101158.2239682-2-naga.akella@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2367996085942098082==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1118869

---Test result---

Test Summary:
CheckPatch                    PASS      6.55 seconds
GitLint                       FAIL      4.87 seconds
BuildEll                      PASS      20.63 seconds
BluezMake                     PASS      545.94 seconds
CheckSmatch                   WARNING   313.00 seconds
bluezmakeextell               PASS      102.14 seconds
IncrementalBuild              PASS      688.13 seconds
ScanBuild                     PASS      993.49 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1,2/6] profiles: update bt_rap_attach_hci call to drop default settings args

1: T1 Title exceeds max length (84>80): "[BlueZ,v1,2/6] profiles: update bt_rap_attach_hci call to drop default settings args"
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/main.c: note: in included file (through src/device.h):


https://github.com/bluez/bluez/pull/2260

---
Regards,
Linux Bluetooth


--===============2367996085942098082==--
