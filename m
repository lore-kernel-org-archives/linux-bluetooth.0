Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AB8C433B4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Apr 2021 08:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FD456145A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Apr 2021 08:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241192AbhDWIAx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Apr 2021 04:00:53 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:39653 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbhDWIAx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Apr 2021 04:00:53 -0400
Received: from marcel-macbook.holtmann.net (p4fefc624.dip0.t-ipconnect.de [79.239.198.36])
        by mail.holtmann.org (Postfix) with ESMTPSA id 0D464CECFB;
        Fri, 23 Apr 2021 10:08:03 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH v3 2/3] Bluetooth: add support to enumerate local supports
 codecs v2
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210422141449.25155-2-kiran.k@intel.com>
Date:   Fri, 23 Apr 2021 10:00:15 +0200
Cc:     linux-bluetooth@vger.kernel.org,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
Content-Transfer-Encoding: 7bit
Message-Id: <F1E3625E-35F1-4B68-9E37-512F45E674D9@holtmann.org>
References: <20210422141449.25155-1-kiran.k@intel.com>
 <20210422141449.25155-2-kiran.k@intel.com>
To:     Kiran K <kiran.k@intel.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

> Add support for HCI_Read_Local_Supported_Codecs_V2 and query codec
> capabilities
> 
> snoop:
>> HCI Event: Command Complete (0x0e) plen 20
>      Read Local Supported Codecs V2 (0x04|0x000d) ncmd 1
>        Status: Success (0x00)
>        Number of supported codecs: 7
>          Codec: u-law log (0x00)
>          Logical Transport Type: 0x02
>            Codec supported over BR/EDR SCO and eSCO
>          Codec: A-law log (0x01)
>          Logical Transport Type: 0x02
>            Codec supported over BR/EDR SCO and eSCO
>          Codec: CVSD (0x02)
>          Logical Transport Type: 0x02
>            Codec supported over BR/EDR SCO and eSCO
>          Codec: Transparent (0x03)
>          Logical Transport Type: 0x02
>            Codec supported over BR/EDR SCO and eSCO
>          Codec: Linear PCM (0x04)
>          Logical Transport Type: 0x02
>            Codec supported over BR/EDR SCO and eSCO
>          Codec: Reserved (0x08)
>          Logical Transport Type: 0x03
>            Codec supported over BR/EDR ACL
>            Codec supported over BR/EDR SCO and eSCO
>          Codec: mSBC (0x05)
>          Logical Transport Type: 0x03
>            Codec supported over BR/EDR ACL
>            Codec supported over BR/EDR SCO and eSCO
>        Number of vendor codecs: 0
> ......
> < HCI Command: Read Local Suppor.. (0x04|0x000e) plen 7
>        Codec: mSBC (0x05)
>        Logical Transport Type: 0x00
>        Direction: Input (Host to Controller) (0x00)
>> HCI Event: Command Complete (0x0e) plen 12
>      Read Local Supported Codec Capabilities (0x04|0x000e) ncmd 1
>        Status: Success (0x00)
>        Number of codec capabilities: 1
>         Capabilities #0:
>        00 00 11 15 02 33
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Signed-off-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> ---
> * changes in v3:
>  No changes
> 
> * changes in v2:
>  add length check for event data before accessing
> 
> include/net/bluetooth/hci.h      |   2 +
> include/net/bluetooth/hci_core.h |  10 +++
> net/bluetooth/hci_core.c         |   4 +-
> net/bluetooth/hci_event.c        | 110 +++++++++++++++++++++++++++++++
> 4 files changed, 125 insertions(+), 1 deletion(-)

I would rather move the v2 support to 3/3 in this series.

Regards

Marcel

