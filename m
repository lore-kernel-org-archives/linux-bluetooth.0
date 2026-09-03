Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4319738398E
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 07:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788420492; cv=pass; b=eCHS5QhoCDc78WoJcUBJfhhsGQKCLHniZ+vuc1MlXV3+Xc+tDgHMJOM0EnqWUan54GKTxRkJI7bvmj31qcCkLrDvOKq5oRJnxJWvT+nWqHm1HyGevE0xK1l1LGdJ6h6ZWUD/18a007pyYUqfpeDX7gxINpW2wMrslGuC6/iHTcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788420492; c=relaxed/simple;
	bh=jMccPdFa87xG65FTskb91pgCxeLLnKt2rLb+RldjcNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BREe7yj/sLd9sKmjF120vQh5pHUWuQdZBEuNknY5K5AaNN7eNvKfL6AWi6VecDiij5R8H5j8VIVExdien3k38w0NvdoBjXdlcozxv9+NFM6eBncimGxmbQ93mbXHOfznXo6Oq0iXl/fte+mgnlTr5Dl34HoVC0lwgBaflefCwsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tAIGUDty; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tAIGUDty"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-85aeb506b78so31574167b3.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 00:28:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788420489; cv=none;
        d=google.com; s=arc-20260327;
        b=LP+PNcx95c+3k/iNOzHUdyFW6MtodxT0NLfyipqn+ga3UHeb+OP+RwBIooBJq5TxXT
         q2AewPAB4v22ehI6KiyY737VEoloUXngl/JRRY2zXWKY59tVxAI3ykjX9mRbTMJ5kZR6
         bMeVhXJJWvuNACrxR38uwa+8jDLUcsOzhoG0l977+imUCH4QUe2iix5MY8QHDHfrCgLo
         7RotJUl4umeb+dVmKaAH/2lNU40qGTgeeye7F86jA7o2zWTWVMjXICmzVjQ7FBk5eaTn
         7bqgCWhM/opZOZgnW/UjYv6vzLKHHh2xGgLIzMp5SkuFzJa83pu8K25gvmdio9vC8/Is
         Yzsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3ECC3LCWvDGI5igp3VplunUwfMO8WVpDlA+Fdc6xm3M=;
        fh=v4Z3N2Htbr8NtGqMLkQjkIE/EbeUcf6lhEWEAm07n3g=;
        b=YiQJkg6LjtBkhk1w0TJadCiRy4n4B9IF1eaIAmUdlLSHnVkAIQPAM68U4TETqX7nSe
         tERuVIulcbB6FnmBjVP+K1HAyhw1V/MgQGOqBfxlCRRv7VG1/qekSilpvzcYSb9jPbJC
         vz5vDnPuEhQY2yeBnGhse2NhEP59rQuWiJa8w9JZt20OcrEgZPjjF3wTxwHLNBZ6x6KE
         RVarsRMubBefHxnnO96xNSaAG4hHQg4RmBn895mAoykEtEpdy4EOxX+ETjO9gpr4JLJ5
         JXHK8sB5XvcZPw9ary+Vs+ef6UO9XFe5T4KO3TyvvH+QpmnphGLrVGiZpbLydQSz5CtN
         Y5Zg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788420489; x=1789025289; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3ECC3LCWvDGI5igp3VplunUwfMO8WVpDlA+Fdc6xm3M=;
        b=tAIGUDtyhkKjlprExloOrepZB1xOJC/AIk9Q62OI1S+thjsEXXFTpJs7T8bTWJGlA7
         VN4YB1TgDgfCXFxdhEhExiWRASriE7f5vSL2zMhW7mDLbGWzz/YZvOTQbaJauth30mEM
         sXBOmF04Zi/Hl4htzY+ePRxKU3sH3eEdz+C5MHTSz36ewHBQ7/GnjxOygsi221e4dHau
         A9bV+nAwUGHrEqO/U1kw9UuAGvXny+xp0b3+cZ8zeTNN97WtTXVJstyOeAZURUfRJqbM
         m0NTE6PnkEUEv0Bk5juaSLkd1JhxhqNzugdJ5Lb1rP5gtiiRH2YEUQqvNBfaYr85wmTD
         a6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788420489; x=1789025289;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3ECC3LCWvDGI5igp3VplunUwfMO8WVpDlA+Fdc6xm3M=;
        b=OnS2PrriRO29bGbMBHvSD+6ykkYXVvxyc4dySZgbVPzjKJK2QlQDvyKyD0ZpH3CVY3
         oasjS6KT/YABXgnX406CR5hM2Bjllh4NWU8YUuFfNw/f0yZvB4DCUHjmspNJ9uoPJHsE
         PCDzymi5Jr4lt0AM0oR7bCQ2PmlwAmesDndNO8u5rM+zjTlJYkZp2qIRdMogyzyjyAlQ
         l+TBAXydDIiuWnn1FylhwlXK8R2VYL1guARsk+P8Zcw75hqRfgmpKuBwJT+vlEI1SI/2
         mKzGiGhSePmOhuJ+mBzvhsFRrGwRx6cVEhGzkqTxjrcR31zolL2YjJ/FI5/KvM3jV7Zi
         lzNQ==
