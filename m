Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB577E9
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Jun 2025 10:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749466085; cv=none; b=Id3Q4VAkpUdajJbPQ2bKvQ5gN3c0PVTgl/naBs+lLQKIiNXrOfCCftvN0HkqcLcbuhKwSpGdC9zotOlk40sVegGLkKP9+kxISBfvljf7zVFLQ/MWa6uphkznmy6+I+g3f5Kd+Tv47UZw8+pPn/JJuGxErkieUxiJeHJs2NnOjKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749466085; c=relaxed/simple;
	bh=L/rCAiUg44bhS7v0BfoEcGSnnuQ9iIu3rVkF73o585M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XlDBjIzARcEhQnc2voDBL3js/udSLFoNkV3u+884p0wjblhTi2Vdyu75zD1ePcD0q3fRxm55NygMT34dxrKJl1tD1TiM2GgaCAPoChSLtFqgg4pplnIUTRyhYqM7gB/FfcupJWnlgzCJpgTXGODWO/nHGjz3Gkjn1Las0T9161A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=codecoup.pl; spf=pass smtp.mailfrom=codecoup.pl; dkim=pass (2048-bit key) header.d=codecoup-pl.20230601.gappssmtp.com header.i=@codecoup-pl.20230601.gappssmtp.com header.b=RZEzxI9q; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=codecoup.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codecoup.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20230601.gappssmtp.com header.i=@codecoup-pl.20230601.gappssmtp.com header.b="RZEzxI9q"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-607873cc6c4so5030189a12.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Jun 2025 03:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20230601.gappssmtp.com; s=20230601; t=1749466080; x=1750070880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abklHvZszotcAvc66swC0yPerHgmHQg63NX9q0h9oBA=;
        b=RZEzxI9q533vsp3UdO25IG2yeMZRK+b1lEoWZLPBpAzCsEdtXSnLoXH12N1ezeY8Xd
         yVrxW0J2krHkJK1AncxJxmuWwioee7YCWv0dpStXFNNHm6tr5GxhZ/Kl2pqW7g6w6v/F
         FjMXWAzHaLmhEx/05lS/xo5h2Xrfp5+jwA78CIzRN29SE/pKsHgv9hkY3lE+qYRqZmhR
         Qz8Dtd9Kf9PoywGs4L19Gw2CXj08yNi8wg9XYVQg1dMs/S+13m1r0ZuafOu8j9vnQ1Ko
         fShRN6QPrqjr3qfDculjTnCgDfdL8JKDJeY933OadCa1oIF3C4L49OTH6M0aRM0wiVxT
         DqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749466080; x=1750070880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=abklHvZszotcAvc66swC0yPerHgmHQg63NX9q0h9oBA=;
        b=FeqEyQCoPeGYVHIMX5yWvwne3Es7KA87RMjEJosl8wAAElh/5WYbfqV33HZnDCB/Hh
         uTlJQMHjzzcWdqMxqe1Zg25+02vLUWNV4dNWanXSb6DZWfcu2bzpTIjpbPNzoZCv6akn
         LsTrSQDA3EOQYDbYEiiHLh9Ky7dDfwcnSdr2I5rhhjgilKD0zwtM4ka/i3XYkEauPGxQ
         vzQcg30Z2dpUojszXQ/Mz7zqlTVilvA2I9IAB0FpB/U0u6LCUZLb9wpGJeso/CO2WyM0
         yXWR3WGAjNi6YfA2HTwtVkx/u3HuV2/khmV3wLLU4JHGNEsk31sm3nNrsMYpURoIwcd3
         CCgQ==
X-Gm-Message-State: AOJu0Yx5ZKjYmqn2u+eEv2R8oksgP3fFNlh+HH1/++vzwzK7ZW7RfdF7
	V8lHjLODNxsbswRikh+VX83VOlD6Ms9WC4wS91U7CB42f+mjgiBnmVHIGpTmm12X+/pnIbF3UBd
	zWBzJ/YduDXXd6AouwQqaFND7eG28+Q/gX3wvjN0ixTpksWCuM24hdLdYyA==
X-Gm-Gg: ASbGncvMd+sKUNKRLS8vJiK1ZzdMizu/vO6IGy9NN3v5Rlx+SQc45Cep+h/PcwkyyxO
	aLKeR9XS5jauNLBFYPuAWF0gMbrcdjaPn2z+BykWs6ISaqZysicOj5jduf0U51B1DOifOFxGBRu
	lsBjNQgv7UDnUkhGh3vGiaoC57pM0YQAXNAZ16r+ljV3c=
X-Google-Smtp-Source: AGHT+IHNOT9cLngbqVKXc8Zq8j+EuT/FC1UkMub/fGNexnaXm0tKSJcoikZV0YVInrIA71S0e+hjb++ZHGY35vmfbtw=
X-Received: by 2002:a05:6402:90b:b0:603:51cd:f1cf with SMTP id
 4fb4d7f45d1cf-60772b618e9mr12126060a12.7.1749466080205; Mon, 09 Jun 2025
 03:48:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605160002.1652091-1-magdalena.kasenberg@codecoup.pl>
 <20250605160002.1652091-2-magdalena.kasenberg@codecoup.pl> <f8c8bb10-7fd1-467b-b4ea-d33f42a45089@molgen.mpg.de>
In-Reply-To: <f8c8bb10-7fd1-467b-b4ea-d33f42a45089@molgen.mpg.de>
From: Magdalena Kasenberg <magdalena.kasenberg@codecoup.pl>
Date: Mon, 9 Jun 2025 12:47:48 +0200
X-Gm-Features: AX0GCFtL5fLTmUxvFpm1ZFP5Kxhd_ZknkV6GJOrujNRKLF7eNbGOPUfpusqWbDw
Message-ID: <CAEiWcDZuisPbCFT6HHUWuZn-5bsPeRacGAsoPQvBkd9dj74Pyw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 1/1] monitor: Add support for decoding Channel Sounding
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

Thanks! Yes, it=E2=80=99s mostly just a straightforward decoding based on t=
he spec.

Best regards,
Magda

