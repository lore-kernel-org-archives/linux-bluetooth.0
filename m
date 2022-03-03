Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3BBC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Mar 2022 12:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbiCCM0a convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Mar 2022 07:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbiCCM03 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Mar 2022 07:26:29 -0500
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2DD3FF1186
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Mar 2022 04:25:44 -0800 (PST)
Received: from smtpclient.apple (p5b3d2910.dip0.t-ipconnect.de [91.61.41.16])
        by mail.holtmann.org (Postfix) with ESMTPSA id 344D7CED23;
        Thu,  3 Mar 2022 13:25:43 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH] Bluetooth: Fix not checking for valid hdev on
 bt_dev_{info,warn,err,dbg}
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220302230858.444141-1-luiz.dentz@gmail.com>
Date:   Thu, 3 Mar 2022 13:25:42 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <EB0E0318-A08B-4FCC-8906-C12A649909E9@holtmann.org>
References: <20220302230858.444141-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This fixes attemting to print hdev->name directly which causes them to
> print an error:
> 
> kernel: read_version:367: (efault): sock 000000006a3008f2
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> include/net/bluetooth/bluetooth.h | 14 ++++++++------
> 1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index a647e5fabdbd..d82736e58d45 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -204,19 +204,21 @@ void bt_err_ratelimited(const char *fmt, ...);
> #define BT_DBG(fmt, ...)	pr_debug(fmt "\n", ##__VA_ARGS__)
> #endif
> 
> +#define bt_dev_name(hdev) (hdev ? (hdev)->name : NULL)
> +

use ((hdev) ? (hdev)->name : “null”)

> #define bt_dev_info(hdev, fmt, ...)				\
> -	BT_INFO("%s: " fmt, (hdev)->name, ##__VA_ARGS__)
> +	BT_INFO("%s: " fmt, bt_dev_name(hdev), ##__VA_ARGS__)
> #define bt_dev_warn(hdev, fmt, ...)				\
> -	BT_WARN("%s: " fmt, (hdev)->name, ##__VA_ARGS__)
> +	BT_WARN("%s: " fmt, bt_dev_name(hdev), ##__VA_ARGS__)
> #define bt_dev_err(hdev, fmt, ...)				\
> -	BT_ERR("%s: " fmt, (hdev)->name, ##__VA_ARGS__)
> +	BT_ERR("%s: " fmt, bt_dev_name(hdev), ##__VA_ARGS__)
> #define bt_dev_dbg(hdev, fmt, ...)				\
> -	BT_DBG("%s: " fmt, (hdev)->name, ##__VA_ARGS__)
> +	BT_DBG("%s: " fmt, bt_dev_name(hdev), ##__VA_ARGS__)
> 
> #define bt_dev_warn_ratelimited(hdev, fmt, ...)			\
> -	bt_warn_ratelimited("%s: " fmt, (hdev)->name, ##__VA_ARGS__)
> +	bt_warn_ratelimited("%s: " fmt, bt_dev_name(hdev), ##__VA_ARGS__)
> #define bt_dev_err_ratelimited(hdev, fmt, ...)			\
> -	bt_err_ratelimited("%s: " fmt, (hdev)->name, ##__VA_ARGS__)
> +	bt_err_ratelimited("%s: " fmt, bt_dev_name(hdev), ##__VA_ARGS__)

Regards

Marcel

