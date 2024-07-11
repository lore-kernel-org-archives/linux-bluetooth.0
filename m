Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D038BFC
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jul 2024 20:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720731192; cv=none; b=BfRxIyqfzwX8wCfVX36H8Y3GhoJo5SlVEhoYE/diUY+UGqj2W/LzI0J5NGx3RxGDE7zLbEy2YQbG8ELR1A12ArfyGYBCwr2hccQE22FvAVCDuPgZeG7XQTjo4E2GcsTB8+7cihvagf5tOw9TT+qYOqOIzX7ed0gf/cWeg9j3bGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720731192; c=relaxed/simple;
	bh=xjzRGa8baFYM8UEedXdMZT2dNjfJHS8i0cFe6zph3oA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YlT/ZxMdPWA89VZcMn962jntjx3bX4URoY76SNVlb4LYe56nqYCJivDdxBhx+ZPYhmwgys/qGuoAF8c7f+5C1EccYxAtEFtnIc9aQoEbLEC1EWTCMZ7AyAqva3OY8bGFwBA0eCHEowRCoFvl5uOvYWZdHI4UmPxgP2ffO7tMcjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aRt0V5M4; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRt0V5M4"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52ea79e689eso1782078e87.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jul 2024 13:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720731189; x=1721335989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=niC+DEoE5Wzwp+zRNrF6U5NtHFUsAopY4KHW49sxNyA=;
        b=aRt0V5M4PAzEkpnhNhleavR7pT7XPCDriYdYA3vXZ4hs6EAOBBQQcMLEob73PcTLQ+
         0m4EYpCTX3nxjfTj4pkXB87iPFD3fBqkXC23127ZjXZLOx9wJ0/znRPkNK3fYWCuRa0X
         EAh0G6egofuh0egO+nNzJS6QX7z8/yw3GnUcf3otAiMv3ktPI5j6ruh1dSd2GTW07OQG
         Sw20+mFD9Ma11Q8sJf7XdlF+78TPr+NvdxncJieTUzMrWcaJWUAWaeWMtL5d8N8LpPiw
         lJR1D//7ASQcF/2IKJD8JPkt0uMHAXlnk34xkmknKVhkEL3mEvVkznHCBa0vqWfsUOyC
         LR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720731189; x=1721335989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=niC+DEoE5Wzwp+zRNrF6U5NtHFUsAopY4KHW49sxNyA=;
        b=FJGV0NYdxTPrDQIRkwa4lLQnfBNeAXENaVTaiHr8acNUcmX+SIWx9f0FI39jkuavX6
         iELDBHcgiAeYrmlkp+jwEOL7xueNDFSRe8FEAujb3ezkcTJfEjTmY527mzkUmBvhpNvp
         MV5JFBVoHLOB33axNDYY3D36sNVUhrkucIWEedxL6I+JnB1h3PKUC9Dh+ioQZ5K0fTAg
         c0qgKn1xn79V6rP1B8dCvRLb4aY0XtPhJpvzKFP3mW6mSmqtwwrAIeeMo3pz+9l164Ix
         hnd2qhHrjSCfTLIfg3mYQ5uATHK7R54FqjGBi5e6iMmAJVoVshS4DGAu7LIHbDGB/a42
         Ph6w==
X-Gm-Message-State: AOJu0Yzs7x5p/kPldGT0TFren+3ZEO0yD5B6WVWC2VV1GQlptngjixyA
	pch831Z13MI7JCdafvLOFVA1X1bUTvQqQaUs+M8dcUt40vKs6lt4BITlzJcG2pOefznTlNxOmh+
	oHcUdabGDIXLwWI/j0t/evCTinjM5f9+B1Ws=
X-Google-Smtp-Source: AGHT+IGZmhSDTHDBBs4ox0X0jGEMH4XOxtwpyO3BkO0Xr6InDUlPueFhoDkowDdOqpFlGSF7nb5y9qA3tVYiJmpm3Ww=
X-Received: by 2002:a2e:7304:0:b0:2ee:8777:f86e with SMTP id
 38308e7fff4ca-2eeb30e3d4fmr78818481fa.14.1720731188460; Thu, 11 Jul 2024
 13:53:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SN4PR19MB5421B1226EA92B735CADEA44E4C82@SN4PR19MB5421.namprd19.prod.outlook.com>
 <SN4PR19MB54215EF3B4E7380A21387D2EE4DB2@SN4PR19MB5421.namprd19.prod.outlook.com>
 <CABBYNZ+8ca5f6nWG3D3x8mL3g=57Z0pogQP-+ww_aQuC0R1DWw@mail.gmail.com>
 <SN4PR19MB54214DD841A41FB8C01DDFC9E4A42@SN4PR19MB5421.namprd19.prod.outlook.com>
 <CABBYNZJpG3ioCK9Skqx7_ki3TrqF+Z0GecApPF6Crv+D+J3hDA@mail.gmail.com>
 <SN4PR19MB5421EA5BEB05EFAC63160576E4A52@SN4PR19MB5421.namprd19.prod.outlook.com>
 <CABBYNZJXfviR-5FND4LxMtdwDL1y-_iRkEJsrp+PkyVk+g=BNw@mail.gmail.com> <SN4PR19MB542196B1C79E5262A2F578FBE4A52@SN4PR19MB5421.namprd19.prod.outlook.com>
