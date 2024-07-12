Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C007043AA9
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jul 2024 17:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720806132; cv=none; b=OTHZRS9AF/Ero61XQP8X8PDhd5+lMQaevI5D+kKtmq3hCePY/LMuBqu5iUl/CV7/GEE4G5UahRksp2EHc5UGErFVVseXSqVDnt7xth0o9MLxHtlTo1Jo+zqynbEiXOgU+X29ddLKfMeRYsKvDQPlITy1HK5qkfMjLOxNNj8cde4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720806132; c=relaxed/simple;
	bh=Fr1J8p6d0uV+HbpGbLttTUUPpU7NXsnv2JQHYWeYBUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=msBLUz82QwSL4QBh5/6OncYSZtV33Bw9y2lhooOgkQL+OOcSEbjBpEbE0XNyQnma/qSWv1R56RqwBg8jH/sptTXN8hnzdLFpDoNIHxZHxqwFizYagSNIRlCqmHcslE9n/l7LW7C0LDRU8kWxo6g72MxLGSxAaPnrZSMwvxByBg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJpnkexL; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJpnkexL"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2eeb1ba040aso28622901fa.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jul 2024 10:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720806129; x=1721410929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlOeF6R4HEF753FyRKDlHlpGGaakYGiiQLNJqJca/I4=;
        b=QJpnkexLyL4A3u2pOR2/oqNlXD74YRrfBbbqTm7qZMzgKPpWVexWgokJNnZxyo141O
         z/wJu/J2jWyge3xO644ScRfNQEdxw1jGI54mScyasyngD3xepJ1nU2E92VH9ineYCSzG
         B+CWZmpDQskbmzQas6zmOH4L1En4C2n6ko28vCgCXznFrSJ9WgtPY1V/ORAIUisQjSuA
         2wiUUt33Q4A0zBfLNll6LGNhA2GHwXw6bZIrebbmDKU0XVoiDq/kbiwdEHjoG9Uihk82
         bay4jikf0WpCZJxmGrBuaQ5UXCsdOezblYNFGQqpzYqsWM1hbMcHUtDUSak6PHlxViEF
         bqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720806129; x=1721410929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OlOeF6R4HEF753FyRKDlHlpGGaakYGiiQLNJqJca/I4=;
        b=tgZLo74Y5ww2HMy8T1PPgGFQAG/PbAQhkqSG9A4n+HxGpb9uHDNW02bcBHHj6wzRaz
         Wa0cl6sHnx8tyZWNWsg8ryPb3y7MFHBkJTGhlt2so1NO6BvaN+0aNz/2oivVlPGYqt/N
         t7n+3s7SZkpf9QkvsfHPzQBWFuz+wfXTSk+o+vUiMLJYEygfuKMx5z1dqO5zBzxcGy+U
         ThJo8VixyRJ6y+ts4yn40h2QyKucm0lf1ARohznuT2tE2PuOTTsGBUayDCVe3zQPcOqb
         UIM4QAXxZCqUneZ22dFbaLl0Y4UMzxGDtWhQaXcZgJF9M84z9ChifK5L7VI8CzhkbiHp
         nbwQ==
X-Gm-Message-State: AOJu0YwqEmhL6WVxsEZdUGwtbZsdUW+OUiAWLiWJ0eSxKa9jhWN5VbK+
	I9+Aoa7REOxlbpWGlz1/ul0xjmiKdqQKKjcuhFSkknc5gs7xUE49rmJT/391YGTY7AmgJlFCYLR
	Nt/sD/2/edREJgdxtV2dIo1uROKbuVOlH
X-Google-Smtp-Source: AGHT+IHqkWuiH2p9ijE2ENNxN8U40kEaKvOzxZRNMp09jgsyBr1CHWVd4RYq6t9k4ZI1MDC2tzgsRj6gqFE5Svq7lJo=
X-Received: by 2002:a2e:a7c4:0:b0:2ee:8ce9:3042 with SMTP id
 38308e7fff4ca-2eeb30b4d76mr105156881fa.9.1720806128571; Fri, 12 Jul 2024
 10:42:08 -0700 (PDT)
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
 <CABBYNZJXfviR-5FND4LxMtdwDL1y-_iRkEJsrp+PkyVk+g=BNw@mail.gmail.com>
 <SN4PR19MB542196B1C79E5262A2F578FBE4A52@SN4PR19MB5421.namprd19.prod.outlook.com>
 <CABBYNZLzgTLqHcKfmOaPUKMkcPXsBeWxbTTfH1V+Dkm-Kvwwog@mail.gmail.com> <SN4PR19MB54210A0B9F146FD283208663E4A62@SN4PR19MB5421.namprd19.prod.outlook.com>
