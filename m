Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4882F12DA
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 10:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791626902; cv=none; b=oxf2nnsJZKPoZMkd0XW1IzjVZWeDUSnJ42T8XqYK+NQ1aGbht6/VrV9KkZ8BvZn1AgRLYqjVz0GtSDY9O2sih0z8z+PoWlLh0AgBmbegLVGfckExSwNiJogVQPkdZRNCe7sWw+5rOtI2/Gr0uaxp7ljufkpqS1C31Q7uGACnO5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791626902; c=relaxed/simple;
	bh=7qFkSKiHx56W3D2rmqw2lp7zUPM5bA9W0cdhPghglHg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fl19efi1EaIo9qg4TmFoE9ncuDRuzm2XHyv408dPHVqvcI6MHHl5m058Tit7d4rRzvKQlg0okBbK4Bd4vl3WU7QY8283NE6t0x8mLY+az8kbr2Ebd+TvrgbHWCVrcYoj02iTcNVBarw+bhbdmfhb7psDsLxLqlb4/CY5H86XXJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHRlWwLf; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHRlWwLf"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso1407635eec.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 03:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791626900; x=1792231700; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qi+XUuw600IasuixlW+bxAm1DKV8OYsRMPepuHKBcvc=;
        b=SHRlWwLfkTZFFx+Mx9zu+HLwBScYRODZHt0lmioVTxt8lnBEhrnyZuff0+uJA4p+M6
         jXgE/oMYAxbuHN4P5Ns5NfbGtjqBwnlpV4iLX45zEih0HIa5grrC0ziJJh9leZz8QXly
         HYHIMzhXEHKvdeYARjxs+zkn9jTNkzB3bMt/ENZDRN+GfPrC6xeI7uVzoNrY/VCf/UXM
         ZWHqWcmDOeZl7jHP4Av12CROOleh29DeHCRvkqnfcNddAfioj/nTqva5nCZ00c/6mR/b
         Y+hmNztMHheFLHYmf36igqKmrYzgBnllP+MKptImtca3sKWda79He/MAz5BxKD1uxy8E
         QIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791626900; x=1792231700;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qi+XUuw600IasuixlW+bxAm1DKV8OYsRMPepuHKBcvc=;
        b=JffXRQKBNN1mHjYLj9q06+6QRpGMbcKWFe6WknOrvWtMonLUM3/5MUcUubSTINEjqe
         qeqnqi/5+OiaE5X5h3shElumXjl36q6z/Ka+EZYX40owWKr3vOb+YaJSHPg0wMgORnk6
         Gzo8/CP+v/1ijdG3vvdqqzDOgCtxjiZXXDsq/vRU/D3ea+hJLTGGNWzF7yWfZVMyArQX
         efCh1suk4xPFPSWHNVZop0RD6QJ1Q4pbhAreKd1HXP1Fc096NATQT2Srqbnilj9SKm3H
         kBzvRXaSaOzr+Q1mm58N+qbramoZgecjlqbPnq2SnvaVQo0oJo2gXlwyvyTD+/ZhAqWK
         OtGg==
X-Gm-Message-State: AFq9FYKABXiuxfOd7gBCFERw+ZWhBATKFudkeBCdfIp0ADjkvx39NTRd
	3w8P4/LDxXHsoNViE3nXDQIzH0sAMcmReWxEV2MVV7YYR+pAssz2UfdF3nqYrg==
X-Gm-Gg: AYBFou1lqz1Sf7KoOozY59wpfuvcrByARTHZHS2gNgF8m6LK0ghVzlAbLCGkq15yNJA
	gzm3MmOMsGIx8UMEDEWSNzSthiRhCvfpSeChDQBUjKsIbaG4CdA4svJhKh2TqECiIYFbrFa05ny
	Foy+uYhJ8Logb68hW2we6BOptz6vyuaYSsqcDgqmrVbxTzA7FppxDroc2RaowOxqa6xIn2wgBUg
	v9yZ2v/YUxkq+hnO03C8uYynzeO/fv2sq+K7Ma3Z0BmytctFWWBaCW5To0G0C3QfyP01zI7y7sE
	sVSf8h5LlKJSNQPGvPadt6GGD7s52qzVetbYoTN53qCem2wqoR/PLf+80SLpHREfg7raegvz69M
	/6BJE/tOXKNuXh/LBqpSQtTZj2sqE9UOEaYMZBtl7rXtqcXs/xCwNr4K0jke0N+nkr5lCV1O87q
	Xl9SytehfpNUF0fQrmn2CYFxX7DgBDssVLV4do2DoJkIcaxxcXxVh0tdZfpdTB7qtAzR+2iOizj
	n5YAw==
X-Received: by 2002:a05:7300:e5c2:b0:358:2e30:8e5 with SMTP id 5a478bee46e88-3582e300988mr2177258eec.1.1791626900057;
        Sat, 10 Oct 2026 03:08:20 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.244.65])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c61eaa0sm16673508eec.0.2026.10.10.03.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 03:08:19 -0700 (PDT)
Message-ID: <6aca0e93.82a2a138.123ae1.3ed3@mx.google.com>
Date: Sat, 10 Oct 2026 03:08:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3922400938621682068=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ye.he@amlogic.com
Subject: RE: [bluez] bearer: Cancel disconn_timer upon btd_bearer_disconnected
In-Reply-To: <20261010-bearer-disconn-timer-v1-1-12461fee99f1@amlogic.com>
References: <20261010-bearer-disconn-timer-v1-1-12461fee99f1@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3922400938621682068==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1182837/

---Test result---

Test Summary:
CheckPatch                    PASS      0.29 seconds
GitLint                       PASS      0.21 seconds
BuildEll                      PASS      28.00 seconds
BluezMake                     PASS      391.41 seconds
CheckSmatch                   PASS      295.22 seconds
bluezmakeextell               PASS      95.37 seconds
TestFunctional                PASS      1206.24 seconds
IncrementalBuild              PASS      379.10 seconds
ScanBuild                     PASS      1142.83 seconds



https://github.com/bluez/bluez/pull/2657

---
Regards,
Linux Bluetooth


--===============3922400938621682068==--
