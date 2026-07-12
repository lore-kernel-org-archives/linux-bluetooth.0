Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934ED1A6807
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2026 13:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783862682; cv=none; b=i0FOa3QDYNKB2oa9mhfJH0yMDJNAr/xJn41UVFASfkDU5gYQmI5UW1iv5+QPeqMrVFd55rmPpwoNmHAIhC8j9OGdxKpw0GgXaAfn5LEQ1bimROtdgWwlsu003zz0zLhEThi1u4jLcfAI4I0qg2HIokL0L/SghqDrceAojsKCz6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783862682; c=relaxed/simple;
	bh=kmNvlfdkNYJwvKuFWhPEjK62ej9hSkuSDTrQzup8vKI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NN+GpASyJYuReSK2YKJhVO/9TEw0mtUdEnWL0xA/OAqxCP4X2LKoG6EDulcdZLenNJrNwkEAX+TVxi/+SMfuVGt50p6IcP99OYHl/WVWm94pz1151AbXQA1XL1So8x5lLPsH+LBvfv6sOLZbPvCRqG9UNwn+fiuDEydxlFAkuxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzNhY9Tw; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzNhY9Tw"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c7c61b5292so40465715ad.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2026 06:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783862681; x=1784467481; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QfWOIyj5Dh1RyW6lJ4ZHjGKaJH5YK30QhHZE5Vm089E=;
        b=PzNhY9Tw0TeABdJibEq27gdg+9LUpnGERN9qsNvp0sGFY+NASpr3el8PUhV48VrbnE
         4MgUE4GFcURza2+VpHUFxKkhw1NHErRicorkkTROx0yPOqLCK96wbkNUEUahz9Vfq2Ui
         B7P56s4R8hMiOccmcrBB3x7Wfd4C6pOGfOhCf+IcRC5hksLkKo44twtO3l6wtYNR3nsY
         y/PZX03efO3rWLoZUoHlKdwCjTesKj8bWx3a6Q8I+YTFda6YkHbAXwY58lMMTtRdetdK
         UhwwlgEmRIvXEh2jy7JgRgcK39zhyAwaDtKN0kNulJ6g5GisedrwaEDhiNL5ENMo/sos
         W+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783862681; x=1784467481;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QfWOIyj5Dh1RyW6lJ4ZHjGKaJH5YK30QhHZE5Vm089E=;
        b=RlTBAOgw7+DetkI6ActLT8V/mpZwoGyWHojqvd9TqLazujSDLSjEEMROPfW3RfHiqR
         TwGuDVwOo/OsbSRag/b+i2gIKXt/YQJAGET4WaZ9+Pli+sbYD0yW+vovknlyfJ8xC3j+
         QJJSeBxSavFTZRHV6CJpd46e7XlHQZl7M9lV5F+LcPEF3D9XdkcRlfIucguJB6skOgi1
         iexUh8HYD00lb+4Rnx4I69GkBDnqpay19PUN/jazRjY7325aaeXjWSWQlvFerYlwJJPT
         idrpxRJRqqiZYcIbE65SB3NdD0xYfgJs0dXFI0kIJGtQuz7SYQXGVm/ugrIhrrIxJR8O
         mwKA==
X-Gm-Message-State: AOJu0YwJKyKX3RUCD7yoL4r5/a0TEQQmn57z+3ToaxJUDzJVTH70lyGI
	vwlQkyeH3SFdnGqK4jAN3htgQIS02bbkNEjpGLzRewGhllmsTtyWm99ThoiZ0g==
X-Gm-Gg: AfdE7clTlfCCekCUf7twddM4A+B58tITmWeTax+V8H+lCYtAqEPbMIFX6Iu8HCz7ygD
	h5SXDutl/D/Eyk3qGwWZvmuGnGDOSTnQcCX+G841FoV65xGiiyw5hDHmBJ0n3jN4T43RnBdHpOM
	GMm5vUUtcWf7672NwSRqRvBHKDonNocUjBvrxHyPKpIoLb/o7fJSbMPGb/95jvn3DFgQ4+aIdCh
	Eoj3rmll9MjQr4BwWYGLSRba3vytcEu6dfBBnS9mT+S+mgvmNu7yPlyXOmdYn015ocX3OZ751gp
	aucdYG+vSttuJDUqdjoeK2rsyyGNBmhMqv6vRkNcM6tgiCj1ecWpTfnlVEJ8xJIdFxHYqfcRgyE
	4ETQhSBEANR1BN1d7HCvkBJNL5sstLmRwiB1M3R9bJT9jI4PITjVOQ2M/BeqyEsfYU2pyCgWXZl
	sonKk75ZK6LeFpKirjP20=
X-Received: by 2002:a17:90b:2d4e:b0:380:fead:448d with SMTP id 98e67ed59e1d1-38dc74cf95bmr5976082a91.13.1783862680896;
        Sun, 12 Jul 2026 06:24:40 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.45.177])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174accb0esm63451038eec.30.2026.07.12.06.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 06:24:40 -0700 (PDT)
Message-ID: <6a539598.6c8668f2.e4f82.4c24@mx.google.com>
Date: Sun, 12 Jul 2026 06:24:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3295827065177186492=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, naga.akella@oss.qualcomm.com
Subject: RE: Add Channel Sounding Dbus support and
In-Reply-To: <20260712121743.2842547-2-naga.akella@oss.qualcomm.com>
References: <20260712121743.2842547-2-naga.akella@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3295827065177186492==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1126078

---Test result---

Test Summary:
CheckPatch                    PASS      2.68 seconds
GitLint                       PASS      0.84 seconds
BuildEll                      PASS      21.10 seconds
BluezMake                     PASS      551.30 seconds
MakeCheck                     PASS      23.41 seconds
MakeDistcheck                 PASS      162.29 seconds
CheckValgrind                 PASS      231.67 seconds
CheckSmatch                   PASS      315.86 seconds
bluezmakeextell               PASS      102.37 seconds
IncrementalBuild              PASS      574.32 seconds
ScanBuild                     PASS      993.72 seconds



https://github.com/bluez/bluez/pull/2301

---
Regards,
Linux Bluetooth


--===============3295827065177186492==--
