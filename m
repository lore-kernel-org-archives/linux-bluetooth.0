Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814003D9028
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2026 15:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781535995; cv=none; b=LLSvx7Dsb1h9/GtQRvEELP/88pP37JwsfsiUOuMHtlbnKm5gEr0N2sPNCMuTbiK9BmC4twaD+hQOILA304cetkEmGigLc2HoSqiFXlkOWf3jJIIAENqXu9f2jlopjaOBh3UQ/Do44Y9nB7fyew65F7D2SYUx5xuRxGO/sNKjp38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781535995; c=relaxed/simple;
	bh=Uot8cnw0quCr3uW2ivN4g6LMzM4kGhNsVlHk6YkAz2U=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qRjtFQC/j9oIY69ngAv4pX17yv8jHcDZB9MpoMVu/4ihcZdCtZAYXksJlb4IgZxfsdXIJVna8HF4f0mu9qcrDJE/K/nO60ikudMIcn+CMPkK/hUc9hLjsMQCUNX/Ul0XRavfmSghF4A6+MkEiefGxCoBveEj5V8HHg8O0LBkZFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=lghFVgyu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OaUT+4K/; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="lghFVgyu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OaUT+4K/"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BE3057A007F;
	Mon, 15 Jun 2026 11:06:32 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-03.internal (MEProxy); Mon, 15 Jun 2026 11:06:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781535992;
	 x=1781622392; bh=SO3p12ZsDxXS4zzt10g0dhvBOnM+ATlaFemfN/QBGI4=; b=
	lghFVgyuxRP4vHaZzvAiWw4Ip+fdY4b2JB1LZNm85BkKQorFMX5CAO0Sjt+aMUJ4
	bGcwrOS9ud/4W2+fn+dpUhyeruCrMXVUuPEgrV260pilQrhu4JEI3URl1LlDMQfE
	g19D7C3MskhMk3aZZ/Wwd6s0XZe7z6Oq7ciczp1tUiBwRlE/gbJSjfm8oTb4rANn
	L5Ze6r+3KvaQvZWF5vzb/GULa1i77LbLKhIlFsEvtizy9wcLzGZ8JR2P46wQ6gCw
	RBC8r3Ga2XvMRUDs4WiQSVN4DKk6DRN4MwNEGz5fxZ1pIWF5G228PmEnTOOFKbA1
	BWUBHRF1imO+wbZg+JPnjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781535992; x=
	1781622392; bh=SO3p12ZsDxXS4zzt10g0dhvBOnM+ATlaFemfN/QBGI4=; b=O
	aUT+4K/BlWKLIHjX+BwH8GWuXOx5vzRrjDI1kpzbv5uVq0s3s8MZfwZoadvYqLTu
	Fb8gR3hOJI+al5Hi0Nt6aBwtY8myC+O0PUA1te/mCZr3lj8YIoox3JcO4vGh9HtH
	kdKCMlhcVY7Ze+p3E0YJmYMhs8npZVq/uCMEpgZUfbZ//+4UAdVkLzy9KaXtcvsP
	zpTzctsN3gPTxpsxXvndYEHyi44VMYWVb9pDU6tQLjC024oYVhcSuCWB8pIokdzj
	GzETWORasJxZ/IcQE2FgqPI1hPk2sAObDECoCqTfzJYEmeta31+I90oyGhFeaMtE
	U6COjbGb57WsStF9QyiIw==
X-ME-Sender: <xms:-BQwavtzwbX9jtXUaRNMXvRSSlkm-UcqN_48hD8MzkjFlNwEkgb5MQ>
    <xme:-BQwarS3hKLoaT46KcewMuYpmuGVtCjhw2K5vn3jxyNy37zgGy1WRB4QFOE4N5d-f
    otjh1GyakYTRh7qR8Gfl8a5IT8Hng4LKdYhf6cGLivJLCAKRGRlbw>
