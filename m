Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AED321457
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 19:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777405450; cv=pass; b=bod+4ivzqxBxgnx+3s+h73iM5qR/TcWwr64IwGP5ndsKkW9JnLlGMAZd5vIbFbMSvI3BFUchDavgMje08gPuqF6ZYjUPaYxcemOzmEU+6i/nt/2wz/gFiXMO19S62g3A+HVjp7mxMNHWebrDaw0/SGYuJPljy1KDZ2GhKLFPBMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777405450; c=relaxed/simple;
	bh=HE32cmc/+hKtRc0jArFklO3gq7prufq80OUy1itWiow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Em1dxUkmBHlCCwYw5J+cGsWC2h2bPi23b+D8yMzL+Mr5iamUkzTFG+rWhFKmefStKWFYRFoImjkAEnnYUKBU3Y58ZK3a3JJV37rsHYyP32yIqZFiHYXFJEgUTtI5dfHSREeoW4VPRK0EDPT48VxbTSSo4xz9c20r8SymEfKTxx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVJG1qJJ; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVJG1qJJ"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64e87a81639so10824428d50.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 12:44:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777405447; cv=none;
        d=google.com; s=arc-20240605;
        b=PI7/TS7IlgeVzbin2E11rPQC7XsfpQtqI7i4q2SJSlwMu50a7cQAPy/UpjsxPxf1/Y
         UJMrAkzGwrfQdx2ZpfIVGT6LNzEoDVZxf4F9R3bDOBkFbSwsZg+9R8FJ5qfiFnmYRjhw
         hhIpAg7e3ru1jeZMfMhJbE+UJd1u+Hcxo+r21NRpJtty39y5VY8r3aiH7MULsAwbNWEw
         Pr/0oZSXn+ksVHuOWjKewVGxcGFo3eKSN8h+BuW6AxdbWHhxheDrLArHhtyY9AxF1cyl
         l/CokJrbk/x5ipEfL1bUhPc/D+haYiGJa7PKVsph4FuU3fmlpae0OC2tCjJxEYCQpPH2
         6Kuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/FOg2wIIZw3Ozi8sBRdKyinr8iucZy591uRb7b5/GNk=;
        fh=jBLUrRQ7ZsNUcAcd5QG5N83k8jhBNkoqDFBeOlOjxqk=;
        b=PBdeUjh1IFidCvC1TXo5PtPerw5bKzpglFM94yznH2vcGzOItEPOOlL7apAc9hiM9r
         3+wG3ozYiYwLr9l5zjfVUuhZ3uDgjVpxjfpw76E+yCYMdhB7PdbO5E74HuW7+3FNMYyC
         /Fy2GEITcnq3YFnqzDTW+SjQrQDzy21zJbBH4zYDiHcnMCLXxRo0EdzeK98158I8Yfrn
         P964IgYapEdag7U0bSSHrdXTaWfOKR4cSFGqro5JmtoYBC1iGf83gXDVgp+t2eTwzmqJ
         lh0TduHQn18tG5iYG34f4tzguUz83FgRFN/qNX++dKsM+gXxMDVR9IdVnrEWgrPzy1Fe
         Wvwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777405447; x=1778010247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/FOg2wIIZw3Ozi8sBRdKyinr8iucZy591uRb7b5/GNk=;
        b=VVJG1qJJ0xEsD8icyEb8RUypfXn6rzRiL7/eDRKqbuFKizfuetXh2jNYvzjwzv4/am
         odjfLNvPNygJiLRas4He3YKRvlpYN5qFDBoAwVq7sGnYcBAkzOhcn4hevjrc/WKJ6QZY
         GEpxJ37k6fB2dfi8+7w5XXPByiZkIc8MJrihFw2y5HusoV0+Auk7MUU8X637bxZQcNh2
         /1JtjuHpQIJAnm/jcjr62qZ5kUEAppFWfS30E6a79rkhWqI1HkDFafhZKw/AKzG2coVZ
         /41Fbt/Aj17qaNg9Z0gDol3VgXbvH2OBimdCJHjPkxOVNIi0yryiJ8TB/7YGj+2A92Qv
         RG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777405447; x=1778010247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/FOg2wIIZw3Ozi8sBRdKyinr8iucZy591uRb7b5/GNk=;
        b=mJQRMXR4iWRT+9Y5VZ+2aWK1wdHJmago/eZCqelYYXipLKnfPdilzZ+mf5klie4nQN
         zYAZSkp/MNq3Z9J+OiH6nxxiNhxd91Ow57nkUoQQu8T3wtC+8D8I9NUVGcgoGRqECez6
         5YcWnVAIIFz77fbMBPTklwCKQHJ+HA8JZp7Nz6y39QZoC02nG1MjSOaST1k7Fo8eyR3i
         vxt13Aec6JKFIxBg6RZ2qIB8g+Tvc6tJvJ/4WII8ZprOzkMKnmOKg19+E+n8jPadLJ6v
         ZQqPmI2kKApMNDJLb2YxD8fvt2MbpVXYEqtTLM52MbOSbtaQNd6cguGNNd1rtY9kFUfS
         o1xA==
X-Gm-Message-State: AOJu0YxV6XCXAGLOlGeHAEALByJDoJmNRwy8FUHCRKvcvfRavmohn9I+
	8VWh5kpwUc7wTkaqoP+QtgrmCPzyMwYexuwTmfK6pyohmivOx6akyW/NFSj+SVuC4B0/tv4dd/D
	a9KamvPg4H41sLA4xOSog/PtrR27Yj8Q=
X-Gm-Gg: AeBDieukSZRfp/dHtKbuqOHUFmwpFhEkk5igcVbTNV+KTvKwq1fPhJW6aeMKTCPQkl3
	8a3OA0eIZVVOdzPq1MbyFqDNmFe78XnisO/UuhxUNgL0xaroWD77faqtuBS9+A1Sa4IZE7ME8vC
	OJ4/I4P2aUVTA8r/dmRMOxNNEOtuHcm0qrk7d59Dme1h0sCB2qBhwhzQFhOdygrcWBo62Jak9Yf
	mbwHQhRFjDF2SNhw+Pdv+nAFRRyX2rl8xIOPnikyzdmrc6kOcG0cXEaQ/7tmtWG0Y1yluNBe1c5
	aUY+88YnpqlRNy+6FX5V1ZpN9lMRD56ezHfnPSzduURM+lH/n5Jyo7oTP9kkGzQSeKAPHZkQ1sM
	bXoKA
X-Received: by 2002:a05:690e:d55:b0:651:d430:783e with SMTP id
 956f58d0204a3-65bfb62c187mr1075436d50.27.1777405446238; Tue, 28 Apr 2026
 12:44:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428023111.1640377-1-prathm@qti.qualcomm.com> <20260428023111.1640377-2-prathm@qti.qualcomm.com>
In-Reply-To: <20260428023111.1640377-2-prathm@qti.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 28 Apr 2026 15:43:52 -0400
X-Gm-Features: AVHnY4J2jMZli906wYWLr1KWjYYH1rXT6-HvBL6vcIPX9oaAoQakKBr0QZD4rKg
Message-ID: <CABBYNZJo+gZZ8=roFQ=nOnR0nQig5RsM8sWfjkPZuM=kYqEByw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v5 1/3] src/shared: Add RAS packet format and
 notification support
To: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prathibha,

