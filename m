Return-Path: <SRS0=zRH5=6U=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D42CC4724C
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 17:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1490320936
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 17:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFl8b/Zz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgEFR2w (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 May 2020 13:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgEFR2w (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 May 2020 13:28:52 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A20C061A0F
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2020 10:28:52 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 72so2041656otu.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 May 2020 10:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EXm3WHjxstSDjKWJWQm5QGZZpYO/PZNqTpkN61YnFL8=;
        b=HFl8b/ZzRxd6zJDaszRqocGYUpNIBqrVTY08jDfCROaHV5N+cO+5SV3b0bjGmDLSTj
         +i3N2tqmyLjkAMVRMkksMzv5PgaoGkqTPM5ktPgqpSn+AeA+1Esys53hemqPYOZ8t5FK
         loJwZTAWVwwXioj4aqe+0KIZzitlSnaoDle5NJeKWp9Bk+Zifk8PrXt9LHdFbqXPLgCy
         kQDKbGQ5+WGRDalRGDpI+yTTkoSWMEHQm0eV9cSE4XYKlZ3RYlmjGdESAOG6JVK7za5e
         L1aKdh9jjmZPTJbUQCQ4kIYpyob4a2RHkkv9Pw4TAhTCbghSx9k9XqWwtXsK4314AQ/c
         2GDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EXm3WHjxstSDjKWJWQm5QGZZpYO/PZNqTpkN61YnFL8=;
        b=oonjAMvDQXiYwc2ZzjqmPnaN9VxUMNzR932z+1F9j4iNy1ysDaClE47er+mxOTW+rM
         R4fjPV5C7khN7NFqz3Cmyrl/qOyPouzMkyBCtVd3lQoDqlVmPJCFjSDBNBECXR3znhxi
         toryEHtZ3rhpGVwouqIV156zWNtKFvIhxsmbFyjc1VpE3g9RyyR+QyVJr5qDuE2gQtjp
         neRsFuFwapNVRbTdDIbyx+m7fX2SO5caYxwCxcx9X8ccdVHh8t4JIpscbeXreY99UMvG
         Ua5ZWu9JbjzmL4Mk+YJtzeN53Pf0qHjdbSPU9orizCAMUH+e3CEwGBsvpgqINfn5g1A/
         j40w==
X-Gm-Message-State: AGi0PubnPxTABo8M6Z6nVHaVnub09Q2th8szOB0MsqWOlotVISpg10Ie
        PC3s9fBMT2/obU664VR1PKEdBZPnF5m7i9X4ucw=
X-Google-Smtp-Source: APiQypK6JQFjsBx5nJGZf6RxMezk7kcnqWi8/UCn0+MNVWQDNb3ILV9L1dUjD6AWq+T1OcLfCdRCJfLZKFK0c7k2KqM=
X-Received: by 2002:a9d:57cb:: with SMTP id q11mr7452728oti.11.1588786131484;
 Wed, 06 May 2020 10:28:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200506194332.Bluez.v1.1.I45da219fa28f72db2e11778c15cee5aad446b1c4@changeid>
In-Reply-To: <20200506194332.Bluez.v1.1.I45da219fa28f72db2e11778c15cee5aad446b1c4@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 6 May 2020 10:28:39 -0700
Message-ID: <CABBYNZJYFG5G=T4SXFk1Aho=w9tg7YD5GoBrkRi08o9V4DFDXg@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] shared/gatt-server: Fix read multiple charc values
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Wed, May 6, 2020 at 4:45 AM Archie Pusaka <apusaka@google.com> wrote:
>
> From: Archie Pusaka <apusaka@chromium.org>
>
> According to bluetooth spec Ver 5.2, Vol 3, Part G, 4.8.4, An
> ATT_ERROR_RSP PDU shall be sent by the server in response to the
> ATT_READ_MULTIPLE_RSP PDU if insufficient authentication,
> insufficient authorization, insufficient encryption key size, or
> insufficient encryption is used by the client, or if a read operation
> is not permitted on any of the Characteristic Values.
>
> Currently if the size of the response grows larger than the MTU size,
> BlueZ does an early return and not check the permission for the rest
> of the characteristics. This patch forces BlueZ to check for possible
> errors even though we already reach MTU size.
>
> This patch also moves the read permission check for read multiple
> characteristics so it is done before actually retrieving the
> characteristics.

Is there a test failing because of this? If there is not I would have
thought this is actually a prefered behavior since the subsequent read
would cause an error at least the client would be able to the data it
could read in the beginning otherwise this will be imposing the
database to read all the handles discarding the data that don't fit
just to propagate the errors before the data can actually be read.

> ---
>
>  src/shared/gatt-server.c | 88 ++++++++++++++++++++--------------------
>  1 file changed, 45 insertions(+), 43 deletions(-)
>
> diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
> index 4e07398d2..e937d80a8 100644
> --- a/src/shared/gatt-server.c
> +++ b/src/shared/gatt-server.c
> @@ -1057,33 +1057,23 @@ static void read_multiple_complete_cb(struct gatt_db_attribute *attr, int err,
>         uint16_t length;
>
>         if (err != 0) {
> -               bt_att_chan_send_error_rsp(data->chan, data->opcode, handle,
> -                                                                       err);
> -               read_mult_data_free(data);
> -               return;
> -       }
> -
> -       ecode = check_permissions(data->server, attr, BT_ATT_PERM_READ |
> -                                               BT_ATT_PERM_READ_AUTHEN |
> -                                               BT_ATT_PERM_READ_ENCRYPT);
> -       if (ecode) {
> -               bt_att_chan_send_error_rsp(data->chan, data->opcode, handle,
> -                                                                       ecode);
> -               read_mult_data_free(data);
> -               return;
> +               ecode = err;
> +               goto error;
>         }
>
>         length = data->opcode == BT_ATT_OP_READ_MULT_VL_REQ ?
> -                       MIN(len, data->mtu - data->length - 3) :
> +                       MIN(len, MAX(0, data->mtu - data->length - 3)) :
>                         MIN(len, data->mtu - data->length - 1);
>
>         if (data->opcode == BT_ATT_OP_READ_MULT_VL_REQ) {
>                 /* The Length Value Tuple List may be truncated within the first
>                  * two octets of a tuple due to the size limits of the current
> -                * ATT_MTU.
> +                * ATT_MTU, but the first two octets cannot be separated.
>                  */
> -               put_le16(len, data->rsp_data + data->length);
> -               data->length += 2;
> +               if (data->mtu - data->length >= 3) {
> +                       put_le16(len, data->rsp_data + data->length);
> +                       data->length += 2;
> +               }
>         }
>
>         memcpy(data->rsp_data + data->length, value, length);
> @@ -1091,45 +1081,46 @@ static void read_multiple_complete_cb(struct gatt_db_attribute *attr, int err,
>
>         data->cur_handle++;
>
> -       len = data->opcode == BT_ATT_OP_READ_MULT_VL_REQ ?
> -               data->mtu - data->length - 3 : data->mtu - data->length - 1;
> -
> -       if (!len || (data->cur_handle == data->num_handles)) {
> +       if (data->cur_handle == data->num_handles) {
>                 bt_att_chan_send_rsp(data->chan, data->opcode + 1,
>                                                 data->rsp_data, data->length);
>                 read_mult_data_free(data);
>                 return;
>         }
>
> +       handle = data->handles[data->cur_handle];
> +
>         util_debug(data->server->debug_callback, data->server->debug_data,
>                                 "%s Req - #%zu of %zu: 0x%04x",
>                                 data->opcode == BT_ATT_OP_READ_MULT_REQ ?
>                                 "Read Multiple" :
>                                 "Read Multiple Variable Length",
>                                 data->cur_handle + 1, data->num_handles,
> -                               data->handles[data->cur_handle]);
> +                               handle);
>
> -       next_attr = gatt_db_get_attribute(data->server->db,
> -                                       data->handles[data->cur_handle]);
> +       next_attr = gatt_db_get_attribute(data->server->db, handle);
>
>         if (!next_attr) {
> -               bt_att_chan_send_error_rsp(data->chan,
> -                                       BT_ATT_OP_READ_MULT_REQ,
> -                                       data->handles[data->cur_handle],
> -                                       BT_ATT_ERROR_INVALID_HANDLE);
> -               read_mult_data_free(data);
> -               return;
> +               ecode = BT_ATT_ERROR_INVALID_HANDLE;
> +               goto error;
>         }
>
> -       if (!gatt_db_attribute_read(next_attr, 0, BT_ATT_OP_READ_MULT_REQ,
> +       ecode = check_permissions(data->server, next_attr, BT_ATT_PERM_READ |
> +                                               BT_ATT_PERM_READ_AUTHEN |
> +                                               BT_ATT_PERM_READ_ENCRYPT);
> +       if (ecode)
> +               goto error;
> +
> +       if (gatt_db_attribute_read(next_attr, 0, data->opcode,
>                                         data->server->att,
> -                                       read_multiple_complete_cb, data)) {
> -               bt_att_chan_send_error_rsp(data->chan,
> -                                               BT_ATT_OP_READ_MULT_REQ,
> -                                               data->handles[data->cur_handle],
> -                                               BT_ATT_ERROR_UNLIKELY);
> -               read_mult_data_free(data);
> -       }
> +                                       read_multiple_complete_cb, data))
> +               return;
> +
> +       ecode = BT_ATT_ERROR_UNLIKELY;
> +
> +error:
> +       bt_att_chan_send_error_rsp(data->chan, data->opcode, handle, ecode);
> +       read_mult_data_free(data);
>  }
>
>  static struct read_mult_data *read_mult_data_new(struct bt_gatt_server *server,
> @@ -1161,8 +1152,9 @@ static void read_multiple_cb(struct bt_att_chan *chan, uint8_t opcode,
>         struct bt_gatt_server *server = user_data;
>         struct gatt_db_attribute *attr;
>         struct read_mult_data *data = NULL;
> -       uint8_t ecode = BT_ATT_ERROR_UNLIKELY;
> +       uint8_t ecode;
>         size_t i = 0;
> +       uint16_t handle = 0;
>
>         if (length < 4) {
>                 ecode = BT_ATT_ERROR_INVALID_PDU;
> @@ -1176,28 +1168,38 @@ static void read_multiple_cb(struct bt_att_chan *chan, uint8_t opcode,
>         for (i = 0; i < data->num_handles; i++)
>                 data->handles[i] = get_le16(pdu + i * 2);
>
> +       handle = data->handles[0];
> +
>         util_debug(server->debug_callback, server->debug_data,
>                         "%s Req - %zu handles, 1st: 0x%04x",
>                         data->opcode == BT_ATT_OP_READ_MULT_REQ ?
>                         "Read Multiple" : "Read Multiple Variable Length",
> -                       data->num_handles, data->handles[0]);
> +                       data->num_handles, handle);
>
> -       attr = gatt_db_get_attribute(server->db, data->handles[0]);
> +       attr = gatt_db_get_attribute(server->db, handle);
>
>         if (!attr) {
>                 ecode = BT_ATT_ERROR_INVALID_HANDLE;
>                 goto error;
>         }
>
> +       ecode = check_permissions(data->server, attr, BT_ATT_PERM_READ |
> +                                               BT_ATT_PERM_READ_AUTHEN |
> +                                               BT_ATT_PERM_READ_ENCRYPT);
> +       if (ecode)
> +               goto error;
> +
>         if (gatt_db_attribute_read(attr, 0, opcode, server->att,
>                                         read_multiple_complete_cb, data))
>                 return;
>
> +       ecode = BT_ATT_ERROR_UNLIKELY;
> +
>  error:
>         if (data)
>                 read_mult_data_free(data);
>
> -       bt_att_chan_send_error_rsp(chan, opcode, 0, ecode);
> +       bt_att_chan_send_error_rsp(chan, opcode, handle, ecode);
>  }
>
>  static bool append_prep_data(struct prep_write_data *prep_data, uint16_t handle,
> --
> 2.26.2.526.g744177e7f7-goog
>


-- 
Luiz Augusto von Dentz
