Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D3A2248AF
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Dec 2025 15:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765208149; cv=none; b=Uz4Tqy9mFQIysY0l7ldbPdImueyzT3A1Fk4gLgJMbJ9i6gCO3AJse/7jgFIDTCkFOR1XLyESWcAq09xN1hROpD93v4lSdFCrTX5ZIkMk69Xc4npQN7wuh/DmE/cSNiQ4Y3lsHEjp9JBIzC9Pd7WcYfghJ5X/4q4yJ3e8kGGbgzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765208149; c=relaxed/simple;
	bh=XKlOssSOiluaAkTuqzPNbnNo5wswOaCh/aOSg/InTMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VUkGvYSwiLS0ktPXBEmIgD0QVlpO2y5yuCgyTK+ffGCExvmPemIYp6vClWqDw/d5Bw6h+i7fK2ZZtwsOf2TFp4DQ2h0WkT0K/XKWPtW0dbRWrcFOH+kY8sQY3MZt7dAX/1nwCBAyebP5rOhXejYBX7LIAu/It6XQGOUWIUSBAU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANbzyLTF; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANbzyLTF"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-37d96f97206so36888471fa.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Dec 2025 07:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765208145; x=1765812945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LnMesBWs9K96ISefwjInMCFFlmWgdyGh6umQLKK1XLg=;
        b=ANbzyLTFDBICyc6ypIWHeVi0W19Wg7ggxT2VPUq7rIEk6F36Kzj7JMsRemx1kBJwI3
         f9SUEoYYA2EtSM4yILNy6C6hAWgB9i1OFjxWg0FvyvIh6JJkDyyCxG3gKyvsXuAVwOEY
         bl6uR5MtLni77EK/VqJUvXMLl50pwyjX0U8I+lm1Aohvhe5J6sintb2G6nAG4n/37DN3
         iDTSkqiKJWq0SlKdNwq2DdZchvkoBNtJyJPWmpABHeyp/NQUNtlF4jnapbbly7a/iIgY
         Dlm7pBUBD35UHG8ON5QCg/9L52S3xYoa23/h3rdtdVfZrUtKwqzgTf6yloAiz6uoHy7b
         wuqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765208145; x=1765812945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LnMesBWs9K96ISefwjInMCFFlmWgdyGh6umQLKK1XLg=;
        b=mbOAb0Gm7S5d/rp4ycBOc65FGsV4yK83jXkh/rxJCOfM+sHCZXnDRofpxjPVnQqxmW
         suCbgHT1C6tLWR1VbzEfuyJInnIX5qlLmRAjm00TkfCSHgkOW6C53kfarbWjqbhfiT/w
         svfhQmUCZwtjD5xg9CcfcDqdCPvqN1ZVEmvGrFZ+S8tXB+cVXYRdBnqcNe3ukqxqRHFi
         wtTS0CYgvIKfKgH244FCl13iO2PSr5e6CBm/YNI4z1Te/3mgEWZgEP0R9EkhM0tTuTsF
         EEzLsG6uQpMGYfdaGAvOvO1oqu2YiqaVuM/ZoYiecc9fr6U6wbwoQDT/Tv58kjm+iD/Q
         ji+g==
X-Gm-Message-State: AOJu0YzmuoWs5k7pRYsPZtnVoCI3f0vhlBD5hkwqisYScRSNqz5EObZc
	6Y7U1w8EN/Tlfci8qYwHy1OxKbRelxihEpWgPE78HTcsOn34wCRePPbEMsfkblGdZOko+BPRTqk
	3p31YT9NsLuVaC830dos7Zv+5zgFVzIM=
X-Gm-Gg: ASbGnctf8wNnc82Thv28JmrEsoJqwaKhvnDSV7j2rxc5sKWcufuhaO3LQrYMS2M9lv8
	YQQ8lILgJ/nr1zDYj2+dY8I87XurymvG8HZODbvedaJWvUNWeCUGmZJ8GZsKoLI7YjgkKJ6NbKi
	pLGFVKKqlKdQvrUv3FVjDjy7WHTGaXc0QMWGhljuos+iWKDU8aoNgQfKmgv00TyaKYoFdHY5uxH
	1E78skrmWU5gKOZp8RkcLRIxPTY9SjgfzAiCsDKA09OXmnXPClgfux5+1JQy3HUS7S6bQ==
X-Google-Smtp-Source: AGHT+IH/up8DOQxkVmAYNK0+IAyqLiY2+XktesBDw4Olo/TvoTZlmB/mY0+aSLFX+k09y1vVE/q1qgkeaNb1trrpUWI=
X-Received: by 2002:a05:651c:3058:b0:37f:933b:aa07 with SMTP id
 38308e7fff4ca-37f933bacbemr12257031fa.33.1765208144560; Mon, 08 Dec 2025
 07:35:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208101915.247459-1-mengshi.wu@oss.qualcomm.com>
In-Reply-To: <20251208101915.247459-1-mengshi.wu@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 8 Dec 2025 10:35:31 -0500
X-Gm-Features: AQt7F2p0cahbqsKycX8T-ypu38qwCPo14vWwNsj_jmmMQgTd8AlsnNQHdvJY66I
Message-ID: <CABBYNZJ=S3LHcwyXAc=gxf0RptcOC+6TPaWvoEmJquar54b3dQ@mail.gmail.com>
Subject: Re: [PATCH v1] gatt-client:Implement error handling for
 DB_OUT_OF_SYNC in GATT caching.
