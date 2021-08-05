Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52D9C4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 13:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A701061154
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 13:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240012AbhHENSe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Aug 2021 09:18:34 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:54431 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbhHENSd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Aug 2021 09:18:33 -0400
Received: from smtpclient.apple (p5b3d23f8.dip0.t-ipconnect.de [91.61.35.248])
        by mail.holtmann.org (Postfix) with ESMTPSA id 3D855CECF1;
        Thu,  5 Aug 2021 15:18:18 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH 1/1] Bluetooth: btusb: Fix fall-through warnings
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210805024012.18022-1-mark-yw.chen@mediatek.com>
Date:   Thu, 5 Aug 2021 15:18:17 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, tedd.an@linux.intel.com,
        chris.lu@mediatek.com, will-cy.lee@mediatek.com,
        sean.wang@mediatek.com, linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        michaelfsun@google.com, shawnku@google.com, jemele@google.com,
        apusaka@google.com, mcchou@chromium.org
Content-Transfer-Encoding: 8BIT
Message-Id: <D3F62378-3C5A-4CED-9EC4-6694752047D6@holtmann.org>
References: <20210805024012.18022-1-mark-yw.chen@mediatek.com>
To:     =?utf-8?B?Ik1hcmstWVcgQ2hlbiAo6Zmz5o+a5paHKSI=?= 
        <Mark-YW.Chen@mediatek.com>
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
> drivers/bluetooth/btusb.c | 2 ++
> 1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index a4cee8327295..89ff9182b7e2 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -4027,7 +4027,9 @@ static int btusb_recv_acl_mtk(struct hci_dev *hdev, struct sk_buff *skb)
> 		 * suspend and thus disable auto-suspend.
> 		 */
> 		usb_disable_autosuspend(data->udev);
> +		fallthrough;
> 	case 0x05ff:		/* Firmware debug logging 1 */
> +		fallthrough;

this one is not needed.


> 	case 0x05fe:		/* Firmware debug logging 2 */
> 		return hci_recv_diag(hdev, skb);
> 	}

Regards

Marcel

