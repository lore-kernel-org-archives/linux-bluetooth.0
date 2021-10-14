Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED012C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Oct 2021 12:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C44D7610CB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Oct 2021 12:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbhJNMmG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Oct 2021 08:42:06 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:40912 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhJNMmG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Oct 2021 08:42:06 -0400
Received: from smtpclient.apple (p4ff9f2d2.dip0.t-ipconnect.de [79.249.242.210])
        by mail.holtmann.org (Postfix) with ESMTPSA id 46198CED0E;
        Thu, 14 Oct 2021 14:39:58 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v3] Bluetooth: vhci: Add support for setting msft_opcode
 and aosp_capable
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211013221701.2826793-1-luiz.dentz@gmail.com>
Date:   Thu, 14 Oct 2021 14:39:57 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <ABE43C65-BA9A-43C0-8A59-CF26A0A106D0@holtmann.org>
References: <20211013221701.2826793-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This adds a debugfs entries to set msft_opcode and aosp_capable enabling
> vhci to emulate controllers with MSFT/AOSP extension support.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> v2: Fix typos: s/extention/extension/g
> v3: Remove checks for HCI_SETUP, merge changes to introduce MSFT/AOSP support
> at the same time.
> 
> drivers/bluetooth/hci_vhci.c | 92 ++++++++++++++++++++++++++++++++++++
> 1 file changed, 92 insertions(+)

patch has been applied to bluetooth-next tree (with slight modifications).

Regards

Marcel

