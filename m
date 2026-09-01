Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FD4480DF0
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2026 16:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788280461; cv=pass; b=lca73HvYJWPDhbyRPJSN89pfszeLBWVJeC6hBsyRVkLqLAy/lYlUyMXN6bBfTdAp/zIl+f7Ag4cZb14BsK/rk9MXTJgbKQM/si0U9rD4lWBN9lvdVI+4Cd3N0Tt4dd7Ud4QaIAKNwhL2vx5cDNrwG4cBXdn5i6PcxnAjpGLIjkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788280461; c=relaxed/simple;
	bh=iTpIe/h3ytNDgDKrNfMJi9YcEvscMgguwwTlaEUSED0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oenuzn3Fncb/PxtGypBFjEkp5d0ChqZsb5Yqrn/SinYcVM1J5l+0GRsVB9iwI4ZSWgAI0K5Jd9DOxkfJjfdZ1PhA+3vnEozh7D5KZkmtk8636TsQLfLEPt54PomJIfLxM7p3Fn5I9/Jkxz2NFqTSWgw+dcjTBQnYQ825bZF7cyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irregular.at; spf=pass smtp.mailfrom=irregular.at; dkim=pass (1024-bit key) header.d=irregular.at header.i=@irregular.at header.b=eWRsH0mr; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irregular.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irregular.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=irregular.at header.i=@irregular.at header.b="eWRsH0mr"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-66f79f58123so79814d50.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Sep 2026 09:34:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788280457; cv=none;
        d=google.com; s=arc-20260327;
        b=RiEG2/qeRde2JGuCqybhiAAi2qYbX3d2b0/hmelcBc5SQ3nOJ6ToQKZfyJq+079uUN
         guU0czGOYnMO0e7yZacLUCM2wXaswAqLyHBUlcaU+5ZxcjRMOrXp8/rij5KxhfbsfzOT
         XewkOCNs5pE2LqKUSmKwoqRcaTYW3JuhtTwZzewUOVDjy90OCTvK5IiARc91Di0WL9KF
         Zg/uHSdC5KvLnCmv4Xr6BVQLQGg7R4GipSOvss1t8IULaz0pTd2yGRTgj305A1hGGC8o
         Lavs5zl5as4OwC58t3jDTPuB7m+Rx199Phv+AYcvV0R7xX2mzifac1WKL1QDW9ELQMGB
         n7uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iTpIe/h3ytNDgDKrNfMJi9YcEvscMgguwwTlaEUSED0=;
        fh=gM34EDS60QVgaEHrDJCaIeDThyF/pNEydYN1nsvi5g4=;
        b=aKcSozhgshO4suSjzqvgS/P2rSBpJYiuxKb4+pduef6x8rkH+5XzqNZvdEKBl4kZzn
         1X7mplMg1B9fYCNOtAfGk2v+B2R/h2FaEH43lNOxxnHMdgy/XPpJM3bRSFwEenB1S99w
         GDYkKDk0fVWGO7ULg3oZXEy8+Spof1aMZ58CZFjSx9nt6wZLvNPALRSOzQV7tFxvSeaO
         ItNjvWwckhwsndyaFtvpLK+6ZknPOz5oPaL00q9m9uMuJwikcO7jja/jLMagoxtDxIpS
         z3QUwG7NZ8IhoTEXD6N38c4BsVi2C6nv7TYxvwzKLkn18IuKTcnUsWFXKd/J+STle4hs
         DYxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=irregular.at; s=google; t=1788280457; x=1788885257; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iTpIe/h3ytNDgDKrNfMJi9YcEvscMgguwwTlaEUSED0=;
        b=eWRsH0mrq9ya4q8SUIb5hURRRPDu04rDk8zo/R/vxvB0AWJqi3+fGwJ2w4JGmi9oWO
         XCmYBrhx6BNlohQ5lcNncegByUgpkWpDwgMsmZNfOvJDbIiedKlQmB0Pif4w0mtRAyhg
         dmvQlZWUgOu9ImuhOmNb7xI9/EUHSy8Lwsozk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788280457; x=1788885257;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iTpIe/h3ytNDgDKrNfMJi9YcEvscMgguwwTlaEUSED0=;
        b=X+jiz/w3IIevZN8y2SAo6nR/zNUjPQkJ2s0TOZLS7UNOjtwZsJN6G6WsLCo4WDwkp6
         aT6cqOA4H/H7v9qzlHzLGKrqvjSBEajWJykGw3WVm0W2M6CZ7JHgBwjaKU/gaXmI4oZA
         skc+2pz4cAnu3BSrTTWd6V9megZMpkxEg9AN6h42j9Ge691C9s1E9eVAFvNR5CeLCQ4O
         OilOLx7VY+tZxHCcLTnXS5L+Bzz+HkezxNDxLCX/t7sHGi0xGZNSJhxVRlqBJ0OuqXFD
         UVknN73Q6KqqKgAu2DNW/qqFpSRAIXxQpd7OjJylEdo58hV/QHDDmr0T3KwCCXv9f2tx
         5Tlg==
