Return-Path: <SRS0=Gf0L=6V=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA84C47257
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 May 2020 02:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71915207DD
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 May 2020 02:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RfnJyede"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgEGCC7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 May 2020 22:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725869AbgEGCC7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 May 2020 22:02:59 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F63C061A0F
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2020 19:02:57 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id u6so4543974ljl.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 May 2020 19:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JftO9ZPk3lm4VEnE5H2ZidL84OVFYFYeTSPVskN7DtQ=;
        b=RfnJyedef7JbA4Y21K8WLdpqnIvfFhPqip9gNXNasO6NR5ITBOYoNAQfEcuXZZPxHw
         vO7rvR/NuYF/Rs5mBdrzsPai9ppRy0POh1jr7rE6wFgJRaULhG3SmcI1ICEbuH9KE6WW
         bnnlhX7lKgH6B1kbiVldtlJG58+rF1RG+tAclVl3+6hTgfzTcmpjznHV0UwO4ZmN8pEn
         mRAt+IxoPuq1megSv5jLHpqYsfUwG5JX4Zq0ruVzFj8V+iktb8pRkyc3tQqYiTonddEE
         4cP7SFu322jQMADApQSiFNpuZIE+/pRQBeqeG4rE9e6EAunX01imP4QqdqNF1NY74b7t
         yWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JftO9ZPk3lm4VEnE5H2ZidL84OVFYFYeTSPVskN7DtQ=;
        b=VZdGRP+GheX33YWKg0KnGmdmCXgApEJtKUJV7zlOtCIuYKgj3Tq07NDT4e7ck2uEoK
         R1DyG7QY8F3/GJ13c/5OgpMSflHO8DzUrX+MT1pXU0W2+g5RAb+ok7SnXnGNuDf9BE9R
         y33za+dcer1irTebQPGZoKxJ8RPxQ0+sIhRpjdd4nxXMRKYE+VsKmzgSYXe3ntIUv6V5
         sA80PxNEOCEt1fCHPeI4/j4v0J1f7dNf/295PfRVrZZ8QhC/1GrhoiL5/JQ0kewgVP0U
         hWiUQQvUz9BqBtWyaFuAzXn+Ka2KRotn8uP9Z7CKFt3EUTWWfVYnkxuKMvSnwsTTs/IF
         a5Ag==
X-Gm-Message-State: AGi0PubP1nGZyECvomzGA3KXt3hgIKuFazkt2Dwi9yxP4764eZi/7aw+
        GcwG73Mv/GWJlQlghvk453nsvI7Hn9Y2PvFhp98x+w==
X-Google-Smtp-Source: APiQypKD3nOUQpdc9UJini1h22hfbiIgNXI4OEyo7B1T5fu5JTG7J1sdJBRPitJS7zmx315nGFnqmq2PDvhX6qff7io=
X-Received: by 2002:a2e:b8c4:: with SMTP id s4mr6644125ljp.101.1588816975322;
 Wed, 06 May 2020 19:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200506194332.Bluez.v1.1.I45da219fa28f72db2e11778c15cee5aad446b1c4@changeid>
 <CABBYNZJYFG5G=T4SXFk1Aho=w9tg7YD5GoBrkRi08o9V4DFDXg@mail.gmail.com>
In-Reply-To: <CABBYNZJYFG5G=T4SXFk1Aho=w9tg7YD5GoBrkRi08o9V4DFDXg@mail.gmail.com>
From:   Archie Pusaka <apusaka@google.com>
Date:   Thu, 7 May 2020 10:02:44 +0800
Message-ID: <CAJQfnxGU8zK=qMVPDtKWiduysMUBt4pWxf=L57eddgdjDQUntw@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] shared/gatt-server: Fix read multiple charc values
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Thu, 7 May 2020 at 01:28, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Archie,
>
> On Wed, May 6, 2020 at 4:45 AM Archie Pusaka <apusaka@google.com> wrote:
> >
> > From: Archie Pusaka <apusaka@chromium.org>
> >
> > According to bluetooth spec Ver 5.2, Vol 3, Part G, 4.8.4, An
> > ATT_ERROR_RSP PDU shall be sent by the server in response to the
> > ATT_READ_MULTIPLE_RSP PDU if insufficient authentication,
> > insufficient authorization, insufficient encryption key size, or
> > insufficient encryption is used by the client, or if a read operation
> > is not permitted on any of the Characteristic Values.
> >
> > Currently if the size of the response grows larger than the MTU size,
> > BlueZ does an early return and not check the permission for the rest
> > of the characteristics. This patch forces BlueZ to check for possible
> > errors even though we already reach MTU size.
> >
> > This patch also moves the read permission check for read multiple
> > characteristics so it is done before actually retrieving the
> > characteristics.
>
> Is there a test failing because of this? If there is not I would have
> thought this is actually a prefered behavior since the subsequent read
> would cause an error at least the client would be able to the data it
> could read in the beginning otherwise this will be imposing the
> database to read all the handles discarding the data that don't fit
> just to propagate the errors before the data can actually be read.
>

