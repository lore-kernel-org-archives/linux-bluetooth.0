Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09971DED40
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Nov 2025 16:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763655234; cv=none; b=eww8m2Su7c7I0/WgF3uWb8ZIIq0c2zr24SzcDyqBq73kESYe2N5Hd0HlJ5sA2pL/SWBytpuXCkf6kGey0NLb5rx7nTun9h7LcSyp1jfxaYRFmaRlTVqh8vJH/GzSv4tUfG2Cv0Pl/CuuTJDTrF2QfXT8fRI/DzHLI/OPlwFvm6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763655234; c=relaxed/simple;
	bh=tnTki4cjftc4VCRi/IXO6gk37TMf+BPqLaDLZEPjEX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sBlbeohrJXppxGc0Vg3iIwmTDcMfOT0p3Vg8u84r1H85rd8KzvDZ5j8hoEVJY26Evg23H//tVGAveP38TYkuJex+gnbN5w8hdyOqpoEGmqIg8j4gkaHC+cYM5D3bbON2Gcjjbg5nf3its2mb8EbkguZ0uZkZheRebrN4PsbZvt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nzmsH/MH; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nzmsH/MH"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-640a3317b89so1756697a12.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Nov 2025 08:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763655230; x=1764260030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fY5BvWFohYUsQWWAbdgvSo56iCSLE2VcTftjflKg6QE=;
        b=nzmsH/MHTfK/qGDd6sB2xMIKsRKLAC/BS8DFb10/r8dzHhw7oCBhpXw1r20cmqh7fn
         tS4aeH/+036yMf7iEBKr437/aA40iv5s3lkAAMmJeuaSpxLkoPODaozzB7w91deoqQ+D
         Z5G3KUhsZ1IylxgSx3oPXF8OVVQGv8wYeG9xM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763655230; x=1764260030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fY5BvWFohYUsQWWAbdgvSo56iCSLE2VcTftjflKg6QE=;
        b=IVuLhb1jNV+pu5eRX/XJPXM0xt60csDPXCGbHqRuUwI7bp3ZXv7rztecSxG0ehkGGu
         YZ3eETXNJnhxKZs51jvhNYrDZ4l9yt21QG+PWLD/B8aluzoCShuI2tQhRFbNocXIuSkH
         Are7P4BsTRSGg9EK45SO00/dwUH+VX5UTz+2jEBf3qoZ3LwF6TWIJh/o+c7FoxFtTIXi
         VCa9D0q1OpCIZx2XieUnCNJssUnVlHUzM4i44KgwOwyfyae+4Zz9CL3vVkejRrdo38h0
         dHS6pFkGWFXSEZXc4r5j5yJuwQ/Ob1yjCSjr6nRyR/LRCy37WdwxLtad8+96SkDMfCeN
         LVfg==
X-Forwarded-Encrypted: i=1; AJvYcCV2K70ROM5zm6H3mgWSy/8dRGwe5GNxDf8YYFhHwrZYx5dlok7Fi6WKjHFhOEuQPNyqZXOZRzxRohYHZ14pWVg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx45t8/h8FRevs3f29gwM6oSlt9NRzomtWh78cFdWwZnE7Ysz0k
	uKIZYJaRKkvcgWoXH6Yf7KN9v9kDNEP6W16xdA6pNPaHRh6vI5kfyc8vYkl6AGpvZo70KdW1++d
	c0PZwHp2Q
X-Gm-Gg: ASbGnctqEmDjfFbyLfNJ8xIrpbAxVO3IBzpVn+Q5wbTZ/akAZDc0zG0fP62OUtqtNML
	EJRCNNjQaflgKwCx6e52quX9AtfhFxDvHWHoZE2KoRklnrg+O1cY7HUc1yXhGJhdLOo1o1QzPT4
	PsGkd57RSiIyx2xZwouQEMdgNBMwqvLikLgfIPLYB+leTPS1dAM86UVofjkW2vASvrw4Rdmr5DV
	3rjbXBEKgZeMox/MLitMOwxVSmxKHWxRK6IOs0jpFsOPFcNOIE5X6OyDbpI/R5TA7j1WkINb+p2
	Tzl4pwuDEUitexhd2mFCoExtnKYbL4dP7ha81svTI+A9fUrCrBFJLFdI1ZcX4H44/qN3HiYenBt
	c1vr4554sB2X0lQ5KPIcuGXtTiYI6CNXHOgf+H/+yudfHPbGrJ5GTHW0/jaJfCw+WQZ19aWPNVv
	TMxE+GMbUbEzRUto6ZXuPa5aqgdAILgd4VDIvwDP4hKySlyn2+7A==
X-Google-Smtp-Source: AGHT+IHklnTuypblP5mieACleQUn2jwrJkbprPcoGrXoDBY2JHRa0WnSjtmnwSsAoC9icXEROGhoGA==
X-Received: by 2002:a17:907:d92:b0:b72:8e31:4354 with SMTP id a640c23a62f3a-b7654d610f6mr386569266b.25.1763655229624;
        Thu, 20 Nov 2025 08:13:49 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654cdd62bsm244476166b.5.2025.11.20.08.13.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 08:13:49 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so9526015e9.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Nov 2025 08:13:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVbZfzhr2uHXBJcGJZGqK1VciwB0yAg1NmCXWDCqrAdmff/sZ350abFNz6Ci9rEXSB18bCV9j6BCJtvya/H15I=@vger.kernel.org
X-Received: by 2002:a17:906:dc8c:b0:b76:23b0:7d70 with SMTP id
 a640c23a62f3a-b7654ea998amr379971766b.39.1763654751460; Thu, 20 Nov 2025
 08:05:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119085354.1.I1ae7aebc967e52c7c4be7aa65fbd81736649568a@changeid>
 <2025112007-quit-enable-3fa1@gregkh>
In-Reply-To: <2025112007-quit-enable-3fa1@gregkh>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 20 Nov 2025 08:05:38 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V7jja=CsA4QyrGNHPKbSb3wfbLbhET+j01cUeuZGSdsQ@mail.gmail.com>
X-Gm-Features: AWmQ_bmHJc4rIzwwFhnOnl9hbzodCqBW9sxgLfvryl54nq-vWqoNlY_oT15PM_w
Message-ID: <CAD=FV=V7jja=CsA4QyrGNHPKbSb3wfbLbhET+j01cUeuZGSdsQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: mediatek: Avoid btusb_mtk_claim_iso_intf()
 NULL deref
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Thorsten Leemhuis <regressions@leemhuis.info>, incogcyberpunk@proton.me, 
	johan.hedberg@gmail.com, regressions@lists.linux.dev, sean.wang@mediatek.com, 
	linux-arm-kernel@lists.infradead.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 19, 2025 at 11:12=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> - You have marked a patch with a "Fixes:" tag for a commit that is in an
>   older released kernel, yet you do not have a cc: stable line in the
>   signed-off-by area at all, which means that the patch will not be
>   applied to any older kernel releases.  To properly fix this, please
>   follow the documented rules in the
>   Documentation/process/stable-kernel-rules.rst file for how to resolve
>   this.

Sure. I'll send a v3 with the Cc to stable added and collect
IncogCyberpunk's Tested-by tag that was given in response to v1.

-Doug
