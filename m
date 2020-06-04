Return-Path: <SRS0=9nD+=7R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A6CC433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jun 2020 22:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6A57207D0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jun 2020 22:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RaRdTqoh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgFDW6x (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Jun 2020 18:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbgFDW6x (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Jun 2020 18:58:53 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1354C08C5C0
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2020 15:58:52 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id s13so6117970otd.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jun 2020 15:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y1LSZGQkJEVh00V8Qot8Gz5G9hgLYAEbbOwLVOv/nBs=;
        b=RaRdTqohtNRs73bcBo2C9bWkHWqxDni7jqzO76DVm28EG9DlodFsIyM+pqwgBSSHRT
         i1IBgf2s00IsdZZhpSYq6skFHc9/CNJFppyMKhWspDRCoDW0JXL+NVlInNq874Tc9igS
         WqVjKA4img5UXp0JU7lgTBuIPaO7LWfGgkUJvDkrAz8YMW7eh7V757pzMktps9NRnonT
         ZU2J2b28oD0UeKjWt64INbFq844GuJAdc8uYujpFRRn0Pw4P4vugiDmdXztjrk7R1KAK
         g8VHb55rtXBWO3tPP5zdpVza8pHEVhn0E0aM2RmNIg8s3ztTUm9vMsFXlqN6X61BDayL
         xKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y1LSZGQkJEVh00V8Qot8Gz5G9hgLYAEbbOwLVOv/nBs=;
        b=LSU54IXTO/uANVYeBGJavI3dMy2ECQ8x6TFZ6i98kAtH8ndD/dqzIPyVpQMSUk39S9
         lekUm0rHP4aFnnqfxHYc9m1dcMM1L7u9vfh3WcDHvZFN0WGAJUD/LDkHw31wPiBkBgaN
         0vacxJEQ39vEHGuqw0F9qHVLiYn83dK0kDZOq46C6bdUvk0LeCIVuxLKtI9ARWh7oOPd
         ODGfd+VFVyMW12metjHnN2FTJppgoWNlXZK30qT8ftl8GfK3m5mksXGP/LWhtBzeGhIm
         TuyyJQxZgNS1ksDKxDQfcp1103PLqKJ2+1mOgxYy9zwdY7S+uIhLGMq4ojIiZ5DCQNgV
         ZIPQ==
X-Gm-Message-State: AOAM532Y5KM7hQVdzKdUNdvz3P73wzbSxdXQQLjC1PW4K55ia+wMbtAF
        fOZF91G6uqAPv5vI5WPu4LqaQC2RSjlxdRhd2eq2dA==
X-Google-Smtp-Source: ABdhPJwgLKQQMDC4wKi8b/20Y5dgTf9NxLbiDA5C4gbgNcbIH1zdtwMDE5u4aLTXXn2NmZkPpd72uitVPSXIMK7+QZc=
X-Received: by 2002:a9d:2049:: with SMTP id n67mr4944474ota.177.1591311532201;
 Thu, 04 Jun 2020 15:58:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200529153814.213125-1-alainm@chromium.org> <20200529153814.213125-2-alainm@chromium.org>
In-Reply-To: <20200529153814.213125-2-alainm@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 4 Jun 2020 15:58:41 -0700
Message-ID: <CABBYNZKE8B2F6b9oEFWvh+A8FxEBhEGE4QrPc1gS6m_+gFW-aw@mail.gmail.com>
Subject: Re: [BlueZ PATCH v3 1/4] mgmt:adding load default system
 configuration definitions
To:     Alain Michaud <alainm@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

On Fri, May 29, 2020 at 8:42 AM Alain Michaud <alainm@chromium.org> wrote:
>
> This change adds the load default system configuration definitions
>
> ---
>
> Changes in v3: None
> Changes in v2: None
>
>  lib/mgmt.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/lib/mgmt.h b/lib/mgmt.h
> index b4fc72069..ea89c46b1 100644
> --- a/lib/mgmt.h
> +++ b/lib/mgmt.h
> @@ -628,6 +628,24 @@ struct mgmt_rp_set_exp_feature {
>         uint32_t flags;
>  } __packed;
>
> +#define MGMT_OP_READ_DEFAULT_SYSTEM_PARAMETERS 0x004b
> +
> +struct mgmt_system_parameter_tlv {
> +       uint16_t parameter_type;
> +       uint8_t length;
> +       uint8_t value[];
> +} __packed;
> +
> +struct mgmt_rp_read_default_system_parameters {
> +       uint8_t parameters[0]; // mgmt_system_parameter_tlv
> +} __packed;
> +
> +#define MGMT_OP_SET_DEFAULT_SYSTEM_PARAMETERS  0x004c
> +
> +struct mgmt_cp_set_default_system_parameters {
> +       uint8_t parameters[0]; // mgmt_system_parameter_tlv
> +} __packed;
> +
>  #define MGMT_EV_CMD_COMPLETE           0x0001
>  struct mgmt_ev_cmd_complete {
>         uint16_t opcode;
> @@ -933,6 +951,8 @@ static const char *mgmt_op[] = {
>         "Read Security Information",                    /* 0x0048 */
>         "Read Experimental Features Information",
>         "Set Experimental Feature",
> +       "Read Default System Configuration",
> +       "Set Default System Configuration",
>  };
>
>  static const char *mgmt_ev[] = {
> --
> 2.27.0.rc0.183.gde8f92d652-goog

Applied 1-3, thanks. I could not make up my mind regarding 4/4, while
it seems correct it doesn't seem to be a common practice on C projects
(e.g: linux, zephyr, etc.), most likely because it would not save much
in practice since it just making const pointer while the string
literal is already marked as const.

-- 
Luiz Augusto von Dentz
