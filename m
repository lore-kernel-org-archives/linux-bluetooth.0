Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA904C13C
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Dec 2024 02:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734314581; cv=none; b=FZFbNyV6xIZRiYvjF7lhCdSN3zlltXjacGZnlMJvz+QGVNWIV8tZD19OQKTFMhW27/sOD/iUn4/nGYERWrhMro+qaZpkaYbcH7gJVh9WzjmZH53HK/nxFppUp7dRqtJ/hvVDRE18Auzlb0GWHav3doQpR/O7NaB+NErjnGfNSHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734314581; c=relaxed/simple;
	bh=jCTFvLiDV6m/Ln58Hjfw/kIq6p9bZ1CLJGf5jFP70qQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V3LTYIZxVhnAlnjrei2yhYyei6OA5lKRBtRkJsDUYEsh6f/p11ZzuoN2a0H9VnMuHnPIZDpVa9BlxsQHLNrntNEJTAAtkwKFdR44A5nyaW9mwWtIbqK2uq+STQiSjpW6JonHuumvPMzNy2YVURknDPK6O0kH3R+3E/rPN6l2M34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=REZ4k6Ea; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="REZ4k6Ea"
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E1E4C3F762
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Dec 2024 02:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1734314575;
	bh=4iAsICRXGCT3sR4suOeTvz18gei3eZgUNv8gmTa+rPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=REZ4k6EaF/6OvBe2BeN2kbD+u83T3KAHpxSfH6rlDLSSHvZEsQ+9YW3ZjAHKpnlV6
	 aNSyKPcIHD+5i2ua3joLdSR0HqvjaX3qET2vG1/6Q2QSD4FYXI09twxJw+6ur3hN3r
	 TDvk6fWlBqGpQgqpT+YRSUHlsBasU3xu8jGN7nsswEg/gyNWO1gx8+0qGaG9vikNtT
	 A0+wXSMh1d6MsEspq8ReKupgx4WeWJtiecw41EzH7/eKn8tH4dIBgY4kd5B07ANwGz
	 HZa2rRcLXezDICAQRvMoi0wnJXhEGCJS4fdb0+dJAsENFOF8AAwg+cvLBa1MYd368i
	 UvhUmlSNEh/5w==
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385f0829430so2402162f8f.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Dec 2024 18:02:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734314575; x=1734919375;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4iAsICRXGCT3sR4suOeTvz18gei3eZgUNv8gmTa+rPk=;
        b=DHYHIDPCFwwIyW7GnTbFWFdkA5gCGhHeMYpoAo3V4mdvRxTddGaNC5sOhVn7NhBGze
         z+rmPW8fWhr0cIrWkNx8h7dmR8fgurOSfPvrezK3Azo3KyHGFYjnJXNvBtUStkjnJJ9k
         Ak3/AuooUNZzYZPeRypnwhHnMhGAGYdjU9bRPhEaOVWlyU3viEn2074FZByMNUWwmFEJ
         hsENXwjxQKRluO1Dk9hVsLqoJgZCqmWRIfVWUeiccZX8M+wfN6yXJBh+QMTgLtqoS/vK
         fOsVioJ0bGfQUXiFxEdHOBmKKLkqfsReudXELbvVXLwnnhOujYj8RcUTE0rsxKid1qM5
         i5+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXrjIA9dVosz6Ed6gSReLRUuezv5x5qW21tmFHvDJFUpfKZVGhA0q7P6sXJETHhP+4OINIpBXx0oHG10rM0dII=@vger.kernel.org
X-Gm-Message-State: AOJu0YzslfN5Eng/UUK/Q+JpMBHSVmAnUp3vYhDrA3+BENP5Dq6Drz21
	Py/XvhhLs5kOPStQjRe9EK64ON3X7fCjmXkh8EK5b4SW5q3LN6WPVmPB4pxbiYKdUqj9fisPi5+
	FOTWUU5Py/7Ev4Dd0LQlqT0U2hwwOWeLUIjipU7bf3r/r/pSjCm9Yp9iuPPpFk+lotnahiRUAz2
	OeLuT2fHXoZ149inxRxPTx4Nqa606jFJc7nTuOpi3gXlPGgbF0Oy+Lo9Hc
X-Gm-Gg: ASbGncvWOjebbWx8d/YqvK5NnSPY9cXyiTfO39Xsr5Soqb98PbFAIyhaD7TLLodw1cq
	K4fTBfFV1wP4Lo8ML1P/QjlooRL8yEuw4CEXQyp4=
X-Received: by 2002:a05:6000:4b0e:b0:382:4ab4:b3e5 with SMTP id ffacd0b85a97d-3886fe7c5ebmr10213533f8f.0.1734314575399;
        Sun, 15 Dec 2024 18:02:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUt/yrjFjCvszEv4lN1aCNpK3Cka7rdVDb6AJmkWbVNemATnalT6T56VmsN9tVoe4PB1mRz0KUSyDutdeFn7k=
