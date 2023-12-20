Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE6D21362
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Dec 2023 11:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnGXoWpO"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-67ef18444ecso40130536d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Dec 2023 03:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703071802; x=1703676602; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CQ4O38TD32Vk3G7+yi34VVOG0SIPADjezNCU+w5YG7k=;
        b=BnGXoWpOmIb1VSVTKfRCYXNeOW2x7HOBKcGX0Bk435nmN4Slx44qNxPYD3xn7jq3y5
         ELPwxhLHTOsNvXvFI3aVr961DxvzFYu9xl1fc8lGDGDK7sO4swltD2Bp0R0YkmVfeDJG
         eXxwnA9YPI7rC4yF6hBFnNu/QM+dxLbN+HAG0a8Gu3UQ9Vik0EMYY7gbgj2HUtb/di9b
         dwb2pZLM/Xex0nGKP9XZoCjAdNg9Bx4vBXPSHoGfceaS03HL3cAY/ALT2cxUQABjeRG3
         RkxMwUjvMPMIw9f63iUjknGe9VdyXbqPsk/ldEQD+qQ8TnhdNYB5udLqgWTvN0+XyOzf
         A3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703071802; x=1703676602;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CQ4O38TD32Vk3G7+yi34VVOG0SIPADjezNCU+w5YG7k=;
        b=MQUJYvqpVSVjYB92QuXVEdvPkHqqK7EGVVf7hZpRn4ZROuMKyEWJt8ehlsQiLI6ug6
         oV248U8VyUeTmtoWkfW3s5CgjTyRo/0fD5GTdU5lO62LUP/XxzKpmqBUZcZvXAVcyBzq
         sYMEWKeT7WmiOvzWXBPfhn71kKluuCI9jWEwxlEoSn2h4sgdx1+IoG6iKkpTlDbkO3L2
         Z8BgdeJJ71etud4nj1qQUOVJkUCyRShRdCe3Cuduw2wNHZjhQYK1A/dN2stsu53qDmHq
         rqulPfAnOLcOUqOXLx44zegtgiceactJOEes+56RW6mF/P1jiW43ZGiZjJf+ZGQXuQce
         pQmA==
X-Gm-Message-State: AOJu0Yw8TOHbH0HBPz4Ba6C9lBiCF5s1OPUheeyYvuM2iqOhq2pRtSjX
	MFM+c6ft/vfM1/bhjEmbokdvBNWaEXg=
X-Google-Smtp-Source: AGHT+IHh5t6WmAF+pwcZyLr2Hmzc5jk/mCPiMYDV1HmnTr3+mSOAU010dQgnZloMnlnCJed8fj5/Fg==
X-Received: by 2002:a05:6214:4389:b0:67e:f56c:b6c0 with SMTP id oh9-20020a056214438900b0067ef56cb6c0mr17330008qvb.60.1703071802371;
        Wed, 20 Dec 2023 03:30:02 -0800 (PST)
Received: from [172.17.0.2] ([74.249.5.110])
        by smtp.gmail.com with ESMTPSA id lf4-20020a0562142cc400b0067f7676699fsm93550qvb.125.2023.12.20.03.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 03:30:02 -0800 (PST)
Message-ID: <6582d03a.050a0220.14f2c.03c2@mx.google.com>
Date: Wed, 20 Dec 2023 03:30:02 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2462663272841675900=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vlad.pruteanu@nxp.com
Subject: RE: client/player: Allow the user to control BIG encryption
In-Reply-To: <20231220102119.74090-2-vlad.pruteanu@nxp.com>
References: <20231220102119.74090-2-vlad.pruteanu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2462663272841675900==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=811757

---Test result---

Test Summary:
CheckPatch                    PASS      0.53 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      24.26 seconds
BluezMake                     PASS      733.48 seconds
MakeCheck                     PASS      12.25 seconds
MakeDistcheck                 PASS      162.01 seconds
CheckValgrind                 PASS      225.43 seconds
CheckSmatch                   PASS      331.18 seconds
bluezmakeextell               PASS      106.57 seconds
IncrementalBuild              PASS      673.82 seconds
ScanBuild                     PASS      934.84 seconds



---
Regards,
Linux Bluetooth


--===============2462663272841675900==--
