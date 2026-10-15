Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D7036E489
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 16:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792083314; cv=none; b=dJ9KUGWFz5WYAIpbDuK86odOi1hFkt/WrE+s2hzV1C0lUssW8EFA5yHL3Hs3kTelR+e3dUvUQe2E0oTdGk1+F3+yFiAvQz0NGpuk2/dkPNTCVbYsryp3GYUA/xoIYlnC1XUYaxQzOy0O65Q/qDgnuvAsq5O6f0ItHy9ssCDyHJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792083314; c=relaxed/simple;
	bh=1/E4P+Cc2L68Lsnbww3SMQFEunaqn0I9Qf/0WQUSw2Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=N+0vYwKQDmh/EgYuuRmqJLtNBnY0Div+TAyGbPsnOxeO+pQGofq1wuZib63hGfwc7QQi20Emg1xbRllGuyVWOp5NnHAQ20ZCHtNz9/ZskkQ/5qMJwSAjZm2a/6XcibVvteI/vtPG9uBuLETF5r2nvUPBd9cFno9A5ShVt3fUAkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s5CKvasE; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s5CKvasE"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93e635220b4so539797985a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 09:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792083297; x=1792688097; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ca/KRMIqWi7C1DOGw47nNLJWLCPJwr8oJyrXlnw02cA=;
        b=s5CKvasEy6ZK3FzPWjFIq6NNLQdvieDaIkDPKQB9HIgsZerE8bC/e2PSSdjjHXR6mI
         +41a4no2xbLx+Ne13H9Pp1IYdvw18wgjsDYMjiPcjY5JQYU8qLEffg6Vur/9rPkeTljw
         hWUj4qEUgJJrbUD7jw7hjzlR04gfoRXPB0UopdSD/y5bAc2rb38eoSODT/Bn6qQ6oVPr
         4Rg9V95nMfSvmaIccr5HaobUhx6HMw0+tA69Uw7QNWdqPDutPnNFPX5sPACgpVNrArqs
         c33IIwHmBHwneTl4HGFGVsR+2e0BdjHPwnzfpOl/VKEFbhetlFp4E4BVSK+5S4isV9Uz
         0Edg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792083297; x=1792688097;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ca/KRMIqWi7C1DOGw47nNLJWLCPJwr8oJyrXlnw02cA=;
        b=vPSd84Yq8t+05cBvfGQzym7Y2iiE0T3WTRggyg/iKJUm/d0+u0nYdeX4ZIVXLxz4Ct
         nhkIDxG8LxUYDUXm1i05w52oJ0Ry99kk4NZt19Ko2GQnpbLo3qvDoc3tL9tJ6d9rHVJz
         XGshVlM/h8+z9S1cn6KibcBWx2RE8Y0mMmWImpNIIY1dr0HTEnPr2yJx+/mRUu6PY61G
         qlMJljarSGLvSg0KkctBqK6rI79gOTEKZdOs9ihm34qFrXe4voYVME1kj9nwO+rb3hAa
         ciYsO8vemKfKke7PavJ9X41u2A4X+SznXdLl8afkUTLk+3zLMB+Mfa8IEn4Xq0NYSExU
         g0ug==
X-Gm-Message-State: AFq9FYIsWB/Ib+oKbJxkCy2TzkuPUO4bTN9jExjUNFEjQHbYtu490p0q
	MLu90wxOe7qtXq3MmR3xOq78m19TV8ADZwiHhpUlI6XlyMl8PFPvWpXhXg2I9Q==
X-Gm-Gg: AYBFou3USc3fMTL7MxjvawnW6LSfU54O8SbU2HWXFCXZoMHkJ5XpD4qzhoP1Dbc8DnO
	KbfnyrByxj0btjGX7JhnPcntI6YUSPum0MnKq1rqTqLd4P5HrfkiTk9KsRApHkuTPUzqh6cAUte
	lrqCZzFsMaCU23ObgM2o7mQVSL8jlwyuYmAhR3Ucjaz7WthtjiKKnsWL0FKvMJFh2VPsIMMICCS
	2NLFGNMR9jXB7O0+BalPTj71ch/QO/tK0ConaJCEu3uEgdWIm5D6TU7bTg4BxCuZkra9LOmvkCk
	+VNKULg0O3Xb08iD0hocTPvM5BIhWgdd43Uf/6qSJN44BONXVJvLqh3MAhUkfL/IqV42+iIR+QP
	nDSpaUiRZ96Cd3MfB3EDMWAck21aXYvu/1pUYJIgKMoYVQ+Ltt7ocnUB8FiS02TvFEIgx6c1R1C
	PqNVkc2/jL1Dh0CUxRTUOTzXHtCKRBi3wCOs6oMn/4MVV8SxeOU2c6TH5ijnaF3TNop74KTbJv/
	48bE9o=
X-Received: by 2002:a05:620a:4487:b0:93c:2c15:e51d with SMTP id af79cd13be357-93ebd273655mr3251403385a.46.1792083297194;
        Thu, 15 Oct 2026 09:54:57 -0700 (PDT)
Received: from [172.17.0.2] ([48.217.116.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef5009b87sm801635985a.11.2026.10.15.09.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 09:54:56 -0700 (PDT)
Message-ID: <6ad10560.06b1574e.71e6.01e5@mx.google.com>
Date: Thu, 15 Oct 2026 09:54:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3359053023849530407=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, altomanigianluca@gmail.com
Subject: RE: Fix use-after-free in GATT client discovery
In-Reply-To: <20260930093928.360745-2-altomanigianluca@gmail.com>
References: <20260930093928.360745-2-altomanigianluca@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3359053023849530407==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       Fix use-after-free in GATT client discovery
   Pull Request: https://github.com/bluez/bluez/pull/2613
   Created:      2026-09-30 14:10:02+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============3359053023849530407==--