X-Received: by 2002:a05:6000:4b0e:b0:382:4ab4:b3e5 with SMTP id
 ffacd0b85a97d-3886fe7c5ebmr10213525f8f.0.1734314575069; Sun, 15 Dec 2024
 18:02:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205071727.36710-1-en-wei.wu@canonical.com> <20241205071727.36710-3-en-wei.wu@canonical.com>
In-Reply-To: <20241205071727.36710-3-en-wei.wu@canonical.com>
From: En-Wei WU <en-wei.wu@canonical.com>
Date: Mon, 16 Dec 2024 10:02:44 +0800
Message-ID: <CAMqyJG2Cqc2M1RsW4DUduVgKCiOm1s=3FrO4e=58Q=wd87oVuQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] Bluetooth: btusb: Improve SKB safety in QCA dump
 packet handling
To: marcel@holtmann.org, luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pmenzel@molgen.mpg.de
Cc: quic_tjiang@quicinc.com, kuan-ying.lee@canonical.com, 
	anthony.wong@canonical.com
Content-Type: text/plain; charset="UTF-8"

Hi,

Sorry for bothering. May I kindly ask if there is any progress?

Thanks. Regards.
En-Wei.

On Thu, 5 Dec 2024 at 15:17, En-Wei Wu <en-wei.wu@canonical.com> wrote:
>
> Replace direct buffer access and manual pointer arithmetic in QCA dump
> packet handling with safer skb_pull_data() calls. This ensures proper
> bounds checking when accessing packet headers and adds proper restoration
> of SKB data pointer and length on error paths.
>
> The changes include:
> - Replacing manual pointer arithmetic with skb_pull_data() for
>   safer packet header access
> - Adding SKB state restoration in error paths
>
> This prevents potential buffer overflows and ensures SKB state remains
> consistent even when packet validation fails.
>
> Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
> ---
>  drivers/bluetooth/btusb.c | 95 +++++++++++++++++----------------------
>  1 file changed, 41 insertions(+), 54 deletions(-)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 2bfb915062cf..cbeb1cec790a 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2935,8 +2935,6 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
>  {
>         int ret = 0;
>         u8 pkt_type;
> -       u8 *sk_ptr;
> -       unsigned int sk_len;
>         u16 seqno;
>         u32 dump_size;
>
> @@ -2945,18 +2943,8 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
>         struct usb_device *udev = btdata->udev;
>
>         pkt_type = hci_skb_pkt_type(skb);
> -       sk_ptr = skb->data;
> -       sk_len = skb->len;
> +       dump_hdr = (struct qca_dump_hdr *)skb->data;
>
> -       if (pkt_type == HCI_ACLDATA_PKT) {
> -               sk_ptr += HCI_ACL_HDR_SIZE;
> -               sk_len -= HCI_ACL_HDR_SIZE;
> -       }
> -
> -       sk_ptr += HCI_EVENT_HDR_SIZE;
> -       sk_len -= HCI_EVENT_HDR_SIZE;
> -
> -       dump_hdr = (struct qca_dump_hdr *)sk_ptr;
>         seqno = le16_to_cpu(dump_hdr->seqno);
>         if (seqno == 0) {
>                 set_bit(BTUSB_HW_SSR_ACTIVE, &btdata->flags);
> @@ -2976,16 +2964,15 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
>
>                 btdata->qca_dump.ram_dump_size = dump_size;
>                 btdata->qca_dump.ram_dump_seqno = 0;
> -               sk_ptr += offsetof(struct qca_dump_hdr, data0);
> -               sk_len -= offsetof(struct qca_dump_hdr, data0);
> +
> +               skb_pull(skb, offsetof(struct qca_dump_hdr, data0));
>
>                 usb_disable_autosuspend(udev);
>                 bt_dev_info(hdev, "%s memdump size(%u)\n",
>                             (pkt_type == HCI_ACLDATA_PKT) ? "ACL" : "event",
>                             dump_size);
>         } else {
> -               sk_ptr += offsetof(struct qca_dump_hdr, data);
> -               sk_len -= offsetof(struct qca_dump_hdr, data);
> +               skb_pull(skb, offsetof(struct qca_dump_hdr, data));
>         }
>
>         if (!btdata->qca_dump.ram_dump_size) {
> @@ -3005,7 +2992,6 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
>                 return ret;
>         }
>
> -       skb_pull(skb, skb->len - sk_len);
>         hci_devcd_append(hdev, skb);
>         btdata->qca_dump.ram_dump_seqno++;
>         if (seqno == QCA_LAST_SEQUENCE_NUM) {
> @@ -3036,61 +3022,62 @@ static bool btqca_acl_pkt_is_dump(struct hci_dev *hdev, struct sk_buff *skb)
>         struct hci_event_hdr *event_hdr;
>         struct hci_acl_hdr *acl_hdr;
>         struct qca_dump_hdr *dump_hdr;
> +       void *orig_data;
> +       unsigned int orig_len;
>
> -       sk_ptr = skb->data;
> -       sk_len = skb->len;
> +       orig_data = skb->data;
> +       orig_len = skb->len;
>
> -       acl_hdr = hci_acl_hdr(skb);
> -       if (le16_to_cpu(acl_hdr->handle) != QCA_MEMDUMP_ACL_HANDLE)
> -               return false;
> -       sk_ptr += HCI_ACL_HDR_SIZE;
> -       sk_len -= HCI_ACL_HDR_SIZE;
> -       event_hdr = (struct hci_event_hdr *)sk_ptr;
> -
> -       if ((event_hdr->evt != HCI_VENDOR_PKT)
> -               || (event_hdr->plen != (sk_len - HCI_EVENT_HDR_SIZE)))
> -               return false;
> +       acl_hdr = skb_pull_data(skb, sizeof(*acl_hdr));
> +       if (!acl_hdr || (le16_to_cpu(acl_hdr->handle) != QCA_MEMDUMP_ACL_HANDLE))
> +               goto restore_return;
>
> -       sk_ptr += HCI_EVENT_HDR_SIZE;
> -       sk_len -= HCI_EVENT_HDR_SIZE;
> +       event_hdr = skb_pull_data(skb, sizeof(*event_hdr));
> +       if (!event_hdr || (event_hdr->evt != HCI_VENDOR_PKT))
> +               goto restore_return;
>
> -       dump_hdr = (struct qca_dump_hdr *)sk_ptr;
> -       if ((sk_len < offsetof(struct qca_dump_hdr, data))
> -               || (dump_hdr->vse_class != QCA_MEMDUMP_VSE_CLASS)
> -           || (dump_hdr->msg_type != QCA_MEMDUMP_MSG_TYPE))
> -               return false;
> +       dump_hdr = (struct qca_dump_hdr *)skb->data;
> +       if ((skb->len < sizeof(*dump_hdr)) ||
> +          (dump_hdr->vse_class != QCA_MEMDUMP_VSE_CLASS) ||
> +          (dump_hdr->msg_type != QCA_MEMDUMP_MSG_TYPE))
> +               goto restore_return;
>
>         return true;
> +
> +restore_return:
> +       skb->data = orig_data;
> +       skb->len = orig_len;
> +       return false;
>  }
>
>  /* Return: true if the event packet is a dump packet, false otherwise. */
>  static bool btqca_event_pkt_is_dump(struct hci_dev *hdev, struct sk_buff *skb)
>  {
> -       u8 *sk_ptr;
> -       unsigned int sk_len;
> -
>         struct hci_event_hdr *event_hdr;
>         struct qca_dump_hdr *dump_hdr;
> +       void *orig_data;
> +       unsigned int orig_len;
>
> -       sk_ptr = skb->data;
> -       sk_len = skb->len;
> +       orig_data = skb->data;
> +       orig_len = skb->len;
>
> -       event_hdr = hci_event_hdr(skb);
> +       event_hdr = skb_pull_data(skb, sizeof(*event_hdr));
> +       if (!event_hdr || (event_hdr->evt != HCI_VENDOR_PKT))
> +               goto restore_return;
>
> -       if ((event_hdr->evt != HCI_VENDOR_PKT)
> -               || (event_hdr->plen != (sk_len - HCI_EVENT_HDR_SIZE)))
> -               return false;
> +       dump_hdr = (struct qca_dump_hdr *)skb->data;
> +       if ((skb->len < sizeof(*dump_hdr)) ||
> +          (dump_hdr->vse_class != QCA_MEMDUMP_VSE_CLASS) ||
> +          (dump_hdr->msg_type != QCA_MEMDUMP_MSG_TYPE))
> +               goto restore_return;
>
> -       sk_ptr += HCI_EVENT_HDR_SIZE;
> -       sk_len -= HCI_EVENT_HDR_SIZE;
> +       return true;
>
> -       dump_hdr = (struct qca_dump_hdr *)sk_ptr;
> -       if ((sk_len < offsetof(struct qca_dump_hdr, data))
> -               || (dump_hdr->vse_class != QCA_MEMDUMP_VSE_CLASS)
> -           || (dump_hdr->msg_type != QCA_MEMDUMP_MSG_TYPE))
> -               return false;
> +restore_return:
> +       skb->data = orig_data;
> +       skb->len = orig_len;
> +       return false;
>
> -       return true;
>  }
>
>  static int btusb_recv_acl_qca(struct hci_dev *hdev, struct sk_buff *skb)
> --
> 2.43.0
>
