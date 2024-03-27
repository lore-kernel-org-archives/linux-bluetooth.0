Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D13149C6C
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Mar 2024 16:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711557632; cv=none; b=RzdADciaWefrwDO8PV+g5WzRAXAAjy9Sj7ul5MFAvDHxgSW/axlELlXnpSOwsKcK8omnH7AcBn+x3fgg0Q336QOgp0I4XChsYMnMBPuZLZI4JmzTOdZ/Cs5Pmv1uONNDyrbPVjdx9VzH4uyTi9jLD1FoCNKREkcG+QbGnbNGsPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711557632; c=relaxed/simple;
	bh=/PetU3/hj9J/cDf/IUOKH0IZhFbJraLU6zTXgENakCM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DgimbaFKdxOpe2IZrn/NRJ6hbipu3xsRIVRHOOblVrS7kXnbF2agl8hv9dq5k80N/VZxkKinLu+0IjrMVwzmCCfhzt15oh5hTzzb5tyF+B9qCgwrESCIac6sxd3rPkVbh6IxEg2RpPzKNn68vFP+B0yYJjc8/lE415eNoEYqpWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GIVXDz1F; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIVXDz1F"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e0bec01232so126935ad.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Mar 2024 09:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711557630; x=1712162430; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MKz1ZAvptLbjS1vB791VtT32rPWKMNr3lt/3shOv6Vw=;
        b=GIVXDz1F9FalLbe8kj1KkX4Eo/kjEJJFUq3NWcQiv0Az3jWxyK5W60nZ6+RC2/cXKV
         nqEY9OA9XmqULi0rj/UvMDGFg+K24sGlxBYgohIh9dcVooh5B90SaKyDq/0tJj9H3jIm
         4wNed7YBBdX4vGTTHPfZs8x0RjVMf2UyOoVQB+6ZzC2eW5vk+ShHoVZN46JV+bVHup7E
         7Tpv2s7V/NsAquriA8CSmIzJqyDpuBuu3eHpTZOKx4OlPcqw/99hIAA2tTM/fLIIWhmv
         /Nl+QBu2RVLwoiqLevkKfGtEkWFnsnDaISRPRLwOIs9LAW+lrUyCPhek31A3QehO780r
         oY4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711557630; x=1712162430;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MKz1ZAvptLbjS1vB791VtT32rPWKMNr3lt/3shOv6Vw=;
        b=qpf8RGPJ2njwYQD8T+8n4rtxv9tmcpFIlE5UG7TFC/+CZ1ELtB1wl8hHQDqU533fPM
         /Tsg+liqw1FN9AlgCJANBPA3k056hYkZzztZ1QD9VA1ChxK4bFsJUKAh4ji2ATvIYinS
         6n0yoNdb1AQhPx1utsKRg2aqXnJ1OkW7GPfXGvGQ5RbL8ZrgAXkpLXfGcmWPsvRUfny+
         iTPTORY+GkY1idoeED1/q+yKc16n7bq7+5OZapGFNh3Ex0yUt3RbhZPwzdE4qn9HIh/y
         wuXWXmPDaNVeh1D1pOILNWkNIU1CvGTiQECNhm3ab2rhTXAltLukFXyOmCN+eUnlcd/p
         w2Mg==
X-Gm-Message-State: AOJu0YyKWAmfrELBotJkuhQaj5XlpaY/JiCiEzweT/Qtuqfzc5df3QJW
	mdQf20QjtbPmfiMV2BGcoGj2D1NNlArJj4rJOEqYcFxs61XlP0i2+t2WlEqd
X-Google-Smtp-Source: AGHT+IFdcBYqBSj1t/OwLXesdIzxXRGvi4MM7eX3xtBfwcpysfr/LL4H6Cn9ByAoRJKiG08yn546ww==
X-Received: by 2002:a17:903:2b05:b0:1dc:a605:5435 with SMTP id mc5-20020a1709032b0500b001dca6055435mr250701plb.31.1711557629769;
        Wed, 27 Mar 2024 09:40:29 -0700 (PDT)
Received: from [172.17.0.2] ([52.157.4.130])
        by smtp.gmail.com with ESMTPSA id q7-20020a170902a3c700b001e005a58237sm9476422plb.93.2024.03.27.09.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 09:40:29 -0700 (PDT)
Message-ID: <66044bfd.170a0220.63397.9d35@mx.google.com>
Date: Wed, 27 Mar 2024 09:40:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3011831462272976821=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] monitor/att: Add support for decoding GATT Long Reads
In-Reply-To: <20240327150727.1584607-1-luiz.dentz@gmail.com>
References: <20240327150727.1584607-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3011831462272976821==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=838923

---Test result---

Test Summary:
CheckPatch                    PASS      0.37 seconds
GitLint                       PASS      0.20 seconds
BuildEll                      PASS      24.24 seconds
BluezMake                     PASS      1703.79 seconds
MakeCheck                     PASS      12.85 seconds
MakeDistcheck                 PASS      180.49 seconds
CheckValgrind                 PASS      248.42 seconds
CheckSmatch                   WARNING   350.76 seconds
bluezmakeextell               PASS      121.56 seconds
IncrementalBuild              PASS      1460.36 seconds
ScanBuild                     PASS      1006.26 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/att.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.


---
Regards,
Linux Bluetooth


--===============3011831462272976821==--
