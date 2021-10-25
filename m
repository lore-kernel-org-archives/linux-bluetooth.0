Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D78CC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 18:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 157D860C4B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 18:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbhJYSYc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Oct 2021 14:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbhJYSYb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Oct 2021 14:24:31 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7316AC061745
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Oct 2021 11:22:09 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id u206so5639880vke.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Oct 2021 11:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=KXU0ygns82Rf8Aj1by2XPwRcHEVRFb5xZkvNqtWJkAA=;
        b=VHNP3JVT2xk+7h3sexde8hxkf+KW7yxnX92eYIflS0XmvCzUe9IoQmviek0ryRZaNE
         NGgxdqwRLOhsj4e7Y76sTStN4eOcIljGLGOQkduHaxuPEzrXVE8GGI0Kc4bWKnTCRzbL
         Kfg/LZQZkLJaWqC+TJNHyhhv+7zOd/XxoqeF/HUIys1WlwTMFBJh2uAimb5qDobgltru
         Ylly3nGQGbdN/WuUpmfjrpynJOZDDtiWZ2gwHqtO7azReKM1gxl/FTM+pLmwLgHR9EB+
         31lF+ywEYc1OWWGyfz2LcMvop6KF871C7d9u6/Q0u3+++VbP8qHlqJWwa84hb1es94Z5
         SNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=KXU0ygns82Rf8Aj1by2XPwRcHEVRFb5xZkvNqtWJkAA=;
        b=8LNws4YXu8GnRiuw0LXeywvCcHsRJSDgAFYAoG8kuHnDQSHpo4oNWtjAKLpw2RXP5R
         C7og81/1LgI4eF8AsMbUtxzRXCx+ai17LdUWEBCNc/EqaDlXnPWVkshNZkRq2RWS/31e
         AI/9zUZzgFJMC8KQWSOz6QedOkozCxUpxqKdgVGuQsHg6jmYrIVJXJj+uqjD8M7BzXKM
         U36OLO7nnAycrVKzE6y8S2iwNgCqWDj+IVTrmde8JiZs7WF98uHjHRpE+EPqwTiZy6AT
         Vr4far/4Rhb+oyIYavR1zU2TQFwNH0LDtpTN48QaLBDEcB6bwUX/cSf6S1q3S3Z4/TdH
         FuVg==
X-Gm-Message-State: AOAM532RE8H5TlWmdoHR9hLyZm/ZeTTeQ+a/a2ruCn8EE8gTCB/Y8AfR
        XOR8c9FYs6gvj1RKi90MyJVJgGMOwzT2eXNg8QMz8C/3
X-Google-Smtp-Source: ABdhPJzENi9ofgOIhp+m0zLH5XAS/vERum7asAlj8ZJzDlg0i9/8gy9gWZfcBpc2MM3Xqg6VqhmQofEA0cmm0v4CLhk=
X-Received: by 2002:a1f:1844:: with SMTP id 65mr16656729vky.3.1635186128013;
 Mon, 25 Oct 2021 11:22:08 -0700 (PDT)
MIME-Version: 1.0
References: <20211022222737.807013-1-luiz.dentz@gmail.com>
In-Reply-To: <20211022222737.807013-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 25 Oct 2021 11:21:57 -0700
Message-ID: <CABBYNZJUVj+kdRp2FXC9zMqFS1LBZ1LqyrvK8_H9sZWaRLAQnQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] btdev: Fix using the callback return as command complete
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Fri, Oct 22, 2021 at 3:27 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Command callback can only be used when generating a command status as
> command complete can carry more than just the status.
> ---
>  emulator/btdev.c | 120 +++++++++++++++++++++++++++++++++--------------
>  1 file changed, 84 insertions(+), 36 deletions(-)
>
> diff --git a/emulator/btdev.c b/emulator/btdev.c
> index e129b5cda..7b311f347 100644
> --- a/emulator/btdev.c
> +++ b/emulator/btdev.c
> @@ -3677,12 +3677,16 @@ static int cmd_add_al(struct btdev *dev, const vo=
id *data, uint8_t len)
>          * HCI_LE_Create_Connection or HCI_LE_Extended_Create_Connection
>          * command is outstanding.
>          */
> -       if (!al_can_change(dev))
> -               return -EPERM;
> +       if (!al_can_change(dev)) {
> +               status =3D BT_HCI_ERR_COMMAND_DISALLOWED;
> +               goto done;
> +       }
>
>         /* Valid range for address type is 0x00 to 0x01 */
> -       if (cmd->addr_type > 0x01)
> -               return -EINVAL;
> +       if (cmd->addr_type > 0x01) {
> +               status =3D BT_HCI_ERR_INVALID_PARAMETERS;
> +               goto done;
> +       }
>
>         for (i =3D 0; i < dev->le_al_len; i++) {
>                 struct btdev_al *al =3D &dev->le_al[i];
> @@ -3694,18 +3698,25 @@ static int cmd_add_al(struct btdev *dev, const vo=
id *data, uint8_t len)
>                         pos =3D i;
>         }
>
> -       if (exists)
> -               return -EALREADY;
> +       /* If the device is already in the Filter Accept List, the Contro=
ller
> +        * should not add the device to the Filter Accept List again and =
should
> +        * return success.
> +        */
> +       if (exists) {
> +               status =3D BT_HCI_ERR_SUCCESS;
> +               goto done;
> +       }
>
>         if (pos < 0) {
> -               cmd_status(dev, BT_HCI_ERR_MEM_CAPACITY_EXCEEDED,
> -                                       BT_HCI_CMD_LE_ADD_TO_ACCEPT_LIST)=
;
> -               return 0;
> +               status =3D BT_HCI_ERR_MEM_CAPACITY_EXCEEDED;
> +               goto done;
>         }
>
>         al_add(&dev->le_al[pos], cmd->addr_type, (bdaddr_t *)&cmd->addr);
>
>         status =3D BT_HCI_ERR_SUCCESS;
> +
> +done:
>         cmd_complete(dev, BT_HCI_CMD_LE_ADD_TO_ACCEPT_LIST,
>                                                 &status, sizeof(status));
>
> @@ -3728,12 +3739,16 @@ static int cmd_remove_al(struct btdev *dev, const=
 void *data, uint8_t len)
