Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230DC1C1F08
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Feb 2025 20:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739995640; cv=none; b=h7xBiDVV7kp5UQb45fl8iGb2LkpJzzZ/vQ6Uws6tqkF0q1UXH/fBme5vAnw01zTAMgUOxfTkTAfUhTrQsQ1MMkeAwq7oDZUU6G74vkcCFvGUycFUYPdgizG8rO05xMQPjd0GnJ04uauYBaxcXGImg0BOk6hrg9POH+hXfzw6N5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739995640; c=relaxed/simple;
	bh=l5a6Fd6Y598CUwa0yY96WZf8nbt8hg7zn2ENap78xac=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=soijP+9dffhO7zd7fvyoy639UbuBqXaQg0V4c4Pe80lHcPWcFvpscKyvxyIF10li239u+08jjrdakDI6RYeRUX+vZHl5cauvf2lJZWRm0yze/aokmFkFucPd9WEwO3I3o+rTKSbGiPUVWDcLZFYpZKXE+eoRCgDVpkEr5UkVHxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecPwDy8b; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecPwDy8b"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e45dbf15c7so1001546d6.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Feb 2025 12:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739995638; x=1740600438; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PgM9JPsp0VgRnQQ1BtHvK/cHGbHFbvbTunAlnpP357M=;
        b=ecPwDy8bSMlZ2pFGlVy0UHMHAqw6UGD/FBGyOIL4KgiyeFy9lctrUxd+BFXTPrYQm5
         hsaMihzOTyWIbbiAqbo5rO9holN17VynKN6UcrVIVzZTGLDc0PSiL8Twjah+sTrX+fwH
         UWbwSEAc7SS+G4V1cuAtEfDP4N2DmvwmqbadZAO76W4wSuwUEequwHCCxlNAWJqomTS/
         EskVoq78Yrsg8lpd/jG/tEsA5LfvpnunOn0NyVNm0mA2osytzu07wRVSOIz96NB32sEQ
         UosPfNg4JPzfZpB6vUEcE4Nh4z2r6Y6vVOgVKBx5NRs9GN+UIFmRmlPHaAGQPGQ4NXva
         0RLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739995638; x=1740600438;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PgM9JPsp0VgRnQQ1BtHvK/cHGbHFbvbTunAlnpP357M=;
        b=CtZ0wm2mvlJevvUvwx3lTSH82xLpRsNA2g5+EkZXzKBUp27s7TdPz4IfekuVqRQH29
         8njy9yB63cn91YLeW7UWw9NqQ3lzB9l35Au6AC4gZ6mQs8oxRtyfVwbVV3CBDdx07kwt
         lEV1co8vcmgrYxm2CUIuLl2t17Of+2hd7gPXCs30M5zwAiP5OUdrq+5YQDedQex9sTFL
         e9+6ODvhgu4EqBBpUVxuHR2Pb4fsjfAFdG5LhZ5Imw88G0Rc2O6sMagP7MjB9csE8G6k
         OQ4IWpLbpyMbCy6yQMTl6Uu21T07AHNXRfVX9OesaDBn7fLv0x7iFErafKZbJ38h5Ojr
         KTJw==
X-Gm-Message-State: AOJu0Yy8c3c0pQtVMmcgSH4/Vl2ITZepILwkCp91FzpDleCggB24rTbH
	QCCHRY+q3zfo2zRp8e7bf6ejYn0tCROnhcG+pgy+e336qoCNRdRvngqtEw==
X-Gm-Gg: ASbGnctbURdhDaXRrVi4OcYHFeEHezFxvO1Qd3KXAsYn8k88he9D/NjSTdNU7XpyYEU
	VZqyZHFBX4dOQR8FEJ53rKLe7JnqnNnLrFttXD2KTugNbuXQ6+iHIAO1TdsG+TqmNrBRIst6tQO
	6H6Z5HQ4k5OC1V5Odv9XPmq+usCDRUT6b+AjLhaaTepLE4OUHoddlcQ2jk+5b8PpVdzfNhvvBNi
	ngM0CWXJTWl0nZqEeWI2sJKdUiEnMmmbGK5foSaqo21mWVJtM90Hjj6RfyiS4xZgLPKm7neTA1H
	vTvRnHIjHKqRXOU5nuUV
X-Google-Smtp-Source: AGHT+IGItiXb2qbpyAMuBZC4CowoQGKTBu0x2+uTz+rh0ugfYkLepFRE/dr4Qeh+ydHd8gKI26AoYA==
X-Received: by 2002:ad4:5fcd:0:b0:6e4:2872:45f5 with SMTP id 6a1803df08f44-6e66ccd4ee1mr283385516d6.25.1739995637740;
        Wed, 19 Feb 2025 12:07:17 -0800 (PST)
Received: from [172.17.0.2] ([20.161.63.48])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471f52e39c7sm32456641cf.3.2025.02.19.12.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 12:07:17 -0800 (PST)
Message-ID: <67b639f5.c80a0220.2a8fc7.0a25@mx.google.com>
Date: Wed, 19 Feb 2025 12:07:17 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6326786236362398386=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_amisjain@quicinc.com
Subject: RE: [v1] obex: Add messages_get_message() implementation for MAP plugin
In-Reply-To: <20250219184758.115316-1-quic_amisjain@quicinc.com>
References: <20250219184758.115316-1-quic_amisjain@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6326786236362398386==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=935687

---Test result---

Test Summary:
CheckPatch                    PENDING   0.20 seconds
GitLint                       PENDING   0.22 seconds
BuildEll                      PASS      21.01 seconds
BluezMake                     PASS      1519.07 seconds
MakeCheck                     PASS      13.08 seconds
MakeDistcheck                 PASS      159.74 seconds
CheckValgrind                 PASS      218.23 seconds
CheckSmatch                   PASS      287.86 seconds
bluezmakeextell               PASS      100.10 seconds
IncrementalBuild              PENDING   0.28 seconds
ScanBuild                     PASS      868.75 seconds

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


--===============6326786236362398386==--
