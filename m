Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E772BEFEB
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 15:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781193119; cv=none; b=fao5XDYpI8NUomrCMY8tR/zgKnTyd9fkrcDlZBqwgp0JK93OUdIjEzy8wSOzUcGk5qcDlR++f/YZavBPDQ0ZdP+aNC7qZhTKYS2pTw0i60Gih328p+klcJDZHbLNlPoaVPOFu6T2qkeNFALscpYdp5IcWAiKNAwPRJXkdCBhneE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781193119; c=relaxed/simple;
	bh=sYFxLuT5Ox/t4zLGUpQTh2LgnoOqo3ebvQbv2hBTlB0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=igdcACKYe23BDrykLpfuIZN/CFNEGEyTK29ZMZQ3s638x70uxr6KQzOWcy+Yu+XgaGAbXm8e69I9acWyljn1HK/OwVQmRdTTom98ZZznSPlf1tFaRTjuOmIsHnj55KWBYXU6vu0jZ68eoErYAKNpB6QLODjN9tdJ1/44RXcyN+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=SzzhWhZs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MtfjfHiJ; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="SzzhWhZs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MtfjfHiJ"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B3DE31400042;
	Thu, 11 Jun 2026 11:51:56 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-03.internal (MEProxy); Thu, 11 Jun 2026 11:51:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781193116;
	 x=1781279516; bh=IPSGdle5gewwFQ/p3erXOpwOoLpIpJIZLzWugFnHt+8=; b=
	SzzhWhZszMWpWUeeEnnaWXF5gfd0/CKsNOfs7MdcKwMYqpEGNzMa/ThjQXNdXl4d
	E3aEMzgGHvK/9ae8oTJ/DrmHYZLYyp/GHIJV2f7xr+9/WCfK1rjqcvbJvUZrR6LD
	tO9eOKKXYLXFnDYOXWra/q25e9lIOXbRTKM98IHV6mwQq1uYp8Ee6Sg7Nr1X2RVr
	l0cf9XBByTXjZhqix/FpFXnNUFcMF+UtD5p6qKxZW/VuV1Yt8vbQkJuD0OUK/1o2
	rPhSipwrS81JgbH0DF1WQRF7ms8Xf2TxHIyAHMa6uvJccYg4rHJFLs7YPkT6+BsX
	c+uH8MvSvD2Kt+kYLbg5tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781193116; x=
	1781279516; bh=IPSGdle5gewwFQ/p3erXOpwOoLpIpJIZLzWugFnHt+8=; b=M
	tfjfHiJSjiGXdiKMVjNVhepOxeS7pmQ7lEhQTtFseN/d7rovU0zgmHX0wbXcosbB
	RZaAqhgNyTGv16N+dDQmJ/ZCqUtjshGBZXQEBLOACOEVwK9vChwWEcWqATGDHiSQ
	cza1mwvD4EjswjRd5xjQbJomtX1/ykhKJVpOOw5DK5AhnZYCqZBd14sjq+ei0FCH
	uQNeMg5aUsrY9mu4Qwww9sD33z2gdb9BgTIDNVdIcJeRf97naKWI/BBBzTsn1RJb
	Rf/ilOTSXwtOP0xBRRoMvCxSxWuRXL6MKi80cl2hCqY8gbu/jsDoj99Xfkxw5pWa
	OFhiemnnelKPg/AWoBVSQ==
X-ME-Sender: <xms:nNkqanFYM716cDyl0S7Kzcc2UfkKyuw4c3Do1yO4BKbqkZNmYp8CBw>
    <xme:nNkqavIBDRLVUzKAJOyXwTPtoQVa001sjMT0big-0fP2_7dkUis4IvaJkmns1XgCi
    M6MB2SP_4g_j21QJ53aKskEnH7B9NLhc2_NEaotsStYOPfc8MuUzg>
