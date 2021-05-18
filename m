Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58B4C433B4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 May 2021 20:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF89D61154
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 May 2021 20:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238794AbhERUUx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 May 2021 16:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238378AbhERUUw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 May 2021 16:20:52 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66466C061573
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 May 2021 13:19:33 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id r8so14987968ybb.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 May 2021 13:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=r3DBVEXFuewAmytRT3k6BSGkHh/NS1ZiMkV/2NqrbTM=;
        b=f7bZOwImMA1Vbcf7gqpnGGy+eZF/BNWond3MMf9ATkIjQ+8CGgMqYGNA+z6UCuMf56
         JISRIJjdr6eH8ZnHmzPk3o/QkpBa4/zjxuP2LbwQNGx5ZKkOUYncPzP422ejAuaULLbG
         IzFy8i9QokRq3NrhD6Zcrvg3rOODHgbxveapDd7rd9qJ1+R3b+2v6LbNerSwazgx0042
         9NGiWUW2yxyhZQuzE6vNhs99q/iqT0VOstEogsJqruik3G+MDfZG1AWm8HK3JFPzxaZ/
         9ytcHLdl6C3UJ1cwJeBYNoj3i/IojZB3RPEPL4SFGL+Et18mM1ON444JpyZg4g7Cdnzv
         1uuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=r3DBVEXFuewAmytRT3k6BSGkHh/NS1ZiMkV/2NqrbTM=;
        b=G1Xr8A8/1waFid3jHrGT03wzqf/6QfBMwaArshKhYFvi4QWNEdysb1rokEbnNF8C5E
         fMkUsLl4koq6Evht952eGeke2gsU+6xbypBPqqx9YItz/q5sH9/oJ5UWyqmRDEOqIM3n
         g83jqTyZx/0oiH1CvDkTK53JENLzenkrK7AXvT0lLsL3tLQpECfkCMRYE8Lkji+HcOOA
         72eYsWSkvrJ16SfWrlpDA097XJRvDd8vE32/HcMOQE1nUL+vLw8yUPcJ7tkeHiygzoFm
         J8uCr1v0WPibhpCLyA5iobAD90mhQiMWgRMjAhKv8oAey4PQb0XWWSizD5Neukk6yfoR
         BUvw==
X-Gm-Message-State: AOAM533ozQOKCAsw1ajIQwdobZvX/cBPKFwxal5DWT7jVIxOjQAc8TZ6
        EyROJ3N6c+get4QZq7SkALG1E0zDV+KWjbBSQJ/Y1pS4
X-Google-Smtp-Source: ABdhPJwUHDtGI7gsADhnsZdEYw2BXG3SSSvu3+SDStot6VcZo4MJYaBGFwbrM4kOm41muFciC3cqBSyvsEFsm2XCBGg=
X-Received: by 2002:a25:a466:: with SMTP id f93mr9719055ybi.264.1621369172520;
 Tue, 18 May 2021 13:19:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210517215223.612671-1-luiz.dentz@gmail.com>
