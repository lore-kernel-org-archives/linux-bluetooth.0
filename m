Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794443854;
	b=Tb0Tqixz5eBUmwjhUAC8Sci23+JprtJAd4lTHhaYxbOau5LDXBSxig9F4L2mRYelinkv
	 fYxKI/2qDKeg7meY5ZlFsY3Zw2BS3mKQDE605S1e5eSYesiicckxzuy/oGix8LVdPsHLR
	 Tj7sdg3+xHbNsf7zeM/QYfObHiCJNsAeKIWFnOWcJbafGmmayjobNG3P+irTLrw0wA79q
	 nFAY1E+NBmGhLuE5bu3QQ+c2T1cCGBMs7UzODfNwdiAx7I1scmtPsl3eEPGH3DFvcKJi+
	 iJ8hztL3Z5SaUXDu3kl2OUjlLG8sGFvcy1CluiOJ7lLmbnDFhwscMbvjAGNdaE2qJyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794443854;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=TvJ2q5oV8j8TKrmM2byQ5iM1YiND/eh7hnTjx+xFflg=;
	b=KNKu2ALoC+Pe6JkQnlr9OtwkgxTFo6zHKG216TMe4JQMgu5M794v6c78/0mlc3LeFpwf
	 q/mXXGdll2+pYfZirfUcXTEhm9U5ExH8YTkzEblEsDd06r2ufOyMaVbDHe9LHRbJ33EJ6
	 k2yMsE02Mddw2NdsEQZY2YvQqu9Stcs6d77CT959f2gDYR09o2oi+QrRwpptHweRhMKp+
	 VdCMoxwxOB/zj8XeAGBtWUpGoyx3dvNiK+VJklqfQECqXH6AjxiQRDKJ1VK3aD2HsimNg
	 cg8nwXNW8mniXZylHgwMne0Hud+L96sKxRkglEWG7unv/WvVb+9c5sjDS3mq7BTvrlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uGlhiCps;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879A6606A31C
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 00:37:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 879A6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uGlhiCps
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3b0e61a4decso2784707a91.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 16:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794443854; x=1795048654; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TvJ2q5oV8j8TKrmM2byQ5iM1YiND/eh7hnTjx+xFflg=;
        b=uGlhiCpsIXprJpblKEG39exau37yvUL3/n6jWeN2BXnyV7vXeECefBZXJCGG4WPbUC
         h0yjO18keOldWi5SkxbYPR2jJGxx2fIRGUAGbuOf0mCea3DRvsQpEcXwD7ETmUpBjmzG
         vSToN250f7ZRkQXzIpD9in/WNQ3LKuv811M/hE5xlTc7lpGAD0E+WNBZMvTxvFzrkyjE
         GKh079Tux5PatQrmCx9QDqbBmTpM4kQvNXmgPVBWvWuv9Gzt0weuKzTLPTwm8BeBIyQw
         9aTfk3mp4b+3B1QKDfVHfiIMaQ4Vmp4sv4fztF7DysAHz2RoJYpLMekzp37ZLRpNtbhE
         +chg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794443854; x=1795048654;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TvJ2q5oV8j8TKrmM2byQ5iM1YiND/eh7hnTjx+xFflg=;
        b=tIFWb6Fw51Nv6e0bH7zq5Z/JwLjzY5ujDVNXFTfp1mzy+Fpo5etF6lC/zzVuQ5SICl
         edfKTT1ElieAB2M4b1x4+cjTfTQZZdiMMKdaQ8Spbco/ahwebX8m1wDXgJZZryXQ9CAW
         6uF8UByKkBdwusW5Pn8Oc4V48n/14kLhq16uekvcSXAoCXSc+uzzY/Atlw9MIkqmsEqN
         r7g7E77OeJFsAqUNFkaBfmyXpXTPp9s7/IDMDX0M9eDrmkdQafrQihQlUZfydNqDFzM5
         IGgMuubBC6oidVa7+RdQ0VsMD0ePtyWbP/6kxLqQVEdp3qWWQf1oU3pd5fmf6juMLitB
         aD5w==
X-Gm-Message-State: APuU4Z+y/uIiYks2IMq1UOTxLl/ssMjsbdXAzRjIavEo5Tv+mkn9YjOL
	AODRHc6p0X5Yj+paFQBYAqlvIxC0qgpMiCrfi+oXa+1mFP/qXKP2zEAmftiboXBP
X-Gm-Gg: AYBFou1onb+2+oMZlSP2yskwJ/lxIFwsWhCunbUkzFylTP/oi2zPD0ZyEW3aG2819dD
	2jyXYvFCX8k1jTmhvb7fZRAjgXELhD8wyhX0IaCConJpDisfiCW+AzrI/pbjfMZjm+pfrB7w/rk
	Kss50nnRaiUaEfXlj1k+MhBLJCxMjIAfHy2hx+2CNtdQZKzpTzaTbAPdryJLkKW7UD6X/bjfjm5
	bVfKbiZ7zqsbe8j4vp8Uo4TntSXZeW38i4jIDT8hqsHgQZ4ai+6uDA+DvS6N6xCq5Qg/tBrECXs
	QAwLvQUHXQChsyfShVLaRxgRqpYoeB03EZYtl/0YKRTAueO6nylJYNLVC8U30kZQ0V66IX+0bPh
	Ehdx1f1O1olOA/yCzk6GIUpAqQqqETM97q+H+MPJE9DlcBraHP20Ro9e3zr9Eu+0zamkgQ6md97
	aThkU+dOWpCqtYBKubcQsuJQTmCLtAKjOv2nxrGGRny33cLPNVxcaTcJm/UlRzL+2JI2lDJfJJb
	698iP/YUY0xgwYffVY7eQBL9wx4LiRBHo7UtRAmnW11/8GQ1gDmz1UNuSPL4jg=
X-Received: by 2002:a17:90b:5286:b0:3ac:b7b9:6471 with SMTP id 98e67ed59e1d1-3b182f65f3dmr3390961a91.65.1794443853823;
        Wed, 11 Nov 2026 16:37:33 -0800 (PST)
Received: from [172.17.0.2] ([20.64.175.145])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d282fdsm1433011a91.14.2026.11.11.16.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 16:37:33 -0800 (PST)
Message-ID: <6af50a4d.7e41ea6f.37f0e4.839b@mx.google.com>
Date: Wed, 11 Nov 2026 16:37:33 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7741724017131389799=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v3,2/8] unit/test-bap: Add test for disabling one ASE of a shared CIS
In-Reply-To: <39244774bf8c444d7870ef0b839ccdc3fb981f24.1794428234.git.luiz.von.dentz@intel.com>
References: <39244774bf8c444d7870ef0b839ccdc3fb981f24.1794428234.git.luiz.von.dentz@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7741724017131389799==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: unit/test-bap.c:4952
error: unit/test-bap.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7741724017131389799==--
