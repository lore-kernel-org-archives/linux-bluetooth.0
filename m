Return-Path: <SRS0=edj+=2D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CE4C79DD6
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82FDC2474A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="cUYdO6uu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbfLMRO7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Dec 2019 12:14:59 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:40656 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728437AbfLMRO7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Dec 2019 12:14:59 -0500
Received: by mail-pj1-f65.google.com with SMTP id s35so1460435pjb.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Dec 2019 09:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=xGfkgHFOiwzu4bSfkgFVF67O8wpT6Z/ekwvnkfqDuzY=;
        b=cUYdO6uuG/TiXeqwUvZcAm2hBzDMImTYy4ODdcn/fMcmh9JgLu1CLGGVX+KIvvSvO0
         o8aWIqxEx/ptb+/MPjY/Yq579KsJr1o9RPqaiCllSSleXUTWrLmcI5RrEd+/Vrfu6Flu
         CWYAgQa0ZlDt6LHKcaWNRNJjJC1lmY2DyL0S80riSCKaUdLoml+I2lmjv4MSWugYx9o5
         s6JunedYMjjRe7k0maLrsIspTN1iGgwZbO2xjk7eeLOQ9oZ/D3yt0WyYvo0YErpvSsqV
         QnY53A7SjfDhKpy53r4//AfCp08E65blD6Nm/gIFCLH23SXnz4k/U4az1r298eO7WUUq
         FlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=xGfkgHFOiwzu4bSfkgFVF67O8wpT6Z/ekwvnkfqDuzY=;
        b=OzdF8oSVV9zphBKcAqEsz+mH4V2ROP4KSN5RfybCS2EeC1TmCvdICbw5SAtIAESPiY
         V7/ztfJKAUd+oz2/JvA/k6Et1eqgMyLRvyu5QvuxMm+Tbqk/L2h5zL+L5/lsnY4HChb2
         jkN9UsYN2Con30hntijLfdbhBDOBDIST2wwgd74P+HhzMQkMjB9rqt9oEcQtMFKCt2DC
         Lwu5csD1v7l7yHYBQgFZpDxIs10oN7MtaUUFKWzrv37TUat3H8O0K6buPsl/gYB8oOyA
         8rTGf6vyGWM1gYgpX+NGdpUAD0zwf50f/KwQwX7YYypmDK7exJxxo6JjsBT++bzkK76C
         XbDw==
X-Gm-Message-State: APjAAAWv7EI2oQ4ip+fibu9vTgXSxPJ2k5TpEg3OpGuOr21d+SRc62+P
        5S+tfT6ybUMK8jY6l8DkWrMddg==
X-Google-Smtp-Source: APXvYqxNp9JqbsXiF34gHi5lFrYjYb8YF87UwVb6GpItvh6TUJ6QG94Jp9JFz8MrAz7ABEyxzH6tHA==
X-Received: by 2002:a17:902:758c:: with SMTP id j12mr431734pll.14.1576257298141;
        Fri, 13 Dec 2019 09:14:58 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id n188sm11426933pga.84.2019.12.13.09.14.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Dec 2019 09:14:57 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Guillaume La Roque <glaroque@baylibre.com>, marcel@holtmann.org,
        johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     netdev@vger.kernel.org, nsaenzjulienne@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] bluetooth: hci_bcm: enable IRQ capability from devicetree
In-Reply-To: <20191213150622.14162-3-glaroque@baylibre.com>
References: <20191213150622.14162-1-glaroque@baylibre.com> <20191213150622.14162-3-glaroque@baylibre.com>
Date:   Fri, 13 Dec 2019 09:14:57 -0800
Message-ID: <7ho8wc87vy.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Guillaume La Roque <glaroque@baylibre.com> writes:

> Actually IRQ can be found from GPIO but all platforms don't support
> gpiod_to_irq, it's the case on amlogic chip.
> so to have possibility to use interrupt mode we need to add interrupts
> property in devicetree and support it in driver.

I would reword this slightly (leaving out the amlogic specifics):

"""
Add support for getting IRQ directly from DT instead of relying on
converting a GPIO to IRQ. This is needed for platforms with GPIO
controllers that that do not support gpiod_to_irq().
"""

Other than that, this looks good to me and now it's clear that it only
affects the DT path.

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

Kevin
