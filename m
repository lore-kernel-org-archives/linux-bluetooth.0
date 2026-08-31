Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DA73939BD
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 14:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788187980; cv=pass; b=hOfjjRdyu8dUsF9VQBRnT12rN3X4pWBsMVKcYSILMa5LgjE/RumBC/K5kcnqw+Pbfd9DhgIdAi/lAHbqPz20OrYphOfl4aA+r3+l+FqNT169TPibPk+/7mVHrUcUkRln+oj/+pMskfdzhuXIrvtaUEJlwD5+M6hxxtJP4g0LYRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788187980; c=relaxed/simple;
	bh=xkNpN7efCHF4pdD46P43IKOykmL+e6GzvtLJUbEDQ8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h6Z1yBVTwfvCXsue0k28lTcyW2Q7X2HgzLQSxNDzjZbWfBTmk2LIf6TMFXOx3vv3DSeAUVd6OCaZBJKz4qVM5X+e0V+Jf4INQl3yWPRvtb3UhUbplqWiMeJAjlIT3H5Pag07SvKXEihuZ2wHnUpNuIMk7jJqdvlE7XBkVq6zezY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRzoNqCL; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRzoNqCL"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-865bdc6ed72so15492317b3.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 07:52:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788187977; cv=none;
        d=google.com; s=arc-20260327;
        b=gIYuBbUkS2c7KtUAKTQmC0QqwBuSUZHS2428t+WIu6wiYe5ubyfTToi1poGgiNv8mN
         rC7m2tXu6i7NJc8//4QO28UPP1jkhu7botSUEA1y+gDbc0KCFIvvLH73SWdXujkzIbxm
         zF6aQygQAtnNcrVyGl1F3Xy7Gsa07HZI+4iolBsQkmh2dv9qVkzG4+IM+rGf2LCOAQ1E
         4uvNMo93B4+p5a/P9K1yQam58Hq7pg6G+K7trL9ikd4D0Kzzlo0/UhKEqoclt4flDs45
         sgLeF4itFycwFW+R0MFuw3JhrNY+jOdRDKTYTvtLZQ46/kaf3tO93JR3xmeflAd3FNLZ
         dbGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WM/dFJBj5xwYcfB5jia0P++D/pur5zHzV+GzG4BESvM=;
        fh=kHFmWf10Jahw6tKqIaA9hlKsHiI3SIct+4k9HWAqKP0=;
        b=hI4ZpM3otih7vVnSWs5v6UT/4PRHOVKOCNLLb73QQRS26K1s9caVOoM1J5WfG2jjEy
         e5NeJHtK8hnoXuz7lWOjGnmMhVxqhXkqfw9It+KJoWpdr7hottpoVWRPrakSbYtuKBD0
         xJqfb8o74otCvxmb/xDDC/xVudz1v2I5k8sliPqtIpOiRnvLHVjiqD5Rvaqrsye4ZtGQ
         8kyEs8xB7KyPLLuc8wb5Ho/X+XWl9s/1XvSKYkWgAp8DyX/2f0Pn2cGQrMH0Hf3tpZBa
         ZsT7OE4qAdtZ5U2loXhS3UY5Qt4/hTaHf5M7G8Vb7MnmqwrqxSb5AXtuV2gIKtwxjjvO
         bxdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788187977; x=1788792777; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WM/dFJBj5xwYcfB5jia0P++D/pur5zHzV+GzG4BESvM=;
        b=kRzoNqCLnnisRQTXu9HBHxtPFmjrPIiathx22F7MvBtUqmLWaF6ns8EUiinM/WVdV8
         SPJzsHLH7tXaeYqczskNotbH15rOsRKNFpUJ9h9tMGa9SzUzOxNyKoizrmmO/Q4uy7fU
         nf95oUO/lEraGneMAZXlzq+hBH/djMfE/tIxPBYKlYKaqIl+k7aqqNP4UrnmqxJixSjD
         HrbI9XS8BCf9BSSaSXuFIAA4uWMakYC5PPApmlU5MptniBxIxsvZgAKpwyKA4KsRhyQC
         XPCxzmhNtgxpfVX30j6KQ/yt2RL3d0FNVqIowQnv9k9ukK4wSbIEyV9C+O4N4EYEW/kI
         KqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788187977; x=1788792777;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WM/dFJBj5xwYcfB5jia0P++D/pur5zHzV+GzG4BESvM=;
        b=lErsXar9r/qEpuyiknaQ0bouZA7i2KZrrlg6euZb73aJ7OXqetQYGR7SG4SO3JgBW2
         3dfGfeZc+PkTiL5J258fcmON2MmKl3E97jFVrBB2jxyKcmlSpzSdVxpjzJuept6S/ovI
         mED2uIPQqh4KtMfC4el4PkLZdrPQTenRH9daFFT3c9B4n+30Uh1nxbsBhBVj85/zfZ1i
         VnqN3RxzoYAAjLtpfwF+UjqM+czkuAYmJ22raD19yU1cza9ms7Js2gC9wue2lJDoH0Mv
         SHVmw4wqdLGZmz/7Y6LpjWkCRebPmFqu/kIChpuPeECqFBh87Myr9vtJ6z5Rhb+jrOoK
         XtSA==
