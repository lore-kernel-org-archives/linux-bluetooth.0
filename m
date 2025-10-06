Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8BD23DEB6
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Oct 2025 17:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759771287; cv=none; b=UQnwFMWD/5TID0GOg3Pmb00vVHBhEVKzlD6qIXqqtW9ZnxuW6Z6tD4PTjxeiZxnbU0OGCDnP5oQoMTcU/mVpA9j4WO92ypdQZzNRxlmoDOSCapsPW3qUMU1buvgp9gsW57YHXziOqJBR7p2cWdyj+rErFwYrlzH3OiyYxEf88gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759771287; c=relaxed/simple;
	bh=GxwecgAhCYFKHy6xZibUthnIopksHNXHtVkNOvFiti0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wea4Cq59yRTOb+7hNERDWD5lOwZZGyXuklBN7jpwWc8I8MdkjQ2LExKBWvJniixV7OxqCt7jkde41FwOLZTOD7Uyq5C2RpFqg2DKoIZBiHnqODZwT2Mc3m7kkIqrgcacVn/KgaoJsdstA9gouunqxfpRZPpLHDu19/bgTh2HgIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=byGj7G1Q; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byGj7G1Q"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-36ba647ac9fso42206121fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Oct 2025 10:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759771284; x=1760376084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Se0cxel0Jn3xk+mIGXRSV6/sl49L1oxhQS5tH5NnoTM=;
        b=byGj7G1Qa4FCkz+78deE88Ce+mrTahHdS4rEONfUdODOMII3dtKiatuwxlxOtrbsjc
         MWrRtbG34jfgKH07xkI3Ib8i8Pa8xJfSZ/Dn/MP8xbWeXWzO5DOLGaLPFJOKgHs3EZgv
         sxxsricaBvjzw78rm5CijlK4iL0o/uCdixz/5Evnn+61y8n7dVcDxVrOLdhD7okfS2Yw
         tsvhbtcQH/KtmPhksNMrl57pSOd4SeFj7xgY1JtwUDGssu8x6+euG3LjEpWcYM0z5auw
         FX+Rw7PjHAIXYNx8MiFFLwVvGF31bCDXR6NQvUTO4yM3KQsKAWzhXCsgO2jYwEIezu87
         mCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759771284; x=1760376084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Se0cxel0Jn3xk+mIGXRSV6/sl49L1oxhQS5tH5NnoTM=;
        b=IbmyykuycoE3rBQbrbYiC/IMbpf2mRUVjr/uM7k7cUkomTY1x4A6nfQjQT4CYhaz3i
         2ZHhKVJN5zlGNG6nKydIduYs0aiheqImfItHmUsPD9K/9DGTcfkDXd5Y/46Q6TtvQMkD
         ijSLobBc4KVes3ShvsSGUMSncTKF5/0xBAUqD1XDaCGseazViNXyyZR7KXyE2o5xAuU0
         5HLuX+ShXDNqCsMqrEmSEjGuMJvBoXyMlTv3y0qvLOa4ETwOvSWUHQtyLiw+rOCxSUu6
         hFAd3RLPPjYomr1FECCLfNGkexaqV5qKVp93NrPxN2YFxUb/+A9aaEYZS//usURuQZhT
         LFFw==
X-Forwarded-Encrypted: i=1; AJvYcCUqREPU4nu8dmLqmOziRAWXQWTgnrKnLKh4tsq0om80ASn7gKyBb4tdebfAkjcE+24dZ2SX21ghuZA8UtMo5Ik=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJvcmGRICWS7zEQq528EO2gDBQAahbusrHBrpiozTk79kfWoeJ
	iVX75kArTMScD7ZUymhWRgT8T+TTVs01KMzDMGxBGwUg9+V1kYPALS/McIzntEXUVdR9msk5j8z
	ieZ/T3vkIEx1eWRalgy/Gq+ofqOgWgc4=
X-Gm-Gg: ASbGncuoL1qUit4zWEWJAvHbQbmd3z8hENQhoeRz7NEvDov+pNcKVi7/uY/TBuUlY8H
	Gs2+v6rVZBMpHvHTe8DD+ItlnS59dyp4XLvuF/XFiM+bCLbBjoEZX8NOeQWtEBhYMgU9+W5+Vsl
	pK3D+oEhFnrex2lUYNm367Ivv8Koy5NRVKFYQRxkMU+tm6AkzcqNFPGnCYnhXG/SwUg5A+xbD/Q
	QpQ0jgntnzVARXme6DcqWi5QLagKlGvQVOikhaU
