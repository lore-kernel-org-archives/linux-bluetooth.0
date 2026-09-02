Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FE73DC4A0
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2026 16:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788365264; cv=pass; b=KbtTN6DVgVS9iiC3GN0eBYPHyEgttEG/s3oba7NJN9uEH/vPVWQNxwI7ROhavzL8l3QCvGai2UDSC2wUNcuw8y4iBz4jAGLH7mS0CNEM4HQGk+k99GsoD8KN+KcgP/FGMlh/X6kLMoevMCc6YM7I2ldZ/NA10Kf4FWu+ainXgRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788365264; c=relaxed/simple;
	bh=X7QrcXuXOt1nGJ3u8C6hWWWdgZUykpnI+LKlaKDpMug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cjUzqR+JEiBA7Xk/bdUWX5Q6B/hZBeFcx2VPBUxh+jdlfYEm30nNqJHqbivqC3F3v0aP3m75aWzCNaslWo6w2jpbSSevOYWR4Ux2z89GAqBqn+6HdeUCVI8WRPwxmuLcKrY7GRhm7pDIUYNkkX+RhvbuAqlcBPOAUVACJ+bf6DU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8XTvX+H; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8XTvX+H"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-66dee7a0c09so1281519d50.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Sep 2026 09:07:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788365260; cv=none;
        d=google.com; s=arc-20260327;
        b=KEoK6P0VVDK4e1W3x7mrklf0+WA8xwIPweJa1mh/INz1hCwCpbSH0lTvmnkihutb6D
         tQ6QkdtzDe6sixJRB4qh1Mp9nfwQkAaC9qyVMD7PkscpmuERlfQvJlqRJ3BCCU1c2Yvp
         rbFf3kMVgbAGfDCuIm8SdwQIrKKe2j1MKjEEk3iQG1JUIEHdU8FrPq7MD0ccdId0eyxc
         xrVtUi1htVva93Tbxp/5tbYT7tEDx0PMOSRY9o1chH7hRnarMX3P9Z9akvPgRxPmrI+D
         oU1JYV32OjP8O++BIqj4Jrvvkj6OFAPvHOxsbjsptXA9xIdyC5V/0vINyMLr/087yjay
         qBxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aK+veNehJ21ESPtTyqUIGdoo4FC2eXl+6KpUSXVR2qE=;
        fh=v4Z3N2Htbr8NtGqMLkQjkIE/EbeUcf6lhEWEAm07n3g=;
        b=I4S5poNZKKTFGowL7qERHfiQn1N6WXUrsGuehsyq0ckoXLpu4MNdJUv4RcEIHFJIpJ
         ZGGjmcPL4e6DiHT6r53psfD/cVtWHCVJskogUisyb34yDRP47WKFTlo3b+Kn7RF0VfeR
         7ui5Zuo3+KIZS2SZHy/u+i8kRDVL9KxBP/TlZuoehiDmtFZVYA01LTvfvPj4fSoC475s
         oFALqtpQTlTmfZTq2mdA1gb4RaRnXhsnMUOTN0wVS8hTQtrbzsDW6DDUdlBVcEWPBVzh
         BTR3HuuEPSAbYvttAJ0yqr50e4DGXidtS9tidNhjA1yATXXuBW8JX4YABBucyBIB3d/6
         4rDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788365260; x=1788970060; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aK+veNehJ21ESPtTyqUIGdoo4FC2eXl+6KpUSXVR2qE=;
        b=j8XTvX+HwKRhGZQ4uG/Ia/d4ofZ192r9yDfrv56Tt0d0mIYfAqPD/xwJ05ZmeP7A7m
         oebpvul8B3NGrunAgw/NyXJ5AZIyzBhYJD330JEHwRK6AhV1x8OhYHIyXOfhVwtFQf7h
         0giu8SxWz6yMTOVVQYZAb4ifxNcRYmWMxK9ccbQSbl+7hu61RffMSJKZsv4bQzmxgStX
         nJC5bFiCW0+eetgqI9gGne+7X+G75WhmjwWS9CGmBnLNttD71Urk4vVsJZdKVooP89y4
         jtOwuz32S8yRU85OoFPsX7skxTTczO/kccpCVHDw57nCTcKMVpguiKQ264z13hIiQ4YY
         Kocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788365260; x=1788970060;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aK+veNehJ21ESPtTyqUIGdoo4FC2eXl+6KpUSXVR2qE=;
        b=HIpZ+Tv+Vw+kyD6ofZ/Udd8Zti0MAVQqxB2OkkSDIe32qZmx/trRn2wg6K7s8TUJFd
         +gH/r+GercjkqhrjNjJ24Uvmuooz9S6MuMeH6DhYCF4rlDStKYAfspxvXN2X3lC6PqXx
         HTWIfuFg0sca56OjnC6hZbDJahIpfhwQiirZCfihvWyBRsDB7dzE2NjZiYHrpTfWf4Gu
         1FB09e+DSSxWfnjWclSW2IfTu9EqQYskPCMqFiHKHHVRTpKyMmeaXNBnyG7sj8AckHWb
         Uzr7hJ/ewcpQ/IARbrryUprX2125S6nHtclfGmA+WpIJwBiiXIoefHea9xZz0ApLLOQn
         +b/w==
