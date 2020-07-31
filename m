Return-Path: <SRS0=UTuE=BK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81ECAC433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Jul 2020 06:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6962A208E4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Jul 2020 06:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731396AbgGaG3n convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 31 Jul 2020 02:29:43 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:51784 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731351AbgGaG3n (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 31 Jul 2020 02:29:43 -0400
Received: from marcel-macpro.fritz.box (p4ff9f430.dip0.t-ipconnect.de [79.249.244.48])
        by mail.holtmann.org (Postfix) with ESMTPSA id 33F24CED04;
        Fri, 31 Jul 2020 08:39:44 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2] Bluetooth: use the proper scan params when conn is
 pending
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200731010535.1422455-1-alainm@chromium.org>
Date:   Fri, 31 Jul 2020 08:29:41 +0200
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Yu Liu <yudiliu@google.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <C43B1571-6221-4D1A-A4F7-E211FE69F499@holtmann.org>
References: <20200731010535.1422455-1-alainm@chromium.org>
To:     Alain Michaud <alainm@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

> When an LE connection is requested and an RPA update is needed via
> hci_connect_le_scan, the default scanning parameters are used rather
> than the connect parameters.  This leads to significant delays in the
> connection establishment process when using lower duty cycle scanning
> parameters.
> 
> The patch simply looks at the pended connection list when trying to
> determine which scanning parameters should be used.
> 
> Before:
> < HCI Command: LE Set Extended Scan Parameters (0x08|0x0041) plen 8
>                             #378 [hci0] 1659.247156
>         Own address type: Public (0x00)
>         Filter policy: Ignore not in white list (0x01)
>         PHYs: 0x01
>         Entry 0: LE 1M
>           Type: Passive (0x00)
>           Interval: 367.500 msec (0x024c)
>           Window: 37.500 msec (0x003c)
> 
> After:
> < HCI Command: LE Set Extended Scan Parameters (0x08|0x0041) plen 8
>                                #39 [hci0] 7.422109
>         Own address type: Public (0x00)
>         Filter policy: Ignore not in white list (0x01)
>         PHYs: 0x01
>         Entry 0: LE 1M
>           Type: Passive (0x00)
>           Interval: 60.000 msec (0x0060)
>           Window: 60.000 msec (0x0060)
> 
> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Reviewed-by: Yu Liu <yudiliu@google.com>
> Signed-off-by: Alain Michaud <alainm@chromium.org>

please swap these around, the signed-off-by from the author should come first.

> 
> ---
> 
> Changes in v2:
> - Fixing Yu's email tag
> 
> net/bluetooth/hci_request.c | 24 ++++++++++++++++++++++++
> 1 file changed, 24 insertions(+)

Patch has been applied to bluetooth-next tree.

Regards

Marcel

