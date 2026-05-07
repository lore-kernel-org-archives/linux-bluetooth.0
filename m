Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A144035B633
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2026 18:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778177866; cv=pass; b=dBbLxFFtT/i6jF1Z7A0gCbSaWeQjpFgt5t0UaZfJsy5zkqusvSZqOZGC/LMUVD147z4Fxgu9y2MvlQvpBRbRUBawIHM9Yz/SEvNYcr4JfCYldWPLoOMUTAUoWG3ztDPnVZxrMhZV44Tx6u/BU6WkCRSOUV5oioh/hhS50v97WSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778177866; c=relaxed/simple;
	bh=smUrRDbKTbJi/+r1ogmD3+vhFzUfLThS9Zk+VL8d2h8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k330f8/aP+gDUDOGwxQnx8bsPjXbg4U3AZulI6yXD7QFjc2cs/M+Jytah7EeWcb+782RaUEk2XRN8lUBUh3XKVe+FC17ffLSHLmsEihAszOhiE13i+zNfHXxzx9jvgrINEP8JuBzA085xAFpRsJkotVyX10IDZWC0qQQgye877I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxAu3/Nb; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxAu3/Nb"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-65c21049dafso1254254d50.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 May 2026 11:17:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778177864; cv=none;
        d=google.com; s=arc-20240605;
        b=cUZBKKSk6mSxKmuPPcvehNLdPm2gATpQJojaulexvID+f4hNrxlctM3gZx1pt5A5JF
         fpHUiCKtlxhF5jaNpNCuOFBbsc6RD/YhovjmEy0VP1D+MNxaVkeuZiikdHgi8wamYUuJ
         v8i07CkkL9fFqbQbUgLSnS5voUqtc/ssw7YPFrLcg1cNtjuIfpV2DvSx7gE+L/rnL27Z
         5CnQl9F0HANcR8lZiWXBu4+HDN/RO5+yJs+MT9v1pgq9e1PlJkrhbMvjfLDIh8mWhIlC
         CnVyK0tkqdr9yFVB+3YXuHX5dzdxWs4nFvfDX4CPub3YZVaiG8nYLlagTLTSNiAgDxQM
         bE7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YdMK/OXvukduecv+EqTFmEW0Bnt5ZckHbecW6Q4EHSs=;
        fh=jBLUrRQ7ZsNUcAcd5QG5N83k8jhBNkoqDFBeOlOjxqk=;
        b=fVEDI7qzGugNIOhiRybRUsXpUkqpwHpMnWp+GYfA6dCGWg5DWmoXKb7NB9lIpK4y1I
         P7ozdhhSWOeYqPUJ6j2BYy1Qc+io64JWrsmqHU/0C5mBhhh8Tw2apbAMprRIa82I4awc
         cOZEAV5D4ZQ74p7ix91EDNyGv2TYa9sCHSJPR4jKXJ/rsR4anwFYSUXg1rXgmWbnxESq
         cx3A6Xe5WJQ0mgGb4X2fZDicq9ML33gpl/hHUc4g9P6a1/eug0cDPLFEZZB3VgZ5r2BO
         oHH/XNq4PA3VU4s/1a+V+L2TgETQjqtW8/kDLbEbX9ojzv36LakR7iJzFOF4twWUAdua
         /0Xw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778177864; x=1778782664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YdMK/OXvukduecv+EqTFmEW0Bnt5ZckHbecW6Q4EHSs=;
        b=JxAu3/Nb/MAW4TUq85hj46E74aNbrD2S4jLQBBxQelT1hc1fLHj6+5TQ6KyXgC0YmV
         dDywNws2gcXCP5uUpJh9DA9yd+pakGEk1sZSfzgLsAvsGw+kLr2Py0aqSxyaq6YXbKmf
         rJJJ5e0mC4DuIkyLs0T3QpOcGeJOjCR7SFVyd6Rd9JExAenHb7JL1CT92Obbk4vwsigv
         LFA2zlS8KljJLENXMnak10f9YahC1J23aLAPy4YMlFFbBSC9TCMqFcex/vXllk36Cu6p
         ZG89xS1EXVR/IZ+wGfUqHydSvkfmUdfT9m+msGEjGTCZ4YyrjtyS8ceDiexSUtK1mloG
         9iXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778177864; x=1778782664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YdMK/OXvukduecv+EqTFmEW0Bnt5ZckHbecW6Q4EHSs=;
        b=ZdocpThitWPrERFjLYrgDnBi0pf/aJgeTa97R/ynuQ0BOsDlkG8mAfG0J7YYSgCsp8
         L7RUVcwOSaACmzKWz1FHTlV7IIQQfnNnuJeIrzBp9KVBsTmWIVIblJLz4SUvFdDlVxBt
         5nqEXoYDNbs4gRwZFsYYuqi10EEar9yEDqdcI8cjcUZH13Yii6UoKyGVIPlrbL0kcRim
         n4HBILckU7rAtG9RgT8BSYzy0xrUEmk9O2A1p6uKhHAv2unBTLu9MxeQYhQsWsgwsPFD
         OjPMCaNGmut/wScICHXCgOhvIgDw48SBsJBofMWeh8xkQacTPzA5ItFsHW5BcJT2mx6/
         KbOw==
