Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00F47261D
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 May 2025 05:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746595781; cv=none; b=QsJWwjNRMzBJnf92ysbzEq+83FGjBxlfdrnZc1Gv7aBXjOJywMA4TAhgNm77fbOszAuxqxU0DGfFZM34BP1J08IElGiKmeO94TxolEeaBTdLKKzPPaPa0EhptQNfN7LRWxiWAlFGqqTbWb9CM+/TyoUL0ps/WUOtds34DNSXCKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746595781; c=relaxed/simple;
	bh=truV7W7wlCOvdh092fGH9J3IXopt6Qfp8wO/hTOTXtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T7C9X1SDds3Jey05lKclpdccLAI23gRSEjHfbuxqLLWYK9dMV9Xk7d/hjrZvN3QaiCSVL8mRe8AQVzEhlq69Vf/BpFikvJcs4P9Iq8Q9g+wyYcDjgy9YAv7Br3EgWxXo5iS5L+lslX3RyxBTGu6raI3PfWp+7eUPwspOqsXWE1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Pynzaafz; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Pynzaafz"
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7B6CC3F128
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 May 2025 05:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1746595771;
	bh=TNhEsCLkvQ4FMv7Oa0gFx/Y+6zdX7PN6tyOXag8sK+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=PynzaafzCk0UUsT2dmVeM62i0F2WsMDUs69KllRngEjbGH+yU+9PoYZ12KIfxve23
	 t/68s6KjqsecNoZRaCDHdehSM/DSg57A3iGpOm+GdZ7OqjNRsbrRNfYX9LZ5X3Kwaq
	 TSz3uGZa9a9bArxL2rZ9e6u4HGddb++4NpnJlsqRlUGr60FI+4BmyqvMwSkTAVY2Kb
	 p0xNnFLHew17Mfywp6kumIFSK9WojWDIEqRssyHHTy8QmoJNqASDzOwWHDiWa1bXyR
	 x78fC5fxIEkgDx4bJNTLOQhKsCsnVe6sd7OxRh44VP5SfGu7WR5gpLCf81Ml6chzyG
	 FSJ4tMJJSKP7w==
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-39d917b1455so1839412f8f.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 May 2025 22:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746595771; x=1747200571;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TNhEsCLkvQ4FMv7Oa0gFx/Y+6zdX7PN6tyOXag8sK+A=;
        b=mjJgi8/HJb8d616hQJe4sLJZxHOlStZE5ejZlyYVB1Zioue9gHWOjoQnEFY2YDMDPQ
         xbHg8GJ0eE//CyKUwQSzePMrt7RFDOLd1guToS6Fhc/wJ39+3y8gW0gJUydzAlxFz/OB
         fyIJVw8YjzipxpJQhcJ7wWbaS+jq4mGJ78nw0LEkqNOwJhuQcH4FvDu/xxAcZv0trJ+K
         MGAxkd1F52ZhXQe22Z0/V/3ua0YAuyYF4LM6QPAvbwz8Mfiahu1n26XiCafSdakAHiSe
         PHg2phVJv0RmH2+UhJ11G/uklP43osK26fPuYv+DrEXPxdYw+lUuhFFyYBABilDHr/lL
         wptA==
X-Forwarded-Encrypted: i=1; AJvYcCVQjKbpgl4AHRZ0ukDsLwSV8ijVriNevJhuRwqsqAMvILfr0U4aGWC9mT/9Qbew6887vNaj3UBvJvViQXqWYAE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9XDkZHREU2IcMz3oQlRO17HgK0ZZ2WlmNj/BWRXK6UYikUxDz
	V4gWx2unzVyTgIYm/53OiPMGzLlWq/rxtqoWGeriBXiZU6H4A563up4IVmkE4NjShaEiK8LVMev
	ds2+/js3JyxRDa8sQsYJCGqVAtFWjf5jbaSygzsuqBIqDVRZPoabwtsMKkhjxW4UjvZa6BxWMum
	5SCFYRArMZ2io6hbxijClXHtALo++PlMUYsOXMrFUxHTkfvRKaD2RKJHvT1TI7B7DtqUY=
