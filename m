Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DA6C7EE24
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 May 2023 09:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbjEaJFJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 May 2023 05:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235265AbjEaJEv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 May 2023 05:04:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB82132;
        Wed, 31 May 2023 02:04:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C68796311E;
        Wed, 31 May 2023 09:04:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4A9C4339C;
        Wed, 31 May 2023 09:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685523889;
        bh=oOGs9tMwzah4+TxwgR87Vqa86XZhF17++9U0nz5jqQc=;
        h=From:To:Cc:Subject:Date:From;
        b=GHprpvKBDrvMHlnkzUfG/zVo6OOctfBecJxrmF4nIhc4Pa+X0A+IffcCQGQE7U9H8
         LIODuR9NRX9i3S2m/15zIrtf24lKMKeoYyqIMEC96DTkgF26NBzBllcGBWl8IvelZ3
         UGccZXZ5NhTcAuhkDlgQ7hzNjPXcXSMMXTOVrSOpWzPQA+NFdsG38uCtsVr+7oRF5t
         djX4RR1D6Jmcg1PRkjxNnRTYUp4zfOoDDnMg9JGc57r2hYjPhv/+8OVmK3I9AdXXkO
         A3UUS0CcdKx5T5S8Jmn2bQzxFsjTSNdsSzcVwwuOm0SCexmEBRTmwiR/dThBRqZi2g
         VAfaiRnDJ/obQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1q4HlE-0000qL-Vz; Wed, 31 May 2023 11:04:53 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH RESEND 0/2] Bluetooth: fix bdaddr quirks
Date:   Wed, 31 May 2023 11:04:22 +0200
Message-Id: <20230531090424.3187-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

These patches fix a couple of issues with the two bdaddr quirks:

The first one allows HCI_QUIRK_INVALID_BDADDR to be used with
HCI_QUIRK_NON_PERSISTENT_SETUP.

The second patch restores the original semantics of the
HCI_QUIRK_USE_BDADDR_PROPERTY so that the controller is marked as
unconfigured when no device address is specified in the devicetree (as
the quirk is documented to work).

This specifically makes sure that Qualcomm HCI controllers such as
wcn6855 found on the Lenovo X13s are marked as unconfigured until user
space has provided a valid address.

Long term, the HCI_QUIRK_USE_BDADDR_PROPERTY should probably be dropped
in favour of HCI_QUIRK_INVALID_BDADDR and always checking the devicetree
property.

Johan


Johan Hovold (2):
  Bluetooth: fix invalid-bdaddr quirk for non-persistent setup
  Bluetooth: fix use-bdaddr-property quirk

 net/bluetooth/hci_sync.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

-- 
2.39.3

