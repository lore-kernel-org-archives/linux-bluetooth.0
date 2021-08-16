Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3F7C4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Aug 2021 15:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F38660F4B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Aug 2021 15:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237169AbhHPP4U (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Aug 2021 11:56:20 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:54892 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237474AbhHPPzq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Aug 2021 11:55:46 -0400
Received: from smtpclient.apple (p5b3d23f8.dip0.t-ipconnect.de [91.61.35.248])
        by mail.holtmann.org (Postfix) with ESMTPSA id 8041CCECC8;
        Mon, 16 Aug 2021 17:55:13 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v4 1/2] Bluetooth: Fix handling of LE Enhanced Connection
 Complete
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210811232016.757154-1-luiz.dentz@gmail.com>
Date:   Mon, 16 Aug 2021 17:55:13 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <C5BED646-C6E3-4CF2-AF07-D8D56A3087B1@holtmann.org>
References: <20210811232016.757154-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> LE Enhanced Connection Complete contains the Local RPA used in the
> connection which must be used when set otherwise there could problems
> when pairing since the address used by the remote stack could be the
> Local RPA:
> 
> BLUETOOTH CORE SPECIFICATION Version 5.2 | Vol 4, Part E
> page 2396
> 
>  'Resolvable Private Address being used by the local device for this
>  connection. This is only valid when the Own_Address_Type (from the
>  HCI_LE_Create_Connection, HCI_LE_Set_Advertising_Parameters,
>  HCI_LE_Set_Extended_Advertising_Parameters, or
>  HCI_LE_Extended_Create_Connection commands) is set to 0x02 or
>  0x03, and the Controller generated a resolvable private address for the
>  local device using a non-zero local IRK. For other Own_Address_Type
>  values, the Controller shall return all zeros.'
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> net/bluetooth/hci_event.c | 93 ++++++++++++++++++++++++++-------------
> 1 file changed, 62 insertions(+), 31 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

