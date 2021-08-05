Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDFBC4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 13:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 277376113B
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 13:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241641AbhHENNF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Aug 2021 09:13:05 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:60318 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241639AbhHENNF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Aug 2021 09:13:05 -0400
Received: from smtpclient.apple (p5b3d23f8.dip0.t-ipconnect.de [91.61.35.248])
        by mail.holtmann.org (Postfix) with ESMTPSA id 4EC50CECF0;
        Thu,  5 Aug 2021 15:12:49 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v5 1/2] Bluetooth: btusb: Record debug log for Mediatek
 Chip.
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <4e9d536cb6a7cffb829f105183f2bb5bceb4122c.camel@linux.intel.com>
Date:   Thu, 5 Aug 2021 15:12:48 +0200
Cc:     Mark-YW.Chen@mediatek.com, Johan Hedberg <johan.hedberg@gmail.com>,
        chris.lu@mediatek.com, will-cy.lee@mediatek.com,
        Sean Wang <sean.wang@mediatek.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        Michael Sun <michaelfsun@google.com>, shawnku@google.com,
        jemele@google.com, Archie Pusaka <apusaka@google.com>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <22F94464-EF65-4676-AC61-1E13E22A837F@holtmann.org>
References: <20210804090316.12080-1-mark-yw.chen@mediatek.com>
 <8988B918-95FD-42DE-95FA-3BAC4A144165@holtmann.org>
 <4e9d536cb6a7cffb829f105183f2bb5bceb4122c.camel@linux.intel.com>
To:     Tedd Ho-Jeong An <tedd.an@linux.intel.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

> I cannot find the original patch email and CI report, however this patch throws this warning.
> 
> drivers/bluetooth/btusb.c: In function ‘btusb_recv_acl_mtk’:
> drivers/bluetooth/btusb.c:4033:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
> 4033 |   usb_disable_autosuspend(data->udev);
>      |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/bluetooth/btusb.c:4034:2: note: here
> 4034 |  case 0x05ff:  /* Firmware debug logging 1 */
>      |  ^~~~

the /* fall through */ comment is missing.

Regards

Marcel

