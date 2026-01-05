Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0EF33987A
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Jan 2026 19:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767640902; cv=none; b=CertdwIcplavA9MFyaVgq+H/8xmiC3+VxPJEbS9ZS8i0/+kldLG6tABLDoz6bM/4zC+Kv8w2idbnkx5Lm8Euu2oQWSzLn0Y2mYSrY1zUIjmkZXdSAnXGEV9SwBSQIIByKkbqrbXBCsfEH/4Rn+RcOdjZGGZ0XuhHd2mm70fYp6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767640902; c=relaxed/simple;
	bh=lcD/d3ZNb14umxwhVn+mXgzFt48wwFQ/OpNkdqBat7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZReggEV0gcPTabCRdw37kVTxxPlvB5FKaYlB054TjzS7oWqVUFod+BBc4UY6WzBbuMLk9av38IMVx3cgrgBXaq7/tq4EngYrzMVbNwFW+Sn2ydYA9gQrMrXpz2YEnhCUPoaSaZhy8e2zHcI2geiIFubb1nBVvDgfnSs86pX5MyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjfBf2Sp; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjfBf2Sp"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-78e6dc6d6d7so3340937b3.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Jan 2026 11:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767640899; x=1768245699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4exfjtlooD29HLGOOr1rfcrYFoscvO4LBNcAmPBeLlE=;
        b=PjfBf2SpH1uJsjSfcpA7kq6I9Rgpw3q3ZHwC8l4VwJQSVilbYXbHz3/wcPqrOQYPnj
         EBA373MwSWpSr30c/EyE1Y7cZwKmD7qP+w0G02IdSegTIZb5CR5kfH3dpMiLZUQ4qN0E
         /fPQyVGG5vzsY3e+hhnr5Q0G9zLLdBVzKhzGnAPdbXNuI2L17k6eEPiaEWv18HZ7TQKC
         1i27hB7xYFbN/gJ/pmA6bwF1TSzIHYWc6ouyVuRP09qdzMXl1Hc+TexftjGrh7oKH8kL
         M/OcsRUAGLrxPb3La+Z27ri3sUwQIS+brv4gHzloa5oCyX0ynw/DSoy+qDVcEo7tp6oG
         Bfnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767640899; x=1768245699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4exfjtlooD29HLGOOr1rfcrYFoscvO4LBNcAmPBeLlE=;
        b=VKr6nxcOoE6E5Ls0LdkGZxKLeu74nDzUbQcN5wWyo5SZCWd4kc0qM1kh8jRTzSH1W3
         tPg7k2cJT7ZBtGzWV5EAqTwc0Wt6fwA9WxlTQSFPtxAtOhFxvhtAZ1nvjWJriPZO0x3c
         9ahdbNhKU84fP22johZdQSmZuU7CbckPYDu/C7/+ItLgutDydLwS9OveS0XosBdPJSXh
         Gpv5Wqb07FWDHrBs1yrW5LRieLMfftHgIRKcJ7v8TBhF9R8ut6kw8dX+rqDbmldVg4j+
         92aoxHE/SHVPdAryFdezQSU+/ecEQbkOx2jj4nHxNSWFiaKqbLEgUmgMvKfp36fZnghg
         Beyg==
X-Gm-Message-State: AOJu0YxqgoptJeluvDbV6SeY2DnQo9k/YIPVZBkAwau9F+lGTfH5TlQ0
	9oLnrKF/1/8/kPD6hE83KJMOGiYAB89EVG0r3Y3NkFixUEV8tfdK8z8KLhxnyhiRo2GqDrjINjU
	3A9FRDt3M/vZGyd6UjwsJZR07RhOUW/E=
