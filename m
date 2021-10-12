Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AD8C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Oct 2021 15:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B42DC61076
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Oct 2021 15:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237584AbhJLPnn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Oct 2021 11:43:43 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:58997 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237707AbhJLPnd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Oct 2021 11:43:33 -0400
Received: from smtpclient.apple (p4fefcb73.dip0.t-ipconnect.de [79.239.203.115])
        by mail.holtmann.org (Postfix) with ESMTPSA id 36F4FCECE2;
        Tue, 12 Oct 2021 17:41:30 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH] Bluetooth: btrtl: Ask ic_info to drop firmware
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <8fc481a872474919b2a53fc2c7072166@realtek.com>
Date:   Tue, 12 Oct 2021 17:41:29 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kai.heng.feng@canonical.com" <kai.heng.feng@canonical.com>,
        "apusaka@chromium.org" <apusaka@chromium.org>,
        Max Chou <max.chou@realtek.com>,
        "alex_lu@realsil.com.cn" <alex_lu@realsil.com.cn>,
        KidmanLee <kidman@realtek.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <DEFB4160-D88E-447C-8B19-DB9DBFC9869A@holtmann.org>
References: <20210930103634.1710-1-hildawu@realtek.com>
 <D5B18E08-AE60-4B8B-960B-694D62E067B5@holtmann.org>
 <912f4b6441b54a1d89df6ffe4a0511ab@realtek.com>
 <065AC802-1C20-42F0-9B2F-24F2B2698B90@holtmann.org>
 <8fc481a872474919b2a53fc2c7072166@realtek.com>
To:     Hilda Wu <hildawu@realtek.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Hilda,

> I'm a little confused about this.
> Did you mean that if use existing MSFT/AOSP extensions vendor cmd/event to check device has this feature.
> This way is not meeting your conception, a simple way to tell which RTL device supports the MSFT or AOSP extensions?

issuing a HCI command and checking HCI command not supported error is not a good design. The Bluetooth Core spec doesn’t use that kind of design. It has supported features and supported commands. And so should any vendor extension.

Regards

Marcel

