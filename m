Return-Path: <SRS0=ax5w=RO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F4CC43381
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Mar 2019 19:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D00420643
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Mar 2019 19:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YucMnXon"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfCKTFe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:05:34 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34441 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbfCKTFe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Mar 2019 15:05:34 -0400
Received: by mail-pg1-f195.google.com with SMTP id v12so1759456pgq.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Mar 2019 12:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tdTosIs+1uAy6/6Lcr3HixClUIqOs4tmhdwSXUDuzDU=;
        b=YucMnXonRZ0j6FKezKbz0TICsBotSm0FR7XY65SIgSZYBKBgpB9ZbawUonfHuJzGsT
         R00xKp1cLSAEm03j/80BD1P6awTwlJeGHL15qkR9Yx6HyUJMzXA/xZJx6lP9jXVGw7oI
         eicU4WXwQZFawr/ttbEKPnYHCKMYvfLydJ3OU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tdTosIs+1uAy6/6Lcr3HixClUIqOs4tmhdwSXUDuzDU=;
        b=OACMgVDPvRkv/tnnAqLFcjCKpallWE2zqZs2+YLP1bVA+eek8i3scItM3xCl2joW/s
         j0yKxxQ9LtXUQkXqTYlvo4hob8oq7VVEp1f+tzz/h4C3iB3O18WntZnKoOmSQx6LA7lI
         AQhIpVxIcXarZ4yYR/cb7puMBhCi5YQmUjH6d6dZ5EdVHmcdiO4g0QrhR45M7oL+yHec
         6RRHWm9+0Yxql4UHmohpBVB5Yi6R3kEZg8Kt2zRmxD/6K8mfE/FsBCUnM2PHDgyvexPh
         /mziUiKBRwXoKh6FZb+8DCkpWOmeFRppoYTLd2IKwxrtyVWI+jPBh/T/kwoL91t/r/vc
         wFsg==
X-Gm-Message-State: APjAAAWxOuk6z5rIivF3UQ/NL14sxL5z7uo2XwE4fmSf0/zbsPAlBTV5
        +DCiNiOH6u1MwqvTqBb5qB37Cw==
X-Google-Smtp-Source: APXvYqxGhg4y/dJxxli0g93Ve4jMoa9a+S3hIhYXxyFDg7qf7KqfqmyRaefrFJjaUu0j/QyELfEBAA==
X-Received: by 2002:a17:902:31a4:: with SMTP id x33mr34816755plb.198.1552331133911;
        Mon, 11 Mar 2019 12:05:33 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id o2sm12961591pgq.29.2019.03.11.12.05.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 12:05:33 -0700 (PDT)
Date:   Mon, 11 Mar 2019 12:05:32 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Hemantg <hemantg@codeaurora.org>
Subject: Re: [PATCH v2] Bluetooth: hci_qca: Add helper function to get the
 chip family
Message-ID: <20190311190532.GA200579@google.com>
References: <20190311183831.174391-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190311183831.174391-1-mka@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Mar 11, 2019 at 11:38:31AM -0700, Matthias Kaehlcke wrote:
> Many functions obtain a 'struct qca_serdev' only to read the btsoc_type
> field. Add a helper function that encapsulates this.
> 
> This also fixes crashes observed on platforms with ROME controllers
> that are instantiated through ldisc and not as serdev clients. The
> crashes are caused by NULL pointer dereferentiations, which stem from
> the driver's assumption that a QCA HCI device is always associated with
> a serdev device.
> 
> Fixes: fa9ad876b8e0 ("Bluetooth: hci_qca: Add support for Qualcomm
> Bluetooth chip wcn3990")

TBH I'm not sure how useful the 'Fixes' tag is in this case. There are
a bunch of other fixes without the tag, intermingled with a few
improvements and new features.
