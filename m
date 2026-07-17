Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A350F32B10B
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 15:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784300875; cv=pass; b=a7lxQkCQOJgs3ItdtSx1qcGDhH5BaNzkH+Ib7qUHoiTLR4g9Yb3Jnz86U9D0nadyKRLtTisG3iocsxZLf9jWUoL4Ql0nueSL4gzuQyrDkohkVCQPY0V7H5y9zsyt9jVAs4BRS2Chrh1V4PVQ8B03z7XpOHezNZ4xdMOBcKa9Im0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784300875; c=relaxed/simple;
	bh=FmxeooaHhh5td33wQcyVb1aZD2MfPuZASULbYpqNCxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ChtwBXR7k4vbsh3WG+8o2llZXGanXcTmC8LV9x2ShcjIe6eHSNF6q73NLNyg4dVujQEyNDTYLSczpro4gXfHu+TNUrk29dawJZBelbA4APBV+QKA8ubG6qvizNVLlFvvqxdiskJF6r4X59aH9C75ypXOdxmZ6hDMfb6y/YMA5Fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VB/mZ5TN; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VB/mZ5TN"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-81062fdeaf5so17494297b3.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 08:07:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784300872; cv=none;
        d=google.com; s=arc-20260327;
        b=bdOx/XLFUY9gfs3BTp2zhGJWsM6Q5l3nDdzU7v22DbyYD8nEhaDMXmTTRV34MDubXW
         dNzlZguf6pamimfC0b/aretT03eJS61DrxIQ9SgKqBC/5lI/pwudEj4yV7wTc0RpgtA5
         jFwy309BAZAtyeHlUVXCje9gGTkJyW2vZJTt+vVy+35JPkIY5HrdZyElmlFQB60JYw/c
         Ukb+ji/EKUG8ZGskJcfRPKM+axxX9N5fFNdkdOYkZz1GezLgypUqk8+6CJg/GEbXhJMG
         iSEqvaMYD6LNzcZzStKELWMcljsPCrHeDnJS/b1EDIe5awWsDBvG3vSCbJI76y4v5HZM
         6Awg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EuIpp7ex5rX1koYV2fsG8wjMwoJtjHA7trUsoFQzM40=;
        fh=jBLUrRQ7ZsNUcAcd5QG5N83k8jhBNkoqDFBeOlOjxqk=;
        b=cN46AMipTHJoui/+XjmZvZZc/WAbQUMMU1oyrCPgp1uPiHVEzvhdmS2qcj+Wv835JC
         vPH56yMIBEIgB708Ll0L7qwprN/fFkOCLTNemt1LAt+cQN88PxOrt9Jybv9/PVecOPcW
         2xnlHnar6ColszxSTwKjfQWvEOtGwPYZ9GwiBnMeQi9KhLiojQ4MoFvfDBGrmgn7WnFc
         E1578yE5c546wRAjAaXEq/PZqGXkyIxm6lEivmzRD6pwAbXdp0KoQeazlfW5xk6lCJDY
         TKrFuJwXQlk1Be16VcBjX1VfGRXUXS3vJppzKizDiakqcZWDqDDCgvNrnTFqmYHu5bMR
         My4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784300872; x=1784905672; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EuIpp7ex5rX1koYV2fsG8wjMwoJtjHA7trUsoFQzM40=;
        b=VB/mZ5TNqtjPA/y7ti+pEHZoWNPNTvB8q+qVNKUeHOD8Nv7g8VKQCmGtCpC5zA0Rvv
         3BvCuHEOVmWtZDp8WAduaIIGLPNURvxBeUsOwSQRz1jT1hMWQVXrHlu+/dfcOXPtn/ug
         LxDLS8C8GgOKcz4Ekl8+/R7SznXYH0eBOjBk/x2Ymxics2jT7qnGOU4TOpJ5agEQ99j/
         T4I7qv1BnZVNuD7epJGe+Acceq/6flYeWyaRF45Z1AD6RLY8/OGOzra7NVv7bBPEL4zz
         x7PqOK4EaJR29HOOF8yOyruJICKBcIVlfNycLaSif8P8+ww6nF9s8niPuLDJYoxSKAgz
         LEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784300872; x=1784905672;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EuIpp7ex5rX1koYV2fsG8wjMwoJtjHA7trUsoFQzM40=;
        b=DvyByevMLn9CT2orEm2b1b/Bug28GkR3qmYw5PWl9TNotZdUGebLh9uJVsHlkRoQjl
         9CNUFPb6BfqfP6sKKdLHtyNqMcK78rwa6DNHR/+amyJN4Xy9EmrXpYySGh7Z+qvtRZiH
         PhG+os36rCYNpYnOPrh6PevnBHDh8/2TwNJpkDyxLApcv5rG5qd5oA1APpFPhwCkAC+6
         u/PQM5p1u3XfKFt5dXc4/aXeVf+wHl0ij5P6tvf6wyjWgKdz490lHOFAoyf6MSKYoDpi
         CwilGXjHoSbw/+36gwknbvUubYmatDV3yLRtSA7UWS4IQFiZngzOG45ryJtenbRdCDoC
         bcIQ==
