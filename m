Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DBCC433C1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Mar 2021 17:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0467619D1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Mar 2021 17:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbhC3RQ7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Mar 2021 13:16:59 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:51485 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbhC3RQu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Mar 2021 13:16:50 -0400
X-Originating-IP: 78.199.60.242
Received: from [192.168.1.150] (unknown [78.199.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 076D1240006;
        Tue, 30 Mar 2021 17:16:48 +0000 (UTC)
Message-ID: <48cba7cf96bb9c6f5d6c95d8ab0b62ecf1b8d107.camel@hadess.net>
Subject: Re: [PATCH BlueZ] profiles/battery: Always update initial battery
 value
From:   Bastien Nocera <hadess@hadess.net>
To:     Sonny Sasaka <sonnysasaka@chromium.org>,
        linux-bluetooth@vger.kernel.org
Date:   Tue, 30 Mar 2021 19:16:48 +0200
In-Reply-To: <20210330170924.16983-1-sonnysasaka@chromium.org>
References: <20210330170924.16983-1-sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0 (3.40.0-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, 2021-03-30 at 10:09 -0700, Sonny Sasaka wrote:
> Due to cache in gatt db, bluetoothd fails to update publish the battery
> value after reconnection when the battery value does not change
> compared
> to before reconnection. For initial battery value, we should update the
> value to D-Bus regardless of the cache value.
> 
> ---
>  profiles/battery/battery.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/profiles/battery/battery.c b/profiles/battery/battery.c
> index 81f849d57..0f8d6ef18 100644
> --- a/profiles/battery/battery.c
> +++ b/profiles/battery/battery.c
> @@ -88,12 +88,13 @@ static void batt_reset(struct batt *batt)
>  }
>  
>  static void parse_battery_level(struct batt *batt,
> -                               const uint8_t *value)
> +                               const uint8_t *value,
> +                               bool force_update)
>  {
>         uint8_t percentage;
>  
>         percentage = value[0];
> -       if (batt->percentage != percentage) {
> +       if (force_update || batt->percentage != percentage) {
>                 batt->percentage = percentage;
>                 DBG("Battery Level updated: %d%%", percentage);
>                 if (!batt->battery) {
> @@ -110,7 +111,7 @@ static void batt_io_value_cb(uint16_t value_handle,
> const uint8_t *value,
>         struct batt *batt = user_data;
>  
>         if (value_handle == batt->batt_level_io_handle) {
> -               parse_battery_level(batt, value);
> +               parse_battery_level(batt, value, false /* force_update
> */);
>         } else {
>                 g_assert_not_reached();
>         }
> @@ -134,7 +135,7 @@ static void batt_io_ccc_written_cb(uint16_t
> att_ecode, void *user_data)
>                 return;
>         }
>  
> -       parse_battery_level(batt, batt->initial_value);
> +       parse_battery_level(batt, batt->initial_value, true /*
> force_update */);

If you need to do this, that means that you should probably declare an
enum instead.

This is old, but still relevant:
https://blog.ometer.com/2011/01/20/boolean-parameters-are-wrong/

>         g_free (batt->initial_value);
>         batt->initial_value = NULL;
>  