X-Gm-Gg: ASbGncuojUu7vQ9fWkdCmGXYXhkBtUBq9PKmmSuKJf67ZtDL/VJDOg31Hfby6q4FXnj
	NXxt9v54AELXNp46bE4EKlbXs88PGPEAdTP9/4YtB3oyfrPWtOmAPNfd8ssXu9bMiwwJXLA==
X-Received: by 2002:a05:6000:2403:b0:3a0:9dd8:420c with SMTP id ffacd0b85a97d-3a0b4a68446mr1259501f8f.50.1746595770768;
        Tue, 06 May 2025 22:29:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqT9u8XjENyEQqWitZKedyb5RQ38lYlKAhClgAvkpr8bKVbVOkcWNQRydq4AfPS7g/QSH/KXSp4k6wCd4Kdbw=
X-Received: by 2002:a05:6000:2403:b0:3a0:9dd8:420c with SMTP id
 ffacd0b85a97d-3a0b4a68446mr1259490f8f.50.1746595770374; Tue, 06 May 2025
 22:29:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506024822.327776-1-en-wei.wu@canonical.com> <aa095579-84d3-4157-91fc-23613ae30448@molgen.mpg.de>
In-Reply-To: <aa095579-84d3-4157-91fc-23613ae30448@molgen.mpg.de>
From: En-Wei WU <en-wei.wu@canonical.com>
Date: Wed, 7 May 2025 13:29:19 +0800
X-Gm-Features: ATxdqUEjR_05HLch-lZLYWyoz6bul3SrZ6GzETTZm2iF6PHiEBGsR5yxOR-nbzU
Message-ID: <CAMqyJG3v9rcBZD-ZFhzC4_Do+Etry9svctgVz-LKh9X27vq98Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: use skb_pull to avoid unsafe access in
 QCA dump handling
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_tjiang@quicinc.com
Content-Type: text/plain; charset="UTF-8"

Hi Paul,

> Also, how did you test this?
I triggered the device coredump by `$ echo 1` to the file named
"coredump" in the sysfs device node of the hci device. The symbolic
link of the file can be found at
/sys/class/bluetooth/hci*/device/coredump.
After triggering the coredump, the core dump file can be found at
/sys/class/devcoredump.

Kind regards,
En-Wei

