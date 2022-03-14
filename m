Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28627C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Mar 2022 15:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239709AbiCNPgk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Mar 2022 11:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbiCNPgj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Mar 2022 11:36:39 -0400
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F29D443C5;
        Mon, 14 Mar 2022 08:35:29 -0700 (PDT)
Received: from smtpclient.apple (p5b3d2183.dip0.t-ipconnect.de [91.61.33.131])
        by mail.holtmann.org (Postfix) with ESMTPSA id C19FACECC5;
        Mon, 14 Mar 2022 16:35:28 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH] Bluetooth: btrtl: Add support for RTL8852B
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220314065422.1446-1-max.chou@realtek.com>
Date:   Mon, 14 Mar 2022 16:35:28 +0100
Cc:     Alex Lu <alex_lu@realsil.com.cn>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, hildawu@realtek.com,
        karenhsu@realtek.com, kidman@realtek.com
Content-Transfer-Encoding: 7bit
Message-Id: <FBE41BF1-B1CA-4649-98BF-F12222996E4B@holtmann.org>
References: <20220314065422.1446-1-max.chou@realtek.com>
To:     Max Chou <max.chou@realtek.com>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Max,

> Add the support for RTL8852B BT controller on USB interface.
> The necessary firmware file will be submitted to linux-firmware.
> 
> Signed-off-by: Max Chou <max.chou@realtek.com>
> ---
> drivers/bluetooth/btrtl.c | 13 +++++++++++++
> 1 file changed, 13 insertions(+)

the patch has been applied to bluetooth-next tree.

Regards

Marcel

