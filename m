Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68057C433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Mar 2021 07:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25987619D3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Mar 2021 07:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhCZHhY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Mar 2021 03:37:24 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:39015 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhCZHhH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Mar 2021 03:37:07 -0400
Received: from marcel-macbook.holtmann.net (p4fefce19.dip0.t-ipconnect.de [79.239.206.25])
        by mail.holtmann.org (Postfix) with ESMTPSA id A8849CEC82;
        Fri, 26 Mar 2021 08:44:45 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH v10 1/9] Bluetooth: btintel: Check firmware version before
 download
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210323185904.3372987-1-luiz.dentz@gmail.com>
Date:   Fri, 26 Mar 2021 08:37:05 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <EF785EC4-F464-4BAC-972F-62F591C59456@holtmann.org>
References: <20210323185904.3372987-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This checks the firmware build number, week and year against the
> repective loaded version. If details are a match, skip the download
> process.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> v2: Add patch that mover checks for operational mode after the version
> checking.
> v3: Fix not checking for operation mode before using btintel_read_boot_params
> since some models depend on that to contruct the fw filename. Also attempt to
> cleanup duplicated code.
> v4: Fix forwarding -EALREADY when firmware has already been loaded.
> v5: Fix not advancing fw_ptr.
> v6: Fix btusb_setup_intel_new_get_fw_name error checking for ddc.
> v7: Disable version checking for WsP/SfP.
> v8: Really disables version checking for WsP/SfP.
> v9: Reintroduce bootloader checks and add workaround for version checking when
> operation and version cannot be read.
> v10: Fix build error when BT_CONFIG_INTEL is not set.
> 
> drivers/bluetooth/btintel.c   | 106 +++++++++++++++++++++++++++-------
> drivers/bluetooth/btintel.h   |   5 +-
> drivers/bluetooth/btusb.c     |  18 +++++-
> drivers/bluetooth/hci_intel.c |   7 ++-
> 4 files changed, 109 insertions(+), 27 deletions(-)

all 9 patches have been applied to bluetooth-next tree.

Regards

Marcel

