Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACD7C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Dec 2021 21:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354095AbhLCVgk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Dec 2021 16:36:40 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:37104 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbhLCVgj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Dec 2021 16:36:39 -0500
Received: from smtpclient.apple (p5b3d2e91.dip0.t-ipconnect.de [91.61.46.145])
        by mail.holtmann.org (Postfix) with ESMTPSA id B4435CED20;
        Fri,  3 Dec 2021 22:33:13 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH v4 4/4] Bluetooth: hci_sync: Set Privacy Mode when
 updating the resolving list
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211201194952.1537811-4-luiz.dentz@gmail.com>
Date:   Fri, 3 Dec 2021 22:33:13 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <F6F1A6A8-85C9-48D8-ACEF-083DED8FD423@holtmann.org>
References: <20211201194952.1537811-1-luiz.dentz@gmail.com>
 <20211201194952.1537811-4-luiz.dentz@gmail.com>
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
> net/bluetooth/hci_event.c        | 29 ++++++++++++++++++
> net/bluetooth/hci_sync.c         | 51 ++++++++++++++++++++++++++++----
> 4 files changed, 85 insertions(+), 6 deletions(-)

this patch doesn’t apply to bluetooth-next tree.

Regards

Marcel

