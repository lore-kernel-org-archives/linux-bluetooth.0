Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0745C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Dec 2021 15:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245574AbhLDPqR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 4 Dec 2021 10:46:17 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:52849 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234711AbhLDPqR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 4 Dec 2021 10:46:17 -0500
Received: from smtpclient.apple (p5b3d2e91.dip0.t-ipconnect.de [91.61.46.145])
        by mail.holtmann.org (Postfix) with ESMTPSA id B03ACCED2C;
        Sat,  4 Dec 2021 16:42:50 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH 1/2] Bluetooth: Introduce HCI_CONN_FLAG_DEVICE_PRIVACY
 device flag
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211203220723.2302153-1-luiz.dentz@gmail.com>
Date:   Sat, 4 Dec 2021 16:42:50 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <F12AE84C-4430-4900-9961-94F411F035A9@holtmann.org>
References: <20211203220723.2302153-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This introduces HCI_CONN_FLAG_DEVICE_PRIVACY which can be used by
> userspace to indicate to the controller to use Device Privacy Mode to a
> specific device.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> include/net/bluetooth/hci_core.h |  4 ++++
> net/bluetooth/mgmt.c             | 12 ++++++++++++
> 2 files changed, 16 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