X-ME-Proxy-Cause: dmFkZTEqzzRyyFnjQS5iKgYtreIF40r44LQsyF6PCPg2iCWOspuJriPqaesaeC4sj7n5Yt
    92C8+ilw6zhkdQ5wImdBK858SAmAbbFYmiVgUOoDM4qhlgY5D0yXqvuQ6YTpGfugTKSy1K
    En5M+1jZhQsfUq3Gq3sF46gqTDVBc9VWa4GzAfgbJI9xtZZv5MIzsxn4obG2ucgLg47Ntw
    Wp5DkAAdcbyatqKTn0I2jC1yOjs4AZOq4Eqw0fZyxf/GxFF74qW7XDgVENwEhJi76QkQ5H
    PujuQhLLXufR6VnvgpxHtqT5csW4UdvW8wELtHQcz2dDSms5APSj+27NWQpqPC4YVLI/p4
    5fpTWOnUU5/a+frDVimBsoVTk/QWvQsBZLv3CQHDPHBG9LzdZTyJGvhydYtyjvK02GMPPZ
    UXopLaP5e1Jdx6QFPslC/WO7qH2iYTgTH4iFU+1EM9VPNVTpsSVA6GOTHkgCYFQYSQ2TNg
    K5yWS0sa/GGtkhbcy9pgw1NYGzRldbp0slX8q6IIo7SavrW6kmE94Ad+lehCgEkCVvkPSb
    MlUVdT76gsT7+llqlRnhS6BRJsLyORiTCJP37X36SxdqygRA/f479Uk4U3l1nV9dfo6pAY
    gapnnmC+lC+UhhO2/NdtMHxExMUDvBJoCbgoCNFAhz5w9/SwGMRCmrMdmseg
X-ME-Proxy: <xmx:-BQwanXROVar7UbCC3A5CEo_kJDrz5uNYn2u7O9CFVt95rgP6MmAUw>
    <xmx:-BQwatZayQ_x_xLbfhcyIq9hTMbXFiiuCDsQwjcdYoDZDeruu4Qk4g>
    <xmx:-BQwat0m4Z4bHl7_22xyJxmSvfj0aqIVzEgbfPbxgH2XDq-Sio9iIw>
    <xmx:-BQwavhnGrcBnLHqPMiAumD5gNWZzJkMofzZguBmDNCItlF1j7Xj4g>
    <xmx:-BQwahq7T4O23IZLIuakgJcqUokDqyiAm9nVma73XVpWo5dcDZ1NA_KV>
Feedback-ID: if72e4b10:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4F8C7216008B; Mon, 15 Jun 2026 11:06:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ay15wreZGY9N
Date: Mon, 15 Jun 2026 11:06:11 -0400
From: "Siwei Zhang" <oss@fourdim.xyz>
To: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Cc: "Pauli Virtanen" <pav@iki.fi>, "XIAO WU" <xiaowu.417@qq.com>,
 linux-bluetooth@vger.kernel.org
Message-Id: <cbe3c81f-7919-4a13-b636-5d2bc776e094@app.fastmail.com>
In-Reply-To: 
 <CABBYNZKRTpmnQ44UWH_0jFwQY9OOP5LAHE2+1ZZn-Ckic4wGZQ@mail.gmail.com>
References: <20260615131131.1459372-1-oss@fourdim.xyz>
 <CABBYNZKRTpmnQ44UWH_0jFwQY9OOP5LAHE2+1ZZn-Ckic4wGZQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] Bluetooth: hci_conn: Fix null ptr deref in hci_abort_conn()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Mon, Jun 15, 2026, at 10:09 AM, Luiz Augusto von Dentz wrote:
> Hi Siwei,
>
> On Mon, Jun 15, 2026 at 9:12=E2=80=AFAM Siwei Zhang <oss@fourdim.xyz> =
wrote:
>>
>> hci_abort_conn() read hci_skb_event(hdev->sent_cmd) when a connection
>> was pending, but hdev->sent_cmd can be NULL while req_status is still
>> HCI_REQ_PEND, leading to a NULL pointer dereference and a general
>> protection fault from the hci_rx_work() receive path.
>>
>> Instead of inspecting hdev->sent_cmd, track the in-flight create
>> connection command with a new per-connection HCI_CONN_CREATE flag and
>> route all cancellation through hci_cancel_connect_sync(). The create
>> command is in exactly one of two states: still queued, or in flight.
>> hci_cancel_connect_sync() holds cmd_sync_work_lock across the whole
>> decision: the worker takes this lock to dequeue every entry, so while=
 it
