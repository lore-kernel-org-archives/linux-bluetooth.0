Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DC01A257D
	for <linux-bluetooth@vger.kernel.org>; Sat,  2 Nov 2024 17:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730569416; cv=none; b=BY3/Q+F1Wfcmc4L1gLyQ++teeHRmVv1y+sOVPHBFpyx6lZh1yoqjEAQIOFvPh549hp5vBLKQcIIrwIwj+2lmLfSlquI3RNOFbRbgx+58Bdol82fdcMDkuaf0R/9QAJbTZ+Yu/BRADQDIyWheh5ZgL8jeIKm66nZ7a2oIl6H1n/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730569416; c=relaxed/simple;
	bh=TGWlH/g0q9ecomaBSiA140IbV0sD32FJ4svSyBERF7I=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=POR8cCZZ4t4dmsWjsqIqUfkBRU9GgqZq7wAaYCa3MRW67UaADfy9QgigIBQKUAal28qUAquLVuOUy9EEaN4F8X5wRL4w72JZhFtcibagYWQR1NIhK1OZJCAcgJgwu9ZLhgQa+OYKvMDPVi/2S7CR5K7muz7m3SYk3+y+DnkBwiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fV71v+rM; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fV71v+rM"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-720c2db824eso2554341b3a.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 02 Nov 2024 10:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730569414; x=1731174214; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Lsi3NOcB7OJsue75fLa+pyNRpv34h0aHVIaTZIuMFWA=;
        b=fV71v+rMu8f3CG8hxc9RFPn56qKP9R0oyVBJopV17zmeQxJU0nh9zUIitUBHVlUfZm
         FGrKAJelGsLWUI0JJInh3FsHOnWP20t2TW2KqJfkwHNin8DoDyZeunzJ6xgKXvTkvOMl
         xtCR9e6Kz/sRPe1AW3CorkCKxW0b4sV+htC+Ynu8sBRRpAv1ngxLC/jKpyI+EaJNNYAt
         jAZJFgdtV4lppy9alcpxiX9E7DO8/2Yr0ZKN9gejaSiwctqrSJU2gNwBoxOxGurvUPSm
         NFUUDVS+acEGR6FToGAtW3Kkg4EkxJR4CrYrVSh3apwzgBWnqL36QxyoXjL9n7qFx0Fd
         VC1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730569414; x=1731174214;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lsi3NOcB7OJsue75fLa+pyNRpv34h0aHVIaTZIuMFWA=;
        b=TIj6c2QB1rHO7fuUMIi7mPjTVlniCGjfLDERTZZ0xBGOUn12+++2U+qZqH5BGYIB0K
         Xob+brq7GDSMkhdhUyy3ZhmCgdNA1bnz2fRGhmjlxWo2UNY3FRq7fGd8fMCEsmtQYxJ0
         /wdASOiiB2HRB/FFur8IQYYG2zWJcIlwFOR+vJNQ0R5ZoHBm0jYmWmvwIlWkJHFWEXOr
         qvaX61HWFy7yjQQITRtr3UghNCRZ/1zDZktqjFNa+XlIPDP9iaXwxM465LiM1J9IH4Uc
         DNo7uOa7/mg3DWwjQ6lxvOyrVLH7YBmg4D+dUd4R/w3chDgNFyKulD27+CbIGxzVvZuu
         BEfA==
X-Gm-Message-State: AOJu0Yx//kv/DjfF0v+KSDY6/iy7f1bqsEV99BatoLqM1fKA/QjUyp8q
	v3fuSnaB329Sikw08hTbdOvkOAMhUoecQX5BVaAuD3mJrFg1jZQs2zmOqQ==
X-Google-Smtp-Source: AGHT+IE/VytgxQWZHYWr09vWoHgO6qBVVW31GTOsmPBAY6knPK7NDPoOrvYkMTGBdQrfo9g2hjXlXQ==
X-Received: by 2002:a05:6a00:cc7:b0:71e:7846:8463 with SMTP id d2e1a72fcca58-7206306dee9mr41586875b3a.19.1730569414141;
        Sat, 02 Nov 2024 10:43:34 -0700 (PDT)
Received: from [172.17.0.2] ([138.91.70.183])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1e6bdcsm4364177b3a.58.2024.11.02.10.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 10:43:33 -0700 (PDT)
Message-ID: <672664c5.a70a0220.a22a2.4377@mx.google.com>
Date: Sat, 02 Nov 2024 10:43:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8558848715521585006=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, gudni.m.g@gmail.com
Subject: RE: [BlueZ] gdbus: define MAX_INPUT for musl
In-Reply-To: <20241102161018.2518100-1-gudni.m.g@gmail.com>
References: <20241102161018.2518100-1-gudni.m.g@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8558848715521585006==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=905688

---Test result---

Test Summary:
CheckPatch                    PASS      0.25 seconds
GitLint                       PASS      0.21 seconds
BuildEll                      PASS      24.81 seconds
BluezMake                     PASS      1627.06 seconds
MakeCheck                     PASS      13.31 seconds
MakeDistcheck                 PASS      179.51 seconds
CheckValgrind                 PASS      252.39 seconds
CheckSmatch                   PASS      356.55 seconds
bluezmakeextell               PASS      119.70 seconds
IncrementalBuild              PASS      1406.49 seconds
ScanBuild                     PASS      996.64 seconds



---
Regards,
Linux Bluetooth


--===============8558848715521585006==--
