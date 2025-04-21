Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021D584039;
	Mon, 21 Apr 2025 15:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745249379; cv=none; b=hsRiROtfmD0vagLr4owyqoos/Xt8h0aPGIbLuB2oMADFcAyptn2to3UWj3y0vSh+MhfXzW8F2E2hG3KOgdDBF8FpXi8z5gfF6biGi1HOe3QAnTX1M/exe/iyR36h0V1EkBJE1WRGdltyURjcqwUhGg4Cbuo9MiFLyBRLtsRCOOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745249379; c=relaxed/simple;
	bh=bRLShvjowgOOy//RuPIGSqjBET7Ge6MZ51PkkqL9DOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qTAvPCYbrXFbr3Kh0ZWS7vrUEyvFdcce2kk69JZ+drv5uMBE6+A4dsdUPilTDqp5TGmod0NVV+Pf0pqd//In9G3YPWUUDSZqaq4Cwm2vZMO0cqKFMvarFYOLUNQN0Yy0kqKgRQl0/ukjA1vs7xlbqg+8WYqypUPXNviagIKd6FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LvOZEEjm; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvOZEEjm"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54e6788d07eso1329284e87.1;
        Mon, 21 Apr 2025 08:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745249376; x=1745854176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hm47Qc5tmb6NJsCaaNaJW9/9jIlAIIjJmwiENTdYKpQ=;
        b=LvOZEEjmO3NG1OV1qpL7/hmnh7/9Za1pUYJA+PR+vFBZjAPKPKWj61rMbuOKoYTRDb
         kXSHMXnaUyJoXvfWXLcdoiqpUrFKWsQQuJuy9gs04l1gu1K9p0bF3K/LJR2bcPcBc4V0
         l2u2WsDsZWPq4TaDCWQqf4KyLmYTT43Lzt18DbLKOMCIWiaKX1B4hFJXzk62KdGRH5vz
         CH5NSrhk8HF1GZtzfJNJOI84uZ8zO8I1D5qAiCeGp7Ik4m20FpXZGr7d/JPFRa0wdTWl
         uvFJ4xJVI9EoffvtVeTW1rTcjNMHlRJobN+n8j+n7bpjNBfgXiLa/bGCKotXKA7nx86P
         FDxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745249376; x=1745854176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hm47Qc5tmb6NJsCaaNaJW9/9jIlAIIjJmwiENTdYKpQ=;
        b=n3BftIvFzfZDYlSLUXJji9Z6WqYT1EPkQr/OC5x4zZ9jQxKgSskXDkcK2/x+qMIS8M
         YvdZGnhNXpmo7d2KLeSNnWGRs3oW781pWwVXC1BNS91Y28DuDNeRQYXe5jyltBsVcBLF
         yoXxZrLpZLEF+86ySzCt5/E6mTY3f5T2RMeV8RtaVVOfNJahqGxznV0cRxqOainu2ypy
         qdMktJ9uqdNYFszxCdO2ZDQy11UOkrR5sNvyXgLqEoYeX7MDdLoKCZ6894vLXqdG9O1V
         JrTqPxCTLYepHA2SPgyLWmxeB/9MmDuWDIcm3KZFJCsX9Z6KMjPD2++iGcqk3CkT8tGS
         gNZg==
X-Forwarded-Encrypted: i=1; AJvYcCU+UlDKdTSh0lNmqcLwo5RU5olAfdmXLXeMReBCIMpzkzF3TwnKSJRSuF0SywlDbs+8WUSkhXz85aLdLtvmg8U=@vger.kernel.org, AJvYcCV4QrraqrEFKWjdHixvArEBcqewperYWS+bjQ5BUAXVJJZdkop28FbrAO8T3jp6tRpmp0Qx6n3RvElJDhpF@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/MIJiq1adjap8IOpGElm/wAqfx7AEhCwGgyOwNhDHZatP56u9
	fAcx53o4Z2UukbFUPGas2TVINHd9uEGS6C5bHEPv87MhxpW9wvoVUmEcAbiRhAp81LnBtd0ha3a
	8p9hc8h82v/SP6RFrJqDT+VAMH6iHqOPs
X-Gm-Gg: ASbGncuzIXfTFU/MgKCE7wHaIekuJJlSgQ+h9QThmb9Dwxmdygz3mcMQsGw7G+vhoQY
	SUqKufawFX3zwlFboqN2KRk/84QB2oAUhd6OS7EMmp3YjSsgdbof5FU/NezxMmopa3p6CWxRqf6
	yjpqPBgDOzXwwXDE4NGMcc
X-Google-Smtp-Source: AGHT+IFYK9UQRC9T9E6sSm0bjJDKv0XdOqwUFIcj0VoIYAESeejUyZSw0qHGc9lVnJYfjVUe0N/XOX1Q6cc+GfyINrg=
X-Received: by 2002:a05:6512:3356:b0:549:9643:68d0 with SMTP id
 2adb3069b0e04-54d6dbf65d3mr3796209e87.17.1745249375754; Mon, 21 Apr 2025
 08:29:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421130038.34998-1-en-wei.wu@canonical.com> <20250421130038.34998-3-en-wei.wu@canonical.com>