X-Gm-Message-State: AOJu0YzOx69AjK3xfPw/GRKzCCxzNSykXmzlSDGuG0QQL1Ly5krlFJAG
	VNngl3qEhKArJWPqnP/MQq2Xmu2Ir9eOFqxjgGXC/W4tPM764EEteyZh3QrwwI+7rk4L5JhJx1x
	+KHU7dqx0oZ+huO+B1YjrRkr8aIui73IpbDztM70=
X-Gm-Gg: Acq92OH9UKd57axdvZ14HLXGQ1usuTsKGasXmmmbz91EBzlShqjyq9DAcagZYiYhHv7
	nfDq8ZaJgVdLLCFhaPZBE7tuFZ8HZNfhqZZCnOPHfW7WGllQcRS2Q6D4prjb8LQIpTxOlCR6ZpK
	hyIVifWKt5Y5+p3G1TJacy+rTml/9oNJ/Djdq8hpjp4CHzeNmySmgn5UbaGBlt1w8yJUJEQFfHP
	0Pbk2wrRgJMSiZkNlvCBw/b3jNIFyxs7AuTlf8ux9JA4sNP6O96Cb2Oh3jx9fgIYYLVQt5WaX59
	TN1vc3GAQdKrThw9Soyzj6WbgvGa+cBBTk3C40LRwFi23VIRETjM6TO9bVvVd5L94B5ljQ==
X-Received: by 2002:a05:690e:1914:b0:650:4aec:29fa with SMTP id
 956f58d0204a3-65c799b239emr9826200d50.38.1778177863500; Thu, 07 May 2026
 11:17:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507180736.2990540-1-prathm@qti.qualcomm.com>
In-Reply-To: <20260507180736.2990540-1-prathm@qti.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 7 May 2026 14:17:30 -0400
X-Gm-Features: AVHnY4JhB6vmQiBx5h5ZTwhSygP25m3WtKwWEvNkQOezTNzdemqqmJ-Xn6iSKwQ
Message-ID: <CABBYNZLOGGLVB9WaKfOH0+qz6Q6pqDbn0M8RhqRxq28QvCZm_g@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] monitor: Add parsing of CS step mode data in RAS
 Notifications Subevent #0: Start ACL Connection Event: 406 Frequency
 Compensation: -16384 (0.01 ppm) Ranging Done Status: Partial results, more to
 follow (0x1) Subevent Done Status: All results complete (0x0) Ranging Abort
 Reason: No abort (0x0) Subevent Abort Reason: No abort (0x0) Reference Power
 Level: -14 dBm Number of Steps Reported: 58 Step 0 Mode Type: 0 Aborted: No
 Packet Quality: 0x00 CS Access Address check is successful, and all bits
 match the expected sequence Bit errors: 0 Packet RSSI: -52 Packet Antenna: 1
 Step 1 Mode Type: 0 Aborted: No Packet Quality: 0x00 CS Access Address check i...
To: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prathibha,

On Thu, May 7, 2026 at 2:07=E2=80=AFPM Prathibha Madugonde
<prathibha.madugonde@oss.qualcomm.com> wrote:

