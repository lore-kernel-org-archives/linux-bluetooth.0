Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD23134EF15
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 15:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784301477; cv=pass; b=GIk17dJkniTEfOsRFylZnStxnhHPuaw6xqCL8QCgykWuxzmQBmMvGKtHcoRfIXSnHFHFLUvJoq+UDa4hOoS6O2LAI0VX4iPlNjJDJNXGuPP1hm07MuE5hTX7iKnjqMzLtg+JxnWKRdeVaEB20CX2dkyxndDQusam42GtMJowHL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784301477; c=relaxed/simple;
	bh=xU8XWybIZvjR2eQQP07NR6DM0Qf4gopIvNcqfpO8mVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hoBFZ2sm0BZz2CxV0bKO/unNmfHFt/YMtw5OBzfx+YMf7BslO6whcG4Yn7ffeAweUMUR8A60g7tF3bQ0IacM6Mxpevu4WLa6SCHu/e31aCyNLAkrLz7SY3z9iwdEvyuLaVEZSFNsz1mNffF0mf52MQLWcAzF55lKFeMQm5Q30/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ru0aP3TM; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ru0aP3TM"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-81e6f2ee60bso14919747b3.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 08:17:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784301474; cv=none;
        d=google.com; s=arc-20260327;
        b=oSer5vOxzIl9UqFHqKVjYQTTg+ZzfKoSp5kRCtkNU60pU5Ng4k5/rBCtjRNpTzP5Kc
         OTkauadZe7WBsBoRT7tjSBnfjg5XMMH6L3JxJxpgbkhjH3uMCa2JCGNRLCbNLHDLz+ir
         6/T3sY07ndQohFCScH5RTYGNkgtjdCyQnRiXmLEXuH4JscePha0l7ihNpfSUawzZb6fO
         loAImN4FiNp9PJm+u6FfSycrMAH2NzfgDK5+9TZ4Nc0861bk9y1eJ7Wpfq//Z8uuQqAi
         MnInHGwLkue1kMuE1zCIfADmDHEA3gQx0/9eQUM6CK8b0hKlvCzO152WjgzcPyiFjDZ/
         vNQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YYAUtwBsV5ztTp6geyuj3brneRZ3HcEk9YMnCD67D34=;
        fh=jBLUrRQ7ZsNUcAcd5QG5N83k8jhBNkoqDFBeOlOjxqk=;
        b=C8vcxXwxL3Zvfgxjpd5YuoD3i66PxGEFyYEj4/mMSlu7mYNMmq1hfYr1KS462/MZGA
         /SjtFrGa7javQMXi3TPyEduNubEOoz3sRNnEOZPYId9rYf0I7aOOA0V6at7LC2WGkIWb
         l5ZR7GWr0JWxmnebWtHcrv6LmXK6HZ7wrsy6ucQ2mW3fSISTRD0afmf+e0ldLe/jyIgO
         RIXkwtKxYFs0k3lrOjZxd7tEa87X1mlAz/gC2XXwgaMVZ5cFvsytrfg4gcSZ8VTL6L85
         g5GVlK7mjbimEuUBM3HX30hLEa+mZW8WAqd6nyHE2whi3OJ1KT2/6Q+oAgbDX6LyxiVi
         /Zfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784301474; x=1784906274; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YYAUtwBsV5ztTp6geyuj3brneRZ3HcEk9YMnCD67D34=;
        b=Ru0aP3TMNiX96hf8+cjlgrICsVuiNSJe2Bp0pw5W+j2CpRDT2gAFJJ3XbNYY/ORDx1
         g9tF6qmAomURYKbm7trvWmLi1kUeIP5YyzKw0T2e9ikkWGXF/fQcyO5MyQUdT7oaB5/E
         omUkVk+Stj2x8/Zq5Vztwc6AVVWDHaM9sYxoeaPLeekMn+tVlvHNEQZ+OtlD9MjwVeiR
         5yJH9kJ6GkdqJ7pNeLVhZGRakfueGOBKJucyeSLGPvdRcDG9yG6/T+HRyylI+yWE6cvh
         tm68/cZQjz2xAJ0FdFFeUHCt7B5pfBvtPVW75/6YVG0+2a8GnSaWi+Sq+MX5pa5vJuD6
         XGWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784301474; x=1784906274;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YYAUtwBsV5ztTp6geyuj3brneRZ3HcEk9YMnCD67D34=;
        b=EiI+tN34AIatXsCnUlmxcSI+MaQmwTL1rqBOGsTyDFqzl2PVYkGTu29XkJne7Vn52q
         Jia2yp4futcKg/NUlhIpfIndv8W3Lg9DEdEiujHmSjW5Y5ja1tBmZIiOf5NtYLFP/3Wv
         6uhtfiOzlVqEfrDx9oO2hiMBJYU/ecXmiqXz3mH81jSNbfmFdcZFvtIjzPC7YweIIxGW
         etk7pI/XOGgTTk8X9rxPinl48njRbrgX8XxvX5C3SzkymNneBp/symQaARYzOGQNSHN+
         dHD9wig0GQDF42hTUJEaNSYSe5+2NtltZLtcwt8zJCO/XDPL2pYjFhRReqgr987XPKzz
         19cQ==
