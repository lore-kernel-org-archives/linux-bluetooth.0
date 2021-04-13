Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FDDC433ED
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Apr 2021 21:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66BFB61176
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Apr 2021 21:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344748AbhDMVQU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Apr 2021 17:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbhDMVQU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Apr 2021 17:16:20 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FBBC061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Apr 2021 14:16:00 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id a21so5346260oib.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Apr 2021 14:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8IRpKI5IpUqx0niUpcfJeLu+UL8jYI5Ms6rA5RbHOMc=;
        b=S1XjhdAWsPlL5BF7UFHJZDogFGQONVVc7ufYauWvjfiGO4i2gH/rTkU5KFJT2VwSwk
         51QXmm1c4V5GiS/5RRyzKaE2Ua4YFduZmjPE+gk/8kARYQ5nAW4sigbgV+WrTRKRJozF
         XbVrFfVUtbgvJOR0m0TfYg4TGHto2W5bgBFxxfBgIJfI7f8AxbINIvRTUmiA7sIICGq1
         3ko96qNul9wQyWiUSgKZY/u8IqWV4uqgsBHK8QLxUgGDRSXzaqwFsIC0GiE7XcE/dIVF
         4dlDYVN9Xu+EAZY+i9SRlwGs4bHJVKO3OWl2so5PI6ve61Rz4SMT/W8rIrxesSRBxfeD
         vklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8IRpKI5IpUqx0niUpcfJeLu+UL8jYI5Ms6rA5RbHOMc=;
        b=OoWQPPhZ/uNz4av0AKwaw8AE4iy5b2bWOCPHhSAsD9DPfaoo6Y3Worow2c5Utb8KfQ
         6gPpLLh2nQ1LnpWQP2xHKXODsrhjlvLmyjpmG7Q+TccAhN2S/dMzHwAUgO8F2lv8WsJ5
         YKHrDMaTNO+OTnER4g5KIS5UjPL2v/bhSaftbmQo5mjuQRbWQCjgeGwDRhxtwqSXxJVc
         H3wOZQz97rRWY4f2OwhBX+fzqg9FWa8YvTN/zpBDumuFwRzuG7vg5qbpUxjK3EzMJRge
         U03HKtsxdVsAIybBb8WqU5Vn3Xc1vAZL36jMDv+QWCK8lMHtlWHVh7yc4hPlcn/iVYLP
         hC2g==
X-Gm-Message-State: AOAM533Egy8YfsFuAU7FhjOq+0eAgnU9+UtoNXAyjMlrQeDf4/3GnhLe
        Q2TBgnfBkS9Bk6rgJdFP7V/y/0X5Ljzwk3lekJJy9x84Fso=
X-Google-Smtp-Source: ABdhPJwKz2Wr4RXqUH8CE/yvdRfZK1Tq+nQIMySWNaWnLUTe6FUSv0SvA/J5kCuxcGUsszf0fYHxicU+DArcMXI09g4=
X-Received: by 2002:a05:6808:10c5:: with SMTP id s5mr1464272ois.58.1618348559379;
 Tue, 13 Apr 2021 14:15:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210412184033.2504931-1-luiz.dentz@gmail.com>
 <20210412184033.2504931-2-luiz.dentz@gmail.com> <D319A29F-E16F-469D-99D9-0770F87BC6D9@holtmann.org>
