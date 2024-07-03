Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A53174EFF
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jul 2024 10:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720004270; cv=none; b=Cf+lfQjnV9KUPf4QGkMSgY2veGKuFd7tJn8rSC0I1up7sUoHmONO3XTutWMu6jn6nsSVmE5U4bssfR2X45rhiTjDckJCmVvJ186MIaTP7WUUyVSLOfTwx6eiMITmWtrXwjSM8Dr1wgJPjjeJeInKd+hDi2v49BUFkNACghMhKUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720004270; c=relaxed/simple;
	bh=vSFpBmUmERTmlNcL+zWv8OaHL2jxSgcr74OHinxrbSE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=myd7a38Q6KscLsyeDw0afDUQI5yrw5CUgLdFL/JXgpuJxX75c3JbL3xkJAXiyruhIyTIiNah5R/w6wN1d0UBFKQK6DcotuI0iYYfpIA5rnkEnn+lI50K593UsvlOeMwA6HCZvF+VDSxyOCzV3HOnUcQ8VhMU6Cx0lw9Tsmtqoow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHMITmAy; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHMITmAy"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3d5666a4860so2973271b6e.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jul 2024 03:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720004268; x=1720609068; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QVozCM2Qt0MWk6e79GAIG5SA9TARND/J3zzky92Y3Y4=;
        b=fHMITmAyf+9fjteHSphjezdclTMo6IjMfbYlFHBZsmWd+aoMGFtu7VAbwOc2s42O2O
         uC7ZS/qTTeXumlXeU5qP5pnMuKxlMJG+1VK+ti1tVYU0CbLoGAhpSLJdVC37rPZ6xxlc
         rFNICm8YIAus0arRLgO89MP4FlEK0ixBoZ8dsS59hCs4OzUWWGeWfdqiFWE5DCgGfJD3
         Gv8Nl8FFYITioOcznC9312tMaENL7OadKc63LuwEqbBc/JvUKe5FZ0+9WlB3dO4Y0klJ
         2+/Yx+xO/FHkrMA8Zi6ggEJBjXslGyyc0VrAXOP4ZCIV4E3gwZeYsTrOIMdyimO6+NjW
         ELiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720004268; x=1720609068;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QVozCM2Qt0MWk6e79GAIG5SA9TARND/J3zzky92Y3Y4=;
        b=h5Os8gzW/TCnXxLwdGDwZVcFkscRaweoE1esN4617AiW4+Xor6fX7AXa5T4Qa2ME/l
         oU2ENZepuLQydbr/YKg1l0uA5NMadCiOirbn9CsMQ/KECubiRsGmua2KusTMPMpOsUHm
         Uukrrej7IiaUN/AyoPm9+yXLncxEdMbCpWToaCreDwGCt4NkxvebF1JwNYBpAvVUa2hU
         aZWTucVziF2kUaswIT/QLYTm0oYe9OOtHqNQozGl3trZlVFO0RS3QKfrmX/O4EjNi+/y
         aDoploW6sfxwPcz+I1+xBWWd98Uoy9mgTCputWVYOGpZoUHNu5OzmYv7Cr5fj0OmtC6x
         7EXQ==
X-Gm-Message-State: AOJu0YxbluhzeE30BBF9JE89qS5sOl4o6Oup+MvPcQbeESQiHNeFWRoJ
	G7VuOKQqLzBbZO9eKHHTzytWFMUKVH3PSad/owuxZhtDbB15Kq5FS1RKBw==
X-Google-Smtp-Source: AGHT+IE51AxplOr1swfG8WJahU1ws21ugKN7yyru8PNTpHYlk5ngZlTd9WA1iP7ja1DraD7IF+jEDg==
X-Received: by 2002:a05:6808:2288:b0:3d2:2768:c8e2 with SMTP id 5614622812f47-3d6b37b3a86mr13121123b6e.30.1720004267986;
        Wed, 03 Jul 2024 03:57:47 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.36.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6afb8f6asm7944244a12.42.2024.07.03.03.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 03:57:47 -0700 (PDT)
Message-ID: <66852eab.630a0220.5ca85.c312@mx.google.com>
Date: Wed, 03 Jul 2024 03:57:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4900374513202713355=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: [BlueZ,v1] shared/bap: move checks for NULL before dereferencing
In-Reply-To: <20240703092322.16659-1-r.smirnov@omp.ru>
References: <20240703092322.16659-1-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4900374513202713355==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=867905

---Test result---

Test Summary:
CheckPatch                    PASS      0.27 seconds
GitLint                       PASS      0.19 seconds
BuildEll                      PASS      24.43 seconds
BluezMake                     PASS      1604.72 seconds
MakeCheck                     PASS      12.97 seconds
MakeDistcheck                 PASS      175.01 seconds
CheckValgrind                 PASS      248.49 seconds
CheckSmatch                   WARNING   350.09 seconds
bluezmakeextell               PASS      118.20 seconds
IncrementalBuild              PASS      1354.84 seconds
ScanBuild                     PASS      972.29 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:286:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:286:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:286:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============4900374513202713355==--
