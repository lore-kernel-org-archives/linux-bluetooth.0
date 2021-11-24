Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0322C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Nov 2021 01:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbhKXB3y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Nov 2021 20:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhKXB3y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Nov 2021 20:29:54 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7451C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Nov 2021 17:26:45 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id r15so1703704uao.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Nov 2021 17:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GuZBkFSYL6zcwOzebtES809+gWrUjJmsvQjotahiCZ0=;
        b=StEHb1STDN38V8JsoPTQaO4IjWZDekkt13STFWTiz0U16BdDyGWb7Rb3vsNFh3w3NK
         iJqJHHT11UOtb4GBOlV6l2QpxvH7vdH/OBB7gL6kwLeJXyKVRau2hug2HgmgklVDsloU
         IBj2sE1ySX/Qo73rgBnzstxNJ38cjUBac1qisk5lloi6vmfKOxQjfYYKoMPiwPACWosj
         CsTOi2zWvhVkBdTkEdLYqjHBwYRjNCLlQg40ICHi9tRdp5lkeBIYJQmzLTC/qC6lt0SN
         92PrMwH2Fv0+UUo45GI9wvjhx43Gie0zbx/aM2fpKkNE+lJ8Tk8QwAok22KzvEGv7qn1
         BP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GuZBkFSYL6zcwOzebtES809+gWrUjJmsvQjotahiCZ0=;
        b=mkLEjj2YpuCGRqWLdLnmCDgFbQwCkwDOKR4/oqTqwLgmcC8Te81h162U2ArUuD0IMI
         uJjm+E2nshdPShUFtMOUAaQuj7Ee78wVgsDyh2WJKpHVo9P/A8Hdg9mx7igjo8Wr2th2
         WoXyyjjcerqB62knPA/MqNCH2WKXHCl1KKVRpymEoU77K7FsqVXOJftjKJ+hkDfACOOq
         tpGLrb0g0ghDpuZpNBcvtq5jSgeL5B7+dGVivU3HG80owNOqRWV4cEyl/uQHXTT93ea7
         rwIHjYAWblYzQfYALE0uZEEUWwv5fawqSYU2aKOgkqAsNvJXiH4/GSep05vWaHejeERT
         abTw==
X-Gm-Message-State: AOAM530Hw/cLZ8evCPFQ6WnzJThyOEtYXyP3GhbAF/eKtFSWM4i8N0lD
        NedHeCEq6QzWkcwyLaAmxHc5hhugBCwjJvY/QMK5iZ9M
X-Google-Smtp-Source: ABdhPJymH2nBRBq25FO17r4Y4vVyWysvOcGEHnpuPwgFcEfiQhiGRjPL5vfQyqvs0rTo2K4Iom8/fMnTfw25QbK3SpM=
X-Received: by 2002:a67:6ac5:: with SMTP id f188mr16578475vsc.61.1637717204684;
 Tue, 23 Nov 2021 17:26:44 -0800 (PST)
MIME-Version: 1.0
References: <20211119082027.12809-1-kiran.k@intel.com> <20211119082027.12809-8-kiran.k@intel.com>
In-Reply-To: <20211119082027.12809-8-kiran.k@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 23 Nov 2021 17:26:33 -0800
Message-ID: <CABBYNZJg7uL2S=Fnm0eFwV8kxShJw1dXYu2rDRPzOiyq4D7ZOg@mail.gmail.com>
Subject: Re: [PATCH v4 08/14] Bluetooth: Implement MSFT avdtp open command
To:     Kiran K <kiran.k@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

