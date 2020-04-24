Return-Path: <SRS0=/Nrl=6I=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31E6C54FCB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Apr 2020 17:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B67C20736
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Apr 2020 17:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9gT3+Ah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbgDXRvA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Apr 2020 13:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728110AbgDXRu7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Apr 2020 13:50:59 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DCAC09B047
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2020 10:50:59 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id g19so13842521otk.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2020 10:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Xiiy48Nji2zZVj+IQPl4sLZF6+QczrdZt0CeDAJi/2c=;
        b=W9gT3+AhsP85oPk5TFbs9HMQ/012oJ7IZXkCzgSUbBt7ioVkMSjOPQ49pwLD5T//Bv
         XtrTZ6yBYWFhB8qhtRaK/L7hA6+2ZTrH2CbaO6eBkszmchHkeBlysL/FuwJet6fnp1Z1
         aRsRFcBa9PCKity+7NAMu5pIsagycQDQakCBTQH4Mtz7E6xqad8DAv8d4igxhjEhwOhf
         XSezYhiJh/1+W3NxE7MyJVa7j16PpSobeFpijT/fHeJvu9LXlET54Vj8fojzkmc4TcCT
         s/8DD5+3TFVjJsd6SlHmqj3ZUToU1ZToASbbZvY1aczRjYZ8GuRkEqmDP3ucQP+EUcEa
         hQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Xiiy48Nji2zZVj+IQPl4sLZF6+QczrdZt0CeDAJi/2c=;
        b=qJ6Cq9YIH0dUNTaWsFQCX0PNr39B/AmGnEBexxflat8LlP0gEAC+fb8+5hcgSMDh5q
         GzHi7Opc3qkrXSUGdfTN0FxZNrF08TrBdJWWAMCGzIjxtW7DLoViUqf65hNyPbM0UuQW
         cV6gDXf5sIfuOOKdJKxMAmhEFCkIrqVsgKQG/OM0DaSJa2qFYd5QynBPOceiK/M+WpSu
         mj5xGE15kofYjLzlD+rZztbpf7yW2J1dIr6xT95pnK1qnbe1kIh3ACd/QtRANe+/4bxJ
         Rkd5jIBXbfBBuQBBIvSsjzOO66g6R2XGxQ0dqPFkfY2PMb2NSd8IXbSIJD4yp5ZHyox9
         uiUw==
X-Gm-Message-State: AGi0PuYtxDZ0CqRNjFJEfCEOFAGXIgxPNQQzx6Y+5+EAy29Ot9FB0FH6
        vjETjpU/Lxud+bX3KIPOvJPz4GRYkuzgCRlAcNw23SAF
X-Google-Smtp-Source: APiQypLD/V0GA3HyDHE2XxG+KTYSp5ReF60Nut4xrKXp02wY8KUf5W3FnuG0gHx9RzVp64SFBKalMshei1bqfmqYmkM=
X-Received: by 2002:aca:b5d5:: with SMTP id e204mr8116388oif.108.1587750658430;
 Fri, 24 Apr 2020 10:50:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200423215501.427266-1-luiz.dentz@gmail.com>
