Return-Path: <SRS0=5gFq=DX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74D7C43467
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Oct 2020 18:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8273C2084C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Oct 2020 18:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uc1wseWD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392291AbgJPSfg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Oct 2020 14:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392287AbgJPSfg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Oct 2020 14:35:36 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961D9C061755
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Oct 2020 11:35:36 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id l4so3312309ota.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Oct 2020 11:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fMPqnPU+ZCqNfDQHhL5hIWz7hBobG9aw0hDKIjNhcmc=;
        b=uc1wseWDDHWyfDZgNJ9QUFYb33M+WNDE7xsO9hqpZwq+9rvOaXzSdQBTBoBGerQs+b
         iyOXe8syxOGo2W4fOjE22SR9Ns5Y2fgCkXjSrI5BDlwUSMgcn07dBOh2rTgg0TYs8FpH
         IbpDpad8FCXzPpVn4g+MDz5tFmJtaRYuOclakBRQVZ4j5H9DvGJzjuBMWNdy++YxpxWH
         Ml/CNhKLrbQyN1AZf3FJ+ZtE/P0R9rAHV8h2YxSpcRdUqTxn0+a4Cpvmw59l1lufv4gp
         7aGdxTI4umuEWoodGr2Jp+8lo/QTUXFcB1OHoivV/+EeESHJ1raapVTweEHxaPr4jscY
         uxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fMPqnPU+ZCqNfDQHhL5hIWz7hBobG9aw0hDKIjNhcmc=;
        b=kWktOmsXJiWxc+SL0WTFnc0PKphtxuLAFwqnqI/KhKy2BZyA9lCOXkVQ9kRvBy1H8W
         uAlzrKcO2lfB/VQv8kFgIrju1FYzvdO+fPGE8F6EJAHoaTJjRcQYGsCvGJJohF056AFl
         HWJKwg5dQuYC7/xhbACe/1FfJCzGFEW3T+S6dvKJW7qBUPMqPGgfrtE3l+Rfu1CQCT/b
         NlzRlbUZkobzPv2bNcVar2b2vJJz8t4H2cvEtUF6lWRYwl1ixH6soyZyv4gX+0rH/qwL
         migAYXuD8NSSkwb7VLY9+aMzQNmuFUZSxZ6Cj0BsdhSZuia8QIWiPP60U7V+5uAPHccZ
         QhCQ==
X-Gm-Message-State: AOAM530meUNsJIiOlrPh/RJIa8+PJbd0ZNS5UaZWejD0noRlkaJx+4uw
        ti4O/jekSuZMkbdfcdmnWkmkpSi9kX1w6rqfI5AtpEoHZK0=
X-Google-Smtp-Source: ABdhPJyVtNg/WipAXdr0JFIkiHxgDurOaiywuNloui0b8QXyn1AJ+0+UXvwkoj3xWpx3rMTwu+pp/qpd5yZzhCsKuyM=
X-Received: by 2002:a05:6830:400d:: with SMTP id h13mr3696469ots.371.1602873335651;
 Fri, 16 Oct 2020 11:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <20201016180956.707681-1-luiz.dentz@gmail.com>
In-Reply-To: <20201016180956.707681-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 16 Oct 2020 11:35:24 -0700
Message-ID: <CABBYNZ+ABX=rVAtopUoWc5rFKMcPeooek+OqjESuB4oUzao8FA@mail.gmail.com>
Subject: Re: [PATCH 1/2] Bluetooth: Fix not checking advertisement bondaries
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Andy Nguyen <theflow@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Alain Michaud <alainm@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

Im CC you guys since you appear in the original fix, if you can please
tests the following patch with the malformed advertisement or let me
know how you were able to generate it I would appreciate it.

