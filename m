Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF7B5338D
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Sep 2024 14:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727362055; cv=none; b=T5Le67HwAyZHqfwJpehfo78o49gNuMStv/6saGXngNdDgyn5hg67U4CKZM6L7xzCfWYGY080b75h3WGZW7GbnKbJvZ72/+39r8SRWNBPMf6MyZYRTwvp++vJsHxZpJK80RojuBnH16Ti7emxeN2vRkdqkPh2dSKTOBGX1ZiwMoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727362055; c=relaxed/simple;
	bh=HXgLJ+jAcpg+N7XVfCuxyQrQ08Koop7xTIFMHbI65Bc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gypn1JmS4lcfrQ8yLdmH/zCJrgd7cYz1fHD6RkjO6mHAgm6TUmXgdUarbMoZxbyzfYtvWeax5QBlMVJIn8nwjueeiCCgqyd+TcsKiQFeyt6tZdmmX8efPHM3tj/QhAAQLfB3jMHBU/EQjudeUSxctWdDly4KMWkc0bDgHoJTpws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYwTgDQy; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYwTgDQy"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f762de00fbso13182361fa.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Sep 2024 07:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727362052; x=1727966852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmVVF+HM2fdOrh/opnbf/1QHiN2G3HwcF0X1JyE0UxM=;
        b=MYwTgDQyYFj71esMbvWUVCb4ViRSwuS91yx96OI3XIlEYYyZBND/1+w9IUYmg/ZV2Z
         uFeyufpg5PJgzaUGCcGqTbg2YB7fX298Os6cyVsgFc32Jpvee3M0001n+M3I/UuSWxB2
         tmoLLHuHTDjVPu6emORJHZuz/AH/gsXI8oEgJ7BWDGb6d8yedFAzCOuJU+3R5EsUo99B
         EW0gcAGAur/bvlJ5LvMBy6lja8aDYKCB4jWc/vbdW1CH9xyyBPFiSkqg/9NMKARzaEF5
         HxCchbVzMKAEtwb+VYyrRzngBJzuB43flac3E43QK0DFi6z7nxqzKKP1/Xt3NgR+Bbfy
         q+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727362052; x=1727966852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hmVVF+HM2fdOrh/opnbf/1QHiN2G3HwcF0X1JyE0UxM=;
        b=aVsNrMOwVtIU21n7yAVNNZJoLPMPyyA7LW3PcKUoBDntkS5jQqhQcCS3AKbnrLCX2q
         lQhm/vgOgSc2ApJ9mOFM8zNr7TyMx16skS+p5BEI5bN8t8SR+cMj0QOL1fgzbCmV+iVe
         bc0/A5Wbcoiv+CXYtBnlvN6YWRZEF+DNnQmUmWABFCwrpS2CsSgVdC/vB1uKFwL/XBZK
         AKM6gBLqa6sxqMTyvExEShdk2x7Ea3x+uNRTHxWNa7HLBWkw0UYhwlk75ZrVShUtEel+
         5sQdN+wDthy4CW9rP4TvsKKawo+vxHBQxkOTAwcyveHIRCWrNnCm3E5JoQQG7ri9zv1g
         eXeA==
X-Gm-Message-State: AOJu0YzcaOLsMNjf3uVpKPSIElj9O7wEIA1tsrE2ZcYBZq7HfRt2cNFs
	fYFFAyh28sD/a2zOG2yChzJi5HETslC7hfUkBcEU4UpwrHAd4rFSbkwLpEJNL9LfRns3djv9oX+
	ClFQOt9QK/rmIgQJdwQgLI0CSER6fTA==
X-Google-Smtp-Source: AGHT+IGGhfa5VjOR/nDOiQfnawxrWdCtri2cJ81iioqiliCExyHHYBH5gtDz5tzcnZJAdjsWVUGjOCP6GRb9112plKA=
X-Received: by 2002:a05:651c:2105:b0:2f7:8ef8:77c0 with SMTP id
 38308e7fff4ca-2f91ca45ddfmr40987881fa.38.1727362051651; Thu, 26 Sep 2024
 07:47:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925090948.1540589-1-quic_chejiang@quicinc.com>
 <CABBYNZJF0qMkEAE5rKz5GQB7ABkAHzSsMbn1Fdp3J8PdywOWtA@mail.gmail.com> <3a1dcec4-551f-434e-84e0-3d08924cb2af@quicinc.com>
