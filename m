Return-Path: <SRS0=CkcR=5T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F9FC43331
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 15:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F9A1206F6
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 15:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wMLRbEZb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbgDCPo0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Apr 2020 11:44:26 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43876 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbgDCPoZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Apr 2020 11:44:25 -0400
Received: by mail-lf1-f65.google.com with SMTP id n20so6138475lfl.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Apr 2020 08:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o9OIp6dbRHBVsH9fZHGiOK95mjakmTUESbJGhHNFhds=;
        b=wMLRbEZbgJ+TNy3NeKgNDHwFO5inFqTCh3Mry6NYyDhZO++cizzKZ63shOw1frrJUr
         8RO5uphh24C2RKoYAF+5mfHIdJAmdkwqy9hgIT813L6/4Z0k9kzuVUwaA+GUhZebIGWD
         8HAlusXkpHVTiHzFt16i7RvOg1FFxOaK36gxBPF8CFq/8VH3Jjrxzhpa/V9s1tcIjYwS
         C4JnFQ46Rssv6RTQ9AiPNMe6eF6Cr5hTbUAJV6Yy8C2+p1Tjlhq4EmT6gnf4PrgmK674
         t/qmk1LXGs5DQ+r4auh8VwDmidflWCUb/q23kE1nNHSnnaVxBx9QtgOLwJ0AIedzuElA
         pMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o9OIp6dbRHBVsH9fZHGiOK95mjakmTUESbJGhHNFhds=;
        b=OszkDUs9TLZKT+uSZ183JlzWP+hfIJDTNXNLoOjIN7Yka66qGPT/IsMiZAYx329Ynu
         NKuplqyrXulHkiRhzQaXSbJ/4AOwLtqJOJYQLAnzaxmGPnxmbpriVKTFmYBxF1BpVPyL
         SxnsHWD7D9cZ29rwubBI41DgnRyW4JzkK5TElk+ji/dplcN10gIuiF0AQkh2TlwAl8xW
         zWlD9+hxKW89uchOj4e9lft4M55lkdCnlPZ3eZtrUyMgRS6TWqDg2FEJAgj2G4OmwPKv
         ZYLRgRbz1XcfS2DwBrMBPuMrYRq7Eb+ZB8SH1+kYzqADKmWw8U3Zl37VnYSWHENxbAgx
         qQ7g==
X-Gm-Message-State: AGi0PubC12PAoHK9y+jZO1K4jybwCxKYnQn5FAF/0c3GdWpXcXqfCIlX
        iB9xPAXmp+4WEYmU3pi+tVWuznlcFzCwJ3VOSp8liDOz
X-Google-Smtp-Source: APiQypKu+oUsCPnGqY2hCIFrNH7hxPR21kHYCAnMLRFnQiEZiMjk0bkzk/AAP9c0LIQxYyWLlsm/KYSVMxhwbAbiacg=
X-Received: by 2002:ac2:539a:: with SMTP id g26mr1554161lfh.129.1585928662339;
 Fri, 03 Apr 2020 08:44:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200402132956.642267-1-marcel@holtmann.org>
In-Reply-To: <20200402132956.642267-1-marcel@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Fri, 3 Apr 2020 11:44:11 -0400
Message-ID: <CALWDO_X-cN4pba3BiSKD7BP5KokaTcDefgyTZeXv0hbxz+LECA@mail.gmail.com>
Subject: Re: [PATCH 1/2] Bluetooth: Add support for reading security information
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

HI Marcel,