In-Reply-To: <D319A29F-E16F-469D-99D9-0770F87BC6D9@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 13 Apr 2021 14:15:48 -0700
Message-ID: <CABBYNZJAgEtmnhHOq5k0NPxTgGAcOfoY66REMo1uirwMGwiMUw@mail.gmail.com>
Subject: Re: [RFC 2/2] Bluetooth: HCI: Use bt_skb_pull to parse events
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Tue, Apr 13, 2021 at 12:08 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> > This uses bt_skb_pull to check the events received have the minimum
> > required length, while at it also rework checks for flexible arrays to
> > use flex_array_size.
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> > include/net/bluetooth/hci.h |  59 ++-
> > net/bluetooth/hci_event.c   | 848 ++++++++++++++++++++++++++++--------
> > 2 files changed, 722 insertions(+), 185 deletions(-)
> >
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index ea4ae551c426..13b7c7747bd1 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -1894,6 +1894,10 @@ struct hci_cp_le_reject_cis {
> > } __packed;
> >
> > /* ---- HCI Events ---- */
> > +struct hci_ev_status {
> > +     __u8    status;
> > +} __packed;
> > +
> > #define HCI_EV_INQUIRY_COMPLETE               0x01
> >
> > #define HCI_EV_INQUIRY_RESULT         0x02
> > @@ -1906,6 +1910,11 @@ struct inquiry_info {
> >       __le16   clock_offset;
> > } __packed;
> >
> > +struct hci_ev_inquiry_result {
> > +     __u8    num;
> > +     struct inquiry_info info[];
> > +};
> > +
> > #define HCI_EV_CONN_COMPLETE          0x03
> > struct hci_ev_conn_complete {
> >       __u8     status;
> > @@ -2017,7 +2026,7 @@ struct hci_comp_pkts_info {
> > } __packed;
> >
> > struct hci_ev_num_comp_pkts {
> > -     __u8     num_hndl;
> > +     __u8     num;
> >       struct hci_comp_pkts_info handles[];
> > } __packed;
> >
> > @@ -2067,7 +2076,7 @@ struct hci_ev_pscan_rep_mode {
> > } __packed;
> >
> > #define HCI_EV_INQUIRY_RESULT_WITH_RSSI       0x22
> > -struct inquiry_info_with_rssi {
> > +struct inquiry_info_rssi {
> >       bdaddr_t bdaddr;
> >       __u8     pscan_rep_mode;
> >       __u8     pscan_period_mode;
> > @@ -2075,7 +2084,7 @@ struct inquiry_info_with_rssi {
> >       __le16   clock_offset;
> >       __s8     rssi;
> > } __packed;
> > -struct inquiry_info_with_rssi_and_pscan_mode {
> > +struct inquiry_info_rssi_pscan {
> >       bdaddr_t bdaddr;
> >       __u8     pscan_rep_mode;
> >       __u8     pscan_period_mode;
> > @@ -2084,6 +2093,14 @@ struct inquiry_info_with_rssi_and_pscan_mode {
> >       __le16   clock_offset;
> >       __s8     rssi;
> > } __packed;
> > +struct hci_ev_inquiry_result_rssi {
> > +     __u8     num;
> > +     struct inquiry_info_rssi info[];
> > +} __packed;
> > +struct hci_ev_inquiry_result_rssi_pscan {
> > +     __u8     num;
> > +     struct inquiry_info_rssi_pscan info[];
> > +} __packed;
> >
> > #define HCI_EV_REMOTE_EXT_FEATURES    0x23
> > struct hci_ev_remote_ext_features {
> > @@ -2138,6 +2155,11 @@ struct extended_inquiry_info {
> >       __u8     data[240];
> > } __packed;
> >
> > +struct hci_ev_ext_inquiry_result {
> > +     __u8     num;
> > +     struct extended_inquiry_info info[];
> > +} __packed;
> > +
> > #define HCI_EV_KEY_REFRESH_COMPLETE   0x30
> > struct hci_ev_key_refresh_complete {
> >       __u8    status;
> > @@ -2305,13 +2327,18 @@ struct hci_ev_le_conn_complete {
> >
> > #define HCI_EV_LE_ADVERTISING_REPORT  0x02
> > struct hci_ev_le_advertising_info {
> > -     __u8     evt_type;
> > +     __u8     type;
> >       __u8     bdaddr_type;
> >       bdaddr_t bdaddr;
> >       __u8     length;
> >       __u8     data[];
> > } __packed;
> >
> > +struct hci_ev_le_advertising_report {
> > +     __u8    num;
> > +     struct hci_ev_le_advertising_info info[];
> > +} __packed;
> > +
> > #define HCI_EV_LE_CONN_UPDATE_COMPLETE        0x03
> > struct hci_ev_le_conn_update_complete {
> >       __u8     status;
> > @@ -2355,7 +2382,7 @@ struct hci_ev_le_data_len_change {
> >
> > #define HCI_EV_LE_DIRECT_ADV_REPORT   0x0B
> > struct hci_ev_le_direct_adv_info {
> > -     __u8     evt_type;
> > +     __u8     type;
>
> these changes look unrelated. Prepare to send a prepare patch.

Yep, I might split the changes so I make each event into a separate
patch since some changes require some changes in the struct (or just
simplify the naming).

>
> >       __u8     bdaddr_type;
> >       bdaddr_t bdaddr;
> >       __u8     direct_addr_type;
> > @@ -2363,6 +2390,11 @@ struct hci_ev_le_direct_adv_info {
> >       __s8     rssi;
> > } __packed;
> >
> > +struct hci_ev_le_direct_adv_report {
> > +     __u8     num;
> > +     struct hci_ev_le_direct_adv_info info[];
> > +} __packed;
> > +
> > #define HCI_EV_LE_PHY_UPDATE_COMPLETE 0x0c
> > struct hci_ev_le_phy_update_complete {
> >       __u8  status;
> > @@ -2372,8 +2404,8 @@ struct hci_ev_le_phy_update_complete {
> > } __packed;
> >
> > #define HCI_EV_LE_EXT_ADV_REPORT    0x0d
> > -struct hci_ev_le_ext_adv_report {
> > -     __le16   evt_type;
> > +struct hci_ev_le_ext_adv_info {
> > +     __le16   type;
> >       __u8     bdaddr_type;
> >       bdaddr_t bdaddr;
> >       __u8     primary_phy;
> > @@ -2381,11 +2413,16 @@ struct hci_ev_le_ext_adv_report {
> >       __u8     sid;
> >       __u8     tx_power;
> >       __s8     rssi;
> > -     __le16   interval;
> > -     __u8     direct_addr_type;
> > +     __le16   interval;
> > +     __u8     direct_addr_type;
> >       bdaddr_t direct_addr;
> > -     __u8     length;
> > -     __u8     data[];
> > +     __u8     length;
> > +     __u8     data[];
> > +} __packed;
> > +
> > +struct hci_ev_le_ext_adv_report {
> > +     __u8     num;
> > +     struct hci_ev_le_ext_adv_info info[];
> > } __packed;
> >
> > #define HCI_EV_LE_ENHANCED_CONN_COMPLETE    0x0a
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 5e99968939ce..db40358521fa 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -45,9 +45,16 @@
> > static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb,
> >                                 u8 *new_status)
> > {
> > -     __u8 status = *((__u8 *) skb->data);
> > +     struct hci_ev_status *rp;
> >
> > -     BT_DBG("%s status 0x%2.2x", hdev->name, status);
> > +     rp = bt_skb_pull(skb, sizeof(*rp));
> > +     if (!rp) {
> > +             bt_dev_err(hdev, "Malformed Command Complete: 0x%4.4x",
> > +                        HCI_OP_INQUIRY_CANCEL);
> > +             return;
> > +     }
>
> So you are repeating this over and over again. The error needs to be part of bt_skb_pull and I would make bt_skb_pull static and local to hci_event.c.

Understood, would something like the following make sense:

static void *hci_ev_pull(skb, opcode, size)

The reason I had introduced bt_skb_pull as public function is that it
may be convenient to parse packets in other protocols as well, but I
guess it could be introduced later if we decide to expand this sort of
logic to other protocols as well.

> Regards
>
> Marcel
>


-- 
Luiz Augusto von Dentz