X-Gm-Message-State: AFuF++k/PGMl/fRI1vWRGUwTJaQuDV9hAXOVCiFKWYXXD9A5VNhRgf2r
	2C0dHHX5BG+R+FRD+IyFSDfJkDL/x+/m+MnYjRFiiXSXHSIQIzLEb5xJvNHk1GrAr6PAH4/5HIp
	mMT1eXrv+ikqSLQVasrgf2D4wd/4qaOhLMCudgD8=
X-Gm-Gg: AYBFou28yF7Yh8CxvuUWQHctSFx7YQurjNdGB0bBvc7fasnEuiPnHU/GRjaep8VFGS1
	CMreb3+8AbAeDbanJvBqFZDnagWQguAsbHIjMEw/BLozyDw5Mxi/7nrUzBCXv4qEqEpuXGs6WuP
	XHxhvvEVYNYPyHfcPXTHcE1YVPIxeAYswtNr3PfOqphxGevsDqdaCIKb088o69OeTQWTRpEaeNW
	HNl6Z1ocAH7TU4DmrOC56PbzjTAsiqeC7VBvGmUE2MNMk9sToiPW/IeQPoYV1otcoUiwzBL0cbJ
	nFxDD4tAT58GN9InJ/QyonJhFBSjk4nOtHOZr2O29Wr0PlqeYaxhUZTENyXSWEvVBXOerUNkSpx
	aBr3UoNbbrQMMJhmePMcVkAV62OOTjSsXNMLIKW6QgPP8vFgF
X-Received: by 2002:a05:690e:1505:b0:66e:606e:cc27 with SMTP id
 956f58d0204a3-66f9b90b288mr3557889d50.5.1788420488964; Thu, 03 Sep 2026
 00:28:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKA8V_8QC7u4OsP+f4_h2UfPQ0uAMy9ESzvuNULo1cFkmxyjow@mail.gmail.com>
 <CABBYNZJTMW_Dg5bpZ9PPitgCOZJ5uKWM_ru9MT1utUcz4uxDaw@mail.gmail.com> <CAKA8V_8B-qfv0OytdvtppF7zSF4j=jJWSERvUbV6dC7Fus9NRA@mail.gmail.com>
In-Reply-To: <CAKA8V_8B-qfv0OytdvtppF7zSF4j=jJWSERvUbV6dC7Fus9NRA@mail.gmail.com>
From: Nicolas Thibert <nithibert@gmail.com>
Date: Thu, 3 Sep 2026 09:27:58 +0200
X-Gm-Features: AcwNN1W8cX35Ptgn3Ge-IA2Xwr3BlPHcfSFJrjZ8B_UtInQ-wlVLhf8q4Q-TKqc
Message-ID: <CAKA8V_-yO_9hma4fFkSnUpMBMcLP8iHWjfVSjQe-eu+w+FDh_Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ] adapter/advertising: fix mgmt endian bug
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz it seems the patch didnt apply correctly, here is a corrected versi=
on
Regards
Nicolas

