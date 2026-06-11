Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A32929B77C
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 16:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781194038; cv=pass; b=KMHdDFfZshf9SNHlD32WbLw7IeKm+orRPGPsJZkOrJan/tKA+vmsfBrc2uuH3fQLPee22lEirv0BCgyv+KwHph5AKu5DeFGh1NxiqF1TlQCvJckHxBDc/zET+XkglEtyu+vo10k4gVD+E1KY7ndigic918Dijh/iAVR0ZvYO5TA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781194038; c=relaxed/simple;
	bh=/ftjBnsnpY5ZghAAON0SLt5nPffDmI3mnV1nERgqDHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MROn01CFOu9XNBIoRF3lNHFMfOMpiXNNl5IX2cHrqR7S6T1vyIXcvBrY/ZUmsUtStLFBPnmFBKqEp/2Zw6h6DjPipcCdOvOmxLxRRjPOc72F5sbPzMbWv1WagOYJKXATA2FW+Gs9PsLHPD+DGSW6frdXt70ykuAjkymE4gU7/Eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n8adiful; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n8adiful"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-65eb226b1ceso22131d50.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 09:07:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781194035; cv=none;
        d=google.com; s=arc-20240605;
        b=WoeWGJtnTwfkV8EYUSFJzs9y/VTF+fXPHl6xAMNMK1q98Y2TyCXfi8rJU9zThfbwUo
         3qFocuU4RnSjQVXy9R0D8XwEjhJHmjp9KHqelaR+u/iwn56AkAMxNqHEmE87VHceYldG
         E3GPb2EGqSpHum9dNo84tiKHoJ0t42E3k+44V5txOF8Vb2ZGSqB2Fq32BitqDlbKXkjv
         WNDU9gA9wDI82Ox8Vx+cBDfukparnyjk4N9qH3iQ8isL6KJOOPtzp8myN4I+zAyoEaMo
         gNra5DICOQRITuXQ1TQPvMKq5zG1Z9tExqs+S2zvH8uFwR+fCAV32O/jNPvfuDFmTTrI
         njyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=suARM81E8NPldRHIFVln/EJJE48ilZDEdizCvLB0tPM=;
        fh=tyIoVIdoo3GG6ZRoi/xsrXAAPlFArnFDetdoYcj+VDI=;
        b=g+TjNXx1PcZPm8RsIO+C466hOTT5brO7Ohb1hKYvFriiac8v0fp2UM06zeqfjJkWWQ
         COFOvJkF+U4PMb3Fwo3pI1wRoSucuGJz+qZFgJ+P782Ak7QNcJIFBIR7qMN3vykJzrQg
         XRUqz2ojdRoVotoN9/d7LBFsoydyCODk9yP8VUxosYAFXvvcnX2iwJGdkbkaLk4UkNv/
         ZHBgGl3tSwqXXDbzSaUCPV58f+ep08jf+AWocKpevGVhzbTGx9XNil5eZh5fIkFrMTQd
         fqENMgcijCpJcNTvTZbQUKCEC7Ul+28wkhtpoYcTNv/8Ky7WmxVYfp4k1dg3kLZshp4q
         eymg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781194035; x=1781798835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=suARM81E8NPldRHIFVln/EJJE48ilZDEdizCvLB0tPM=;
        b=n8adiful+jZS6h2m7Vuifo7HgPm9c0SHchlsR9r+ik7yNA29OplHaM6r2cXTDbesos
         Xy2lwQ+nss26OQXfRh+RrxmNxlYMPRRYu0o2XABMiOuf0GIN/s78f2UKWTPR47ZZ5R8I
         SVSInaYLy0sXJGIgne6NChNgD4B8VMi1L++x9YJw+7OVfvsqBhvDeoXkmSaFEWCPx56z
         eYednZ8SohfU0GSyJuOnX5eFN39nadyZnX6Iyq4B3YYShjwDkg7Ic3J6E1HtOS5T7Pb/
         Dj2c9TXbtujzNH6ZKMTzdI8+3hHpzV4Mi2sB1X4GepBRORP7wKqQgPphe+vljHtCg5gD
         0pVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781194035; x=1781798835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=suARM81E8NPldRHIFVln/EJJE48ilZDEdizCvLB0tPM=;
        b=f5ca6OQ+MnA4UxNOnEMpXAp/HfhqoqwvJ5+1N/qHwReURvEoDf33AnthSLzeejOWKG
         InbC/jGmG2Ylp2EixySOb4xil2ItSUmIYjLkK+vUCxEwL38LMPeR+CfUmu5QqKgbawAb
         U9JTR/+IQEHOo6ra3ZA4x8rPUq7qTQS0hssc8rJsaProXV8pPhctJTDAUzf8O7y+ILZo
         MPoeNqAO6NZD7d/gYvfvT4ShOSjyMx4qgMJ00miNiVsXksyxN27g/pysnQzMnp/BoW/l
         oWUH2z4SfkqiXy0BO8ST5epTZWW8Wap+UJ0EyOB05mYjBJ81H5AEsXb4nthV4zx/nB7t
         pFCg==
