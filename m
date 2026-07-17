Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B768D340418
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 15:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784303068; cv=pass; b=sxJu9Ua430ASKwWZwP5kqiDrzHBoZp2OAf/nCUWW97URry0IcrzpBJP6MtEjK6M7fsr6NVwgL0/Ow6Y19dYOvRq+dZ/YHHP6gW2BkQhSuAiNrs3Iyg2I6KBe0N8UUnP//a6aq3VXNOnmtCBif3zBKtfcl4OsV64ULM5acDGd4w8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784303068; c=relaxed/simple;
	bh=cM5v2hiDSiRBnBqWQmBCtXxZyDmGtG5fpZWBfRmItFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DnQ58FNlLzM8zouTRUtCLLMvYNXavkzoCT6MHndb/f/uuac/p1Zn3VXhqtoPi9n5FTTnv5QiJFE0s3/a4Dy6qVuDRb0T2pEJ+roVt8d9vekPlisDXP2lT3oUgRNS+0BwnS3hiWdgzNBiGCvCjC8Vk7257PZ6RIj+x1tv99mgtcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDwevoOO; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDwevoOO"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8143daf89c7so44170587b3.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 08:44:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784303065; cv=none;
        d=google.com; s=arc-20260327;
        b=Xtbbt+ESRSYI1xICUYEWNr2VNxYIEDE9h9z4jwQvCjFEnHjxMdT/Rw5gRvyAG3sOLM
         aveSud7Kv03OC1C6PAf/wBTsQ0+OIHKnmRwLwtjguTLw0st9ZkwGjX7agDrN+FUjvv8I
         O7aj8SytYR2yNPTkJCMFXir1G1KawvO2bHd8gM3lrGhDkpP0pN+B76ozu4YjKUeDL6PW
         P+MmQ8fGPQS6mFrdNR9d3he3lFsyzDZt0A9sreU6P1DW9/OQFTxj7z6uk1tL1fVCTc0R
         J4ZagLVk8swEgbjBw+sZF9/RAprYc96UZVLl29yj827s4bNWsJo5D7t2oOI45FXY0ReW
         /UAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QKjjf+Wxrl3t1767pPpQlXc477izIJ+FXNrMDk3RRQY=;
        fh=jBLUrRQ7ZsNUcAcd5QG5N83k8jhBNkoqDFBeOlOjxqk=;
        b=YQ6k2SmhiTr/S6h9MDnjHY9hJwxePgV+tcTHrKv0a7k661lu2eLB6GxdjwHkd5W/WN
         GTAx574bW80xrBsTPrR2rYGqHFVkGUg2EcT/yWPGj5bxschnZc473QVk07WSJwxYyha/
         g2NgaR9U3dHdMdSmftxHJbbaL/8Zo4aDk1rtNiEg8fMcyVwlKb/JfLY6MVaz0rr8shC/
         66QgT0ae6yluNUs/+qUuLgCyY1Sddj2MPgTzJX6W5jpnC8pjjUpQa4SzTJ5D71+Q0LRn
         9YFF4MHtkciaYyQ9GUvVa56ACdsMiJt6kJXXDNuQJh46NuyUSrh8MussTAIvYRYtO+Dk
         /drQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784303065; x=1784907865; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QKjjf+Wxrl3t1767pPpQlXc477izIJ+FXNrMDk3RRQY=;
        b=dDwevoOOSyrckBV6QFPenh4F08Q+wIA2L/uZvqEane/uJ6RXtHOqUn63GUFdX0gUmG
         FMr24RetmDDUbkOtDS17fHWYZq03e8FRxs93G1/oMJILkHT2ilQtfXu5Zve7vtip4Yzu
         /LJIRNhPK2WqpfKyG9GB8Jv/QY+pYgsh1aWY4AFAfFFWMFd2x4z/ECKh0jtROKhD3nht
         //GwNWunbZb76uiLmYrJpqI3bvA0cBssF1uZqru8aeFXr1GAvseUjko/4I/PXFr7/8hC
         l8OCx11RnAgv/dYRg9TvSPzLuBX7ddvsBr1RY5Brf4mgN+em+kDk/gBtoR1liM6MBAyW
         nOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784303065; x=1784907865;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QKjjf+Wxrl3t1767pPpQlXc477izIJ+FXNrMDk3RRQY=;
        b=mrEbDlw8l9GgPi7a9o7jC1XQ0OyqARdzFg9m9Ny5vUmtnOxnRhXJcNKQmdKkumHVOS
         1QDROm7DOk7Q/aU/Y4ev0oDQVE5JR+oybjP7xfMA3l9NQ8d5wPwZwpYc/ifdRZpks3Ac
         V06oGGUt9E9w2VIxVfm7fBsKJNigbDwAcvMs9oLaOoERuU/O0lNctFprg/vmUoxegGQn
         GQRR0+wW5080MZ3w7kqWCS1KGH8MQoMUm/5KAdYylt7u6k+GQ+imA2kPbTICUgev32fQ
         MFazAkhIindIP0B15M8U4yxfwQfIEQuvCqgw1Frd+QlpwaHfywWolUOA9yMl7zXUYpwV
         6Z/w==