---
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
src/adapter.c     | 5 +++--
src/advertising.c | 8 ++++----
2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 7390ceeee..edbdb53b5 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -10219,10 +10219,11 @@ static bool set_blocked_keys(struct
btd_adapter *adapter)
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
diff --git a/src/advertising.c b/src/advertising.c
index 1ed09c902..3f70fb4e9 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -1042,7 +1042,7 @@ static int refresh_legacy_adv(struct
btd_adv_client *client,

cp->flags =3D htobl(flags);
cp->instance =3D client->instance;
-     cp->duration =3D client->duration;
+     cp->duration =3D cpu_to_le16(client->duration);
cp->adv_data_len =3D adv_data_len;
cp->scan_rsp_len =3D scan_rsp_len;
memcpy(cp->data, adv_data, adv_data_len);
@@ -1093,13 +1093,13 @@ static int refresh_extended_adv(struct
btd_adv_client *client,
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

Le mer. 2 sept. 2026 =C3=A0 18:07, Nicolas Thibert <nithibert@gmail.com> a =
=C3=A9crit :
>
> Hi Luiz,
> Ty for your answer, here is a correction
> Regards,
> Nicolas
>
> Several places in adapter.c and advertising.c write a native-endian
> value directly into a __le16/__le32 field of an mgmt command struct,
> skipping the cpu_to_le16()/cpu_to_le32() conversion used everywhere
> else in this codebase for the same purpose. This is a no-op on
> little-endian hosts (where cpu_to_le16()/cpu_to_le32() are themselves
> no-ops), which is why it has gone unnoticed, but corrupts the value on
> big-endian hosts.
>
> Confirmed live on MIPS big-endian (OpenWrt/ath79): set_blocked_keys()
> sends key_count=3D2 (2 blocked keys), which the kernel's
> __le16_to_cpu() correctly interprets as 512 (0x0002 byte-swapped is
> 0x0200) since the wire bytes were never actually swapped to little-
> endian on the way out -- producing "expected 8706 bytes, got 36
> bytes" / "Failed to set blocked keys: Invalid Parameters" errors in
> dmesg/bluetoothd logs.
>
> add_advertising()'s cp->duration and refresh_extended_adv()'s
> cp.duration/cp.min_interval/cp.max_interval have the identical bug. It
> is inert with bluetoothctl's default (0) duration/interval values (0
> byte-swapped is still 0), but A/B tested live (patch removed vs.
> applied, bluetoothctl's advertise submenu "interval 100 100" set
> explicitly) confirms this is not just a theoretical correctness fix:
> with the bug present, the device stops being discoverable by a real
> BLE scanner the moment a non-default interval is requested, and
> becomes discoverable again immediately once patched. Any application
> that sets an explicit advertising interval or duration hits this.
>
> v2: use cpu_to_le16()/cpu_to_le32() instead of htobs()/htobl(), as
> requested by Luiz. Retested live on the same MIPS big-endian board
> (blocked keys + explicit advertising interval): behaves identically
> to the v1 fix, no regressions.
> ---
> src/adapter.c     |  5 +++--
> src/advertising.c |  6 +++---
> 2 files changed, 6 insertions(+), 5 deletions(-)
>
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -9938,10 +9938,11 @@ static bool set_blocked_keys(struct btd_
> sizeof(blocked_keys)] =3D { 0 };
> struct mgmt_cp_set_blocked_keys *cp =3D
> (struct mgmt_cp_set_blocked_keys *)buffer;
> +     const uint16_t key_count =3D ARRAY_SIZE(blocked_keys);
> int i;
>
> -     cp->key_count =3D ARRAY_SIZE(blocked_keys);
> -     for (i =3D 0; i < cp->key_count; ++i) {
> +     cp->key_count =3D cpu_to_le16(key_count);
> +     for (i =3D 0; i < key_count; ++i) {
> cp->keys[i].type =3D blocked_keys[i].type;
> memcpy(cp->keys[i].val, blocked_keys[i].val,
> sizeof(cp->keys[i].val));
> +     for (i =3D 0; i < key_count; ++i) {
> cp->keys[i].type =3D blocked_keys[i].type;
> memcpy(cp->keys[i].val, blocked_keys[i].val,
> sizeof(cp->keys[i].val));
> --- a/src/advertising.c
> +++ b/src/advertising.c
> memcpy(cp->keys[i].val, blocked_keys[i].val,
> sizeof(cp->keys[i].val));
> --- a/src/advertising.c
> +++ b/src/advertising.c
> @@ -995,7 +995,7 @@ static int refresh_legacy_adv(struct btd
>
> cp->flags =3D htobl(flags);
> cp->instance =3D client->instance;
> -     cp->duration =3D client->duration;
> +     cp->duration =3D cpu_to_le16(client->duration);
> cp->adv_data_len =3D adv_data_len;
> cp->scan_rsp_len =3D scan_rsp_len;
> memcpy(cp->data, adv_data, adv_data_len);
> @@ -1046,13 +1046,13 @@ static int refresh_extended_adv(struct b
> */
>
> if (client->duration) {
> -             cp.duration =3D client->duration;
> +             cp.duration =3D cpu_to_le16(client->duration);
> flags |=3D MGMT_ADV_PARAM_DURATION;
> }
>
> if (client->min_interval && client->max_interval) {
> -             cp.min_interval =3D client->min_interval;
> -             cp.max_interval =3D client->max_interval;
> +             cp.min_interval =3D cpu_to_le32(client->min_interval);
> +             cp.max_interval =3D cpu_to_le32(client->max_interval);
> flags |=3D MGMT_ADV_PARAM_INTERVALS;
> }
>
> --
> 2.34.1
>
> Le mer. 2 sept. 2026 =C3=A0 16:21, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> a =C3=A9crit :
> >
> > Hi Nicolas,
> >
> > On Wed, Sep 2, 2026 at 10:19=E2=80=AFAM Nicolas Thibert <nithibert@gmai=
l.com> wrote:
> > >
> > > Several places in adapter.c and advertising.c write a native-endian
> > > value directly into a __le16/__le32 field of an mgmt command struct,
> > > skipping the htobs()/htobl() conversion used everywhere else in this
> > > codebase for the same purpose. This is a no-op on little-endian hosts
> > > (where htobs()/htobl() are themselves no-ops), which is why it has
> > > gone unnoticed, but corrupts the value on big-endian hosts.
> > >
> > > Confirmed live on MIPS big-endian (OpenWrt/ath79): set_blocked_keys()
> > > sends key_count=3D2 (2 blocked keys), which the kernel's
> > > __le16_to_cpu() correctly interprets as 512 (0x0002 byte-swapped is
> > > 0x0200) since the wire bytes were never actually swapped to little-
> > > endian on the way out -- producing "expected 8706 bytes, got 36
> > > bytes" / "Failed to set blocked keys: Invalid Parameters" errors in
> > > dmesg/bluetoothd logs.
> > >
> > > add_advertising()'s cp->duration and refresh_extended_adv()'s
> > > cp.duration/cp.min_interval/cp.max_interval have the identical bug. I=
t
> > > is inert with bluetoothctl's default (0) duration/interval values (0
> > > byte-swapped is still 0), but A/B tested live (patch removed vs.
> > > applied, bluetoothctl's advertise submenu "interval 100 100" set
> > > explicitly) confirms this is not just a theoretical correctness fix:
> > > with the bug present, the device stops being discoverable by a real
> > > BLE scanner the moment a non-default interval is requested, and
> > > becomes discoverable again immediately once patched. Any application
> > > that sets an explicit advertising interval or duration hits this.
> > > ---
> > > src/adapter.c     |  5 +++--
> > > src/advertising.c |  6 +++---
> > > 2 files changed, 6 insertions(+), 5 deletions(-)
> > >
> > > --- a/src/adapter.c
> > > +++ b/src/adapter.c
> > > @@ -9938,10 +9938,11 @@ static bool set_blocked_keys(struct btd_
> > > sizeof(blocked_keys)] =3D { 0 };
> > > struct mgmt_cp_set_blocked_keys *cp =3D
> > > (struct mgmt_cp_set_blocked_keys *)buffer;
> > > +     const uint16_t key_count =3D ARRAY_SIZE(blocked_keys);
> > > int i;
> > >
> > > -     cp->key_count =3D ARRAY_SIZE(blocked_keys);
> > > -     for (i =3D 0; i < cp->key_count; ++i) {
> > > +     cp->key_count =3D htobs(key_count);
> > > +     for (i =3D 0; i < key_count; ++i) {
> > > cp->keys[i].type =3D blocked_keys[i].type;
> > > memcpy(cp->keys[i].val, blocked_keys[i].val,
> > > sizeof(cp->keys[i].val));
> > > --- a/src/advertising.c
> > > +++ b/src/advertising.c
> > > @@ -995,7 +995,7 @@ static int refresh_legacy_adv(struct btd
> > >
> > > cp->flags =3D htobl(flags);
> > > cp->instance =3D client->instance;
> > > -     cp->duration =3D client->duration;
> > > +     cp->duration =3D htobs(client->duration);
> > > cp->adv_data_len =3D adv_data_len;
> > > cp->scan_rsp_len =3D scan_rsp_len;
> > > memcpy(cp->data, adv_data, adv_data_len);
> > > @@ -1046,13 +1046,13 @@ static int refresh_extended_adv(struct b
> > > */
> > > if (client->duration) {
> > > -             cp.duration =3D client->duration;
> > > +             cp.duration =3D htobs(client->duration);
> > > flags |=3D MGMT_ADV_PARAM_DURATION;
> > > }
> > >
> > > if (client->min_interval && client->max_interval) {
> > > -             cp.min_interval =3D client->min_interval;
> > > -             cp.max_interval =3D client->max_interval;
> > > +             cp.min_interval =3D htobl(client->min_interval);
> > > +             cp.max_interval =3D htobl(client->max_interval);
> >
> > Use cpu_to_le** instead of htobl.
> >
> > > flags |=3D MGMT_ADV_PARAM_INTERVALS;
> > > }
> > >
> > > --
> > > 2.34.1
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz
