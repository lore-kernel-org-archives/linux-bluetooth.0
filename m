Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EE4C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Nov 2021 21:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72F98619E3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Nov 2021 21:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350995AbhKOVro (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Nov 2021 16:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351213AbhKOVpw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Nov 2021 16:45:52 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE80CC06120A
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Nov 2021 13:23:33 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id b17so37971240uas.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Nov 2021 13:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nOxd4mGzq7XFIio0RuWvK4VjnfascHHViknBFY/zS+g=;
        b=bEQC/3/dQ50lN6Y8RTdAMR+aq4TZDb3QpF+VkRc1m7WARHsWtfdv98I2hB/+4N//0f
         LpBG3p5XicgOezKFLgWRYLdPGV8fGsaZLaw9av9QhYoP+/d0aI2uLQutABsfAM4iw5n/
         gZLIBboHno3xaGbqI/1qJMkQ7o3kWI8bn9SLqGUco2GbsfhOeHkqL/go57HTa6BBw1SE
         ddVMVQ8uhukFr8U0s3+jiGcam1y/hQPwv0QvGMSUTe/4xMH95tdlyl52TP4dWaqYGxEV
         yOYtY2Z8OlLhmn5GbVBjXGa6N3hjLJemLo3nOL0eenkJZG8fJPcnJwltO1rSyEDE1UaX
         QugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nOxd4mGzq7XFIio0RuWvK4VjnfascHHViknBFY/zS+g=;
        b=GiVIbdC0S46rGropbNvbTLVEzeGtCAM1KztSahDlE0/rzfN9JjtEb/JlEEv/onv+dF
         Fp7bs57I3IfmHPpRvJOjPTEAl1vKhR3ZC9CKLDRkLW+I8BL8vV8Q9PNL6SP7GiY/xiGV
         DVlJlhUT9g0Pw/5LfEAPiragBYU2e+1leBPAWuLdUrqaRcPq9HJ1ajIOtdcHg5uE0u84
         bEJ7xd94dRJ8t042C6rez4wcJyKC5jx13xdzBPJRkru/BcybP6RBllfMrHpQSK1+X+cz
         0mXupiROTZbPqmFYNjyenf7oaScMwYLnmDhZHGFwNv4woE+PWKCjPiUgIZNA5z406LHR
         mHYA==
X-Gm-Message-State: AOAM531wnkaQZAl/9LfDzUZD3VxbeNDPb/krA/SBiXniaAVGkQgIWrmo
        Yg8qEt2Ww1QavpbdYgMALvGlSGQO1yCUro08kpPKSjUX
X-Google-Smtp-Source: ABdhPJyrwRPptbBo6JrY0J2UgrpIWtpXAaRJrWu8/UYS3QLJekL+Ree7earmB4tdG+YQkAOs0SvpFBBCudm4hIZtKjw=
X-Received: by 2002:ab0:3e3:: with SMTP id 90mr2919626uau.102.1637011412835;
 Mon, 15 Nov 2021 13:23:32 -0800 (PST)
MIME-Version: 1.0
References: <20211115064914.2345-1-kiran.k@intel.com> <20211115064914.2345-8-kiran.k@intel.com>
In-Reply-To: <20211115064914.2345-8-kiran.k@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 15 Nov 2021 13:23:22 -0800
Message-ID: <CABBYNZL0aZeFjutT8yJ8X0nRmM6RjmmUXUJSD-LX20w+GC0hyg@mail.gmail.com>
Subject: Re: [PATCH v3 08/13] Bluetooth: Implement MSFT avdtp open command
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

On Sun, Nov 14, 2021 at 10:44 PM Kiran K <kiran.k@intel.com> wrote:
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
>  include/net/bluetooth/bluetooth.h |  2 ++
>  include/net/bluetooth/hci.h       | 16 ++++++++++++
>  net/bluetooth/hci_codec.c         | 43 +++++++++++++++++++++++++++++++
>  net/bluetooth/hci_codec.h         |  4 +++
>  net/bluetooth/l2cap_sock.c        | 24 +++++++++++++++++
>  5 files changed, 89 insertions(+)
>
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index 2f31e571f34c..5e07cfed941d 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -177,6 +177,8 @@ struct bt_codecs {
>  #define BT_CODEC_TRANSPARENT   0x03
>  #define BT_CODEC_MSBC          0x05
>
> +#define BT_MSFT_OPEN           20

I rather not have each command as a different sockopt, instead I would
suggest just one opcode and a internal header for each command so we
don't pollute too much our sockopt space since this only really apply
to MSFT I guess calling it BT_MSFT should be fine, also Id make it
extensible so we have a header and a flexible payload in case more
commands needs to be added.

>  __printf(1, 2)
>  void bt_info(const char *fmt, ...);
>  __printf(1, 2)
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 7ea1bfce204f..a7dad0125c10 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -2009,6 +2009,22 @@ struct hci_cp_le_reject_cis {
>         __u8    reason;
>  } __packed;
>
> +#define HCI_MSFT_AVDTP_CMD                     0xfc1e
> +
> +#define HCI_MSFT_AVDTP_OPEN                    0x08
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
> +} __packed;
> +
>  /* ---- HCI Events ---- */
>  #define HCI_EV_INQUIRY_COMPLETE                0x01
>
> diff --git a/net/bluetooth/hci_codec.c b/net/bluetooth/hci_codec.c
> index c6bd934dcf36..e179f3bfb494 100644
> --- a/net/bluetooth/hci_codec.c
> +++ b/net/bluetooth/hci_codec.c
> @@ -355,3 +355,46 @@ int hci_get_supported_codecs(struct hci_dev *hdev, u8 type, char __user *optval,
>  error:
>         return err;
>  }
> +
> +int hci_configure_msft_avdtp_open(struct hci_dev *hdev, struct l2cap_chan *chan,
> +                                 sockptr_t optval, int optlen)
> +{
> +       struct msft_cp_avdtp_open *cmd = NULL;
> +       struct hci_media_service_caps *caps;
> +       int err;
> +
> +       if (!optlen || optlen < sizeof(*caps)) {
> +               err = -EINVAL;
> +               goto fail;
> +       }
> +
> +       cmd = kzalloc(sizeof(*cmd) + optlen, GFP_KERNEL);
> +       if (!cmd) {
> +               err = -ENOMEM;
> +               goto fail;
> +       }
> +
> +       cmd->sub_opcode = HCI_MSFT_AVDTP_OPEN;
> +       cmd->handle = __cpu_to_le16(chan->conn->hcon->handle);
> +       cmd->dcid = cpu_to_le16(chan->dcid);
> +       cmd->omtu = cpu_to_le16(chan->omtu);
> +       caps = (void *)(cmd + 1);
> +
> +       if (copy_from_sockptr(caps, optval, optlen)) {
> +               err = -EFAULT;
> +               goto fail;
> +       }
> +
> +       if (caps->category != 0x07) {
> +               err = -EINVAL;
> +               goto fail;
> +       }
> +
> +       hci_send_cmd(hdev, HCI_MSFT_AVDTP_CMD, sizeof(*cmd) + optlen, cmd);
> +
> +       /* wait until we get avdtp handle or timeout */
> +
> +fail:
> +       kfree(cmd);
> +       return err;
> +}
> diff --git a/net/bluetooth/hci_codec.h b/net/bluetooth/hci_codec.h
> index 6e849c7d75b9..123b46a6a8ce 100644
> --- a/net/bluetooth/hci_codec.h
> +++ b/net/bluetooth/hci_codec.h
> @@ -2,8 +2,12 @@
>
>  /* Copyright (C) 2014 Intel Corporation */
>
> +#include <net/bluetooth/l2cap.h>
> +
>  void hci_read_supported_codecs(struct hci_dev *hdev);
>  void hci_read_supported_codecs_v2(struct hci_dev *hdev);
>  void hci_codec_list_clear(struct list_head *codec_list);
>  int hci_get_supported_codecs(struct hci_dev *hdev, u8 type, char __user *optval,
>                              int __user *optlen, int len);
> +int hci_configure_msft_avdtp_open(struct hci_dev *hdev, struct l2cap_chan *chan,
> +                                 sockptr_t optval, int optlen);

Id place this function inside msft.h/msft.c since this is a MSFT extension.

> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index a883acf33e3c..fa689e576576 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -909,6 +909,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
>         struct l2cap_conn *conn;
>         int len, err = 0;
>         u32 opt;
> +       struct hci_dev *hdev;
>
>         BT_DBG("sk %p", sk);
>
> @@ -1137,6 +1138,29 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
>
>                 break;
>
> +       case BT_MSFT_OPEN:
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
> +               if (!hci_dev_test_flag(hdev, HCI_OFFLOAD_CODECS_ENABLED) ||
> +                   !hdev->get_data_path_id) {
> +                       err = -EOPNOTSUPP;
> +                       hci_dev_put(hdev);
> +                       break;
> +               }
> +
> +               err = hci_configure_msft_avdtp_open(hdev, chan, optval, optlen);
> +               hci_dev_put(hdev);
> +               break;
> +
>         default:
>                 err = -ENOPROTOOPT;
>                 break;
> --
> 2.17.1
>


-- 
Luiz Augusto von Dentz
