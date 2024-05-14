Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD403D69
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 May 2024 00:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715646588; cv=none; b=g/oyYNl/fMy6BnBiNthx1P2UoSi3Xg5DSf3ik7d9IF4w2xPT/SdxU/tYE0NhnAiyAyg+blqIAMlmuVI6F9ReQ/3w4/XgasQMHQj3LlCgbT4DY715t2yC3wC6XT1FVsy1qF5rK/hYgBgM+2CYT9BlZHiB7FlkMf8pgpq0fRlt4Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715646588; c=relaxed/simple;
	bh=eT/1kXsEObu5uoePgPfJRKxaqjIMsA2qORYEqXFoBSU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=YXo073R3Af70QvxtMcvxYUYAvxpXh9bzcUMBDPiiejhx/FKhiJKTfa0QG7ZPHGaziwICzZS/WDsnBxD9ZYDeK6s/oaWCi/WuGtYL91lvQGBHzuh/8VV6y1JnnR+SVTsBIhqqnYnmq1LdP0qdyVk9ORSQabcg/oIl4gLHbYRl4hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVgrLgVi; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVgrLgVi"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4df439e1056so1601998e0c.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 May 2024 17:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715646585; x=1716251385; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dkU/9IONHpeyJhUtZNMiIqGnh6LMbsbmj1o0H87y17Q=;
        b=eVgrLgViWSMk5PWnHJT3ee4Ped533Q2/a+nQgP4CFR580LnaOWMP1bvry8XtdY5GoW
         778k4iPtucTY+cMkQjUyFJ8nAwa5lLKucGf6QZhn5l5/8ySY+cawDjPBXSPPYpgSo2Xa
         9mPF4TF7HR733PQcuceMJkA12kXU5jfPjCgl06Jyh1Gi+6rka9ZsHb+iYZdsaBMOvywK
         ddxNluEMmZ5v4n3nqAgp8rTKxRFSOEgsVcP4uwpsNXntfbWTzE/QsU20WjxZ8668Tk3E
         N+YUXtQeo6ivsCsZoQ2O8z0zmv20nSGFrnWM+BQol1NxdgJauhP4PDw29RFgCb+/qJCg
         +2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715646585; x=1716251385;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dkU/9IONHpeyJhUtZNMiIqGnh6LMbsbmj1o0H87y17Q=;
        b=ZzGVBhogub96wTmw+Hmow0rymOHFH1JHnAPgupUYUItU5SCaI4HBULX60eCl+6dyfl
         ASmpaNsP3OqaN4sHpHk6XZ0B5FQxwo8Gunmr+SAVR3b8DPGLsRaIaGMHdXVI6FcvYKUu
         G2mSvwwnwCvvXHqC3JjYbQ8WiwCr7hyBfcK5GPrRMW2D0iXganvon+g30jebb+osu0K/
         1voLnvCbG6xZnKUhyzKAoKqVG+4Pp5+CETc9o1E+t3hrMazhniLL5AWPEEUN0q4IrOW+
         vHyfc9Na5zS6Dabu7KuEBbe0Uk8KwtI25p69/qolxfzhd7z5JVOXyLx6JvQynI9BYbfc
         XU/w==
X-Gm-Message-State: AOJu0YwSAkV/JEvmm+Xu3hGhbS84W9zW7UeXLc+Z7wgZqXlYvGZMd8u5
	uQNMl7BlVxsifHtynfMaaB81r83Df+S1CKrp0hTxkB37UtRpecnmxolbZg60tdz+NJnxT1ZaUpt
	SHrskpExBObYn4xIGVdc1lWfkySjgnT4+drU=
X-Google-Smtp-Source: AGHT+IH17TVUpZhIWf4veP+GIpvurkRe9VsEQxZJWRX9vkXMtRATp9Ipn2+a64QM52YZ/4nOERqLOS5pQXmM3jH0BCo=
X-Received: by 2002:a05:6122:1696:b0:4d4:15d2:8b3b with SMTP id
 71dfb90a1353d-4df882eab40mr9527802e0c.9.1715646585366; Mon, 13 May 2024
 17:29:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: WU RUXU <wrxzzj@gmail.com>
Date: Tue, 14 May 2024 08:29:34 +0800
Message-ID: <CABuKQijRjx_i+yR9kACgzWXYenUavVijGseKiuph2WNbsBJD+g@mail.gmail.com>
Subject: bluetooth mouse bugs in bluez-5.75 and bluez-git
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Bluetooth Mouse Device :
Logitech  M585/M590

When I turn off the mouse , and turn it on again , this mouse cannot
work as expected.

in bluez 5.74, it's okay
-- 
Thanks
PGP Fingerprint: F7BA D6CE 6592 77C7 0D2E  3BD5 5479 A15E B305 B8FE
