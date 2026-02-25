Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BC82C21F1
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 23:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772062890; cv=none; b=iz1XRLLcOOKCaUwv5cFP0VRdHKO4MowpR82yo9dfRz/K/Q+gsDJuZpysBVcNWBsDnqHlMUTOwQpS++Pxdui5lvriuRwtQbT37cyaRoICZMmbTjv9toDpEisZul4ehD+14UEeYH5uNHsKOkhYkjIz3C7ISxcKerU4C07Rv1PNlOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772062890; c=relaxed/simple;
	bh=Mq+SNSz0hjy2ct8FwpYn5XnXdZWnoBSeAFiO2cV90ws=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Zg7RGFlJ/7YpbZ1jiZOr1TGMaYHOfghgoVIvsbfYgp5QZC3wvNBqvnLuph7X4C8zEYHkfHiGsG/5sGZ0RRYPKoAABwq/ScnENzBbxZhTUYp1Y9A/mCTqUAbEmpZTKXOGkLXHcEKNdindTFVlUJGrIUz8rZSH7MfgF+FdL60bQ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMrweLVg; arc=none smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMrweLVg"
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-896f82e5961so4257556d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 15:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772062888; x=1772667688; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=s1PPua3aUiq+HOnfdRm6i5P4KDZbGPQEEZ+yJiU8Ius=;
        b=VMrweLVglhzuLD3cAldGtjG3ML5F6YVDjn0KdEcNG4Qiw7YDkLubOUsQWeaZjAUdqh
         2pPIKArL/+nX11KDsznwp4Mj2cmnX5EgIpmLv36xPpDExXqbgLlGXtW2WDF5UiF8xR8a
         6L2FY1nkkmp5TfOJll+cW4SJ6+USu7VdSmo+94NeN+geQsnFCABxvS8kF/kGlDhGDeqT
         S9CYwMcwAxwBo2GIqd3qS10PfTF7X5zuscPu/4n1ZbeNOazxch+FEwt6rJAbBCfSX6ap
         LaPt3aeB05/r41ijBh7uqk0DGZlwdCmmOihF6CI7Bv/9LbrGx/hoFmmTytdXlovUcT6L
         kICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772062888; x=1772667688;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1PPua3aUiq+HOnfdRm6i5P4KDZbGPQEEZ+yJiU8Ius=;
        b=Yz9jGhUBSC35X9VYROh0zNpNYOGkBAu5VtHm5pT7FHnsvP8+gQkv8kD85mElKJ8USS
         Rhb3TuYrHQu1FlVADdOXPpWUnt3SPvm3KE/ezVJyr9IkgxVydLS0hTSlenuGiBMZakEt
         +G2pXziABrQpRYC4cdS9Iyw4G7ir9cjjxVvr+T6DCrMB1nOcnkhITGbJc4LfoiaLTkah
         iDWFN3Jyz/6wAkiwQO8wvhO8zvMkwOIz/97Tl3+WbW9/YGG4D1s75C+qTkGtyVzJr2QL
         LUnui17lbTZmWVZui5lqCBYgCbuN+670Xp7C14X8sUtvBAmoDRN5ar4yVudNp2S1E46H
         q+pQ==
X-Gm-Message-State: AOJu0YzKMDY4JBo2I/M/X/3scrMWVHcvq6vLRMT18QzAhrWTAIFiEsW9
	fJ5ZbGyWDyNTDOn8iYeu/c24rNfblBdb1MBG7TVf2hkTdpR3Heu39Kz/MSYV4/jw
X-Gm-Gg: ATEYQzynWWuXPAOtpORykk5gEURUPPnSGMZRKdIz5b2h3hAD+qCeQVYgmTEVPHDqoqL
	u7JeYx327t+5b8o2vzNwsh6kCiN1BKlTs1hxRE/2N8umhzaXerSLXrlgJ9pdCxvKF6l0WmrbyiC
	GMqgQBVKbvrkYQUepo/xAQcqwQOmHw50KPIS6y8cvq7gy4ClP7F2/9hpMpHx46uByiW71oz5b4T
	0qZNqfnRsKiWobdRl+j5Oo/J67sAmtYYhsdJB1TEZNXNzNpqu0ev+BIV3FvAjL2tsr9eGgHyZEd
	bY9x614j2yqKZHuQ0GyHpWZDDE8+ZlJnw1fx9OWgFFEvVtDj115VfYygGVioPner58GOGFXadCC
	EiExT3Oczc0l23mj4Z/zDXKJvSlbZxg7BOQ9norXWz0VLKQWlK5OQWgDVuaprytNdSPGq3mje0J
	+M3MqlR/fTWrpYd0zeYyU3oJCSXfdTWMzojFfv1p+xdA==
X-Received: by 2002:a05:6214:29cd:b0:899:bbaa:7775 with SMTP id 6a1803df08f44-899c140040cmr36147456d6.27.1772062887784;
        Wed, 25 Feb 2026 15:41:27 -0800 (PST)
Received: from [172.17.0.2] ([135.232.208.153])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf66c515sm55620485a.11.2026.02.25.15.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 15:41:27 -0800 (PST)
Message-ID: <699f88a7.050a0220.33e2a6.dbac@mx.google.com>
Date: Wed, 25 Feb 2026 15:41:27 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4937896596233248829=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] bthost: Add segmentation support for L2CAP LE-(E)CRED mode
In-Reply-To: <20260225222345.199032-1-luiz.dentz@gmail.com>
References: <20260225222345.199032-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4937896596233248829==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1058038

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.33 seconds
BuildEll                      PASS      21.37 seconds
BluezMake                     PASS      649.60 seconds
MakeCheck                     PASS      18.51 seconds
MakeDistcheck                 PASS      254.13 seconds
CheckValgrind                 PASS      299.90 seconds
CheckSmatch                   WARNING   364.01 seconds
bluezmakeextell               PASS      183.50 seconds
IncrementalBuild              PENDING   0.65 seconds
ScanBuild                     PASS      1036.94 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/bthost.c:703:28: warning: Variable length array is used.emulator/bthost.c:704:32: warning: Variable length array is used.emulator/bthost.c:945:28: warning: Variable length array is used.emulator/bthost.c:979:28: warning: Variable length array is used.emulator/bthost.c:980:32: warning: Variable length array is used.
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4937896596233248829==--
