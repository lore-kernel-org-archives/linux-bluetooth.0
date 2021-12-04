Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C64C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Dec 2021 15:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245653AbhLDPql (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 4 Dec 2021 10:46:41 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:35508 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234711AbhLDPqk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 4 Dec 2021 10:46:40 -0500
Received: from smtpclient.apple (p5b3d2e91.dip0.t-ipconnect.de [91.61.46.145])
        by mail.holtmann.org (Postfix) with ESMTPSA id 2C5E2CED2C;
        Sat,  4 Dec 2021 16:43:14 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH 2/2] Bluetooth: hci_sync: Set Privacy Mode when updating
 the resolving list
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211203220723.2302153-2-luiz.dentz@gmail.com>
Date:   Sat, 4 Dec 2021 16:43:14 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <8825D155-E5B9-4064-A832-5862A27BDEC2@holtmann.org>
References: <20211203220723.2302153-1-luiz.dentz@gmail.com>
 <20211203220723.2302153-2-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This adds support for Set Privacy Mode when updating the resolving list
> when HCI_CONN_FLAG_DEVICE_PRIVACY so the controller shall use Device
> Mode for devices programmed in the resolving list, Device Mode is
> actually required when the remote device are not able to use RPA as
> otherwise the default mode is Network Privacy Mode in which only
> allows RPAs thus the controller would filter out advertisement using
> identity addresses for which there is an IRK.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> include/net/bluetooth/hci.h      | 10 +++++++
> include/net/bluetooth/hci_core.h |  1 +
> net/bluetooth/hci_event.c        | 30 ++++++++++++++++++-
> net/bluetooth/hci_sync.c         | 51 ++++++++++++++++++++++++++++----
> 4 files changed, 85 insertions(+), 7 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