X-Gm-Message-State: AOJu0Ywzq4jQoBFBqyLVWpJSGG8UetMGzC86AQVx2M6Rexbrp9oCFgDv
	hX5ZAwT56iNRVH7KVc3hqgqwwHRDttMvuZcGKRYYE3Hv5wqtJhGWso0GqjAcZ6vYgOdM/sNWaOb
	MeJgBuhybx2zp7Ph6EenOmdlsiYror4s=
X-Gm-Gg: AfdE7clIl/InYD1eADN8zd/AjhbuPb9vawv9IjOhNfTQP/TZoOoxtJgQJOyAbTsBxWy
	hBFfW9xK+vszO+yUF9tqZPzije6zuNvnFOVdmv570TsQhYBOwByOC53wAOpMf3QxfFyTAZj9wIa
	l9Qp3BsRuZ+gV/Mraba7yl/UZ1l49r9IIvgNfsWc6gZrEeEPFQu6dG2raWhdlE7Ozs2XPYxcgZD
	Q6x1/1KiCkhyrFjkiCGuxpDV/p2F8DLWbK3a5nhU0g2/9Fd1wXIkQt38j8R0B6TKluy0L5eM9ML
	Ix5NVzsJEhFigoE1gu5yWSQkn8EAyKiT7i/+35/+jtLHcnwGq84aIxEYVMM=
X-Received: by 2002:a05:690c:f06:b0:81e:b78d:688b with SMTP id
 00721157ae682-81ee280f13dmr45536957b3.12.1784300872360; Fri, 17 Jul 2026
 08:07:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717072647.255002-1-prathm@qti.qualcomm.com> <20260717072647.255002-3-prathm@qti.qualcomm.com>
In-Reply-To: <20260717072647.255002-3-prathm@qti.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 17 Jul 2026 11:07:40 -0400
X-Gm-Features: AUfX_mzrGp2dtU3CESmacBjYSECHrTcdMpS1U8B3dhKa6GIYpPi1I1D41Nbev3k
Message-ID: <CABBYNZ++i-JNcjCz5PG5JKNf9aWgMkm05i4-m7b5TPhTdMmojg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 2/2] profiles/ranging: Add D-Bus ProcedureData
 signal for Channel Sounding
To: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prathibha,

On Fri, Jul 17, 2026 at 3:27=E2=80=AFAM Prathibha Madugonde
<prathibha.madugonde@oss.qualcomm.com> wrote:
>
> From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
>
> Marshal bcs_procedure_data (subevents, steps, mode 0/1/2/3 results,
> and CS/procedure-enable config) into an a{sv} dictionary and emit it
> as a new ProcedureData signal on the CS D-Bus interface.

Was this documented though? It doesn't seem to follow the likes of
https://github.com/bluez/bluez/blob/master/doc/org.bluez.ChannelSounding1.r=
st,
for instance we don't use camel case for dictionary options. Also, if
this is a result of `StartMeasurement`, we should probably signal it
as Results or something like that, but I'd start with documentation so
we can agree on the overall design.

