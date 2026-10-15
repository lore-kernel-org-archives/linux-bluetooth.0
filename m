Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C76470117
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 06:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792046581; cv=none; b=uAVBjfdQAzr8pfXVU4a7pc0KkpaL1LM2xDm5XshXZ5gj20tAs7u/K9cT06ByiEUczQt8bmQtvb5AV7qfD4yTbpc0MnqDZYGSN9ZG19vIt28GB67qxIYzvbcaiBEPtfS2P9hsfqNR3U3wRXxbkr8pO9gNvTQEGIqJJEvGLwqC7zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792046581; c=relaxed/simple;
	bh=1iyAFKS4CBv42YEzb5MvIlBlc9CvANKm0dLIJbeEsd0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Xo+2ChEAcpKl77zh/Vl5+avj5hbbDumRTEOQIK5sKCr0Y2XDXAPSszRVxe+pRkxPU0TBdhpHYKoZiZrxcTIO9a/98FZUl6DczjHSGUMGv3hvKE9+QIdDzdX169YpIHGq2XPmR9y6fe4ZyjoyF/mAzCJKvsWWzucPNTfvqnnvs8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEa+Lsbc; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEa+Lsbc"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6dfd530a2d5so2629734eaf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 23:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792046579; x=1792651379; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1iyAFKS4CBv42YEzb5MvIlBlc9CvANKm0dLIJbeEsd0=;
        b=SEa+LsbcDtSfVJeIY4035C2uOHf7wTraoxfFW2eeRsgEVVglSLIDRg4udUTKskptyw
         xgthySXQERz67ATOOWPMKM45lU8r8CLB+5xhfFgf/U65/Z9Zhh47kK+s2HwE2809Hte6
         WVFmCkQIQLCQ8NGjixyk6n4cd02nME2Pn+HIL6pr9AMt6Qr/1BMVUPYyQ9O8HO/g2a7b
         Uu1Q98WD6+vk8d3N+4Obzl2H3QBD+J5YfK/yo8nOj6qXeu625qU8S7Lj+vPK476AUCZe
         XHc2u23slVftLNfgShpvOfrMuzg8nRhsB4LEcBBDtVZ1zutVtDV0+bxtn4k1FmaAspmX
         gJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792046579; x=1792651379;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1iyAFKS4CBv42YEzb5MvIlBlc9CvANKm0dLIJbeEsd0=;
        b=b6W2rTNQ8Xzdk3GHNa9dpi6UdCwA6rcHOfZjl0o7V6tnHRYV6pwvqkxA6hoF1DRNDo
         UK/5LgyW/sg1akx2qsUCMokwi2iniayaBxWuaL7vXmiE7XInSvmf0Wt8Jftrb6Tlkmdv
         4OvZWEIV3KjnVkZPC2ogfVBLaBJ+f5F7MfJm0YEkPmTocnJ8ZvKxNIOVBTBacr2jDBbp
         PbzXHSQDGMBHuAtUrreEG+XWur/AVYnh4qHekiK/KXQPWifpUcahCPIPvG22OSMH37aA
         yPKzC9f8rEL4+NMCqZMw0BiC5BSDHPgkf+Gx7PSeiQUY/VaqRDCiyW8+jw26cJRC6dlt
         xImA==
X-Gm-Message-State: AFq9FYLkI708b2SWyM8+l7e7DAt26sBU7KwCZzdf02DAY3UTQzIL5E9F
	NMt5GuJ6pIEwtR06AEzJuj0MpxPOyS30k3Aj1QtMVlyg3fqN5azJFP+ufGxibQ==
X-Gm-Gg: AYBFou09A3q5yjsY+vhqjFiK4sO5KGUHP9qEZCutwucpWoFTDUag1vl1NUVrAxrDVMu
	0BQrluv7oAdpyQaoqFJJvWaY7NTPfKfxeyPBoO6XCDQ08oE6IcbPnG5rvnJl++ha9rDIQg4KJDn
	ibR8wxdW9TI0+ETjdtAGqk9Lvc1aO28F+j5NDWcCWb9voGqXh1LtBnPg/dLfQ7FInLfuTZMzV60
	IzLltd+B/iiA2gSJSexAPBQFuichcyDK8lnM6PCDUANvJm4UTI2CdTl4BrvilIpH945KvCIAApf
	neNwO7TPtog9VsZtBzRV4fcaD7QdHO7O7boql6kjOH1ydujZJeoaTOHQVJ8U1h691D4+g/Lmdse
	bbSPiUzFgcsVh1CdUo+sdzhIToUnXnnQZ84ERolksh8hh95Qnbtfn42o3MuRSNoHCphoyTmEXT8
	SEgpJBv/4YHBkSiflvUKNem2f7jMPzlBUYAbdwXlexpChTIDS97tsEASADhwczETfteHuVaoXpD
	yg9J8DF
X-Received: by 2002:a05:6820:1846:b0:6f9:4f1b:3987 with SMTP id 006d021491bc7-6f94f1b40d5mr6350909eaf.59.1792046579070;
        Wed, 14 Oct 2026 23:42:59 -0700 (PDT)
Received: from [172.17.0.2] ([172.215.147.167])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6ef03e39840sm15506147eaf.15.2026.10.14.23.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 23:42:58 -0700 (PDT)
Message-ID: <6ad075f2.29364a16.3abf20.13d6@mx.google.com>
Date: Wed, 14 Oct 2026 23:42:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7644682170238134411=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: [RFC,v2] Bluetooth: L2CAP: tolerate zero-ident LE credit indications
In-Reply-To: <20261015052751.137705-1-cochcoder@proton.me>
References: <20261015052751.137705-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7644682170238134411==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/l2cap_core.c:5396
error: net/bluetooth/l2cap_core.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7644682170238134411==--
