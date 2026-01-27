Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065EC27FB35
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 15:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769528163; cv=pass; b=tMOuoQFvsPKB8ci+iu62jsBEsDohkC/etYX0mpqfgP7CKJMN1ngPd2orM5IqY4jRGkQ5b69EM/cbY8ga853kbnuY2obDR4d0+4plY3BrC4MtuYtoLs+Dfn2p+37UcO74Ge7fcTOusnLlVm8LxLK7WDGjO7jo7aiWizqX3GkCh7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769528163; c=relaxed/simple;
	bh=scS8mmD2i1hDf2F++ys4CdSlzih98Wo1W1g2Eb+nWGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GWSBDl9bCCsUdhWrk4woubgi0oHOy7TEYNGBia3AIUTbgfjQ4/BbrCoWH5vl55WTZQpHLxbOebzuCv1sxZfSlQy7hoKC6gZx3Q+HTw5xEPn9W1CQeWImNyJxe0CJCTxy95cMrTxp9XjBbccL1t00AF76PEFyRMinjCesDYSuffM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/9J6xrF; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/9J6xrF"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7927261a3acso63184527b3.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 07:36:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769528161; cv=none;
        d=google.com; s=arc-20240605;
        b=aDMm+WXRGpZ0kEJAhKmovAidV757nnOrxSm9ZUF9lDWKjjf8iQ3Nf4KvW7JPtHXTs2
         0XdH34s+4AuCGalBM8OGevhHfGfyJDNUw6MRhDkRqa/9CkQGuXB3/N/XVTvvhbCOddJ/
         jM7YnTvOLKssCQM50/s5O6julvV/KClGprC4Tzhc1cwFz7g0ke6tQ8RS7KBU12KP7c6U
         UhC62pBKVE5/qt8aCS63Vi0sWz6f0w8CoM8nrkJcLXE7WWjtKGQa6tHOHGMXLTWrb8hA
         y0mt1Rq5xd+8vo83EAuVCg0EO9ehoaHAzbgfFTr4jzUVoQ6dgvTOBwH5ira1aChHhZBf
         MImA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lfw+6jjpL1nC3rcOQtPanpHAu4c5vkZ+XRl9u2m0zE8=;
        fh=fXWXWrmQVmO8a3ItkADHjf2Px6vrJt4Rn10LLYlU1ZQ=;
        b=RQvOecYwQcAptF3TyzmRZemH5vdF/pzdTlSKWjDfaQnbyHmz+BXqO0nv1I88HzbJqg
         PByiZscVVunpKsOYl8zZo3gcx4tyltbO+8BZefrtdwXUDhZQ23qLyj9Njp2tuNza87cO
         oGImhbEPiFC0wfNryq4mVuP7CeVVceNXtPv+fYccoYS/RCrSxjqKdhw3SBb+YNhCzM9q
         jdE+PJkrUJVPM2b9QELgafjm/2TtJvYGjPsscmWX9FjvXeyV3omj9osBz4PzdMpJ3dZn
         eaE0DvLwYE3s1WbO8kRwOY2tGPaoM7UlEvH2DbNvjtKZDytA73FI+H65N43+LjLIGzQc
         9rzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769528161; x=1770132961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfw+6jjpL1nC3rcOQtPanpHAu4c5vkZ+XRl9u2m0zE8=;
        b=Z/9J6xrFM4WOl45kzUgLFYQx+7hezyEXvzpA4U2qe8vG+ARtvUlMtG7nJTvXJTN7P5
         hTy27I7N4D58nh18FbBuEvlmn+dcJ64jPLyElecA4qjOWn9YY6VBwChwHdUJKFjQoeqv
         tDWmdivczkt3bxi97uPoV6JZqdJu+vBvrcqC+Eid//mh4TuLdgBvBDxIb8a9xBaxNAvd
         Zqx3G/7gvsbPSJ2gME8IRRviamPJpwqQT77AgDYZ/Und6+/+3wz4aOHA8L2IyMQjh61T
         rBsAxDi/1hbmae7wiZUsq819VpuiQ+xFmTWdPJx7pKwd7ERictS0samhGL16iTzcux5G
         tTlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769528161; x=1770132961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lfw+6jjpL1nC3rcOQtPanpHAu4c5vkZ+XRl9u2m0zE8=;
        b=FdwrLVluCVafqMAcyCwhl/vBIQa6fb0JRjjZZ9UwCFn+A9pTlifGhc4nUPUNl7AKto
         0ZnC9QMfkJ659HbhilUQjulLq5Hsrd3MkOSesJvVZxxj3FU/dmd32OM5PrEtuPdWxehs
         fWp+Qc8PNkR2yMyCceByiMGP+6dbFGCKdVPFn1OO39h0fB/cF9aspkL/tMzu9H/xo7xG
         mrUua9wNxdMARGunrp9CwZAZvJi2vZKq4j5n2jhfVqsk9bjNOKb1TUOCeORJZ/s3X/br
         Lc6c+ssr3QRp+LXDOmVWI952YsOuMhKfk5q8WMQ+HtGyTsJymY6uz+TZI2EaSbR3F8WG
         qggA==
