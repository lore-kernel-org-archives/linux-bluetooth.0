Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B61194140
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jun 2024 09:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718617471; cv=none; b=flrEGnXCQNgjreyjKcuQLUuOFfon/tzT7/ssLHnofz9GjX1eqOyiIi2GJOiE8N+V23Ya8cEDq2naXlYtoDD2MPLS5Qzl0SIAWnqTm3pSLQp/vuhUOXX173SKrbLIWgaHDs3eckW1hPMIWbmNl0+eXhnQ1n+0EtBut7xcIn/5tx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718617471; c=relaxed/simple;
	bh=JLz1OXT6T0Iu+tnS+1MK287HmLwRktZeA3aCwzvK2Ys=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OS3YtAQK1nQbtLRlPpnGBtE6XJR8tlrmFvbkIRoAUp7x091i17dmAMNB0G+RmdULMrOHLJJ+spZPZnCPZDv4gIzAAA+deKnqguUHzWzd+ceUuP0rO5hycyMRTkEUx0yoUynY+0e+gKxktgEgTm7NArrl/kWPGdo659S0v5RN+rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWBju+pr; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWBju+pr"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-6c5bcb8e8edso3403156a12.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jun 2024 02:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718617469; x=1719222269; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Lq+8KIlauwNgyuO4atr58ov9/CclejR2qZE0Q7FFKqA=;
        b=EWBju+prpwDj+l8g+AztikL93q0Nyj5vhZ/zUYD7Z0UAQaPS7sX7bYkg33w/riWJWX
         J6k4QImwFx8HmXAu8bvcNbJzRlSlpBe232uCay5Mnh1LPqu0GzA0IYu/25k05td5srUs
         rhBnGvcREf0xOr8dQQ0m6ZSBysD4H+XtU+cAbx0Z1ZQLEQ/1/hAV19kUi0qJPeJVekhW
         enjKrwIEu3abAn8kh4leDyiz01KX1Sb8uvD2Kubsq5HQpDMflWp71MzFKd5ELrdAJ0Bq
         zuZ/KkiNtkj0zxJuihc8QOKch25RJuRXlzWrFsLO83npKgbmiaXgxGiwBtQwHOctGIgU
         L6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718617469; x=1719222269;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lq+8KIlauwNgyuO4atr58ov9/CclejR2qZE0Q7FFKqA=;
        b=pRYpiPGeuOzXu380cIUguEMIhhbNe4bEck+3DyFtGuHBQeI9jDxX8TCwUd2bHIIgna
         1cvWD3W+1PNsvfaWxycVqk4uTrmmZwTXUebhwU4wPQ4VqBJTlvYI34/bVDxxHa+JOrLC
         afVZSW9FsUAEs77kTQBc7TtGS3Ct/VvU/+yC2T3xw6rWYpP5I8+2U3bnMxHKNnh11SUx
         UfGfZvh27b+ya5AbYANajrRJ6Y4iP9wF539mti6Tgb1i0HdJu47/4c82OEQBeR8XVyaT
         z/wD361xIGGJyLuE5teCrAJC2bpS99oAs7kMxi7ObwOpWZmRupsZrlGd3VRhqZQnsgLF
         5F6A==
X-Gm-Message-State: AOJu0Yxv9RT580afQwT9bXquwcUENKU7e2DuaP6P7y3YFrxLI4wVBtkf
	Fxwb1fLlgbDYEy4NGkGc6cMQI2Uf3TVXH/L6hI9+njf6X+bjAfCeYfBAzw==
X-Google-Smtp-Source: AGHT+IFC6vJ+gHA5HsK6ed7JNLb3g7x7MG4jX2MIleQrwbNfRgFpcwd5aEBvKfMXro5MHxS4FuAYtQ==
X-Received: by 2002:a17:903:18a:b0:1f6:4ba6:74ad with SMTP id d9443c01a7336-1f862b260ebmr108525765ad.58.1718617469286;
        Mon, 17 Jun 2024 02:44:29 -0700 (PDT)
Received: from [172.17.0.2] ([52.238.27.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f86e1d82aesm50483305ad.253.2024.06.17.02.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 02:44:29 -0700 (PDT)
Message-ID: <6670057d.170a0220.6a722.cb87@mx.google.com>
Date: Mon, 17 Jun 2024 02:44:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9100593427876900444=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vlad.pruteanu@nxp.com
Subject: RE: src/adapter: Check if device is connected before clean up
In-Reply-To: <20240617075934.154540-2-vlad.pruteanu@nxp.com>
References: <20240617075934.154540-2-vlad.pruteanu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9100593427876900444==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=862501

---Test result---

Test Summary:
CheckPatch                    PASS      0.27 seconds
GitLint                       PASS      0.20 seconds
BuildEll                      PASS      24.35 seconds
BluezMake                     PASS      1735.49 seconds
MakeCheck                     PASS      12.98 seconds
MakeDistcheck                 PASS      184.47 seconds
CheckValgrind                 PASS      250.09 seconds
CheckSmatch                   PASS      351.15 seconds
bluezmakeextell               PASS      118.87 seconds
IncrementalBuild              PASS      1436.67 seconds
ScanBuild                     PASS      975.58 seconds



---
Regards,
Linux Bluetooth


--===============9100593427876900444==--
