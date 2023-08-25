Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1B7EE49A3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Aug 2023 20:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjHYUGa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Aug 2023 16:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjHYUGA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Aug 2023 16:06:00 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551832689
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Aug 2023 13:05:57 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b703a0453fso19845341fa.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Aug 2023 13:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692993955; x=1693598755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3s4X3FKruQeV+k3LbHE4o8mnuJuvVp8gZyBaVefO7c=;
        b=RHuV4SEDDiAcwBra8hPmtXWaaBoyPlhVW05LrN7geZz7wFDUGpHFUt5Uo3PfO7nyPF
         ZK3/C9Hal6YsQmrcxsFw/Lrqa08w0QPYYEPIzAmChImJHJEeHBLeNCfL/f0KX0yqG3kI
         fMWSwYAL0Z2w3EP2d97IcJEIvsB/BMbDe9C59F0js953QwWQsOMU0/55911BU1SXmUQn
         t3Cj19+XW5kmDk9V30Ef7UsvAvQRgwh9++KglbphxNvBvc42LuhjMZ+QRzb+R/de3CR6
         gK92qXYNWSZmlD1bRA6Wfua0isDMB9hghLex7auf6kwcVEhnHcDBPfZShDuLQYEalZGl
         sLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692993955; x=1693598755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I3s4X3FKruQeV+k3LbHE4o8mnuJuvVp8gZyBaVefO7c=;
        b=QvpwmKEwCGjgaXIrXcD/NJCoOdypJUlt6T0Zh7NDn+QQigLqL2vhPM8RPlOf3zBNlj
         JhgJJlcIErRNb+9PtsGtr3oXymx2tKjPJ+1H6RkHrFMO0428eS5DcO7fjJ6Da399C02X
         KwzAbPWOPDMoIoPiUH1bNgSXMmtKUE1jlfPwgYyhT7QhOWq/iBR2DErC5hz7W9gjrtiP
         iyqe/P59mmAozH5VRPVAi6q96sVmcaRQEDL/7EXwcH+wAZeTNzyH1xYtqoa4+rpOu3an
         2NJugZ/jp09Sv2b5wnuUW4Gr97kI2X74kfoCIoLodIujNGgHsiUI6VCVrKc5oHZSvtIy
         llmA==
X-Gm-Message-State: AOJu0Yxp4mDeXyaudMTIORBSjpjMBr5bOPCyMv4fh1kE9UD38R+8PJ4V
        8IyPXfmQW65eIxSmZy4kMbEv8i1qcg3V7fGzY/4=
X-Google-Smtp-Source: AGHT+IHGpPptGrg+rImMqOJKNwkknRzNaypHZ7JBHvbr48TR0gDZUgRZAHXC99LHjRtpSRihKIn3hAbgFSMYEI/VgFY=
X-Received: by 2002:a2e:9e09:0:b0:2b6:dac0:affe with SMTP id
 e9-20020a2e9e09000000b002b6dac0affemr14647797ljk.31.1692993955267; Fri, 25
 Aug 2023 13:05:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230824102407.25883-1-iulia.tanasescu@nxp.com> <20230824102407.25883-3-iulia.tanasescu@nxp.com>
In-Reply-To: <20230824102407.25883-3-iulia.tanasescu@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 25 Aug 2023 13:05:42 -0700
Message-ID: <CABBYNZ+ncrqo64pEc9FSASaiScR=G-bBmAVEqYtU37JKn_v3Tw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/4] monitor: Add decoding support for BIGInfo mgmt event
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Iulia,