On Fri, Oct 16, 2020 at 11:09 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> When receiving advertisements check if the length is actually within
> the skb, this also make use of skb_pull to advance on the skb->data
> instead of a custom ptr that way skb->len shall always indicates how
> much data is remaining and can be used to perform checks if there is
> enough data to parse.
>
> Fixes: a2ec905d1e160a33b2e210e45ad30445ef26ce0e ("Bluetooth: fix kernel oops in store_pending_adv_report")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/hci_event.c | 72 ++++++++++++++++++++++++++++++---------
>  1 file changed, 55 insertions(+), 17 deletions(-)
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index a4c3703f2e94..ae31d227730b 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -5599,24 +5599,40 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
>  static void hci_le_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
>  {
>         u8 num_reports = skb->data[0];
> -       void *ptr = &skb->data[1];
>
>         hci_dev_lock(hdev);
>
> +       skb_pull(skb, sizeof(num_reports));
> +
>         while (num_reports--) {
> -               struct hci_ev_le_advertising_info *ev = ptr;
> +               struct hci_ev_le_advertising_info *ev;
>                 s8 rssi;
>
> -               if (ev->length <= HCI_MAX_AD_LENGTH) {
> -                       rssi = ev->data[ev->length];
> -                       process_adv_report(hdev, ev->evt_type, &ev->bdaddr,
> -                                          ev->bdaddr_type, NULL, 0, rssi,
> -                                          ev->data, ev->length, false);
> -               } else {
> -                       bt_dev_err(hdev, "Dropping invalid advertising data");
> +               if (skb->len < sizeof(*ev)) {
> +                       bt_dev_err(hdev, "Malformed advertising report");
> +                       break;
> +               }
> +
> +               ev = (void *) skb->data;
> +               skb_pull(skb, sizeof(*ev));
> +
> +               if (skb->len < ev->length || ev->length > HCI_MAX_AD_LENGTH) {
> +                       bt_dev_err(hdev, "Malformed advertising data");
> +                       break;
>                 }
>
> -               ptr += sizeof(*ev) + ev->length + 1;
> +               skb_pull(skb, ev->length);
> +
> +               if (skb->len < sizeof(rssi)) {
> +                       bt_dev_err(hdev, "Malformed advertising rssi");
> +                       break;
> +               }
> +
> +               rssi = get_unaligned(skb->data);
> +
> +               process_adv_report(hdev, ev->evt_type, &ev->bdaddr,
> +                                  ev->bdaddr_type, NULL, 0, rssi,
> +                                  ev->data, ev->length, false);
>         }
>
>         hci_dev_unlock(hdev);
> @@ -5669,15 +5685,31 @@ static u8 ext_evt_type_to_legacy(struct hci_dev *hdev, u16 evt_type)
>  static void hci_le_ext_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
>  {
>         u8 num_reports = skb->data[0];
> -       void *ptr = &skb->data[1];
>
>         hci_dev_lock(hdev);
>
> +       skb_pull(skb, sizeof(num_reports));
> +
>         while (num_reports--) {
> -               struct hci_ev_le_ext_adv_report *ev = ptr;
> +               struct hci_ev_le_ext_adv_report *ev;
>                 u8 legacy_evt_type;
>                 u16 evt_type;
>
> +               if (skb->len < sizeof(*ev)) {
> +                       bt_dev_err(hdev, "Malformed ext advertising report");
> +                       break;
> +               }
> +
> +               ev = (void *) skb->data;
> +               skb_pull(skb, sizeof(*ev));
> +
> +               if (skb->len < ev->length || ev->length > HCI_MAX_AD_LENGTH) {
> +                       bt_dev_err(hdev, "Malformed ext advertising data");
> +                       break;
> +               }
> +
> +               skb_pull(skb, ev->length);
> +
>                 evt_type = __le16_to_cpu(ev->evt_type);
>                 legacy_evt_type = ext_evt_type_to_legacy(hdev, evt_type);
>                 if (legacy_evt_type != LE_ADV_INVALID) {
> @@ -5687,7 +5719,6 @@ static void hci_le_ext_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
>                                            !(evt_type & LE_EXT_ADV_LEGACY_PDU));
>                 }
>
> -               ptr += sizeof(*ev) + ev->length;
>         }
>
>         hci_dev_unlock(hdev);
> @@ -5873,19 +5904,26 @@ static void hci_le_direct_adv_report_evt(struct hci_dev *hdev,
>                                          struct sk_buff *skb)
>  {
>         u8 num_reports = skb->data[0];
> -       void *ptr = &skb->data[1];
>
>         hci_dev_lock(hdev);
>
> +       skb_pull(skb, sizeof(num_reports));
> +
>         while (num_reports--) {
> -               struct hci_ev_le_direct_adv_info *ev = ptr;
> +               struct hci_ev_le_direct_adv_info *ev;
> +
> +               if (skb->len < sizeof(*ev)) {
> +                       bt_dev_err(hdev, "Malformed direct advertising");
> +                       break;
> +               }
> +
> +               ev = (void *) skb->data;
> +               skb_pull(skb, sizeof(*ev));
>
>                 process_adv_report(hdev, ev->evt_type, &ev->bdaddr,
>                                    ev->bdaddr_type, &ev->direct_addr,
>                                    ev->direct_addr_type, ev->rssi, NULL, 0,
>                                    false);
> -
> -               ptr += sizeof(*ev);
>         }
>
>         hci_dev_unlock(hdev);
> --
> 2.26.2
>


-- 
Luiz Augusto von Dentz
