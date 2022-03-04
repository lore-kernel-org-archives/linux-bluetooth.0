Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C385AC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Mar 2022 15:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239813AbiCDPbL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Mar 2022 10:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiCDPbK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Mar 2022 10:31:10 -0500
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2ED131C4B3A;
        Fri,  4 Mar 2022 07:30:22 -0800 (PST)
Received: from smtpclient.apple (p5b3d2910.dip0.t-ipconnect.de [91.61.41.16])
        by mail.holtmann.org (Postfix) with ESMTPSA id 4DDB3CECC9;
        Fri,  4 Mar 2022 16:30:21 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH] Bluetooth: hci_event: Add missing locking on hdev in
 hci_le_ext_adv_term_evt
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <436acf8a-ea5f-a308-0e3e-fc7c6ffde7aa@ugent.be>
Date:   Fri, 4 Mar 2022 16:30:20 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <4E8D6D80-C300-4E79-B2EC-B733D5AFCACD@holtmann.org>
References: <436acf8a-ea5f-a308-0e3e-fc7c6ffde7aa@ugent.be>
To:     Niels Dossche <niels.dossche@ugent.be>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Niels,

> Both hci_find_adv_instance and hci_remove_adv_instance have a comment
> above their function definition saying that these two functions require
> the caller to hold the hdev->lock lock. However, hci_le_ext_adv_term_evt
> does not acquire that lock and neither does its caller hci_le_meta_evt
> (hci_le_meta_evt calls hci_le_ext_adv_term_evt via an indirect function
> call because of the lookup in hci_le_ev_table).
> 
> The other event handlers all acquire and release the hdev->lock and they
> follow the rule that hci_find_adv_instance and hci_remove_adv_instance
> must be called while holding the hdev->lock lock.
> 
> The solution is to make sure hci_le_ext_adv_term_evt also acquires and
> releases the hdev->lock lock. The check on ev->status which logs a
> warning and does an early return is not covered by the lock because
> other functions also access ev->status without holding the lock.
> 
> Signed-off-by: Niels Dossche <niels.dossche@ugent.be>
> ---
> net/bluetooth/hci_event.c | 19 ++++++++++++-------
> 1 file changed, 12 insertions(+), 7 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