X-Gm-Message-State: AOJu0Yywi2ts5yw6SChFEtuMmkOrOY5eejkU7mLuHE2DDAwSxLamEYv8
	zQ4Kfbyuo9qInZpfcOeV6gI7ppFqsuGIq2MIFH0l8vZJkDABdrygL6BkHWnB5pYriHMgAWQuFDt
	J+Deqfa2Uwfz1ietuwcwqpPO2HEPUGO4Vy1H3Aug=
X-Gm-Gg: AfdE7cluIeyLkUYLPS1tpblkxJffqh8Bb/Dsw91iBEji8NFHVmhWVqsW/RKgLiEahO7
	azyFk3vmsXWZh0Ev41ADXnAPrNhVjGwU2ApQBf115DgMgsUaj295oe8Jdsa8RjYlLM9hawiEohv
	7xtlP3QoNcOuJAQLZCbZQbwHYxSnNFeMscUJgUepKnKizMX6JaOIQgjXEhVk5XF0X0PWZaCN4Mi
	NKyGQehN1Nux7zgZ2TqLnRdSWlmAz1lQnVUFDToXMQca8SeAUpqXf/+k8afUjGzno0mEkA8c5hW
	SLYjgL3xsbnh58wPLnsv3bjmaGPd63iLaWogkhNTrtwg5gNm
X-Received: by 2002:a05:690c:c183:b0:81e:6def:63c4 with SMTP id
 00721157ae682-81ee292eccemr33942387b3.28.1784301472910; Fri, 17 Jul 2026
 08:17:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717072647.255002-1-prathm@qti.qualcomm.com>
 <20260717072647.255002-3-prathm@qti.qualcomm.com> <CABBYNZ++i-JNcjCz5PG5JKNf9aWgMkm05i4-m7b5TPhTdMmojg@mail.gmail.com>
In-Reply-To: <CABBYNZ++i-JNcjCz5PG5JKNf9aWgMkm05i4-m7b5TPhTdMmojg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 17 Jul 2026 11:17:41 -0400
X-Gm-Features: AUfX_mw-PlrNNsDN1xd0DTOyfbSQ0KKIgKC-F72n65N2-xypWTZ4SLUjzRKBRE4
Message-ID: <CABBYNZL1rf4LbLNiese8DwRBMMgtCps-VH-nNCbZ9G1Xu=1RBQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 2/2] profiles/ranging: Add D-Bus ProcedureData
 signal for Channel Sounding
To: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi.

On Fri, Jul 17, 2026 at 11:07=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Prathibha,
>
> On Fri, Jul 17, 2026 at 3:27=E2=80=AFAM Prathibha Madugonde
> <prathibha.madugonde@oss.qualcomm.com> wrote:
> >
> > From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
> >
> > Marshal bcs_procedure_data (subevents, steps, mode 0/1/2/3 results,
> > and CS/procedure-enable config) into an a{sv} dictionary and emit it
> > as a new ProcedureData signal on the CS D-Bus interface.
>
> Was this documented though? It doesn't seem to follow the likes of
> https://github.com/bluez/bluez/blob/master/doc/org.bluez.ChannelSounding1=
.rst,
> for instance we don't use camel case for dictionary options. Also, if
> this is a result of `StartMeasurement`, we should probably signal it
> as Results or something like that, but I'd start with documentation so
> we can agree on the overall design.

Ok, looks like this does follow the documentation already:

https://github.com/bluez/bluez/blob/master/doc/org.bluez.ChannelSounding1.r=
st#void-proceduredatadict-data

That said that will probably need updating since some dictionaries use
camel case and others don't, so this needs to converge to a single
format.

