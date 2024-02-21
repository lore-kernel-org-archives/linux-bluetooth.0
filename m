Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E1B4CB41
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Feb 2024 11:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708515034; cv=none; b=GuydfvKr0v7MyUff04E/ci7ikK7cD985WfkT7Au72ZCQDZVaOkFZfSzQommzGYv7wmXpw1JZFWJvNryzcj9eaORQLxRSifzoNWAlU8NbdVJ0LT08nHNyMifMOUoG7ZCl4yQpXVmlC2OEboFdzqNJmixIGxWO7lC5l6tk9Zfv6To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708515034; c=relaxed/simple;
	bh=IvJYiwhxYhABepXMF1yIAapHFbMoLbhaJ5lWd818Yt0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VZX6cvj3uotbBVhKuSGapnBEb5s/ZP5K7ffPiZMXOkZy6tT4kJDMLhDbTy+Qw1UBDUwnc6ARLCpILS88gB0C1HZIL7JxISZDmC6b4UchzzJoGczH6oHYMvd8Ql7tJ0FJwR8u1i2yGG23OuWzxnloMjb0FBgX5U+GNzKL0vLpBoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Czm9jFHQ; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Czm9jFHQ"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d180d6bd32so74209541fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Feb 2024 03:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708515031; x=1709119831; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xqccCbhbJuq0sAknNyASp/HD4gmGq2EJQdGHZ7p3NLk=;
        b=Czm9jFHQ90l96twNoLTBXdLsarlXsdng1gH2hs2aWgE5FtQRLhDLF6BTL1z2zl1UnV
         e55goKYOCEesmbz7nodUriUDHE0Yya9IxgeEwTCDWq4VpjrHVsU12fQ7botNZ9SLiYxX
         Xbkv6cDXd06qDmxgqKo1waKIoIT5WubbOFS/q0o4nUq+XQjMM9Pp6udcQ+mzskk/iDab
         z39TCm9QRJyOKDSlscKfiY9REQLNmtU4pB+BPGEPSQ85N+d5/SNlPKElUN3Q/GvfJLaX
         ktLbppXX8l68P1qxc6P6Su2FHHpReLjlN9VkCejeU3+VP8CxJg8Cr8MAypGZ/hrrFQTh
         SKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708515031; x=1709119831;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xqccCbhbJuq0sAknNyASp/HD4gmGq2EJQdGHZ7p3NLk=;
        b=okuUqkyKfwlZJd1lbhQDxsH+PZMlAeQ2BBnHfLPKKEvw+73eUwU3zYzYR4hAf8YHJZ
         9ZqlAP4PKQ+xctoT4mNO4VINOfMjKeK5ziR/XhZQnzgWJohmLTHOuyfTD8f4Oilw4+hR
         cV0OSucgxgJxowjzSD7dKpieIkxtVfwKp0ApUtD3IXtz7rPF9c1rWuc0xB73ggcquLfo
         shXPN9YArh5TUACO5t92eR/u4qm0Y3HH0Y/8dKdNHBLelebcDu/c4VmFfsG7g1tcGlXA
         ImtOxSl1LNANVLAkJQRiR2yYazCME2HjGFQlb+tyCC8SJjS2iF5QaBEWuFmdo0YcnJm/
         cpDg==
X-Gm-Message-State: AOJu0Ywyx7ydk+UfTV2KVSpBFLkD70D38YcV/9gqeDpHgF5ygRC0jdrw
	l8viKqj/CCtk5i950OvDd8X+6DxcUGfOFKULRDgQUxgxHXrvzrPGz1gXvwxw
X-Google-Smtp-Source: AGHT+IEjQp4MTlKBghKaL8wI7IArS/7ULwgzsSEssuEE0SasfxWrnN728sk2AtIrGR2afBIWPhHz2A==
X-Received: by 2002:a2e:b8c8:0:b0:2d0:c77c:b1ca with SMTP id s8-20020a2eb8c8000000b002d0c77cb1camr13793487ljp.49.1708515030530;
        Wed, 21 Feb 2024 03:30:30 -0800 (PST)
Received: from [172.17.0.2] ([20.102.46.214])
        by smtp.gmail.com with ESMTPSA id e6-20020adffd06000000b0033cf60e268fsm16474838wrr.116.2024.02.21.03.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 03:30:30 -0800 (PST)
Message-ID: <65d5ded6.df0a0220.fd33c.c60e@mx.google.com>
Date: Wed, 21 Feb 2024 03:30:30 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5259317437850358593=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, shahid.bashir.vichhi@intel.com
Subject: RE: [BlueZ,v3] profiles/audio/ccp: Add CCP plugin for call control profile
In-Reply-To: <20240221032221.404011-1-shahid.bashir.vichhi@intel.com>
References: <20240221032221.404011-1-shahid.bashir.vichhi@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5259317437850358593==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=828218

---Test result---

Test Summary:
CheckPatch                    PASS      0.58 seconds
GitLint                       PASS      0.33 seconds
BuildEll                      PASS      24.30 seconds
BluezMake                     PASS      706.76 seconds
MakeCheck                     PASS      12.13 seconds
MakeDistcheck                 PASS      162.79 seconds
CheckValgrind                 PASS      225.85 seconds
CheckSmatch                   PASS      328.39 seconds
bluezmakeextell               PASS      106.76 seconds
IncrementalBuild              PASS      664.97 seconds
ScanBuild                     PASS      943.29 seconds



---
Regards,
Linux Bluetooth


--===============5259317437850358593==--