On Fri, Nov 19, 2021 at 12:16 AM Kiran K <kiran.k@intel.com> wrote:
>
> In A2DP offload use case, controller needs to configured
> with selected codec capabilities, dcid of media transport
> channel and ACL connection handle.
>
> Controller responds with avdtp handle which needs to be
> sent in other avdtp commands like start, suspend and close.
>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> ---
>  include/net/bluetooth/bluetooth.h |   2 +
>  net/bluetooth/l2cap_sock.c        |  27 ++++++++
>  net/bluetooth/msft.c              | 104 ++++++++++++++++++++++++++++++
>  net/bluetooth/msft.h              |   3 +
>  4 files changed, 136 insertions(+)
>
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index 2f31e571f34c..6d5580316493 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -177,6 +177,8 @@ struct bt_codecs {
>  #define BT_CODEC_TRANSPARENT   0x03
>  #define BT_CODEC_MSBC          0x05
>
> +#define BT_MSFT                        20
> +
>  __printf(1, 2)
>  void bt_info(const char *fmt, ...);
>  __printf(1, 2)
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index 3c293d6bd04b..6f8d8c189b41 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -37,6 +37,8 @@
>
>  #include "smp.h"
>  #include "hci_codec.h"
> +#include "hci_request.h"
> +#include "msft.h"
>
>  static struct bt_sock_list l2cap_sk_list = {
>         .lock = __RW_LOCK_UNLOCKED(l2cap_sk_list.lock)
> @@ -916,6 +918,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
>         struct l2cap_conn *conn;
>         int len, err = 0;
>         u32 opt;
> +       struct hci_dev *hdev;
>
>         BT_DBG("sk %p", sk);
>
> @@ -1144,6 +1147,30 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
>
>                 break;
>
> +       case BT_MSFT:
> +               if (sk->sk_state != BT_CONNECTED) {
> +                       err = -ENOTCONN;
> +                       break;
> +               }
> +
> +               hdev = hci_get_route(BDADDR_ANY, &chan->src, BDADDR_BREDR);
> +               if (!hdev) {
> +                       err = -EBADFD;
> +                       break;
> +               }
> +
> +               if (!hci_dev_test_flag(hdev,
> +                                      HCI_MSFT_A2DP_OFFLOAD_CODECS_ENABLED) ||
> +                   !hdev->get_data_path_id) {
> +                       err = -EOPNOTSUPP;
> +                       hci_dev_put(hdev);
> +                       break;
> +               }
> +
> +               err = msft_avdtp_cmd(hdev, chan, optval, optlen);
> +               hci_dev_put(hdev);
> +               break;
> +
>         default:
>                 err = -ENOPROTOOPT;
>                 break;
> diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
> index 1122097e1e49..60ed08d65a06 100644
> --- a/net/bluetooth/msft.c
> +++ b/net/bluetooth/msft.c
> @@ -6,6 +6,7 @@
>  #include <net/bluetooth/bluetooth.h>
>  #include <net/bluetooth/hci_core.h>
>  #include <net/bluetooth/mgmt.h>
> +#include <net/bluetooth/l2cap.h>
>
>  #include "hci_request.h"
>  #include "mgmt_util.h"
> @@ -98,6 +99,28 @@ struct msft_data {
>         __u8 filter_enabled;
>  };
>
> +#define MSFT_OP_AVDTP                  0xfc1e

Is this different than the opcode used in other commands? Afaik all
MSFT command share the same opcode or is this different for AVDTP?

> +struct msft_cp_avdtp {
> +       __u8    sub_opcode;
> +       __u8    len;
> +       __u8    data[0];
> +};
> +
> +#define MSFT_OP_AVDTP_OPEN                     0x08
> +struct hci_media_service_caps {
> +       __u8    category;
> +       __u8    len;
> +       __u8    data[0];
> +} __packed;
> +
> +struct msft_cp_avdtp_open {
> +       __u8    sub_opcode;
> +       __le16  handle;
> +       __le16  dcid;
> +       __le16  omtu;
> +       __u8    caps[0];
> +} __packed;
> +
>  static int __msft_add_monitor_pattern(struct hci_dev *hdev,
>                                       struct adv_monitor *monitor);
>  static int __msft_remove_monitor(struct hci_dev *hdev,
> @@ -812,3 +835,84 @@ bool msft_curve_validity(struct hci_dev *hdev)
>  {
>         return hdev->msft_curve_validity;
>  }
> +
> +static int msft_avdtp_open(struct hci_dev *hdev,
> +                          struct l2cap_chan *chan,
> +                          struct msft_cp_avdtp *cmd)
> +{
> +       struct msft_cp_avdtp_open *open_cmd;
> +       struct hci_media_service_caps *caps;
> +       int err = 0;
> +
> +       caps = (void *)cmd->data;
> +
> +       if (!caps || caps->category != 0x07) {
> +               err = -EINVAL;
> +               goto fail;
> +       }
> +
> +       open_cmd = kzalloc(sizeof(*open_cmd) + caps->len, GFP_KERNEL);
> +       if (!open_cmd) {
> +               err = -ENOMEM;
> +               goto fail;
> +       }
> +
> +       open_cmd->sub_opcode = MSFT_OP_AVDTP_OPEN;
> +       open_cmd->handle = cpu_to_le16(chan->conn->hcon->handle);
> +       open_cmd->dcid = cpu_to_le16(chan->dcid);
> +       open_cmd->omtu = cpu_to_le16(chan->omtu);
> +
> +       /* copy codec capabilities */
> +       memcpy(open_cmd->caps, caps, sizeof(*caps) + caps->len);
> +
> +       hci_send_cmd(hdev, MSFT_OP_AVDTP, sizeof(*open_cmd) + cmd->len,
> +                    open_cmd);
> +
> +       /* wait until we get avdtp handle or timeout */
> +fail:
> +       kfree(open_cmd);
> +       return err;
> +}
> +
> +int msft_avdtp_cmd(struct hci_dev *hdev, struct l2cap_chan *chan,
> +                  sockptr_t optval, int optlen)
> +{
> +       int err = 0;
> +       struct msft_cp_avdtp *cmd;
> +       u8 buffer[255];
> +
> +       if (!optlen) {
> +               err = -EINVAL;
> +               goto fail;
> +       }
> +
> +       if (optlen > sizeof(buffer)) {
> +               err = -ENOBUFS;
> +               goto fail;
> +       }
> +
> +       if (copy_from_sockptr(buffer, optval, optlen)) {
> +               err = -EFAULT;
> +               goto fail;
> +       }
> +
> +       cmd = (void *)buffer;
> +
> +       switch (cmd->sub_opcode) {
> +       case MSFT_OP_AVDTP_OPEN:
> +               if (cmd->len > sizeof(buffer) - sizeof(*cmd)) {
> +                       err = -EINVAL;
> +                       break;
> +               }
> +               err = msft_avdtp_open(hdev, chan, cmd);
> +               break;
> +
> +       default:
> +               err = -EINVAL;
> +               bt_dev_err(hdev, "Invalid MSFT avdtp sub opcode = 0x%2.2x",
> +                          cmd->sub_opcode);
> +               break;
> +       }
> +fail:
> +       return err;
> +}
> diff --git a/net/bluetooth/msft.h b/net/bluetooth/msft.h
> index b59b63dc0ea8..7628c87e6358 100644
> --- a/net/bluetooth/msft.h
> +++ b/net/bluetooth/msft.h
> @@ -77,3 +77,6 @@ static inline bool msft_curve_validity(struct hci_dev *hdev)
>  }
>
>  #endif
> +
> +int msft_avdtp_cmd(struct hci_dev *hdev, struct l2cap_chan *chan,
> +                  sockptr_t optval, int optlen);
> --
> 2.17.1
>


-- 
Luiz Augusto von Dentz