X-Forwarded-Encrypted: i=1; AKwUvBwFI72kkYqJ85ZwTxyBp53gR6X8ut2MFsS0EYCIguiz7K2qWUG74GY2mjLfWLFv3Neb5nrIX2IunzG8fnKXZYQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kT5teDJjNQmjzZw6bnoLILSeghPflEZGLEhZjaPXC8L/TDlVb4
	nGNQRu8SMXzVxNBkzlhJQ5E6j515pjlscL2l40xLWH0lyxhrYKoMywP8ZbDooQxD7Qkk+pkSMIH
	SWYa9DGP7a4iZ+uA136h9dx+49REL8o4=
X-Gm-Gg: AYBFou2loTMat7KtpgwBqC648vo1bWGqEauzUgbun6kXVsRwy74CjSSGcTDkDZEbzd0
	D8YpYgAPvZreP7y6r30/JQvqFX4t/WCMQqUTnXA7uoLSAQCtBkVRXn2n9rRl812Xqf8C8/thhRv
	qk/NPS2HV23YK1NvlzlE3AgiBT6enja5VxLPAPj3hTU/YFzpphjMGWudTVzMx8ymSO18gIrFSaP
	Vy/A+FnaTUCNlvJpp1M7zqATcvQqIr8LajshAcHlR9PCtUrQQfPJUIvcZZfeexeY4qWElUXV3no
	ePyvI8d7MU4PKkM4LkTQ+6JMJ5qtBrGoLRTsdRR8SxTaU+hxWaabJyPjaMYqOoqYezjC+zlwxsa
	xz0k+kpwFAyNJ4XsNevE37pu4PFpMZTl5zbRBkWo=
X-Received: by 2002:a05:690c:5781:b0:844:c27b:35dc with SMTP id
 00721157ae682-868726e5b60mr6009007b3.18.1788187977347; Mon, 31 Aug 2026
 07:52:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260830-vendor_hci-v2-0-9903760957ab@oss.qualcomm.com> <20260830-vendor_hci-v2-3-9903760957ab@oss.qualcomm.com>
In-Reply-To: <20260830-vendor_hci-v2-3-9903760957ab@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 31 Aug 2026 10:52:45 -0400
X-Gm-Features: AcwNN1VCwJTbcNQuKlRnGP6yJam0SZxWYGeWYc-7G-0_oku3jhC5ORFN5ToMMAk
Message-ID: <CABBYNZJg6f4GCk0SToAYn4carEkjizXGV7cNsBLr6o=Es1=oCg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 3/3] monitor: Support vendor HCI packets
To: Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Zijun Hu <zijun_hu@icloud.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zijun,

