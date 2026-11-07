Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794084848;
	b=0yxeZfWX1Y3Epj1PcIHKL3GeHNFnaIcSXyicROlV5NQUhv9TP7HZt9H9kryq+n4qkDyt
	 4xFRxN4dMzUbQd6HVy+zIfWjK03z9Hy5pvW9vPyy0fbXrwUW2BHN1/A1rPdXAiU5wfdPp
	 iGSu5Z7yX3UhGjp8aGdrfi5S9h+utTaNeJL3tGdVsVfIqySze9S3zzCVzBagXwKLI4sGb
	 w6K1G0KnqESQlxnr/mtWccxFs+q2zbXXW9IWt4szU9UGqJnXPomK63xyJM0mywc0yazLd
	 RkxhkL9z6PrQhLCw+sotYnCZiooQdZf9dw7a+ib5ypGZr0m10mOHiNZB14qsngTZSJg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794084848;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=UB4Ffls1RRfwNR5EJwlsLgbhjNmWmCcC6pPDJNyOpAw=;
	b=w39ihjhOesWQ80Bqz+H1ts2kOZdVFm66uVYIc4EeRbcyIPbwuxar6JB68ltSK8aX75iO
	 1Tw/ACIRzDQcgH3eHjRjtgxDYZU/Qke4Brj5sbj3Ao8bsr81m3xE0jLhjy5Z7bzmzruEB
	 6HQ1fyJ/qmcZ0K8j0SFvpBNdjCJL/nHkzQgLHRWasc6P2ofa2MTr7ijzGw7cyJ7FksW2N
	 GS9QikUS5Hyt/CYLjS7kvh/K21vn31PjCYkg9ulcsTgzi/WSJZY245L/1CS4eMDC0oS89
	 LiyHIgQq6hYndTDQBhVZ8mOX5R3D/242t+UT/rqSBhmCbbZo5jYGb05RG20Aj/vxUOQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RF37HKxX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.171
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89430606A326
	for <linux-bluetooth@vger.kernel.org>; Sat,  7 Nov 2026 20:54:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89430606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RF37HKxX
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8b335ef6441so12794227b3.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 07 Nov 2026 12:54:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794084846; cv=none;
        d=google.com; s=arc-20260327;
        b=gEhA8EDCzL86UERWburh6UGyPvTwUpBylQUWJ1E6mCGOOk/u3a9weZOear0eb8aYF2
         Pu0hFGrxHw+78q7Nm0Ri7zxRXEssSrxvyfGpIY1jcqv1oOnRbliaYNfet6unClPL5rS+
         f26pc4oFGHWsgJFwnXLb55caWRG5DKUiysvXIg2Hq7NGOg8a0EjfImEtRHId1IrYPic+
         0X+ZD1/XWwK7ineIsWxoYM2C267uZVf96QDHv0seJXMjbYBrCMiD+3I22rawAOyGUD3d
         et8IQYYBhIWpjXOXH9byg36XO+94w0IZgNT1zj5NV7jsxBqSgS7GL7vkTQJQJEVDZCcL
         sZcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UB4Ffls1RRfwNR5EJwlsLgbhjNmWmCcC6pPDJNyOpAw=;
        fh=LUWgbrUuhMtahyXO6QT454ErJE9yEFx36d0SI3GxXhQ=;
        b=fioPJKcSygEgNh4UoQY2de064wA/V2uIywNpLBANi1xxsNg2ImQ7Q1TTALisfC0qxf
         EqfoeEKkrt9U6fV5zMTaTE4sqlgeSb/ZFuRRkd8poVJwGRMDx9u45reCWp+9KieyPRr/
         v4EYm9vHBDHPuYWcdFD8ehZHqxC7KUkxvo9z1l69ZaBFTzI8WQUsaYoi+jJv3yfVMdXp
         3x5+/CVEWeYryckUsjvjh3f8L5rErXTqRDakmMCfztcCCcAE7VEnDsOKwgdJPzz+NNtY
         JxLAww+bWLhACC+Eg4oVRLmfZTT17SymXqNFRI5agm+sjLDZUdx0xG/tbv4AaErGi0OT
         lI6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794084846; x=1794689646; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UB4Ffls1RRfwNR5EJwlsLgbhjNmWmCcC6pPDJNyOpAw=;
        b=RF37HKxXc8dkjtMutUnP/DcqMX1rO2xQdDWERv6nhHfiCV6ZUZico6LHYqNL8dMLfT
         dxKcTIysk1+nK7AOsSMKqRmN4Qhv+6IMhde3/E/Hqt7sdkMRT5OdnJRQoHgKxyDgQ7T9
         VUkAL860o4cAb9K8MGKO7MmukyyM55jJeEVBzKhEKhQKpuOLrClzJJMhrjewtiIrg7Aj
         X7Z6S4PHo3X9FZztd9j2zsCRWKFvMlulQPnNubcnHL+zUuVGPGfbwf5qYyPVoOlpt6zA
         cef4z7U1rhgYYte8Rf9LfAGfkJ8RZUxqpmgt1tIUM6+184B0s1pfVrdRnpYxjE/YJRx+
         /qeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794084846; x=1794689646;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UB4Ffls1RRfwNR5EJwlsLgbhjNmWmCcC6pPDJNyOpAw=;
        b=UiIf0XFXMeVQBfuuMq68+NKgCR7oxhnPk+KBg6k/Bmu2cM9+ApyKbTKmTMeUaKB+Uz
         8zhGCwkbpWom+eb/FK+ptjKCcY2JwIxwI1AXotcRWNFdk9yFPbU2tHu77fQxhgmcboOc
         cfUbSACfJxjyK6TCb/T5PfP7vMORco2eifdAOXaCRYEOkJCRc6l/YEc3UMuKlaNTbVHD
         2fmYGdtd/JjwKXlrfdMchXe3eOXzL24sxDS3OgK6l4fXFqF6TJ+D0EKVPm3FcYPj+ob0
         LBLiozpF7HbO0hY30IH7pG55dn0RRUpI6L3AeMxMnQHJK26u/OOVZKvmteAdh+42wTgq
         K5YQ==
