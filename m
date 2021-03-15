Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A91C433DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Mar 2021 20:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E62664F26
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Mar 2021 20:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbhCOUwr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Mar 2021 16:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbhCOUwc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Mar 2021 16:52:32 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37280C06174A
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Mar 2021 13:52:31 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id ha17so8704360pjb.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Mar 2021 13:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=GlSRBRC6mRflh3kSSjMee01CtTzCxhAFVTs0c6grDVk=;
        b=GnH3MIPC8ZcVVJ59NVMct1//zNJWqN73PonY9zcN1hJyBlAAOzSqZGh4O/xMMTuSjG
         vL5DLGI7/ofsvUXjbdOK8HVmu3qEmJocI0zJ2+/DtveonWnR/U6EFxgzXG0YoBJeWJO4
         KRCTaKULScfoelMvVP+U5NPhSi+JzCGuTTnib4oMlvJHCe02DSPelkgpULng9ehxXk09
         oRp8mCjStQRg6p2aABkGRNo3f/cJ+xouMOHc3InW8Y8V2KKuhS/hSNKCSfIUhD9oAKNH
         mzZXKSsQCbgjM+ten79lrz54vaLKkTouhl8KtXW0KOID/BzMK7kx1ygxvsnKdsbx4y30
         PN4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=GlSRBRC6mRflh3kSSjMee01CtTzCxhAFVTs0c6grDVk=;
        b=cbMzo4dYH2Krg5P+ddiqeG9UoMV/qPz9EIRD40oPSmUoAdOo8NRLskfyua9GdLy05G
         rsoETQN12MwTsytVbjmJcB4yttU26uFS/C/Bo17pLJ+dS3I4XCThR2NTZKKQdOix9eh7
         rYLK+nQD5zrZnHMIOr4Rgd5GGOPwfhWZIHAeS56cJB9j+lguMN+QR9maCAyZE60iZ/o/
         Lc+L/h4nBG7wk6+6i/4SZcKfvDXHTQbSPOyLRvLKy5VfdQiiHd7Szi4tgxJwXnS0xnCx
         /3rkHiBTNJtNlqdqcdtiMQ2IZdpdmun0rtNUGtzutzWNCwYgHNfo/27AlV8xz+Dzm79x
         FqLQ==
X-Gm-Message-State: AOAM530ED9IltP9huxYOMpYpIa12kTRmuBLL5pBRkMTFhDiJKIuwTyMo
        1GZjKea0b4esvESrE4vT48c=
X-Google-Smtp-Source: ABdhPJwNsi6T3hvv6fryXQsjs/SfN/eSdSKv+ITpQQcdLItlbK7gCskqmFYFGWkhJQzr9XMdSZB12Q==
X-Received: by 2002:a17:90a:bb95:: with SMTP id v21mr980370pjr.30.1615841550763;
        Mon, 15 Mar 2021 13:52:30 -0700 (PDT)
Received: from han1-NUC8i7BEH ([2601:1c0:6a01:d830:bd38:85f4:60c8:d814])
        by smtp.gmail.com with ESMTPSA id ds3sm507270pjb.23.2021.03.15.13.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 13:52:30 -0700 (PDT)
Message-ID: <6644650bbd0e5748368a2468e1df9f181bdc413c.camel@gmail.com>
Subject: Re: [PATCH v9 1/9] Bluetooth: btintel: Check firmware version
 before download
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Date:   Mon, 15 Mar 2021 13:52:29 -0700
In-Reply-To: <20210315174002.1778447-1-luiz.dentz@gmail.com>
References: <20210315174002.1778447-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Mon, 2021-03-15 at 10:39 -0700, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
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
> 
>  drivers/bluetooth/btintel.c   | 106 +++++++++++++++++++++++++++-------
>  drivers/bluetooth/btintel.h   |   5 +-
>  drivers/bluetooth/btusb.c     |  18 +++++-
>  drivers/bluetooth/hci_intel.c |   7 ++-
>  4 files changed, 109 insertions(+), 27 deletions(-)

I ran a quick test the v9 with the devices what I have.

Test cases are:
- cold boot - expect to downloading the firmware
- reboot - expect to no firmware downloading
- fw upgrade - expect to device reset and download new firmware

Devices tests:
SfP, WsP, ThP, TyP

Results:
ThP, TyP: All 3 test cases were passed.
SfP, WsP: fw upgrade case(#3) didn't work but it was known issue
		- insufficient fw version information in the firmware file

Tested-by: Tedd Ho-Jeong An <tedd.an@intel.com>
Tested-by: Kiran K <kiran.k@intel.com>

Regards,
Tedd





