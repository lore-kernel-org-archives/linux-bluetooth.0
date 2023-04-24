Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32CBC7618E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Apr 2023 13:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbjDXNgA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Apr 2023 09:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbjDXNfp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Apr 2023 09:35:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF1C86A9;
        Mon, 24 Apr 2023 06:35:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29EB5623DF;
        Mon, 24 Apr 2023 13:35:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BC0C433A7;
        Mon, 24 Apr 2023 13:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682343335;
        bh=y75lIJf876GxKiQkHIBiRfNRr/Wh0exyC294HWMMYSY=;
        h=From:To:Cc:Subject:Date:From;
        b=c63FNuRh+ltANDc9x1c2RV4jMvPfo8O4kXdC8p/oHFQtXWMmmBTdsV+i1QB2weBhs
         y3SNmnOoaww2SMmteRuoOGkdquo4UWnhvUd7SJa0OqjocVFJeDqsELAR5AEDYFQbbR
         aqcCqgaY1AmwCSnSo3qnSdE7y9mzWeVcZc1lq8J2rOoyfFof6WRn8gclL59ibAUbuU
         sRy8HwSdYGEc2fRqD25vYpzOi0wKMq1BxUbi2dy/WkGv6QTTja8LK5asLZbhUiIIwi
         5mEt+540mtlNEL8FG8E+6rEpXNLu7frMwAhubw8MhiuB4pwt4Aa1oYOZGrlT017+UK
         seWfrKpO9w6qA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pqwMB-0003kG-EN; Mon, 24 Apr 2023 15:35:52 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/2] Bluetooth: fix bdaddr quirks
Date:   Mon, 24 Apr 2023 15:35:40 +0200
Message-Id: <20230424133542.14383-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

These patches fixes a couple of issues with the two bdaddr quirks:

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
2.39.2

