Return-Path: <SRS0=z3SO=5V=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B14C2D0F4
	for <linux-bluetooth@archiver.kernel.org>; Sun,  5 Apr 2020 11:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2332B206C3
	for <linux-bluetooth@archiver.kernel.org>; Sun,  5 Apr 2020 11:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZaEvUniI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgDELye (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 5 Apr 2020 07:54:34 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:36891 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgDELye (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 5 Apr 2020 07:54:34 -0400
Received: by mail-pj1-f65.google.com with SMTP id k3so5206252pjj.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 05 Apr 2020 04:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rfjo1CPOUgbQ/K1PnBu3dIEOLNoWWFCaw4rR1EWL5Tw=;
        b=ZaEvUniIMea+EjFzhxotwoubAAGgSsEtyjqQdUMMB2++gq88KWvTYV3a533T41tJtT
         FvNPsdoGlI+pRcMT+dLrd2JDtwMDWI4RpLHpkTnuhw3rXrf+Js/92TU0uQAGn5hXFGMz
         j8S3USxlepSW6UQg6wGywjL6f5XDhyD6yDcEKswb1EHFfFvzY5VzoDDdlEbiHgcuf+vx
         d8zz3asuiFCChqnsQKBwLgC64T+AT6SaXopz5B/x1FKpuwX4aMRrO8ulSCj0oj+gf1e+
         pnCmqcfFOS6h7qtqR1kdPGpJFdnIAmTL2nuXZg4M5LeGeS5z+IBokBssL+YN0FwA1OFq
         W0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Rfjo1CPOUgbQ/K1PnBu3dIEOLNoWWFCaw4rR1EWL5Tw=;
        b=FaOolrZAFfr7lJ8Cvu4ON3WvltlYuvOnYy12yRPs04xZWFl5eqWwy14kPD2B0SYS0X
         8LCu16f/QJBKnDY9hSqytK0s77niQEPcGddblMskB3jogon8RxSZtGY1kWbarMiwJx8Q
         RMlwsd0y9KoPOHQUkEQsUXju98wnQiJSNZHM+ZgL7J27RDmRcr3FU4JJq+ooUJ3omkAr
         XOUoU6gWxHDpxWAd3DmbZbFjo3ZcyXWBKaqwgJHgvnvIdIx8VszCbTC3ut6+bG6ObDbm
         aNo2c++x9LEpXyfvi0/1dw+SYkM2/GyuQczzWBRA2o+PP0Qs0DspN2eJMjtchIVGHHkA
         /9mw==
X-Gm-Message-State: AGi0PuYQt6S5Tuxl1byL9/Cd0jyesVJ4gT2IcmTnBOEe5mUXW1aOZi8Z
        6AWXsxj3GvbiOwWmK1Cz6ergTT7TanU3Mw==
X-Google-Smtp-Source: APiQypJPuFP6/ZSKaZoXebWnopmYLWMNeFO3syALZAbnWx64b1PQevRFSWhDu3jQ15n9dfvtSqAqCA==
X-Received: by 2002:a17:90a:21ce:: with SMTP id q72mr20000502pjc.160.1586087671332;
        Sun, 05 Apr 2020 04:54:31 -0700 (PDT)
Received: from localhost ([192.55.55.45])
        by smtp.gmail.com with ESMTPSA id mn18sm9780424pjb.13.2020.04.05.04.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 04:54:30 -0700 (PDT)
Date:   Sun, 5 Apr 2020 14:54:26 +0300
From:   Johan Hedberg <johan.hedberg@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 00/10] List of pending patches
Message-ID: <20200405115426.GA20858@yganon-mobl1.ger.corp.intel.com>
Mail-Followup-To: Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org
References: <20200403194407.784943-1-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403194407.784943-1-marcel@holtmann.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Fri, Apr 03, 2020, Marcel Holtmann wrote:
> This is the list of pending patches that are ready for bluetooth-next.
> 
> Marcel Holtmann (6):
>   Bluetooth: Move debugfs configuration above the selftests
>   Bluetooth: btusb: Enable Intel events even if already in operational
>     mode
>   Bluetooth: Add support for Read Local Simple Pairing Options
>   Bluetooth: Add support for reading security information
>   Bluetooth: Increment management interface revision
>   Bluetooth: Add HCI device identifier for VIRTIO devices
> 
> Miao-chen Chou (2):
>   Bluetooth: Add framework for Microsoft vendor extension
>   Bluetooth: btusb: Enable MSFT extension for Intel ThunderPeak devices
> 
> Sathish Narasimman (1):
>   Bluetooth: btusb: handle mSBC audio over USB Endpoints
> 
> Sathish Narsimman (1):
>   Bluetooth: add support to notify using SCO air mode
> 
>  drivers/bluetooth/btusb.c        | 182 +++++++++++++++++++++++--------
>  include/net/bluetooth/hci.h      |  11 ++
>  include/net/bluetooth/hci_core.h |  15 +++
>  include/net/bluetooth/mgmt.h     |   7 ++
>  net/bluetooth/Kconfig            |  23 ++--
>  net/bluetooth/Makefile           |   1 +
>  net/bluetooth/hci_conn.c         |  25 ++++-
>  net/bluetooth/hci_core.c         |   9 ++
>  net/bluetooth/hci_event.c        |  49 ++++++++-
>  net/bluetooth/mgmt.c             |  55 +++++++++-
>  net/bluetooth/msft.c             | 141 ++++++++++++++++++++++++
>  net/bluetooth/msft.h             |  18 +++
>  12 files changed, 477 insertions(+), 59 deletions(-)
>  create mode 100644 net/bluetooth/msft.c
>  create mode 100644 net/bluetooth/msft.h

All patches in this set have been applied to bluetooth-next. Thanks.

Johan
