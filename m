Return-Path: <SRS0=7mPt=CW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA2FC43461
	for <linux-bluetooth@archiver.kernel.org>; Sun, 13 Sep 2020 07:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFB47206BE
	for <linux-bluetooth@archiver.kernel.org>; Sun, 13 Sep 2020 07:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725918AbgIMH5Y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 13 Sep 2020 03:57:24 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:50350 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgIMH5V (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 13 Sep 2020 03:57:21 -0400
Received: from marcel-macbook.fritz.box (p4ff9f430.dip0.t-ipconnect.de [79.249.244.48])
        by mail.holtmann.org (Postfix) with ESMTPSA id 74188CECC4;
        Sun, 13 Sep 2020 10:04:15 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH v2 0/3] Bluetooth: Emit events for suspend/resume
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200911210713.4066465-1-abhishekpandit@chromium.org>
Date:   Sun, 13 Sep 2020 09:57:19 +0200
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <BF8FE78A-77AF-4788-A819-B275D851309A@holtmann.org>
References: <20200911210713.4066465-1-abhishekpandit@chromium.org>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhishek,

> This series adds the suspend/resume events suggested in
> https://patchwork.kernel.org/patch/11771001/.
> 
> I have tested it with some userspace changes that monitors the
> controller resumed event to trigger audio device reconnection and
> verified that the events are correctly emitted.
> 
> Patch for btmon changes: https://patchwork.kernel.org/patch/11743863/
> 
> Please take a look.
> Abhishek
> 
> Changes in v2:
> - Added suspend/resume events to list of mgmt events
> 
> Abhishek Pandit-Subedi (3):
>  Bluetooth: Add mgmt suspend and resume events
>  Bluetooth: Add suspend reason for device disconnect
>  Bluetooth: Emit controller suspend and resume events
> 
> include/net/bluetooth/hci_core.h |  6 +++
> include/net/bluetooth/mgmt.h     | 16 +++++++
> net/bluetooth/hci_core.c         | 26 +++++++++++-
> net/bluetooth/hci_event.c        | 73 ++++++++++++++++++++++++++++++++
> net/bluetooth/mgmt.c             | 30 +++++++++++++
> 5 files changed, 150 insertions(+), 1 deletion(-)

All 3 patches have been applied to bluetooth-next tree.

Regards

Marcel

