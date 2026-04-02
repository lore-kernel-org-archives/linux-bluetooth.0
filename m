Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9659C2248AF
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 15:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775143720; cv=pass; b=AgbCKPZ1A9JhVPVmO9k9mzrAIlz7738uxzpPZX3Ivz9QKADodsdHAeeReZcGfzhV4ZUewmKoee4XcLVTwx1E/qI/GB6g6fY4ka8vsIryaDkLbJO7OhK2O+KJ1EpDcP7Q+fP9JSxVNZ6UGAyYCGF9AFf783fAAXb+iiFKwR5Gl2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775143720; c=relaxed/simple;
	bh=KjuoemJkq3RW5QdFs3Dmox81WUf1MW4cWn7aS9vZOJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dURUwZARfHjx116QCXpn3hilzGSqW5rVOQ3NU80G1e8tbgcKkPoGNb+ZVda+ohyNAijIjXcKPINeLf/nA6JyKqW5XUt76b3BwoyCkjPzPQdjpS84Y6+mSSjcn0B+JQF5mXZDMIOq3V8pFoDdNSxGAMLhoNZj+j9Yfi1OEle3mX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLQ9nhLF; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLQ9nhLF"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-65003f40a22so526504d50.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Apr 2026 08:28:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775143718; cv=none;
        d=google.com; s=arc-20240605;
        b=jqXiKN4YINf4G4bl87TnfVbcoKEk4GM6dTjHt0oIT1NynLWpxnHwyC2vChiDOvx1lQ
         5G01cffCibrUo9rNl1RvYF6k800qGcfpQIKmGsdXEIQpbMi/W5k7C7hGTAC0S+OX1eUx
         aBmhnkpgwbWeHpfsxv3EMzJvuDrTwrdFNMiBKJuqODis3gT+UvJi23TXvbdduiboizt1
         HcCyJ+0qy7KS9qbZL5jDBgitkE3H0I7TyNZo/IWZrSZE0qBOZARrGnNRmQLXaAZ3Ki8q
         PXkH/8+0DhMWXg9QMHPG08yl9OhoZUvD/CtXq1xbsbAglDspOlzdnKThbi28ApkY4ZgO
         tBBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UNKz4F/HfgvcAPmRHwI/m7peq1PWiWFvnrtLQ4w24lc=;
        fh=8vmOwSm9QheBlSAtzpU2h+vPN6vqZAy+khabkFtSFIk=;
        b=A0u7Qttb29VRcKcO23ZwNelGZHWJ6ehTikbolYfeO7j2SqrxbWZLbr4WTp1FpGHtdK
         sK49vQzaGz+zoAfq3fdff64CujcPnc/53wdtlpbkjzVzdqN28pk89dp/edCcQyhgngfd
         /GrNUjVUDD+YwpSValnHKTuBcjN8nj4tk28gKMKDnmer6JuHNxOAeaR7vYDxLXZRDga/
         WlOL7ba5k9f74uzOIxcWXMbdX6qenIAFBDUYHnu8S3fDN9C9xYGrEHgxzol+GW9Zoajd
         YVIbgAig6oVQNWl1KhgkzXEkTDD+muwtZMdWkpK5DgLKq0/nisLuwRWULck9MpHH7u/e
         JFCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775143718; x=1775748518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNKz4F/HfgvcAPmRHwI/m7peq1PWiWFvnrtLQ4w24lc=;
        b=gLQ9nhLFZPacsycnCGnhA6DJTWXhWUWKwd7HRAYicW08V1nkSI1nVneMsYs4Dn2P+/
         G03NL7fnQ18dTXphElDeMkhu7A9r/QZZ6kgazCiAl6QOGM/1IZ/5q6uvsTgMOjf2BNBs
         gJPsQmV3WzfP2DVqrdsU7p4wSlv4X/jryljN+c5y64DxjKskNJb8UOnwKLTrtOBMFS7a
         MGswpqigVBnZnBu5gpqfWloP4+NCj20bCC2gxTM+sbfRq0FTs8NrC23x0y00Zry+w3aZ
         R2cG1aOPnLyMVjk1IggrWN7uSL3wQlZQkQ5owwHjHuq1oJlLARM2LJKFghHOmfgkXApz
         swjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775143718; x=1775748518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UNKz4F/HfgvcAPmRHwI/m7peq1PWiWFvnrtLQ4w24lc=;
        b=FTsCN32rK2/GJnh45qxPTkAam2boPgfhD5oejt853QlshFDJ07UGMRUldG5sOFFjv6
         T8QPaAsH0aUXjgU6O38kMiv9eowP5VlI/TopEjbtx8j/cPtY93/A6bSox8XVk41V5TO3
         nYR4Ywjx4UmUJ2fvTCiXXYc7MVhfKrYqChOzZlWHWcsGKAe0WXDniOfVD9HcPtgecp/W
         PsziH8D+fi/qku1iEWk27zKepKbFfPDQgTEmtOxw29jip6It5qrrk7W4B1ZFkFKc0tKW
         O678rftrjXYf4ljmU56cHHFzuN7I+RXEa+exBAllwA9HsyIfAAZe3s1G8UxgOGULTBK2
         LfNw==
