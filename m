Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0207CC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Jan 2022 20:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiAUUmU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Jan 2022 15:42:20 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:54197 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiAUUmT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Jan 2022 15:42:19 -0500
Received: from smtpclient.apple (p4fefca45.dip0.t-ipconnect.de [79.239.202.69])
        by mail.holtmann.org (Postfix) with ESMTPSA id A49F2CED17;
        Fri, 21 Jan 2022 21:42:18 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH] Bluetooth: Remove kernel-doc style comment block
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220115010329.241808-1-hj.tedd.an@gmail.com>
Date:   Fri, 21 Jan 2022 21:42:18 +0100
Cc:     linux-bluetooth@vger.kernel.org,
        Tedd Ho-Jeong An <tedd.an@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <45425719-76A0-4F09-B7F4-80489B0313EB@holtmann.org>
References: <20220115010329.241808-1-hj.tedd.an@gmail.com>
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

> This patch changes the kernel-doc style comment block to common comment
> block. These files don't support kernel-doc style so no need to use the
> kernel-doc style. Also, they cause the warning when W=1 option is used
> as below.
> 
> drivers/bluetooth/hci_ll.c:518: warning: Function parameter or member 'lldev' not described in 'download_firmware'
> drivers/bluetooth/btmrvl_debugfs.c:29: warning: cannot understand function prototype: 'struct btmrvl_debugfs_data '
> drivers/bluetooth/btmrvl_sdio.c:36: warning: expecting prototype for Marvell BT-over-SDIO driver(). Prototype was for VERSION() instead
> 
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
> drivers/bluetooth/btmrvl_debugfs.c | 2 +-
> drivers/bluetooth/btmrvl_sdio.c    | 2 +-
> drivers/bluetooth/hci_ll.c         | 2 +-
> 3 files changed, 3 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

