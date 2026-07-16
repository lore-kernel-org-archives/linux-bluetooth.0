Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7546C35979
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 16:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784221160; cv=pass; b=eK/IhWj1Cc2TGmIDpOVZQnpPrT1DG7QAvGgCVOUct25QvvYGBbPImKOYW1K+vzTsvkTaDTXnWhgXYsXxNFEG+mncavaMh7gsbOOUzZEBGNoDN1/cmI23inZT3i8v4UxJJ0+HVOynJMNgFeOkW+wInk41UD+EntusYBOcOTT2SvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784221160; c=relaxed/simple;
	bh=WqpvixR8Chv9tSBHMmGQ4mKMvqxXmC13ev0ip36jv9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gR1FlgZ7nb4NRmK/laRZweiX39JaXLSu8STDjCvpoxBAjU6ls5XocqxT6Af70zKN8lPHUj/mx0yanm2wwHe1Hjh2rufSESan/TEFiBjyeu+0WzswJ3qql3Z5EJRomHq0C2Kp3D+iXY66ZPvJbc7Vbt2vT7xXj6mLJJHj+7Pvg0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lsAulUWQ; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsAulUWQ"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-80a123ef90aso16279697b3.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 09:59:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784221150; cv=none;
        d=google.com; s=arc-20260327;
        b=PPB5R0uTMFdAoPYPwasMQYnCy32SlO+5Xrf2dODyZSOgH6Tz6IYDkmPtR9TUKzqihF
         x33DQZTSKsb806nj7YKM45iSfxFhyzIw7WU8LE05BM2rBxVo0NpRO8Td47N7r0q3kVzq
         sJGBnCBD6L+SCZcZYNkzOFEjvIA7gn1E9pEb+JB0TeMeJFW7CT776Zm7pUh3PpRG+0vU
         IzZbyjdrwAAWKQrSL/0N1HAQemt2rRQ46f+Gfngpjzc5ryAazTVLFM/82Sqt9PXBTfil
         Cz1e2PwpJSFs8zBRUPjZ9mDuBHcab94eMzygcfXmJSsEMzssq7n+ggPw8QfDRgJrdJnB
         7Kuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PCF3rYJKWsY0Xz4j8Mv/HUbsVmBglZ/ANquM5NDn2Ks=;
        fh=jBLUrRQ7ZsNUcAcd5QG5N83k8jhBNkoqDFBeOlOjxqk=;
        b=nJCQSc8tULPKRgPwNYxncEx9Gs0O+K8IRKPcUHgHPJEpeWL4nZWHPLz4AWhBoy0+VT
         E8YdyB54QvXCrlHk/PTdMl8QKGxraamW3+VLFLwvXsmtGJ7E1VKr1Uort9b96JykvnvX
         gH1Lwba42yg01lwmoP7XYI/3dubtxeuIIYamnoFiMPu111GqwY6YlEDBJmbwC4wBJw90
         HqNLBHFTz/tgCFWzSnQbKqoSbGUzV5HT1U+vwodm6TNKniar6Mhn705oK/gUtEIw2IT/
         jIm/Nz6t5LVhffuCRdjLV3spNurWBIXqrg7QWoBUGu+OQDs09YAVHuBSxSgBTUiSEqV5
         90ug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784221150; x=1784825950; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PCF3rYJKWsY0Xz4j8Mv/HUbsVmBglZ/ANquM5NDn2Ks=;
        b=lsAulUWQc9GcTabX6QLc2Vgz0/glg+vMDwhIYB35ERkhmqAKR3aZQDWdKfET6SB6wF
         rK2MRCYL2BLRFgbbQ56DejPmgP0mbOtxVWHEL6Z/Z39v7Sz9UeTkDNQjpyR31f5fo5FT
         2FHNUCKL6NBG3owvz+4WU/T1IscZdr/IapjjMFdbz6U7hiXwr1+35lQezklFBpZDkvyy
         UDEnXB9UMkkBRwgrYFcIKjmfGTUAjIUpPyeFoqDaPyctWxdKrcfKOHtHc7+he6qQAKEA
         Nfr+3nFTtKz8PxWATtPkhnU5Rry5t5jRWt8OS/IeahM22PckGb7Q4vs6SwnrPoi4vVnA
         8kaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784221150; x=1784825950;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PCF3rYJKWsY0Xz4j8Mv/HUbsVmBglZ/ANquM5NDn2Ks=;
        b=f1xg3EVXb2+AHSEIU6dXHUWHcpMOpiyhAz8nK5QDSD1Igu3dHEvgjpAqi19uNHx/pk
         aPphps0h8FuuRJWWW+pPAKQDkVywoR2AHtG0lWq6HPZ+JDw8qtsXYO6xiNILrlULmVyR
         ayXCGP7rrM7xzB8SODjNr3jmyqt3XviaMCaUXQBDaP8eaikjun+xKccZQ/UDIJqmEX/p
         witOKEimcxq0f5DCu62tOYb13qjCHDZUS10pLbW/GxsM4oPmIW2YRjqV9G6beNz6ha1+
         ObQwbFgvTzJxy20GqMRkUYeBqurEFSPZTuOqBQRX8q0HjHcgDs8r1d7Ja+A/me4N2GV/
         1tsQ==
X-Gm-Message-State: AOJu0Yz5yBWDhHXHqHtYbz2mHpJ0hOm22rVIC/0VbrydoKVBFSKYZaGL
	DZHYEeJqH/tAOfmorVdKT6hPPc+R+Bjv7KKnx+72IZ5XdC/D+fEty0U24rZu0tGcmPIN9aAyfgO
	je98DEdnxu+g2YIb/CmtyXnSx6qv7o9g=
X-Gm-Gg: AfdE7cnpmdIBxiPDZhhnE/1/hk1ZmWt9bpSfIEYouuRIp9HcLpRA2FEKQxq/j5bf6Zu
	6FoXWC22wGmADvpLGD+GXs07SQDfanr3VgCvBuyu5oHOFgbHQpNuVuWGzFkelUO7BjJMjyalEoN
	slLYGeKmFDpvWQpm/wAYoxyktkNg0tJfyedddtJMYJjK8bcw+61hItUTV2euep7wVcx7BrMv6IQ
	DiSfKY65fWRKhh6ltR3RRtwRcp6ee2DZMRfn9NnlBE2Ymecuj/k2cgg3uLRgeUgzAMOdNls/mfr
	nQH83zgwhKlEVfn2RpBXAeiZScLBusE8xeefp1isKbzk0e7P
X-Received: by 2002:a05:690c:2789:b0:7ef:9fd9:db07 with SMTP id
 00721157ae682-81ee280b004mr24373127b3.12.1784221149409; Thu, 16 Jul 2026
 09:59:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716141706.3640868-1-prathm@qti.qualcomm.com>
