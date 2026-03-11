Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE052FFDE1
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2026 13:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773234971; cv=none; b=gH0HXP8f4ZKqshOl6FxfR7hPkx6PyN997xG04ozfsrBBgwK7tHQjtuSNg8rzICr+M6/jcXuNC/8ao42We9/ylRokoVwG9CUX6Faxlnh4KX57M63uDc6j8mzUuxe0u8nkA5iAv5G0V19o1Gs+0RZ1js9nmvz5bEXt2ISw2RMvyQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773234971; c=relaxed/simple;
	bh=bQRlE5OR+3/41N9B/xBGXfMeOTv3hgeQ2WrY6jcTpBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fjrC5WgzOX4Q1FQASlGYMYhwefWiV/1AzMpyO2xd8Z+QU9unll77tV2lXIt4l3hYmoJbeuAvwJ9kO4jU/mKPpfBYT1Q+dDgC2DyYyHD5H3zycdNgiurXd8yPauD/Cf4ab2HYjURDC6VXBM6OJH9AnbQIgSUvd5Gk7AcR2tnzdoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5675d609621so11786919e0c.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2026 06:16:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773234969; x=1773839769;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34DR94e/1PAvLLEaib58vFA4GW0m5SGe6jvxchEhMek=;
        b=lizrvJ/ZEArD4fsA+AtVOwsyJoq91z0gvoBCJZVo4dBZpmTgFaSPzAev2XUZsrlEoM
         Em28SPUEcDaEqG8VZ/LOMYGDfspMmI0JUvBZMhOfVqk22xRNGvizPrwxcxWXn8bHrpMS
         oZcVPHKDf5XpC4BJaq6tZnIsroXrkbGWqGCSmjsHtdi8lhhh9+FwVt5+bAgs2Blu7/P1
         wN4WI/qSo/L+Y4IqS18AmTRZ9U1pNTX/r/tUT0y9P2K+D2fFnaApW9HB4zoQHiDHUGOI
         +7gNhCybDjpwxVLYiAAQ+ViuK3oDr1/uTcbuqgD0u5So/4ZKiOWeQ4gHuKVMESoGuMCb
         +hnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHLq8U0cjjr5cZnDP6L7MR/lvyxQIvir9Rk0cx4FJuxnYo20B3VHB2EG6fnIyh6gosalbVJ2ZxOCCncE6f9W4=@vger.kernel.org
X-Gm-Message-State: AOJu0YygxQO16uUQsPMpz+ghBg+29De/vT3ctXcMZYx+MhuDbH84ScYh
	bMeM4qLjv8R4+nTjGgjnpcpBkyYo5USOvqf2zgmy60fHZ2Hfz4AM/JkmYS2ZwsbWUvc=
X-Gm-Gg: ATEYQzwIj6Nx5cL95PHX7jSfH4vIB8hcAXG81intICUYPsXdukN4WsYtovRlvemhFYA
	oLhW/t1OuLfmIoT2GzMVvNeg4zbH+sbeborn+oGX46MRkyS6RRS9GQxicPWxYwPj+X1CfmzqGHI
	kXj1+W5EZnGTULkUaIK6FePQM6KrWAG3xcSjQ6BKnK3cfpR8137yZFVRFtqA49z8IftjBRXP5Mg
	TYe6Kt+vaIOvQd5dzK1Pb9QBnJ9Qx9AlShvP0xawuGARMlvlPLYw/7xPRWzhj1eIQ1qMX+YtRUQ
	Jcyo8Sv40wZ4iReApUzcaqtoaD/JP/coYp3b0lBY5NVRJm3KK+RGJLlgi2ZUHsUIjz0Rzufr13o
	54uihcklq/sMG5XofQ64xWqsj72SDELiQtQXdFaYqFJNzGo4bgHwr9l1H+TvIQrsJL+yYcfr1it
	+2R8i60E06O/FiR+JQ3PFPjd0773e4pLqZLU+23fkWc1MUf4xc4RDZmB9Bpznf8XGF
X-Received: by 2002:a05:6122:319e:b0:56a:ef89:34e2 with SMTP id 71dfb90a1353d-56b4767668fmr916027e0c.17.1773234968717;
        Wed, 11 Mar 2026 06:16:08 -0700 (PDT)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56b4634177esm957644e0c.6.2026.03.11.06.16.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 06:16:07 -0700 (PDT)
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-56b18f05f49so2419021e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2026 06:16:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX21NsgR+4J9xbjNe5b+kIIV7oSm1P2RBmfodijRK16FK9CBj8tDuc7KSwvFNNw5NqruMBUfc3KrvoPYUYzkSw=@vger.kernel.org
X-Received: by 2002:a05:6122:1d05:b0:55b:7494:177b with SMTP id
 71dfb90a1353d-56b4752d806mr922396e0c.10.1773234967338; Wed, 11 Mar 2026
 06:16:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de> <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 14:15:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
X-Gm-Features: AaiRm52J84H77ROK64ZWWtJfaiCpnFeKyoSRmPbi-NC8CN6Ju1TJEFxJU9gZQQ8
Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
Subject: Re: [PATCH 36/61] arch/sh: Prefer IS_ERR_OR_NULL over manual NULL check
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
	target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	v9fs@lists.linux.dev, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Mar 2026 at 12:56, Philipp Hahn <phahn-oss@avm.de> wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>
> Change generated with coccinelle.
>
> To: Yoshinori Sato <ysato@users.sourceforge.jp>
> To: Rich Felker <dalias@libc.org>
> To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: linux-sh@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