On Sat, 7 Jun 2025 at 19:01, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Magdalena,
>
>
> Thank you for the improved commit message..
>
> Am 05.06.25 um 18:00 schrieb Magdalena Kasenberg:
> > Add initial support for decoding commands and events of Channel
> > Sounding, a new feature introduced in Bluetooth Core Specification
> > Version 6.0 | Vol 1, Part A, Section 9 "Channel Sounding Using
> > Bluetooth Low Energy".
> >
> > Testing:
> >
> > To test the feature you need a hardware that supports Channel Sounding.
> > Channel Sounding can be tested using Nordic Semiconductor's sample
> > applications for the Initiator and Reflector roles, which are available
> > as part of the nRF Connect SDK and require an nRF54L15 development kit.
> > See tutorials:
> > https://docs.nordicsemi.com/bundle/ncs-latest/page/nrf/samples/bluetoot=
h/channel_sounding_ras_initiator/README.html
> > https://docs.nordicsemi.com/bundle/ncs-latest/page/nrf/samples/bluetoot=
h/channel_sounding_ras_reflector/README.html
>
> Thank you for describing the test setup. As you add decoding, an example
> trace might be good to have in the commit message too.
>
> > ---
> >   monitor/bt.h     |  321 +++++++++++++
> >   monitor/packet.c | 1200 +++++++++++++++++++++++++++++++++++++++++++++=
+
>
> Phew. Quite some added lines. Kudos.
>
> Anything special regarding the implementation, or just describing the
> types and so on to decode it?
>
>
> Kind regards,
>
> Paul
>
>
> >   2 files changed, 1521 insertions(+)
> >
> > diff --git a/monitor/bt.h b/monitor/bt.h
> > index dd67750dc..0e80ad2a2 100644
> > --- a/monitor/bt.h
> > +++ b/monitor/bt.h
> > @@ -2937,6 +2937,211 @@ struct bt_hci_rsp_le_read_iso_link_quality {
> >       uint32_t duplicated_packets;
> >   } __attribute__ ((packed));
> >
> > +#define BT_HCI_CMD_LE_CS_RD_LOC_SUPP_CAP     0x2089
> > +#define BT_HCI_BIT_LE_CS_RD_LOC_SUPP_CAP     BT_HCI_CMD_BIT(20, 5)
> > +struct bt_hci_rsp_le_cs_rd_loc_supp_cap {
> > +     uint8_t status;
> > +     uint8_t num_config_supported;
> > +     uint16_t max_consecutive_procedures_supported;
> > +     uint8_t num_antennas_supported;
> > +     uint8_t max_antenna_paths_supported;
> > +     uint8_t roles_supported;
> > +     uint8_t modes_supported;
> > +     uint8_t rtt_capability;
> > +     uint8_t rtt_aa_only_n;
> > +     uint8_t rtt_sounding_n;
> > +     uint8_t rtt_random_payload_n;
> > +     uint16_t nadm_sounding_capability;
> > +     uint16_t nadm_random_capability;
> > +     uint8_t cs_sync_phys_supported;
> > +     uint16_t subfeatures_supported;
> > +     uint16_t t_ip1_times_supported;
> > +     uint16_t t_ip2_times_supported;
> > +     uint16_t t_fcs_times_supported;
> > +     uint16_t t_pm_times_supported;
> > +     uint8_t t_sw_time_supported;
> > +     uint8_t tx_snr_capability;
> > +} __attribute__((packed));
> > +
> > +#define BT_HCI_CMD_LE_CS_RD_REM_SUPP_CAP     0x208A
> > +#define BT_HCI_BIT_LE_CS_RD_REM_SUPP_CAP     BT_HCI_CMD_BIT(20, 6)
> > +struct bt_hci_cmd_le_cs_rd_rem_supp_cap {
> > +     uint16_t handle;
> > +} __attribute__((packed));
> > +
> > +#define BT_HCI_CMD_LE_CS_WR_CACHED_REM_SUPP_CAP      0x208B
> > +#define BT_HCI_BIT_LE_CS_WR_CACHED_REM_SUPP_CAP      BT_HCI_CMD_BIT(20=
, 7)
> > +struct bt_hci_cmd_le_cs_wr_cached_rem_supp_cap {
> > +     uint16_t handle;
> > +     uint8_t num_config_supported;
> > +     uint16_t max_consecutive_procedures_supported;
> > +     uint8_t num_antennas_supported;
> > +     uint8_t max_antenna_paths_supported;
> > +     uint8_t roles_supported;
> > +     uint8_t modes_supported;
> > +     uint8_t rtt_capability;
> > +     uint8_t rtt_aa_only_n;
> > +     uint8_t rtt_sounding_n;
> > +     uint8_t rtt_random_payload_n;
> > +     uint16_t nadm_sounding_capability;
> > +     uint16_t nadm_random_capability;
> > +     uint8_t cs_sync_phys_supported;
> > +     uint16_t subfeatures_supported;
> > +     uint16_t t_ip1_times_supported;
> > +     uint16_t t_ip2_times_supported;
> > +     uint16_t t_fcs_times_supported;
> > +     uint16_t t_pm_times_supported;
> > +     uint8_t t_sw_time_supported;
> > +     uint8_t tx_snr_capability;
> > +} __attribute__((packed));
> > +struct bt_hci_rsp_le_cs_wr_cached_rem_supp_cap {
> > +     uint8_t status;
> > +     uint16_t handle;
> > +} __attribute__((packed));
> > +
> > +#define BT_HCI_CMD_LE_CS_SEC_ENABLE          0x208C
> > +#define BT_HCI_BIT_LE_CS_SEC_ENABLE          BT_HCI_CMD_BIT(24, 1)
> > +struct bt_hci_cmd_le_cs_sec_enable {
> > +     uint16_t handle;
> > +} __attribute__((packed));
> > +
> > +#define BT_HCI_CMD_LE_CS_SET_DEF_SETTINGS    0x208D
> > +#define BT_HCI_BIT_LE_CS_SET_DEF_SETTINGS    BT_HCI_CMD_BIT(24, 7)
> > +struct bt_hci_cmd_le_cs_set_def_settings {
> > +     uint16_t handle;
> > +     uint8_t role_enable;
> > +     uint8_t cs_sync_antenna_selection;
> > +     uint8_t max_tx_power;
> > +} __attribute__((packed));
> > +struct bt_hci_rsp_le_cs_set_def_settings {
> > +     uint8_t status;
> > +     uint16_t handle;
> > +} __attribute__((packed));
> > +
> > +#define BT_HCI_CMD_LE_CS_RD_REM_FAE          0x208E
> > +#define BT_HCI_BIT_LE_CS_RD_REM_FAE          BT_HCI_CMD_BIT(12, 2)
> > +struct bt_hci_cmd_le_cs_rd_rem_fae {
> > +     uint16_t handle;
> > +} __attribute__((packed));
> > +
> > +#define BT_HCI_CMD_LE_CS_WR_CACHED_REM_FAE   0x208F
> > +#define BT_HCI_BIT_LE_CS_WR_CACHED_REM_FAE   BT_HCI_CMD_BIT(12, 3)
> > +struct bt_hci_cmd_le_cs_wr_cached_rem_fae {
> > +     uint16_t handle;
> > +     uint8_t remote_fae_table[72];
> > +} __attribute__((packed));
> > +struct bt_hci_rsp_le_cs_wr_cached_rem_fae {
> > +     uint8_t status;
> > +     uint16_t handle;
> > +} __attribute__((packed));
> > +
> > +#define BT_HCI_CMD_LE_CS_CREATE_CONFIG               0x2090
> > +#define BT_HCI_BIT_LE_CS_CREATE_CONFIG               BT_HCI_CMD_BIT(16=
, 6)
> > +struct bt_hci_cmd_le_cs_create_config {
> > +     uint16_t handle;
> > +     uint8_t config_id;
> > +     uint8_t create_context;
> > +     uint8_t main_mode_type;
> > +     uint8_t sub_mode_type;
> > +     uint8_t min_main_mode_steps;
> > +     uint8_t max_main_mode_steps;
> > +     uint8_t main_mode_repetition;
> > +     uint8_t mode_0_steps;
> > +     uint8_t role;
> > +     uint8_t rtt_type;
> > +     uint8_t cs_sync_phy;
> > +     uint8_t channel_map[10];
> > +     uint8_t channel_map_repetition;
> > +     uint8_t channel_selection_type;
> > +     uint8_t ch3c_shape;
> > +     uint8_t ch3c_jump;
> > +     uint8_t reserved;
> > +} __attribute__((packed));
> > +
> > +#define BT_HCI_CMD_LE_CS_REMOVE_CONFIG               0x2091
> > +#define BT_HCI_BIT_LE_CS_REMOVE_CONFIG               BT_HCI_CMD_BIT(16=
, 7)
> > +struct bt_hci_cmd_le_cs_remove_config {
> > +     uint16_t handle;
> > +     uint8_t config_id;
> > +} __attribute__((packed));
> > +
> > +#define BT_HCI_CMD_LE_CS_SET_CHAN_CLASS              0x2092
> > +#define BT_HCI_BIT_LE_CS_SET_CHAN_CLASS              BT_HCI_CMD_BIT(29=
, 0)
> > +struct bt_hci_cmd_le_cs_set_chan_class {
> > +     uint8_t channel_classification[10];
> > +} __attribute__((packed));
> > +struct bt_hci_rsp_le_cs_set_chan_class {
> > +     uint8_t status;
> > +} __attribute__((packed));
> > +
> > +#define BT_HCI_CMD_LE_CS_SET_PROC_PARAMS     0x2093
> > +#define BT_HCI_BIT_LE_CS_SET_PROC_PARAMS     BT_HCI_CMD_BIT(29, 1)
> > +struct bt_hci_cmd_le_cs_set_proc_params {
> > +     uint16_t handle;
> > +     uint8_t config_id;
> > +     uint16_t max_procedure_len;
> > +     uint16_t min_procedure_interval;
> > +     uint16_t max_procedure_interval;
> > +     uint16_t max_procedure_count;
> > +     uint8_t min_subevent_len[3];
> > +     uint8_t max_subevent_len[3];
> > +     uint8_t tone_antenna_config_selection;
> > +     uint8_t phy;
> > +     uint8_t tx_power_delta;
> > +     uint8_t preferred_peer_antenna;
> > +     uint8_t snr_control_initiator;
> > +     uint8_t snr_control_reflector;
> > +} __attribute__((packed));
> > +struct bt_hci_rsp_le_cs_set_proc_params {
> > +     uint8_t status;
> > +     uint16_t handle;
> > +} __attribute__((packed));
> > +
> > +#define BT_HCI_CMD_LE_CS_PROC_ENABLE         0x2094
> > +#define BT_HCI_BIT_LE_CS_PROC_ENABLE         BT_HCI_CMD_BIT(29, 2)
> > +struct bt_hci_cmd_le_cs_proc_enable {
> > +     uint16_t handle;
> > +     uint8_t config_id;
> > +     uint8_t enable;
> > +} __attribute__((packed));
> > +
> > +#define BT_HCI_CMD_LE_CS_TEST                        0x2095
> > +#define BT_HCI_BIT_LE_CS_TEST                        BT_HCI_CMD_BIT(23=
, 3)
> > +struct bt_hci_cmd_le_cs_test {
> > +     uint8_t main_mode_type;
> > +     uint8_t sub_mode_type;
> > +     uint8_t main_mode_repetition;
> > +     uint8_t mode_0_steps;
> > +     uint8_t role;
> > +     uint8_t rtt_type;
> > +     uint8_t cs_sync_phy;
> > +     uint8_t cs_sync_antenna_selection;
> > +     uint8_t subevent_len[3];
> > +     uint16_t subevent_interval;
> > +     uint8_t max_num_subevents;
> > +     uint8_t transmit_power_level;
> > +     uint8_t t_ip1_time;
> > +     uint8_t t_ip2_time;
> > +     uint8_t t_fcs_time;
> > +     uint8_t t_pm_time;
> > +     uint8_t t_sw_time;
> > +     uint8_t tone_antenna_config_selection;
> > +     uint8_t reserved;
> > +     uint8_t snr_control_initiator;
> > +     uint8_t snr_control_reflector;
> > +     uint16_t drbg_nonce;
> > +     uint8_t channel_map_repetition;
> > +     uint16_t override_config;
> > +     uint8_t override_parameters_length;
> > +     uint8_t override_parameters_data[];
> > +} __attribute__((packed));
> > +struct bt_hci_rsp_le_cs_test {
> > +     uint8_t status;
> > +} __attribute__((packed));
> > +
> > +#define BT_HCI_CMD_LE_CS_TEST_END            0x2096
> > +#define BT_HCI_BIT_LE_CS_TEST_END            BT_HCI_CMD_BIT(23, 4)
> > +
> >   #define BT_HCI_CMD_LE_FSU                   0x209d
> >   #define BT_HCI_BIT_LE_FSU                   BT_HCI_CMD_BIT(48, 1)
> >   struct bt_hci_cmd_le_fsu {
> > @@ -3770,6 +3975,122 @@ struct bt_hci_evt_le_big_info_adv_report {
> >       uint8_t  encryption;
> >   } __attribute__ ((packed));
> >
> > +#define BT_HCI_EVT_LE_CS_RD_REM_SUPP_CAP_COMPLETE    (0x2C)
> > +struct bt_hci_evt_le_cs_rd_rem_supp_cap_complete {
> > +     uint8_t status;
> > +     uint16_t handle;
> > +     uint8_t num_config_supported;
> > +     uint16_t max_consecutive_procedures_supported;
> > +     uint8_t num_antennas_supported;
> > +     uint8_t max_antenna_paths_supported;
> > +     uint8_t roles_supported;
> > +     uint8_t modes_supported;
> > +     uint8_t rtt_capability;
> > +     uint8_t rtt_aa_only_n;
> > +     uint8_t rtt_sounding_n;
> > +     uint8_t rtt_random_payload_n;
> > +     uint16_t nadm_sounding_capability;
> > +     uint16_t nadm_random_capability;
> > +     uint8_t cs_sync_phys_supported;
> > +     uint16_t subfeatures_supported;
> > +     uint16_t t_ip1_times_supported;
> > +     uint16_t t_ip2_times_supported;
> > +     uint16_t t_fcs_times_supported;
> > +     uint16_t t_pm_times_supported;
> > +     uint8_t t_sw_time_supported;
> > +     uint8_t tx_snr_capability;
> > +} __attribute__((packed));
> > +
> > +#define BT_HCI_EVT_LE_CS_RD_REM_FAE_COMPLETE (0x2D)
> > +struct bt_hci_evt_le_cs_rd_rem_fae_complete {
> > +     uint8_t status;
> > +     uint16_t handle;
> > +     uint8_t remote_fae_table[72];
> > +} __attribute__((packed));
> > +
> > +#define BT_HCI_EVT_LE_CS_SEC_ENABLE_COMPLETE (0x2E)
> > +struct bt_hci_evt_le_cs_sec_enable_complete {
> > +     uint8_t status;
> > +     uint16_t handle;
> > +} __attribute__((packed));
> > +
> > +#define BT_HCI_EVT_LE_CS_CONFIG_COMPLETE     (0x2F)
> > +struct bt_hci_evt_le_cs_config_complete {
> > +     uint8_t status;
> > +     uint16_t handle;
> > +     uint8_t config_id;
> > +     uint8_t action;
> > +     uint8_t main_mode_type;
> > +     uint8_t sub_mode_type;
> > +     uint8_t min_main_mode_steps;
> > +     uint8_t max_main_mode_steps;
> > +     uint8_t main_mode_repetition;
> > +     uint8_t mode_0_steps;
> > +     uint8_t role;
> > +     uint8_t rtt_type;
> > +     uint8_t cs_sync_phy;
> > +     uint8_t channel_map[10];
> > +     uint8_t channel_map_repetition;
> > +     uint8_t channel_selection_type;
> > +     uint8_t ch3c_shape;
> > +     uint8_t ch3c_jump;
> > +     uint8_t reserved;
> > +     uint8_t t_ip1_time;
> > +     uint8_t t_ip2_time;
> > +     uint8_t t_fcs_time;
> > +     uint8_t t_pm_time;
> > +} __attribute__((packed));
> > +
> > +#define BT_HCI_EVT_LE_CS_PROC_ENABLE_COMPLETE        (0x30)
> > +struct bt_hci_evt_le_cs_proc_enable_complete {
> > +     uint8_t status;
> > +     uint16_t handle;
> > +     uint8_t config_id;
> > +     uint8_t state;
> > +     uint8_t tone_antenna_config_selection;
> > +     uint8_t selected_tx_power;
> > +     uint8_t subevent_len[3];
> > +     uint8_t subevents_per_event;
> > +     uint16_t subevent_interval;
> > +     uint16_t event_interval;
> > +     uint16_t procedure_interval;
> > +     uint16_t procedure_count;
> > +     uint16_t max_procedure_len;
> > +} __attribute__((packed));
> > +
> > +#define BT_HCI_EVT_LE_CS_SUBEVENT_RESULT     (0x31)
> > +struct bt_hci_evt_le_cs_subevent_result {
> > +     uint16_t handle;
> > +     uint8_t config_id;
> > +     uint16_t start_acl_conn_event_counter;
> > +     uint16_t procedure_counter;
> > +     uint16_t frequency_compensation;
> > +     uint8_t reference_power_level;
> > +     uint8_t procedure_done_status;
> > +     uint8_t subevent_done_status;
> > +     uint8_t abort_reason;
> > +     uint8_t num_antenna_paths;
> > +     uint8_t num_steps_reported;
> > +     uint8_t steps[];
> > +} __attribute__((packed));
> > +
> > +#define BT_HCI_EVT_LE_CS_SUBEVENT_RESULT_CONTINUE    (0x32)
> > +struct bt_hci_evt_le_cs_subevent_result_continue {
> > +     uint16_t handle;
> > +     uint8_t config_id;
> > +     uint8_t procedure_done_status;
> > +     uint8_t subevent_done_status;
> > +     uint8_t abort_reason;
> > +     uint8_t num_antenna_paths;
> > +     uint8_t num_steps_reported;
> > +     uint8_t steps[];
> > +} __attribute__((packed));
> > +
> > +#define BT_HCI_EVT_LE_CS_TEST_END_COMPLETE   (0x33)
> > +struct bt_hci_evt_le_cs_test_end_complete {
> > +     uint8_t status;
> > +} __attribute__((packed));
> > +
> >   #define BT_HCI_EVT_LE_FSU_COMPLETE          0x35
> >   struct bt_hci_evt_le_fsu_complete {
> >       uint8_t  status;
> > diff --git a/monitor/packet.c b/monitor/packet.c
> > index 149eabad0..ba4701a35 100644
> > --- a/monitor/packet.c
> > +++ b/monitor/packet.c
> > @@ -9080,6 +9080,473 @@ static void status_le_read_iso_link_quality_rsp=
(uint16_t index,
> >       print_field("Duplicated packets %d", rsp->duplicated_packets);
> >   }
> >
> > +static const struct bitfield_data cs_roles_supp_table[] =3D {
> > +     { 0, "Initiator"        },
> > +     { 1, "Reflector"        },
> > +     { }
> > +};
> > +
> > +static const struct bitfield_data cs_sync_phys_supp_table[] =3D {
> > +     { 1, "LE 2M"            },
> > +     { 2, "LE 2M 2BT"        },
> > +     { }
> > +};
> > +
> > +static const struct bitfield_data cs_subfeatures_supp_table[] =3D {
> > +     { 1, "CS with no transmitter Frequency Actuation Error"         }=
,
> > +     { 2, "CS Channel Selection Algorithm #3c"                       }=
,
> > +     { 3, "CS phase-based ranging from RTT sounding sequence"        }=
,
> > +     { }
> > +};
> > +
> > +static const struct bitfield_data cs_t_ip1_times_supp_table[] =3D {
> > +     { 0, "10 =CE=BCs"    },
> > +     { 1, "20 =CE=BCs"    },
> > +     { 2, "30 =CE=BCs"    },
> > +     { 3, "40 =CE=BCs"    },
> > +     { 4, "50 =CE=BCs"    },
> > +     { 5, "60 =CE=BCs"    },
> > +     { 6, "80 =CE=BCs"    },
> > +     { }
> > +};
> > +
> > +static const struct bitfield_data cs_t_ip2_times_supp_table[] =3D {
> > +     { 0, "10 =CE=BCs"    },
> > +     { 1, "20 =CE=BCs"    },
> > +     { 2, "30 =CE=BCs"    },
> > +     { 3, "40 =CE=BCs"    },
> > +     { 4, "50 =CE=BCs"    },
> > +     { 5, "60 =CE=BCs"    },
> > +     { 6, "80 =CE=BCs"    },
> > +     { }
> > +};
> > +
> > +static const struct bitfield_data cs_t_fcs_times_supp_table[] =3D {
> > +     { 0, "15 =CE=BCs"    },
> > +     { 1, "20 =CE=BCs"    },
> > +     { 2, "30 =CE=BCs"    },
> > +     { 3, "40 =CE=BCs"    },
> > +     { 4, "50 =CE=BCs"    },
> > +     { 5, "60 =CE=BCs"    },
> > +     { 6, "80 =CE=BCs"    },
> > +     { 7, "100 =CE=BCs"   },
> > +     { 8, "120 =CE=BCs"   },
> > +     { }
> > +};
> > +
> > +static const struct bitfield_data cs_t_pm_times_supp_table[] =3D {
> > +     { 0, "10 us"    },
> > +     { 1, "20 us"    },
> > +     { }
> > +};
> > +
> > +static const struct bitfield_data cs_tx_snr_capability_table[] =3D {
> > +     { 0, "18 dB"    },
> > +     { 1, "21 dB"    },
> > +     { 2, "24 dB"    },
> > +     { 3, "27 dB"    },
> > +     { 4, "30 dB"    },
> > +     { }
> > +};
> > +
> > +static void le_cs_rd_loc_supp_cap_rsp(uint16_t index, const void *data=
,
> > +                                     uint8_t size)
> > +{
> > +     const struct bt_hci_rsp_le_cs_rd_loc_supp_cap *rsp =3D data;
> > +     uint16_t mask;
> > +
> > +     print_status(rsp->status);
> > +     print_field("Num Config Supported: %d", rsp->num_config_supported=
);
> > +     print_field("Max Consecutive Procedures Supported: %d",
> > +             le16_to_cpu(rsp->max_consecutive_procedures_supported));
> > +     print_field("Num Antennas Supported: %d", rsp->num_antennas_suppo=
rted);
> > +     print_field("Max Antenna Paths Supported: %d",
> > +             rsp->max_antenna_paths_supported);
> > +
> > +     print_field("Roles Supported: 0x%2.2x", rsp->roles_supported);
> > +     mask =3D print_bitfield(2, rsp->roles_supported, cs_roles_supp_ta=
ble);
> > +     if (mask)
> > +             print_text(COLOR_UNKNOWN_FEATURE_BIT,
> > +                     "  Unknown Role (0x%2.2x)", mask);
> > +
> > +     print_field("Modes Supported: 0x%2.2x", rsp->modes_supported);
> > +     print_field("RTT Capability: 0x%2.2x", rsp->rtt_capability);
> > +     print_field("RTT AA Only N: %d", rsp->rtt_aa_only_n);
> > +     print_field("RTT Sounding N: %d", rsp->rtt_sounding_n);
> > +     print_field("RTT Random Sequence N: %d", rsp->rtt_random_payload_=
n);
> > +     print_field("NADM Sounding Capability: 0x%2.2x",
> > +             le16_to_cpu(rsp->nadm_sounding_capability));
> > +     print_field("NADM Random Capability: 0x%2.2x",
> > +             le16_to_cpu(rsp->nadm_random_capability));
> > +
> > +     print_field("CS_SYNC PHYs Supported: 0x%2.2x",
> > +             rsp->cs_sync_phys_supported);
> > +     mask =3D print_bitfield(2, rsp->cs_sync_phys_supported,
> > +             cs_sync_phys_supp_table);
> > +     if (mask)
> > +             print_text(COLOR_UNKNOWN_PHY, "  Unknown PHYs (0x%2.2x)",=
 mask);
> > +
> > +     print_field("Subfeatures Supported: 0x%4.4x",
> > +             le16_to_cpu(rsp->subfeatures_supported));
> > +     mask =3D print_bitfield(2, le16_to_cpu(rsp->subfeatures_supported=
),
> > +             cs_subfeatures_supp_table);
> > +     if (mask)
> > +             print_text(COLOR_UNKNOWN_FEATURE_BIT, "  Unknown subfeatu=
res"
> > +                     " (0x%4.4x)", mask);
> > +
> > +     print_field("T_IP1 Times Supported: 0x%4.4x",
> > +             le16_to_cpu(rsp->t_ip1_times_supported));
> > +     mask =3D print_bitfield(2, le16_to_cpu(rsp->t_ip1_times_supported=
),
> > +             cs_t_ip1_times_supp_table);
> > +     if (mask)
> > +             print_text(COLOR_UNKNOWN_FEATURE_BIT, "  Unknown T_IP1 Ti=
mes"
> > +                     " (0x%4.4x)", mask);
> > +
> > +     print_field("T_IP2 Times Supported: 0x%4.4x",
> > +             le16_to_cpu(rsp->t_ip2_times_supported));
> > +     mask =3D print_bitfield(2, le16_to_cpu(rsp->t_ip2_times_supported=
),
> > +             cs_t_ip2_times_supp_table);
> > +     if (mask)
> > +             print_text(COLOR_UNKNOWN_FEATURE_BIT, "  Unknown T_IP2 Ti=
mes"
> > +                     " (0x%4.4x)", mask);
> > +
> > +     print_field("T_FCS Times Supported: 0x%4.4x",
> > +             le16_to_cpu(rsp->t_fcs_times_supported));
> > +     mask =3D print_bitfield(2, le16_to_cpu(rsp->t_fcs_times_supported=
),
> > +             cs_t_fcs_times_supp_table);
> > +     if (mask)
> > +             print_text(COLOR_UNKNOWN_FEATURE_BIT, "  Unknown T_FCS Ti=
mes"
> > +                     " (0x%4.4x)", mask);
> > +
> > +     print_field("T_PM Times Supported: 0x%4.4x",
> > +             le16_to_cpu(rsp->t_pm_times_supported));
> > +     mask =3D print_bitfield(2, le16_to_cpu(rsp->t_pm_times_supported)=
,
> > +             cs_t_pm_times_supp_table);
> > +     if (mask)
> > +             print_text(COLOR_UNKNOWN_FEATURE_BIT, "  Unknown T_PM Tim=
es"
> > +                     " (0x%4.4x)", mask);
> > +
> > +     print_field("T_SW Time Supported: 0x%2.2x", rsp->t_sw_time_suppor=
ted);
> > +
> > +     print_field("TX_SNR Capability: 0x%2.2x", rsp->tx_snr_capability)=
;
> > +     mask =3D print_bitfield(2, rsp->tx_snr_capability,
> > +             cs_tx_snr_capability_table);
> > +     if (mask)
> > +             print_text(COLOR_UNKNOWN_FEATURE_BIT,
> > +                     "  Unknown TX_SNR Capability (0x%2.2x)", mask);
> > +}
> > +
> > +static void le_cs_rd_rem_supp_cap_cmd(uint16_t index, const void *data=
,
> > +                                     uint8_t size)
> > +{
> > +     const struct bt_hci_cmd_le_cs_rd_rem_supp_cap *cmd =3D data;
> > +
> > +     print_field("Connection handle: %d", le16_to_cpu(cmd->handle));
> > +}
> > +
> > +static void le_cs_wr_cached_rem_supp_cap_cmd(uint16_t index, const voi=
d *data,
> > +                                     uint8_t size)
> > +{
> > +     const struct bt_hci_cmd_le_cs_wr_cached_rem_supp_cap *cmd =3D dat=
a;
> > +     uint16_t mask;
> > +
> > +     print_field("Connection Handle: %d", le16_to_cpu(cmd->handle));
> > +     print_field("Num Config Supported: %d", cmd->num_config_supported=
);
> > +     print_field("Max Consecutive Procedures Supported: %d",
> > +             le16_to_cpu(cmd->max_consecutive_procedures_supported));
> > +     print_field("Num Antennas Supported: %d", cmd->num_antennas_suppo=
rted);
> > +     print_field("Max Antenna Paths Supported: %d",
> > +             cmd->max_antenna_paths_supported);
> > +
> > +     print_field("Roles Supported: 0x%2.2x", cmd->roles_supported);
> > +     mask =3D print_bitfield(2, cmd->roles_supported, cs_roles_supp_ta=
ble);
> > +     if (mask)
> > +             print_text(COLOR_UNKNOWN_FEATURE_BIT,
> > +             "  Unknown Role (0x%2.2x)", mask);
> > +
> > +     print_field("Modes Supported: 0x%2.2x", cmd->modes_supported);
> > +     print_field("RTT Capability: 0x%2.2x", cmd->rtt_capability);
> > +     print_field("RTT AA Only N: %d", cmd->rtt_aa_only_n);
> > +     print_field("RTT Sounding N: %d", cmd->rtt_sounding_n);
> > +     print_field("RTT Random Sequence N: %d", cmd->rtt_random_payload_=
n);
> > +     print_field("NADM Sounding Capability: 0x%2.2x",
> > +             le16_to_cpu(cmd->nadm_sounding_capability));
> > +     print_field("NADM Random Capability: 0x%2.2x",
> > +             le16_to_cpu(cmd->nadm_random_capability));
> > +
> > +     print_field("CS_SYNC PHYs Supported: 0x%2.2x",
> > +             cmd->cs_sync_phys_supported);
> > +     mask =3D print_bitfield(2, cmd->cs_sync_phys_supported,
> > +             cs_sync_phys_supp_table);
> > +     if (mask)
> > +             print_text(COLOR_UNKNOWN_PHY, "  Unknown PHYs (0x%2.2x)",=
 mask);
> > +
> > +     print_field("Subfeatures Supported: 0x%4.4x",
> > +             le16_to_cpu(cmd->subfeatures_supported));
> > +     mask =3D print_bitfield(2, le16_to_cpu(cmd->subfeatures_supported=
),
> > +             cs_subfeatures_supp_table);
> > +     if (mask)
> > +             print_text(COLOR_UNKNOWN_FEATURE_BIT, "  Unknown subfeatu=
res"
> > +                     " (0x%4.4x)", mask);
> > +
> > +     print_field("T_IP1 Times Supported: 0x%4.4x",
> > +             le16_to_cpu(cmd->t_ip1_times_supported));
> > +     mask =3D print_bitfield(2, le16_to_cpu(cmd->t_ip1_times_supported=
),
> > +             cs_t_ip1_times_supp_table);
> > +     if (mask)
> > +             print_text(COLOR_UNKNOWN_FEATURE_BIT, "  Unknown T_IP1 Ti=
mes"
> > +                     " (0x%4.4x)", mask);
> > +
> > +     print_field("T_IP2 Times Supported: 0x%4.4x",
> > +             le16_to_cpu(cmd->t_ip2_times_supported));
> > +     mask =3D print_bitfield(2, le16_to_cpu(cmd->t_ip2_times_supported=
),
> > +             cs_t_ip2_times_supp_table);
> > +     if (mask)
> > +             print_text(COLOR_UNKNOWN_FEATURE_BIT, "  Unknown T_IP2 Ti=
mes"
> > +                     " (0x%4.4x)", mask);
> > +
> > +     print_field("T_FCS Times Supported: 0x%4.4x",
> > +             le16_to_cpu(cmd->t_fcs_times_supported));
> > +     mask =3D print_bitfield(2, le16_to_cpu(cmd->t_fcs_times_supported=
),
> > +             cs_t_fcs_times_supp_table);
> > +     if (mask)
> > +             print_text(COLOR_UNKNOWN_FEATURE_BIT, "  Unknown T_FCS Ti=
mes"
> > +                     " (0x%4.4x)", mask);
> > +
> > +     print_field("T_PM Times Supported: 0x%4.4x",
> > +             le16_to_cpu(cmd->t_pm_times_supported));
> > +     mask =3D print_bitfield(2, le16_to_cpu(cmd->t_pm_times_supported)=
,
> > +             cs_t_pm_times_supp_table);
> > +     if (mask)
> > +             print_text(COLOR_UNKNOWN_FEATURE_BIT, "  Unknown T_PM Tim=
es"
> > +                     " (0x%4.4x)", mask);
> > +
> > +     print_field("T_SW Time Supported: 0x%2.2x", cmd->t_sw_time_suppor=
ted);
> > +
> > +     print_field("TX_SNR Capability: 0x%2.2x", cmd->tx_snr_capability)=
;
> > +     mask =3D print_bitfield(2, cmd->tx_snr_capability,
> > +             cs_tx_snr_capability_table);
> > +     if (mask)
> > +             print_text(COLOR_UNKNOWN_FEATURE_BIT,
> > +                     "  Unknown TX_SNR Capability (0x%2.2x)", mask);
> > +}
> > +
> > +static void le_cs_wr_cached_rem_supp_cap_rsp(uint16_t index, const voi=
d *data,
> > +                                     uint8_t size)
> > +{
> > +     const struct bt_hci_rsp_le_cs_wr_cached_rem_supp_cap *rsp =3D dat=
a;
> > +
> > +     print_status(rsp->status);
> > +     print_field("Connection handle: %d", le16_to_cpu(rsp->handle));
> > +}
> > +
> > +static void le_cs_sec_enable_cmd(uint16_t index, const void *data,
> > +                                     uint8_t size)
> > +{
> > +     const struct bt_hci_cmd_le_cs_sec_enable *cmd =3D data;
> > +
> > +     print_field("Connection handle: %d", le16_to_cpu(cmd->handle));
> > +}
> > +
> > +static void le_cs_set_def_settings_cmd(uint16_t index, const void *dat=
a,
> > +                                     uint8_t size)
> > +{
> > +     const struct bt_hci_cmd_le_cs_set_def_settings *cmd =3D data;
> > +     uint16_t mask;
> > +
> > +     print_field("Connection handle: %d", le16_to_cpu(cmd->handle));
> > +     print_field("Role Enable: 0x%2.2x", cmd->role_enable);
> > +     mask =3D print_bitfield(2, cmd->role_enable, cs_roles_supp_table)=
;
> > +     if (mask)
> > +             print_text(COLOR_UNKNOWN_FEATURE_BIT,
> > +             "  Unknown Role (0x%2.2x)", mask);
> > +
> > +     print_field("CS SYNC Antenna Selection: 0x%2.2x",
> > +             cmd->cs_sync_antenna_selection);
> > +     print_field("Max TX Power: %d", cmd->max_tx_power);
> > +}
> > +
> > +static void le_cs_set_def_settings_rsp(uint16_t index, const void *dat=
a,
> > +                                     uint8_t size)
> > +{
> > +     const struct bt_hci_rsp_le_cs_set_def_settings *rsp =3D data;
> > +
> > +     print_status(rsp->status);
> > +     print_field("Connection handle: %d", le16_to_cpu(rsp->handle));
> > +}
> > +
> > +static void le_cs_rd_rem_fae_cmd(uint16_t index, const void *data,
> > +                                     uint8_t size)
> > +{
> > +     const struct bt_hci_cmd_le_cs_rd_rem_fae *cmd =3D data;
> > +
> > +     print_field("Connection handle: %d", le16_to_cpu(cmd->handle));
> > +}
> > +
> > +static void le_cs_wr_cached_rem_fae_cmd(uint16_t index, const void *da=
ta,
> > +                                     uint8_t size)
> > +{
> > +     const struct bt_hci_cmd_le_cs_wr_cached_rem_fae *cmd =3D data;
> > +
> > +     print_field("Connection handle: %d", le16_to_cpu(cmd->handle));
> > +     print_hex_field("Remote FAE Table: ", cmd->remote_fae_table,
> > +             sizeof(cmd->remote_fae_table));
> > +}
> > +
> > +static void le_cs_wr_cached_rem_fae_rsp(uint16_t index, const void *da=
ta,
> > +                                     uint8_t size)
> > +{
> > +     const struct bt_hci_rsp_le_cs_wr_cached_rem_fae *rsp =3D data;
> > +
> > +     print_status(rsp->status);
> > +     print_field("Connection handle: %d", le16_to_cpu(rsp->handle));
> > +}
> > +
> > +static void le_cs_create_config_cmd(uint16_t index, const void *data,
> > +                                     uint8_t size)
> > +{
> > +     const struct bt_hci_cmd_le_cs_create_config *cmd =3D data;
> > +
> > +     print_field("Connection handle: %d", le16_to_cpu(cmd->handle));
> > +     print_field("Config ID: %d", cmd->config_id);
> > +     print_field("Create Context: %d", cmd->create_context);
> > +     print_field("Main Mode Type: %d", cmd->main_mode_type);
> > +     print_field("Sub Mode Type: %d", cmd->sub_mode_type);
> > +     print_field("Min Main Mode Steps: %d", cmd->min_main_mode_steps);
> > +     print_field("Max Main Mode Steps: %d", cmd->max_main_mode_steps);
> > +     print_field("Main Mode Repetition: %d", cmd->main_mode_repetition=
);
> > +     print_field("Mode 0 Steps: %d", cmd->mode_0_steps);
> > +     print_field("Role: %d", cmd->role);
> > +     print_field("RTT Type: %d", cmd->rtt_type);
> > +     print_field("CS SYNC PHY: %d", cmd->cs_sync_phy);
> > +     print_hex_field("Channel Map: ", cmd->channel_map,
> > +             sizeof(cmd->channel_map));
> > +     print_field("Channel Map Repetition: %d", cmd->channel_map_repeti=
tion);
> > +     print_field("Channel Selection Type: %d", cmd->channel_selection_=
type);
> > +     print_field("Ch3c Shape: %d", cmd->ch3c_shape);
> > +     print_field("Ch3c Jump: %d", cmd->ch3c_jump);
> > +     print_field("Reserved: %d", cmd->reserved);
> > +}
> > +
> > +static void le_cs_remove_config_cmd(uint16_t index, const void *data,
> > +                                     uint8_t size)
> > +{
> > +     const struct bt_hci_cmd_le_cs_remove_config *cmd =3D data;
> > +
> > +     print_field("Connection handle: %d", le16_to_cpu(cmd->handle));
> > +     print_field("Config ID: %d", cmd->config_id);
> > +}
> > +
> > +static void le_cs_set_chan_class_cmd(uint16_t index, const void *data,
> > +                                     uint8_t size)
> > +{
> > +     const struct bt_hci_cmd_le_cs_set_chan_class *cmd =3D data;
> > +
> > +     print_hex_field("Channel Classification: ",
> > +                     cmd->channel_classification,
> > +                     sizeof(cmd->channel_classification));
> > +}
> > +
> > +static void le_cs_set_chan_class_rsp(uint16_t index, const void *data,
> > +                                     uint8_t size)
> > +{
> > +     const struct bt_hci_rsp_le_cs_set_chan_class *rsp =3D data;
> > +
> > +     print_status(rsp->status);
> > +}
> > +
> > +static void le_cs_set_proc_params_cmd(uint16_t index, const void *data=
,
> > +                                     uint8_t size)
> > +{
> > +     const struct bt_hci_cmd_le_cs_set_proc_params *cmd =3D data;
> > +
> > +     print_field("Connection Handle: %d", le16_to_cpu(cmd->handle));
> > +     print_field("Config ID: %d", cmd->config_id);
> > +     print_field("Max Procedure Len: %d",
> > +             le16_to_cpu(cmd->max_procedure_len));
> > +     print_field("Min Procedure Interval: %d",
> > +                 le16_to_cpu(cmd->min_procedure_interval));
> > +     print_field("Max Procedure Interval: %d",
> > +                 le16_to_cpu(cmd->max_procedure_interval));
> > +     print_field("Max Procedure Count: %d",
> > +                 le16_to_cpu(cmd->max_procedure_count));
> > +     print_field("Min Subevent Len: %d",
> > +                 get_le24(cmd->min_subevent_len));
> > +     print_field("Max Subevent Len: %d",
> > +                 get_le24(cmd->max_subevent_len));
> > +     print_field("Tone Antenna Config Selection: %d",
> > +                 cmd->tone_antenna_config_selection);
> > +     print_field("PHY: %d", cmd->phy);
> > +     print_field("Tx Power Delta: %d", cmd->tx_power_delta);
> > +     print_field("Preferred Peer Antenna: %d", cmd->preferred_peer_ant=
enna);
> > +     print_field("SNR Control Initiator: %d", cmd->snr_control_initiat=
or);
> > +     print_field("SNR Control Reflector: %d", cmd->snr_control_reflect=
or);
> > +}
> > +
> > +static void le_cs_set_proc_params_rsp(uint16_t index, const void *data=
,
> > +                                     uint8_t size)
> > +{
> > +     const struct bt_hci_rsp_le_cs_set_proc_params *rsp =3D data;
> > +
> > +     print_status(rsp->status);
> > +     print_field("Connection handle: %d", le16_to_cpu(rsp->handle));
> > +}
> > +
> > +static void le_cs_proc_enable_cmd(uint16_t index, const void *data,
> > +                                     uint8_t size)
> > +{
> > +     const struct bt_hci_cmd_le_cs_proc_enable *cmd =3D data;
> > +
> > +     print_field("Connection handle: %d", le16_to_cpu(cmd->handle));
> > +     print_field("Config ID: %d", cmd->config_id);
> > +     print_field("Enable: %d", cmd->enable);
> > +}
> > +
> > +static void le_cs_test_cmd(uint16_t index, const void *data, uint8_t s=
ize)
> > +{
> > +     const struct bt_hci_cmd_le_cs_test *cmd =3D data;
> > +
> > +     print_field("Main Mode Type: %d", cmd->main_mode_type);
> > +     print_field("Sub Mode Type: %d", cmd->sub_mode_type);
> > +     print_field("Main Mode Repetition: %d", cmd->main_mode_repetition=
);
> > +     print_field("Mode 0 Steps: %d", cmd->mode_0_steps);
> > +     print_field("Role: %d", cmd->role);
> > +     print_field("RTT Type: %d", cmd->rtt_type);
> > +     print_field("CS_SYNC PHY: %d", cmd->cs_sync_phy);
> > +     print_field("CS_SYNC Antenna Selection: %d",
> > +             cmd->cs_sync_antenna_selection);
> > +     print_field("Subevent Len: %d", get_le24(cmd->subevent_len));
> > +     print_field("Subevent Interval: %d",
> > +             le16_to_cpu(cmd->subevent_interval));
> > +     print_field("Max Num Subevents: %d", cmd->max_num_subevents);
> > +     print_field("Transmit Power Level: %d", cmd->transmit_power_level=
);
> > +     print_field("T_IP1 Time: %d", cmd->t_ip1_time);
> > +     print_field("T_IP2 Time: %d", cmd->t_ip2_time);
> > +     print_field("T_FCS Time: %d", cmd->t_fcs_time);
> > +     print_field("T_PM Time: %d", cmd->t_pm_time);
> > +     print_field("T_SW Time: %d", cmd->t_sw_time);
> > +     print_field("Tone Antenna Config Selection: %d",
> > +             cmd->tone_antenna_config_selection);
> > +     print_field("Reserved: %d", cmd->reserved);
> > +     print_field("SNR Control Initiator: %d", cmd->snr_control_initiat=
or);
> > +     print_field("SNR Control Reflector: %d", cmd->snr_control_reflect=
or);
> > +     print_field("DRBG Nonce: %d", le16_to_cpu(cmd->drbg_nonce));
> > +     print_field("Channel Map Repetition: %d", cmd->channel_map_repeti=
tion);
> > +     print_field("Override Config: %d",  le16_to_cpu(cmd->override_con=
fig));
> > +     print_field("Override Parameters Length: %d",
> > +             cmd->override_parameters_length);
> > +     print_hex_field("Override Parameters Data: ",
> > +             cmd->override_parameters_data,
> > +             cmd->override_parameters_length);
> > +}
> > +
> > +static void le_cs_test_rsp(uint16_t index, const void *data, uint8_t s=
ize)
> > +{
> > +     const struct bt_hci_rsp_le_cs_test *rsp =3D data;
> > +
> > +     print_status(rsp->status);
> > +}
> > +
> >   static const struct bitfield_data fsu_type_table[] =3D {
> >       {  0, "T_IFS_ACL_CP"            },
> >       {  1, "T_IFS_ACL_PC"            },
> > @@ -10075,6 +10542,101 @@ static const struct opcode_data opcode_table[=
] =3D {
> >                               sizeof(
> >                               struct bt_hci_rsp_le_read_iso_link_qualit=
y),
> >                               true },
> > +     { BT_HCI_CMD_LE_CS_RD_LOC_SUPP_CAP, BT_HCI_BIT_LE_CS_RD_LOC_SUPP_=
CAP,
> > +                             "LE CS Read Local Supported Capabilities"=
,
> > +                             NULL, 0, false,
> > +                             le_cs_rd_loc_supp_cap_rsp,
> > +                             sizeof(struct bt_hci_rsp_le_cs_rd_loc_sup=
p_cap),
> > +                             true },
> > +     { BT_HCI_CMD_LE_CS_RD_REM_SUPP_CAP, BT_HCI_BIT_LE_CS_RD_REM_SUPP_=
CAP,
> > +                             "LE CS Read Remote Supported Capabilities=
",
> > +                             le_cs_rd_rem_supp_cap_cmd,
> > +                             sizeof(struct bt_hci_cmd_le_cs_rd_rem_sup=
p_cap),
> > +                             true },
> > +     { BT_HCI_CMD_LE_CS_WR_CACHED_REM_SUPP_CAP,
> > +                             BT_HCI_BIT_LE_CS_WR_CACHED_REM_SUPP_CAP,
> > +                             "LE CS Write Cached Remote Supported Capa=
bilities",
> > +                             le_cs_wr_cached_rem_supp_cap_cmd,
> > +                             sizeof(
> > +                             struct bt_hci_cmd_le_cs_wr_cached_rem_sup=
p_cap),
> > +                             true,
> > +                             le_cs_wr_cached_rem_supp_cap_rsp,
> > +                             sizeof(
> > +                             struct bt_hci_rsp_le_cs_wr_cached_rem_sup=
p_cap),
> > +                             true },
> > +     { BT_HCI_CMD_LE_CS_SEC_ENABLE, BT_HCI_BIT_LE_CS_SEC_ENABLE,
> > +                             "LE CS Security Enable",
> > +                             le_cs_sec_enable_cmd,
> > +                             sizeof(struct bt_hci_cmd_le_cs_sec_enable=
),
> > +                             true },
> > +     { BT_HCI_CMD_LE_CS_SET_DEF_SETTINGS,
> > +                             BT_HCI_BIT_LE_CS_SET_DEF_SETTINGS,
> > +                             "LE CS Set Default Settings",
> > +                             le_cs_set_def_settings_cmd,
> > +                             sizeof(
> > +                             struct bt_hci_cmd_le_cs_set_def_settings)=
,
> > +                             true,
> > +                             le_cs_set_def_settings_rsp,
> > +                             sizeof(
> > +                             struct bt_hci_rsp_le_cs_set_def_settings)=
,
> > +                             true },
> > +     { BT_HCI_CMD_LE_CS_RD_REM_FAE, BT_HCI_BIT_LE_CS_RD_REM_FAE,
> > +                             "LE CS Read Remote FAE Table",
> > +                             le_cs_rd_rem_fae_cmd,
> > +                             sizeof(struct bt_hci_cmd_le_cs_rd_rem_fae=
),
> > +                             true },
> > +     { BT_HCI_CMD_LE_CS_WR_CACHED_REM_FAE,
> > +                             BT_HCI_BIT_LE_CS_WR_CACHED_REM_FAE,
> > +                             "LE CS Write Cached Remote FAE Table",
> > +                             le_cs_wr_cached_rem_fae_cmd,
> > +                             sizeof(
> > +                             struct bt_hci_cmd_le_cs_wr_cached_rem_fae=
),
> > +                             true,
> > +                             le_cs_wr_cached_rem_fae_rsp,
> > +                             sizeof(
> > +                             struct bt_hci_rsp_le_cs_wr_cached_rem_fae=
),
> > +                             true },
> > +     { BT_HCI_CMD_LE_CS_CREATE_CONFIG, BT_HCI_BIT_LE_CS_CREATE_CONFIG,
> > +                             "LE CS Create Config",
> > +                             le_cs_create_config_cmd,
> > +                             sizeof(struct bt_hci_cmd_le_cs_create_con=
fig),
> > +                             true },
> > +     { BT_HCI_CMD_LE_CS_REMOVE_CONFIG, BT_HCI_BIT_LE_CS_REMOVE_CONFIG,
> > +                             "LE CS Remove Config",
> > +                             le_cs_remove_config_cmd,
> > +                             sizeof(struct bt_hci_cmd_le_cs_remove_con=
fig),
> > +                             true },
> > +     { BT_HCI_CMD_LE_CS_SET_CHAN_CLASS, BT_HCI_BIT_LE_CS_SET_CHAN_CLAS=
S,
> > +                             "LE CS Set Channel Classification",
> > +                             le_cs_set_chan_class_cmd,
> > +                             sizeof(struct bt_hci_cmd_le_cs_set_chan_c=
lass),
> > +                             true,
> > +                             le_cs_set_chan_class_rsp,
> > +                             sizeof(struct bt_hci_rsp_le_cs_set_chan_c=
lass),
> > +                             true},
> > +     { BT_HCI_CMD_LE_CS_SET_PROC_PARAMS,
> > +                             BT_HCI_BIT_LE_CS_SET_PROC_PARAMS,
> > +                             "LE CS Set Procedure Parameters",
> > +                             le_cs_set_proc_params_cmd,
> > +                             sizeof(struct bt_hci_cmd_le_cs_set_proc_p=
arams),
> > +                             true,
> > +                             le_cs_set_proc_params_rsp,
> > +                             sizeof(struct bt_hci_rsp_le_cs_set_proc_p=
arams),
> > +                             true },
> > +     { BT_HCI_CMD_LE_CS_PROC_ENABLE, BT_HCI_BIT_LE_CS_PROC_ENABLE,
> > +                             "LE CS Procedure Enable",
> > +                             le_cs_proc_enable_cmd,
> > +                             sizeof(struct bt_hci_cmd_le_cs_proc_enabl=
e),
> > +                             true },
> > +     { BT_HCI_CMD_LE_CS_TEST, BT_HCI_BIT_LE_CS_TEST,
> > +                             "LE CS Test", le_cs_test_cmd,
> > +                             sizeof(struct bt_hci_cmd_le_cs_test),
> > +                             false,
> > +                             le_cs_test_rsp,
> > +                             sizeof(struct bt_hci_rsp_le_cs_test),
> > +                             true},
> > +     { BT_HCI_CMD_LE_CS_TEST_END, BT_HCI_BIT_LE_CS_TEST_END,
> > +                             "LE CS Test End" },
> >       { BT_HCI_CMD_LE_FSU, BT_HCI_BIT_LE_FSU,
> >                               "LE Frame Space Update", le_fsu_cmd,
> >                               sizeof(struct bt_hci_cmd_le_fsu),
> > @@ -11898,6 +12460,611 @@ static void le_big_info_evt(struct timeval *t=
v, uint16_t index,
> >       print_field("Encryption: 0x%02x", evt->encryption);
> >   }
> >
> > +static void le_cs_rd_rem_supp_cap_complete_evt(struct timeval *tv,
> > +                             uint16_t index, const void *data, uint8_t=
 size)
> > +{
> > +     const struct bt_hci_evt_le_cs_rd_rem_supp_cap_complete *evt =3D d=
ata;
> > +     uint16_t mask;
> > +
> > +     print_status(evt->status);
> > +     print_field("Connection Handle: %d", le16_to_cpu(evt->handle));
> > +     print_field("Num Config Supported: %d", evt->num_config_supported=
);
> > +     print_field("Max Consecutive Procedures Supported: %d",
> > +             le16_to_cpu(evt->max_consecutive_procedures_supported));
> > +     print_field("Num Antennas Supported: %d", evt->num_antennas_suppo=
rted);
> > +     print_field("Max Antenna Paths Supported: %d",
> > +             evt->max_antenna_paths_supported);
> > +
> > +     print_field("Roles Supported: 0x%2.2x", evt->roles_supported);
> > +     mask =3D print_bitfield(2, evt->roles_supported, cs_roles_supp_ta=
ble);
> > +     if (mask)
> > +             print_text(COLOR_UNKNOWN_FEATURE_BIT,
> > +             "  Unknown Role (0x%2.2x)", mask);
> > +
> > +     print_field("Modes Supported: 0x%2.2x", evt->modes_supported);
> > +     print_field("RTT Capability: 0x%2.2x", evt->rtt_capability);
> > +     print_field("RTT AA Only N: %d", evt->rtt_aa_only_n);
> > +     print_field("RTT Sounding N: %d", evt->rtt_sounding_n);
> > +     print_field("RTT Random Sequence N: %d", evt->rtt_random_payload_=
n);
> > +     print_field("NADM Sounding Capability: 0x%2.2x",
> > +             le16_to_cpu(evt->nadm_sounding_capability));
> > +     print_field("NADM Random Capability: 0x%2.2x",
> > +             le16_to_cpu(evt->nadm_random_capability));
> > +
> > +     print_field("CS_SYNC PHYs Supported: 0x%2.2x",
> > +             evt->cs_sync_phys_supported);
> > +     mask =3D print_bitfield(2, evt->cs_sync_phys_supported,
> > +             cs_sync_phys_supp_table);
> > +     if (mask)
> > +             print_text(COLOR_UNKNOWN_PHY, "  Unknown PHYs (0x%2.2x)",=
 mask);
> > +
> > +     print_field("Subfeatures Supported: 0x%4.4x",
> > +             le16_to_cpu(evt->subfeatures_supported));
> > +     mask =3D print_bitfield(2, le16_to_cpu(evt->subfeatures_supported=
),
> > +             cs_subfeatures_supp_table);
> > +     if (mask)
> > +             print_text(COLOR_UNKNOWN_FEATURE_BIT, "  Unknown subfeatu=
res"
> > +                     " (0x%4.4x)", mask);
> > +
> > +     print_field("T_IP1 Times Supported: 0x%4.4x",
> > +             le16_to_cpu(evt->t_ip1_times_supported));
> > +     mask =3D print_bitfield(2, le16_to_cpu(evt->t_ip1_times_supported=
),
> > +             cs_t_ip1_times_supp_table);
> > +     if (mask)
> > +             print_text(COLOR_UNKNOWN_FEATURE_BIT, "  Unknown T_IP1 Ti=
mes"
> > +                     " (0x%4.4x)", mask);
> > +
> > +     print_field("T_IP2 Times Supported: 0x%4.4x",
> > +             le16_to_cpu(evt->t_ip2_times_supported));
> > +     mask =3D print_bitfield(2, le16_to_cpu(evt->t_ip2_times_supported=
),
> > +             cs_t_ip2_times_supp_table);
> > +     if (mask)
> > +             print_text(COLOR_UNKNOWN_FEATURE_BIT, "  Unknown T_IP2 Ti=
mes"
> > +                     " (0x%4.4x)", mask);
> > +
> > +     print_field("T_FCS Times Supported: 0x%4.4x",
> > +             le16_to_cpu(evt->t_fcs_times_supported));
> > +     mask =3D print_bitfield(2, le16_to_cpu(evt->t_fcs_times_supported=
),
> > +             cs_t_fcs_times_supp_table);
> > +     if (mask)
> > +             print_text(COLOR_UNKNOWN_FEATURE_BIT, "  Unknown T_FCS Ti=
mes"
> > +                     " (0x%4.4x)", mask);
> > +
> > +     print_field("T_PM Times Supported: 0x%4.4x",
> > +             le16_to_cpu(evt->t_pm_times_supported));
> > +     mask =3D print_bitfield(2, le16_to_cpu(evt->t_pm_times_supported)=
,
> > +             cs_t_pm_times_supp_table);
> > +     if (mask)
> > +             print_text(COLOR_UNKNOWN_FEATURE_BIT, "  Unknown T_PM Tim=
es"
> > +                     " (0x%4.4x)", mask);
> > +
> > +     print_field("T_SW Time Supported: 0x%2.2x", evt->t_sw_time_suppor=
ted);
> > +
> > +     print_field("TX_SNR Capability: 0x%2.2x", evt->tx_snr_capability)=
;
> > +     mask =3D print_bitfield(2, evt->tx_snr_capability,
> > +             cs_tx_snr_capability_table);
> > +     if (mask)
> > +             print_text(COLOR_UNKNOWN_FEATURE_BIT,
> > +                     "  Unknown TX_SNR Capability (0x%2.2x)", mask);
> > +}
> > +
> > +static void le_cs_rd_rem_fae_complete_evt(struct timeval *tv, uint16_t=
 index,
> > +                                     const void *data, uint8_t size)
> > +{
> > +     const struct bt_hci_evt_le_cs_rd_rem_fae_complete *evt =3D data;
> > +
> > +     print_status(evt->status);
> > +     print_field("Connection handle: %d", le16_to_cpu(evt->handle));
> > +     print_hex_field("Remote FAE Table: ", evt->remote_fae_table,
> > +             sizeof(evt->remote_fae_table));
> > +}
> > +
> > +static void le_cs_sec_enable_complete_evt(struct timeval *tv, uint16_t=
 index,
> > +                                     const void *data, uint8_t size)
> > +{
> > +     const struct bt_hci_evt_le_cs_sec_enable_complete *evt =3D data;
> > +
> > +     print_status(evt->status);
> > +     print_field("Connection handle: %d", le16_to_cpu(evt->handle));
> > +}
> > +
> > +static void print_cs_role(uint8_t role)
> > +{
> > +     const char *str;
> > +
> > +     switch (role) {
> > +     case 0x00:
> > +             str =3D "Initiator";
> > +             break;
> > +     case 0x01:
> > +             str =3D "Reflector";
> > +             break;
> > +     default:
> > +             str =3D "Reserved";
> > +             break;
> > +     }
> > +
> > +     print_field("Role: %s (0x%2.2x)", str, role);
> > +}
> > +
> > +static void le_cs_config_complete_evt(struct timeval *tv, uint16_t ind=
ex,
> > +                                     const void *data, uint8_t size)
> > +{
> > +     const struct bt_hci_evt_le_cs_config_complete *evt =3D data;
> > +
> > +     print_status(evt->status);
> > +     print_field("Connection handle: %d", le16_to_cpu(evt->handle));
> > +     print_field("Config ID: %d", evt->config_id);
> > +     print_field("Action: %d", evt->action);
> > +     print_field("Main Mode Type: %d", evt->main_mode_type);
> > +     print_field("Sub Mode Type: %d", evt->sub_mode_type);
> > +     print_field("Min Main Mode Steps: %d", evt->min_main_mode_steps);
> > +     print_field("Max Main Mode Steps: %d", evt->max_main_mode_steps);
> > +     print_field("Main Mode Repetition: %d", evt->main_mode_repetition=
);
> > +     print_field("Mode 0 Steps: %d", evt->mode_0_steps);
> > +     print_cs_role(evt->role);
> > +     print_field("RTT Type: %d", evt->rtt_type);
> > +     print_field("CS_SYNC PHY: %d", evt->cs_sync_phy);
> > +     print_hex_field("Channel Map: ", evt->channel_map,
> > +             sizeof(evt->channel_map));
> > +     print_field("Channel Map Repetition: %d", evt->channel_map_repeti=
tion);
> > +     print_field("Channel Selection Type: %d", evt->channel_selection_=
type);
> > +     print_field("Ch3c Shape: %d", evt->ch3c_shape);
> > +     print_field("Ch3c Jump: %d", evt->ch3c_jump);
> > +     print_field("Reserved: %d", evt->reserved);
> > +     print_field("T_IP1 Time: %d", evt->t_ip1_time);
> > +     print_field("T_IP2 Time: %d", evt->t_ip2_time);
> > +     print_field("T_FCS Time: %d", evt->t_fcs_time);
> > +     print_field("T_PM Tim: %d", evt->t_pm_time);
> > +}
> > +
> > +static void le_cs_proc_enable_complete_evt(struct timeval *tv, uint16_=
t index,
> > +                                     const void *data, uint8_t size)
> > +{
> > +     const struct bt_hci_evt_le_cs_proc_enable_complete *evt =3D data;
> > +
> > +     print_status(evt->status);
> > +     print_field("Connection handle: %d", le16_to_cpu(evt->handle));
> > +     print_field("Config ID: %d", evt->config_id);
> > +     print_field("State: %d", evt->state);
> > +     print_field("Tone Antenna Config Selection: %d",
> > +             evt->tone_antenna_config_selection);
> > +     print_field("Selected TX Power: %d", evt->selected_tx_power);
> > +     print_field("Subevent Len: %d", get_le24(evt->subevent_len));
> > +     print_field("Subevents Per Event: %d", evt->subevents_per_event);
> > +     print_field("Subevent Interval: %d",
> > +             le16_to_cpu(evt->subevent_interval));
> > +     print_field("Event Interval: %d", le16_to_cpu(evt->event_interval=
));
> > +     print_field("Procedure Interval: %d",
> > +             le16_to_cpu(evt->procedure_interval));
> > +     print_field("Procedure Count: %d", le16_to_cpu(evt->procedure_cou=
nt));
> > +     print_field("Max Procedure Len: %d",
> > +             le16_to_cpu(evt->max_procedure_len));
> > +}
> > +
> > +static void print_cs_packet_quality(uint8_t packet_quality)
> > +{
> > +     const char *str;
> > +
> > +     print_field("  Packet Quality: 0x%2.2x", packet_quality);
> > +
> > +     switch (packet_quality & 0xF) {
> > +     case 0x00:
> > +             str =3D "CS Access Address check is successful, and all b=
its"
> > +                     " match the expected sequence";
> > +             break;
> > +     case 0x01:
> > +             str =3D "CS Access Address check contains one or more bit=
 errors";
> > +             break;
> > +     case 0x02:
> > +             str =3D "CS Access Address not found";
> > +             break;
> > +     default:
> > +             str =3D "Reserved";
> > +             break;
> > +     }
> > +
> > +     print_field("    %s", str);
> > +     print_field("    Bit errors: %d", (packet_quality & 0xF0) >> 4);
> > +}
> > +
> > +static void print_cs_packet_nadm(uint8_t packet_nadm)
> > +{
> > +     const char *str;
> > +
> > +     switch (packet_nadm) {
> > +     case 0x00:
> > +             str =3D "Attack is extremely unlikely";
> > +             break;
> > +     case 0x01:
> > +             str =3D "Attack is very unlikely";
> > +             break;
> > +     case 0x02:
> > +             str =3D "Attack is unlikely";
> > +             break;
> > +     case 0x03:
> > +             str =3D "Attack is possible";
> > +             break;
> > +     case 0x04:
> > +             str =3D "Attack is likely";
> > +             break;
> > +     case 0x05:
> > +             str =3D "Attack is very likely";
> > +             break;
> > +     case 0x06:
> > +             str =3D "Attack is extremely likely";
> > +             break;
> > +     case 0xFF:
> > +             str =3D "Unknown NADM";
> > +             break;
> > +     default:
> > +             str =3D "Reserved";
> > +             break;
> > +     }
> > +
> > +     print_field("  Packet NADM: %s (0x%2.2x)", str, packet_nadm);
> > +}
> > +
> > +static void print_cs_sync_pct(uint32_t pct, uint8_t id)
> > +{
> > +     print_field("  Packet PCT%d: 0x%6.6x", id, pct);
> > +     print_field("    I: 0x%3.3x", pct & 0xFFF);
> > +     print_field("    Q: 0x%3.3x", (pct >> 12) & 0xFFF);
> > +}
> > +
> > +static void print_cs_tone_quality_indicator(uint8_t ind)
> > +{
> > +     const char *str;
> > +     uint8_t quality =3D ind & 0xF;
> > +     uint8_t ext_slot =3D (ind >> 4) & 0xF;
> > +
> > +     print_field("    Tone quality indicator: 0x%2.2x", ind);
> > +
> > +     switch (quality) {
> > +     case 0x00:
> > +             str =3D "Tone quality is high";
> > +             break;
> > +     case 0x01:
> > +             str =3D "Tone quality is medium";
> > +             break;
> > +     case 0x02:
> > +             str =3D "Tone quality is low";
> > +             break;
> > +     case 0x03:
> > +             str =3D "Tone quality indication is not available";
> > +             break;
> > +     default:
> > +             str =3D "Reserved";
> > +             break;
> > +     }
> > +
> > +     print_field("      %s (0x%2.2x)", str, quality);
> > +
> > +     switch (ext_slot) {
> > +     case 0x00:
> > +             str =3D "Not tone extension slot";
> > +             break;
> > +     case 0x01:
> > +             str =3D "Tone extension slot; tone not expected to be pre=
sent";
> > +             break;
> > +     case 0x02:
> > +             str =3D "Tone extension slot; tone expected to be present=
";
> > +             break;
> > +     default:
> > +             str =3D "Reserved";
> > +             break;
> > +     }
> > +
> > +     print_field("      %s (0x%2.2x)", str, ext_slot);
> > +}
> > +
> > +static int print_cs_mode0_result(const uint8_t *data, uint8_t size)
> > +{
> > +     if (size < 3)
> > +             return 1;
> > +
> > +     print_cs_packet_quality(data[0]);
> > +     print_field("  Packet RSSI: %d", (int8_t)data[1]);
> > +     print_field("  Packet Antenna: %d", data[2]);
> > +
> > +     if (size =3D=3D 5) {
> > +             print_field("  Measured Freq Offset: 0x%4.4x",
> > +                                     get_le16(data + 3) & 0x7FFF);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int print_cs_mode1_result(const uint8_t *data, uint8_t size)
> > +{
> > +     uint16_t tod_toa;
> > +
> > +     if (size < 6)
> > +             return 1;
> > +
> > +     print_cs_packet_quality(data[0]);
> > +     print_cs_packet_nadm(data[1]);
> > +     print_field("  Packet RSSI: %d", (int8_t)data[2]);
> > +
> > +     tod_toa =3D get_le16(data + 3);
> > +     if (tod_toa =3D=3D 0x8000)
> > +             print_field("  ToA_ToD: Time difference is not available"=
);
> > +     else
> > +             print_field("  ToA_ToD: 0x%4.4x", (int16_t)tod_toa);
> > +
> > +     print_field("  Packet Antenna: %d", data[5]);
> > +
> > +     if (size <=3D 14)
> > +             return 0;
> > +
> > +     print_cs_sync_pct(get_le32(data + 6), 1);
> > +     print_cs_sync_pct(get_le32(data + 10), 2);
> > +
> > +     return 0;
> > +}
> > +
> > +static int print_cs_mode2_result(const uint8_t *data, uint8_t size)
> > +{
> > +     const uint8_t *pct_ptr;
> > +     uint32_t pct;
> > +     uint8_t antenna_paths;
> > +     uint8_t i;
> > +
> > +     if (size < 5)
> > +             return 1;
> > +
> > +     print_field("  Antenna Permutation Index: %d", data[0]);
> > +
> > +     antenna_paths =3D (size - 1) / 4;
> > +     pct_ptr =3D data + 1;
> > +
> > +     for (i =3D 0; i < antenna_paths; ++i) {
> > +             pct =3D get_le24(pct_ptr);
> > +             print_field("  Path %d", i);
> > +             print_field("    PCT: 0x%6.6x", pct);
> > +             print_field("      I: 0x%3.3x", pct & 0xFFF);
> > +             print_field("      Q: 0x%3.3x", (pct >> 12) & 0xFFF);
> > +             pct_ptr +=3D 3;
> > +             print_cs_tone_quality_indicator(*pct_ptr);
> > +             pct_ptr +=3D 1;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int print_cs_mode3_result(const uint8_t *data, uint8_t size)
> > +{
> > +     uint16_t tod_toa;
> > +
> > +     if (size < 6)
> > +             return 1;
> > +
> > +     print_cs_packet_quality(data[0]);
> > +     print_cs_packet_nadm(data[1]);
> > +     print_field("  Packet RSSI: %d", (int8_t)data[2]);
> > +
> > +     tod_toa =3D get_le16(data + 3);
> > +     if (tod_toa =3D=3D 0x8000) {
> > +             print_field("  ToA_ToD: Time difference is not available =
"
> > +                     "(0x%4.4x)", tod_toa);
> > +     } else {
> > +             print_field("  ToA_ToD: %d (0x%4.4x)", tod_toa,
> > +                     (int16_t)tod_toa);
> > +     }
> > +
> > +     print_field("  Packet Antenna: %d", data[5]);
> > +
> > +     /* To parse the remaining data for mode3 results we would need
> > +      * to capture and cache the exchanged CS configuration.
> > +      */
> > +
> > +     return 0;
> > +}
> > +
> > +static void print_cs_steps(const uint8_t *data, uint8_t size)
> > +{
> > +     int rc =3D 1;
> > +     const uint8_t *ptr =3D data;
> > +     uint8_t data_len;
> > +     uint8_t mode;
> > +     uint8_t channel;
> > +     uint8_t i =3D 0;
> > +
> > +     while (size > 3) {
> > +             mode =3D ptr[0];
> > +             channel =3D ptr[1];
> > +             data_len =3D ptr[2];
> > +             ptr +=3D 3;
> > +             size -=3D 3;
> > +             if (size < data_len)
> > +                     break;
> > +
> > +             print_field("Step %d", i++);
> > +             print_field("  Mode: %d", mode);
> > +             print_field("  Channel: %d", channel);
> > +             print_field("  Step data len: %d", data_len);
> > +             print_hex_field("  Raw step data: ", ptr, data_len);
> > +
> > +             if (data_len =3D=3D 0)
> > +                     continue;
> > +
> > +             switch (mode) {
> > +             case 0x00:
> > +                     rc =3D print_cs_mode0_result(ptr, data_len);
> > +                     break;
> > +             case 0x01:
> > +                     rc =3D print_cs_mode1_result(ptr, data_len);
> > +                     break;
> > +             case 0x02:
> > +                     rc =3D print_cs_mode2_result(ptr, data_len);
> > +                     break;
> > +             case 0x03:
> > +                     rc =3D print_cs_mode3_result(ptr, data_len);
> > +                     break;
> > +             default:
> > +                     rc =3D 1;
> > +             }
> > +
> > +             if (rc)
> > +                     break;
> > +
> > +             size -=3D data_len;
> > +             ptr +=3D data_len;
> > +     }
> > +}
> > +
> > +static void print_cs_procedure_done_status(uint8_t status)
> > +{
> > +     const char *str;
> > +
> > +     switch (status) {
> > +     case 0x00:
> > +             str =3D "All results complete for the CS procedure";
> > +             break;
> > +     case 0x01:
> > +             str =3D "Partial results with more to follow for the CS "
> > +                     "procedure";
> > +             break;
> > +     case 0x0F:
> > +             str =3D "All subsequent CS procedures aborted";
> > +             break;
> > +     default:
> > +             str =3D "Reserved";
> > +             break;
> > +     }
> > +
> > +     print_field("Procedure Done Status: %s (0x%2.2x)", str, status);
> > +}
> > +
> > +static void print_cs_subevent_done_status(uint8_t status)
> > +{
> > +     const char *str;
> > +
> > +     switch (status) {
> > +     case 0x00:
> > +             str =3D "All results complete for the CS subevent";
> > +             break;
> > +     case 0x01:
> > +             str =3D "Partial results with more to follow for the CS s=
ubevent";
> > +             break;
> > +     case 0x0F:
> > +             str =3D "Current CS subevent aborted";
> > +             break;
> > +     default:
> > +             str =3D "Reserved";
> > +             break;
> > +     }
> > +
> > +     print_field("Subevent Done Status: %s (0x%2.2x)", str, status);
> > +}
> > +
> > +static void print_cs_abort_reason(uint8_t reason)
> > +{
> > +     const char *str;
> > +
> > +     print_field("Abort reason: 0x%2.2x", reason);
> > +
> > +     switch (reason & 0xF) {
> > +     case 0x00:
> > +             str =3D "Report with no abort";
> > +             break;
> > +     case 0x01:
> > +             str =3D "Abort because of local Host or remote request";
> > +             break;
> > +     case 0x02:
> > +             str =3D "Abort because filtered channel map has less than=
 15 "
> > +                   "channels";
> > +             break;
> > +     case 0x03:
> > +             str =3D "Abort because the channel map update instant has=
 passed";
> > +             break;
> > +     case 0x0F:
> > +             str =3D "Abort because of unspecified reasons";
> > +             break;
> > +     default:
> > +             str =3D "Reserved";
> > +             break;
> > +     }
> > +
> > +     print_field("  Procedure: %s (0x%2.2x)", str, reason & 0xF);
> > +
> > +     switch ((reason & 0xF0) >> 4) {
> > +     case 0x00:
> > +             str =3D "Report with no abort";
> > +             break;
> > +     case 0x01:
> > +             str =3D "Abort because of local Host or remote request";
> > +             break;
> > +     case 0x02:
> > +             str =3D "Abort because no CS_SYNC (mode-0) received";
> > +             break;
> > +     case 0x03:
> > +             str =3D "Abort because of scheduling conflicts or limited=
 "
> > +                   "resources";
> > +             break;
> > +     case 0x0F:
> > +             str =3D "Abort because of unspecified reasons";
> > +             break;
> > +     default:
> > +             str =3D "Reserved";
> > +             break;
> > +     }
> > +
> > +     print_field("  Subevent: %s (0x%2.2x)", str, (reason & 0xF0) >> 4=
);
> > +}
> > +
> > +static void le_cs_subevent_result_evt(struct timeval *tv, uint16_t ind=
ex,
> > +                                     const void *data, uint8_t size)
> > +{
> > +     const struct bt_hci_evt_le_cs_subevent_result *evt =3D data;
> > +     uint8_t head_size =3D sizeof(struct bt_hci_evt_le_cs_subevent_res=
ult);
> > +
> > +     print_field("Connection handle: %d", le16_to_cpu(evt->handle));
> > +     print_field("Config ID: %d", evt->config_id);
> > +     print_field("Start ACL Conn Event Counter: %d",
> > +             le16_to_cpu(evt->start_acl_conn_event_counter));
> > +     print_field("Procedure Counter: %d",
> > +             le16_to_cpu(evt->procedure_counter));
> > +     print_field("Frequency Compensation: %d",
> > +             le16_to_cpu(evt->frequency_compensation));
> > +     print_field("Reference Power Level: %d", evt->reference_power_lev=
el);
> > +     print_cs_procedure_done_status(evt->procedure_done_status);
> > +     print_cs_subevent_done_status(evt->subevent_done_status);
> > +     print_cs_abort_reason(evt->abort_reason);
> > +     print_field("Num Antenna Paths: %d", evt->num_antenna_paths);
> > +     print_field("Num Steps Reported: %d", evt->num_steps_reported);
> > +     print_hex_field("Steps data: ",
> > +             (const uint8_t *)evt->steps + head_size, size - head_size=
);
> > +     print_cs_steps(evt->steps, size - head_size);
> > +}
> > +
> > +static void le_cs_subevent_result_continue_evt(struct timeval *tv,
> > +                             uint16_t index, const void *data, uint8_t=
 size)
> > +{
> > +     const struct bt_hci_evt_le_cs_subevent_result_continue *evt =3D d=
ata;
> > +     uint8_t head_size =3D sizeof(
> > +             struct bt_hci_evt_le_cs_subevent_result_continue);
> > +
> > +     print_field("Connection handle: %d", le16_to_cpu(evt->handle));
> > +     print_field("Config ID: %d", evt->config_id);
> > +     print_cs_procedure_done_status(evt->procedure_done_status);
> > +     print_cs_subevent_done_status(evt->subevent_done_status);
> > +     print_cs_abort_reason(evt->abort_reason);
> > +     print_field("Num Antenna Paths: %d", evt->num_antenna_paths);
> > +     print_field("Num Steps Reported: %d", evt->num_steps_reported);
> > +     print_hex_field("Steps data: ",
> > +             (const uint8_t *)evt->steps + head_size, size - head_size=
);
> > +     print_cs_steps(evt->steps, size - head_size);
> > +}
> > +
> > +static void le_cs_test_end_complete_evt(struct timeval *tv, uint16_t i=
ndex,
> > +                                     const void *data, uint8_t size)
> > +{
> > +     const struct bt_hci_evt_le_cs_test_end_complete *evt =3D data;
> > +
> > +     print_status(evt->status);
> > +}
> > +
> >   static void print_fsu_initiator(uint8_t initiator)
> >   {
> >       const char *str;
> > @@ -12059,6 +13226,39 @@ static const struct subevent_data le_meta_even=
t_table[] =3D {
> >               "LE Broadcast Isochronous Group Info Advertising Report",
> >               le_big_info_evt,
> >               sizeof(struct bt_hci_evt_le_big_info_adv_report) },
> > +     { BT_HCI_EVT_LE_CS_RD_REM_SUPP_CAP_COMPLETE,
> > +             "LE CS Read Remote Supported Capabilities Complete",
> > +             le_cs_rd_rem_supp_cap_complete_evt,
> > +             sizeof(struct bt_hci_evt_le_cs_rd_rem_supp_cap_complete),=
 true},
> > +     { BT_HCI_EVT_LE_CS_RD_REM_FAE_COMPLETE,
> > +             "LE CS Read Remote FAE Table Complete",
> > +             le_cs_rd_rem_fae_complete_evt,
> > +             sizeof(struct bt_hci_evt_le_cs_rd_rem_fae_complete), true=
 },
> > +     { BT_HCI_EVT_LE_CS_SEC_ENABLE_COMPLETE,
> > +             "LE CS Security Enable Complete",
> > +             le_cs_sec_enable_complete_evt,
> > +             sizeof(struct bt_hci_evt_le_cs_sec_enable_complete), true=
 },
> > +     { BT_HCI_EVT_LE_CS_CONFIG_COMPLETE,
> > +             "LE CS Config Complete",
> > +             le_cs_config_complete_evt,
> > +             sizeof(struct bt_hci_evt_le_cs_config_complete), true },
> > +     { BT_HCI_EVT_LE_CS_PROC_ENABLE_COMPLETE,
> > +             "LE CS Procedure Enable Complete",
> > +             le_cs_proc_enable_complete_evt,
> > +             sizeof(struct bt_hci_evt_le_cs_proc_enable_complete), tru=
e },
> > +     { BT_HCI_EVT_LE_CS_SUBEVENT_RESULT,
> > +             "LE CS Subevent Result",
> > +             le_cs_subevent_result_evt,
> > +             sizeof(struct bt_hci_evt_le_cs_subevent_result), false },
> > +     { BT_HCI_EVT_LE_CS_SUBEVENT_RESULT_CONTINUE,
> > +             "LE CS Subevent Result Continue",
> > +             le_cs_subevent_result_continue_evt,
> > +             sizeof(struct bt_hci_evt_le_cs_subevent_result_continue),
> > +             false },
> > +     { BT_HCI_EVT_LE_CS_TEST_END_COMPLETE,
> > +             "LE CS Test End Complete",
> > +             le_cs_test_end_complete_evt,
> > +             sizeof(struct bt_hci_evt_le_cs_test_end_complete), true }=
,
> >       { BT_HCI_EVT_LE_FSU_COMPLETE,
> >               "LE Frame Space Update Complete",
> >               le_fsu_evt, sizeof(struct bt_hci_evt_le_fsu_complete) },
>