To: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com, 
	cheng.jiang@oss.qualcomm.com, chezhou@qti.qualcomm.com, 
	wei.deng@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 8, 2025 at 5:19=E2=80=AFAM Mengshi Wu <mengshi.wu@oss.qualcomm.=
com> wrote:
>
> Add automatic DB re-discovery on receiving BT_ATT_ERROR_DB_OUT_OF_SYNC
> error code from ATT operations. This ensures the local GATT database
> stays synchronized with the remote device by triggering a full service
> discovery (handles 0x0001-0xffff) when the database becomes out of sync.
>
> The process_db_out_of_sync() function is now called in all ATT error
> response handlers (read_multiple, read_long, write, execute_write,
> prepare_write, and prep_write callbacks) to handle this error condition
> consistently.
>
> Signed-off-by: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
> ---
>  src/shared/gatt-client.c | 35 +++++++++++++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
>
> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> index f6d5dc4b7..087d4e228 100644
> --- a/src/shared/gatt-client.c
> +++ b/src/shared/gatt-client.c
> @@ -1965,6 +1965,29 @@ fail:
>                 "Failed to initiate service discovery after Service Chang=
ed");
>  }
>
> +static void process_db_out_of_sync(struct bt_gatt_client *client,
> +                                  uint8_t att_ecode)
> +{
> +       struct service_changed_op *op;
> +
> +       if (att_ecode !=3D BT_ATT_ERROR_DB_OUT_OF_SYNC)
> +               return;
> +
> +       DBG(client, "Database Out of Sync - triggering full re-discovery"=
);
> +
> +       if (!client->in_svc_chngd) {
> +               process_service_changed(client, 0x0001, 0xffff);
> +               return;
> +       }
> +
> +       op =3D new0(struct service_changed_op, 1);
> +
> +       op->start_handle =3D 0x0001;
> +       op->end_handle =3D 0xffff;
> +
> +       queue_push_tail(client->svc_chngd_queue, op);
> +}

Id just change process_error to call into db_out_sync, that said this
is not recovering at all, it just rediscovering but the original
request will be lost, I wonder if we should implement some backoff
logic wait to see if the server do a service changed, read the hash
(in case we are not doing it already), and then redo the operation.
Also we do need to make sure we don't end up in a loop rediscovery.

>  static void service_changed_cb(uint16_t value_handle, const uint8_t *val=
ue,
>                                         uint16_t length, void *user_data)
>  {
> @@ -2709,10 +2732,12 @@ static void read_multiple_cb(uint8_t opcode, cons=
t void *pdu, uint16_t length,
>                         (!pdu && length)) {
>                 success =3D false;
>
> -               if (opcode =3D=3D BT_ATT_OP_ERROR_RSP)
> +               if (opcode =3D=3D BT_ATT_OP_ERROR_RSP) {
>                         att_ecode =3D process_error(pdu, length);
> -               else
> +                       process_db_out_of_sync(req->client, att_ecode);
> +               } else {
>                         att_ecode =3D 0;
> +               }
>
>                 pdu =3D NULL;
>                 length =3D 0;
> @@ -2864,6 +2889,7 @@ static void read_long_cb(uint8_t opcode, const void=
 *pdu,
>         if (opcode =3D=3D BT_ATT_OP_ERROR_RSP) {
>                 success =3D false;
>                 att_ecode =3D process_error(pdu, length);
> +               process_db_out_of_sync(req->client, att_ecode);
>                 goto done;
>         }
>
> @@ -3050,6 +3076,7 @@ static void write_cb(uint8_t opcode, const void *pd=
u, uint16_t length,
>         if (opcode =3D=3D BT_ATT_OP_ERROR_RSP) {
>                 success =3D false;
>                 att_ecode =3D process_error(pdu, length);
> +               process_db_out_of_sync(req->client, att_ecode);
>                 goto done;
>         }
>
> @@ -3213,6 +3240,7 @@ static void execute_write_cb(uint8_t opcode, const =
void *pdu, uint16_t length,
>         if (opcode =3D=3D BT_ATT_OP_ERROR_RSP) {
>                 success =3D false;
>                 att_ecode =3D process_error(pdu, length);
> +               process_db_out_of_sync(req->client, att_ecode);
>         } else if (opcode !=3D BT_ATT_OP_EXEC_WRITE_RSP || pdu || length)
>                 success =3D false;
>
> @@ -3278,6 +3306,7 @@ static void prepare_write_cb(uint8_t opcode, const =
void *pdu, uint16_t length,
>         if (opcode =3D=3D BT_ATT_OP_ERROR_RSP) {
>                 success =3D false;
>                 att_ecode =3D process_error(pdu, length);
> +               process_db_out_of_sync(req->client, att_ecode);
>                 goto done;
>         }
>
> @@ -3447,6 +3476,7 @@ static void prep_write_cb(uint8_t opcode, const voi=
d *pdu, uint16_t length,
>                 success =3D false;
>                 reliable_error =3D false;
>                 att_ecode =3D process_error(pdu, length);
> +               process_db_out_of_sync(req->client, att_ecode);
>                 goto done;
>         }
>
> @@ -3597,6 +3627,7 @@ static void exec_write_cb(uint8_t opcode, const voi=
d *pdu, uint16_t length,
>         if (opcode =3D=3D BT_ATT_OP_ERROR_RSP) {
>                 success =3D false;
>                 att_ecode =3D process_error(pdu, length);
> +               process_db_out_of_sync(req->client, att_ecode);
>                 goto done;
>         }
>
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
