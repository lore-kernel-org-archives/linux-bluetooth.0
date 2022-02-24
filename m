Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D87DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Feb 2022 13:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbiBXNnO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Feb 2022 08:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbiBXNnN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Feb 2022 08:43:13 -0500
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E527D154732
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Feb 2022 05:42:43 -0800 (PST)
Received: from smtpclient.apple (p4fefc101.dip0.t-ipconnect.de [79.239.193.1])
        by mail.holtmann.org (Postfix) with ESMTPSA id 19AB7CED12;
        Thu, 24 Feb 2022 14:42:43 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [RFC] Bluetooth: SCO: Fix codec when using
 HCI_Enhanced_Setup_Synchronous_Connection
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220222212227.24515-1-luiz.dentz@gmail.com>
Date:   Thu, 24 Feb 2022 14:42:42 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <064E5D28-C0AB-4ADA-883B-E9AB90067E4A@holtmann.org>
References: <20220222212227.24515-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This makes sure BT_CODEC_MSBC is used by default if socket user attempt
> to use BT_VOICE_TRANSPARENT.
> 
> Fixes: b2af264ad3af ("Bluetooth: Add support for HCI_Enhanced_Setup_Synchronous_Connection command")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> net/bluetooth/sco.c | 12 +++---------
> 1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index 8eabf41b2993..b35c772efc7e 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -879,15 +879,9 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
> 		}
> 
> 		sco_pi(sk)->setting = voice.setting;
> -		hdev = hci_get_route(&sco_pi(sk)->dst, &sco_pi(sk)->src,
> -				     BDADDR_BREDR);
> -		if (!hdev) {
> -			err = -EBADFD;
> -			break;
> -		}
> -		if (enhanced_sco_capable(hdev) &&
> -		    voice.setting == BT_VOICE_TRANSPARENT)
> -			sco_pi(sk)->codec.id = BT_CODEC_TRANSPARENT;
> +		if (voice.setting == BT_VOICE_TRANSPARENT)
> +			sco_pi(sk)->codec.id = BT_CODEC_MSBC;
> +
> 		hci_dev_put(hdev);
> 		break;

why are you removing the rest and especially the eSCO check?

Regards

Marcel