In-Reply-To: <20260716141706.3640868-1-prathm@qti.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 16 Jul 2026 12:58:58 -0400
X-Gm-Features: AUfX_mwO2W0QuA87EU_P2rTBFpXzQgZL9a2B70EKMaZN85WhFi7s9A24mmOyIsU
Message-ID: <CABBYNZK1rOiY9a9DHiH4woYez=VQ+OOcD72kX9WYGET8mvJD3A@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3] shared/rap: Add bcs_procedure_data aggregation
 and procedure data API
To: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prathibha,

On Thu, Jul 16, 2026 at 10:17=E2=80=AFAM Prathibha Madugonde
<prathibha.madugonde@oss.qualcomm.com> wrote:
>
> From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
>
> Define bcs_procedure_data to hold per-procedure CS results from both
> the local initiator and remote reflector, including subevent step data,
> selected TX powers, procedure enable config, CS config, sw_time values,
> and BLE connection interval.
>
> Add cs_proc_state with a 16-entry ring buffer in cstracker to track
> procedures keyed by procedure counter, accumulating results
> independently from each side until both report all-results-complete.
>
> Update parse_mode_{0,1,2,3}, parse_step, and parse_subevent_steps with
> output pointer parameters to capture remote reflector step data.
> Introduce parse_cs_local_initiator_data() to store local HCI subevent
> results, handling both initial and continuation events. Update
> parse_ras_data_segments() to route decoded RAS subevent data into the
> matching cs_proc_state as reflector results.
>
> Add bt_rap_set_procedure_data_cb() to register a callback fired once
> both local and remote results are complete for a given procedure.
> Add bt_rap_set_local_sw_time(), bt_rap_set_remote_sw_time(), and
> bt_rap_set_conn_interval() so callers such as rap_hci.c can supply the
> CS capability sw_time and connection interval required by upper-layer
> distance calculation algorithms.

Does this mean the spec is incomplete or something? The ACL connection
interval is known, but I have no idea what sw_time would be, is that a
timestamp? And if it is how would that be transported if it is not
part of RAP procedures?

If it is specific to the vendor algorithm it means it doesn't belong
to bt_rap, or RAP does allows to carry vendor specific information?
Even if does then we need to called what it is bt_rap_set_vendor_data,
or something like that, but that would mean the other side needs to
understand this information but I though the distance algorithm is
something only the initiator has to deal with, if both side needs to
negotiate this parameter it means they need to negotiate what
algorithm to use as well.

