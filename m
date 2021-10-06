Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B935C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 08:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62D7F610A5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 08:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237744AbhJFJAG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Oct 2021 05:00:06 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:33146 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237594AbhJFJAF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Oct 2021 05:00:05 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id 56D8BCED2D;
        Wed,  6 Oct 2021 10:58:13 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH 1/3] Bluetooth: hci_vhci: Fix calling
 hci_{suspend,resume}_dev
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211006010935.902645-1-luiz.dentz@gmail.com>
Date:   Wed, 6 Oct 2021 10:58:13 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <4EAA306C-86A2-4D92-8DE3-9CD99A01E58D@holtmann.org>
References: <20211006010935.902645-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> Defer calls to hci_{suspend,resume}_dev to work so it doesn't block the
> processing of the events.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> drivers/bluetooth/hci_vhci.c | 24 ++++++++++++++++--------
> 1 file changed, 16 insertions(+), 8 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

