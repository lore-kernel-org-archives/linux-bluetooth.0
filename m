Return-Path: <SRS0=JXiH=C3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66430C43464
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 19:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DEB122211
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 19:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OM6JmKTQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgIRTig (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Sep 2020 15:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgIRTig (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Sep 2020 15:38:36 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247D0C0613CE
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2020 12:38:36 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id y11so7347827lfl.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2020 12:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=aowMQxFjnMPe9KoJRtXpPFXt027PL0v5kj+8if/hy2Y=;
        b=OM6JmKTQK6gBrN1pHwKS/VzaMXomrAjWh0RzuvNEABH4NZJ3nUGNct9jRceXnQ82Uz
         bYa7gaLLkmAIKpZkHIZvo58NeVkbSmjBew8oqAHiIBNczkUOKuQFRmm3dsRRDmdR7R7W
         2QlLmJTH2d0uarENgLJ7bOP5wfhnzGKzfOrrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=aowMQxFjnMPe9KoJRtXpPFXt027PL0v5kj+8if/hy2Y=;
        b=n/FqvXavk1ob/kze3omF0w0KuBdrHq5iUDR5WmQgmORopb5hUBtiBFFCgXjytbL/tJ
         lcReAXVBC/nOxhJWGFyQh35B1IMHTqqMZJflbOABjOEQ4n3uEr3lrJ09c9rOMzVo59kq
         7MDW597ArhLmVEslH+JsOstJT7rsPMjLNU1yV0xfAAT1XWDY9VbE3QjkAKjc9A9ppxEr
         h6d1pXgW9RDplLXxd98+pIC+GcMfFGjhLzzEF5aAtoI3+IxqXipN+c8dOEenPEBwV8oY
         2xdzO9Jf2vxqzblpms+RzjAjck8E5wkzK3jkfMfNJVmOPPZDkFw7C0kJPHia6xdOXpl1
         ryMQ==
X-Gm-Message-State: AOAM531YUNF03rnnC7Uv5AZLLuuwJHE2G96eZdWkP81o+aSh566kWuUf
        NvCKfy5LN9QZT9FlQHBL4l082uGij+VZb6x+TSTHHG2D0CNFQw==
X-Google-Smtp-Source: ABdhPJw0vtBqBTufsct7firNqecZrcgtk/BRdDRG6E67Sdt73OwitK81ckSwBBt8aJprNOPQ4H9Qrgk3EiN7zQI6arM=
X-Received: by 2002:ac2:4559:: with SMTP id j25mr10565607lfm.484.1600457912893;
 Fri, 18 Sep 2020 12:38:32 -0700 (PDT)
MIME-Version: 1.0
From:   Miao-chen Chou <mcchou@chromium.org>
Date:   Fri, 18 Sep 2020 12:38:21 -0700
Message-ID: <CABmPvSHYi7WeWqgqxSe60omSyVXj_EezMhGi1GMXBBWM-TWeBw@mail.gmail.com>
Subject: Modifying Makefile.am to facilitate test-adv-monitor and future unit tests.
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     Alain Michaud <alainm@chromium.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Howard Chung <howardchung@google.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz and Marcel,

Unlike the rest of the existing unit tests in BlueZ, the logic blocks
tested in test-adv-monitor require dependencies of not only
src/adv_monitor.c but also all the dependency tree of
src/adv_monitor.c. The current convention in Makefile.am is to add all
the extra dependencies one by one. However, the maintenance cost is
high and not suitable in the case of test-adv-monitor. Therefore, we'd
like to propose changes in Makefile.am to make the source of
bluetoothd as a static library and link it for bluetoothd target and
the unit test target. It would be great if you can provide feedback on
this idea before the implementation. Thanks in advance!

Regards,
Miao
