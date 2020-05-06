Return-Path: <SRS0=zRH5=6U=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B72AC28CBC
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 19:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D120A20747
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 19:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VBj6kQf8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgEFT6F (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 May 2020 15:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbgEFT6F (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 May 2020 15:58:05 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDBCC061A0F
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2020 12:58:03 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id o7so2922877oif.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 May 2020 12:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FNrS4Y96E/KIKvbVV70tfWsX8/4iUb6oDqHOy8bVjYg=;
        b=VBj6kQf8DlTv8GTdgyqET9n6ZOc55c+C1SmxQnlfzNNNgVXdpCfDxuCrEMsRTz4Pgv
         urJDTn7ZyR9jhZPasawxAHR9s7MJ6rPDiywazv3aZXLTNy67JPT3c/BS9g91w+P0jnZ1
         dNB0Cq6gE5pqAw5LS2FUrCXXoxDr54kBpmy3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FNrS4Y96E/KIKvbVV70tfWsX8/4iUb6oDqHOy8bVjYg=;
        b=GxOeQyqVtHwtXbtuQ4fg2OZX3eCpXLv4cdC4wbONJcBBsoYvHePL5Abqfspk3Db8by
         suglvYsRl75CFpXe7Nh7ITdXTO2JGEhSTWboi1IoS8cZOLRKjazOq/cGz2I3GXj8nVFO
         DdXz5abjsI+ME59kYhBHs+dQIOws8R8eoWmAmQLis+MAfDwHdf9aHvvqcJZe7Nu7S9BE
         OCeEUf/sUmYnlPDcW2uRMmHBZ87i8g/EwEinKXDtt9e/IxVHkjxMWsanpbT6RtG0MpDK
         oZSNgDF5S9pXNY7PER0HlsgBpTXswHV4LwYtd6uLIkiT4Qe4n7pAW+4+DfNtXCRfoVgO
         Gdnw==
X-Gm-Message-State: AGi0Pua829k+WFzCiQdVaGC0JzEup0HddNQuIbTMtkM30RlP2DBEq8Vo
        6jBb7iO43JBWX5oOoU0BhFuch2pBGlZWltn3+jeTjQEO
X-Google-Smtp-Source: APiQypIIhBHvBtoVH05sf35Y0K2sG+DH/ZZohSyKrbdXXZozy3528pYbcKtPhxdxygKK01ty7UMAcjeRhcuFKx8c9Ec=
X-Received: by 2002:aca:c705:: with SMTP id x5mr4015752oif.136.1588795083278;
 Wed, 06 May 2020 12:58:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200428051151.14879-1-sonnysasaka@gmail.com> <D2192131-CC65-4D4E-91BE-B1C3B1C12BC4@holtmann.org>
 <CAOxioN=2p23_K1VuFth5PwFAUR1oXcgs5GPHeM595OOivh6Y2Q@mail.gmail.com>
 <CAOxioN=1dP9W=WZ2TM+3RLbVmxBYkcrG0s4HiExihAXQ=0pJJg@mail.gmail.com> <89566A98-F0CE-4E70-A344-915E81FB0C14@holtmann.org>
In-Reply-To: <89566A98-F0CE-4E70-A344-915E81FB0C14@holtmann.org>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Wed, 6 May 2020 12:57:52 -0700
Message-ID: <CAOxioNkYyVdOorRkZsvQjcLjuHgc0BJKqG--g30meO3F=Rv46g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Handle Inquiry Cancel error after Inquiry Complete
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

Please take a look at the modified patch based on your feedback. Thanks.

On Tue, May 5, 2020 at 4:42 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Sonny,
>
> > Could you take another look at my last proposal based on your
> > suggestion? If we are to move the logic inside hci_cc_inquiry_cancel,
> > we will need a way to update the status to the caller, for example by
> > having hci_cc_inquiry_cancel return a value, or accept a pointer for
> > the updated status value. Let me know which way you prefer.
>
> maybe something like this (missing comment of course):
>
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -42,14 +42,20 @@
>
>  /* Handle HCI Event packets */
>
> -static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb)
> +static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb,
> +                                 u8 *new_status)
>  {
>         __u8 status = *((__u8 *) skb->data);
>
>         BT_DBG("%s status 0x%2.2x", hdev->name, status);
>
> -       if (status)
> +       if (status) {
> +               if (!test_bit(HCI_INQUIRY, &hdev->flags) && status == 0x0c) {
> +                       BT_DBG("Ignoring error of HCI Inquiry Cancel command");
> +                       *new_status = 0x00;
> +               }
>                 return;
> +       }
>
>         clear_bit(HCI_INQUIRY, &hdev->flags);
>         smp_mb__after_atomic(); /* wake_up_bit advises about this barrier */
> @@ -3233,7 +3239,7 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
>
>         switch (*opcode) {
>         case HCI_OP_INQUIRY_CANCEL:
> -               hci_cc_inquiry_cancel(hdev, skb);
> +               hci_cc_inquiry_cancel(hdev, skb, status);
>                 break;
>
>         case HCI_OP_PERIODIC_INQ:
>
> Regards
>
> Marcel
>
