Return-Path: <SRS0=Bgmv=7Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCB6C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jun 2020 22:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A008C206D7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jun 2020 22:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXh4Fths"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgFKWiU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Jun 2020 18:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgFKWiT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Jun 2020 18:38:19 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE675C03E96F
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2020 15:38:19 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id g5so5865457otg.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2020 15:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dbJdSi91YZSwBv1uR/zmR6Hx0+JFk6Q4xUYphbRBl60=;
        b=DXh4FthsZ7MlAInw/y59xippbnvENPVr2u9wKwyiSl//cpt9TSOrlwqD+k2CI78a6s
         SlLmtvo/P24HUbkKg9spdzzZkXO4pUESFY+ekJ+s/W6A2MhSmzcPoGZlLdY4E1lA4oMg
         P2eCIfHfZ1AgzJCwmTWum/o6NBk3sdE5sD3+ZdbaDZYNBH9iICfJU16K+m3ETAfl9gNZ
         FafPEj6CcA2wvNZRjY1DOuEC59HS7XkN2xoopIYx/eDaOsaafOuXQ4cjVlLnyGsMsibo
         tIVkyc+0ie5dhefFEEucRH5B6MUGe7UMgveYVUYrnyUzUhQNvHLS+vxo5QAWp/3awjLS
         3/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dbJdSi91YZSwBv1uR/zmR6Hx0+JFk6Q4xUYphbRBl60=;
        b=QgOxZkaqLEzeF99OoB0/f88bCj9+rDTjTMlIB2G7wEng6u4krdDgp8KNX+vf5KYx7f
         F5MbUOW9Lc20F9x468KBRhxkeyX4DJPe5/hJkEATHO7HQINEziG62SOML3boR+ZumWmu
         XHUodpkEsE5IQdHJJ8MDhr4bZCH0eYTB8wdytc+RTLgsVhI51+/x+gEo7Uon1Os2O1Ra
         cfGwJdeYILbAbYcex6DdF7SDFr4ubQNeQo8iWnLmHfr3fS4+PzNaDjc9Y9ydpCOafNYs
         y8mse//PSYsuS7zFeDgMhcKQlU/nwhfxmBkD8g76PQ0fvOANMj+Z03Zi/Si5UO/qEWuL
         cbug==
X-Gm-Message-State: AOAM531d7QMa2lqBQL1xwWARDnVVxyxxgYq8L1ibd2n1fnS6ykdCSvaQ
        Hg1LiIiHA+h0tQB+KVAyXlNozCIs1dq24HK72hA=
X-Google-Smtp-Source: ABdhPJz7XZzRCrHDy1d8VKKqvVEZXVcPFT0gN6XM2Tx8wJAFo1hHdBD+zXaeNwdlUgZmqeHouiqd0ytYVvYtFsiLm50=
X-Received: by 2002:a05:6830:1d76:: with SMTP id l22mr7755055oti.177.1591915099160;
 Thu, 11 Jun 2020 15:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200518200949.BlueZ.v2.1.I6e499969d74a49ab2a152bf0484a18c08a07a267@changeid>
In-Reply-To: <20200518200949.BlueZ.v2.1.I6e499969d74a49ab2a152bf0484a18c08a07a267@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 11 Jun 2020 15:38:07 -0700
Message-ID: <CABBYNZL0_kkoUzuAysoq=VvH-pw2Lz=7-UPCW1rRu4eSqwKzGw@mail.gmail.com>
Subject: Re: [BlueZ PATCH v2] lib: Add definitions for advertisement monitor features
To:     Miao-chen Chou <mcchou@chromium.org>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Yoni Shavit <yshavit@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Alain Michaud <alainm@chromium.org>,
        Michael Sun <michaelfsun@google.com>,
        Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Miao,