X-Gm-Message-State: AFuF++maCXdIfohLoJpAHl7jDFZxcKpiTJSxfjOIlPHPFN1MzwdUCHbo
	Z56RAWXr44qc9ACbtQMPJtcUA/VGJLUjhhPk/qmncEEOBPQzFL+u6I79vZ/ycQl8KvwtHHVr04x
	Cu1P82QXpK5KW+03vzed1H9ehzr4D/D5fxp89FFE=
X-Gm-Gg: AYBFou2RLeLz9AdnxZQUvFUUqinDz7Bodgze8k7jV6kasr3n/twtXRo9lQ/IyHxG3Yu
	+NKQaFvli12AuUUkOFxkXj3LwylEehqm1wMpHf2xq9ebrp459CdnO4VqAHW8HJ7ZJpkcYlY8oD6
	U4+pgSPAbousyu4F81zdrgeL1Ltwb+KvJaSd7tEChvp2GK2NswMhy1H+zEkCFPKnRS6mpMfd9Yv
	Qd3nCiAJ2hw6uqHMgnujGI/gom8kF4lIM9Fkewe2s0SU7CS7cNDakpRBe1LokMW1uNTs76w4fcF
	9uRevm2qFk0+HrIgZZG4zmU3B/87jipqcOkXSTwGdIu7xFCUzXo8wBk7+mbHNHYh1Wzvmu22sbY
	xW06pKSVp4U/12NHaRkOYk7GG
X-Received: by 2002:a05:690e:23c5:b0:66f:9743:7c28 with SMTP id
 956f58d0204a3-66f9bc3aebdmr1727630d50.45.1788365260261; Wed, 02 Sep 2026
 09:07:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKA8V_8QC7u4OsP+f4_h2UfPQ0uAMy9ESzvuNULo1cFkmxyjow@mail.gmail.com>
 <CABBYNZJTMW_Dg5bpZ9PPitgCOZJ5uKWM_ru9MT1utUcz4uxDaw@mail.gmail.com>
In-Reply-To: <CABBYNZJTMW_Dg5bpZ9PPitgCOZJ5uKWM_ru9MT1utUcz4uxDaw@mail.gmail.com>
From: Nicolas Thibert <nithibert@gmail.com>
Date: Wed, 2 Sep 2026 18:07:29 +0200
X-Gm-Features: AcwNN1XNfVp6fGZ2zKyyL3cU5vCdQnKkn4XWn0wsWXKAdxuXPAuI_rvxeq28NKg
Message-ID: <CAKA8V_8B-qfv0OytdvtppF7zSF4j=jJWSERvUbV6dC7Fus9NRA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] adapter/advertising: fix mgmt endian bug
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,
Ty for your answer, here is a correction
Regards,
Nicolas

Several places in adapter.c and advertising.c write a native-endian
value directly into a __le16/__le32 field of an mgmt command struct,
skipping the cpu_to_le16()/cpu_to_le32() conversion used everywhere
else in this codebase for the same purpose. This is a no-op on
little-endian hosts (where cpu_to_le16()/cpu_to_le32() are themselves
no-ops), which is why it has gone unnoticed, but corrupts the value on
big-endian hosts.