X-Gm-Gg: AY/fxX7My+Dc8jh4A6ofn1+etzVraEILIPvWGM+aVnkTs9Ml98Qi7H67MfQ4vY4I/Hx
	x25sNAa1U43OcAKVxMvtBKL3BJbai6TYGS1J5ONV2g893oj/MErdX0XIrCEJ8WF8VwZDWN3YHyX
	vTEcfRtYFTdUZMCxhc5+jDopVN9tZ2Pmo66a9UUI9GiGhAzhhSagukc5EDp4dWIZhHeSND91u7D
	VvttVvbcLDm8mg6X9f3hePYepkEsfNIKolmFfdX/2p/NvFmHoawHOyHMkArvraxIJpChPrwk4mG
	szZxbpSuG2zGHab1VV0UVHFO8l8cY60WEyFUvGOWAaQidlNfdE7oNnx/5GSvTIHavGO+
X-Google-Smtp-Source: AGHT+IF6HeaLW5MjP/lIk6+i2/a+OqIe35Y2yHPD9UpyoAAojACZAytkxrOdvXKFlknQ1cC3baoXAJmLwxrNEv2pJSo=
X-Received: by 2002:a05:690c:4b8b:b0:78f:cd58:5d3a with SMTP id
 00721157ae682-790a8afdbc0mr5406557b3.43.1767640899090; Mon, 05 Jan 2026
 11:21:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105103828.105346-1-mengshi.wu@oss.qualcomm.com> <20260105103828.105346-2-mengshi.wu@oss.qualcomm.com>
In-Reply-To: <20260105103828.105346-2-mengshi.wu@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 5 Jan 2026 14:21:27 -0500
X-Gm-Features: AQt7F2pAHAEn7TCZcrDhNSyoD1ONZ_dqB8qHPK-R9tKi41JxD-6EOwieRAkoCjg
Message-ID: <CABBYNZLC=4gsvTQhWa4RgY_DAhJX0wbzpoHFRgYFCoSR7GquHQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] gatt-client:Implement error handling for
 DB_OUT_OF_SYNC in GATT caching.
To: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com, 
	cheng.jiang@oss.qualcomm.com, chezhou@qti.qualcomm.com, 
	wei.deng@oss.qualcomm.com, yiboz@qti.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mengshi,

On Mon, Jan 5, 2026 at 5:38=E2=80=AFAM Mengshi Wu <mengshi.wu@oss.qualcomm.=
com> wrote:
>
> Implement automatic recovery when ATT_ECODE_DB_OUT_OF_SYNC error is
> received from the remote device. The recovery mechanism:
>
> - Detects DB_OUT_OF_SYNC errors during GATT operations
> - Extracts affected handles from the original request PDU
> - Checks if Service Changed indications overlap with those handles
> - Verifies database consistency using Database Hash characteristic
> - Automatically retries the original request if DB is consistent
> - Automatically retries the original request if handle is not affected
>
> This may prevent some application-level failures when the GATT database
> changes on the remote device.

Some btmon traffic corresponding to the above would be great to see in
the commit description.