In-Reply-To: <20210517215223.612671-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 18 May 2021 13:19:21 -0700
Message-ID: <CABBYNZLMK7SFj9+TchU-UKMx8nqYJdL9KUaf34CDUgsM5AiNzg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] btdev: Add resolving list support
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Mon, May 17, 2021 at 2:52 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This adds support for commands related to resolving list.
> ---
>  emulator/btdev.c | 211 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 210 insertions(+), 1 deletion(-)
>
> diff --git a/emulator/btdev.c b/emulator/btdev.c
> index 2fd452970..692fabd71 100644
> --- a/emulator/btdev.c
> +++ b/emulator/btdev.c
> @@ -34,6 +34,7 @@
>  #include "btdev.h"
>
>  #define WL_SIZE                        16
> +#define RL_SIZE                        16
>
>  #define has_bredr(btdev)       (!((btdev)->features[4] & 0x20))
>  #define has_le(btdev)          (!!((btdev)->features[4] & 0x40))
> @@ -157,6 +158,9 @@ struct btdev {
>         uint8_t  le_iso_path[2];
>
>         uint8_t  le_wl[WL_SIZE][7];
> +       uint8_t  le_rl[RL_SIZE][39];
> +       uint8_t  le_rl_enable;
> +       uint16_t le_rl_timeout;
>
>         uint8_t le_local_sk256[32];
>
> @@ -3440,6 +3444,191 @@ static int cmd_remove_wl(struct btdev *dev, const void *data, uint8_t len)
>         return 0;
>  }
>
> +static int cmd_add_rl(struct btdev *dev, const void *data, uint8_t len)
> +{
> +       const struct bt_hci_cmd_le_add_to_resolv_list *cmd = data;
> +       uint8_t status;
> +       bool exists = false;
> +       int i, pos = -1;
> +
> +       /* Valid range for address type is 0x00 to 0x01 */
> +       if (cmd->addr_type > 0x01)
> +               return -EINVAL;
> +
> +       for (i = 0; i < RL_SIZE; i++) {
> +               if (dev->le_rl[i][0] == cmd->addr_type &&
> +                               !memcmp(&dev->le_rl[i][1], cmd->addr, 6)) {
> +                       exists = true;
> +                       break;
> +               } else if (pos < 0 && dev->le_rl[i][0] == 0xff)
> +                       pos = i;
> +       }
> +
> +       if (exists)
> +               return -EALREADY;
> +
> +       if (pos < 0) {
> +               cmd_status(dev, BT_HCI_ERR_MEM_CAPACITY_EXCEEDED,
> +                                       BT_HCI_CMD_LE_ADD_TO_RESOLV_LIST);
> +               return 0;
> +       }
> +
> +       dev->le_rl[pos][0] = cmd->addr_type;
> +       memcpy(&dev->le_rl[pos][1], cmd->addr, 6);
> +       memcpy(&dev->le_rl[pos][7], cmd->peer_irk, 16);
> +       memcpy(&dev->le_rl[pos][23], cmd->local_irk, 16);
> +
> +       status = BT_HCI_ERR_SUCCESS;
> +       cmd_complete(dev, BT_HCI_CMD_LE_ADD_TO_RESOLV_LIST,
> +                                               &status, sizeof(status));
> +
> +       return 0;
> +}
> +
> +static int cmd_remove_rl(struct btdev *dev, const void *data, uint8_t len)
> +{
> +       const struct bt_hci_cmd_le_remove_from_resolv_list *cmd = data;
> +       uint8_t status;
> +       int i, pos = -1;
> +
> +       /* Valid range for address type is 0x00 to 0x01 */
> +       if (cmd->addr_type > 0x01)
> +               return -EINVAL;
> +
> +       for (i = 0; i < RL_SIZE; i++) {
> +               if (dev->le_rl[i][0] == cmd->addr_type &&
> +                               !memcmp(&dev->le_rl[i][1], cmd->addr, 6)) {
> +                       pos = i;
> +                       break;
> +               }
> +       }
> +
> +       if (pos < 0)
> +               return -EINVAL;
> +
> +       dev->le_rl[pos][0] = 0xff;
> +       memset(&dev->le_rl[pos][1], 0, 38);
> +
> +       status = BT_HCI_ERR_SUCCESS;
> +       cmd_complete(dev, BT_HCI_CMD_LE_REMOVE_FROM_RESOLV_LIST,
> +                                               &status, sizeof(status));
> +
> +       return 0;
> +}
> +
> +static void rl_clear(struct btdev *dev)
> +{
> +       int i;
> +
> +       for (i = 0; i < RL_SIZE; i++) {
> +               dev->le_rl[i][0] = 0xff;
> +               memset(&dev->le_rl[i][1], 0, 38);
> +       }
> +}
> +
> +static int cmd_clear_rl(struct btdev *dev, const void *data, uint8_t len)
> +{
> +       uint8_t status;
> +
> +       rl_clear(dev);
> +
> +       status = BT_HCI_ERR_SUCCESS;
> +       cmd_complete(dev, BT_HCI_CMD_LE_CLEAR_RESOLV_LIST,
> +                                               &status, sizeof(status));
> +
> +       return 0;
> +}
> +
> +static int cmd_read_rl_size(struct btdev *dev, const void *data, uint8_t len)
> +{
> +       struct bt_hci_rsp_le_read_resolv_list_size rsp;
> +
> +       rsp.status = BT_HCI_ERR_SUCCESS;
> +       rsp.size = RL_SIZE;
> +
> +       cmd_complete(dev, BT_HCI_CMD_LE_READ_RESOLV_LIST_SIZE,
> +                                                       &rsp, sizeof(rsp));
> +
> +       return 0;
> +}
> +
> +static int cmd_read_peer_rl_addr(struct btdev *dev, const void *data,
> +                                                       uint8_t size)
> +{
> +       const struct bt_hci_cmd_le_read_peer_resolv_addr *cmd = data;
> +       struct bt_hci_rsp_le_read_peer_resolv_addr rsp;
> +
> +       /* Valid range for address type is 0x00 to 0x01 */
> +       if (cmd->addr_type > 0x01)
> +               return -EINVAL;
> +
> +       rsp.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
> +       memset(rsp.addr, 0, 6);
> +
> +       cmd_complete(dev, BT_HCI_CMD_LE_READ_PEER_RESOLV_ADDR,
> +                                                       &rsp, sizeof(rsp));
> +
> +       return 0;
> +}
> +
> +static int cmd_read_local_rl_addr(struct btdev *dev, const void *data,
> +                                                       uint8_t size)
> +{
> +       const struct bt_hci_cmd_le_read_local_resolv_addr *cmd = data;
> +       struct bt_hci_rsp_le_read_local_resolv_addr rsp;
> +
> +       /* Valid range for address type is 0x00 to 0x01 */
> +       if (cmd->addr_type > 0x01)
> +               return -EINVAL;
> +
> +       rsp.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
> +       memset(rsp.addr, 0, 6);
> +
> +       cmd_complete(dev, BT_HCI_CMD_LE_READ_LOCAL_RESOLV_ADDR,
> +                                                       &rsp, sizeof(rsp));
> +
> +       return 0;
> +}
> +
> +static int cmd_set_rl_enable(struct btdev *dev, const void *data, uint8_t len)
> +{
> +       const struct bt_hci_cmd_le_set_resolv_enable *cmd = data;
> +       uint8_t status;
> +
> +       /* Valid range for address resolution enable is 0x00 to 0x01 */
> +       if (cmd->enable > 0x01)
> +               return -EINVAL;
> +
> +       dev->le_rl_enable = cmd->enable;
> +
> +       status = BT_HCI_ERR_SUCCESS;
> +       cmd_complete(dev, BT_HCI_CMD_LE_SET_RESOLV_ENABLE,
> +                                               &status, sizeof(status));
> +
> +       return 0;
> +}
> +
> +static int cmd_set_rl_timeout(struct btdev *dev, const void *data, uint8_t len)
> +{
> +       const struct bt_hci_cmd_le_set_resolv_timeout *cmd = data;
> +       uint16_t timeout;
> +       uint8_t status;
> +
> +       timeout = le16_to_cpu(cmd->timeout);
> +
> +       /* Valid range for RPA timeout is 0x0001 to 0xa1b8 */
> +       if (timeout < 0x0001 || timeout > 0xa1b8)
> +               return -EINVAL;
> +
> +       dev->le_rl_timeout = timeout;
> +
> +       status = BT_HCI_ERR_SUCCESS;
> +       cmd_complete(dev, BT_HCI_CMD_LE_SET_RESOLV_TIMEOUT,
> +                                               &status, sizeof(status));
> +
> +       return 0;
> +}
> +
>  static int cmd_conn_update(struct btdev *dev, const void *data, uint8_t len)
>  {
>         cmd_status(dev, BT_HCI_ERR_SUCCESS, BT_HCI_CMD_LE_CONN_UPDATE);
> @@ -3828,7 +4017,16 @@ static int cmd_gen_dhkey(struct btdev *dev, const void *data, uint8_t len)
>         CMD(BT_HCI_CMD_LE_CONN_PARAM_REQ_NEG_REPLY, cmd_conn_param_neg_reply, \
>                                         cmd_conn_param_neg_reply_complete), \
>         CMD(BT_HCI_CMD_LE_READ_LOCAL_PK256, cmd_read_local_pk256, NULL), \
> -       CMD(BT_HCI_CMD_LE_GENERATE_DHKEY, cmd_gen_dhkey, NULL)
> +       CMD(BT_HCI_CMD_LE_GENERATE_DHKEY, cmd_gen_dhkey, NULL), \
> +       CMD(BT_HCI_CMD_LE_ADD_TO_RESOLV_LIST, cmd_add_rl,  NULL), \
> +       CMD(BT_HCI_CMD_LE_REMOVE_FROM_RESOLV_LIST, cmd_remove_rl, NULL), \
> +       CMD(BT_HCI_CMD_LE_CLEAR_RESOLV_LIST, cmd_clear_rl, NULL), \
> +       CMD(BT_HCI_CMD_LE_READ_RESOLV_LIST_SIZE, cmd_read_rl_size, NULL), \
> +       CMD(BT_HCI_CMD_LE_READ_PEER_RESOLV_ADDR, cmd_read_peer_rl_addr, NULL), \
> +       CMD(BT_HCI_CMD_LE_READ_LOCAL_RESOLV_ADDR, cmd_read_local_rl_addr, \
> +                                       NULL), \
> +       CMD(BT_HCI_CMD_LE_SET_RESOLV_ENABLE, cmd_set_rl_enable, NULL), \
> +       CMD(BT_HCI_CMD_LE_SET_RESOLV_TIMEOUT, cmd_set_rl_timeout, NULL)
>
>  static int cmd_set_default_phy(struct btdev *dev, const void *data,
>                                                         uint8_t len)
> @@ -5022,6 +5220,14 @@ static void set_le_commands(struct btdev *btdev)
>         /* Extra LE commands for >= 4.2 adapters */
>         btdev->commands[34] |= 0x02;    /* LE Read Local P-256 Public Key */
>         btdev->commands[34] |= 0x04;    /* LE Generate DHKey */
> +       btdev->commands[34] |= 0x08;    /* LE Add Device To Resolving List */
> +       btdev->commands[34] |= 0x10;    /* LE Remove Dev From Resolving List */
> +       btdev->commands[34] |= 0x20;    /* LE Clear Resolving List */
> +       btdev->commands[34] |= 0x40;    /* LE Read Resolving List Size */
> +       btdev->commands[34] |= 0x80;    /* LE Read Peer Resolvable Address */
> +       btdev->commands[35] |= 0x01;    /* LE Read Local Resolvable Address */
> +       btdev->commands[35] |= 0x02;    /* LE Set Address Resolution Enable */
> +       btdev->commands[35] |= 0x04;    /* LE Set RPA Timeout */
>
>         btdev->cmds = cmd_le;
>
> @@ -5302,6 +5508,9 @@ static void set_le_states(struct btdev *btdev)
>         btdev->le_states[5] = 0x03;
>
>         wl_clear(btdev);
> +       rl_clear(btdev);
> +       btdev->le_rl_enable = 0x00;
> +       btdev->le_rl_timeout = 0x0384;  /* 900 secs or 15 minutes */
>  }
>
>  static void set_amp_features(struct btdev *btdev)
> --
> 2.30.2

Pushed.

-- 
Luiz Augusto von Dentz