X-Gm-Message-State: APuU4Z9nwV8BIrn09uucK3lDZjBKLziqWSOpZOdL0ZYlpvHCSap2amt7
	rosVARJpDQj/bpJk5Oqhj7p7+h9ibW6SXVhSyMKMs4/O4x+oUsPHIRqXTw202zMCueBSVss164F
	OYC6+bmqjzak/77GSOX4/+gkdLOgFBKs=
X-Gm-Gg: AYBFou36A6H8YO5VnZk2gm6Zzc9N2WeluiRCv+sc2J+yTMrTF9IiFtH+yoE4CstDRTe
	o3zfFiPb3EpkDY2SIot9WSkiuyD15u9q4uwM/C2AMVue12yhRwNL5Hs3cr3EJzbTxFE2w0fDMXh
	vma03PtU4WEzC/Y8y1zg7xMJh0op2wxJwBO1ZRVm5kY61jkW2DzJSfhpn/aFwN9zxBiNh5/PGWv
	4534+9au4rUJWWODSOQ/QVJHPzf3DusLJf/Nl0QyGW+R7R0vuPSHQ0dlsdOAFBEscbJRHUpUoN7
	29hTppsHZ7l78XoS7w9RwrPhZq96QGc9Ht3dDm6M6e6uI8yDbZXEF9LJUM3bPRAagrn0xpMGU4Y
	Hoa9SwRD8uf9STFD7VovMMwPC+MK7EicFKfBuKwM5qVuZlEHlf+hoic1PcCZX876hSWeHCmWHYL
	Z49w4vMPIlJOVx6dtPcrWK8++4ORXQ05gUXCmeJ23QRKTYBV6+zm2yOlgg
X-Received: by 2002:a05:690c:a902:b0:8a4:be24:f233 with SMTP id
 00721157ae682-8b341ad10e4mr27819697b3.46.1794084846256; Sat, 07 Nov 2026
 12:54:06 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261107065854.2147141-1-cochcoder@proton.me>
