Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AA8C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Nov 2021 23:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236778AbhKWXqs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Nov 2021 18:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhKWXqr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Nov 2021 18:46:47 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15650C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Nov 2021 15:43:39 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id ay21so1212834uab.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Nov 2021 15:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mW8j06k6ou2HNwt+5oGpEqlP9H5RWPjCPFGgHo9hlow=;
        b=JANi5mo13+7cf86hJwmNGq3wIhggBldEMpkcZEMZ++hZ7M4FVxHHEiUdQTF9AZdMqe
         R6lacuwlJOZHEtbNchrKy9Za2jiA/aCKA1Hm0luBLEIRivpTRnziELQD5xZGY5pN53PH
         6DhDvgBpndX8VdV/5x+WmEgwPshBENgVB6YAN/BbMtWdQNMaAhr4XqdFuHKFL8H6coM7
         u5S9XMS+Rnzg0cG4lBpelrTFxhYm/DdXsDF0axs8QlV/xI4Sgo4pwW4Too5+RswoJPaM
         OLihQoi46iWd1/NDC3/DX2iQ6Pqb369sPoF6YjspqCOM8tPFN9Au+f8HPKvSQQIrzb+K
         Ez2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mW8j06k6ou2HNwt+5oGpEqlP9H5RWPjCPFGgHo9hlow=;
        b=YmjnY1F21tb2FSY0G5P1UMMUfccjtqA10kOR3bBQBf14HbwA6YRKq5X4vfC7MwEmOv
         oPOEMiohYu/YB2PngB2WGaY8hCDK2SrZTjio8bVhiRPlbgV0fh7OfRIvAQrdetj0pv71
         agKOy8EjhhBAI8CvNmUyQQeN9dpxob728j276Tl9EwrtoVr6LzCKNuCD8k4unyTjnJRv
         PcVQ5p46NBYdVUgLZwh8gxwAurQVV9dVWrsf7LMQ3usW2cbc8Xyx5e6LNRfcTZez34hy
         XTU1HkjxZ50MPOGiw7NOix+h/sns/Rpumapl5kdn+p/ZePAYZ3TSTGSWjwW0XTkS1NK4
         76ZQ==
X-Gm-Message-State: AOAM533hkqt6QhAzEvpCrQJ3G2Vj2wXI99/D7mso6iKHogA1eZ+UAN1B
        TpZWWriKYCJEEOwczLdhj5Iote0+OS+rsEMp88otglkY
X-Google-Smtp-Source: ABdhPJzTnhe5NyM+Pih9TvmR+zDqszzDSzp+ZdOuuwpJxQ0gAbcz/yQGSG9aTMD4r8IPEZMQ1aznB+xxrEqRrDRqbJ4=
X-Received: by 2002:a05:6102:5109:: with SMTP id bm9mr15124107vsb.10.1637711017941;
 Tue, 23 Nov 2021 15:43:37 -0800 (PST)
MIME-Version: 1.0
References: <20211119082027.12809-1-kiran.k@intel.com> <20211119082027.12809-4-kiran.k@intel.com>
In-Reply-To: <20211119082027.12809-4-kiran.k@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 23 Nov 2021 15:43:27 -0800
Message-ID: <CABBYNZ+YUuoPAJb11_VF_wJKUf7P3=RMS504G6=jprX=JNbQRQ@mail.gmail.com>
Subject: Re: [PATCH v4 04/14] Bluetooth: Pass transport type in get_data_path_id
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

