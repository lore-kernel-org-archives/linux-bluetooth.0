Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06634C11F65
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Jun 2021 20:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D523061457
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Jun 2021 20:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbhF3Ulr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Jun 2021 16:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbhF3Ulp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Jun 2021 16:41:45 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3ABC061756
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Jun 2021 13:39:15 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id p22so7141008yba.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Jun 2021 13:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lqSgEBktzuoHqm4ah6t3WB6daUcNWAfYGisSyIAuWHU=;
        b=AEScU3XNMdWPSV1JMs5RnPPtL5HPGv5en3NAapxXEplrrBb4/QvgnIIEg2SYGoeTHv
         TAJAWRpmAKP6ljtc4Y/5aSG+nf5YLbogm5Jou5kjV6q4nweJVyzqAkJE6uulGhO/4S/7
         EWJ+ZhelliYc34WYgXu45owJGAHxBnEYoi0zJP3SQBNJRNIMaqN/AZe/phjmVxGqyHxZ
         xyAvG8LRUuirtXpdxfWKMkZOD1Km7gevENNh4nERa6zKXTGNUApDj2TNzsUxuJ9i885e
         7YW1nNHNPKMwP8IAtqZQPFCwirLSPbnR6mRxGqKdlABfzCio58lTbYym8ZjSQB2FSXd8
         do3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lqSgEBktzuoHqm4ah6t3WB6daUcNWAfYGisSyIAuWHU=;
        b=rqiaKXl50JLt5dMdZSfgT417B+DkY6/YKOfUd/pO0O9p3grorJV+65CYsA8Q0F7Abx
         MrLKSPIjRdXRfsoOccseVpmstmPVulbBDtCagBcS4XP37YqR89ZUbBeEMJ0IX4mQjI6f
         hJsekzu84MsmBsYOYQmHOH3fnpK3NkTEltmOabsEmrr+XQcNpXsv1hRKq+d0Cwe53Doa
         hhNDOttmeC9osoKn6UtgN+X31yMMdGMvPfzsxLSvGsHedI/waIuC7+phGuuLw60TS7fP
         Wehu7b0JNe8LCUe+47asPYGumSe/FcZJGh6Di0XbX6ia6JHN6s4iRPaan7hdrLTZ/Qjq
         xbTw==
X-Gm-Message-State: AOAM531gUWkawJLFoxokyANq9dFH46JoeIdxVcJ8E5yI0pcD467R2b5r
        IIwvZYJQRvlmu4IOkyD6riHr/NS3hppYZP06Rkc=
X-Google-Smtp-Source: ABdhPJxazdaJ0h104SdCIe27Oj9ZNemdwmLXmelIiozfeTMC5eYAr/u23eT7A9gUgga4iX63EPurewBY8wim0SqDCCk=
X-Received: by 2002:a05:6902:114c:: with SMTP id p12mr49396346ybu.282.1625085554995;
 Wed, 30 Jun 2021 13:39:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210630080807.12600-1-kiran.k@intel.com> <20210630080807.12600-8-kiran.k@intel.com>
In-Reply-To: <20210630080807.12600-8-kiran.k@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 30 Jun 2021 13:39:04 -0700
Message-ID: <CABBYNZ+p=vYj0daHwn+L6tTDGfYyhtkMJCyY1fzdFGFohtP9gA@mail.gmail.com>
Subject: Re: [PATCH v10 08/10] Bluetooth: Add support for HCI_Enhanced_Setup_Synchronous_Connection
 command
To:     Kiran K <kiran.k@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