In-Reply-To: <SN4PR19MB54210A0B9F146FD283208663E4A62@SN4PR19MB5421.namprd19.prod.outlook.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 12 Jul 2024 13:41:56 -0400
Message-ID: <CABBYNZKDZW=9Sz+2UoT6jd-m9ibMXhmGgP0ryNiV-VRE32N3hw@mail.gmail.com>
Subject: Re: [PATCH] ATT: Error (0x01) - Error: Unlikely error (14) Prepare
 Write req (0x16)
To: "Ramsay, Trey" <Trey.Ramsay@dell.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Trey,

On Fri, Jul 12, 2024 at 12:42=E2=80=AFPM Ramsay, Trey <Trey.Ramsay@dell.com=
> wrote:
>
> Hi Luiz,
> We use gatt-server for in house BMC daemon for BLE communication to and f=
rom the BMC via mobile device.  When we updated the bluez libriary, the att=
ribute for setting the IPV4 settings failed because a response was never se=
nt for prep_write_cb

Not familiar with the daemon, is that something open source?

> I believe prep_write_complete_cb should be called after prep_write_cb so =
the BT_ATT_OP_PREP_WRITE_RSP response is sent.

Not if you mark to authorize prepare write
https://github.com/bluez/bluez/blob/master/src/gatt-database.c#L3276:

    if (opcode =3D=3D BT_ATT_OP_PREP_WRITE_REQ) {
        if (!btd_device_is_trusted(device) && !desc->prep_authorized &&
                        desc->req_prep_authorization)
            send_write(att, attrib, desc->proxy,
                    desc->pending_writes, id, value, len,
                    offset, false, true);
        else
            gatt_db_attribute_write_result(attrib, id, 0);

        return;
    }

Perhaps what you are not understanding is that this code is
asynchronous, it doesn't respond inline so prep_write_complete_cb will
only be called after the application authorizes/when
gatt_db_attribute_write_result is called to complete the operation.

> Thanks,
> Trey
>
> -----Original Message-----
> From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Sent: Thursday, July 11, 2024 3:53 PM
> To: Ramsay, Trey <Trey_Ramsay@Dell.com>
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: [PATCH] ATT: Error (0x01) - Error: Unlikely error (14) Prepa=
re Write req (0x16)
>
>
> [EXTERNAL EMAIL]
>
> Hi Trey,
>
> On Thu, Jul 11, 2024 at 4:14=E2=80=AFPM Ramsay, Trey <Trey.Ramsay@dell.co=
m> wrote:
> >
> > Thanks Luiz,
> > Maybe I don't understand. In bluez 5.39, prep_write_cb would send BT_AT=
T_OP_PREP_WRITE_RSP at the end of the function.  In the new code, prep_writ=
e_complete_cb is supposed to send BT_ATT_OP_PREP_WRITE_RSP  but prep_write_=
complete_cb  is never called from gatt_db_attribute_write.  Who is supposed=
 to send the BT_ATT_OP_PREP_WRITE_RSP since prep_write_complete_cb  is not =
