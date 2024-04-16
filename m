Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBDE131BD6
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 17:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713287932; cv=none; b=cjo8WsPnHnMwsLviAbbrysFcJY0mcwsz3xNppaXDwdulUdGutlZzklGfSs/1kJlGHqj+qb9qAuJVHXzZeQgR66gSlLc6lnQhAIslmTMYyWLJYt3vYSM8UAv8vRxZgoj2pFISbsztNoI2Q1jm4zCeMhpWhlo9/ux4oyjTKzYAMw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713287932; c=relaxed/simple;
	bh=Rt0aUeBOqKn3XAEJkT+RpfaTFgu5rqXYaqBg5Lb385w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=c3ykgSUGQYF79HvWxnkjt+sRMMJIZ4Pp4+7Fao6vcj3fn36dPQFWvD2Yxt3/i5Lw37v6q//PgHiNNmRWMEoIJNMZuhjRpMeaIMls0Ux4TEmqvwtV2rc43c80qYQgHwnjOp4Fo7NKFHbCjoguSTOYeoK0gmxPLMd/kIAF1vFqn+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlBtvEPy; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlBtvEPy"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d858501412so60474501fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 10:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713287928; x=1713892728; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bZy59k4Yf4//hdpvug+/8aDp/2G24OIgYFKhyuI0VfA=;
        b=dlBtvEPyegUqqestDtsv2JLz9LU720meb6zFBgT5he15LQ8NTpsG/xF99ToJZgE+mC
         PGXkl54+wbUw2nnV6+CqFQpwQRoczbQKSHNo6xw/juyxpsI1lzitW7EkQtsACel3a9FI
         Tsb/z98pkjmZKokAuHOKqZA0votqyTX8iJ+ksXOWZXnMhf+1gs86vMnhvmZNjDdnZqhU
         ejokZkPG5GQAff8JFW/P2iyblaJJJ6OqlZb4qc3psBE2NFIVBT9QOaUngqd+T+4iAmQ4
         TWP17iy44Bk4UlGo9ZTJ+YmO87esguJUnh1wX+Dm/4BeOhULO7gHhqs+tpKhHXMluKTU
         qhEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713287928; x=1713892728;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bZy59k4Yf4//hdpvug+/8aDp/2G24OIgYFKhyuI0VfA=;
        b=OcbwyrKK49p/nFb1hIgKEV4TjrTk6A6fVTNOQum6Otmp8UN/yKXlolAh26tIRQEtty
         LkB7QjRCFY7holJdMOHCpOz0yAf/9i+wDUWZAgfF9oR4jJeZ2dCuHUdD8ebJBLALIHFD
         NNoMJ5zAm8PA0XolQLncptF61u29rqOWmkQ6UtN/jANEdr4Lh2pTQm/7ZpcMlaORxW+E
         h/4GspmYfWOo3p8e+eeunbDsB4Vfe3bzpaaEnO0VB8+1LQWGjEKeq3K75VI3QerHclPH
         BqbluFXc31VONK4yUSCXwN+o49ZuI7rnc5HqlI27ZaEeZG3JriJBooxaB2QdGvQFM5f4
         FFcA==
X-Gm-Message-State: AOJu0Yx8LLR8EmzEKsmUJ0coVFNgOpCMI0o1XruAla0ypuWqT7PhUL7q
	bqvrd6LqHCjIu4ru6CYoUNJEGvEfm5yZysNRtGGkAKwwJG4qSEeO09ntPQF6sLVyT/fg38tDd9T
	IrdN/6+EPR6DZrsa2rbPHhldQ1cO4BNeG
X-Google-Smtp-Source: AGHT+IE7AvrlMjxJ/i+ObI25KsHMyhl2fuxNeGHVW0niJrDm11PbFBgjXdW0tT6LzWPbwloAODn3ZZuAzGItAwVtnXs=
X-Received: by 2002:a05:651c:1994:b0:2d8:394c:6e7e with SMTP id
 bx20-20020a05651c199400b002d8394c6e7emr9282816ljb.15.1713287928243; Tue, 16
 Apr 2024 10:18:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 16 Apr 2024 13:18:35 -0400
Message-ID: <CABBYNZL9Tu2mdZeYdwgYuzATbvUMDxJb1T9jznnkxzscS0eLxA@mail.gmail.com>
Subject: Generic BlueZ Host Qualification
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: Oliver.Staude@avnet.eu, Alex Lu <alex_lu@realsil.com.cn>, 
	Ron Wong <ron.wong@nxp.com>, Chris Laplante <Chris.Laplante@lairdconnect.com>, 
	Arkadiusz Bokowy <a.bokowy@samsung.com>, =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>, 
	hannes.riedl@streamunlimited.com
Content-Type: text/plain; charset="UTF-8"

Hi,

I created a discussion in github in attempt to gather information
about companies qualifying BlueZ and if they would be interested in
having a generic Host Stack Qualification:

https://github.com/orgs/bluez/discussions/817

Some of the benefits would be that not only companies can reuse the
same listing on their products but we actually could attempt to do
more automation and use the qualification process to stabilize the
stack.

Note: If you appear in the CC is that because you have contributed to
BlueZ and your company has a qualification listed in the discussion
above.

Note 2: I would suggest not start with discussions about how to fund
the qualification, or who shall be the company in the listing, since
for that we might want to involve the likes of Linux Foundation.

-- 
Luiz Augusto von Dentz
