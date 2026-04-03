Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE9535975
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 05:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775192587; cv=none; b=T6+mt1DYmYirZgyiunQjD9QcklgZg44dDUHfUvJDFokDrwVksh2W8Jsx1IDXANvjoOHmnFCkW5TVSD6xyRPx64xm5FCls0rSLdbvfUvbEcs55KnE6mmwGQ0+KmOiW3qGbwVgMkKDvesB0MlovXERJLexYd/nQ4J/VinfEUAVV7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775192587; c=relaxed/simple;
	bh=CDDxvfZcrozZ814W7+WHm9rW+n/GYAh35RvppU7ttG4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Ud25AAsjqqQl0x3cb4vR+a9sRiQsqH8CCOgBDOCeqUaW37QysZRCLOOqyNfjCmTslrUMpgMYRwGOEF5rr77dTtIHBRcSgnBwEQM5iQ0nRPW2AEAzjAsw4bz0zVCI1J7JX/VAfQglWdekqxonoCC+9dnwzFFKTg6dOgQvy86qaU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oI9Pwi9c; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oI9Pwi9c"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso1046774eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Apr 2026 22:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775192585; x=1775797385; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CDDxvfZcrozZ814W7+WHm9rW+n/GYAh35RvppU7ttG4=;
        b=oI9Pwi9cUbrYPHZwGRUhAUjQ17MOzpGDm1BKshBphDafClRjkdo7wE6592kqVMcSCL
         nW5RYnvO8liGbXW5wzrXYajIljwgpAJ2fp3JopTFrTI3MIt+eoQFD2Z4oX8d/ETtj2hr
         BA70vaGICIwbk/8PyDIcZJXN8dELR3i2DmzK+ze421B3lkHOe3qDabsVTMxooodl2Kwc
         TEdYJuqMbOKG3BKWAt/oaaBsCoxb8kaWaR6Lc1UCCwW2Ozpxim7zyW414BQBPC/jphW0
         r3PymB0AvTl2gy/VqfqEcJ/uqxdgTdwsu77LuFOZXPWh5Pmc69flRcheDItcOi6zxUHP
         fgrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775192585; x=1775797385;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDDxvfZcrozZ814W7+WHm9rW+n/GYAh35RvppU7ttG4=;
        b=ChN7xFb/pMZSF3y/xQ3nSIErAxaKDC9bzxQPp8nXS/syFOxz4G/CuGo8kK5CYhii/P
         7bHwbURIYGG+mrKvImKe76u8GPLlFgIyQrdVOkwACTtutm+kOm7SQBmtgsYG/07Yjx/o
         cLm3VUriNPZ4AKafK0hCpin8/DRqD/WeKJIk6AWzGtdWSlOamXu0i44YqGge+PBdbq3i
         /2wJr4ENDwVz/kuu61zjI0Gn0YrrAUyHRtRkuyBtoRujJqH2a5Y8c/puuqYbzBTBVfcm
         9/7uL0WZhOSPPhPALGf0AxXMolFHVWKqX6BzrXFvm02Vy0d5Ng8omLVWHETbFLaVS0vy
         N+Fg==
X-Gm-Message-State: AOJu0YxplP1JYfAUelDJNj8vLGGzpWahTxlyIhsaa60uAxg4NdddS/io
	Jj5lPo6nup3Ftv5YgngxZw9CP/Ev7cBdtOwmjEwYvvO1IuPxGTgwLHEI3iZtOQ==
X-Gm-Gg: AeBDietn6Cxt7cLTK/Cah+OGnvT5s6n8vCkgklX5L47Ki40U+I9ar4nC0kHaYzwoDVf
	9efWerhEzEBpsj0lOLfbWTNXWYL1mVmB6eoyHx2r7BO9g69GWQcEVfZCY3GP6aPTNgzW+KuegNY
	GFo0GgUP7zwm0+lQzfn3Hd9mcU2dS0MlOBk9mY7H7VyCZWBbie5C0bCotZ94XXrgQPBmVzdfXuV
	NqRhcHlZEmoQyT8Mz/d5xm/4+/rFBLASBRv8knU39zkGo3XyMpXWEnuJc8Y/fhQvR9bGKXy+RLX
	dCoaQjErPbssdirUx953plUWKG2gloqfTDsJRvy56h6L8YosyNt7AY81UNbebFuqJtvD9B1ABSK
	ND+EQIt+sQ5JseUU/m9cmMwM6TVSRzWiuOsWXDaJTs0GZk5ByDzebzPXYfcXovB7TmWdO3EBKjK
	Rx58tfJBcdedxwLMI46Um82TvIRRAGUYs=
X-Received: by 2002:a05:7301:d17:b0:2c5:c532:1fe1 with SMTP id 5a478bee46e88-2cad60cb61fmr2117332eec.3.1775192585090;
        Thu, 02 Apr 2026 22:03:05 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.117.145])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7c7f268esm4267770eec.20.2026.04.02.22.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 22:03:04 -0700 (PDT)
Message-ID: <69cf4a08.050a0220.114c76.66b8@mx.google.com>
Date: Thu, 02 Apr 2026 22:03:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8474434604796260174=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, phx0fer@gmail.com
Subject: RE: Bluetooth: l2cap: Add missing chan lock in l2cap_ecred_reconf_rsp
In-Reply-To: <20260403023513.25151-1-phx0fer@gmail.com>
References: <20260403023513.25151-1-phx0fer@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8474434604796260174==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: corrupt patch at line 26
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8474434604796260174==--
