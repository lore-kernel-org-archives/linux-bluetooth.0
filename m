Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE16EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Nov 2021 19:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC62D60FC4
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Nov 2021 19:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbhKAT1N convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Nov 2021 15:27:13 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:34541 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbhKAT1M (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Nov 2021 15:27:12 -0400
Received: from smtpclient.apple (p4fefc15c.dip0.t-ipconnect.de [79.239.193.92])
        by mail.holtmann.org (Postfix) with ESMTPSA id B6061CECDB;
        Mon,  1 Nov 2021 20:24:37 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH v2] Bluetooth: hci_sync: Fix missing static warnings
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211101165240.2707193-1-luiz.dentz@gmail.com>
Date:   Mon, 1 Nov 2021 20:24:37 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <07BC68F5-329B-42A9-B314-9B0C7221AA79@holtmann.org>
References: <20211101165240.2707193-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This fixes the following warnings:
> 
>>> net/bluetooth/hci_sync.c:1333:5: warning: no previous prototype for
> 'hci_scan_disable_sync' [-Wmissing-prototypes]
>    1333 | int hci_scan_disable_sync(struct hci_dev *hdev, bool rpa_le_conn)
>         |     ^~~~~~~~~~~~~~~~~~~~~
>>> net/bluetooth/hci_sync.c:1762:5: warning: no previous prototype for
> 'hci_passive_scan_sync' [-Wmissing-prototypes]
>    1762 | int hci_passive_scan_sync(struct hci_dev *hdev)
>         |     ^~~~~~~~~~~~~~~~~~~~~
> 
> Fixes: e8907f76544f ("Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 3")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> net/bluetooth/hci_sync.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

