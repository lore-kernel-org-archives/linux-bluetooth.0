Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE51AC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jan 2022 21:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbiAYVlI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jan 2022 16:41:08 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:40336 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233241AbiAYVlI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jan 2022 16:41:08 -0500
Received: from smtpclient.apple (p5b3d24e1.dip0.t-ipconnect.de [91.61.36.225])
        by mail.holtmann.org (Postfix) with ESMTPSA id 0562DCECF6;
        Tue, 25 Jan 2022 22:41:07 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH] Bluetooth: hci_core: Rate limit the logging of invalid
 SCO handle
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220125191537.2426630-1-luiz.dentz@gmail.com>
Date:   Tue, 25 Jan 2022 22:41:06 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <A071DB4D-49A8-4933-AFA8-BE8A7FED7C0B@holtmann.org>
References: <20220125191537.2426630-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> The invalid SCO handle error is normally caused by a race in the USB
> transport where the data and event happen to be 2 different endpoints
> so the event carrying the SCO handle is processed after its data.
> 
> Note: This can probably be resolved with use of force_poll_sync
> debugfs.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> net/bluetooth/hci_core.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

