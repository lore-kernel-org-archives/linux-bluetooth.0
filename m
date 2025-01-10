Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C337D2139B6
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2025 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736533878; cv=none; b=JjifeEoPlYO35K8mHgOtfb5dISBgCaqHJN0AU3a7drRjdu5X923vn66lC3amLLqTQ9C2q6wGs/mpX1c8/ZrHqsTFsHr5aVRjnNiJSbh/SKxBzRyCjLCqwgxCjscS1FdOIWdEBWxUBNtdTeAqVKKNAm3fg1sjjn+FlUTXmTrBk7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736533878; c=relaxed/simple;
	bh=Nvl4ebWoB7Azy7zFHmkcTa+mguciZbzxPBu4xYXW2bM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GSFrEqu1u5SBDiV6vTePo2BRMaFPVSH+CXwtWFheh16B68m2a9listmYcv4CI7C1h9XO1pRVbPkN/T4mWo39KN26L8Xc60HZ0MixzXNec5yTMylGA8+X31PVs8PzAY1YiNWr7bPqaydVAWOeGBiPyU6mmhqxwwqHElYfND8uM4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ER1Qx4+h; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ER1Qx4+h"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b6f1be1daeso203181485a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2025 10:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736533875; x=1737138675; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6Pz+GkqUr1jTcFU5Rf5CqkomeUWKNCKA1T3mZtr0SR0=;
        b=ER1Qx4+hd/6Gt/BYQJUac8nHn0MzPJBIGKzjFVrdxnf6rc3RYC3z3jGW05eb817FGe
         Br0zYOFvEh3I8MxAK/mAMrrGO2xOJ0MQTCxflXfCheYxCujp98Lb7S4r38GMt73HbmH1
         h0P3CadTu3kdVCgVCmNSovrVJkJ3KO3fqn2au7GhgezvQLRt7Y5oFpU1gezSfxmbow+f
         GwJKl3OXbjPhxdMty/8GqYCbVkv5py6YchEa3/lVnaATz8bM99JGU7UvINZkGf76c0tW
         CjLRsTXhO/Ni4trwhUskbpWfHLeR23qzk3ZBLm76jbo5OiNmboPUlAKSTf4llKhPEk2G
         YS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736533875; x=1737138675;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Pz+GkqUr1jTcFU5Rf5CqkomeUWKNCKA1T3mZtr0SR0=;
        b=H3/NkkFCa9lyFYsGYJsp/Oi1/qYlsO670CJ/0WqJ+cHolbslJeDCMSDtb5aAH9jMvp
         J2lG/uUKL60McgU6jpWIN6RdXksH+5Gq2PcQ7+YDeoPx5RZQQ1xiMfeijeDs2Vxutgsj
         t0Mcu8BH5J+oa3i8uHHmwbVKzr5tZmPygfGsmSE/x+tyTglaEHZVSqIoDycDy2hKWQp0
         yW0Vdox6HPtRC0MZ02u8lNhYZr79JtXOstLA6ZR9LrpTEDh00hc/nbh3IlnDeaQo3BvZ
         7l/BjKHm2kYlEiwu2Xa2xjsGifezC90yV/9+FZ7yXPfu2vTh9YYq9/mVywo7QJVHCwtw
         NaNg==
X-Gm-Message-State: AOJu0YyL7jRQO8e187ODxV2njEToAOzGhCp1lqlc8as3eXdDNb5Ac6Zb
	KqGY7dvgQFSarAAYuwjIKKRkqZJ8qSlx8iMi/1+hj+LqOBKB2U+v+PSPUg==
X-Gm-Gg: ASbGncu1U6nANSHCP/DQt1h/zPYZ69YqT9g0JGA3NWJB51qWGuf8hXX7l7Cs78ajg3R
	rLj5cX7UAEQReoYrqRRqYr0OBs7In846AFXbfOToguwph0j5Gc+UXJ0/lNuYQdhN5KnmRNpZYCA
	E/kNBGvfUidmF75paWG27OcY7lSnTYbCeaY8mH8HrMHcgeWNcYERTqPXzoZP6EKYSD44TsS7FOT
	NX6/HfkyUsOWcTE+zkxHlZQZtJ13O3B4CoLixTGYSnwqYG7TdbHQfI0az8277gK
X-Google-Smtp-Source: AGHT+IFMqhBPbXMkvun7vGWfKPT+OxZrkrAlA+YEtxS6vPb1FZZTgYtdVztm31Cd4p3C49sg2EXUIA==
X-Received: by 2002:a05:620a:17a2:b0:7b8:6331:a55e with SMTP id af79cd13be357-7bcd975a181mr1950230285a.44.1736533875478;
        Fri, 10 Jan 2025 10:31:15 -0800 (PST)
Received: from [172.17.0.2] ([172.183.229.88])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce350e155sm198157785a.97.2025.01.10.10.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 10:31:15 -0800 (PST)
Message-ID: <67816773.050a0220.130f82.983e@mx.google.com>
Date: Fri, 10 Jan 2025 10:31:15 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4570351383725517338=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ludovico.denittis@collabora.com
Subject: RE: [BlueZ] device: Clear pending_wake_allowed on error
In-Reply-To: <20250110173146.309964-1-ludovico.denittis@collabora.com>
References: <20250110173146.309964-1-ludovico.denittis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4570351383725517338==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=924349

---Test result---

Test Summary:
CheckPatch                    PENDING   0.20 seconds
GitLint                       PENDING   0.25 seconds
BuildEll                      PASS      20.59 seconds
BluezMake                     PASS      1509.98 seconds
MakeCheck                     PASS      13.05 seconds
MakeDistcheck                 PASS      156.96 seconds
CheckValgrind                 PASS      213.77 seconds
CheckSmatch                   PASS      272.33 seconds
bluezmakeextell               PASS      98.24 seconds
IncrementalBuild              PENDING   0.30 seconds
ScanBuild                     PASS      863.29 seconds

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


--===============4570351383725517338==--