>> is held a queued command cannot start running and an in-flight command
>> cannot complete and let the next command become pending. This keeps t=
he
>> flag test and hci_cmd_sync_cancel() atomic with respect to the worker,
>> so a queued command is simply dequeued, and an in-flight command owned
>> by this connection is cancelled without the risk of cancelling an
>> unrelated command that became pending in the meantime. CIS uses the s=
ame
>> path via the existing HCI_CONN_CREATE_CIS flag.
>>
>> hci_acl_create_conn_sync() and hci_le_create_conn_sync() clear
>> HCI_CONN_CREATE after the create command completes, but the command
>> status handler can free conn via hci_conn_del() (for example when the
>> controller rejects the connection) while the worker is still blocked =
on
>> the connection complete event. Hold a reference on conn across the
>> create command so the flag can be cleared without a use-after-free.
>>
>> Fixes: a13f316e90fd ("Bluetooth: hci_conn: Consolidate code for abort=
ing connections")
>> Cc: stable@vger.kernel.org
>> Suggested-by: XIAO WU <xiaowu.417@qq.com>
>> Assisted-by: Claude:claude-opus-4-8
>> Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
>> ---
>>  include/net/bluetooth/hci_core.h |  1 +
>>  net/bluetooth/hci_conn.c         | 21 +------
>>  net/bluetooth/hci_sync.c         | 96 ++++++++++++++++++++++++++++--=
--
>>  3 files changed, 88 insertions(+), 30 deletions(-)
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
>> index df23245d6ccd..06b87e9cd999 100644
>> --- a/net/bluetooth/hci_sync.c
>> +++ b/net/bluetooth/hci_sync.c
>> @@ -6611,6 +6611,11 @@ static int hci_le_create_conn_sync(struct hci_=
dev *hdev, void *data)
>>
>>         bt_dev_dbg(hdev, "conn %p", conn);
>>
>> +       /* Hold a reference so conn stays valid for the HCI_CONN_CREA=
TE
>> +        * clear_bit() at done.
>> +        */
>> +       hci_conn_get(conn);
>> +
>>         clear_bit(HCI_CONN_SCANNING, &conn->flags);
>>         conn->state =3D BT_CONNECT;
>>
>> @@ -6623,6 +6628,7 @@ static int hci_le_create_conn_sync(struct hci_d=
ev *hdev, void *data)
>>                     hdev->le_scan_type =3D=3D LE_SCAN_ACTIVE &&
>>                     !hci_dev_test_flag(hdev, HCI_LE_SIMULTANEOUS_ROLE=
S)) {
>>                         hci_conn_del(conn);
>> +                       hci_conn_put(conn);
>>                         return -EBUSY;
>>                 }
>>
>> @@ -6668,6 +6674,12 @@ static int hci_le_create_conn_sync(struct hci_=
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
>> @@ -6703,11 +6715,14 @@ static int hci_le_create_conn_sync(struct hci=
_dev *hdev, void *data)
>>                                        conn->conn_timeout, NULL);
>>
>>  done:
>> +       clear_bit(HCI_CONN_CREATE, &conn->flags);
>> +
>>         if (err =3D=3D -ETIMEDOUT)
>>                 hci_le_connect_cancel_sync(hdev, conn, 0x00);
>>
>>         /* Re-enable advertising after the connection attempt is fini=
shed. */
>>         hci_resume_advertising_sync(hdev);
>> +       hci_conn_put(conn);
>>         return err;
>>  }
>>
>> @@ -6982,10 +6997,25 @@ static int hci_acl_create_conn_sync(struct hc=
i_dev *hdev, void *data)
>>         else
>>                 cp.role_switch =3D 0x00;
>>
>> -       return __hci_cmd_sync_status_sk(hdev, HCI_OP_CREATE_CONN,
>> -                                       sizeof(cp), &cp,
>> -                                       HCI_EV_CONN_COMPLETE,
>> -                                       conn->conn_timeout, NULL);
>> +       /* Hold a reference so conn stays valid for the HCI_CONN_CREA=
TE
>> +        * clear_bit() below.
>> +        */
>> +       hci_conn_get(conn);
>> +
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
>> +       hci_conn_put(conn);
>> +
>> +       return err;
>>  }
>>
>>  int hci_connect_acl_sync(struct hci_dev *hdev, struct hci_conn *conn)
>> @@ -7039,20 +7069,62 @@ int hci_connect_le_sync(struct hci_dev *hdev,=
 struct hci_conn *conn)