On Mon, Aug 31, 2026 at 1:39=E2=80=AFAM Zijun Hu <zijun.hu@oss.qualcomm.com=
> wrote:
>
> Vendor HCI packets have 0xff as packet type.
>
> Support them in tool btmon.
>
> ---
> Changes since previous version:
> - Rename COLOR_VENDOR_HCI to COLOR_HCI_VENDOR
> - Rename packet_vendor_hci() to packet_hci_vendor()
> - Improve the commit title and message
> ---
>  doc/btsnoop-protocol.rst |  8 ++++++++
>  monitor/analyze.c        | 23 +++++++++++++++++++++++
>  monitor/packet.c         | 26 ++++++++++++++++++++++++++
>  monitor/packet.h         |  2 ++
>  src/shared/btsnoop.h     |  2 ++
>  5 files changed, 61 insertions(+)
>
> diff --git a/doc/btsnoop-protocol.rst b/doc/btsnoop-protocol.rst
> index a875db63a9dd..81cd8fdc71ae 100644
> --- a/doc/btsnoop-protocol.rst
> +++ b/doc/btsnoop-protocol.rst
> @@ -111,16 +111,24 @@ values match the definitions in ``src/shared/btsnoo=
p.h``.
>     * - BTSNOOP_OPCODE_ISO_TX_PKT
>       - 18
>       - 0x0012
>       - Outgoing ISO packet
>     * - BTSNOOP_OPCODE_ISO_RX_PKT
>       - 19
>       - 0x0013
>       - Incoming ISO packet
> +   * - BTSNOOP_OPCODE_VENDOR_TX_PKT
> +     - 22
> +     - 0x0016
> +     - Outgoing vendor HCI packet
> +   * - BTSNOOP_OPCODE_VENDOR_RX_PKT
> +     - 23
> +     - 0x0017
> +     - Incoming vendor HCI packet
>
>  New Index
>  ---------
>
>  Code: 0x0000
>
>  Parameters:
>
> diff --git a/monitor/analyze.c b/monitor/analyze.c
> index de9c23603a21..59e8ac819272 100644
> --- a/monitor/analyze.c
> +++ b/monitor/analyze.c
> @@ -39,16 +39,17 @@ struct hci_dev {
>         struct timeval time_added;
>         struct timeval time_removed;
>         unsigned long num_hci;
>         unsigned long num_cmd;
>         unsigned long num_evt;
>         unsigned long num_acl;
>         unsigned long num_sco;
>         unsigned long num_iso;
> +       unsigned long vendor_hci;
>         unsigned long vendor_diag;
>         unsigned long system_note;
>         unsigned long user_log;
>         unsigned long ctrl_msg;
>         unsigned long unknown;
>         uint16_t manufacturer;
>         struct queue *conn_list;
>  };
> @@ -460,16 +461,17 @@ static void dev_destroy(void *data)
>         printf("\n");
>
>
>         printf("  %lu commands\n", dev->num_cmd);
>         printf("  %lu events\n", dev->num_evt);
>         printf("  %lu ACL packets\n", dev->num_acl);
>         printf("  %lu SCO packets\n", dev->num_sco);
>         printf("  %lu ISO packets\n", dev->num_iso);
> +       printf("  %lu vendor HCI packets\n", dev->vendor_hci);
>         printf("  %lu vendor diagnostics\n", dev->vendor_diag);
>         printf("  %lu system notes\n", dev->system_note);
>         printf("  %lu user logs\n", dev->user_log);
>         printf("  %lu control messages \n", dev->ctrl_msg);
>         printf("  %lu unknown opcodes\n", dev->unknown);
>         queue_destroy(dev->conn_list, conn_destroy);
>         printf("\n");
>
> @@ -1357,16 +1359,29 @@ static void iso_pkt(struct timeval *tv, uint16_t =
index, bool out,
>
>         if (out) {
>                 conn_pkt_tx(conn, tv, size - sizeof(*hdr), NULL);
>         } else {
>                 conn_pkt_rx(conn, tv, size - sizeof(*hdr), NULL);
>         }
>  }
>
> +static void vendor_hci_pkt(struct timeval *tv, uint16_t index, bool out,
> +                                       const void *data, uint16_t size)
> +{
> +       struct hci_dev *dev;
> +
> +       dev =3D dev_lookup(index);
> +       if (!dev)
> +               return;
> +
> +       dev->num_hci++;
> +       dev->vendor_hci++;
> +}
> +
>  static void unknown_opcode(struct timeval *tv, uint16_t index,
>                                         const void *data, uint16_t size)
>  {
>         struct hci_dev *dev;
>
>         dev =3D dev_lookup(index);
>         if (!dev)
>                 return;
> @@ -1463,16 +1478,24 @@ void analyze_trace(const char *path)
>                 case BTSNOOP_OPCODE_ISO_TX_PKT:
>                         num_frames++;
>                         iso_pkt(&tv, index, true, buf, pktlen);
>                         break;
>                 case BTSNOOP_OPCODE_ISO_RX_PKT:
>                         num_frames++;
>                         iso_pkt(&tv, index, false, buf, pktlen);
>                         break;
> +               case BTSNOOP_OPCODE_VENDOR_TX_PKT:
> +                       num_frames++;
> +                       vendor_hci_pkt(&tv, index, true, buf, pktlen);
> +                       break;
> +               case BTSNOOP_OPCODE_VENDOR_RX_PKT:
> +                       num_frames++;
> +                       vendor_hci_pkt(&tv, index, false, buf, pktlen);
> +                       break;
>                 default:
>                         unknown_opcode(&tv, index, buf, pktlen);
>                         break;
>                 }
>
>                 num_packets++;
>         }
>
> diff --git a/monitor/packet.c b/monitor/packet.c
> index 0d3b23cc3fb7..7adcf64a3631 100644
> --- a/monitor/packet.c
> +++ b/monitor/packet.c
> @@ -67,16 +67,17 @@
>
>  #define COLOR_HCI_COMMAND              COLOR_BLUE
>  #define COLOR_HCI_COMMAND_UNKNOWN      COLOR_WHITE_BG
>  #define COLOR_HCI_EVENT                        COLOR_MAGENTA
>  #define COLOR_HCI_EVENT_UNKNOWN                COLOR_WHITE_BG
>  #define COLOR_HCI_ACLDATA              COLOR_CYAN
>  #define COLOR_HCI_SCODATA              COLOR_YELLOW
>  #define COLOR_HCI_ISODATA              COLOR_YELLOW
> +#define COLOR_HCI_VENDOR               COLOR_GREEN
>
>  #define COLOR_UNKNOWN_ERROR            COLOR_WHITE_BG
>  #define COLOR_UNKNOWN_FEATURE_BIT      COLOR_WHITE_BG
>  #define COLOR_UNKNOWN_COMMAND_BIT      COLOR_WHITE_BG
>  #define COLOR_UNKNOWN_EVENT_MASK       COLOR_WHITE_BG
>  #define COLOR_UNKNOWN_LE_STATES                COLOR_WHITE_BG
>  #define COLOR_UNKNOWN_SERVICE_CLASS    COLOR_WHITE_BG
>  #define COLOR_UNKNOWN_PKT_TYPE_BIT     COLOR_WHITE_BG
> @@ -4523,16 +4524,22 @@ void packet_monitor(struct timeval *tv, struct uc=
red *cred,
>                 packet_hci_scodata(tv, cred, index, true, data, size);
>                 break;
>         case BTSNOOP_OPCODE_ISO_TX_PKT:
>                 packet_hci_isodata(tv, cred, index, false, data, size);
>                 break;
>         case BTSNOOP_OPCODE_ISO_RX_PKT:
>                 packet_hci_isodata(tv, cred, index, true, data, size);
>                 break;
> +       case BTSNOOP_OPCODE_VENDOR_TX_PKT:
> +               packet_hci_vendor(tv, cred, index, false, data, size);
> +               break;
> +       case BTSNOOP_OPCODE_VENDOR_RX_PKT:
> +               packet_hci_vendor(tv, cred, index, true, data, size);
> +               break;
>         case BTSNOOP_OPCODE_OPEN_INDEX:
>                 if (index < MAX_INDEX)
>                         addr2str(index_list[index].bdaddr, str);
>                 else
>                         sprintf(str, "00:00:00:00:00:00");
>
>                 packet_open_index(tv, index, str);
>                 break;
> @@ -14650,16 +14657,35 @@ malformed:
>                 print_packet(tv, cred, '*', index, NULL, COLOR_ERROR,
>                                 "Malformed ISO Data RX packet", NULL, NUL=
L);
>         else
>                 print_packet(tv, cred, '*', index, NULL, COLOR_ERROR,
>                                 "Malformed ISO Data TX packet", NULL, NUL=
L);
>         packet_hexdump(data, size);
>  }
>
> +void packet_hci_vendor(struct timeval *tv, struct ucred *cred, uint16_t =
index,
> +                               bool in, const void *data, uint16_t size)
> +{
> +       char extra_str[16];
> +
> +       if (index >=3D MAX_INDEX) {
> +               print_field("Invalid index (%d).", index);
> +               return;
> +       }
> +
> +       index_list[index].frame++;
> +
> +       sprintf(extra_str, "(len %d)", size);
> +       print_packet(tv, cred, in ? '>' : '<', index, NULL, COLOR_HCI_VEN=
DOR,
> +                               "Vendor HCI Packet", NULL, extra_str);
> +
> +       packet_hexdump(data, size);
> +}