> Remove unwanted function rap_detached , fix for rap profile level
> disconnections
>
> Changes in V2:
>  Removed the block-scoped variable inside find_or_create_proc_state()
>  Replaced the fixed 16-entry proc_states[] array with a struct queue *
>   of heap-allocated cs_proc_state entries
> ---
>  src/shared/rap.c | 673 ++++++++++++++++++++++++++++++++++++++++++++---
>  src/shared/rap.h |  47 ++++
>  2 files changed, 684 insertions(+), 36 deletions(-)
>
> diff --git a/src/shared/rap.c b/src/shared/rap.c
> index dfb272d3a..eadc41707 100644
> --- a/src/shared/rap.c
> +++ b/src/shared/rap.c
> @@ -12,6 +12,8 @@
>  #include <stdbool.h>
>  #include <unistd.h>
>  #include <errno.h>
> +#include <time.h>
> +#include <glib.h>
>
>  #include "bluetooth/bluetooth.h"
>  #include "bluetooth/hci.h"
> @@ -151,6 +153,16 @@ static inline uint8_t ranging_header_get_antenna_mas=
k(
>         return hdr->antenna_pct & 0x0F;
>  }
>
> +static inline uint16_t ranging_header_get_counter(
> +                                       const struct ranging_header *hdr)
> +{
> +       if (!hdr)
> +               return 0;
> +
> +       return (uint16_t)(hdr->counter_config[0] |
> +                         ((hdr->counter_config[1] & 0x0F) << 8));
> +}
> +
>  static inline uint8_t antenna_mask_count_paths(uint8_t antenna_mask)
>  {
>         uint8_t count =3D 0;
> @@ -206,11 +218,23 @@ enum cs_role {
>  };
>
>  #define CS_INVALID_CONFIG_ID   0xFF
> +#define CS_RANGING_COUNTER_MASK   0x0FFF
> +
>  /* Minimal enums (align to controller values if needed) */
>  enum cs_procedure_done_status {
>         CS_PROC_ALL_RESULTS_COMPLETE =3D 0x00,
>         CS_PROC_PARTIAL_RESULTS      =3D 0x01,
> -       CS_PROC_ABORTED              =3D 0x02
> +       CS_PROC_ABORTED              =3D 0x0F
> +};
> +
> +/* Per-procedure tracking =E2=80=94 one entry per HCI procedure counter =
*/
> +struct cs_proc_state {
> +       uint16_t proc_counter;
> +       struct bcs_procedure_data bcs_data;
> +       enum cs_procedure_done_status local_status;
> +       bool                          local_has_complete_subevent;
> +       enum cs_procedure_done_status remote_status;
> +       bool                          remote_has_complete_subevent;
>  };
>
>  /* Main cs_procedure_data  */
> @@ -253,6 +277,12 @@ struct cstracker {
>         struct ranging_header   ranging_header_;
>         /* Client - subsequent segments appended using iovec */
>         struct iovec segment_data;
> +
> +       /* Session-level config template and per-procedure state */
> +       struct bcs_procedure_data     bcs_proc_data;
> +       struct queue                  *proc_states;
> +       uint8_t                       procedure_sequence_after_enable;
> +       uint64_t                      proc_start_timestamp_nanos;
>  };
>
>  /* Ranging Service context */
> @@ -300,6 +330,15 @@ struct bt_rap {
>         bt_rap_destroy_func_t debug_destroy;
>         void *debug_data;
>         void *user_data;
> +
> +       bt_rap_procedure_data_func_t  procedure_data_cb;
> +       bt_rap_destroy_func_t         procedure_data_destroy;
> +       void                         *procedure_data_user_data;
> +
> +       /* CS capabilities sw_time and connection interval for config par=
am */
> +       uint8_t local_sw_time;
> +       uint8_t remote_sw_time;
> +       uint16_t conn_interval;
>         struct cstracker *resptracker;
>         struct cstracker *reqtracker;
>  };
> @@ -542,6 +581,177 @@ static bool cs_pd_ras_commit_subevent(struct cs_pro=
cedure_data *d,
>         return true;
>  }
>
> +/* ---------- bcs_procedure_data helpers -------------------------------=
---- */
> +static uint64_t get_time_nanos(void)
> +{
> +       struct timespec ts;
> +
> +       clock_gettime(CLOCK_REALTIME, &ts);
> +       return (uint64_t)ts.tv_sec * 1000000000ULL + ts.tv_nsec;
> +}
> +
> +static void bcs_proc_data_clear(struct bcs_procedure_data *proc)
> +{
> +       uint32_t i;
> +
> +       if (!proc)
> +               return;
> +
> +       for (i =3D 0; i < proc->initiator_subevent_count; i++)
> +               free(proc->initiator_subevent_results[i].step_data);
> +       free(proc->initiator_subevent_results);
> +       proc->initiator_subevent_results =3D NULL;
> +       proc->initiator_subevent_count =3D 0;
> +
> +       for (i =3D 0; i < proc->reflector_subevent_count; i++)
> +               free(proc->reflector_subevent_results[i].step_data);
> +       free(proc->reflector_subevent_results);
> +       proc->reflector_subevent_results =3D NULL;
> +       proc->reflector_subevent_count =3D 0;
> +}
> +
> +static bool bcs_proc_data_add_initiator_subevent(
> +                                       struct bcs_procedure_data *proc,
> +                                       uint16_t start_acl_evt,
> +                                       uint16_t freq_comp,
> +                                       int8_t ref_pwr,
> +                                       uint8_t num_ant_paths,
> +                                       uint8_t abort_reason,
> +                                       uint64_t timestamp_nanos,
> +                                       struct cs_step_data *steps,
> +                                       uint32_t num_steps)
> +{
> +       struct cs_subevent_result_data *arr;
> +       uint32_t new_count;
> +
> +       if (!proc)
> +               return false;
> +
> +       new_count =3D proc->initiator_subevent_count + 1;
> +       arr =3D realloc(proc->initiator_subevent_results,
> +                                       new_count * sizeof(*arr));
> +       if (!arr) {
> +               free(steps);
> +               return false;
> +       }
> +
> +       arr[new_count - 1].start_acl_conn_evt_counter =3D start_acl_evt;
> +       arr[new_count - 1].freq_comp =3D freq_comp;
> +       arr[new_count - 1].ref_pwr_lvl =3D ref_pwr;
> +       arr[new_count - 1].num_ant_paths =3D num_ant_paths;
> +       arr[new_count - 1].subevent_abort_reason =3D abort_reason;
> +       arr[new_count - 1].timestamp_nanos =3D timestamp_nanos;
> +       arr[new_count - 1].num_steps =3D num_steps;
> +       arr[new_count - 1].step_data =3D steps;
> +
> +       proc->initiator_subevent_results =3D arr;
> +       proc->initiator_subevent_count =3D new_count;
> +       return true;
> +}
> +
> +static bool bcs_proc_data_add_reflector_subevent(
> +                                       struct bcs_procedure_data *proc,
> +                                       uint16_t start_acl_evt,
> +                                       uint16_t freq_comp,
> +                                       int8_t ref_pwr,
> +                                       uint8_t num_ant_paths,
> +                                       uint8_t abort_reason,
> +                                       uint64_t timestamp_nanos,
> +                                       struct cs_step_data *steps,
> +                                       uint32_t num_steps)
> +{
> +       struct cs_subevent_result_data *arr;
> +       uint32_t new_count;
> +
> +       if (!proc)
> +               return false;
> +
> +       new_count =3D proc->reflector_subevent_count + 1;
> +       arr =3D realloc(proc->reflector_subevent_results,
> +                                       new_count * sizeof(*arr));
> +       if (!arr) {
> +               free(steps);
> +               return false;
> +       }
> +
> +       arr[new_count - 1].start_acl_conn_evt_counter =3D start_acl_evt;
> +       arr[new_count - 1].freq_comp =3D freq_comp;
> +       arr[new_count - 1].ref_pwr_lvl =3D ref_pwr;
> +       arr[new_count - 1].num_ant_paths =3D num_ant_paths;
> +       arr[new_count - 1].subevent_abort_reason =3D abort_reason;
> +       arr[new_count - 1].timestamp_nanos =3D timestamp_nanos;
> +       arr[new_count - 1].num_steps =3D num_steps;
> +       arr[new_count - 1].step_data =3D steps;
> +
> +       proc->reflector_subevent_results =3D arr;
> +       proc->reflector_subevent_count =3D new_count;
> +       return true;
> +}
> +
> +static bool match_proc_counter(const void *data, const void *match_data)
> +{
> +       const struct cs_proc_state *s =3D data;
> +       uint16_t proc_counter =3D PTR_TO_UINT(match_data);
> +
> +       return s->proc_counter =3D=3D proc_counter;
> +}
> +
> +static void free_proc_state(void *data)
> +{
> +       struct cs_proc_state *s =3D data;
> +
> +       bcs_proc_data_clear(&s->bcs_data);
> +       free(s);
> +}
> +
> +static struct cs_proc_state *find_or_create_proc_state(struct cstracker =
*t,
> +                                                       uint16_t proc_cou=
nter)
> +{
> +       struct cs_proc_state *s;
> +
> +       s =3D queue_find(t->proc_states, match_proc_counter,
> +                                       UINT_TO_PTR(proc_counter));
> +       if (s)
> +               return s;
> +
> +       s =3D new0(struct cs_proc_state, 1);
> +       s->proc_counter  =3D proc_counter;
> +       s->local_status  =3D CS_PROC_PARTIAL_RESULTS;
> +       s->remote_status =3D CS_PROC_PARTIAL_RESULTS;
> +       /* Copy session-level config from template */
> +       s->bcs_data.proc_enable_config =3D t->bcs_proc_data.proc_enable_c=
onfig;
> +       s->bcs_data.cs_config =3D t->bcs_proc_data.cs_config;
> +       s->bcs_data.t_sw_time_us_supported_by_local =3D
> +                       t->bcs_proc_data.t_sw_time_us_supported_by_local;
> +       s->bcs_data.t_sw_time_us_supported_by_remote =3D
> +                       t->bcs_proc_data.t_sw_time_us_supported_by_remote=
;
> +       s->bcs_data.ble_conn_interval =3D t->bcs_proc_data.ble_conn_inter=
val;
> +       s->bcs_data.initiator_selected_tx_power =3D
> +                       t->bcs_proc_data.initiator_selected_tx_power;
> +       s->bcs_data.procedure_counter =3D proc_counter;
> +
> +       queue_push_tail(t->proc_states, s);
> +
> +       return s;
> +}
> +
> +static struct cs_proc_state *find_proc_state_for_ras(struct cstracker *t=
,
> +                                               uint16_t ranging_counter)
> +{
> +       const struct queue_entry *entry;
> +
> +       for (entry =3D queue_get_entries(t->proc_states); entry;
> +                                                       entry =3D entry->=
next) {
> +               struct cs_proc_state *s =3D entry->data;
> +
> +               if ((s->proc_counter & CS_RANGING_COUNTER_MASK) =3D=3D
> +                   ranging_counter)
> +                       return s;
> +       }
> +       return NULL;
> +}
> +/* ---------- end bcs helpers ------------------------------------------=
---- */
> +
>  static struct ras *rap_get_ras(struct bt_rap *rap)
>  {
>         if (!rap)
> @@ -556,14 +766,6 @@ static struct ras *rap_get_ras(struct bt_rap *rap)
>         return rap->rrapdb->ras;
>  }
>
> -static void rap_detached(void *data, void *user_data)
> -{
> -       struct bt_rap_cb *cb =3D data;
> -       struct bt_rap *rap =3D user_data;
> -
> -       cb->detached(rap, cb->user_data);
> -}
> -
>  void bt_rap_detach(struct bt_rap *rap)
>  {
>         if (!queue_remove(sessions, rap))
> @@ -572,8 +774,6 @@ void bt_rap_detach(struct bt_rap *rap)
>         bt_gatt_client_idle_unregister(rap->client, rap->idle_id);
>         bt_gatt_client_unref(rap->client);
>         rap->client =3D NULL;
> -
> -       queue_foreach(bt_rap_cbs, rap_detached, rap);
>  }
>
>  static void rap_db_free(void *data)
> @@ -608,15 +808,21 @@ static void rap_free(void *data)
>         rap_db_free(rap->rrapdb);
>
>         if (rap->resptracker) {
> +               free(rap->resptracker->segment_data.iov_base);
>                 free(rap->resptracker);
>                 rap->resptracker =3D NULL;
>         }
>
>         if (rap->reqtracker) {
> +               queue_destroy(rap->reqtracker->proc_states, free_proc_sta=
te);
> +               free(rap->reqtracker->segment_data.iov_base);
>                 free(rap->reqtracker);
>                 rap->reqtracker =3D NULL;
>         }
>
> +       if (rap->procedure_data_destroy)
> +               rap->procedure_data_destroy(rap->procedure_data_user_data=
);
> +
>         queue_destroy(rap->notify, free);
>         queue_destroy(rap->pending, NULL);
>         queue_destroy(rap->ready_cbs, rap_ready_free);
> @@ -702,6 +908,24 @@ bool bt_rap_set_debug(struct bt_rap *rap, bt_rap_deb=
ug_func_t func,
>         return true;
>  }
>
> +bool bt_rap_set_procedure_data_cb(struct bt_rap *rap,
> +                                 bt_rap_procedure_data_func_t cb,
> +                                 void *user_data,
> +                                 bt_rap_destroy_func_t destroy)
> +{
> +       if (!rap)
> +               return false;
> +
> +       if (rap->procedure_data_destroy)
> +               rap->procedure_data_destroy(rap->procedure_data_user_data=
);
> +
> +       rap->procedure_data_cb      =3D cb;
> +       rap->procedure_data_destroy =3D destroy;
> +       rap->procedure_data_user_data =3D user_data;
> +
> +       return true;
> +}
> +
>  static void cs_tracker_init(struct cstracker *t)
>  {
>         if (!t)
> @@ -716,6 +940,7 @@ static void cs_tracker_init(struct cstracker *t)
>         t->last_start_acl_conn_evt_counter =3D 0;
>         t->last_freq_comp =3D 0;
>         t->last_ref_pwr_lvl =3D 0;
> +       t->proc_states =3D queue_new();
>
>         /* Initialize ranging header using helper functions */
>         memset(&t->ranging_header_, 0, sizeof(t->ranging_header_));
> @@ -1804,12 +2029,180 @@ static void form_ras_data_with_cs_subevent_resul=
t_cont(struct bt_rap *rap,
>                 cont->step_data);
>  }
>
> +static void write_procedure_data_to_bcs_algo(struct bt_rap *rap,
> +                                            struct bcs_procedure_data *b=
cs)
> +{
> +       if (!rap || !bcs)
> +               return;
> +
> +       if (rap->reqtracker && rap->reqtracker->proc_start_timestamp_nano=
s) {
> +               uint64_t elapsed_nanos =3D get_time_nanos() -
> +                               rap->reqtracker->proc_start_timestamp_nan=
os;
> +               uint32_t k;
> +
> +               DBG(rap, "Procedure elapsed time: %llu nanos",
> +                   (unsigned long long)elapsed_nanos);
> +
> +               for (k =3D 0; k < bcs->initiator_subevent_count; k++)
> +                       bcs->initiator_subevent_results[k].timestamp_nano=
s =3D
> +                                                               elapsed_n=
anos;
> +               for (k =3D 0; k < bcs->reflector_subevent_count; k++)
> +                       bcs->reflector_subevent_results[k].timestamp_nano=
s =3D
> +                                                               elapsed_n=
anos;
> +       }
> +
> +       DBG(rap, "procedure_counter=3D%u sequence=3D%u "
> +           "init_tx_pwr=3D%d refl_tx_pwr=3D%d "
> +           "init_abort=3D%d refl_abort=3D%d "
> +           "init_subevents=3D%u refl_subevents=3D%u",
> +           bcs->procedure_counter, bcs->procedure_sequence,
> +           bcs->initiator_selected_tx_power,
> +           bcs->reflector_selected_tx_power,
> +           bcs->initiator_procedure_abort_reason,
> +           bcs->reflector_procedure_abort_reason,
> +           bcs->initiator_subevent_count,
> +           bcs->reflector_subevent_count);
> +
> +       if (rap->procedure_data_cb)
> +               rap->procedure_data_cb(rap, bcs,
> +                                      rap->procedure_data_user_data);
> +
> +       bcs_proc_data_clear(bcs);
> +}
> +
> +static void check_cs_procedure_complete(struct bt_rap *rap,
> +                                        struct cstracker *reqtracker,
> +                                        struct cs_proc_state *state)
> +{
> +       struct bcs_procedure_data *bcs =3D &state->bcs_data;
> +
> +       if (!rap->procedure_data_cb)
> +               return;
> +
> +       if (state->local_status !=3D CS_PROC_ALL_RESULTS_COMPLETE ||
> +           state->remote_status !=3D CS_PROC_ALL_RESULTS_COMPLETE) {
> +               DBG(rap, "Procedure not complete: local=3D%d remote=3D%d"=
,
> +                   state->local_status, state->remote_status);
> +               return;
> +       }
> +
> +       if (!state->local_has_complete_subevent &&
> +           !state->remote_has_complete_subevent) {
> +               DBG(rap, "No complete subevent available");
> +               return;
> +       }
> +
> +       reqtracker->procedure_sequence_after_enable++;
> +       bcs->procedure_sequence =3D reqtracker->procedure_sequence_after_=
enable;
> +       write_procedure_data_to_bcs_algo(rap, bcs);
> +
> +       queue_remove(reqtracker->proc_states, state);
> +       free(state);
> +}
> +
> +static void parse_cs_local_initiator_data(struct bt_rap *rap,
> +                                       bool has_header_fields,
> +                                       uint8_t config_id,
> +                                       uint8_t num_ant_paths,
> +                                       uint16_t proc_counter,
> +                                       uint16_t start_acl_conn_evt_count=
er,
> +                                       uint16_t freq_comp,
> +                                       int8_t ref_pwr_lvl,
> +                                       uint8_t proc_done_status,
> +                                       uint8_t subevt_done_status,
> +                                       uint8_t abort_reason,
> +                                       uint8_t num_steps_reported,
> +                                       const struct cs_step_data *hci_st=
eps)
> +{
> +       struct cstracker *reqtracker =3D rap->reqtracker;
> +       uint16_t effective_counter;
> +       struct cs_proc_state *state;
> +       struct bcs_procedure_data *bcs;
> +
> +       effective_counter =3D has_header_fields ? proc_counter
> +                                             : reqtracker->last_proc_cou=
nter;
> +
> +       state =3D find_or_create_proc_state(reqtracker, effective_counter=
);
> +       if (!state)
> +               return;
> +
> +       bcs =3D &state->bcs_data;
> +
> +       bcs->initiator_selected_tx_power      =3D reqtracker->selected_tx=
_power;
> +       bcs->initiator_procedure_abort_reason =3D abort_reason & 0x0F;
> +
> +       state->local_status =3D
> +               (enum cs_procedure_done_status)(proc_done_status & 0x0F);
> +       if ((subevt_done_status & 0x0F) =3D=3D 0x00)
> +               state->local_has_complete_subevent =3D true;
> +
> +       if (has_header_fields) {
> +               struct cs_step_data *steps =3D NULL;
> +
> +               reqtracker->proc_start_timestamp_nanos =3D get_time_nanos=
();
> +
> +               bcs->procedure_counter        =3D proc_counter;
> +               reqtracker->last_proc_counter =3D proc_counter;
> +               reqtracker->last_start_acl_conn_evt_counter =3D
> +                                       start_acl_conn_evt_counter;
> +               reqtracker->last_freq_comp   =3D freq_comp;
> +               reqtracker->last_ref_pwr_lvl =3D ref_pwr_lvl;
> +
> +               if (num_steps_reported > 0 && hci_steps) {
> +                       steps =3D calloc(num_steps_reported, sizeof(*step=
s));
> +                       if (!steps)
> +                               return;
> +                       memcpy(steps, hci_steps,
> +                              num_steps_reported * sizeof(*steps));
> +               }
> +
> +               bcs_proc_data_add_initiator_subevent(bcs,
> +                               start_acl_conn_evt_counter,
> +                               freq_comp, ref_pwr_lvl,
> +                               num_ant_paths,
> +                               (abort_reason >> 4) & 0x0F,
> +                               0,
> +                               steps, num_steps_reported);
> +       } else {
> +               struct cs_subevent_result_data *last;
> +               struct cs_step_data *new_steps;
> +               uint32_t old_count, new_count;
> +
> +               if (!bcs->initiator_subevent_results ||
> +                   bcs->initiator_subevent_count =3D=3D 0)
> +                       return;
> +
> +               last =3D &bcs->initiator_subevent_results[
> +                                       bcs->initiator_subevent_count - 1=
];
> +               old_count =3D last->num_steps;
> +               new_count =3D old_count + num_steps_reported;
> +
> +               if (num_steps_reported > 0 && hci_steps) {
> +                       new_steps =3D realloc(last->step_data,
> +                                           new_count * sizeof(*new_steps=
));
> +                       if (!new_steps)
> +                               return;
> +
> +                       memcpy(&new_steps[old_count], hci_steps,
> +                              num_steps_reported * sizeof(*new_steps));
> +                       last->step_data =3D new_steps;
> +                       last->num_steps =3D new_count;
> +               }
> +
> +               last->subevent_abort_reason =3D (abort_reason >> 4) & 0x0=
F;
> +       }
> +
> +       check_cs_procedure_complete(rap, reqtracker, state);
> +}
> +
> +
>  static void fill_initiator_data_from_cs_subevent_result_cont(struct bt_r=
ap *rap,
>                 const struct rap_ev_cs_subevent_result_cont *cont,
>                 uint16_t length)
>  {
>         size_t base_len =3D offsetof(struct rap_ev_cs_subevent_result_con=
t,
>                                         step_data);
> +       struct cstracker *reqtracker;
>
>         if (!rap || !rap->reqtracker || !cont)
>                 return;
> @@ -1819,6 +2212,22 @@ static void fill_initiator_data_from_cs_subevent_r=
esult_cont(struct bt_rap *rap,
>
>         DBG(rap, "Received CS subevent result continue subevent: len=3D%u=
",
>                 length);
> +
> +       reqtracker =3D rap->reqtracker;
> +
> +       parse_cs_local_initiator_data(rap,
> +                               false,
> +                               cont->config_id,
> +                               cont->num_ant_paths,
> +                               reqtracker->last_proc_counter,
> +                               reqtracker->last_start_acl_conn_evt_count=
er,
> +                               reqtracker->last_freq_comp,
> +                               reqtracker->last_ref_pwr_lvl,
> +                               cont->proc_done_status,
> +                               cont->subevt_done_status,
> +                               cont->abort_reason,
> +                               cont->num_steps_reported,
> +                               cont->step_data);
>  }
>
>  static void fill_initiator_data_from_cs_subevent_result(struct bt_rap *r=
ap,
> @@ -1836,7 +2245,20 @@ static void fill_initiator_data_from_cs_subevent_r=
esult(struct bt_rap *rap,
>                 return;
>
>         DBG(rap, "Received CS subevent result subevent: len=3D%u", length=
);
> -       /* TODO: Store initiator subevent result data */
> +
> +       parse_cs_local_initiator_data(rap,
> +                               true,
> +                               data->config_id,
> +                               data->num_ant_paths,
> +                               data->proc_counter,
> +                               data->start_acl_conn_evt_counter,
> +                               data->freq_comp,
> +                               data->ref_pwr_lvl,
> +                               data->proc_done_status,
> +                               data->subevt_done_status,
> +                               data->abort_reason,
> +                               data->num_steps_reported,
> +                               data->step_data);
>  }
>
>  void bt_rap_hci_cs_subevent_result_cont_callback(uint16_t length,
> @@ -1880,6 +2302,7 @@ void bt_rap_hci_cs_procedure_enable_complete_callba=
ck(uint16_t length,
>         const struct rap_ev_cs_proc_enable_cmplt *data =3D param;
>         struct bt_rap *rap =3D user_data;
>         struct cstracker *resptracker;
> +       struct cstracker *reqtracker;
>
>         DBG(rap, "Received CS procedure enable complete subevent: len=3D%=
u",
>             length);
> @@ -1895,6 +2318,21 @@ void bt_rap_hci_cs_procedure_enable_complete_callb=
ack(uint16_t length,
>         /* Populate responder tracker */
>         resptracker->config_id =3D data->config_id;
>         resptracker->selected_tx_power =3D data->sel_tx_pwr;
> +
> +       if (!rap->reqtracker) {
> +               reqtracker =3D new0(struct cstracker, 1);
> +               cs_tracker_init(reqtracker);
> +               rap->reqtracker =3D reqtracker;
> +       }
> +
> +       reqtracker =3D rap->reqtracker;
> +       reqtracker->config_id =3D data->config_id;
> +       reqtracker->selected_tx_power =3D data->sel_tx_pwr;
> +       reqtracker->bcs_proc_data.initiator_selected_tx_power =3D
> +                                                       data->sel_tx_pwr;
> +
> +       /* Store procedure enable config in the session-level template */
> +       reqtracker->bcs_proc_data.proc_enable_config =3D *data;
>  }
>
>  void bt_rap_hci_cs_sec_enable_complete_callback(uint16_t length,
> @@ -1945,6 +2383,39 @@ void bt_rap_hci_cs_config_complete_callback(uint16=
_t length,
>         reqtracker->config_id =3D data->config_id;
>         reqtracker->role =3D data->role;
>         reqtracker->rtt_type =3D data->rtt_type;
> +       reqtracker->procedure_sequence_after_enable =3D 0;
> +
> +       /* Store cs_config in session-level template for procedure data *=
/
> +       reqtracker->bcs_proc_data.cs_config =3D *data;
> +       reqtracker->bcs_proc_data.t_sw_time_us_supported_by_local =3D
> +                                               rap->local_sw_time;
> +       reqtracker->bcs_proc_data.t_sw_time_us_supported_by_remote =3D
> +                                               rap->remote_sw_time;
> +       reqtracker->bcs_proc_data.ble_conn_interval =3D rap->conn_interva=
l;
> +}
> +
> +void bt_rap_set_local_sw_time(struct bt_rap *rap, uint8_t local_sw_time)
> +{
> +       if (!rap)
> +               return;
> +
> +       rap->local_sw_time =3D local_sw_time;
> +}
> +
> +void bt_rap_set_remote_sw_time(struct bt_rap *rap, uint8_t remote_sw_tim=
e)
> +{
> +       if (!rap)
> +               return;
> +
> +       rap->remote_sw_time =3D remote_sw_time;
> +}
> +
> +void bt_rap_set_conn_interval(struct bt_rap *rap, uint16_t conn_interval=
)
> +{
> +       if (!rap)
> +               return;
> +
> +       rap->conn_interval =3D conn_interval;
>  }
>
>  struct bt_rap *bt_rap_new(struct gatt_db *ldb, struct gatt_db *rdb)
> @@ -2122,7 +2593,8 @@ static size_t get_mode_zero_length(enum cs_role rem=
ote_role)
>  }
>
>  static void parse_mode_zero(struct bt_rap *rap, struct iovec *mode_iov,
> -                           enum cs_role remote_role)
> +                           enum cs_role remote_role,
> +                           struct cs_mode_zero_data *out)
>  {
>         uint8_t packet_quality;
>         int8_t packet_rssi_dbm;
> @@ -2143,7 +2615,12 @@ static void parse_mode_zero(struct bt_rap *rap, st=
ruct iovec *mode_iov,
>                 }
>         }
>
> -       /* TODO: Store this data as reflector data */
> +       if (out) {
> +               out->packet_quality =3D packet_quality;
> +               out->packet_rssi_dbm =3D (uint8_t)packet_rssi_dbm;
> +               out->packet_ant =3D packet_ant;
> +               out->init_measured_freq_offset =3D init_measured_freq_off=
set;
> +       }
>  }
>
>  static size_t get_mode_one_length(bool include_pct)
> @@ -2154,7 +2631,8 @@ static size_t get_mode_one_length(bool include_pct)
>  }
>
>  static void parse_mode_one(struct bt_rap *rap, struct iovec *mode_iov,
> -                          enum cs_role remote_role, bool include_pct)
> +                          enum cs_role remote_role, bool include_pct,
> +                          struct cs_mode_one_data *out)
>  {
>         uint8_t packet_quality;
>         uint8_t packet_nadm;
> @@ -2178,7 +2656,20 @@ static void parse_mode_one(struct bt_rap *rap, str=
uct iovec *mode_iov,
>                 parse_i_q_sample(mode_iov, &pct2_i, &pct2_q);
>         }
>
> -       /* TODO: Store this data as reflector data */
> +       if (out) {
> +               out->packet_quality =3D packet_quality;
> +               out->packet_nadm =3D packet_nadm;
> +               out->packet_rssi_dbm =3D (uint8_t)packet_rssi_dbm;
> +               out->packet_ant =3D packet_ant;
> +               if (remote_role =3D=3D CS_ROLE_REFLECTOR)
> +                       out->tod_toa_refl =3D time_value;
> +               else
> +                       out->toa_tod_init =3D time_value;
> +               out->packet_pct1.i_sample =3D pct1_i;
> +               out->packet_pct1.q_sample =3D pct1_q;
> +               out->packet_pct2.i_sample =3D pct2_i;
> +               out->packet_pct2.q_sample =3D pct2_q;
> +       }
>  }
>
>  static size_t get_mode_two_length(uint8_t num_antenna_paths)
> @@ -2189,7 +2680,8 @@ static size_t get_mode_two_length(uint8_t num_anten=
na_paths)
>  }
>
>  static void parse_mode_two(struct bt_rap *rap, struct iovec *mode_iov,
> -                          uint8_t num_antenna_paths)
> +                          uint8_t num_antenna_paths,
> +                          struct cs_mode_two_data *out)
>  {
>         uint8_t ant_perm_index;
>         int16_t tone_pct_i[5];
> @@ -2228,7 +2720,14 @@ static void parse_mode_two(struct bt_rap *rap, str=
uct iovec *mode_iov,
>         DBG(rap, "    cs_mode_two_data: ant_perm_idx=3D%u",
>                 ant_perm_index);
>
> -       /* TODO: Store this data as reflector data */
> +       if (out) {
> +               out->ant_perm_index =3D ant_perm_index;
> +               for (k =3D 0; k < num_paths; k++) {
> +                       out->tone_pct[k].i_sample =3D tone_pct_i[k];
> +                       out->tone_pct[k].q_sample =3D tone_pct_q[k];
> +                       out->tone_quality_indicator[k] =3D tone_quality[k=
];
> +               }
> +       }
>  }
>
>  static size_t get_mode_three_length(uint8_t num_antenna_paths, bool incl=
ude_pct)
> @@ -2239,13 +2738,17 @@ static size_t get_mode_three_length(uint8_t num_a=
ntenna_paths, bool include_pct)
>
>  static void parse_mode_three(struct bt_rap *rap, struct iovec *mode_iov,
>                              enum cs_role remote_role, bool include_pct,
> -                            uint8_t num_antenna_paths)
> +                            uint8_t num_antenna_paths,
> +                            struct cs_mode_three_data *out)
>  {
> +       struct cs_mode_one_data *out_m1 =3D out ? &out->mode_one_data : N=
ULL;
> +       struct cs_mode_two_data *out_m2 =3D out ? &out->mode_two_data : N=
ULL;
> +
>         /* Mode 3 =3D Mode 1 + Mode 2 */
> -       parse_mode_one(rap, mode_iov, remote_role, include_pct);
> +       parse_mode_one(rap, mode_iov, remote_role, include_pct, out_m1);
>
>         if (mode_iov->iov_len > 0)
> -               parse_mode_two(rap, mode_iov, num_antenna_paths);
> +               parse_mode_two(rap, mode_iov, num_antenna_paths, out_m2);
>  }
>
>  static bool parse_subevent_header(struct iovec *iov,
> @@ -2278,7 +2781,8 @@ static bool parse_subevent_header(struct iovec *iov=
,
>
>  static bool parse_step(struct bt_rap *rap, struct iovec *iov,
>                         struct cstracker *reqtracker,
> -                       uint8_t num_antenna_paths, uint8_t step_idx)
> +                       uint8_t num_antenna_paths, uint8_t step_idx,
> +                       struct cs_step_data *out_step)
>  {
>         uint8_t mode_byte, step_mode;
>         bool include_pct;
> @@ -2337,20 +2841,42 @@ static bool parse_step(struct bt_rap *rap, struct=
 iovec *iov,
>         mode_iov.iov_base =3D payload;
>         mode_iov.iov_len =3D step_payload_len;
>
> +       if (out_step) {
> +               out_step->step_mode =3D step_mode;
> +               out_step->step_chnl =3D 0;
> +               out_step->step_data_length =3D (uint8_t)step_payload_len;
> +       }
> +
>         switch (step_mode) {
> -       case CS_MODE_ZERO:
> -               parse_mode_zero(rap, &mode_iov, remote_role);
> +       case CS_MODE_ZERO: {
> +               struct cs_mode_zero_data *out =3D out_step ?
> +                       &out_step->step_mode_data.mode_zero_data : NULL;
> +
> +               parse_mode_zero(rap, &mode_iov, remote_role, out);
>                 break;
> -       case CS_MODE_ONE:
> -               parse_mode_one(rap, &mode_iov, remote_role, include_pct);
> +       }
> +       case CS_MODE_ONE: {
> +               struct cs_mode_one_data *out =3D out_step ?
> +                       &out_step->step_mode_data.mode_one_data : NULL;
> +
> +               parse_mode_one(rap, &mode_iov, remote_role, include_pct, =
out);
>                 break;
> -       case CS_MODE_TWO:
> -               parse_mode_two(rap, &mode_iov, num_antenna_paths);
> +       }
> +       case CS_MODE_TWO: {
> +               struct cs_mode_two_data *out =3D out_step ?
> +                       &out_step->step_mode_data.mode_two_data : NULL;
> +
> +               parse_mode_two(rap, &mode_iov, num_antenna_paths, out);
>                 break;
> -       case CS_MODE_THREE:
> +       }
> +       case CS_MODE_THREE: {
> +               struct cs_mode_three_data *out =3D out_step ?
> +                       &out_step->step_mode_data.mode_three_data : NULL;
> +
>                 parse_mode_three(rap, &mode_iov, remote_role, include_pct=
,
> -                                               num_antenna_paths);
> +                                       num_antenna_paths, out);
>                 break;
> +       }
>         default:
>                 break;
>         }
> @@ -2360,12 +2886,16 @@ static bool parse_step(struct bt_rap *rap, struct=
 iovec *iov,
>
>  static void parse_subevent_steps(struct bt_rap *rap, struct iovec *iov,
>                                 struct cstracker *reqtracker,
> -                               uint8_t num_antenna_paths, uint8_t num_st=
eps)
> +                               uint8_t num_antenna_paths, uint8_t num_st=
eps,
> +                               struct cs_step_data *out_steps)
>  {
>         uint8_t i;
>
>         for (i =3D 0; i < num_steps; i++) {
> -               if (!parse_step(rap, iov, reqtracker, num_antenna_paths, =
i))
> +               struct cs_step_data *out =3D out_steps ? &out_steps[i] : =
NULL;
> +
> +               if (!parse_step(rap, iov, reqtracker, num_antenna_paths, =
i,
> +                               out))
>                         break;
>         }
>  }
> @@ -2376,6 +2906,10 @@ static void parse_ras_data_segments(struct bt_rap =
*rap,
>         struct iovec iov;
>         uint8_t antenna_mask;
>         uint8_t num_antenna_paths;
> +       uint16_t ranging_counter;
> +       struct cs_proc_state *state =3D NULL;
> +       struct bcs_procedure_data *bcs =3D NULL;
> +       bool is_initiator;
>
>         if (!rap || !reqtracker)
>                 return;
> @@ -2387,10 +2921,30 @@ static void parse_ras_data_segments(struct bt_rap=
 *rap,
>                 ranging_header_get_antenna_mask(&reqtracker->ranging_head=
er_);
>         num_antenna_paths =3D antenna_mask_count_paths(antenna_mask);
>
> +       ranging_counter =3D
> +               ranging_header_get_counter(&reqtracker->ranging_header_);
> +
> +       /* Find the per-procedure state that matches this RAS counter */
> +       if (rap->procedure_data_cb) {
> +               state =3D find_proc_state_for_ras(reqtracker, ranging_cou=
nter);
> +               if (state) {
> +                       bcs =3D &state->bcs_data;
> +                       bcs->reflector_selected_tx_power =3D
> +                               reqtracker->ranging_header_.selected_tx_p=
ower;
> +               }
> +       }
> +
> +       /* When local role=3DINITIATOR, remote data goes to
> +        * reflector_subevent_results. When local role=3DREFLECTOR,
> +        * remote data goes to initiator_subevent_results.
> +        */
> +       is_initiator =3D (reqtracker->role =3D=3D CS_ROLE_INITIATOR);
> +
>         iov =3D reqtracker->segment_data;
>
>         while (iov.iov_len >=3D RAS_SUBEVENT_HEADER_SIZE) {
>                 struct ras_subevent_header hdr;
> +               struct cs_step_data *steps =3D NULL;
>
>                 if (!parse_subevent_header(&iov, &hdr))
>                         break;
> @@ -2402,19 +2956,66 @@ static void parse_ras_data_segments(struct bt_rap=
 *rap,
>                     hdr.reference_power_level,
>                     hdr.num_steps_reported);
>
> +               if (bcs && hdr.num_steps_reported > 0)
> +                       steps =3D calloc(hdr.num_steps_reported, sizeof(*=
steps));
> +
>                 parse_subevent_steps(rap, &iov, reqtracker,
>                                         num_antenna_paths,
> -                                       hdr.num_steps_reported);
> +                                       hdr.num_steps_reported,
> +                                       steps);
> +
> +               if (bcs) {
> +                       uint32_t stored_steps =3D
> +                                       steps ? hdr.num_steps_reported : =
0;
> +
> +                       if (is_initiator)
> +                               bcs_proc_data_add_reflector_subevent(bcs,
> +                                       hdr.start_acl_conn_event,
> +                                       hdr.frequency_compensation,
> +                                       hdr.reference_power_level,
> +                                       num_antenna_paths,
> +                                       hdr.subevent_abort_reason,
> +                                       0,
> +                                       steps, stored_steps);
> +                       else
> +                               bcs_proc_data_add_initiator_subevent(bcs,
> +                                       hdr.start_acl_conn_event,
> +                                       hdr.frequency_compensation,
> +                                       hdr.reference_power_level,
> +                                       num_antenna_paths,
> +                                       hdr.subevent_abort_reason,
> +                                       0,
> +                                       steps, stored_steps);
> +                       steps =3D NULL; /* ownership transferred */
> +               } else {
> +                       free(steps);
> +                       steps =3D NULL;
> +               }
>
> -               if (hdr.subevent_done_status =3D=3D
> -                   SUBEVENT_DONE_ALL_RESULTS_COMPLETE ||
> -                   hdr.ranging_done_status =3D=3D
> +               if (state) {
> +                       if (hdr.subevent_done_status =3D=3D
> +                           SUBEVENT_DONE_ALL_RESULTS_COMPLETE)
> +                               state->remote_has_complete_subevent =3D t=
rue;
> +                       if (hdr.ranging_done_status =3D=3D
> +                           RANGING_DONE_ALL_RESULTS_COMPLETE)
> +                               state->remote_status =3D
> +                                               CS_PROC_ALL_RESULTS_COMPL=
ETE;
> +               }
> +
> +               if (bcs && hdr.ranging_abort_reason)
> +                       bcs->reflector_procedure_abort_reason =3D
> +                                       hdr.ranging_abort_reason & 0x0F;
> +
> +               if (hdr.ranging_done_status =3D=3D
>                     RANGING_DONE_ALL_RESULTS_COMPLETE) {
>                         DBG(rap, "Ranging procedure complete");
>                         break;
>                 }
>         }
>
> +       if (state)
> +               check_cs_procedure_complete(rap, reqtracker, state);
> +
>         free(reqtracker->segment_data.iov_base);
>         reqtracker->segment_data.iov_base =3D NULL;
>         reqtracker->segment_data.iov_len =3D 0;
> diff --git a/src/shared/rap.h b/src/shared/rap.h
> index 7bc49f03d..e3f1cf994 100644
> --- a/src/shared/rap.h
> +++ b/src/shared/rap.h
> @@ -157,10 +157,45 @@ struct rap_ev_cs_subevent_result_cont {
>         struct cs_step_data step_data[];
>  };
>
> +struct cs_subevent_result_data {
> +       uint16_t             start_acl_conn_evt_counter;
> +       uint16_t             freq_comp;
> +       int8_t               ref_pwr_lvl;
> +       uint8_t              num_ant_paths;
> +       uint8_t              subevent_abort_reason;
> +       uint64_t             timestamp_nanos;
> +       uint32_t             num_steps;
> +       struct cs_step_data *step_data;
> +};
> +
> +struct bcs_procedure_data {
> +       uint16_t procedure_counter;
> +       uint16_t procedure_sequence;
> +
> +       int8_t   initiator_selected_tx_power;
> +       int8_t   reflector_selected_tx_power;
> +
> +       struct cs_subevent_result_data *initiator_subevent_results;
> +       uint32_t initiator_subevent_count;
> +       uint8_t  initiator_procedure_abort_reason;
> +
> +       struct cs_subevent_result_data *reflector_subevent_results;
> +       uint32_t reflector_subevent_count;
> +       uint8_t  reflector_procedure_abort_reason;
> +
> +       struct rap_ev_cs_proc_enable_cmplt proc_enable_config;
> +       struct rap_ev_cs_config_cmplt      cs_config;
> +       uint8_t  t_sw_time_us_supported_by_local;
> +       uint8_t  t_sw_time_us_supported_by_remote;
> +       uint16_t ble_conn_interval;
> +};
>  typedef void (*bt_rap_debug_func_t)(const char *str, void *user_data);
>  typedef void (*bt_rap_ready_func_t)(struct bt_rap *rap, void *user_data)=
;
>  typedef void (*bt_rap_destroy_func_t)(void *user_data);
>  typedef void (*bt_rap_func_t)(struct bt_rap *rap, void *user_data);
> +typedef void (*bt_rap_procedure_data_func_t)(struct bt_rap *rap,
> +                                       struct bcs_procedure_data *data,
> +                                       void *user_data);
>
>  struct bt_rap *bt_rap_ref(struct bt_rap *rap);
>  void bt_rap_unref(struct bt_rap *rap);
> @@ -177,6 +212,10 @@ bool bt_rap_set_user_data(struct bt_rap *rap, void *=
user_data);
>  bool bt_rap_set_debug(struct bt_rap *rap, bt_rap_debug_func_t func,
>                         void *user_data, bt_rap_destroy_func_t destroy);
>
> +bool bt_rap_set_procedure_data_cb(struct bt_rap *rap,
> +                               bt_rap_procedure_data_func_t cb,
> +                               void *user_data,
> +                               bt_rap_destroy_func_t destroy);
>  /* session related functions */
>  unsigned int bt_rap_register(bt_rap_func_t attached, bt_rap_func_t detac=
hed,
>                                         void *user_data);
> @@ -211,6 +250,10 @@ void *bt_rap_attach_hci(struct bt_rap *rap, struct b=
t_hci *hci,
>                         int8_t max_tx_power);
>  void bt_rap_detach_hci(struct bt_rap *rap, void *hci_sm);
>
> +bool bt_rap_hci_set_procedure_data_cb(void *hci_sm,
> +                               bt_rap_procedure_data_func_t cb,
> +                               void *user_data,
> +                               bt_rap_destroy_func_t destroy);
>  /* Connection handle mapping functions */
>  bool bt_rap_set_conn_hndl(void *hci_sm,
>                         struct bt_rap *rap,
> @@ -220,3 +263,7 @@ bool bt_rap_set_conn_hndl(void *hci_sm,
>                         bool is_central);
>
>  void bt_rap_clear_conn_handle(void *hci_sm, uint16_t handle);
> +/* CS capability sw_time and connection interval setters */
> +void bt_rap_set_local_sw_time(struct bt_rap *rap, uint8_t local_sw_time)=
;
> +void bt_rap_set_remote_sw_time(struct bt_rap *rap, uint8_t remote_sw_tim=
e);
> +void bt_rap_set_conn_interval(struct bt_rap *rap, uint16_t conn_interval=
);
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