X-Gm-Message-State: AOJu0YxZpncxCm4XDrVqMjhD22rMxOqq6PicCDj0HjPsNVPUo61TzqxP
	giVzTd2v3nYs/QhYmXzeYVLap0ff/azUeTX/QzHInOj2x6aeJW7mvI1IA9A9op1pRd5a7unhQUf
	7tKiYcJgHUHh26QZ0S1nHCT2482jhb/ApkztWYXs=
X-Gm-Gg: AeBDies+F4uhwGroDaYHktEn483LcHrfG+7D1yNz/cZgqoImn0NtWdsIBVbs7S2btEt
	tnkQcRL4KaBngzDwjQCdKszZaFDCVRbMS2aSGrIMpprel5IAfYH+h/OyUJh0/9nF1kbphtzJiMV
	1fB6xj23wxd7oPDZNb6O/xdfpSI99ywZuWlmKigyUuAF3SY762DchSWEBXJp4mZ7TnNtqvMlH5G
	9+hn8mDUZd05ARK+tTwOrrnioMe8TmCCQXBHNe9MMdxI8WAXgmhZXF5F6WchyajELyydTreFg4K
	Wx4nTl3IICQRzaFF2EyAyJP4kAcsrZvbeHQV/mraB2J8fM9EXD1Yumg=
X-Received: by 2002:a53:ac89:0:b0:64e:a2c4:a16a with SMTP id
 956f58d0204a3-6502fe83e84mr8338126d50.68.1775143717458; Thu, 02 Apr 2026
 08:28:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402103900.310778-1-naga.akella@oss.qualcomm.com> <20260402103900.310778-2-naga.akella@oss.qualcomm.com>
In-Reply-To: <20260402103900.310778-2-naga.akella@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 2 Apr 2026 11:28:25 -0400
X-Gm-Features: AQROBzDwWmIfl4bggCwE3oPkzvTQ65yCeNBdZfQ-8SLgP1d5oBy-B7afq1S5k_M
Message-ID: <CABBYNZJUp4gQBX7UZ1qJHZa8SW+Yrr47e35oE1qnZajv26HPwg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 1/3] shared: rap: Introduce Channel Sounding HCI
 raw interface support
To: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com, 
	prathibha.madugonde@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Naga,