X-ME-Proxy-Cause: dmFkZTGkcA26IHk+0jzlqh+d8Zb6hqStQLn8XWI2qgTjwbXdsCpOUJWtG06y0hRBnlczO1
    kn0MgM/FF136nQvIMZHAMR2mk66QPE+yqcimpR6CwqiPvZyXbpTFRctUeKK4/adD7M2NSr
    ameLO0YMtg3wloo+dO2qpekHmu+EO15AetqA7Yo1MB/r7JCUhAWjVN7MGsl4u3vF0Yv230
    ITkkQzpaGriameEOs++yRLUcX+YoVyC6dX1ILSe7lcOWbLHwX6rucKbmOr7yJwLG5XvQvz
    0zDycTCzFCmC+4mRg2Yh52S6kM4KPv1uEQf6bvu64waldo4jNpjvOxkqwD1/UV6bxqFWPf
    qXrVLk3RRJw0HJ8pkAOK9Q2t0wgedtiA0Mi1pRv5lgIxGJzF0Tr3qxPfPzunQJhg2aeVXT
    hPTBBkwR3ygeEqdixw4l/Ysn8gbxJRULpMYauzVq7KJEQOIKlTfrc0dGslzgq8tECezdif
    uuYALhUP/0D32LkGmz3jW9sxlU7lvSD2Mdmq68BnGuYmjTq5iU7QYIVhJl9JqLWb7YYykt
    OR83PpTd/atKcP6qVy0K2fQuvDq45z1kYZ8crd8OWqFbhy/xDrHn5Pt5xGQ9l5LEQ0zTtr
    BIbtjbuOY2KUvfPQwlbSbyvGp/FQ+H8Ok3lecgxD+0E8lAJOJSKwTE1ErAZA
X-ME-Proxy: <xmx:nNkqaty9ON9mLZHF-h0Zu5Jwd5igeJKFeN1LsioEvQwlJ6dxWW38ng>
    <xmx:nNkqarPHZvyhfLCflZ4mIpxvhQW3AGkB6Zc6XmA-wU594v2HiYD9XA>
    <xmx:nNkqau5W-Av-aMCcVTHMEUi_joxr_izUlcEaFxoz9dvy2Wso3foUGg>
    <xmx:nNkqasPC1lsdEpRA7erUDDSgGblwYxFu3JKPvPeYmjxo5UgXmZ0ORQ>
    <xmx:nNkqar7kS3VJ5LrbhbA6KTRZ_thtPvRl_N8E5ZmlE_Gzy-1i0QRGLyPI>
Feedback-ID: if72e4b10:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 875E0216008A; Thu, 11 Jun 2026 11:51:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AyaPtLk80PWF
Date: Thu, 11 Jun 2026 11:51:34 -0400
From: "Siwei Zhang" <oss@fourdim.xyz>
To: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <c1de98e4-e599-42e2-987e-d1a4a371eac2@app.fastmail.com>
In-Reply-To: 
 <CABBYNZJf5fVxkLVWKwXWOdhyrxANBLfF9Rc_1oka-RgW-mx+Ow@mail.gmail.com>
References: <20260611152039.2176565-1-oss@fourdim.xyz>
 <CABBYNZJf5fVxkLVWKwXWOdhyrxANBLfF9Rc_1oka-RgW-mx+Ow@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: hci_conn: Fix null ptr deref in hci_abort_conn()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Thu, Jun 11, 2026, at 11:36 AM, Luiz Augusto von Dentz wrote:
> Hi Siwei,
>
> On Thu, Jun 11, 2026 at 11:20=E2=80=AFAM Siwei Zhang <oss@fourdim.xyz>=
 wrote:
