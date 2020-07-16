Return-Path: <SRS0=Zco+=A3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EA4C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jul 2020 06:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D7AD206F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jul 2020 06:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbgGPGkq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Jul 2020 02:40:46 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:37516 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbgGPGkq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Jul 2020 02:40:46 -0400
Received: from marcel-macpro.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id B8F35CECFC;
        Thu, 16 Jul 2020 08:50:43 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2] Bluetooth: Fix update of connection state in
 `hci_encrypt_cfm`
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <50fd2c75ce196196f879f8373555cc30bfc75154.1594834970.git.ps@pks.im>
Date:   Thu, 16 Jul 2020 08:40:44 +0200
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <B06670C9-21F4-484E-91FD-11713B8DCBFF@holtmann.org>
References: <0df5bf3eac160de28b9493a8959510980a8a8e8b.1594803508.git.ps@pks.im>
 <50fd2c75ce196196f879f8373555cc30bfc75154.1594834970.git.ps@pks.im>
To:     Patrick Steinhardt <ps@pks.im>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Patrick,

> Starting with the upgrade to v5.8-rc3, I've noticed I wasn't able to
> connect to my Bluetooth headset properly anymore. While connecting to
> the device would eventually succeed, bluetoothd seemed to be confused
> about the current connection state where the state was flapping hence
> and forth. Bisecting this issue led to commit 3ca44c16b0dc (Bluetooth:
> Consolidate encryption handling in hci_encrypt_cfm, 2020-05-19), which
> refactored `hci_encrypt_cfm` to also handle updating the connection
> state.
> 
> The commit in question changed the code to call `hci_connect_cfm` inside
> `hci_encrypt_cfm` and to change the connection state. But with the
> conversion, we now only update the connection state if a status was set
> already. In fact, the reverse should be true: the status should be
> updated if no status is yet set. So let's fix the isuse by reversing the
> condition.
> 
> Fixes: 3ca44c16b0dc ("Bluetooth: Consolidate encryption handling in hci_encrypt_cfm")
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> include/net/bluetooth/hci_core.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