In-Reply-To: <20261107065854.2147141-1-cochcoder@proton.me>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Sat, 7 Nov 2026 15:53:54 -0500
X-Gm-Features: AclHuK_HckUkHmdrM08TzuvwdhfpdSIf1dc10ESBqKKIVoHMoUfm2jy5Vygoklk
Message-ID: <CABBYNZ+UJ16buyae82cO_j7jmvYjcZ4ivJ=jVjKE2JWUOALRcw@mail.gmail.com>
Subject: Re: [PATCH] shared/gatt-client: Cancel discovery read-by-type requests
To: Kyle Pepper <cochcoder@proton.me>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kyle,

On Sat, Nov 7, 2026 at 1:59=E2=80=AFAM Kyle Pepper <cochcoder@proton.me> wr=
ote:
>
> Server Features and Database Hash reads outlive the client when it is
> released during discovery. Their destroy callback then dereferences the
> freed client while unregistering the discovery database callback.
>
> Retain cancellable request references for both reads and release them
> on completion or client cancellation. Preserve the boolean helper for
> callers that do not retain requests. Add native ATT teardown regressions
> for queued and pending reads, including repeated cancellation.
>
> Fixes: 76d63c91b27a ("shared/gatt-client: Add support for EATT features")
> Fixes: 0f67d5e2f19f ("shared/gatt-client: Read database hash if available=
")
> Assisted-by: Codex:gpt-6
> ---
>  src/shared/gatt-client.c  | 32 +++++++++++++++++++++---
>  src/shared/gatt-helpers.c | 26 +++++++++++++++++---
>  src/shared/gatt-helpers.h |  7 ++++++
>  unit/test-gatt.c          | 52 ++++++++++++++++++++++++++++++++++++++-
>  4 files changed, 108 insertions(+), 9 deletions(-)
>
> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> index 836a59a..d283376 100644
> --- a/src/shared/gatt-client.c
> +++ b/src/shared/gatt-client.c
> @@ -105,6 +105,8 @@ struct bt_gatt_client {
>         unsigned int next_request_id;
>
>         struct bt_gatt_request *discovery_req;
> +       struct bt_gatt_request *server_feat_req;
> +       struct bt_gatt_request *db_hash_req;

We probably need a queue to store these requests and then cancel them
or perhaps reuse the pending_requests logic, since they pending
request just submitted internally but Id still argue they are pending.
And lets have each of them fixed separatly so if we need to revert one
we don't have to revert both fixes, and the same applies to tests.

>         unsigned int mtu_req_id;
>
>         /* Pending retry operation for DB out of sync handling */
> @@ -1472,6 +1474,9 @@ static void db_hash_read_cb(bool success, uint8_t a=
tt_ecode,
>         uint16_t len, handle;
>         struct bt_gatt_iter iter;
>
> +       bt_gatt_request_unref(client->db_hash_req);
> +       client->db_hash_req =3D NULL;
> +
>         if (!success)
>                 goto discover;
>
> @@ -1542,10 +1547,12 @@ static bool read_db_hash(struct discovery_op *op
>         if (!op->hash)
>                 return false;
>
> -       if (!bt_gatt_read_by_type(client->att, 0x0001, 0xffff, &uuid,
> +       client->db_hash_req =3D bt_gatt_read_by_type_request(client->att,
> +                                                       0x0001, 0xffff, &=
uuid,
>                                                         db_hash_read_cb,
>                                                         discovery_op_ref(=
op),
> -                                                       discovery_op_unre=
f)) {
> +                                                       discovery_op_unre=
f);
> +       if (!client->db_hash_req) {
>                 discovery_op_unref(op);
>                 return false;
>         }
> @@ -1562,6 +1569,9 @@ static void db_server_feat_read(bool success, uint8=
_t att_ecode,
>         uint16_t len, handle;
>         struct bt_gatt_iter iter;
>
> +       bt_gatt_request_unref(client->server_feat_req);
> +       client->server_feat_req =3D NULL;
> +
>         if (!result)
>                 return;
>
> @@ -1606,10 +1616,12 @@ static void read_server_feat(struct discovery_op =
*op)
>                         return;
>         }
>
> -       if (!bt_gatt_read_by_type(client->att, 0x0001, 0xffff, &uuid,
> +       client->server_feat_req =3D bt_gatt_read_by_type_request(client->=
att,
> +                                                       0x0001, 0xffff, &=
uuid,
>                                                         db_server_feat_re=
ad,
>                                                         discovery_op_ref(=
op),
> -                                                       discovery_op_unre=
f))
> +                                                       discovery_op_unre=
f);
> +       if (!client->server_feat_req)
>                 discovery_op_unref(op);
>  }
>
> @@ -2841,6 +2853,15 @@ static void cancel_pending(void *data)
>         cancel_request(data);
>  }
>
> +static void cancel_gatt_request(struct bt_gatt_request **req)
> +{
> +       struct bt_gatt_request *pending =3D *req;
> +
> +       *req =3D NULL;
> +       bt_gatt_request_cancel(pending);
> +       bt_gatt_request_unref(pending);
> +}
> +
>  bool bt_gatt_client_cancel_all(struct bt_gatt_client *client)
>  {
>         if (!client || !client->att)
> @@ -2848,6 +2869,9 @@ bool bt_gatt_client_cancel_all(struct bt_gatt_clien=
t *client)
>
>         queue_remove_all(client->pending_requests, NULL, NULL, cancel_pen=
ding);
>
> +       cancel_gatt_request(&client->server_feat_req);
> +       cancel_gatt_request(&client->db_hash_req);
> +
>         if (client->discovery_req) {
>                 bt_gatt_request_cancel(client->discovery_req);
>                 bt_gatt_request_unref(client->discovery_req);
> diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
> index b3d5d8f..f33d387 100644
> --- a/src/shared/gatt-helpers.c
> +++ b/src/shared/gatt-helpers.c
> @@ -1356,7 +1356,8 @@ done:
>         discovery_op_complete(op, success, att_ecode);
>  }
>
> -bool bt_gatt_read_by_type(struct bt_att *att, uint16_t start, uint16_t e=
nd,
> +struct bt_gatt_request *bt_gatt_read_by_type_request(struct bt_att *att,
> +                                       uint16_t start, uint16_t end,
>                                         const bt_uuid_t *uuid,
>                                         bt_gatt_request_callback_t callba=
ck,
>                                         void *user_data,
> @@ -1366,7 +1367,7 @@ bool bt_gatt_read_by_type(struct bt_att *att, uint1=
6_t start, uint16_t end,
>         uint8_t pdu[4 + get_uuid_len(uuid)];
>
>         if (!att || !uuid || uuid->type =3D=3D BT_UUID_UNSPEC)
> -               return false;
> +               return NULL;
>
>         op =3D new0(struct bt_gatt_request, 1);
>         op->att =3D att;
> @@ -1386,10 +1387,27 @@ bool bt_gatt_read_by_type(struct bt_att *att, uin=
t16_t start, uint16_t end,
>                                                 bt_gatt_request_ref(op),
>                                                 async_req_unref);
>         if (op->id)
> -               return true;
> +               return bt_gatt_request_ref(op);
>
>         free(op);
> -       return false;
> +       return NULL;
> +}
> +
> +bool bt_gatt_read_by_type(struct bt_att *att, uint16_t start, uint16_t e=
nd,
> +                                       const bt_uuid_t *uuid,
> +                                       bt_gatt_request_callback_t callba=
ck,
> +                                       void *user_data,
> +                                       bt_gatt_destroy_func_t destroy)
> +{
> +       struct bt_gatt_request *req;
> +
> +       req =3D bt_gatt_read_by_type_request(att, start, end, uuid, callb=
ack,
> +                                                       user_data, destro=
y);
> +       if (!req)
> +               return false;
> +
> +       bt_gatt_request_unref(req);
> +       return true;
>  }
>
>  static void discover_descs_cb(uint8_t opcode, const void *pdu,
> diff --git a/src/shared/gatt-helpers.h b/src/shared/gatt-helpers.h
> index 2bf5aad..528ef21 100644
> --- a/src/shared/gatt-helpers.h
> +++ b/src/shared/gatt-helpers.h
> @@ -102,5 +102,12 @@ bool bt_gatt_read_by_type(struct bt_att *att, uint16=
_t start, uint16_t end,
>                                         void *user_data,
>                                         bt_gatt_destroy_func_t destroy);
>
> +struct bt_gatt_request *bt_gatt_read_by_type_request(struct bt_att *att,
> +                                       uint16_t start, uint16_t end,
> +                                       const bt_uuid_t *uuid,
> +                                       bt_gatt_request_callback_t callba=
ck,
> +                                       void *user_data,
> +                                       bt_gatt_destroy_func_t destroy);
> +
>  uint16_t bt_gatt_req_get_end_handle(struct bt_gatt_request *req);
>  uint16_t bt_gatt_req_get_start_handle(struct bt_gatt_request *req);
> diff --git a/unit/test-gatt.c b/unit/test-gatt.c
> index 6d6d0c7..d206a44 100644
> --- a/unit/test-gatt.c
> +++ b/unit/test-gatt.c
> @@ -42,6 +42,7 @@ struct test_pdu {
>  enum context_type {
>         ATT,
>         CLIENT,
> +       CLIENT_CACHED,
>         SERVER
>  };
>
> @@ -680,7 +681,13 @@ static struct context *create_context(uint16_t mtu, =
gconstpointer data)
>                                                 "bt_gatt_server:", NULL);
>                 break;
>         case CLIENT:
> -               context->client_db =3D gatt_db_new();
> +       case CLIENT_CACHED:
> +               if (test_data->context_type =3D=3D CLIENT_CACHED)
> +                       context->client_db =3D
> +                                       gatt_db_clone(test_data->source_d=
b);
> +               else
> +                       context->client_db =3D gatt_db_new();
> +
>                 g_assert(context->client_db);
>
>                 context->client =3D bt_gatt_client_new(context->client_db=
,
> @@ -1968,6 +1975,22 @@ static void test_client(gconstpointer data)
>         create_context(512, data);
>  }
>
> +static void test_client_cancel(gconstpointer data)
> +{
> +       struct context *context =3D create_context(23, data);
> +
> +       context_quit(context);
> +}
> +
> +static void test_client_cancel_all(gconstpointer data)
> +{
> +       struct context *context =3D create_context(23, data);
> +
> +       g_assert(bt_gatt_client_cancel_all(context->client));
> +       g_assert(bt_gatt_client_cancel_all(context->client));
> +       context_quit(context);
> +}
> +
>  static void test_server(gconstpointer data)
>  {
>         struct context *context =3D create_context(512, data);
> @@ -2480,9 +2503,36 @@ int main(int argc, char *argv[])
>  {
>         struct gatt_db *service_db_1, *service_db_2, *service_db_3;
>         struct gatt_db *ts_small_db, *ts_large_db_1, *ts_tail_db;
> +       struct gatt_db *hash_db;
> +       const struct att_handle_spec hash_specs[] =3D {
> +               PRIMARY_SERVICE(0x0001, GATT_UUID, 3),
> +               CHARACTERISTIC(GATT_CHARAC_DB_HASH, BT_ATT_PERM_READ,
> +                               BT_GATT_CHRC_PROP_READ, 0x00),
> +               { }
> +       };
>
>         tester_init(&argc, &argv);
>
> +       define_test_client("/robustness/client-cancel-queued-discovery",
> +                       test_client_cancel, NULL, NULL, {});
> +
> +       define_test_client("/robustness/client-cancel-pending-server-feat=
ures",
> +                       test_client, NULL, NULL, MTU_EXCHANGE_CLIENT_PDUS=
,
> +                       raw_pdu(0x08, 0x01, 0x00, 0xff, 0xff, 0x3a, 0x2b)=
);
> +
> +       define_test_client("/robustness/client-cancel-all-queued-discover=
y",
> +                       test_client_cancel_all, NULL, NULL, {});
> +
> +       hash_db =3D make_db(hash_specs);
> +       define_test("/robustness/client-cancel-queued-db-hash",
> +                       test_client_cancel, CLIENT_CACHED, NULL, hash_db,
> +                       NULL, {});
> +
> +       define_test("/robustness/client-cancel-pending-db-hash",
> +                       test_client, CLIENT_CACHED, NULL, hash_db, NULL,
> +                       CLIENT_INIT_PDUS,
> +                       raw_pdu(0x08, 0x01, 0x00, 0xff, 0xff, 0x2a, 0x2b)=
);
> +
>         service_db_1 =3D make_service_data_1_db();
>         service_db_2 =3D make_service_data_2_db();
>         service_db_3 =3D make_service_data_3_db();
> --
> 2.56.0
>
>


--=20
Luiz Augusto von Dentz
