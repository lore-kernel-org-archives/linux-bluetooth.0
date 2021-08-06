Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7ABFC4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Aug 2021 12:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD35C61184
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Aug 2021 12:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343909AbhHFMuj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Aug 2021 08:50:39 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:45438 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343871AbhHFMuX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Aug 2021 08:50:23 -0400
Received: from smtpclient.apple (p5b3d23f8.dip0.t-ipconnect.de [91.61.35.248])
        by mail.holtmann.org (Postfix) with ESMTPSA id 99CEACED0D;
        Fri,  6 Aug 2021 14:50:05 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH 1/1] Bluetooth: btusb: Fix fall-through warnings
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210806013516.26148-1-mark-yw.chen@mediatek.com>
Date:   Fri, 6 Aug 2021 14:50:05 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Tedd Ho-Jeong An <tedd.an@linux.intel.com>,
        chris.lu@mediatek.com, will-cy.lee@mediatek.com,
        Sean Wang <sean.wang@mediatek.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        Michael Sun <michaelfsun@google.com>, shawnku@google.com,
        jemele@google.com, Archie Pusaka <apusaka@google.com>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <ECE92D22-1581-4B04-BD3A-19741B15449E@holtmann.org>
References: <20210806013516.26148-1-mark-yw.chen@mediatek.com>
To:     Mark-YW.Chen@mediatek.com
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Mark,

> Fix fall-through warnings:
> drivers/bluetooth/btusb.c: In function ‘btusb_recv_acl_mtk’:
> drivers/bluetooth/btusb.c:4033:3: warning:
> this statement may fall through [-Wimplicit-fallthrough=]
> 4033 |   usb_disable_autosuspend(data->udev);
>      |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/bluetooth/btusb.c:4034:2: note: here
> 4034 |  case 0x05ff:  /* Firmware debug logging 1 */
>      |  ^~~~
> 
> Signed-off-by: mark-yw.chen <mark-yw.chen@mediatek.com>
> ---
> drivers/bluetooth/btusb.c | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

