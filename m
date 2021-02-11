Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C73C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Feb 2021 07:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 930CB61490
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Feb 2021 07:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbhBKHey (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Feb 2021 02:34:54 -0500
Received: from mga11.intel.com ([192.55.52.93]:18382 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229752AbhBKHeo (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Feb 2021 02:34:44 -0500
IronPort-SDR: aLCxZ1fuD6TQe/bMBTb34GiOBSEK7ab5mOeoF1QCV7aADFvojsKVWZfEoOA3WDwvOnB5860TyJ
 PnUxP0O0tioA==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="178696053"
X-IronPort-AV: E=Sophos;i="5.81,169,1610438400"; 
   d="scan'208";a="178696053"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 23:32:53 -0800
IronPort-SDR: RtlkM6Pbr1gp4IKbRZxhLLE5y0AtzVXbLSAl938dkdWoBMLZfRMC31XrI/jX/Zjk5YSQLJZ9yQ
 wER/Qd1DG7eg==
X-IronPort-AV: E=Sophos;i="5.81,169,1610438400"; 
   d="scan'208";a="397150253"
Received: from wmays-mobl.amr.corp.intel.com ([10.255.231.21])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 23:32:52 -0800
Message-ID: <9e9b46f42acc828ab362ba7f85ec0850e2d65770.camel@linux.intel.com>
Subject: Re: [PATCH v8 1/6] Bluetooth: btintel: Check firmware version
 before download
From:   Tedd Ho-Jeong An <tedd.an@linux.intel.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Date:   Wed, 10 Feb 2021 23:32:52 -0800
In-Reply-To: <20210211010900.2326531-1-luiz.dentz@gmail.com>
References: <20210211010900.2326531-1-luiz.dentz@gmail.com>
Organization: Intel Corporation
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Wed, 2021-02-10 at 17:08 -0800, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This checks the firmware build number, week and year matches with
> repective version loaded and then skip the download process.
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
> 
>  drivers/bluetooth/btintel.c   | 105 +++++++++++++++++++++++++++-------
>  drivers/bluetooth/btintel.h   |   5 +-
>  drivers/bluetooth/btusb.c     |  18 +++++-
>  drivers/bluetooth/hci_intel.c |   7 ++-
>  4 files changed, 109 insertions(+), 26 deletions(-)
> 

I tested with ThP and no issue found.
I also tested with WsP and fw loading fine and no upgrading as expected.

More devices will be tested. Stay tune.

Regards,
Tedd

