Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A411EA7F9
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 May 2025 18:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747332156; cv=none; b=JuRpIdHV0LUdaNNS686wwzkgz497/yPjlxo5X900rDe8zYmk2/LajBKlqQ/BVAsTgcKYYhXPYM25zqBlVjWc2hIpRrrbcerlu9CX9C4qQ/FoC4kFGd1t8r3Oh88yS0rKMqljWPUiNI/EY2c1KH7m2HOpL3TS0nhFBw0mkeqU/qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747332156; c=relaxed/simple;
	bh=V5dcoX+NoC1hcHS+08bqZzjnw1idh83M43U8soyUZ1s=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Y8E/cMyyjUT2hIbwFEUM3EUedH9tl3SZ9tjSb1FZlFvNRK6IWTNe8pOEa12a91PcWYD2RTMEC3D8ruUKnJsIUVdOkqln1onJje/QxIi1cXq+rEb1dOmUO8ort6tNVmMJ/q5GXJZAWcoc6/48ZLKc0g6ISKXn79UkhiHaHVYEmiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jb+I9TFt; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jb+I9TFt"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22fac0694aaso10181615ad.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 May 2025 11:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747332154; x=1747936954; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1YrgQIg0e/FQPWr93MSa1vYKQFzhiX47KklttkHwRl8=;
        b=jb+I9TFtVktB59432OS8RWmE4tdO5D3QBWwYW8+/z7UfJe80F99oaxJfmM2iUtSMBS
         PQF4he0lgYMweIzvFZHyF5aqIHxkWI8I+3oUmIQAvAQy0DoBGdluZtcdJ3pMSC5a709W
         5Ru8jmRFAZ1+ayMP9TAnBsWyQq8k+sMpoxFk/bp6pXuP0lA/SBdvL++LYoe+APxhPugQ
         EwDtiiNiVdlMTAo+pKNONwACzKEbyHJ7UROWbxpQBkJVGK45FBXoNGH1uNtZRLjeDGXc
         CxQEyp6KXMtJq+JBGue6F0iUroO6XITN2tEEo77YY1K9Nfhq5LAf/Qb5k68PExOEohP8
         U6Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747332154; x=1747936954;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1YrgQIg0e/FQPWr93MSa1vYKQFzhiX47KklttkHwRl8=;
        b=wfCs3KZYrSPi8AfiGWq0Zym9HrpiGgN9Ka3zVuyDAdCtFMaYN7j4eq6QRKNORFVqV6
         MEAm1PuVZ9NO+XLMJJaX/ZrzLREopZv54asdgojgVHjctH2/wCtn/gPyP+4/HUYnHHNj
         f/B75IAjuLfuZpSpXS2zTETNBN34kVqqrJVgBNvrQMMSp9pDOSUQ/40Es24GBEsV5KtG
         LU1ZHg5+KTKMc1ZX+1CujZiehJG+fU4e2/EpQGjPE+Pjf3Xrh1rZ5/C/d4gMy3o4cHiS
         I0XudvWXCg5sroq1Q9efrF6ibx7cB4OvWpRpy1bth6kFT09nxx+A+BKUJgePOWl33vqG
         foeQ==
X-Gm-Message-State: AOJu0YyyNBrS5TKsR79aeeJTex5sN1ZOavOKptRwXDU5vCyhK65vzgrz
	q/hBPNFvFdrnnOtAHdYexHcg9eoEbZoVe7CCSB8jYYv7WpmTJmfhC8yXoOY9SQ==
X-Gm-Gg: ASbGncsTNYkYO7Ogu3PTORA1if4tRRkViqMOeqqCR+v/W/Ui1XJ2QMqfWlls4cyFwit
	Y2J5+Lcu+WpFIHkCPs91iCmdoaWCzjbnz8ptc2xbW5L6Rq20CCp8RxOetS/HerSTDSFV+FsQyer
	iWMRICRw+Wzt1U8SrQ6Q1f1NXtuZiojDHlXFyIOgc0fz7hZiWh9E00YfrMHWiU0WyaGBQeuHWKt
	Wod7qe7VZpyiH7NE25/+aBlDjGzRBzIGAav9dfR28OpLv3aqPhJjOFn9h7Oet1J+cLa/O04XFTb
	1F9lRjtqul40p3xv8ChPZ6wz4pJAufyiqVNf0vuFe7V3DPf4XNx2GB5u37g=
X-Google-Smtp-Source: AGHT+IFb7SPBnKT6D7Siq3qDYfSkh2aF6mTTi3HtiH3mn+921EJ1lxEliJbipVNmm+pVZ/13ZKgiJA==
X-Received: by 2002:a17:903:f8c:b0:223:54e5:bf4b with SMTP id d9443c01a7336-231d43bdb88mr5247535ad.25.1747332153445;
        Thu, 15 May 2025 11:02:33 -0700 (PDT)
Received: from [172.17.0.2] ([40.112.208.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ac93besm767615ad.12.2025.05.15.11.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 11:02:32 -0700 (PDT)
Message-ID: <68262c38.170a0220.6c7eb.1d8b@mx.google.com>
Date: Thu, 15 May 2025 11:02:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1497252808764027823=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,v2] device: Reply br-connection-key-missing on connection bonding error
In-Reply-To: <20250515163448.189497-1-frederic.danis@collabora.com>
References: <20250515163448.189497-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1497252808764027823==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=963312

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.34 seconds
BuildEll                      PASS      20.22 seconds
BluezMake                     PASS      2706.04 seconds
MakeCheck                     PASS      20.51 seconds
MakeDistcheck                 PASS      198.22 seconds
CheckValgrind                 PASS      274.95 seconds
CheckSmatch                   PASS      302.48 seconds
bluezmakeextell               PASS      130.07 seconds
IncrementalBuild              PENDING   0.35 seconds
ScanBuild                     PASS      903.40 seconds

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


--===============1497252808764027823==--
