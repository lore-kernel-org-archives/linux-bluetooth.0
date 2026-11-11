Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.121
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794433427;
	b=KI/K/ep6/RF3DmJJZFyJovWWX2NVQoSeyEPmSXpcUyPdrrpYVVroEm/A6qyqPI//rTuH
	 Wv33IEZzc1JU6TmHLdNvdXyRbS9Z1/bN/s9wEvX/jHAACaw1X9xIdo8IT6BzhJVE7PJge
	 C4ISzCSqEbq0j+f9nN6XS6E+igbMOziunlN+uPKqsIzTiHQ8/3BOLJHlxc3QUnbAT393F
	 1kW1tLDc3ysHrGdAc9d+IWWtdVk9qAbm3rE95wvvv07mrZxlg6JIh+eDF15PRKIJ8WRAU
	 z/V/VDHJSmYh15W+ZcDYz3NLDMpMrp/uBz07XBwjDjsfJ9J9LI9gZ3G0IJjgQF/UKDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794433427;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=pPtLbLmpdu1+/0mHM04LHCfwkyMlBuSLXQgWO0T89mk=;
	b=07Pbem7AgT8k+olNKmGVSxOjmrc6UwFJEPpNpCKKs09H72Hbi8HdkdhYdqLdKenySg+Z
	 TV6lRKNrMDciIKzZNrep7ur9YIEI0n0hF7MT7NwLwK/RlJ3QJ3Vv/kgrr72FgB+Z+VsFz
	 8IqjcxqwiNzOXVEZoIqfue4nDdk+EC7/0yt8aWSMPO0IJpjU2Rne+OamviSY6Bz/nDP3G
	 VCfpQ38NRVWY93YFfWgadaZTzWCVfjvXrmWR5g3CF7wERRlHTIaxwrDrA8Zsx4y7AiCWf
	 6Ue/bchX9Y1LARfY2xsjX3gLLgCw7MQUQ7/wmacOqYcQFPQh2yKhudgCs/SLquoBuOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=KRPjTbla;
	arc=none smtp.remote-ip=109.224.244.121
