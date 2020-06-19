Return-Path: <SRS0=y5DB=AA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD7AC433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Jun 2020 07:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 392222078D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Jun 2020 07:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730936AbgFSHzB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Jun 2020 03:55:01 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:34130 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730880AbgFSHzA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Jun 2020 03:55:00 -0400
Received: from marcel-macbook.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id 70974CECF1;
        Fri, 19 Jun 2020 10:04:51 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2 1/2] Bluetooth: Disconnect if E0 is used for Level 4
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200520212015.626026-1-luiz.dentz@gmail.com>
Date:   Fri, 19 Jun 2020 09:54:59 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <2B2EAC6C-D6FA-4CF1-87EB-8CCB774DBBE4@holtmann.org>
References: <20200520212015.626026-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> E0 is not allowed with Level 4:
> 
> BLUETOOTH CORE SPECIFICATION Version 5.2 | Vol 3, Part C page 1319:
> 
>  '128-bit equivalent strength for link and encryption keys
>   required using FIPS approved algorithms (E0 not allowed,
>   SAFER+ not allowed, and P-192 not allowed; encryption key
>   not shortened'
> 
> SC enabled:
> 
>> HCI Event: Read Remote Extended Features (0x23) plen 13
>        Status: Success (0x00)
>        Handle: 256
>        Page: 1/2
>        Features: 0x0b 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>          Secure Simple Pairing (Host Support)
>          LE Supported (Host)
>          Secure Connections (Host Support)
>> HCI Event: Encryption Change (0x08) plen 4
>        Status: Success (0x00)
>        Handle: 256
>        Encryption: Enabled with AES-CCM (0x02)
> 
> SC disabled:
> 
>> HCI Event: Read Remote Extended Features (0x23) plen 13
>        Status: Success (0x00)
>        Handle: 256
>        Page: 1/2
>        Features: 0x03 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>          Secure Simple Pairing (Host Support)
>          LE Supported (Host)
>> HCI Event: Encryption Change (0x08) plen 4
>        Status: Success (0x00)
>        Handle: 256
>        Encryption: Enabled with E0 (0x01)
> [May 8 20:23] Bluetooth: hci0: Invalid security: expect AES but E0 was used
> < HCI Command: Disconnect (0x01|0x0006) plen 3
>        Handle: 256
>        Reason: Authentication Failure (0x05)
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> include/net/bluetooth/hci_core.h | 10 ++++++----
> net/bluetooth/hci_conn.c         | 17 +++++++++++++++++
> net/bluetooth/hci_event.c        | 20 ++++++++------------
> 3 files changed, 31 insertions(+), 16 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