X-Gm-Message-State: AOJu0YweLTrGwhPlk/vaHs9icoYV38kbzWybz1QsxKlYLAAdjX0Rw3Ap
	NO9fY887Y0vPGU0deyGYIpNaZiM3vsaTjK6SD+Y9HUiBBc1iKqoesstV2nHi9J/xwuF76fT28Mz
	Vi0n+MdfQBr86M85vFOQr+SSUJecdXYo=
X-Gm-Gg: AfdE7clJ6wOhrPd237M+xPjj77GE6TPfjUNhmR5YtW1mcxtxFQ/HRSmQgcPy4M166He
	hzij1pfSMXyu3+PFpAGdPmewdx4LI4MPelRBJ43lW4t0OjCZ+E1P5VJKRZbMdlSEpCkeLaQPZKd
	f32UT4h9GKew6ET4Xhc0S/3EaPlF6hN9Fenuw6aQYGWnrp4YMxPbdwmq9czFSacgv0NfNzoUEbK
	aNsqMOM45NnJnDq68nqb68JOkWcde6uOku7f+BToOFSuf33a+PT69AUEmhARgbyzS/JjpwYOz23
	4Rr8cGfL77Ei3gWn2beZaiXXzO+gspL6CxXxc8rg3fUWJXwgOrB653smq+M=
X-Received: by 2002:a05:690c:650e:b0:81e:6cd1:531f with SMTP id
 00721157ae682-81ef25b9f84mr11083157b3.46.1784303064271; Fri, 17 Jul 2026
 08:44:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717072647.255002-1-prathm@qti.qualcomm.com>
 <20260717072647.255002-3-prathm@qti.qualcomm.com> <CABBYNZ++i-JNcjCz5PG5JKNf9aWgMkm05i4-m7b5TPhTdMmojg@mail.gmail.com>
 <CABBYNZL1rf4LbLNiese8DwRBMMgtCps-VH-nNCbZ9G1Xu=1RBQ@mail.gmail.com>
In-Reply-To: <CABBYNZL1rf4LbLNiese8DwRBMMgtCps-VH-nNCbZ9G1Xu=1RBQ@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 17 Jul 2026 11:44:12 -0400
X-Gm-Features: AUfX_mzIaSJWRLuzQ3Y6wIXRdTv3hcJtTI9zOUUhRQ1KCq-aULGlcwuWVMhzT_o
Message-ID: <CABBYNZKzMDdapr8cXq6Yy_4w5Er7iw78a2EmQwmS74Vi_EWuUg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 2/2] profiles/ranging: Add D-Bus ProcedureData
 signal for Channel Sounding
To: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 17, 2026 at 11:17=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi.
>
> On Fri, Jul 17, 2026 at 11:07=E2=80=AFAM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Prathibha,
> >
> > On Fri, Jul 17, 2026 at 3:27=E2=80=AFAM Prathibha Madugonde
> > <prathibha.madugonde@oss.qualcomm.com> wrote:
> > >
> > > From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
> > >
> > > Marshal bcs_procedure_data (subevents, steps, mode 0/1/2/3 results,
> > > and CS/procedure-enable config) into an a{sv} dictionary and emit it
> > > as a new ProcedureData signal on the CS D-Bus interface.
> >
> > Was this documented though? It doesn't seem to follow the likes of
> > https://github.com/bluez/bluez/blob/master/doc/org.bluez.ChannelSoundin=
g1.rst,
> > for instance we don't use camel case for dictionary options. Also, if
> > this is a result of `StartMeasurement`, we should probably signal it
> > as Results or something like that, but I'd start with documentation so
> > we can agree on the overall design.
>
> Ok, looks like this does follow the documentation already:
>
> https://github.com/bluez/bluez/blob/master/doc/org.bluez.ChannelSounding1=
.rst#void-proceduredatadict-data
>
> That said that will probably need updating since some dictionaries use
> camel case and others don't, so this needs to converge to a single
> format.

I chatted with Marcel, and we concluded this should probably go as a
data blob since the fields are somewhat analog and meaningless
individually, packing it into a dictionary just to unpack it later is
useless.

