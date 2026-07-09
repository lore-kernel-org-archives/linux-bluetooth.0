Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05574028E9
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 09:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783588747; cv=none; b=ogzaPCHzSfMTheY64NkYqVE/UxvyAttuyIC25ZWegYl4YAZPruAkdTjiYEJD8L9qgC9TSdfJNAblMElXhU6LQOSLktQXAuJBBPPcsos5tef5w2Bz+yqZF1KZgkLwtUgFQBwspaAjaSUwL0BjtT87ffH1du27+tylTTK1qKTg8/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783588747; c=relaxed/simple;
	bh=uclMkzwUy+G2c4apmqGsCGnkLy77aZPjoXndPws5smw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=d+A3pl3wqU8ay24cOu/eGX1ehCma7iaayDJR6f82j5HUgjsjcY4SvukG1myKjeP88ozU5Xd6AAqiJ0KDNtOk+4Kue5WA2chp5xENdRNShYFGUO7XGlzX9X2y9D9kVakNbxiuQRzFVJfc+WazAbYocnbnxouJ6JXms0i6oC7M6I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fiK0EN1d; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiK0EN1d"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92e51d3d83cso81726585a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jul 2026 02:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783588745; x=1784193545; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hrMqizGaa05KASJlishpkBIj6+CwZLnOY13N5s+tUBE=;
        b=fiK0EN1dCsW7wfnIvO1Xi1tKDcMcZZzZc4JHKL3Cm0+EAb7Yl3y1EDlLraJo6ECFIV
         jJszJAnOOX/GpWXJWCvttcUhMFiwf3pgIK0iP20ZJKv4CryossiXpe44aQ33UG8NRDl/
         Yy8lz+hSnD1b944NS4uQ+rhavBs/adX8VDxpXEzQd1i/yd8Cp1yTf9bnn6ALmxgrkI0w
         ulx6A3mxLyd1mqxrumlGvkOeiTbt2PKlptSbMUmYtQyPo0zYWRv4b3Eob6CXDZq/LKGR
         Xcpw7QQvUEAjpfmjKlfVIurVWai24jRSkCZgSwB578jGe34nVYdlIwUGOduyxugHJG+G
         6p9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783588745; x=1784193545;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hrMqizGaa05KASJlishpkBIj6+CwZLnOY13N5s+tUBE=;
        b=JjIRw3COrFlsgBLMOBpPazjgOIT88G6AYOhhvW+FvpzCUn73at6svupQWMKUW3yCRq
         7bplzIFTQ6fOnxHLB2rn3JCGLy0BqPrt+Xl7Cr7DmIyetFKJAE+P58Ayq57T/r/1DZ0j
         K5m3I7tVZ61mgyoLY7UCTY/NGXDxeeZ07wM/bstUPcxiWz7Z5COk2ZeMJ457i/SjpWe+
         fKYh0sBEtAEiuF36BIARBoCnhOd1tHEuTqDAJJFrwU5xrGXPzfFJCSXyCQ/CyRkIHApF
         +qNcji/8tTYUH4rMc5E7JZITJbreM+iqizisKO40hRmY834LTURFTGYB2b3+To2mcfSb
         9ujw==
X-Gm-Message-State: AOJu0YxQ3ZB059vMcTGCxu2xK0FGYs/1Vwpq6t0BoN58O18s86Uv0Djp
	BK9GGJGUSiaEKaQEMuWX6G3lCiaE0ko7qJyzNYcFDX25tnv7STseUjOjifb6FA==
X-Gm-Gg: AfdE7cmgDOXhQs34a35fHEfzYgaonv6VfISFq3W5TKexdHUwmQn2w+dUsePqwk2vV5F
	nngMoAOH1fA9+uMompPOqoZR7Jm8ZKduN0LZFN6nAOQRtvxMtkm+2qWRV3lNMkhBUWJ7CGOdlaK
	2kmxRnaQ6fR8xL7qhAUcwSNUkH4FyGwcKxnS4CgQWhApuGAv6T/4HmmS7TZPJyO/k7EPIgKGycf
	MtmT4B/B5iyhvbw3WxLTR5Rx1mjLYsXLEdKukBnC1hQP8jhefjchnMHg8XjgJpJGqeZLQK9NZuZ
	izGSempWRJ33VKLDj8fzfDA6RfxStwxVNNah+bNrqTvl3rcHtybI6kke9e7g+PBSyVyaXIWadQf
	JjeizJIWR0JZBFNlYBdrKU0koxvY0z3YImaWTHzeSw9mPlZKWzy7H0XAdbzR9FHHk1L18EA2Y+S
	tRF/LULRv+jAzHtpbwr2mb
X-Received: by 2002:a05:620a:1725:b0:92e:84f0:d3fb with SMTP id af79cd13be357-92ecf622febmr641067285a.15.1783588744859;
        Thu, 09 Jul 2026 02:19:04 -0700 (PDT)
Received: from [172.17.0.2] ([172.214.45.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90b800efsm1566684685a.4.2026.07.09.02.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:19:04 -0700 (PDT)
Message-ID: <6a4f6788.9c25d69c.cfb90.3f83@mx.google.com>
Date: Thu, 09 Jul 2026 02:19:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9191327222720478135=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ruoyuw560@gmail.com
Subject: RE: Bluetooth: hci_qca: Clear memdump state on invalid dump size
In-Reply-To: <20260709062250.4166128-1-ruoyuw560@gmail.com>
References: <20260709062250.4166128-1-ruoyuw560@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9191327222720478135==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1124325

---Test result---

Test Summary:
CheckPatch                    PASS      0.82 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      5.21 seconds
BuildKernel                   PASS      27.74 seconds
CheckAllWarning               PASS      30.80 seconds
CheckSparse                   PASS      34.04 seconds
BuildKernel32                 PASS      27.48 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      513.18 seconds
IncrementalBuild              PASS      27.01 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/415

---
Regards,
Linux Bluetooth


--===============9191327222720478135==--