>>
>>  int hci_cancel_connect_sync(struct hci_dev *hdev, struct hci_conn *c=
onn)
>>  {
>> -       if (conn->state !=3D BT_OPEN)
>> -               return -EINVAL;
>> +       struct hci_cmd_sync_work_entry *entry;
>> +       hci_cmd_sync_work_func_t func =3D NULL;
>> +       hci_cmd_sync_work_destroy_t destroy =3D NULL;
>> +       int create_flag =3D -1;
>> +       int err =3D -EBUSY;
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
>
> Instead of doing everything in the same function, it probably makes
> more sense to add dedicated functions for each type, for example,
> `hci_acl_cancel_create_conn_sync`, etc.
>

int hci_cancel_connect_sync(struct hci_dev *hdev, struct hci_conn *conn)
{
	switch (conn->type) {
	case ACL_LINK:
		return hci_cancel_create_conn_sync(hdev, conn, HCI_CONN_CREATE,
						   hci_acl_create_conn_sync,
						   NULL);
	case LE_LINK:
		return hci_cancel_create_conn_sync(hdev, conn, HCI_CONN_CREATE,
						   hci_le_create_conn_sync,
						   create_le_conn_complete);
	case CIS_LINK:
		return hci_cancel_create_conn_sync(hdev, conn,
						   HCI_CONN_CREATE_CIS, NULL,
						   NULL);
	default:
		return -ENOENT;
	}
}

I would like to have something like this.=20
hci_acl_cancel_create_conn_sync will have an unnecessary wrapper.
What do you think?

>> +               break;
>> +       default:
>> +               return -ENOENT;
>>         }
>>
>> -       return -ENOENT;
>> +       /* The create command is either still queued or in flight. Ho=
ld
>> +        * cmd_sync_work_lock across the test and the cancel: the wor=
ker takes
>> +        * this lock to dequeue every entry, so while it is held no o=
ther command
>> +        * can become pending, which keeps hci_cmd_sync_cancel() from=
 racing with
>> +        * completion and cancelling an unrelated command.
>> +        */
>> +       mutex_lock(&hdev->cmd_sync_work_lock);
>> +
>> +       /* The flag is set while the worker blocks on the connection =
complete
>> +        * event, so if it is set this connection owns the pending re=
quest.
>> +        */
>> +       if (create_flag >=3D 0 && test_bit(create_flag, &conn->flags)=
) {
>> +               hci_cmd_sync_cancel(hdev, ECANCELED);
>> +               goto unlock;
>> +       }
>> +
>> +       /* Otherwise it may still be queued; dequeue it. A successful=
 dequeue
>> +        * means it never started, so there is nothing to disconnect.
>> +        */
>> +       if (func) {
>> +               entry =3D _hci_cmd_sync_lookup_entry(hdev, func, conn=
, destroy);
>> +               if (entry) {
>> +                       _hci_cmd_sync_cancel_entry(hdev, entry, -ECAN=
CELED);
>> +                       err =3D 0;
>> +               }
>> +       }
>> +
>> +unlock:
>> +       mutex_unlock(&hdev->cmd_sync_work_lock);
>> +       return err;
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
