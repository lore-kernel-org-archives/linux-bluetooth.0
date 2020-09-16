Return-Path: <SRS0=qc6f=CZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F81C43461
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 22:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCBFE2087D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 22:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H3r6+T3l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgIPWkO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Sep 2020 18:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgIPWkN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Sep 2020 18:40:13 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0096CC06174A
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 15:40:12 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id j2so200042eds.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 15:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gv5Ym7Y65u7UpAXs48lxQYYvj7ha6lG/xcFtbTRD8zI=;
        b=H3r6+T3lprSi9LqwoZJK0zuMM9U8FaF/TNFQbuwOTd5OvetcZ6kPTEIbjnl8Ma7QVn
         st1OLTsPVcGlIsGPOGpCRbTpY/o5hH2XhNmjlNHwvP0kgs7zcZZV1be8+rerIjAmDXpx
         sO3M3DuF5/ps6BjVRJDuGOLGrsOGcdyafsM7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gv5Ym7Y65u7UpAXs48lxQYYvj7ha6lG/xcFtbTRD8zI=;
        b=bA1MUP7vbeKLN4vD3iYCBbT1AtRCUVaXR+vpWLOrz/Ms0CBKFHsrDsdKN0ge5T3LV8
         IAFQHxHCYVlXqy3j7NUjCGLDQZFRV2e/KcY3RevfUNLErZ1q52SajbZYL6pe27ekge7Z
         wRu/ZZSFraI5Q36Fq6aJG7TTOf/Kl61rmHvBaTJRGdceEJWCoS+R77tD4d1NIBzV1LoC
         K4u1fhtq6xyv3r5ioOXKgE37IDJG6c/X9dP/fEXtBE/VKdXNlxH34Vyy9WRWGa2Ejb+A
         CT07pGHwntcVXdAY+3ZFTwoRf7HehpsESVEIUSAC8jFuJU3LGE8XLYBwy8qSpplzpyuh
         3xvQ==
X-Gm-Message-State: AOAM530aBUxoVkqQfOqk/UbgQYO/HZeREE7oBHvVJBCORrJ9XG3zxcR9
        odS5BKBrzlCySx0wWKMEOrk0Wk/YqxBnQw==
X-Google-Smtp-Source: ABdhPJzxK/0kyalzBSHSAUWK8lbvtWwkMQeDWEvdI0Wwt1hLepZFo6a1lXGKcJ/78nYcIm0MirQaPg==
X-Received: by 2002:aa7:c054:: with SMTP id k20mr30373740edo.224.1600296011255;
        Wed, 16 Sep 2020 15:40:11 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id cf7sm15036479edb.78.2020.09.16.15.40.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2020 15:40:10 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id e17so128647wme.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 15:40:10 -0700 (PDT)
X-Received: by 2002:a05:600c:2312:: with SMTP id 18mr601790wmo.141.1600296009905;
 Wed, 16 Sep 2020 15:40:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200814190909.361764-1-sonnysasaka@chromium.org>
In-Reply-To: <20200814190909.361764-1-sonnysasaka@chromium.org>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Wed, 16 Sep 2020 15:39:58 -0700
X-Gmail-Original-Message-ID: <CAO271m=+2vqnmWK=M5ySfSYYBsKqAJbjmCDnjj4C_BxD3vQ5gQ@mail.gmail.com>
Message-ID: <CAO271m=+2vqnmWK=M5ySfSYYBsKqAJbjmCDnjj4C_BxD3vQ5gQ@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Fix auto-creation of hci_conn at Conn
 Complete event
To:     BlueZ <linux-bluetooth@vger.kernel.org>
Cc:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear maintainers,

Friendly ping to review this patch. Thanks!

On Fri, Aug 14, 2020 at 12:09 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> Currently the code auto-creates hci_conn only if the remote address has
> been discovered before. This may not be the case. For example, the
> remote device may trigger connection after reboot at already-paired
> state so there is no inquiry result found, but it is still correct to
> create the hci_conn when Connection Complete event is received.
>
> A better guard is to check against bredr allowlist. Devices in the
> allowlist have been given permission to auto-connect.
>
> Fixes: 4f40afc6c764 ("Bluetooth: Handle BR/EDR devices during suspend")
> Signed-off-by: Sonny Sasaka <sonnysasaka@chromium.org>
> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
>
> ---
>  net/bluetooth/hci_event.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 33d8458fdd4a..6b83da1790ee 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -2566,7 +2566,6 @@ static void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *skb)
>  static void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
>  {
>         struct hci_ev_conn_complete *ev = (void *) skb->data;
> -       struct inquiry_entry *ie;
>         struct hci_conn *conn;
>
>         BT_DBG("%s", hdev->name);
> @@ -2575,13 +2574,19 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
>
>         conn = hci_conn_hash_lookup_ba(hdev, ev->link_type, &ev->bdaddr);
>         if (!conn) {
> -               /* Connection may not exist if auto-connected. Check the inquiry
> -                * cache to see if we've already discovered this bdaddr before.
> -                * If found and link is an ACL type, create a connection class
> +               /* Connection may not exist if auto-connected. Check the bredr
> +                * allowlist to see if this device is allowed to auto connect.
> +                * If link is an ACL type, create a connection class
>                  * automatically.
> +                *
> +                * Auto-connect will only occur if the event filter is
> +                * programmed with a given address. Right now, event filter is
> +                * only used during suspend.
>                  */
> -               ie = hci_inquiry_cache_lookup(hdev, &ev->bdaddr);
> -               if (ie && ev->link_type == ACL_LINK) {
> +               if (ev->link_type == ACL_LINK &&
> +                   hci_bdaddr_list_lookup_with_flags(&hdev->whitelist,
> +                                                     &ev->bdaddr,
> +                                                     BDADDR_BREDR)) {
>                         conn = hci_conn_add(hdev, ev->link_type, &ev->bdaddr,
>                                             HCI_ROLE_SLAVE);
>                         if (!conn) {
> --
> 2.26.2
>
