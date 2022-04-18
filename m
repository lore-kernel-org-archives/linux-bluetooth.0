Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA90C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Apr 2022 23:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236013AbiDSACI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Apr 2022 20:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235925AbiDSACG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Apr 2022 20:02:06 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D923029CA7
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Apr 2022 16:59:24 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id r8so16465112oib.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Apr 2022 16:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XNhEj6yQXEf8EzMPjLuIxRDR2ydDTYwBFv9bpimUglk=;
        b=MDQfJBj3MEAwUtq9QPREFz1h5XcDDQxVdPXL7/gPb2EQ0qQIhru6P3j80J1EeIQlc4
         EJWvoVtch7OJ6DdV8f6agPKFixuk7KchoZzPrcLw0ifRKZDYHdZDGE2aruWc5BEYelJB
         w0DkNzPa5Ez7ZQuHmAjtBlNIYd/68+T6BkTd6K2Xe7A3wcdKdB/GDygT485lbaa8azq/
         KJkUhjI8yXCKFvpDy6V550MqC30zGvhYRtAMijL1TObfPfERrYxEhLBom5RmQvfM7gyg
         o0gRUOzNLw7wLSrETBOrjGwv/atnXiBHxsFyAUMkO/nQZ2k2+49JqSCxOVGHwZKcES0b
         QjPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XNhEj6yQXEf8EzMPjLuIxRDR2ydDTYwBFv9bpimUglk=;
        b=rqeekKTp2uVjiNGAUQVdBS/vSrGjLLUgnJkCoBfSSmB7Q/h+hD5ISNW/O4+i6e5vIu
         cYALYWuyrW3v+w0l1F1sv45wBcTCGwfQKUe6UoN+Q8ESxwVw5sDF4/lsYkuBAlWZFFmp
         zDiTpn/qyrsPS60O+RFNBRxyi7o68J3FbRdbqnGHUvxuE7XV4n9bfn9AQsLyqai3L91x
         nV1/5qWJ3Bxz1OKoqzRjnMBY0N+5sKtIIR86DSXkffo9E/YBkLuHqGoW6Qp/9i0HrRnI
         rU44d2NKcuu1dpAoDMZE0AXTeueHiV6gB8nxrv+Dw6CAFAuNBTuDUM8mryZEDbDEh7Qr
         PDFQ==
X-Gm-Message-State: AOAM531rfU/aSyEB8fXT2S8xbp4ZRo5i053ax4LvPGHefB8DeiomCXAe
        USui8bAi3Jk4c9K5VHRRL+fd0NJGbLei5lVxPiPxr/CJ
X-Google-Smtp-Source: ABdhPJw//kRSfXcMTeL0WQSkqzdBOPYsjktIzB8wGn6kt+rafwQF1+QwAOgGJNynZX/Gj9VPkm+sg9ZHqwRjg3KIXLw=
X-Received: by 2002:a05:6808:1115:b0:2ec:e78e:3fc0 with SMTP id
 e21-20020a056808111500b002ece78e3fc0mr8160291oih.207.1650326364134; Mon, 18
 Apr 2022 16:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220418174929.2777339-1-jiangzp@google.com> <20220418174914.Bluez.v2.2.I29a0e38364a8d5854342019b607fa049c74248a3@changeid>
In-Reply-To: <20220418174914.Bluez.v2.2.I29a0e38364a8d5854342019b607fa049c74248a3@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 18 Apr 2022 16:59:12 -0700
Message-ID: <CABBYNZLREYcfJuPmw9ZT_Pe6dXgF4FCBe8vU4pigsb7gd7UzbA@mail.gmail.com>
Subject: Re: [Bluez PATCH v2 2/2] client: Add bonded-devices and show Bonded
 flag in info
To:     Zhengping Jiang <jiangzp@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Yun-Hao Chung <howardchung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Zhengping,

On Mon, Apr 18, 2022 at 10:49 AM Zhengping Jiang <jiangzp@google.com> wrote:
>
> Add "bonded-devices" to the menu and show the "Bonded" property for
> command "info".
>
> Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
> Reviewed-by: Yun-Hao Chung <howardchung@chromium.org>
>
> Signed-off-by: Zhengping Jiang <jiangzp@google.com>
> ---
>
> (no changes since v1)
>
> Changes in v1:
> - Show the status of the "Bonded" flag in bluetoothctl
> - Add option to show list of bonded devices
>
>  client/main.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/client/main.c b/client/main.c
> index 589268c3a68c..45c89a1de37b 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -1090,6 +1090,32 @@ static void cmd_paired_devices(int argc, char *argv[])
>         return bt_shell_noninteractive_quit(EXIT_SUCCESS);
>  }
>
> +static void cmd_bonded_devices(int argc, char *argv[])
> +{
> +       GList *ll;
> +
> +       if (check_default_ctrl() == FALSE)
> +               return bt_shell_noninteractive_quit(EXIT_SUCCESS);
> +
> +       for (ll = g_list_first(default_ctrl->devices);
> +                       ll; ll = g_list_next(ll)) {
> +               GDBusProxy *proxy = ll->data;
> +               DBusMessageIter iter;
> +               dbus_bool_t bonded;
> +
> +               if (g_dbus_proxy_get_property(proxy, "Bonded", &iter) == FALSE)
> +                       continue;
> +
> +               dbus_message_iter_get_basic(&iter, &bonded);
> +               if (!bonded)
> +                       continue;
> +
> +               print_device(proxy, NULL);
> +       }
> +
> +       return bt_shell_noninteractive_quit(EXIT_SUCCESS);
> +}
> +
>  static void generic_callback(const DBusError *error, void *user_data)
>  {
>         char *str = user_data;
> @@ -1781,6 +1807,7 @@ static void cmd_info(int argc, char *argv[])
>         print_property(proxy, "Appearance");
>         print_property(proxy, "Icon");
>         print_property(proxy, "Paired");
> +       print_property(proxy, "Bonded");
>         print_property(proxy, "Trusted");
>         print_property(proxy, "Blocked");
>         print_property(proxy, "Connected");
> @@ -3116,6 +3143,8 @@ static const struct bt_shell_menu main_menu = {
>         { "devices",      NULL,       cmd_devices, "List available devices" },
>         { "paired-devices", NULL,     cmd_paired_devices,
>                                         "List paired devices"},
> +       { "bonded-devices", NULL,     cmd_bonded_devices,
> +                                       "List bonded devices"},

I would have done it a little be different, make devices command
create different lists:

bluetoothctl> devices [Trusted/Paired/Bonded/Connected]
Device XX:... Name (Trusted, Paired, Bonded...)
...

That way we don't have to create a command for each possible device filter.


>         { "system-alias", "<name>",   cmd_system_alias,
>                                         "Set controller alias" },
>         { "reset-alias",  NULL,       cmd_reset_alias,
> --
> 2.36.0.rc0.470.gd361397f0d-goog
>


-- 
Luiz Augusto von Dentz
