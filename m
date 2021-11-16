Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68CAC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Nov 2021 14:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D95A61C12
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Nov 2021 14:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237269AbhKPOP6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Nov 2021 09:15:58 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:43951 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237253AbhKPOPr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Nov 2021 09:15:47 -0500
Received: from smtpclient.apple (p4fefc15c.dip0.t-ipconnect.de [79.239.193.92])
        by mail.holtmann.org (Postfix) with ESMTPSA id A0C5FCECD7;
        Tue, 16 Nov 2021 15:12:49 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH] Bluetooth: btmrvl_main: repair a non-kernel-doc comment
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211115030517.17931-1-rdunlap@infradead.org>
Date:   Tue, 16 Nov 2021 15:12:49 +0100
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <1DA72F3A-70A5-4679-A7F8-E458CBA18E3D@holtmann.org>
References: <20211115030517.17931-1-rdunlap@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Randy,

> Do not use "/**" to begin a non-kernel-doc comment.
> Fixes this build warning:
> 
> drivers/bluetooth/btmrvl_main.c:2: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Johan Hedberg <johan.hedberg@gmail.com>
> Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Cc: linux-bluetooth@vger.kernel.org
> ---
> drivers/bluetooth/btmrvl_main.c |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

