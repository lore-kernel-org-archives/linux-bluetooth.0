Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F87A26ED41
	for <linux-bluetooth@vger.kernel.org>; Sat,  9 May 2026 15:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778340699; cv=none; b=hxbJdxBHRFIIDQGI8KobOadK5rJd1p5om4kI8VteqzHfYXPJrtkccLD34QwPf2XrE7sFy81rjwW+xOv4Is5Gu2N3vOcI9YUYBiSnAUHYgk4RfOh1pwV8h0Yu2KTvKBv2vmAbo2HbQ0iW1F40wMNeAKMliKX+c0ViDYTsE3haY3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778340699; c=relaxed/simple;
	bh=HCySDTlk/5AUy2ZQY8Bwy+NCIU64YMqRRrySRnB4Csg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qBFxWa8Q9XOxvtTDwgEpt7YMvc+kHP+XPb6ifpEyQnmYG/PipuA0Ty/qDA7kpM8B6YVFIJwSn71JNEgCpJna9/uSg6m2VSBoTFdjVcM5XWtUArz7Kdkcvtbkm+j+gYzncjfqMTDpDVqQi5w0EOua4/nQWDVu0aT6vZuF8t2x/7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHG0gmvv; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHG0gmvv"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bc64ad08bf9so456591866b.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 09 May 2026 08:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778340697; x=1778945497; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCySDTlk/5AUy2ZQY8Bwy+NCIU64YMqRRrySRnB4Csg=;
        b=dHG0gmvv4aAOBLBusKjNeX0tYarzWTh74xwqusaTRoQHPG0CJ6kTRfILUpaDZ0oyxq
         lpRhZH1mCZVi6dlYixU+oUvXnGWFgBlDoxeY8wxnZ3xkqXn61uQgP3VcL+3OC7oqooj+
         UDSK37ep2hc3zXYBMhDzWe3dL3580PvnDz46wBTPiP9hOYe/YJo33rXgNk0vEK+68s5Z
         1G/PFTQmlgKwuEKs1reRdy0uVDsd+ly7rAxC0yDK+x1Y/d4vfpbcpjD43roIXoGOu7MD
         zR9Xn8oo+szcHJSfqXF/1uE1CtxxwnCoIzRmLblX9ZP8pezyWdgEBVdUPwKZ3xcCxips
         7nnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778340697; x=1778945497;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HCySDTlk/5AUy2ZQY8Bwy+NCIU64YMqRRrySRnB4Csg=;
        b=e6FZV3KZfRZVlf0WUtsMBCNAGOtzC8qv3lW90ui8JOU0mXiH7QL1c2kwdZJ49/iPP9
         U6R3t4+A5v9djePiVvzZPduncQmDFO9lSQjNrPj7rGm8PLhGn2moZr69vOkRJeBDIEJf
         xLY4ss/tOZ7dXMvzkHC5GYbng6vWe/vUgWsv05AHOMglltuZVTsymBN5RUMc6BjTyma4
         dvOvsbxbMka8fPbkbV/vilN0vZ2x7ZvNriDK2ZRNbxiSNJBaqaeHverT8kHvculYhkft
         boGN/5InNIJbTqGNXTDXcsz84wEQkG42OPzHxN+couiZGqa7neHS4deg4g0TpZeu1X38
         umlA==
X-Forwarded-Encrypted: i=1; AFNElJ8y54FoWqDHDi8tNcd6+6cIvZ01sM7gEJ4x+ix0Uc6x6QpMZrzU1Wlk8oZ4FLwARZFP60EHt/zAIS7H7XmHPIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcugtJF36hvAleFUbRtSEDuUGuPXSF5ZLAljLxnOMxkLrVAktK
	KldxlBAKBJ2nBw1+pcCWSlQkYBRqBiEtToRulf/1GODOHYqt23/y8sI=
X-Gm-Gg: Acq92OGxGQUc65bN07KYsBJBXLWiS2fkOOaGE2YPxgcSisp0KreiSnoDQfPx+oHV8ra
	wpRjafqtc2HYSPwIeGTPhj8BNYldZR+Os6JUbM9ompH9KJRyXR9BeXdVjWBG5+5+mtwoHVZtlm7
	+JS5WRsZlpvMpO+J6xxPStmtesS2gCFkxNGWUmSfBxMQU/Eu2v8LAA6T4wZ9sypWziozvcYgJNM
	VAuy6X37gRJ/GQ7NAhe+3oe03HVorCHK4zYGrtk1BM7Sn6xQaRm0palMpl4EFmXHw0ISR8Hd4bg
	iRgKnCYOypMCcd3fUmtad5TtQztMVN/rrmgD8VW69WUWkAR0HCpoQBIqql4NdEBtp/cUZ4D06DO
	Ovzndan4VmPcSEUQMuOLXTLO1rIqeLGbkcOhjcqbf8u7XYoB6xch7jJEjqssjze0+z50x1QywB6
	ht
X-Received: by 2002:a17:907:e148:10b0:bc6:14b3:e838 with SMTP id a640c23a62f3a-bc614b3f201mr807691366b.6.1778340696400;
        Sat, 09 May 2026 08:31:36 -0700 (PDT)
Received: from debian ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4549120eab7sm12303834f8f.23.2026.05.09.08.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 08:31:35 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject:
 Re: [PATCH] Bluetooth: btmtk: handle FUNC_CTRL events without status field
Date: Sat, 09 May 2026 15:31:34 -0000
Message-ID: <177834069495.1159760.2273651965423157568@gmail.com>
In-Reply-To: <20260508173121.27526-1-mikhail.v.gavrilov@gmail.com>
References: <20260508173121.27526-1-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-05-08 at 22:31 +0500, Mikhail Gavrilov wrote:
> Preserve that effective behaviour explicitly: when the status field
> is absent, set status to BTMTK_WMT_ON_UNDONE instead of failing.
> The OOB read remains closed, since skb_pull_data() still validates
> the length before any further access.

Makes sense. The hard -EINVAL was too strict for controllers that
legitimately omit the status field -- falling back to UNDONE preserves
the pre-fix behavior without reopening the OOB read.

Reviewed-by: Tristan Madani <tristan@talencesecurity.com>
