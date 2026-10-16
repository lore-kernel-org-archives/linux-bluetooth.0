Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB8B24E4A1
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Oct 2026 05:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792127827; cv=none; b=AAJTRZdAG0iSyc0rbxE5/OFGloND6qCDtKfY2R1+lbCbuvEilpzgb2jJLsS/b+Yv4uGH1ePZyi6M4WROUvFBLv9YN8RXOqoP11+hIX2R3pGF8Z0mNPe5BggMMCwBVkuS+FWLn8dIOPiCYmvq8QiaEydadSR+tgqOBsKJzoXoeCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792127827; c=relaxed/simple;
	bh=XtP+2xeilvoB+r9Rlzno19i8Z3qdXJJYQclcrvAdCVw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=UAbHx+93xxS0D4NXZHjq0JVNYeXklmbR0Dt2xH0aqTuTLlvZLIgW6OWYl1WLZzAma1ii9/u9lw0GmJWfyPf10VCL3ZHOicr+ilUdITd5hibz4D9Fwnf9jdMox1uum6l2KwbquQnMrLNr0L+VPB6Jn3kZrjcgc/7p9RsiZbfeb7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=szFbIQ7P; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="szFbIQ7P"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-4a6bb779d13so2402230fac.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 22:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792127824; x=1792732624; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XtP+2xeilvoB+r9Rlzno19i8Z3qdXJJYQclcrvAdCVw=;
        b=szFbIQ7PU4yQwblAubyK/FT+XgXLGFKNlZzdOoFLCnvN5JNl0nBTds7FI8d5KPTUmB
         XHkLPmfXCKOlpBbLjoiUdK25lUv9ps48uGTDJEt5ZwQMsBrj4G2IPUa2aem/E/FPkV6P
         3h+VrDuG7mRhyBWhRFVEw8PV2P5qv55OKugvlSTqVuXG09R8CnZ4Vy9gsHrNOoOYNMXk
         eJYYLKm+A+JiAkAt0U84gsj7rw04Zt2PIs7U3HEuGE01LxQmVk+Dm4nk/vmaocd74BOg
         NbovDSehTjS+8UmXEruZt4Wo9U5F3jSvJyLjqMLAQ4erPTumUJrpLRL2QuzFSVGN1dDD
         ROBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792127824; x=1792732624;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XtP+2xeilvoB+r9Rlzno19i8Z3qdXJJYQclcrvAdCVw=;
        b=ouD4DksVWa31c1iO4rpH/AIGkPf3aUt/9B0sgoYhIIAWZ5Kw41f0ilJ9xnLmNUKlrl
         u8b0q+CGVAIlwV5uEe6n4LMYIx+dz+P3CDuqccG398w6MBk+1gA6Keami5LcsWZDe3aM
         GUY1cB0+fM2BoTZnOUvm/l+JPB85ffYIr/HL+kPcdVTGwzTOjtDmX0Uo+FIe23T8ooGw
         Tjy8yvpxl72jFqYeLwiGi3fOso6/MzUMuuF1yc59doriOvxfnWw/yb7dXGuo+Rx74KsI
         87UioDUKKmBKpomVNx/stTnSgqDY1LvLRH5sLrUI945msTBYYIjoBO0+apZJ+o9FjU3C
         GyGw==
X-Gm-Message-State: AFq9FYJdv9REnEoNzg9z8wJhDlvfruvinQCNdEC8/cPYfImlbztT5/3y
	EmYbvxjd1C1vR93bIY3YEeEiP0Tngxcin9bEVpNXnfK26WpNc9suLFDRq67bd4v6
X-Gm-Gg: AYBFou1t2sjpZMuTE6Pm4qg52A8JyJXZyF/nlCLXJ3R9ioDSmrukTKtHooIni2KCt9a
	xNQhskh2Jw07KkNmdEzxqenVIHdOCuJTDyx3CXU+8tEXmdTDs9Kp9ZiY59qxYeGw1IDcZ53JEvM
	aaPv7ehGVErVcFkXH7agebKY6LqiJfVofhb1ouIHP2Ac7Lz5JJYSkNNA9mh6JjOzyN/snC/HP2C
	A4taEADp4j2IOlKEu2wwfDlrlrWrfz7nD1o1lWZUitphpIEpslOjSHiujSz/FOmpVyUvRWM7Oqp
	tulQB5U9y2MtosqFp01WhmvEL6IBVmtNu2AthrswokYnr6Xi/SBK1ivzY/Nmxw5seAcjGwAcOLb
	3f1pXp22ZkM8iRDmivCYOFm0/B5Ox0MU/HECf+UYXAN4Lq0xLcsHOlY58tvwmukcL5touU1hCQ5
	MtCgNMuFnLVwBgfx3wBa+sv/ByczvZQlX6x/EGH6N4yYUMeSaxYPU2LjDCmQVpLoR2eRzUG32+t
	A==
X-Received: by 2002:a05:6870:82a8:b0:4a7:4452:bcb6 with SMTP id 586e51a60fabf-4a74452e125mr173659fac.38.1792127824423;
        Thu, 15 Oct 2026 22:17:04 -0700 (PDT)
Received: from [172.17.0.2] ([9.234.6.74])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a73b6e4a79sm853396fac.13.2026.10.15.22.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 22:17:03 -0700 (PDT)
Message-ID: <6ad1b34f.318e7587.270083.cc8c@mx.google.com>
Date: Thu, 15 Oct 2026 22:17:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3618270115010231378=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, artem@trailofbits.com
Subject: RE: [6.6.y] Bluetooth: eir: Fix possible crashes on eir_create_adv_data
In-Reply-To: <20261016021517.16686-1-artem@trailofbits.com>
References: <20261016021517.16686-1-artem@trailofbits.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3618270115010231378==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/eir.c:242
error: net/bluetooth/eir.c: patch does not apply
error: patch failed: net/bluetooth/eir.h:9
error: net/bluetooth/eir.h: patch does not apply
error: patch failed: net/bluetooth/hci_sync.c:1334
error: net/bluetooth/hci_sync.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3618270115010231378==--
