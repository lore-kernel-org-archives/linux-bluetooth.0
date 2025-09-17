Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16DD8F58
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Sep 2025 00:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758068977; cv=none; b=q0KnTCjRd/Bi+HbaNIV8VGIaubaE9+pv3HCB41idjeqbMSRV0IgfSIj2uGtWqZf7n0LXUiodxZ8MqpvEMfZMbMVp74cqfitVwN97quFHz6EBDXLk3thNmHGH6TUbuTzxJPbKQkr9EEMCY0PdBlnN4LTtITachmEW2qsJy07eNTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758068977; c=relaxed/simple;
	bh=5zw3ifZH3Vt7i1v8P/CycVMJ5zk+LKnEg1Ipr23sVqY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=E96QCsQnME0T72tyPYm7KK6d/z2FUE7/be2QySl9W96WpfxZcmBI8VXwFpHoVvyoLAJ9wtkQZQ0rLfl5l8GlxHSRK0D0gVVSVLwdP27WU0pA82QatZEQ/dXfoTRHdQ2x89ukJRvrFmZhpxtpn9XGOtcIf4hF8RwVa6R/Y8qgDyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hiq7vCay; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiq7vCay"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-8877b60f7a5so203285539f.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Sep 2025 17:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758068975; x=1758673775; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xWzrs+kQccthOYtaAimC8rr3YT0vKVLTreC2tcJwbks=;
        b=hiq7vCayqu/wDCChcEiMn6BP99UTnZ+5rWw7vPsxSPN+NxqB1h5fS5AcY6piBls2/1
         l1VvOZT+9cR7P5IZGFIyIJYdQqgwMUWO2N/yihrV0W3W8ZTDnY/ZY54taBgecxTMy91p
         /4oWzWNDvP9BwRpgztMdIUAijj12xJBXI9/VwOj0rBl67cgu9w387LQCAvLhuLk+R/21
         l98e9ZiZ4w7cXEPvKQlnFcF0MNxjEEQBf3Tc11R8sF4x3ccqrrAWM/sm2GPGid6oc/tA
         xWpl3QiL8nI41cC7l5Sr36MwUCrGjxY9OT1LQhiUybOld6x5hEU8ifatQ2DrrGBqgJFE
         fuMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758068975; x=1758673775;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xWzrs+kQccthOYtaAimC8rr3YT0vKVLTreC2tcJwbks=;
        b=avrK0ePdcc7SIHFmNKZ2eOCXKfmPr//elT17y0mj99V1V7flAfsQYMHB+0iTqnOb39
         /dUnG7iRLrCvbcbMxYrmkvtv3VKYReTG6/dqeGI057JvNiWctlPXnvzVTn8r4dbu2Wvn
         sZTA8xfKK7D6BQwPb5SVca964Kfyy4pAY4dw41qsFb06SLnQbapvWGeRNzCQ8tuH2O7j
         yRMN8ebXM5oVBT0o4uu8zP4kcGpHDmWhP2mP/Fri40bh6gS4buYxXAqEW+jS/ZkjEh2M
         zgMNu70ZisoJiEMlT68FgKtN/PQo3ahw+psMQd04fTuJ0LP3+lQP1xT2ZJY2zgNvBEBQ
         cJWg==
X-Gm-Message-State: AOJu0Yxdhc3a9k7BJ4UJ7DXc73/9ODwhgRZa3Awd0TkMRF3tFA48nFx7
	vOAkQXO4fhwIpAvl8cMyPQTjeF0H9/sOgCCmUbpVuyTzb19Up4mpu0xRfOWXeA==
X-Gm-Gg: ASbGncueVIpjJURCW4Q1Lhj5rDCyr8LZyooDs68NDfAI59eYVOJbSrHJiwmsh4Cgztx
	3/d4wx3l1pTjUGtDGyauatpCl6ZqctJ16OyLYCTIOJ7VhN3OG8Ra+LFfNdmFnC89Un6dXEmF5jQ
	GqmQSXdv5REo5SqLpzf3kogq8qm5d+t/KJyg+3ZMR0/0LcCNmQoEQQU5BzzqHAlcr1M6KGj27WK
	lkw3EJt0xBylxNNi/DVCpxb1GMlFeVsx5h0pJKK/P88ugWaH13SfoZuc95V3cGsnW4+ky9YchaS
	Ur3Ycr9M0kyGK6alMeT62HQG6ilFszeAcfm5ROzpTOiioNe+9vK5xi9Tm+Hr7G9PGmyE38FRAhW
	SivUpSsfZqzeGK3ZomrEX3IoVI2/B
X-Google-Smtp-Source: AGHT+IFhpsnNCcAqRcePPB//4TyqOFinTWqgKsM+pafcak4FTdD7uO1hhJb3cy9A7+GT4AZBqTZqoQ==
X-Received: by 2002:a05:6e02:1aa3:b0:40b:db4:839b with SMTP id e9e14a558f8ab-4241a4b9a0bmr3122915ab.5.1758068974457;
        Tue, 16 Sep 2025 17:29:34 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.160.16])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5120ef21180sm4488520173.55.2025.09.16.17.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 17:29:33 -0700 (PDT)
Message-ID: <68ca00ed.050a0220.28a04b.5b45@mx.google.com>
Date: Tue, 16 Sep 2025 17:29:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6765143587056299529=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ] transport: Fix build with VCP support disabled
In-Reply-To: <20250916230017.2216629-1-hadess@hadess.net>
References: <20250916230017.2216629-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6765143587056299529==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1003112

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.31 seconds
BuildEll                      PASS      20.09 seconds
BluezMake                     PASS      2604.18 seconds
MakeCheck                     PASS      20.57 seconds
MakeDistcheck                 PASS      187.46 seconds
CheckValgrind                 PASS      239.57 seconds
CheckSmatch                   PASS      309.80 seconds
bluezmakeextell               PASS      129.70 seconds
IncrementalBuild              PENDING   0.36 seconds
ScanBuild                     PASS      908.08 seconds

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


--===============6765143587056299529==--
