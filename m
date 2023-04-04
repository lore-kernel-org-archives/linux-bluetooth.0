Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3630FC761A6
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Apr 2023 18:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235811AbjDDSNj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Apr 2023 14:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbjDDSNh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Apr 2023 14:13:37 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1A4AC
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 Apr 2023 11:13:35 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id h11so36485605lfu.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Apr 2023 11:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680632013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtb986e1FdVh8XCYOf6ZMTAcHoGRPBYaRaeT5U97s98=;
        b=mtQxLUBRr6eCQ1EoGNDueltscb8z+a+Cymq8FGt45I0C+5TB87iLlOyR7/XUEsyAj7
         9BgzIKMHkfB02WChC8PJRsymA3XXU6OmQmCxp9xehmfXMeR6ecotN6jdRZyq177a11w/
         GXfkNQEfR61ZLWamhKRdc+AZ04KQHMI1tdbOQtgNkDGRBlrer0ZSZ9XEaUa7FS2S8yQx
         nmmrRW7eACGUck0TVCVwT83AEWsUouq9wUhrZR1OQo1h281/tZ5EIvF/nDT2nEpggJjt
         umsI+dfnEVv7MRo1H/3XkdQZprLAEXHebMPsk3WSVDJDsGTFOTN1sgupAx/XKnT1CuDL
         6pVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680632013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xtb986e1FdVh8XCYOf6ZMTAcHoGRPBYaRaeT5U97s98=;
        b=Nk7ga/Meg6WrzSwlFwFITaqkrLYbP7KLTyvTe+RjMOFR2YK6HWmyPKF7rfmkwt2sRv
         Z+Btx2Ft09GK7AlL+8EzYmKpRST+pDWzBV65zbsQZVf5PGY/OGG6t10+RC4mcDf6C2BZ
         TS9kJyhHg/6XMgg8SKkL7lOjfXEE6HpErSGu9ErqhqqfgA7hX9UWz960nwdYUhE8qOOq
         7l0r94MPucIGUn+A+l6WqmuwgcOjHuH2oymx98adI1JNDPuNPpWEaWtHQ1MRUNpeCAER
         LrM6RqP7lT7NUFhxFle56IPtFTSopv9B8HSnZ53AjDkTvTy1Mtsv/eHuYlWVYJYSu/Bm
         vDww==
X-Gm-Message-State: AAQBX9f0Mjs8Vn07eChPLzdA9HehJbeacA3LxNLnFD+ty1pdBbA0HA1M
        qG/qAI6uyEhtdoxyB9bhSvCCgu4LbOXfDTJTs9Q829r7
X-Google-Smtp-Source: AKy350YvpZtHJ9mUc2zp789MWYZ4CJnznzkIRHUmNfCVBDTohS2Bs/l6d/c3yzulBEmua5PAlaQ7NFzTslQ8bUYEcm0=
X-Received: by 2002:a19:740f:0:b0:4eb:d8d:6c17 with SMTP id
 v15-20020a19740f000000b004eb0d8d6c17mr1014601lfe.10.1680632013095; Tue, 04
 Apr 2023 11:13:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230404143053.101464-1-iulia.tanasescu@nxp.com> <20230404143053.101464-2-iulia.tanasescu@nxp.com>
In-Reply-To: <20230404143053.101464-2-iulia.tanasescu@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 4 Apr 2023 11:13:21 -0700
Message-ID: <CABBYNZK7_SCq4hN27GjV1i=TxN3DLfy0+nrMLN3ZwP99AqL76A@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/1] monitor/att: Add decoding support for BASS
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Iulia,

On Tue, Apr 4, 2023 at 7:47=E2=80=AFAM Iulia Tanasescu <iulia.tanasescu@nxp=
.com> wrote:
>
> This adds decoding support for BASS attributes:
>
> > ACL Data RX: Handle 0 flags 0x02 dlen 7
>       ATT: Read Request (0x0a) len 2
>         Handle: 0x003a Type: Broadcast Receive State (0x2bc8)
>
> < ACL Data TX: Handle 0 flags 0x00 dlen 45
>       ATT: Read Response (0x0b) len 40
>         Value: 0100f2698be807c0013a65010203b803eac6afbb65a25a41f15305
>                 68020101000000000403020400
>         Handle: 0x003a Type: Broadcast Receive State (0x2bc8)

