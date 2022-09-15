Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B244CECAAA1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Sep 2022 20:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiIOU7l (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Sep 2022 16:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiIOU7k (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Sep 2022 16:59:40 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F2D15710
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Sep 2022 13:59:38 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id r12so22123478ljg.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Sep 2022 13:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=oO03tDQOiuRKPMa8yosWJ07djMCToqrnGkprhhHFXU4=;
        b=Q5HTPYvsr3WxWLsAT4SvFUkRTNpCVL/bq9YmdE8pGKO43VGjvJzkHWbOu6gkUYtk24
         8OaccYwB/niH3g3VPvILyxTR81GbPVDmF+kxu/XpKgLv1YHX61ffVW9+dFyHIhtLdtyK
         4jxz1c4UFFRA8APZgmokzIpwyF0GWr5ZYmiQo42AreyQOXFsEAOjraEUbkR6vC3Zyybn
         rLWk8UHYiEYPJAM9RWvsDYKVug7x90eB33gqNxpSY2OgHqOQjeZGvs2ojcMNf8Eo0wir
         YZrQ0a5XWmI0enh2gkhQJjvRbER8rJfN/vmAEaSA5cAcvNE6H92J66lbJz6Qattyjh6u
         5pew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=oO03tDQOiuRKPMa8yosWJ07djMCToqrnGkprhhHFXU4=;
        b=ycQatSesC4dHnYXlfZ7kth9kEtZ1iV/5iyYN6N88CLnX3aY3yZLvhZncq0Y19KzJck
         Y5enlW40XdF8+eJHm1fhJ63BPvPwfG3YdN7s3XzJs5pm4ewmpcJ3xZoY64S2H/bWAOuH
         0tfmAZvpA4Y+eWNdwmqV+LJ2y6CwB/jMyoZCoJouaZGvXG15ZiJjXFpxN4ye0Of/Rs5f
         fMvWx9ravOzPGfl/AlOkLfsx1rEANzXnJfLuEhkvtNuESKXCOswLbyAbkg+IY0SXdYK4
         fAmJ2DCWOmlFJzPOZ/z8ZF8ldZDLfdvKjhcYFZghSVPPTEXW+2hER/e1W7mNGxpmn9f5
         IKWg==
X-Gm-Message-State: ACrzQf0DpG19hc9liiEHyITjLMKghaCMX39Jx5Rvu8TBdJGXiGBPntQW
        wyS+y/Ls489mWQJxP0fEAtIyI7DbbTnvz/pM2/EQYHM4y80=
X-Google-Smtp-Source: AMsMyM6sQ5onWN85MMoUBrQmnSVlda1ngwWbaGFBGuU87OiPC+9dVwSkN6OoraKHM+xAziq7dxvZ/i6YVBQqTjIr5uc=
X-Received: by 2002:a2e:a884:0:b0:25d:d8a2:d18c with SMTP id
 m4-20020a2ea884000000b0025dd8a2d18cmr467271ljq.305.1663275576376; Thu, 15 Sep
 2022 13:59:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220915095412.462210-1-sathish.narasimman@intel.com> <20220915095412.462210-4-sathish.narasimman@intel.com>
In-Reply-To: <20220915095412.462210-4-sathish.narasimman@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 15 Sep 2022 13:59:24 -0700
Message-ID: <CABBYNZL4z0U30iaWDHiAJ0ufhD5N9JiKhbyp3ZyAK2M2o6PWUw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 4/4] monitor/att: Add decoding support for Volume
 Control Serice
To:     Sathish Narasimman <sathish.narasimman@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sathish,

On Thu, Sep 15, 2022 at 3:11 AM Sathish Narasimman
<sathish.narasimman@intel.com> wrote:
>
> This adds decoding support for VCS attributes
>
> > ACL Data RX: Handle 3585 flags 0x02 dlen 7
>       ATT: Read Request (0x0a) len 2
>         Handle: 0x0017 Type: Volume State (0x2b7d)
> < ACL Data TX: Handle 3585 flags 0x00 dlen 8
>       ATT: Read Response (0x0b) len 3
>         Value: 000000
>         Handle: 0x0017 Type: Volume State (0x2b7d)
>             Volume Setting: 0
>             Not Muted: 0
>             Change Counter: 0
> > HCI Event: Number of Completed Packets (0x13) plen 5
>         Num handles: 1
>         Handle: 3585 Address: 49:71:FC:C0:66:C6 (Resolvable)
>         Count: 1
> > ACL Data RX: Handle 3585 flags 0x02 dlen 7
>       ATT: Read Request (0x0a) len 2
>         Handle: 0x001c Type: Volume Flags (0x2b7f)
> < ACL Data TX: Handle 3585 flags 0x00 dlen 6
>       ATT: Read Response (0x0b) len 1
>         Value: 01
>         Handle: 0x001c Type: Volume Flags (0x2b7f)
>             Volume Falg: 1
> ---
>  monitor/att.c | 159 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 159 insertions(+)
>
> diff --git a/monitor/att.c b/monitor/att.c
> index b7470f7a2ff4..3c1ff2e2aaa0 100644
> --- a/monitor/att.c
> +++ b/monitor/att.c
> @@ -1590,6 +1590,162 @@ static void pac_context_notify(const struct l2cap_frame *frame)
>         print_pac_context(frame);
>  }
>
> +static void print_vcs_state(const struct l2cap_frame *frame)
> +{
> +       uint8_t vol_set, mute, chng_ctr;
> +
> +       if (!l2cap_frame_get_u8((void *)frame, &vol_set)) {
> +               print_text(COLOR_ERROR, "Volume Settings: invalid size");
> +               goto done;
> +       }
> +       print_field("    Volume Setting: %u", vol_set);
> +
> +       if (!l2cap_frame_get_u8((void *)frame, &mute)) {
> +               print_text(COLOR_ERROR, "Mute Filed: invalid size");
> +               goto done;
> +       }
> +
> +       switch (mute) {
> +       case 0x00:
> +               print_field("    Not Muted: %u", mute);
> +               break;
> +       case 0x01:
> +               print_field("    Muted: %u", mute);
> +               break;
> +       default:
> +               print_field("    Unknown Mute Value: %u", mute);
> +               break;
> +       }
> +
> +       if (!l2cap_frame_get_u8((void *)frame, &chng_ctr)) {
> +               print_text(COLOR_ERROR, "Change Counter: invalid size");
> +               goto done;
> +       }
> +       print_field("    Change Counter: %u", chng_ctr);
> +
> +done:
> +       if (frame->size)
> +               print_hex_field("  Data", frame->data, frame->size);
> +}
> +
> +static void vol_state_read(const struct l2cap_frame *frame)
> +{
> +       print_vcs_state(frame);
> +}
> +
> +static void vol_state_notify(const struct l2cap_frame *frame)
> +{
> +       print_vcs_state(frame);
> +}
> +
> +static bool vcs_config_cmd(const struct l2cap_frame *frame)
> +{
> +       if (!l2cap_frame_print_u8((void *)frame, "    Change Counter"))
> +               return false;
> +
> +       return true;
> +}
> +
> +static bool vcs_absolute_cmd(const struct l2cap_frame *frame)
> +{
> +       if (!l2cap_frame_print_u8((void *)frame, "    Change Counter"))
> +               return false;
> +
> +       if (!l2cap_frame_print_u8((void *)frame, "    Volume Setting"))
> +               return false;
> +
> +       return true;
> +}
> +
> +#define ASE_CMD(_op, _desc, _func) \
> +[_op] = { \
> +       .desc = _desc, \
> +       .func = _func, \
> +}

