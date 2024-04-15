Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA165FBB2
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 11:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713181072; cv=none; b=cg/lHfdSX0ZW6odEmHp5vk/CBJOViB2ZT66nyzbuxcjVkVF1pPJz6EUBfodbHvkxXczsh5Dwfv12HXCU8oZM0PAolK6oct+L0A4UFXiU5mmk2zhgOr3LUHRTZG/LFymI9D4Op+XkbiT7jd9jwNDuR55GRHwWnUrAUW7fS8Lwy38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713181072; c=relaxed/simple;
	bh=jeE5pHmzpnW13ura6n6yNGzp0QzgncKmWdPKsjsee84=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tZ4o0SY6YZSfzEWsL/kSjkdi4z4CVgzp1bdsV1W+ip4+kBpTd6pvvM0FqjNLtDQIJZl3yV2DYxVH+ZYZpEFrWto+it3BWskThmumVpnMP2tJ1odWpnQeINvUCXQJ86GCetKBs53al2tJCyVXevk0cKGvo81v+Jx4UGZdgmZJhNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9m1RQxl; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9m1RQxl"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-617d25b2bc4so34631267b3.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 04:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713181070; x=1713785870; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QqJJ51diYZHxadqQM+hnlTVVgdEsj45t8lBFmKWpdxg=;
        b=L9m1RQxlTwNfVkSP0gMZPRjxsRv3LYCVQCfsOoDO2gILoIi8Ya+sRsGKBd4c3em0Vc
         qa6BIVKf/GL4xmqkJD65ws/kGIbq9v4phLkvKYE4vEU6F7ekjAHVliZpHw8GmczLIdVR
         BwkcxLMXh1Pjtl8k55QTFrpPEJ9CtyIthjn+az6rrBPm/Vl+xY36HG+hCLmKE1NiK8fM
         AY5jHdq8CKMT+sS9fopF9VcGS8LHDx5+hLOo0zEIYNHvksMPcEDuLttVyIKgZ/21vfy1
         N6F3XaiBjirntqxAZ5nExvQ7AnivwBZ/J3kKEeEOBEombdEW2Moa5zE+vX/0CYKrmEE7
         EpUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713181070; x=1713785870;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QqJJ51diYZHxadqQM+hnlTVVgdEsj45t8lBFmKWpdxg=;
        b=fVov274V7nSBbJ9AQVmb//nbkzWrqyPjiI3PpvFB5F6gCUrWc+LhSW5hQ1JKouPjCx
         kCc1a4m0ObQrGa1a2SnA4YG8aQpq2DVXiT0C63C8ogpptsn5o5u7HOZzk9jsi2OgJwgw
         lDSowDANyKJvdNwddul0NzF42K3Vw+25Tyx1jovwxNIMmtMkHTQ1mD6PLnHNC8kSNvvP
         psU6PkVEUYn4VbHmdtWuLI3sbgxCJfSnR601I1PHFavfgbKuMP9Ng4wi3SmCvbreO8dn
         I23DCisdo6nZDqTsDRcWJaGIxXPK1/Kz2RCFDhOuzxCotL8ReORlExuvm/6xm81RUiKt
         oUMQ==
X-Gm-Message-State: AOJu0YyZ92RIUvOExVB3p26Gi1WfUcUz+4vMbsZPUHiMSt/56URosk2t
	g0JklxLCMrSS6ZnRexcYxUFkWaK7Gw5Ay1OU07Jsgcim2izytcD4oBB7bQ==
X-Google-Smtp-Source: AGHT+IH9GL4DSTYacbk/fIarQSc4AFvWyu1bGib6pJQyChrtLFBMzIdDhiZJzgR/KPyW0pTJ9ePY1w==
X-Received: by 2002:a81:848b:0:b0:618:1ce6:b618 with SMTP id u133-20020a81848b000000b006181ce6b618mr9203597ywf.12.1713181070045;
        Mon, 15 Apr 2024 04:37:50 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.82.201])
        by smtp.gmail.com with ESMTPSA id r3-20020a0dec43000000b0061893269739sm1148258ywn.31.2024.04.15.04.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 04:37:49 -0700 (PDT)
Message-ID: <661d118d.0d0a0220.9430e.531a@mx.google.com>
Date: Mon, 15 Apr 2024 04:37:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7747965040195525268=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jpalus@fastmail.com
Subject: RE: [BlueZ] build: list new tools/tester.h header in sources
In-Reply-To: <20240415094440.5820-1-jpalus@fastmail.com>
References: <20240415094440.5820-1-jpalus@fastmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7747965040195525268==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=844541

---Test result---

Test Summary:
CheckPatch                    PASS      0.45 seconds
GitLint                       PASS      0.30 seconds
BuildEll                      PASS      24.28 seconds
BluezMake                     PASS      1673.78 seconds
MakeCheck                     PASS      25.25 seconds
MakeDistcheck                 PASS      177.30 seconds
CheckValgrind                 PASS      247.45 seconds
CheckSmatch                   PASS      349.47 seconds
bluezmakeextell               PASS      119.19 seconds
IncrementalBuild              PASS      1418.20 seconds
ScanBuild                     PASS      996.73 seconds



---
Regards,
Linux Bluetooth


--===============7747965040195525268==--
