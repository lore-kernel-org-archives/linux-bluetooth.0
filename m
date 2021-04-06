Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEA3C433B4
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Apr 2021 03:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 417D4613A0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Apr 2021 03:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239677AbhDFDIc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Apr 2021 23:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238646AbhDFDIc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Apr 2021 23:08:32 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1436DC061574
        for <linux-bluetooth@vger.kernel.org>; Mon,  5 Apr 2021 20:08:24 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 125-20020a4a1a830000b02901b6a144a417so3342262oof.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Apr 2021 20:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2L/NKKxc/QCQ+L+gM6vaooYvk4fG9nyap4uuHy5XjMA=;
        b=JVdYylND5zZ9VlKWYKmVMgNfU0QnVcfBs5bdkC8LolWWtokPONoSOgkzKAQv1Xc9Mo
         7bzUbAdpRP6C6rFg8EnsW38rwyBXxPFwvJU46aGlUDoqKNMRXzWDc+2WKuPljea9WwS5
         Gd+biLdizWtecfsZFXwN3Aiu5rSS0Y01O6PZVMa+Uwp/6iECwEOe9NEBQNIzr0U96CgJ
         TJblORXR6D8KHHxSjOTjBVTVP7lQigTPmM66/ATLYgMY0L8rFbWz8xzh7PjjUSUO33/4
         DVetlQvCk886AfrEcZ0lzNKAAcR8WREc1shy3REsPiW2NogSbVCcU4gfbfNK+ox69470
         p/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2L/NKKxc/QCQ+L+gM6vaooYvk4fG9nyap4uuHy5XjMA=;
        b=bOZ+42aiSvuo6F2eJz7QZR/q8lMg/ZKE5mrgkceHRP22eDN/kUUvpynZMKdS2n/Ndd
         dt6mZM6JmTef1Dgm6vEJjLNrZN6DK6Nxfc90JEexx9cjtZKZanzYrisE+u67NkQe9hLU
         n9F/ujoZSDFLP0Scu/mBkxU35PdJPn6bR3Gaw8Eqped9AI2gbSWPLu775/0Z+Z3//Q6H
         rgRX56EIv84op2dKkYnpIGaG2qLDVlAdnezFFFKpU5QYQhGg/0HJHEYYiwLT5I1CMl9a
         EaOm0ybZniOPLt9d7LbklcZCGwXCu8C11SwRpzvf3NxGezi0cm8nCiXahzCC/uROpF1m
         nDCA==
X-Gm-Message-State: AOAM531pSwf/mOOifqU6rbVpIIryQewJvsMggMO+XgJz2aL6oDGK/n1O
        uL46sE6+R01ClQflfwh+vN26BVlcFu/4Ijkdy4A=
X-Google-Smtp-Source: ABdhPJwutYlCYLwd8eMA3JuvJ0ZWEf4lMqnOaORUjxJa1vpGZ9WS+QgZC/258NqGXFWXUqIsXGbKx9fca2O/EZaadnA=
X-Received: by 2002:a4a:c316:: with SMTP id c22mr24956887ooq.65.1617678503412;
 Mon, 05 Apr 2021 20:08:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210405145802.27317-1-sathish.narasimman@intel.com>
In-Reply-To: <20210405145802.27317-1-sathish.narasimman@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 5 Apr 2021 20:08:13 -0700
Message-ID: <CABBYNZLTU1t=UEsvxsu8F0kP8f5-Nvi_Xysy8ftg57j9Snu99w@mail.gmail.com>
Subject: Re: [Bluez PATCH] btmgmt: Add support to enable LL privacy
To:     Sathish Narasimman <sathish.narasimman@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sathish,

On Mon, Apr 5, 2021 at 3:40 PM Sathish Narasimman
<sathish.narasimman@intel.com> wrote:
>
> If the Bluetooth controller supports LL privacy this command will be
> used to test the same.
> "sudo btmgmt power off"
> "sudo btmgmt llprivacy on"
> "sudo btmgmt power on"
>
> Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
> ---
>  tools/btmgmt.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/tools/btmgmt.c b/tools/btmgmt.c
> index 93d244ff8ec8..4a53c3768fe9 100644
> --- a/tools/btmgmt.c
> +++ b/tools/btmgmt.c
> @@ -2261,6 +2261,42 @@ static void cmd_bredr(int argc, char **argv)
>         cmd_setting(MGMT_OP_SET_BREDR, argc, argv);
>  }
>
> +static void ll_rpa_resoln_rsp(uint8_t status, uint16_t len, const void *param,
> +                             void *user_data)
> +{
> +       if (status != 0)
> +               error("Could not set LL RPA resolution with status 0x%02x (%s)",
> +                     status, mgmt_errstr(status));
> +       else
> +               print("LL RPA Resolution successfully set");
> +
> +       bt_shell_noninteractive_quit(EXIT_SUCCESS);
> +}
> +
> +static void cmd_set_ll_rpa_resoln(int argc, char **argv)
> +{
> +       /* 15c0a148-c273-11ea-b3de-0242ac130004 */
> +       static const uint8_t rpa_resolution_uuid[16] = {
> +                               0x04, 0x00, 0x13, 0xac, 0x42, 0x02, 0xde, 0xb3,
> +                               0xea, 0x11, 0x73, 0xc2, 0x48, 0xa1, 0xc0, 0x15,
> +       };
> +       struct mgmt_cp_set_exp_feature cp;
> +       uint16_t index;
> +
> +       memset(&cp, 0, sizeof(cp));
> +       memcpy(cp.uuid, rpa_resolution_uuid, 16);
> +
> +       index = mgmt_index;
> +       if (index == MGMT_INDEX_NONE)
> +               index = 0;
> +
> +       if (parse_setting(argc, argv, &cp.action) == false)
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +
> +       mgmt_send(mgmt, MGMT_OP_SET_EXP_FEATURE, index,
> +                 sizeof(cp), &cp, ll_rpa_resoln_rsp, NULL, NULL);
> +}
> +
>  static void cmd_privacy(int argc, char **argv)
>  {
>         struct mgmt_cp_set_privacy cp;
> @@ -5243,6 +5279,8 @@ static const struct bt_shell_menu main_menu = {
>                 cmd_bredr,              "Toggle BR/EDR support",        },
>         { "privacy",            "<on/off>",
>                 cmd_privacy,            "Toggle privacy support"        },
> +       { "llprivacy",          "<on/off>",
> +               cmd_set_ll_rpa_resoln,  "Toggle LL privacy support"     },

Let's have it as a parameter of privacy command <on/off/ll> so when a
user enters ll it enables link-layer privacy.

>         { "class",              "<major> <minor>",
>                 cmd_class,              "Set device major/minor class"  },
>         { "disconnect",         "[-t type] <remote address>",
> --
> 2.17.1
>


-- 
Luiz Augusto von Dentz
