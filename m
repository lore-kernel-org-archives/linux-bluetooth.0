Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B402AD0C
	for <linux-bluetooth@vger.kernel.org>; Sat, 17 Oct 2026 06:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792216931; cv=none; b=TZ7nHZd0kp7RD3w5CJRVPZ2vMVOkBm9o2/qPrBJSglclshjvvV95vKuuBQEP+j012fIltnKuj1ZIpnCp8asA5dasu1//gvl8W+9pr26XHrP8wwJ8wv9JW+7LZ0VS1i7fX5fC0VbtkdUJaL3dSK/1rLuyCA8vDKfxVKXHMPakjV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792216931; c=relaxed/simple;
	bh=eyugf3jquUe5wDG8mpDIpivqXAhOonZaEuAOiMF1FRE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dfb9LUYeoDIG8BuEoWaA7xETUJUpYs3ovbFYBl9T98ZiBPsgga+g3fTNko/1NgboN5yXt2WCCEBC3U324l+LNEP6tbO0pygoytkDVPS8a1/ezSMgfGuGHHwbeLcX037pHeWz4Du3dPbytUDGQ+WxPHslW8mPUutQN4qP8WN8tUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rh2Qhj2I; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rh2Qhj2I"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6fbf1ba31fbso254408eaf.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Oct 2026 23:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792216929; x=1792821729; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eyugf3jquUe5wDG8mpDIpivqXAhOonZaEuAOiMF1FRE=;
        b=Rh2Qhj2IE7Mssnx0W8P21Li81l/U3wFUjAnOVMrMqbeUWVyA+oFsC8v0EwYpUds/VS
         sLw3EchbVHri0tKkwFMN8QnC4oGqOq5+0XKmbh97x52fCiXfeZws7s6m3D90qV/amvOm
         Je8tkktNG1+9KyWkShnchPwE5E/wtgDG9ng/99+QvUrg+H/CUFoXG/gSLfo1He4RdUy8
         cOpQmAyq0FTCJ7yZZoVWuCwrUI3WFS32iYwowQyeSNGDBT+q13OwclfDxZlLBt+k7jhY
         bCR6lPN5K2J78C28pZWPI3C+DibDETvXO1mJDgnoaPoyNQSAe/J+SeKF/IUecGzGUw6G
         djUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792216929; x=1792821729;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eyugf3jquUe5wDG8mpDIpivqXAhOonZaEuAOiMF1FRE=;
        b=f0Ev8RSrcuqzuguYqMHwjWcoZkfIMMX7HmZntjfUMYwpCncnCFtZOYbuQGkLhE12UI
         jue/NEZPiH2Q+ehtaNxJIutYKM2hrle1t6we/me+IyPrmikCGxsfClCEkJVpdVHHpAPr
         UZ4GJDnV5tKcfyNR1l0oqwoq1F7DP2ba01S1qtT7Cpjnl5Kd/v5eW6GP/qk/b+HPdHhZ
         LN47XCkSJkV9NwhmAMTL322zy2Exf9UyJOReEYsLxPYWl6jby+Sv/UtxoJqlrP27x6+i
         WhGoJX/94/hp/qxLJDwh18/kCh61awVqr6AWLzFUczFXD81OA9pkAdqapuscodFOHA0o
         jqOA==
X-Gm-Message-State: AFq9FYKLmvrmnVaVESgLD3LbQwjc8Dj70HrBc5q/1MIRLToKuC7mLTEN
	gKSsuQS71qx+3JBoXjQ1k+XVHAvP0DcMhEjJQ6uIXZrUn2KmVM+Pjp9uGMPGxw==
X-Gm-Gg: AYBFou3FNwfPf27jBCKPAWWn77kE6qNiOMdQRNY+1zBmQ5HSAbCljVDzN76c/1T83le
	OXux0h+VVPlNgdHzklwKnDq01Gu3L6vUsqC6nZjUbj3mMEt9o1yBmuXzUkZt44AyfvCAkbNP/oC
	xj6buGgw4kdxEgHdFPswO2n24Hgv72y12KX61WFW+plqJ5DiB31WOUuSiKMzyrT3p7ew7GRcUvv
	643V4IS0MvHC6KXcThaYYst304IhK23d9O0x64x4YCmoZpIO1LRiJsOnaiR5fkvGz5DAKf/XY6W
	gQ0R4isIwkmlxwWRGqQE9JMTmLrxT0GrEnchKfhwDEL2bjZBN0ODuvDOcy1fGmCAjeEEGA0Yxd6
	MVcenrHGGgXkkgWvCFfTk8rAI2CSlQraHq0XK+RKJd9ihoVJyTIGUrNtIGp/UBP8ltpMtxChnMX
	GgSNmLazzDbqmlaNOWNfor+YfSNhoFeLEXE0qnCkPmBOGjnkTHqrALD6080389qlWYM0vbPbmhj
	T/IsOA=
X-Received: by 2002:a05:6820:1ca8:b0:6f6:3762:5f9c with SMTP id 006d021491bc7-7035229085bmr1357833eaf.11.1792216929526;
        Fri, 16 Oct 2026 23:02:09 -0700 (PDT)
Received: from [172.17.0.2] ([20.84.157.246])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-703abed6c24sm638121eaf.5.2026.10.16.23.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 23:02:08 -0700 (PDT)
Message-ID: <6ad30f60.963fedab.31043f.0d6b@mx.google.com>
Date: Fri, 16 Oct 2026 23:02:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1984747472790538113=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yaojiale02@163.com
Subject: RE: [1/2] Bluetooth: MGMT: free remove monitor command on cancel
In-Reply-To: <20261017030939.3615701-1-yaojiale02@163.com>
References: <20261017030939.3615701-1-yaojiale02@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1984747472790538113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/mgmt.c:5682
error: net/bluetooth/mgmt.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1984747472790538113==--