> > Register a procedure_data callback on the RAP HCI state machine so
> > rap.c is notified when a procedure completes, and propagate the
> > locally supported T_SW time capability from the read-local-supported-
> > capabilities response into bt_rap.
> >
> > ---
> >  profiles/ranging/rap.c     | 497 ++++++++++++++++++++++++++++++++++++-
> >  profiles/ranging/rap_hci.c |  59 +++++
> >  2 files changed, 555 insertions(+), 1 deletion(-)
> >
> > diff --git a/profiles/ranging/rap.c b/profiles/ranging/rap.c
> > index 3ffc0da76..42e1ef2a4 100644
> > --- a/profiles/ranging/rap.c
> > +++ b/profiles/ranging/rap.c
> > @@ -379,6 +379,492 @@ static const struct cs_dict_param_desc *cs_find_d=
ict_param_desc(
> >         return NULL;
> >  }
> >
> > +static void dict_append_byte(DBusMessageIter *dict, const char *key,
> > +                               uint8_t val)
> > +{
> > +       DBusMessageIter entry, variant;
> > +
> > +       dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY, NU=
LL,
> > +                                               &entry);
> > +       dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
> > +       dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT, "y"=
,
> > +                                               &variant);
> > +       dbus_message_iter_append_basic(&variant, DBUS_TYPE_BYTE, &val);
> > +       dbus_message_iter_close_container(&entry, &variant);
> > +       dbus_message_iter_close_container(dict, &entry);
> > +}
> > +
> > +static void dict_append_int32(DBusMessageIter *dict, const char *key,
> > +                               dbus_int32_t val)
> > +{
> > +       DBusMessageIter entry, variant;
> > +
> > +       dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY, NU=
LL,
> > +                                               &entry);
> > +       dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
> > +       dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT, "i"=
,
> > +                                               &variant);
> > +       dbus_message_iter_append_basic(&variant, DBUS_TYPE_INT32, &val)=
;
> > +       dbus_message_iter_close_container(&entry, &variant);
> > +       dbus_message_iter_close_container(dict, &entry);
> > +}
> > +
> > +static void dict_append_uint32(DBusMessageIter *dict, const char *key,
> > +                               dbus_uint32_t val)
> > +{
> > +       DBusMessageIter entry, variant;
> > +
> > +       dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY, NU=
LL,
> > +                                               &entry);
> > +       dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
> > +       dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT, "u"=
,
> > +                                               &variant);
> > +       dbus_message_iter_append_basic(&variant, DBUS_TYPE_UINT32, &val=
);
> > +       dbus_message_iter_close_container(&entry, &variant);
> > +       dbus_message_iter_close_container(dict, &entry);
> > +}
> > +
> > +static void dict_append_uint64(DBusMessageIter *dict, const char *key,
> > +                               dbus_uint64_t val)
> > +{
> > +       DBusMessageIter entry, variant;
> > +
> > +       dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY, NU=
LL,
> > +                                               &entry);
> > +       dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
> > +       dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT, "t"=
,
> > +                                               &variant);
> > +       dbus_message_iter_append_basic(&variant, DBUS_TYPE_UINT64, &val=
);
> > +       dbus_message_iter_close_container(&entry, &variant);
> > +       dbus_message_iter_close_container(dict, &entry);
> > +}
> > +
> > +static void dict_append_byte_array(DBusMessageIter *dict, const char *=
key,
> > +                                       const uint8_t *data, int len)
> > +{
> > +       DBusMessageIter entry, variant, arr;
> > +       int i;
> > +
> > +       dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY, NU=
LL,
> > +                                               &entry);
> > +       dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
> > +       dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT, "ay=
",
> > +                                               &variant);
> > +       dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY, "y"=
, &arr);
> > +       for (i =3D 0; i < len; i++)
> > +               dbus_message_iter_append_basic(&arr, DBUS_TYPE_BYTE, &d=
ata[i]);
> > +       dbus_message_iter_close_container(&variant, &arr);
> > +       dbus_message_iter_close_container(&entry, &variant);
> > +       dbus_message_iter_close_container(dict, &entry);
> > +}
> > +
> > +static void append_mode_zero(DBusMessageIter *dict,
> > +                               const struct cs_mode_zero_data *m0)
> > +{
> > +       dict_append_byte(dict, "packetQuality", m0->packet_quality);
> > +       dict_append_byte(dict, "packetRssiDbm", m0->packet_rssi_dbm);
> > +       dict_append_byte(dict, "packetAntenna", m0->packet_ant);
> > +       dict_append_int32(dict, "initiatorMeasuredFreqOffset",
> > +                               (dbus_int32_t)m0->init_measured_freq_of=
fset);
> > +}
> > +
> > +static void append_pct_iq_pair(DBusMessageIter *dict, const char *key,
> > +                               const struct pct_iq_sample *pct)
> > +{
> > +       DBusMessageIter entry, variant, arr;
> > +       dbus_int32_t i_s =3D pct->i_sample;
> > +       dbus_int32_t q_s =3D pct->q_sample;
> > +
> > +       dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY, NU=
LL,
> > +                                        &entry);
> > +       dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
> > +       dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT, "ai=
",
> > +                                        &variant);
> > +       dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY, "i"=
, &arr);
> > +       dbus_message_iter_append_basic(&arr, DBUS_TYPE_INT32, &i_s);
> > +       dbus_message_iter_append_basic(&arr, DBUS_TYPE_INT32, &q_s);
> > +       dbus_message_iter_close_container(&variant, &arr);
> > +       dbus_message_iter_close_container(&entry, &variant);
> > +       dbus_message_iter_close_container(dict, &entry);
> > +}
> > +
> > +static void append_mode_one(DBusMessageIter *dict,
> > +                               const struct cs_mode_one_data *m1)
> > +{
> > +       dict_append_byte(dict, "packetQuality", m1->packet_quality);
> > +       dict_append_byte(dict, "packetNadm", m1->packet_nadm);
> > +       dict_append_byte(dict, "packetRssiDbm", m1->packet_rssi_dbm);
> > +       dict_append_int32(dict, "toaTodInitiator",
> > +                               (dbus_int32_t)m1->toa_tod_init);
> > +       dict_append_int32(dict, "todToaReflector",
> > +                               (dbus_int32_t)m1->tod_toa_refl);
> > +       dict_append_byte(dict, "packetAntenna", m1->packet_ant);
> > +       append_pct_iq_pair(dict, "packetPct1", &m1->packet_pct1);
> > +       append_pct_iq_pair(dict, "packetPct2", &m1->packet_pct2);
> > +}
> > +
> > +static void append_mode_two(DBusMessageIter *dict,
> > +                               const struct cs_mode_two_data *m2,
> > +                               uint8_t num_ant_paths)
> > +{
> > +       DBusMessageIter entry, variant, arr;
> > +       const char *key;
> > +       int j;
> > +       int num_paths;
> > +
> > +       /*
> > +        * num_ant_paths is the HCI "number of antenna paths" value
> > +        * (0-indexed), so actual tone sample count =3D num_ant_paths +=
 1,
> > +        * capped at array size.
> > +        */
> > +       num_paths =3D (num_ant_paths + 1) < CS_MAX_ANT_PATHS ?
> > +                               (num_ant_paths + 1) : CS_MAX_ANT_PATHS;
> > +
> > +       dict_append_byte(dict, "antennaPermutationIndex", m2->ant_perm_=
index);
> > +
> > +       /* tonePctIQSamples: interleaved (i,q) pairs as "ai" */
> > +       key =3D "tonePctIQSamples";
> > +       dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY, NU=
LL,
> > +                                        &entry);
> > +       dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
> > +       dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT, "ai=
",
> > +                                        &variant);
> > +       dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY, "i"=
, &arr);
> > +       for (j =3D 0; j < num_paths; j++) {
> > +               dbus_int32_t i_s =3D m2->tone_pct[j].i_sample;
> > +               dbus_int32_t q_s =3D m2->tone_pct[j].q_sample;
> > +
> > +               dbus_message_iter_append_basic(&arr, DBUS_TYPE_INT32, &=
i_s);
> > +               dbus_message_iter_append_basic(&arr, DBUS_TYPE_INT32, &=
q_s);
> > +       }
> > +       dbus_message_iter_close_container(&variant, &arr);
> > +       dbus_message_iter_close_container(&entry, &variant);
> > +       dbus_message_iter_close_container(dict, &entry);
> > +
> > +       /* toneQualityIndicators: "ay" */
> > +       key =3D "toneQualityIndicators";
> > +       dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY, NU=
LL,
> > +                                        &entry);
> > +       dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
> > +       dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT, "ay=
",
> > +                                        &variant);
> > +       dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY, "y"=
, &arr);
> > +       for (j =3D 0; j < num_paths; j++) {
> > +               uint8_t tqi =3D m2->tone_quality_indicator[j];
> > +
> > +               dbus_message_iter_append_basic(&arr, DBUS_TYPE_BYTE, &t=
qi);
> > +       }
> > +       dbus_message_iter_close_container(&variant, &arr);
> > +       dbus_message_iter_close_container(&entry, &variant);
> > +       dbus_message_iter_close_container(dict, &entry);
> > +}
> > +
> > +static void append_proc_enable_config(DBusMessageIter *outer_dict,
> > +                               const struct rap_ev_cs_proc_enable_cmpl=
t *cfg)
> > +{
> > +       DBusMessageIter entry, variant, inner;
> > +       const char *key =3D "procedureEnableConfig";
> > +       dbus_uint32_t sub_evt_len_us;
> > +
> > +       sub_evt_len_us =3D cfg->sub_evt_len[0] |
> > +                        ((uint32_t)cfg->sub_evt_len[1] << 8) |
> > +                        ((uint32_t)cfg->sub_evt_len[2] << 16);
> > +
> > +       dbus_message_iter_open_container(outer_dict, DBUS_TYPE_DICT_ENT=
RY,
> > +                                        NULL, &entry);
> > +       dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
> > +       dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT, "a{=
sv}",
> > +                                        &variant);
> > +       dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY, "{s=
v}",
> > +                                        &inner);
> > +
> > +       dict_append_byte(&inner, "toneAntennaConfigSelection",
> > +                        cfg->tone_ant_config_sel);
> > +       dict_append_uint32(&inner, "subeventLenUs", sub_evt_len_us);
> > +       dict_append_byte(&inner, "subeventsPerEvent", cfg->sub_evts_per=
_evt);
> > +       dict_append_uint32(&inner, "subeventInterval", cfg->sub_evt_int=
rvl);
> > +       dict_append_uint32(&inner, "eventInterval", cfg->evt_intrvl);
> > +       dict_append_uint32(&inner, "procedureInterval", cfg->proc_intrv=
l);
> > +       dict_append_uint32(&inner, "procedureCount", cfg->proc_counter)=
;
> > +       dict_append_uint32(&inner, "maxProcedureLen", cfg->max_proc_len=
);
> > +
> > +       dbus_message_iter_close_container(&variant, &inner);
> > +       dbus_message_iter_close_container(&entry, &variant);
> > +       dbus_message_iter_close_container(outer_dict, &entry);
> > +}
> > +
> > +static void append_cs_config_param(DBusMessageIter *outer_dict,
> > +                               const struct bcs_procedure_data *bcs)
> > +{
> > +       DBusMessageIter entry, variant, inner;
> > +       const char *key =3D "csConfigParam";
> > +       const struct rap_ev_cs_config_cmplt *cfg =3D &bcs->cs_config;
> > +
> > +       dbus_message_iter_open_container(outer_dict, DBUS_TYPE_DICT_ENT=
RY,
> > +                                        NULL, &entry);
> > +       dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
> > +       dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT, "a{=
sv}",
> > +                                        &variant);
> > +       dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY, "{s=
v}",
> > +                                        &inner);
> > +
> > +       dict_append_byte(&inner, "modeType", cfg->main_mode_type);
> > +       dict_append_byte(&inner, "subModeType", cfg->sub_mode_type);
> > +       dict_append_byte(&inner, "rttType", cfg->rtt_type);
> > +       dict_append_byte_array(&inner, "channelMap", cfg->channel_map,
> > +                              sizeof(cfg->channel_map));
> > +       dict_append_byte(&inner, "minMainModeSteps", cfg->min_main_mode=
_steps);
> > +       dict_append_byte(&inner, "maxMainModeSteps", cfg->max_main_mode=
_steps);
> > +       dict_append_byte(&inner, "mainModeRepetition", cfg->main_mode_r=
ep);
> > +       dict_append_byte(&inner, "mode0Steps", cfg->mode_0_steps);
> > +       dict_append_byte(&inner, "role", cfg->role);
> > +       dict_append_byte(&inner, "csSyncPhyType", cfg->cs_sync_phy);
> > +       dict_append_byte(&inner, "channelSelectionType", cfg->channel_s=
el_type);
> > +       dict_append_byte(&inner, "ch3cShapeType", cfg->ch3c_shape);
> > +       dict_append_byte(&inner, "ch3cJump", cfg->ch3c_jump);
> > +       dict_append_byte(&inner, "channelMapRepetition", cfg->channel_m=
ap_rep);
> > +       dict_append_byte(&inner, "tIp1TimeUs", cfg->t_ip1_time);
> > +       dict_append_byte(&inner, "tIp2TimeUs", cfg->t_ip2_time);
> > +       dict_append_byte(&inner, "tFcsTimeUs", cfg->t_fcs_time);
> > +       dict_append_byte(&inner, "tPmTimeUs", cfg->t_pm_time);
> > +       dict_append_byte(&inner, "tSwTimeUsSupportedByLocal",
> > +                        bcs->t_sw_time_us_supported_by_local);
> > +       dict_append_byte(&inner, "tSwTimeUsSupportedByRemote",
> > +                        bcs->t_sw_time_us_supported_by_remote);
> > +       dict_append_uint32(&inner, "bleConnInterval", bcs->ble_conn_int=
erval);
> > +
> > +       dbus_message_iter_close_container(&variant, &inner);
> > +       dbus_message_iter_close_container(&entry, &variant);
> > +       dbus_message_iter_close_container(outer_dict, &entry);
> > +}
> > +
> > +static void append_step_to_dict(DBusMessageIter *dict,
> > +                               const struct cs_step_data *step,
> > +                               uint8_t num_ant_paths)
> > +{
> > +       DBusMessageIter entry, variant, inner;
> > +       const char *mode_key;
> > +
> > +       dict_append_byte(dict, "stepMode", step->step_mode);
> > +       dict_append_byte(dict, "stepChannel", step->step_chnl);
> > +
> > +       switch (step->step_mode) {
> > +       case CS_MODE_ZERO:
> > +               mode_key =3D "modeZeroData";
> > +               dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_E=
NTRY,
> > +                                                NULL, &entry);
> > +               dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING=
,
> > +                                              &mode_key);
> > +               dbus_message_iter_open_container(&entry, DBUS_TYPE_VARI=
ANT,
> > +                                                "a{sv}", &variant);
> > +               dbus_message_iter_open_container(&variant, DBUS_TYPE_AR=
RAY,
> > +                                                "{sv}", &inner);
> > +               append_mode_zero(&inner,
> > +                                &step->step_mode_data.mode_zero_data);
> > +               dbus_message_iter_close_container(&variant, &inner);
> > +               dbus_message_iter_close_container(&entry, &variant);
> > +               dbus_message_iter_close_container(dict, &entry);
> > +               break;
> > +
> > +       case CS_MODE_ONE:
> > +               mode_key =3D "modeOneData";
> > +               dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_E=
NTRY,
> > +                                                NULL, &entry);
> > +               dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING=
,
> > +                                              &mode_key);
> > +               dbus_message_iter_open_container(&entry, DBUS_TYPE_VARI=
ANT,
> > +                                                "a{sv}", &variant);
> > +               dbus_message_iter_open_container(&variant, DBUS_TYPE_AR=
RAY,
> > +                                                "{sv}", &inner);
> > +               append_mode_one(&inner,
> > +                               &step->step_mode_data.mode_one_data);
> > +               dbus_message_iter_close_container(&variant, &inner);
> > +               dbus_message_iter_close_container(&entry, &variant);
> > +               dbus_message_iter_close_container(dict, &entry);
> > +               break;
> > +
> > +       case CS_MODE_TWO:
> > +               mode_key =3D "modeTwoData";
> > +               dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_E=
NTRY,
> > +                                                NULL, &entry);
> > +               dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING=
,
> > +                                              &mode_key);
> > +               dbus_message_iter_open_container(&entry, DBUS_TYPE_VARI=
ANT,
> > +                                                "a{sv}", &variant);
> > +               dbus_message_iter_open_container(&variant, DBUS_TYPE_AR=
RAY,
> > +                                                "{sv}", &inner);
> > +               append_mode_two(&inner,
> > +                               &step->step_mode_data.mode_two_data,
> > +                               num_ant_paths);
> > +               dbus_message_iter_close_container(&variant, &inner);
> > +               dbus_message_iter_close_container(&entry, &variant);
> > +               dbus_message_iter_close_container(dict, &entry);
> > +               break;
> > +
> > +       case CS_MODE_THREE:
> > +               mode_key =3D "modeThreeData";
> > +               dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_E=
NTRY,
> > +                                                NULL, &entry);
> > +               dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING=
,
> > +                                              &mode_key);
> > +               dbus_message_iter_open_container(&entry, DBUS_TYPE_VARI=
ANT,
> > +                                                "a{sv}", &variant);
> > +               dbus_message_iter_open_container(&variant, DBUS_TYPE_AR=
RAY,
> > +                                                "{sv}", &inner);
> > +               append_mode_one(&inner,
> > +                       &step->step_mode_data.mode_three_data.mode_one_=
data);
> > +               append_mode_two(&inner,
> > +                       &step->step_mode_data.mode_three_data.mode_two_=
data,
> > +                       num_ant_paths);
> > +               dbus_message_iter_close_container(&variant, &inner);
> > +               dbus_message_iter_close_container(&entry, &variant);
> > +               dbus_message_iter_close_container(dict, &entry);
> > +               break;
> > +
> > +       default:
> > +               break;
> > +       }
> > +}
> > +
> > +static void append_subevent_to_dict(DBusMessageIter *dict,
> > +                               const struct cs_subevent_result_data *s=
ub)
> > +{
> > +       DBusMessageIter entry, variant, arr;
> > +       const char *key;
> > +       uint32_t i;
> > +
> > +       dict_append_int32(dict, "startAclConnEvtCounter",
> > +                         (dbus_int32_t)sub->start_acl_conn_evt_counter=
);
> > +       dict_append_int32(dict, "freqComp", (dbus_int32_t)sub->freq_com=
p);
> > +       dict_append_byte(dict, "refPwrLvl", (uint8_t)sub->ref_pwr_lvl);
> > +       dict_append_byte(dict, "numAntPaths", sub->num_ant_paths);
> > +       dict_append_byte(dict, "subeventAbortReason",
> > +                        sub->subevent_abort_reason);
> > +       dict_append_uint64(dict, "timestampNanos", sub->timestamp_nanos=
);
> > +       dict_append_uint32(dict, "numSteps", sub->num_steps);
> > +
> > +       /* stepData: av (each element is a{sv}) */
> > +       key =3D "stepData";
> > +       dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY, NU=
LL,
> > +                                        &entry);
> > +       dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
> > +       dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT, "av=
",
> > +                                        &variant);
> > +       dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY, "v"=
, &arr);
> > +       if (sub->step_data) {
> > +               for (i =3D 0; i < sub->num_steps; i++) {
> > +                       DBusMessageIter inner, step_dict;
> > +
> > +                       dbus_message_iter_open_container(&arr,
> > +                                       DBUS_TYPE_VARIANT, "a{sv}", &in=
ner);
> > +                       dbus_message_iter_open_container(&inner,
> > +                                       DBUS_TYPE_ARRAY, "{sv}", &step_=
dict);
> > +                       append_step_to_dict(&step_dict, &sub->step_data=
[i],
> > +                                           sub->num_ant_paths);
> > +                       dbus_message_iter_close_container(&inner, &step=
_dict);
> > +                       dbus_message_iter_close_container(&arr, &inner)=
;
> > +               }
> > +       }
> > +       dbus_message_iter_close_container(&variant, &arr);
> > +       dbus_message_iter_close_container(&entry, &variant);
> > +       dbus_message_iter_close_container(dict, &entry);
> > +}
> > +
> > +static void append_subevent_array(DBusMessageIter *outer_dict,
> > +                               const char *key,
> > +                               const struct cs_subevent_result_data *s=
ubevents,
> > +                               uint32_t count)
> > +{
> > +       DBusMessageIter entry, variant, arr;
> > +       uint32_t i;
> > +
> > +       dbus_message_iter_open_container(outer_dict, DBUS_TYPE_DICT_ENT=
RY,
> > +                                        NULL, &entry);
> > +       dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
> > +       dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT, "av=
",
> > +                                        &variant);
> > +       dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY, "v"=
, &arr);
> > +       for (i =3D 0; i < count; i++) {
> > +               DBusMessageIter inner, sub_dict;
> > +
> > +               dbus_message_iter_open_container(&arr, DBUS_TYPE_VARIAN=
T,
> > +                                                "a{sv}", &inner);
> > +               dbus_message_iter_open_container(&inner, DBUS_TYPE_ARRA=
Y,
> > +                                                "{sv}", &sub_dict);
> > +               append_subevent_to_dict(&sub_dict, &subevents[i]);
> > +               dbus_message_iter_close_container(&inner, &sub_dict);
> > +               dbus_message_iter_close_container(&arr, &inner);
> > +       }
> > +       dbus_message_iter_close_container(&variant, &arr);
> > +       dbus_message_iter_close_container(&entry, &variant);
> > +       dbus_message_iter_close_container(outer_dict, &entry);
> > +}
> > +
> > +static void rap_emit_procedure_data(struct rap_data *data,
> > +                               const struct bcs_procedure_data *bcs)
> > +{
> > +       DBusMessage *signal;
> > +       DBusMessageIter iter, dict;
> > +
> > +       signal =3D dbus_message_new_signal(device_get_path(data->device=
),
> > +                                        CS_INTERFACE, "ProcedureData")=
;
> > +       if (!signal) {
> > +               error("Failed to allocate ProcedureData signal");
> > +               return;
> > +       }
> > +
> > +       dbus_message_iter_init_append(signal, &iter);
> > +       dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY, "{sv}"=
, &dict);
> > +
> > +       dict_append_int32(&dict, "procedureCounter",
> > +                         (dbus_int32_t)bcs->procedure_counter);
> > +       dict_append_int32(&dict, "procedureSequence",
> > +                         (dbus_int32_t)bcs->procedure_sequence);
> > +       dict_append_byte(&dict, "initiatorSelectedTxPower",
> > +                        (uint8_t)bcs->initiator_selected_tx_power);
> > +       dict_append_byte(&dict, "reflectorSelectedTxPower",
> > +                        (uint8_t)bcs->reflector_selected_tx_power);
> > +
> > +       dict_append_uint32(&dict, "initiatorSubeventCount",
> > +                          bcs->initiator_subevent_count);
> > +       if (bcs->initiator_subevent_results &&
> > +                                       bcs->initiator_subevent_count >=
 0)
