Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B450233B96B
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jan 2026 18:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769019328; cv=pass; b=rOyM9SpF/HCruwKscFIxcG7ZwseX0itHwj9fpoiWnJjY4OCOArgtYkuWyJ2qBIeDNdzdrKqE6Sx7cKenwmbWWHXtntlenY+wRiLeTSgypwccmTqfkh54xQ4RRJYMvsm+ZL5krpbRf2Ljc+gkTu//1T0ZW96u8bluIrOGux7nVz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769019328; c=relaxed/simple;
	bh=3rmoD/rM7AF1GleJVxfTJT7kwqc68Er7aLpNzUyV+Qo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gT80QU23YQ/n1+dev1MU5vkMudBp5i4rIrD5g0k3AlgoaExUKaD05FuYwUSO2a7ntrlzkYhJjDe40BkXnVdMjEr6Mr9VRbIDusIGTK32KPBP+0D/yNVVpZpC36J2WqIYTNIJRBctsRB6NYXwXoKkz62v7g0/OFervAEAJsMfVpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bENQgV75; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bENQgV75"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-79419542b12so683267b3.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jan 2026 10:15:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769019325; cv=none;
        d=google.com; s=arc-20240605;
        b=PpYPnKgiTzFTcgYsXB6fJ1+V/TRqyi4uWK2mwyzORubJaPw8lwl9y9mZ0sp/QaB8O9
         Q3wA9sznrUPxjuPc6TXiCXzTXu4fiNdktQMPQ+yToOnrymJ+WoyKCVPVvHCUb6nNEdkh
         HlvugBTctjc409ycIt90qOILn4h7r6D6ULtLgsKW/p9uBYIMHwaYNnbLG7iE/FEneB1A
         KcZfkQwD+3Nu5o56PkajI/UCXkNLB57NNmRtbwvxFitIjwm37unNr8cxjAtfOzk7yut2
         htakRhVUaX4sGNZOomqBjdurSwpBFPgxpx7fr0YAJl9HvnL6jXI1Cecu7Ic0osF8jiGu
         5a9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t6d1SOFNxNzR7PNUZ4lJ9ItcQMAxC53e9OqXq7ffibw=;
        fh=fXWXWrmQVmO8a3ItkADHjf2Px6vrJt4Rn10LLYlU1ZQ=;
        b=lD3RzVhPZ5JF2o0hQdCPI5lzyVhfeGZd834aRxHQzvVoBKWZwGHpVECBiww30s3YCP
         OOTf+WIrq+GW8ZKoATyL0ohGwSd7FlxwB08jZQcCW8SmOMi5OJyRfgtJz4dht+R/A9Lm
         dP7g5fH2XKc6PZV1nPOrpiT79eelvRxor4TIillLh+R2azrQgSp2Fbe3b0XR/UNu5bjd
         3bdcZI/lswhK56bSEVsovTrFvdTvARFgQzoo6z23yGY0ONIeMpU/TVnztxiufzzXyDen
         vUZyrsaSxltk0uWjAKNysgbPjzXuz28fRm+Mgb3AdMqOpNW4Xsaqh9RQbQMkNMptIHxb
         dfpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769019325; x=1769624125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6d1SOFNxNzR7PNUZ4lJ9ItcQMAxC53e9OqXq7ffibw=;
        b=bENQgV75pb8ph7n4PuAUm4ilBwOXBXVlgz7XQOwxr94z6V5WPKjeaKcHN0h9DM48kt
         YnDMsCW3U9BcXGITstx1z5TzvIRqx7nQa4w6a9K+BgPRYkIQFTQiB1vHzYplnciQh5jP
         a7UT53zFupJtgvPFIMHc+fZDBYM2EFTUoEjo7cj2bv4Ciy//28D+9GKS0cZlm2czvEZm
         jQPRt+j5vgRZj3v7Wgp0RmK+WXHmo82HqE61ZHyGguPQrADCCX/K4ZhcBsmX+s5lVJEC
         eW/Y1S1TYL6o3uP8i51Q2HMaj+moo/yquUz8inar5Hr8f0CHugoxg55trRNZZLohHIk/
         sl+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769019325; x=1769624125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t6d1SOFNxNzR7PNUZ4lJ9ItcQMAxC53e9OqXq7ffibw=;
        b=EWI3bZEeWw8JVNyzIhTOmy7eW8REaO2KeDWXdi/WBG5SuOVyxaAsSdyQgoRd9/X6zc
         JM4K8ym+jyw5z+NB2YiSiWwhaZ5XEG0jT2Ci6sfoHRwN+wJ79FO7ciMY8wTpjX74gDZb
         cELziRWE0A72UUadyP8Xo1fKslzyHIJFNfFtfYujf5N6YurOGc/WsOE7gAXkylxVM/nQ
         91YKOnGeB7n05HFojKtUr9j3myQo2SrsfgvyVepcgKppVb6Rac56mZwWXk1fwgr5mduh
         a4dLd1WY65Dg7fjVm9IGlkYY0MV28g2G3dqSqo4jM3XyDKPf9RWVprsZLD/qRL14a9g2
         ZOYw==