On Wed, Jun 30, 2021 at 1:06 AM Kiran K <kiran.k@intel.com> wrote:
>
> < HCI Command: Enhanced Setup Synchronous Connection (0x01|0x003d) plen 59
>         Handle: 256
>         Transmit bandwidth: 8000
>         Receive bandwidth: 8000
>         Max latency: 13
>         Packet type: 0x0380
>           3-EV3 may not be used
>           2-EV5 may not be used
>           3-EV5 may not be used
>         Retransmission effort: Optimize for link quality (0x02)
> > HCI Event: Command Status (0x0f) plen 4
>       Enhanced Setup Synchronous Connection (0x01|0x003d) ncmd 1
>         Status: Success (0x00)
> > HCI Event: Synchronous Connect Complete (0x2c) plen 17
>         Status: Success (0x00)
>         Handle: 257
>         Address: CC:98:8B:92:04:FD (SONY Visual Products Inc.)
>         Link type: eSCO (0x02)
>         Transmission interval: 0x0c
>         Retransmission window: 0x06
>         RX packet length: 60
>         TX packet length: 60
>         Air mode: Transparent (0x03)
>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> ---
> * changes in v10:
>   - Fix typos and remove unwanted chunks
> * changes in v9:
>   - Fix review comments, use bt_dev_dbg instead of BT_DBG
>
>  include/net/bluetooth/bluetooth.h |   3 +-
>  include/net/bluetooth/hci.h       |  34 ++++++++++
>  include/net/bluetooth/hci_core.h  |   7 +-
>  net/bluetooth/hci_conn.c          | 106 ++++++++++++++++++++++++++++--
>  net/bluetooth/hci_event.c         |  48 +++++++++++++-
>  net/bluetooth/sco.c               |  13 +++-
>  6 files changed, 201 insertions(+), 10 deletions(-)
>
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index 0e8802d09068..af2809121571 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -173,7 +173,8 @@ struct bt_codecs {
>         struct bt_codec codecs[];
>  } __packed;
>
> -#define CODING_FORMAT_CVSD     0x02
> +#define CODING_FORMAT_CVSD             0x02
> +#define CODING_FORMAT_TRANSPARENT      0x03
>
>  __printf(1, 2)
>  void bt_info(const char *fmt, ...);
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index ae384b7bf000..e20318854900 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -871,6 +871,40 @@ struct hci_cp_logical_link_cancel {
>         __u8     flow_spec_id;
>  } __packed;
>
> +#define HCI_OP_ENHANCED_SETUP_SYNC_CONN                0x043D
> +struct hci_coding_format {
> +       __u8    id;
> +       __le16  cid;
> +       __le16  vid;
> +} __packed;
> +
> +struct hci_cp_enhanced_setup_sync_conn {
> +       __le16   handle;
> +       __le32   tx_bandwidth;
> +       __le32   rx_bandwidth;
> +       struct   hci_coding_format tx_coding_format;
> +       struct   hci_coding_format rx_coding_format;
> +       __le16   tx_codec_frame_size;
> +       __le16   rx_codec_frame_size;
> +       __le32   in_bandwidth;
> +       __le32   out_bandwidth;
> +       struct   hci_coding_format in_coding_format;
> +       struct   hci_coding_format out_coding_format;
> +       __le16   in_coded_data_size;
> +       __le16   out_coded_data_size;
> +       __u8     in_pcm_data_format;
> +       __u8     out_pcm_data_format;
> +       __u8     in_pcm_sample_payload_msb_pos;
> +       __u8     out_pcm_sample_payload_msb_pos;
> +       __u8     in_data_path;
> +       __u8     out_data_path;
> +       __u8     in_transport_unit_size;
> +       __u8     out_transport_unit_size;
> +       __le16   max_latency;
> +       __le16   pkt_type;
> +       __u8     retrans_effort;
> +} __packed;
> +
>  struct hci_rp_logical_link_cancel {
>         __u8     status;
>         __u8     phy_handle;
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index ebf42a3ac6cd..80ed81fb1883 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -719,6 +719,7 @@ struct hci_conn {
>         struct amp_mgr  *amp_mgr;
>
>         struct hci_conn *link;
> +       struct bt_codec codec;
>
>         void (*connect_cfm_cb)  (struct hci_conn *conn, u8 status);
>         void (*security_cfm_cb) (struct hci_conn *conn, u8 status);
> @@ -1101,6 +1102,7 @@ static inline struct hci_conn *hci_lookup_le_connect(struct hci_dev *hdev)
>
>  int hci_disconnect(struct hci_conn *conn, __u8 reason);
>  bool hci_setup_sync(struct hci_conn *conn, __u16 handle);
> +bool hci_enhanced_setup_sync(struct hci_conn *conn, __u16 handle);
>  void hci_sco_setup(struct hci_conn *conn, __u8 status);
>
>  struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
> @@ -1125,7 +1127,7 @@ struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
>                                  u8 sec_level, u8 auth_type,
>                                  enum conn_reasons conn_reason);
>  struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
> -                                __u16 setting);
> +                                __u16 setting, struct bt_codec *codec);
>  int hci_conn_check_link_mode(struct hci_conn *conn);
>  int hci_conn_check_secure(struct hci_conn *conn, __u8 sec_level);
>  int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type,
> @@ -1446,6 +1448,9 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
>  /* Use LL Privacy based address resolution if supported */
>  #define use_ll_privacy(dev) ((dev)->le_features[0] & HCI_LE_LL_PRIVACY)
>
> +/* Use enhanced synchronous connection if command is supported */
> +#define use_enhanced_sco_conn(dev) ((dev)->commands[29] & 0x08)
> +
>  /* Use ext scanning if set ext scan param and ext scan enable is supported */
>  #define use_ext_scan(dev) (((dev)->commands[37] & 0x20) && \
>                            ((dev)->commands[37] & 0x40))
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 2b5059a56cda..d4a08b344ad0 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -307,6 +307,96 @@ static bool find_next_esco_param(struct hci_conn *conn,
>         return conn->attempt <= size;
>  }
>
> +bool hci_enhanced_setup_sync(struct hci_conn *conn, __u16 handle)
> +{
> +       struct hci_dev *hdev = conn->hdev;
> +       struct hci_cp_enhanced_setup_sync_conn cp;
> +       const struct sco_param *param;
> +
> +       bt_dev_dbg(hdev, "hcon %p", conn);
> +
> +       conn->state = BT_CONNECT;
> +       conn->out = true;
> +
> +       conn->attempt++;
> +
> +       memset(&cp, 0x00, sizeof(cp));
> +
> +       cp.handle   = cpu_to_le16(handle);
> +
> +       cp.tx_bandwidth   = cpu_to_le32(0x00001f40);
> +       cp.rx_bandwidth   = cpu_to_le32(0x00001f40);
> +
> +       switch (conn->codec.id) {
> +       case CODING_FORMAT_TRANSPARENT:
> +               if (!find_next_esco_param(conn, esco_param_msbc,
> +                                         ARRAY_SIZE(esco_param_msbc)))
> +                       return false;
> +               param = &esco_param_msbc[conn->attempt - 1];
> +               cp.tx_coding_format.id = 0x03;
> +               cp.rx_coding_format.id = 0x03;
> +               cp.tx_codec_frame_size = __cpu_to_le16(60);
> +               cp.rx_codec_frame_size = __cpu_to_le16(60);
> +               cp.in_bandwidth = __cpu_to_le32(0x1f40);
> +               cp.out_bandwidth = __cpu_to_le32(0x1f40);
> +               cp.in_coding_format.id = 0x03;
> +               cp.out_coding_format.id = 0x03;
> +               cp.in_coded_data_size = __cpu_to_le16(16);
> +               cp.out_coded_data_size = __cpu_to_le16(16);
> +               cp.in_pcm_data_format = 2;
> +               cp.out_pcm_data_format = 2;
> +               cp.in_pcm_sample_payload_msb_pos = 0;
> +               cp.out_pcm_sample_payload_msb_pos = 0;
> +               cp.in_data_path = conn->codec.data_path;
> +               cp.out_data_path = conn->codec.data_path;
> +               cp.in_transport_unit_size = 1;
> +               cp.out_transport_unit_size = 1;
> +               break;
> +
> +       case CODING_FORMAT_CVSD:
> +               if (lmp_esco_capable(conn->link)) {
> +                       if (!find_next_esco_param(conn, esco_param_cvsd,
> +                                                 ARRAY_SIZE(esco_param_cvsd)))
> +                               return false;
> +                       param = &esco_param_cvsd[conn->attempt - 1];
> +               } else {
> +                       if (conn->attempt > ARRAY_SIZE(sco_param_cvsd))
> +                               return false;
> +                       param = &sco_param_cvsd[conn->attempt - 1];
> +               }
> +               cp.tx_coding_format.id = 2;
> +               cp.rx_coding_format.id = 2;
> +               cp.tx_codec_frame_size = __cpu_to_le16(60);
> +               cp.rx_codec_frame_size = __cpu_to_le16(60);
> +               cp.in_bandwidth = __cpu_to_le32(16000);
> +               cp.out_bandwidth = __cpu_to_le32(16000);
> +               cp.in_coding_format.id = 4;
> +               cp.out_coding_format.id = 4;
> +               cp.in_coded_data_size = __cpu_to_le16(16);
> +               cp.out_coded_data_size = __cpu_to_le16(16);
> +               cp.in_pcm_data_format = 2;
> +               cp.out_pcm_data_format = 2;
> +               cp.in_pcm_sample_payload_msb_pos = 0;
> +               cp.out_pcm_sample_payload_msb_pos = 0;
> +               cp.in_data_path = conn->codec.data_path;
> +               cp.out_data_path = conn->codec.data_path;
> +               cp.in_transport_unit_size = 16;
> +               cp.out_transport_unit_size = 16;
> +               break;
> +       default:
> +               return false;
> +       }
> +
> +       cp.retrans_effort = param->retrans_effort;
> +       cp.pkt_type = __cpu_to_le16(param->pkt_type);
> +       cp.max_latency = __cpu_to_le16(param->max_latency);
> +
> +       if (hci_send_cmd(hdev, HCI_OP_ENHANCED_SETUP_SYNC_CONN, sizeof(cp), &cp) < 0)
> +               return false;
> +
> +       return true;
> +}
> +
>  bool hci_setup_sync(struct hci_conn *conn, __u16 handle)
>  {
>         struct hci_dev *hdev = conn->hdev;
> @@ -424,10 +514,14 @@ void hci_sco_setup(struct hci_conn *conn, __u8 status)
>         BT_DBG("hcon %p", conn);
>
>         if (!status) {
> -               if (lmp_esco_capable(conn->hdev))
> -                       hci_setup_sync(sco, conn->handle);
> -               else
> +               if (lmp_esco_capable(conn->hdev)) {
> +                       if (use_enhanced_sco_conn(conn->hdev))
> +                               hci_enhanced_setup_sync(sco, conn->handle);
> +                       else
> +                               hci_setup_sync(sco, conn->handle);

Make the check for use_enhanced_sco_conn inside hci_setup_sync and
then call it internally there so we don't have to check it in multiple
places (afaik we normally use _capable for this sort of macros). Btw
since the use of enhanced version won't be conditional to the new
Kconfig you must enable it in the emulator so it can be exercised by
the CI, also Id just send this one separately alongside the changes to
enable it on the emulator.

> +               } else {
>                         hci_add_sco(sco, conn->handle);
> +               }
>         } else {
>                 hci_connect_cfm(sco, status);
>                 hci_conn_del(sco);
> @@ -1319,7 +1413,7 @@ struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
>  }
>
>  struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
> -                                __u16 setting)
> +                                __u16 setting, struct bt_codec *codec)
>  {
>         struct hci_conn *acl;
>         struct hci_conn *sco;
> @@ -1344,6 +1438,10 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
>         hci_conn_hold(sco);
>
>         sco->setting = setting;
> +       sco->codec.id = codec->id;
> +       sco->codec.cid = codec->cid;
> +       sco->codec.vid = codec->vid;
> +       sco->codec.data_path = codec->data_path;
>
>         if (acl->state == BT_CONNECTED &&
>             (sco->state == BT_OPEN || sco->state == BT_CLOSED)) {
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 1c3018202564..a021f29f12ad 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -2236,6 +2236,41 @@ static void hci_cs_setup_sync_conn(struct hci_dev *hdev, __u8 status)
>         hci_dev_unlock(hdev);
>  }
>
> +static void hci_cs_enhanced_setup_sync_conn(struct hci_dev *hdev, __u8 status)
> +{
> +       struct hci_cp_enhanced_setup_sync_conn *cp;
> +       struct hci_conn *acl, *sco;
> +       __u16 handle;
> +
> +       bt_dev_dbg(hdev, "status 0x%2.2x", status);
> +
> +       if (!status)
> +               return;
> +
> +       cp = hci_sent_cmd_data(hdev, HCI_OP_ENHANCED_SETUP_SYNC_CONN);
> +       if (!cp)
> +               return;
> +
> +       handle = __le16_to_cpu(cp->handle);
> +
> +       bt_dev_dbg(hdev, "handle 0x%4.4x", handle);
> +
> +       hci_dev_lock(hdev);
> +
> +       acl = hci_conn_hash_lookup_handle(hdev, handle);
> +       if (acl) {
> +               sco = acl->link;
> +               if (sco) {
> +                       sco->state = BT_CLOSED;
> +
> +                       hci_connect_cfm(sco, status);
> +                       hci_conn_del(sco);
> +               }
> +       }
> +
> +       hci_dev_unlock(hdev);
> +}
> +
>  static void hci_cs_sniff_mode(struct hci_dev *hdev, __u8 status)
>  {
>         struct hci_cp_sniff_mode *cp;
> @@ -3715,6 +3750,10 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb,
>                 hci_cs_setup_sync_conn(hdev, ev->status);
>                 break;
>
> +       case HCI_OP_ENHANCED_SETUP_SYNC_CONN:
> +               hci_cs_enhanced_setup_sync_conn(hdev, ev->status);
> +               break;
> +
>         case HCI_OP_SNIFF_MODE:
>                 hci_cs_sniff_mode(hdev, ev->status);
>                 break;
> @@ -4401,8 +4440,13 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev,
>                 if (conn->out) {
>                         conn->pkt_type = (hdev->esco_type & SCO_ESCO_MASK) |
>                                         (hdev->esco_type & EDR_ESCO_MASK);
> -                       if (hci_setup_sync(conn, conn->link->handle))
> -                               goto unlock;
> +                       if (use_enhanced_sco_conn(hdev)) {
> +                               if (hci_enhanced_setup_sync(conn, conn->link->handle))
> +                                       goto unlock;
> +                       } else {
> +                               if (hci_setup_sync(conn, conn->link->handle))
> +                                       goto unlock;
> +                       }
>                 }
>                 fallthrough;
>
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index 4b6ee0b302d7..b44d56eb936a 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -240,7 +240,7 @@ static int sco_connect(struct sock *sk)
>         }
>
>         hcon = hci_connect_sco(hdev, type, &sco_pi(sk)->dst,
> -                              sco_pi(sk)->setting);
> +                              sco_pi(sk)->setting, &sco_pi(sk)->codec);
>         if (IS_ERR(hcon)) {
>                 err = PTR_ERR(hcon);
>                 goto done;
> @@ -876,9 +876,9 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
>         u32 opt;
>  #if IS_ENABLED(CONFIG_BT_OFFLOAD_CODECS)
>         struct bt_codecs *codecs;
> -       struct hci_dev *hdev;
>         __u8 buffer[255];
>  #endif
> +       struct hci_dev *hdev;
>
>         BT_DBG("sk %p", sk);
>
> @@ -926,6 +926,15 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
>                 }
>
>                 sco_pi(sk)->setting = voice.setting;
> +               hdev = hci_get_route(&sco_pi(sk)->dst, &sco_pi(sk)->src,
> +                                    BDADDR_BREDR);
> +               if (!hdev) {
> +                       err = -EBADFD;
> +                       break;
> +               }
> +               if (use_enhanced_sco_conn(hdev) &&
> +                   voice.setting == BT_VOICE_TRANSPARENT)
> +                       sco_pi(sk)->codec.id = CODING_FORMAT_TRANSPARENT;
>                 break;
>
>         case BT_PKT_STATUS:
> --
> 2.17.1
>


-- 
Luiz Augusto von Dentz