On Thu, Apr 2, 2026 at 6:39=E2=80=AFAM Naga Bhavani Akella
<naga.akella@oss.qualcomm.com> wrote:
>
> Implement stub callbacks for Channel Sounding HCI events and add the
> required protocol definitions for CS configuration, procedure control,
> and subevent result parsing
>
> Add data structures to support Channel Sounding Processing
> ---
>  src/shared/rap.c |  46 +++++++++++++
>  src/shared/rap.h | 168 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 214 insertions(+)
>
> diff --git a/src/shared/rap.c b/src/shared/rap.c
> index 39ef3f278..a0ca6ca71 100644
> --- a/src/shared/rap.c
> +++ b/src/shared/rap.c
> @@ -504,6 +504,52 @@ bool bt_rap_unregister(unsigned int id)
>         return true;
>  }
>
> +void bt_rap_hci_cs_subevent_result_cont_callback(uint16_t length,
> +                                               const void *param,
> +                                               void *user_data)
> +{
> +       struct bt_rap *rap =3D user_data;
> +
> +       DBG(rap, "Received CS subevent CONT: len=3D%d", length);
> +}
> +
> +void bt_rap_hci_cs_subevent_result_callback(uint16_t length,
> +                                       const void *param,
> +                                       void *user_data)
> +{
> +       struct bt_rap *rap =3D user_data;
> +
> +       DBG(rap, "Received CS subevent: len=3D%d", length);
> +}
> +
> +void bt_rap_hci_cs_procedure_enable_complete_callback(uint16_t length,
> +                                               const void *param,
> +                                               void *user_data)
> +{
> +       struct bt_rap *rap =3D user_data;
> +
> +       DBG(rap, "Received CS procedure enable complete subevent: len=3D%=
d",
> +           length);
> +}
> +
> +void bt_rap_hci_cs_sec_enable_complete_callback(uint16_t length,
> +                                                const void *param,
> +                                                void *user_data)
> +{
> +       struct bt_rap *rap =3D user_data;
> +
> +       DBG(rap, "Received CS security enable subevent: len=3D%d", length=
);
> +}
> +
> +void bt_rap_hci_cs_config_complete_callback(uint16_t length,
> +                                       const void *param,
> +                                       void *user_data)
> +{
> +       struct bt_rap *rap =3D user_data;
> +
> +       DBG(rap, "Received CS config complete subevent: len=3D%d", length=
);
> +}
> +
>  struct bt_rap *bt_rap_new(struct gatt_db *ldb, struct gatt_db *rdb)
>  {
>         struct bt_rap *rap;
> diff --git a/src/shared/rap.h b/src/shared/rap.h
> index a1d1ff2ae..5bd45a65d 100644
> --- a/src/shared/rap.h
> +++ b/src/shared/rap.h
> @@ -9,9 +9,154 @@
>  #include <inttypes.h>
>
>  #include "src/shared/io.h"
> +#include "lib/bluetooth/mgmt.h"

Do we still need the mgmt.h?

> +#include "src/shared/hci.h"
>
>  struct bt_rap;
>
> +/* Channel Sounding Events */
> +struct bt_rap_hci_cs_options {
> +       uint8_t role;
> +       uint8_t cs_sync_ant_sel;
> +       int8_t max_tx_power;
> +       int rtt_type;
> +};
> +
> +#define CS_MODE_ZERO                           0x00
> +#define CS_MODE_ONE                            0x01
> +#define CS_MODE_TWO                            0x02
> +#define CS_MODE_THREE                          0x03
> +
> +#define CS_REFLECTOR                   0x01
> +#define CS_INITIATOR                   0x00
> +
> +#define CS_MAX_ANT_PATHS                       0x05
> +#define CS_MAX_STEPS                   0xA0
> +#define CS_MAX_STEP_DATA_LEN           0xFF
> +
> +struct rap_ev_cs_config_cmplt {
> +       uint8_t status;
> +       uint16_t conn_hdl;
> +       uint8_t config_id;
> +       uint8_t action;
> +       uint8_t main_mode_type;
> +       uint8_t sub_mode_type;
> +       uint8_t min_main_mode_steps;
> +       uint8_t max_main_mode_steps;
> +       uint8_t main_mode_rep;
> +       uint8_t mode_0_steps;
> +       uint8_t role;
> +       uint8_t rtt_type;
> +       uint8_t cs_sync_phy;
> +       uint8_t channel_map[10];
> +       uint8_t channel_map_rep;
> +       uint8_t channel_sel_type;
> +       uint8_t ch3c_shape;
> +       uint8_t ch3c_jump;
> +       uint8_t reserved;
> +       uint8_t t_ip1_time;
> +       uint8_t t_ip2_time;
> +       uint8_t t_fcs_time;
> +       uint8_t t_pm_time;
> +} __packed;
> +
> +struct rap_ev_cs_sec_enable_cmplt {
> +       uint8_t status;
> +       uint16_t conn_hdl;
> +} __packed;
> +
> +struct rap_ev_cs_proc_enable_cmplt {
> +       uint8_t status;
> +       uint16_t conn_hdl;
> +       uint8_t config_id;
> +       uint8_t state;
> +       uint8_t tone_ant_config_sel;
> +       int8_t sel_tx_pwr;
> +       uint8_t sub_evt_len[3];
> +       uint8_t sub_evts_per_evt;
> +       uint16_t sub_evt_intrvl;
> +       uint16_t evt_intrvl;
> +       uint16_t proc_intrvl;
> +       uint16_t proc_counter;
> +       uint16_t max_proc_len;
> +} __packed;
> +
> +#define CS_MAX_STEPS                   0xA0
> +
> +struct pct_iq_sample {
> +       int16_t i_sample;
> +       int16_t q_sample;
> +} __packed;
> +
> +struct cs_mode_zero_data {
> +       uint8_t packet_quality;
> +       uint8_t packet_rssi_dbm;
> +       uint8_t packet_ant;
> +       uint32_t init_measured_freq_offset;
> +} __packed;
> +
> +struct cs_mode_one_data {
> +       uint8_t packet_quality;
> +       uint8_t packet_rssi_dbm;
> +       uint8_t packet_ant;
> +       uint8_t packet_nadm;
> +       int16_t toa_tod_init;
> +       int16_t tod_toa_refl;
> +       struct pct_iq_sample packet_pct1;
> +       struct pct_iq_sample packet_pct2;
> +} __packed;
> +
> +struct cs_mode_two_data {
> +       uint8_t ant_perm_index;
> +       struct pct_iq_sample tone_pct[4];
> +       uint8_t tone_quality_indicator[4];
> +} __packed;
> +
> +struct cs_mode_three_data {
> +       struct cs_mode_one_data mode_one_data;
> +       struct cs_mode_two_data mode_two_data;
> +} __packed;
> +
> +union cs_mode_data {
> +       struct cs_mode_zero_data mode_zero_data;
> +       struct cs_mode_one_data mode_one_data;
> +       struct cs_mode_two_data mode_two_data;
> +       struct cs_mode_three_data mode_three_data;
> +};
> +
> +struct cs_step_data {
> +       uint8_t step_mode;
> +       uint8_t step_chnl;
> +       uint8_t step_data_length;
> +       union cs_mode_data step_mode_data;
> +} __packed;
> +
> +struct rap_ev_cs_subevent_result {
> +       uint16_t conn_hdl;
> +       uint8_t config_id;
> +       uint16_t start_acl_conn_evt_counter;
> +       uint16_t proc_counter;
> +       uint16_t freq_comp;
> +       uint8_t ref_pwr_lvl;
> +       uint8_t proc_done_status;
> +       uint8_t subevt_done_status;
> +       uint8_t abort_reason;
> +       uint8_t num_ant_paths;
> +       uint8_t num_steps_reported;
> +       struct cs_step_data step_data[];
> +} __packed;
> +
> +struct rap_ev_cs_subevent_result_cont {
> +       uint16_t conn_hdl;
> +       uint8_t config_id;
> +       uint8_t proc_done_status;
> +       uint8_t subevt_done_status;
> +       uint8_t abort_reason;
> +       uint8_t num_ant_paths;
> +       uint8_t num_steps_reported;
> +       struct cs_step_data step_data[];
> +} __packed;
> +
>  typedef void (*bt_rap_debug_func_t)(const char *str, void *user_data);
>  typedef void (*bt_rap_ready_func_t)(struct bt_rap *rap, void *user_data)=
;
>  typedef void (*bt_rap_destroy_func_t)(void *user_data);
> @@ -43,3 +188,26 @@ bool bt_rap_ready_unregister(struct bt_rap *rap, unsi=
gned int id);
>  bool bt_rap_unregister(unsigned int id);
>
>  struct bt_rap *bt_rap_new(struct gatt_db *ldb, struct gatt_db *rdb);
> +
> +/* HCI Raw Channel Approach */
> +void bt_rap_hci_cs_config_complete_callback(uint16_t length,
> +                                            const void *param,
> +                                            void *user_data);
> +void bt_rap_hci_cs_sec_enable_complete_callback(uint16_t length,
> +                                                const void *param,
> +                                                void *user_data);
> +void bt_rap_hci_cs_procedure_enable_complete_callback(uint16_t length,
> +                                                     const void *param,
> +                                                     void *user_data);
> +void bt_rap_hci_cs_subevent_result_callback(uint16_t length,
> +                                            const void *param,
> +                                            void *user_data);
> +void bt_rap_hci_cs_subevent_result_cont_callback(uint16_t length,
> +                                                 const void *param,
> +                                                 void *user_data);
> +
> +void bt_rap_hci_set_le_bcs_options(uint8_t role, uint8_t cs_sync_ant_sel=
,
> +                                  int8_t max_tx_power);
> +
> +bool bt_rap_attach_hci(struct bt_rap *rap, struct bt_hci *hci);
> +void bt_rap_hci_sm_cleanup(void);
> --
>


--=20
Luiz Augusto von Dentz
