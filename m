Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50E82F12AB
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 19:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771960269; cv=pass; b=erVZ5KiwtPQtoCXSaUgIVCbnPYYsbbTM4Ry62iYVeGMO5oikrEH/4t40FuczlrkF/qjfDl99kUlF4Hhwu1qGzPGCmBxqJcZPPFi+UB7mRq25gz2tRHd9j78O2NQQr8SrfGLmZyK01erGzd9IKzYJuMTHSmL1SUyusjo4AVPcBEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771960269; c=relaxed/simple;
	bh=WNgFjyM1P0SMWOETX8amvSWivkSKrdZ3ug9Pd3KyALw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=FSXXuI5K6USxvivjH7SgqLKXGO8GfXUdrDISQELI/b+i6VBgU1eW9G4Cge3zrRFO4w4YcqXHL5/mimlbivap5Ne9Km9/IV6QqPT0lHj0hTPAeDYqPNjTl5r8cCCUeJQFwdpKNLFfmEoQrHWiFHDtuwBwrE8egs9PPGu3T6yosTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmX1M1rL; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmX1M1rL"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64c9c8f8783so158376d50.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 11:11:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771960267; cv=none;
        d=google.com; s=arc-20240605;
        b=UNuZuGpc/lQQIa99CD5JYigf6c7FCj+ZqOvvX/i9v5DyGalI59+wTyAJbaz6Jjh09X
         Esp8DR/XuzjIvh0CQ8LQadwCryLjrpgfgMQ/7a40fiOUKQiRJJo1Ld/frlnQ3FT79u7y
         aPT4MhdQnyHYwYzftv+B9lzQQ9i66801sjtZjvsey+aljEKhOfd+TY3BhSStUKhjKEOJ
         +7Zxqb5YUKIMu6vxz0BNMW0r9k6haX7OMRcez10bGEjF+D2BYqnrf0gHoxnEID4DUZid
         jbl4hG2SPh0QVMsKxmWcGgbifv3cz3b+egu56+XlSUnb1SL4qDw4++28t99eJrLRdufS
         yN+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LfTUDEgmqgHPsk6oMv5kxy+JMxDu9je7FBY12R1gJYA=;
        fh=vCodtToMk8i5UbNIxIN1KAuhEbzq/innvt1KO9RCRjA=;
        b=Nmo0QCjZYW6k73WVZF65Yn5+4OPssrlwx5d5Z0UK0Y21JsgB6itOOWEvs7e/wLbzfL
         EIVIlWFrQE8jdiiAataewqMXfROVFMFX18599sIj4Fy1JJGnqR+plzrAYOqUOxCZEBBg
         lF5o5IxUW9aThqutgcUeLMAk0jRikZHcjdUp05mfc1/udjhuI1FYOcff3im61l3HVVbI
         ZSmzTtkSRTSbc+zJ1xD4/+dbPwo+FeQo2btgiQInXmOOaHwUQclDrA4EC1LCJcfpzcX0
         R7LN5dVqQBFD9SrCOsG2jl2ev8ZYKHKf/k13WndTJOIl4jKt7s+yoCMUOyacROPuaoTx
         tFyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771960267; x=1772565067; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LfTUDEgmqgHPsk6oMv5kxy+JMxDu9je7FBY12R1gJYA=;
        b=KmX1M1rLi2Dyb3ZRwgaF7CzsgMxTmMPZpPBs8gqXu5eMDF8j6D/xRynR+taZjYGgLm
         kWe/hjXSbuCCNQBnCvKhb5Q1ItJAzvZVkRNT0x65KtFo23vWoCV6MD4gDFeb35HgW+LJ
         6GhJ15ZECme5Ve54fUXLVDogNahW4njUvE204w2mikM5Uh+uvYx5B/WGk5F6uYetcIy2
         t5obpo+xwIKqJBNIqsrFVmeynJYiHPasCZRZp1V2Hi2ufhj97CzfRPQVYheUOkosYFF2
         EpiT0lR4E/gNc4L0UGwly086ewhoMTmmGQ2Xd6p4ImfIJyhq/MDWD6R0MtM7s0DZmPUi
         rqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771960267; x=1772565067;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LfTUDEgmqgHPsk6oMv5kxy+JMxDu9je7FBY12R1gJYA=;
        b=Y1iCxaBflreVGqdZl3pTCZr43zKo4iW2RbDEA7VvI8Gfx15S+UbwuScr4bmR+WpWea
         J4eX/73Qt7SN4r9nDHKCOJJhZuPSjJT/6uQB00+/lZK9gmDxI8cGva0m8TjZYuWLQO17
         W00P03tZWoa4aALGeezGayd1ktk9V0vqwMygU92DaFftc7af48OGs6FIafQcCiwxquEp
         ZGsV72809U3SXa2+HaOxb8SO2FCbJ/BYSPJjn7iz9dMaphKUsrzWQBuK+KZNRwFf7G5d
         aDTb5plrjj7a7SVqE03dW9mIY1qTHX06YRKsuJgCCiXB9F6uKGJzVbmxAuobZr2RCUiB
         qc5g==
