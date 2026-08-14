Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9B3483BEA
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 15:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786721393; cv=none; b=lCr3FVSILmdwa+uKoYjpHbJIBPeGZrDGlqm6V/mfVGUUT3AFx10v0svHdOPvtuTpdZHd6iTnXY11SExjTlqicA5DIz7wG8Yrn+GTSRuJMn/S9jYdxXujW+nfAkVVEYS706lbMAt/wdn9o9g0h3pn47vho7Xlr25folDa0cdXNX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786721393; c=relaxed/simple;
	bh=6iGJ2PTY6PVB2uFNU0HVV2jH2CnnShP1u7O7w/f1eko=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jTZaYlrl1NGD2C+swxPOe5pPOottDV8ONzDOV//ItZawIyZbk2adDsCmb7EcN3DI8HN6lOPWPjAZIayXrnZ//bfjHYzwlztRAKeVcXWF09nUglMpw0DY54jliKLkW5t3CyQUJWmu/dP38YPnJzTXQ37ZdgnUUSmLORyLA2oe4WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4ZMWEQO; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4ZMWEQO"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc11a30a259so176986a12.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 08:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786721391; x=1787326191; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zrTj27OG8xLG5zkTSM3MUJeLR8ddkr4GzlZLOhMEoQg=;
        b=K4ZMWEQOxKBCxtscI1jQ0ejjrkIr3ygARggxTcIaVeIuswoEpxjkE55j7QE69/Jkh/
         bNHeSz7H902JGwpO1ZdmIlVQKrwbofC38xnkCxjIajFqK7fqwYEyHoZZ0KW77eqTOKYs
         L8V5FcuqR9cSdDOfqdiAbVy+ZT1fMi907DG9MIT4YuSi9ETLSf+sri+k/8eR0fN3Ls40
         2qH9BRR9UKNAtgUPP9+MN3MuS1Dajs+8MElwoFtNqK/9oEbywRd+JOqiO3oFal9p9ygG
         WCq9PpOMyaCyZT+gOljE5dMjfOJ+aGm864fADR+gCPaqS2XneR0qN58G1gCMeI9hauwM
         GRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786721391; x=1787326191;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zrTj27OG8xLG5zkTSM3MUJeLR8ddkr4GzlZLOhMEoQg=;
        b=NnyXEOaLnsDFYF0JcE9TI4rZtiMqnsvmRZk5wtHt6+tZwONnqcAzE/4XvbzQCAK7Xs
         9bZP3nI9ltB1IT++yUep78gPxHV4F135FcQRVeZyuzUEqXJgeFTrjvlZISALUQ/KLRHi
         IYP2jqU1u0EvnykikjCqAfU3R2NugnN3jtyT+GQCut6+fa9VhYejVK/87uhugHmRuqom
         CJ63oKP57+C5byE0o/UTOKzIVC9pSs1hdqJymaqFKTN9IcK63Ju8xNzd/t4YjG50HhHF
         r6nuOhitWlCF/t2NyuQqaNiLKckPo2ABVvt+A7R4V9XfaEoxlI35M3Cya9ULcc5KtPrZ
         9F4g==
X-Gm-Message-State: AOJu0YzBMZ8q9L3GZd+pOjAAf1EnamHjRDQQe8k35oEIjAv/Tp1GTDeN
	r1tYX92pMBxLMnHtDnc9kS0b+y9B9y6GlqjupUYZQzmQfMywv2RmUUyh8SMKJw==
X-Gm-Gg: AR+sD104J52ns0TNWLD378FhizlFCcMc5aH6u97i3cTfpjw2akQOZSU0wLl9dhMh2Yt
	XTVhk/rXL5IxgzXqUVXuxM3htUtGn73WxrO1/8Bi1dKbuvB2Geel5nqjTCAFjlx/dH8i6Ci4NNj
	NXpGGOtUgh+3Jh3Q79nfpWfSOhj4FizitHUqXjaEmCvwQyWM3t+MHfYvAkmdLCQF2DXfFVQSH4X
	HIw6uu6EPhYRZoMNIrnAj6ADYN+kPGzPC4gzn5u/zP154xBf2AVjr52RS3CU0LOmM/5h+GFFL6T
	9rn6CLyd1cVIP07FDOiI8a9YR0CQTNz3qMy62Qjfhzmc8M2bFqsXC+D5VgOr5tOyeChb9QTVCOP
	oHZSgjiVMQStIjSYugVvuKVFLMfX20AWFLJRp8HkCGD16KF4wmMHpxyFc6noR5CTqfDwBd6Cypq
	kKhmj9eSHSNT+kpob8PXl/KCPJxUo7kegAof29ib/ECZtkOL2+QpApMcY5YBhjbHu0rK4=
X-Received: by 2002:a05:6a21:3398:b0:3bc:5284:5445 with SMTP id adf61e73a8af0-3cc71d53eacmr7350402637.21.1786721391464;
        Fri, 14 Aug 2026 08:29:51 -0700 (PDT)
Received: from [172.17.0.2] ([57.151.129.34])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320ea302649sm5203829eec.24.2026.08.14.08.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 08:29:50 -0700 (PDT)
Message-ID: <6a7f346e.ed8a271b.38c9a9.1a51@mx.google.com>
Date: Fri, 14 Aug 2026 08:29:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1950879500060894454=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ,v4] avrcp: Fix Out-of-Bounds Read in AVRCP GetFolderItems parsing
In-Reply-To: <20260814140155.3155081-1-hadess@hadess.net>
References: <20260814140155.3155081-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1950879500060894454==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1146125

---Test result---

Test Summary:
CheckPatch                    PASS      0.38 seconds
GitLint                       PASS      0.25 seconds
BuildEll                      PASS      20.70 seconds
BluezMake                     PASS      555.84 seconds
MakeCheck                     PASS      3.60 seconds
MakeDistcheck                 PASS      155.62 seconds
CheckValgrind                 PASS      150.86 seconds
CheckSmatch                   PASS      298.49 seconds
bluezmakeextell               PASS      96.48 seconds
IncrementalBuild              PASS      553.95 seconds
ScanBuild                     PASS      895.27 seconds



https://github.com/bluez/bluez/pull/2400

---
Regards,
Linux Bluetooth


--===============1950879500060894454==--
