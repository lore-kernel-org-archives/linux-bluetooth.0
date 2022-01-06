Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F4BC433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Jan 2022 13:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239800AbiAFN6J (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Jan 2022 08:58:09 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:47295 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239519AbiAFN6I (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Jan 2022 08:58:08 -0500
Received: from smtpclient.apple (p4fefca45.dip0.t-ipconnect.de [79.239.202.69])
        by mail.holtmann.org (Postfix) with ESMTPSA id 3AF3DCECD5;
        Thu,  6 Jan 2022 14:58:07 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH] Bluetooth: hci_event: Rework
 hci_inquiry_result_with_rssi_evt
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220105225953.3240356-1-luiz.dentz@gmail.com>
Date:   Thu, 6 Jan 2022 14:58:06 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <55276042-AD90-42DD-B3CF-439DB4EEBAEA@holtmann.org>
References: <20220105225953.3240356-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This rework the handling of hci_inquiry_result_with_rssi_evt to not use
> a union to represent the different inquiry responses.
> 
> Tested-by: Soenke Huster <soenke.huster@eknoes.de>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> include/net/bluetooth/hci.h |  6 +-----
> net/bluetooth/hci_event.c   | 19 +++++++++----------
> 2 files changed, 10 insertions(+), 15 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

