Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31AE2C64E7B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Dec 2020 16:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C70CB206A5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Dec 2020 16:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgLAQ0E (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Dec 2020 11:26:04 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:57179 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgLAQ0D (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Dec 2020 11:26:03 -0500
X-Originating-IP: 82.255.60.242
Received: from [192.168.0.28] (lns-bzn-39-82-255-60-242.adsl.proxad.net [82.255.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 52CC140004;
        Tue,  1 Dec 2020 16:25:21 +0000 (UTC)
Message-ID: <e82cef2e672e9b7f413341264f82d90c3c268cf3.camel@hadess.net>
Subject: Re: [PATCH BlueZ v5 4/7] doc: Add Battery Provider API doc
From:   Bastien Nocera <hadess@hadess.net>
To:     Sonny Sasaka <sonnysasaka@chromium.org>,
        linux-bluetooth@vger.kernel.org
Cc:     Miao-chen Chou <mcchou@chromium.org>
Date:   Tue, 01 Dec 2020 17:25:20 +0100
In-Reply-To: <20201130215602.386545-4-sonnysasaka@chromium.org>
References: <20201130215602.386545-1-sonnysasaka@chromium.org>
         <20201130215602.386545-4-sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, 2020-11-30 at 13:55 -0800, Sonny Sasaka wrote:
> This patch add the documentation of the Battery Provider which lets
> external clients feed battery information to BlueZ if they are able
> to
> decode battery reporting via any profile. BlueZ UI clients can then
> use
> the org.bluez.Battery1 API as a single source of battery information
> coming from many different profiles.
> 
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> 
> ---
>  doc/battery-api.txt | 55
> +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/doc/battery-api.txt b/doc/battery-api.txt
> index dc7dbeda2..9a6b4fd39 100644
> --- a/doc/battery-api.txt
> +++ b/doc/battery-api.txt
> @@ -12,3 +12,58 @@ Object path  [variable
> prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
>  Properties     byte Percentage [readonly]
>  
>                         The percentage of battery left as an unsigned
> 8-bit integer.
> +
> +               string Source [readonly, optional, experimental]
> +
> +                       Describes where the battery information comes
> from
> +                       This property is informational only and may
> be useful
> +                       for debugging purposes.
> +                       Providers from BatteryProvider1 may make use
> of this
> +                       property to indicate where the battery report
> comes from
> +                       (e.g. "HFP 1.7", "HID", or the profile UUID).
> +
> +
> +Battery Provider Manager hierarchy
> +==================================
> +A battery provider starts by registering itself as a battery
> provider with the
> +RegisterBatteryProvider method passing an object path as the
> provider ID. Then,
> +it can start exposing org.bluez.BatteryProvider1 objects having the
> path
> +starting with the given provider ID. It can also remove objects at
> any time.
> +The objects and their properties exposed by battery providers will
> be reflected
> +on org.bluez.Battery1 interface.
> +
> +BlueZ will stop monitoring these exposed and removed objects after
> +UnregisterBatteryProvider is called for that provider ID.
> +
> +Service                org.bluez
> +Interface      org.bluez.BatteryProviderManager1 [experimental]
> +Object path    /org/bluez/{hci0,hci1,...}
> +
> +Methods                void RegisterBatteryProvider(object provider)
> +
> +                       This registers a battery provider. A
> registered
> +                       battery provider can then expose objects with
> +                       org.bluez.BatteryProvider1 interface
> described below.
> +
> +               void UnregisterBatteryProvider(object provider)
> +
> +                       This unregisters a battery provider. After
> +                       unregistration, the BatteryProvider1 objects
> provided
> +                       by this client are ignored by BlueZ.
> +
> +
> +Battery Provider hierarchy
> +==========================
> +
> +Service                <client D-Bus address>
> +Interface      org.bluez.BatteryProvider1 [experimental]
> +Object path    {provider_root}/{unique battery object path}
> +
> +Properties     Objects provided on this interface contain the same properties
> +               as org.bluez.Battery1 interface. Additionally, this interface
> +               needs to have the Device property indicating the object path
> +               of the device this battery provides.

"this interface needs to have a Device property indicating the object
path this battery information pertains to."
or
"this interface needs to have a Device property indicating the object
path the battery information is provided for."

> +
> +               object Device [readonly]
> +
> +                       The object path of the device that has this
> battery.