Well those are not really ASE commands so Id probably reword that to
be VCS_CMD instead.

> +struct vcs_cmd {
> +       const char *desc;
> +       bool (*func)(const struct l2cap_frame *frame);
> +} vcs_cmd_table[] = {
> +       /* Opcode = 0x00 (Relative Volume Down) */
> +       ASE_CMD(0x00, "Relative Volume Down", vcs_config_cmd),
> +       /* Opcode = 0x01 (Relative Volume Up) */
> +       ASE_CMD(0x01, "Relative Volume Up", vcs_config_cmd),
> +       /* Opcode = 0x02 (Unmute/Relative Volume Down) */
> +       ASE_CMD(0x02, "Unmute/Relative Volume Down", vcs_config_cmd),
> +       /* Opcode = 0x03 (Unmute/Relative Volume Up) */
> +       ASE_CMD(0x03, "Unmute/Relative Volume Up", vcs_config_cmd),
> +       /* Opcode = 0x04 (Set Absolute Volume) */
> +       ASE_CMD(0x04, "Set Absolute Volume", vcs_absolute_cmd),
> +       /* Opcode = 0x05 (Unmute) */
> +       ASE_CMD(0x05, "Unmute", vcs_config_cmd),
> +       /* Opcode = 0x06 (Mute) */
> +       ASE_CMD(0x06, "Mute", vcs_config_cmd),
> +};
> +
> +static struct vcs_cmd *vcs_get_cmd(uint8_t op)
> +{
> +       if (op > ARRAY_SIZE(vcs_cmd_table))
> +               return NULL;
> +
> +       return &vcs_cmd_table[op];
> +}
> +
> +static void print_vcs_cmd(const struct l2cap_frame *frame)
> +{
> +       uint8_t op;
> +       struct vcs_cmd *cmd;
> +
> +       if (!l2cap_frame_get_u8((void *)frame, &op)) {
> +               print_text(COLOR_ERROR, "opcode: invalid size");
> +               goto done;
> +       }
> +
> +       cmd = vcs_get_cmd(op);
> +       if (!cmd) {
> +               print_field("    Opcode: Reserved (0x%2.2x)", op);
> +               goto done;
> +       }
> +
> +       print_field("    Opcode: %s (0x%2.2x)", cmd->desc, op);
> +       if (!cmd->func(frame))
> +               print_field("    Unknown Opcode");
> +
> +done:
> +       if (frame->size)
> +               print_hex_field("  Data", frame->data, frame->size);
> +}
> +
> +static void vol_cp_write(const struct l2cap_frame *frame)
> +{
> +       print_vcs_cmd(frame);
> +}
> +
> +static void print_vcs_flag(const struct l2cap_frame *frame)
> +{
> +       uint8_t vol_flag;
> +
> +       if (!l2cap_frame_get_u8((void *)frame, &vol_flag)) {
> +               print_text(COLOR_ERROR, "Volume Flag: invalid size");
> +               goto done;
> +       }
> +       print_field("    Volume Falg: %u", vol_flag);
> +
> +done:
> +       if (frame->size)
> +               print_hex_field("  Data", frame->data, frame->size);
> +}
> +
> +static void vol_flag_read(const struct l2cap_frame *frame)
> +{
> +       print_vcs_flag(frame);
> +}
> +
> +static void vol_flag_notify(const struct l2cap_frame *frame)
> +{
> +       print_vcs_flag(frame);
> +}
> +
>  #define GATT_HANDLER(_uuid, _read, _write, _notify) \
>  { \
>         .uuid = { \
> @@ -1617,6 +1773,9 @@ struct gatt_handler {
>         GATT_HANDLER(0x2bcc, pac_loc_read, NULL, pac_loc_notify),
>         GATT_HANDLER(0x2bcd, pac_context_read, NULL, pac_context_notify),
>         GATT_HANDLER(0x2bce, pac_context_read, NULL, pac_context_notify),
> +       GATT_HANDLER(0x2b7d, vol_state_read, NULL, vol_state_notify),
> +       GATT_HANDLER(0x2b7e, NULL, vol_cp_write, NULL),
> +       GATT_HANDLER(0x2b7f, vol_flag_read, NULL, vol_flag_notify),
>  };
>
>  static struct gatt_handler *get_handler(struct gatt_db_attribute *attr)
> --
> 2.25.1
>


-- 
Luiz Augusto von Dentz
