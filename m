Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186EBC4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 23:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E373E60F39
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 23:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236658AbhHQXtn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Aug 2021 19:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235369AbhHQXtj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Aug 2021 19:49:39 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAFEC061764
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Aug 2021 16:48:58 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id a126so1665096ybg.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Aug 2021 16:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+D6jd+A9PgU317g7/eVd45yFplXC9x/PQVLiWRXP48I=;
        b=L9J0CQgKbUP6cTwJ1IWbL5+CcqJRX5MC/lH8dS26RyzjBQHiFr52DVYj9t9fiBY1VW
         bmWADhnTNMfdI/SFs4V620HB9pWkPDsjN7a8gWGkun+JlS1Jz2/+6U5F62hVZ38uhu/J
         fKLAjWfdEKOR+LXkNhOKWQ6Sq17AH7MrExswYmxMY0i2/QfYazseDSRsNf0I4fyKQdvc
         GNZ96KK4UDRZLflMkWntcuSX0XtSW7aR1WvG2Z2uhcXhskqlUAHiFLu+syjNh8r00+n3
         1A8/vR3JDsMjUI8evUNJ0XMWvktHt1bIs3i7UUMYaT//EswVGZYNh5XDsUUqt18nhLum
         k0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+D6jd+A9PgU317g7/eVd45yFplXC9x/PQVLiWRXP48I=;
        b=OCJTR5aaZbNrAcQnXwTq9rzaIozAb5USM0oM15YZ6JBS3MvN0wHAmuNDX9tiBz2nee
         Zi8ofe3AAFG0hMTrjUbx6P7y5IuZUW8KwkqiKbiIYdRzcSdZsyt84IhgWcZHIZh74hC0
         jOuBUIECAfWH+sPaJS+gKDkcRANXHh+DDTfgdMt5VoWwyLS9KmEHs531HxX4b1wlEUcE
         PA3JltYF/0edRfKLfAwK70EOiaPaIHnAbQcKCEj7EQBC8xlASL8N8os8igAaCjDmVdXI
         VCU+p+3byGXNlcjuNIILfNqMs7S/GdcJAdo8ywl7IRCFoSV0lUnslboC08EnTpT5bDIH
         l+Rw==
X-Gm-Message-State: AOAM5333hyIztZIFmyVOnRReBDxq7ZDLyWMbTDMPi+5T8QeLY2J2kt0o
        YISCADADIBq+pcyzd6dqUJbYfvt/DpYM+3N1bSk=
X-Google-Smtp-Source: ABdhPJxKvSz+zrek2667wIEVDLq92NwqTrDKgUCwG6MGGhGmILWM8pt7MzH3D9b58V28l4Z/ZH2mYsBhr5i/5sQmu+8=
X-Received: by 2002:a25:1456:: with SMTP id 83mr7715802ybu.440.1629244137714;
 Tue, 17 Aug 2021 16:48:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210817030930.9211-1-kiran.k@intel.com>
In-Reply-To: <20210817030930.9211-1-kiran.k@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 17 Aug 2021 16:48:46 -0700
Message-ID: <CABBYNZL_C+NLxGw5GKDGfkhqpYn+OdNQHD4+z+htVQyayJKseA@mail.gmail.com>
Subject: Re: [PATCH v2] mgmt: Set offload codec mgmt feature
To:     Kiran K <kiran.k@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

On Mon, Aug 16, 2021 at 8:06 PM Kiran K <kiran.k@intel.com> wrote:
>
> Add mgmt support to toggle offload codec feature
> ---
> changes in v2:
>  - fix warnings reported by checkpatch
>  - add uuid to /src/shared/util.c:uuid128_table
>  - remove sign-off from commit message
>
>  src/shared/util.c |  1 +
>  tools/btmgmt.c    | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
>
> diff --git a/src/shared/util.c b/src/shared/util.c
> index 854b48d38f09..2447564566ce 100644
> --- a/src/shared/util.c
> +++ b/src/shared/util.c
> @@ -1027,6 +1027,7 @@ static const struct {
>                 "BlueZ Experimental LL privacy" },
>         { "330859bc-7506-492d-9370-9a6f0614037f",
>                 "BlueZ Experimental Bluetooth Quality Report" },
> +       { "a6695ace-ee7f-4fb9-881a-5fac66c629af", "BlueZ Offload Codecs"},

Please have it as a separate patch.

>         { }
>  };
>
> diff --git a/tools/btmgmt.c b/tools/btmgmt.c
> index 7d908238156d..a840c428cc74 100644
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
> +               error("Set offload codec failed with status 0x%02x (%s)",
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
> +
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
> +               cmd_exp_offload_codecs, "Toggle codec support"          },
>         { "read-sysconfig",     NULL,
>                 cmd_read_sysconfig,     "Read System Configuration"     },
>         { "set-sysconfig",      "<-v|-h> [options...]",
> --
> 2.17.1
>


-- 
Luiz Augusto von Dentz
