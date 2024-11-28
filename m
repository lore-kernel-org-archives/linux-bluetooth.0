Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3163D5B216
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Nov 2024 09:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732786416; cv=none; b=OQvMHrkOTaGDYAjg0SrQaL3XJPlQVeBB1muXWw4mOtq7kfLdKBtSb4HY/8ntCC9CGQEUFNParY0Sp8+n0sNq5mYp4g9A8rrPOHDzvfRc6V49v8zm5IC8p+tWM0gHe1mESgGdc3efxkJs0nCeqJQ0Vk02wHt/JN5cVlwzH+eZ7Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732786416; c=relaxed/simple;
	bh=vYq4neSFTl0T1qVMSCUeRLvXeDvAM1S9H0PXhEbnRQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SADtjTgVGdkOkXrAdOC4mue6Ndcej/dUTJtft5L+J+t7fDWzD6H0n+6Y8r4Ehm03k7LkC3Aicyshr+GV5PVMhSQk04dQ6YEFQo5ClGWzADa/Ftl2FE10GM04hOfffAC7D6kgH5ksYMQQJeJf7eIVu6nZXVuhgWhQhlRCZTZN3jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=E7U4mYM9; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="E7U4mYM9"
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5E90F3F5B5
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Nov 2024 09:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1732786411;
	bh=lUZGQ+mjPqbnTlfT51QJ0a2FFEKFHgm9wc5Bm6qalzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=E7U4mYM9RUjCr2n/ybd/s+MnkfrCWfEnmOVGucv9Vg1MLURVanEaS4xCoTuCDKR0K
	 dV/4j24ZkvaTf2OnTi/VKWqVgMWRlHIVrwWjnMPf3MCB+IR5s9hUADO+3gmSwQO43d
	 ezvNYCQjHvlmnkrUSPOHinMeKuUcGz0FbfScs4g8+89AzpG/xNhulLFL8uhMrk5Ooc
	 rPVNC0n0Brvq4wQatxlKVjE541L5H48wC0ZUVD6mHIsYDZE8IbwGTiarAF26DkIa/Z
	 nJEMD25YPOTUx2/nUlLlFmqDomER9jLWPpaE6+wFh0GdeJ4ZeSB0Agk7wrgpI/IIvT
	 eTp6hWUx52mmA==
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43498af7937so5015605e9.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Nov 2024 01:33:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732786411; x=1733391211;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lUZGQ+mjPqbnTlfT51QJ0a2FFEKFHgm9wc5Bm6qalzU=;
        b=Z2wE4u9bSeiAgqmAWIoyxZgqN/JXfY0elefgFDH6HP/7eJG6QZ1DaG45cRS8Bo9vGR
         CUmPiCpC+lnewNsP+yWFAOSakXvUmCAatJHgZtttSp2NmmbsTkyFnmjflmsQqd4KBaUG
         GtYXuDsyF2pVJImTIZztj0yODA/7wM5kDc2S0RUo8yHFnrbNUajlZiMGamBr4vM4ZT0E
         zNMh9dFUKoU378Dn+44iv0s9a6MZ/oCII6gyr0RWhgsxx/hJ6slpEZB2dgR6JXYBtgBh
         XXshV3Ffjop/fDEHawMVc5vLjWs55tcYmBSUfiEykQupackJYDy9UNOUekQRUQ2eQaCI
         x//w==
X-Forwarded-Encrypted: i=1; AJvYcCVNPrVKYzzEDgE4mkGy60iUq61m6h6H81fK3AGHQTIFPvzNEgcmK7aQpjRggv+DIRZDKTTsEVIoBtnM3RTu3/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtHXfL3KPrL8CrF8zFvTKKYvQKrsaIcAq3/9j1mWK/nHGpA3JY
	ziBGTIppKmMGEkEFKroWPaNh8G9cMm3GcHMAkQ60LjDgt3j5Y8FGxzCwC9PrE1Ah7JPJj+OpW2R
	m56tZ36E7+pLAuDbqwnA7TrZFFOdmcFMCELrLGPivjDOWp76iJSeUeB+DN5gTC4ViIoHgtpDcOh
	cSReLa277khR0uG///QlW7QOeWJ3m7ZxHyeqRkkJtWaDSZL4/Z+LL3w7sF
X-Gm-Gg: ASbGnctbaNAtv3NS/f1J43tP3p5kjUE7wwomSZCj+x9mWphtKVvIvWOszl8BYO+bF1M
	Mk+Q6m9DuklERZpYLqjd0K+Idd+B1aXKS
X-Received: by 2002:a05:6000:4007:b0:382:424:94fe with SMTP id ffacd0b85a97d-385c6edd99dmr6007213f8f.36.1732786410723;
        Thu, 28 Nov 2024 01:33:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGladE772oN2ugn6H0CZvF5Jr87lmw6P1ToSvaaXfFRRUzvDuaJg2ws5aGVhUnyQwSO24sI4gypR6IFLn76z7E=
