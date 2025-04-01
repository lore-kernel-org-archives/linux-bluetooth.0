Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B0E207663
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Apr 2025 15:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743520281; cv=none; b=MagJlEh7o1uUyL+dsAZfvTlB9NkpAc+C54LEMiZTmIi87yOBPRF8CZqT4pxP781xyslTSUdtHvGOtwD7FK9Vfr38edfdK5YbJSAaFP/PdLaGdEJbzo+w8pbN3LkoFsFMk0a5r9a+9ONWvyomwKO8yDoiHdltr+Kppce+jmCcg8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743520281; c=relaxed/simple;
	bh=H4VqiPcDx3EyHHgMyvxTEyz0rHO6TgSMxeQdCfPA/Ig=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZGmyseIeNSOEnrREPTaVcgWj9EuSqjayi8f8n9zo1NMa2l+V+/6IX0EVLSjGWdZ7me3sQJsrJZ+mcv9pCUBbwe4UJAhcFLCspV0VKAoaV2EilBZWYRWM8oOtHEE6tLKz7B8C4RBZuHNM9qIaTpmRxGuiOjeXRgWwAB159rDcc+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nikKcweN; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nikKcweN"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-223fb0f619dso107056455ad.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Apr 2025 08:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743520278; x=1744125078; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sSReQiK6Ma1YLeUjeVCsM5DX0iqOaJ148KI4yIELIGU=;
        b=nikKcweNe9FVEjUPVUS2EnTjDGpBanhHsJwHJvLO0l0lKodg2bdy0ekgQq/jkuB2UZ
         U5ztpAHfQENvjOkVlnpVPHfTcRiTDIh4XAnX+NKuBEtXsxzxljsj0tjwFetGmWIf5uBQ
         37evLUBMMsUipnwvJzfilGg8rOY1dxUc1DH/hkPQm6ZGCkHomOBhak+5zx5GVz/OASlF
         A73BVM09dCM3D9z9Ij1D2tQcNir3shq+EKOJYQ1dBCRDwo7PdU0En5SG6BaZLVokkGFG
         SBLOEL08KTDjorHdVy4aTzsESIjnG5r1UJYwcRbE+Fp1NW8u/grwbxqGCnI/PIwGnYIQ
         i5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743520278; x=1744125078;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sSReQiK6Ma1YLeUjeVCsM5DX0iqOaJ148KI4yIELIGU=;
        b=Z3RWch9XHd2POgboJzSrMh+hgUbuBH7+kujbiN7SKPZK5TKzjDXL4EZzP2R2jBO07c
         NjXxYRXXGQsNYq/ruVAvg0y1yqjgzTNa0k1YqcBKVGwbLeYnFpkqMC0RNARS+7KFwkrA
         Ow7H8mr6M5iqm4U095ho+N7h7LriLS/QueKGhvvbXnU1H4R4mhWItrkc8c3pc+nWxcHb
         F6L96M4ciRkUjVmBgf9nuimg6wlGU68xOls5MtkwSafUQ7tMohlKw8/22/bSM9IdGY01
         KNMvgNigI06qNDEyT35vtOQ4gz2XdGL1G9AaQuZyRnkZ/C7Mfj78lxyDa3YUw4EtwFmL
         mWZQ==
X-Gm-Message-State: AOJu0Ywu8kULWlXmIbis9BrtTHv1VCalezvLDipcKqnQu8F1NQs1YPb8
	56cod27DSBE2hF0k1KN+FID+gozAU5Vw8HtQEm6yW2xK/4YjZT0T3hglBb7Y
X-Gm-Gg: ASbGncu3XaF1o/YdW5e93XzpoIxKrrDWpoeBZohzmADJO5Gp7zaQxGKAcvl/pE/MScy
	YBCpVyEqw7C2YzjtDP41cISy40dJAvnCU8RMMoebbhlKM9BYUnHHYDGeQ08MN915RE62N0NCYO/
	1HWd61Gb9idqV+BFDIdW0WlWLWOIvyuqfclqqROFQ49f/6ppzZAmI2mDbCEwSu6Y4j9/jFJa7tA
	ajK7TKU8HHXqvey5l3vOUkcLaW/z3tYIGTHcQYwjhdc4P9ULd50u2+qCRrWqr+zCRXa8p3L8OOz
	XBVYBJ4tPEXfBwBaCSYNl/pNVx7FS1tnUrLMEYhCgfUomNg7bdIQ3d1p/tQ=
X-Google-Smtp-Source: AGHT+IH7c3PfsNG3NZC1StHJfzBK9xX0jdaXWjJLYjP0MLkWLAHq7/jkfKwKVP9bUqBzxbnwK5iv1Q==
X-Received: by 2002:a17:902:e88f:b0:221:78a1:27fb with SMTP id d9443c01a7336-2295be31744mr51960855ad.11.1743520277961;
        Tue, 01 Apr 2025 08:11:17 -0700 (PDT)
Received: from [172.17.0.2] ([52.225.31.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1ecb62sm89261525ad.230.2025.04.01.08.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 08:11:17 -0700 (PDT)
Message-ID: <67ec0215.170a0220.19568.43dc@mx.google.com>
Date: Tue, 01 Apr 2025 08:11:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3347303941550506735=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] dbus: Fix condition for invalidating path
In-Reply-To: <20250401134904.3721187-1-luiz.dentz@gmail.com>
References: <20250401134904.3721187-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3347303941550506735==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=948957

---Test result---

Test Summary:
CheckPatch                    PENDING   0.39 seconds
GitLint                       PENDING   0.32 seconds
BuildEll                      PASS      20.49 seconds
BluezMake                     PASS      1501.79 seconds
MakeCheck                     PASS      12.93 seconds
MakeDistcheck                 PASS      157.66 seconds
CheckValgrind                 PASS      216.69 seconds
CheckSmatch                   PASS      283.78 seconds
bluezmakeextell               PASS      97.95 seconds
IncrementalBuild              PENDING   0.34 seconds
ScanBuild                     PASS      868.85 seconds

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


--===============3347303941550506735==--