>>
>> hci_abort_conn() read hci_skb_event(hdev->sent_cmd) when a connection
>> was pending, but hdev->sent_cmd can be NULL while req_status is still
>> HCI_REQ_PEND, leading to a NULL pointer dereference and a general
>> protection fault from the hci_rx_work() receive path.
>>
>> Instead of inspecting hdev->sent_cmd, track the in-flight create
>> connection command with a new per-connection HCI_CONN_CREATE flag and
>> route all cancellation through hci_cancel_connect_sync(), which deque=
ues
>> the command if still queued, or cancels the pending request if this
>> connection owns the in-flight create command. CIS uses the same path
>> via the existing HCI_CONN_CREATE_CIS flag.
>>
>> Fixes: a13f316e90fd ("Bluetooth: hci_conn: Consolidate code for abort=
ing connections")
>> Cc: stable@vger.kernel.org
>> Assisted-by: Claude:claude-opus-4-8
>> Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
>> ---
>>  include/net/bluetooth/hci_core.h |  1 +
>>  net/bluetooth/hci_conn.c         | 21 ++--------
>>  net/bluetooth/hci_sync.c         | 66 ++++++++++++++++++++++++++----=
--
>>  3 files changed, 58 insertions(+), 30 deletions(-)
>>
>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth=
/hci_core.h
>> index aa600fbf9a53..aa554c34f9ec 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -988,6 +988,7 @@ enum {
>>         HCI_CONN_AUTH_FAILURE,
>>         HCI_CONN_PER_ADV,
>>         HCI_CONN_BIG_CREATED,
>> +       HCI_CONN_CREATE,
>>         HCI_CONN_CREATE_CIS,
>>         HCI_CONN_CREATE_BIG_SYNC,
>>         HCI_CONN_BIG_SYNC,
>> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
>> index 54eabaa46960..eba4a548bef5 100644
>> --- a/net/bluetooth/hci_conn.c
>> +++ b/net/bluetooth/hci_conn.c
>> @@ -3181,26 +3181,11 @@ int hci_abort_conn(struct hci_conn *conn, u8 =
reason)
>>
>>         conn->abort_reason =3D reason;
>>
>> -       /* If the connection is pending check the command opcode sinc=
e that
>> -        * might be blocking on hci_cmd_sync_work while waiting its r=
espective
>> -        * event so we need to hci_cmd_sync_cancel to cancel it.
>> -        *
>> -        * hci_connect_le serializes the connection attempts so only =
one
>> -        * connection can be in BT_CONNECT at time.
>> +       /* Cancel the connect attempt. A return of 0 means the create=
 command
>> +        * was still queued and got dequeued, so there is nothing to =
disconnect.
>>          */
>> -       if (conn->state =3D=3D BT_CONNECT && READ_ONCE(hdev->req_stat=
us) =3D=3D HCI_REQ_PEND) {
>> -               switch (hci_skb_event(hdev->sent_cmd)) {
>> -               case HCI_EV_CONN_COMPLETE:
>> -               case HCI_EV_LE_CONN_COMPLETE:
>> -               case HCI_EV_LE_ENHANCED_CONN_COMPLETE:
>> -               case HCI_EVT_LE_CIS_ESTABLISHED:
>> -                       hci_cmd_sync_cancel(hdev, ECANCELED);
>> -                       break;
>> -               }
>> -       /* Cancel connect attempt if still queued/pending */
>> -       } else if (!hci_cancel_connect_sync(hdev, conn)) {
>> +       if (!hci_cancel_connect_sync(hdev, conn))
>>                 return 0;
>> -       }
>>
>>         /* Run immediately if on cmd_sync_work since this may be call=
ed
>>          * as a result to MGMT_OP_DISCONNECT/MGMT_OP_UNPAIR which does
>> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
>> index df23245d6ccd..1fe19ddbbc2c 100644
>> --- a/net/bluetooth/hci_sync.c
>> +++ b/net/bluetooth/hci_sync.c
>> @@ -6668,6 +6668,12 @@ static int hci_le_create_conn_sync(struct hci_=
dev *hdev, void *data)
>>                                              &own_addr_type);
>>         if (err)
>>                 goto done;
>> +
>> +       /* Mark create connection in flight so hci_cancel_connect_syn=
c() can
>> +        * cancel it while blocking on the connection complete event.
>> +        */
>> +       set_bit(HCI_CONN_CREATE, &conn->flags);
>> +
>>         /* Send command LE Extended Create Connection if supported */
>>         if (use_ext_conn(hdev)) {
>>                 err =3D hci_le_ext_create_conn_sync(hdev, conn, own_a=
ddr_type);
>> @@ -6703,6 +6709,8 @@ static int hci_le_create_conn_sync(struct hci_d=
ev *hdev, void *data)
>>                                        conn->conn_timeout, NULL);
>>
>>  done:
>> +       clear_bit(HCI_CONN_CREATE, &conn->flags);
>> +
>>         if (err =3D=3D -ETIMEDOUT)
>>                 hci_le_connect_cancel_sync(hdev, conn, 0x00);
>>
>> @@ -6982,10 +6990,19 @@ static int hci_acl_create_conn_sync(struct hc=
i_dev *hdev, void *data)
>>         else
>>                 cp.role_switch =3D 0x00;
>>
>> -       return __hci_cmd_sync_status_sk(hdev, HCI_OP_CREATE_CONN,
>> -                                       sizeof(cp), &cp,
>> -                                       HCI_EV_CONN_COMPLETE,
>> -                                       conn->conn_timeout, NULL);
>> +       /* Mark create connection in flight so hci_cancel_connect_syn=
c() can
>> +        * cancel it while blocking on the connection complete event.
>> +        */
>> +       set_bit(HCI_CONN_CREATE, &conn->flags);
>> +
>> +       err =3D __hci_cmd_sync_status_sk(hdev, HCI_OP_CREATE_CONN,
>> +                                      sizeof(cp), &cp,
>> +                                      HCI_EV_CONN_COMPLETE,
>> +                                      conn->conn_timeout, NULL);
>> +
>> +       clear_bit(HCI_CONN_CREATE, &conn->flags);
>> +
>> +       return err;
>>  }
>>
>>  int hci_connect_acl_sync(struct hci_dev *hdev, struct hci_conn *conn)
>> @@ -7039,20 +7056,45 @@ int hci_connect_le_sync(struct hci_dev *hdev,=
 struct hci_conn *conn)
>>
>>  int hci_cancel_connect_sync(struct hci_dev *hdev, struct hci_conn *c=
onn)
>>  {
>> -       if (conn->state !=3D BT_OPEN)
>> -               return -EINVAL;
>> +       hci_cmd_sync_work_func_t func =3D NULL;
>> +       hci_cmd_sync_work_destroy_t destroy =3D NULL;
>> +       int create_flag =3D -1;
>>
>>         switch (conn->type) {
>>         case ACL_LINK:
>> -               return !hci_cmd_sync_dequeue_once(hdev,
>> -                                                 hci_acl_create_conn=
_sync,
>> -                                                 conn, NULL);
>> +               func =3D hci_acl_create_conn_sync;
>> +               create_flag =3D HCI_CONN_CREATE;
>> +               break;
>>         case LE_LINK:
>> -               return !hci_cmd_sync_dequeue_once(hdev, hci_le_create=
_conn_sync,
>> -                                                 conn, create_le_con=
n_complete);
>> +               func =3D hci_le_create_conn_sync;
>> +               destroy =3D create_le_conn_complete;
>> +               create_flag =3D HCI_CONN_CREATE;
>> +               break;
>> +       case CIS_LINK:
>> +               /* LE Create CIS is shared by the whole CIG and canno=
t be
>> +                * dequeued per-connection; only cancel it in-flight =
below.
>> +                */
>> +               create_flag =3D HCI_CONN_CREATE_CIS;
>> +               break;
>> +       default:
>> +               return -ENOENT;
>>         }
>>
>> -       return -ENOENT;
>> +       /* The create command is in exactly one of two states: still =
queued, or
>> +        * in flight. The create flag is only set once the worker has=
 dequeued
>> +        * the entry and started running it, so the two states are mu=
tually
>> +        * exclusive. Try to dequeue first: if it succeeds the comman=
d had not
>> +        * started yet and we are done. Otherwise the worker already =
pulled it
>> +        * off the queue (the dequeue is a no-op here),
>
> This is where I disagree, `dequeue` is not a no-op. It must traverse
> the list of entries in cmd_sync_work_list, so it is cheaper to check
> the flag first and then attempt to dequeue.
>

If we test the flag first and read 0 while the entry is still queued, th=
e worker
can advance it to in-flight before our dequeue runs.
In that case we will return without cancelling.

I can update the comment saying that it has no effect instead of no-op.

>> +        * owns the in-flight create command, cancel the pending requ=
est.
>> +        */
>> +       if (func && hci_cmd_sync_dequeue_once(hdev, func, conn, destr=
oy))
>> +               return 0;
>> +
>> +       if (create_flag >=3D 0 && test_bit(create_flag, &conn->flags))
>> +               hci_cmd_sync_cancel(hdev, ECANCELED);
>> +
>> +       return -EBUSY;
>>  }
>>
>>  int hci_le_conn_update_sync(struct hci_dev *hdev, struct hci_conn *c=
onn,
>> --
>> 2.54.0
>>
>
>
> --=20
> Luiz Augusto von Dentz

Best,
Siwei
