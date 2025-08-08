Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508B0274FF1
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Aug 2025 11:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754653567; cv=none; b=cn9ISprF2RrIp85mgccsA0aDEFZMpXQN74eoLlmW5weLAQjOx3b9acyqL1eRgRrIAx62LO0fwQcUlgpf94sTFIKukHf9Rny88ZJXiWkEVDRX63jiLnwzrh5HIt+S6RB92QlClq/DiQzk3hjyG+9TXEldKbjGf+sEbBSTw+m0l2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754653567; c=relaxed/simple;
	bh=PcPGTtncImF8Z5wvneLo9VqcFvCNyY28rYZn5EbXSL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=smcyLOgDcU3bP0q/Bv6AJK5UOHjwVtY0WGnFxn4hSmHuGGdjUL+DZChPUOAtBsF0QLafNyiXtxcm13X9sTiEc2yUEi5bflwbHPN90yWM3C7QWt5eCo8zys1ovsGyW54rE5QgMcI1HrLiGXTmBmwT80lICagUxHKJVa/yuElW8qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=naHbOvQc; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="naHbOvQc"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-70749d4c5b5so18230746d6.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Aug 2025 04:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754653565; x=1755258365; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PcPGTtncImF8Z5wvneLo9VqcFvCNyY28rYZn5EbXSL4=;
        b=naHbOvQcoSo7x/k47TLzW35DprN81KGj5QOVC58Auf9m8Z6DbDUt4lIb3x9n8wrRoo
         UdZyZ/6KZBeLk0PtL58xUuVEYqqpyiNwZgH+0W/waXXiyPc6E5swj3EBpaN8K/TwsXDm
         l7ClhrvFIvXBJShjySYitMYVuLlic5aogQpWzADk9V2JtPkp/efT76/ZWDCOPQulH1Tg
         6toWgTWgFpeIB8kBQkW8yB+5GYhL1CW3a6URAqOfO490nfEYO6jhhSlGb42YMMbjAQJR
         EM6LlI+MGRl0/grkb9XyPTRSChHBwuBgZ1E/5OkH/MEX6B0Tm5xFLQ/oRRIa1KbfgwCm
         Yjng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754653565; x=1755258365;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PcPGTtncImF8Z5wvneLo9VqcFvCNyY28rYZn5EbXSL4=;
        b=NF5pkLCIq/cZVl7YQWr6VP2IUPhwu02v9NYUj+ATdOCF5G0wXytfG5sj6R4Lk3xZB2
         HyjBxZren0dqzj//FCNDsw16QUl3dsuqwzEUHd+RvSvtDU7n2S2eUCYNlCqi2nPoR+Up
         6/YFAo7UXrVnAN8PUdaOSBz7cGjfDn8LYrpEiviTpIdgfqEIUXBJ3RIZIcMzs6UV9tM+
         Dj58TjGJszKHIKjYQMRES9oOYIHMVR8F8zyOScaGNtWJ/Y747I3XLPZUsFUGiY/Z0biG
         l8w+7Lom1yOw4Ymfgf7Q0VH2/DEOaX5gbw/UTQFMy3hkOOppkBR6QVM8btMZ0Q2oBtwB
         /Wmg==
X-Gm-Message-State: AOJu0Yw5EMYNTjxEUwWAR9uRxPdcYzRsLtwgNkauO4KIh3ul869FlgRy
	QYNA+QwVHqJMIAA5CcbjKCbNLXqGOK0q/J/1ao3UytPY/KaWk5uKbB/DnFSGgJ6k4WfcMs2kztF
	896x7dpBBX1A+QV4yIdzZT+1f3w/GLsY89xeI7WESiJGd/MvUTEXeMOQZgt8=
X-Gm-Gg: ASbGncs0V0ZDbHPsY075NbJSc8giSNqyabmWYYMxGgdKUDAIhuAJOpONqCMiwOIxdoA
	y7n0JDDHM1NY2VXkaRetrrxB7XsETBzOuk5ce0TVTFGJo112VOjP0sHv042POEG7fwEempSan4O
	Twte8PevORnk+kyY0oY7hSqH2fwlEhiq22cPSQjuteUdSGhqX0KxBJvqQKY2u9q6d3L7wPJoeNQ
	GEJ3JHfWZhOpmPIzosgYRQnRarXxz4fMRPLg8H5Xg==
X-Google-Smtp-Source: AGHT+IF3NYtu/F1UjXUxvRyXkI9Km6qJiYdBO5d0m9Yor84nlDLoSRc0gk5HAYSsBvkankCJY+5vHiJAMhnxlfYMDpg=
X-Received: by 2002:a05:6214:230e:b0:706:c5fe:d3ac with SMTP id
 6a1803df08f44-7099a49dcf8mr29306286d6.33.1754653564724; Fri, 08 Aug 2025
 04:46:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808013402.548986-1-ochang@google.com> <20250808013402.548986-2-ochang@google.com>
 <8f18dbeaf80530fb3d460060864a2a15f73b7039.camel@hadess.net> <CAFqAZOL4iKjuxa=ubwFCGHyfgtuGBCW7F1US=1sYSoeWiMZpTg@mail.gmail.com>
In-Reply-To: <CAFqAZOL4iKjuxa=ubwFCGHyfgtuGBCW7F1US=1sYSoeWiMZpTg@mail.gmail.com>
From: Oliver Chang <ochang@google.com>
Date: Fri, 8 Aug 2025 21:45:52 +1000
X-Gm-Features: Ac12FXz35EOY3cDsPRPtuwXYqCu7T8fYuEymn6MYFrL4-w1MUvHpu7i3wNieWHs
Message-ID: <CAFqAZOJzuHn=hUO+xyZwQBh8u0mzABkDf3==imzxkQmj0czGhA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/1] Fixed heap-buffer-overflow in `compute_seq_size`.
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org, oss-fuzz-bugs@google.com
Content-Type: text/plain; charset="UTF-8"

(Apologies for the noise, I'm new to this. One more attempt to resend
this as text-only for those who have seen this email multiple times).

Thank you for the feedback. The problem here is that there is a heap
buffer overflow found by fuzzing with the following testcase:

`<sequence><foo/><text/></sequence>`

This causes the `compute_seq_size(ctx_data->stack_head->data);` to be
called on `ctx_data->stack_head->data` that isn't a sequence type.
This patch adds some type checks to guard against that.

I don't believe a regression test using valgrind would catch this --
we used AddressSanitizer to detect this.

While fixing this, we also discovered a memory leak in the error
handling path touched by the patch (` if
(g_markup_parse_context_parse(ctx, data, size, NULL) == FALSE) `),
which we included a fix for.
Would it be better if we separated out the heap buffer overflow fix
and the memory leak fix into 2 separate commits?

Best,
Oliver
