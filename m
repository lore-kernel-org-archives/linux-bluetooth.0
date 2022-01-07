Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B65AC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jan 2022 07:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbiAGHa3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Jan 2022 02:30:29 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:55434 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbiAGHa3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Jan 2022 02:30:29 -0500
Received: from smtpclient.apple (p4fefca45.dip0.t-ipconnect.de [79.239.202.69])
        by mail.holtmann.org (Postfix) with ESMTPSA id 11808CECE8;
        Fri,  7 Jan 2022 08:30:28 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH] Bluetooth: btintel: Fix broken LED quirk for legacy ROM
 devices
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220107003454.315475-1-hj.tedd.an@gmail.com>
Date:   Fri, 7 Jan 2022 08:30:27 +0100
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Tedd Ho-Jeong An <tedd.an@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <758313D7-B953-4334-AFC9-5423E5D634FB@holtmann.org>
References: <20220107003454.315475-1-hj.tedd.an@gmail.com>
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

> This patch fixes the broken LED quirk for Intel legacy ROM devices.
> To fix the LED issue that doesn't turn off immediately, the host sends
> the SW RFKILL command while shutting down the interface and it puts the
> devices in SW RFKILL state.
> 
> Once the device is in SW RFKILL state, it can only accept HCI_Reset to
> exit from the SW RFKILL state. This patch checks the quirk for broken
> LED and sends the HCI_Reset before sending the HCI_Intel_Read_Version
> command.
> 
> The affected legacy ROM devices are
> - 8087:07dc
> - 8087:0a2a
> - 8087:0aa7
> 
> fixes: ffcba827c0a1d ("Bluetooth: btintel: Fix the LED is not turning off immediately")
> 
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
> drivers/bluetooth/btintel.c | 20 +++++++++++---------
> drivers/bluetooth/btintel.h |  2 +-
> drivers/bluetooth/btusb.c   | 13 ++++++++++---
> 3 files changed, 22 insertions(+), 13 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