On Fri, Nov 19, 2021 at 12:15 AM Kiran K <kiran.k@intel.com> wrote:
>
> To support fetching of data path id for other transport types
> like a2dp, le audio, pass an additional parameter to get_data_path_id
> callback function.
>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> ---
>  drivers/bluetooth/btintel.c      | 19 +++++++++++++++----
>  drivers/bluetooth/hci_vhci.c     |  6 +++++-
>  include/net/bluetooth/hci_core.h |  3 ++-
>  net/bluetooth/hci_codec.c        |  9 ++++++---
>  net/bluetooth/hci_conn.c         |  3 ++-
>  net/bluetooth/hci_request.c      |  5 +++--
>  net/bluetooth/hci_request.h      |  3 ++-
>  7 files changed, 35 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index c8c5c7007094..4b6d7ea08425 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -2209,11 +2209,22 @@ static int btintel_get_codec_config_data(struct hci_dev *hdev,
>         return err;
>  }
>
> -static int btintel_get_data_path_id(struct hci_dev *hdev, __u8 *data_path_id)
> +static int btintel_get_data_path_id(struct hci_dev *hdev, __u8 transport,
> +                                   __u8 *data_path_id)
>  {
> -       /* Intel uses 1 as data path id for all the usecases */
> -       *data_path_id = 1;
> -       return 0;
> +       struct btintel_data *intel_data;
> +
> +       if (transport != HCI_TRANSPORT_SCO_ESCO)
> +               return -EINVAL;
> +
> +       intel_data = hci_get_priv((hdev));
> +
> +       if (intel_data->use_cases.preset[0] & 0x03) {
> +               /* Intel uses 1 as data path id for all the usecases */
> +               *data_path_id = 1;
> +               return 0;
> +       }
> +       return  -EOPNOTSUPP;
>  }
>
>  static int btintel_configure_offload(struct hci_dev *hdev)
> diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
> index 49ac884d996e..57f4d016fa89 100644
> --- a/drivers/bluetooth/hci_vhci.c
> +++ b/drivers/bluetooth/hci_vhci.c
> @@ -80,8 +80,12 @@ static int vhci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
>         return 0;
>  }
>
> -static int vhci_get_data_path_id(struct hci_dev *hdev, u8 *data_path_id)
> +static int vhci_get_data_path_id(struct hci_dev *hdev, u8 transport,
> +                                u8 *data_path_id)
>  {
> +       if (transport != HCI_TRANSPORT_SCO_ESCO)
> +               return -EINVAL;
> +
>         *data_path_id = 0;
>         return 0;
>  }
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 2560cfe80db8..b0c5eba20fd4 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -617,7 +617,8 @@ struct hci_dev {
>         void (*cmd_timeout)(struct hci_dev *hdev);
>         bool (*wakeup)(struct hci_dev *hdev);
>         int (*set_quality_report)(struct hci_dev *hdev, bool enable);
> -       int (*get_data_path_id)(struct hci_dev *hdev, __u8 *data_path);
> +       int (*get_data_path_id)(struct hci_dev *hdev, __u8 transport,
> +                               __u8 *data_path);
>         int (*get_codec_config_data)(struct hci_dev *hdev, __u8 type,
>                                      struct bt_codec *codec, __u8 *vnd_len,
>                                      __u8 **vnd_data);
> diff --git a/net/bluetooth/hci_codec.c b/net/bluetooth/hci_codec.c
> index 1e486aca3002..33b341104105 100644
> --- a/net/bluetooth/hci_codec.c
> +++ b/net/bluetooth/hci_codec.c
> @@ -259,12 +259,17 @@ int hci_get_supported_codecs(struct hci_dev *hdev, u8 type, char __user *optval,
>         struct bt_codec codec;
>         u8 num_codecs = 0, i, __user *ptr;
>         struct codec_list *c;
> +       u8 data_path;
>
>         if (!hdev->get_data_path_id) {
>                 err = -EOPNOTSUPP;
>                 goto error;
>         }
>
> +       err = hdev->get_data_path_id(hdev, type, &data_path);
> +       if (err < 0)
> +               goto error;
> +
>         /* find total buffer size required to copy codec + capabilities */
>         hci_dev_lock(hdev);
>         list_for_each_entry(c, &hdev->local_codecs, list) {
> @@ -301,9 +306,7 @@ int hci_get_supported_codecs(struct hci_dev *hdev, u8 type, char __user *optval,
>                 codec.id = c->id;
>                 codec.cid = c->cid;
>                 codec.vid = c->vid;
> -               err = hdev->get_data_path_id(hdev, &codec.data_path);
> -               if (err < 0)
> -                       break;
> +               codec.data_path = data_path;
>                 codec.num_caps = c->num_caps;
>                 if (copy_to_user(ptr, &codec, sizeof(codec))) {
>                         err = -EFAULT;
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index cd6e1cf7e396..ce87692272b5 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -317,7 +317,8 @@ static bool hci_enhanced_setup_sync_conn(struct hci_conn *conn, __u16 handle)
>
>         /* for offload use case, codec needs to configured before opening SCO */
>         if (conn->codec.data_path)
> -               hci_req_configure_datapath(hdev, &conn->codec);
> +               hci_req_configure_datapath(hdev, HCI_TRANSPORT_SCO_ESCO,
> +                                          &conn->codec);
>
>         conn->state = BT_CONNECT;
>         conn->out = true;
> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> index 8b3205e4b23e..00460317dec0 100644
> --- a/net/bluetooth/hci_request.c
> +++ b/net/bluetooth/hci_request.c
> @@ -2480,7 +2480,8 @@ static void config_data_path_complete(struct hci_dev *hdev, u8 status,
>         bt_dev_dbg(hdev, "status %u", status);
>  }
>
> -int hci_req_configure_datapath(struct hci_dev *hdev, struct bt_codec *codec)
> +int hci_req_configure_datapath(struct hci_dev *hdev, u8 transport,
> +                              struct bt_codec *codec)
>  {
>         struct hci_request req;
>         int err;
> @@ -2500,7 +2501,7 @@ int hci_req_configure_datapath(struct hci_dev *hdev, struct bt_codec *codec)
>                 goto error;
>         }
>
> -       err = hdev->get_data_path_id(hdev, &cmd->data_path_id);
> +       err = hdev->get_data_path_id(hdev, transport, &cmd->data_path_id);
>         if (err < 0)
>                 goto error;
>
> diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
> index 5f8e8846ec74..e360085def98 100644
> --- a/net/bluetooth/hci_request.h
> +++ b/net/bluetooth/hci_request.h
> @@ -111,7 +111,8 @@ void __hci_req_update_class(struct hci_request *req);
>  /* Returns true if HCI commands were queued */
>  bool hci_req_stop_discovery(struct hci_request *req);
>
> -int hci_req_configure_datapath(struct hci_dev *hdev, struct bt_codec *codec);
> +int hci_req_configure_datapath(struct hci_dev *hdev, u8 transport,
> +                              struct bt_codec *codec);

We are moving away from the hci_req* design, instead one should either
use a sync version if that could block or queue a command callback.

>  static inline void hci_req_update_scan(struct hci_dev *hdev)
>  {
> --
> 2.17.1
>


-- 
Luiz Augusto von Dentz