> > +               append_subevent_array(&dict, "initiatorSubeventResults"=
,
> > +                                     bcs->initiator_subevent_results,
> > +                                     bcs->initiator_subevent_count);
> > +
> > +       dict_append_byte(&dict, "initiatorProcedureAbortReason",
> > +                        bcs->initiator_procedure_abort_reason);
> > +
> > +       dict_append_uint32(&dict, "reflectorSubeventCount",
> > +                          bcs->reflector_subevent_count);
> > +       if (bcs->reflector_subevent_results &&
> > +                                       bcs->reflector_subevent_count >=
 0)
> > +               append_subevent_array(&dict, "reflectorSubeventResults"=
,
> > +                                     bcs->reflector_subevent_results,
> > +                                     bcs->reflector_subevent_count);
> > +
> > +       dict_append_byte(&dict, "reflectorProcedureAbortReason",
> > +                        bcs->reflector_procedure_abort_reason);
> > +
> > +       append_proc_enable_config(&dict, &bcs->proc_enable_config);
> > +       append_cs_config_param(&dict, bcs);
> > +
> > +       dbus_message_iter_close_container(&iter, &dict);
> > +
> > +       g_dbus_send_message(btd_get_dbus_connection(), signal);
> > +}
> > +
> > +static void rap_procedure_data(struct bt_rap *rap,
> > +                               struct bcs_procedure_data *bcs,
> > +                               void *user_data)
> > +{
> > +       struct rap_data *data =3D user_data;
> > +
> > +       DBG("procedure_counter=3D%u", bcs->procedure_counter);
> > +       rap_emit_procedure_data(data, bcs);
> > +}
> > +
> >  static DBusMessage *start_measurement(DBusConnection *conn,
> >                                 DBusMessage *msg, void *user_data)
> >  {
> > @@ -534,6 +1020,9 @@ bad_type:
> >         data->active_session.cfg           =3D cfg;
> >         data->active_session.freq          =3D freq;
> >
> > +       bt_rap_hci_set_procedure_data_cb(data->hci_sm, rap_procedure_da=
ta,
> > +                                        data, NULL);
> > +
> >         return dbus_message_new_method_return(msg);
> >  }
> >
> > @@ -588,6 +1077,11 @@ static const GDBusPropertyTable cs_dbus_propertie=
s[] =3D {
> >         { }
> >  };
> >
> > +static const GDBusSignalTable cs_dbus_signals[] =3D {
> > +       { GDBUS_SIGNAL("ProcedureData", GDBUS_ARGS({ "data", "a{sv}" })=
) },
> > +       { }
> > +};
> > +
> >  static void rap_measurement_timeout_cb(void *user_data)
> >  {
> >         struct rap_data *data =3D user_data;
> > @@ -752,7 +1246,8 @@ static int rap_accept(struct btd_service *service)
> >         g_dbus_register_interface(btd_get_dbus_connection(),
> >                                   device_get_path(data->device),
> >                                   CS_INTERFACE, cs_dbus_methods,
> > -                                 NULL, cs_dbus_properties, data, NULL)=
;
> > +                                 cs_dbus_signals, cs_dbus_properties,
> > +                                 data, NULL);
> >
> >         return 0;
> >  }
> > diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
> > index e57f967a2..3da98972e 100644
> > --- a/profiles/ranging/rap_hci.c
> > +++ b/profiles/ranging/rap_hci.c
> > @@ -442,6 +442,8 @@ static void rap_rd_loc_supp_cap_done_cb(const void =
*data, uint8_t size,
> >         DBG("Sending read remote capabilities for handle 0x%04X",
> >                 sm->active_conn_handle);
> >         bt_rap_read_remote_supported_capabilities(sm, sm->active_conn_h=
andle);
> > +
> > +       bt_rap_set_local_sw_time(sm->rap, rsp->t_sw_time_supported);
> >  }
> >
> >  static void rap_send_hci_cs_create_config_command(struct cs_state_mach=
ine *sm,
> > @@ -873,6 +875,8 @@ static void rap_rd_rmt_supp_cap_cmplt_evt(const voi=
d *data, uint8_t size,
> >                 cs_set_state(sm, CS_STATE_INIT);
> >                 rap_send_hci_def_settings_command(sm, evt);
> >         }
> > +
> > +       bt_rap_set_remote_sw_time(sm->rap, evt->t_sw_time_supported);
> >  }
> >
> >  static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
> > @@ -1162,6 +1166,46 @@ static void rap_cs_proc_enable_cmplt_evt(const v=
oid *data, uint8_t size,
> >                         &rap_ev, sm->rap);
> >  }
> >
> > +static void rap_le_conn_update_complete_evt(const void *data, uint8_t =
size,
> > +                                           void *user_data)
> > +{
> > +       struct cs_state_machine *sm =3D user_data;
> > +       const struct bt_hci_evt_le_conn_update_complete *evt;
> > +       struct rap_conn_mapping *mapping;
> > +       struct bt_rap *rap;
> > +       struct iovec iov;
> > +
> > +       if (!sm || !data ||
> > +           size < sizeof(struct bt_hci_evt_le_conn_update_complete))
> > +               return;
> > +
> > +       iov.iov_base =3D (void *) data;
> > +       iov.iov_len =3D size;
> > +
> > +       evt =3D util_iov_pull_mem(&iov, sizeof(*evt));
> > +       if (!evt) {
> > +               error("Failed to pull LE conn update complete struct");
> > +               return;
> > +       }
> > +
> > +       DBG("status=3D0x%02X handle=3D0x%04X interval=3D%u",
> > +           evt->status, evt->handle, evt->interval);
> > +
> > +       if (evt->status !=3D 0)
> > +               return;
> > +
> > +       mapping =3D find_mapping_by_handle(sm, evt->handle);
> > +       if (mapping && mapping->rap) {
> > +               DBG("Found handle 0x%04X in mapping cache", evt->handle=
);
> > +               rap =3D mapping->rap;
> > +       } else {
> > +               error("No mapping found for handle 0x%04X", evt->handle=
);
> > +               return;
> > +       }
> > +
> > +       bt_rap_set_conn_interval(rap, evt->interval);
> > +}
> > +
> >  static void parse_i_q_sample(struct iovec *iov, int16_t *i_sample,
> >                                 int16_t *q_sample)
> >  {
> > @@ -1662,6 +1706,8 @@ void *bt_rap_attach_hci(struct bt_rap *rap, struc=
t bt_hci *hci,
> >                                         rap_cs_subevt_result_evt },
> >                 { BT_HCI_EVT_LE_CS_SUBEVENT_RESULT_CONTINUE,
> >                                         rap_cs_subevt_result_cont_evt }=
,
> > +               { BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE,
> > +                                       rap_le_conn_update_complete_evt=
 },
> >         };
> >         struct cs_state_machine *sm;
> >         unsigned int i;
> > @@ -1781,6 +1827,19 @@ bool bt_rap_stop_measurement(void *hci_sm)
> >                                                 false);
> >  }
> >
> > +bool bt_rap_hci_set_procedure_data_cb(void *hci_sm,
> > +                               bt_rap_procedure_data_func_t cb,
> > +                               void *user_data,
> > +                               bt_rap_destroy_func_t destroy)
> > +{
> > +       struct cs_state_machine *sm =3D hci_sm;
> > +
> > +       if (!sm || !sm->rap)
> > +               return false;
> > +
> > +       return bt_rap_set_procedure_data_cb(sm->rap, cb, user_data, des=
troy);
> > +}
> > +
> >  bool bt_rap_set_conn_hndl(void *hci_sm, struct bt_rap *rap,
> >                 uint16_t handle, const uint8_t *bdaddr, uint8_t bdaddr_=
type,
> >                 bool is_central)
> > --
> > 2.34.1
> >
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