X-Gm-Message-State: AFuF++kKWxNVp3NphytsjHWGqQZ1eCj0LyHPS/i+OapEwRlzYqetObLU
	ZQsjalFDqult1bp8KDATveDSpZ/Loo/8pZSUQVF4RVuxRAIq5wlPzFuAk96x7qyWAsZ5h0izcag
	kca7uBb4GtLmUJeMih+sfxU/B/kXA8XzcQT8wTt/yeWtm6J5A3yyqjc/Vzg==
X-Gm-Gg: AYBFou3UurFJz+KmK+hq3rvKSkEOEllA3zOvwDdsxTY47zwIzLSokG0SHQiX2FTBdCC
	hXJY9Io1yiLiNdjPx3x52udVlFGxzeTi4HjEhcDqHEsGeGo6yMR/EcN0QRgT1IMxEWJOmHHCw03
	eR95yQ3AzkEt5Bxs3oU0X9LNrU/33P0W9utEKSQN5btBBGjYyvfD8m9bWE2AHpiMOB89W+9pXEs
	46K1vZZMDsL7L6v4wbBCliVe7rDv2wClep3I6stnFMPWpue86mavDXTsSD2021t8z3pnSBJXCMP
	RFt3EpWDnXlb4PuZMKuLADe87JGNiCmohWOb9ls9nC70Jj3VpDookB04Bu5VPBTDXlHUCCLN2gg
	YWisG0l05kbx0DoSiUuq99n41P3ghLU5uTuzLMlC9LQLW9VQrnciic19HmNLY/4Y=
X-Received: by 2002:a53:de05:0:b0:668:9d0f:ab70 with SMTP id
 956f58d0204a3-66f874acc04mr2588006d50.18.1788280457446; Tue, 01 Sep 2026
 09:34:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1787327795.git.m.kurz@irregular.at>
In-Reply-To: <cover.1787327795.git.m.kurz@irregular.at>
From: Matthias Kurz <m.kurz@irregular.at>
Date: Tue, 1 Sep 2026 18:34:06 +0200
X-Gm-Features: AcwNN1WiPhMmu9iwZ3HPS-XfT4FbDhE03InxpgvtOkfDvPFFww_0JqMCYUpf3jA
Message-ID: <CAO=2mx7zXHmahddsPMaDAZ=2zOdonYOE2nvJB__S6ORU_by3-A@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 0/4] Add component batteries and Fast Pair
 Message Stream
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

A gentle ping on this v2 series. It addresses the feedback on v1 and
was tested end-to-end with Pixel Buds Pro through UPower and KDE Plasma.

Would you have time to take another look? Please let me know if I should
change or split anything to make the series easier to review.

Regards,
Matthias
