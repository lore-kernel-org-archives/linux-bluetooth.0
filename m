Return-Path: <SRS0=F55x=EI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C65C00A89
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Nov 2020 23:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB1CA22280
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Nov 2020 23:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0UZ1JKX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgKBX3R (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Nov 2020 18:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgKBX3R (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Nov 2020 18:29:17 -0500
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D418C0617A6
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2020 15:29:17 -0800 (PST)
Received: by mail-oo1-xc44.google.com with SMTP id f1so3788463oov.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2020 15:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=tcpfYZcsnXAmdOxaYPZZUx0G2IPvMai1SiiZMCWYVxU=;
        b=X0UZ1JKXt0LdGQNfMm3tM+UAL43T1Er0XnQM1DhZwMoRAFfZOx0+Ys8R0U1RkfUI5K
         +JIDzexJ8A8IwWnC2Dfh0jMQ4wc9cUcc8LUOz1hDw5JiVijcRDSV7i+7LCaVJZaEPsU0
         xtzGRWAspqrajCRufq4dR+zz7osndxpBY18+D9cujqMH+I9puHRe4vdHA+hw876M2tVY
         ajFm8R46u1tk4v3Bizqw1oHwu17HDtFQ45MdRVkDHRxMrXlCMCmTylVi19aTsRt49oW/
         QNFySezZSOiwLQC6j90NQw2m/IOdpUmaM/FK6ntVKS3O2Ljxk3mU6wmu2ddjtLfb7AO5
         BU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=tcpfYZcsnXAmdOxaYPZZUx0G2IPvMai1SiiZMCWYVxU=;
        b=kQ+QfxgG7FZWKfl6ht8gcp2++wDiY9CqNydogtIZEQ59hsjzk23sYmLwlO51wVmdFT
         F64ib7gBQ1bZxDIut2SmNPaM9xbprU9N6TT3XcELZrHg6Vyht6E5h/Jr9KRr5/mCx2LA
         Pr7JXL6rLNxQyB9CfeTH6VLcgkwg3yFqnB0aBWaAoNKVAi9SygcuO3yg7XmdNxA2nK9h
         betZXWpfoq0mK5rPqTOVRKbDTS7euMwpI+OzCg1S+Kzwc6Wc5QeHiiEnV6UL6fESta37
         k5eQvIyO/eYmiWMP6LrTMhQU4MwBFFO6ltvBGvWtgSnNPR3UCu6eKsTqfRnM0sTEHJqf
         LrIw==
X-Gm-Message-State: AOAM533+YmMLQq/tKV3Ad8HoMqZYzFMdO1VznnVjx4QRNYsnXEKOOIpV
        yX5M3S+vNEoNIzV+s+gyf/drQP5uNruIXC/PLY1cN4h2M0g=
X-Google-Smtp-Source: ABdhPJxlTqHTjjIiNjEqos3oW1N02WU4mDG7r9Ersg2QxXXi9J2i1mlbikQXDUgvxtq3Dh9YlVg0peujHN+DLqiLOpQ=
X-Received: by 2002:a4a:e04a:: with SMTP id v10mr13544272oos.24.1604359756485;
 Mon, 02 Nov 2020 15:29:16 -0800 (PST)
MIME-Version: 1.0
References: <20201102191232.1848737-1-luiz.dentz@gmail.com>
In-Reply-To: <20201102191232.1848737-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 2 Nov 2020 15:29:05 -0800
Message-ID: <CABBYNZJqCzoBfP4O98JjUdt7LtqDVoX6kteuxXpNFmNmWcK81Q@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] emulator/btdev: Add debug support
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Mon, Nov 2, 2020 at 11:12 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This adds btdev_set_debug which can be used to debug internals of
> btdev.
> ---
>  emulator/btdev.c | 99 +++++++++++++++++++++++++-----------------------
>  emulator/btdev.h |  5 +++
>  2 files changed, 57 insertions(+), 47 deletions(-)
>
> diff --git a/emulator/btdev.c b/emulator/btdev.c
> index ca87681a6..c89815b3e 100644
> --- a/emulator/btdev.c
> +++ b/emulator/btdev.c
> @@ -144,6 +144,10 @@ struct btdev {
>         uint8_t  sync_train_service_data;
>
>         uint16_t le_ext_adv_type;
> +
> +       btdev_debug_func_t debug_callback;
> +       btdev_destroy_func_t debug_destroy;
> +       void *debug_data;
>  };
>
>  struct inquiry_data {
> @@ -257,45 +261,6 @@ static inline struct btdev *find_btdev_by_bdaddr_type(const uint8_t *bdaddr,
>         return NULL;
>  }
>
> -static void hexdump(const unsigned char *buf, uint16_t len)
> -{
> -       static const char hexdigits[] = "0123456789abcdef";
> -       char str[68];
> -       uint16_t i;
> -
> -       if (!len)
> -               return;
> -
> -       for (i = 0; i < len; i++) {
> -               str[((i % 16) * 3) + 0] = hexdigits[buf[i] >> 4];
> -               str[((i % 16) * 3) + 1] = hexdigits[buf[i] & 0xf];
> -               str[((i % 16) * 3) + 2] = ' ';
> -               str[(i % 16) + 49] = isprint(buf[i]) ? buf[i] : '.';
> -
> -               if ((i + 1) % 16 == 0) {
> -                       str[47] = ' ';
> -                       str[48] = ' ';
> -                       str[65] = '\0';
> -                       printf("%-12c%s\n", ' ', str);
> -                       str[0] = ' ';
> -               }
> -       }
> -
> -       if (i % 16 > 0) {
> -               uint16_t j;
> -               for (j = (i % 16); j < 16; j++) {
> -                       str[(j * 3) + 0] = ' ';
> -                       str[(j * 3) + 1] = ' ';
> -                       str[(j * 3) + 2] = ' ';
> -                       str[j + 49] = ' ';
> -               }
> -               str[47] = ' ';
> -               str[48] = ' ';
> -               str[65] = '\0';
> -               printf("%-12c%s\n", ' ', str);
> -       }
> -}
> -
>  static void get_bdaddr(uint16_t id, uint8_t index, uint8_t *bdaddr)
>  {
>         bdaddr[0] = id & 0xff;
> @@ -768,6 +733,22 @@ void btdev_destroy(struct btdev *btdev)
>         free(btdev);
>  }
>
> +bool btdev_set_debug(struct btdev *btdev, btdev_debug_func_t callback,
> +                       void *user_data, btdev_destroy_func_t destroy)
> +{
> +       if (!btdev)
> +               return false;
> +
> +       if (btdev->debug_destroy)
> +               btdev->debug_destroy(btdev->debug_data);
> +
> +       btdev->debug_callback = callback;
> +       btdev->debug_destroy = destroy;
> +       btdev->debug_data = user_data;
> +
> +       return true;
> +}
> +
>  const uint8_t *btdev_get_bdaddr(struct btdev *btdev)
>  {
>         return btdev->bdaddr;
> @@ -824,9 +805,20 @@ void btdev_set_send_handler(struct btdev *btdev, btdev_send_func handler,
>  static void send_packet(struct btdev *btdev, const struct iovec *iov,
>                                                                 int iovlen)
>  {
> +       int i;
> +
>         if (!btdev->send_handler)
>                 return;
>
> +       for (i = 0; i < iovlen; i++) {
> +               if (!i)
> +                       util_hexdump('<', iov[i].iov_base, iov[i].iov_len,
> +                               btdev->debug_callback, btdev->debug_data);
> +               else
> +                       util_hexdump(' ', iov[i].iov_base, iov[i].iov_len,
> +                               btdev->debug_callback, btdev->debug_data);
> +       }
> +
>         btdev->send_handler(iov, iovlen, btdev->send_data);
>  }
>
> @@ -837,6 +829,9 @@ static void send_event(struct btdev *btdev, uint8_t event,
>         struct iovec iov[3];
>         uint8_t pkt = BT_H4_EVT_PKT;
>
> +       util_debug(btdev->debug_callback, btdev->debug_data,
> +                               "event 0x%02x", event);
> +
>         iov[0].iov_base = &pkt;
>         iov[0].iov_len = sizeof(pkt);
>
> @@ -863,6 +858,9 @@ static void send_cmd(struct btdev *btdev, uint8_t evt, uint16_t opcode,
>         uint8_t pkt = BT_H4_EVT_PKT;
>         int i;
>
> +       util_debug(btdev->debug_callback, btdev->debug_data,
> +                               "event 0x%02x opcode 0x%04x", evt, opcode);
> +
>         iov2[0].iov_base = &pkt;
>         iov2[0].iov_len = sizeof(pkt);
>
> @@ -921,6 +919,9 @@ static void le_meta_event(struct btdev *btdev, uint8_t event,
>  {
>         void *pkt_data;
>
> +       util_debug(btdev->debug_callback, btdev->debug_data,
> +                               "meta event 0x%02x", event);
> +
>         pkt_data = alloca(1 + len);
>         if (!pkt_data)
>                 return;
> @@ -2089,7 +2090,6 @@ static void send_ext_adv(struct btdev *btdev, const struct btdev *remote,
>                                         uint16_t type, bool is_scan_rsp)
>  {
>         struct __packed {
> -               uint8_t subevent;
>                 uint8_t num_reports;
>                 union {
>                         struct bt_hci_le_ext_adv_report lear;
> @@ -2097,8 +2097,6 @@ static void send_ext_adv(struct btdev *btdev, const struct btdev *remote,
>                 };
>         } meta_event;
>
> -       meta_event.subevent = BT_HCI_EVT_LE_EXT_ADV_REPORT;
> -
>         memset(&meta_event.lear, 0, sizeof(meta_event.lear));
>         meta_event.num_reports = 1;
>         meta_event.lear.event_type = cpu_to_le16(type);
> @@ -2121,8 +2119,8 @@ static void send_ext_adv(struct btdev *btdev, const struct btdev *remote,
>                                                 meta_event.lear.data_len);
>         }
>
> -       send_event(btdev, BT_HCI_EVT_LE_META_EVENT, &meta_event,
> -                                       1 + 1 + 24 + meta_event.lear.data_len);
> +       le_meta_event(btdev, BT_HCI_EVT_LE_EXT_ADV_REPORT, &meta_event,
> +                                       1 + 24 + meta_event.lear.data_len);
>  }
>
>  static uint8_t get_adv_report_type(uint8_t adv_type)
> @@ -3952,8 +3950,8 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
>         return;
>
>  unsupported:
> -       printf("Unsupported command 0x%4.4x\n", opcode);
> -       hexdump(data, len);
> +       util_debug(btdev->debug_callback, btdev->debug_data,
> +                       "Unsupported command 0x%4.4x\n", opcode);
>         cmd_status(btdev, BT_HCI_ERR_UNKNOWN_COMMAND, opcode);
>  }
>
> @@ -4267,6 +4265,9 @@ static void process_cmd(struct btdev *btdev, const void *data, uint16_t len)
>         callback.data = data + sizeof(*hdr);
>         callback.len = hdr->plen;
>
> +       util_debug(btdev->debug_callback, btdev->debug_data,
> +                               "command 0x%04x", callback.opcode);
> +
>         if (btdev->command_handler)
>                 btdev->command_handler(callback.opcode,
>                                         callback.data, callback.len,
> @@ -4331,6 +4332,9 @@ void btdev_receive_h4(struct btdev *btdev, const void *data, uint16_t len)
>         if (len < 1)
>                 return;
>
> +       util_hexdump('>', data, len, btdev->debug_callback,
> +                                       btdev->debug_data);
> +
>         pkt_type = ((const uint8_t *) data)[0];
>
>         switch (pkt_type) {
> @@ -4348,7 +4352,8 @@ void btdev_receive_h4(struct btdev *btdev, const void *data, uint16_t len)
>                         send_iso(btdev->conn, data, len);
>                 break;
>         default:
> -               printf("Unsupported packet 0x%2.2x\n", pkt_type);
> +               util_debug(btdev->debug_callback, btdev->debug_data,
> +                               "Unsupported packet 0x%2.2x\n", pkt_type);
>                 break;
>         }
>  }
> diff --git a/emulator/btdev.h b/emulator/btdev.h
> index 7cb265f1c..f7cba149a 100644
> --- a/emulator/btdev.h
> +++ b/emulator/btdev.h
> @@ -66,6 +66,11 @@ struct btdev;
>  struct btdev *btdev_create(enum btdev_type type, uint16_t id);
>  void btdev_destroy(struct btdev *btdev);
>
> +typedef void (*btdev_debug_func_t)(const char *str, void *user_data);
> +typedef void (*btdev_destroy_func_t)(void *user_data);
> +bool btdev_set_debug(struct btdev *btdev, btdev_debug_func_t callback,
> +                       void *user_data, btdev_destroy_func_t destroy);
> +
>  const uint8_t *btdev_get_bdaddr(struct btdev *btdev);
>  uint8_t *btdev_get_features(struct btdev *btdev);
>
> --
> 2.26.2
>

Pushed.

-- 
Luiz Augusto von Dentz