X-Gm-Message-State: AOJu0YyWM2t1tQxPfXZjMrlYHd3w8EGk0yNe18HpKiadWbeiKmgTByNB
	hgFeewvWfxEc9uRRAQiFNv+16VCqJ95Pam+PV2aBcXJF0QIaCLkNklpN6IyIuObGofelZhiqwzK
	jBVFtH1SHW2rAvNqcvgAby4zEOTTD6VE=
X-Gm-Gg: AZuq6aIllvwF7jeF/euLU4otQtIavCUaKd0qvQEsZcEr1ME+TfPdYZQzZI6fp3o2lxC
	NA1g5yd18YbMGl61PmtD58P4hPfYnwC80ry3sWZUeVwNsExt0RL+utdflg6B1eMVerGTJaoUjsK
	de/tbIRMlznU0vBXqDGcqCEmrKBpTKZU6rbYFlp8+SOdNxiiMfusZfrmuDO4dkJ8aLfJpvVT6JY
	52cGdRqndeb2kN0XE4o7dfVZHzq8DM1ECbIw2kBX3/l05S+NcV7YwCe/VLoBnj3nWQNOk6UFP7K
	t2gNH9Xxo58ohPTBQQPL1+bId10U7ciA0nNVB9YRCZRs5sP8GCWsC1MJwkZmlqUxRg==
X-Received: by 2002:a05:690c:60c4:b0:794:7b60:77f9 with SMTP id
 00721157ae682-7947b608e85mr13853087b3.61.1769528160655; Tue, 27 Jan 2026
 07:36:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121083804.4010106-1-mengshi.wu@oss.qualcomm.com>
 <20260121083804.4010106-2-mengshi.wu@oss.qualcomm.com> <CABBYNZJwuqc3=scrzx+iqYBKr+7C4o5ARFy2V9KtOU4rqcL1ew@mail.gmail.com>
 <80008178-352b-41ca-9a4f-65662a099b13@oss.qualcomm.com>
In-Reply-To: <80008178-352b-41ca-9a4f-65662a099b13@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 27 Jan 2026 10:35:48 -0500
X-Gm-Features: AZwV_Qi_cCaYiK55ekdYQ-XdhPgjLOyjA2AFGPidD0otUmYLo7ePF5NjWVjVU50
Message-ID: <CABBYNZKrsOnkaRDD7AJSAPjgyXaFxCyksnvYZF6s23WfGs4nJA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] shared/att: Implement ATT error retry mechanism
 with callback support
To: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com, 
	cheng.jiang@oss.qualcomm.com, chezhou@qti.qualcomm.com, 
	wei.deng@oss.qualcomm.com, yiboz@qti.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 26, 2026 at 5:44=E2=80=AFAM Mengshi Wu <mengshi.wu@oss.qualcomm=
