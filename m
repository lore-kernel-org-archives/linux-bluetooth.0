Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9772C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Dec 2021 21:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354078AbhLCVgn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Dec 2021 16:36:43 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:46572 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354044AbhLCVgn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Dec 2021 16:36:43 -0500
Received: from smtpclient.apple (p5b3d2e91.dip0.t-ipconnect.de [91.61.46.145])
        by mail.holtmann.org (Postfix) with ESMTPSA id D77B0CED21;
        Fri,  3 Dec 2021 22:33:17 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH v4 2/4] Bluetooth: hci_core: Rework hci_conn_params flags
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211201194952.1537811-2-luiz.dentz@gmail.com>
Date:   Fri, 3 Dec 2021 22:33:17 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <A37EF1CD-0EE2-4BDF-965B-401005F6E8AE@holtmann.org>
References: <20211201194952.1537811-1-luiz.dentz@gmail.com>
 <20211201194952.1537811-2-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This reworks hci_conn_params flags to use bitmap_* helpers and add
> support for setting the supported flags in hdev->conn_flags so it can
> easily be accessed.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> include/net/bluetooth/hci_core.h | 24 ++++++++++++------------
> net/bluetooth/hci_core.c         |  8 +++++++-
> net/bluetooth/hci_request.c      |  4 ++--
> net/bluetooth/hci_sync.c         |  7 +++----
> net/bluetooth/mgmt.c             | 30 ++++++++++++++++++++----------
> 5 files changed, 44 insertions(+), 29 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