On Thu, Apr 2, 2020 at 9:30 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> To allow userspace to make correcty security policy decision, the kernel
> needs to export a few details of the supported security features and
> encryption key size information. This command exports this information
> and also allows future extensions if needed.
>
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/mgmt.h |  7 +++++
>  net/bluetooth/mgmt.c         | 53 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 60 insertions(+)
>
> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> index f41cd87550dc..65dd6fd1fff3 100644
> --- a/include/net/bluetooth/mgmt.h
> +++ b/include/net/bluetooth/mgmt.h
> @@ -674,6 +674,13 @@ struct mgmt_cp_set_blocked_keys {
>
>  #define MGMT_OP_SET_WIDEBAND_SPEECH    0x0047
>
> +#define MGMT_OP_READ_SECURITY_INFO     0x0048
> +#define MGMT_READ_SECURITY_INFO_SIZE   0
> +struct mgmt_rp_read_security_info {
> +       __le16   sec_len;
> +       __u8     sec[0];
> +} __packed;
> +
>  #define MGMT_EV_CMD_COMPLETE           0x0001
>  struct mgmt_ev_cmd_complete {
>         __le16  opcode;
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 6552003a170e..7b9eac339c87 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -108,6 +108,7 @@ static const u16 mgmt_commands[] = {
>         MGMT_OP_SET_APPEARANCE,
>         MGMT_OP_SET_BLOCKED_KEYS,
>         MGMT_OP_SET_WIDEBAND_SPEECH,
> +       MGMT_OP_READ_SECURITY_INFO,
>  };
>
>  static const u16 mgmt_events[] = {
> @@ -155,6 +156,7 @@ static const u16 mgmt_untrusted_commands[] = {
>         MGMT_OP_READ_CONFIG_INFO,
>         MGMT_OP_READ_EXT_INDEX_LIST,
>         MGMT_OP_READ_EXT_INFO,
> +       MGMT_OP_READ_SECURITY_INFO,
>  };
>
>  static const u16 mgmt_untrusted_events[] = {
> @@ -3659,6 +3661,55 @@ static int set_wideband_speech(struct sock *sk, struct hci_dev *hdev,
>         return err;
>  }
>
> +static int read_security_info(struct sock *sk, struct hci_dev *hdev,
> +                             void *data, u16 data_len)
> +{
> +       char buf[16];
> +       struct mgmt_rp_read_security_info *rp = (void *)buf;
> +       u16 sec_len = 0;
> +       u8 flags = 0;
> +
> +       bt_dev_dbg(hdev, "sock %p", sk);
> +
> +       memset(&buf, 0, sizeof(buf));
> +
> +       hci_dev_lock(hdev);
> +
> +       /* When the Read Simple Pairing Options command is supported, then
> +        * the remote public key validation is supported.
> +        */
> +       if (hdev->commands[41] & 0x08)
> +               flags |= 0x01;  /* Remote public key validation (BR/EDR) */
> +
> +       flags |= 0x02;          /* Remote public key validation (LE) */
> +
> +       /* When the Read Encryption Key Size command is supported, then the
> +        * encryption key size is enforced.
> +        */
> +       if (hdev->commands[20] & 0x10)
> +               flags |= 0x04;  /* Encryption key size enforcement (BR/EDR) */
> +
> +       flags |= 0x08;          /* Encryption key size enforcement (LE) */
> +
> +       sec_len = eir_append_data(rp->sec, sec_len, 0x01, &flags, 1);
> +
> +       /* When the Read Simple Pairing Options command is supported, then
> +        * also max encryption key size information is provided.
> +        */
> +       if (hdev->commands[41] & 0x08)
> +               sec_len = eir_append_le16(rp->sec, sec_len, 0x02,
> +                                         hdev->max_enc_key_size);
> +
> +       sec_len = eir_append_le16(rp->sec, sec_len, 0x03, SMP_MAX_ENC_KEY_SIZE);
> +
> +       rp->sec_len = cpu_to_le16(sec_len);
> +
> +       hci_dev_unlock(hdev);
> +
> +       return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_READ_SECURITY_INFO, 0,
> +                                rp, sizeof(*rp) + sec_len);
> +}
> +
>  static void read_local_oob_data_complete(struct hci_dev *hdev, u8 status,
>                                          u16 opcode, struct sk_buff *skb)
>  {
> @@ -7099,6 +7150,8 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
>         { set_blocked_keys,        MGMT_OP_SET_BLOCKED_KEYS_SIZE,
>                                                 HCI_MGMT_VAR_LEN },
>         { set_wideband_speech,     MGMT_SETTING_SIZE },
> +       { read_security_info,      MGMT_READ_SECURITY_INFO_SIZE,
> +                                               HCI_MGMT_UNTRUSTED },
>  };
>
>  void mgmt_index_added(struct hci_dev *hdev)
> --
> 2.25.1
>
LGTM.
