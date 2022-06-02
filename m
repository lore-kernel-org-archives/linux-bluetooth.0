Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335A0C43334
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jun 2022 15:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236480AbiFBPkh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jun 2022 11:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbiFBPkh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jun 2022 11:40:37 -0400
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0C19279E75;
        Thu,  2 Jun 2022 08:40:35 -0700 (PDT)
Received: from smtpclient.apple (p4ff9fc30.dip0.t-ipconnect.de [79.249.252.48])
        by mail.holtmann.org (Postfix) with ESMTPSA id 0D110CED19;
        Thu,  2 Jun 2022 17:40:35 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH] iBluetooth: hci_intel: Add check for
 platform_driver_register
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220531033228.1939386-1-jiasheng@iscas.ac.cn>
Date:   Thu, 2 Jun 2022 17:40:34 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <1230E2E8-B3F7-470F-B03F-2060173B5821@holtmann.org>
References: <20220531033228.1939386-1-jiasheng@iscas.ac.cn>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
X-Mailer: Apple Mail (2.3696.100.31)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jiasheng,

> As platform_driver_register() could fail, it should be better
> to deal with the return value in order to maintain the code
> consisitency.
> 
> Fixes: 1ab1f239bf17 ("Bluetooth: hci_intel: Add support for platform driver")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
> drivers/bluetooth/hci_intel.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
> index 7249b91d9b91..d4801b26cc8e 100644
> --- a/drivers/bluetooth/hci_intel.c
> +++ b/drivers/bluetooth/hci_intel.c
> @@ -1217,7 +1217,11 @@ static struct platform_driver intel_driver = {
> 
> int __init intel_init(void)
> {
> -	platform_driver_register(&intel_driver);
> +	int ret;
> +
> +	ret = platform_driver_register(&intel_driver);
> +	if (ret)
> +		return ret;

most of the driver uses int err. So please do that as well.

Regards

Marcel

