Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A607C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sun,  9 Jan 2022 15:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbiAIPHr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 9 Jan 2022 10:07:47 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:54407 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbiAIPHq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 9 Jan 2022 10:07:46 -0500
Received: from smtpclient.apple (p4fefca45.dip0.t-ipconnect.de [79.239.202.69])
        by mail.holtmann.org (Postfix) with ESMTPSA id 46A11CED22;
        Sun,  9 Jan 2022 16:07:45 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH] Bluetooth: hci_sync: Fix compilation warning
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220109052145.4081797-1-luiz.dentz@gmail.com>
Date:   Sun, 9 Jan 2022 16:07:44 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <C2B481A5-B6D0-4451-AE3A-66A1A9F86DC6@holtmann.org>
References: <20220109052145.4081797-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This fixes the following warning:
> 
> net/bluetooth/hci_sync.c:5143:5: warning: no previous prototype for
> ‘hci_le_ext_create_conn_sync’ [-Wmissing-prototypes]
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> net/bluetooth/hci_sync.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

