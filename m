Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F71B745C6
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Feb 2024 16:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707494803; cv=none; b=YGwVq+7rvP8mrQrgEH5ndX8lLU5uzimXZAHfGGHo6zviCew7zSLfUiGxZS2zRsbcs8nkTRD6291njIKxEhiXmJQwB/4Hqt2Tb4WRTIwCkjr/vCuFralsHOfWbq51wHCiI2F6HzBw8c+xuyezNM4BaiiPN8t2grmrcs6VZd8nFq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707494803; c=relaxed/simple;
	bh=xHOjNfrlZ4DyHwH47YCR9y8w7Kb6UwCr8q6TvclwR2w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XKje1CDzcu/kSVjL2arjPFdLc8O7ucBTH18V/+CY+ZdMcztBeQXo34aUaaRbfWN3QDFxLlaDGkBpDANhGhdZA/rUq5rCReemryCACfYsWbZpTOq/irHiTqklOmVif0BxNk8YpZXb6TlILfGakYAR86fCcRMsz6uDT6RVol1+5IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLUud2vo; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLUud2vo"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-42a8b99eaf9so6863981cf.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Feb 2024 08:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707494801; x=1708099601; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DI5oD4soR/37UlXWSkejzbi/fNCwk9EyI5NtOwN98cA=;
        b=NLUud2voluZhElcocSfoRYiTIFb5ZvufgdyXWdPOK6b7rwkfiMG9RWgJ48sDp0+Vis
         sQurMfidudP2SkUf4Rl16BYton8kxcimjpD+JMJmgM+/zvxURlY7Gu3tx97DiHQ955hX
         Uo+/75AXIpQuzZ++JOhvm1mfFofxEGy1Bz6iWuotUyp6lqJPmiqLL4O8IX+7C40ML/f0
         siyQK2njPeCb9zhr6fzYFkcV1LW1MNhb0cUu3YgMGALAMhcLZOGwmq8Jt7stFQmH2YYS
         usdeggINCNCHjDE50PKVtwezKAuiV31VuA2ZxESR8aUUCNJ/KD36l7i0mm+JgJzSa4EG
         v2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707494801; x=1708099601;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DI5oD4soR/37UlXWSkejzbi/fNCwk9EyI5NtOwN98cA=;
        b=HRfH1OusF4A05+BYG3z4w4A2uIuj6Qks+Ph6DKqwLwMBkOVkqquxW59AsNH0aBDtcG
         AODmGZlxteVlBWQeUB3RVIeIOjewySY3DRsxf02fPj3ebvCy4kbNpnBwIJTLT1yRYHkr
         qW8kycJFIP9g6okV4dghYN8JyqciznElLe9QqyKXYcBL8iERATlTfqszKZwFzI59S4y6
         nYa/jOQK4tBCnwGlFtyZcMJwc4YE+HHJ0jpJfGDr6djb7EZaV3DeO9mx8GNkPI13VX5b
         3Li02p1nUDi2+Xf8G9RtiGoXaKL3ZhctQa7BFP+JtsHN/o1I6zHWfEhLmNUR2ueTwwJT
         Im3A==
X-Gm-Message-State: AOJu0Ywcfg2X8Cr4dn6U4dkOBPIOZ5kfaAkX929W0HHjGY5W1HzDDynV
	s32nm4sbqezOf+utWWGyQ5sC+3LV1HAVLw/82IWDqworl07wMBc0+APJO/hr
X-Google-Smtp-Source: AGHT+IG4Htg24+7/KjmdKwx3qjuJYIPTAOrlmQqov+Rxc7YmK1uf02LA/TIe7+pG1mKKD/VqR9J3MA==
X-Received: by 2002:a05:622a:ce:b0:42c:615d:3c61 with SMTP id p14-20020a05622a00ce00b0042c615d3c61mr771156qtw.11.1707494801026;
        Fri, 09 Feb 2024 08:06:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVpvUi3oupCwP30maFyRpvKLkqm1A4R6BsD+SzeMuogIMjkZF4bWEQBcfBM5MwUO4vNhSeOHzy2r6TLH11N9f7X5zF4Bg==
Received: from [172.17.0.2] ([172.183.91.55])
        by smtp.gmail.com with ESMTPSA id h19-20020ac846d3000000b0042c5adc6016sm599181qto.4.2024.02.09.08.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 08:06:40 -0800 (PST)
Message-ID: <65c64d90.c80a0220.d90e8.3a64@mx.google.com>
Date: Fri, 09 Feb 2024 08:06:40 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9206955732530319031=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] hog-lib: Don't destroy UHID device on detach
In-Reply-To: <20240209145917.3583663-1-luiz.dentz@gmail.com>
References: <20240209145917.3583663-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9206955732530319031==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=824683

---Test result---

Test Summary:
CheckPatch                    PASS      0.40 seconds
GitLint                       PASS      0.27 seconds
BuildEll                      PASS      24.10 seconds
BluezMake                     PASS      719.49 seconds
MakeCheck                     PASS      11.81 seconds
MakeDistcheck                 PASS      163.75 seconds
CheckValgrind                 PASS      226.53 seconds
CheckSmatch                   PASS      326.81 seconds
bluezmakeextell               PASS      107.07 seconds
IncrementalBuild              PASS      673.84 seconds
ScanBuild                     PASS      944.04 seconds



---
Regards,
Linux Bluetooth


--===============9206955732530319031==--
