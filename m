Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31FB545297
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 16:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792083320; cv=none; b=ABe/MGZ+vRPl8uP2ZljQAUQIYwHKhSc22GbodW7GqsLmT9g/mX0nnUBWE+o4tFzXZ9cgUqqfjLFRmmAl309yEY/ou9myToogOQb7O5pC+NozTQpkKf31PruMEzN48fckXvVaQFaYoC3G/aNUzdqmNW6+25lmQfZQuph+BIhbU+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792083320; c=relaxed/simple;
	bh=OcNaYGa39mAQB/oWNFzkxAKFVdaHjCKop0epIvWUR2w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mNpFMRajAXyqQ+lBLsI3AFzyK2n3eRAxdVHj4+J09jU9gyxvIWbLXLiPb/2SeyCF8PrZPMGXU/NCC96ZHlD0iRti01DmVORsL7J7wFwQwAH7ivPksqrdJCSFrDK/scxAdfVBmKaH4jb0u9qCMiT6KEH/z3eiVvzsiwoF7WH2XYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r3UX2HR+; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r3UX2HR+"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5350cc60b51so76466121cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 09:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792083299; x=1792688099; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qPrUR7ADhVfwrFWcSwZiBXgoH1cK8wpOnbM09tyoyko=;
        b=r3UX2HR+WU3WnnvP1c03sJ+fsDb/CMAzpqmRhFeC9DDVgd3SXMTmGO9QjBUu8quK+a
         iqxZyzoeuM0pml4KTwUS+bxgui2/8Sl2pzz7lrJEwevI7lfTlQSKYva60TqwzZI9VyvY
         M9E+9/rrxGSKeB14PPu7MoammjFN1JdZtxGhZt1deM/UlWRPxm8a3MG7rQyIZgaPrWtl
         UPP4YZJMhOfkX4lED/5oFnq4ZxWJa4iqhdiR14E6uzmu7/L5TRZjPJJ+fpBbjdqvWJUp
         WrMqf9jb0m1D5idxipyoFZQePJA7gZ6l+57vdWd1RgD7bVtpSBrH308S4tJPi2ea48pI
         fs9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792083299; x=1792688099;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qPrUR7ADhVfwrFWcSwZiBXgoH1cK8wpOnbM09tyoyko=;
        b=vovxSRLPGtfcJKXAh3F2OMWciG9DVz0cG6UxzmQIFQz9lyWnDQPRzTETVyh1mOavlO
         Upw7UCjLapkyomU5XLlH7p+tgz8110fx+rltXDvEljLQ1oc9vyanGBNiG7OfD63oUtTI
         x/HMKwN53PsNnZDHMeUUOLkV5lPF7vbljxn0jVTj/g0U6QDcyDnBxTdGFJpb/eYV+5bv
         XffO7f0DhvtJQBbfV4idtV5tcY3bnt6T8smjk2xkn1jFkCEcSWRkWpHrcZHJq0pwGfPf
         lLwa/0qYcxeq8TaDAGV8QnXKzsevM1vb8uIxmPr9L1bisG9qGMbSlxsAn0ZeYSnm2f4H
         YXLg==
X-Gm-Message-State: AFq9FYL9z6O/7nEbh1bVPBDzWgdhg1eF7J38LsEZ9cnN/L3vTiOEjEru
	jK3VNYvgEeGb5yLZ34VmOi7nu2FBOOXfb8ARv9p/b4zJd/3J4nebIgLuIaJVSJbH
X-Gm-Gg: AYBFou1e0QMUSjEo4jYoBd20cZua56Q87uAK/WTLk8X7Yx57DjBcFsIXg95cA3j52Z3
	6tcpFUX39WYMuPXy3qjjDcVh9lnGuVT1z3tL4cm/Cvy8BHoF2o9YLpzhuB/gBezfIRXH+fODvDU
	qJSczl/ZyccINxUdcctzyVnH4d4wyZrYHAVAlUy4rBJD1cWje+QbJfh615cE4QkzUz8txwWhdBD
	i8F7OdxrqFSvPC2faSrjGY3i8MGGhBCfYgk8qOV5WKFPDKAwmRhd7Aj6ZLCb/x0NnZr8Br4MJQi
	f94uz2qeF08Ug7eLs7RcqhZhIF+6xY8vVTPXFwjtW4Yw7fcW5tz9l453I6PXN48dVleta7Uc+BR
	pPXzP7r8GNwp3kp0BFKJ3qa/lhzFGXxJhtUFdXC6Kl1nI+AMzeGsCICTChVJ3uUUu+CrnAYV8Wa
	QtCCxuoIGl2H2usJd26mbwxN2G/LYO0u/yOzGId7djzbQ3H5VNzW+JdG1x1LLkT6b+UeTn9tIp2
	mjH7as=
X-Received: by 2002:a05:622a:130c:b0:533:8ce0:67d6 with SMTP id d75a77b69052e-5359fdf67f1mr308101751cf.58.1792083299558;
        Thu, 15 Oct 2026 09:54:59 -0700 (PDT)
Received: from [172.17.0.2] ([48.217.116.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b97c4044dsm85162226d6.46.2026.10.15.09.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 09:54:59 -0700 (PDT)
Message-ID: <6ad10563.39081132.10b50e.ee6f@mx.google.com>
Date: Thu, 15 Oct 2026 09:54:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1929845758977623508=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, aluvala.sai.teja@intel.com
Subject: RE: emulator: add generic HW rfkill test tool
In-Reply-To: <66971d6f85d714f2728b29fada7136d5a2fbb3c2.1790752800.git.aluvala.sai.teja@intel.com>
References: <66971d6f85d714f2728b29fada7136d5a2fbb3c2.1790752800.git.aluvala.sai.teja@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1929845758977623508==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       emulator: add generic HW rfkill test tool
   Pull Request: https://github.com/bluez/bluez/pull/2612
   Created:      2026-09-30 14:09:57+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============1929845758977623508==--
