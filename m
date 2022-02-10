Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1115DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Feb 2022 23:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244876AbiBJX5F (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Feb 2022 18:57:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243325AbiBJX5E (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Feb 2022 18:57:04 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA025F7D
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Feb 2022 15:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644537424; x=1676073424;
  h=message-id:subject:from:to:date:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=D0KlA15nFsknitjKhZPyWgU2/kQ1B6vwluQDe5GKLIc=;
  b=oG1PJKZABUumY8lVxHW5v4wzfj9ruhVVtCrIdMSoU37ptUNDnoV2/YZl
   HBHSfO+sc7FJKSM4tQzqD+ro8d6a48+BgOAWGoqapytuJ5xAnBfuQ0md2
   Mqw3F+yYOTEtek5zD7vv7clbDGVWVEqKCYeJYxwP9umoHMLWzeEWsBMDT
   sFRXIGjkW8KiKkTWRDeV+tkFtBOkYtu+lcrvvVB3KiveTKD/v9u3FhJzI
   bbGuYl2Q5WneYnAxazqaKzL+d+bWbmDbDBJsKWO93/YMG+lYOMEU+f4Bm
   Ulk667mAYt6dOdhKSyaRAZ7RNnQ4L2w46aqIA8+4NCCWFexXjTraAiZA1
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="249371302"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="249371302"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 15:57:04 -0800
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="486024523"
Received: from dtamondo-mobl.amr.corp.intel.com (HELO [10.212.170.152]) ([10.212.170.152])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 15:57:04 -0800
Message-ID: <121567b781f15898ae71109c96f3c8b7fa740e9c.camel@linux.intel.com>
Subject: Re: [BlueZ PATCH v2] device: Fix crash when removing device
From:   Tedd Ho-Jeong An <tedd.an@linux.intel.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Date:   Thu, 10 Feb 2022 15:56:57 -0800
In-Reply-To: <20220210225552.573320-1-luiz.dentz@gmail.com>
References: <20220210225552.573320-1-luiz.dentz@gmail.com>
Organization: Intel Corporation
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, 2022-02-10 at 14:55 -0800, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Calling btd_adapter_remove_device from device_remove_connection can
> cause a crash, so instead of removing it immediatelly this set a the
> temporary timeout to 0.
> 
> Fixes: https://github.com/bluez/bluez/issues/290

Tested-by: Tedd Ho-Jeong AN <tedd.an@intel.com>

> ---
> v2: Fix compilation
> 
>  src/device.c | 46 +++++++++++++++++++++++-----------------------
>  1 file changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/src/device.c b/src/device.c
> index 6d29eb896..81b8ebd1e 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -3200,6 +3200,28 @@ void device_add_connection(struct btd_device *dev, uint8_t bdaddr_type)
>                                                                 "Connected");
>  }
>  
> +static bool device_disappeared(gpointer user_data)
> +{
> +       struct btd_device *dev = user_data;
> +
> +       dev->temporary_timer = 0;
> +
> +       btd_adapter_remove_device(dev->adapter, dev);
> +
> +       return FALSE;
> +}
> +
> +static void set_temporary_timer(struct btd_device *dev, unsigned int timeout)
> +{
> +       clear_temporary_timer(dev);
> +
> +       if (!timeout)
> +               return;
> +
> +       dev->temporary_timer = timeout_add_seconds(timeout, device_disappeared,
> +                                                               dev, NULL);
> +}
> +
>  void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
>  {
>         struct bearer_state *state = get_state(device, bdaddr_type);
> @@ -3285,7 +3307,7 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
>                                                 DEVICE_INTERFACE, "Connected");
>  
>         if (remove_device)
> -               btd_adapter_remove_device(device->adapter, device);
> +               set_temporary_timer(device, 0);
>  }
>  
>  guint device_add_disconnect_watch(struct btd_device *device,
> @@ -4590,28 +4612,6 @@ void device_set_le_support(struct btd_device *device, uint8_t bdaddr_type)
>         store_device_info(device);
>  }
>  
> -static bool device_disappeared(gpointer user_data)
> -{
> -       struct btd_device *dev = user_data;
> -
> -       dev->temporary_timer = 0;
> -
> -       btd_adapter_remove_device(dev->adapter, dev);
> -
> -       return FALSE;
> -}
> -
> -static void set_temporary_timer(struct btd_device *dev, unsigned int timeout)
> -{
> -       clear_temporary_timer(dev);
> -
> -       if (!timeout)
> -               return;
> -
> -       dev->temporary_timer = timeout_add_seconds(timeout, device_disappeared,
> -                                                               dev, NULL);
> -}
> -
>  void device_update_last_seen(struct btd_device *device, uint8_t bdaddr_type)
>  {
>         if (bdaddr_type == BDADDR_BREDR)


