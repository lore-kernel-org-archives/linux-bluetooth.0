Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7927A39FF3
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Dec 2024 16:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734711277; cv=none; b=ZbGbMgGQ4eZCkPO6AbuY3mSIXsPkBnnDS3WKMgSxE5+m+eH0lCAzRwBA5BL8BnTjtukVxknYjzF6X/UtFipEyM01SIiBcI//U99EmLmtwkiMoewhQC6+MJ12JH8QPA66VoAoDquGGHtJoY6hY7WoDKRbIO3FGurNca6F1wfTgtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734711277; c=relaxed/simple;
	bh=LsUb4pC1I3P2upWQDOQUUBuMsaa8CMMxL6iybOKLH+0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Gw67IcLCFTGRd2BvGEVmcvPCRAvUYIm54hdfplZgQht3gPXK2CCu8SF/F3e5ITbStm5PZfBegh9olW36tFSugZhUUO3D+YUEksba8YTsd3Y8fkHY8RzeeuIhwM5DDDThsV0HO4kbCC+gIrMVsNmJtq1oiYj0P+Xoj/PzaREFXyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAGqHUGx; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAGqHUGx"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b6f1be1daeso168997085a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Dec 2024 08:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734711273; x=1735316073; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qTDyishXLFZ0meWXxTDgcV4ISlDk2tEC835I59DYAHk=;
        b=FAGqHUGxksIWw3aIzteED8zdP/J3XY2UGP52c4VZHhosrwJMJrh0O9+oviM8FWP2Jv
         kHiPgLe3sm84tX3+gu40QmNagbg4c6VwWXGMO0vmQ+70XgffrVQ7b6r0qyfxIxS8e0Mj
         64Lne+U+oHCAcBXxA++O9yzzDYQ/yzhqO/IB5oCG0NwjIJ9rRWtohoQV/1nvBMEkuLD4
         HdSrn7+w1FXEvVni4fPYdw2h9g4nmdMzWVYlbvcd3TXEsTJhlwdNkr9QjqLltvyyUh2I
         Gge4P1Ti3+C6PZEwz7u2pw9KUT0za536LIm8sM+01O+8NULvc19fUhaTNzhlp16bVI9A
         F52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734711273; x=1735316073;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qTDyishXLFZ0meWXxTDgcV4ISlDk2tEC835I59DYAHk=;
        b=f7WDFmC9X5xaVZTmTTVRuplmDxfvWhpQO/4EIzzL2SJSgB3yWZglASK8XQ7KOaAHML
         DRUm6RV/HySxT7/wvLykx2Vj6KmGQaQqSzWhY8cyq1dwKr5bokEz67ze3/tF5BT+TdSN
         28EwcOQL1zzGlbVYS72k+vqD6q21CGsDbRBLwkOipdvbOv731sytUDupxW/a32mrcjPi
         gtehupxaZfRGYztCjwokFVst5fAePv6lsaGXwlaNDrv+g9yISGF190fAQHQxnfUzXLAS
         dpKfSnM0RkYhMkSztZxsVKDcQBS7uqLp9GRU5g/k54FYYMi9pKvinKi3uyheugz7pDzF
         1EBw==
X-Gm-Message-State: AOJu0Yy22IUmRTBUG17o7LassuhGXL9BgzzqNAGVcZmm2QKPkaA05zub
	EBoHhdGtWAq+TC3DUTqahPEgvd7nEqKg8eouEPmCW1MOPyia3duBVfKnbQ==
X-Gm-Gg: ASbGncv7ymuYf3J4RjQd9QK4lARxjg9P6yD9p/ZmiyYWdB/GVzw8GZ/gr2mQ07t0Qvc
	vPfl/Q6cA8xVpqlBoybd2/y8Y5qiPY8TqKjD39l0HwpiRmQ9Zk8IQSBuBYrAuBCFzm/Mp4yXpNJ
	GVhE7JE+AE+znFldxVnfSM1yx7EewbX2FiXgbKK4KgoaLY/T0MoTlfkVC+dssifHa9GBNauGP2F
	GMID6PtMdMQ0KJ7zzfapu9HFz16e5r4lgZgaNYT0gQoO1besLIDj/EI/oMlHm6J
X-Google-Smtp-Source: AGHT+IFeFHYK/EBjrQ2PWsZ7e/8lpAU6Af4egi4MC6PDEygm/61ywBTZkmZel7r4fTIxKX2NnMwd2w==
X-Received: by 2002:a05:620a:318c:b0:7b6:e20d:2b47 with SMTP id af79cd13be357-7b9ba7fe5e8mr602907985a.49.1734711273096;
        Fri, 20 Dec 2024 08:14:33 -0800 (PST)
Received: from [172.17.0.2] ([172.183.82.218])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac2df7a0sm148478985a.47.2024.12.20.08.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 08:14:32 -0800 (PST)
Message-ID: <676597e8.050a0220.c9379.637d@mx.google.com>
Date: Fri, 20 Dec 2024 08:14:32 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1966631255703468972=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: client/player: Rework transport select for encrypted streams
In-Reply-To: <20241220144458.27739-2-iulia.tanasescu@nxp.com>
References: <20241220144458.27739-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1966631255703468972==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=919923

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.23 seconds
BuildEll                      PASS      21.54 seconds
BluezMake                     PASS      1690.61 seconds
MakeCheck                     PASS      12.90 seconds
MakeDistcheck                 PASS      170.49 seconds
CheckValgrind                 PASS      225.99 seconds
CheckSmatch                   PASS      291.03 seconds
bluezmakeextell               PASS      103.98 seconds
IncrementalBuild              PENDING   0.27 seconds
ScanBuild                     PASS      910.26 seconds

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


--===============1966631255703468972==--