I was running the qualification test GATT/SR/GAR/BI-18-C to BI-22-C,
and sometimes this issue pops out.
It looks like PTS runs these tests by randomly selecting 1 readable
characteristic and 1 other characteristic which is known to be
unauthorized, nonexistent, or with other types of errors. If the 1
readable characteristic is too long, then BlueZ will not return the
expected error, which upsets PTS.

The core spec also describes this behavior in Vol 3, Part F, 3.4.4.7:
"The server shall respond with an ATT_READ_MULTIPLE_RSP PDU if all the
handles are valid and all attributes have sufficient permissions to
allow reading."

> > ---
> >
> >  src/shared/gatt-server.c | 88 ++++++++++++++++++++--------------------
> >  1 file changed, 45 insertions(+), 43 deletions(-)
> >
> > diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
> > index 4e07398d2..e937d80a8 100644
> > --- a/src/shared/gatt-server.c
> > +++ b/src/shared/gatt-server.c
> > @@ -1057,33 +1057,23 @@ static void read_multiple_complete_cb(struct gatt_db_attribute *attr, int err,
> >         uint16_t length;
> >
> >         if (err != 0) {
> > -               bt_att_chan_send_error_rsp(data->chan, data->opcode, handle,
> > -                                                                       err);
> > -               read_mult_data_free(data);
> > -               return;
> > -       }
> > -
> > -       ecode = check_permissions(data->server, attr, BT_ATT_PERM_READ |
> > -                                               BT_ATT_PERM_READ_AUTHEN |
> > -                                               BT_ATT_PERM_READ_ENCRYPT);
> > -       if (ecode) {
> > -               bt_att_chan_send_error_rsp(data->chan, data->opcode, handle,
> > -                                                                       ecode);
> > -               read_mult_data_free(data);
> > -               return;
> > +               ecode = err;
> > +               goto error;
> >         }
> >
> >         length = data->opcode == BT_ATT_OP_READ_MULT_VL_REQ ?
> > -                       MIN(len, data->mtu - data->length - 3) :
> > +                       MIN(len, MAX(0, data->mtu - data->length - 3)) :
> >                         MIN(len, data->mtu - data->length - 1);
> >
> >         if (data->opcode == BT_ATT_OP_READ_MULT_VL_REQ) {
> >                 /* The Length Value Tuple List may be truncated within the first
> >                  * two octets of a tuple due to the size limits of the current
> > -                * ATT_MTU.
> > +                * ATT_MTU, but the first two octets cannot be separated.
> >                  */
> > -               put_le16(len, data->rsp_data + data->length);
> > -               data->length += 2;
> > +               if (data->mtu - data->length >= 3) {
> > +                       put_le16(len, data->rsp_data + data->length);
> > +                       data->length += 2;
> > +               }
> >         }
> >
> >         memcpy(data->rsp_data + data->length, value, length);
> > @@ -1091,45 +1081,46 @@ static void read_multiple_complete_cb(struct gatt_db_attribute *attr, int err,
> >
> >         data->cur_handle++;
> >
> > -       len = data->opcode == BT_ATT_OP_READ_MULT_VL_REQ ?
> > -               data->mtu - data->length - 3 : data->mtu - data->length - 1;
> > -
> > -       if (!len || (data->cur_handle == data->num_handles)) {
> > +       if (data->cur_handle == data->num_handles) {
> >                 bt_att_chan_send_rsp(data->chan, data->opcode + 1,
> >                                                 data->rsp_data, data->length);
> >                 read_mult_data_free(data);
> >                 return;
> >         }
> >
> > +       handle = data->handles[data->cur_handle];
> > +
> >         util_debug(data->server->debug_callback, data->server->debug_data,
> >                                 "%s Req - #%zu of %zu: 0x%04x",
> >                                 data->opcode == BT_ATT_OP_READ_MULT_REQ ?
> >                                 "Read Multiple" :
> >                                 "Read Multiple Variable Length",
> >                                 data->cur_handle + 1, data->num_handles,
> > -                               data->handles[data->cur_handle]);
> > +                               handle);
> >
> > -       next_attr = gatt_db_get_attribute(data->server->db,
> > -                                       data->handles[data->cur_handle]);
> > +       next_attr = gatt_db_get_attribute(data->server->db, handle);
> >
> >         if (!next_attr) {
> > -               bt_att_chan_send_error_rsp(data->chan,
> > -                                       BT_ATT_OP_READ_MULT_REQ,
> > -                                       data->handles[data->cur_handle],
> > -                                       BT_ATT_ERROR_INVALID_HANDLE);
> > -               read_mult_data_free(data);
> > -               return;
> > +               ecode = BT_ATT_ERROR_INVALID_HANDLE;
> > +               goto error;
> >         }
> >
> > -       if (!gatt_db_attribute_read(next_attr, 0, BT_ATT_OP_READ_MULT_REQ,
> > +       ecode = check_permissions(data->server, next_attr, BT_ATT_PERM_READ |
> > +                                               BT_ATT_PERM_READ_AUTHEN |
> > +                                               BT_ATT_PERM_READ_ENCRYPT);
> > +       if (ecode)
> > +               goto error;
> > +
> > +       if (gatt_db_attribute_read(next_attr, 0, data->opcode,
> >                                         data->server->att,
> > -                                       read_multiple_complete_cb, data)) {
> > -               bt_att_chan_send_error_rsp(data->chan,
> > -                                               BT_ATT_OP_READ_MULT_REQ,
> > -                                               data->handles[data->cur_handle],
> > -                                               BT_ATT_ERROR_UNLIKELY);
> > -               read_mult_data_free(data);
> > -       }
> > +                                       read_multiple_complete_cb, data))
> > +               return;
> > +
> > +       ecode = BT_ATT_ERROR_UNLIKELY;
> > +
> > +error:
> > +       bt_att_chan_send_error_rsp(data->chan, data->opcode, handle, ecode);
> > +       read_mult_data_free(data);
> >  }
> >
> >  static struct read_mult_data *read_mult_data_new(struct bt_gatt_server *server,
> > @@ -1161,8 +1152,9 @@ static void read_multiple_cb(struct bt_att_chan *chan, uint8_t opcode,
> >         struct bt_gatt_server *server = user_data;
> >         struct gatt_db_attribute *attr;
> >         struct read_mult_data *data = NULL;
> > -       uint8_t ecode = BT_ATT_ERROR_UNLIKELY;
> > +       uint8_t ecode;
> >         size_t i = 0;
> > +       uint16_t handle = 0;
> >
> >         if (length < 4) {
> >                 ecode = BT_ATT_ERROR_INVALID_PDU;
> > @@ -1176,28 +1168,38 @@ static void read_multiple_cb(struct bt_att_chan *chan, uint8_t opcode,
> >         for (i = 0; i < data->num_handles; i++)
> >                 data->handles[i] = get_le16(pdu + i * 2);
> >
> > +       handle = data->handles[0];
> > +
> >         util_debug(server->debug_callback, server->debug_data,
> >                         "%s Req - %zu handles, 1st: 0x%04x",
> >                         data->opcode == BT_ATT_OP_READ_MULT_REQ ?
> >                         "Read Multiple" : "Read Multiple Variable Length",
> > -                       data->num_handles, data->handles[0]);
> > +                       data->num_handles, handle);
> >
> > -       attr = gatt_db_get_attribute(server->db, data->handles[0]);
> > +       attr = gatt_db_get_attribute(server->db, handle);
> >
> >         if (!attr) {
> >                 ecode = BT_ATT_ERROR_INVALID_HANDLE;
> >                 goto error;
> >         }
> >
> > +       ecode = check_permissions(data->server, attr, BT_ATT_PERM_READ |
> > +                                               BT_ATT_PERM_READ_AUTHEN |
> > +                                               BT_ATT_PERM_READ_ENCRYPT);
> > +       if (ecode)
> > +               goto error;
> > +
> >         if (gatt_db_attribute_read(attr, 0, opcode, server->att,
> >                                         read_multiple_complete_cb, data))
> >                 return;
> >
> > +       ecode = BT_ATT_ERROR_UNLIKELY;
> > +
> >  error:
> >         if (data)
> >                 read_mult_data_free(data);
> >
> > -       bt_att_chan_send_error_rsp(chan, opcode, 0, ecode);
> > +       bt_att_chan_send_error_rsp(chan, opcode, handle, ecode);
> >  }
> >
> >  static bool append_prep_data(struct prep_write_data *prep_data, uint16_t handle,
> > --
> > 2.26.2.526.g744177e7f7-goog
> >
>
>
> --
> Luiz Augusto von Dentz
