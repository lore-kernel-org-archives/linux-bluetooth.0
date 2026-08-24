Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F27436A352
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 15:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787584838; cv=none; b=clv/rSsFxb0QFe3JT8w8UKgrKs1OAjlDfNVqI9cR1H3yPqLZ27cQj5WNipaKsZi9RVVf1iqIxHsAwbj+ElnZbeGb0MCyEt9LdESENGoo4enDJ7oe+oskPx6ku59JPNEX7Y8ARXi2Hr2ncrdULO7IQfNWyhiaSIQBLBiL6gRuJ3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787584838; c=relaxed/simple;
	bh=C+TelH3AlZcX47ivj645rZ84HzDP94p8X5F+vZbw0ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZsgMoQq3PJGQrxHweReEwHR6ttZWNJHUkz79eSFIFD2dDIQijZhsODswPr1WqNgmG6bOUOU0mCd1H0Px0hAw6S8BqtmYN8EZS2JTV7ktQd8cqLA/f7m/A5SkefoSqJL+k970epSw2G74f/Y0bRbIa+rvwzc1nYZAWrIt1Bg5DTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdMsfuZq; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdMsfuZq"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38dcbade417so4277129a91.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 08:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787584836; x=1788189636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=frPrxefuhESfKlbGZEYzZ+IYOc/LSZSpcmZ15xxxNFY=;
        b=HdMsfuZqpKAPUG8LpEs7kUs6fPzkOhaV2Wo6TAEpoL1SieyEm1o4wSgdtNDnZh3TNC
         0mEW1XyXl4OAWDpe62niabGEq3jQYczHwB3g//N3uYVln7BKTWAsx2fYi3neTOsfeu9I
         0/lBaNvXdiloHuTfiLNpiTINsmpLR55zAkagcpBD7/nAgf1rFryNGtyFR0kS+/GcpyjG
         eTb83dEHWzcj3RO8BTXpflv2SvJJSzShkTqnC907OFDsjBsLLLFz8jj8WThqJKgMYNRv
         BS5LEHTSrn6XQ5xuONwhj0PD0y0nEYIv0FmOXCHYQkv1Yym0g9bw++kiB7Kdnjc6mcME
         pP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787584836; x=1788189636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=frPrxefuhESfKlbGZEYzZ+IYOc/LSZSpcmZ15xxxNFY=;
        b=paVCWNoVYcABhDinp0xVhc/E+eX3HBqkcNtSqka13kQM+ndY0VEPVwGkpjVO+8mwyM
         1k+r+E/ZC/j6d8tcMSRaauheBvWahj9WR5G8GIYFNqL1C7jMkE9A+hXqaKPtKYlnnc+9
         bSqRLKc9jJRGEayc0C386l7Jp4DCB7xmPP1eqnhYwYvRz2ryISm/gOR51tWAS/jbgZZy
         ma0L1prdPnDb70PZpJulJVGAg9NDEzqAw1L7+AbtScdzMhbOK5yeDME8pIsaGS13rcXT
         Hla7nF0LrXc+LXPyWtLSVwQXacewoJx2GDvnUyFEw0VszUs1ZeBVD1dx2SnEv+Gg0yJC
         jChQ==
X-Gm-Message-State: AFuF++kaPUNEulaJ+9C7ZuPLA9YSdLBI3WfZEXlHWYUyZtFpvWaTz846
	8S/GSsnu7l5yZzsSxIQZHGBAkKJbjYWEOtKYtyo7dAZKq3b7eehcWAmMHuoJBA==
X-Gm-Gg: AR+sD12jbajeagGFf5hvTRlkQN6AiX4K7O6mzfCDfMWa9MftHl0e3vBkvXq3Sq0rGJN
	5WMoQLfztsqtt/EHnO8qINEUqlsHqNmkzNP3/OawuiZ+JPyMmoYpHdwZqq9QqfC10lkjdfJYI2v
	tgJg/1BOsUgWKLc2f5iEXT7d5nv6KS3/8Pi5UQPQuJ3Su2D2egxIQ/pzLdvX8zxryvD3y3p/rAG
	sUp//USWApifok9eBdZIwZANQBj1tmw939nL1Swc0VZwLNvGfiSYbiSBxzFpYipw7HrklBVKMYP
	lYQqnbWQ9mZIl7H6cIMID3zNb4VcuvJmADG5gXczth2HdU0ruch03Bgl11Lq3pkOchYPttofsQp
	Jt19bGirf+Z9ao4UYrE/u+9A7mv77BcOCI365GGIJW2g2BLcdhAYT9MksjBhzvb3Q9proa2UMRY
	sZOBS9HF/KWK6gx9t9XBOwW9uUKt6S5ePr1/D5XOd1hQCe2YJdsPsDhmyqhYAlbGB6cug0RxMIL
	NKHEuWKieVLr5e9VAFRxiZ50vo7kvjMP9BEQOynJP5bYUfZo++r8d9EKofvTOemFzMI20foTbiC
	gNlqLH9LHoPg1VtUvd3AWQaUvmrjq10D8BqdBurWI1C4P4ab5YQKRIJLLDZ4vhHeVnFkkw4aZf+
	/gN+RMy/hI23AvC8o4tP5dSXXpfLtQBQd9UZdAr4BWoHXNJaF+vet9uP0bFk=
X-Received: by 2002:a17:90b:1b04:b0:38d:dfd1:7c1 with SMTP id 98e67ed59e1d1-395c33406e0mr46004122a91.2.1787584836296;
        Mon, 24 Aug 2026 08:20:36 -0700 (PDT)
Received: from localhost.localdomain ([101.251.7.10])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32814a06261sm11384329eec.21.2026.08.24.08.20.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 24 Aug 2026 08:20:35 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_codec: validate vendor codec count length
Date: Mon, 24 Aug 2026 21:05:29 +0545
Message-ID: <20260824152029.51492-1-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <CABBYNZKJ10anQiThzYturqWyRxhnKY-xOMKhKHF5ysx37VmHkQ@mail.gmail.com>
References: <20260823161638.32348-1-acharyalaxman8848@gmail.com> <CABBYNZ+h-m9YQCim5Zm2_sgARZh+jM=POFYX_zTQ=xYUdxz-vw@mail.gmail.com> <20260824144051.50010-1-acharyalaxman8848@gmail.com> <CABBYNZKJ10anQiThzYturqWyRxhnKY-xOMKhKHF5ysx37VmHkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Luiz,

Thanks for looking at this.  Sorry that my earlier wording was unclear.
I agree that the uses of p inside sizeof() and __must_be_array() are
unevaluated, and that sizeof(vnd_codecs->num) is a compile-time value of
one.

The runtime access comes from the third macro argument, count.  Here that
argument is the expression vnd_codecs->num.  Since it is not a constant
expression, __builtin_choose_expr() selects the size_mul() branch, which
effectively evaluates:

	size_mul(vnd_codecs->num, sizeof(*vnd_codecs->codec))

Evaluating the first argument reads vnd_codecs->num before the result is
compared with skb->len.  Therefore, if no byte remains after the standard
codec array, the read is already out of bounds.  The issue is this count
load, rather than any evaluation of the sizeof() operands.

I also verified this with a minimal reproducer using the same macro
expansion: the compiler emits a byte load from vnd_codecs, and ASan
reports a one-byte out-of-bounds read when the pointer is at the end of
the buffer.

Changing the trailing sizeof(vnd_codecs->num) to sizeof(*vnd_codecs)
would give the same size, but it would not prevent the earlier count
load.  The added check ensures that the count byte is present before
flex_array_size() uses it.

Thanks,
Laxman
