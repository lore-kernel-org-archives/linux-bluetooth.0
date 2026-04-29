Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FF33B961D
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 16:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777481032; cv=none; b=tDuW3lB6ouRBcYewAEw4uy1hyPKEV0tQeoIu+DHPORI9ZbPJ2cBW4lxibv4EeOy6qMQTCvU26IIonmDbTPWeO8dRjyteh/i95LUAc9qc4m+T6i1pH097wxwvzVkCT4TZVzLfOdYOIrDIQuhNQCne1Wi7t2BPmmgsrc47M+VnWGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777481032; c=relaxed/simple;
	bh=UDZVV0zuD3kfXVIsnKUOhotf5rf3DCqScm1FSZYXNgs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GmPrdehZ2awLIrsVyKUgmY17X9YIkqy2gc02zu3gh40mH1H2Na5DiF5JzO3y4JHX4y0YqIBbeXuDR9NftN3wFbJjF6/dk1Ibb8KAMcc2/ma6lTTySSljc703RdZQoqtltGxj9a3Y3YFMc4Jb7/6v/8QQ6seGCHlT3NsuW/o7SBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvVcR8T0; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvVcR8T0"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50faf8ed9c5so55253021cf.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 09:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777481030; x=1778085830; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QkLjcq+o26rw/QDQVDB4nYBIfaLNPWgTozM/GdOy7V4=;
        b=hvVcR8T0FeuHu3oAK82iR9cVW7O32CyQ9ABRDmUIrntSnbM8/LZ1fNU1ehjaWXJ0SF
         Qxdudk50u/mOacsrim/sIrEtX6dRfEDf7ZZZDobzJmWzYQqp9pT4qeJ5kw2l1Bu+Bjdk
         0qYBHgLD7Ube/ZXtUhXYy05XO7AJFKY950cwe2KDjwMoAewzPVSvIvG7PB646B7BWone
         tZYvzQ6Ts7CSwsoGJVTv6Y16t51cYs+yEaRZxZ63A5Gg1C6j7fbToEbCp5k1+xvmifdM
         2UhOR6eVrMLEJk5z0I6gTaUkzVQxCJ1GupnbDfp36x74SdgTsFiVW5bhlv2g5tv0rMkW
         gZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777481030; x=1778085830;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QkLjcq+o26rw/QDQVDB4nYBIfaLNPWgTozM/GdOy7V4=;
        b=JFLEVLCg3mYWfc/SOPe6Pb/1Dx/V89JWi9xWoXDl5SATV0EePE+ItBHwtVjmWk+0xA
         vgEmseztGz4upoxV6X8bmPXcRAjZchYViBtxbP5OX7p7BltBkK/maQryUCt0gRJo5Vgl
         8b1k3K2NOyf6yYWUA90wSkbtzD+XFUjSFX88uNFVrmfmBkHgxn94JpzfR6AdYXd5omXN
         J/xBvTsCsIMuBTerQka50R1Zi97ZOcTgk3anKuQKxeN/SjI2uhjdGYYUDEfstjf8B6/3
         8ZN1IANqAeyMKcDC6tdC75lFFBqev7xImnpHmcLeJqkoMT5QyOiYUAj96eElA+NEXhiB
         Lt/w==
X-Gm-Message-State: AOJu0Yw9MNiE3KpXodzO9MJLTeBEI84pRLJgyC4AKyihzS1jME6Ei7tt
	Uz/iV9G9XgkfB866/ZHYin4o86DIQoO20ji1xdTTOzU78iPQLTh9alnohB/J9g==
X-Gm-Gg: AeBDies5UMo5blTjMIdaVG0a9+Z18nlVIutY3aVFGqsKN91Gw35XsrXCChDBp+yAiMi
	q9ozJ5xRt2va9nG9J0SXQWdmFI3jqjyZsB42CYFpbPoGwqU2RnqniWXl0EJqmCjg2EGgKoxFYiN
	F93uJPgVnQVkQwvGK3mm7El5WuyBhC6ptz/yFaTnfadTUdBg+B38WOpHlLpijiQgOXKk3LKCuot
	+a5lvPq1VcqSURsR6/q1bUIthjUL+ECoy04F9cHS9HHbaKfKCkdt8tR0LMOimHIKga2N3o+uokx
	PSP/Ig+epYa/0pthWbLzj2eZFjkzXwfP2lIkY4R11LIvA5Cot/cc4ejH8JtLCSvopl6FHq3a2EJ
	vdQbzzTHDAufdBlitigyOg6orbLCeqakp32riRApP/ZSwbk2J8fTKMUo94vN3vsyvPo1WMHWdvu
	fHlJllkUWqvnuGDTCrWv4+QIsKPuiw56LH0kq4gz00SDs=
X-Received: by 2002:a05:622a:1e89:b0:50d:cd5a:577b with SMTP id d75a77b69052e-51018a34651mr69489871cf.35.1777481030149;
        Wed, 29 Apr 2026 09:43:50 -0700 (PDT)
Received: from [172.17.0.2] ([172.174.165.225])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51024bc3139sm5231691cf.0.2026.04.29.09.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 09:43:49 -0700 (PDT)
Message-ID: <69f23545.c80a0220.2d0740.43c2@mx.google.com>
Date: Wed, 29 Apr 2026 09:43:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3675531562256708166=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, alexej@sidorenko.cz
Subject: RE: Bluetooth: btrtl: fix RTL8761B/BU broken LE extended scan
In-Reply-To: <20260429151343.28142-1-alexej@sidorenko.cz>
References: <20260429151343.28142-1-alexej@sidorenko.cz>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3675531562256708166==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1087576

---Test result---

Test Summary:
CheckPatch                    PASS      0.72 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.16 seconds
BuildKernel                   PASS      25.55 seconds
CheckAllWarning               PASS      28.38 seconds
CheckSparse                   PASS      26.93 seconds
BuildKernel32                 PASS      25.18 seconds
TestRunnerSetup               PASS      561.16 seconds
IncrementalBuild              PASS      24.22 seconds



https://github.com/bluez/bluetooth-next/pull/133

---
Regards,
Linux Bluetooth


--===============3675531562256708166==--