In-Reply-To: <SN4PR19MB542196B1C79E5262A2F578FBE4A52@SN4PR19MB5421.namprd19.prod.outlook.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 11 Jul 2024 16:52:56 -0400
Message-ID: <CABBYNZLzgTLqHcKfmOaPUKMkcPXsBeWxbTTfH1V+Dkm-Kvwwog@mail.gmail.com>
Subject: Re: [PATCH] ATT: Error (0x01) - Error: Unlikely error (14) Prepare
 Write req (0x16)
To: "Ramsay, Trey" <Trey.Ramsay@dell.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Trey,

On Thu, Jul 11, 2024 at 4:14=E2=80=AFPM Ramsay, Trey <Trey.Ramsay@dell.com>=
 wrote:
>
> Thanks Luiz,
> Maybe I don't understand. In bluez 5.39, prep_write_cb would send BT_ATT_=
OP_PREP_WRITE_RSP at the end of the function.  In the new code, prep_write_=
complete_cb is supposed to send BT_ATT_OP_PREP_WRITE_RSP  but prep_write_co=
mplete_cb  is never called from gatt_db_attribute_write.  Who is supposed t=
o send the BT_ATT_OP_PREP_WRITE_RSP since prep_write_complete_cb  is not ge=
tting called?  With the patch, prep_write_complete_cb will get called.
>
>
> From Bluez 5.39
> static void prep_write_cb(uint8_t opcode, const void *pdu,
>                                         uint16_t length, void *user_data)
> {
>         struct bt_gatt_server *server =3D user_data;
>         uint16_t handle =3D 0;
>         uint16_t offset;
>         struct gatt_db_attribute *attr;
>         uint8_t ecode;
>
>         if (length < 4) {
>                 ecode =3D BT_ATT_ERROR_INVALID_PDU;
>                 goto error;
>         }
>
>         if (queue_length(server->prep_queue) >=3D server->max_prep_queue_=
len) {
>                 ecode =3D BT_ATT_ERROR_PREPARE_QUEUE_FULL;
>                 goto error;
>         }
>
>         handle =3D get_le16(pdu);
>         offset =3D get_le16(pdu + 2);
>
>         attr =3D gatt_db_get_attribute(server->db, handle);
>         if (!attr) {
>                 ecode =3D BT_ATT_ERROR_INVALID_HANDLE;
>                 goto error;
>         }
>
>         util_debug(server->debug_callback, server->debug_data,
>                                 "Prep Write Req - handle: 0x%04x", handle=
);
>
>         ecode =3D check_permissions(server, attr, BT_ATT_PERM_WRITE |
>                                                 BT_ATT_PERM_WRITE_AUTHEN =
|
>                                                 BT_ATT_PERM_WRITE_ENCRYPT=
);
>         if (ecode)
>                 goto error;
>
>         if (!store_prep_data(server, handle, offset, length - 4,
>                                                 &((uint8_t *) pdu)[4])) {
>                 ecode =3D BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
>                 goto error;
>         }
>
>         bt_att_send(server->att, BT_ATT_OP_PREP_WRITE_RSP, pdu, length, N=
ULL,     <------------------------- Response is sent
>                                                                 NULL, NUL=
L);
>         return;
>
> error:
>         bt_att_send_error_rsp(server->att, opcode, handle, ecode);
> }
>
>
> -------------------------------------------------------------------------=
-------------------------------------------------------------
> In Bluez master, the response is sent from prep_write_complete_cb but the=
 call back is never called since gatt_db_attribute_write returns True befor=
e func is executed which is the function pointer to prep_write_complete_cb
> static void prep_write_complete_cb(struct gatt_db_attribute *attr, int er=
r,
>                                                                 void *use=
r_data)
> {
>         struct prep_write_complete_data *pwcd =3D user_data;
>         uint16_t handle =3D 0;
>         uint16_t offset;
>
>         handle =3D get_le16(pwcd->pdu);
>
>         if (err) {
>                 bt_att_chan_send_error_rsp(pwcd->chan, BT_ATT_OP_PREP_WRI=
TE_REQ,
>                                                                 handle, e=
rr);
>                 free(pwcd->pdu);
>                 free(pwcd);
>
>                 return;
>         }
>
>         offset =3D get_le16(pwcd->pdu + 2);
>
>         if (!store_prep_data(pwcd->server, handle, offset, pwcd->length -=
 4,
>                                                 &((uint8_t *) pwcd->pdu)[=
4]))
>                 bt_att_chan_send_error_rsp(pwcd->chan, BT_ATT_OP_PREP_WRI=
TE_RSP,
>                                         handle,
>                                         BT_ATT_ERROR_INSUFFICIENT_RESOURC=
ES);
>
>         bt_att_chan_send_rsp(pwcd->chan, BT_ATT_OP_PREP_WRITE_RSP, pwcd->=
pdu,  <-------------- Response is sent
>                                                                 pwcd->len=
gth);
>
>         free(pwcd->pdu);
>         free(pwcd);
> }

It might be because of:

commit 1ebfc68ff53ea5ed5cb424df151bf413c7ffe9be
Author: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
Date:   Mon May 28 10:20:52 2018 +0200

    shared/gatt-server: Request authorization for prepare writes

    This patch adds gatt-server possibility to request authorization from
    application if needed and previously wasn't authorized. Authorization i=
s
    requested by sending message with set prepare write authorization reqes=
t
    to client.

Anyway we are talking about ancient changes here, what exactly is the
attribute you are trying to use the so called long write procedure
btw? Is that using bluetoothctl to register it or is some other
application involved? Or is this some PTS test case that requires
authorization? If you use bluetoothctl for that it might be prompting
to authorize the request.
