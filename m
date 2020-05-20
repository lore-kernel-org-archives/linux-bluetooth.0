Return-Path: <SRS0=JpWv=7C=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C00DC433E2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 May 2020 14:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 852C3205CB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 May 2020 14:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgETOZj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 May 2020 10:25:39 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:48852 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgETOZj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 May 2020 10:25:39 -0400
Received: from marcel-macbook.fritz.box (p4fefc5a7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 4A254CED09;
        Wed, 20 May 2020 16:35:21 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 3/4] Bluetooth: Fix bogus check for re-auth no supported
 with non-ssp
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200519202519.219335-3-luiz.dentz@gmail.com>
Date:   Wed, 20 May 2020 16:25:37 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <6C0E3EC4-853B-4736-8611-47B895BEE3D0@holtmann.org>
References: <20200519202519.219335-1-luiz.dentz@gmail.com>
 <20200519202519.219335-3-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This reverts 19f8def031bfa50c579149b200bfeeb919727b27
> "Bluetooth: Fix auth_complete_evt for legacy units" which seems to be
> working around a bug on a broken controller rather then any limitation
> imposed by the Bluetooth spec, in fact if there ws not possible to
> re-auth the command shall fail not succeed.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> net/bluetooth/hci_event.c | 10 ++--------
> 1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index dc1cc3c4348c..8c9051ffa665 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -2869,14 +2869,8 @@ static void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
> 
> 	if (!ev->status) {
> 		clear_bit(HCI_CONN_AUTH_FAILURE, &conn->flags);
> -
> -		if (!hci_conn_ssp_enabled(conn) &&
> -		    test_bit(HCI_CONN_REAUTH_PEND, &conn->flags)) {
> -			bt_dev_info(hdev, "re-auth of legacy device is not possible.");
> -		} else {
> -			set_bit(HCI_CONN_AUTH, &conn->flags);
> -			conn->sec_level = conn->pending_sec_level;
> -		}
> +		set_bit(HCI_CONN_AUTH, &conn->flags);
> +		conn->sec_level = conn->pending_sec_level;
> 	} else {
> 		if (ev->status == HCI_ERROR_PIN_OR_KEY_MISSING)
> 			set_bit(HCI_CONN_AUTH_FAILURE, &conn->flags);

wouldn’t we now also remove HCI_CONN_REAUTH_PEND flag?

Regards

Marcel

