Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB94C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Jul 2021 12:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 965D960F12
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Jul 2021 12:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238663AbhG3MfJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Jul 2021 08:35:09 -0400
Received: from fgw21-4.mail.saunalahti.fi ([62.142.5.108]:37635 "EHLO
        fgw21-4.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230429AbhG3MfI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Jul 2021 08:35:08 -0400
Received: from ydin.reaktio.net (reaktio.net [85.76.255.15])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id 8ee2df34-f132-11eb-ae1c-005056bdd08f;
        Fri, 30 Jul 2021 15:35:02 +0300 (EEST)
Received: by ydin.reaktio.net (Postfix, from userid 1001)
        id 38F2520089; Fri, 30 Jul 2021 15:35:01 +0300 (EEST)
Date:   Fri, 30 Jul 2021 15:35:01 +0300
From:   Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
To:     Pauli Virtanen <pav@iki.fi>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, kernel@kempniu.pl,
        linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
        hildawu@realtek.com, josephsih@google.com
Subject: Re: [PATCH v3] Bluetooth: btusb: check conditions before enabling
 USB ALT 3 for WBS
Message-ID: <20210730123501.GA16261@reaktio.net>
References: <d43dffdc43a40782ec6d5d6c24b1638005992a8f.camel@iki.fi>
 <20210726180206.49703-1-pav@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210726180206.49703-1-pav@iki.fi>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Mon, Jul 26, 2021 at 09:02:06PM +0300, Pauli Virtanen wrote:
> Some USB BT adapters don't satisfy the MTU requirement mentioned in
> commit e848dbd364ac ("Bluetooth: btusb: Add support USB ALT 3 for WBS")
> and have ALT 3 setting that produces no/garbled audio. Some adapters
> with larger MTU were also reported to have problems with ALT 3.
> 
> Add a flag and check it and MTU before selecting ALT 3, falling back to
> ALT 1. Enable the flag for Realtek, restoring the previous behavior for
> non-Realtek devices.
> 
> Tested with USB adapters (mtu<72, no/garbled sound with ALT3, ALT1
> works) BCM20702A1 0b05:17cb, CSR8510A10 0a12:0001, and (mtu>=72, ALT3
> works) RTL8761BU 0bda:8771, Intel AX200 8087:0029 (after disabling
> ALT6). Also got reports for (mtu>=72, ALT 3 reported to produce bad
> audio) Intel 8087:0a2b.
> 
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> Fixes: e848dbd364ac ("Bluetooth: btusb: Add support USB ALT 3 for WBS")
> Tested-by: Michał Kępień <kernel@kempniu.pl>
> ---
>

This probably also should have CC stable@kernel.org, as users have
started reporting this bug as distros have started shipping kernels with
the faulty patch in it.. so it'd be nice to have the fix backported to
stable kernel trees.


Thanks,

-- Pasi

> 
> Changes in v3:
> - Rename flag to BTUSB_USE_ALT3_FOR_WBS.
> - No spaces in indent.
> - Added Tested-by: Michał Kępień
> 
> Changes in v2:
> - Explain magic number 72 in a comment; didn't add the table for them,
>   because it's not used elsewhere and we need just one number from it.
> - Add flag for ALT3 support, restoring the behavior
>   for non-Realtek devices the same as before e848dbd364ac, due to
>   the problems reported on an Intel adapter. Don't have the device
>   myself.
> 
