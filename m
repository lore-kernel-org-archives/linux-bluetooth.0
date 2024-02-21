Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F149365190
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Feb 2024 12:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708518679; cv=none; b=Cc5hfcyr6sZ3V4jvI+vXxRteIDLvcWbD/fsX7aflXFilq8SjnbUDthngTCBPkBjJgOxBqyrZy3Zj40Wnbxa92YVfWOrrP8NrZvSbdZnuh/22INihVy3yaYa/F8C3M7IAvXgVRpFCnewFwUe+WEaKOajfcrPajoywIRTmhp0cceQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708518679; c=relaxed/simple;
	bh=m8196nwmEjpVz0S8tvyNICC2qtyjyqYPqyTeOvaPfe8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NiiRsO6ukRYrQ1Uzi0sFfeqe/iavq1I2XPzx+sUdYgSxncBoYqFQ1WySMvcLhc0uO8M8mFkmkzHG0174/me7GgTBE5WJjkEFEf1YnC93XTzxZxUNaW+f13lseXUh1TZwAC/YvtX8L/wLLSOqAN58/g9DnH4agWkt7xKyeREZcos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7xpQV/Z; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7xpQV/Z"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6e2d83d2568so356835a34.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Feb 2024 04:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708518677; x=1709123477; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hehNo2xgLSw0FnzsMSz6IiATvgTo4ST+n062jM7Gp04=;
        b=Q7xpQV/Z1DPXGwEmsB3u8DGEqoZzcUV1aX0VyQnJV6HPkrzcRG4Um+V3Qi8jV0/LHf
         Rd43NWBimKLvvWgRCcwQQRr2s3/DKBeCStxZMnzqSqZusf0TNrLOAfeHpFzbpNIUa9x1
         dldUgOD5wnBVeLaWUa86PU7rw3DCx3oRUWRyYmHl1+yDHfG+dJSaOxcppheegJs9n1FI
         q6Xh2wq7bDyvGngMTM4h8dBudFzD0kwycY5TEmmOsEvTbe0CuSK0DiVeYAlJJ64YZ8rt
         Lq7iCg+f2i8Z9sKgaIdWRoPTJhNuzrnnS24P24i5M7LOC5b/Ly87Mdi8sD5xzWxjF3kx
         pMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708518677; x=1709123477;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hehNo2xgLSw0FnzsMSz6IiATvgTo4ST+n062jM7Gp04=;
        b=o4EAB11uaINuRHF75I5gyCt3V4vwELUvVhmXlrT54diqZnCJNtyxm9G/JqIR4mid7v
         LbvHR5N6HIttdkbEUhwN3SaUqrkqixYa6mCrg6ARj8dUn8VCpdJo8XkJo3KIjAVL6nRQ
         f7Z82YFiAA6DrtYyYGi2pXuEHgII5LTHUP7sjgaJ7WXPrxMJkoR5rnzPsPelwWKCHBNt
         0apfBpixxacXxYbdyuM2OvAza2cX/QWJG/jhse/1Ouf7aS5Pw2VrRSAXB56CkZddo/Wr
         0pUfFQ7PC73eR5Lq/9I+C3/561Qz1FlwLZjvm5Z5xFc+W00SKD64q6CUXul71OgBtrVN
         +JLw==
X-Gm-Message-State: AOJu0YzEOhNGTBqx/c2T9KO3Es0mjO656/YpFCHsLQerwmrqxPuLtcNG
	8GjpIvH32b13aVqovTryBYAV3AQh76MjvleLaEgvzuXpjExfvniRnDZyXLMP
X-Google-Smtp-Source: AGHT+IGUZhFtZ/J+XAkeSwZUEiW247E1cyfVrsR2Zb2VRMlBLMkPoPyD2cClMxCRgK8YM0Y0xWzshA==
X-Received: by 2002:a05:6359:a38c:b0:17b:5db3:fb3d with SMTP id ky12-20020a056359a38c00b0017b5db3fb3dmr1612674rwc.8.1708518676806;
        Wed, 21 Feb 2024 04:31:16 -0800 (PST)
Received: from [172.17.0.2] ([20.81.159.23])
        by smtp.gmail.com with ESMTPSA id a23-20020ac84d97000000b0042c5a47df18sm4358490qtw.55.2024.02.21.04.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 04:31:16 -0800 (PST)
Message-ID: <65d5ed14.c80a0220.b0f17.2c9b@mx.google.com>
Date: Wed, 21 Feb 2024 04:31:16 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7004610052810622626=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, Joakim.Tjernlund@infinera.com
Subject: RE: bluez.pc.in: Add definition of libexecdir
In-Reply-To: <20240221111901.2807853-1-joakim.tjernlund@infinera.com>
References: <20240221111901.2807853-1-joakim.tjernlund@infinera.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7004610052810622626==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=828228

---Test result---

Test Summary:
CheckPatch                    PASS      0.45 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      24.09 seconds
BluezMake                     PASS      731.39 seconds
MakeCheck                     PASS      11.64 seconds
MakeDistcheck                 PASS      164.21 seconds
CheckValgrind                 PASS      226.26 seconds
CheckSmatch                   PASS      332.91 seconds
bluezmakeextell               PASS      107.54 seconds
IncrementalBuild              PASS      689.97 seconds
ScanBuild                     PASS      971.58 seconds



---
Regards,
Linux Bluetooth


--===============7004610052810622626==--
