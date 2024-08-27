Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260AC19A29A
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Aug 2024 12:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724763583; cv=none; b=LSEEs6yv07jn+hNRG+yyFrFYh3XFA10elIYS98ymj8EK5szLmPxCdoO42iVYpii4/wkizeHrA4BvdFjr977KcbvosTqDM4D78AJbl4hJZ4WIJ/LSq8lqLNcCiijkh7OLNt7wYaP3djk04XTceKvHxMbwiwnxD2RLOAPLm6K7OeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724763583; c=relaxed/simple;
	bh=z54daB+7MBQy/aGyCho8PJjGRi13O5CydAmsEU0/e+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CdABQM2gjcy5tWswMys6bPXNpuhAMqoV5Ku3fEd2FbFHIlH0+GB06Dw8CigxOs2Cfk4VvEE3qUCYf8yTg7/ttPHJS2eDn+yDolEv0pNprPe/niaNJPOgs4daZ1RJxyPxp5NI/O/W4M2x81R4FXvg7XpM+lBRBx2nre760Wc8F0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gr/ggne8; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gr/ggne8"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f3e9fb6ee9so63918151fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Aug 2024 05:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724763579; x=1725368379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNvoZR4VZ4eUiGhxxKfASqmsbEaygbZFje5MLEqILMQ=;
        b=Gr/ggne8zWmvS+kv+CHDUgnvNVQTGIwKNdM/ngkMq7PXQwyvpyDRMNvyNznNZae1ZO
         O9leVwT+N44xqOPwZcfV/uCEt04DMuuXO6ovg6QpWujaCplqRNSqI1ziNF6gUZe+F2jK
         TzqPqHeVoJWSqIX1MWxUMy+elOQdPMFcLWlWEfYArX0i5l2XGChj1Y9zd08sFh076ni1
         2d/7NTGIYXd704r49gjKKht18yITulzhX+GfegzQu9p0I52ttm6H6xfoV0Dhzh8iJ6/E
         qyUpxyebHUONIeL9P5EayfJQyLrGBZQK4ejsFFt+w4nQRqi0MqpuxqNqgUoE7tR/aFPa
         O8sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724763579; x=1725368379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BNvoZR4VZ4eUiGhxxKfASqmsbEaygbZFje5MLEqILMQ=;
        b=XSyxNEzgaBVN9wORtbujdgJo+IaVCMK+n//LJLtZHjYF3UXsDoh/A2g1RhFvmTz8U7
         yjdtBPPjin1Vm+Gyxlcwdnd1e0eeeo0BxBk/wlZVhccAk9/+4Fj+mF2l9HY8LjI93zcr
         Tg1CcRkOMUgqHZ0bSF5779qb+VfVBp7JjakC8BbsedxtFCZfWpo+SJvXNrqNiYI1YZiG
         lo54QFNZsz2YspWfL91FAs2+Cob7XRjCt27ljKwZdy/s07cmad08yGIFqhwcWESKlZ2+
         eGyc86hqG5yH8TDNi6pNVhtHQM2oaq7H+dA66/1uBb4PwG4MJl4kkx+1atPUaDmsHXvQ
         mooA==
X-Gm-Message-State: AOJu0Yze5PKgxephDFeEmzrINkjEeQhRUVT1haoA/1nuA3F8JAqXGAN7
	79xvd8TKCcrGfJhqnrpbTZUJ7fPeRitKawA6aELhJgt3mW+u3v5ORwOUegaiO2CUEIKIvErxnth
	s0Uy0nVHRKFy+RX3+8Xt79n7ItjM=
X-Google-Smtp-Source: AGHT+IHgfLU5qgAAYBKXOz4TsMgjmHcMKytTPO4TOgKI87Xr+/g1m2gGlblz2QpbaShu6ZHynpzoDXpkxDfBs9DXdps=
X-Received: by 2002:a2e:5109:0:b0:2ef:2c27:6680 with SMTP id
 38308e7fff4ca-2f4f48f8efamr76522081fa.12.1724763578249; Tue, 27 Aug 2024
 05:59:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826070438.557107-1-quic_chejiang@quicinc.com>
 <CABBYNZL5A5SoDrthoyvwuauEnnyOzebHgtkqwptcHZ1em=dAjg@mail.gmail.com> <770d58c7-753b-435b-a98c-ed36ef23d275@quicinc.com>
