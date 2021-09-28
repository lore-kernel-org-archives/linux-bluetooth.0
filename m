Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D2BC433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 08:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DAAD61159
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 08:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239323AbhI1IHt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Sep 2021 04:07:49 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:54461 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239337AbhI1IHt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Sep 2021 04:07:49 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id 358A5CECD6;
        Tue, 28 Sep 2021 10:06:09 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH 1/3] Bluetooth: Make use of hci_{suspend,resume}_dev on
 suspend notifier
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210927200611.2722757-1-luiz.dentz@gmail.com>
Date:   Tue, 28 Sep 2021 10:06:08 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <D98BDF56-031B-4AFF-B5E4-A2D30285F9D8@holtmann.org>
References: <20210927200611.2722757-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This moves code from hci_suspend_notifier to hci_{suspend,resume}_dev
> since some driver may handle pm directly using
> HCI_QUIRK_NO_SUSPEND_NOTIFIER.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> net/bluetooth/hci_core.c | 116 ++++++++++++++++++++++-----------------
> 1 file changed, 67 insertions(+), 49 deletions(-)

hmmm. So btmrvl_sdio.c actually calls hci_suspend_dev. And in fact hci_suspend_dev is only there to be called from the drivers. Something called from the core or via debugfs needs a different function name.

Regards

Marcel

