Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A1A3FE675
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 10:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777544483; cv=none; b=NnmAJQOu5Geq10oawEVHmk9+Q2WOD2Hw+7zDY5xLl3nlGNP8sy1OzBbIET3B3/9qfGw1oVQ7PTCBHJT6Se/LqejaSF6e8Y9Uwin0naDBWFvj+Xe/q0woAy6w5tnfOhleTncYN391Z3ZYX1suNQOex70Nq49vqV7+t4KyNHNUwYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777544483; c=relaxed/simple;
	bh=0daAOpFx1lgsEYcCiSNxFIPpRU13XyQ1oFgE/EvRrbo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gRJbTU/XU6LGF0vPZ1RoI8Sc+paJZVIhqQw77Nb91gUb8by0ffobR/l0GE33zkEtTD7ccWgC+eouO7Ye135ftft0AidP/4DEGciTzOuVGkmT1ct14hImfKy/6Ickpo7Jpv1JZVku/+9q4l1cUWYsSIdpZqMLVdwnwtsFFhcyZpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzqWv+y7; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzqWv+y7"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8aca2726f61so10817666d6.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 03:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777544480; x=1778149280; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zNHot+p3Op9Zed9mihKGw38/xNFCfxOy0kcUobAEchc=;
        b=RzqWv+y73TPmrSuWrmiLFZFfZcS3XEwvebNDAk/rSTOCkxD7QICEN2RLOyY4R7TgIC
         yedxN9hfvi4oCzFQPlOzzN7CRLgFDut3TWuMLCBrdqBSqKcdOe8EcndOfYC7WDOt5i9o
         POIo0phOSHACj8t2IEZ5Igv9N+evS62U66nz0JlA7WBNbulRc6KLWTgoE3QlrlXPlUyY
         r+9bfHaDR0g84tCaaN5sF0/Vz5rKcOAU7nTPl4bsG3u7zrjGoHgcvZrStXRjr//g64NS
         LiC55j3dfyqur9lOVibon+YaIIUfM5AkMBuEEW35vuZ8ByALjCoRVlDIFbUJWca7lIIh
         dC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777544480; x=1778149280;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNHot+p3Op9Zed9mihKGw38/xNFCfxOy0kcUobAEchc=;
        b=M3lfkp580RTNeKrOV5HxF4NzG06P3F7AIctvna6bxtca8uCKx8hPYRBRY/Vbb+Bv+1
         y8ZZPWp9TctQyDdj87yWKffOiFKbzPwfSymNKLEDR44QoHJrd03y/f27MlLqqGxMFEOt
         gwMtkvdNjoWxxOQO38J9rdUv7mexGWJb0OAAeZ3q5tRllF4H4ld28CWS/CMGgE/bNoHh
         Azbo9VECIFNjQ102GgReMALffVU9XkfUbhCEWChwpCEw1ksuNr/CX00I458yxocT1bx/
         pV9bsyAq9qBfwPSIQv7GJ1ArW2uogv8BTOKxpH1h+9wBz2nOUsiczHWj8+38tKl/AM1v
         usbw==
X-Gm-Message-State: AOJu0YxGcb5B1Jtfx/5vgOqFEktSlLftLbyb6Gh3cZoVYSC/ugPm75PI
	AzxYslYkDM3LUhOZS2mZoZopo7wfedwGeTmKtnWp8/5Cs0mUQBimO3ISxytCiQ==
X-Gm-Gg: AeBDievaS3D2gpjHwTarMytl2uzO1IPmanoGfVQBKXyNfaUd0CxCVE7Ajp7G2WGIrmm
	tI2w8h5anRuVL1ta86FP7fI0F272z8fe/M3/4YYewMXJ2oKIqbBi3n317FArdHa4ZtFwKHpM/Qq
	ii+2KbFJexbuyupsJ4P/Qlzn7vG/Plqwcvc5gsig+ceSxKu+ZODYhNSx/I5wgb3kQfG4lLAc4Ej
	Oxb73uhJnCOm9zvBQQLc+oIMgGH97nYHjDeNE242p4iUn89S4Q17lH+uoaDLcStqFO/GroET8Qt
	mbdfgGsq4rm6+9DEimIBxnP36z4WeL/B+KdC2UuXUwLS+PUcn64mCu93OktcYg5EHpTr3olZr0G
	3q0nsTVL62qfichOeGQoSHMx8avP6UzMcH4p7Ll8Nh3hM6LA+TQ8TdgJ7fafn8md4jNO4sIoRPY
	psSf2aYb3vo3MEiaiXraHJOchwekiETEZMu/d7t6cxpA==
X-Received: by 2002:a05:6214:31a0:b0:8b0:2910:a365 with SMTP id 6a1803df08f44-8b3fece5fa4mr30825696d6.29.1777544480214;
        Thu, 30 Apr 2026 03:21:20 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.232.84])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b3ff308ed8sm15494126d6.4.2026.04.30.03.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 03:21:19 -0700 (PDT)
Message-ID: <69f32d1f.050a0220.252294.aee4@mx.google.com>
Date: Thu, 30 Apr 2026 03:21:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5553715877014908850=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, prathibha.madugonde@oss.qualcomm.com
Subject: RE: Add RAS Packet format and Notification support
In-Reply-To: <20260430074142.3599484-2-prathm@qti.qualcomm.com>
References: <20260430074142.3599484-2-prathm@qti.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5553715877014908850==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1087948

---Test result---

Test Summary:
CheckPatch                    PASS      1.79 seconds
GitLint                       PASS      3.43 seconds
BuildEll                      PASS      20.20 seconds
BluezMake                     PASS      637.12 seconds
MakeCheck                     PASS      1.01 seconds
MakeDistcheck                 PASS      243.36 seconds
CheckValgrind                 PASS      218.54 seconds
CheckSmatch                   PASS      346.96 seconds
bluezmakeextell               PASS      180.68 seconds
IncrementalBuild              PASS      636.66 seconds
ScanBuild                     PASS      1018.19 seconds



https://github.com/bluez/bluez/pull/2086

---
Regards,
Linux Bluetooth


--===============5553715877014908850==--