In-Reply-To: <20200423215501.427266-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 24 Apr 2020 10:50:47 -0700
Message-ID: <CABBYNZ+yNa2VicDFm=h5Y6Hg4E9gvVADVEchO4W781p7jyzJAQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] monitor: Remove use of base defines for 5.2
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Thu, Apr 23, 2020 at 2:55 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Use the allocated value directly instead of base value + offset.
> ---
>  monitor/bt.h | 117 ++++++++++++++++++++++++++-------------------------
>  1 file changed, 60 insertions(+), 57 deletions(-)
>
> diff --git a/monitor/bt.h b/monitor/bt.h
> index f9ac6b180..39ca1e39a 100644
> --- a/monitor/bt.h
> +++ b/monitor/bt.h
> @@ -24,11 +24,7 @@
>
>  #include <stdint.h>
>
> -#define BT_HCI_CMD_5_2         0x2060
> -#define BT_HCI_BIT_5_2         (8 * 41) + 5
> -#define BT_HCI_SUBEVT_5_2      0x19
> -
> -#define BT_LL_CMD_5_2          0x1f
> +#define BT_HCI_CMD_BIT(_byte, _bit) ((8 * _byte) + _bit)
>
>  struct bt_ll_hdr {
>         uint8_t  preamble;
> @@ -181,7 +177,7 @@ struct bt_ll_clock_acc {
>
>  #define BT_LL_CLOCK_ACCURACY_RSP 0x1e
>
> -#define BT_LL_CIS_REQ          BT_LL_CMD_5_2
> +#define BT_LL_CIS_REQ          0x1f
>  struct bt_ll_cis_req {
>         uint8_t  cig;
>         uint8_t  cis;
> @@ -204,14 +200,14 @@ struct bt_ll_cis_req {
>         uint16_t conn_event_count;
>  } __attribute__ ((packed));
>
> -#define BT_LL_CIS_RSP          BT_LL_CMD_5_2 + 1
> +#define BT_LL_CIS_RSP          0x20
>  struct bt_ll_cis_rsp {
>         uint8_t  offset_min[3];
>         uint8_t  offset_max[3];
>         uint16_t conn_event_count;
>  } __attribute__ ((packed));
>
> -#define BT_LL_CIS_IND          BT_LL_CMD_5_2 + 2
> +#define BT_LL_CIS_IND          0x21
>  struct bt_ll_cis_ind {
>         uint32_t addr;
>         uint8_t  cis_offset[3];
> @@ -220,7 +216,7 @@ struct bt_ll_cis_ind {
>         uint16_t conn_event_count;
>  } __attribute__ ((packed));
>
> -#define BT_LL_CIS_TERMINATE_IND        BT_LL_CMD_5_2 + 3
> +#define BT_LL_CIS_TERMINATE_IND        0x22
>  struct bt_ll_cis_term_ind {
>         uint8_t  cig;
>         uint8_t  cis;
> @@ -2568,8 +2564,8 @@ struct bt_hci_cmd_default_periodic_adv_sync_trans_params {
>         uint8_t  cte_type;
>  } __attribute__ ((packed));
>
> -#define BT_HCI_CMD_LE_READ_BUFFER_SIZE_V2      BT_HCI_CMD_5_2
> -#define BT_HCI_BIT_LE_READ_BUFFER_SIZE_V2      BT_HCI_BIT_5_2
> +#define BT_HCI_CMD_LE_READ_BUFFER_SIZE_V2      0x2060
> +#define BT_HCI_BIT_LE_READ_BUFFER_SIZE_V2      BT_HCI_CMD_BIT(41, 5)
>  struct bt_hci_rsp_le_read_buffer_size_v2 {
>         uint8_t  status;
>         uint16_t acl_mtu;
> @@ -2578,8 +2574,8 @@ struct bt_hci_rsp_le_read_buffer_size_v2 {
>         uint8_t  iso_max_pkt;
>  } __attribute__ ((packed));
>
> -#define BT_HCI_CMD_LE_READ_ISO_TX_SYNC         BT_HCI_CMD_5_2 + 1
> -#define BT_HCI_BIT_LE_READ_ISO_TX_SYNC         BT_HCI_BIT_5_2 + 1
> +#define BT_HCI_CMD_LE_READ_ISO_TX_SYNC         0x2061
> +#define BT_HCI_BIT_LE_READ_ISO_TX_SYNC         BT_HCI_CMD_BIT(41, 6)
>  struct bt_hci_cmd_le_read_iso_tx_sync {
>         uint16_t handle;
>  } __attribute__ ((packed));
> @@ -2592,8 +2588,8 @@ struct bt_hci_rsp_le_read_iso_tx_sync {
>         uint8_t  offset[3];
>  } __attribute__ ((packed));
>
> -#define BT_HCI_CMD_LE_SET_CIG_PARAMS           BT_HCI_CMD_5_2 + 2
> -#define BT_HCI_BIT_LE_SET_CIG_PARAMS           BT_HCI_BIT_5_2 + 2
> +#define BT_HCI_CMD_LE_SET_CIG_PARAMS           0x2062
> +#define BT_HCI_BIT_LE_SET_CIG_PARAMS           BT_HCI_CMD_BIT(41, 7)
>  struct bt_hci_cis_params {
>         uint8_t  cis_id;
>         uint16_t m_sdu;
> @@ -2624,8 +2620,8 @@ struct bt_hci_rsp_le_set_cig_params {
>         uint16_t handle[0];
>  } __attribute__ ((packed));
>
> -#define BT_HCI_CMD_LE_SET_CIG_PARAMS_TEST      BT_HCI_CMD_5_2 + 3
> -#define BT_HCI_BIT_LE_SET_CIG_PARAMS_TEST      BT_HCI_BIT_5_2 + 3
> +#define BT_HCI_CMD_LE_SET_CIG_PARAMS_TEST      0x2063
> +#define BT_HCI_BIT_LE_SET_CIG_PARAMS_TEST      BT_HCI_CMD_BIT(42, 0)
>  struct bt_hci_cis_params_test {
>         uint8_t  cis_id;
>         uint8_t  nse;
> @@ -2653,8 +2649,8 @@ struct bt_hci_cmd_le_set_cig_params_test {
>         struct bt_hci_cis_params_test cis[0];
>  } __attribute__ ((packed));
>
> -#define BT_HCI_CMD_LE_CREATE_CIS               BT_HCI_CMD_5_2 + 4
> -#define BT_HCI_BIT_LE_CREATE_CIS               BT_HCI_BIT_5_2 + 4
> +#define BT_HCI_CMD_LE_CREATE_CIS               0x2064
> +#define BT_HCI_BIT_LE_CREATE_CIS               BT_HCI_CMD_BIT(42, 1)
>  struct bt_hci_cis {
>         uint16_t  cis_handle;
>         uint16_t  acl_handle;
> @@ -2665,27 +2661,27 @@ struct bt_hci_cmd_le_create_cis {
>         struct bt_hci_cis cis[0];
>  } __attribute__ ((packed));
>
> -#define BT_HCI_CMD_LE_REMOVE_CIG               BT_HCI_CMD_5_2 + 5
> -#define BT_HCI_BIT_LE_REMOVE_CIG               BT_HCI_BIT_5_2 + 5
> +#define BT_HCI_CMD_LE_REMOVE_CIG               0x2065
> +#define BT_HCI_BIT_LE_REMOVE_CIG               BT_HCI_CMD_BIT(42, 2)
>  struct bt_hci_cmd_le_remove_cig {
>         uint8_t  cig_id;
>  } __attribute__ ((packed));
>
> -#define BT_HCI_CMD_LE_ACCEPT_CIS               BT_HCI_CMD_5_2 + 6
> -#define BT_HCI_BIT_LE_ACCEPT_CIS               BT_HCI_BIT_5_2 + 6
> +#define BT_HCI_CMD_LE_ACCEPT_CIS               0x2066
> +#define BT_HCI_BIT_LE_ACCEPT_CIS               BT_HCI_CMD_BIT(42, 3)
>  struct bt_hci_cmd_le_accept_cis {
>         uint16_t handle;
>  } __attribute__ ((packed));
>
> -#define BT_HCI_CMD_LE_REJECT_CIS               BT_HCI_CMD_5_2 + 7
> -#define BT_HCI_BIT_LE_REJECT_CIS               BT_HCI_BIT_5_2 + 7
> +#define BT_HCI_CMD_LE_REJECT_CIS               0x2067
> +#define BT_HCI_BIT_LE_REJECT_CIS               BT_HCI_CMD_BIT(42, 4)
>  struct bt_hci_cmd_le_reject_cis {
>         uint16_t handle;
>         uint8_t  reason;
>  } __attribute__ ((packed));
>
> -#define BT_HCI_CMD_LE_CREATE_BIG               BT_HCI_CMD_5_2 + 8
> -#define BT_HCI_BIT_LE_CREATE_BIG               BT_HCI_BIT_5_2 + 8
> +#define BT_HCI_CMD_LE_CREATE_BIG               0x2068
> +#define BT_HCI_BIT_LE_CREATE_BIG               BT_HCI_CMD_BIT(42, 5)
>  struct bt_hci_bis {
>         uint8_t  sdu_interval[3];
>         uint16_t sdu;
> @@ -2705,8 +2701,8 @@ struct bt_hci_cmd_le_create_big {
>         struct bt_hci_bis bis[0];
>  } __attribute__ ((packed));
>
> -#define BT_HCI_CMD_LE_CREATE_BIG_TEST          BT_HCI_CMD_5_2 + 9
> -#define BT_HCI_BIT_LE_CREATE_BIG_TEST          BT_HCI_BIT_5_2 + 9
> +#define BT_HCI_CMD_LE_CREATE_BIG_TEST          0x2069
> +#define BT_HCI_BIT_LE_CREATE_BIG_TEST          BT_HCI_CMD_BIT(42, 6)
>  struct bt_hci_bis_test {
>         uint8_t  sdu_interval[3];
>         uint16_t iso_interval;
> @@ -2731,15 +2727,15 @@ struct bt_hci_cmd_le_create_big_test {
>         struct bt_hci_bis_test bis[0];
>  } __attribute__ ((packed));
>
> -#define BT_HCI_CMD_LE_TERM_BIG                 BT_HCI_CMD_5_2 + 10
> -#define BT_HCI_BIT_LE_TERM_BIG                 BT_HCI_BIT_5_2 + 10
> +#define BT_HCI_CMD_LE_TERM_BIG                 0x206a
> +#define BT_HCI_BIT_LE_TERM_BIG                 BT_HCI_CMD_BIT(42, 7)
>  struct bt_hci_cmd_le_term_big {
>         uint8_t  big_id;
>         uint8_t  reason;
>  } __attribute__ ((packed));
>
> -#define BT_HCI_CMD_LE_BIG_CREATE_SYNC          BT_HCI_CMD_5_2 + 11
> -#define BT_HCI_BIT_LE_BIG_CREATE_SYNC          BT_HCI_BIT_5_2 + 11
> +#define BT_HCI_CMD_LE_BIG_CREATE_SYNC          0x206b
> +#define BT_HCI_BIT_LE_BIG_CREATE_SYNC          BT_HCI_CMD_BIT(43, 0)
>  struct bt_hci_bis_sync {
>  } __attribute__ ((packed));
>
> @@ -2754,20 +2750,20 @@ struct bt_hci_cmd_le_big_create_sync {
>         struct bt_hci_bis_sync bis[0];
>  } __attribute__ ((packed));
>
> -#define BT_HCI_CMD_LE_BIG_TERM_SYNC            BT_HCI_CMD_5_2 + 12
> -#define BT_HCI_BIT_LE_BIG_TERM_SYNC            BT_HCI_BIT_5_2 + 12
> +#define BT_HCI_CMD_LE_BIG_TERM_SYNC            0x206c
> +#define BT_HCI_BIT_LE_BIG_TERM_SYNC            BT_HCI_CMD_BIT(43, 1)
>  struct bt_hci_cmd_le_big_term_sync {
>         uint8_t  big_id;
>  } __attribute__ ((packed));
>
> -#define BT_HCI_CMD_LE_REQ_PEER_SCA             BT_HCI_CMD_5_2 + 13
> -#define BT_HCI_BIT_LE_REQ_PEER_SCA             BT_HCI_BIT_5_2 + 13
> +#define BT_HCI_CMD_LE_REQ_PEER_SCA             0x206d
> +#define BT_HCI_BIT_LE_REQ_PEER_SCA             BT_HCI_CMD_BIT(43, 2)
>  struct bt_hci_cmd_le_req_peer_sca {
>         uint16_t handle;
>  } __attribute__ ((packed));
>
> -#define BT_HCI_CMD_LE_SETUP_ISO_PATH           BT_HCI_CMD_5_2 + 14
> -#define BT_HCI_BIT_LE_SETUP_ISO_PATH           BT_HCI_BIT_5_2 + 14
> +#define BT_HCI_CMD_LE_SETUP_ISO_PATH           0x206e
> +#define BT_HCI_BIT_LE_SETUP_ISO_PATH           BT_HCI_CMD_BIT(43, 3)
>  struct bt_hci_cmd_le_setup_iso_path {
>         uint16_t handle;
>         uint8_t  direction;
> @@ -2780,24 +2776,31 @@ struct bt_hci_cmd_le_setup_iso_path {
>         uint8_t  codec_cfg[0];
>  } __attribute__ ((packed));
>
> -#define BT_HCI_CMD_LE_REMOVE_ISO_PATH          BT_HCI_CMD_5_2 + 15
> -#define BT_HCI_BIT_LE_REMOVE_ISO_PATH          BT_HCI_BIT_5_2 + 15
> +#define BT_HCI_CMD_LE_REMOVE_ISO_PATH          0x206f
> +#define BT_HCI_BIT_LE_REMOVE_ISO_PATH          BT_HCI_CMD_BIT(43, 4)
>  struct bt_hci_cmd_le_remove_iso_path {
>         uint16_t handle;
>         uint8_t  path_dir;
>  } __attribute__ ((packed));
>
> -#define BT_HCI_CMD_LE_ISO_TX_TEST              BT_HCI_CMD_5_2 + 16
> -#define BT_HCI_BIT_LE_ISO_TX_TEST              BT_HCI_BIT_5_2 + 16
> +#define BT_HCI_CMD_LE_ISO_TX_TEST              0x2070
> +#define BT_HCI_BIT_LE_ISO_TX_TEST              BT_HCI_CMD_BIT(43, 5)
> +
> +#define BT_HCI_CMD_LE_ISO_RX_TEST              0x2071
> +#define BT_HCI_BIT_LE_ISO_RX_TEST              BT_HCI_CMD_BIT(43, 6)
>
> -#define BT_HCI_CMD_LE_ISO_RX_TEST              BT_HCI_CMD_5_2 + 17
> -#define BT_HCI_BIT_LE_ISO_RX_TEST              BT_HCI_BIT_5_2 + 17
> +#define BT_HCI_CMD_LE_ISO_READ_TEST_COUNTER    0x2072
> +#define BT_HCI_BIT_LE_ISO_READ_TEST_COUNTER    BT_HCI_CMD_BIT(43, 7)
>
> -#define BT_HCI_CMD_LE_ISO_READ_TEST_COUNTER    BT_HCI_CMD_5_2 + 18
> -#define BT_HCI_BIT_LE_ISO_READ_TEST_COUNTER    BT_HCI_BIT_5_2 + 18
> +#define BT_HCI_CMD_LE_ISO_TEST_END             0x2073
> +#define BT_HCI_BIT_LE_ISO_TEST_END             BT_HCI_CMD_BIT(44, 0)
>
> -#define BT_HCI_CMD_LE_ISO_TEST_END             BT_HCI_CMD_5_2 + 19
> -#define BT_HCI_BIT_LE_ISO_TEST_END             BT_HCI_BIT_5_2 + 19
> +#define BT_HCI_CMD_LE_SET_HOST_FEATURE         0x2074
> +#define BT_HCI_BIT_LE_SET_HOST_FEATURE         BT_HCI_CMD_BIT(44, 1)
> +struct bt_hci_cmd_le_set_host_feature {
> +       uint8_t  bit_number;
> +       uint8_t  bit_value;
> +} __packed;
>
>  #define BT_HCI_EVT_INQUIRY_COMPLETE            0x01
>  struct bt_hci_evt_inquiry_complete {
> @@ -3155,7 +3158,7 @@ struct bt_hci_evt_keypress_notify {
>
>  #define BT_HCI_EVT_REMOTE_HOST_FEATURES_NOTIFY 0x3d
>  struct bt_hci_evt_remote_host_features_notify {
> -       uint8_t  bdaddr[6];
> +uint8_t  bdaddr[6];
>         uint8_t  features[8];
>  } __attribute__ ((packed));
>
> @@ -3498,7 +3501,7 @@ struct bt_hci_evt_le_per_adv_sync_trans_rec {
>         uint8_t  clock_accuracy;
>  } __attribute__ ((packed));
>
> -#define BT_HCI_EVT_LE_CIS_ESTABLISHED          BT_HCI_SUBEVT_5_2
> +#define BT_HCI_EVT_LE_CIS_ESTABLISHED                  0x19
>  struct bt_hci_evt_le_cis_established {
>         uint8_t  status;
>         uint16_t conn_handle;
> @@ -3518,7 +3521,7 @@ struct bt_hci_evt_le_cis_established {
>         uint16_t interval;
>  } __attribute__ ((packed));
>
> -#define BT_HCI_EVT_LE_CIS_REQ                  BT_HCI_SUBEVT_5_2 + 1
> +#define BT_HCI_EVT_LE_CIS_REQ                          0x1a
>  struct bt_hci_evt_le_cis_req {
>         uint16_t acl_handle;
>         uint16_t cis_handle;
> @@ -3526,7 +3529,7 @@ struct bt_hci_evt_le_cis_req {
>         uint8_t  cis_id;
>  } __attribute__ ((packed));
>
> -#define BT_HCI_EVT_LE_BIG_COMPLETE             BT_HCI_SUBEVT_5_2 + 2
> +#define BT_HCI_EVT_LE_BIG_COMPLETE                     0x1b
>  struct bt_hci_evt_le_big_complete {
>         uint8_t  status;
>         uint8_t  big_id;
> @@ -3537,13 +3540,13 @@ struct bt_hci_evt_le_big_complete {
>         uint16_t handle[0];
>  } __attribute__ ((packed));
>
> -#define BT_HCI_EVT_LE_BIG_TERMINATE            BT_HCI_SUBEVT_5_2 + 3
> +#define BT_HCI_EVT_LE_BIG_TERMINATE                    0x1c
>  struct bt_hci_evt_le_big_terminate {
>         uint8_t  reason;
>         uint8_t  big_id;
>  } __attribute__ ((packed));
>
> -#define BT_HCI_EVT_LE_BIG_SYNC_ESTABILISHED    BT_HCI_SUBEVT_5_2 + 4
> +#define BT_HCI_EVT_LE_BIG_SYNC_ESTABILISHED            0x1d
>  struct bt_hci_evt_le_big_sync_estabilished {
>         uint8_t  status;
>         uint8_t  big_id;
> @@ -3552,13 +3555,13 @@ struct bt_hci_evt_le_big_sync_estabilished {
>         uint16_t handle[0];
>  } __attribute__ ((packed));
>
> -#define BT_HCI_EVT_LE_BIG_SYNC_LOST            BT_HCI_SUBEVT_5_2 + 5
> +#define BT_HCI_EVT_LE_BIG_SYNC_LOST                    0x1e
>  struct bt_hci_evt_le_big_sync_lost {
>         uint8_t  big_id;
>         uint8_t  reason;
>  } __attribute__ ((packed));
>
> -#define BT_HCI_EVT_LE_REQ_PEER_SCA_COMPLETE    BT_HCI_SUBEVT_5_2 + 6
> +#define BT_HCI_EVT_LE_REQ_PEER_SCA_COMPLETE            0x1f
>  struct bt_hci_evt_le_req_peer_sca_complete {
>         uint8_t  status;
>         uint16_t handle;
> --
> 2.25.3

Pushed.

-- 
Luiz Augusto von Dentz
