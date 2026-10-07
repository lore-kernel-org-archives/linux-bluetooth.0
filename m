Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3769D3D954D
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Oct 2026 12:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791374780; cv=none; b=oLVh1tT4E6cNF5w80n0D5IYNehbumo5INee68yJoKzzTpLK1hiHRBE+BjIqeSdX91uOssuTuEiivVm++tMG/HbAQsP8yACKAO/WGiv0FIFLsQy6pGDwhaWMyTInUcJAMdxTNZfws//qC5tOnHbp9aQP8t+wgQAbJid1oWY2/HtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791374780; c=relaxed/simple;
	bh=o7h8FIcEmmQ8YvkfOUP3oJWtw5waLwrFeZU8tbJUxyA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OI0w9WVg6tjzqU+SSsQCpgVDMAcJPO/XD/tjk9KNd8qKky6gewhBvzDrJeGrA8QaohFkq5Vg3GBQdWu32JOcmLuaCygu9Kafs77YRX4ZMxRZImZqLRUgBSL/dVm/ApW7uygLmvZQv1ApZ3XEkxGGk3yH2iKlqqespxXfqrRe/ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UkGak/XF; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkGak/XF"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6de1fd5f572so755058eaf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Oct 2026 05:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791374762; x=1791979562; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4xE7tevLwNsxASknGT6jnYaKOv9RT/ZLTRmv3R+xhCQ=;
        b=UkGak/XFt+H/Hv59We0AFGcpBRIt/EC4zwwRLmyXtdak6Jd4cj2zU866vRA5t2SGeH
         8fCfYLQu/ja7R2QAac4rYpvXKtfAe8vsDv6RI9Idne3TxM0oq6JVgJX2nbq97Wxv6CUX
         qanvwogzsivw/YOa6cWQ7ybGqI40R2GF+Cd9CQJzuXr1Kjy+9xWFstQyy3yLgJ37icyD
         iQXCnN0qjl8Jv67acQ0yxxtPH7P4zs28YvxEmKQS5Kt8cc1uenbXJU77XMMLaJ5R0Tp6
         xWib7XOXBvtn7gsjjwsKYNKNqNUkunZsDqVyLRL8pY9+4m7/Ugh6zB1lXpCEDHL5au40
         iaUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791374762; x=1791979562;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4xE7tevLwNsxASknGT6jnYaKOv9RT/ZLTRmv3R+xhCQ=;
        b=e8a40Rrk076F9MR31/6HFOHDY/mH8v3YZmb2dBo1VA4KABNnCNhN1U84DZakO9JM5T
         2hwXBXcM4KD4MBEGA1Df/cgkVIUTEQ3wDZEJjM18aKJPzoNKeUwnTdjKXm09upmEvJbP
         P8lQZIEm4s6TPlODtVUuUsXX4E3ub9a6yJ1qzVFvJpwj84dyEvCZ7dvLPWIDqsQIEPKa
         ksPDJeek9W1L26sfxQZotf40957ox4lEcpg93p4RBOjwkVbUA2TS2ro61FgmK6q7MktQ
         61i5+kSJUqvLyVyEsCydQgsDUIbMWtsirMuNdM9gAbAkb/OEj/GM0XfR+LEI8oLRViq3
         9uqw==
X-Gm-Message-State: AFuF++lKxP7mib5nUGpRSJJI0EiZeLWxEwOkky8NJmsZ35l3Mrswq3zx
	bXxywCdyBfKn7SdGRGuH8IXWzjVqTbXrZSEOMs9OxCPQC2YdzM/LYB0LA2M4EVHK
X-Gm-Gg: AYBFou1dVQIpBAYULL9xpzqmOg69hxtKTa7GpsQoGfbRP+Lry8a+z2gPuLtL34DobXl
	RN+AOrcYmRFfTy9MM9D4asM/GCUu5Uz0EeU4aAaypYAnWfAC2Gjfk5DRox4Y27M9qpCUtYLEEWb
	xeVmBB8gqtZCGa5I3tABOjAJ2ZQbEJeczOSGcZv8WEeYCvWLoNmu9oMCmA8ME0eH8q8DILm5X8M
	nhDW3lMfge4b0F8Qe53rlC4K9b3zI/2shYht40jqW1bfPza/h92gj0U8ohLQn/yNEDddc9BWObT
	Oz55z7IFBmBTKSxT87fIuX4CNTCYtPXmOEPLCLjkNNEMlwjAUD/HeFouJR9x43uori6J4mWA3fT
	BXwXST24O+BD6dR2OpGCtgtPc+IQwXYRyzB3lxaSoSJWgC6uKaxq+gQq3zixl9X5tIR5xCiFqTs
	v28aO++5KMd1U5KczXrgNbhc4j397Y9Hky8a5sztWX2fmSe7LEn2XCtLLZklog4Wq3goVAfCcUe
	XJNDqC/nwtF1GDMog==
X-Received: by 2002:a05:6820:188c:b0:6dd:9790:7dd5 with SMTP id 006d021491bc7-6e7a58815d5mr1996869eaf.1.1791374762606;
        Wed, 07 Oct 2026 05:06:02 -0700 (PDT)
Received: from [172.17.0.2] ([52.165.250.245])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a257016f84sm1928381fac.5.2026.10.07.05.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 05:06:02 -0700 (PDT)
Message-ID: <6ac635aa.e782ec0c.d8363.6d22@mx.google.com>
Date: Wed, 07 Oct 2026 05:06:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4815738903781485774=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nicholas.hammond0@gmail.com
Subject: RE: Cancel pending HoG reports before detach
In-Reply-To: <CAB2hQnT9LEYHqAk2k5=C9o32JBN3PHb9URLpA_Srw35dEdvGLQ@mail.gmail.com>
References: <CAB2hQnT9LEYHqAk2k5=C9o32JBN3PHb9URLpA_Srw35dEdvGLQ@mail.gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4815738903781485774==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       Cancel pending HoG reports before detach
   Pull Request: https://github.com/bluez/bluez/pull/2563
   Created:      2026-09-22 06:15:05+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============4815738903781485774==--
