Return-Path: <SRS0=x0qO=4W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B359AC3F2CD
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Mar 2020 13:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9112B208C3
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Mar 2020 13:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgCENWW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Mar 2020 08:22:22 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:49499 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgCENWV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Mar 2020 08:22:21 -0500
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id A4A80CECEB;
        Thu,  5 Mar 2020 14:31:47 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH] Bluetooth: Make spurious error message debug
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200305131424.381031-1-szymon.janc@codecoup.pl>
Date:   Thu, 5 Mar 2020 14:22:19 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <FD181B72-2968-4B27-8FE7-03D908B4D52C@holtmann.org>
References: <20200305131424.381031-1-szymon.janc@codecoup.pl>
To:     Szymon Janc <szymon.janc@codecoup.pl>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Szymon,

> Even with rate limited reporting this is very spammy and since
> it is remote device that is providing bogus data there is no
> need to report this as error.
> 
> [72454.143336] bt_err_ratelimited: 10 callbacks suppressed
> [72454.143337] Bluetooth: hci0: advertising data len corrected
> [72454.296314] Bluetooth: hci0: advertising data len corrected
> [72454.892329] Bluetooth: hci0: advertising data len corrected
> [72455.051319] Bluetooth: hci0: advertising data len corrected
> [72455.357326] Bluetooth: hci0: advertising data len corrected
> [72455.663295] Bluetooth: hci0: advertising data len corrected
> [72455.787278] Bluetooth: hci0: advertising data len corrected
> [72455.942278] Bluetooth: hci0: advertising data len corrected
> [72456.094276] Bluetooth: hci0: advertising data len corrected
> [72456.249137] Bluetooth: hci0: advertising data len corrected
> [72459.416333] bt_err_ratelimited: 13 callbacks suppressed
> [72459.416334] Bluetooth: hci0: advertising data len corrected
> [72459.721334] Bluetooth: hci0: advertising data len corrected
> [72460.011317] Bluetooth: hci0: advertising data len corrected
> [72460.327171] Bluetooth: hci0: advertising data len corrected
> [72460.638294] Bluetooth: hci0: advertising data len corrected
> [72460.946350] Bluetooth: hci0: advertising data len corrected
> [72461.225320] Bluetooth: hci0: advertising data len corrected
> [72461.690322] Bluetooth: hci0: advertising data len corrected
> [72462.118318] Bluetooth: hci0: advertising data len corrected
> [72462.427319] Bluetooth: hci0: advertising data len corrected
> [72464.546319] bt_err_ratelimited: 7 callbacks suppressed
> [72464.546319] Bluetooth: hci0: advertising data len corrected
> [72464.857318] Bluetooth: hci0: advertising data len corrected
> [72465.163332] Bluetooth: hci0: advertising data len corrected
> [72465.278331] Bluetooth: hci0: advertising data len corrected
> [72465.432323] Bluetooth: hci0: advertising data len corrected
> [72465.891334] Bluetooth: hci0: advertising data len corrected
> [72466.045334] Bluetooth: hci0: advertising data len corrected
> [72466.197321] Bluetooth: hci0: advertising data len corrected
> [72466.340318] Bluetooth: hci0: advertising data len corrected
> [72466.498335] Bluetooth: hci0: advertising data len corrected
> [72469.803299] bt_err_ratelimited: 10 callbacks suppressed
> 
> Signed-off-by: Szymon Janc <szymon.janc@codecoup.pl>
> ---
> net/bluetooth/hci_event.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index a40ed31f6eb8..c69267f1951e 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -5277,7 +5277,8 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
> 
> 	/* Adjust for actual length */
> 	if (len != real_len) {
> -		bt_dev_err_ratelimited(hdev, "advertising data len corrected");
> +		BT_DBG("%s: advertising data len corrected (%u->%u)",
> +		       hdev->name, len, real_len);

can we use bt_dev_dbg please.

Regards

Marcel

