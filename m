Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB38D48F835
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 22:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790030560; cv=none; b=s1aup0dg0LMKNa2U8Rrnq66bNc/9C0IAFzSRY11To7UY66BN7jLs9g0ln6BhTpaZAwZFCryDPoGkFt/FYu7m6jVHKbGI3M1zMjpsXU/w8zYgUXgpyX3/B85C7clpJkKh6/XF8QqtgSh5fenoStoJaG2tQ92mguQMQNnipRYF6CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790030560; c=relaxed/simple;
	bh=oP+iEZ4sbIFDA3DxmddV8+54rZbIYFEnigoYYU4D4Nk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jxxtNk+LY+EC7jgw/+y9t4Upv2oSse0P9nK5PEAaNP1bIQKCoVGxyHqPsRqHl95Z+e/J00q+FV9Mgk2GpM2vYKOgz9OX2RQwnXG6cA1moHSTDo7GYSNxJtB5SbiXNPGLRLHQ58Dj2hx+Fl+Zm6C1VVND81wnf14838b/qG0p6Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esUreNdx; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esUreNdx"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466cc9b4b63so540613fac.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 15:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790030557; x=1790635357; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oP+iEZ4sbIFDA3DxmddV8+54rZbIYFEnigoYYU4D4Nk=;
        b=esUreNdx33r4CgHTtS+NC17O0pFAEAnz49h2M6pwn2mo+ldWFNdnrNdKj2JPztqsCt
         mHTQXIcTgzBFBlrgyvqZdcckKYECpuKn3+kkUfel6PxV8TsXGtO+nYVvALpV2U7SOgZn
         K4drzhi+F1/OSDueD35fLxKkZAjpJjaKvGOWSCZnKbXZNtd2y7lU5Bea9R2KanrzYuix
         L71wCujslQfspocfcsRNlzxLqrLBQwnWbKiyxbPMkaVUeTE03Q1fLyVMBcVI0x8VyvMB
         MVYZ1CjQ9765qUk6mvW+VH/0dTyCO60Zn5bsMvTV/OkwS6KcndKYe7/9lkTjrC8XvfS+
         UHvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790030557; x=1790635357;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oP+iEZ4sbIFDA3DxmddV8+54rZbIYFEnigoYYU4D4Nk=;
        b=aAGxX3HISC7MdGfmWWnIMTteiNmmwNxELP46dQejB3/rmQha5ugYpv+efq3ytXH9mY
         uCq5KB05vcdVsrH3uyLtv2rJrx8s5Adu7YKidHhp/i2q6PPWq6dvqObJRly2krVrahSh
         ZHoaRW/5Puy+rKiUW0ShOaibpyBKXzk4cK8MBtMpagR0TWXHA0az6r7Lp/9L+/iXcx7q
         GINkDqbJdmvM0LGTOB94bPDZ4y93Ryx43+rGMV38TubZcqL0XbnSYB1DOjthujUbwG0T
         U7hH0gb6U9RRAK3B68cP5xpbw5Z8jIVLSR+JZPBVRrmIP8UgtwhohSvlcJ9r1Fq+2NvH
         joag==
X-Gm-Message-State: AFuF++mfZt9nidC1wKAunmp2P1++L+vmGEDx/OEUH1ObAeL0ftQ3LE8z
	FA9EdDkVE/X+3wN1xI8gh1BBnvJso7rpF4LOBa64aDjdfCzfCLA5kDONAgZ/mQ==
X-Gm-Gg: AYBFou0Esws7P6jE6L52JEYmKdEZ+1m3lWDcHa4r/15fOsYkvu5K74vp53wx3OAAsF+
	ByUpcEgP/uE/IgQjtwP9EZE4rakOeguMTkJSyGfVkwJ/BpV/W5D3LlN9Ti3y6CHr/ruLXE28veH
	ocyIujd4ylTnkGLXUzTWqJOG4jiOrUaFRa8F9Yf+rXY3VAq9YRFj094sbigcWWbsn2/x0iS3eLb
	TGQzVshh1RJk0BVPzYQNboARCj0fVMI7w0KY2vPWxJwg41j5c63LYTOUuO0SlChUPe0/7dIMFCJ
	ZZk4utFv+CwzOsfbiey7Xq5pEJBiav8T3VQbwvvdnKDY95hOiLQQAULudxyfbbYpXiBkQPzenG4
	hE0awtSP2wLBMNmB5t0Gi4nenzgxoEcMCf7jbpAOb5CNlPdkblJ23FMeWckqRywHW1cPVgc/VEw
	ZbkwA4D75tNzRNP5Y77UYQcJWH+5x8t3UPjG2HPA0zwwV3zo7vM/P6DgXf4cpwH2UsMKBNzZLIU
	FCoYuw=
X-Received: by 2002:a05:6820:8108:b0:6c2:f818:336d with SMTP id 006d021491bc7-6d1580786e8mr974436eaf.3.1790030557388;
        Mon, 21 Sep 2026 15:42:37 -0700 (PDT)
Received: from [172.17.0.2] ([20.125.176.183])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d1833b75c5sm649928eaf.15.2026.09.21.15.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 15:42:36 -0700 (PDT)
Message-ID: <6ab1b2dc.29364a16.36af65.331b@mx.google.com>
Date: Mon, 21 Sep 2026 15:42:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8158802082664632882=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yaroslav.voytovych@gmail.com
Subject: RE: [BlueZ,v2] adapter: Fix crash on short start discovery reply
In-Reply-To: <20260921204706.211385-1-yaroslav.voytovych@gmail.com>
References: <20260921204706.211385-1-yaroslav.voytovych@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8158802082664632882==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: src/adapter.c:1863
error: src/adapter.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8158802082664632882==--