In-Reply-To: <20250421130038.34998-3-en-wei.wu@canonical.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 21 Apr 2025 11:29:22 -0400
X-Gm-Features: ATxdqUFMvQZeigKWA623h_DM9bCAMtg78BUdI0q0OqyB8wci3znKgNDP-EzK_Ek
Message-ID: <CABBYNZJi857F45eDfwA0W83jt7gT5z501hc0r68hxOMXzrAy=A@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] Bluetooth: btusb: use skb_pull to avoid unsafe
 access in QCA dump handling
To: En-Wei Wu <en-wei.wu@canonical.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pmenzel@molgen.mpg.de, quic_tjiang@quicinc.com, 
	chia-lin.kao@canonical.com, anthony.wong@canonical.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi En-Wei,

On Mon, Apr 21, 2025 at 9:00=E2=80=AFAM En-Wei Wu <en-wei.wu@canonical.com>=
 wrote:
>
> Use skb_pull() and skb_pull_data() to safely parse QCA dump packets.
>
> This avoids direct pointer math on skb->data, which could lead to
> invalid access if the packet is shorter than expected.
>
> Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
> ---
>  drivers/bluetooth/btusb.c | 98 ++++++++++++++++-----------------------
>  1 file changed, 41 insertions(+), 57 deletions(-)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index f905780fcdea..031292ab766f 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3017,8 +3017,6 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev=
, struct sk_buff *skb)
>  {
>         int ret =3D 0;
>         u8 pkt_type;
> -       u8 *sk_ptr;
> -       unsigned int sk_len;
>         u16 seqno;
>         u32 dump_size;
>
> @@ -3027,18 +3025,8 @@ static int handle_dump_pkt_qca(struct hci_dev *hde=
v, struct sk_buff *skb)
>         struct usb_device *udev =3D btdata->udev;
>
>         pkt_type =3D hci_skb_pkt_type(skb);
> -       sk_ptr =3D skb->data;
> -       sk_len =3D skb->len;
> +       dump_hdr =3D (struct qca_dump_hdr *)skb->data;
>
> -       if (pkt_type =3D=3D HCI_ACLDATA_PKT) {
> -               sk_ptr +=3D HCI_ACL_HDR_SIZE;
> -               sk_len -=3D HCI_ACL_HDR_SIZE;
> -       }
> -
> -       sk_ptr +=3D HCI_EVENT_HDR_SIZE;
> -       sk_len -=3D HCI_EVENT_HDR_SIZE;
> -
> -       dump_hdr =3D (struct qca_dump_hdr *)sk_ptr;
>         seqno =3D le16_to_cpu(dump_hdr->seqno);
>         if (seqno =3D=3D 0) {
>                 set_bit(BTUSB_HW_SSR_ACTIVE, &btdata->flags);
> @@ -3058,16 +3046,15 @@ static int handle_dump_pkt_qca(struct hci_dev *hd=
ev, struct sk_buff *skb)
>
>                 btdata->qca_dump.ram_dump_size =3D dump_size;
>                 btdata->qca_dump.ram_dump_seqno =3D 0;
> -               sk_ptr +=3D offsetof(struct qca_dump_hdr, data0);
> -               sk_len -=3D offsetof(struct qca_dump_hdr, data0);
> +
> +               skb_pull(skb, offsetof(struct qca_dump_hdr, data0));
>
>                 usb_disable_autosuspend(udev);
>                 bt_dev_info(hdev, "%s memdump size(%u)\n",
>                             (pkt_type =3D=3D HCI_ACLDATA_PKT) ? "ACL" : "=
event",
>                             dump_size);
>         } else {
> -               sk_ptr +=3D offsetof(struct qca_dump_hdr, data);
> -               sk_len -=3D offsetof(struct qca_dump_hdr, data);
> +               skb_pull(skb, offsetof(struct qca_dump_hdr, data));
>         }
>
>         if (!btdata->qca_dump.ram_dump_size) {
> @@ -3087,7 +3074,6 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev=
, struct sk_buff *skb)
>                 return ret;
>         }
>
> -       skb_pull(skb, skb->len - sk_len);
>         hci_devcd_append(hdev, skb);
>         btdata->qca_dump.ram_dump_seqno++;
>         if (seqno =3D=3D QCA_LAST_SEQUENCE_NUM) {
> @@ -3115,67 +3101,65 @@ static int handle_dump_pkt_qca(struct hci_dev *hd=
ev, struct sk_buff *skb)
>  /* Return: true if the ACL packet is a dump packet, false otherwise. */
>  static bool acl_pkt_is_dump_qca(struct hci_dev *hdev, struct sk_buff *sk=
b)
>  {
> -       u8 *sk_ptr;
> -       unsigned int sk_len;
> -
>         struct hci_event_hdr *event_hdr;
>         struct hci_acl_hdr *acl_hdr;
>         struct qca_dump_hdr *dump_hdr;
> +       void *orig_data;
> +       unsigned int orig_len;
>
> -       sk_ptr =3D skb->data;
> -       sk_len =3D skb->len;
> +       orig_data =3D skb->data;
> +       orig_len =3D skb->len;
>
> -       acl_hdr =3D hci_acl_hdr(skb);
> -       if (le16_to_cpu(acl_hdr->handle) !=3D QCA_MEMDUMP_ACL_HANDLE)
> -               return false;
> -       sk_ptr +=3D HCI_ACL_HDR_SIZE;
> -       sk_len -=3D HCI_ACL_HDR_SIZE;
> -       event_hdr =3D (struct hci_event_hdr *)sk_ptr;
> +       acl_hdr =3D skb_pull_data(skb, sizeof(*acl_hdr));
> +       if (!acl_hdr || (le16_to_cpu(acl_hdr->handle) !=3D QCA_MEMDUMP_AC=
L_HANDLE))
> +               goto restore_return;
>
> -       if ((event_hdr->evt !=3D HCI_VENDOR_PKT)
> -               || (event_hdr->plen !=3D (sk_len - HCI_EVENT_HDR_SIZE)))
> -               return false;
> +       event_hdr =3D skb_pull_data(skb, sizeof(*event_hdr));
> +       if (!event_hdr || (event_hdr->evt !=3D HCI_VENDOR_PKT))
> +               goto restore_return;
>
> -       sk_ptr +=3D HCI_EVENT_HDR_SIZE;
> -       sk_len -=3D HCI_EVENT_HDR_SIZE;
> -
> -       dump_hdr =3D (struct qca_dump_hdr *)sk_ptr;
> -       if ((sk_len < offsetof(struct qca_dump_hdr, data))
> -               || (dump_hdr->vse_class !=3D QCA_MEMDUMP_VSE_CLASS)
> -           || (dump_hdr->msg_type !=3D QCA_MEMDUMP_MSG_TYPE))
> -               return false;
> +       dump_hdr =3D (struct qca_dump_hdr *)skb->data;
> +       if ((skb->len < sizeof(*dump_hdr)) ||
> +          (dump_hdr->vse_class !=3D QCA_MEMDUMP_VSE_CLASS) ||
> +          (dump_hdr->msg_type !=3D QCA_MEMDUMP_MSG_TYPE))
> +               goto restore_return;
>
>         return true;
> +
> +restore_return:
> +       skb->data =3D orig_data;
> +       skb->len =3D orig_len;
> +       return false;
>  }
>
>  /* Return: true if the event packet is a dump packet, false otherwise. *=
/
>  static bool evt_pkt_is_dump_qca(struct hci_dev *hdev, struct sk_buff *sk=
b)
>  {
> -       u8 *sk_ptr;
> -       unsigned int sk_len;
> -
>         struct hci_event_hdr *event_hdr;
>         struct qca_dump_hdr *dump_hdr;
> +       void *orig_data;
> +       unsigned int orig_len;
>
> -       sk_ptr =3D skb->data;
> -       sk_len =3D skb->len;
> +       orig_data =3D skb->data;
> +       orig_len =3D skb->len;
>
> -       event_hdr =3D hci_event_hdr(skb);
> +       event_hdr =3D skb_pull_data(skb, sizeof(*event_hdr));
> +       if (!event_hdr || (event_hdr->evt !=3D HCI_VENDOR_PKT))
> +               goto restore_return;
>
> -       if ((event_hdr->evt !=3D HCI_VENDOR_PKT)
> -               || (event_hdr->plen !=3D (sk_len - HCI_EVENT_HDR_SIZE)))
> -               return false;
> +       dump_hdr =3D (struct qca_dump_hdr *)skb->data;
> +       if ((skb->len < sizeof(*dump_hdr)) ||
> +          (dump_hdr->vse_class !=3D QCA_MEMDUMP_VSE_CLASS) ||
> +          (dump_hdr->msg_type !=3D QCA_MEMDUMP_MSG_TYPE))
> +               goto restore_return;
>
> -       sk_ptr +=3D HCI_EVENT_HDR_SIZE;
> -       sk_len -=3D HCI_EVENT_HDR_SIZE;
> +       return true;
>
> -       dump_hdr =3D (struct qca_dump_hdr *)sk_ptr;
> -       if ((sk_len < offsetof(struct qca_dump_hdr, data))
> -               || (dump_hdr->vse_class !=3D QCA_MEMDUMP_VSE_CLASS)
> -           || (dump_hdr->msg_type !=3D QCA_MEMDUMP_MSG_TYPE))
> -               return false;
> +restore_return:
> +       skb->data =3D orig_data;
> +       skb->len =3D orig_len;
> +       return false;
>
> -       return true;
>  }
>
>  static int btusb_recv_acl_qca(struct hci_dev *hdev, struct sk_buff *skb)
> --
> 2.43.0

While I agree using the likes of skb_pull is a much safer way to parse
these packets Im not so sure it is safe to restore the skb->data and
skb->len like that, perhaps we should be using skb_clone and
skb_unclone for example.

--=20
Luiz Augusto von Dentz