getting called?  With the patch, prep_write_complete_cb will get called.
> >
> >
> > From Bluez 5.39
> > static void prep_write_cb(uint8_t opcode, const void *pdu,
> >                                         uint16_t length, void
> > *user_data) {
> >         struct bt_gatt_server *server =3D user_data;
> >         uint16_t handle =3D 0;
> >         uint16_t offset;
> >         struct gatt_db_attribute *attr;
> >         uint8_t ecode;
> >
> >         if (length < 4) {
> >                 ecode =3D BT_ATT_ERROR_INVALID_PDU;
> >                 goto error;
> >         }
> >
> >         if (queue_length(server->prep_queue) >=3D server->max_prep_queu=
e_len) {
> >                 ecode =3D BT_ATT_ERROR_PREPARE_QUEUE_FULL;
> >                 goto error;
> >         }
> >
> >         handle =3D get_le16(pdu);
> >         offset =3D get_le16(pdu + 2);
> >
> >         attr =3D gatt_db_get_attribute(server->db, handle);
> >         if (!attr) {
> >                 ecode =3D BT_ATT_ERROR_INVALID_HANDLE;
> >                 goto error;
> >         }
> >
> >         util_debug(server->debug_callback, server->debug_data,
> >                                 "Prep Write Req - handle: 0x%04x",
> > handle);
> >
> >         ecode =3D check_permissions(server, attr, BT_ATT_PERM_WRITE |
> >                                                 BT_ATT_PERM_WRITE_AUTHE=
N |
> >                                                 BT_ATT_PERM_WRITE_ENCRY=
PT);
> >         if (ecode)
> >                 goto error;
> >
> >         if (!store_prep_data(server, handle, offset, length - 4,
> >                                                 &((uint8_t *) pdu)[4]))=
 {
> >                 ecode =3D BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
> >                 goto error;
> >         }
> >
> >         bt_att_send(server->att, BT_ATT_OP_PREP_WRITE_RSP, pdu, length,=
 NULL,     <------------------------- Response is sent
> >                                                                 NULL, N=
ULL);
> >         return;
> >
> > error:
> >         bt_att_send_error_rsp(server->att, opcode, handle, ecode); }
> >
> >
> > -----------------------------------------------------------------------=
---------------------------------------------------------------
> > In Bluez master, the response is sent from prep_write_complete_cb but t=
he call back is never called since gatt_db_attribute_write returns True bef=
ore func is executed which is the function pointer to prep_write_complete_c=
b
> > static void prep_write_complete_cb(struct gatt_db_attribute *attr, int =
err,
> >                                                                 void *u=
ser_data)
> > {
> >         struct prep_write_complete_data *pwcd =3D user_data;
> >         uint16_t handle =3D 0;
> >         uint16_t offset;
> >
> >         handle =3D get_le16(pwcd->pdu);
> >
> >         if (err) {
> >                 bt_att_chan_send_error_rsp(pwcd->chan, BT_ATT_OP_PREP_W=
RITE_REQ,
> >                                                                 handle,=
 err);
> >                 free(pwcd->pdu);
> >                 free(pwcd);
> >
> >                 return;
> >         }
> >
> >         offset =3D get_le16(pwcd->pdu + 2);
> >
> >         if (!store_prep_data(pwcd->server, handle, offset, pwcd->length=
 - 4,
> >                                                 &((uint8_t *) pwcd->pdu=
)[4]))
> >                 bt_att_chan_send_error_rsp(pwcd->chan, BT_ATT_OP_PREP_W=
RITE_RSP,
> >                                         handle,
> >                                         BT_ATT_ERROR_INSUFFICIENT_RESOU=
RCES);
> >
> >         bt_att_chan_send_rsp(pwcd->chan, BT_ATT_OP_PREP_WRITE_RSP, pwcd=
->pdu,  <-------------- Response is sent
> >                                                                 pwcd->l=
ength);
> >
> >         free(pwcd->pdu);
> >         free(pwcd);
> > }
>
> It might be because of:
>
> commit 1ebfc68ff53ea5ed5cb424df151bf413c7ffe9be
> Author: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
> Date:   Mon May 28 10:20:52 2018 +0200
>
>     shared/gatt-server: Request authorization for prepare writes
>
>     This patch adds gatt-server possibility to request authorization from
>     application if needed and previously wasn't authorized. Authorization=
 is
>     requested by sending message with set prepare write authorization req=
est
>     to client.
>
> Anyway we are talking about ancient changes here, what exactly is the
> attribute you are trying to use the so called long write procedure
> btw? Is that using bluetoothctl to register it or is some other
> application involved? Or is this some PTS test case that requires
> authorization? If you use bluetoothctl for that it might be prompting
> to authorize the request.



--=20
Luiz Augusto von Dentz
