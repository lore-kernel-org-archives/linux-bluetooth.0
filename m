Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF8F3546FA
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2026 14:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788358889; cv=pass; b=Yhp4W3EsCcmTo2szSvI+4Jit/8PqM86qG+EYAI8wLuizDvDe8VeDwgn8aOJHsKOP78ZYEBLNxkmQ0CywxOOp5CfBiP7YE7RSS2yrtWhXKPFaSOgO02fl5iNf9uVJJ72ebtcJfiS1cgeCgcuKgFZLPI6lCVCDua5Zaxs05STkt4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788358889; c=relaxed/simple;
	bh=2r+lnupSC/nWHH505iCw7eA1T/6MsKjnYNMGjdByAKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MpDLkPy20BXD9jw2qY2LLzBcOsWIkMFc9qZYs5Ou6Yii+h6k/hsrPItGR9yfEmpx2d1AaZjEeVH6uiKnzobwVb+35Bk7RIOYyPoGGnbJYFkr+Qb6Kppo0MVf5PjODkTQ0DX6V/v21Rf+ZZ6Tt/rpsKXuuScYGx37YI2kRNurceE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NC+XM2Dt; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NC+XM2Dt"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-86d43cdee51so6239997b3.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Sep 2026 07:21:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788358887; cv=none;
        d=google.com; s=arc-20260327;
        b=IbTxRhWvyBR2FAAS7VQ46ESC4e9wzdKzBZfSxwZ9SGHoBmwwgfde0RzIINJvIWASSJ
         6m4M5ioRBfkoIAyym29uHTXoDxg5EguMoAcZhfR2asb4sdwZByG4SUpDuFqgiJnar1jc
         3FIJEEoFL2OWoeVwp1YN/2gauYrbYn6USg0btS4cOEgbnPEGEU39q926EgXHhaeZtJ1D
         ZyWeaWo961GkuPk6nMVdhC7Nu+bIVHzxE/2pHHuzMzy2aHgmxLEpcHppPXbTY7WkiywO
         ouTFedW8y7nYxqRb967aQL2UuBr3NuR2tlBokcu6a5ti68I+WKqhCGtq0I6HjhHUHih0
         W+YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UnkzoBG21gsH02CPC4qJUhlha7Hb69/kJ7Y993hDOQY=;
        fh=kc5TcPwbtmAgYy0p6cYNmdWRet3Mr/mvpcm07F+9fs8=;
        b=lgljYQ8jX5s3qzWKT9igXm4Sk1ypB1HaM0HIUPwhMeeS9buK6zwla5M845DTCufGeg
         fixgW9xisrQybHfl/n321KW1BPZOUXDU/Y3JeIfGKU1tyd6w3PsBEIr1ZRH/hyOCA8gh
         +zNYowF/7XPIkfXzYBNwC1EfZ2WHDf78nmDG5uhnzfrF4AEGEvD/Ova10Q1LzvWFBOtG
         yZnwivIjhzuubKu8HnkAGeKXgjJXiejdmuePWO/RgJPFsAVSpj/rzi++9WjrBkanKYfk
         hqJaOWa00rKN+ShB7ser0w9RTojAz8kAp/22ihl4dmaFOZsjpP8bqp50ffY547Kzklnx
         G9zw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788358887; x=1788963687; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UnkzoBG21gsH02CPC4qJUhlha7Hb69/kJ7Y993hDOQY=;
        b=NC+XM2DtlgPgKpLzr6WH4pw+KBwjbyUa0WGf3gbJR4TbJoB2pKTXKNWTcQCeq58Ydi
         GLa4hINrBsdks4nE1hoPislskuYq8uF8Abr5st1LxlfIMmgIlXHcbZ3+xfHFMeFUiErr
         bFHxLENIfRbimS01j1G295RNPYiL/WzKk2y/PWofvmvvdxBdGYh4giphBydwqZSzO+8c
         /5/FL3p/lZpPmOIBASbtoF7HfKSxVMmipYCWj/2ncsHFaxlsHRhUmEjfwH1rDOtjO+DA
         baxg0H+XXiQHPFXdctsDEUN6vfMWKSoQNue6NyxhnteHv/qG+bSvw2MXZLWHnRlSsiBR
         ov7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788358887; x=1788963687;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UnkzoBG21gsH02CPC4qJUhlha7Hb69/kJ7Y993hDOQY=;
        b=qEgy6yaa1C6ZpyWeBJsJ581c00dGa0Ce9ffZBb6K0heZhUac420KGtGWP4lSBYzyd6
         J5mrpoexzfa7B9VKpyfE2G5gu8ilArRLOSUD7Ul3A1GZYEfza1Z1coluAuQ7jamw5wUO
         zj+h2KlBFnoQCmQo6wytPvfo/2qa7w/G0lZurXzsRWfz4wp7NQU5mk5SVLnPwtlBqVkG
         fnkDIdEQT+r5F+wN+Eqz8iUJBPxA9sZzt6mYNqwb114Xv0XxLKiC3xB4kdUAj/a2bxEQ
         TrPidZ3giyzpJSu2qTxlvL2+n+ybGmsAf9GHENp4smPAiMPbwYwPXVGhL07w/9zPzBN4
         Xbtg==