There is already support for vendor traffic:

static const struct vendor_ocf *current_vendor_ocf(uint16_t ocf)
{
uint16_t manufacturer, msft_opcode;

if (index_current < MAX_INDEX) {
manufacturer =3D index_list[index_current].manufacturer;
msft_opcode =3D index_list[index_current].msft_opcode;
} else {
manufacturer =3D fallback_manufacturer;
msft_opcode =3D BT_HCI_CMD_NOP;
}

if (msft_opcode !=3D BT_HCI_CMD_NOP &&
cmd_opcode_ocf(msft_opcode) =3D=3D ocf)
return msft_vendor_ocf();

switch (manufacturer) {
case COMPANY_ID_INTEL:
return intel_vendor_ocf(ocf);
case COMPANY_ID_BROADCOM:
return broadcom_vendor_ocf(ocf);
}

return NULL;
}

static const struct vendor_evt *current_vendor_evt(const void *data,
uint8_t size, int *consumed_size)
{
uint16_t manufacturer;
uint8_t evt =3D *((const uint8_t *) data);

if (msft_event_prefix_match(data, size)) {
*consumed_size =3D index_list[index_current].msft_evt_len;
return msft_vendor_evt();
}

/* A regular vendor event consumes 1 byte. */
*consumed_size =3D 1;

if (index_current < MAX_INDEX)
manufacturer =3D index_list[index_current].manufacturer;
else
manufacturer =3D fallback_manufacturer;

switch (manufacturer) {
case COMPANY_ID_INTEL:
return intel_vendor_evt(data, consumed_size);
case COMPANY_ID_BROADCOM:
return broadcom_vendor_evt(evt);
}

return NULL;
}