Swap these 2 lines above so Handle is printed first and values latter.

>           Source_ID: 1
>           Source_Address_Type: 0
>           Source_Address: C0:07:E8:8B:69:F2
>           Source_Adv_SID: 1
>           Broadcast_ID: 0x01653a
>           PA_Sync_State: Synchronized to PA
>           BIG_Encryption: Broadcast_Code required
>           Num_Subgroups: 1
>           Subgroup #0:
>             BIS_Sync State: 0x00000000
>             Metadata #0: len 0x03 type 0x02
>             Metadata: 0400
>
> > ACL Data RX: Handle 0 flags 0x02 dlen 7
>       ATT: Read Request (0x0a) len 2
>         Handle: 0x003d Type: Broadcast Receive State (0x2bc8)
>
> < ACL Data TX: Handle 0 flags 0x00 dlen 5
>       ATT: Read Response (0x0b) len 0
>         Value:
>         Handle: 0x003d Type: Broadcast Receive State (0x2bc8)
>           Empty characteristic
>
> > ACL Data RX: Handle 0 flags 0x02 dlen 8
>       ATT: Write Request (0x12) len 3
>         Handle: 0x0040 Type: Broadcast Audio Scan Control Point (0x2bc7)
>           Data: 00
>             Opcode: Remote Scan Stopped (0x00)
>
> < ACL Data TX: Handle 0 flags 0x00 dlen 9
>       ATT: Error Response (0x01) len 4
>         Write Request (0x12)
>         Handle: 0x0040
>         Error: Reserved (0x80)
>
> > ACL Data RX: Handle 0 flags 0x02 dlen 8
>       ATT: Write Request (0x12) len 3
>         Handle: 0x0040 Type: Broadcast Audio Scan Control Point (0x2bc7)
>           Data: 01
>             Opcode: Remote Scan Started (0x01)
>
> < ACL Data TX: Handle 0 flags 0x00 dlen 9
>       ATT: Error Response (0x01) len 4
>         Write Request (0x12)
>         Handle: 0x0040
>         Error: Reserved (0x80)
>
> > ACL Data RX: Handle 0 flags 0x01 dlen 5
>       ATT: Write Request (0x12) len 27
>         Handle: 0x0040 Type: Broadcast Audio Scan Control Point (0x2bc7)
>           Data: 0200f2698be807c0013a650100ffff01000000000403020400
>             Opcode: Add Source (0x02)
>             Source_Address_Type: 0
>             Source_Address: C0:07:E8:8B:69:F2
>             Source_Adv_SID: 1
>             Broadcast_ID: 0x01653a
>             PA_Sync_State: Do not synchronize to PA
>             PA_Interval: 0xffff
>             Num_Subgroups: 1
>             Subgroup #0:
>               BIS_Sync State: 0x00000000
>               Metadata #0: len 0x03 type 0x02
>               Metadata: 0400
>
> < ACL Data TX: Handle 0 flags 0x00 dlen 9
>       ATT: Error Response (0x01) len 4
>         Write Request (0x12)
>         Handle: 0x0040
>         Error: Reserved (0x80)
>
> > ACL Data RX: Handle 0 flags 0x02 dlen 22
>       ATT: Write Request (0x12) len 17
>         Handle: 0x0040 Type: Broadcast Audio Scan Control Point (0x2bc7)
>           Data: 030102780001000000000403040400
>             Opcode: Modify Source (0x03)
>             Source_ID: 1
>             PA_Sync_State: Synchronize to PA - PAST not available
>             PA_Interval: 0x0078
>             Num_Subgroups: 1
>             Subgroup #0:
>               BIS_Sync State: 0x00000000
>               Metadata #0: len 0x03 type 0x04
>               Metadata: 0400
>
> < ACL Data TX: Handle 0 flags 0x00 dlen 9
>       ATT: Error Response (0x01) len 4
>         Write Request (0x12)
>         Handle: 0x0040
>         Error: Reserved (0x80)
>
> > ACL Data RX: Handle 0 flags 0x02 dlen 25
>       ATT: Write Request (0x12) len 20
>         Handle: 0x0040 Type: Broadcast Audio Scan Control Point (0x2bc7)
>           Data: 0401b803eac6afbb65a25a41f15305680201
>             Opcode: Set Broadcast_Code (0x04)
>             Source_ID: 1
>             Broadcast_Code: b803eac6afbb65a25a41f15305680201
>
> < ACL Data TX: Handle 0 flags 0x00 dlen 5
>       ATT: Write Response (0x13) len 0
>
> < ACL Data TX: Handle 0 flags 0x00 dlen 33
>       ATT: Handle Multiple Value Notification (0x23) len 28
>         Length: 0x0018
>         Handle: 0x003a Type: Broadcast Receive State (0x2bc8)
>           Data: 0100f2698be807c0013a6501020201000000000403020400
>           Source_ID: 1
>           Source_Address_Type: 0
>           Source_Address: C0:07:E8:8B:69:F2
>           Source_Adv_SID: 1
>           Broadcast_ID: 0x01653a
>           PA_Sync_State: Synchronized to PA
>           BIG_Encryption: Decrypting
>           Num_Subgroups: 1
>           Subgroup #0:
>             BIS_Sync State: 0x00000000
>             Metadata #0: len 0x03 type 0x02
>             Metadata: 0400
>
> > ACL Data RX: Handle 0 flags 0x02 dlen 9
>       ATT: Write Request (0x12) len 4
>         Handle: 0x0040 Type: Broadcast Audio Scan Control Point (0x2bc7)
>           Data: 0501
>             Opcode: Remove Source (0x05)
>             Source_ID: 1
>
> < ACL Data TX: Handle 0 flags 0x00 dlen 9
>       ATT: Error Response (0x01) len 4
>         Write Request (0x12)
>         Handle: 0x0040
>         Error: Reserved (0x80)
>
> ---
>  monitor/att.c | 461 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 461 insertions(+)
>
> diff --git a/monitor/att.c b/monitor/att.c
> index ff77620c5..4baf029ed 100644
> --- a/monitor/att.c
> +++ b/monitor/att.c
> @@ -5,6 +5,7 @@
>   *
>   *  Copyright (C) 2011-2014  Intel Corporation
>   *  Copyright (C) 2002-2010  Marcel Holtmann <marcel@holtmann.org>
> + *  Copyright 2023 NXP
>   *
>   *
>   */
> @@ -2514,6 +2515,462 @@ static void content_control_id_read(const struct =
l2cap_frame *frame)
>         print_content_control_id(frame);
>  }
>
> +static const struct pa_sync_state_decoder {
> +       uint8_t code;
> +       char *value;
> +} pa_sync_state_decoders[] =3D {
> +       { 0x00, "Not synchronized to PA" },
> +       { 0x01, "SyncInfo Request" },
> +       { 0x02, "Synchronized to PA" },
> +       { 0x03, "Failed to synchronize to PA" },
> +       { 0x04, "No PAST" },
> +};
> +
> +static const struct cp_pa_sync_state_decoder {
> +       uint8_t code;
> +       char *value;
> +} cp_pa_sync_state_decoders[] =3D {
> +       { 0x00, "Do not synchronize to PA" },
> +       { 0x01, "Synchronize to PA - PAST available" },
> +       { 0x02, "Synchronize to PA - PAST not available" },
> +};
> +
> +static const struct big_enc_decoder {
> +       uint8_t code;
> +       char *value;
> +} big_enc_decoders[] =3D {
> +       { 0x00, "Not encrypted" },
> +       { 0x01, "Broadcast_Code required" },
> +       { 0x02, "Decrypting" },
> +       { 0x03, "Bad_Code (incorrect encryption key)" },
> +};
> +
> +static bool print_subgroup_lv(const struct l2cap_frame *frame,
> +               const char *label, struct packet_ltv_decoder *decoder,
> +               size_t decoder_len)
> +{
> +       struct bt_hci_lv_data *lv;
> +
> +       lv =3D l2cap_frame_pull((void *)frame, frame, sizeof(*lv));
> +       if (!lv) {
> +               print_text(COLOR_ERROR, "%s: invalid size", label);
> +               return false;
> +       }
> +
> +       if (!l2cap_frame_pull((void *)frame, frame, lv->len)) {
> +               print_text(COLOR_ERROR, "%s: invalid size", label);
> +               return false;
> +       }
> +
> +       packet_print_ltv(label, lv->data, lv->len, decoder, decoder_len);
> +
> +       return true;
> +}
> +
> +static bool print_subgroup_metadata(const char *label,
> +                               const struct l2cap_frame *frame)
> +{
> +       return print_subgroup_lv(frame, label, NULL, 0);
> +}
> +
> +static void print_bcast_recv_state(const struct l2cap_frame *frame)
> +{
> +       uint8_t i;
> +       uint8_t id;
> +       uint8_t addr_type;
> +       uint8_t *addr;
> +       uint8_t sid;
> +       uint32_t bid;
> +       uint8_t pa_sync_state;
> +       uint8_t enc;
> +       uint8_t *bad_code;
> +       uint8_t num_subgroups =3D 0;
> +       uint32_t bis_sync_state;
> +
> +       if (frame->size =3D=3D 0) {
> +               print_field("  Empty characteristic");
> +               goto done;
> +       }
> +
> +       if (!l2cap_frame_get_u8((void *)frame, &id)) {
> +               print_text(COLOR_ERROR, "Source_ID: invalid size");
> +               goto done;
> +       }
> +
> +       print_field("  Source_ID: %u", id);
> +
> +       if (!l2cap_frame_get_u8((void *)frame, &addr_type)) {
> +               print_text(COLOR_ERROR, "Source_Address_Type: invalid siz=
e");
> +               goto done;
> +       }
> +
> +       print_field("  Source_Address_Type: %u", addr_type);
> +
> +       addr =3D l2cap_frame_pull((void *)frame, frame, sizeof(bdaddr_t))=
;
> +       if (!addr) {
> +               print_text(COLOR_ERROR, "Source_Address: invalid size");
> +               goto done;
> +       }
> +
> +       print_field("  Source_Address: %2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2=
X",
> +                                       addr[5], addr[4],
> +                                       addr[3], addr[2],
> +                                       addr[1], addr[0]);
> +
> +       if (!l2cap_frame_get_u8((void *)frame, &sid)) {
> +               print_text(COLOR_ERROR, "Source_Adv_SID: invalid size");
> +               goto done;
> +       }
> +
> +       print_field("  Source_Adv_SID: %u", sid);
> +
> +       if (!l2cap_frame_get_le24((void *)frame, &bid)) {
> +               print_text(COLOR_ERROR, "Broadcast_ID: invalid size");
> +               goto done;
> +       }
> +
> +       print_field("  Broadcast_ID: 0x%06x", bid);
> +
> +       if (!l2cap_frame_get_u8((void *)frame, &pa_sync_state)) {
> +               print_text(COLOR_ERROR, "PA_Sync_State: invalid size");
> +               goto done;
> +       }
> +
> +       for (i =3D 0; i < ARRAY_SIZE(pa_sync_state_decoders); i++) {
> +               const struct pa_sync_state_decoder *decoder;
> +
> +               decoder =3D &pa_sync_state_decoders[i];
> +
> +               if (decoder->code =3D=3D pa_sync_state) {
> +                       print_field("  PA_Sync_State: %s", decoder->value=
);
> +                       break;
> +               }
> +       }
> +
> +       if (i =3D=3D ARRAY_SIZE(pa_sync_state_decoders))
> +               print_field("  PA_Sync_State: %s", "Invalid value");
> +
> +       if (!l2cap_frame_get_u8((void *)frame, &enc)) {
> +               print_text(COLOR_ERROR, "BIG_Encryption: invalid size");
> +               goto done;
> +       }
> +
> +       for (i =3D 0; i < ARRAY_SIZE(big_enc_decoders); i++) {
> +               const struct big_enc_decoder *decoder;
> +
> +               decoder =3D &big_enc_decoders[i];
> +
> +               if (decoder->code =3D=3D enc) {
> +                       print_field("  BIG_Encryption: %s", decoder->valu=
e);
> +                       break;
> +               }
> +       }
> +
> +       if (i =3D=3D ARRAY_SIZE(big_enc_decoders))
> +               print_field("  BIG_Encryption: %s", "Invalid value");
> +
> +       if (enc =3D=3D 0x03) {
> +               bad_code =3D l2cap_frame_pull((void *)frame, frame, 16);
> +               if (!bad_code) {
> +                       print_text(COLOR_ERROR, "Bad_Code: invalid size")=
;
> +                       goto done;
> +               }
> +
> +               print_hex_field("  Bad_Code", bad_code, 16);
> +       }
> +
> +       if (!l2cap_frame_get_u8((void *)frame, &num_subgroups)) {
> +               print_text(COLOR_ERROR, "Num_Subgroups: invalid size");
> +               goto done;
> +       }
> +
> +       print_field("  Num_Subgroups: %u", num_subgroups);
> +
> +       for (i =3D 0; i < num_subgroups; i++) {
> +               print_field("  Subgroup #%u:", i);
> +
> +               if (!l2cap_frame_get_le32((void *)frame, &bis_sync_state)=
) {
> +                       print_text(COLOR_ERROR, "BIS_Sync State: invalid =
size");
> +                       goto done;
> +               }
> +
> +               print_field("    BIS_Sync State: 0x%8.8x", bis_sync_state=
);
> +
> +               if (!print_subgroup_metadata("    Metadata", frame))
> +                       goto done;
> +       }
> +
> +done:
> +       if (frame->size)
> +               print_hex_field("  Data", frame->data, frame->size);
> +}
> +
> +static void bcast_recv_state_read(const struct l2cap_frame *frame)
> +{
> +       print_bcast_recv_state(frame);
> +}
> +
> +static void bcast_recv_state_notify(const struct l2cap_frame *frame)
> +{
> +       print_bcast_recv_state(frame);
> +}
> +
> +#define BCAST_AUDIO_SCAN_CP_CMD(_op, _desc, _func) \
> +[_op] =3D { \
> +       .desc =3D _desc, \
> +       .func =3D _func, \
> +}
> +
> +static void bcast_audio_scan_cp_add_src_cmd(const struct l2cap_frame *fr=
ame)
> +{
> +       uint8_t i;
> +       uint8_t addr_type;
> +       uint8_t *addr;
> +       uint8_t sid;
> +       uint32_t bid;
> +       uint8_t pa_sync_state;
> +       uint16_t pa_interval;
> +       uint8_t num_subgroups =3D 0;
> +       uint32_t bis_sync_state;
> +
> +       if (!l2cap_frame_get_u8((void *)frame, &addr_type)) {
> +               print_text(COLOR_ERROR, "Source_Address_Type: invalid siz=
e");
> +               return;
> +       }
> +
> +       print_field("    Source_Address_Type: %u", addr_type);
> +
> +       addr =3D l2cap_frame_pull((void *)frame, frame, sizeof(bdaddr_t))=
;
> +       if (!addr) {
> +               print_text(COLOR_ERROR, "Source_Address: invalid size");
> +               return;
> +       }
> +
> +       print_field("    Source_Address: %2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2=
.2X",
> +                                       addr[5], addr[4],
> +                                       addr[3], addr[2],
> +                                       addr[1], addr[0]);
> +
> +       if (!l2cap_frame_get_u8((void *)frame, &sid)) {
> +               print_text(COLOR_ERROR, "Source_Adv_SID: invalid size");
> +               return;
> +       }
> +
> +       print_field("    Source_Adv_SID: %u", sid);
> +
> +       if (!l2cap_frame_get_le24((void *)frame, &bid)) {
> +               print_text(COLOR_ERROR, "Broadcast_ID: invalid size");
> +               return;
> +       }
> +
> +       print_field("    Broadcast_ID: 0x%06x", bid);
> +
> +       if (!l2cap_frame_get_u8((void *)frame, &pa_sync_state)) {
> +               print_text(COLOR_ERROR, "PA_Sync_State: invalid size");
> +               return;
> +       }
> +
> +       for (i =3D 0; i < ARRAY_SIZE(cp_pa_sync_state_decoders); i++) {
> +               const struct cp_pa_sync_state_decoder *decoder;
> +
> +               decoder =3D &cp_pa_sync_state_decoders[i];
> +
> +               if (decoder->code =3D=3D pa_sync_state) {
> +                       print_field("    PA_Sync_State: %s", decoder->val=
ue);
> +                       break;
> +               }
> +       }
> +
> +       if (i =3D=3D ARRAY_SIZE(cp_pa_sync_state_decoders))
> +               print_field("    PA_Sync_State: %s", "Invalid value");
> +
> +       if (!l2cap_frame_get_le16((void *)frame, &pa_interval)) {
> +               print_text(COLOR_ERROR, "PA_Interval: invalid size");
> +               return;
> +       }
> +
> +       print_field("    PA_Interval: 0x%04x", pa_interval);
> +
> +       if (!l2cap_frame_get_u8((void *)frame, &num_subgroups)) {
> +               print_text(COLOR_ERROR, "Num_Subgroups: invalid size");
> +               return;
> +       }
> +
> +       print_field("    Num_Subgroups: %u", num_subgroups);
> +
> +       for (i =3D 0; i < num_subgroups; i++) {
> +               print_field("    Subgroup #%u:", i);
> +
> +               if (!l2cap_frame_get_le32((void *)frame, &bis_sync_state)=
) {
> +                       print_text(COLOR_ERROR, "BIS_Sync State: invalid =
size");
> +                       return;
> +               }
> +
> +               print_field("      BIS_Sync State: 0x%8.8x", bis_sync_sta=
te);
> +
> +               if (!print_subgroup_metadata("      Metadata", frame))
> +                       return;
> +       }
> +}
> +
> +static void bcast_audio_scan_cp_mod_src_cmd(const struct l2cap_frame *fr=
ame)
> +{
> +       uint8_t i;
> +       uint8_t id;
> +       uint8_t pa_sync_state;
> +       uint16_t pa_interval;
> +       uint8_t num_subgroups =3D 0;
> +       uint32_t bis_sync_state;
> +
> +       if (!l2cap_frame_get_u8((void *)frame, &id)) {
> +               print_text(COLOR_ERROR, "Source_ID: invalid size");
> +               return;
> +       }
> +
> +       print_field("    Source_ID: %u", id);
> +
> +       if (!l2cap_frame_get_u8((void *)frame, &pa_sync_state)) {
> +               print_text(COLOR_ERROR, "PA_Sync_State: invalid size");
> +               return;
> +       }
> +
> +       for (i =3D 0; i < ARRAY_SIZE(cp_pa_sync_state_decoders); i++) {
> +               const struct cp_pa_sync_state_decoder *decoder;
> +
> +               decoder =3D &cp_pa_sync_state_decoders[i];
> +
> +               if (decoder->code =3D=3D pa_sync_state) {
> +                       print_field("    PA_Sync_State: %s", decoder->val=
ue);
> +                       break;
> +               }
> +       }
> +
> +       if (i =3D=3D ARRAY_SIZE(cp_pa_sync_state_decoders))
> +               print_field("    PA_Sync_State: %s", "Invalid value");
> +
> +       if (!l2cap_frame_get_le16((void *)frame, &pa_interval)) {
> +               print_text(COLOR_ERROR, "PA_Interval: invalid size");
> +               return;
> +       }
> +
> +       print_field("    PA_Interval: 0x%04x", pa_interval);
> +
> +       if (!l2cap_frame_get_u8((void *)frame, &num_subgroups)) {
> +               print_text(COLOR_ERROR, "Num_Subgroups: invalid size");
> +               return;
> +       }
> +
> +       print_field("    Num_Subgroups: %u", num_subgroups);
> +
> +       for (i =3D 0; i < num_subgroups; i++) {
> +               print_field("    Subgroup #%u:", i);
> +
> +               if (!l2cap_frame_get_le32((void *)frame, &bis_sync_state)=
) {
> +                       print_text(COLOR_ERROR, "BIS_Sync State: invalid =
size");
> +                       return;
> +               }
> +
> +               print_field("      BIS_Sync State: 0x%8.8x", bis_sync_sta=
te);
> +
> +               if (!print_subgroup_metadata("      Metadata", frame))
> +                       return;
> +       }
> +}
> +
> +static void bcast_audio_scan_cp_set_bcode_cmd(const struct l2cap_frame *=
frame)
> +{
> +       uint8_t id;
> +       uint8_t *bcast_code;
> +
> +       if (!l2cap_frame_get_u8((void *)frame, &id)) {
> +               print_text(COLOR_ERROR, "Source_ID: invalid size");
> +               return;
> +       }
> +
> +       print_field("    Source_ID: %u", id);
> +
> +       bcast_code =3D l2cap_frame_pull((void *)frame, frame, 16);
> +       if (!bcast_code) {
> +               print_text(COLOR_ERROR, "Broadcast_Code: invalid size");
> +               return;
> +       }
> +
> +       print_hex_field("    Broadcast_Code", bcast_code, 16);
> +
> +}
> +
> +static void bcast_audio_scan_cp_remove_src_cmd(const struct l2cap_frame =
*frame)
> +{
> +       uint8_t id;
> +
> +       if (!l2cap_frame_get_u8((void *)frame, &id)) {
> +               print_text(COLOR_ERROR, "Source_ID: invalid size");
> +               return;
> +       }
> +
> +       print_field("    Source_ID: %u", id);
> +}
> +
> +struct bcast_audio_scan_cp_cmd {
> +       const char *desc;
> +       void (*func)(const struct l2cap_frame *frame);
> +} bcast_audio_scan_cp_cmd_table[] =3D {
> +       /* Opcode =3D 0x00 (Remote Scan Stopped) */
> +       BCAST_AUDIO_SCAN_CP_CMD(0x00, "Remote Scan Stopped", NULL),
> +       /* Opcode =3D 0x01 (Remote Scan Started) */
> +       BCAST_AUDIO_SCAN_CP_CMD(0x01, "Remote Scan Started", NULL),
> +       /* Opcode =3D 0x02 (Add Source) */
> +       BCAST_AUDIO_SCAN_CP_CMD(0x02, "Add Source",
> +                                       bcast_audio_scan_cp_add_src_cmd),
> +       /* Opcode =3D 0x03 (Modify Source) */
> +       BCAST_AUDIO_SCAN_CP_CMD(0x03, "Modify Source",
> +                                       bcast_audio_scan_cp_mod_src_cmd),
> +       /* Opcode =3D 0x04 (Set Broadcast_Code) */
> +       BCAST_AUDIO_SCAN_CP_CMD(0x04, "Set Broadcast_Code",
> +                                       bcast_audio_scan_cp_set_bcode_cmd=
),
> +       /* Opcode =3D 0x05 (Remove Source) */
> +       BCAST_AUDIO_SCAN_CP_CMD(0x05, "Remove Source",
> +                                       bcast_audio_scan_cp_remove_src_cm=
d),
> +};
> +
> +static struct bcast_audio_scan_cp_cmd *bcast_audio_scan_cp_get_cmd(uint8=
_t op)
> +{
> +       if (op > ARRAY_SIZE(bcast_audio_scan_cp_cmd_table))
> +               return NULL;
> +
> +       return &bcast_audio_scan_cp_cmd_table[op];
> +}
> +
> +static void print_bcast_audio_scan_cp_cmd(const struct l2cap_frame *fram=
e)
> +{
> +       uint8_t op;
> +       struct bcast_audio_scan_cp_cmd *cmd;
> +
> +       if (!l2cap_frame_get_u8((void *)frame, &op)) {
> +               print_text(COLOR_ERROR, "Opcode: invalid size");
> +               goto done;
> +       }
> +
> +       cmd =3D bcast_audio_scan_cp_get_cmd(op);
> +       if (!cmd) {
> +               print_field("    Opcode: Reserved (0x%2.2x)", op);
> +               goto done;
> +       }
> +
> +       print_field("    Opcode: %s (0x%2.2x)", cmd->desc, op);
> +       if (cmd->func)
> +               cmd->func(frame);
> +
> +done:
> +       if (frame->size)
> +               print_hex_field("  Data", frame->data, frame->size);
> +}
> +
> +static void bcast_audio_scan_cp_write(const struct l2cap_frame *frame)
> +{
> +       print_bcast_audio_scan_cp_cmd(frame);
> +}
> +
>  #define GATT_HANDLER(_uuid, _read, _write, _notify) \
>  { \
>         .uuid =3D { \
> @@ -2568,6 +3025,10 @@ struct gatt_handler {
>         GATT_HANDLER(0x2ba5, media_cp_op_supported_read, NULL,
>                                         media_cp_op_supported_notify),
>         GATT_HANDLER(0x2bba, content_control_id_read, NULL, NULL),
> +
> +       GATT_HANDLER(0x2bc7, NULL, bcast_audio_scan_cp_write, NULL),
> +       GATT_HANDLER(0x2bc8, bcast_recv_state_read, NULL,
> +                                       bcast_recv_state_notify),
>  };
>
>  static struct gatt_handler *get_handler_uuid(const bt_uuid_t *uuid)
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
