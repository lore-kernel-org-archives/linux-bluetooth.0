Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82733C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Dec 2021 21:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhLCVgk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Dec 2021 16:36:40 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:44632 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354044AbhLCVgk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Dec 2021 16:36:40 -0500
Received: from smtpclient.apple (p5b3d2e91.dip0.t-ipconnect.de [91.61.46.145])
        by mail.holtmann.org (Postfix) with ESMTPSA id 0BA43CED21;
        Fri,  3 Dec 2021 22:33:15 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH v4 3/4] Bluetooth: Introduce HCI_CONN_FLAG_DEVICE_PRIVACY
 device flag
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211201194952.1537811-3-luiz.dentz@gmail.com>
Date:   Fri, 3 Dec 2021 22:33:14 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <B2BC4071-BDEC-4E18-94FA-8982054DBE1B@holtmann.org>
References: <20211201194952.1537811-1-luiz.dentz@gmail.com>
 <20211201194952.1537811-3-luiz.dentz@gmail.com>
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

since 4/4 doesn’t apply, I didn’t apply this one.

Regards

Marcel