>          * HCI_LE_Create_Connection or HCI_LE_Extended_Create_Connection
>          * command is outstanding.
>          */
> -       if (!al_can_change(dev))
> -               return -EPERM;
> +       if (!al_can_change(dev)) {
> +               status =3D BT_HCI_ERR_COMMAND_DISALLOWED;
> +               goto done;
> +       }
>
>         /* Valid range for address type is 0x00 to 0x01 */
> -       if (cmd->addr_type > 0x01)
> -               return -EINVAL;
> +       if (cmd->addr_type > 0x01) {
> +               status =3D BT_HCI_ERR_INVALID_PARAMETERS;
> +               goto done;
> +       }
>
>         for (i =3D 0; i < dev->le_al_len; i++) {
>                 struct btdev_al *al =3D &dev->le_al[i];
> @@ -3750,10 +3765,14 @@ static int cmd_remove_al(struct btdev *dev, const=
 void *data, uint8_t len)
>                 }
>         }
>
> -       if (i =3D=3D dev->le_al_len)
> -               return -EINVAL;
> +       if (i =3D=3D dev->le_al_len) {
> +               status =3D BT_HCI_ERR_INVALID_PARAMETERS;
> +               goto done;
> +       }
>
>         status =3D BT_HCI_ERR_SUCCESS;
> +
> +done:
>         cmd_complete(dev, BT_HCI_CMD_LE_REMOVE_FROM_ACCEPT_LIST,
>                                                 &status, sizeof(status));
>
> @@ -3774,12 +3793,16 @@ static int cmd_add_rl(struct btdev *dev, const vo=
id *data, uint8_t len)
>          * =E2=80=A2 an HCI_LE_Create_Connection, HCI_LE_Extended_Create_=
Connection,
>          * or HCI_LE_Periodic_Advertising_Create_Sync command is outstand=
ing.
>          */
> -       if (dev->le_adv_enable || dev->le_scan_enable)
> -               return -EPERM;
> +       if (dev->le_adv_enable || dev->le_scan_enable) {
> +               status =3D BT_HCI_ERR_COMMAND_DISALLOWED;
> +               goto done;
> +       }
>
>         /* Valid range for address type is 0x00 to 0x01 */
> -       if (cmd->addr_type > 0x01)
> -               return -EINVAL;
> +       if (cmd->addr_type > 0x01) {
> +               status =3D BT_HCI_ERR_INVALID_PARAMETERS;
> +               goto done;
> +       }
>
>         for (i =3D 0; i < dev->le_rl_len; i++) {
>                 struct btdev_rl *rl =3D &dev->le_rl[i];
> @@ -3791,13 +3814,18 @@ static int cmd_add_rl(struct btdev *dev, const vo=
id *data, uint8_t len)
>                         pos =3D i;
>         }
>
> -       if (exists)
> -               return -EALREADY;
> +       /* If an entry already exists in the resolving list with the same=
 four
> +        * parameter values, the Controller shall either reject the comma=
nd or
> +        * not add the device to the resolving list again and return succ=
ess.
> +        */
> +       if (exists) {
> +               status =3D BT_HCI_ERR_SUCCESS;
> +               goto done;
> +       }
>
>         if (pos < 0) {
> -               cmd_status(dev, BT_HCI_ERR_MEM_CAPACITY_EXCEEDED,
> -                                       BT_HCI_CMD_LE_ADD_TO_RESOLV_LIST)=
;
> -               return 0;
> +               status =3D BT_HCI_ERR_MEM_CAPACITY_EXCEEDED;
> +               goto done;
>         }
>
>         dev->le_rl[pos].type =3D cmd->addr_type;
> @@ -3806,6 +3834,8 @@ static int cmd_add_rl(struct btdev *dev, const void=
 *data, uint8_t len)