Received: from mail-244121.protonmail.ch (mail-244121.protonmail.ch [109.224.244.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A543606A31C
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 21:43:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A543606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=KRPjTbla
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1794433424; x=1794692624;
	bh=pPtLbLmpdu1+/0mHM04LHCfwkyMlBuSLXQgWO0T89mk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=KRPjTbla+YoVMOKr3gX4TP4fRZ91NUZ8aCgmipuzPhkfEyhjC0/Hgq/HZ7dsPlWo0
	 2A+CKfyzQxSViITO1Kq69wXP/ldQMobC9DKcdHSNGXR3z1nmSjfI9YKTEdlJQHgFFD
	 pPastnsWQ3pqtFO3IU4w8LOzGhaBp6GGcEBNJZEfZAJ6taSg25zMWdX3iZGg9rlNau
	 yHB5U/7VVPktrXxSx1nCk/PYvIM+VA1WA40cLp22tvTKrqdMajickoYifW+O0SGWbk
	 Qz5zMHfCrjbU8NoL+n5K4Peq84ZNKqWT2RE6qlug2AtDW7Es8fYJR0uGC6hsxdTMQZ
	 LeSNGVGjSGGZQ==
Date: Wed, 11 Nov 2026 21:43:39 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com
Subject: [PATCH v2 1/3] shared/gatt-client: Support pending GATT helper requests
Message-ID: <4c16af75cbdb770ef8bf3ba44ef2173c10e9fc8a.1794432472.git.cochcoder@proton.me>
In-Reply-To: <cover.1794432472.git.cochcoder@proton.me>
References: <20261107065854.2147141-1-cochcoder@proton.me> <cover.1794432472.git.cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: a13849627070f2dec2b857855bfa51e0f879e391
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Allow pending requests to own a cancellable GATT helper request, so
multi-PDU operations can use the existing cancellation queue. Expose a
request-returning read-by-type helper and keep the boolean interface for
callers that do not retain requests.

Assisted-by: Codex:gpt-6
---
 src/shared/gatt-client.c  | 10 ++++++++++
 src/shared/gatt-helpers.c | 26 ++++++++++++++++++++++----
 src/shared/gatt-helpers.h |  7 +++++++
 3 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 7bebc50dc..f301a105b 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -120,6 +120,7 @@ struct request {
 =09int ref_count;
 =09unsigned int id;
 =09unsigned int att_id;
+=09struct bt_gatt_request *gatt_req;
 =09void *data;
 =09void (*destroy)(void *);
 };
@@ -2811,6 +2812,15 @@ static bool cancel_request(struct request *req)
 {
 =09req->removed =3D true;
=20
+=09if (req->gatt_req) {
+=09=09struct bt_gatt_request *gatt_req =3D req->gatt_req;
+
+=09=09req->gatt_req =3D NULL;
+=09=09bt_gatt_request_cancel(gatt_req);
+=09=09bt_gatt_request_unref(gatt_req);
+=09=09return true;
+=09}
+
 =09if (req->long_write)
 =09=09return cancel_long_write_req(req->client, req);
=20
diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index ea77a41ef..6d307e893 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -1484,7 +1484,8 @@ done:
 =09discovery_op_complete(op, success, att_ecode);
 }
=20
-bool bt_gatt_read_by_type(struct bt_att *att, uint16_t start, uint16_t end=
,
+struct bt_gatt_request *bt_gatt_read_by_type_request(struct bt_att *att,
+=09=09=09=09=09uint16_t start, uint16_t end,
 =09=09=09=09=09const bt_uuid_t *uuid,
 =09=09=09=09=09bt_gatt_request_callback_t callback,
 =09=09=09=09=09void *user_data,
@@ -1495,7 +1496,7 @@ bool bt_gatt_read_by_type(struct bt_att *att, uint16_=
t start, uint16_t end,
 =09struct iovec req =3D { pdu, 0 };
=20
 =09if (!att || !uuid || uuid->type =3D=3D BT_UUID_UNSPEC)
-=09=09return false;
+=09=09return NULL;
=20
 =09op =3D new0(struct bt_gatt_request, 1);
 =09op->att =3D att;
@@ -1516,10 +1517,27 @@ bool bt_gatt_read_by_type(struct bt_att *att, uint1=
6_t start, uint16_t end,
 =09=09=09=09=09=09bt_gatt_request_ref(op),
 =09=09=09=09=09=09async_req_unref);
 =09if (op->id)
-=09=09return true;
+=09=09return bt_gatt_request_ref(op);
=20
 =09free(op);
-=09return false;
+=09return NULL;
+}
+
+bool bt_gatt_read_by_type(struct bt_att *att, uint16_t start, uint16_t end=
,
+=09=09=09=09=09const bt_uuid_t *uuid,
+=09=09=09=09=09bt_gatt_request_callback_t callback,
+=09=09=09=09=09void *user_data,
+=09=09=09=09=09bt_gatt_destroy_func_t destroy)
+{
+=09struct bt_gatt_request *req;
+
+=09req =3D bt_gatt_read_by_type_request(att, start, end, uuid, callback,
+=09=09=09=09=09=09=09user_data, destroy);
+=09if (!req)
+=09=09return false;
+
+=09bt_gatt_request_unref(req);
+=09return true;
 }
=20
 static void discover_descs_cb(uint8_t opcode, const void *pdu,
diff --git a/src/shared/gatt-helpers.h b/src/shared/gatt-helpers.h
index 2bf5aad46..528ef2196 100644
--- a/src/shared/gatt-helpers.h
+++ b/src/shared/gatt-helpers.h
@@ -102,5 +102,12 @@ bool bt_gatt_read_by_type(struct bt_att *att, uint16_t=
 start, uint16_t end,
 =09=09=09=09=09void *user_data,
 =09=09=09=09=09bt_gatt_destroy_func_t destroy);
=20
+struct bt_gatt_request *bt_gatt_read_by_type_request(struct bt_att *att,
+=09=09=09=09=09uint16_t start, uint16_t end,
+=09=09=09=09=09const bt_uuid_t *uuid,
+=09=09=09=09=09bt_gatt_request_callback_t callback,
+=09=09=09=09=09void *user_data,
+=09=09=09=09=09bt_gatt_destroy_func_t destroy);
+
 uint16_t bt_gatt_req_get_end_handle(struct bt_gatt_request *req);
 uint16_t bt_gatt_req_get_start_handle(struct bt_gatt_request *req);
--=20
2.56.0


