Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB60C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 13:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CE766141B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 13:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344296AbhI2N4q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Sep 2021 09:56:46 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:56429 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244987AbhI2N4q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Sep 2021 09:56:46 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id F37D6CECF9;
        Wed, 29 Sep 2021 15:55:03 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v2 1/3] Bluetooth: Make use of hci_{suspend,resume}_dev on
 suspend notifier
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210928213653.3028439-1-luiz.dentz@gmail.com>
Date:   Wed, 29 Sep 2021 15:55:03 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <D5203438-DB71-4909-97EB-A52363C43AD2@holtmann.org>
References: <20210928213653.3028439-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This moves code from hci_suspend_notifier to hci_{suspend,resume}_dev
> since some driver may handle pm directly using
> HCI_QUIRK_NO_SUSPEND_NOTIFIER they would instead call
> hci_{suspend,resume}_dev directly and we want that to have the same
> behavior regardless of where pm is being handled.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> v2: Clarify why some code is being move into hci_{suspend,resume}_dev and
> move debugfs entries to hci_vhci driver so it emulates more closely the
> behavior of the driver implementing pm handling and calling the likes of
> hci_suspend_dev.
> 
> net/bluetooth/hci_core.c | 116 ++++++++++++++++++++++-----------------
> 1 file changed, 67 insertions(+), 49 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

