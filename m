Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CFD4207F
	for <linux-bluetooth@vger.kernel.org>; Sat,  4 Oct 2025 11:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759577469; cv=none; b=Uld+TLwEXrWl/AQuHrPFkoLdo6lonkqwdkECDSjMaebzwvsfn9hL6algnwzy1ymf9lkwc6tt6Vwt0uDCnYK3naAK8kcxDuPIgaRB4QMxoBSGwYnSj0i+9dbSBMKT3T6d7npQUevNREAKArCudMsVRLgt2wtPjw3L3WDYTPTbaug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759577469; c=relaxed/simple;
	bh=H8Amr1pw361NYG32/WoPrsrKPrwEqqDi71QT2TyhwKA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Mr1H1/SW5aEA+Jd5cPZeAChnhSHZgjCETTBhgEZHZ4S8vGj5X/Se/Vh9+SuJKtckkex93QX/78swedOW2eGVXeeRoYH0qSd+qunZHShK7jpdO7JHQmt8A3Q7vNbB7eG8Ii1t1pm9vGrE/Os56k//poiIxhSjFHLxE7/VFz/64q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=msDYKJNr; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msDYKJNr"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-32eb76b9039so4314131a91.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 04 Oct 2025 04:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759577464; x=1760182264; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Sr9/Oxr2hb2wogy0TCiIXMf1J7fvOHyApy3p6ujHMH4=;
        b=msDYKJNr/Ii76fvXYnWW29XghhjdThsLb/lw0OK59NCW+7Xr1/PQkbgfaA9/od6geg
         UtXKX1qMdL41q1tqArWfVRolw5JoAZrM8kTRQhJaPsFIEX2/WAwBVpbMxPAA+8t0TSoe
         sr+htgv3X1ZMvMfXxCNXH0KSu+HFAEDL2gSmQM9wqbR9W2qEEmJclNmqKDSM0xNrkD/3
         hmnvBFm1pByrPicWWj85qOX6CS24Qty3ZTgNwrZoMO4Sk6Nki+b5C4N7El9BmgWQewR/
         iSVLZFhj18hHU3uAWaKXQ33sZWT4+Kgo2SQhNoSpGeVZbke48tE522YVWpPQZjej5E2w
         sRMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759577464; x=1760182264;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sr9/Oxr2hb2wogy0TCiIXMf1J7fvOHyApy3p6ujHMH4=;
        b=qWr3wseLOWZ32+n9VPfByts0hykNG4sBXmIANq2rqybCiNvkMYsTtx5//hRO3cc6Bl
         Tc7bP5+n+dd5bkD1O4NHpjGZakAV2MsBx+cu+Yd31UQTmkqTbaYNunEYkHV5yiBulhdp
         uC+BJVltvRU1BW4KTmH7iDzJCeUtWpGLRNSoEEcbhsEDuEDY5Cw9Za1vK9AZfx416uVV
         sQ+Q25CPDcoR+TCVNQUH9jfPP/Joa285z91d3PstbIqrlQUuAHpjAgYsenLl2H0KENvw
         JrKTaY6YiAbMQcxjTxzrexrNtgy43MLxhhq5tnkx87s+T/I1Srd5vy/J+eSVuTIMmHh2
         MoWw==
X-Gm-Message-State: AOJu0YytxV44G4jcPFKVAtqdq596ABd+PLHjmtCNCGfUuObJezWwx8XO
	VfbQBZz03kUv0oGBcQURs316KsYqKPAl+2SDqryaR3s/es6oqtK/455eH0PhfA==
X-Gm-Gg: ASbGnctzrVMiJ2FeSZno6FkuJ9bQy/ykpG61/lXVHBT1jtwV27MkE9OaIFmZtwLZCju
	HiHUhBhFVg24qH5mKzUy2+d6m8Y9mMl5MwVlYmA92rWbxhjWKV7WLZZFcdg9+sNvPWNn0YCdP8Y
	V2um1AsmIFtIUW8Y+3Cl8P35XzkhtiqyrTgS/KYGNsB+PDncMex909klUJ5tjSuO6Pby/SAH/uw
	qDYT3qhpfe2KoWTB0iAw/IT6T9PFJdWSwgaT/XdfC9sd+lpPUo1xi1uPTCsWoGJqsb+xabUkCch
	ehMMAiks/HOkJvBsAr/9cOHpUiShMvPDDbSH1xY5lpy316M6cjVrOqmdsh3znH45xds3tCzYPYB
	Ez/1mb5ULqZdf5LVjX3xtJAdx3Qy85CKAZWKJLBMI9oxY8DnMZny1ARhi9QvxlRCN
X-Google-Smtp-Source: AGHT+IFTqQC5GXCL1DkY9zjSACwDxfBGAm3btPgYSYzv8kEfDv1F6zrPHfl8oGFsRTJUUh1FOLhwSA==
X-Received: by 2002:a17:90b:3b86:b0:32b:8b8d:c2d1 with SMTP id 98e67ed59e1d1-339c27a56e4mr7428368a91.21.1759577463976;
        Sat, 04 Oct 2025 04:31:03 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.226.68])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6ebd74dsm10722375a91.8.2025.10.04.04.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Oct 2025 04:31:03 -0700 (PDT)
Message-ID: <68e10577.170a0220.34eeba.6d29@mx.google.com>
Date: Sat, 04 Oct 2025 04:31:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2928346888060915990=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] transport: always show A2DP Delay property as sink if DelayReporting
In-Reply-To: <daaa156e4ff99ddd24eb5f14fe4c6940e8fa8527.1759572113.git.pav@iki.fi>
References: <daaa156e4ff99ddd24eb5f14fe4c6940e8fa8527.1759572113.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2928346888060915990==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1008427

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.34 seconds
BuildEll                      PASS      19.90 seconds
BluezMake                     PASS      2556.94 seconds
MakeCheck                     PASS      20.37 seconds
MakeDistcheck                 PASS      184.16 seconds
CheckValgrind                 PASS      234.53 seconds
CheckSmatch                   PASS      306.07 seconds
bluezmakeextell               PASS      127.76 seconds
IncrementalBuild              PENDING   0.27 seconds
ScanBuild                     PASS      907.62 seconds

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


--===============2928346888060915990==--