> > > Register a procedure_data callback on the RAP HCI state machine so
> > > rap.c is notified when a procedure completes, and propagate the
> > > locally supported T_SW time capability from the read-local-supported-
> > > capabilities response into bt_rap.
> > >
> > > ---
> > >  profiles/ranging/rap.c     | 497 +++++++++++++++++++++++++++++++++++=
+-
> > >  profiles/ranging/rap_hci.c |  59 +++++
> > >  2 files changed, 555 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/profiles/ranging/rap.c b/profiles/ranging/rap.c
> > > index 3ffc0da76..42e1ef2a4 100644
> > > --- a/profiles/ranging/rap.c
> > > +++ b/profiles/ranging/rap.c
> > > @@ -379,6 +379,492 @@ static const struct cs_dict_param_desc *cs_find=
_dict_param_desc(
> > >         return NULL;
> > >  }
> > >
> > > +static void dict_append_byte(DBusMessageIter *dict, const char *key,
> > > +                               uint8_t val)
> > > +{
> > > +       DBusMessageIter entry, variant;
> > > +
> > > +       dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY, =
NULL,
> > > +                                               &entry);
> > > +       dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key=
);
> > > +       dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT, "=
y",
> > > +                                               &variant);
> > > +       dbus_message_iter_append_basic(&variant, DBUS_TYPE_BYTE, &val=
);
> > > +       dbus_message_iter_close_container(&entry, &variant);
> > > +       dbus_message_iter_close_container(dict, &entry);
> > > +}
> > > +
> > > +static void dict_append_int32(DBusMessageIter *dict, const char *key=
,
> > > +                               dbus_int32_t val)
> > > +{
> > > +       DBusMessageIter entry, variant;
> > > +
> > > +       dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY, =
NULL,
> > > +                                               &entry);
> > > +       dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key=
);
> > > +       dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT, "=
i",
> > > +                                               &variant);
> > > +       dbus_message_iter_append_basic(&variant, DBUS_TYPE_INT32, &va=
l);
> > > +       dbus_message_iter_close_container(&entry, &variant);
> > > +       dbus_message_iter_close_container(dict, &entry);
> > > +}
> > > +
> > > +static void dict_append_uint32(DBusMessageIter *dict, const char *ke=
y,
> > > +                               dbus_uint32_t val)
> > > +{
> > > +       DBusMessageIter entry, variant;
> > > +
> > > +       dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY, =
NULL,
> > > +                                               &entry);
> > > +       dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key=
);
> > > +       dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT, "=
u",
> > > +                                               &variant);
> > > +       dbus_message_iter_append_basic(&variant, DBUS_TYPE_UINT32, &v=
al);
> > > +       dbus_message_iter_close_container(&entry, &variant);
> > > +       dbus_message_iter_close_container(dict, &entry);
> > > +}
> > > +
> > > +static void dict_append_uint64(DBusMessageIter *dict, const char *ke=
y,
> > > +                               dbus_uint64_t val)
> > > +{
> > > +       DBusMessageIter entry, variant;
> > > +
> > > +       dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY, =
NULL,
> > > +                                               &entry);
> > > +       dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key=
);
> > > +       dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT, "=
t",
> > > +                                               &variant);
> > > +       dbus_message_iter_append_basic(&variant, DBUS_TYPE_UINT64, &v=
al);
> > > +       dbus_message_iter_close_container(&entry, &variant);
> > > +       dbus_message_iter_close_container(dict, &entry);
> > > +}
> > > +
> > > +static void dict_append_byte_array(DBusMessageIter *dict, const char=
 *key,
> > > +                                       const uint8_t *data, int len)
> > > +{
> > > +       DBusMessageIter entry, variant, arr;
> > > +       int i;
> > > +
> > > +       dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY, =
NULL,
> > > +                                               &entry);
> > > +       dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key=
);
> > > +       dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT, "=
ay",
> > > +                                               &variant);
> > > +       dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY, "=
y", &arr);
> > > +       for (i =3D 0; i < len; i++)
> > > +               dbus_message_iter_append_basic(&arr, DBUS_TYPE_BYTE, =
&data[i]);
> > > +       dbus_message_iter_close_container(&variant, &arr);
> > > +       dbus_message_iter_close_container(&entry, &variant);
> > > +       dbus_message_iter_close_container(dict, &entry);
> > > +}
> > > +
> > > +static void append_mode_zero(DBusMessageIter *dict,
> > > +                               const struct cs_mode_zero_data *m0)
> > > +{
> > > +       dict_append_byte(dict, "packetQuality", m0->packet_quality);
> > > +       dict_append_byte(dict, "packetRssiDbm", m0->packet_rssi_dbm);
> > > +       dict_append_byte(dict, "packetAntenna", m0->packet_ant);
> > > +       dict_append_int32(dict, "initiatorMeasuredFreqOffset",
> > > +                               (dbus_int32_t)m0->init_measured_freq_=
offset);
> > > +}
> > > +
> > > +static void append_pct_iq_pair(DBusMessageIter *dict, const char *ke=
y,
> > > +                               const struct pct_iq_sample *pct)
> > > +{
> > > +       DBusMessageIter entry, variant, arr;
> > > +       dbus_int32_t i_s =3D pct->i_sample;
> > > +       dbus_int32_t q_s =3D pct->q_sample;
> > > +
> > > +       dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY, =
NULL,
> > > +                                        &entry);
> > > +       dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key=
);
> > > +       dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT, "=
ai",
> > > +                                        &variant);
> > > +       dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY, "=
i", &arr);
> > > +       dbus_message_iter_append_basic(&arr, DBUS_TYPE_INT32, &i_s);
> > > +       dbus_message_iter_append_basic(&arr, DBUS_TYPE_INT32, &q_s);
> > > +       dbus_message_iter_close_container(&variant, &arr);
> > > +       dbus_message_iter_close_container(&entry, &variant);
> > > +       dbus_message_iter_close_container(dict, &entry);
> > > +}
> > > +
> > > +static void append_mode_one(DBusMessageIter *dict,
> > > +                               const struct cs_mode_one_data *m1)
> > > +{
> > > +       dict_append_byte(dict, "packetQuality", m1->packet_quality);
> > > +       dict_append_byte(dict, "packetNadm", m1->packet_nadm);
> > > +       dict_append_byte(dict, "packetRssiDbm", m1->packet_rssi_dbm);
> > > +       dict_append_int32(dict, "toaTodInitiator",
> > > +                               (dbus_int32_t)m1->toa_tod_init);
> > > +       dict_append_int32(dict, "todToaReflector",
> > > +                               (dbus_int32_t)m1->tod_toa_refl);
> > > +       dict_append_byte(dict, "packetAntenna", m1->packet_ant);
> > > +       append_pct_iq_pair(dict, "packetPct1", &m1->packet_pct1);
> > > +       append_pct_iq_pair(dict, "packetPct2", &m1->packet_pct2);
> > > +}
> > > +
> > > +static void append_mode_two(DBusMessageIter *dict,
> > > +                               const struct cs_mode_two_data *m2,
> > > +                               uint8_t num_ant_paths)
> > > +{
> > > +       DBusMessageIter entry, variant, arr;
> > > +       const char *key;
> > > +       int j;
> > > +       int num_paths;
> > > +
> > > +       /*
> > > +        * num_ant_paths is the HCI "number of antenna paths" value
> > > +        * (0-indexed), so actual tone sample count =3D num_ant_paths=
 + 1,
> > > +        * capped at array size.
> > > +        */
> > > +       num_paths =3D (num_ant_paths + 1) < CS_MAX_ANT_PATHS ?
> > > +                               (num_ant_paths + 1) : CS_MAX_ANT_PATH=
S;
> > > +
> > > +       dict_append_byte(dict, "antennaPermutationIndex", m2->ant_per=
m_index);
> > > +
> > > +       /* tonePctIQSamples: interleaved (i,q) pairs as "ai" */
> > > +       key =3D "tonePctIQSamples";
> > > +       dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY, =
NULL,
> > > +                                        &entry);
> > > +       dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key=
);
> > > +       dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT, "=
ai",
> > > +                                        &variant);
> > > +       dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY, "=
i", &arr);
> > > +       for (j =3D 0; j < num_paths; j++) {
> > > +               dbus_int32_t i_s =3D m2->tone_pct[j].i_sample;
> > > +               dbus_int32_t q_s =3D m2->tone_pct[j].q_sample;
> > > +
> > > +               dbus_message_iter_append_basic(&arr, DBUS_TYPE_INT32,=
 &i_s);
> > > +               dbus_message_iter_append_basic(&arr, DBUS_TYPE_INT32,=
 &q_s);
> > > +       }
> > > +       dbus_message_iter_close_container(&variant, &arr);
> > > +       dbus_message_iter_close_container(&entry, &variant);
> > > +       dbus_message_iter_close_container(dict, &entry);
> > > +
> > > +       /* toneQualityIndicators: "ay" */
> > > +       key =3D "toneQualityIndicators";
> > > +       dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY, =
NULL,
> > > +                                        &entry);
> > > +       dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key=
);
> > > +       dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT, "=
ay",
> > > +                                        &variant);
> > > +       dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY, "=
y", &arr);
> > > +       for (j =3D 0; j < num_paths; j++) {
> > > +               uint8_t tqi =3D m2->tone_quality_indicator[j];
> > > +
> > > +               dbus_message_iter_append_basic(&arr, DBUS_TYPE_BYTE, =
&tqi);
> > > +       }
> > > +       dbus_message_iter_close_container(&variant, &arr);
> > > +       dbus_message_iter_close_container(&entry, &variant);
> > > +       dbus_message_iter_close_container(dict, &entry);
> > > +}
> > > +
> > > +static void append_proc_enable_config(DBusMessageIter *outer_dict,
> > > +                               const struct rap_ev_cs_proc_enable_cm=
plt *cfg)
> > > +{
> > > +       DBusMessageIter entry, variant, inner;
> > > +       const char *key =3D "procedureEnableConfig";
> > > +       dbus_uint32_t sub_evt_len_us;
> > > +
> > > +       sub_evt_len_us =3D cfg->sub_evt_len[0] |
> > > +                        ((uint32_t)cfg->sub_evt_len[1] << 8) |
> > > +                        ((uint32_t)cfg->sub_evt_len[2] << 16);
> > > +
> > > +       dbus_message_iter_open_container(outer_dict, DBUS_TYPE_DICT_E=
NTRY,
> > > +                                        NULL, &entry);
> > > +       dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key=
);
> > > +       dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT, "=
a{sv}",
> > > +                                        &variant);
> > > +       dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY, "=
{sv}",
> > > +                                        &inner);
> > > +
> > > +       dict_append_byte(&inner, "toneAntennaConfigSelection",
> > > +                        cfg->tone_ant_config_sel);
> > > +       dict_append_uint32(&inner, "subeventLenUs", sub_evt_len_us);
> > > +       dict_append_byte(&inner, "subeventsPerEvent", cfg->sub_evts_p=
er_evt);
> > > +       dict_append_uint32(&inner, "subeventInterval", cfg->sub_evt_i=
ntrvl);
> > > +       dict_append_uint32(&inner, "eventInterval", cfg->evt_intrvl);
> > > +       dict_append_uint32(&inner, "procedureInterval", cfg->proc_int=
rvl);
> > > +       dict_append_uint32(&inner, "procedureCount", cfg->proc_counte=
r);
> > > +       dict_append_uint32(&inner, "maxProcedureLen", cfg->max_proc_l=
en);
> > > +
> > > +       dbus_message_iter_close_container(&variant, &inner);
> > > +       dbus_message_iter_close_container(&entry, &variant);
> > > +       dbus_message_iter_close_container(outer_dict, &entry);
> > > +}
> > > +
> > > +static void append_cs_config_param(DBusMessageIter *outer_dict,
> > > +                               const struct bcs_procedure_data *bcs)
> > > +{
> > > +       DBusMessageIter entry, variant, inner;
> > > +       const char *key =3D "csConfigParam";
> > > +       const struct rap_ev_cs_config_cmplt *cfg =3D &bcs->cs_config;
> > > +
> > > +       dbus_message_iter_open_container(outer_dict, DBUS_TYPE_DICT_E=
NTRY,
> > > +                                        NULL, &entry);
> > > +       dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key=
);
> > > +       dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT, "=
a{sv}",
> > > +                                        &variant);
> > > +       dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY, "=
{sv}",
> > > +                                        &inner);
> > > +
> > > +       dict_append_byte(&inner, "modeType", cfg->main_mode_type);
> > > +       dict_append_byte(&inner, "subModeType", cfg->sub_mode_type);
> > > +       dict_append_byte(&inner, "rttType", cfg->rtt_type);
> > > +       dict_append_byte_array(&inner, "channelMap", cfg->channel_map=
,
> > > +                              sizeof(cfg->channel_map));
> > > +       dict_append_byte(&inner, "minMainModeSteps", cfg->min_main_mo=
de_steps);
> > > +       dict_append_byte(&inner, "maxMainModeSteps", cfg->max_main_mo=
de_steps);
> > > +       dict_append_byte(&inner, "mainModeRepetition", cfg->main_mode=
_rep);
> > > +       dict_append_byte(&inner, "mode0Steps", cfg->mode_0_steps);
> > > +       dict_append_byte(&inner, "role", cfg->role);
> > > +       dict_append_byte(&inner, "csSyncPhyType", cfg->cs_sync_phy);
> > > +       dict_append_byte(&inner, "channelSelectionType", cfg->channel=
_sel_type);
> > > +       dict_append_byte(&inner, "ch3cShapeType", cfg->ch3c_shape);
> > > +       dict_append_byte(&inner, "ch3cJump", cfg->ch3c_jump);
> > > +       dict_append_byte(&inner, "channelMapRepetition", cfg->channel=
_map_rep);
> > > +       dict_append_byte(&inner, "tIp1TimeUs", cfg->t_ip1_time);
> > > +       dict_append_byte(&inner, "tIp2TimeUs", cfg->t_ip2_time);
> > > +       dict_append_byte(&inner, "tFcsTimeUs", cfg->t_fcs_time);
> > > +       dict_append_byte(&inner, "tPmTimeUs", cfg->t_pm_time);
> > > +       dict_append_byte(&inner, "tSwTimeUsSupportedByLocal",
> > > +                        bcs->t_sw_time_us_supported_by_local);
> > > +       dict_append_byte(&inner, "tSwTimeUsSupportedByRemote",
> > > +                        bcs->t_sw_time_us_supported_by_remote);
> > > +       dict_append_uint32(&inner, "bleConnInterval", bcs->ble_conn_i=
nterval);
> > > +
> > > +       dbus_message_iter_close_container(&variant, &inner);
> > > +       dbus_message_iter_close_container(&entry, &variant);
> > > +       dbus_message_iter_close_container(outer_dict, &entry);
> > > +}
> > > +
> > > +static void append_step_to_dict(DBusMessageIter *dict,
> > > +                               const struct cs_step_data *step,
> > > +                               uint8_t num_ant_paths)
> > > +{
> > > +       DBusMessageIter entry, variant, inner;
> > > +       const char *mode_key;
> > > +
> > > +       dict_append_byte(dict, "stepMode", step->step_mode);
> > > +       dict_append_byte(dict, "stepChannel", step->step_chnl);
> > > +
> > > +       switch (step->step_mode) {
> > > +       case CS_MODE_ZERO:
> > > +               mode_key =3D "modeZeroData";
> > > +               dbus_message_iter_open_container(dict, DBUS_TYPE_DICT=
_ENTRY,
> > > +                                                NULL, &entry);
> > > +               dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRI=
NG,
> > > +                                              &mode_key);
> > > +               dbus_message_iter_open_container(&entry, DBUS_TYPE_VA=
RIANT,
> > > +                                                "a{sv}", &variant);
> > > +               dbus_message_iter_open_container(&variant, DBUS_TYPE_=
ARRAY,
> > > +                                                "{sv}", &inner);
> > > +               append_mode_zero(&inner,
> > > +                                &step->step_mode_data.mode_zero_data=
);
> > > +               dbus_message_iter_close_container(&variant, &inner);
> > > +               dbus_message_iter_close_container(&entry, &variant);
> > > +               dbus_message_iter_close_container(dict, &entry);
> > > +               break;
> > > +
> > > +       case CS_MODE_ONE:
> > > +               mode_key =3D "modeOneData";
> > > +               dbus_message_iter_open_container(dict, DBUS_TYPE_DICT=
_ENTRY,
> > > +                                                NULL, &entry);
> > > +               dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRI=
NG,
> > > +                                              &mode_key);
> > > +               dbus_message_iter_open_container(&entry, DBUS_TYPE_VA=
RIANT,
> > > +                                                "a{sv}", &variant);
> > > +               dbus_message_iter_open_container(&variant, DBUS_TYPE_=
ARRAY,
> > > +                                                "{sv}", &inner);
> > > +               append_mode_one(&inner,
> > > +                               &step->step_mode_data.mode_one_data);
> > > +               dbus_message_iter_close_container(&variant, &inner);
> > > +               dbus_message_iter_close_container(&entry, &variant);
> > > +               dbus_message_iter_close_container(dict, &entry);
> > > +               break;
> > > +
> > > +       case CS_MODE_TWO:
> > > +               mode_key =3D "modeTwoData";
> > > +               dbus_message_iter_open_container(dict, DBUS_TYPE_DICT=
_ENTRY,
> > > +                                                NULL, &entry);
> > > +               dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRI=
NG,
> > > +                                              &mode_key);
> > > +               dbus_message_iter_open_container(&entry, DBUS_TYPE_VA=
RIANT,
> > > +                                                "a{sv}", &variant);
> > > +               dbus_message_iter_open_container(&variant, DBUS_TYPE_=
ARRAY,
> > > +                                                "{sv}", &inner);
> > > +               append_mode_two(&inner,
> > > +                               &step->step_mode_data.mode_two_data,
> > > +                               num_ant_paths);
> > > +               dbus_message_iter_close_container(&variant, &inner);
> > > +               dbus_message_iter_close_container(&entry, &variant);
> > > +               dbus_message_iter_close_container(dict, &entry);
> > > +               break;
> > > +
> > > +       case CS_MODE_THREE:
> > > +               mode_key =3D "modeThreeData";
> > > +               dbus_message_iter_open_container(dict, DBUS_TYPE_DICT=
_ENTRY,
> > > +                                                NULL, &entry);
> > > +               dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRI=
NG,
> > > +                                              &mode_key);
> > > +               dbus_message_iter_open_container(&entry, DBUS_TYPE_VA=
RIANT,
> > > +                                                "a{sv}", &variant);
> > > +               dbus_message_iter_open_container(&variant, DBUS_TYPE_=
ARRAY,
> > > +                                                "{sv}", &inner);
> > > +               append_mode_one(&inner,
> > > +                       &step->step_mode_data.mode_three_data.mode_on=
e_data);
> > > +               append_mode_two(&inner,
> > > +                       &step->step_mode_data.mode_three_data.mode_tw=
o_data,
> > > +                       num_ant_paths);
> > > +               dbus_message_iter_close_container(&variant, &inner);
> > > +               dbus_message_iter_close_container(&entry, &variant);
> > > +               dbus_message_iter_close_container(dict, &entry);
> > > +               break;
> > > +
> > > +       default:
> > > +               break;
> > > +       }
> > > +}
> > > +
> > > +static void append_subevent_to_dict(DBusMessageIter *dict,
> > > +                               const struct cs_subevent_result_data =
*sub)
> > > +{
> > > +       DBusMessageIter entry, variant, arr;
> > > +       const char *key;
> > > +       uint32_t i;
> > > +
> > > +       dict_append_int32(dict, "startAclConnEvtCounter",
> > > +                         (dbus_int32_t)sub->start_acl_conn_evt_count=
er);
> > > +       dict_append_int32(dict, "freqComp", (dbus_int32_t)sub->freq_c=
omp);
> > > +       dict_append_byte(dict, "refPwrLvl", (uint8_t)sub->ref_pwr_lvl=
);
> > > +       dict_append_byte(dict, "numAntPaths", sub->num_ant_paths);
> > > +       dict_append_byte(dict, "subeventAbortReason",
> > > +                        sub->subevent_abort_reason);
> > > +       dict_append_uint64(dict, "timestampNanos", sub->timestamp_nan=
os);
> > > +       dict_append_uint32(dict, "numSteps", sub->num_steps);
> > > +
> > > +       /* stepData: av (each element is a{sv}) */
> > > +       key =3D "stepData";
> > > +       dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY, =
NULL,
> > > +                                        &entry);
> > > +       dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key=
);
> > > +       dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT, "=
av",
> > > +                                        &variant);
> > > +       dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY, "=
v", &arr);
> > > +       if (sub->step_data) {
> > > +               for (i =3D 0; i < sub->num_steps; i++) {
> > > +                       DBusMessageIter inner, step_dict;
> > > +
> > > +                       dbus_message_iter_open_container(&arr,
> > > +                                       DBUS_TYPE_VARIANT, "a{sv}", &=
inner);
> > > +                       dbus_message_iter_open_container(&inner,
> > > +                                       DBUS_TYPE_ARRAY, "{sv}", &ste=
p_dict);
> > > +                       append_step_to_dict(&step_dict, &sub->step_da=
ta[i],
> > > +                                           sub->num_ant_paths);
> > > +                       dbus_message_iter_close_container(&inner, &st=
ep_dict);
> > > +                       dbus_message_iter_close_container(&arr, &inne=
r);
> > > +               }
> > > +       }
> > > +       dbus_message_iter_close_container(&variant, &arr);
> > > +       dbus_message_iter_close_container(&entry, &variant);
> > > +       dbus_message_iter_close_container(dict, &entry);
> > > +}
> > > +
> > > +static void append_subevent_array(DBusMessageIter *outer_dict,
> > > +                               const char *key,
> > > +                               const struct cs_subevent_result_data =
*subevents,
> > > +                               uint32_t count)
> > > +{
> > > +       DBusMessageIter entry, variant, arr;
> > > +       uint32_t i;
> > > +
> > > +       dbus_message_iter_open_container(outer_dict, DBUS_TYPE_DICT_E=
NTRY,
> > > +                                        NULL, &entry);
> > > +       dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key=
);
> > > +       dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT, "=
av",
> > > +                                        &variant);
> > > +       dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY, "=
v", &arr);
> > > +       for (i =3D 0; i < count; i++) {
> > > +               DBusMessageIter inner, sub_dict;
> > > +
> > > +               dbus_message_iter_open_container(&arr, DBUS_TYPE_VARI=
ANT,
> > > +                                                "a{sv}", &inner);
> > > +               dbus_message_iter_open_container(&inner, DBUS_TYPE_AR=
RAY,
> > > +                                                "{sv}", &sub_dict);
> > > +               append_subevent_to_dict(&sub_dict, &subevents[i]);
> > > +               dbus_message_iter_close_container(&inner, &sub_dict);
> > > +               dbus_message_iter_close_container(&arr, &inner);
> > > +       }
> > > +       dbus_message_iter_close_container(&variant, &arr);
> > > +       dbus_message_iter_close_container(&entry, &variant);
> > > +       dbus_message_iter_close_container(outer_dict, &entry);
> > > +}
> > > +
> > > +static void rap_emit_procedure_data(struct rap_data *data,
> > > +                               const struct bcs_procedure_data *bcs)
> > > +{
> > > +       DBusMessage *signal;
> > > +       DBusMessageIter iter, dict;
> > > +
> > > +       signal =3D dbus_message_new_signal(device_get_path(data->devi=
ce),
> > > +                                        CS_INTERFACE, "ProcedureData=
");
> > > +       if (!signal) {
> > > +               error("Failed to allocate ProcedureData signal");
> > > +               return;
> > > +       }
> > > +
> > > +       dbus_message_iter_init_append(signal, &iter);
> > > +       dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY, "{sv=
}", &dict);
> > > +
> > > +       dict_append_int32(&dict, "procedureCounter",
> > > +                         (dbus_int32_t)bcs->procedure_counter);
> > > +       dict_append_int32(&dict, "procedureSequence",
> > > +                         (dbus_int32_t)bcs->procedure_sequence);
> > > +       dict_append_byte(&dict, "initiatorSelectedTxPower",
> > > +                        (uint8_t)bcs->initiator_selected_tx_power);
> > > +       dict_append_byte(&dict, "reflectorSelectedTxPower",
> > > +                        (uint8_t)bcs->reflector_selected_tx_power);
> > > +
> > > +       dict_append_uint32(&dict, "initiatorSubeventCount",
> > > +                          bcs->initiator_subevent_count);
> > > +       if (bcs->initiator_subevent_results &&
> > > +                                       bcs->initiator_subevent_count=
 > 0)
> > > +               append_subevent_array(&dict, "initiatorSubeventResult=
s",
> > > +                                     bcs->initiator_subevent_results=
,
> > > +                                     bcs->initiator_subevent_count);
> > > +
> > > +       dict_append_byte(&dict, "initiatorProcedureAbortReason",
> > > +                        bcs->initiator_procedure_abort_reason);
> > > +
> > > +       dict_append_uint32(&dict, "reflectorSubeventCount",
> > > +                          bcs->reflector_subevent_count);
> > > +       if (bcs->reflector_subevent_results &&
> > > +                                       bcs->reflector_subevent_count=
 > 0)
> > > +               append_subevent_array(&dict, "reflectorSubeventResult=
s",
> > > +                                     bcs->reflector_subevent_results=
,
> > > +                                     bcs->reflector_subevent_count);
> > > +
> > > +       dict_append_byte(&dict, "reflectorProcedureAbortReason",
> > > +                        bcs->reflector_procedure_abort_reason);
> > > +
> > > +       append_proc_enable_config(&dict, &bcs->proc_enable_config);
> > > +       append_cs_config_param(&dict, bcs);
> > > +
> > > +       dbus_message_iter_close_container(&iter, &dict);
> > > +
> > > +       g_dbus_send_message(btd_get_dbus_connection(), signal);
> > > +}
> > > +
> > > +static void rap_procedure_data(struct bt_rap *rap,
> > > +                               struct bcs_procedure_data *bcs,
> > > +                               void *user_data)
> > > +{
> > > +       struct rap_data *data =3D user_data;
> > > +
> > > +       DBG("procedure_counter=3D%u", bcs->procedure_counter);
> > > +       rap_emit_procedure_data(data, bcs);
> > > +}
> > > +
> > >  static DBusMessage *start_measurement(DBusConnection *conn,
> > >                                 DBusMessage *msg, void *user_data)
> > >  {
> > > @@ -534,6 +1020,9 @@ bad_type:
> > >         data->active_session.cfg           =3D cfg;
> > >         data->active_session.freq          =3D freq;
> > >
> > > +       bt_rap_hci_set_procedure_data_cb(data->hci_sm, rap_procedure_=
data,
> > > +                                        data, NULL);
> > > +
> > >         return dbus_message_new_method_return(msg);
> > >  }
> > >
> > > @@ -588,6 +1077,11 @@ static const GDBusPropertyTable cs_dbus_propert=
ies[] =3D {
> > >         { }
> > >  };
> > >
> > > +static const GDBusSignalTable cs_dbus_signals[] =3D {
> > > +       { GDBUS_SIGNAL("ProcedureData", GDBUS_ARGS({ "data", "a{sv}" =
})) },
> > > +       { }
> > > +};
> > > +
> > >  static void rap_measurement_timeout_cb(void *user_data)
> > >  {
> > >         struct rap_data *data =3D user_data;
> > > @@ -752,7 +1246,8 @@ static int rap_accept(struct btd_service *servic=
e)
> > >         g_dbus_register_interface(btd_get_dbus_connection(),
> > >                                   device_get_path(data->device),
> > >                                   CS_INTERFACE, cs_dbus_methods,
> > > -                                 NULL, cs_dbus_properties, data, NUL=
L);
> > > +                                 cs_dbus_signals, cs_dbus_properties=
,
> > > +                                 data, NULL);
> > >
> > >         return 0;
> > >  }
> > > diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
> > > index e57f967a2..3da98972e 100644
> > > --- a/profiles/ranging/rap_hci.c
> > > +++ b/profiles/ranging/rap_hci.c
> > > @@ -442,6 +442,8 @@ static void rap_rd_loc_supp_cap_done_cb(const voi=
d *data, uint8_t size,
> > >         DBG("Sending read remote capabilities for handle 0x%04X",
> > >                 sm->active_conn_handle);
> > >         bt_rap_read_remote_supported_capabilities(sm, sm->active_conn=
_handle);
> > > +
> > > +       bt_rap_set_local_sw_time(sm->rap, rsp->t_sw_time_supported);
> > >  }
> > >
> > >  static void rap_send_hci_cs_create_config_command(struct cs_state_ma=
chine *sm,
> > > @@ -873,6 +875,8 @@ static void rap_rd_rmt_supp_cap_cmplt_evt(const v=
oid *data, uint8_t size,
> > >                 cs_set_state(sm, CS_STATE_INIT);
> > >                 rap_send_hci_def_settings_command(sm, evt);
> > >         }
> > > +
> > > +       bt_rap_set_remote_sw_time(sm->rap, evt->t_sw_time_supported);
> > >  }
> > >
> > >  static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
> > > @@ -1162,6 +1166,46 @@ static void rap_cs_proc_enable_cmplt_evt(const=
 void *data, uint8_t size,
> > >                         &rap_ev, sm->rap);
> > >  }
> > >
> > > +static void rap_le_conn_update_complete_evt(const void *data, uint8_=
t size,
> > > +                                           void *user_data)
> > > +{
> > > +       struct cs_state_machine *sm =3D user_data;
> > > +       const struct bt_hci_evt_le_conn_update_complete *evt;
> > > +       struct rap_conn_mapping *mapping;
> > > +       struct bt_rap *rap;
> > > +       struct iovec iov;
> > > +
> > > +       if (!sm || !data ||
> > > +           size < sizeof(struct bt_hci_evt_le_conn_update_complete))
> > > +               return;
> > > +
> > > +       iov.iov_base =3D (void *) data;
> > > +       iov.iov_len =3D size;
> > > +
> > > +       evt =3D util_iov_pull_mem(&iov, sizeof(*evt));
> > > +       if (!evt) {
> > > +               error("Failed to pull LE conn update complete struct"=
);
> > > +               return;
> > > +       }
> > > +
> > > +       DBG("status=3D0x%02X handle=3D0x%04X interval=3D%u",
> > > +           evt->status, evt->handle, evt->interval);
> > > +
> > > +       if (evt->status !=3D 0)
> > > +               return;
> > > +
> > > +       mapping =3D find_mapping_by_handle(sm, evt->handle);
> > > +       if (mapping && mapping->rap) {
> > > +               DBG("Found handle 0x%04X in mapping cache", evt->hand=
le);
> > > +               rap =3D mapping->rap;
> > > +       } else {
> > > +               error("No mapping found for handle 0x%04X", evt->hand=
le);
> > > +               return;
> > > +       }
> > > +
> > > +       bt_rap_set_conn_interval(rap, evt->interval);
> > > +}
> > > +
> > >  static void parse_i_q_sample(struct iovec *iov, int16_t *i_sample,
> > >                                 int16_t *q_sample)
> > >  {
> > > @@ -1662,6 +1706,8 @@ void *bt_rap_attach_hci(struct bt_rap *rap, str=
uct bt_hci *hci,
> > >                                         rap_cs_subevt_result_evt },
> > >                 { BT_HCI_EVT_LE_CS_SUBEVENT_RESULT_CONTINUE,
> > >                                         rap_cs_subevt_result_cont_evt=
 },
> > > +               { BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE,
> > > +                                       rap_le_conn_update_complete_e=
vt },
> > >         };
> > >         struct cs_state_machine *sm;
> > >         unsigned int i;
> > > @@ -1781,6 +1827,19 @@ bool bt_rap_stop_measurement(void *hci_sm)
> > >                                                 false);
> > >  }
> > >
> > > +bool bt_rap_hci_set_procedure_data_cb(void *hci_sm,
> > > +                               bt_rap_procedure_data_func_t cb,
> > > +                               void *user_data,
> > > +                               bt_rap_destroy_func_t destroy)
> > > +{
> > > +       struct cs_state_machine *sm =3D hci_sm;
> > > +
> > > +       if (!sm || !sm->rap)
> > > +               return false;
> > > +
> > > +       return bt_rap_set_procedure_data_cb(sm->rap, cb, user_data, d=
estroy);
> > > +}
> > > +
> > >  bool bt_rap_set_conn_hndl(void *hci_sm, struct bt_rap *rap,
> > >                 uint16_t handle, const uint8_t *bdaddr, uint8_t bdadd=
r_type,
> > >                 bool is_central)
> > > --
> > > 2.34.1
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
