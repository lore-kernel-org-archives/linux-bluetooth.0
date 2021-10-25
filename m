Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61A2C433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 11:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E04C61002
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 11:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbhJYLrC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Oct 2021 07:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbhJYLq7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Oct 2021 07:46:59 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179BCC061243
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Oct 2021 04:44:37 -0700 (PDT)
Received: from SoMainline.org (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 301AD3F35A;
        Mon, 25 Oct 2021 13:44:33 +0200 (CEST)
Date:   Mon, 25 Oct 2021 13:44:31 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: Re: [BlueZ PATCH] src/device: Fix glib assertion
Message-ID: <20211025114431.zohrqmktwsqajgbd@SoMainline.org>
References: <20211022031456.373471-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022031456.373471-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On 2021-10-21 20:14:56, Tedd Ho-Jeong An wrote:
> From: Tedd Ho-Jeong An <tedd.an@intel.com>
> 
> This patch fixes the assertion by resetting the GError variable to NULL.
> 
> bluetoothd[370193]: GLib: g_file_set_contents: assertion 'error == NULL || *error == NULL' failed
> bluetoothd[370193]: ++++++++ backtrace ++++++++
> bluetoothd[370193]: #1  g_logv+0x21c (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6) [0x7f314559455c]
> bluetoothd[370193]: #2  g_log+0x93 (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6) [0x7f3145594743]
> bluetoothd[370193]: #3  g_file_set_contents+0x68 (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6) [0x7f3145577a68]
> bluetoothd[370193]: #4  store_device_info_cb+0x3b6 (src/device.c:475) [0x55be0a3591e6]
> bluetoothd[370193]: #5  g_main_context_dispatch+0x14e (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6) [0x7f314558d04e]
> bluetoothd[370193]: #6  ?? (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6) [0x7f314558d400]
> bluetoothd[370193]: #7  g_main_loop_run+0x83 (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6) [0x7f314558d6f3]
> bluetoothd[370193]: #8  mainloop_run+0x19 (src/shared/mainloop-glib.c:68) [0x55be0a394149]
> bluetoothd[370193]: #9  mainloop_run_with_signal+0xf0 (src/shared/mainloop-notify.c:190) [0x55be0a3945b0]
> bluetoothd[370193]: #10 main+0xabc (src/main.c:1212) [0x55be0a2d9d9c]
> bluetoothd[370193]: #11 __libc_start_main+0xf3 (../csu/libc-start.c:342) [0x7f314521e0b3]
> bluetoothd[370193]: #12 _start+0x2e (/home/han1/work/dev/bluez/src/bluetoothd) [0x55be0a2dac7e]
> bluetoothd[370193]: +++++++++++++++++++++++++++

Is it desired to have a `Fixes: 6a154cd08 ("device: Fix unchecked return
value")` annotation for BlueZ patches, just like is done for the kernel?

> ---
>  src/device.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/src/device.c b/src/device.c
> index d5aae9576..f3cd69003 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -399,6 +399,7 @@ static gboolean store_device_info_cb(gpointer user_data)
>  		error("Unable to load key file from %s: (%s)", filename,
>  								gerr->message);
>  		g_error_free(gerr);
> +		gerr = NULL;

You should also correct all the other g_error_free paths that were
introduced recently, whenever this gerr pointer is reused.  I'm running
into this assertion in quite a few places such as update_bredr_services.

Note that Luiz fixed this in a different way for store_device_info_cb in
8b6b9b775 ("adapter: Fix storing IRK causing invalid read") by actually
bailing on error, instead of merely printing it and continuing.  When
those "Fix unchecked return value" patches were made, was every
call-site evaluated to need a return instead of continuing?  That's the
intended action of those coverity warnings, not just printing them for
the sake of it.

I would have sent patches to correct this, but as shown in Luiz' patch
linked above the desired error-handling behaviour will differ per
calling-site.  As far as I'm aware some of these errors such as the key
file not yet existing are normal, but invalid file contents are not
(hence why a create_file seems to be performed instead of allowing all
errors through).  This also seems to be the desired solution for
update_bredr_services.

Who's responsible for going through all the `Fix unchecked return value`
patches and cleaning up their error-handling properly akin to 8b6b9b775?

>  	}
>  
>  	g_key_file_set_string(key_file, "General", "Name", device->name);
> -- 
> 2.25.1
> 

- Marijn