Confirmed live on MIPS big-endian (OpenWrt/ath79): set_blocked_keys()
sends key_count=3D2 (2 blocked keys), which the kernel's
__le16_to_cpu() correctly interprets as 512 (0x0002 byte-swapped is
0x0200) since the wire bytes were never actually swapped to little-
endian on the way out -- producing "expected 8706 bytes, got 36
bytes" / "Failed to set blocked keys: Invalid Parameters" errors in
dmesg/bluetoothd logs.

add_advertising()'s cp->duration and refresh_extended_adv()'s
cp.duration/cp.min_interval/cp.max_interval have the identical bug. It
is inert with bluetoothctl's default (0) duration/interval values (0
byte-swapped is still 0), but A/B tested live (patch removed vs.
applied, bluetoothctl's advertise submenu "interval 100 100" set
explicitly) confirms this is not just a theoretical correctness fix:
with the bug present, the device stops being discoverable by a real
BLE scanner the moment a non-default interval is requested, and
becomes discoverable again immediately once patched. Any application
that sets an explicit advertising interval or duration hits this.

v2: use cpu_to_le16()/cpu_to_le32() instead of htobs()/htobl(), as
requested by Luiz. Retested live on the same MIPS big-endian board
(blocked keys + explicit advertising interval): behaves identically
to the v1 fix, no regressions.
---
src/adapter.c     |  5 +++--
src/advertising.c |  6 +++---
2 files changed, 6 insertions(+), 5 deletions(-)

--- a/src/adapter.c
+++ b/src/adapter.c
@@ -9938,10 +9938,11 @@ static bool set_blocked_keys(struct btd_
sizeof(blocked_keys)] =3D { 0 };
struct mgmt_cp_set_blocked_keys *cp =3D
(struct mgmt_cp_set_blocked_keys *)buffer;
+     const uint16_t key_count =3D ARRAY_SIZE(blocked_keys);
int i;