In-Reply-To: <770d58c7-753b-435b-a98c-ed36ef23d275@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 27 Aug 2024 08:59:25 -0400
Message-ID: <CABBYNZL9u++gGSbGLHCR_4nX-1h4aAaLs6VrnNV=6UVmRitECA@mail.gmail.com>
Subject: Re: [PATCH v1] adapter: Manage device state of cross-transport SMP keys
To: Cheng Jiang <quic_chejiang@quicinc.com>, Xiao Yao <xiaoyao@rock-chips.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cheng,

On Mon, Aug 26, 2024 at 10:20=E2=80=AFPM Cheng Jiang <quic_chejiang@quicinc=
.com> wrote:
>
> Hi Luiz, Please check the comment inline, Please correct me if I'm wrong.
>
> On 8/26/2024 9:56 PM, Luiz Augusto von Dentz wrote:
> > Hi Cheng,
> >
> > On Mon, Aug 26, 2024 at 3:05=E2=80=AFAM Cheng Jiang <quic_chejiang@quic=
inc.com> wrote:
> >>
> >> Cross-transport derived ltk/csrk/irk are reported to bluetoothd from
> >> kernel with BR/EDR address type, and bluetoothd doesn't treat it as LE
> >> paired/bonded. In this case, bluetoothd won't send remove bond operati=
on
> >> with LE address type to kernel when executing unpair, so SMP keys are
> >> retained in kernel list. Then RPA is getting resolved since we still
> >> have irk which was not deleted when unpair device is done because only
> >> link key is deleted since addr type is bredr.
> >>
> >> What=E2=80=99s more, pair LE of the same address will always fail in k=
ernel
> >> for ltk existence, and send back AlreadyExists error, but device state
> >> is still unpaired/unbonded in bluetoothd.
> >>
> >> So bluetoothd needs to consider LE paired/bonded when receiving SMP ke=
ys
> >> even if they are cross-transport derived.

Yeah, and we are chasing our own tail here:

https://github.com/bluez/bluetooth-next/commit/59b047bc98084f8af2c41483e4d6=
8a5adf2fa7f7

So I think we better revert that since that is the culprit of the
problem and doesn't follow our very own documentation, too bad we
didn't realize it sooner because it is causing a lot of problems such:

https://github.com/bluez/bluez/issues/875

