Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ACE239E6A
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 May 2025 17:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746811993; cv=none; b=K907Za4bjElLZOP/yKOuhWDkdmxEnxRbCBcaBB/CoN0PgazFyTTL0TEGLglAWvs2pe7c8f6SNjVhFFe7DD5QlgNhTetGGa6YBUFmbbFXae9ttqW/29l7sf9JPkV8wa4kULkbknf6tcdngmMG7f7P1gKdFejr2cBoSQtThZCBtug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746811993; c=relaxed/simple;
	bh=L8EW0OHUL0Dd6LuSDrS5VNnVBnv/BBesjBknyld3nyw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SZqQPGqrK6GZtjZHet/iZQ5zj6LD9pT400CJbdMIJbIjQVR0FsNt+WAMyTKU+AX6NeUAswLpnY28L5EjinPG+iMporzw8Z9AtI2RUm/pV5qT5hoIDzxtz3JmpR2prBj4EiuecFtWSPc7bHLswO/1WlL8kP2JvnrR8Lg3HTMX3Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iX6H/ztU; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iX6H/ztU"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6f2b04a6169so27466966d6.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 May 2025 10:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746811990; x=1747416790; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6t0g+F6dUh1G6Z6BT57ozsJG7J+25uALIOdvFlPVPA=;
        b=iX6H/ztUtiMYKEDkn9tX2rMRJrIS/9krcDIfEYVWVIEU0SxOjrbek9cGmtZaCBd+lG
         84d92BQaBMX+rKV/1srAKIwsmkoDClqk5U/W63lMKyH5J+TpDDX9wB5mQz/et9aSCyCV
         JUd02TWr6YoOozoi+JbC8FAARjtHYtdV/bWmUnbQ5ojN51o3sGM5/28nTCLdU7vABL6x
         GFRh5QoYlnQiI/uohSs5faQswO0/ZDWuRpVM4lDHQOs91BUsU0QJqB0KAcc2vtxIIxKg
         hqHu4VK03L6UsjYaRWhJdnKJPl98yM6bs219aoFqjEW/JG/6eh9COw/w5n5loiRbmsQW
         uVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746811990; x=1747416790;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y6t0g+F6dUh1G6Z6BT57ozsJG7J+25uALIOdvFlPVPA=;
        b=f+lVxbqXcftK6L9+WiIv5+QgKyWD287ZqSFDtmBf9WNrilxCsNhRMl04rQyqlsdIEa
         DztyWvT9f5iO+8GrKm0Ozhbn4sMtS1HHSz+VZjE2HsA/MBbR97nWk/4bch0wMKrrXfGk
         45QskkX1GuEWIIGSceROPBU+5gazVdxmIPIS9XBxnIGe09c1rbnXCkU1Ziw+kV/BRX4Z
         v1U8IARoIzk2q7KR03L5YFToAO8jEC5+nHZ38gaKH5NmCASN9t9Z8yOeoaW51cZAhU9a
         ZsZ1/x4xx/IAkVy+AJWZMHrgJpLNMFlqZqFUcFEOj9n3IUJ9EOlTrRSDFbFvXAPPMQ9Y
         u58w==
X-Gm-Message-State: AOJu0Yw6jFi0PktdFequq61EEx12324vkU6txNDeFEg6qeGmWrc0He0x
	WGSe3Ghgc75hvIqM7uDzg2vJzwcb0pVqq/wsx6u7IbmUA9nD642CDwFn9w==
X-Gm-Gg: ASbGncumzxOwEZ0WX+WD41C2VUlflYoUzQVmjGXCSwe4UCfmbXZh2BqDI5SZ6CNJ83K
	Bt6hIFxpcIsbztAKU7wAdVhOPULSfHeIqXd5Z/fDXkjBakvyb1jmIZgA5GOTsY9dzQb1BBZwbXw
	G0cNNNlVER7Wdb9yAQYXkLPBvGLo+Dh0EKirW07WBM8kheHkp8aLtrGvKk3t04Aw1/rElt05iu3
	nSVbuIXgLe+LcYoMtqTaJ7aiTZ4ly4syPOYgk+U6cpJ/jTy7h3VWUpibpLLyqKIYDcvbjAXa7Ny
	FRiVumJPFld0iROeFNyd9U1swJHriiuy6VQIqTR4NYS2C9k=
X-Google-Smtp-Source: AGHT+IEFww9QLjXgGhgeo49NJ9N76iXXQfUWihcG4ywKlepxa4FPgydeCHZkMzNpBQdqnMjJmfIUKw==
X-Received: by 2002:a05:6214:5197:b0:6f2:c79b:ef9b with SMTP id 6a1803df08f44-6f6e47b9b40mr67072606d6.16.1746811989138;
        Fri, 09 May 2025 10:33:09 -0700 (PDT)
Received: from [172.17.0.2] ([172.203.175.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f6e3a471e2sm16220916d6.76.2025.05.09.10.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 10:33:08 -0700 (PDT)
Message-ID: <681e3c54.050a0220.3966c4.b3db@mx.google.com>
Date: Fri, 09 May 2025 10:33:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2550913037550497321=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] doc: Convert mgmt-api.txt to mgmt.rst
In-Reply-To: <20250509160123.596638-1-luiz.dentz@gmail.com>
References: <20250509160123.596638-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2550913037550497321==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=961436

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.25 seconds
BuildEll                      PASS      20.58 seconds
BluezMake                     PASS      2724.28 seconds
MakeCheck                     PASS      20.56 seconds
MakeDistcheck                 PASS      200.39 seconds
CheckValgrind                 PASS      277.54 seconds
CheckSmatch                   PASS      304.18 seconds
bluezmakeextell               PASS      130.27 seconds
IncrementalBuild              PENDING   0.20 seconds
ScanBuild                     PASS      922.56 seconds

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


--===============2550913037550497321==--