Not sure what went wrong, but the commit subject is way too big. If
you are trying to add an example of decoded trace produced by these
changes add it in the commit description _after_ the first/subject
line e.g.:

monitor: Add decoding of CS step mode data

<example>

> From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
>
> ---
>  monitor/att.c | 521 ++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 500 insertions(+), 21 deletions(-)
>
> diff --git a/monitor/att.c b/monitor/att.c
> index 03d46634f..c8915ab04 100644
> --- a/monitor/att.c
> +++ b/monitor/att.c
> @@ -4120,16 +4120,18 @@ static void print_ras_segmentation_header(uint8_t=
 header)
>         print_field("    Segment Index: %u", segment_index);
>  }
>
> -static void print_ras_ranging_header(const struct l2cap_frame *frame)
> +static uint8_t print_ras_ranging_header(const struct l2cap_frame *frame)
>  {
>         uint16_t ranging_counter_config;
>         uint8_t selected_tx_power;
>         uint8_t antenna_paths_mask;
>         uint8_t mask;
> +       uint8_t num_antenna_paths =3D 0;
> +       uint8_t i;
>
>         if (!l2cap_frame_get_le16((void *)frame, &ranging_counter_config)=
) {
>                 print_text(COLOR_ERROR, "    Ranging Header: invalid size=
");
> -               return;
> +               return 0;
>         }
>
>         /* Lower 12 bits: Ranging Counter, Upper 4 bits: Configuration ID=
 */
> @@ -4140,14 +4142,14 @@ static void print_ras_ranging_header(const struct=
 l2cap_frame *frame)
>
>         if (!l2cap_frame_get_u8((void *)frame, &selected_tx_power)) {
>                 print_text(COLOR_ERROR, "    Selected TX Power: invalid s=
ize");
> -               return;
> +               return 0;
>         }
>
>         print_field("    Selected TX Power: %d dBm", (int8_t)selected_tx_=
power);
>
>         if (!l2cap_frame_get_u8((void *)frame, &antenna_paths_mask)) {
>                 print_text(COLOR_ERROR, "    Antenna Paths Mask: invalid =
size");
> -               return;
> +               return 0;
>         }
>
>         print_field("    Antenna Paths Mask: 0x%2.2x", antenna_paths_mask=
);
> @@ -4157,6 +4159,14 @@ static void print_ras_ranging_header(const struct =
l2cap_frame *frame)
>
>         if (mask)
>                 print_text(COLOR_WHITE_BG, "      RFU (0x%2.2x)", mask);
> +
> +       /* Count the number of set bits in antenna_paths_mask */
> +       for (i =3D 0; i < 4; i++) {
> +               if (antenna_paths_mask & (1 << i))
> +                       num_antenna_paths++;
> +       }
> +
> +       return num_antenna_paths;
>  }
>
>  static const char *ras_ranging_done_status_str(uint8_t status)
> @@ -4203,7 +4213,7 @@ static const char *ras_abort_reason_str(uint8_t rea=
son)
>         }
>  }
>
> -static void print_ras_subevent_header(const struct l2cap_frame *frame)
> +static uint8_t print_ras_subevent_header(const struct l2cap_frame *frame=
)
>  {
>         uint16_t start_acl_conn_event;
>         uint16_t freq_compensation;
> @@ -4216,7 +4226,7 @@ static void print_ras_subevent_header(const struct =
l2cap_frame *frame)
>         if (!l2cap_frame_get_le16((void *)frame, &start_acl_conn_event)) =
{
>                 print_text(COLOR_ERROR,
>                         "      Start ACL Connection Event: invalid size")=
;
> -               return;
> +               return 0;
>         }
>
>         print_field("      Start ACL Connection Event: %u",
> @@ -4225,7 +4235,7 @@ static void print_ras_subevent_header(const struct =
l2cap_frame *frame)
>         if (!l2cap_frame_get_le16((void *)frame, &freq_compensation)) {
>                 print_text(COLOR_ERROR,
>                         "      Frequency Compensation: invalid size");
> -               return;
> +               return 0;
>         }
>
>         print_field("      Frequency Compensation: %d (0.01 ppm)",
> @@ -4233,7 +4243,7 @@ static void print_ras_subevent_header(const struct =
l2cap_frame *frame)
>
>         if (!l2cap_frame_get_u8((void *)frame, &status_byte1)) {
>                 print_text(COLOR_ERROR, "      Status: invalid size");
> -               return;
> +               return 0;
>         }
>
>         ranging_done_status =3D status_byte1 & 0x0F;
> @@ -4248,7 +4258,7 @@ static void print_ras_subevent_header(const struct =
l2cap_frame *frame)
>
>         if (!l2cap_frame_get_u8((void *)frame, &status_byte2)) {
>                 print_text(COLOR_ERROR, "      Abort Reasons: invalid siz=
e");
> -               return;
> +               return 0;
>         }
>
>         ranging_abort_reason =3D status_byte2 & 0x0F;
> @@ -4264,7 +4274,7 @@ static void print_ras_subevent_header(const struct =
l2cap_frame *frame)
>         if (!l2cap_frame_get_u8((void *)frame, &ref_power_level)) {
>                 print_text(COLOR_ERROR,
>                         "      Reference Power Level: invalid size");
> -               return;
> +               return 0;
>         }
>
>         print_field("      Reference Power Level: %d dBm",
> @@ -4273,10 +4283,460 @@ static void print_ras_subevent_header(const stru=
ct l2cap_frame *frame)
>         if (!l2cap_frame_get_u8((void *)frame, &num_steps_reported)) {
>                 print_text(COLOR_ERROR,
>                         "      Number of Steps Reported: invalid size");
> -               return;
> +               return 0;
>         }
>
>         print_field("      Number of Steps Reported: %u", num_steps_repor=
ted);
> +
> +       return num_steps_reported;
> +}
> +
> +static const char *packet_quality_str(uint8_t quality)
> +{
> +       switch (quality & 0x03) {
> +       case 0x00:
> +               return "CS Access Address check is successful, and all bi=
ts "
> +                       "match the expected sequence";
> +       case 0x01:
> +               return "CS Access Address check is successful, but some b=
its "
> +                       "do not match the expected sequence";
> +       case 0x02:
> +               return "CS Access Address check failed";
> +       default:
> +               return "Reserved";
> +       }
> +}
> +
> +static const char *tone_quality_str(uint8_t quality)
> +{
> +       switch (quality & 0x03) {
> +       case 0x00:
> +               return "Tone quality is high";
> +       case 0x01:
> +               return "Tone quality is medium";
> +       case 0x02:
> +               return "Tone quality is low";
> +       case 0x03:
> +               return "Tone quality indication is not available";
> +       default:
> +               return "Reserved";
> +       }
> +}
> +
> +static const char *tone_extension_str(uint8_t quality)
> +{
> +       switch ((quality >> 4) & 0x03) {
> +       case 0x00:
> +               return "Not tone extension slot";
> +       case 0x01:
> +               return "Tone extension slot; tone not expected to be pres=
ent";
> +       case 0x02:
> +               return "Tone extension slot; tone expected to be present"=
;
> +       default:
> +               return "Reserved";
> +       }
> +}
> +
> +static void print_step_mode_0(const struct l2cap_frame *frame, uint8_t l=
en)
> +{
> +       uint8_t quality, rssi, antenna;
> +       uint16_t freq_offset;
> +
> +       if (len < 3) {
> +               print_hex_field("          Raw step data", frame->data, l=
en);
> +               return;
> +       }
> +
> +       if (!l2cap_frame_get_u8((void *)frame, &quality)) {
> +               print_text(COLOR_ERROR,
> +                       "          Packet Quality: invalid");
> +               return;
> +       }
> +
> +       print_field("          Packet Quality: 0x%02x", quality);
> +       print_field("            %s", packet_quality_str(quality));
> +       print_field("            Bit errors: %u", (quality >> 2) & 0x3F);
> +
> +       if (!l2cap_frame_get_u8((void *)frame, &rssi)) {
> +               print_text(COLOR_ERROR, "          Packet RSSI: invalid")=
;
> +               return;
> +       }
> +
> +       print_field("          Packet RSSI: %d", (int8_t)rssi);
> +
> +       if (!l2cap_frame_get_u8((void *)frame, &antenna)) {
> +               print_text(COLOR_ERROR,
> +                       "          Packet Antenna: invalid");
> +               return;
> +       }
> +
> +       print_field("          Packet Antenna: %u", antenna);
> +
> +       if (len =3D=3D 5) {
> +               if (!l2cap_frame_get_le16((void *)frame, &freq_offset)) {
> +                       print_text(COLOR_ERROR,
> +                               "          Measured Freq Offset: invalid =
size");
> +                       return;
> +               }
> +
> +               print_field("          Measured Freq Offset: %d (0.01 ppm=
)",
> +                                               (int16_t)freq_offset);
> +       }
> +}
> +
> +static void print_step_mode_1(const struct l2cap_frame *frame, uint8_t l=
en)
> +{
> +       uint8_t quality, nadm, rssi, antenna;
> +       uint16_t toa_tod;
> +
> +       if (len < 6) {
> +               print_hex_field("          Raw step data", frame->data, l=
en);
> +               return;
> +       }
> +
> +       if (!l2cap_frame_get_u8((void *)frame, &quality)) {
> +               print_text(COLOR_ERROR, "          Packet Quality: invali=
d");
> +               return;
> +       }
> +
> +       print_field("          Packet Quality: 0x%02x", quality);
> +       print_field("            %s", packet_quality_str(quality));
> +       print_field("            Bit errors: %u", (quality >> 2) & 0x3F);
> +
> +       if (!l2cap_frame_get_u8((void *)frame, &nadm)) {
> +               print_text(COLOR_ERROR, "          Packet NADM: invalid")=
;
> +               return;
> +       }
> +
> +       if (nadm =3D=3D 0xFF)
> +               print_field("          Packet NADM: Unknown NADM (0xff)")=
;
> +       else
> +               print_field("          Packet NADM: %u", nadm);
> +
> +       if (!l2cap_frame_get_u8((void *)frame, &rssi)) {
> +               print_text(COLOR_ERROR, "          Packet RSSI: invalid")=
;
> +               return;
> +       }
> +
> +       print_field("          Packet RSSI: %d", (int8_t)rssi);
> +
> +       if (!l2cap_frame_get_le16((void *)frame, &toa_tod)) {
> +               print_text(COLOR_ERROR, "          ToA_ToD: invalid");
> +               return;
> +       }
> +
> +       print_field("          ToA_ToD: 0x%08x", toa_tod | 0xFFFF0000);
> +
> +       if (!l2cap_frame_get_u8((void *)frame, &antenna)) {
> +               print_text(COLOR_ERROR, "          Packet Antenna: invali=
d");
> +               return;
> +       }
> +
> +       print_field("          Packet Antenna: %u", antenna);
> +}
> +
> +static void print_step_mode_2(const struct l2cap_frame *frame, uint8_t l=
en,
> +                               uint8_t num_antenna_paths)
> +{
> +       uint8_t ant_perm_idx;
> +       uint8_t i;
> +       uint32_t pct;
> +       uint16_t i_sample, q_sample;
> +       uint8_t quality;
> +
> +       if (len < 1) {
> +               print_hex_field("          Raw step data", frame->data, l=
en);
> +               return;
> +       }
> +
> +       if (!l2cap_frame_get_u8((void *)frame, &ant_perm_idx)) {
> +               print_text(COLOR_ERROR, "          Antenna Permutation In=
dex: "
> +                                                       "invalid size");
> +               return;
> +       }
> +
> +       print_field("          Antenna Permutation Index: %u", ant_perm_i=
dx);
> +
> +       /* Use the antenna paths count from ranging header */
> +       for (i =3D 0; i < (num_antenna_paths + 1); i++) {
> +               if (frame->size < 4) {
> +                       print_text(COLOR_ERROR,
> +                               "            Insufficient data for path %=
u",
> +                               i);
> +                       return;
> +               }
> +
> +               if (!l2cap_frame_get_le24((void *)frame, &pct)) {
> +                       print_text(COLOR_ERROR, "            PCT: invalid=
");
> +                       return;
> +               }
> +
> +               /* Extract 12-bit I and Q samples from 24-bit PCT */
> +               i_sample =3D pct & 0x0FFF;
> +               q_sample =3D (pct >> 12) & 0x0FFF;
> +
> +               print_field("          Path %u", i);
> +               print_field("            PCT: 0x%06x", pct);
> +               print_field("              I: 0x%03x", i_sample);
> +               print_field("              Q: 0x%03x", q_sample);
> +
> +               if (!l2cap_frame_get_u8((void *)frame, &quality)) {
> +                       print_text(COLOR_ERROR,
> +                               "            Tone quality indicator: "
> +                               "invalid size");
> +                       return;
> +               }
> +
> +               print_field("            Tone quality indicator: 0x%02x",
> +                               quality);
> +               print_field("              %s (0x%02x)",
> +                               tone_quality_str(quality),
> +                               quality & 0x03);
> +               print_field("              %s (0x%02x)",
> +                               tone_extension_str(quality),
> +                               (quality >> 4) & 0x03);
> +       }
> +}
> +
> +static void print_step_mode_3(const struct l2cap_frame *frame, uint8_t l=
en,
> +                               uint8_t num_antenna_paths)
> +{
> +       uint8_t quality, nadm, rssi, antenna;
> +       uint16_t toa_tod;
> +       uint8_t ant_perm_idx;
> +       uint8_t i;
> +       uint32_t pct;
> +       uint16_t i_sample, q_sample;
> +       uint8_t tone_quality;
> +
> +       /* Mode 3 =3D Mode 1 (6 bytes) + Mode 2 (variable) */
> +       if (len < 6) {
> +               print_hex_field("          Raw step data", frame->data, l=
en);
> +               return;
> +       }
> +
> +       /* Parse Mode 1 data first */
> +       if (!l2cap_frame_get_u8((void *)frame, &quality)) {
> +               print_text(COLOR_ERROR, "          Packet Quality: invali=
d");
> +               return;
> +       }
> +
> +       print_field("          Packet Quality: 0x%02x", quality);
> +       print_field("            %s", packet_quality_str(quality));
> +       print_field("            Bit errors: %u", (quality >> 2) & 0x3F);
> +
> +       if (!l2cap_frame_get_u8((void *)frame, &nadm)) {
> +               print_text(COLOR_ERROR, "          Packet NADM: invalid s=
ize");
> +               return;
> +       }
> +
> +       if (nadm =3D=3D 0xFF)
> +               print_field("          Packet NADM: Unknown NADM (0xff)")=
;
> +       else
> +               print_field("          Packet NADM: %u", nadm);
> +
> +       if (!l2cap_frame_get_u8((void *)frame, &rssi)) {
> +               print_text(COLOR_ERROR, "          Packet RSSI: invalid s=
ize");
> +               return;
> +       }
> +
> +       print_field("          Packet RSSI: %d", (int8_t)rssi);
> +
> +       if (!l2cap_frame_get_le16((void *)frame, &toa_tod)) {
> +               print_text(COLOR_ERROR, "          ToA_ToD: invalid size"=
);
> +               return;
> +       }
> +
> +       print_field("          ToA_ToD: 0x%08x", toa_tod | 0xFFFF0000);
> +
> +       if (!l2cap_frame_get_u8((void *)frame, &antenna)) {
> +               print_text(COLOR_ERROR, "          Packet Antenna: invali=
d");
> +               return;
> +       }
> +
> +       print_field("          Packet Antenna: %u", antenna);
> +
> +       /* Now parse Mode 2 data */
> +       if (frame->size < 1)
> +               return;
> +
> +       if (!l2cap_frame_get_u8((void *)frame, &ant_perm_idx)) {
> +               print_text(COLOR_ERROR, "          Antenna Permutation In=
dex: "
> +                                                       "invalid size");
> +               return;
> +       }
> +
> +       print_field("          Antenna Permutation Index: %u", ant_perm_i=
dx);
> +
> +       /* Use the antenna paths count from ranging header */
> +       for (i =3D 0; i < (num_antenna_paths + 1); i++) {
> +               if (frame->size < 4) {
> +                       print_text(COLOR_ERROR,
> +                               "            Insufficient data for path %=
u",
> +                               i);
> +                       return;
> +               }
> +
> +               if (!l2cap_frame_get_le24((void *)frame, &pct)) {
> +                       print_text(COLOR_ERROR, "            PCT: invalid=
");
> +                       return;
> +               }
> +
> +               /* Extract 12-bit I and Q samples from 24-bit PCT */
> +               i_sample =3D pct & 0x0FFF;
> +               q_sample =3D (pct >> 12) & 0x0FFF;
> +
> +               print_field("          Path %u", i);
> +               print_field("            PCT: 0x%06x", pct);
> +               print_field("              I: 0x%03x", i_sample);
> +               print_field("              Q: 0x%03x", q_sample);
> +
> +               if (!l2cap_frame_get_u8((void *)frame, &tone_quality)) {
> +                       print_text(COLOR_ERROR,
> +                               "            Tone quality indicator: "
> +                               "invalid size");
> +                       return;
> +               }
> +
> +               print_field("            Tone quality indicator: 0x%02x",
> +                               tone_quality);
> +               print_field("              %s (0x%02x)",
> +                               tone_quality_str(tone_quality),
> +                               tone_quality & 0x03);
> +               print_field("              %s (0x%02x)",
> +                               tone_extension_str(tone_quality),
> +                               (tone_quality >> 4) & 0x03);
> +       }
> +}
> +
> +static void  print_ranging_steps(const struct l2cap_frame *frame,
> +                               uint8_t num_steps, uint8_t num_antenna_pa=
ths)
> +{
> +       uint8_t step_idx;
> +
> +       for (step_idx =3D 0; step_idx < num_steps && frame->size > 0;
> +                                                               step_idx+=
+) {
> +               uint8_t mode_byte;
> +               uint8_t mode_type;
> +               bool aborted;
> +               uint8_t step_data_len;
> +
> +               if (!l2cap_frame_get_u8((void *)frame, &mode_byte)) {
> +                       print_text(COLOR_ERROR,
> +                               "        Step %u: Mode: invalid size",
> +                               step_idx);
> +                       return;
> +               }
> +
> +               mode_type =3D mode_byte & 0x03;
> +               aborted =3D (mode_byte & 0x80) !=3D 0;
> +
> +               print_field("        Step %u", step_idx);
> +               print_field("          Mode Type: %u", mode_type);
> +               print_field("          Aborted: %s", aborted ? "Yes" : "N=
o");
> +
> +               /* If aborted, step data length is 0 */
> +               if (aborted)
> +                       continue;
> +
> +               /* Determine step data length based on mode type
> +                * Mode 0: Check if we have 5 bytes (initiator) or 3 byte=
s
> +                * (reflector)
> +                * Mode 1: Always 6 bytes
> +                * Mode 2: 1 byte (ant_perm_idx) + num_antenna_paths * 4 =
bytes
> +                * Mode 3: 6 bytes (Mode 1) + 1 byte (ant_perm_idx) +
> +                * num_antenna_paths * 4 bytes
> +                */
> +               switch (mode_type) {
> +               case 0:
> +                       /* Mode 0: Default to 3 bytes (reflector)
> +                        * Only use 5 bytes if we're the last step AND ha=
ve
> +                        * exactly 5 bytes remaining
> +                        */
> +                       if (step_idx =3D=3D num_steps - 1 && frame->size =
=3D=3D 5) {
> +                               /* Initiator - last step with exactly 5 b=
ytes */
> +                               step_data_len =3D 5;
> +                       } else if (frame->size >=3D 3) {
> +                               /* Reflector - default case */
> +                               step_data_len =3D 3;
> +                       } else {
> +                               print_text(COLOR_ERROR,
> +                                       "          Insufficient data for =
Mode 0");
> +                               return;
> +                       }
> +                       break;
> +               case 1:
> +                       /* Mode 1: Always 6 bytes */
> +                       if (frame->size < 6) {
> +                               print_text(COLOR_ERROR,
> +                                       "          Insufficient data for =
Mode 1");
> +                               return;
> +                       }
> +                       step_data_len =3D 6;
> +                       break;
> +               case 2:
> +                       /* Mode 2: 1 byte antenna + num_antenna_paths * 4
> +                        * bytes per path
> +                        */
> +                       step_data_len =3D 1 + ((num_antenna_paths + 1) * =
4);
> +                       if (frame->size < step_data_len) {
> +                               print_text(COLOR_ERROR,
> +                                       "          Insufficient data for =
Mode 2 (need %u)",
> +                                       step_data_len);
> +                               return;
> +                       }
> +                       break;
> +               case 3:
> +                       /* Mode 3: 6 bytes Mode 1 + 1 byte antenna +
> +                        * num_antenna_paths * 4 bytes
> +                        */
> +                       step_data_len =3D 7 + ((num_antenna_paths + 1) * =
4);
> +                       if (frame->size < step_data_len) {
> +                               print_text(COLOR_ERROR,
> +                                       "          Insufficient data for =
Mode 3 (need %u)",
> +                                       step_data_len);
> +                               return;
> +                       }
> +                       break;
> +               default:
> +                       print_text(COLOR_ERROR, "          Unknown mode t=
ype");
> +                       return;
> +               }
> +
> +               if (step_data_len > frame->size) {
> +                       print_text(COLOR_ERROR,
> +                               "          Invalid step data length");
> +                       return;
> +               }
> +
> +               if (step_data_len > 0) {
> +                       struct l2cap_frame step_frame;
> +
> +                       l2cap_frame_clone(&step_frame, frame);
> +                       step_frame.size =3D step_data_len;
> +
> +                       switch (mode_type) {
> +                       case 0:
> +                               print_step_mode_0(&step_frame, step_data_=
len);
> +                               break;
> +                       case 1:
> +                               print_step_mode_1(&step_frame, step_data_=
len);
> +                               break;
> +                       case 2:
> +                               print_step_mode_2(&step_frame, step_data_=
len,
> +                                               num_antenna_paths);
> +                               break;
> +                       case 3:
> +                               print_step_mode_3(&step_frame, step_data_=
len,
> +                                               num_antenna_paths);
> +                               break;
> +                       }
> +
> +                       if (!l2cap_frame_pull((void *)frame, frame,
> +                                                       step_data_len))
> +                               return;
> +               }
> +       }
>  }
>
>  static void ras_ranging_data_read(const struct l2cap_frame *frame)
> @@ -4292,26 +4752,45 @@ static void ras_ranging_data_read(const struct l2=
cap_frame *frame)
>         print_ras_segmentation_header(seg_header);
>
>         first_segment =3D seg_header & 0x01;
> -
>         /* Only try to decode headers if this is the first segment */
> -       if (first_segment && frame->size >=3D 6) {
> +       if (first_segment && frame->size >=3D 4) {
> +               uint8_t num_steps;
> +               uint8_t num_antenna_paths;
> +
>                 print_field("  Ranging Data Body:");
> -               print_ras_ranging_header(frame);
> +               num_antenna_paths =3D print_ras_ranging_header(frame);
>
>                 /* Try to decode subevent header if enough data remains *=
/
> -               if (frame->size >=3D 10) {
> +               if (frame->size >=3D 8) {
>                         print_field("    Subevent #0:");
> -                       print_ras_subevent_header(frame);
> +                       num_steps =3D print_ras_subevent_header(frame);
> +
> +                       /* Parse steps if we have num_steps and
> +                        * num_antenna_paths
> +                        */
> +                       if (num_steps > 0 && num_antenna_paths > 0 &&
> +                                               frame->size > 0) {
> +                               print_ranging_steps((void *)frame, num_st=
eps,
> +                                               num_antenna_paths);
> +                       }
>                 }
> +       } else if (!first_segment && frame->size > 0) {
> +               /* For continuation segments, we cannot reliably decode w=
ithout
> +                * full segment reassembly, as steps may be split across
> +                * segments.
> +                * Just show the raw data.
> +                */
> +               print_field("  Continuation Segment (raw data - requires =
"
> +                               "reassembly for proper decoding):");
> +               print_hex_field("    Segment Data", frame->data, frame->s=
ize);
>         }
>
> -       if (frame->size > 0) {
> -               print_hex_field("  Remaining Ranging Data Segment", frame=
->data,
> -                                                               frame->si=
ze);
> -       }
> +       if (frame->size > 0 && first_segment)
> +               print_hex_field("  Remaining Ranging Data Segment",
> +                                               frame->data, frame->size)=
;
>
>  done:
> -       if (frame->size)
> +       if (frame->size && first_segment)
>                 print_hex_field("  Remaining Data", frame->data, frame->s=
ize);
>  }
>
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