X-Received: by 2002:a05:6000:4007:b0:382:424:94fe with SMTP id
 ffacd0b85a97d-385c6edd99dmr6007181f8f.36.1732786410364; Thu, 28 Nov 2024
 01:33:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128030807.270581-1-en-wei.wu@canonical.com> <ce455385-2000-4da3-aaa1-a3b292220130@molgen.mpg.de>
In-Reply-To: <ce455385-2000-4da3-aaa1-a3b292220130@molgen.mpg.de>
From: En-Wei WU <en-wei.wu@canonical.com>
Date: Thu, 28 Nov 2024 17:33:19 +0800
Message-ID: <CAMqyJG3DONewrkNwo-AuaghS4X0_gpn9rVQwAUt-B0QCtRydNQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: avoid NULL pointer defereference in skb_dequeue()
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, anthony.wong@canonical.com, 
	kuan-ying.lee@canonical.com, Tim Jiang <quic_tjiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

Dear Paul,

Thanks for the quick response.

> How can I force the the firmware crash dump selection?
I haven't found a way to force the firmware crashing dump. In our
cases, we often encountered the hardware error and it would
automatically do the crash dump process.

Here is the log of crash dump after applying this patch
[ 178.424131] Bluetooth: hci0: ACL memdump size(589824)
[ 179.028136] Bluetooth: hci0: memdump done: pkts(2418), total(589824)
[ 179.036315] Bluetooth: hci0: hardware error 0x85

As we can see, the NULL pointer dereference error is gone.

Best regards,
En-Wei.