X-Gm-Message-State: AOJu0YxUxr9uSnar60/R70XRxQY6cQEAZP4pKOgiPB5YsGZGPUL8WjmD
	0zaas61ocMmE3c9VSCTJyWrZfgd0Ul0MEqZW8Q8PyQu50PoSotTS1Ovka/X20KE6H/mhIzMx9ol
	feJ0XJ2bLJgLhm9h37Y7NR1ZatjbTZ2TQpJKf
X-Gm-Gg: ATEYQzxkBPBa2bgXnlarhCl9po6bkJz8x5cA97dHdRrRiuSBO68mPJkA6cCdQg3Jo49
	We+SHrbK+Buyn78w/UYj+zDyOTIxX1mcX+hcMUPYT0kdBlALbOHHQX4hNsIqhut0i/TftJstld6
	ak2dv32us+54b/o+Y07i5NdpvGw/NaIcGMhUPJ1i4p9pBYvA1gZAJ8uyUcc0jqkUGPn9CrJZlNR
	qF+gOwmzAWdq/alMGe0Djm+4T8oLFFDhOrXnfZh9CxFycOL0ult5m7hFoetY04+rveY2eaujiYr
	NefAaMjOvMwA5rd3PVDk8pIZiaWpUVE7RNZlRf91eyMSyAG5x9DGDbNBnthzxE0lIVVe4A==
X-Received: by 2002:a05:690e:1a65:b0:64c:9822:b8a9 with SMTP id
 956f58d0204a3-64ca612498emr722827d50.19.1771960266508; Tue, 24 Feb 2026
 11:11:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224185524.4044679-1-luiz.dentz@gmail.com>
In-Reply-To: <20260224185524.4044679-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 24 Feb 2026 14:10:53 -0500
X-Gm-Features: AaiRm51POqz0lPtqUrq64SlqKN1YWFCME9HOs46_kp8rwmHZ8fsGlNv7G-Y_hkQ
Message-ID: <CABBYNZJAETpL_0XDVhZ7O6iKdQ+XPjdQdtydt0x99+BwUow4OA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1] shared/att: Simplify logic of DB out of sync recovery
To: linux-bluetooth@vger.kernel.org, Mengshi Wu <mengshi.wu@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mengshi,