On Tue, 6 May 2025 at 16:46, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear En-Wei,
>
>
> Thank you for your patch.
>
> Am 06.05.25 um 04:48 schrieb En-Wei Wu:
> > Use skb_pull() and skb_pull_data() to safely parse QCA dump packets.
> >
> > This avoids direct pointer math on skb->data, which could lead to
> > invalid access if the packet is shorter than expected.
>
> Please add a Fixes: tag.
>
> Also, how did you test this?
>
> > Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
> > ---
> >   drivers/bluetooth/btusb.c | 99 ++++++++++++++++-----------------------
> >   1 file changed, 41 insertions(+), 58 deletions(-)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 357b18dae8de..17136924a278 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -2979,9 +2979,8 @@ static void btusb_coredump_qca(struct hci_dev *hdev)
> >   static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
> >   {
> >       int ret = 0;
> > +     int skip = 0;
>
> `unsigned int`, as the signature is:
>
>      include/linux/skbuff.h:void *skb_pull(struct sk_buff *skb, unsigned
> int len);
>
> >       u8 pkt_type;
> > -     u8 *sk_ptr;
> > -     unsigned int sk_len;
> >       u16 seqno;
> >       u32 dump_size;
> >
> > @@ -2990,18 +2989,14 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
> >       struct usb_device *udev = btdata->udev;
> >
> >       pkt_type = hci_skb_pkt_type(skb);
> > -     sk_ptr = skb->data;
> > -     sk_len = skb->len;
> > -
> > -     if (pkt_type == HCI_ACLDATA_PKT) {
> > -             sk_ptr += HCI_ACL_HDR_SIZE;
> > -             sk_len -= HCI_ACL_HDR_SIZE;
> > -     }
> > +     if (pkt_type == HCI_ACLDATA_PKT)
> > +             skip = sizeof(struct hci_acl_hdr) + sizeof(struct hci_event_hdr);
> > +     else
> > +             skip = sizeof(struct hci_event_hdr);
>
> Maybe write it as below:
>
>      skip = sizeof(struct hci_event_hdr);
>
>      if (pkt_type == HCI_ACLDATA_PKT)
>         skip += sizeof(struct hci_acl_hdr);
>
>
> Kind regards,
>
> Paul
>
>
> >
> > -     sk_ptr += HCI_EVENT_HDR_SIZE;
> > -     sk_len -= HCI_EVENT_HDR_SIZE;
> > +     skb_pull(skb, skip);
> > +     dump_hdr = (struct qca_dump_hdr *)skb->data;
> >
> > -     dump_hdr = (struct qca_dump_hdr *)sk_ptr;
> >       seqno = le16_to_cpu(dump_hdr->seqno);
> >       if (seqno == 0) {
> >               set_bit(BTUSB_HW_SSR_ACTIVE, &btdata->flags);
> > @@ -3021,16 +3016,15 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
> >
> >               btdata->qca_dump.ram_dump_size = dump_size;
> >               btdata->qca_dump.ram_dump_seqno = 0;
> > -             sk_ptr += offsetof(struct qca_dump_hdr, data0);
> > -             sk_len -= offsetof(struct qca_dump_hdr, data0);
> > +
> > +             skb_pull(skb, offsetof(struct qca_dump_hdr, data0));
> >
> >               usb_disable_autosuspend(udev);
> >               bt_dev_info(hdev, "%s memdump size(%u)\n",
> >                           (pkt_type == HCI_ACLDATA_PKT) ? "ACL" : "event",
> >                           dump_size);
> >       } else {
> > -             sk_ptr += offsetof(struct qca_dump_hdr, data);
> > -             sk_len -= offsetof(struct qca_dump_hdr, data);
> > +             skb_pull(skb, offsetof(struct qca_dump_hdr, data));
> >       }
> >
> >       if (!btdata->qca_dump.ram_dump_size) {
> > @@ -3050,7 +3044,6 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
> >               return ret;
> >       }
> >
> > -     skb_pull(skb, skb->len - sk_len);
> >       hci_devcd_append(hdev, skb);
> >       btdata->qca_dump.ram_dump_seqno++;
> >       if (seqno == QCA_LAST_SEQUENCE_NUM) {
> > @@ -3078,68 +3071,58 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
> >   /* Return: true if the ACL packet is a dump packet, false otherwise. */
> >   static bool acl_pkt_is_dump_qca(struct hci_dev *hdev, struct sk_buff *skb)
> >   {
> > -     u8 *sk_ptr;
> > -     unsigned int sk_len;
> > -
> >       struct hci_event_hdr *event_hdr;
> >       struct hci_acl_hdr *acl_hdr;
> >       struct qca_dump_hdr *dump_hdr;
> > +     struct sk_buff *clone = skb_clone(skb, GFP_ATOMIC);
> > +     bool is_dump = false;
> >
> > -     sk_ptr = skb->data;
> > -     sk_len = skb->len;
> > -
> > -     acl_hdr = hci_acl_hdr(skb);
> > -     if (le16_to_cpu(acl_hdr->handle) != QCA_MEMDUMP_ACL_HANDLE)
> > +     if (!clone)
> >               return false;
> >
> > -     sk_ptr += HCI_ACL_HDR_SIZE;
> > -     sk_len -= HCI_ACL_HDR_SIZE;
> > -     event_hdr = (struct hci_event_hdr *)sk_ptr;
> > -
> > -     if ((event_hdr->evt != HCI_VENDOR_PKT) ||
> > -         (event_hdr->plen != (sk_len - HCI_EVENT_HDR_SIZE)))
> > -             return false;
> > +     acl_hdr = skb_pull_data(clone, sizeof(*acl_hdr));
> > +     if (!acl_hdr || (le16_to_cpu(acl_hdr->handle) != QCA_MEMDUMP_ACL_HANDLE))
> > +             goto out;
> >
> > -     sk_ptr += HCI_EVENT_HDR_SIZE;
> > -     sk_len -= HCI_EVENT_HDR_SIZE;
> > +     event_hdr = skb_pull_data(clone, sizeof(*event_hdr));
> > +     if (!event_hdr || (event_hdr->evt != HCI_VENDOR_PKT))
> > +             goto out;
> >
> > -     dump_hdr = (struct qca_dump_hdr *)sk_ptr;
> > -     if ((sk_len < offsetof(struct qca_dump_hdr, data)) ||
> > -         (dump_hdr->vse_class != QCA_MEMDUMP_VSE_CLASS) ||
> > -         (dump_hdr->msg_type != QCA_MEMDUMP_MSG_TYPE))
> > -             return false;
> > +     dump_hdr = skb_pull_data(clone, sizeof(*dump_hdr));
> > +     if (!dump_hdr || (dump_hdr->vse_class != QCA_MEMDUMP_VSE_CLASS) ||
> > +        (dump_hdr->msg_type != QCA_MEMDUMP_MSG_TYPE))
> > +             goto out;
> >
> > -     return true;
> > +     is_dump = true;
> > +out:
> > +     consume_skb(clone);
> > +     return is_dump;
> >   }
> >
> >   /* Return: true if the event packet is a dump packet, false otherwise. */
> >   static bool evt_pkt_is_dump_qca(struct hci_dev *hdev, struct sk_buff *skb)
> >   {
> > -     u8 *sk_ptr;
> > -     unsigned int sk_len;
> > -
> >       struct hci_event_hdr *event_hdr;
> >       struct qca_dump_hdr *dump_hdr;
> > +     struct sk_buff *clone = skb_clone(skb, GFP_ATOMIC);
> > +     bool is_dump = false;
> >
> > -     sk_ptr = skb->data;
> > -     sk_len = skb->len;
> > -
> > -     event_hdr = hci_event_hdr(skb);
> > -
> > -     if ((event_hdr->evt != HCI_VENDOR_PKT)
> > -         || (event_hdr->plen != (sk_len - HCI_EVENT_HDR_SIZE)))
> > +     if (!clone)
> >               return false;
> >
> > -     sk_ptr += HCI_EVENT_HDR_SIZE;
> > -     sk_len -= HCI_EVENT_HDR_SIZE;
> > +     event_hdr = skb_pull_data(clone, sizeof(*event_hdr));
> > +     if (!event_hdr || (event_hdr->evt != HCI_VENDOR_PKT))
> > +             goto out;
> >
> > -     dump_hdr = (struct qca_dump_hdr *)sk_ptr;
> > -     if ((sk_len < offsetof(struct qca_dump_hdr, data)) ||
> > -         (dump_hdr->vse_class != QCA_MEMDUMP_VSE_CLASS) ||
> > -         (dump_hdr->msg_type != QCA_MEMDUMP_MSG_TYPE))
> > -             return false;
> > +     dump_hdr = skb_pull_data(clone, sizeof(*dump_hdr));
> > +     if (!dump_hdr || (dump_hdr->vse_class != QCA_MEMDUMP_VSE_CLASS) ||
> > +        (dump_hdr->msg_type != QCA_MEMDUMP_MSG_TYPE))
> > +             goto out;
> >
> > -     return true;
> > +     is_dump = true;
> > +out:
> > +     consume_skb(clone);
> > +     return is_dump;
> >   }
> >
> >   static int btusb_recv_acl_qca(struct hci_dev *hdev, struct sk_buff *skb)
>
