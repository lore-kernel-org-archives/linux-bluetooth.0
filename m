Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E795650E5
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 17:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791999173; cv=none; b=Gmehuey73+VN/HAd71L7jV7JWqtty4O2S09q0HlfvEUgJiaXfCqFHN6rklyS8GW111ktXVBvY0cqP1vPZilG9RunxZ6+BEP+QGasDCZSyFAuZfvhHvDa+sUESMj7wGYaO2OQMtwUGAfdsn6DtDyK3uRItVEqM5GsYT2d9BReK0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791999173; c=relaxed/simple;
	bh=ObSYEgWgHpLaU20ZJcRAFl4oWCkj5SlE2lo9MQUBkTc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=kwrOc/P4iaiF+w9n+0hdtb8CCn7Cy3oizyxUbNoa9fbmr7AWQ1F/fhQfuPgVjSGT5YjGoJeRf8YEQdqDbwWL5tcD3d8SnDBderGRXrLMMvDPiTJcfJRMukwXrKZOnMdzBhpGvz2tM3Dsh/mcXch+++iemnZt+0pnj7CzaxxHORw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lt6FTb6d; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lt6FTb6d"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-91ba702cceaso7182496d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 10:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791999163; x=1792603963; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JSlMwem3baQkRMyP/NR4ZRWMPil0JVcn7IRrnRIb7oc=;
        b=Lt6FTb6dG/eeEQ2eQc3nuykR93rufqPuu08keSYyCbq0TcrZgFLl1AQSO/oT6duRFb
         F40YFXuTZGKnM05hGlInnyHrJB7wwn4eTpCLHNekpqqQ1UUfC0+1reeQqspJwz4Pjj/f
         XJ952LQX+p8Pj7V3BN2sJF07IbVz0gOySOFlXL+LUiSlZrah1M3/N10RFRC+p5BjZI8R
         RG27+p2JdsGNTRRY8NeBqi57mMCjsIriVvDxDo0SAlpHR9WQwBST7qLXBdTplBYtE8z9
         V45+docOe6NzwVTSH+KbJ0yTAPGBv+0v4r+Vpul5pkAtWooStB2nqtfOyLv9DHDmG7M/
         F0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791999163; x=1792603963;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JSlMwem3baQkRMyP/NR4ZRWMPil0JVcn7IRrnRIb7oc=;
        b=QBmD8835tZYN3AjTmzwrfIX3L7Kw8ytggiyVZBQ47/l5qtkb6ObPZIrV7j1VnIhTXP
         f5Ot3jrMCPPL2vlSnX3i3vF6D5vMFYrnTrWwgflEF3tU2qmHVjhyovjLe3U7iE0A9fek
         E3F7bANmI9ofWxF5PvkMjDQ2LBZgEjhPqv4GTsUZOU6iCkXAlxzXEbAEC2R3rEqnRJPO
         TkJjP92fp6NSh9rhJsUufSxc45nH0eHqAlsH9+9cyninK7aXTjLR4vLfFI96+TcldWsp
         2u10uodscdRxz/8m0i596ub/ji1OOCSM19rRU7Am1OTDcO/GtExiT4XRysvm7sex0/a6
         zTyA==
X-Gm-Message-State: AFq9FYKP1jB33HLPSrAful6foNAPI5OmCyMFoIip/JhuCHjzwZNhLuMP
	ZqhYLCA9lIMMucJUe4edCaLt52drnisoxl5rc2lbEH9w2FXE3wFcjINdu7/N8w==
X-Gm-Gg: AYBFou0JpkWIDrzuKYwnTfjyzyf7oSNUcqhkuS6peJ1bAd/xjFLPQs3ebaOfg0GjXxY
	JYjkPsse+1ZWlt68cawThFgpGzqfoOHZk5v82I+gDx0LjtjvEk2shvXiN7YOC654cnOy3c/tlWx
	DO2YCwNxyc/19Z3gn/4uKDchdIxbg8WJZ7QruC3Vt2TvZf/Ocix+vnOlc2f2WsumAx/lZ1WjawY
	boCT2o7esPAJcCJr55k5ajeAk69AZJOYCHemqndGLu2RtCUZgoCt3QF1RByjyaT+VK4kFbYdsTC
	+vXTbbQbuq6RJtuoUgX6cQDrCOx67V1A38CnL4k/fuJWVi2/7gtYLLZRqb+nM9+BPycyCN5W29r
	BH6fMveQj7DFhS5VifnfGDKf+tQa+sEkClY2M4WjeqiqjLEWZRUnw4XCEXr5xgPZQ7SplyxT4O5
	NXz0fvYkp962N2c4q4cI1R69pwIc8FrEn8jZVH/eDMV2VXKOctOgRGDvAqgyLQgw2+oXtqc/Qj9
	i0=
X-Received: by 2002:a05:6214:2585:b0:919:5a24:d20d with SMTP id 6a1803df08f44-91b554b75edmr299046306d6.11.1791999163058;
        Wed, 14 Oct 2026 10:32:43 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.9.227])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b97b9eaadsm57658676d6.33.2026.10.14.10.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 10:32:42 -0700 (PDT)
Message-ID: <6acfbcba.9500dc99.31692.bb70@mx.google.com>
Date: Wed, 14 Oct 2026 10:32:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1084371562119379226=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,v3] avrcp: Poll GetPlayStatus when position changed event unsupported
In-Reply-To: <20260929121749.282866-1-frederic.danis@collabora.com>
References: <20260929121749.282866-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1084371562119379226==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [BlueZ,v3] avrcp: Poll GetPlayStatus when position changed event unsupported
   Pull Request: https://github.com/bluez/bluez/pull/2607
   Created:      2026-09-29 13:51:02+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============1084371562119379226==--
