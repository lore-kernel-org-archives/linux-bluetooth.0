Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFBFC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Jan 2022 07:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiAMHFC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Jan 2022 02:05:02 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:39367 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiAMHFC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Jan 2022 02:05:02 -0500
Received: from smtpclient.apple (p4fefca45.dip0.t-ipconnect.de [79.239.202.69])
        by mail.holtmann.org (Postfix) with ESMTPSA id BADDFCECF2;
        Thu, 13 Jan 2022 08:05:00 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [Bluez PATCH] device: Fix device can't be scanned for 5 mins
 after reboot
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220113141533.Bluez.1.Iad485a29772515142eefb1b120d5eb5e101d82f6@changeid>
Date:   Thu, 13 Jan 2022 08:05:00 +0100
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Shuo-Peng Liao <deanliao@chromium.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <2413B80E-E93D-49F1-849D-BAA899BAF832@holtmann.org>
References: <20220113141533.Bluez.1.Iad485a29772515142eefb1b120d5eb5e101d82f6@changeid>
To:     Archie Pusaka <apusaka@google.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

> After the patches which limit the attempts of doing remote name
> resolving, there's an issue which prevents BlueZ to RNR new devices
> for 5 minutes after reboot. It's caused by failed_time is init to 0,
> and is then treated as the timestamp when the device failed RNR.
> However, actually there is no failure yet.
> 
> This CL fixes it by always allowing RNR when failed_time = 0.
> 
> Reviewed-by: Shuo-Peng Liao <deanliao@chromium.org>
> ---
> 
> src/device.c | 11 ++++++++---
> 1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/src/device.c b/src/device.c
> index f2447c478e..16b1ed5bd3 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -4487,10 +4487,15 @@ bool device_is_name_resolve_allowed(struct btd_device *device)
> 
> 	clock_gettime(CLOCK_MONOTONIC, &now);
> 
> -	/* If now < failed_time, it means the clock has somehow turned back,
> -	 * possibly because of system restart. Allow name request in this case.
> +	/* Allow name request for any of these cases:
> +	 * (1) failed_time is empty (0). Meaning no prior failure.
> +	 * (2) now < failed_time. Meaning the clock has somehow turned back,
> +	 *     possibly because of system restart. Allow just to be safe.
> +	 * (3) now >= failed_time + name_request_retry_delay. Meaning the
> +	 *     period of not sending name request is over.
> 	 */
> -	return now.tv_sec < device->name_resolve_failed_time ||
> +	return device->name_resolve_failed_time == 0 ||
> +		now.tv_sec < device->name_resolve_failed_time ||
> 		now.tv_sec >= device->name_resolve_failed_time +
> 					btd_opts.name_request_retry_delay;
> }

I have the feeling this becomes complex and hard to follow. I appreciate the comment above, but just for thoughts, would it be better to do something like this:

	/* failed_time is empty (0). Meaning no prior failure. */
	if (device->name_..failed_time == 0)
		return true;

	..

	return false;

Regards

Marcel

