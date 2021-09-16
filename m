Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A81C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Sep 2021 00:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2B3761165
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Sep 2021 00:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbhIPAGF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Sep 2021 20:06:05 -0400
Received: from mga17.intel.com ([192.55.52.151]:14969 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232465AbhIPAGF (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Sep 2021 20:06:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10108"; a="202610812"
X-IronPort-AV: E=Sophos;i="5.85,296,1624345200"; 
   d="scan'208";a="202610812"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 17:04:45 -0700
X-IronPort-AV: E=Sophos;i="5.85,296,1624345200"; 
   d="scan'208";a="545248319"
Received: from vyellapa-mobl.amr.corp.intel.com ([10.209.32.240])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 17:04:45 -0700
Message-ID: <b79bfb3c6816aecf69e15c815b17b46137ed66e6.camel@linux.intel.com>
Subject: Re: [PATCH v4 1/4] Bluetooth: hci_sock: Add support for
 BT_{SND,RCV}BUF
From:   Tedd Ho-Jeong An <tedd.an@linux.intel.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Date:   Wed, 15 Sep 2021 17:04:44 -0700
In-Reply-To: <20210915233600.4129808-1-luiz.dentz@gmail.com>
References: <20210915233600.4129808-1-luiz.dentz@gmail.com>
Organization: Intel Corporation
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Wed, 2021-09-15 at 16:35 -0700, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds support for BT_{SND,RCV}BUF so userspace can set MTU based on
> the channel usage.
> 
> Fixes: https://github.com/bluez/bluez/issues/201
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/hci_sock.c | 105 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 94 insertions(+), 11 deletions(-)
> 

Tested-by: Tedd Ho-Jeong An <tedd.an@intel.com>

Regards,
Tedd

