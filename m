Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71B9150993
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 09:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719913434; cv=none; b=QdRop2w6Q9/q/UghV3ZdEtnGQT+i/cEku2Dluos22fJLAnBEeUZNjxkY0Q9FAN5sHf+yLugKemeMeNPvWT96JpeAOPlbGGPdenwVBGJFdn0Lsydb5bswNI9TymrdHxtu7PPw3BFoZ7i1nph5QNC4D9UrmpPfMyrNHP+Ba+J07G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719913434; c=relaxed/simple;
	bh=UZX/beulYn6ZXkCkLv7/SUIALguW5PqLi9Z6j/4tTag=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=C8j65UDqMYCOVE+pNls3YS514nptF0dz1gRnV+4lc8OoD4EXBQWQVu4WfVTF9G1oTeQv0L3sPYnO6FouX3SfhKss1hLH+xMnO2bQj4XFKfMnPUZ/hwpzPuJ0RHPRSCksBHPsrtVGVVbkpnGDMoZgNzNAzx3SnQ6GkvT3OAlNWwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ibuS7iNk; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibuS7iNk"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-79c03dbddb8so381620485a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jul 2024 02:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719913431; x=1720518231; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zDjVNbme0D80ZLXrCRb9Edzx3vHm8CL20UgiaVVsRoA=;
        b=ibuS7iNkFApZkOqUrs5T9+OKW3ru7h1uysa+KJWMY+4TNIn6QsJKZfp0J1rZrmV2d2
         j4V/+9iZtQvkeDjwKc6EWbxwCs/LcAYZjkeSYpn6xhWjwnCbl6VtqGvJYQ36JPcTDF4c
         LiMMTxDw5MpnIA/18YMezk/hZKF2G8gTTV0RATlyedMh1lkOygBz8aiP3NQlqqD3XPvc
         walGBphxKVktOhAuBCK2c4piN5hphEO51GL4ANjsW+uZGP9sam9Rq3q4GPllroAeXXes
         1Lc3Qj+Em+gpCPTJLqYzSLTtmuVgEKRxnU9V1AinxTe0rAzeI4TvwZ9jaRlnHMyCHSfv
         UTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719913431; x=1720518231;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zDjVNbme0D80ZLXrCRb9Edzx3vHm8CL20UgiaVVsRoA=;
        b=rLmxogdHemj4+1nftGAl51qrOP0GohgjVzMIgWo9HZxPRE7ts5PcW4ACTvYd3g5c/0
         aeyJjrDsbWkC52rF8VVxBzvgSmwwM+hZQmTmO74WHgIlfcnC96ii/SbWWuFE/4jzongv
         RQwdD832zRtg9+XWWZansrYc3bWX/ZPGwWOB/DkbmQOZ6gNLljipI52Yzj3/YLgAk2fj
         yjFSn+15BPHsfk3Ywc4W6ry0g6QcKYyQyPuleFIzrtVg7vfPqs/npEOt9IfmzU6R5Cz3
         a7uRXQ5OlpaN4ZeWkk+O8urgC4xibieS5ArxEZEVrPPHK9ChUsJr6Fdpyi68adiWwT1d
         htqg==
X-Gm-Message-State: AOJu0YwTL3/llfsCfOdu+qmEnKx05QJPOdcFMP0/5chyik6WELio1zaR
	Cyf/Zn4QJ/qdS4nw8klgLqmF5zRq7mJ8cJMhLTOKZTaoSPwj+Pb/zdQEaw==
X-Google-Smtp-Source: AGHT+IEukXmm7teofG6Ut/D0SKxbuQPO/1PoZwh1mNAMCZUEuYdrsDk/ApuELtyaIbL/cP6YcJV6sw==
X-Received: by 2002:ae9:f44c:0:b0:79d:6539:b181 with SMTP id af79cd13be357-79d7b9f1c29mr805712785a.37.1719913431560;
        Tue, 02 Jul 2024 02:43:51 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.76.231])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d69307c42sm435370285a.122.2024.07.02.02.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 02:43:51 -0700 (PDT)
Message-ID: <6683cbd7.050a0220.d91d5.0866@mx.google.com>
Date: Tue, 02 Jul 2024 02:43:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5649211645886006003=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: [BlueZ,v1] audio/a2dp: add NULL checks to find_remote_sep()
In-Reply-To: <20240702073955.10962-1-r.smirnov@omp.ru>
References: <20240702073955.10962-1-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5649211645886006003==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=867428

---Test result---

Test Summary:
CheckPatch                    PASS      0.43 seconds
GitLint                       PASS      0.30 seconds
BuildEll                      PASS      26.44 seconds
BluezMake                     PASS      1611.40 seconds
MakeCheck                     PASS      13.31 seconds
MakeDistcheck                 PASS      176.99 seconds
CheckValgrind                 PASS      250.12 seconds
CheckSmatch                   PASS      351.41 seconds
bluezmakeextell               PASS      125.11 seconds
IncrementalBuild              PASS      1551.65 seconds
ScanBuild                     PASS      984.95 seconds



---
Regards,
Linux Bluetooth


--===============5649211645886006003==--
