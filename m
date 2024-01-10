Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2F54D580
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jan 2024 18:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZZNt22J"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6d9f94b9186so3811519b3a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jan 2024 10:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704911279; x=1705516079; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1Ccqe1anfbbjrp+yVnROrbjnjb5BbB5unEf8NRNw9ko=;
        b=DZZNt22JMv9QV9RBdVrb5pVpZmtbm+j0jUvnyAMawS+cpnnL0MaPc2WkDDSvTW9qZF
         nk0RRyrwIdJv6AmPLJ4WBlguEyf83xAp7+mNbWEmhy5VhptTiddfKl9+EMRbYseHHBHo
         5i2o5SjNzu/b3j6bc5k9kdbHwa1tdaI3ioLbY6FyE5xIOVBAP8x2t8U3AWMIMUE0uzZj
         5x4WoN8Hz2Vf0aakVBCpD/zXiSFAh2PdiM/8I+BwyanksJhoCvUOBenoi7bnZjaoMIsS
         ynAzjJfMCWwtP9yRhz1DKzL8ccouLD0ft3KtIuRvSyTjcqFt37vSpI0DXiOP6aSDYDKd
         OBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704911279; x=1705516079;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Ccqe1anfbbjrp+yVnROrbjnjb5BbB5unEf8NRNw9ko=;
        b=lJI79EjYP8dwyNEYO7U9o6MT8Wa311CH6Rbh+mX1w1ysA/Rfa2DOxlcjDcerelzFK/
         4Yc7lxKSHiGPIo7N8gB3mzqtQ1myM+M2KZeERXkoH2gz+XDRa1lj83RIHXEAHDmEBUBV
         94w+RNKJ+sZz4NHCafy7kxMUjI3H/MtQ/Uk69eaWeZzVailn+inXypMmNLU0R7VMzd5G
         oyR13uoxFE0p6P9tI4VBJwUizp5FvFPpyBvNwqf5+GK9YHCyFmkgCTEapJmh4KGgqJto
         g+h6JW4ai4bgFvldDdAmOljZop5AH9yMNMeyCJwIipVEMUhbo1hkmt+G4fD9eo6ILwjX
         /VrQ==
X-Gm-Message-State: AOJu0Yw8CiZyo3rdtlMA53HuIO0ktPgKJp7ISvYrroOzS474wUE1kCOI
	KzhAWu5iw3yYvguCmKQhX8V5xIwR/cM=
X-Google-Smtp-Source: AGHT+IGQV3Aod0mnkFIxpEcVCzLmzRabk/ZGQsCz38Ru+7/LJYZw0T89U0zoXtlonmmiJ2gXZ+eM3A==
X-Received: by 2002:a05:6a20:9781:b0:199:144b:e205 with SMTP id hx1-20020a056a20978100b00199144be205mr1308655pzc.99.1704911279038;
        Wed, 10 Jan 2024 10:27:59 -0800 (PST)
Received: from [172.17.0.2] ([52.157.5.234])
        by smtp.gmail.com with ESMTPSA id fi25-20020a056a00399900b006db3358a0bdsm1385187pfb.193.2024.01.10.10.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 10:27:58 -0800 (PST)
Message-ID: <659ee1ae.050a0220.8881e.4d52@mx.google.com>
Date: Wed, 10 Jan 2024 10:27:58 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7191330375370683350=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, silviu.barbulescu@nxp.com
Subject: RE: Add support for multiple BISes
In-Reply-To: <20240110165824.114022-2-silviu.barbulescu@nxp.com>
References: <20240110165824.114022-2-silviu.barbulescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7191330375370683350==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=815792

---Test result---

Test Summary:
CheckPatch                    PASS      2.48 seconds
GitLint                       PASS      0.63 seconds
BuildEll                      PASS      23.95 seconds
BluezMake                     PASS      703.41 seconds
MakeCheck                     PASS      12.19 seconds
MakeDistcheck                 PASS      161.11 seconds
CheckValgrind                 PASS      221.77 seconds
CheckSmatch                   PASS      327.49 seconds
bluezmakeextell               PASS      106.17 seconds
IncrementalBuild              PASS      1984.66 seconds
ScanBuild                     PASS      942.79 seconds



---
Regards,
Linux Bluetooth


--===============7191330375370683350==--
