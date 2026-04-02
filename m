Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0DB3F23CB
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 16:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775147629; cv=none; b=ngOz/57YTS6bi9xU/bARKm7sxZEUE6rcYfZl5PNl922BAsEsjwVrCDUXQ5Es+uEXPid96NvG1NELqkvqQmG4XgwGEQoMQ/I0AwfgjrCGZhNQmDXeouQgO05Rs8UGM+nai+JLAnxe2C6DLtGB7YPuPsV9RrbMyW4Iv8/jVEPDJDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775147629; c=relaxed/simple;
	bh=bdY9E17nkxKz+Evk/WM/SGqPFLeF4pKn9r4ekjEB37A=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YGRyc8DlDRC2xW1t0KWMAKGSOis+xGBlpJW//AbRClR+xLrPoTxVSBc8SmZX2stn7WMbcef2xqA4t6SCh7G8YINEjas0vRoi8ixFG31ot/0UwXGd570mW3+rRNjTfRxHrWlgTU2fASjG0v59mFuPaeZiKWyjmXmN/26Kpsd1Cgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwfrwC7x; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwfrwC7x"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8a154cc6a48so13619756d6.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Apr 2026 09:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775147627; x=1775752427; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bdY9E17nkxKz+Evk/WM/SGqPFLeF4pKn9r4ekjEB37A=;
        b=iwfrwC7xcuM5ybjf7SVGcIsN5h6n0PWdldTwHLRiWppPmitamZzJJwx9EV9+YXJnLl
         9pIP6nj8g/MauAvZE82rU1PRdJ8rXCFkGLUtzSLjdC4GTOJbFEhGJ+JcZTmFFxXYJYBy
         yolrNLbO/aqoC2Ui/xj7ZQphJ+GUKkWiBS7ILN88/Qs2a3TcpUIUAF8e7mba+rAL4NCh
         FwAu0FGP346EM+xQPGTFUX17sZsqCJKiHkocLGpKyl/C2d4t7GTCo4eGWfD1jnqXLaht
         RfLngGWUv7Di4OZvhdSJF4ADZIbJB9tcfjuwI5An5MUx4UgTIiCel+UDR2zxqTlbpfnI
         /rXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775147627; x=1775752427;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdY9E17nkxKz+Evk/WM/SGqPFLeF4pKn9r4ekjEB37A=;
        b=OL+FQZiGYUIrOtKlFd4F87WsQ1eX3dTcclIYcoJ6yxKlpdV0bibr9Cg0AfvosZ+N+X
         bXiiLsaW4UZBQRQqlzRF3KdPbc6hEikh7UamkHu6ikI3WfSfA5jGMdibDwpd8Yd2IfqQ
         OtvQdAl0ASUsrpdVZILaQXBW4bJ8u+y+CZla991ipaX3CgWO9eEJ/kM0Ciba2jGg/nre
         EyoH4U1Aw/tAPIU3oziseUc3YanYK6b+tQB88qGx4Dpn9t8+x8AQoMEmEqkkqmO3q0g8
         b0R649bcuiEcidKxROP9LSP3Luo8U847RKQvhw4TP21fM0he9G+mkkN59CoRLvbchcfI
         VtDg==
X-Gm-Message-State: AOJu0Yw7VWKkq4s9sW3Hoh9r9nrea5pQ+pCK1DAqYMHwb0vMV5wbpqyL
	7/BwiXeA0uZBeaArL1rI82gHZTvHLMJGtogT3zz/LMlGuta8UziE7lM8EWRaqw==
X-Gm-Gg: AeBDiet1AKJfAFBKWOdLtA1BRSfIt/Tm5mEkvOsPkiy1egIVV2LTwQn8X7Neb4j5Y+p
	c/PgspIpl1LM6G+Ws6es3YFZqXNBDjeW5vGXdQVtDKwu6X6UJhLn6HO7WsWEtV1CdhPUW/NCXdY
	TlvpOwyqgfW9ihBc8ZFL9mNEvliXxFxFQdDGQ1KpYGI3ItfuTl73/lPu9aFNA2Q+R1ABM9KEaOj
	kDP/JGwIRYWnfTJclVQt7nlguZhGDd6P8czZ973e3K2OplW3fHOaPA7qQonpgfDq3sTnV22AJ7l
	1Ag2UScnAoOiJoHrCWM4UqLYXbkEgpIH7MK6PWim6NFVV99mDJtCvjBs5jPnlflW/2osMdswHWa
	zTmhogvSJNhBUxawXt1UcbVWDzJF1sXBeFNEVBVw2nHjx7lWHZ8fViJEuH3rVfGv3UPJZS5wL1D
	n7UU+i9fml+3vEk1/JZnj/sGUUq7lSHLE=
X-Received: by 2002:a05:6214:5184:b0:8a1:be09:94fe with SMTP id 6a1803df08f44-8a43ab45a08mr125571106d6.52.1775147626916;
        Thu, 02 Apr 2026 09:33:46 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.137.134])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a593333516sm25564216d6.6.2026.04.02.09.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 09:33:46 -0700 (PDT)
Message-ID: <69ce9a6a.050a0220.1ecd9f.f15a@mx.google.com>
Date: Thu, 02 Apr 2026 09:33:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8499753708830765303=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ,1/3] shared: Add single-link list implementation
In-Reply-To: <20260402154520.48939-1-hadess@hadess.net>
References: <20260402154520.48939-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8499753708830765303==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: Makefile.am:700
error: Makefile.am: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8499753708830765303==--