X-Google-Smtp-Source: AGHT+IE1iXszFPocGfX7qXHVJT5YVBxPcMPiwoag2yynKKs8nHxqcOtoAdp0YPRayW+7Uew9/xRJq589UqWPgfxUMVw=
X-Received: by 2002:a2e:bc12:0:b0:36c:47c8:b61c with SMTP id
 38308e7fff4ca-374c38704a4mr36772641fa.34.1759771283500; Mon, 06 Oct 2025
 10:21:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003205837.10748-1-pascal.giard@etsmtl.ca>
In-Reply-To: <20251003205837.10748-1-pascal.giard@etsmtl.ca>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 6 Oct 2025 13:21:07 -0400
X-Gm-Features: AS18NWAO9zoHMAD2MKmfqNz5oZt9LQCbRQbrV_fdxB9ddan3XJEslyqug-Mo_i0
Message-ID: <CABBYNZJVUoVnJPdOXARvk7T_9EsvomJ_oe_ZZ_QZMTQBVjNDHw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Add filter for Qualcomm debug packets
To: Pascal Giard <evilynux@gmail.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Pascal Giard <pascal.giard@etsmtl.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pascal,

On Fri, Oct 3, 2025 at 4:59=E2=80=AFPM Pascal Giard <evilynux@gmail.com> wr=
ote:
>
> Some Qualcomm Bluetooth controllers, e.g., QCNFA765 send debug packets
> as ACL frames with header 0x2EDC. The kernel misinterprets these as
> malformed ACL packets, causing repeated errors:
>
>   Bluetooth: hci0: ACL packet for unknown connection handle 3804
>
> This can occur hundreds of times per minute, greatly cluttering logs.
> On my computer, I am observing approximately 7 messages per second
> when streaming audio to a speaker.
>
> For Qualcomm controllers exchanging over UART, hci_qca.c already
> filters out these debug packets. This patch is for controllers
> not going through UART, but USB.
>
> This patch filters these packets in btusb_recv_acl() before they reach
> the HCI layer, redirecting them to hci_recv_diag().
>
> Tested on: Thinkpad T14 gen2 (AMD) with QCNFA765, kernel 6.16.9
>
> Signed-off-by: Pascal Giard <pascal.giard@etsmtl.ca>
> ---
>  drivers/bluetooth/btusb.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 5e9ebf0c5312..900400646315 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -68,6 +68,9 @@ static struct usb_driver btusb_driver;
>  #define BTUSB_ACTIONS_SEMI             BIT(27)
>  #define BTUSB_BARROT                   BIT(28)
>
> +/* Qualcomm firmware debug packets header */
> +#define QCA_DEBUG_HEADER       0x2EDC
> +
>  static const struct usb_device_id btusb_table[] =3D {
>         /* Generic Bluetooth USB device */
>         { USB_DEVICE_INFO(0xe0, 0x01, 0x01) },
> @@ -1229,6 +1232,12 @@ static int btusb_recv_intr(struct btusb_data *data=
, void *buffer, int count)
>
>  static int btusb_recv_acl(struct btusb_data *data, struct sk_buff *skb)
>  {
> +       /* Drop QCA firmware debug packets sent as ACL frames */
> +       if (skb->len >=3D 2) {
> +               if (get_unaligned_le16(skb->data) =3D=3D QCA_DEBUG_HEADER=
)
> +                       return hci_recv_diag(data->hdev, skb);
> +       }

Well it turns out that handle 0x2EDC is actually a valid handle, so we
can't just reclassify these packets just because Qualcomm thinks that
it could reserve it for its own, so this needs to be using
classify_pkt_type to reclassify the packets to the handle 0x2EDC to
HCI_DIAG_PKT for the models affected.

>         /* Only queue ACL packet if intr_interval is set as it means
>          * force_poll_sync has been enabled.
>          */
> --
> 2.51.0
>


--=20
Luiz Augusto von Dentz