X-Gm-Message-State: AFuF++nQJ+luEvfMHgybFCaFA/qfqXjr95+QhZ9zzgM0O0MFImQHXS4B
	nxZOqPI+OqHnth7X82FEdEqfTGAbtMxaSs/iHduIhFOM/Ty9/hi8zkADvMvbxUBSPml7KRBSFce
	e2l2qBj8aIgn/yqQIHSfGLBQzhk9E8yRHNHkCsIEwvg==
X-Gm-Gg: AYBFou3w430ZO9WlKlivePuwKfSwNdS2DlqDPyrf4vPdOZjnHPM/TpDws9/uzHTF8lk
	pR5txn3Ai3g0QdTIMi0KNGpfWU5ApCFSb9Hc57tU7NcTK0WdmElmFGk2GtunRZtvsqHbcyfehXv
	ULUt8dBxIlFXmGUV81eJ8anKeaMr8lxcfIyshkqjdKyytXbWmbwg+UBiPfMC/TDxq6sH2qvcXKk
	sqage+UjMhbuWdTlYsaH+ZY4oQF+dONb4whbWmkJ8Rik9eX6/JI5bRr2hKhhuAUaACSburPqqdN
	ciunnW67gRcsmENXdv6cJ1gaNN9PnWROgOSe94mROH2+IVl5wFLGm43oRv88Z+5NIW6XspJU9pi
	9Eqqscc3Y07gbenqjLbz1aqPQlQLL
X-Received: by 2002:a05:690c:85:b0:866:4769:d59a with SMTP id
 00721157ae682-86c4e018b82mr26149557b3.2.1788358886262; Wed, 02 Sep 2026
 07:21:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKA8V_8QC7u4OsP+f4_h2UfPQ0uAMy9ESzvuNULo1cFkmxyjow@mail.gmail.com>
In-Reply-To: <CAKA8V_8QC7u4OsP+f4_h2UfPQ0uAMy9ESzvuNULo1cFkmxyjow@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 2 Sep 2026 10:21:14 -0400
X-Gm-Features: AcwNN1XHKuSVoaGOdqfsn7a1FCZ0FKFlIqiDURkkEFfP6zM_adEma3AxMhOawCk
Message-ID: <CABBYNZJTMW_Dg5bpZ9PPitgCOZJ5uKWM_ru9MT1utUcz4uxDaw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] adapter/advertising: fix mgmt endian bug
To: Nicolas Thibert <nithibert@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

On Wed, Sep 2, 2026 at 10:19=E2=80=AFAM Nicolas Thibert <nithibert@gmail.co=
m> wrote:
>
> Several places in adapter.c and advertising.c write a native-endian
> value directly into a __le16/__le32 field of an mgmt command struct,
> skipping the htobs()/htobl() conversion used everywhere else in this
> codebase for the same purpose. This is a no-op on little-endian hosts
> (where htobs()/htobl() are themselves no-ops), which is why it has
> gone unnoticed, but corrupts the value on big-endian hosts.
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
> +     cp->key_count =3D htobs(key_count);
> +     for (i =3D 0; i < key_count; ++i) {
> cp->keys[i].type =3D blocked_keys[i].type;
> memcpy(cp->keys[i].val, blocked_keys[i].val,
> sizeof(cp->keys[i].val));
> --- a/src/advertising.c
> +++ b/src/advertising.c
> @@ -995,7 +995,7 @@ static int refresh_legacy_adv(struct btd
>
> cp->flags =3D htobl(flags);
> cp->instance =3D client->instance;
> -     cp->duration =3D client->duration;
> +     cp->duration =3D htobs(client->duration);
> cp->adv_data_len =3D adv_data_len;
> cp->scan_rsp_len =3D scan_rsp_len;
> memcpy(cp->data, adv_data, adv_data_len);
> @@ -1046,13 +1046,13 @@ static int refresh_extended_adv(struct b
> */
> if (client->duration) {
> -             cp.duration =3D client->duration;
> +             cp.duration =3D htobs(client->duration);
> flags |=3D MGMT_ADV_PARAM_DURATION;
> }
>
> if (client->min_interval && client->max_interval) {
> -             cp.min_interval =3D client->min_interval;
> -             cp.max_interval =3D client->max_interval;
> +             cp.min_interval =3D htobl(client->min_interval);
> +             cp.max_interval =3D htobl(client->max_interval);

Use cpu_to_le** instead of htobl.

> flags |=3D MGMT_ADV_PARAM_INTERVALS;
> }
>
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