On Mon, Apr 27, 2026 at 10:31=E2=80=AFPM Prathibha Madugonde
<prathibha.madugonde@oss.qualcomm.com> wrote:
>
> From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
>
> Implement complete RAS data pipeline:
>  - Handle HCI CS subevent result/continuation events
>  - Serialize ranging/subevent headers per spec
>  - GATT notifications for real-time ranging data
> ---
>  src/shared/rap.c | 1376 +++++++++++++++++++++++++++++++++++++++++++++-
>  src/shared/rap.h |    4 +-
>  2 files changed, 1366 insertions(+), 14 deletions(-)
>
> diff --git a/src/shared/rap.c b/src/shared/rap.c
> index ac6de04e0..db924b0e9 100644
> --- a/src/shared/rap.c
> +++ b/src/shared/rap.c
> @@ -33,6 +33,170 @@
>  /* Total number of attribute handles reserved for the RAS service */
>  #define RAS_TOTAL_NUM_HANDLES          18
>
> +/* 2(rc+cfg) + 1(tx_pwr) + 1(4 bits antenna_mask, 2 bits reserved,
> + * 2 bits pct_format)
> + */
> +#define RAS_RANGING_HEADER_SIZE 4
> +#define TOTAL_RAS_RANGING_HEADER_SIZE 5
> +#define ATT_OVERHEAD 3 /* 1(opcode) + 2(char handle) */
> +#define RAS_STEP_ABORTED_BIT   0x80/* set step aborted */
> +#define RAS_SUBEVENT_HEADER_SIZE 8
> +
> +enum pct_format {
> +       IQ =3D 0,
> +       PHASE =3D 1,
> +};
> +
> +enum ranging_done_status {
> +       RANGING_DONE_ALL_RESULTS_COMPLETE =3D 0x0,
> +       RANGING_DONE_PARTIAL_RESULTS =3D 0x1,
> +       RANGING_DONE_ABORTED =3D 0xF,
> +};
> +
> +enum subevent_done_status {
> +       SUBEVENT_DONE_ALL_RESULTS_COMPLETE =3D 0x0,
> +       SUBEVENT_DONE_PARTIAL_RESULTS =3D 0x1,
> +       SUBEVENT_DONE_ABORTED =3D 0xF,
> +};
> +
> +enum ranging_abort_reason {
> +       RANGING_ABORT_NO_ABORT =3D 0x0,
> +       RANGING_ABORT_LOCAL_HOST_OR_REMOTE =3D 0x1,
> +       RANGING_ABORT_INSUFFICIENT_FILTERED_CHANNELS =3D 0x2,
> +       RANGING_ABORT_INSTANT_HAS_PASSED =3D 0x3,
> +       RANGING_ABORT_UNSPECIFIED =3D 0xF,
> +};
> +
> +enum subevent_abort_reason {
> +       SUBEVENT_ABORT_NO_ABORT =3D 0x0,
> +       SUBEVENT_ABORT_LOCAL_HOST_OR_REMOTE =3D 0x1,
> +       SUBEVENT_ABORT_NO_CS_SYNC_RECEIVED =3D 0x2,
> +       SUBEVENT_ABORT_SCHEDULING_CONFLICTS_OR_LIMITED_RESOURCES =3D 0x3,
> +       SUBEVENT_ABORT_UNSPECIFIED =3D 0xF,
> +};
> +
> +/* Segmentation header: 1 byte
> + * bit 0: first_segment
> + * bit 1: last_segment
> + * bits 2-7: rolling_segment_counter (6 bits)
> + */
> +struct segmentation_header {
> +       uint8_t first_segment;
> +       uint8_t last_segment;
> +       uint8_t rolling_segment_counter;
> +};
> +
> +/* Macros to pack/unpack segmentation header */
> +#define SEG_HDR_PACK(first, last, counter) \
> +       ((uint8_t)(((first) ? 0x01 : 0x00) | \
> +               ((last) ? 0x02 : 0x00) | \
> +               (((counter) & 0x3F) << 2)))
> +
> +#define SEG_HDR_UNPACK_FIRST(byte)    ((byte) & 0x01)
> +#define SEG_HDR_UNPACK_LAST(byte)     (((byte) >> 1) & 0x01)
> +#define SEG_HDR_UNPACK_COUNTER(byte)  (((byte) >> 2) & 0x3F)
> +
> +/* Ranging header: 4 bytes
> + * 0-1: ranging_counter (12 bits) | configuration_id (4 bits)
> + *      [little-endian]
> + * byte 2: selected_tx_power (signed)
> + * byte 3: antenna_paths_mask (4 bits) | reserved (2 bits) |
> + *         pct_format (2 bits)
> + */
> +struct ranging_header {
> +       uint16_t ranging_counter;
> +       uint8_t configuration_id;
> +       int8_t selected_tx_power;
> +       uint8_t antenna_paths_mask;
> +       uint8_t pct_format;
> +} __packed;
> +
> +/* Macros to pack/unpack ranging header */
> +#define RANGING_HDR_PACK_BYTE0_1(rc, cfg) \
> +       ((uint16_t)(((rc) & 0x0FFF) | (((cfg) & 0x0F) << 12)))
> +
> +#define RANGING_HDR_PACK_BYTE3(ant_mask, pct_fmt) \
> +       ((uint8_t)(((ant_mask) & 0x0F) | (((pct_fmt) & 0x03) << 6)))
> +
> +#define RANGING_HDR_UNPACK_RC(byte0_1) \
> +       ((uint16_t)((byte0_1) & 0x0FFF))
> +
> +#define RANGING_HDR_UNPACK_CFG(byte0_1) \
> +       ((uint8_t)(((byte0_1) >> 12) & 0x0F))
> +
> +#define RANGING_HDR_UNPACK_ANT_MASK(byte3) \
> +       ((uint8_t)((byte3) & 0x0F))
> +
> +#define RANGING_HDR_UNPACK_PCT_FMT(byte3) \
> +       ((uint8_t)(((byte3) >> 6) & 0x03))
> +
> +struct ras_subevent_header {
> +       uint16_t start_acl_conn_event;
> +       uint16_t frequency_compensation;
> +       uint8_t ranging_done_status;
> +       uint8_t subevent_done_status;
> +       uint8_t ranging_abort_reason;
> +       uint8_t subevent_abort_reason;
> +       int8_t reference_power_level;
> +       uint8_t num_steps_reported;
> +};
> +
> +struct ras_subevent {
> +       struct ras_subevent_header subevent_header;
> +       uint8_t subevent_data[];
> +};
> +
> +/* Role maps to Core CS roles (initiator/reflector) */
> +enum cs_role {
> +       CS_ROLE_INITIATOR =3D 0x00,
> +       CS_ROLE_REFLECTOR =3D 0x01,
> +};
> +
> +#define CS_INVALID_CONFIG_ID   0xFF
> +/* Minimal enums (align to controller values if needed) */
> +enum cs_procedure_done_status {
> +       CS_PROC_ALL_RESULTS_COMPLETE =3D 0x00,
> +       CS_PROC_PARTIAL_RESULTS      =3D 0x01,
> +       CS_PROC_ABORTED              =3D 0x02
> +};
> +
> +/* Main cs_procedure_data  */
> +struct cs_procedure_data {
> +       /* Identity and counters */
> +       uint16_t counter;
> +       uint8_t  num_antenna_paths;
> +       /* Flags and status */
> +       enum cs_procedure_done_status local_status;
> +       enum cs_procedure_done_status remote_status;
> +       bool contains_complete_subevent_;
> +       /* RAS aggregation */
> +       struct segmentation_header segmentation_header_;
> +       struct ranging_header      ranging_header_;
> +       struct iovec       ras_raw_data_;        /* raw concatenated */
> +       uint16_t           ras_raw_data_index_;
> +       struct ras_subevent_header  ras_subevent_header_;
> +       struct iovec       ras_subevent_data_;   /* buffer per subevent *=
/
> +       uint8_t            ras_subevent_counter_;
> +       /* Reference power levels */
> +       int8_t initiator_reference_power_level;
> +       int8_t reflector_reference_power_level;
> +       bool ranging_header_prepended_;
> +       bool ras_subevent_header_emitted;
> +};
> +
> +struct cstracker {
> +       enum cs_role        role;                 /* INITIATOR/REFLECTOR =
*/
> +       uint8_t             config_id;            /* CS_INVALID_CONFIG_ID=
 */
> +       uint8_t             selected_tx_power;    /* PROC_ENABLE_COMPLETE=
 */
> +       uint8_t             rtt_type;             /* RTT type */
> +       struct cs_procedure_data *current_proc;
> +       /* Cached header values for CONT events (per-connection state) */
> +       uint16_t last_proc_counter;
> +       uint16_t last_start_acl_conn_evt_counter;
> +       uint16_t last_freq_comp;
> +       int8_t last_ref_pwr_lvl;
> +};
> +
>  /* Ranging Service context */
>  struct ras {
>         struct bt_rap_db *rapdb;
> @@ -43,9 +207,17 @@ struct ras {
>         struct gatt_db_attribute *realtime_chrc;
>         struct gatt_db_attribute *realtime_chrc_ccc;
>         struct gatt_db_attribute *ondemand_chrc;
> +       struct gatt_db_attribute *ondemand_ccc;
>         struct gatt_db_attribute *cp_chrc;
> +       struct gatt_db_attribute *cp_ccc;
>         struct gatt_db_attribute *ready_chrc;
> +       struct gatt_db_attribute *ready_ccc;
>         struct gatt_db_attribute *overwritten_chrc;
> +       struct gatt_db_attribute *overwritten_ccc;
> +
> +       /* CCC state tracking for mutual exclusivity */
> +       uint16_t realtime_ccc_value;
> +       uint16_t ondemand_ccc_value;
>  };
>
>  struct bt_rap_db {
> @@ -70,6 +242,7 @@ struct bt_rap {
>         bt_rap_destroy_func_t debug_destroy;
>         void *debug_data;
>         void *user_data;
> +       struct cstracker *resptracker;
>  };
>
>  static struct queue *rap_db;
> @@ -90,6 +263,209 @@ struct bt_rap_ready {
>         void *data;
>  };
>
> +uint16_t default_ras_mtu =3D 247; /*Section 3.1.2 of RAP 1.0*/
> +uint8_t ras_segment_header_size =3D 1;
> +
> +static struct cs_procedure_data *cs_procedure_data_create(
> +                                       uint16_t procedure_counter,
> +                                       uint8_t num_antenna_paths,
> +                                       uint8_t configuration_id,
> +                                       uint8_t selected_tx_power)
> +{
> +       struct cs_procedure_data *d;
> +       uint8_t i;
> +
> +       d =3D calloc(1, sizeof(struct cs_procedure_data));
> +
> +       if (!d)
> +               return NULL;
> +
> +       d->counter =3D procedure_counter;
> +       d->num_antenna_paths =3D num_antenna_paths;
> +       d->local_status =3D CS_PROC_PARTIAL_RESULTS;
> +       d->remote_status =3D CS_PROC_PARTIAL_RESULTS;
> +       d->contains_complete_subevent_ =3D false;
> +       d->segmentation_header_.first_segment =3D 1;
> +       d->segmentation_header_.last_segment =3D 0;
> +       d->segmentation_header_.rolling_segment_counter =3D 0;
> +       d->ranging_header_.ranging_counter =3D procedure_counter;
> +       d->ranging_header_.configuration_id =3D configuration_id;
> +       d->ranging_header_.selected_tx_power =3D selected_tx_power;
> +       d->ranging_header_.antenna_paths_mask =3D 0;
> +
> +       for (i =3D 0; i < num_antenna_paths; i++)
> +               d->ranging_header_.antenna_paths_mask |=3D (1u << i);
> +
> +       d->ranging_header_.pct_format =3D IQ;
> +       memset(&d->ras_raw_data_, 0, sizeof(d->ras_raw_data_));
> +       d->ras_raw_data_index_ =3D 0;
> +       memset(&d->ras_subevent_data_, 0, sizeof(d->ras_subevent_data_));
> +       d->ras_subevent_counter_ =3D 0;
> +       d->initiator_reference_power_level =3D 0;
> +       d->reflector_reference_power_level =3D 0;
> +       d->ranging_header_prepended_ =3D false;
> +       d->ras_subevent_header_emitted =3D false;
> +
> +       return d;
> +}
> +
> +static void cs_procedure_data_destroy(struct cs_procedure_data *d)
> +{
> +       if (!d)
> +               return;
> +
> +       free(d->ras_raw_data_.iov_base);
> +       free(d->ras_subevent_data_.iov_base);
> +       free(d);
> +}
> +
> +static void cs_pd_set_local_status(struct cs_procedure_data *d,
> +                               enum cs_procedure_done_status s)
> +{
> +       if (d)
> +               d->local_status =3D s;
> +}
> +
> +static void cs_pd_set_remote_status(struct cs_procedure_data *d,
> +                               enum cs_procedure_done_status s)
> +{
> +       if (d)
> +               d->remote_status =3D s;
> +}
> +
> +static void cs_pd_set_reference_power_levels(struct cs_procedure_data *d=
,
> +                                       int8_t init_lvl, int8_t ref_lvl)
> +{
> +       if (!d)
> +               return;
> +
> +       d->initiator_reference_power_level =3D init_lvl;
> +       d->reflector_reference_power_level =3D ref_lvl;
> +}
> +
> +static void cs_pd_ras_begin_subevent(struct cs_procedure_data *d,
> +                               uint16_t start_acl_conn_event,
> +                               uint16_t frequency_compensation,
> +                               int8_t reference_power_level)
> +{
> +       if (!d)
> +               return;
> +
> +       d->ras_subevent_counter_++;
> +       d->ras_subevent_header_.start_acl_conn_event =3D start_acl_conn_e=
vent;
> +       d->ras_subevent_header_.frequency_compensation =3D
> +               frequency_compensation;
> +       d->ras_subevent_header_.reference_power_level =3D reference_power=
_level;
> +       d->ras_subevent_header_.num_steps_reported =3D 0;
> +       d->ras_subevent_header_emitted =3D false;
> +       d->ras_subevent_data_.iov_len =3D 0;
> +}
> +
> +static bool cs_pd_ras_append_subevent_bytes(struct cs_procedure_data *d,
> +                                       const uint8_t *bytes, size_t len)
> +{
> +       if (!d || !bytes || len =3D=3D 0)
> +               return false;
> +
> +       return util_iov_append(&d->ras_subevent_data_, bytes, len) !=3D N=
ULL;
> +}
> +
> +static inline size_t serialize_ras_subevent_header(
> +                               const struct ras_subevent_header *h,
> +                               uint8_t *out, size_t out_len)
> +{
> +       uint16_t start_le;
> +       uint16_t freq_le;
> +
> +       if (!h || !out || out_len < RAS_SUBEVENT_HEADER_SIZE)
> +               return 0;
> +
> +       start_le =3D (uint16_t)h->start_acl_conn_event;
> +       out[0] =3D (uint8_t)(start_le & 0xFF);
> +       out[1] =3D (uint8_t)((start_le >> 8) & 0xFF);

What is the struct we want to produce here? And why aren't we using
acl_handle_pack? Or perhaps

handle =3D cpu_to_le16(acl_handle_pack(handle, flags)); /* if flags
should be carried over otherwise use acl_handle */

> +
> +       freq_le =3D (uint16_t)h->frequency_compensation;
> +       out[2] =3D (uint8_t)(freq_le & 0xFF);
> +       out[3] =3D (uint8_t)((freq_le >> 8) & 0xFF);

cpu_to_le16?

> +
> +       out[4] =3D (uint8_t)((h->ranging_done_status & 0x0F) |
> +                       ((h->subevent_done_status & 0x0F) << 4));

done_status_pack(ranging, subevent);

> +
> +       out[5] =3D (uint8_t)((h->ranging_abort_reason & 0x0F) |
> +                       ((h->subevent_abort_reason & 0x0F) << 4));

abort_reason_pack(ranging, subevent);

> +       out[6] =3D (uint8_t)h->reference_power_level;
> +       out[7] =3D (uint8_t)h->num_steps_reported;

Not sure what is up with casting above?

> +       return RAS_SUBEVENT_HEADER_SIZE;
> +}
> +
> +static bool cs_pd_ras_commit_subevent(struct cs_procedure_data *d,
> +                               uint8_t num_steps_reported,
> +                               uint8_t ranging_done_status,
> +                               uint8_t subevent_done_status,
> +                               uint8_t ranging_abort_reason,
> +                               uint8_t subevent_abort_reason)
> +{
> +       size_t hdr_sz;
> +       size_t payload_sz;
> +       size_t total;
> +       uint8_t *buf;
> +       size_t w;
> +       bool ok;
> +
> +       if (!d)
> +               return false;
> +
> +       d->ras_subevent_header_.num_steps_reported =3D
> +               (uint8_t)(d->ras_subevent_header_.num_steps_reported +
> +                       num_steps_reported);
> +       d->ras_subevent_header_.ranging_done_status =3D ranging_done_stat=
us;
> +       d->ras_subevent_header_.subevent_done_status =3D subevent_done_st=
atus;
> +       d->ras_subevent_header_.ranging_abort_reason =3D ranging_abort_re=
ason;
> +       d->ras_subevent_header_.subevent_abort_reason =3D subevent_abort_=
reason;
> +
> +       if (subevent_done_status =3D=3D SUBEVENT_DONE_ALL_RESULTS_COMPLET=
E)
> +               d->contains_complete_subevent_ =3D true;
> +
> +       if (subevent_done_status =3D=3D SUBEVENT_DONE_PARTIAL_RESULTS)
> +               return true;
> +
> +       if (!d->ras_subevent_header_emitted) {
> +               hdr_sz =3D RAS_SUBEVENT_HEADER_SIZE;
> +               payload_sz =3D d->ras_subevent_data_.iov_len;
> +               total =3D hdr_sz + payload_sz;
> +               buf =3D (uint8_t *)malloc(total);
> +
> +               if (!buf)
> +                       return false;
> +
> +               w =3D serialize_ras_subevent_header(&d->ras_subevent_head=
er_,
> +                                               buf, total);
> +
> +               if (w !=3D hdr_sz) {
> +                       free(buf);
> +                       return false;
> +               }
> +
> +               if (payload_sz > 0)
> +                       memcpy(buf + hdr_sz,
> +                               (const uint8_t *)d->ras_subevent_data_.io=
v_base,
> +                               payload_sz);
> +
> +               ok =3D util_iov_append(&d->ras_raw_data_, buf, total) !=
=3D NULL;
> +               free(buf);
> +
> +               if (!ok)
> +                       return false;
> +
> +               d->ras_subevent_data_.iov_len =3D 0;
> +               d->ras_subevent_header_emitted =3D true;
> +       }
> +
> +       return true;
> +}
> +
>  static struct ras *rap_get_ras(struct bt_rap *rap)
>  {
>         if (!rap)
> @@ -155,6 +531,11 @@ static void rap_free(void *data)
>
>         rap_db_free(rap->rrapdb);
>
> +       if (rap->resptracker) {
> +               free(rap->resptracker);
> +               rap->resptracker =3D NULL;
> +       }
> +
>         queue_destroy(rap->notify, free);
>         queue_destroy(rap->pending, NULL);
>         queue_destroy(rap->ready_cbs, rap_ready_free);
> @@ -240,6 +621,22 @@ bool bt_rap_set_debug(struct bt_rap *rap, bt_rap_deb=
ug_func_t func,
>         return true;
>  }
>
> +static void cs_tracker_init(struct cstracker *t)
> +{
> +       if (!t)
> +               return;
> +
> +       memset(t, 0, sizeof(*t));
> +       t->role =3D CS_ROLE_REFLECTOR;
> +       t->config_id =3D CS_INVALID_CONFIG_ID;
> +       t->rtt_type =3D 0;
> +       t->selected_tx_power =3D 0;
> +       t->last_proc_counter =3D 0;
> +       t->last_start_acl_conn_evt_counter =3D 0;
> +       t->last_freq_comp =3D 0;
> +       t->last_ref_pwr_lvl =3D 0;
> +}
> +
>  static void ras_features_read_cb(struct gatt_db_attribute *attrib,
>                                  unsigned int id, uint16_t offset,
>                                  uint8_t opcode, struct bt_att *att,
> @@ -304,6 +701,225 @@ static void ras_data_overwritten_read_cb(struct gat=
t_db_attribute *attrib,
>         gatt_db_attribute_read_result(attrib, id, 0, value, sizeof(value)=
);
>  }
>
> +/* CCC write callbacks for custom handling */
> +static void ras_realtime_ccc_write_cb(struct gatt_db_attribute *attrib,
> +                                       unsigned int id, uint16_t offset,
> +                                       const uint8_t *value, size_t len,
> +                                       uint8_t opcode, struct bt_att *at=
t,
> +                                       void *user_data)
> +{
> +       struct ras *ras =3D user_data;
> +       uint16_t ccc_value;
> +
> +       if (!ras) {
> +               gatt_db_attribute_write_result(attrib, id,
> +                                       BT_ATT_ERROR_UNLIKELY);
> +               return;
> +       }
> +
> +       if (offset) {
> +               gatt_db_attribute_write_result(attrib, id,
> +                                       BT_ATT_ERROR_INVALID_OFFSET);
> +               return;
> +       }
> +
> +       if (len !=3D 2) {
> +               gatt_db_attribute_write_result(attrib, id,
> +                       BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN);
> +               return;
> +       }
> +
> +       ccc_value =3D get_le16(value);
> +
> +       if (ccc_value !=3D 0x0000 && ccc_value !=3D 0x0001 &&
> +           ccc_value !=3D 0x0002 && ccc_value !=3D 0x0003) {
> +               gatt_db_attribute_write_result(attrib, id,
> +                                       BT_ERROR_WRITE_REQUEST_REJECTED);
> +               return;
> +       }
> +
> +       /* Check mutual exclusivity: reject if trying to enable realtime
> +        * while ondemand is already enabled
> +        */

It is probably worth mentioning if there is a test case that requires
this behavior.

> +       if (ccc_value !=3D 0x0000 && ras->ondemand_ccc_value !=3D 0x0000)=
 {
> +               gatt_db_attribute_write_result(attrib, id,
> +                                       BT_ERROR_CCC_IMPROPERLY_CONFIGURE=
D);
> +               return;
> +       }
> +
> +       /* Update state */
> +       ras->realtime_ccc_value =3D ccc_value;
> +
> +       gatt_db_attribute_write_result(attrib, id, 0);
> +}
> +
> +static void ras_ondemand_ccc_write_cb(struct gatt_db_attribute *attrib,
> +                                       unsigned int id, uint16_t offset,
> +                                       const uint8_t *value, size_t len,
> +                                       uint8_t opcode, struct bt_att *at=
t,
> +                                       void *user_data)
> +{
> +       struct ras *ras =3D user_data;
> +       uint16_t ccc_value;
> +
> +       if (!ras) {
> +               gatt_db_attribute_write_result(attrib, id,
> +                                       BT_ATT_ERROR_UNLIKELY);
> +               return;
> +       }
> +
> +       if (offset) {
> +               gatt_db_attribute_write_result(attrib, id,
> +                                       BT_ATT_ERROR_INVALID_OFFSET);
> +               return;
> +       }
> +
> +       if (len !=3D 2) {
> +               gatt_db_attribute_write_result(attrib, id,
> +                               BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN)=
;
> +               return;
> +       }
> +
> +       ccc_value =3D get_le16(value);
> +
> +       if (ccc_value !=3D 0x0000 && ccc_value !=3D 0x0001 && ccc_value !=
=3D 0x0002 &&
> +           ccc_value !=3D 0x0003) {
> +               gatt_db_attribute_write_result(attrib, id,
> +                                       BT_ERROR_WRITE_REQUEST_REJECTED);
> +               return;
> +       }
> +
> +       /* Check mutual exclusivity: reject if trying to enable ondemand
> +        * while realtime is already enabled
> +        */
> +       if (ccc_value !=3D 0x0000 && ras->realtime_ccc_value !=3D 0x0000)=
 {
> +               gatt_db_attribute_write_result(attrib, id,
> +                                       BT_ERROR_CCC_IMPROPERLY_CONFIGURE=
D);
> +               return;
> +       }
> +
> +       /* Update state */
> +       ras->ondemand_ccc_value =3D ccc_value;
> +
> +       gatt_db_attribute_write_result(attrib, id, 0);

This looks duplicated, can we just use the same callback for both?

> +}
> +
> +static void ras_cp_ccc_write_cb(struct gatt_db_attribute *attrib,
> +                                       unsigned int id, uint16_t offset,
> +                                       const uint8_t *value, size_t len,
> +                                       uint8_t opcode, struct bt_att *at=
t,
> +                                       void *user_data)
> +{
> +       struct ras *ras =3D user_data;
> +       uint16_t ccc_value;
> +
> +       if (!ras) {
> +               gatt_db_attribute_write_result(attrib, id,
> +                                       BT_ATT_ERROR_UNLIKELY);
> +               return;
> +       }
> +
> +       if (offset) {
> +               gatt_db_attribute_write_result(attrib, id,
> +                                       BT_ATT_ERROR_INVALID_OFFSET);
> +               return;
> +       }
> +
> +       if (len !=3D 2) {
> +               gatt_db_attribute_write_result(attrib, id,
> +                       BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN);
> +               return;
> +       }
> +
> +       ccc_value =3D get_le16(value);
> +
> +       if (ccc_value !=3D 0x0000 && ccc_value !=3D 0x0001 &&
> +           ccc_value !=3D 0x0002) {
> +               gatt_db_attribute_write_result(attrib, id,
> +                                       BT_ERROR_WRITE_REQUEST_REJECTED);
> +               return;
> +       }
> +
> +       gatt_db_attribute_write_result(attrib, id, 0);
> +}
> +
> +static void ras_ready_ccc_write_cb(struct gatt_db_attribute *attrib,
> +                                       unsigned int id, uint16_t offset,
> +                                       const uint8_t *value, size_t len,
> +                                       uint8_t opcode, struct bt_att *at=
t,
> +                                       void *user_data)
> +{
> +       struct ras *ras =3D user_data;
> +       uint16_t ccc_value;
> +
> +       if (!ras) {
> +               gatt_db_attribute_write_result(attrib, id,
> +                                       BT_ATT_ERROR_UNLIKELY);
> +               return;
> +       }
> +
> +       if (offset) {
> +               gatt_db_attribute_write_result(attrib, id,
> +                                       BT_ATT_ERROR_INVALID_OFFSET);
> +               return;
> +       }
> +
> +       if (len !=3D 2) {
> +               gatt_db_attribute_write_result(attrib, id,
> +                       BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN);
> +               return;
> +       }
> +
> +       ccc_value =3D get_le16(value);
> +
> +       if (ccc_value !=3D 0x0000 && ccc_value !=3D 0x0001 &&
> +           ccc_value !=3D 0x0002 && ccc_value !=3D 0x0003) {
> +               gatt_db_attribute_write_result(attrib, id,
> +                                       BT_ERROR_WRITE_REQUEST_REJECTED);
> +               return;
> +       }
> +
> +       gatt_db_attribute_write_result(attrib, id, 0);
> +}
> +
> +static void ras_overwritten_ccc_write_cb(struct gatt_db_attribute *attri=
b,
> +                                       unsigned int id, uint16_t offset,
> +                                       const uint8_t *value, size_t len,
> +                                       uint8_t opcode, struct bt_att *at=
t,
> +                                       void *user_data)
> +{
> +       struct ras *ras =3D user_data;
> +       uint16_t ccc_value;
> +
> +       if (!ras) {
> +               gatt_db_attribute_write_result(attrib, id,
> +                                       BT_ATT_ERROR_UNLIKELY);
> +               return;
> +       }
> +
> +       if (offset) {
> +               gatt_db_attribute_write_result(attrib, id,
> +                                       BT_ATT_ERROR_INVALID_OFFSET);
> +               return;
> +       }
> +
> +       if (len !=3D 2) {
> +               gatt_db_attribute_write_result(attrib, id,
> +                       BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN);
> +               return;
> +       }
> +
> +       ccc_value =3D get_le16(value);
> +
> +       if (ccc_value !=3D 0x0000 && ccc_value !=3D 0x0001 &&
> +           ccc_value !=3D 0x0002 && ccc_value !=3D 0x0003) {
> +               gatt_db_attribute_write_result(attrib, id,
> +                                       BT_ERROR_WRITE_REQUEST_REJECTED);
> +               return;
> +       }
> +
> +       gatt_db_attribute_write_result(attrib, id, 0);
> +}
>  /* Service registration =E2=80=93 store attribute pointers */
>  static struct ras *register_ras_service(struct gatt_db *db)
>  {
> @@ -349,9 +965,9 @@ static struct ras *register_ras_service(struct gatt_d=
b *db)
>                                                   NULL, NULL, ras);
>
>         ras->realtime_chrc_ccc =3D
> -               gatt_db_service_add_ccc(ras->svc,
> -                                       BT_ATT_PERM_READ |
> -                                       BT_ATT_PERM_WRITE);
> +               gatt_db_service_add_ccc_custom(ras->svc,
> +                                       BT_ATT_PERM_READ | BT_ATT_PERM_WR=
ITE,
> +                                       ras_realtime_ccc_write_cb, ras);
>
>         /* On-demand Ranging Data */
>         bt_uuid16_create(&uuid, RAS_ONDEMAND_DATA_UUID);
> @@ -364,8 +980,9 @@ static struct ras *register_ras_service(struct gatt_d=
b *db)
>                                                   ras_ondemand_read_cb, N=
ULL,
>                                                   ras);
>
> -       gatt_db_service_add_ccc(ras->svc,
> -                               BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
> +       ras->ondemand_ccc =3D gatt_db_service_add_ccc_custom(ras->svc,
> +                                       BT_ATT_PERM_READ | BT_ATT_PERM_WR=
ITE,
> +                                       ras_ondemand_ccc_write_cb, ras);
>
>         /* RAS Control Point */
>         bt_uuid16_create(&uuid, RAS_CONTROL_POINT_UUID);
> @@ -379,8 +996,9 @@ static struct ras *register_ras_service(struct gatt_d=
b *db)
>                                                   ras_control_point_write=
_cb,
>                                                   ras);
>
> -       gatt_db_service_add_ccc(ras->svc,
> -                               BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
> +       ras->cp_ccc =3D gatt_db_service_add_ccc_custom(ras->svc,
> +                                       BT_ATT_PERM_READ | BT_ATT_PERM_WR=
ITE,
> +                                       ras_cp_ccc_write_cb, ras);
>
>         /* RAS Data Ready */
>         bt_uuid16_create(&uuid, RAS_DATA_READY_UUID);
> @@ -394,8 +1012,9 @@ static struct ras *register_ras_service(struct gatt_=
db *db)
>                                                   ras_data_ready_read_cb,=
 NULL,
>                                                   ras);
>
> -       gatt_db_service_add_ccc(ras->svc,
> -                               BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
> +       ras->ready_ccc =3D gatt_db_service_add_ccc_custom(ras->svc,
> +                                       BT_ATT_PERM_READ | BT_ATT_PERM_WR=
ITE,
> +                                       ras_ready_ccc_write_cb, ras);
>
>         /* RAS Data Overwritten */
>         bt_uuid16_create(&uuid, RAS_DATA_OVERWRITTEN_UUID);
> @@ -409,8 +1028,9 @@ static struct ras *register_ras_service(struct gatt_=
db *db)
>                                                   ras_data_overwritten_re=
ad_cb,
>                                                   NULL, ras);
>
> -       gatt_db_service_add_ccc(ras->svc,
> -                               BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
> +       ras->overwritten_ccc =3D gatt_db_service_add_ccc_custom(ras->svc,
> +                                       BT_ATT_PERM_READ | BT_ATT_PERM_WR=
ITE,
> +                                       ras_overwritten_ccc_write_cb, ras=
);

Do we really need custom callbacks for every single CCC here? I though
that was just for those that cannot be enabled together, otherwise
they just identical/duplicated.

>         /* Activate the service */
>         gatt_db_service_set_active(ras->svc, true);
> @@ -503,32 +1123,746 @@ bool bt_rap_unregister(unsigned int id)
>         return true;
>  }
>
> +static inline size_t serialize_segmentation_header(
> +                               const struct segmentation_header *s,
> +                               uint8_t *out, size_t out_len)
> +{
> +       if (!s || !out || out_len < 1)
> +               return 0;
> +
> +       /* [0] bit0: first, bit1: last, bits2..7: rolling counter */
> +       out[0] =3D (s->first_segment ? 0x01 : 0x00) |
> +               (s->last_segment ? 0x02 : 0x00) |
> +               ((s->rolling_segment_counter & 0x3F) << 2);
> +
> +       return 1;
> +}
> +
> +static inline size_t serialize_ranging_header(const struct ranging_heade=
r *r,
> +                                               uint8_t *out, size_t out_=
len)
> +{
> +       uint16_t rcid;
> +
> +       if (!r || !out || out_len < RAS_RANGING_HEADER_SIZE)
> +               return 0;
> +
> +       /* Little-endian pack: [rc (12 bits) | cfg_id (4 bits)] */
> +       rcid =3D RANGING_HDR_PACK_BYTE0_1(r->ranging_counter,
> +                                       r->configuration_id);
> +
> +       put_le16(rcid, out + 0);
> +       out[2] =3D (uint8_t)r->selected_tx_power;
> +       /* Byte 3: antenna_paths_mask | reserved | pct_format */
> +       out[3] =3D RANGING_HDR_PACK_BYTE3(r->antenna_paths_mask,
> +                                       r->pct_format);

Can't we define packed structs instead of serializing to a byte array
like this? That way we can actually use sizeof, etc.

> +       return RAS_RANGING_HEADER_SIZE;
> +}
> +
> +static inline uint16_t ras_att_value_payload_max(struct bt_rap *rap)
> +{
> +       struct bt_att *att =3D bt_rap_get_att(rap);
> +       uint16_t mtu =3D att ? bt_att_get_mtu(att) : default_ras_mtu;

Still don't get it how this can be called with a NULL att?

> +
> +       return (uint16_t)(mtu > ATT_OVERHEAD ?
> +               (mtu - ATT_OVERHEAD - TOTAL_RAS_RANGING_HEADER_SIZE -
> +               ras_segment_header_size) : 0);
> +}
> +
> +/* Prepend data to an iovec */
> +static bool iov_prepend_bytes(struct iovec *iov, const uint8_t *bytes,
> +                               size_t len)
> +{
> +       size_t new_len;
> +       void *new_base;
> +
> +       if (!iov || !bytes || len =3D=3D 0)
> +               return false;
> +
> +       new_len =3D iov->iov_len + len;
> +       new_base =3D malloc(new_len);

This wouldn't be too bad if we could avoid it, since this is
apparently done inline, allowing us to avoid copying each segment on a
new memory chunk or in the worst case, we can use multiple iovs to
track each segment independently and add an API to notify using writev
semantics.

> +       if (!new_base)
> +               return false;
> +
> +       memcpy(new_base, bytes, len);
> +
> +       if (iov->iov_len > 0)
> +               memcpy((uint8_t *)new_base + len, iov->iov_base,
> +                       iov->iov_len);
> +
> +       free(iov->iov_base);
> +       iov->iov_base =3D new_base;
> +       iov->iov_len =3D new_len;
> +
> +       return true;
> +}
> +
> +/* Append the 4-byte RangingHeader to ras_raw_data_ on first segment */
> +static bool ras_maybe_prepend_ranging_header(struct cs_procedure_data *d=
)
> +{
> +       uint8_t hdr[RAS_RANGING_HEADER_SIZE];
> +       size_t w;
> +       bool ok;
> +
> +       if (!d)
> +               return false;
> +
> +       if (d->ranging_header_prepended_)
> +               return false;
> +
> +       if (!d->segmentation_header_.first_segment)
> +               return false;
> +
> +       if (d->ras_raw_data_index_ !=3D 0)
> +               return false;
> +
> +       w =3D serialize_ranging_header(&d->ranging_header_, hdr, sizeof(h=
dr));
> +
> +       if (w !=3D RAS_RANGING_HEADER_SIZE)
> +               return false;
> +
> +       ok =3D iov_prepend_bytes(&d->ras_raw_data_, hdr, w);
> +
> +       if (ok)
> +               d->ranging_header_prepended_ =3D true;
> +
> +       return ok;
> +}
> +
> +static void send_ras_segment_data(struct bt_rap *rap,
> +                               struct cs_procedure_data *proc)
> +{
> +       struct ras *ras;
> +       uint16_t value_max;
> +       const uint16_t header_len =3D ras_segment_header_size;
> +       uint16_t raw_payload_size;
> +       bool ok;
> +
> +       if (!rap || !proc)
> +               return;
> +
> +       if (!rap->lrapdb || !rap->lrapdb->ras)
> +               return;

Empty line after the if statement.

> +       ras =3D rap->lrapdb->ras;
> +       value_max =3D ras_att_value_payload_max(rap);
> +
> +       if (value_max =3D=3D 0) {
> +               DBG(rap, "value_max=3D0 (MTU not available?)");
> +               return;
> +       }
> +
> +       if (value_max <=3D header_len) {
> +               DBG(rap, "value_max(%u) too small for header", value_max)=
;
> +               return;
> +       }
> +
> +       raw_payload_size =3D (uint16_t)(value_max - header_len);
> +
> +       /* Convert tail recursion to loop */
> +       while (true) {
> +               size_t total_len =3D proc->ras_raw_data_.iov_len;
> +               size_t index =3D proc->ras_raw_data_index_;
> +               size_t unsent_data_size;
> +               uint16_t copy_size;
> +               uint16_t seg_len;
> +               uint8_t *seg;
> +               uint16_t wr =3D 0;
> +
> +               if (index > total_len)
> +                       index =3D total_len;
> +
> +               unsent_data_size =3D total_len - index;
> +
> +               if (unsent_data_size =3D=3D 0)
> +                       return;
> +
> +               /* Set last_segment if procedure complete or fits in segm=
ent */
> +               if ((proc->local_status !=3D CS_PROC_PARTIAL_RESULTS &&
> +                               unsent_data_size <=3D raw_payload_size) |=
|
> +                       (proc->contains_complete_subevent_ &&
> +                               unsent_data_size <=3D raw_payload_size)) =
{
> +                       proc->segmentation_header_.last_segment =3D 1;
> +               } else {
> +                       proc->segmentation_header_.last_segment =3D 0;
> +               }
> +
> +               /* Wait for more data if needed and not last segment */
> +               if (unsent_data_size < raw_payload_size &&
> +                               proc->segmentation_header_.last_segment =
=3D=3D 0) {
> +                       DBG(rap, "waiting for more data (unsent=3D%zu < "
> +                               "payload=3D%u)", unsent_data_size,
> +                               raw_payload_size);
> +                       return;
> +               }
> +
> +               copy_size =3D (uint16_t)((unsent_data_size < raw_payload_=
size) ?
> +                               unsent_data_size : raw_payload_size);
> +               seg_len =3D (uint16_t)(header_len + copy_size);
> +               seg =3D (uint8_t *)malloc(seg_len);
> +
> +               if (!seg) {
> +                       DBG(rap, "OOM (%u)", seg_len);
> +                       return;
> +               }
> +
> +               wr +=3D (uint16_t)serialize_segmentation_header(
> +                               &proc->segmentation_header_, seg + wr,
> +                               seg_len - wr);
> +               memcpy(seg + wr,
> +                       (const uint8_t *)proc->ras_raw_data_.iov_base + i=
ndex,
> +                       copy_size);
> +               wr +=3D copy_size;
> +
> +               /* Try sending to real-time characteristic */
> +               if (ras->realtime_chrc)
> +                       ok =3D gatt_db_attribute_notify(ras->realtime_chr=
c, seg,
> +                                               wr, bt_rap_get_att(rap));
> +
> +               /* Try sending to on-demand characteristic */
> +               if (ras->ondemand_chrc)
> +                       ok =3D gatt_db_attribute_notify(ras->ondemand_chr=
c, seg,
> +                                               wr, bt_rap_get_att(rap));
> +
> +               free(seg);
> +
> +               if (!ok) {
> +                       DBG(rap, "Failed to send RAS notification");
> +                       return;
> +               }
> +
> +               /* Advance read cursor and update segmentation state */
> +               proc->ras_raw_data_index_ +=3D copy_size;
> +               proc->segmentation_header_.first_segment =3D 0;
> +               proc->segmentation_header_.rolling_segment_counter =3D
> +                       (uint8_t)((proc->segmentation_header_
> +                               .rolling_segment_counter + 1) & 0x3F);
> +
> +               if (proc->segmentation_header_.last_segment ||
> +                               proc->ras_raw_data_index_ >=3D
> +                               proc->ras_raw_data_.iov_len) {
> +                       DBG(rap, "RAS clear ras buffers");
> +                       proc->ras_raw_data_.iov_len =3D 0;
> +                       proc->ras_raw_data_index_ =3D 0;
> +                       proc->ranging_header_prepended_ =3D false;
> +                       return;
> +               }
> +       }
> +}
> +
> +static inline void resptracker_reset_current_proc(struct cstracker *t)
> +{
> +       if (!t)
> +               return;
> +
> +       if (t->current_proc) {
> +               cs_procedure_data_destroy(t->current_proc);
> +               t->current_proc =3D NULL;
> +       }
> +}
> +/* Unified local subevent handler */
> +static void handle_local_subevent_result(struct bt_rap *rap,
> +                                       bool has_header_fields,
> +                                       uint8_t config_id,
> +                                       uint8_t num_ant_paths,
> +                                       uint16_t proc_counter,
> +                                       uint16_t start_acl_conn_evt_count=
er,
> +                                       uint16_t freq_comp,
> +                                       int8_t  ref_pwr_lvl,
> +                                       uint8_t proc_done_status,
> +                                       uint8_t subevt_done_status,
> +                                       uint8_t abort_reason,
> +                                       uint8_t num_steps_reported,
> +                                       const void *step_bytes)
> +{
> +       struct cstracker *resptracker;
> +       struct cs_procedure_data *proc;
> +       const struct cs_step_data *steps;
> +       uint8_t idx;
> +
> +       if (!rap || !rap->resptracker || !step_bytes)
> +               return;
> +
> +       resptracker =3D rap->resptracker;
> +
> +       if (resptracker->current_proc) {
> +               struct cs_procedure_data *cur =3D resptracker->current_pr=
oc;
> +
> +               if (has_header_fields && cur->counter !=3D proc_counter) =
{
> +                       /* Safety: a new procedure; destroy the previous =
one */
> +                       resptracker_reset_current_proc(resptracker);
> +               }
> +       }
> +
> +       proc =3D resptracker->current_proc;
> +       /* Cache header info from a RESULT event for later CONT usage */
> +       if (has_header_fields) {
> +               resptracker->last_proc_counter =3D proc_counter;
> +               resptracker->last_start_acl_conn_evt_counter =3D
> +                       start_acl_conn_evt_counter;
> +               resptracker->last_freq_comp =3D freq_comp;
> +               resptracker->last_ref_pwr_lvl =3D ref_pwr_lvl;
> +       }
> +
> +       /* Create the procedure on first use */
> +       if (!proc) {
> +               uint16_t create_counter =3D has_header_fields ? proc_coun=
ter :
> +                                       resptracker->last_proc_counter;
> +
> +               proc =3D cs_procedure_data_create(create_counter,
> +                                               num_ant_paths,
> +                                               config_id,
> +                                               resptracker->selected_tx_=
power);
> +               if (!proc)
> +                       return;
> +
> +               resptracker->current_proc =3D proc;
> +
> +               /* Reference power levels and status defaults */
> +               cs_pd_set_reference_power_levels(proc,
> +                       has_header_fields ? ref_pwr_lvl :
> +                               resptracker->last_ref_pwr_lvl,
> +                       has_header_fields ? ref_pwr_lvl :
> +                               resptracker->last_ref_pwr_lvl);
> +               cs_pd_set_local_status(proc,
> +                       (enum cs_procedure_done_status)proc_done_status);
> +               cs_pd_set_remote_status(proc,
> +                       (enum cs_procedure_done_status)subevt_done_status=
);
> +       }
> +
> +       /* Begin a new RAS subevent only when we have header fields */
> +       if (has_header_fields) {
> +               cs_pd_ras_begin_subevent(proc,
> +                                       start_acl_conn_evt_counter,
> +                                       freq_comp,
> +                                       ref_pwr_lvl);
> +       }
> +
> +       /* step_bytes points to an array of struct cs_step_data */
> +       steps =3D (const struct cs_step_data *)step_bytes;
> +
> +       /* Process each step */
> +       for (idx =3D 0; idx < num_steps_reported; idx++) {
> +               const struct cs_step_data *step =3D &steps[idx];
> +               const uint8_t mode =3D step->step_mode;
> +               const uint8_t channel =3D step->step_chnl;
> +               const uint8_t payload_len =3D step->step_data_length;
> +               uint8_t mode_byte;
> +               uint8_t mode_type;
> +               const uint8_t *payload;
> +               uint8_t plen;
> +               bool step_aborted;
> +
> +               /* Check if step is aborted: bit 7 of step_mode or
> +                * 0 payload len
> +                */
> +               step_aborted =3D (mode & RAS_STEP_ABORTED_BIT) ||
> +                       (payload_len =3D=3D 0);
> +
> +               DBG(rap, "step[%u]: mode=3D0x%02x channel=3D%u payload_le=
n=3D%u "
> +                       "aborted=3D%s", idx, mode, channel, payload_len,
> +                       step_aborted ? "YES" : "NO");
> +
> +               /* Slim-step serialization for RAS:
> +                * - 1 byte: mode (bit7 set if aborted)
> +                * - payload: exactly step_data_length bytes (raw mode da=
ta)
> +                */
> +               mode_byte =3D step->step_mode;
> +               payload =3D (const uint8_t *)&step->step_mode_data;
> +               plen =3D step->step_data_length;
> +
> +               if (step_aborted) {
> +                       /* Ensure abort bit is set */
> +                       mode_byte |=3D RAS_STEP_ABORTED_BIT;
> +                       cs_pd_ras_append_subevent_bytes(proc, &mode_byte,=
 1);
> +                       /* No payload when aborted - per RAS spec Table 3=
.8 */
> +                       DBG(rap, "step[%u]: mode=3D0x%02x aborted, "
> +                               "no payload sent", idx, mode_byte);
> +               } else {
> +                       mode_type =3D mode & 0x03;
> +
> +                       /* Mode byte first (without abort bit) */
> +                       cs_pd_ras_append_subevent_bytes(proc, &mode_byte,=
 1);
> +
> +                       switch (mode_type) {
> +                       case CS_MODE_ZERO: {
> +                               /* Mode 0: use raw structure bytes */
> +                               payload =3D
> +                                       (const uint8_t *)&step->step_mode=
_data;
> +                               plen =3D step->step_data_length;
> +                               cs_pd_ras_append_subevent_bytes(proc,
> +                                                               payload, =
plen);
> +                               DBG(rap, "step[%u]: mode=3D0x%02x Mode0 "
> +                                       "payload_len=3D%u sent",
> +                                       idx, mode_byte, (unsigned int)ple=
n);
> +                               break;
> +                       }
> +                       case CS_MODE_ONE: {
> +                               const struct cs_mode_one_data *m1 =3D
> +                                       &step->step_mode_data.mode_one_da=
ta;
> +                               uint8_t buf[16];  /* Max Mode 1 size */
> +                               uint8_t *p =3D buf;
> +                               uint16_t time_val;
> +                               uint32_t pct1;
> +                               uint32_t pct2;
> +                               enum cs_role cs_role =3D resptracker->rol=
e;
> +                               uint8_t cs_rtt_type =3D resptracker->rtt_=
type;
> +
> +                               *p++ =3D m1->packet_quality;
> +                               *p++ =3D m1->packet_nadm;
> +                               *p++ =3D m1->packet_rssi_dbm;
> +
> +                               /* Time value (2 bytes LE) - use the
> +                                * appropriate field based on role
> +                                */
> +                               if (cs_role =3D=3D CS_ROLE_REFLECTOR)
> +                                       time_val =3D m1->tod_toa_refl;
> +                               else
> +                                       time_val =3D m1->toa_tod_init;
> +
> +                               *p++ =3D (uint8_t)(time_val & 0xFF);
> +                               *p++ =3D (uint8_t)((time_val >> 8) & 0xFF=
);
> +
> +                               *p++ =3D m1->packet_ant;
> +
> +                               /* PCT samples if RTT type contains
> +                                * sounding sequence
> +                                */
> +                               if (cs_rtt_type =3D=3D 0x01 ||
> +                                               cs_rtt_type =3D=3D 0x02) =
{
> +                                       pct1 =3D ((uint32_t)(m1->packet_p=
ct1
> +                                                       .i_sample &
> +                                                       0x0FFF)) |
> +                                               (((uint32_t)(m1->packet_p=
ct1
> +                                                       .q_sample &
> +                                                       0x0FFF)) << 12);
> +                                       *p++ =3D (uint8_t)(pct1 & 0xFF);
> +                                       *p++ =3D (uint8_t)((pct1 >> 8) & =
0xFF);
> +                                       *p++ =3D (uint8_t)((pct1 >> 16) &=
 0xFF);
> +
> +                                       /* PCT2 (3 bytes) */
> +                                       pct2 =3D ((uint32_t)(m1->packet_p=
ct2
> +                                                       .i_sample &
> +                                                       0x0FFF)) |
> +                                               (((uint32_t)(m1->packet_p=
ct2
> +                                                       .q_sample &
> +                                                       0x0FFF)) << 12);
> +                                       *p++ =3D (uint8_t)(pct2 & 0xFF);
> +                                       *p++ =3D (uint8_t)((pct2 >> 8) & =
0xFF);
> +                                       *p++ =3D (uint8_t)((pct2 >> 16) &=
 0xFF);
> +                               }
> +
> +                               plen =3D (uint8_t)(p - buf);
> +                               cs_pd_ras_append_subevent_bytes(proc, buf=
,
> +                                                               plen);
> +                               DBG(rap, "step[%u]: mode=3D0x%02x Mode1 "
> +                                       "serialized payload_len=3D%u role=
=3D%s "
> +                                       "rtt_type=3D0x%02x",
> +                                       idx, mode_byte, (unsigned int)ple=
n,
> +                                       cs_role =3D=3D CS_ROLE_INITIATOR =
?
> +                                               "INIT" : "REFL", cs_rtt_t=
ype);
> +                               break;
> +                       }
> +                       case CS_MODE_TWO: {
> +                               const struct cs_mode_two_data *m2 =3D
> +                                       &step->step_mode_data.mode_two_da=
ta;
> +                               /* Max Mode 2 size: 1 + 5*(3+1) =3D 21 by=
tes */
> +                               uint8_t buf[64];
> +                               uint8_t *p =3D buf;
> +                               uint8_t k;
> +                               uint8_t num_paths =3D (num_ant_paths + 1)=
 < 5 ?
> +                                       (num_ant_paths + 1) : 5;
> +
> +                               *p++ =3D m2->ant_perm_index;
> +
> +                               /* Serialize each path: PCT (3 bytes) +
> +                                * quality (1 byte)
> +                                */
> +                               for (k =3D 0; k < num_paths; k++) {
> +                                       /* Convert 4-byte structure PCT t=
o
> +                                        * 3-byte wire format
> +                                        */
> +                                       uint32_t pct =3D
> +                                               ((uint32_t)(m2->tone_pct[=
k]
> +                                                       .i_sample &
> +                                                       0x0FFF)) |
> +                                               (((uint32_t)(m2->tone_pct=
[k]
> +                                                       .q_sample &
> +                                                       0x0FFF)) << 12);
> +                                       *p++ =3D (uint8_t)(pct & 0xFF);
> +                                       *p++ =3D (uint8_t)((pct >> 8) & 0=
xFF);
> +                                       *p++ =3D (uint8_t)((pct >> 16) & =
0xFF);
> +
> +                                       *p++ =3D m2->tone_quality_indicat=
or[k];
> +                               }
> +
> +                               plen =3D (uint8_t)(p - buf);
> +                               cs_pd_ras_append_subevent_bytes(proc, buf=
,
> +                                                               plen);
> +                               DBG(rap, "step[%u]: mode=3D0x%02x Mode2 "
> +                                       "serialized payload_len=3D%u path=
s=3D%u",
> +                                       idx, mode_byte, (unsigned int)ple=
n,
> +                                       num_paths);
> +                               break;
> +                       }
> +                       case CS_MODE_THREE: {
> +                               const struct cs_mode_three_data *m3 =3D
> +                                       &step->step_mode_data.mode_three_=
data;
> +                               const struct cs_mode_one_data *m1 =3D
> +                                       &m3->mode_one_data;
> +                               const struct cs_mode_two_data *m2 =3D
> +                                       &m3->mode_two_data;
> +                               uint8_t buf[80];  /* Max Mode 3 size */
> +                               uint8_t *p =3D buf;
> +                               uint8_t k;
> +                               uint32_t pct1;
> +                               uint32_t pct2;
> +                               uint8_t num_paths =3D (num_ant_paths + 1)=
 < 5 ?
> +                                       (num_ant_paths + 1) : 5;
> +                               uint8_t cs_rtt_type =3D resptracker->rtt_=
type;
> +                               enum cs_role cs_role =3D resptracker->rol=
e;
> +                               uint16_t time_val;
> +                               bool include_pct;
> +
> +                               /* Determine if PCT samples should be
> +                                * included
> +                                */
> +                               include_pct =3D (cs_rtt_type =3D=3D 0x01 =
||
> +                                               cs_rtt_type =3D=3D 0x02) =
&&
> +                                       (cs_role =3D=3D CS_ROLE_INITIATOR=
 ||
> +                                               cs_role =3D=3D CS_ROLE_RE=
FLECTOR);
> +
> +                               /* Mode 1 portion - basic fields */
> +                               *p++ =3D m1->packet_quality;
> +                               *p++ =3D m1->packet_nadm;
> +                               *p++ =3D m1->packet_rssi_dbm;
> +
> +                               /* Time value based on role */
> +                               if (cs_role =3D=3D CS_ROLE_REFLECTOR)
> +                                       time_val =3D m1->tod_toa_refl;
> +                               else
> +                                       time_val =3D m1->toa_tod_init;
> +
> +                               *p++ =3D (uint8_t)(time_val & 0xFF);
> +                               *p++ =3D (uint8_t)((time_val >> 8) & 0xFF=
);
> +
> +                               *p++ =3D m1->packet_ant;
> +
> +                               /* PCT samples if conditions met */
> +                               if (include_pct) {
> +                                       pct1 =3D ((uint32_t)(m1->packet_p=
ct1
> +                                                       .i_sample &
> +                                                       0x0FFF)) |
> +                                               (((uint32_t)(m1->packet_p=
ct1
> +                                                       .q_sample &
> +                                                       0x0FFF)) << 12);
> +                                       *p++ =3D (uint8_t)(pct1 & 0xFF);
> +                                       *p++ =3D (uint8_t)((pct1 >> 8) & =
0xFF);
> +                                       *p++ =3D (uint8_t)((pct1 >> 16) &=
 0xFF);
> +
> +                                       pct2 =3D ((uint32_t)(m1->packet_p=
ct2
> +                                                       .i_sample &
> +                                                       0x0FFF)) |
> +                                               (((uint32_t)(m1->packet_p=
ct2
> +                                                       .q_sample &
> +                                                       0x0FFF)) << 12);
> +                                       *p++ =3D (uint8_t)(pct2 & 0xFF);
> +                                       *p++ =3D (uint8_t)((pct2 >> 8) & =
0xFF);
> +                                       *p++ =3D (uint8_t)((pct2 >> 16) &=
 0xFF);
> +                               }
> +
> +                               /* Mode 2 portion */
> +                               *p++ =3D m2->ant_perm_index;
> +
> +                               for (k =3D 0; k < num_paths; k++) {
> +                                       uint32_t pct =3D
> +                                               ((uint32_t)(m2->tone_pct[=
k]
> +                                                       .i_sample &
> +                                                       0x0FFF)) |
> +                                               (((uint32_t)(m2->tone_pct=
[k]
> +                                                       .q_sample &
> +                                                       0x0FFF)) << 12);
> +                                       *p++ =3D (uint8_t)(pct & 0xFF);
> +                                       *p++ =3D (uint8_t)((pct >> 8) & 0=
xFF);
> +                                       *p++ =3D (uint8_t)((pct >> 16) & =
0xFF);
> +
> +                                       *p++ =3D m2->tone_quality_indicat=
or[k];
> +                               }
> +
> +                               plen =3D (uint8_t)(p - buf);
> +                               cs_pd_ras_append_subevent_bytes(proc, buf=
,
> +                                                               plen);
> +                               DBG(rap, "step[%u]: mode=3D0x%02x Mode3 "
> +                                       "serialized payload_len=3D%u path=
s=3D%u "
> +                                       "role=3D%s rtt_type=3D0x%02x pct=
=3D%s",
> +                                       idx, mode_byte, (unsigned int)ple=
n,
> +                                       num_paths,
> +                                       cs_role =3D=3D CS_ROLE_INITIATOR =
?
> +                                               "INIT" : "REFL",
> +                                       cs_rtt_type,
> +                                       include_pct ? "YES" : "NO");
> +                               break;
> +                       }

Make each case call a helper function to perform the operation.

> +                       default:
> +                               /* Unknown mode: use raw structure bytes =
*/
> +                               payload =3D
> +                                       (const uint8_t *)&step->step_mode=
_data;
> +                               plen =3D step->step_data_length;
> +                               cs_pd_ras_append_subevent_bytes(proc, pay=
load,
> +                                                               plen);
> +                               DBG(rap, "step[%u]: mode=3D0x%02x unknown=
 mode, "
> +                                       "payload_len=3D%u sent",
> +                                       idx, mode_byte, (unsigned int)ple=
n);
> +                               break;
> +                       }
> +               }
> +       }
> +
> +       /* Update status for this chunk */
> +       cs_pd_set_local_status(proc,
> +                       (enum cs_procedure_done_status)proc_done_status);
> +       cs_pd_set_remote_status(proc,
> +                       (enum cs_procedure_done_status)subevt_done_status=
);
> +
> +       /* Commit subevent chunk (RESULT or CONT) */
> +       cs_pd_ras_commit_subevent(proc,
> +               num_steps_reported,
> +               proc_done_status,
> +               subevt_done_status,
> +               abort_reason & 0x0F,
> +               (abort_reason >> 4) & 0x0F);
> +
> +       /* Ensure first segment body starts with the 4-byte RangingHeader=
 */
> +       ras_maybe_prepend_ranging_header(proc);
> +
> +       if (subevt_done_status !=3D SUBEVENT_DONE_PARTIAL_RESULTS)
> +               /* Send RAS raw segment data */
> +               send_ras_segment_data(rap, proc);
> +
> +       /* Procedure complete? Clean up */
> +       if (proc_done_status =3D=3D CS_PROC_ALL_RESULTS_COMPLETE) {
> +               DBG(rap, "Destroying CsProcedureData counter=3D%u and "
> +                       "clearing current_proc", proc->counter);
> +               resptracker_reset_current_proc(resptracker);
> +               /* Reset cached header values for next procedure */
> +               resptracker->last_proc_counter =3D 0;
> +               resptracker->last_start_acl_conn_evt_counter =3D 0;
> +               resptracker->last_freq_comp =3D 0;
> +               resptracker->last_ref_pwr_lvl =3D 0;
> +       }
> +}
> +
> +static void form_ras_data_with_cs_subevent_result(struct bt_rap *rap,
> +               const struct rap_ev_cs_subevent_result *data,
> +               uint16_t length)
> +{
> +       size_t base_len =3D offsetof(struct rap_ev_cs_subevent_result,
> +                                       step_data);
> +
> +       if (!rap || !rap->resptracker || !data)
> +               return;
> +
> +       /* Defensive check: base header must be present */
> +       if (length < base_len)
> +               return;
> +
> +       DBG(rap, "Received CS subevent result subevent: len=3D%d", length=
);
> +
> +       handle_local_subevent_result(rap,
> +               true,                   /* has header fields */
> +               data->config_id,
> +               data->num_ant_paths,
> +               data->proc_counter,
> +               data->start_acl_conn_evt_counter,
> +               data->freq_comp,
> +               data->ref_pwr_lvl,
> +               data->proc_done_status,
> +               data->subevt_done_status,
> +               data->abort_reason,
> +               data->num_steps_reported,
> +               data->step_data);       /* start of steps */
> +}
> +static void form_ras_data_with_cs_subevent_result_cont(struct bt_rap *ra=
p,
> +               const struct rap_ev_cs_subevent_result_cont *cont,
> +               uint16_t length)
> +{
> +       size_t base_len =3D offsetof(struct rap_ev_cs_subevent_result_con=
t,
> +                                       step_data);
> +       struct cstracker *resptracker;
> +
> +       if (!rap || !rap->resptracker || !cont)
> +               return;
> +
> +       if (length < base_len)
> +               return;
> +
> +       DBG(rap, "Received CS subevent result continue subevent: len=3D%d=
",
> +               length);
> +
> +       resptracker =3D rap->resptracker;
> +
> +       /* Use cached header values captured from the last RESULT event *=
/
> +       handle_local_subevent_result(rap,
> +               false,                  /* CONT has no header fields */
> +               cont->config_id,
> +               cont->num_ant_paths,
> +               resptracker->last_proc_counter,
> +               resptracker->last_start_acl_conn_evt_counter,
> +               resptracker->last_freq_comp,
> +               resptracker->last_ref_pwr_lvl,
> +               cont->proc_done_status,
> +               cont->subevt_done_status,
> +               cont->abort_reason,
> +               cont->num_steps_reported,
> +               cont->step_data);
> +}
>  void bt_rap_hci_cs_subevent_result_cont_callback(uint16_t length,
>                                                 const void *param,
>                                                 void *user_data)
>  {
> +       const struct rap_ev_cs_subevent_result_cont *cont =3D param;
>         struct bt_rap *rap =3D user_data;
>
>         DBG(rap, "Received CS subevent CONT: len=3D%d", length);
> +
> +       form_ras_data_with_cs_subevent_result_cont(rap, cont, length);
>  }
>
>  void bt_rap_hci_cs_subevent_result_callback(uint16_t length,
>                                         const void *param,
>                                         void *user_data)
>  {
> +       const struct rap_ev_cs_subevent_result *data =3D param;
>         struct bt_rap *rap =3D user_data;
>
>         DBG(rap, "Received CS subevent: len=3D%d", length);
> +
> +       /* Populate CsProcedureData and send RAS payload */
> +       form_ras_data_with_cs_subevent_result(rap, data, length);
>  }
>
>  void bt_rap_hci_cs_procedure_enable_complete_callback(uint16_t length,
>                                                 const void *param,
>                                                 void *user_data)
>  {
> +       const struct rap_ev_cs_proc_enable_cmplt *data =3D param;
>         struct bt_rap *rap =3D user_data;
> +       struct cstracker *resptracker;
>
>         DBG(rap, "Received CS procedure enable complete subevent: len=3D%=
d",
>             length);
> +
> +       if (!rap->resptracker) {
> +               resptracker =3D new0(struct cstracker, 1);
> +               cs_tracker_init(resptracker);
> +               rap->resptracker =3D resptracker;
> +       }
> +
> +       resptracker =3D rap->resptracker;
> +
> +       /* Populate responder tracker */
> +       resptracker->config_id =3D data->config_id;
> +       resptracker->selected_tx_power =3D data->sel_tx_pwr;
>  }
>
>  void bt_rap_hci_cs_sec_enable_complete_callback(uint16_t length,
> @@ -544,9 +1878,27 @@ void bt_rap_hci_cs_config_complete_callback(uint16_=
t length,
>                                         const void *param,
>                                         void *user_data)
>  {
> +       const struct rap_ev_cs_config_cmplt *data =3D param;
>         struct bt_rap *rap =3D user_data;
> +       struct cstracker *resptracker;
> +
> +       if (!rap)
> +               return;
>
>         DBG(rap, "Received CS config complete subevent: len=3D%d", length=
);
> +
> +       if (!rap->resptracker) {
> +               resptracker =3D new0(struct cstracker, 1);
> +               cs_tracker_init(resptracker);
> +               rap->resptracker =3D resptracker;
> +       }
> +
> +       resptracker =3D rap->resptracker;
> +
> +       /* Basic fields */
> +       resptracker->config_id =3D data->config_id;
> +       resptracker->role =3D data->role;
> +       resptracker->rtt_type =3D data->rtt_type;
>  }
>
>  struct bt_rap *bt_rap_new(struct gatt_db *ldb, struct gatt_db *rdb)
> @@ -786,7 +2138,7 @@ bool bt_rap_attach(struct bt_rap *rap, struct bt_gat=
t_client *client)
>
>         bt_uuid16_create(&uuid, RAS_UUID16);
>
> -       gatt_db_foreach_service(rap->lrapdb->db, &uuid,
> +       gatt_db_foreach_service(rap->rrapdb->db, &uuid,
>                                 foreach_rap_service, rap);
>
>         return true;
> diff --git a/src/shared/rap.h b/src/shared/rap.h
> index 15ddea295..c9431aecd 100644
> --- a/src/shared/rap.h
> +++ b/src/shared/rap.h
> @@ -97,11 +97,11 @@ struct cs_mode_zero_data {
>
>  struct cs_mode_one_data {
>         uint8_t packet_quality;
> -       uint8_t packet_rssi_dbm;
> -       uint8_t packet_ant;
>         uint8_t packet_nadm;
> +       uint8_t packet_rssi_dbm;
>         int16_t toa_tod_init;
>         int16_t tod_toa_refl;
> +       uint8_t packet_ant;
>         struct pct_iq_sample packet_pct1;
>         struct pct_iq_sample packet_pct2;
>  };
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