.com> wrote:
>
> Hi Luiz,
>
> Thanks for your comments.
>
> On 1/22/2026 2:15 AM, Luiz Augusto von Dentz wrote:
> > Hi Mengshi,
> >
> > On Wed, Jan 21, 2026 at 3:38=E2=80=AFAM Mengshi Wu <mengshi.wu@oss.qual=
comm.com> wrote:
> >>
> >> Add a retry mechanism for ATT operations that allows upper layers to
> >> decide whether to retry failed requests. This includes:
> >>
> >> - Add retry callback registration (bt_att_set_retry_cb) to allow
> >>   applications to handle retry decisions
> >> - Implement pending_retry state tracking in att_send_op to store
> >>   operations awaiting retry approval
> >> - Add bt_att_retry_request() and bt_att_cancel_retry() functions to
> >>   approve or reject retry attempts
> >> - Store error PDUs during retry_pending state for callback inspection
> >> - Modify handle_error_rsp() to return retry decision codes instead of
> >>   boolean values
> >> - Add BT_ATT_RETRY_* constants for retry decision handling
> >> - Update GATT helpers to support retry callbacks for operations like
> >>   discovery and read/write requests
> >>
> >> This enables more robust error handling by allowing the application
> >> layer to implement custom retry logic based on ATT error codes.
> >>
> >> Signed-off-by: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
> >> ---
> >>  src/shared/att.c | 182 +++++++++++++++++++++++++++++++++++++++++++++-=
-
> >>  src/shared/att.h |  16 +++++
> >>  2 files changed, 191 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/src/shared/att.c b/src/shared/att.c
> >> index 77ca4aa24..4ae97530a 100644
> >> --- a/src/shared/att.c
> >> +++ b/src/shared/att.c
> >> @@ -47,6 +47,7 @@ struct bt_att_chan {
> >>
> >>         struct att_send_op *pending_req;
> >>         struct att_send_op *pending_ind;
> >> +       struct att_send_op *pending_retry;
> >>         bool writer_active;
> >>
> >>         bool in_req;                    /* There's a pending incoming =
request */
> >> @@ -78,6 +79,10 @@ struct bt_att {
> >>         bt_att_destroy_func_t timeout_destroy;
> >>         void *timeout_data;
> >>
> >> +       bt_att_retry_func_t retry_callback;
> >> +       bt_att_destroy_func_t retry_destroy;
> >> +       void *retry_data;
> >
> > Why do we need these fields? The bt_att_chan already have this data as
> > part of pending_retry, so this sound duplicated to me, or is this this
> > just to register for retry callback?
>
> These fields serve different purposes. The callback in att_send_op
> (pending_retry in bt_att_chan) is triggered too late to handle a deferred
> retry. By the time this callback is executed, the retry opportunity has
> already been lost. Therefore, I added this new callback that checks wheth=
er
> a retry is pending beforehand.

Don't really understand, it seems to me that the retry callback here
is not used for retrying but instead to check if a request needs
retrying by upper layer (gatt-client).

> >
> >> +
> >>         uint8_t debug_level;
> >>         bt_att_debug_func_t debug_callback;
> >>         bt_att_destroy_func_t debug_destroy;
> >> @@ -194,6 +199,9 @@ struct att_send_op {
> >>         void *pdu;
> >>         uint16_t len;
> >>         bool retry;
> >> +       bool retry_pending;  /* Waiting for approval to retry */
> >> +       uint8_t *error_pdu;  /* Stored error PDU for retry_pending */
> >> +       uint16_t error_pdu_len;
> >
> > These fields are definitely not needed, juist reuse pdu, len and retry
> > fields, you are already adding a dedicated field for them in
> > bt_att_chan.pending_retry.
>
> These fields store the received error=E2=80=91response PDU, not the origi=
nal ATT
> request PDU, which is already kept in the pdu/len fields. We need to keep
> the error information because, if recovery fails, the error will be
> propagated to the upper layer.

Well, afaik there is only one error that needs this sort of handling,
so this is suboptimal at best, I would assume if could just use the
chan.pending_db_sync to store the pending op and that already tell
exactly what it is for, rather than using a generic retry mechanism
which we don't know we will need in the future.

>
> >
> >>         bt_att_response_func_t callback;
> >>         bt_att_destroy_func_t destroy;
> >>         void *user_data;
> >> @@ -210,6 +218,7 @@ static void destroy_att_send_op(void *data)
> >>                 op->destroy(op->user_data);
> >>
> >>         free(op->pdu);
> >> +       free(op->error_pdu);
> >>         free(op);
> >>  }
> >>
> >> @@ -644,6 +653,9 @@ static void bt_att_chan_free(void *data)
> >>         if (chan->pending_ind)
> >>                 destroy_att_send_op(chan->pending_ind);
> >>
> >> +       if (chan->pending_retry)
> >> +               destroy_att_send_op(chan->pending_retry);
> >> +
> >>         queue_destroy(chan->queue, destroy_att_send_op);
> >>
> >>         io_destroy(chan->io);
> >> @@ -682,6 +694,11 @@ static bool disconnect_cb(struct io *io, void *us=
er_data)
> >>                 chan->pending_ind =3D NULL;
> >>         }
> >>
> >> +       if (chan->pending_retry) {
> >> +               disc_att_send_op(chan->pending_retry);
> >> +               chan->pending_retry =3D NULL;
> >> +       }
> >> +
> >>         bt_att_chan_free(chan);
> >>
> >>         /* Don't run disconnect callback if there are channels left */
> >> @@ -777,16 +794,17 @@ static bool change_security(struct bt_att_chan *=
chan, uint8_t ecode)
> >>         return bt_att_chan_set_security(chan, security);
> >>  }
> >>
> >> -static bool handle_error_rsp(struct bt_att_chan *chan, uint8_t *pdu,
> >> +static int handle_error_rsp(struct bt_att_chan *chan, uint8_t *pdu,
> >>                                         ssize_t pdu_len, uint8_t *opco=
de)
> >>  {
> >>         struct bt_att *att =3D chan->att;
> >>         const struct bt_att_pdu_error_rsp *rsp;
> >>         struct att_send_op *op =3D chan->pending_req;
> >> +       int should_retry =3D BT_ATT_RETRY_NO;
> >>
> >>         if (pdu_len !=3D sizeof(*rsp)) {
> >>                 *opcode =3D 0;
> >> -               return false;
> >> +               return should_retry;
> >>         }
> >>
> >>         rsp =3D (void *) pdu;
> >> @@ -797,11 +815,43 @@ static bool handle_error_rsp(struct bt_att_chan =
*chan, uint8_t *pdu,
> >>          * the security again.
> >>          */
> >>         if (op->retry)
> >> -               return false;
> >> +               return should_retry;
> >>
> >>         /* Attempt to change security */
> >> -       if (!change_security(chan, rsp->ecode))
> >> -               return false;
> >> +       if (change_security(chan, rsp->ecode)) {
> >> +               should_retry =3D BT_ATT_RETRY_YES;
> >> +       } else if (att->retry_callback) {
> >> +               should_retry =3D att->retry_callback(op->opcode, rsp->=
ecode,
> >> +                                                  op->pdu + 1, op->le=
n - 1,
> >> +                                                  op->id, att->retry_=
data);
> >> +
> >> +               /* Check if callback wants to defer the retry decision=
 */
> >> +               if (should_retry =3D=3D BT_ATT_RETRY_PENDING) {
> >> +                       op->retry_pending =3D true;
> >> +
> >> +                       /* Store error PDU for later use */
> >> +                       op->error_pdu =3D malloc(pdu_len);
> >> +                       if (op->error_pdu) {
> >> +                               memcpy(op->error_pdu, pdu, pdu_len);
> >> +                               op->error_pdu_len =3D pdu_len;
> >> +                       }
> >> +
> >> +                       /* Remove timeout since we're waiting for appr=
oval */
> >> +                       if (op->timeout_id) {
> >> +                               timeout_remove(op->timeout_id);
> >> +                               op->timeout_id =3D 0;
> >> +                       }
> >> +
> >> +                       /* Move from pending_req to pending_retry */
> >> +                       chan->pending_retry =3D op;
> >> +
> >> +                       DBG(att, "(chan %p) Retry pending for operatio=
n %p",
> >> +                           chan, op);
> >> +               }
> >> +       }
> >> +
> >> +       if (should_retry !=3D BT_ATT_RETRY_YES)
> >> +               return should_retry;
> >>
> >>         /* Remove timeout_id if outstanding */
> >>         if (op->timeout_id) {
> >> @@ -815,7 +865,8 @@ static bool handle_error_rsp(struct bt_att_chan *c=
han, uint8_t *pdu,
> >>         op->retry =3D true;
> >>
> >>         /* Push operation back to channel queue */
> >> -       return queue_push_head(chan->queue, op);
> >> +       return queue_push_head(chan->queue, op) ?
> >> +               BT_ATT_RETRY_YES : BT_ATT_RETRY_NO;
> >>  }
> >>
> >>  static void handle_rsp(struct bt_att_chan *chan, uint8_t opcode, uint=
8_t *pdu,
> >> @@ -845,9 +896,15 @@ static void handle_rsp(struct bt_att_chan *chan, =
uint8_t opcode, uint8_t *pdu,
> >>          */
> >>         if (opcode =3D=3D BT_ATT_OP_ERROR_RSP) {
> >>                 /* Return if error response cause a retry */
> >> -               if (handle_error_rsp(chan, pdu, pdu_len, &req_opcode))=
 {
> >> +               switch (handle_error_rsp(chan, pdu, pdu_len, &req_opco=
de)) {
> >> +               case BT_ATT_RETRY_PENDING:
> >> +                       /* Operation moved to pending_retry, clear pen=
ding_req */
> >> +                       chan->pending_req =3D NULL;
> >> +               case BT_ATT_RETRY_YES:
> >>                         wakeup_chan_writer(chan, NULL);
> >>                         return;
> >> +               default:
> >> +                       break;
> >>                 }
> >>         } else if (!(req_opcode =3D get_req_opcode(opcode)))
> >>                 goto fail;
> >> @@ -1142,6 +1199,9 @@ static void bt_att_free(struct bt_att *att)
> >>         if (att->timeout_destroy)
> >>                 att->timeout_destroy(att->timeout_data);
> >>
> >> +       if (att->retry_destroy)
> >> +               att->retry_destroy(att->retry_data);
> >> +
> >>         if (att->debug_destroy)
> >>                 att->debug_destroy(att->debug_data);
> >>
> >> @@ -1473,6 +1533,23 @@ bool bt_att_set_timeout_cb(struct bt_att *att, =
bt_att_timeout_func_t callback,
> >>         return true;
> >>  }
> >>
> >> +bool bt_att_set_retry_cb(struct bt_att *att, bt_att_retry_func_t call=
back,
> >> +                                               void *user_data,
> >> +                                               bt_att_destroy_func_t =
destroy)
> >> +{
> >> +       if (!att)
> >> +               return false;
> >> +
> >> +       if (att->retry_destroy)
> >> +               att->retry_destroy(att->retry_data);
> >> +
> >> +       att->retry_callback =3D callback;
> >> +       att->retry_destroy =3D destroy;
> >> +       att->retry_data =3D user_data;
> >> +
> >> +       return true;
> >> +}
> >> +
> >>  unsigned int bt_att_register_disconnect(struct bt_att *att,
> >>                                         bt_att_disconnect_func_t callb=
ack,
> >>                                         void *user_data,
> >> @@ -2051,6 +2128,97 @@ bool bt_att_has_crypto(struct bt_att *att)
> >>         return att->crypto ? true : false;
> >>  }
> >>
> >> +bool bt_att_retry_request(struct bt_att *att, unsigned int id)
> >> +{
> >> +       const struct queue_entry *entry;
> >> +       struct bt_att_chan *chan =3D NULL;
> >> +       struct att_send_op *op;
> >> +
> >> +       if (!att || !id)
> >> +               return false;
> >> +
> >> +       /* Find the channel with the pending retry operation */
> >> +       for (entry =3D queue_get_entries(att->chans); entry;
> >> +                                               entry =3D entry->next)=
 {
> >> +               struct bt_att_chan *c =3D entry->data;
> >> +
> >> +               if (c->pending_retry && c->pending_retry->id =3D=3D id=
 &&
> >> +                   c->pending_retry->retry_pending) {
> >> +                       chan =3D c;
> >> +                       op =3D c->pending_retry;
> >> +                       break;
> >> +               }
> >> +       }
> >> +
> >> +       if (!chan || !op)
> >> +               return false;
> >> +
> >> +       DBG(att, "(chan %p) Approving retry for operation %p", chan, o=
p);
> >> +
> >> +       /* Clear pending retry state and mark for retry */
> >> +       op->retry_pending =3D false;
> >> +       op->retry =3D true;
> >> +       chan->pending_retry =3D NULL;
> >> +
> >> +       /* Free stored error PDU as we're retrying */
> >> +       free(op->error_pdu);
> >> +       op->error_pdu =3D NULL;
> >> +       op->error_pdu_len =3D 0;
> >> +
> >> +       /* Push operation back to channel queue for retry */
> >> +       if (!queue_push_head(chan->queue, op))
> >> +               return false;
> >> +
> >> +       /* Wake up writer to send the retry */
> >> +       wakeup_chan_writer(chan, NULL);
> >> +
> >> +       return true;
> >> +}
> >> +
> >> +bool bt_att_cancel_retry(struct bt_att *att, unsigned int id)
> >> +{
> >> +       const struct queue_entry *entry;
> >> +       struct bt_att_chan *chan =3D NULL;
> >> +       struct att_send_op *op;
> >> +
> >> +       if (!att || !id)
> >> +               return false;
> >> +
> >> +       /* Find the channel with the pending retry operation */
> >> +       for (entry =3D queue_get_entries(att->chans); entry;
> >> +                                               entry =3D entry->next)=
 {
> >> +               struct bt_att_chan *c =3D entry->data;
> >> +
> >> +               if (c->pending_retry && c->pending_retry->id =3D=3D id=
 &&
> >> +                   c->pending_retry->retry_pending) {
> >> +                       chan =3D c;
> >> +                       op =3D c->pending_retry;
> >> +                       break;
> >> +               }
> >> +       }
> >> +
> >> +       if (!chan || !op)
> >> +               return false;
> >> +
> >> +       DBG(att, "(chan %p) Canceling retry for operation %p", chan, o=
p);
> >> +
> >> +       /* Clear pending retry state */
> >> +       op->retry_pending =3D false;
> >> +       chan->pending_retry =3D NULL;
> >> +
> >> +       /* Call the callback with stored error PDU to notify upper lay=
er */
> >> +       if (op->callback)
> >> +               op->callback(BT_ATT_OP_ERROR_RSP, op->error_pdu,
> >> +                            op->error_pdu_len, op->user_data);
> >> +
> >> +       destroy_att_send_op(op);
> >> +
> >> +       /* Wake up writer in case there are other operations */
> >> +       wakeup_chan_writer(chan, NULL);
> >> +
> >> +       return true;
> >> +}
> >> +
> >>  bool bt_att_set_retry(struct bt_att *att, unsigned int id, bool retry=
)
> >>  {
> >>         struct att_send_op *op;
> >> diff --git a/src/shared/att.h b/src/shared/att.h
> >> index 53a3f7a2a..6dc9944bb 100644
> >> --- a/src/shared/att.h
> >> +++ b/src/shared/att.h
> >> @@ -46,6 +46,15 @@ typedef void (*bt_att_disconnect_func_t)(int err, v=
oid *user_data);
> >>  typedef void (*bt_att_exchange_func_t)(uint16_t mtu, void *user_data)=
;
> >>  typedef bool (*bt_att_counter_func_t)(uint32_t *sign_cnt, void *user_=
data);
> >>
> >> +/* Return values for bt_att_retry_func_t */
> >> +#define BT_ATT_RETRY_NO        0       /* Don't retry */
> >> +#define BT_ATT_RETRY_YES       1       /* Retry immediately */
> >> +#define BT_ATT_RETRY_PENDING   2       /* Defer retry decision */
> >> +
> >> +typedef int (*bt_att_retry_func_t)(uint8_t opcode, uint8_t error_code=
,
> >> +                                       const void *pdu, uint16_t leng=
th,
> >> +                                       unsigned int att_id, void *use=
r_data);
> >> +
> >>  bool bt_att_set_debug(struct bt_att *att, uint8_t level,
> >>                         bt_att_debug_func_t callback, void *user_data,
> >>                         bt_att_destroy_func_t destroy);
> >> @@ -58,6 +67,13 @@ bool bt_att_set_timeout_cb(struct bt_att *att, bt_a=
tt_timeout_func_t callback,
> >>                                                 void *user_data,
> >>                                                 bt_att_destroy_func_t =
destroy);
> >>
> >> +bool bt_att_set_retry_cb(struct bt_att *att, bt_att_retry_func_t call=
back,
> >> +                                               void *user_data,
> >> +                                               bt_att_destroy_func_t =
destroy);
> >> +
> >> +bool bt_att_retry_request(struct bt_att *att, unsigned int id);
> >> +bool bt_att_cancel_retry(struct bt_att *att, unsigned int id);
> >
> > Hmm, why are you not reusing bt_att_resend and bt_att_cancel? We may
> > need to adapt bt_att_resend to locate the id in the pending_retry and
> > then force pushing to the queue head but other than that it looks
> > pretty similar to me, also I don't think it really needs to be sent
> > over the same channel, since over the air it really is another request
> > it can be enqueued in the session queue, rather than the channel
> > queue, just as done with bt_att_resend.
> >
>
> I did not reuse bt_att_resend() because it requires the original PDU and
> respose callback as parameters, and these are not stored in the upper lay=
er.
> As discussed earlier, we moved these parts into att.c so that we can reus=
e
> the relevant logic there.

Well you can still use it internally though, instead of duplicating
most of its logic in a new function, anyway why does it needs to be
called from upper layer? I though the retry_callback would be used to
communicate to the upper layer about an error and then depending on
the return of the callback we could resend the request directly in
att.c.

Maybe something like the following works better:

typedef bool (*bt_att_out_of_sync_func_t)(uint8_t opcode,
                                      const void *pdu, uint16_t length,
                                       unsigned int att_id, void *user_data=
);

So if the upper layer return true it means the request should be
resend, otherwise bt_att_response_func_t should be called.

> bt_att_cancel() can be reused with a few adaptations. I will remove
> bt_att_cancel_retry().
>
> It does't need to be sent over the same channel, I just want to reuse an
> existing op. I noticed that handle_error_rsp() does this.
>
> >>  unsigned int bt_att_send(struct bt_att *att, uint8_t opcode,
> >>                                         const void *pdu, uint16_t leng=
th,
> >>                                         bt_att_response_func_t callbac=
k,
> >> --
> >> 2.34.1
> >>
> >
> >
>
> Best regards,
> Mengshi Wu



--=20
Luiz Augusto von Dentz