X-Gm-Message-State: AOJu0YxYsqjEjJaeYjDYBjXmPxxFF06uXKcL1OpC4cfBqsJT9u6nItkl
	4fOppCqurPV+gCyuxONdevP5vCpUWXOFyAlBjvux7m7ngsCm23Bk2ik/odNnQSngth/b+e04xKV
	ffEQxW+JIHgyc0pe/4QMXmvYd9voARoA=
X-Gm-Gg: AZuq6aIbuw8vsyZVcllh5dZ3vV+3sM32ULgqlZBsvTt/1ho13RdYq49Prqfff73Q/XG
	cbyo7PVJ1MRa9qbWlvHg06vkthhNwQlWui5ghxkjAqGV2pxPASXEnwwvQGlBf5q8FMI0BQyLs8y
	iGKCYX8uWrWwKxd+SslrkldUoRM4f70RWAzhhO2sI4/D5M67vpRKYYfu69PqncNKXRLevsG6ZwF
	5MvICu7PARvKdFNCbqfKGjyKQ0exw0L0jXq82sBQhKv3pJ7Lxn99oFfOgfIysONZpsXr1rmrQl4
	8+MqBeaviPa1Vr2KU+rJqeWKYh17eJqMHX+zr+5u6MlgcZpzY3HNil0=
X-Received: by 2002:a05:690c:f09:b0:78d:b1e9:85f0 with SMTP id
 00721157ae682-793c6831d0dmr134301187b3.47.1769019325264; Wed, 21 Jan 2026
 10:15:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121083804.4010106-1-mengshi.wu@oss.qualcomm.com> <20260121083804.4010106-2-mengshi.wu@oss.qualcomm.com>
In-Reply-To: <20260121083804.4010106-2-mengshi.wu@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 21 Jan 2026 13:15:13 -0500
X-Gm-Features: AZwV_QhDlXjWWrych5ZfHYAwCtlfvbNZrGtO2ILzWhmGLkm5HOVV5qa8zUc3M4s
Message-ID: <CABBYNZJwuqc3=scrzx+iqYBKr+7C4o5ARFy2V9KtOU4rqcL1ew@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] shared/att: Implement ATT error retry mechanism
 with callback support
To: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com, 
	cheng.jiang@oss.qualcomm.com, chezhou@qti.qualcomm.com, 
	wei.deng@oss.qualcomm.com, yiboz@qti.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mengshi,

