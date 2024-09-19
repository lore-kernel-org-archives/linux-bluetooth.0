Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922BF17D344
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Sep 2024 10:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726740578; cv=none; b=l4tb+Do11DkpGu1PxQrq7t3UQfKlHhPRPc4ppIobgZ0oJQ6o2Ok8GwFzLJyT1f3OJ6pX/aYpFct5uA6zStthR+rtPacuR1CngxHLPN3rmoJ1kpBHhOMp/r4fGacizm2OKxupRjmL8HGdrfYRJtiu3tDEXg3Ym87t95Wrfntv5YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726740578; c=relaxed/simple;
	bh=ZecpU0MZOyATwt/gYfD2gPkQHzibrfmomTjdlmoytdc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NEGpPYDDDoWggYBaVO+7MwPNWdKaOwdU4DUmHjqETXwSag4o5otAr8Y02iiaCbs70xI5JvWv608ZTc3KrglgzsmroZoR6a5atRTWFpqpATGRswEM9OGBvvcA7M7vGf+KbHDyzOH2MsvWjK+H1wkLwTR8qrB/znt4b6W1uNWKdUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KIbC4Wgw; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIbC4Wgw"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6c354415c19so4842906d6.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Sep 2024 03:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726740575; x=1727345375; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zt11ijXFn8hqS3ijeX4ooynARjNX2HD6WAKEJSEBhfw=;
        b=KIbC4Wgw+S62HHmVko29FtLIS55DKrC0GHi3fs+aMmmteEDLiXtyEqzaogFC5XXQMM
         WryqZzKW+hpgbbWqs1Ht4NpxPaT+M2+t91ABYgiEEml1aDsKviMnPuPemyVm1i1KFXeq
         YP2bY8sLSmbv7fK/dImgVeAJNb15cakS03/ZI9jywkn7w0x1LsxIberAdB9J3u01um1h
         ImNAXOwJEVSRhujtmLmV8Njy9jZUX0Wj7uiRSziQP7JEupMXaup/vfThHR+B0KuEH57c
         hychziJxf9bC1StYWGCm9xy5BtAd2+dqnyaBBkYRgrHDVbY6P2rSCra+mtBvmZqBpriP
         D9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726740575; x=1727345375;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zt11ijXFn8hqS3ijeX4ooynARjNX2HD6WAKEJSEBhfw=;
        b=H5f740vBCZYWm4FZsP/2t8ihmmHbfsPZFlRNJ5SMCvhd4G7Mx6Ia1tBUixGUI9/twn
         A/FjfrwkDmaqvahAlOvgGMMwplXmFp9sQBF4BSvIu89By3j7Izr4ELhXCml/UBKt4IcB
         5uTshVF+V29Sm1RxXV7ekNzCj0O4DVQG8kfkqozagJbm7ogqoSL3fUs8jeY0tDC0hsCr
         pabmjPGm+RYLyMzWeK42ZIevjG4LRpgu7Demfp2MARJMbHUWExr1QI1I0/NMn2Cs96L+
         fil18gxQnjy6n23kqswsKx5VIkmpr/9Q+UITjJ/ha6/7LBak7s3IY67H2dh48DVlyexf
         dnTg==
X-Gm-Message-State: AOJu0YymWOXvtTZjtUUjSNhCglRWpBg79Qlad6MTOQEFLq4dnmbsRhL+
	veWc/+qfTAuXc4Hs4V0BkG48L7885S0Dqrhyq210ssb9q5GoAwXmkq/ytVPg
X-Google-Smtp-Source: AGHT+IGTLDR0a4592cp1yonPx8VysYYYS6UXNXnbvT/QV1jBnaBsoBuq7Pi4uWeg9GtrXfWIAybxrw==
X-Received: by 2002:a05:6214:3907:b0:6c5:2fce:4904 with SMTP id 6a1803df08f44-6c57355e7bamr387260126d6.12.1726740575128;
        Thu, 19 Sep 2024 03:09:35 -0700 (PDT)
Received: from [172.17.0.2] ([172.171.255.192])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c75e586b42sm5785486d6.138.2024.09.19.03.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 03:09:34 -0700 (PDT)
Message-ID: <66ebf85e.050a0220.249880.1c99@mx.google.com>
Date: Thu, 19 Sep 2024 03:09:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2177975399061401861=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: bap: Set bap debug func at broadcast probe
In-Reply-To: <20240919082046.7208-2-iulia.tanasescu@nxp.com>
References: <20240919082046.7208-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2177975399061401861==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=891354

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      24.11 seconds
BluezMake                     PASS      1659.41 seconds
MakeCheck                     PASS      13.50 seconds
MakeDistcheck                 PASS      181.74 seconds
CheckValgrind                 PASS      255.39 seconds
CheckSmatch                   PASS      358.33 seconds
bluezmakeextell               PASS      119.25 seconds
IncrementalBuild              PASS      1478.98 seconds
ScanBuild                     PASS      1078.56 seconds



---
Regards,
Linux Bluetooth


--===============2177975399061401861==--
