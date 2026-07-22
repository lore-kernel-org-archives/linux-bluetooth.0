Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDAC361651
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 04:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784694401; cv=none; b=UQ9QStsYskuejFKfWxSch6oOatr/LpUeCcq5wkT7L+VmOW4Pfo3gE7HxTc+OFt8n75gUb7+RajSgnj4EqXGnnr4bGgSQUS7U+oSOg7njZmoxXKP4HO07eIECC7CpA5XSjb7B72G/N4OO0BFyLf7DyzolIMaVEqJW7c2Ee1qSMYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784694401; c=relaxed/simple;
	bh=Yi5AccLS7rSvGffzBOceSqAT4KuaKHx0TdZd7PRXxxI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Woj6dOqVHCj9sGSn9InZcFN1qjJgwbqqLevu9Q6BWqV2foW9fyEI0P1c+MqsrT5JRsofCGY/0BDZWpFBmgGRl/qjfBTjXW805Ecc6ZfBpmy9BxipYm5FnJXG9fA9BMmaOx3yMFFFs2qHlbBQxxh9a6ct/lPCVB5swM8dSgMxVoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qPlrYQk8; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qPlrYQk8"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-930f4e5eed1so36789185a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 21:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784694397; x=1785299197; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Yi5AccLS7rSvGffzBOceSqAT4KuaKHx0TdZd7PRXxxI=;
        b=qPlrYQk8Xmapy827mLPuABMGDKsGgtCe/KwXaSVfQDpxjdYWDsSX81O2HhLXvXFy2R
         8Uk6y/fyxAdwQo3tSwjmT/Qki0JGO7vWH4SeisTjPfP5HyYsivP7KU4wiqQ+aaJY8lX+
         27mnZhYa+0RyXyoiFyIfLs1QCXQ0taoXfSLFupj3z5LCVSs4eswkW+7fZzDH1ByL3hJY
         J/ygZvNLnqOrLTk4tLTu0ZsVBbWljirZbvkeuZ9l+lFSxOcCTsxKJDvAzVUygPan16K4
         VQHT+3zjpuSCbUWmyD6yJLMBQGPhvFCckDoqEw0dH/AhieX352rCvnHmahty7hdvWIFd
         zf5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784694397; x=1785299197;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Yi5AccLS7rSvGffzBOceSqAT4KuaKHx0TdZd7PRXxxI=;
        b=F2HhJGRl0BlKERCWu35MEOpNlcRuFq2Whi728cy6kC1zYvRcpmOO4+7k/rSZeiXw9+
         GsjttmPKOGPYwcDca8RSBbabrWIj9Ls6ILYEboGMB7i7O4JKIw56xAhCcEhtLDrmfdOE
         hqgjxca6jnHG8AbwYjFf22tnuGIeu5fQGycp8e43WvVHvgsa+aLRHiJWFgcSQXhafOqG
         fLo/XpmLIyC2Z+0RDXhAhoDQ0cy50jaWr07UvkIJp5FXqVvkKvcUZIea9n6xSp0HT4Gx
         J22Xe+/kV8n/eDo/JtX/SPaZdJ5t/u2UhqscuYkr5f77+txtw59EgSu9CTJcirYdUpyG
         vyqQ==
X-Gm-Message-State: AOJu0YwWRwBxgSb8Fobso8oY+7CmY4TJutp/iuSCIedf5/8oKdIg4IA8
	GrUhH3bzPvlHeqwZzvtQ2FL5xTwxon/7nVjoTv7Q+NczRYSu7hv0wZFPKchCXQ==
X-Gm-Gg: AR+sD11TDkbKknaAXwwgU2hIehDBWLWBIDY+4PNLACJr6/fE7I4dUl2x4mVZuaVBbnK
	qokcnMUzfhj6UXRzMBH+PwKxT/8aKWqXv7Jo72JLDeAbYcXsb3tuumkTbWDGMiYBqUGOU5FnT5y
	c6/XiAQHegh3mMCLlQAmjY04kM2+BdM+mRWo0nLDkHzGQV+rbQXZjrShLMBrEhI1vZ3ALxHaHX8
	ACbLBwdt6kBxPAeKDTs9b1i1rhOE2jyFUWg7+tbFMy41W816VfbsdpLf4hJG1injloEZ91Qb+JN
	RxLpKOa2ed4QcScN7DF+yThF4vjXr/7lClE6ShCfyPR30VU/TZ6gLdUoaS6UZK+7CNfbUdnoVM5
	4rPRzmTzs1Pewxl54ilE1C215PNnUmWKfoMJcwIWNJKIo6Gy2UqzbetnyhyL/NPrKGIDzxdye/e
	5Gfj+hb5vjQSEOnaIs6Q7t
X-Received: by 2002:a05:620a:711a:b0:92e:c118:18e3 with SMTP id af79cd13be357-930b437fd89mr2148450285a.90.1784694397405;
        Tue, 21 Jul 2026 21:26:37 -0700 (PDT)
Received: from [172.17.0.2] ([172.208.127.33])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930f6a036dasm69575785a.29.2026.07.21.21.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 21:26:36 -0700 (PDT)
Message-ID: <6a60467c.068af3ef.37f5d.35cf@mx.google.com>
Date: Tue, 21 Jul 2026 21:26:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4434571126249285421=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chandrashekar.devegowda@intel.com
Subject: RE: [v4] Bluetooth: btintel_pcie: Add vendor_rst PCI sysfs for PLDR
In-Reply-To: <20260722012158.813793-1-chandrashekar.devegowda@intel.com>
References: <20260722012158.813793-1-chandrashekar.devegowda@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4434571126249285421==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btintel_pcie.c:2781
error: drivers/bluetooth/btintel_pcie.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4434571126249285421==--
