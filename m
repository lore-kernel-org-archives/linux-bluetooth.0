Return-Path: <SRS0=zBKN=5Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866B7C43331
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Mar 2020 19:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D27A212CC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Mar 2020 19:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UIs5M7yg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbgCaTTV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Mar 2020 15:19:21 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36266 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbgCaTTU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Mar 2020 15:19:20 -0400
Received: by mail-lj1-f195.google.com with SMTP id b1so2668042ljp.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2020 12:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y8b+fY+FSOhIQyquVtH2+ZFjRjsJrgUrVeSm/zV2Y8w=;
        b=UIs5M7ygqRK67Ww+DhfEj7FEK3mJoDmLbYmOG91Q9EJbR0vYOQ1PmOOCLd7CRBeOQT
         jju06ncbVeDi84TVOt91mVnYvJUt680+AUfAWvjPbzsdaXlHgdWVXnntCowwefgxzn9h
         l9MuLypriLQ9QwWhZ+zLiOvO8vJnj+LqXJQHATWG/yIfYMjHKyrK+ZsPK9Dg1R/twJkP
         ku4UKoKqXrjgoVgV/nYB4W/j3LyVcFWQHfXEJ/ZDEzE9690qegv0HM1aVOqdriyQ+tSY
         22EBJRPh91oa8EPrcJTErJ9F7TnMdRvLxepqMhcN7nYF8Pc2gNLT0k50+5eFnr2ZWhQd
         ltEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y8b+fY+FSOhIQyquVtH2+ZFjRjsJrgUrVeSm/zV2Y8w=;
        b=tmU34JaKivlOm/HZX0vzorIlo7hSr9c4Sg6UYKvVmAg4msOICr/hG1VegwsB+krwKw
         hTodLnyy3WCE3/Y+Neu+tHH6+9w/pHJh7IjvodTl16HqulUQ1jLTVImiDRsvQLTdT+uw
         0NcIVVMq0Rngbm/lJKBMiYVXnnzH0mmeo0Xw8vEevrhg2tbPFxZ5byOd5kBTn9X4jU4O
         UIHk/ZQPOQ/hZtZsFiUVb/h//17nt4epMK2lVVZ9J+8Pd2b5/SUDLprb+5DI+yTpKPWo
         QDup68UJ5lhI58o+EKzZoGI8bUC188Ode5eXnbxcRkVOHIdorklIHo7Nzeyy6/ANJ8G7
         3VUQ==
X-Gm-Message-State: AGi0PuY+qje9jeCrSf8IkPeYHMH/TM9Bv21OmPd8GfJ6RdWqBLc431f6
        1eAXuV7mPAemx3vHZeZReqyvrWi1+n6JL/xvCaTGrMah
X-Google-Smtp-Source: APiQypLZbh79652Jv6BtfmXUJDyqwQ7cbKYdQ/DmslVPaTdpIXkWIGz0KAs1q+9NbBHh5xfZ3ISVpN+ULhKQnzw7HSU=
X-Received: by 2002:a2e:99c9:: with SMTP id l9mr11633826ljj.79.1585682357722;
 Tue, 31 Mar 2020 12:19:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200331132831.443518-1-marcel@holtmann.org>
In-Reply-To: <20200331132831.443518-1-marcel@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Tue, 31 Mar 2020 15:19:06 -0400
Message-ID: <CALWDO_WskBZnYwja=g-hfvUgAQgt9im7cK5U197cKhdGd+3Gng@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Add support for Read Local Simple Pairing Options
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,


On Tue, Mar 31, 2020 at 9:28 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> With the Read Local Simple Pairing Options command it is possible to
> retrieve the support for max encryption key size supported by the
> controller and also if the controller correctly verifies the ECDH public
> key during pairing.
>
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h      |  7 +++++++
>  include/net/bluetooth/hci_core.h |  2 ++
>  net/bluetooth/hci_core.c         |  4 ++++
>  net/bluetooth/hci_event.c        | 21 +++++++++++++++++++++
>  4 files changed, 34 insertions(+)
>
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 5f60e135aeb6..a495964d5553 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -1272,6 +1272,13 @@ struct hci_rp_read_data_block_size {
>
>  #define HCI_OP_READ_LOCAL_CODECS       0x100b
>
> +#define HCI_OP_READ_LOCAL_PAIRING_OPTS 0x100c
> +struct hci_rp_read_local_pairing_opts {
> +       __u8     status;
> +       __u8     pairing_opts;
> +       __u8     max_key_size;
> +} __packed;
> +
>  #define HCI_OP_READ_PAGE_SCAN_ACTIVITY 0x0c1b
>  struct hci_rp_read_page_scan_activity {
>         __u8     status;
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index d4e28773d378..228b5021060c 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -312,6 +312,8 @@ struct hci_dev {
>         __u16           conn_info_max_age;
>         __u16           auth_payload_timeout;
>         __u8            min_enc_key_size;
> +       __u8            max_enc_key_size;
> +       __u8            pairing_opts;
>         __u8            ssp_debug_mode;
>         __u8            hw_error_code;
>         __u32           clock;
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 2e7bc2da8371..331759878b3c 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -826,6 +826,10 @@ static int hci_init4_req(struct hci_request *req, unsigned long opt)
>         if (hdev->commands[29] & 0x20)
>                 hci_req_add(req, HCI_OP_READ_LOCAL_CODECS, 0, NULL);
>
> +       /* Read local pairing options if the HCI command is supported */
> +       if (hdev->commands[41] & 0x08)
> +               hci_req_add(req, HCI_OP_READ_LOCAL_PAIRING_OPTS, 0, NULL);
> +
>         /* Get MWS transport configuration if the HCI command is supported */
>         if (hdev->commands[30] & 0x08)
>                 hci_req_add(req, HCI_OP_GET_MWS_TRANSPORT_CONFIG, 0, NULL);
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 0a591be8b0ae..ca7a00e9312a 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -746,6 +746,23 @@ static void hci_cc_read_bd_addr(struct hci_dev *hdev, struct sk_buff *skb)
>                 bacpy(&hdev->setup_addr, &rp->bdaddr);
>  }
>
> +static void hci_cc_read_local_pairing_opts(struct hci_dev *hdev,
> +                                          struct sk_buff *skb)
> +{
> +       struct hci_rp_read_local_pairing_opts *rp = (void *) skb->data;
> +
> +       BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
> +
> +       if (rp->status)
> +               return;
> +
> +       if (hci_dev_test_flag(hdev, HCI_SETUP) ||
> +           hci_dev_test_flag(hdev, HCI_CONFIG)) {
> +               hdev->pairing_opts = rp->pairing_opts;
> +               hdev->max_enc_key_size = rp->max_key_size;
> +       }
> +}
> +
>  static void hci_cc_read_page_scan_activity(struct hci_dev *hdev,
>                                            struct sk_buff *skb)
>  {
> @@ -3334,6 +3351,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
>                 hci_cc_read_bd_addr(hdev, skb);
>                 break;
>
> +       case HCI_OP_READ_LOCAL_PAIRING_OPTS:
> +               hci_cc_read_local_pairing_opts(hdev, skb);
> +               break;
> +
>         case HCI_OP_READ_PAGE_SCAN_ACTIVITY:
>                 hci_cc_read_page_scan_activity(hdev, skb);
>                 break;
> --
> 2.25.1
>

LGTM.

Thanks,
Alain
