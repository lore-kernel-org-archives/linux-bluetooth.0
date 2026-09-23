Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF634E379B
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 21:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790200241; cv=none; b=a1DyBrRh6ytUNCtu9sWNsEwiQEgzQh2cxcgYtzmsO/g0n3itIsTP8Zp7BJD9FeJN+cUIGe9NzVEpQLtZU9ycR+AeksrDKBmHlPEAzOLpYMo/8DrttGQsVzswOPJsxAC79HCNA0ObPa134xP84bIy9YIqaSqZ5I1CbuwOsmq0wp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790200241; c=relaxed/simple;
	bh=6h0n/f+deURkNJn5lJ4BbckSFWV0/xlj2Px2+u5/rls=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fdsdAAhJnLJJl5TvF8Cgi6uppZyzh7imcMMzXh27bLVIQlvYVsFTtTYxMR0ScYWfIKv16Q7go8l5KP/l0Q7tkhVUzZvTh+pa6tap2+JKTZrJWsW+9+3bv6ZhUuMCVUgrKDiSQzJ9hOT7pHhWOB2z+mSd01uYovnKk+TNAeP9ksE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLv8ANVT; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLv8ANVT"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-328664dbdd2so473258eec.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 14:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790200239; x=1790805039; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6h0n/f+deURkNJn5lJ4BbckSFWV0/xlj2Px2+u5/rls=;
        b=DLv8ANVTpCPNICQxSwYWVHwW/95iqduKr40nidhEhWe9IXVqjeOUKg8qqGwSz9CCWq
         BE5vNaiC5ujB8c3QZ40Aig6DTLK8IVJbsJR3uwXqOcwjochxJnNzA3e09oMqFlxXN2Am
         DiIiKVIxefsdXcc6BUpzvEe/lFVVjAL01v2iH4yBEigy4ulrLvTx8/kCBp4QvRaWzM97
         BGjc9BHaKi9XpFaVKQbekr/2Y99gkVfqnAzfjxBauwwCdvySSIl9r9r1DYlqCE1T1kou
         Tgxu0EjfgFwF8wwWGeTUFeLf+55ayXlmxY/vayXXSQDtIAd/lnnJ93e+BAIVTGyfPX1u
         EJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790200239; x=1790805039;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6h0n/f+deURkNJn5lJ4BbckSFWV0/xlj2Px2+u5/rls=;
        b=d2AnWch8bDfyuw3BGxL1aXE86zn+W/gX0U3LT5433rb5vo0iW71W7l9OjQfL0U+Fcb
         4SOTMAPTIHHMeX6oefGr5Ghbq+SAK41EpZWXIdfVNWpmRDmmUbyVWVDyPGqvP74CCUNV
         +K36c9yXe7yfV4ySV52GhZd+80Qqt7zjK01kKUMckWqwecuyPl6oTO+G6lEGSDWjwPDf
         tjQ8wbnz6b7YCb/PNOCrRqCkYfc2H4mREaHGjFNUc/IHbWieYPn7XpvzU2IuJa8xbBBL
         9J7doV7/zeIMDmAgir4b7LOjmoAgKjyDOLroCyLqadq14bRwJaA6kCXisHYBS9Wx51Xl
         NDNA==
X-Gm-Message-State: AFuF++mAmdUl12zr2dPT4CI/t/qm6xA0gBuieniga+6h9jXg/SVgo9fC
	aQKu+zICCLC9t5gijdLv7o5sA2W/KWWEPjL7murOtNx1V51H7wVuuSF2ex6ufg==
X-Gm-Gg: AYBFou260II4gOpOhR0LKIFdGd3x5CAC/cFa4nuxLNjt8/JqUNGRmAAnJHlzM0Gmq13
	cyT8SZd44wFvQe/jaKg9ulLDMIzTGmLuI/z+/ICi7CZGTPnVfXBdjF8dbI74T1Ig0eH/kuvK2C6
	eG+CJTzdXH7j03Po5AGGP3b6DwLZwjWHOXs3uLuJGGAemgE/P2atIY/RfhKRNKpDPvAR+uUAB2r
	v8KTLbbEv3aB3tVYYk1Dbz5TK7XkRokrotryBti1bF49V5uKZWKIa1bneKSoOQcxMV2iXz10W22
	EFzGoALNAbEeLayvZVQVRtOibPOwb7kkL4lB5p41RkrQ17cEcWzzXCOpWgIc4CHvESjpnD/UiLs
	exnhElX8IUdeoAD8e1F77sd5V+fJAuDwmczYtj3TGS4jhwKV/CIDtI3ANCpcyrLHjyJ3BBvvTWF
	Yi/Ajzs9cyEGBAG1JaHr90Tx3H7YT05dccCWypPNWhCctOD6gVIJMOso/++b7kzUKDlVKnhNjts
	ks6
X-Received: by 2002:a05:693c:65c4:b0:33b:f87e:9e24 with SMTP id 5a478bee46e88-33fff54fdedmr321394eec.0.1790200239218;
        Wed, 23 Sep 2026 14:50:39 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.93.185])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e9684d643sm18714532eec.18.2026.09.23.14.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 14:50:38 -0700 (PDT)
Message-ID: <6ab449ae.d153db54.1da6b8.b403@mx.google.com>
Date: Wed, 23 Sep 2026 14:50:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0705784710108046809=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,vRFC] doc: Add functional-hfp documentation
In-Reply-To: <20260923203105.264648-1-luiz.dentz@gmail.com>
References: <20260923203105.264648-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0705784710108046809==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: Makefile.am:501
error: Makefile.am: patch does not apply
error: patch failed: doc/functional-testing.rst:15
error: doc/functional-testing.rst: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0705784710108046809==--