On Wed, Jan 21, 2026 at 3:38=E2=80=AFAM Mengshi Wu <mengshi.wu@oss.qualcomm=
.com> wrote:
>
> Add a retry mechanism for ATT operations that allows upper layers to
> decide whether to retry failed requests. This includes:
>
> - Add retry callback registration (bt_att_set_retry_cb) to allow
>   applications to handle retry decisions
> - Implement pending_retry state tracking in att_send_op to store
>   operations awaiting retry approval
> - Add bt_att_retry_request() and bt_att_cancel_retry() functions to
>   approve or reject retry attempts
> - Store error PDUs during retry_pending state for callback inspection
> - Modify handle_error_rsp() to return retry decision codes instead of
>   boolean values
> - Add BT_ATT_RETRY_* constants for retry decision handling
> - Update GATT helpers to support retry callbacks for operations like
>   discovery and read/write requests
>
> This enables more robust error handling by allowing the application
> layer to implement custom retry logic based on ATT error codes.
>
> Signed-off-by: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
> ---
>  src/shared/att.c | 182 +++++++++++++++++++++++++++++++++++++++++++++--
>  src/shared/att.h |  16 +++++
>  2 files changed, 191 insertions(+), 7 deletions(-)
>
> diff --git a/src/shared/att.c b/src/shared/att.c
> index 77ca4aa24..4ae97530a 100644
> --- a/src/shared/att.c
> +++ b/src/shared/att.c
> @@ -47,6 +47,7 @@ struct bt_att_chan {
>
>         struct att_send_op *pending_req;
>         struct att_send_op *pending_ind;
> +       struct att_send_op *pending_retry;
>         bool writer_active;
>
>         bool in_req;                    /* There's a pending incoming req=
uest */
> @@ -78,6 +79,10 @@ struct bt_att {
>         bt_att_destroy_func_t timeout_destroy;
>         void *timeout_data;
>
> +       bt_att_retry_func_t retry_callback;
> +       bt_att_destroy_func_t retry_destroy;
> +       void *retry_data;

Why do we need these fields? The bt_att_chan already have this data as
part of pending_retry, so this sound duplicated to me, or is this this
just to register for retry callback?

> +
>         uint8_t debug_level;
>         bt_att_debug_func_t debug_callback;
>         bt_att_destroy_func_t debug_destroy;
> @@ -194,6 +199,9 @@ struct att_send_op {
>         void *pdu;
>         uint16_t len;
>         bool retry;
> +       bool retry_pending;  /* Waiting for approval to retry */
> +       uint8_t *error_pdu;  /* Stored error PDU for retry_pending */
> +       uint16_t error_pdu_len;

These fields are definitely not needed, juist reuse pdu, len and retry
fields, you are already adding a dedicated field for them in
bt_att_chan.pending_retry.

>         bt_att_response_func_t callback;
>         bt_att_destroy_func_t destroy;
>         void *user_data;
> @@ -210,6 +218,7 @@ static void destroy_att_send_op(void *data)
>                 op->destroy(op->user_data);
>
>         free(op->pdu);
> +       free(op->error_pdu);
>         free(op);
>  }
>
> @@ -644,6 +653,9 @@ static void bt_att_chan_free(void *data)
>         if (chan->pending_ind)
>                 destroy_att_send_op(chan->pending_ind);
>
> +       if (chan->pending_retry)
> +               destroy_att_send_op(chan->pending_retry);
> +
>         queue_destroy(chan->queue, destroy_att_send_op);
>
>         io_destroy(chan->io);
> @@ -682,6 +694,11 @@ static bool disconnect_cb(struct io *io, void *user_=
data)
>                 chan->pending_ind =3D NULL;
>         }
>
> +       if (chan->pending_retry) {
> +               disc_att_send_op(chan->pending_retry);
> +               chan->pending_retry =3D NULL;
> +       }
> +
>         bt_att_chan_free(chan);
>
>         /* Don't run disconnect callback if there are channels left */
> @@ -777,16 +794,17 @@ static bool change_security(struct bt_att_chan *cha=
n, uint8_t ecode)
>         return bt_att_chan_set_security(chan, security);
>  }
>
> -static bool handle_error_rsp(struct bt_att_chan *chan, uint8_t *pdu,
> +static int handle_error_rsp(struct bt_att_chan *chan, uint8_t *pdu,
>                                         ssize_t pdu_len, uint8_t *opcode)
>  {
>         struct bt_att *att =3D chan->att;
>         const struct bt_att_pdu_error_rsp *rsp;
>         struct att_send_op *op =3D chan->pending_req;
> +       int should_retry =3D BT_ATT_RETRY_NO;
>
>         if (pdu_len !=3D sizeof(*rsp)) {
>                 *opcode =3D 0;
> -               return false;
> +               return should_retry;
>         }
>
>         rsp =3D (void *) pdu;
> @@ -797,11 +815,43 @@ static bool handle_error_rsp(struct bt_att_chan *ch=
an, uint8_t *pdu,
>          * the security again.
>          */
>         if (op->retry)
> -               return false;
> +               return should_retry;
>
>         /* Attempt to change security */
> -       if (!change_security(chan, rsp->ecode))
> -               return false;
> +       if (change_security(chan, rsp->ecode)) {
> +               should_retry =3D BT_ATT_RETRY_YES;
> +       } else if (att->retry_callback) {
> +               should_retry =3D att->retry_callback(op->opcode, rsp->eco=
de,
> +                                                  op->pdu + 1, op->len -=
 1,
> +                                                  op->id, att->retry_dat=
a);
> +
> +               /* Check if callback wants to defer the retry decision */
> +               if (should_retry =3D=3D BT_ATT_RETRY_PENDING) {
> +                       op->retry_pending =3D true;
> +
> +                       /* Store error PDU for later use */
> +                       op->error_pdu =3D malloc(pdu_len);
> +                       if (op->error_pdu) {
> +                               memcpy(op->error_pdu, pdu, pdu_len);
> +                               op->error_pdu_len =3D pdu_len;
> +                       }
> +
> +                       /* Remove timeout since we're waiting for approva=
l */
> +                       if (op->timeout_id) {
> +                               timeout_remove(op->timeout_id);
> +                               op->timeout_id =3D 0;
> +                       }
> +
> +                       /* Move from pending_req to pending_retry */
> +                       chan->pending_retry =3D op;
> +
> +                       DBG(att, "(chan %p) Retry pending for operation %=
p",
> +                           chan, op);
> +               }
> +       }
> +
> +       if (should_retry !=3D BT_ATT_RETRY_YES)
> +               return should_retry;
>
>         /* Remove timeout_id if outstanding */
>         if (op->timeout_id) {
> @@ -815,7 +865,8 @@ static bool handle_error_rsp(struct bt_att_chan *chan=
, uint8_t *pdu,
>         op->retry =3D true;
>
>         /* Push operation back to channel queue */
> -       return queue_push_head(chan->queue, op);
> +       return queue_push_head(chan->queue, op) ?
> +               BT_ATT_RETRY_YES : BT_ATT_RETRY_NO;
>  }
>
>  static void handle_rsp(struct bt_att_chan *chan, uint8_t opcode, uint8_t=
 *pdu,
> @@ -845,9 +896,15 @@ static void handle_rsp(struct bt_att_chan *chan, uin=
t8_t opcode, uint8_t *pdu,
>          */
>         if (opcode =3D=3D BT_ATT_OP_ERROR_RSP) {
>                 /* Return if error response cause a retry */
> -               if (handle_error_rsp(chan, pdu, pdu_len, &req_opcode)) {
> +               switch (handle_error_rsp(chan, pdu, pdu_len, &req_opcode)=
) {
> +               case BT_ATT_RETRY_PENDING:
> +                       /* Operation moved to pending_retry, clear pendin=
g_req */
> +                       chan->pending_req =3D NULL;
> +               case BT_ATT_RETRY_YES:
>                         wakeup_chan_writer(chan, NULL);
>                         return;
> +               default:
> +                       break;
>                 }
>         } else if (!(req_opcode =3D get_req_opcode(opcode)))
>                 goto fail;
> @@ -1142,6 +1199,9 @@ static void bt_att_free(struct bt_att *att)
>         if (att->timeout_destroy)
>                 att->timeout_destroy(att->timeout_data);
>
> +       if (att->retry_destroy)
> +               att->retry_destroy(att->retry_data);
> +
>         if (att->debug_destroy)
>                 att->debug_destroy(att->debug_data);
>
> @@ -1473,6 +1533,23 @@ bool bt_att_set_timeout_cb(struct bt_att *att, bt_=
att_timeout_func_t callback,
>         return true;
>  }
>
> +bool bt_att_set_retry_cb(struct bt_att *att, bt_att_retry_func_t callbac=
k,
> +                                               void *user_data,
> +                                               bt_att_destroy_func_t des=
troy)
> +{
> +       if (!att)
> +               return false;
> +
> +       if (att->retry_destroy)
> +               att->retry_destroy(att->retry_data);
> +
> +       att->retry_callback =3D callback;
> +       att->retry_destroy =3D destroy;
> +       att->retry_data =3D user_data;
> +
> +       return true;
> +}
> +
>  unsigned int bt_att_register_disconnect(struct bt_att *att,
>                                         bt_att_disconnect_func_t callback=
,
>                                         void *user_data,
> @@ -2051,6 +2128,97 @@ bool bt_att_has_crypto(struct bt_att *att)
>         return att->crypto ? true : false;
>  }
>
> +bool bt_att_retry_request(struct bt_att *att, unsigned int id)
> +{
> +       const struct queue_entry *entry;
> +       struct bt_att_chan *chan =3D NULL;
> +       struct att_send_op *op;
> +
> +       if (!att || !id)
> +               return false;
> +
> +       /* Find the channel with the pending retry operation */
> +       for (entry =3D queue_get_entries(att->chans); entry;
> +                                               entry =3D entry->next) {
> +               struct bt_att_chan *c =3D entry->data;
> +
> +               if (c->pending_retry && c->pending_retry->id =3D=3D id &&
> +                   c->pending_retry->retry_pending) {
> +                       chan =3D c;
> +                       op =3D c->pending_retry;
> +                       break;
> +               }
> +       }
> +
> +       if (!chan || !op)
> +               return false;
> +
> +       DBG(att, "(chan %p) Approving retry for operation %p", chan, op);
> +
> +       /* Clear pending retry state and mark for retry */
> +       op->retry_pending =3D false;
> +       op->retry =3D true;
> +       chan->pending_retry =3D NULL;
> +
> +       /* Free stored error PDU as we're retrying */
> +       free(op->error_pdu);
> +       op->error_pdu =3D NULL;
> +       op->error_pdu_len =3D 0;
> +
> +       /* Push operation back to channel queue for retry */
> +       if (!queue_push_head(chan->queue, op))
> +               return false;
> +
> +       /* Wake up writer to send the retry */
> +       wakeup_chan_writer(chan, NULL);
> +
> +       return true;
> +}
> +
> +bool bt_att_cancel_retry(struct bt_att *att, unsigned int id)
> +{
> +       const struct queue_entry *entry;
> +       struct bt_att_chan *chan =3D NULL;
> +       struct att_send_op *op;
> +
> +       if (!att || !id)
> +               return false;
> +
> +       /* Find the channel with the pending retry operation */
> +       for (entry =3D queue_get_entries(att->chans); entry;
> +                                               entry =3D entry->next) {
> +               struct bt_att_chan *c =3D entry->data;
> +
> +               if (c->pending_retry && c->pending_retry->id =3D=3D id &&
> +                   c->pending_retry->retry_pending) {
> +                       chan =3D c;
> +                       op =3D c->pending_retry;
> +                       break;
> +               }
> +       }
> +
> +       if (!chan || !op)
> +               return false;
> +
> +       DBG(att, "(chan %p) Canceling retry for operation %p", chan, op);
> +
> +       /* Clear pending retry state */
> +       op->retry_pending =3D false;
> +       chan->pending_retry =3D NULL;
> +
> +       /* Call the callback with stored error PDU to notify upper layer =
*/
> +       if (op->callback)
> +               op->callback(BT_ATT_OP_ERROR_RSP, op->error_pdu,
> +                            op->error_pdu_len, op->user_data);
> +
> +       destroy_att_send_op(op);
> +
> +       /* Wake up writer in case there are other operations */
> +       wakeup_chan_writer(chan, NULL);
> +
> +       return true;
> +}
> +
>  bool bt_att_set_retry(struct bt_att *att, unsigned int id, bool retry)
>  {
>         struct att_send_op *op;
> diff --git a/src/shared/att.h b/src/shared/att.h
> index 53a3f7a2a..6dc9944bb 100644
> --- a/src/shared/att.h
> +++ b/src/shared/att.h
> @@ -46,6 +46,15 @@ typedef void (*bt_att_disconnect_func_t)(int err, void=
 *user_data);
>  typedef void (*bt_att_exchange_func_t)(uint16_t mtu, void *user_data);
>  typedef bool (*bt_att_counter_func_t)(uint32_t *sign_cnt, void *user_dat=
a);
>
> +/* Return values for bt_att_retry_func_t */
> +#define BT_ATT_RETRY_NO        0       /* Don't retry */
> +#define BT_ATT_RETRY_YES       1       /* Retry immediately */
> +#define BT_ATT_RETRY_PENDING   2       /* Defer retry decision */
> +
> +typedef int (*bt_att_retry_func_t)(uint8_t opcode, uint8_t error_code,
> +                                       const void *pdu, uint16_t length,
> +                                       unsigned int att_id, void *user_d=
ata);
> +
>  bool bt_att_set_debug(struct bt_att *att, uint8_t level,
>                         bt_att_debug_func_t callback, void *user_data,
>                         bt_att_destroy_func_t destroy);
> @@ -58,6 +67,13 @@ bool bt_att_set_timeout_cb(struct bt_att *att, bt_att_=
timeout_func_t callback,
>                                                 void *user_data,
>                                                 bt_att_destroy_func_t des=
troy);
>
> +bool bt_att_set_retry_cb(struct bt_att *att, bt_att_retry_func_t callbac=
k,
> +                                               void *user_data,
> +                                               bt_att_destroy_func_t des=
troy);
> +
> +bool bt_att_retry_request(struct bt_att *att, unsigned int id);
> +bool bt_att_cancel_retry(struct bt_att *att, unsigned int id);

Hmm, why are you not reusing bt_att_resend and bt_att_cancel? We may
need to adapt bt_att_resend to locate the id in the pending_retry and
then force pushing to the queue head but other than that it looks
pretty similar to me, also I don't think it really needs to be sent
over the same channel, since over the air it really is another request
it can be enqueued in the session queue, rather than the channel
queue, just as done with bt_att_resend.

>  unsigned int bt_att_send(struct bt_att *att, uint8_t opcode,
>                                         const void *pdu, uint16_t length,
>                                         bt_att_response_func_t callback,
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
