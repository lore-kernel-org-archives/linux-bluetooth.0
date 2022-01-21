Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D410C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Jan 2022 20:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbiAUUi0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Jan 2022 15:38:26 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:43093 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbiAUUiZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Jan 2022 15:38:25 -0500
Received: from smtpclient.apple (p4fefca45.dip0.t-ipconnect.de [79.239.202.69])
        by mail.holtmann.org (Postfix) with ESMTPSA id 057C5CED17;
        Fri, 21 Jan 2022 21:38:24 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH v2] Bluetooth: btintel: Fix WBS setting for Intel legacy
 ROM products
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220120194418.349438-1-hj.tedd.an@gmail.com>
Date:   Fri, 21 Jan 2022 21:38:23 +0100
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Tedd Ho-Jeong An <tedd.an@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <069B834F-BBDC-4A9B-99FE-0603CB91D915@holtmann.org>
References: <20220120194418.349438-1-hj.tedd.an@gmail.com>
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

> This patch adds the flag to identify the Intel legacy ROM products that
> don't support WBS like WP and StP.
> 
> Fixes: 3df4dfbec0f29 ("Bluetooth: btintel: Move hci quirks to setup routine")
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
> drivers/bluetooth/btintel.c | 11 ++++++++---
> drivers/bluetooth/btintel.h |  1 +
> drivers/bluetooth/btusb.c   |  6 ++++++
> 3 files changed, 15 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

