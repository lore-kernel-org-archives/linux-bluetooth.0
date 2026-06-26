Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DD73F20FC
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 13:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782479663; cv=none; b=YZnBu3TIWD6sF0oql2BEZIYNsIzFoSNGz0NM2+zfebia0Hb7qIF8q+YloMQ826X0JmaJqhiVnUzKx08ejnTe0+kgaGCAgi9stmaTuCQ/MdhEshTUvn7JM8K85kvvfJXFkqTQTBkDb4IhpOdU/hQXnbHQ9wnFilZPo/gZphG4NzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782479663; c=relaxed/simple;
	bh=D9NsQSrswv+maqT1oV5/ImBuBY4l0az0pdEJyxi4ndY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GgEP71IYKWg0STtTv6PoK10bMdey5efO8Qd0Fv1U785fvP63HEx5ecj0RrNpov0QuuNAWNLWgwsI3VdgK9h1jiIdAp8eiJYgAjGmMyVSqrwljSwcOL5WkSmXL6YXsL5hAc3JM0UOt6rK3cd6gTTDLhdzGzJHZsp6aRgqUp9FgQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzBRRQrY; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzBRRQrY"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7e936c2473dso1047053a34.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 06:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782479661; x=1783084461; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=D9NsQSrswv+maqT1oV5/ImBuBY4l0az0pdEJyxi4ndY=;
        b=IzBRRQrYH8iDx2Y4y8PU0hAcqOiIdJKr6k9AEVX0e3TGva4n0TXWbnojwwRABbyTrF
         /UwQChLa66G9dGmrcYiIuyLcwKrLpIr/xYJEeagqKBPRxsAC8XlIjPyNwNLtvtRCbaS7
         XbSDtEbXKJnp6w9B4bwpVehVh/Zcw0ucoCXyaLAUQozviFY0dga2yebsEqLJ7IazGxCc
         qw1gsjvLZg2OVRZr0nZUTxQCOJ3lJXgy9tg2fI4SQE/hPRpzrFpLDP2wVYRKmvqaPSIB
         ur0I7buYL/N8tT1pR+QvkvknCeRbDsDqdDAfqIBX7aKXHmYVB5LRh+4GwJtdIK7oBH66
         kkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782479661; x=1783084461;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9NsQSrswv+maqT1oV5/ImBuBY4l0az0pdEJyxi4ndY=;
        b=r7cNf0VfBOByDf58KCUM+2veZZeyT6U/SrKcX6TpXZy4A1FgAo0mIsX9z7IPJ0HwBj
         lmml6ggYthy1B4vrzzBbQuzq15m/kJhMJFIh9QQ54DRSz8cvtpfDGjwa98lGW+txUBL9
         VXKcnYdodnHp1cRx+QAClDz2lpCpx56ykLctAEPiMV/oKP+NwyQN6GpM4Q3aEl6yJpsl
         8RHJyIoeaL0ZbWtObL/z1s6eru3PhuvZ04qSw9i/z0D8pJpDGI6VXi9tO5YqOaeGQApi
         PwczhVv6B0dZ7OvNlMSicLS30Qd6GLZJAcpxhV7yOmyi52wzWyE3KtY6Hvsqcaec2+G5
         EOUg==
X-Gm-Message-State: AOJu0YznPhPsCmSH0Zk8OcVvIGjOs0FrZ5Ewmlhh+mH+2N9NePG3zuJI
	CvlDLrExcYVZX+xfoRK0l7geFb3GaiRDVxJTPDmxUH+xTTC64/6C1nkWPXtisw==
X-Gm-Gg: AfdE7cm1RSkONtp2RGapS3BCsRIIuYUrOgaH1oPi9oSenLfBWXMwxL5nba3p57JflVd
	+cKNHHXv5Ka4ryfArEyYXbwz8qdLjq+bOhdKRKW4uI+a6ltFFpLfOX6cC1VTvpmZInkx/NZOFei
	lIhVoHLEbVhooJ+Z3FkxBjmU2YUkrkcTfge7m+GqFSAOxNnVogciPvQka55J9MiL7HoM+k8szZw
	a3rEmIPQDd2SIwWu1/bxz3m5tFwbAxbZuuYB9n6mPr9cKK/P5cnbXBF3e5TStrlosspXWOFtF0i
	caT+QIxuwjIhRd//4ChX4l44wsssnYfxgL4P3pkoxcobelHory+2H9XY8lKK9mJkxMpeeSiXTmF
	nTHo20pFdz7VVRxVyOI5B6LcXAnWkj2SAi6/oAmq+dJW3VxmBE1UQ16Xla3/wQvLUuq6AM2A9oE
	vBMX51ITQCEHeDpVtf0g==
X-Received: by 2002:a05:6820:4b87:b0:69e:53fb:7867 with SMTP id 006d021491bc7-6a13434f2a1mr4450545eaf.17.1782479660837;
        Fri, 26 Jun 2026 06:14:20 -0700 (PDT)
Received: from [172.17.0.2] ([52.176.37.70])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9b4eec3cbsm201589a34.14.2026.06.26.06.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 06:14:20 -0700 (PDT)
Message-ID: <6a3e7b2c.39be5633.3abf7.f196@mx.google.com>
Date: Fri, 26 Jun 2026 06:14:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7205822626114814622=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sivakumar.bs@gmail.com
Subject: RE: Bluetooth: btmtk: WMT event length validation (CVE-2026-46140) - 6.6.y backport
In-Reply-To: <20260626104604.3465124-2-sivakumar.bs@gmail.com>
References: <20260626104604.3465124-2-sivakumar.bs@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7205822626114814622==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btmtk.c:655
error: drivers/bluetooth/btmtk.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7205822626114814622==--
