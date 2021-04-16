Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E98C433ED
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Apr 2021 10:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BABE561166
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Apr 2021 10:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbhDPK47 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Apr 2021 06:56:59 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:51293 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhDPK4y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Apr 2021 06:56:54 -0400
Received: from [192.168.1.150] (unknown [78.199.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 4804224000C;
        Fri, 16 Apr 2021 10:56:26 +0000 (UTC)
Message-ID: <dcd78309d7bbbdad511e10a63eb0e73f01934e8b.camel@hadess.net>
Subject: Re: [PATCH v2 resend 2/2] iio: documentation: Document
 accelerometer label use
From:   Bastien Nocera <hadess@hadess.net>
To:     Hans de Goede <hdegoede@redhat.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Pearson <mpearson@lenovo.com>
Date:   Fri, 16 Apr 2021 12:56:26 +0200
In-Reply-To: <20210405203933.17282-3-hdegoede@redhat.com>
References: <20210405203933.17282-1-hdegoede@redhat.com>
         <20210405203933.17282-3-hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0 (3.40.0-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, 2021-04-05 at 22:39 +0200, Hans de Goede wrote:
> Some 2-in-1 laptops / convertibles with 360° (yoga-style) hinges,
> have 2 accelerometers, 1 in their base and 1 in their display.
> 
> In many cases the kernel can detect the location of each
> accelerometer
> based on e.g. information from the ACPI tables.
> 
> It is important for userspace to know the location of the 2
> accelerometers.
> Rather then adding a new sysfs-attribute for this we can relay this
> information to userspace by using standardized label strings for
> this.
> This mirrors how this is done for proximity sensors.
> 
> This commit documents 2 new standardized label strings for this
> purpose:
> "accel-base"
> "accel-display"

If we have a combined proximity and accelerometer sensor (which
wouldn't be unheard off with sensor hubs being used), how are multiple
labels, say "proximity-wifi" and "accel-base" documented?

I think that it might be worth using a separate sysfs attribute for
this, say "location" which would have "display" or "base" as a value,
and which iio-sensor-proxy could already consume.

This would also make it easier to funnel values from DeviceTree or ACPI
to udev and/or a single sysfs kernel attribute one-to-one.

Cheers

> 
> Note the "base" and "display" suffixes were chosen to match the
> values
> used for the systemd/udev hwdb.d/60-sensor.hwdb file's ACCEL_LOCATION
> property.
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Mark Pearson <mpearson@lenovo.com>
> Cc: Bastien Nocera <hadess@hadess.net>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio
> b/Documentation/ABI/testing/sysfs-bus-iio
> index 7379e40d862d..b7529bca83f5 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -72,6 +72,13 @@ Description:
>                 calculated by firmware from other sensor readings,
> rather then
>                 being a raw sensor reading.
>  
> +               For accelerometers used in 2-in-1s with 360° (yoga-
> style) hinges,
> +               which have an accelerometer in both their base and
> their display,
> +               the following standardized labels are used:
> +
> +               * "accel-base"
> +               * "accel-display"
> +
>  What:          /sys/bus/iio/devices/iio:deviceX/current_timestamp_cl
> ock
>  KernelVersion: 4.5
>  Contact:       linux-iio@vger.kernel.org