-     cp->key_count =3D ARRAY_SIZE(blocked_keys);
-     for (i =3D 0; i < cp->key_count; ++i) {
+     cp->key_count =3D cpu_to_le16(key_count);
+     for (i =3D 0; i < key_count; ++i) {
cp->keys[i].type =3D blocked_keys[i].type;
memcpy(cp->keys[i].val, blocked_keys[i].val,
sizeof(cp->keys[i].val));
+     for (i =3D 0; i < key_count; ++i) {
cp->keys[i].type =3D blocked_keys[i].type;
memcpy(cp->keys[i].val, blocked_keys[i].val,
sizeof(cp->keys[i].val));
--- a/src/advertising.c
+++ b/src/advertising.c
memcpy(cp->keys[i].val, blocked_keys[i].val,
sizeof(cp->keys[i].val));
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -995,7 +995,7 @@ static int refresh_legacy_adv(struct btd

cp->flags =3D htobl(flags);
cp->instance =3D client->instance;
-     cp->duration =3D client->duration;
+     cp->duration =3D cpu_to_le16(client->duration);
cp->adv_data_len =3D adv_data_len;
cp->scan_rsp_len =3D scan_rsp_len;
memcpy(cp->data, adv_data, adv_data_len);
@@ -1046,13 +1046,13 @@ static int refresh_extended_adv(struct b
*/

if (client->duration) {
-             cp.duration =3D client->duration;
+             cp.duration =3D cpu_to_le16(client->duration);
flags |=3D MGMT_ADV_PARAM_DURATION;
}

if (client->min_interval && client->max_interval) {
-             cp.min_interval =3D client->min_interval;
-             cp.max_interval =3D client->max_interval;
+             cp.min_interval =3D cpu_to_le32(client->min_interval);
+             cp.max_interval =3D cpu_to_le32(client->max_interval);
flags |=3D MGMT_ADV_PARAM_INTERVALS;
}

--
2.34.1

Le mer. 2 sept. 2026 =C3=A0 16:21, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> a =C3=A9crit :
>
> Hi Nicolas,
>
> On Wed, Sep 2, 2026 at 10:19=E2=80=AFAM Nicolas Thibert <nithibert@gmail.=
com> wrote:
> >
> > Several places in adapter.c and advertising.c write a native-endian
> > value directly into a __le16/__le32 field of an mgmt command struct,
> > skipping the htobs()/htobl() conversion used everywhere else in this
> > codebase for the same purpose. This is a no-op on little-endian hosts
> > (where htobs()/htobl() are themselves no-ops), which is why it has
> > gone unnoticed, but corrupts the value on big-endian hosts.
> >
> > Confirmed live on MIPS big-endian (OpenWrt/ath79): set_blocked_keys()
> > sends key_count=3D2 (2 blocked keys), which the kernel's
> > __le16_to_cpu() correctly interprets as 512 (0x0002 byte-swapped is
> > 0x0200) since the wire bytes were never actually swapped to little-
> > endian on the way out -- producing "expected 8706 bytes, got 36
> > bytes" / "Failed to set blocked keys: Invalid Parameters" errors in
> > dmesg/bluetoothd logs.
> >
> > add_advertising()'s cp->duration and refresh_extended_adv()'s
> > cp.duration/cp.min_interval/cp.max_interval have the identical bug. It
> > is inert with bluetoothctl's default (0) duration/interval values (0
> > byte-swapped is still 0), but A/B tested live (patch removed vs.
> > applied, bluetoothctl's advertise submenu "interval 100 100" set
> > explicitly) confirms this is not just a theoretical correctness fix:
> > with the bug present, the device stops being discoverable by a real
> > BLE scanner the moment a non-default interval is requested, and
> > becomes discoverable again immediately once patched. Any application
> > that sets an explicit advertising interval or duration hits this.
> > ---
> > src/adapter.c     |  5 +++--
> > src/advertising.c |  6 +++---
> > 2 files changed, 6 insertions(+), 5 deletions(-)
> >
> > --- a/src/adapter.c
> > +++ b/src/adapter.c
> > @@ -9938,10 +9938,11 @@ static bool set_blocked_keys(struct btd_
> > sizeof(blocked_keys)] =3D { 0 };
> > struct mgmt_cp_set_blocked_keys *cp =3D
> > (struct mgmt_cp_set_blocked_keys *)buffer;
> > +     const uint16_t key_count =3D ARRAY_SIZE(blocked_keys);
> > int i;
> >
> > -     cp->key_count =3D ARRAY_SIZE(blocked_keys);
> > -     for (i =3D 0; i < cp->key_count; ++i) {
> > +     cp->key_count =3D htobs(key_count);
> > +     for (i =3D 0; i < key_count; ++i) {
> > cp->keys[i].type =3D blocked_keys[i].type;
> > memcpy(cp->keys[i].val, blocked_keys[i].val,
> > sizeof(cp->keys[i].val));
> > --- a/src/advertising.c
> > +++ b/src/advertising.c
> > @@ -995,7 +995,7 @@ static int refresh_legacy_adv(struct btd
> >
> > cp->flags =3D htobl(flags);
> > cp->instance =3D client->instance;
> > -     cp->duration =3D client->duration;
> > +     cp->duration =3D htobs(client->duration);
> > cp->adv_data_len =3D adv_data_len;
> > cp->scan_rsp_len =3D scan_rsp_len;
> > memcpy(cp->data, adv_data, adv_data_len);
> > @@ -1046,13 +1046,13 @@ static int refresh_extended_adv(struct b
> > */
> > if (client->duration) {
> > -             cp.duration =3D client->duration;
> > +             cp.duration =3D htobs(client->duration);
> > flags |=3D MGMT_ADV_PARAM_DURATION;
> > }
> >
> > if (client->min_interval && client->max_interval) {
> > -             cp.min_interval =3D client->min_interval;
> > -             cp.max_interval =3D client->max_interval;
> > +             cp.min_interval =3D htobl(client->min_interval);
> > +             cp.max_interval =3D htobl(client->max_interval);
>
> Use cpu_to_le** instead of htobl.
>
> > flags |=3D MGMT_ADV_PARAM_INTERVALS;
> > }
> >
> > --
> > 2.34.1
> >
>
>
> --
> Luiz Augusto von Dentz