> >> ---
> >>  src/adapter.c | 53 ++++++++++++++++++++++++++++++++++++++------------=
-
> >>  1 file changed, 40 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/src/adapter.c b/src/adapter.c
> >> index 245de4456..4e5af9579 100644
> >> --- a/src/adapter.c
> >> +++ b/src/adapter.c
> >> @@ -8647,6 +8647,7 @@ static void new_link_key_callback(uint16_t index=
, uint16_t length,
> >>         struct btd_adapter *adapter =3D user_data;
> >>         struct btd_device *device;
> >>         char dst[18];
> >> +       uint8_t addr_type;
> >>
> >>         if (length < sizeof(*ev)) {
> >>                 btd_error(adapter->dev_id, "Too small new link key eve=
nt");
> >> @@ -8666,7 +8667,13 @@ static void new_link_key_callback(uint16_t inde=
x, uint16_t length,
> >>                 return;
> >>         }
> >>
> >> -       device =3D btd_adapter_get_device(adapter, &addr->bdaddr, addr=
->type);
> >> +       /*
> >> +        * For LE public address, key here is cross-transport derived,
> >> +        * so consider it as BR/EDR public address.
> >> +        *
> >> +        */
> >> +       addr_type =3D addr->type =3D=3D BDADDR_LE_PUBLIC ? BDADDR_BRED=
R : addr->type;
> >> +       device =3D btd_adapter_get_device(adapter, &addr->bdaddr, addr=
_type);
> >>         if (!device) {
> >>                 btd_error(adapter->dev_id,
> >>                                 "Unable to get device object for %s", =
dst);
> >> @@ -8682,7 +8689,7 @@ static void new_link_key_callback(uint16_t index=
, uint16_t length,
> >>                 device_set_bonded(device, BDADDR_BREDR);
> >>         }
> >>
> >> -       bonding_complete(adapter, &addr->bdaddr, addr->type, 0);
> >> +       bonding_complete(adapter, &addr->bdaddr, addr_type, 0);
> >>  }
> >>
> >>  static void store_ltk_group(struct btd_adapter *adapter, const bdaddr=
_t *peer,
> >> @@ -8773,6 +8780,7 @@ static void new_long_term_key_callback(uint16_t =
index, uint16_t length,
> >>         struct btd_device *device;
> >>         bool persistent;
> >>         char dst[18];
> >> +       uint8_t addr_type;
> >>
> >>         if (length < sizeof(*ev)) {
> >>                 btd_error(adapter->dev_id, "Too small long term key ev=
ent");
> >> @@ -8784,7 +8792,13 @@ static void new_long_term_key_callback(uint16_t=
 index, uint16_t length,
> >>         DBG("hci%u new LTK for %s type %u enc_size %u",
> >>                 adapter->dev_id, dst, ev->key.type, ev->key.enc_size);
> >>
> >> -       device =3D btd_adapter_get_device(adapter, &addr->bdaddr, addr=
->type);
> >> +       /*
> >> +        * For BR/EDR public address, key here is cross-transport deri=
ved,
> >> +        * so consider it as LE public address for SMP.
> >> +        *
> >> +        */
> >
> > This is only the case if, an only if, the device is a dual-mode
> > device, so this probably need to be checked that we don't attempt to
> > do this regardless.
> Only the dual-mode device supports Cross-transport derived Keys. From BLE=
 keys to BR/EDR keys, vice versa. If
> single mode device, the addr->type always is BDADDR_BREDR in link key cal=
lback. and BDADDR_LE_PUBLIC or
> BDADDR_LE_RANDOM for LTK/CSRK/IRK callback.
>
> Link Key is for BR/EDR, so we check the address type is BDADDR_LE_PUBLIC =
or not, if yes, treated as BR/EDR,
> it means the link key is derived from BLE bearer. Otherwise, use the orig=
inal addr type. LTK, CSRK, IRK are
> related to BLE, so checked the address type is BDADDR_BREDR or not, if ye=
s, treated as BLE address, it means
> the BLE related key are derived from BR/EDR bearer.
>
> The change seems not affect the current logic, could you please help to e=
xplain more what need to check? Thanks!
> >
> >> +       addr_type =3D addr->type =3D=3D BDADDR_BREDR ? BDADDR_LE_PUBLI=
C : addr->type;
> >> +       device =3D btd_adapter_get_device(adapter, &addr->bdaddr, addr=
_type);
> >>         if (!device) {
> >>                 btd_error(adapter->dev_id,
> >>                                 "Unable to get device object for %s", =
dst);
> >> @@ -8802,8 +8816,7 @@ static void new_long_term_key_callback(uint16_t =
index, uint16_t length,
> >>          * be persistently stored.
> >>          *
> >>          */
> >> -       if (addr->type =3D=3D BDADDR_LE_RANDOM &&
> >> -                               (addr->bdaddr.b[5] & 0xc0) !=3D 0xc0)
> >> +       if (addr_type =3D=3D BDADDR_LE_RANDOM && (addr->bdaddr.b[5] & =
0xc0) !=3D 0xc0)
> >>                 persistent =3D false;
> >>         else
> >>                 persistent =3D !!ev->store_hint;
> >> @@ -8817,15 +8830,15 @@ static void new_long_term_key_callback(uint16_=
t index, uint16_t length,
> >>                 rand =3D le64_to_cpu(key->rand);
> >>
> >>                 store_longtermkey(adapter, &key->addr.bdaddr,
> >> -                                       key->addr.type, key->val, key-=
>central,
> >> +                                       addr_type, key->val, key->cent=
ral,
> >>                                         key->type, key->enc_size, ediv=
, rand);
> >>
> >> -               device_set_bonded(device, addr->type);
> >> +               device_set_bonded(device, addr_type);
> >>         }
> >>
> >>         device_set_ltk(device, ev->key.val, ev->key.central, ev->key.e=
nc_size);
> >>
> >> -       bonding_complete(adapter, &addr->bdaddr, addr->type, 0);
> >> +       bonding_complete(adapter, &addr->bdaddr, addr_type, 0);
> >>  }
> >>
> >>  static void new_csrk_callback(uint16_t index, uint16_t length,
> >> @@ -8837,6 +8850,7 @@ static void new_csrk_callback(uint16_t index, ui=
nt16_t length,
> >>         struct btd_adapter *adapter =3D user_data;
> >>         struct btd_device *device;
> >>         char dst[18];
> >> +       uint8_t addr_type;
> >>
> >>         if (length < sizeof(*ev)) {
> >>                 btd_error(adapter->dev_id, "Too small CSRK event");
> >> @@ -8848,7 +8862,13 @@ static void new_csrk_callback(uint16_t index, u=
int16_t length,
> >>         DBG("hci%u new CSRK for %s type %u", adapter->dev_id, dst,
> >>                                                                 ev->ke=
y.type);
> >>
> >> -       device =3D btd_adapter_get_device(adapter, &addr->bdaddr, addr=
->type);
> >> +       /*
> >> +        * For BR/EDR public address, key here is cross-transport deri=
ved,
> >> +        * so consider it as LE public address for SMP.
> >> +        *
> >> +        */
> >> +       addr_type =3D addr->type =3D=3D BDADDR_BREDR ? BDADDR_LE_PUBLI=
C : addr->type;
> >
> > Ditto.
> >
> >> +       device =3D btd_adapter_get_device(adapter, &addr->bdaddr, addr=
_type);
> >>         if (!device) {
> >>                 btd_error(adapter->dev_id,
> >>                                 "Unable to get device object for %s", =
dst);
> >> @@ -8911,6 +8931,7 @@ static void new_irk_callback(uint16_t index, uin=
t16_t length,
> >>         struct btd_device *device, *duplicate;
> >>         bool persistent;
> >>         char dst[18], rpa[18];
> >> +       uint8_t addr_type;
> >>
> >>         if (length < sizeof(*ev)) {
> >>                 btd_error(adapter->dev_id, "Too small New IRK event");
> >> @@ -8922,16 +8943,22 @@ static void new_irk_callback(uint16_t index, u=
int16_t length,
> >>
> >>         DBG("hci%u new IRK for %s RPA %s", adapter->dev_id, dst, rpa);
> >>
> >> +       /*
> >> +        * For BR/EDR public address, key here is cross-transport deri=
ved,
> >> +        * so consider it as LE public address for SMP.
> >> +        *
> >> +        */
> >> +       addr_type =3D addr->type =3D=3D BDADDR_BREDR ? BDADDR_LE_PUBLI=
C : addr->type;
> >
> > Ditto.
> >
> >>         if (bacmp(&ev->rpa, BDADDR_ANY)) {
> >>                 device =3D btd_adapter_get_device(adapter, &ev->rpa,
> >>                                                         BDADDR_LE_RAND=
OM);
> >>                 duplicate =3D btd_adapter_find_device(adapter, &addr->=
bdaddr,
> >> -                                                               addr->=
type);
> >> +                                                               addr_t=
ype);
> >>                 if (duplicate =3D=3D device)
> >>                         duplicate =3D NULL;
> >>         } else {
> >>                 device =3D btd_adapter_get_device(adapter, &addr->bdad=
dr,
> >> -                                                               addr->=
type);
> >> +                                                               addr_t=
ype);
> >>                 duplicate =3D NULL;
> >>         }
> >>
> >> @@ -8941,7 +8968,7 @@ static void new_irk_callback(uint16_t index, uin=
t16_t length,
> >>                 return;
> >>         }
> >>
> >> -       device_update_addr(device, &addr->bdaddr, addr->type);
> >> +       device_update_addr(device, &addr->bdaddr, addr_type);
> >>
> >>         if (duplicate)
> >>                 device_merge_duplicate(device, duplicate);
> >> @@ -8950,7 +8977,7 @@ static void new_irk_callback(uint16_t index, uin=
t16_t length,
> >>         if (!persistent)
> >>                 return;
> >>
> >> -       store_irk(adapter, &addr->bdaddr, addr->type, irk->val);
> >> +       store_irk(adapter, &addr->bdaddr, addr_type, irk->val);
> >>
> >>         btd_device_set_temporary(device, false);
> >>  }
> >> --
> >> 2.25.1
> >>
> >>
> >
> >
>


--=20
Luiz Augusto von Dentz