> Register a procedure_data callback on the RAP HCI state machine so
> rap.c is notified when a procedure completes, and propagate the
> locally supported T_SW time capability from the read-local-supported-
> capabilities response into bt_rap.
>
> ---
>  profiles/ranging/rap.c     | 497 ++++++++++++++++++++++++++++++++++++-
>  profiles/ranging/rap_hci.c |  59 +++++
>  2 files changed, 555 insertions(+), 1 deletion(-)
>
> diff --git a/profiles/ranging/rap.c b/profiles/ranging/rap.c
> index 3ffc0da76..42e1ef2a4 100644
> --- a/profiles/ranging/rap.c
> +++ b/profiles/ranging/rap.c
> @@ -379,6 +379,492 @@ static const struct cs_dict_param_desc *cs_find_dic=
t_param_desc(
>         return NULL;
>  }
>
> +static void dict_append_byte(DBusMessageIter *dict, const char *key,
> +                               uint8_t val)
> +{
> +       DBusMessageIter entry, variant;
> +
> +       dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY, NULL=
,
> +                                               &entry);
> +       dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
> +       dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT, "y",
> +                                               &variant);
> +       dbus_message_iter_append_basic(&variant, DBUS_TYPE_BYTE, &val);
> +       dbus_message_iter_close_container(&entry, &variant);
> +       dbus_message_iter_close_container(dict, &entry);
> +}
> +
> +static void dict_append_int32(DBusMessageIter *dict, const char *key,
> +                               dbus_int32_t val)
> +{
> +       DBusMessageIter entry, variant;
> +
> +       dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY, NULL=
,
> +                                               &entry);
> +       dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
> +       dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT, "i",
> +                                               &variant);
> +       dbus_message_iter_append_basic(&variant, DBUS_TYPE_INT32, &val);
> +       dbus_message_iter_close_container(&entry, &variant);
> +       dbus_message_iter_close_container(dict, &entry);
> +}
> +
> +static void dict_append_uint32(DBusMessageIter *dict, const char *key,
> +                               dbus_uint32_t val)
> +{
> +       DBusMessageIter entry, variant;
> +
> +       dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY, NULL=
,
> +                                               &entry);
> +       dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
> +       dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT, "u",
> +                                               &variant);
> +       dbus_message_iter_append_basic(&variant, DBUS_TYPE_UINT32, &val);
> +       dbus_message_iter_close_container(&entry, &variant);
> +       dbus_message_iter_close_container(dict, &entry);
> +}
> +
> +static void dict_append_uint64(DBusMessageIter *dict, const char *key,
> +                               dbus_uint64_t val)
> +{
> +       DBusMessageIter entry, variant;
> +
> +       dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY, NULL=
,
> +                                               &entry);
> +       dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
> +       dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT, "t",
> +                                               &variant);
> +       dbus_message_iter_append_basic(&variant, DBUS_TYPE_UINT64, &val);
> +       dbus_message_iter_close_container(&entry, &variant);
> +       dbus_message_iter_close_container(dict, &entry);
> +}
> +
> +static void dict_append_byte_array(DBusMessageIter *dict, const char *ke=
y,
> +                                       const uint8_t *data, int len)
> +{
> +       DBusMessageIter entry, variant, arr;
> +       int i;
> +
> +       dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY, NULL=
,
> +                                               &entry);
> +       dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
> +       dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT, "ay",
> +                                               &variant);
> +       dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY, "y", =
&arr);
> +       for (i =3D 0; i < len; i++)
> +               dbus_message_iter_append_basic(&arr, DBUS_TYPE_BYTE, &dat=
a[i]);
> +       dbus_message_iter_close_container(&variant, &arr);
> +       dbus_message_iter_close_container(&entry, &variant);
> +       dbus_message_iter_close_container(dict, &entry);
> +}
> +
> +static void append_mode_zero(DBusMessageIter *dict,
> +                               const struct cs_mode_zero_data *m0)
> +{
> +       dict_append_byte(dict, "packetQuality", m0->packet_quality);
> +       dict_append_byte(dict, "packetRssiDbm", m0->packet_rssi_dbm);
> +       dict_append_byte(dict, "packetAntenna", m0->packet_ant);
> +       dict_append_int32(dict, "initiatorMeasuredFreqOffset",
> +                               (dbus_int32_t)m0->init_measured_freq_offs=
et);
> +}
> +
> +static void append_pct_iq_pair(DBusMessageIter *dict, const char *key,
> +                               const struct pct_iq_sample *pct)
> +{
> +       DBusMessageIter entry, variant, arr;
> +       dbus_int32_t i_s =3D pct->i_sample;
> +       dbus_int32_t q_s =3D pct->q_sample;
> +
> +       dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY, NULL=
,
> +                                        &entry);
> +       dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
> +       dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT, "ai",
> +                                        &variant);
> +       dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY, "i", =
&arr);
> +       dbus_message_iter_append_basic(&arr, DBUS_TYPE_INT32, &i_s);
> +       dbus_message_iter_append_basic(&arr, DBUS_TYPE_INT32, &q_s);
> +       dbus_message_iter_close_container(&variant, &arr);
> +       dbus_message_iter_close_container(&entry, &variant);
> +       dbus_message_iter_close_container(dict, &entry);
> +}
> +
> +static void append_mode_one(DBusMessageIter *dict,
> +                               const struct cs_mode_one_data *m1)
> +{
> +       dict_append_byte(dict, "packetQuality", m1->packet_quality);
> +       dict_append_byte(dict, "packetNadm", m1->packet_nadm);
> +       dict_append_byte(dict, "packetRssiDbm", m1->packet_rssi_dbm);
> +       dict_append_int32(dict, "toaTodInitiator",
> +                               (dbus_int32_t)m1->toa_tod_init);
> +       dict_append_int32(dict, "todToaReflector",
> +                               (dbus_int32_t)m1->tod_toa_refl);
> +       dict_append_byte(dict, "packetAntenna", m1->packet_ant);
> +       append_pct_iq_pair(dict, "packetPct1", &m1->packet_pct1);
> +       append_pct_iq_pair(dict, "packetPct2", &m1->packet_pct2);
> +}
> +
> +static void append_mode_two(DBusMessageIter *dict,
> +                               const struct cs_mode_two_data *m2,
> +                               uint8_t num_ant_paths)
> +{
> +       DBusMessageIter entry, variant, arr;
> +       const char *key;
> +       int j;
> +       int num_paths;
> +
> +       /*
> +        * num_ant_paths is the HCI "number of antenna paths" value
> +        * (0-indexed), so actual tone sample count =3D num_ant_paths + 1=
,
> +        * capped at array size.
> +        */
> +       num_paths =3D (num_ant_paths + 1) < CS_MAX_ANT_PATHS ?
> +                               (num_ant_paths + 1) : CS_MAX_ANT_PATHS;
> +
> +       dict_append_byte(dict, "antennaPermutationIndex", m2->ant_perm_in=
dex);
> +
> +       /* tonePctIQSamples: interleaved (i,q) pairs as "ai" */
> +       key =3D "tonePctIQSamples";
> +       dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY, NULL=
,
> +                                        &entry);
> +       dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
> +       dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT, "ai",
> +                                        &variant);
> +       dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY, "i", =
&arr);
> +       for (j =3D 0; j < num_paths; j++) {
> +               dbus_int32_t i_s =3D m2->tone_pct[j].i_sample;
> +               dbus_int32_t q_s =3D m2->tone_pct[j].q_sample;
> +
> +               dbus_message_iter_append_basic(&arr, DBUS_TYPE_INT32, &i_=
s);
> +               dbus_message_iter_append_basic(&arr, DBUS_TYPE_INT32, &q_=
s);
> +       }
> +       dbus_message_iter_close_container(&variant, &arr);
> +       dbus_message_iter_close_container(&entry, &variant);
> +       dbus_message_iter_close_container(dict, &entry);
> +
> +       /* toneQualityIndicators: "ay" */
> +       key =3D "toneQualityIndicators";
> +       dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY, NULL=
,
> +                                        &entry);
> +       dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
> +       dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT, "ay",
> +                                        &variant);
> +       dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY, "y", =
&arr);
> +       for (j =3D 0; j < num_paths; j++) {
> +               uint8_t tqi =3D m2->tone_quality_indicator[j];
> +
> +               dbus_message_iter_append_basic(&arr, DBUS_TYPE_BYTE, &tqi=
);
> +       }
> +       dbus_message_iter_close_container(&variant, &arr);
> +       dbus_message_iter_close_container(&entry, &variant);
> +       dbus_message_iter_close_container(dict, &entry);
> +}
> +
> +static void append_proc_enable_config(DBusMessageIter *outer_dict,
> +                               const struct rap_ev_cs_proc_enable_cmplt =
*cfg)
> +{
> +       DBusMessageIter entry, variant, inner;
> +       const char *key =3D "procedureEnableConfig";
> +       dbus_uint32_t sub_evt_len_us;
> +
> +       sub_evt_len_us =3D cfg->sub_evt_len[0] |
> +                        ((uint32_t)cfg->sub_evt_len[1] << 8) |
> +                        ((uint32_t)cfg->sub_evt_len[2] << 16);
> +
> +       dbus_message_iter_open_container(outer_dict, DBUS_TYPE_DICT_ENTRY=
,
> +                                        NULL, &entry);
> +       dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
> +       dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT, "a{sv=
}",
> +                                        &variant);
> +       dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY, "{sv}=
",
> +                                        &inner);
> +
> +       dict_append_byte(&inner, "toneAntennaConfigSelection",
> +                        cfg->tone_ant_config_sel);
> +       dict_append_uint32(&inner, "subeventLenUs", sub_evt_len_us);
> +       dict_append_byte(&inner, "subeventsPerEvent", cfg->sub_evts_per_e=
vt);
> +       dict_append_uint32(&inner, "subeventInterval", cfg->sub_evt_intrv=
l);
> +       dict_append_uint32(&inner, "eventInterval", cfg->evt_intrvl);
> +       dict_append_uint32(&inner, "procedureInterval", cfg->proc_intrvl)=
;
> +       dict_append_uint32(&inner, "procedureCount", cfg->proc_counter);
> +       dict_append_uint32(&inner, "maxProcedureLen", cfg->max_proc_len);
> +
> +       dbus_message_iter_close_container(&variant, &inner);
> +       dbus_message_iter_close_container(&entry, &variant);
> +       dbus_message_iter_close_container(outer_dict, &entry);
> +}
> +
> +static void append_cs_config_param(DBusMessageIter *outer_dict,
> +                               const struct bcs_procedure_data *bcs)
> +{
> +       DBusMessageIter entry, variant, inner;
> +       const char *key =3D "csConfigParam";
> +       const struct rap_ev_cs_config_cmplt *cfg =3D &bcs->cs_config;
> +
> +       dbus_message_iter_open_container(outer_dict, DBUS_TYPE_DICT_ENTRY=
,
> +                                        NULL, &entry);
> +       dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
> +       dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT, "a{sv=
}",
> +                                        &variant);
> +       dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY, "{sv}=
",
> +                                        &inner);
> +
> +       dict_append_byte(&inner, "modeType", cfg->main_mode_type);
> +       dict_append_byte(&inner, "subModeType", cfg->sub_mode_type);
> +       dict_append_byte(&inner, "rttType", cfg->rtt_type);
> +       dict_append_byte_array(&inner, "channelMap", cfg->channel_map,
> +                              sizeof(cfg->channel_map));
> +       dict_append_byte(&inner, "minMainModeSteps", cfg->min_main_mode_s=
teps);
> +       dict_append_byte(&inner, "maxMainModeSteps", cfg->max_main_mode_s=
teps);
> +       dict_append_byte(&inner, "mainModeRepetition", cfg->main_mode_rep=
);
> +       dict_append_byte(&inner, "mode0Steps", cfg->mode_0_steps);
> +       dict_append_byte(&inner, "role", cfg->role);
> +       dict_append_byte(&inner, "csSyncPhyType", cfg->cs_sync_phy);
> +       dict_append_byte(&inner, "channelSelectionType", cfg->channel_sel=
_type);
> +       dict_append_byte(&inner, "ch3cShapeType", cfg->ch3c_shape);
> +       dict_append_byte(&inner, "ch3cJump", cfg->ch3c_jump);
> +       dict_append_byte(&inner, "channelMapRepetition", cfg->channel_map=
_rep);
> +       dict_append_byte(&inner, "tIp1TimeUs", cfg->t_ip1_time);
> +       dict_append_byte(&inner, "tIp2TimeUs", cfg->t_ip2_time);
> +       dict_append_byte(&inner, "tFcsTimeUs", cfg->t_fcs_time);
> +       dict_append_byte(&inner, "tPmTimeUs", cfg->t_pm_time);
> +       dict_append_byte(&inner, "tSwTimeUsSupportedByLocal",
> +                        bcs->t_sw_time_us_supported_by_local);
> +       dict_append_byte(&inner, "tSwTimeUsSupportedByRemote",
> +                        bcs->t_sw_time_us_supported_by_remote);
> +       dict_append_uint32(&inner, "bleConnInterval", bcs->ble_conn_inter=
val);
> +
> +       dbus_message_iter_close_container(&variant, &inner);
> +       dbus_message_iter_close_container(&entry, &variant);
> +       dbus_message_iter_close_container(outer_dict, &entry);
> +}
> +
> +static void append_step_to_dict(DBusMessageIter *dict,
> +                               const struct cs_step_data *step,
> +                               uint8_t num_ant_paths)
> +{
> +       DBusMessageIter entry, variant, inner;
> +       const char *mode_key;
> +
> +       dict_append_byte(dict, "stepMode", step->step_mode);
> +       dict_append_byte(dict, "stepChannel", step->step_chnl);
> +
> +       switch (step->step_mode) {
> +       case CS_MODE_ZERO:
> +               mode_key =3D "modeZeroData";
> +               dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENT=
RY,
> +                                                NULL, &entry);
> +               dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
> +                                              &mode_key);
> +               dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIAN=
T,
> +                                                "a{sv}", &variant);
> +               dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRA=
Y,
> +                                                "{sv}", &inner);
> +               append_mode_zero(&inner,
> +                                &step->step_mode_data.mode_zero_data);
> +               dbus_message_iter_close_container(&variant, &inner);
> +               dbus_message_iter_close_container(&entry, &variant);
> +               dbus_message_iter_close_container(dict, &entry);
> +               break;
> +
> +       case CS_MODE_ONE:
> +               mode_key =3D "modeOneData";
> +               dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENT=
RY,
> +                                                NULL, &entry);
> +               dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
> +                                              &mode_key);
> +               dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIAN=
T,
> +                                                "a{sv}", &variant);
> +               dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRA=
Y,
> +                                                "{sv}", &inner);
> +               append_mode_one(&inner,
> +                               &step->step_mode_data.mode_one_data);
> +               dbus_message_iter_close_container(&variant, &inner);
> +               dbus_message_iter_close_container(&entry, &variant);
> +               dbus_message_iter_close_container(dict, &entry);
> +               break;
> +
> +       case CS_MODE_TWO:
> +               mode_key =3D "modeTwoData";
> +               dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENT=
RY,
> +                                                NULL, &entry);
> +               dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
> +                                              &mode_key);
> +               dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIAN=
T,
> +                                                "a{sv}", &variant);
> +               dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRA=
Y,
> +                                                "{sv}", &inner);
> +               append_mode_two(&inner,
> +                               &step->step_mode_data.mode_two_data,
> +                               num_ant_paths);
> +               dbus_message_iter_close_container(&variant, &inner);
> +               dbus_message_iter_close_container(&entry, &variant);
> +               dbus_message_iter_close_container(dict, &entry);
> +               break;
> +
> +       case CS_MODE_THREE:
> +               mode_key =3D "modeThreeData";
> +               dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENT=
RY,
> +                                                NULL, &entry);
> +               dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
> +                                              &mode_key);
> +               dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIAN=
T,
> +                                                "a{sv}", &variant);
> +               dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRA=
Y,
> +                                                "{sv}", &inner);
> +               append_mode_one(&inner,
> +                       &step->step_mode_data.mode_three_data.mode_one_da=
ta);
> +               append_mode_two(&inner,
> +                       &step->step_mode_data.mode_three_data.mode_two_da=
ta,
> +                       num_ant_paths);
> +               dbus_message_iter_close_container(&variant, &inner);
> +               dbus_message_iter_close_container(&entry, &variant);
> +               dbus_message_iter_close_container(dict, &entry);
> +               break;
> +
> +       default:
> +               break;
> +       }
> +}
> +
> +static void append_subevent_to_dict(DBusMessageIter *dict,
> +                               const struct cs_subevent_result_data *sub=
)
> +{
> +       DBusMessageIter entry, variant, arr;
> +       const char *key;
> +       uint32_t i;
> +
> +       dict_append_int32(dict, "startAclConnEvtCounter",
> +                         (dbus_int32_t)sub->start_acl_conn_evt_counter);
> +       dict_append_int32(dict, "freqComp", (dbus_int32_t)sub->freq_comp)=
;
> +       dict_append_byte(dict, "refPwrLvl", (uint8_t)sub->ref_pwr_lvl);
> +       dict_append_byte(dict, "numAntPaths", sub->num_ant_paths);
> +       dict_append_byte(dict, "subeventAbortReason",
> +                        sub->subevent_abort_reason);
> +       dict_append_uint64(dict, "timestampNanos", sub->timestamp_nanos);
> +       dict_append_uint32(dict, "numSteps", sub->num_steps);
> +
> +       /* stepData: av (each element is a{sv}) */
> +       key =3D "stepData";
> +       dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY, NULL=
,
> +                                        &entry);
> +       dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
> +       dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT, "av",
> +                                        &variant);
> +       dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY, "v", =
&arr);
> +       if (sub->step_data) {
> +               for (i =3D 0; i < sub->num_steps; i++) {
> +                       DBusMessageIter inner, step_dict;
> +
> +                       dbus_message_iter_open_container(&arr,
> +                                       DBUS_TYPE_VARIANT, "a{sv}", &inne=
r);
> +                       dbus_message_iter_open_container(&inner,
> +                                       DBUS_TYPE_ARRAY, "{sv}", &step_di=
ct);
> +                       append_step_to_dict(&step_dict, &sub->step_data[i=
],
> +                                           sub->num_ant_paths);
> +                       dbus_message_iter_close_container(&inner, &step_d=
ict);
> +                       dbus_message_iter_close_container(&arr, &inner);
> +               }
> +       }
> +       dbus_message_iter_close_container(&variant, &arr);
> +       dbus_message_iter_close_container(&entry, &variant);
> +       dbus_message_iter_close_container(dict, &entry);
> +}
> +
> +static void append_subevent_array(DBusMessageIter *outer_dict,
> +                               const char *key,
> +                               const struct cs_subevent_result_data *sub=
events,
> +                               uint32_t count)
> +{
> +       DBusMessageIter entry, variant, arr;
> +       uint32_t i;
> +
> +       dbus_message_iter_open_container(outer_dict, DBUS_TYPE_DICT_ENTRY=
,
> +                                        NULL, &entry);
> +       dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
> +       dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT, "av",
> +                                        &variant);
> +       dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY, "v", =
&arr);
> +       for (i =3D 0; i < count; i++) {
> +               DBusMessageIter inner, sub_dict;
> +
> +               dbus_message_iter_open_container(&arr, DBUS_TYPE_VARIANT,
> +                                                "a{sv}", &inner);
> +               dbus_message_iter_open_container(&inner, DBUS_TYPE_ARRAY,
> +                                                "{sv}", &sub_dict);
> +               append_subevent_to_dict(&sub_dict, &subevents[i]);
> +               dbus_message_iter_close_container(&inner, &sub_dict);
> +               dbus_message_iter_close_container(&arr, &inner);
> +       }
> +       dbus_message_iter_close_container(&variant, &arr);
> +       dbus_message_iter_close_container(&entry, &variant);
> +       dbus_message_iter_close_container(outer_dict, &entry);
> +}
> +
> +static void rap_emit_procedure_data(struct rap_data *data,
> +                               const struct bcs_procedure_data *bcs)
> +{
> +       DBusMessage *signal;
> +       DBusMessageIter iter, dict;
> +
> +       signal =3D dbus_message_new_signal(device_get_path(data->device),
> +                                        CS_INTERFACE, "ProcedureData");
> +       if (!signal) {
> +               error("Failed to allocate ProcedureData signal");
> +               return;
> +       }
> +
> +       dbus_message_iter_init_append(signal, &iter);
> +       dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY, "{sv}", =
&dict);
> +
> +       dict_append_int32(&dict, "procedureCounter",
> +                         (dbus_int32_t)bcs->procedure_counter);
> +       dict_append_int32(&dict, "procedureSequence",
> +                         (dbus_int32_t)bcs->procedure_sequence);
> +       dict_append_byte(&dict, "initiatorSelectedTxPower",
> +                        (uint8_t)bcs->initiator_selected_tx_power);
> +       dict_append_byte(&dict, "reflectorSelectedTxPower",
> +                        (uint8_t)bcs->reflector_selected_tx_power);
> +
> +       dict_append_uint32(&dict, "initiatorSubeventCount",
> +                          bcs->initiator_subevent_count);
> +       if (bcs->initiator_subevent_results &&
> +                                       bcs->initiator_subevent_count > 0=
)
> +               append_subevent_array(&dict, "initiatorSubeventResults",
> +                                     bcs->initiator_subevent_results,
> +                                     bcs->initiator_subevent_count);
> +
> +       dict_append_byte(&dict, "initiatorProcedureAbortReason",
> +                        bcs->initiator_procedure_abort_reason);
> +
> +       dict_append_uint32(&dict, "reflectorSubeventCount",
> +                          bcs->reflector_subevent_count);
> +       if (bcs->reflector_subevent_results &&
> +                                       bcs->reflector_subevent_count > 0=
)
> +               append_subevent_array(&dict, "reflectorSubeventResults",
> +                                     bcs->reflector_subevent_results,
> +                                     bcs->reflector_subevent_count);
> +
> +       dict_append_byte(&dict, "reflectorProcedureAbortReason",
> +                        bcs->reflector_procedure_abort_reason);
> +
> +       append_proc_enable_config(&dict, &bcs->proc_enable_config);
> +       append_cs_config_param(&dict, bcs);
> +
> +       dbus_message_iter_close_container(&iter, &dict);
> +
> +       g_dbus_send_message(btd_get_dbus_connection(), signal);
> +}
> +
> +static void rap_procedure_data(struct bt_rap *rap,
> +                               struct bcs_procedure_data *bcs,
> +                               void *user_data)
> +{
> +       struct rap_data *data =3D user_data;
> +
> +       DBG("procedure_counter=3D%u", bcs->procedure_counter);
> +       rap_emit_procedure_data(data, bcs);
> +}
> +
>  static DBusMessage *start_measurement(DBusConnection *conn,
>                                 DBusMessage *msg, void *user_data)
>  {
> @@ -534,6 +1020,9 @@ bad_type:
>         data->active_session.cfg           =3D cfg;
>         data->active_session.freq          =3D freq;
>
> +       bt_rap_hci_set_procedure_data_cb(data->hci_sm, rap_procedure_data=
,
> +                                        data, NULL);
> +
>         return dbus_message_new_method_return(msg);
>  }
>
> @@ -588,6 +1077,11 @@ static const GDBusPropertyTable cs_dbus_properties[=
] =3D {
>         { }
>  };
>
> +static const GDBusSignalTable cs_dbus_signals[] =3D {
> +       { GDBUS_SIGNAL("ProcedureData", GDBUS_ARGS({ "data", "a{sv}" })) =
},
> +       { }
> +};
> +
>  static void rap_measurement_timeout_cb(void *user_data)
>  {
>         struct rap_data *data =3D user_data;
> @@ -752,7 +1246,8 @@ static int rap_accept(struct btd_service *service)
>         g_dbus_register_interface(btd_get_dbus_connection(),
>                                   device_get_path(data->device),
>                                   CS_INTERFACE, cs_dbus_methods,
> -                                 NULL, cs_dbus_properties, data, NULL);
> +                                 cs_dbus_signals, cs_dbus_properties,
> +                                 data, NULL);
>
>         return 0;
>  }
> diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
> index e57f967a2..3da98972e 100644
> --- a/profiles/ranging/rap_hci.c
> +++ b/profiles/ranging/rap_hci.c
> @@ -442,6 +442,8 @@ static void rap_rd_loc_supp_cap_done_cb(const void *d=
ata, uint8_t size,
>         DBG("Sending read remote capabilities for handle 0x%04X",
>                 sm->active_conn_handle);
>         bt_rap_read_remote_supported_capabilities(sm, sm->active_conn_han=
dle);
> +
> +       bt_rap_set_local_sw_time(sm->rap, rsp->t_sw_time_supported);
>  }
>
>  static void rap_send_hci_cs_create_config_command(struct cs_state_machin=
e *sm,
> @@ -873,6 +875,8 @@ static void rap_rd_rmt_supp_cap_cmplt_evt(const void =
*data, uint8_t size,
>                 cs_set_state(sm, CS_STATE_INIT);
>                 rap_send_hci_def_settings_command(sm, evt);
>         }
> +
> +       bt_rap_set_remote_sw_time(sm->rap, evt->t_sw_time_supported);
>  }
>
>  static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
> @@ -1162,6 +1166,46 @@ static void rap_cs_proc_enable_cmplt_evt(const voi=
d *data, uint8_t size,
>                         &rap_ev, sm->rap);
>  }
>
> +static void rap_le_conn_update_complete_evt(const void *data, uint8_t si=
ze,
> +                                           void *user_data)
> +{
> +       struct cs_state_machine *sm =3D user_data;
> +       const struct bt_hci_evt_le_conn_update_complete *evt;
> +       struct rap_conn_mapping *mapping;
> +       struct bt_rap *rap;
> +       struct iovec iov;
> +
> +       if (!sm || !data ||
> +           size < sizeof(struct bt_hci_evt_le_conn_update_complete))
> +               return;
> +
> +       iov.iov_base =3D (void *) data;
> +       iov.iov_len =3D size;
> +
> +       evt =3D util_iov_pull_mem(&iov, sizeof(*evt));
> +       if (!evt) {
> +               error("Failed to pull LE conn update complete struct");
> +               return;
> +       }
> +
> +       DBG("status=3D0x%02X handle=3D0x%04X interval=3D%u",
> +           evt->status, evt->handle, evt->interval);
> +
> +       if (evt->status !=3D 0)
> +               return;
> +
> +       mapping =3D find_mapping_by_handle(sm, evt->handle);
> +       if (mapping && mapping->rap) {
> +               DBG("Found handle 0x%04X in mapping cache", evt->handle);
> +               rap =3D mapping->rap;
> +       } else {
> +               error("No mapping found for handle 0x%04X", evt->handle);
> +               return;
> +       }
> +
> +       bt_rap_set_conn_interval(rap, evt->interval);
> +}
> +
>  static void parse_i_q_sample(struct iovec *iov, int16_t *i_sample,
>                                 int16_t *q_sample)
>  {
> @@ -1662,6 +1706,8 @@ void *bt_rap_attach_hci(struct bt_rap *rap, struct =
bt_hci *hci,
>                                         rap_cs_subevt_result_evt },
>                 { BT_HCI_EVT_LE_CS_SUBEVENT_RESULT_CONTINUE,
>                                         rap_cs_subevt_result_cont_evt },
> +               { BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE,
> +                                       rap_le_conn_update_complete_evt }=
,
>         };
>         struct cs_state_machine *sm;
>         unsigned int i;
> @@ -1781,6 +1827,19 @@ bool bt_rap_stop_measurement(void *hci_sm)
>                                                 false);
>  }
>
> +bool bt_rap_hci_set_procedure_data_cb(void *hci_sm,
> +                               bt_rap_procedure_data_func_t cb,
> +                               void *user_data,
> +                               bt_rap_destroy_func_t destroy)
> +{
> +       struct cs_state_machine *sm =3D hci_sm;
> +
> +       if (!sm || !sm->rap)
> +               return false;
> +
> +       return bt_rap_set_procedure_data_cb(sm->rap, cb, user_data, destr=
oy);
> +}
> +
>  bool bt_rap_set_conn_hndl(void *hci_sm, struct bt_rap *rap,
>                 uint16_t handle, const uint8_t *bdaddr, uint8_t bdaddr_ty=
pe,
>                 bool is_central)
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
