Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5985111B6
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 17:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789062175; cv=none; b=IZKia9CTu34kUZSQeetiKJf6g2Sg/hLWk5dl/D83YO0jTnwn9kuhnEAJzY/RD2uVqHZrWwxJinMtXNbaRYf/+famN2ngaFtAbbUjZCwY5DZwKrYKlz417TSUpZZQGfEklZTYpl+wUdekH9b1PrGuSAetXvzVOaHalIsDeBzCIIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789062175; c=relaxed/simple;
	bh=HaeEm+5wY8ixElFuIQpjXuyMdzlllvFyDuKES+Siby8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=sQfd1r4PACn0K6Lmb6Sba2DPFFAfd1eKNhEIOPf9GRNSXj2fBD5ntaSVsQzwe8Ow7jI/MNoTZbg81w1gzVfK+Zl9o3SKi4wAi5RzSAicQnJa7tMV9ZdQFUKdVUhG5ic/bd//S+HR13Udd6Q+AkMauaFOlUDkSunJ0WoH/ADBLWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQMWLWSM; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQMWLWSM"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb752so2668888a91.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 10:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789062155; x=1789666955; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=g/DcN8xyHQyEyPNouj5V+VCQirBflS5p7i5teLQTUI0=;
        b=NQMWLWSM6cnAywM2OFr5XrTT35chmCixaPcJcm4Nv72EmLe8r5nPsavQSYPFSAw7jt
         4VVwYYt0a3UBWHve0xxJVZec3S/919U0tI+ukGo34ynVTKPsG7uY2bbEUQek0oZQ1BAs
         QoEbCtj2ukTCl61tDek2I0HzQ6g74Jrr2pQ8AIl3/oVjxfgIxEgacpHf1Nhj4NQUzPjD
         LCSU31g8/5ZRZVJJw0oFULOWxaqORS659HiM1ErVP9bOIywZCF3fmR29k4BXm3beEQhM
         uRhduiqY2D+duIOUyVwM8B6sk+7yhX+Kn2qAj/pcuI3Se6soos+QAnKv8xFznl8UYM2u
         5q/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789062155; x=1789666955;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=g/DcN8xyHQyEyPNouj5V+VCQirBflS5p7i5teLQTUI0=;
        b=K71+Ev3GH9cAya/uNWhwRUZ0/h/kg7h8RHV8JMRsFnTUR5QjA9XZqKCisziH7MIYxm
         DZB3hQal4tFFbz8vWjtA+Pvdq37I97wCcJQxdsjZty5IXqM7h39TvFWSH+B30GmXh3Mh
         SF0X9Fd5Bqa3y3bO8ah4F2s2IQtYEZ6h2FAlmjLhUsR+RX8p9+hLm59DVi3zh7aMKz0j
         E9AydvBgQ950LLG7dYnlFz1/1D7KpTnp2MHdSXiKO9PQB6xV2HOapaGx2/79+ZA8d1kM
         LVK8jxFjju4DuERQZyBZR4khKj/8AGrsRgl7oNFcyjBNtNLTe68tmwibH6LLsOwt/vik
         0YTg==
X-Gm-Message-State: AFuF++l45Cnz7ijCV/5npCq4aMM9qSM+lX5qcKIqL76mKYNSm1ocAW5O
	i/g2VfDXLNXGABUy0d0NpmqgDHhWGdRVHCMKqw/3ksG8htkLUquuJr1sRcxqJQ==
X-Gm-Gg: AYBFou1/ukcyJWDqo/xLpgHHoiX0AJfo122eQzYiUwOLROrqn4azEPxTFPV8HVKxOEA
	UUlzkq2M2JsmP172cFBFFpOj0DuGdkYJGMrvfKPzhn0Ltj5wdFK0iqWfp8o0Se0Dje9096kvk8t
	3XHKgnew5uI3be0nbanXWwf7oIRDFzuquMJl440oxQWi6JilNB09IEUqwrbnJhP9159kygtld/2
	jRZoVyNySYAgsQl/dkyVjprrPd53rgXfN7/cQSMjXSKancIYOxeqqD8fTL0HoqIqbJPvF9LA9zU
	26tLJkK6oBvudnoh3Cl4Fo09mT2bf48Ww09117vZX13iecRMZ3fHgvqovKAurOnFRB0w6XZSx6l
	BHRzz7sNERNWlOz948BSxEkTOAf6sjZjTgVd5J0mN2bo+9xL9Qi2db+/itPuD9V+iG6mc+HPHTd
	CRH/WfzuE7Meuje+OBjj7jPCR4iQWtel4/ABYyfHWO4Iq3xfC3PFc4UVlYvBD0+KCZc3X7BB0ZU
	nIvb+vQMqe2y7Yn
X-Received: by 2002:a17:90b:3d89:b0:398:dcfe:968e with SMTP id 98e67ed59e1d1-39bac3f9063mr22298627a91.20.1789062154290;
        Thu, 10 Sep 2026 10:42:34 -0700 (PDT)
Received: from [172.17.0.2] ([128.24.161.17])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33987ccf483sm14584945eec.20.2026.09.10.10.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 10:42:31 -0700 (PDT)
Message-ID: <6aa2ec07.daefcc87.14b7e1.8dcd@mx.google.com>
Date: Thu, 10 Sep 2026 10:42:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3725961078391331200=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, naga.akella@oss.qualcomm.com
Subject: RE: Add CS distance provider implementation
In-Reply-To: <20260812100345.2956271-2-naga.akella@oss.qualcomm.com>
References: <20260812100345.2956271-2-naga.akella@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3725961078391331200==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       Add CS distance provider implementation
   Pull Request: https://github.com/bluez/bluez/pull/2397
   Created:      2026-08-12 10:44:46+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============3725961078391331200==--