X-Gm-Message-State: AOJu0YxRH2BXbj0DYffQpe+EkeUWUlihCxY5TD52/6qV7R4mmFNHHTjS
	x1rABOsMwUmtn2VPmnJgE5nGsZv5ccKmC33v7jdTFvirzQIYtNhYca1SGruHPiC1rg5z/ZHurpk
	1nS2B3Wn/QOnWMaGbV+B2q8Brl3wkqWZVV0B5RL0=
X-Gm-Gg: Acq92OHe0LpkLqOxUPwkTuBtYkrg2o9OY0wfgN0SsLzaKAyEv9pmOK6ILO4r8iOLopH
	fUUTQKA48p1U/6TyXNzCwGndBnXyuOqNonwC5wbMVhgUlmSKTZ3ASG5cKNi6PUt1uCxDdY3erht
	vdBNlzYJdDgMx1OHKDHawCh0z2YOOwaZMWVyhutG4Lo//iyW2aKMmU0mXqzqv6RawutRL/ZeR0o
	8H/p8CtSKZ+9WkrmJbOMPCZdJCZIwiRlTFR4cjJWmb4IkbGbAQYs4JI+KgpTU/2ayVpF7VJQLb5
	zyF0v6AEQXz/T0VXPO/E5+FN+OQBytQHA7RPPaRJYIZdWRLk3ggmf8+zASlkB8QdpSXHENbp5Oh
	5Vg==
X-Received: by 2002:a53:b118:0:b0:660:3426:3fe7 with SMTP id
 956f58d0204a3-662699d8088mr2492299d50.52.1781194035455; Thu, 11 Jun 2026
 09:07:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611152039.2176565-1-oss@fourdim.xyz> <CABBYNZJf5fVxkLVWKwXWOdhyrxANBLfF9Rc_1oka-RgW-mx+Ow@mail.gmail.com>
 <c1de98e4-e599-42e2-987e-d1a4a371eac2@app.fastmail.com>
In-Reply-To: <c1de98e4-e599-42e2-987e-d1a4a371eac2@app.fastmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 11 Jun 2026 12:07:04 -0400
X-Gm-Features: AVVi8Ccr76Ze9O1vzse6PwEbQyvoHH0rzo2cD2-UCd5JCWWbMGwecxEsk_pK-z0
Message-ID: <CABBYNZJhy6wXtzWMn3irB2kBm86FnwRCKTVcOcHR6M-WwsANJg@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: hci_conn: Fix null ptr deref in hci_abort_conn()
To: Siwei Zhang <oss@fourdim.xyz>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Siwei,

