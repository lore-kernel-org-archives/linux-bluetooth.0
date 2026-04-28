Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66517404E
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 03:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777347388; cv=none; b=RjhgXlbiuzGVBhnZvDdlyNeyLj8naPo/H9OAsXRdVSry+f89amy4JtWgS5iLJChs+Wq8o14iA2yo1rm2P+GMeLvPt6/xX0+3cnTAlyzAe8Zq195kw9OMrymLbccAGXYgpuC7V026P6Ckf74f1OOZq0mvTKiwexXuNrVdKlJ3lmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777347388; c=relaxed/simple;
	bh=hffMiNtxuL6VekEt4srd3ApK4iTeYiZ0KVt6a5PzrWs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=AINoWJBCrPIL/qdQXXSr5Q+59a37QC33j2/Sa8b6/AoJBHhptYGO6le4EcdiL6afS5QpXyLSFBVSxvoGLYFqOr71yQFJpPxByIHgEZ3ClXX2ApWMLv/WFKE53GSvOolFOTHtsHqfUz4m03zKSbdEt5IRMEJFPC+odiTzvYSpYUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVs28oaO; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVs28oaO"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so10393066eec.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 20:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777347386; x=1777952186; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=43LV9J6bEw2RGZBg7V4iPai6xDj4LasyIFvII2le1EY=;
        b=DVs28oaO7padaoghsQVxPb6+EIIbP2FfjIdRnVacxMNMWx4tQRyrxosY1cXxGjlX3H
         Xkt0jPeM5gGxPV/UPn01HXthQ/p7XFsNjqjxF6GUAaHiPnWZG+JUxQjIRBXPbPh5ZMHm
         RA/KJM2NkOptJjGjDTVU2TBvF4Q0103y6B6cbC8YsA17OHZ/8nWtxWATyaoSpZXlJCBA
         vTwx85bjIL6tekfNaEb2HQOSM1VlZXMc7U6d5F3OFSs1kOiJLFvlqZxxkR5MmS6LVsn2
         yNuvLVsmrgb58Wfkk3WaFk5EO3ZR8qUcQx8likTG4Wk/Z2QhMNRf/sPHXFn97PyJTJHU
         6wuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777347386; x=1777952186;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43LV9J6bEw2RGZBg7V4iPai6xDj4LasyIFvII2le1EY=;
        b=gX1rz2SjVn+44eblaTZZQf2yHdWCM42tBsQ0U1Qh/yPgY1Sl1nR/wsTptx46NaAHud
         8M0u8+I9v45Ctl7ZvbRL6BNT5yCo+4t6MJJq+MXlH1Nvns5VYGZYP1ocDCQXif7IsXa9
         Wde5PM/bIoJYGaPmH5r32pqONVKp92/yqxGMrLMXZUJEQGfn2B0SuN9hdG9xM4jPHXRF
         q0OEF4ACqTg4sz/SKpOPRoJOnnBBMftDKHQ8BooLfaHe4TQjBUhvUrECxB8DOwR3rcVp
         sxuTDggi5MayYTmb7R3eFx4j8xo3aspz2Zp1bR8HMcXggPCkiEjF0gaAuqQApzjBy6/K
         A/Hg==
X-Gm-Message-State: AOJu0Yytf9JTZQ8nUX0FAqyrOTy2XJM23paKSiSfWt1ZEbUWmUFM4R9S
	GZLz/N/EjiiF9elYjqkF9/5JEVUIQSU+hqRtMwMVTKdCcRAcozcTVArA9CjWQw==
X-Gm-Gg: AeBDievjErnlfD0FFtOYD3LmicfPnIm0UaVBtnvbJH/o1YfFyj4Su2zuB8aT/jiBNbI
	+fdXDFsUuRn3k98wivWfI2McAeVhR0budU8CMHNZNp2usp6uqOKas2WaVQdr5AVOX/DYsqK3tjz
	OAE8d14LuYKqz10H/LAz29kNi86iukUBfmEA2ehKtZvQ0HyZpC5/8giCcecCVFXGxxSN9WeKtL3
	ZI97JkpFUoeKfiKcjyeA5/PKeG+kFDqniUbQpFigRThDFY9n+ryuNj1BgbhIv8fICD31E7vdb1F
	rODhbEElPTkFGfoNGKT51UexAlM/EfocwR2GF3/nR1Rk1zrIZRWY+SwJXff5uXN/AALvgcXU7OG
	oIXUVyh6pfNphgoAOO8oe5Yq6MeV1ri62910pb7OXp3koSV1zPDQCuPmtFxioKFHKAa3FEqpm2A
	aLlp01GG8y2cpVxjtJoXp4CTDkiispVhKyRlD9nhdiDibGTs2MqA==
X-Received: by 2002:a05:7300:220f:b0:2df:3eb7:531d with SMTP id 5a478bee46e88-2ed0a0b077amr652370eec.19.1777347386414;
        Mon, 27 Apr 2026 20:36:26 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.227.4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed0a103542sm1782928eec.21.2026.04.27.20.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 20:36:25 -0700 (PDT)
Message-ID: <69f02b39.050a0220.28c5e4.745b@mx.google.com>
Date: Mon, 27 Apr 2026 20:36:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0417062237690833518=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, prathibha.madugonde@oss.qualcomm.com
Subject: RE: Add RAS Packet format and Notification support
In-Reply-To: <20260428023111.1640377-2-prathm@qti.qualcomm.com>
References: <20260428023111.1640377-2-prathm@qti.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0417062237690833518==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1086507

---Test result---

Test Summary:
CheckPatch                    PASS      1.85 seconds
GitLint                       PASS      0.42 seconds
BuildEll                      PASS      20.23 seconds
BluezMake                     PASS      638.35 seconds
MakeCheck                     PASS      0.99 seconds
MakeDistcheck                 PASS      245.83 seconds
CheckValgrind                 PASS      222.44 seconds
CheckSmatch                   PASS      348.84 seconds
bluezmakeextell               PASS      181.26 seconds
IncrementalBuild              PASS      640.76 seconds
ScanBuild                     PASS      1012.70 seconds



https://github.com/bluez/bluez/pull/2079

---
Regards,
Linux Bluetooth


--===============0417062237690833518==--