On Fri, Aug 25, 2023 at 12:41=E2=80=AFAM Iulia Tanasescu
<iulia.tanasescu@nxp.com> wrote:
>
> This adds btmon support for decoding BIGInfo MGMT events.
>
> ---
>  monitor/control.c | 25 +++++++++++++++++++++++++
>  monitor/packet.c  | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 58 insertions(+)
>
> diff --git a/monitor/control.c b/monitor/control.c
> index 009cf1520..b843d076f 100644
> --- a/monitor/control.c
> +++ b/monitor/control.c
> @@ -5,6 +5,7 @@
>   *
>   *  Copyright (C) 2011-2014  Intel Corporation
>   *  Copyright (C) 2002-2010  Marcel Holtmann <marcel@holtmann.org>
> + *  Copyright 2023 NXP
>   *
>   *
>   */
> @@ -788,6 +789,27 @@ static void mgmt_advertising_removed(uint16_t len, c=
onst void *buf)
>         packet_hexdump(buf, len);
>  }
>
> +static void mgmt_big_info_adv_report(uint16_t len, const void *buf)
> +{
> +       const struct mgmt_ev_le_big_info_adv_report *ev =3D buf;
> +       uint16_t sync_handle;
> +
> +       if (len < sizeof(*ev)) {
> +               printf("* Malformed BIGInfo advertising report control\n"=
);
> +               return;
> +       }
> +
> +       sync_handle =3D le16_to_cpu(ev->sync_handle);
> +
> +       printf("@ BIGInfo Advertising Report: sync_handle 0x%4.4x num_bis=
 %u "
> +               "encryption %u\n", sync_handle, ev->num_bis, ev->encrypti=
on);
> +
> +       buf +=3D sizeof(*ev);
> +       len -=3D sizeof(*ev);
> +
> +       packet_hexdump(buf, len);
> +}
> +
>  void control_message(uint16_t opcode, const void *data, uint16_t size)
>  {
>         if (!decode_control)
> @@ -893,6 +915,9 @@ void control_message(uint16_t opcode, const void *dat=
a, uint16_t size)
>         case MGMT_EV_ADVERTISING_REMOVED:
>                 mgmt_advertising_removed(size, data);
>                 break;
> +       case MGMT_EV_LE_BIG_INFO_ADV_REPORT:
> +               mgmt_big_info_adv_report(size, data);
> +               break;
>         default:
>                 printf("* Unknown control (code %d len %d)\n", opcode, si=
ze);
>                 packet_hexdump(data, size);
> diff --git a/monitor/packet.c b/monitor/packet.c
> index 8eae8c9ea..96fc2662e 100644
> --- a/monitor/packet.c
> +++ b/monitor/packet.c
> @@ -15396,6 +15396,37 @@ static void mgmt_mesh_device_found_evt(const voi=
d *data, uint16_t size)
>         print_hex_field("EIR Data", eir_data, size);
>  }
>
> +static void mgmt_big_info_adv_report(const void *data, uint16_t size)
> +{
> +       uint16_t sync_handle =3D get_le16(data);
> +       uint8_t num_bis =3D get_u8(data + 2);
> +       uint8_t nse =3D get_u8(data + 3);
> +       uint16_t iso_interval =3D get_le16(data + 4);
> +       uint8_t bn =3D get_u8(data + 6);
> +       uint8_t pto =3D get_u8(data + 7);
> +       uint8_t irc =3D get_u8(data + 8);
> +       uint16_t max_pdu =3D get_le16(data + 9);
> +       const uint8_t *sdu_interval =3D data + 11;
> +       uint16_t max_sdu =3D get_le16(data + 14);
> +       uint8_t phy =3D get_u8(data + 16);
> +       uint8_t framing =3D get_u8(data + 17);
> +       uint8_t encryption =3D get_u8(data + 18);
> +
> +       print_field("Sync Handle: 0x%4.4x", sync_handle);
> +       print_field("Number BIS: %u", num_bis);
> +       print_field("NSE: %u", nse);
> +       print_slot_125("ISO Interval", iso_interval);
> +       print_field("BN: %u", bn);
> +       print_field("PTO: %u", pto);
> +       print_field("IRC: %u", irc);
> +       print_field("Maximum PDU: %u", max_pdu);
> +       print_usec_interval("SDU Interval", sdu_interval);
> +       print_field("Maximum SDU: %u", max_sdu);
> +       print_le_phy("PHY", phy);
> +       print_framing(framing);
> +       print_field("Encryption: 0x%02x", encryption);
> +}
> +
>  static void mgmt_mesh_packet_cmplt_evt(const void *data, uint16_t size)
>  {
>         uint8_t handle =3D get_u8(data);
> @@ -15500,6 +15531,8 @@ static const struct mgmt_data mgmt_event_table[] =
=3D {
>                         mgmt_mesh_device_found_evt, 22, false },
>         { 0x0032, "Mesh Packet Complete",
>                         mgmt_mesh_packet_cmplt_evt, 1, true },
> +       { 0x0033, "BIGInfo advertising report",
> +                       mgmt_big_info_adv_report, 19, false },

This should got to the ISO socket not via mgmt interface, that said we
may need to do some changes to how we discover the broadcast, it seems
we will need to do short lived PA sync to enumerate the BASE, so I
think we are better of having the driver register with BAA UUID,
initially this can probably be done in userspace so once it detects
the device is advertising with BCAA it will attempt to fetch the BASE
automatically and merge it into the bt_ad.

Later on we may decide to move this into the kernel as part of general
discovery procedure and then merge the discovered BASE into Device
Found event, etc, but I think it is too early to evaluate if that is a
good idea or not before exploring if the short lived PA sync would
work reliably, or if we really need a dedicated API for discovering
Broadcasters.

>         { }
>  };
>
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