On Thu, Jun 11, 2026 at 11:51=E2=80=AFAM Siwei Zhang <oss@fourdim.xyz> wrot=
e:
>
> Hi Luiz,
>
> On Thu, Jun 11, 2026, at 11:36 AM, Luiz Augusto von Dentz wrote:
> > Hi Siwei,
> >
> > On Thu, Jun 11, 2026 at 11:20=E2=80=AFAM Siwei Zhang <oss@fourdim.xyz> =
wrote:
> >>
> >> hci_abort_conn() read hci_skb_event(hdev->sent_cmd) when a connection
> >> was pending, but hdev->sent_cmd can be NULL while req_status is still
> >> HCI_REQ_PEND, leading to a NULL pointer dereference and a general
> >> protection fault from the hci_rx_work() receive path.
> >>
> >> Instead of inspecting hdev->sent_cmd, track the in-flight create
> >> connection command with a new per-connection HCI_CONN_CREATE flag and
> >> route all cancellation through hci_cancel_connect_sync(), which dequeu=
es
> >> the command if still queued, or cancels the pending request if this
> >> connection owns the in-flight create command. CIS uses the same path
> >> via the existing HCI_CONN_CREATE_CIS flag.
> >>
> >> Fixes: a13f316e90fd ("Bluetooth: hci_conn: Consolidate code for aborti=
ng connections")
> >> Cc: stable@vger.kernel.org
> >> Assisted-by: Claude:claude-opus-4-8
> >> Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
> >> ---
> >>  include/net/bluetooth/hci_core.h |  1 +
> >>  net/bluetooth/hci_conn.c         | 21 ++--------
> >>  net/bluetooth/hci_sync.c         | 66 ++++++++++++++++++++++++++-----=
-
> >>  3 files changed, 58 insertions(+), 30 deletions(-)
> >>
> >> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/=
hci_core.h
> >> index aa600fbf9a53..aa554c34f9ec 100644
> >> --- a/include/net/bluetooth/hci_core.h
> >> +++ b/include/net/bluetooth/hci_core.h
> >> @@ -988,6 +988,7 @@ enum {
> >>         HCI_CONN_AUTH_FAILURE,
> >>         HCI_CONN_PER_ADV,
> >>         HCI_CONN_BIG_CREATED,
> >> +       HCI_CONN_CREATE,
> >>         HCI_CONN_CREATE_CIS,
> >>         HCI_CONN_CREATE_BIG_SYNC,
> >>         HCI_CONN_BIG_SYNC,
> >> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> >> index 54eabaa46960..eba4a548bef5 100644
> >> --- a/net/bluetooth/hci_conn.c
> >> +++ b/net/bluetooth/hci_conn.c
> >> @@ -3181,26 +3181,11 @@ int hci_abort_conn(struct hci_conn *conn, u8 r=
eason)
> >>
> >>         conn->abort_reason =3D reason;
> >>
> >> -       /* If the connection is pending check the command opcode since=
 that
> >> -        * might be blocking on hci_cmd_sync_work while waiting its re=
spective
> >> -        * event so we need to hci_cmd_sync_cancel to cancel it.
> >> -        *
> >> -        * hci_connect_le serializes the connection attempts so only o=
ne
> >> -        * connection can be in BT_CONNECT at time.
> >> +       /* Cancel the connect attempt. A return of 0 means the create =
command
> >> +        * was still queued and got dequeued, so there is nothing to d=
isconnect.
> >>          */
> >> -       if (conn->state =3D=3D BT_CONNECT && READ_ONCE(hdev->req_statu=
s) =3D=3D HCI_REQ_PEND) {
> >> -               switch (hci_skb_event(hdev->sent_cmd)) {
> >> -               case HCI_EV_CONN_COMPLETE:
> >> -               case HCI_EV_LE_CONN_COMPLETE:
> >> -               case HCI_EV_LE_ENHANCED_CONN_COMPLETE:
> >> -               case HCI_EVT_LE_CIS_ESTABLISHED:
> >> -                       hci_cmd_sync_cancel(hdev, ECANCELED);
> >> -                       break;
> >> -               }
> >> -       /* Cancel connect attempt if still queued/pending */
> >> -       } else if (!hci_cancel_connect_sync(hdev, conn)) {
> >> +       if (!hci_cancel_connect_sync(hdev, conn))
> >>                 return 0;
> >> -       }
> >>
> >>         /* Run immediately if on cmd_sync_work since this may be calle=
d
> >>          * as a result to MGMT_OP_DISCONNECT/MGMT_OP_UNPAIR which does
> >> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> >> index df23245d6ccd..1fe19ddbbc2c 100644
> >> --- a/net/bluetooth/hci_sync.c
> >> +++ b/net/bluetooth/hci_sync.c
> >> @@ -6668,6 +6668,12 @@ static int hci_le_create_conn_sync(struct hci_d=
ev *hdev, void *data)
> >>                                              &own_addr_type);
> >>         if (err)
> >>                 goto done;
> >> +
> >> +       /* Mark create connection in flight so hci_cancel_connect_sync=
() can
> >> +        * cancel it while blocking on the connection complete event.
> >> +        */
> >> +       set_bit(HCI_CONN_CREATE, &conn->flags);
> >> +
> >>         /* Send command LE Extended Create Connection if supported */
> >>         if (use_ext_conn(hdev)) {
> >>                 err =3D hci_le_ext_create_conn_sync(hdev, conn, own_ad=
dr_type);
> >> @@ -6703,6 +6709,8 @@ static int hci_le_create_conn_sync(struct hci_de=
v *hdev, void *data)
> >>                                        conn->conn_timeout, NULL);
> >>
> >>  done:
> >> +       clear_bit(HCI_CONN_CREATE, &conn->flags);
> >> +
> >>         if (err =3D=3D -ETIMEDOUT)
> >>                 hci_le_connect_cancel_sync(hdev, conn, 0x00);
> >>
> >> @@ -6982,10 +6990,19 @@ static int hci_acl_create_conn_sync(struct hci=
_dev *hdev, void *data)
> >>         else
> >>                 cp.role_switch =3D 0x00;
> >>
> >> -       return __hci_cmd_sync_status_sk(hdev, HCI_OP_CREATE_CONN,
> >> -                                       sizeof(cp), &cp,
> >> -                                       HCI_EV_CONN_COMPLETE,
> >> -                                       conn->conn_timeout, NULL);
> >> +       /* Mark create connection in flight so hci_cancel_connect_sync=
() can
> >> +        * cancel it while blocking on the connection complete event.
> >> +        */
> >> +       set_bit(HCI_CONN_CREATE, &conn->flags);
> >> +
> >> +       err =3D __hci_cmd_sync_status_sk(hdev, HCI_OP_CREATE_CONN,
> >> +                                      sizeof(cp), &cp,
> >> +                                      HCI_EV_CONN_COMPLETE,
> >> +                                      conn->conn_timeout, NULL);
> >> +
> >> +       clear_bit(HCI_CONN_CREATE, &conn->flags);
> >> +
> >> +       return err;
> >>  }
> >>
> >>  int hci_connect_acl_sync(struct hci_dev *hdev, struct hci_conn *conn)
> >> @@ -7039,20 +7056,45 @@ int hci_connect_le_sync(struct hci_dev *hdev, =
struct hci_conn *conn)
> >>
> >>  int hci_cancel_connect_sync(struct hci_dev *hdev, struct hci_conn *co=
nn)
> >>  {
> >> -       if (conn->state !=3D BT_OPEN)
> >> -               return -EINVAL;
> >> +       hci_cmd_sync_work_func_t func =3D NULL;
> >> +       hci_cmd_sync_work_destroy_t destroy =3D NULL;
> >> +       int create_flag =3D -1;
> >>
> >>         switch (conn->type) {
> >>         case ACL_LINK:
> >> -               return !hci_cmd_sync_dequeue_once(hdev,
> >> -                                                 hci_acl_create_conn_=
sync,
> >> -                                                 conn, NULL);
> >> +               func =3D hci_acl_create_conn_sync;
> >> +               create_flag =3D HCI_CONN_CREATE;
> >> +               break;
> >>         case LE_LINK:
> >> -               return !hci_cmd_sync_dequeue_once(hdev, hci_le_create_=
conn_sync,
> >> -                                                 conn, create_le_conn=
_complete);
> >> +               func =3D hci_le_create_conn_sync;
> >> +               destroy =3D create_le_conn_complete;
> >> +               create_flag =3D HCI_CONN_CREATE;
> >> +               break;
> >> +       case CIS_LINK:
> >> +               /* LE Create CIS is shared by the whole CIG and cannot=
 be
> >> +                * dequeued per-connection; only cancel it in-flight b=
elow.
> >> +                */
> >> +               create_flag =3D HCI_CONN_CREATE_CIS;
> >> +               break;
> >> +       default:
> >> +               return -ENOENT;
> >>         }
> >>
> >> -       return -ENOENT;
> >> +       /* The create command is in exactly one of two states: still q=
ueued, or
> >> +        * in flight. The create flag is only set once the worker has =
dequeued
> >> +        * the entry and started running it, so the two states are mut=
ually
> >> +        * exclusive. Try to dequeue first: if it succeeds the command=
 had not
> >> +        * started yet and we are done. Otherwise the worker already p=
ulled it
> >> +        * off the queue (the dequeue is a no-op here),
> >
> > This is where I disagree, `dequeue` is not a no-op. It must traverse
> > the list of entries in cmd_sync_work_list, so it is cheaper to check
> > the flag first and then attempt to dequeue.
> >
>
> If we test the flag first and read 0 while the entry is still queued, the=
 worker
> can advance it to in-flight before our dequeue runs.
> In that case we will return without cancelling.

Maybe we need to hold cmd_sync_work_lock to make sure nothing is
changed in the meantime before we dequeue (well dequeue will hold it
but not for the window immeditely after checking the flag).

> I can update the comment saying that it has no effect instead of no-op.
>
> >> +        * owns the in-flight create command, cancel the pending reque=
st.
> >> +        */
> >> +       if (func && hci_cmd_sync_dequeue_once(hdev, func, conn, destro=
y))
> >> +               return 0;
> >> +
> >> +       if (create_flag >=3D 0 && test_bit(create_flag, &conn->flags))
> >> +               hci_cmd_sync_cancel(hdev, ECANCELED);
> >> +
> >> +       return -EBUSY;
> >>  }
> >>
> >>  int hci_le_conn_update_sync(struct hci_dev *hdev, struct hci_conn *co=
nn,
> >> --
> >> 2.54.0
> >>
> >
> >
> > --
> > Luiz Augusto von Dentz
>
> Best,
> Siwei



--=20
Luiz Augusto von Dentz
