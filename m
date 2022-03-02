Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A00C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Mar 2022 14:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235102AbiCBOWB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Mar 2022 09:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiCBOWB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Mar 2022 09:22:01 -0500
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 825F44EA25
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Mar 2022 06:21:16 -0800 (PST)
Received: from smtpclient.apple (p5b3d2910.dip0.t-ipconnect.de [91.61.41.16])
        by mail.holtmann.org (Postfix) with ESMTPSA id 95B70CED0C;
        Wed,  2 Mar 2022 15:21:15 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH] Bluetooth: hci_core: Fix unbalanced unlock in
 set_device_flags()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220302134439.515377-1-hdegoede@redhat.com>
Date:   Wed, 2 Mar 2022 15:21:15 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Transfer-Encoding: 7bit
Message-Id: <ECE52602-4BDE-47DB-878E-CE607A6B6723@holtmann.org>
References: <20220302134439.515377-1-hdegoede@redhat.com>
To:     Hans de Goede <hdegoede@redhat.com>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Hans,

> There is only one "goto done;" in set_device_flags() and this happens
> *before* hci_dev_lock() is called, move the done label to after the
> hci_dev_unlock() to fix the following unlock balance:
> 
> [   31.493567] =====================================
> [   31.493571] WARNING: bad unlock balance detected!
> [   31.493576] 5.17.0-rc2+ #13 Tainted: G         C  E
> [   31.493581] -------------------------------------
> [   31.493584] bluetoothd/685 is trying to release lock (&hdev->lock) at:
> [   31.493594] [<ffffffffc07603f5>] set_device_flags+0x65/0x1f0 [bluetooth]
> [   31.493684] but there are no more locks to release!
> 
> Note this bug has been around for a couple of years, but before
> commit fe92ee6425a2 ("Bluetooth: hci_core: Rework hci_conn_params flags")
> supported_flags was hardcoded to "((1U << HCI_CONN_FLAG_MAX) - 1)" so
> the check for unsupported flags which does the "goto done;" never
> triggered.
> 
> Fixes: fe92ee6425a2 ("Bluetooth: hci_core: Rework hci_conn_params flags")
> Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> net/bluetooth/mgmt.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-stable tree.

Regards

Marcel

