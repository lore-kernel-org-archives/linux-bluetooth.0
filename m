Return-Path: <SRS0=y5DB=AA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6F6C433E1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Jun 2020 07:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C032207DD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Jun 2020 07:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730849AbgFSH60 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Jun 2020 03:58:26 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:35058 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730651AbgFSH6Z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Jun 2020 03:58:25 -0400
Received: from marcel-macbook.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id 25937CECF0;
        Fri, 19 Jun 2020 10:08:16 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2 0/7] LL Privacy support
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200603171713.9882-1-sathish.narasimman@intel.com>
Date:   Fri, 19 Jun 2020 09:58:23 +0200
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Sathish Narasimman <sathish.narasimman@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <ACE20ACA-6CE3-4348-88E2-D38DF6680C7F@holtmann.org>
References: <20200603171713.9882-1-sathish.narasimman@intel.com>
To:     Sathish Narasimman <nsathish41@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sathish,

> Based on the input the patches modified and verifed accordingly.
> 
> Marcel Holtmann (3):
>  Bluetooth: Translate additional address type correctly
>  Bluetooth: Configure controller address resolution if available
>  Bluetooth: Update resolving list when updating whitelist
> 
> Sathish Narasimman (4):
>  Bluetooth: Translate additional address type during le_conn
>  Bluetooth: Let controller creates RPA during le create conn
>  Bluetooth: Enable/Disable address resolution during le create conn
>  Bluetooth: Enable RPA Timeout
> 
> include/net/bluetooth/hci.h      |   8 ++-
> include/net/bluetooth/hci_core.h |   3 +
> net/bluetooth/hci_conn.c         |   6 +-
> net/bluetooth/hci_core.c         |  17 +++++
> net/bluetooth/hci_event.c        |  20 ++++++
> net/bluetooth/hci_request.c      | 119 ++++++++++++++++++++++++++-----
> net/bluetooth/hci_request.h      |   3 +-
> net/bluetooth/mgmt.c             |   2 +-
> 8 files changed, 157 insertions(+), 21 deletions(-)

can you please rebase this against the latest bluetooth-next tree. With the introduction of the advertising monitor, we now have a few conflicts that you need to resolve.

Also as discussed, we wanted to hide this initially after an experimental feature flag so it would need to be enabled first. And I think once enabled, we need to take the support of “advertising” aka peripheral away from the controller until we can fully ensure it works for scanning and advertising at the same time.

Regards

Marcel

