Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794443875;
	b=gCuku6VqTdxgQLNGcdpjhnRF5ZWNFPKmJMD4fofxffaYUXKmxfPfnguiYkzLYva32lmc
	 hGfaNFIBY4VOBtxreDhcFxouzQzo2qd41RBpbmE93zS33+THFhKouDk/FcFPKHJ/SmQOw
	 jVxWahv1ElzpNH3cu47YEGe2YA3X4wgjhSmLzxLlUlfal03Oacr7TSk98qn/ZrzTyTaX2
	 6PU1ZG8rakt/CCnCWHLD3Hr8vOrlBOsBTPUuTbt+G/1OWhJ2xHTtpuSwWwtcc415A+Fce
	 5V2Wwfm3GQhhTnvYzxFcfyZgd1SHJ6PEolY9oHwAK9seRMVkirOU8jv5a9mZgDVltYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794443875;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=qgDJu5rpHaA1TFD2Lp4LLH0hjj1rh2zmpkcvqWONHqI=;
	b=h5UARFR+UYZqyyxMBSYwkkjlEEFRY7jNsoVc1tGBP2S4OqS4dUAxOuBsQKGDDqtDbKcH
	 mJto1jpJsEYxCfmFcASKiwmNM7+oNo2axR0MKhfTqgvEjuDYrBGhOvZN2RRFgyrgX0A/y
	 utqfgQmGCGreo6DiPYtb40L1Iy+k+kQ5Z3r+SZWyUVfqDGOAEPlex08rRPic5sxg02m5H
	 PEO0y6qQyIim8UcsJJK1qZkurE/1IRsbeyXKR2/YraOQ9JBSQBE/uUEIQ3XqrMjvQgtPU
	 5lZ+wBpWb6otpxCl9oMV+IuMsjXlU0FdKOb1EElsiKWap0t34jbLatVnI+14OsnNBvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fFZ0qRBi;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28B5606A32D
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 00:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B28B5606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fFZ0qRBi
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cd69954c755so2614880a12.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 16:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794443874; x=1795048674; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qgDJu5rpHaA1TFD2Lp4LLH0hjj1rh2zmpkcvqWONHqI=;
        b=fFZ0qRBieCycG9WN8ABZsxP6OOh+ojcbOsAkWFLoXoKr/0MlXocJ4YTu0T6DUEQmi1
         MC1RNZQZJe5r9ibmNdA1wyoqv+wJyxBRjKjqn+L9znKdoXwi8ii187Pjg3eIIa2UZQvh
         0LHf9gwqZc5GjwAHxZX0kgdK7F+wcZS/oOLRXlexFUSRh/fPbBB1YHXdqJeoKQTDt5ET
         UCkyGpIDLZ+zscffC0u5VmNneQwHPEpeRpo2GYRPveMZzVvYvLvfbgSq6as0G+FKC09e
         FFyh6RfV3blprB7d+idD8sAMJb+xSbyrgCUlqwDlWv9N4+RlxkmjmyA6bHkpesy+DyUu
         DA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794443874; x=1795048674;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qgDJu5rpHaA1TFD2Lp4LLH0hjj1rh2zmpkcvqWONHqI=;
        b=WF2z4YD84YuaQiK4u7bwKFqNycH8Vxn4f+y/UTZclZjIudP77Hs9u35bKls/wmRAPO
         UEjnw3hAzU1PpucKEVqg/RyF/AVP1SswdpS/k+9JxODvcCXWF6tiKlB9IV8B+iBHlUhj
         DAueDgumGKeoeDzcnYLRk9Lbq0mkAonXN7qmIwBEg6yuG+1NQeAVY+QYNlS7eZYVYyli
         LtpEWOgXRqK0lGy2mN0i7U57ng1mIyF1WwrIBmxWG69ayMefsN0jBvvohPq/aFqEKVQK
         mx9a5Xwn5GJ4j5JI2bvoRQPbHPN0I9zW3rJXnKU7MdiqOeJ1/oeyKU0Yg+3b865blGQE
         s8tw==
X-Gm-Message-State: APuU4Z/mLtKo+0Y78Exip5eNTXPoMB8xuAS+qgxFU56lOK4EFBYNnGz1
	kdNTD8mZJKqIR5wxxxnsPnT183mjATS2ep9v6mtaYWqdzVm3h5GXMxhdjsE7RK1X
X-Gm-Gg: AYBFou3c5cf03CBDoXw6cW1hbC/EY5gKGaoQmi1evZ2xnrIt+AlB5XqJG3ht8Lr+Fv3
	on+rbl6j5VM1bdtcZ90IS6ZKjcwAmnL1pf1893/5C6w+F8flXPus2rryNLcHKzmtK9+NjY7n2Rd
	lbLVeXqshJ2MZI5LpTEVtlYvD1bWgla+fs/3COcN42mZEED5nzsl9RH9LPHuJ0HOkCtz7M0hU9X
	NWDtnwkUcsG3VHSzta/rkpEicyhLiWXcyVDZFBgKQREZYqsmf5vKs+2m3wKkJ7U7DO97SlaNnjp
	IoewkmraCm7z39NPFef0c6nR9whQBoJ92E+1iV/J54d1aUAbEnGlg/CpTaefjMOgK8pJ+QqNFLs
	dyD63wj+oYc66DRRnrSCshr0jv/nRRTH/USh85zEHZU5WMHYXPVi54sGBuHvJrUS2+bNMKQlAfI
	+VdFi6jKvL8d+vX65E8JWpMVJRxgkV/lh/al8wawin+teRXJ5s9Uk8lsvA47FCnhPkEKXLbpZS0
	7a+mowhRnbM60DuU5RCRRZukBnk8YYHG2YPUX5XwC5trSbMijRVhIKLPJUfUXg=
X-Received: by 2002:a05:6372:a745:b0:3e2:6f90:b54c with SMTP id adf61e73a8af0-3f2fe3cd454mr3654489637.47.1794443873990;
        Wed, 11 Nov 2026 16:37:53 -0800 (PST)
Received: from [172.17.0.2] ([20.64.175.145])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdd8d67b070sm2223189a12.9.2026.11.11.16.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 16:37:53 -0800 (PST)
Message-ID: <6af50a61.7a942c93.134f53.5183@mx.google.com>
Date: Wed, 11 Nov 2026 16:37:53 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9184205356727141457=="
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
Subject: RE: [BlueZ,v3,5/8] doc/functional-bap: Document disabling one ASE of a shared owner
In-Reply-To: <9b4196abbefc8e5284c6b48ed457a695f1d457c2.1794428234.git.luiz.von.dentz@intel.com>
References: <9b4196abbefc8e5284c6b48ed457a695f1d457c2.1794428234.git.luiz.von.dentz@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9184205356727141457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: doc/functional-bap.rst:313
error: doc/functional-bap.rst: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============9184205356727141457==--