>
> Signed-off-by: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
> ---
>  src/shared/gatt-client.c  | 376 +++++++++++++++++++++++++++++++++++++-
>  src/shared/gatt-helpers.c |  16 ++
>  src/shared/gatt-helpers.h |   3 +
>  3 files changed, 392 insertions(+), 3 deletions(-)
>
> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> index f8ebab3fa..22b6c5d1d 100644
> --- a/src/shared/gatt-client.c
> +++ b/src/shared/gatt-client.c
> @@ -41,6 +41,9 @@
>         gatt_log(_client, "[%p] %s:%s() " _format, _client, __FILE__, \
>                 __func__, ## arg)
>
> +#define DB_OUT_OF_SYNC_HOLD_ON true
> +#define DB_OUT_OF_SYNC_GO_ON false

This is a bad start, why do you have to use these defines for a boolean?

>  struct ready_cb {
>         bt_gatt_client_callback_t callback;
>         bt_gatt_client_destroy_func_t destroy;
> @@ -114,6 +117,9 @@ struct bt_gatt_client {
>
>         struct bt_gatt_request *discovery_req;
>         unsigned int mtu_req_id;
> +
> +       /* Pending DB out of sync handling */
> +       struct db_out_of_sync_data *pending_db_sync;
>  };
>
>  struct request {
> @@ -126,8 +132,31 @@ struct request {
>         unsigned int att_id;
>         void *data;
>         void (*destroy)(void *);
> +
> +       /* For DB_OUT_OF_SYNC recovery capability */
> +       uint8_t *sent_pdu;
> +       uint16_t sent_pdu_len;
> +       uint8_t sent_opcode;
> +};
> +
> +struct db_out_of_sync_data {
> +       struct bt_gatt_client *client;
> +       struct request *original_req;
> +       uint8_t opcode;
> +       uint8_t *pdu;
> +       uint16_t pdu_len;
> +       bt_att_response_func_t att_callback;
> +       uint16_t *handles;
> +       uint8_t num_handles;
> +       bool handle_overlaps;
> +       bool svc_changed_arrived;
> +       /* Store original error PDU */
> +       struct bt_att_pdu_error_rsp error_pdu;
>  };

This actually tells me the handling of such functionality shall really
be in att.c not gat-client.c, since the former already does the
handling of things like BT_ATT_ERROR_AUTHENTICATION so it just
reschedules the att_send_op, perhaps we need a callback for the
error_rsp to be processed by gatt-client.c as we handle things like
gatt db hash, etc, there, but there retry logic we shall be able to
use the att.c.

> +static void db_out_of_sync_data_free(struct db_out_of_sync_data *data);
> +static void call_original_callback_with_error(struct db_out_of_sync_data=
 *data);
> +
>  static struct request *request_ref(struct request *req)
>  {
>         __sync_fetch_and_add(&req->ref_count, 1);
> @@ -210,6 +239,7 @@ static void request_unref(void *data)
>                         notify_client_idle(client);
>         }
>
> +       free(req->sent_pdu);
>         free(req);
>  }
>
> @@ -1968,11 +1998,272 @@ fail:
>                 "Failed to initiate service discovery after Service Chang=
ed");
>  }
>
> +static void db_out_of_sync_recover(struct bt_gatt_client *client)
> +{
> +       struct db_out_of_sync_data *pending =3D client->pending_db_sync;
> +       unsigned int new_att_id =3D 0;
> +
> +       assert(pending);
> +
> +       new_att_id =3D bt_att_send(client->att, pending->opcode, pending-=
>pdu,
> +                                pending->pdu_len, pending->att_callback,
> +                                request_ref(pending->original_req),
> +                                request_unref);
> +       if (new_att_id)
> +               pending->original_req->att_id =3D new_att_id;
> +       else
> +               call_original_callback_with_error(pending);
> +       client->pending_db_sync =3D NULL;
> +       db_out_of_sync_data_free(pending);
> +}
> +
> +static void db_hash_check_read_cb(bool success, uint8_t att_ecode,
> +                                 struct bt_gatt_result *result,
> +                                 void *user_data)
> +{
> +       struct bt_gatt_client *client =3D user_data;
> +       struct db_out_of_sync_data *pending =3D client->pending_db_sync;
> +       const uint8_t *local_hash =3D NULL, *remote_hash;
> +       struct gatt_db_attribute *hash_attr =3D NULL;
> +       struct service_changed_op *op;
> +       struct bt_gatt_iter iter;
> +       bt_uuid_t uuid;
> +       uint16_t handle, len;
> +
> +       assert(pending);
> +
> +       if (pending->svc_changed_arrived) {
> +               if (!pending->handle_overlaps) {
> +                       /* No overlap - resend original request */
> +                       DBG(client, "Service changed range doesn't overla=
p");
> +                       db_out_of_sync_recover(client);
> +               }
> +
> +               return;
> +       }
> +
> +       /* If read failed, fall back to full re-discovery */
> +       if (!success)
> +               goto trigger_rediscovery;
> +
> +       if (!result || !bt_gatt_iter_init(&iter, result))
> +               goto trigger_rediscovery;
> +
> +       if (!bt_gatt_iter_next_read_by_type(&iter, &handle,
> +                                       &len, &remote_hash))
> +               goto trigger_rediscovery;
> +
> +       if (len !=3D 16)
> +               goto trigger_rediscovery;
> +
> +       bt_uuid16_create(&uuid, GATT_CHARAC_DB_HASH);
> +       gatt_db_find_by_type(client->db, 0x0001, 0xffff, &uuid,
> +                            get_first_attribute, &hash_attr);
> +
> +       if (hash_attr) {
> +               gatt_db_attribute_read(hash_attr, 0, BT_ATT_OP_READ_REQ, =
NULL,
> +                                      db_hash_read_value_cb, &local_hash=
);
> +       }
> +
> +       /* If hashes match, no need to trigger re-discovery */
> +       if (local_hash && !memcmp(local_hash, remote_hash, 16)) {
> +               db_out_of_sync_recover(client);
> +               return;
> +       }
> +
> +       DBG(client, "DB Hash mismatch: triggering re-discovery");
> +
> +trigger_rediscovery:
> +       call_original_callback_with_error(pending);
> +       client->pending_db_sync =3D NULL;
> +       db_out_of_sync_data_free(pending);
> +
> +       process_service_changed(client, 0x0001, 0xffff);
> +}
> +
> +static void db_out_of_sync_data_free(struct db_out_of_sync_data *data)
> +{
> +       if (!data)
> +               return;
> +
> +       if (data->original_req)
> +               request_unref(data->original_req);
> +
> +       free(data->pdu);
> +       free(data->handles);
> +       free(data);
> +}
> +
> +static bool check_handle_overlap(uint16_t *handles, uint8_t num_handles,
> +                                uint16_t start, uint16_t end)
> +{
> +       uint8_t i;
> +
> +       if (!handles)
> +               return true;
> +
> +       for (i =3D 0; i < num_handles; i++) {
> +               if (handles[i] >=3D start && handles[i] <=3D end)
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +
> +static uint8_t extract_handles_from_pdu(uint8_t opcode, const uint8_t *p=
du,
> +                                       uint16_t pdu_len, uint16_t **hand=
les)
> +{
> +       uint8_t num_handles =3D 0;
> +       uint16_t *handle_array;
> +       uint16_t i;
> +
> +       switch (opcode) {
> +       case BT_ATT_OP_READ_REQ:
> +       case BT_ATT_OP_READ_BLOB_REQ:
> +       case BT_ATT_OP_WRITE_REQ:
> +       case BT_ATT_OP_WRITE_CMD:
> +       case BT_ATT_OP_PREP_WRITE_REQ:
> +               /* Single handle at offset 0 */
> +               num_handles =3D 1;
> +               handle_array =3D malloc(sizeof(uint16_t));
> +               if (handle_array)
> +                       handle_array[0] =3D get_le16(pdu);
> +               break;
> +
> +       case BT_ATT_OP_READ_MULT_REQ:
> +       case BT_ATT_OP_READ_MULT_VL_REQ:
> +               /* Multiple handles, 2 bytes each */
> +               num_handles =3D pdu_len / 2;
> +               handle_array =3D malloc(num_handles * sizeof(uint16_t));
> +               if (handle_array) {
> +                       for (i =3D 0; i < num_handles; i++)
> +                               handle_array[i] =3D get_le16(pdu + (i * 2=
));
> +               }
> +               break;
> +
> +       default:
> +               return 0;
> +       }
> +
> +       if (!handle_array)
> +               return 0;
> +
> +       *handles =3D handle_array;
> +       return num_handles;
> +}
> +
> +static void call_original_callback_with_error(struct db_out_of_sync_data=
 *data)
> +{
> +       struct request *req =3D data->original_req;
> +
> +       if (!req || !data->att_callback)
> +               return;
> +
> +       data->att_callback(BT_ATT_OP_ERROR_RSP, &(data->error_pdu),
> +                          sizeof(struct bt_att_pdu_error_rsp), req);
> +}
> +
> +static bool process_db_out_of_sync(struct bt_gatt_client *client,
> +                                  uint8_t att_ecode, const void *error_p=
du,
> +                                  struct request *req,
> +                                  bt_att_response_func_t callback)
> +{
> +       struct db_out_of_sync_data *pending;
> +       struct service_changed_op *op;
> +       struct bt_gatt_request *gatt_req_op =3D client->discovery_req;
> +       const struct bt_att_pdu_error_rsp *epdu =3D error_pdu;
> +       bt_uuid_t uuid;
> +       unsigned int new_att_id =3D 0;
> +
> +       if (att_ecode !=3D BT_ATT_ERROR_DB_OUT_OF_SYNC)
> +               return DB_OUT_OF_SYNC_GO_ON;
> +
> +       /* Check if we already have a pending operation */
> +       if (client->pending_db_sync)
> +               return DB_OUT_OF_SYNC_GO_ON;
> +
> +       /* Only handle if we have the necessary request info */
> +       if (!req || !req->sent_pdu || !callback)
> +               goto trigger_rediscovery;
> +
> +       /* Create pending structure */
> +       pending =3D new0(struct db_out_of_sync_data, 1);
> +       if (!pending)
> +               goto trigger_rediscovery;
> +
> +       pending->client =3D client;
> +       pending->original_req =3D request_ref(req);
> +       pending->att_callback =3D callback;
> +       pending->opcode =3D req->sent_opcode;
> +       pending->pdu_len =3D req->sent_pdu_len;
> +
> +       /* Copy PDU */
> +       pending->pdu =3D malloc(pending->pdu_len);
> +       if (!pending->pdu) {
> +               db_out_of_sync_data_free(pending);
> +               goto trigger_rediscovery;
> +       }
> +       memcpy(pending->pdu, req->sent_pdu, pending->pdu_len);
> +
> +       /* Store original error PDU */
> +       memcpy(&(pending->error_pdu), error_pdu,
> +              sizeof(struct bt_att_pdu_error_rsp));
> +
> +       /* Extract handles from PDU */
> +       pending->num_handles =3D
> +               extract_handles_from_pdu(pending->opcode, pending->pdu,
> +                                        pending->pdu_len, &pending->hand=
les);

This doesn't sound right, the error response bt_att_pdu_error_rsp
already contains the affected handle, why not use it instead of trying
to extract from the request?

> +       if (!pending->num_handles) {
> +               db_out_of_sync_data_free(pending);
> +               goto trigger_rediscovery;
> +       }
> +
> +       /* Store pending operation */
> +       client->pending_db_sync =3D pending;
> +
> +       /* Initiate hash read */
> +       bt_uuid16_create(&uuid, GATT_CHARAC_DB_HASH);
> +
> +       if (bt_gatt_read_by_type(client->att, 0x0001, 0xffff, &uuid,
> +                                db_hash_check_read_cb, client, NULL)) {
> +               return DB_OUT_OF_SYNC_HOLD_ON;
> +       }
> +
> +       client->pending_db_sync =3D NULL;
> +       db_out_of_sync_data_free(pending);
> +
> +trigger_rediscovery:
> +
> +       if (client->in_svc_chngd) {
> +               if (client->discovery_req && req && req->sent_pdu && call=
back &&
> +                   (epdu->handle !=3D 0) && gatt_req_op &&
> +                   (bt_gatt_request_get_start_handle(gatt_req_op) >
> +                            epdu->handle ||
> +                    bt_gatt_request_get_end_handle(gatt_req_op) <
> +                            epdu->handle)) {
> +                       new_att_id =3D bt_att_send(client->att, req->sent=
_opcode,
> +                                                req->sent_pdu,
> +                                                req->sent_pdu_len, callb=
ack,
> +                                                request_ref(req),
> +                                                request_unref);
> +                       if (new_att_id) {
> +                               req->att_id =3D new_att_id;
> +                               return DB_OUT_OF_SYNC_HOLD_ON;
> +                       }
> +               }
> +               return DB_OUT_OF_SYNC_GO_ON;
> +       }
> +
> +       process_service_changed(client, 0x0001, 0xffff);
> +       return DB_OUT_OF_SYNC_GO_ON;
> +}
> +
>  static void service_changed_cb(uint16_t value_handle, const uint8_t *val=
ue,
>                                         uint16_t length, void *user_data)
>  {
>         struct bt_gatt_client *client =3D user_data;
>         struct service_changed_op *op;
> +       struct db_out_of_sync_data *pending;
>         uint16_t start, end;
>
>         if (length !=3D 4)
> @@ -1990,6 +2281,14 @@ static void service_changed_cb(uint16_t value_hand=
le, const uint8_t *value,
>         DBG(client, "Service Changed received - start: 0x%04x end: 0x%04x=
",
>                         start, end);
>
> +       /* Check if there's a pending DB out of sync operation */
> +       pending =3D client->pending_db_sync;
> +       if (pending) {
> +               pending->svc_changed_arrived =3D true;
> +               pending->handle_overlaps =3D check_handle_overlap(pending=
->handles,
> +                                       pending->num_handles, start, end)=
;
> +       }
> +
>         if (!client->in_svc_chngd) {
>                 process_service_changed(client, start, end);
>                 return;
> @@ -2332,6 +2631,10 @@ static void att_disconnect_cb(int err, void *user_=
data)
>
>         client->disc_id =3D 0;
>
> +       /* Cleanup pending DB out of sync operation */
> +       db_out_of_sync_data_free(client->pending_db_sync);
> +       client->pending_db_sync =3D NULL;
> +
>         bt_att_unref(client->att);
>         client->att =3D NULL;
>
> @@ -2712,10 +3015,15 @@ static void read_multiple_cb(uint8_t opcode, cons=
t void *pdu, uint16_t length,
>                         (!pdu && length)) {
>                 success =3D false;
>
> -               if (opcode =3D=3D BT_ATT_OP_ERROR_RSP)
> +               if (opcode =3D=3D BT_ATT_OP_ERROR_RSP) {
>                         att_ecode =3D process_error(pdu, length);
> -               else
> +                       if (process_db_out_of_sync(req->client, att_ecode=
,
> +                                                  pdu, req,
> +                                                  read_multiple_cb))
> +                               return;
> +               } else {
>                         att_ecode =3D 0;
> +               }
>
>                 pdu =3D NULL;
>                 length =3D 0;
> @@ -2799,6 +3107,13 @@ unsigned int bt_gatt_client_read_multiple(struct b=
t_gatt_client *client,
>                 BT_GATT_CHRC_CLI_FEAT_EATT ? BT_ATT_OP_READ_MULT_VL_REQ :
>                 BT_ATT_OP_READ_MULT_REQ;
>
> +       /* Store PDU for potential resend on DB_OUT_OF_SYNC */
> +       req->sent_opcode =3D opcode;
> +       req->sent_pdu_len =3D num_handles * 2;
> +       req->sent_pdu =3D malloc(req->sent_pdu_len);
> +       if (req->sent_pdu)
> +               memcpy(req->sent_pdu, pdu, req->sent_pdu_len);
> +
>         req->att_id =3D bt_att_send(client->att, opcode, pdu, num_handles=
 * 2,
>                                                         read_multiple_cb,=
 req,
>                                                         request_unref);
> @@ -2867,6 +3182,10 @@ static void read_long_cb(uint8_t opcode, const voi=
d *pdu,
>         if (opcode =3D=3D BT_ATT_OP_ERROR_RSP) {
>                 success =3D false;
>                 att_ecode =3D process_error(pdu, length);
> +               if (process_db_out_of_sync(req->client, att_ecode,
> +                                          pdu, req,
> +                                          read_long_cb))
> +                       return;
>                 goto done;
>         }
>
> @@ -2975,6 +3294,13 @@ unsigned int bt_gatt_client_read_long_value(struct=
 bt_gatt_client *client,
>                 att_op =3D BT_ATT_OP_READ_REQ;
>         }
>
> +       /* Store PDU for potential resend on DB_OUT_OF_SYNC */
> +       req->sent_opcode =3D att_op;
> +       req->sent_pdu_len =3D pdu_len;
> +       req->sent_pdu =3D malloc(req->sent_pdu_len);
> +       if (req->sent_pdu)
> +               memcpy(req->sent_pdu, pdu, req->sent_pdu_len);
> +
>         req->att_id =3D bt_att_send(client->att, att_op, pdu, pdu_len,
>                                         read_long_cb, req, request_unref)=
;
>
> @@ -3053,6 +3379,9 @@ static void write_cb(uint8_t opcode, const void *pd=
u, uint16_t length,
>         if (opcode =3D=3D BT_ATT_OP_ERROR_RSP) {
>                 success =3D false;
>                 att_ecode =3D process_error(pdu, length);
> +               if (process_db_out_of_sync(req->client, att_ecode,
> +                                          pdu, req, write_cb))
> +                       return;
>                 goto done;
>         }
>
> @@ -3096,6 +3425,13 @@ unsigned int bt_gatt_client_write_value(struct bt_=
gatt_client *client,
>         put_le16(value_handle, pdu);
>         memcpy(pdu + 2, value, length);
>
> +       /* Store PDU for potential resend on DB_OUT_OF_SYNC */
> +       req->sent_opcode =3D BT_ATT_OP_WRITE_REQ;
> +       req->sent_pdu_len =3D 2 + length;
> +       req->sent_pdu =3D malloc(req->sent_pdu_len);
> +       if (req->sent_pdu)
> +               memcpy(req->sent_pdu, pdu, req->sent_pdu_len);
> +
>         req->att_id =3D bt_att_send(client->att, BT_ATT_OP_WRITE_REQ,
>                                                         pdu, 2 + length,
>                                                         write_cb, req,
> @@ -3216,6 +3552,10 @@ static void execute_write_cb(uint8_t opcode, const=
 void *pdu, uint16_t length,
>         if (opcode =3D=3D BT_ATT_OP_ERROR_RSP) {
>                 success =3D false;
>                 att_ecode =3D process_error(pdu, length);
> +               if (process_db_out_of_sync(req->client, att_ecode,
> +                                          pdu, req,
> +                                          execute_write_cb))
> +                       return;
>         } else if (opcode !=3D BT_ATT_OP_EXEC_WRITE_RSP || pdu || length)
>                 success =3D false;
>
> @@ -3281,6 +3621,10 @@ static void prepare_write_cb(uint8_t opcode, const=
 void *pdu, uint16_t length,
>         if (opcode =3D=3D BT_ATT_OP_ERROR_RSP) {
>                 success =3D false;
>                 att_ecode =3D process_error(pdu, length);
> +               if (process_db_out_of_sync(req->client, att_ecode,
> +                                          pdu, req,
> +                                          prepare_write_cb))
> +                       return;
>                 goto done;
>         }
>
> @@ -3401,11 +3745,15 @@ unsigned int bt_gatt_client_write_long_value(stru=
ct bt_gatt_client *client,
>         put_le16(offset, pdu + 2);
>         memcpy(pdu + 4, op->value, op->cur_length);
>
> +       /* Store PDU for potential resend on DB_OUT_OF_SYNC */
> +       req->sent_opcode =3D BT_ATT_OP_PREP_WRITE_REQ;
> +       req->sent_pdu_len =3D op->cur_length + 4;
> +       req->sent_pdu =3D pdu;
> +
>         req->att_id =3D bt_att_send(client->att, BT_ATT_OP_PREP_WRITE_REQ=
,
>                                                         pdu, op->cur_leng=
th + 4,
>                                                         prepare_write_cb,=
 req,
>                                                         request_unref);
> -       free(pdu);
>
>         if (!req->att_id) {
>                 op->destroy =3D NULL;
> @@ -3450,6 +3798,10 @@ static void prep_write_cb(uint8_t opcode, const vo=
id *pdu, uint16_t length,
>                 success =3D false;
>                 reliable_error =3D false;
>                 att_ecode =3D process_error(pdu, length);
> +               if (process_db_out_of_sync(req->client, att_ecode,
> +                                          pdu, req,
> +                                          prep_write_cb))
> +                       return;
>                 goto done;
>         }
>
> @@ -3566,6 +3918,13 @@ unsigned int bt_gatt_client_prepare_write(struct b=
t_gatt_client *client,
>         memcpy(op->pdu, pdu, length);
>         op->pdu_len =3D length;
>
> +       /* Store PDU for potential resend on DB_OUT_OF_SYNC */
> +       req->sent_opcode =3D BT_ATT_OP_PREP_WRITE_REQ;
> +       req->sent_pdu_len =3D length;
> +       req->sent_pdu =3D malloc(req->sent_pdu_len);
> +       if (req->sent_pdu)
> +               memcpy(req->sent_pdu, pdu, req->sent_pdu_len);
> +
>         /*
>          * Now we are ready to send command
>          * Note that request_unref will be done on write execute
> @@ -3600,6 +3959,10 @@ static void exec_write_cb(uint8_t opcode, const vo=
id *pdu, uint16_t length,
>         if (opcode =3D=3D BT_ATT_OP_ERROR_RSP) {
>                 success =3D false;
>                 att_ecode =3D process_error(pdu, length);
> +               if (process_db_out_of_sync(req->client, att_ecode,
> +                                          pdu, req,
> +                                          exec_write_cb))
> +                       return;
>                 goto done;
>         }
>
> @@ -3659,6 +4022,13 @@ unsigned int bt_gatt_client_write_execute(struct b=
t_gatt_client *client,
>         req->data =3D op;
>         req->destroy =3D destroy_write_op;
>
> +       /* Store PDU for potential resend on DB_OUT_OF_SYNC */
> +       req->sent_opcode =3D BT_ATT_OP_EXEC_WRITE_REQ;
> +       req->sent_pdu_len =3D sizeof(pdu);
> +       req->sent_pdu =3D malloc(req->sent_pdu_len);
> +       if (req->sent_pdu)
> +               memcpy(req->sent_pdu, &pdu, req->sent_pdu_len);


This is sort of repeated in all requests thus why I think we are
better off doing it in att.c, so we don't have to keep calling
process_db_out_of_sync and then copy the requests which is actually a
duplicating what att.c is doing with att_send_op.

>         req->att_id =3D bt_att_send(client->att, BT_ATT_OP_EXEC_WRITE_REQ=
, &pdu,
>                                                 sizeof(pdu), exec_write_c=
b,
>                                                 req, request_unref);
> diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
> index c1cbbdc91..e3a6548c4 100644
> --- a/src/shared/gatt-helpers.c
> +++ b/src/shared/gatt-helpers.c
> @@ -790,6 +790,22 @@ done:
>         discovery_op_complete(op, success, att_ecode);
>  }
>
> +uint16_t bt_gatt_request_get_start_handle(struct bt_gatt_request *reques=
t)
> +{
> +       if (!request)
> +               return 0;
> +
> +       return request->start_handle;
> +}
> +
> +uint16_t bt_gatt_request_get_end_handle(struct bt_gatt_request *request)
> +{
> +       if (!request)
> +               return 0;
> +
> +       return request->end_handle;
> +}
> +
>  static struct bt_gatt_request *discover_services(struct bt_att *att,
>                                         bt_uuid_t *uuid,
>                                         uint16_t start, uint16_t end,
> diff --git a/src/shared/gatt-helpers.h b/src/shared/gatt-helpers.h
> index 7623862e9..7a51ec619 100644
> --- a/src/shared/gatt-helpers.h
> +++ b/src/shared/gatt-helpers.h
> @@ -101,3 +101,6 @@ bool bt_gatt_read_by_type(struct bt_att *att, uint16_=
t start, uint16_t end,
>                                         bt_gatt_request_callback_t callba=
ck,
>                                         void *user_data,
>                                         bt_gatt_destroy_func_t destroy);
> +
> +uint16_t bt_gatt_request_get_end_handle(struct bt_gatt_request *request)=
;
> +uint16_t bt_gatt_request_get_start_handle(struct bt_gatt_request *reques=
t);
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