On Thu, 28 Nov 2024 at 13:55, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> [Cc: +Tim]
>
> Dear En-Wei,
>
>
> Thank you for the patch. There is a typo in the summary/title/subject:
>
> dereference
>
> Am 28.11.24 um 04:08 schrieb En-Wei Wu:
> > The WCN7851 (0489:e0f3) Bluetooth controller supports firmware crash dump
> > collection through devcoredump. During this process, the crash dump data
> > is queued to a dump queue as skb for further processing.
> >
> > A NULL pointer dereference occurs in skb_dequeue() when processing the
> > dump queue due to improper return value handling:
> >
> > [ 93.672166] Bluetooth: hci0: ACL memdump size(589824)
> >
> > [ 93.672475] BUG: kernel NULL pointer dereference, address: 0000000000000008
> > [ 93.672517] Workqueue: hci0 hci_devcd_rx [bluetooth]
> > [ 93.672598] RIP: 0010:skb_dequeue+0x50/0x80
> >
> > The issue stems from handle_dump_pkt_qca() returning the wrong value on
> > success. It currently returns the value from hci_devcd_init() (0 on success),
> > but callers expect > 0 to indicate successful dump handling. This causes
> > hci_recv_frame() to free the skb while it's still queued for dump
> > processing, leading to the NULL pointer dereference when hci_devcd_rx()
> > tries to dequeue it.
> >
> > Fix this by:
> >
> > 1. Extracting dump packet detection into new is_dump_pkt_qca() function
> > 2. Making handle_dump_pkt_qca() return 0 on success and negative errno
> >     on failure, consistent with other kernel interfaces
> >
> > This prevents premature skb freeing by ensuring proper handling of dump packets.
>
> Re-flow this line for 75/72 characters per line?
>
> How can I force the the firmware crash dump selection?
>
> > Fixes: 20981ce2d5a5 ("Bluetooth: btusb: Add WCN6855 devcoredump support")
> > Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
> > ---
> >   drivers/bluetooth/btusb.c | 75 ++++++++++++++++++++++++---------------
> >   1 file changed, 47 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 279fe6c115fa..8926f8f60e5c 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -2930,22 +2930,16 @@ static void btusb_coredump_qca(struct hci_dev *hdev)
> >               bt_dev_err(hdev, "%s: triggle crash failed (%d)", __func__, err);
> >   }
> >
> > -/*
> > - * ==0: not a dump pkt.
> > - * < 0: fails to handle a dump pkt
> > - * > 0: otherwise.
> > - */
> > +/* Return: 0 on success, negative errno on failure. */
> >   static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
> >   {
> > -     int ret = 1;
> > +     int ret = 0;
> >       u8 pkt_type;
> >       u8 *sk_ptr;
> >       unsigned int sk_len;
> >       u16 seqno;
> >       u32 dump_size;
> >
> > -     struct hci_event_hdr *event_hdr;
> > -     struct hci_acl_hdr *acl_hdr;
> >       struct qca_dump_hdr *dump_hdr;
> >       struct btusb_data *btdata = hci_get_drvdata(hdev);
> >       struct usb_device *udev = btdata->udev;
> > @@ -2955,30 +2949,14 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
> >       sk_len = skb->len;
> >
> >       if (pkt_type == HCI_ACLDATA_PKT) {
> > -             acl_hdr = hci_acl_hdr(skb);
> > -             if (le16_to_cpu(acl_hdr->handle) != QCA_MEMDUMP_ACL_HANDLE)
> > -                     return 0;
> >               sk_ptr += HCI_ACL_HDR_SIZE;
> >               sk_len -= HCI_ACL_HDR_SIZE;
> > -             event_hdr = (struct hci_event_hdr *)sk_ptr;
> > -     } else {
> > -             event_hdr = hci_event_hdr(skb);
> >       }
> >
> > -     if ((event_hdr->evt != HCI_VENDOR_PKT)
> > -             || (event_hdr->plen != (sk_len - HCI_EVENT_HDR_SIZE)))
> > -             return 0;
> > -
> >       sk_ptr += HCI_EVENT_HDR_SIZE;
> >       sk_len -= HCI_EVENT_HDR_SIZE;
> >
> >       dump_hdr = (struct qca_dump_hdr *)sk_ptr;
> > -     if ((sk_len < offsetof(struct qca_dump_hdr, data))
> > -             || (dump_hdr->vse_class != QCA_MEMDUMP_VSE_CLASS)
> > -         || (dump_hdr->msg_type != QCA_MEMDUMP_MSG_TYPE))
> > -             return 0;
> > -
> > -     /*it is dump pkt now*/
> >       seqno = le16_to_cpu(dump_hdr->seqno);
> >       if (seqno == 0) {
> >               set_bit(BTUSB_HW_SSR_ACTIVE, &btdata->flags);
> > @@ -3052,17 +3030,58 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
> >       return ret;
> >   }
> >
> > +/* Return: true if packet is a dump packet, false otherwise. */
> > +static bool is_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
> > +{
> > +     u8 pkt_type;
> > +     u8 *sk_ptr;
> > +     unsigned int sk_len;
> > +
> > +     struct hci_event_hdr *event_hdr;
> > +     struct hci_acl_hdr *acl_hdr;
> > +     struct qca_dump_hdr *dump_hdr;
> > +
> > +     pkt_type = hci_skb_pkt_type(skb);
> > +     sk_ptr = skb->data;
> > +     sk_len = skb->len;
> > +
> > +     if (pkt_type == HCI_ACLDATA_PKT) {
> > +             acl_hdr = hci_acl_hdr(skb);
> > +             if (le16_to_cpu(acl_hdr->handle) != QCA_MEMDUMP_ACL_HANDLE)
> > +                     return false;
> > +             sk_ptr += HCI_ACL_HDR_SIZE;
> > +             sk_len -= HCI_ACL_HDR_SIZE;
> > +             event_hdr = (struct hci_event_hdr *)sk_ptr;
> > +     } else {
> > +             event_hdr = hci_event_hdr(skb);
> > +     }
> > +
> > +     if ((event_hdr->evt != HCI_VENDOR_PKT)
> > +             || (event_hdr->plen != (sk_len - HCI_EVENT_HDR_SIZE)))
> > +             return false;
> > +
> > +     sk_ptr += HCI_EVENT_HDR_SIZE;
> > +     sk_len -= HCI_EVENT_HDR_SIZE;
> > +
> > +     dump_hdr = (struct qca_dump_hdr *)sk_ptr;
> > +     if ((sk_len < offsetof(struct qca_dump_hdr, data))
> > +             || (dump_hdr->vse_class != QCA_MEMDUMP_VSE_CLASS)
> > +         || (dump_hdr->msg_type != QCA_MEMDUMP_MSG_TYPE))
> > +             return false;
> > +
> > +     return true;
> > +}
>
> Add a blank line here?
>
> >   static int btusb_recv_acl_qca(struct hci_dev *hdev, struct sk_buff *skb)
> >   {
> > -     if (handle_dump_pkt_qca(hdev, skb))
> > -             return 0;
> > +     if (is_dump_pkt_qca(hdev, skb))
> > +             return handle_dump_pkt_qca(hdev, skb);
> >       return hci_recv_frame(hdev, skb);
> >   }
> >
> >   static int btusb_recv_evt_qca(struct hci_dev *hdev, struct sk_buff *skb)
> >   {
> > -     if (handle_dump_pkt_qca(hdev, skb))
> > -             return 0;
> > +     if (is_dump_pkt_qca(hdev, skb))
> > +             return handle_dump_pkt_qca(hdev, skb);
> >       return hci_recv_frame(hdev, skb);
> >   }
>
> The rest looks good.
>
>
> Kind regards,
>
> Paul
