Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7C9C4338F
	for <linux-bluetooth@archiver.kernel.org>; Sun, 25 Jul 2021 06:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D21260F37
	for <linux-bluetooth@archiver.kernel.org>; Sun, 25 Jul 2021 06:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbhGYF52 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 25 Jul 2021 01:57:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229460AbhGYF51 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 25 Jul 2021 01:57:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C0F8C60F26;
        Sun, 25 Jul 2021 06:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627195078;
        bh=KhfxSM4bGalnc86aaQ4+BeZvZ3bwXosyeMhrUxjgFrs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k/VXlEmxe2sxnSKsbgmAQ6dk/yeEbahO0A8UWRxQRmJjCC5/XJ0lBaKNyFw0OJGUx
         Xh3dZb4FBF+cE4jlNHx3RwzamxAT/eiqxhDtcWqtr6tczYbEHLKSo3DnzwsRw4tJgD
         INV3srpPUh7t4JYA5xwbWodxZN4adCIvf+ASlqh8=
Date:   Sun, 25 Jul 2021 08:37:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Salah Triki <salah.triki@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bluetooth: bcm203x: update the reference count of udev
Message-ID: <YP0GwoOT32z183K3@kroah.com>
References: <20210724182054.GA451351@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210724182054.GA451351@pc>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Sat, Jul 24, 2021 at 07:20:54PM +0100, Salah Triki wrote:
> Use usb_get_dev() and usb_put_dev() in order to update the reference
> count of udev.

That says _what_ you are doing, but no reason as to _why_ this is being
done :(

