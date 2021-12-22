Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDA7C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Dec 2021 22:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240578AbhLVWCw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Dec 2021 17:02:52 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:58381 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbhLVWCv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Dec 2021 17:02:51 -0500
Received: from smtpclient.apple (p5b3d2e91.dip0.t-ipconnect.de [91.61.46.145])
        by mail.holtmann.org (Postfix) with ESMTPSA id 07683CED17;
        Wed, 22 Dec 2021 23:02:50 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH v5 1/6] Bluetooth: hci_sync: Add hci_le_create_conn_sync
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211222202201.977779-1-luiz.dentz@gmail.com>
Date:   Wed, 22 Dec 2021 23:02:49 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <2BA5CAD3-BE50-438B-9C41-4A1112432F6D@holtmann.org>
References: <20211222202201.977779-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This adds hci_le_create_conn_sync and make hci_le_connect use it instead
> of queueing multiple commands which may conflict with the likes of
> hci_update_passive_scan which uses hci_cmd_sync_queue.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> v2: Remove setting of direct_rpa as random address and add a patch checking
> hdev->le_states if simultaneous roles are supported.
> v3: Fix checkpatch warnings.
> v4: Add patch fixing LE simultaneous roles supported vs enabled.
> v5: Add patch setting HCI_QUIRK_VALID_LE_STATES for vhci since it is
> now required in order for LE simultaneous roles UUID to be listed as
> experimental and was the reason mgmt-tester had 1 test failing.
> 
> include/net/bluetooth/hci_core.h |   3 +-
> include/net/bluetooth/hci_sync.h |   4 +
> net/bluetooth/hci_conn.c         | 305 ++-----------------------------
> net/bluetooth/hci_event.c        |   6 +-
> net/bluetooth/hci_request.c      |  50 -----
> net/bluetooth/hci_request.h      |   2 -
> net/bluetooth/hci_sync.c         | 277 ++++++++++++++++++++++++++++
> net/bluetooth/l2cap_core.c       |   2 +-
> 8 files changed, 300 insertions(+), 349 deletions(-)

all 6 patches have been applied to bluetooth-next tree.

Regards

Marcel