In-Reply-To: <3a1dcec4-551f-434e-84e0-3d08924cb2af@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 26 Sep 2024 10:47:18 -0400
Message-ID: <CABBYNZL63cUk1JMZ=76cR3M+gUdxHPUiBRwj8HUsOHzWrwRDcg@mail.gmail.com>
Subject: Re: [PATCH v3] device: Remove device after all bearers are disconnected
To: Cheng Jiang <quic_chejiang@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_jiaymao@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cheng,

On Wed, Sep 25, 2024 at 9:31=E2=80=AFPM Cheng Jiang <quic_chejiang@quicinc.=
com> wrote:
>
> Hi Luiz,
>
> On 9/25/2024 10:56 PM, Luiz Augusto von Dentz wrote:
> > Hi Cheng,
> >
> > On Wed, Sep 25, 2024 at 5:10=E2=80=AFAM Cheng Jiang <quic_chejiang@quic=
inc.com> wrote:
> >>
> >> For a combo mode remote, both BR/EDR and BLE may be connected.
> >> RemoveDevice should be handled after all bearers are dropped,
> >> otherwise, remove device is not performed in adapter_remove_connection=
.
> >> ---
> >>  src/device.c | 12 +++++++++++-
> >>  1 file changed, 11 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/src/device.c b/src/device.c
> >> index f8f61e643..c25bf6b60 100644
> >> --- a/src/device.c
> >> +++ b/src/device.c
> >> @@ -3492,8 +3492,18 @@ void device_remove_connection(struct btd_device=
 *device, uint8_t bdaddr_type,
> >>                 DBusMessage *msg =3D device->disconnects->data;
> >>
> >>                 if (dbus_message_is_method_call(msg, ADAPTER_INTERFACE=
,
> >> -                                                               "Remov=
eDevice"))
> >> +                                                       "RemoveDevice"=
)) {
> >> +
> >> +                       /* Don't handle the RemoveDevice msg if device=
 is
> >> +                        * connected. For a dual mode remote, both BR/=
EDR
> >> +                        * and BLE may be connected, RemoveDevice shou=
ld
> >> +                        * be handled after all bearers are disconnect=
s.
> >> +                        */
> >> +                       if (device->bredr_state.connected ||
> >> +                                       device->le_state.connected)
> >> +                               break;
> >
> > While this seems to make sense further down there is the same state:
> >
> > line 3531: if (device->bredr_state.connected || device->le_state.connec=
ted)
> >
> > So what this is doing is just to avoid removing the msg from
> > device->disconnects but perhaps I'm missing something.
> Yes, it is used to avoid remove the msg. If BR/EDR and BLE are connected,=
 when user perform
> remove operation, the BR/EDR connection is disconnect first. Then it set =
the "remove_device"
> to True, and remove the msg from device->disconnects, but BLE is still co=
nnected, so this function
> (device_remove_connection) will return without set the *remove to True.
> Then the BLE is disconnected, but at this time, msg is already removed fr=
om device->disconnects, so
> "remove_device" is not set to True. And accordingly *remove is not true. =
The device is not removed for
> adapter in adapter_remove_connection. Need to wait for temporary device t=
imeout to remove the device.

Aha, that makes a lot more sense now, could you please update this in
the patch description just to make it more clear, I will push it once
you do that.

>
> >
> >>                         remove_device =3D true;
> >> +               }
> >>
> >>                 g_dbus_send_reply(dbus_conn, msg, DBUS_TYPE_INVALID);
> >>                 device->disconnects =3D g_slist_remove(device->disconn=
ects, msg);
> >> --
> >> 2.25.1
> >>
> >>
> >
> >
>


--=20
Luiz Augusto von Dentz