So this not only fails to use the manufacturer info to hook into its
own dedicated file but it makes the vendor packets completely opaque
by just hexdumping their content.

>  void packet_ctrl_open(struct timeval *tv, struct ucred *cred, uint16_t i=
ndex,
>                                         const void *data, uint16_t size)
>  {
>         uint32_t cookie;
>         uint16_t format;
>         char channel[11];
>
>         if (size < 6) {
> diff --git a/monitor/packet.h b/monitor/packet.h
> index 73a86f64b242..8c519eca61c1 100644
> --- a/monitor/packet.h
> +++ b/monitor/packet.h
> @@ -130,16 +130,18 @@ void packet_hci_command(struct timeval *tv, struct =
ucred *cred, uint16_t index,
>  void packet_hci_event(struct timeval *tv, struct ucred *cred, uint16_t i=
ndex,
>                                         const void *data, uint16_t size);
>  void packet_hci_acldata(struct timeval *tv, struct ucred *cred, uint16_t=
 index,
>                                 bool in, const void *data, uint16_t size)=
;
>  void packet_hci_scodata(struct timeval *tv, struct ucred *cred, uint16_t=
 index,
>                                 bool in, const void *data, uint16_t size)=
;
>  void packet_hci_isodata(struct timeval *tv, struct ucred *cred, uint16_t=
 index,
>                                 bool in, const void *data, uint16_t size)=
;
> +void packet_hci_vendor(struct timeval *tv, struct ucred *cred, uint16_t =
index,
> +                               bool in, const void *data, uint16_t size)=
;
>
>  void packet_ctrl_open(struct timeval *tv, struct ucred *cred, uint16_t i=
ndex,
>                                         const void *data, uint16_t size);
>  void packet_ctrl_close(struct timeval *tv, struct ucred *cred, uint16_t =
index,
>                                         const void *data, uint16_t size);
>  void packet_ctrl_command(struct timeval *tv, struct ucred *cred, uint16_=
t index,
>                                         const void *data, uint16_t size);
>  void packet_ctrl_event(struct timeval *tv, struct ucred *cred, uint16_t =
index,
> diff --git a/src/shared/btsnoop.h b/src/shared/btsnoop.h
> index c24755d56729..efa87a8f2971 100644
> --- a/src/shared/btsnoop.h
> +++ b/src/shared/btsnoop.h
> @@ -37,16 +37,18 @@
>  #define BTSNOOP_OPCODE_SYSTEM_NOTE     12
>  #define BTSNOOP_OPCODE_USER_LOGGING    13
>  #define BTSNOOP_OPCODE_CTRL_OPEN       14
>  #define BTSNOOP_OPCODE_CTRL_CLOSE      15
>  #define BTSNOOP_OPCODE_CTRL_COMMAND    16
>  #define BTSNOOP_OPCODE_CTRL_EVENT      17
>  #define BTSNOOP_OPCODE_ISO_TX_PKT      18
>  #define BTSNOOP_OPCODE_ISO_RX_PKT      19
> +#define BTSNOOP_OPCODE_VENDOR_TX_PKT   22
> +#define BTSNOOP_OPCODE_VENDOR_RX_PKT   23
>
>  #define BTSNOOP_MAX_PACKET_SIZE                (1486 + 4)
>
>  #define BTSNOOP_TYPE_PRIMARY   0
>  #define BTSNOOP_TYPE_AMP       1
>
>  #define BTSNOOP_BUS_VIRTUAL    0
>  #define BTSNOOP_BUS_USB                1
>
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