On Mon, May 18, 2020 at 8:14 PM Miao-chen Chou <mcchou@chromium.org> wrote:
>
> This adds the following command opcodes, event codes and the corresponding
> structures.
> - MGMT_OP_READ_ADV_MONITOR_FEATURES
> - MGMT_OP_ADD_ADV_PATTERNS_MONITOR
> - MGMT_OP_REMOVE_ADV_MONITOR
> - MGMT_EV_ADV_MONITOR_ADDED
> - MGMT_EV_ADV_MONITOR_REMOVED
> ---
>
> Changes in v2:
> - Fix build failures.
>
>  lib/mgmt.h | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>
> diff --git a/lib/mgmt.h b/lib/mgmt.h
> index b4fc72069..6d7441ccc 100644
> --- a/lib/mgmt.h
> +++ b/lib/mgmt.h
> @@ -628,6 +628,42 @@ struct mgmt_rp_set_exp_feature {
>         uint32_t flags;
>  } __packed;
>
> +#define MGMT_ADV_MONITOR_FEATURE_MASK_OR_PATTERNS      (1 << 0)
> +
> +#define MGMT_OP_READ_ADV_MONITOR_FEATURES      0x004B
> +struct mgmt_rp_read_adv_monitor_features {
> +       uint32_t supported_features;
> +       uint32_t enabled_features;
> +       uint16_t max_num_handles;
> +       uint8_t max_num_patterns;
> +       uint16_t num_handles;
> +       uint16_t handles[0];
> +}  __packed;
> +
> +struct mgmt_adv_pattern {
> +       uint8_t ad_type;
> +       uint8_t offset;
> +       uint8_t length;
> +       uint8_t value[31];
> +} __packed;
> +
> +#define MGMT_OP_ADD_ADV_PATTERNS_MONITOR       0x004C
> +struct mgmt_cp_add_adv_patterns_monitor {
> +       uint8_t pattern_count;
> +       struct mgmt_adv_pattern patterns[0];
> +} __packed;
> +struct mgmt_rp_add_adv_patterns_monitor {
> +       uint16_t monitor_handle;
> +} __packed;
> +
> +#define MGMT_OP_REMOVE_ADV_MONITOR             0x004D
> +struct mgmt_cp_remove_adv_monitor {
> +       uint16_t monitor_handle;
> +} __packed;
> +struct mgmt_rp_remove_adv_monitor {
> +       uint16_t monitor_handle;
> +} __packed;
> +
>  #define MGMT_EV_CMD_COMPLETE           0x0001
>  struct mgmt_ev_cmd_complete {
>         uint16_t opcode;
> @@ -857,6 +893,16 @@ struct mgmt_ev_exp_feature_changed {
>         uint32_t flags;
>  } __packed;
>
> +#define MGMT_EV_ADV_MONITOR_ADDED      0x0028
> +struct mgmt_ev_adv_monitor_added {
> +       uint16_t monitor_handle;
> +}  __packed;
> +
> +#define MGMT_EV_ADV_MONITOR_REMOVED    0x0029
> +struct mgmt_ev_adv_monitor_removed {
> +       uint16_t monitor_handle;
> +}  __packed;
> +
>  static const char *mgmt_op[] = {
>         "<0x0000>",
>         "Read Version",
> @@ -933,6 +979,9 @@ static const char *mgmt_op[] = {
>         "Read Security Information",                    /* 0x0048 */
>         "Read Experimental Features Information",
>         "Set Experimental Feature",
> +       "Read Advertisement Monitor Features",
> +       "Add Advertisement Patterns Monitor",
> +       "Remove Advertisement Monitor",
>  };
>
>  static const char *mgmt_ev[] = {
> @@ -976,6 +1025,8 @@ static const char *mgmt_ev[] = {
>         "Extended Controller Information Changed",
>         "PHY Configuration Changed",
>         "Experimental Feature Changed",
> +       "Advertisement Monitor Added",                  /* 0x0028 */
> +       "Advertisement Monitor Removed",
>  };
>
>  static const char *mgmt_status[] = {
> --
> 2.26.2
>

Applied, thanks. Note I did adjust the opcodes so it matches the ones
used in the documentation, I've also dropped the pattern term from the
add command since we can assume a monitor will always be filtering
based on patterns and it is not used for the event.

-- 
Luiz Augusto von Dentz