>         memcpy(dev->le_rl[pos].local_irk, cmd->local_irk, 16);
>
>         status =3D BT_HCI_ERR_SUCCESS;
> +
> +done:
>         cmd_complete(dev, BT_HCI_CMD_LE_ADD_TO_RESOLV_LIST,
>                                                 &status, sizeof(status));
>
> @@ -3825,12 +3855,16 @@ static int cmd_remove_rl(struct btdev *dev, const=
 void *data, uint8_t len)
>          * =E2=80=A2 an HCI_LE_Create_Connection, HCI_LE_Extended_Create_=
Connection,
>          * or HCI_LE_Periodic_Advertising_Create_Sync command is outstand=
ing.
>          */
> -       if (dev->le_adv_enable || dev->le_scan_enable)
> -               return -EPERM;
> +       if (dev->le_adv_enable || dev->le_scan_enable) {
> +               status =3D BT_HCI_ERR_COMMAND_DISALLOWED;
> +               goto done;
> +       }
>
>         /* Valid range for address type is 0x00 to 0x01 */
> -       if (cmd->addr_type > 0x01)
> -               return -EINVAL;
> +       if (cmd->addr_type > 0x01) {
> +               status =3D BT_HCI_ERR_INVALID_PARAMETERS;
> +               goto done;
> +       }
>
>         for (i =3D 0; i < dev->le_rl_len; i++) {
>                 struct btdev_rl *rl =3D &dev->le_rl[i];
> @@ -3841,10 +3875,14 @@ static int cmd_remove_rl(struct btdev *dev, const=
 void *data, uint8_t len)
>                 }
>         }
>
> -       if (i =3D=3D dev->le_rl_len)
> -               return -EINVAL;
> +       if (i =3D=3D dev->le_rl_len) {
> +               status =3D BT_HCI_ERR_INVALID_PARAMETERS;
> +               goto done;
> +       }
>
>         status =3D BT_HCI_ERR_SUCCESS;
> +
> +done:
>         cmd_complete(dev, BT_HCI_CMD_LE_REMOVE_FROM_RESOLV_LIST,
>                                                 &status, sizeof(status));
>
> @@ -3862,12 +3900,16 @@ static int cmd_clear_rl(struct btdev *dev, const =
void *data, uint8_t len)
>          * =E2=80=A2 an HCI_LE_Create_Connection, HCI_LE_Extended_Create_=
Connection,
>          * or HCI_LE_Periodic_Advertising_Create_Sync command is outstand=
ing.
>          */
> -       if (dev->le_adv_enable || dev->le_scan_enable)
> -               return -EPERM;
> +       if (dev->le_adv_enable || dev->le_scan_enable) {
> +               status =3D BT_HCI_ERR_COMMAND_DISALLOWED;
> +               goto done;
> +       }
>
>         rl_clear(dev);
>
>         status =3D BT_HCI_ERR_SUCCESS;
> +
> +done:
>         cmd_complete(dev, BT_HCI_CMD_LE_CLEAR_RESOLV_LIST,
>                                                 &status, sizeof(status));
>
> @@ -3894,12 +3936,15 @@ static int cmd_read_peer_rl_addr(struct btdev *de=
v, const void *data,
>         struct bt_hci_rsp_le_read_peer_resolv_addr rsp;
>
>         /* Valid range for address type is 0x00 to 0x01 */
> -       if (cmd->addr_type > 0x01)
> -               return -EINVAL;
> +       if (cmd->addr_type > 0x01) {
> +               rsp.status =3D BT_HCI_ERR_INVALID_PARAMETERS;
> +               goto done;
> +       }
>
>         rsp.status =3D BT_HCI_ERR_UNKNOWN_CONN_ID;
>         memset(rsp.addr, 0, 6);
>
> +done:
>         cmd_complete(dev, BT_HCI_CMD_LE_READ_PEER_RESOLV_ADDR,
>                                                         &rsp, sizeof(rsp)=
);
>
> @@ -3913,12 +3958,15 @@ static int cmd_read_local_rl_addr(struct btdev *d=
ev, const void *data,
>         struct bt_hci_rsp_le_read_local_resolv_addr rsp;
>
>         /* Valid range for address type is 0x00 to 0x01 */
> -       if (cmd->addr_type > 0x01)
> -               return -EINVAL;
> +       if (cmd->addr_type > 0x01) {
> +               rsp.status =3D BT_HCI_ERR_INVALID_PARAMETERS;
> +               goto done;
> +       }
>
>         rsp.status =3D BT_HCI_ERR_UNKNOWN_CONN_ID;
>         memset(rsp.addr, 0, 6);
>
> +done:
>         cmd_complete(dev, BT_HCI_CMD_LE_READ_LOCAL_RESOLV_ADDR,
>                                                         &rsp, sizeof(rsp)=
);
>
> --
> 2.31.1

Pushed.

--=20
Luiz Augusto von Dentz
