Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B218C4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Aug 2021 22:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6413960F41
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Aug 2021 22:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbhHPWAd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Aug 2021 18:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbhHPWAc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Aug 2021 18:00:32 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12E8C061764
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Aug 2021 15:00:00 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id r4so12764484ybp.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Aug 2021 15:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JOR9C92s2UsDICtNwg7xlXmIT0xJxQ6mVkXV7t9tpME=;
        b=IQIy2In2L0qCDemP7R+U/qhPaOQRCCVxOdcZmjeimo+2f8TVAowcldDfW96ORoQ7Va
         J+e1mJFPgV7DBTlnNRmbD62KABOdbfhoHxZMMZ888zN0r682ZC4cSyiQ1CviSzIbSA7Y
         EAbdJ/GU3FRWB7TAxoVYAY6hOJ3kFYBLJKhjWQN8l/7pfdZX1gNntHPJH6U1K23cCFGv
         B77XJ9mt7o1n2+27pLlXYzOGJDGcSS3hLW7iU3rXDBxRLDkTN75XWbFHpm/FKMm/naSe
         sFp2Qyh2XVKN82jjO2Yl81WUqHqGycL21LZfNvh6nF1d9fVV+sKDGhuirQYKiMneAmB6
         /gbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JOR9C92s2UsDICtNwg7xlXmIT0xJxQ6mVkXV7t9tpME=;
        b=L7e1o1qRLLGHcjtVpNQZOHxMyzk4sLZImnwVH1SQWeV/Bl6sHYpzY/i5OjUP96Q0jY
         /1HFsKFUfXmkJz2LuoJl3tE/XzkaA90oHLc2VHvYf32+RygTQusyjdiTwiDhSh7c0dC7
         VHpRsDNzq8ig3YK4qjvF6N9aG2+a9Vszy/Rjb4G0WJx0cmen9kbKJgTi68gflkpSMl7h
         pTWpac34BvhUuNFXMyWDeEeBoyIc81/6Is8W3FMepAlgQZDgK15eFCuJ1VBFh2hlGfr3
         r0LwVsN3A3lopF+8GCkCuP4YMaqdumA+vdBxLlG1WDPFOBNW8xG7EPyhF5I3r6nK2mmj
         dSrw==
X-Gm-Message-State: AOAM532tlnldHjKu2SPxJLdwasIhkEO2Q2DUt/K+lMsp6GdNyoYhnj3N
        ljObG6L98nmCntd+KPdKo/E7KdsjXC0EuSSW53c=
X-Google-Smtp-Source: ABdhPJyIES6S02FuXHbuJueSr9M5eMAUvdRDkR1R1YaTWIR4S67azwkIGRDg30+yMkleUs09/4DHgCrkYzEOKsGsGQM=
X-Received: by 2002:a25:8082:: with SMTP id n2mr238514ybk.79.1629151200142;
 Mon, 16 Aug 2021 15:00:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210815001550.24643-1-kiran.k@intel.com>
In-Reply-To: <20210815001550.24643-1-kiran.k@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 16 Aug 2021 14:59:49 -0700
Message-ID: <CABBYNZL2pmpJAstAQTNLmrRoZ-sVD92k3h9N+BWHuhCkiwTqzg@mail.gmail.com>
Subject: Re: [PATCH] mgmt: Set offload codec mgmt feature
To:     Kiran K <kiran.k@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

On Sat, Aug 14, 2021 at 5:13 PM Kiran K <kiran.k@intel.com> wrote:
>
> Signed-off-by: Kiran K <kiran.k@intel.com>

We don't use Signed-off-by on userspace patches.

> ---
>  tools/btmgmt.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/tools/btmgmt.c b/tools/btmgmt.c
> index 7d908238156d..c5f55ae1290c 100644
> --- a/tools/btmgmt.c
> +++ b/tools/btmgmt.c
> @@ -2554,6 +2554,48 @@ static void cmd_privacy(int argc, char **argv)
>         }
>  }
>
> +static void exp_offload_rsp(uint8_t status, uint16_t len, const void *param,
> +                                                       void *user_data)
> +{
> +       if (status != 0)
> +               error("Set offload codec feature failed with status 0x%02x (%s)",
> +                                               status, mgmt_errstr(status));
> +       else
> +               print("Offload codec feature successfully set");
> +
> +       bt_shell_noninteractive_quit(EXIT_SUCCESS);
> +}
> +
> +static void cmd_exp_offload_codecs(int argc, char **argv)
> +{
> +       /* a6695ace-ee7f-4fb9-881a-5fac66c629af */
> +       static const uint8_t uuid[16] = {
> +                               0xaf, 0x29, 0xc6, 0x66, 0xac, 0x5f, 0x1a, 0x88,
> +                               0xb9, 0x4f, 0x7f, 0xee, 0xce, 0x5a, 0x69, 0xa6,
> +       };

This also should be added to src/shared/util.c:uuid128_table so we are
able to decode it when using the likes of btmon and bluetoothctl.

> +       struct mgmt_cp_set_exp_feature cp;
> +       uint8_t val;
> +       uint16_t index;
> +
> +       if (parse_setting(argc, argv, &val) == false)
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +
> +       index = mgmt_index;
> +       if (index == MGMT_INDEX_NONE)
> +               index = 0;
> +
> +       memset(&cp, 0, sizeof(cp));
> +       memcpy(cp.uuid, uuid, 16);
> +       cp.action = val;
> +
> +       if (mgmt_send(mgmt, MGMT_OP_SET_EXP_FEATURE, index,
> +                       sizeof(cp), &cp, exp_offload_rsp, NULL, NULL) == 0) {
> +               error("Unable to send offload codecs feature cmd");
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +}
> +
>  static void class_rsp(uint16_t op, uint16_t id, uint8_t status, uint16_t len,
>                                                         const void *param)
>  {
> @@ -5595,6 +5637,8 @@ static const struct bt_shell_menu main_menu = {
>                 cmd_exp_privacy,        "Set LL privacy feature"        },
>         { "exp-quality",        "<on/off>", cmd_exp_quality,
>                 "Set bluetooth quality report feature"                  },
> +       { "exp-offload",                "<on/off>",
> +               cmd_exp_offload_codecs, "Toggle codec support support"  },
>         { "read-sysconfig",     NULL,
>                 cmd_read_sysconfig,     "Read System Configuration"     },
>         { "set-sysconfig",      "<-v|-h> [options...]",
> --
> 2.17.1
>


-- 
Luiz Augusto von Dentz
