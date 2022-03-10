Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA85C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Mar 2022 09:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbiCJJ6E (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Mar 2022 04:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiCJJ6C (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Mar 2022 04:58:02 -0500
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A672513C9FD;
        Thu, 10 Mar 2022 01:56:59 -0800 (PST)
Received: from smtpclient.apple (p5b3d2183.dip0.t-ipconnect.de [91.61.33.131])
        by mail.holtmann.org (Postfix) with ESMTPSA id 91A7CCECD8;
        Thu, 10 Mar 2022 10:56:58 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH v4 1/2] Bluetooth: hci_sync: Add a new quirk to skip
 HCI_FLT_CLEAR_ALL
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220307200445.5554-1-swyterzone@gmail.com>
Date:   Thu, 10 Mar 2022 10:56:58 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        hdegoede@redhat.com, pmenzel@molgen.mpg.de
Content-Transfer-Encoding: 7bit
Message-Id: <A006B33C-0A4C-4B68-B1DB-42BB8A1667D4@holtmann.org>
References: <20220307200445.5554-1-swyterzone@gmail.com>
To:     Ismael Ferreras Morezuelas <swyterzone@gmail.com>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ismael,

> Some controllers have problems with being sent a command to clear
> all filtering. While the HCI code does not unconditionally
> send a clear-all anymore at BR/EDR setup (after the state machine
> refactor), there might be more ways of hitting these codepaths
> in the future as the kernel develops.
> 
> Cc: stable@vger.kernel.org
> Cc: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Ismael Ferreras Morezuelas <swyterzone@gmail.com>
> ---
> include/net/bluetooth/hci.h | 10 ++++++++++
> net/bluetooth/hci_sync.c    | 16 ++++++++++++++++
> 2 files changed, 26 insertions(+)

both patches have been applied to bluetooth-next tree.

Regards

Marcel