On Tue, Feb 24, 2026 at 1:55=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This removes struct pending_db_sync since it is not really necessary
> to record all the field in bt_att_pdu_error_rsp, most of them can be
> directly recovered from the original request and the ecode is meant
> to be only BT_ATT_ERROR_DB_OUT_OF_SYNC.
> ---
>  src/shared/att.c | 101 ++++++++++++++---------------------------------
>  1 file changed, 30 insertions(+), 71 deletions(-)
>
> diff --git a/src/shared/att.c b/src/shared/att.c
> index f6236248874c..3d3c8cfa262a 100644
> --- a/src/shared/att.c
> +++ b/src/shared/att.c
> @@ -35,7 +35,6 @@
>  #define BT_ATT_SIGNATURE_LEN           12
>
>  struct att_send_op;
> -struct pending_db_sync;
>
>  struct bt_att_chan {
>         struct bt_att *att;
> @@ -48,7 +47,7 @@ struct bt_att_chan {
>
>         struct att_send_op *pending_req;
>         struct att_send_op *pending_ind;
> -       struct pending_db_sync *pending_db_sync;
> +       struct att_send_op *pending_db_sync;
>         bool writer_active;
>
>         bool in_req;                    /* There's a pending incoming req=
uest */
> @@ -205,11 +204,6 @@ struct att_send_op {
>         void *user_data;
>  };
>
> -struct pending_db_sync {
> -       struct att_send_op *op;
> -       struct bt_att_pdu_error_rsp error;
> -};
> -
>  static void destroy_att_send_op(void *data)
>  {
>         struct att_send_op *op =3D data;
> @@ -655,10 +649,8 @@ static void bt_att_chan_free(void *data)
>         if (chan->pending_ind)
>                 destroy_att_send_op(chan->pending_ind);
>
> -       if (chan->pending_db_sync) {
> -               destroy_att_send_op(chan->pending_db_sync->op);
> -               free(chan->pending_db_sync);
> -       }
> +       if (chan->pending_db_sync)
> +               destroy_att_send_op(chan->pending_db_sync);
>
>         queue_destroy(chan->queue, destroy_att_send_op);
>
> @@ -699,8 +691,7 @@ static bool disconnect_cb(struct io *io, void *user_d=
ata)
>         }
>
>         if (chan->pending_db_sync) {
> -               disc_att_send_op(chan->pending_db_sync->op);
> -               free(chan->pending_db_sync);
> +               disc_att_send_op(chan->pending_db_sync);
>                 chan->pending_db_sync =3D NULL;
>         }
>
> @@ -828,15 +819,6 @@ static bool handle_error_rsp(struct bt_att_chan *cha=
n, uint8_t *pdu,
>         /* Check if this is DB_OUT_OF_SYNC and we have a callback */
>         if (rsp->ecode =3D=3D BT_ATT_ERROR_DB_OUT_OF_SYNC &&
>                                 att->db_sync_callback) {
> -               struct pending_db_sync *pending;
> -
> -               pending =3D new0(struct pending_db_sync, 1);
> -               if (!pending)
> -                       return false;
> -
> -               pending->op =3D op;
> -               pending->error =3D *rsp;
> -
>                 /* Remove timeout since we're waiting for approval */
>                 if (op->timeout_id) {
>                         timeout_remove(op->timeout_id);
> @@ -844,13 +826,13 @@ static bool handle_error_rsp(struct bt_att_chan *ch=
an, uint8_t *pdu,
>                 }
>
>                 /* Move to pending_db_sync */
> -               chan->pending_db_sync =3D pending;
> +               chan->pending_db_sync =3D op;
>                 chan->pending_req =3D NULL;
>
>                 DBG(att, "(chan %p) DB out of sync for operation %p", cha=
n, op);
>
>                 /* Notify upper layer */
> -               att->db_sync_callback(&pending->error, op->pdu + 1, op->l=
en - 1,
> +               att->db_sync_callback(rsp, op->pdu + 1, op->len - 1,
>                                       op->id, att->db_sync_data);
>
>                 return true;
> @@ -1726,7 +1708,6 @@ int bt_att_resend(struct bt_att *att, unsigned int =
id, uint8_t opcode,
>  {
>         const struct queue_entry *entry;
>         struct att_send_op *op;
> -       bool from_db_sync =3D false;
>         bool result;
>
>         if (!att || !id)
> @@ -1741,40 +1722,18 @@ int bt_att_resend(struct bt_att *att, unsigned in=
t id, uint8_t opcode,
>                         break;
>
>                 /* Also check pending_db_sync */
> -               if (chan->pending_db_sync &&
> -                               chan->pending_db_sync->op->id =3D=3D id) =
{
> -                       from_db_sync =3D true;
> -                       break;
> +               if (chan->pending_db_sync && chan->pending_db_sync->id =
=3D=3D id) {
> +                       op =3D chan->pending_db_sync;
> +                       chan->pending_db_sync =3D NULL;
> +                       DBG(att, "(chan %p) Resending DB out of sync oper=
ation"
> +                               " %p", chan, op);
> +                       goto done;
>                 }
>         }
>
>         if (!entry)
>                 return -ENOENT;
>
> -       /* If from pending_db_sync, extract operation details if not prov=
ided */
> -       if (from_db_sync) {
> -               struct bt_att_chan *chan =3D entry->data;
> -               struct pending_db_sync *pending =3D chan->pending_db_sync=
;
> -               struct att_send_op *stored_op =3D pending->op;
> -
> -               /* Auto-extract from stored operation if pdu is NULL */
> -               if (!pdu) {
> -                       opcode =3D stored_op->opcode;
> -                       pdu =3D stored_op->pdu + 1;
> -                       length =3D stored_op->len - 1;
> -                       callback =3D stored_op->callback;
> -                       user_data =3D stored_op->user_data;
> -                       destroy =3D stored_op->destroy;
> -               }
> -
> -               DBG(att, "(chan %p) Resending DB out of sync operation %p=
",
> -                       chan, stored_op);
> -
> -               /* Clear pending_db_sync state */
> -               chan->pending_db_sync =3D NULL;
> -               free(pending);
> -       }
> -
>         /* Only allow requests to be resend */
>         if (get_op_type(opcode) !=3D ATT_OP_TYPE_REQ)
>                 return -EOPNOTSUPP;
> @@ -1786,6 +1745,7 @@ int bt_att_resend(struct bt_att *att, unsigned int =
id, uint8_t opcode,
>
>         op->id =3D id;
>
> +done:
>         switch (opcode) {
>         /* Only prepend requests that could be a continuation */
>         case BT_ATT_OP_READ_BLOB_REQ:
> @@ -1873,30 +1833,29 @@ bool bt_att_chan_cancel(struct bt_att_chan *chan,=
 unsigned int id)
>
>  static bool bt_att_db_sync_cancel(struct bt_att_chan *chan, unsigned int=
 id)
>  {
> -       if (chan->pending_db_sync && chan->pending_db_sync->op->id =3D=3D=
 id) {
> -               struct pending_db_sync *pending =3D chan->pending_db_sync=
;
> -               struct att_send_op *op =3D pending->op;
> -               uint8_t error_pdu[sizeof(struct bt_att_pdu_error_rsp)];
> +       struct att_send_op *op =3D chan->pending_db_sync;
> +       struct bt_att_pdu_error_rsp rsp;
>
> -               /* Build error response PDU */
> -               memcpy(error_pdu, &pending->error, sizeof(pending->error)=
);
> +       if (!op || op->id !=3D id)
> +               return false;
>
> -               /* Clear pending state */
> -               chan->pending_db_sync =3D NULL;
> -               free(pending);
> +       /* Build error response PDU */
> +       memset(&rsp, 0, sizeof(rsp));
> +       rsp.opcode =3D op->opcode;
> +       rsp.ecode =3D BT_ATT_ERROR_DB_OUT_OF_SYNC;
>
> -               /* Notify callback with error */
> -               if (op->callback)
> -                       op->callback(BT_ATT_OP_ERROR_RSP, error_pdu,
> -                                    sizeof(error_pdu), op->user_data);
> +       /* Clear pending state */
> +       chan->pending_db_sync =3D NULL;
>
> -               destroy_att_send_op(op);
> -               wakeup_chan_writer(chan, NULL);
> +       /* Notify callback with error */
> +       if (op->callback)
> +               op->callback(BT_ATT_OP_ERROR_RSP, &rsp, sizeof(rsp),
> +                                               op->user_data);
>
> -               return true;
> -       }
> +       destroy_att_send_op(op);
> +       wakeup_chan_writer(chan, NULL);
>
> -       return false;
> +       return true;
>  }
>
>  static bool bt_att_disc_cancel(struct bt_att *att, unsigned int id)
> --
> 2.52.0

Can you verify these changes don't break anything you were testing?

--=20
Luiz Augusto von Dentz
