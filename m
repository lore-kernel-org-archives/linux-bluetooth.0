Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD51D402447
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2026 15:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781536618; cv=none; b=rBifBH6Ak1tjCuHl0eHdovDbH2FwykGfxZ/aN+ZRKsfkIJ+gnjC08X81jJSfqxLoLxsG4FHZgRcK9P8l2cKsFRYxL8FffJ/bgjXqwfQ+1lQafs64vadQ+oR4qD70XMqgT+d/Dsh0ahNofht1a03SHIwtbzxVYq3C9c5O99vfEIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781536618; c=relaxed/simple;
	bh=yeYIXUHcl8QYkSOVU6/wUJ4rWct2n0h6A/wu9njjnJc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=tsWJT4Milp3/fApPQwArYb2eBPT/Q8/yZpuJheyCjbzcY0NM3bPscqAxZhkCpl3eUKJVfl1nBWe6VaNu1BwTy36oYzf4lyG9Vr3weYs9OoijySGDnoqN4CAhim5lUFMpvJTozbQwaLksxkr3U9DMYN4lptc4D6zgpFPaLs7Vaz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=kX4/LdFW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UVz6OwQC; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="kX4/LdFW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UVz6OwQC"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 277847A0137;
	Mon, 15 Jun 2026 11:16:56 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-03.internal (MEProxy); Mon, 15 Jun 2026 11:16:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781536616;
	 x=1781623016; bh=d6owxbEyhdRVix2FsAkOBTCK58eIDcm7SjTkJCuMXXk=; b=
	kX4/LdFWOqnt2jPEQGiwM4txkobSWb42WC/ECV1zFE0m3/Fq+sDN3yIILK/19YRk
	UAbQ0GQ1Pqov4IhZjZ4j/RJDSTFyhv7dnh/4sEBemt0qhfgqCTCz8A/JKqR4ip14
	87HZMbIVzDRFE7GdS/3NkAGlCdS9gFxWgU1fCSFZuDKdrYsL/aTr6HymtY7/TYj3
	zUmwuNa/DdXSrS1w9UjRNYEmBez8wMXi7RcwpC4OsS2vzn7sg+wl2lEUjCApCTGx
	IixTkvgTGX8vG8k2Kt+MnBzYvXQTAKY8KHb+56yOf9lTT42JP3VmEqTwI0BWa4gj
	GoX5kWSmnaOK65usonPC2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781536616; x=
	1781623016; bh=d6owxbEyhdRVix2FsAkOBTCK58eIDcm7SjTkJCuMXXk=; b=U
	Vz6OwQCiRsCh/82vlzQteTbf3uxRKj0ri3i0YTujsVvfZQoC992TXKDL/NRW67IR
	VIQo/x4cWBYeOglzzKoMmjpAd6cGMNeMV3TgRUvqXUgpAw77cSvGI6aQaH1wGdGz
	tqoctrPood9IsQZ1iRFXW47swMI4C02TpVHsmsJn9eLeGVFT7Tzw/zEUIxhDUbZR
	nNsfJjuxINbSet5XoE95R5hTmhXxTm3bpIxW78b7GM46oQaaxvoK4a5AoptN4oVz
	Fp0V7EYEvai3+udwsKYERAUe559Id72RojlttWLgiRVo2P4lQVGYuB0mXozYU7K2
	3O9n9wcFrRIcnN5QvSTyA==
X-ME-Sender: <xms:Zxcwag0TCdBxgJ7e2RdTxcaHlldAieBJrlhu1r5snZ2Vcahvc8gTaw>
    <xme:Zxcwal6ehWyxc3BNZ_BZnqsEnFcw3xrRj7fTZ0vSPW0vTwHwVmEfT_pOsJ8zllDDr
    S200vZ6tPIp3LunfxLGD7mB_5Wz1PYZ_W3QV6QcULPhm0oEamNcEQ>
X-ME-Proxy-Cause: dmFkZTFKUcAyHAN3aKge7xefLDUv+xOe8A8pH3dFn/Uv3vJhSOfsKphhglxcFJtITFx6Ga
    SUDlO7sg19QYRQPVkOIIEwXAAYK8DIsDpJZXe4C+z4/8kEsm/TnSRxCRPaA+OCfMW/DXYs
    4G3XC8FR4uVJL5r57medX3kJ+NP9542aL5aUCaXa5DH8omGzTHQNzSowiRnEkyuTo4S6NX
    VieXyLatg/n2QpK5AygwSIZkiJr3RWtjB1F/KPmLPuC9dVSCr1NJjWHzZDMjTv6jvESOrM
    wVMbqR9JCFJgirfCrN09mzKQQzWRzxzSsjFstYvKcOcxFgnfn6KZG6HdqkXLfNIRWN3osp
    o6WD1wvv96XHBXIOwHsVLZJTL8fQ+0bwgsTkZRsFWBZi/FUITPeh1r96qAhRv4lWSYvPIs
    o4LtxiRsNxVArxm/jTP4Y2hEBrzgxrGhFnkjL0IxT/WCCnY749fNGc9+aQpauO8X/mWYUU
    GlxbBsz14Xa3EyEepiTiwHlbvWDFId0Mg4+OOlNn3nQqJZ4sP68mFw9sg/68yqIfn4Kepy
    xZVPwoh0XPlVl+syk+/EzzmUTVCZ0N1NhPlpX8VJ2+FsiwHNDUVkzgoJBVkkKVTO5vLXVi
    xNy8nbeEm2p6NdcItqoezxCTpsa3HzcBEjS/nHJeOCnYwStaufUhAu65/lKw
X-ME-Proxy: <xmx:Zxcwamdk72fXkK-XOWLRxXXLx84ADbyRi0-Ai9xSLVAT2-Kb-KdRGQ>
    <xmx:ZxcwauBXNg-88ZbWlwn7Zx8HH0a39hpJSenWmnvMlTFDIV_igcfEXg>
    <xmx:Zxcwah_g1zyC3o8ONb5cDcwL4HiVdvoIzMNiz0BqKU7zBiG5EpMKrw>
    <xmx:ZxcwahKVcKioJb-KhGXsaciXxCX9iZWm1puom7ZECplZmGmHyKyc1g>
    <xmx:aBcwatSOKTHmTshKDOjNI_9TWeY91LCAv5kqs-AS2DKQ5peS2jF5zfya>
Feedback-ID: if72e4b10:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C9AF2216008A; Mon, 15 Jun 2026 11:16:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ay15wreZGY9N
Date: Mon, 15 Jun 2026 11:15:19 -0400
From: "Siwei Zhang" <oss@fourdim.xyz>
To: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Cc: "Pauli Virtanen" <pav@iki.fi>, "XIAO WU" <xiaowu.417@qq.com>,
 linux-bluetooth@vger.kernel.org
Message-Id: <9aa182c2-11bd-4268-b254-9637db5535ca@app.fastmail.com>
In-Reply-To: 
 <CABBYNZLvSOHWQVmCX_T6wEXTPuS=JCii8Aujdh-C6Oo__1CGSw@mail.gmail.com>
References: <20260615131131.1459372-1-oss@fourdim.xyz>
 <CABBYNZKRTpmnQ44UWH_0jFwQY9OOP5LAHE2+1ZZn-Ckic4wGZQ@mail.gmail.com>
 <cbe3c81f-7919-4a13-b636-5d2bc776e094@app.fastmail.com>
 <CABBYNZLvSOHWQVmCX_T6wEXTPuS=JCii8Aujdh-C6Oo__1CGSw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] Bluetooth: hci_conn: Fix null ptr deref in hci_abort_conn()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Mon, Jun 15, 2026, at 11:11 AM, Luiz Augusto von Dentz wrote:
> Hi Siwei,
>
> On Mon, Jun 15, 2026 at 11:06=E2=80=AFAM Siwei Zhang <oss@fourdim.xyz>=
 wrote:
>>
>> Hi Luiz,
>>
>> On Mon, Jun 15, 2026, at 10:09 AM, Luiz Augusto von Dentz wrote:
>> > Hi Siwei,
>> >
>> > On Mon, Jun 15, 2026 at 9:12=E2=80=AFAM Siwei Zhang <oss@fourdim.xy=
z> wrote:
>> >>
>> >> hci_abort_conn() read hci_skb_event(hdev->sent_cmd) when a connect=
ion
>> >> was pending, but hdev->sent_cmd can be NULL while req_status is st=
ill
>> >> HCI_REQ_PEND, leading to a NULL pointer dereference and a general
>> >> protection fault from the hci_rx_work() receive path.
>> >>
>> >> Instead of inspecting hdev->sent_cmd, track the in-flight create
>> >> connection command with a new per-connection HCI_CONN_CREATE flag =
and
>> >> route all cancellation through hci_cancel_connect_sync(). The crea=
te
>> >> command is in exactly one of two states: still queued, or in fligh=
t.
>> >> hci_cancel_connect_sync() holds cmd_sync_work_lock across the whole
>> >> decision: the worker takes this lock to dequeue every entry, so wh=
ile it
>> >> is held a queued command cannot start running and an in-flight com=
mand
>> >> cannot complete and let the next command become pending. This keep=
s the
>> >> flag test and hci_cmd_sync_cancel() atomic with respect to the wor=
ker,
>> >> so a queued command is simply dequeued, and an in-flight command o=
wned
>> >> by this connection is cancelled without the risk of cancelling an
>> >> unrelated command that became pending in the meantime. CIS uses th=
e same
>> >> path via the existing HCI_CONN_CREATE_CIS flag.
>> >>
>> >> hci_acl_create_conn_sync() and hci_le_create_conn_sync() clear
>> >> HCI_CONN_CREATE after the create command completes, but the command
>> >> status handler can free conn via hci_conn_del() (for example when =
the
>> >> controller rejects the connection) while the worker is still block=
ed on
>> >> the connection complete event. Hold a reference on conn across the
>> >> create command so the flag can be cleared without a use-after-free.
>> >>
>> >> Fixes: a13f316e90fd ("Bluetooth: hci_conn: Consolidate code for ab=
orting connections")
>> >> Cc: stable@vger.kernel.org
>> >> Suggested-by: XIAO WU <xiaowu.417@qq.com>
>> >> Assisted-by: Claude:claude-opus-4-8
>> >> Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
>> >> ---
>> >>  include/net/bluetooth/hci_core.h |  1 +
>> >>  net/bluetooth/hci_conn.c         | 21 +------
>> >>  net/bluetooth/hci_sync.c         | 96 +++++++++++++++++++++++++++=
+----
>> >>  3 files changed, 88 insertions(+), 30 deletions(-)
>> >>
>> >> diff --git a/include/net/bluetooth/hci_core.h b/include/net/blueto=
oth/hci_core.h
>> >> index aa600fbf9a53..aa554c34f9ec 100644
>> >> --- a/include/net/bluetooth/hci_core.h
>> >> +++ b/include/net/bluetooth/hci_core.h
>> >> @@ -988,6 +988,7 @@ enum {
>> >>         HCI_CONN_AUTH_FAILURE,
>> >>         HCI_CONN_PER_ADV,
>> >>         HCI_CONN_BIG_CREATED,
>> >> +       HCI_CONN_CREATE,
>> >>         HCI_CONN_CREATE_CIS,
>> >>         HCI_CONN_CREATE_BIG_SYNC,
>> >>         HCI_CONN_BIG_SYNC,
>> >> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
>> >> index 54eabaa46960..eba4a548bef5 100644
>> >> --- a/net/bluetooth/hci_conn.c
>> >> +++ b/net/bluetooth/hci_conn.c
>> >> @@ -3181,26 +3181,11 @@ int hci_abort_conn(struct hci_conn *conn, =
u8 reason)
>> >>
>> >>         conn->abort_reason =3D reason;
>> >>
>> >> -       /* If the connection is pending check the command opcode s=
ince that
>> >> -        * might be blocking on hci_cmd_sync_work while waiting it=
s respective
>> >> -        * event so we need to hci_cmd_sync_cancel to cancel it.
>> >> -        *
>> >> -        * hci_connect_le serializes the connection attempts so on=
ly one
>> >> -        * connection can be in BT_CONNECT at time.
>> >> +       /* Cancel the connect attempt. A return of 0 means the cre=
ate command
>> >> +        * was still queued and got dequeued, so there is nothing =
to disconnect.
>> >>          */
>> >> -       if (conn->state =3D=3D BT_CONNECT && READ_ONCE(hdev->req_s=
tatus) =3D=3D HCI_REQ_PEND) {
>> >> -               switch (hci_skb_event(hdev->sent_cmd)) {
>> >> -               case HCI_EV_CONN_COMPLETE:
>> >> -               case HCI_EV_LE_CONN_COMPLETE:
>> >> -               case HCI_EV_LE_ENHANCED_CONN_COMPLETE:
>> >> -               case HCI_EVT_LE_CIS_ESTABLISHED:
>> >> -                       hci_cmd_sync_cancel(hdev, ECANCELED);
>> >> -                       break;
>> >> -               }
>> >> -       /* Cancel connect attempt if still queued/pending */
>> >> -       } else if (!hci_cancel_connect_sync(hdev, conn)) {
>> >> +       if (!hci_cancel_connect_sync(hdev, conn))
>> >>                 return 0;
>> >> -       }
>> >>
>> >>         /* Run immediately if on cmd_sync_work since this may be c=
alled
>> >>          * as a result to MGMT_OP_DISCONNECT/MGMT_OP_UNPAIR which =
does
>> >> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
>> >> index df23245d6ccd..06b87e9cd999 100644
>> >> --- a/net/bluetooth/hci_sync.c
>> >> +++ b/net/bluetooth/hci_sync.c
>> >> @@ -6611,6 +6611,11 @@ static int hci_le_create_conn_sync(struct h=
ci_dev *hdev, void *data)
>> >>
>> >>         bt_dev_dbg(hdev, "conn %p", conn);
>> >>
>> >> +       /* Hold a reference so conn stays valid for the HCI_CONN_C=
REATE
>> >> +        * clear_bit() at done.
>> >> +        */
>> >> +       hci_conn_get(conn);
>> >> +
>> >>         clear_bit(HCI_CONN_SCANNING, &conn->flags);
>> >>         conn->state =3D BT_CONNECT;
>> >>
>> >> @@ -6623,6 +6628,7 @@ static int hci_le_create_conn_sync(struct hc=
i_dev *hdev, void *data)
>> >>                     hdev->le_scan_type =3D=3D LE_SCAN_ACTIVE &&
>> >>                     !hci_dev_test_flag(hdev, HCI_LE_SIMULTANEOUS_R=
OLES)) {
>> >>                         hci_conn_del(conn);
>> >> +                       hci_conn_put(conn);
>> >>                         return -EBUSY;
>> >>                 }
>> >>
>> >> @@ -6668,6 +6674,12 @@ static int hci_le_create_conn_sync(struct h=
ci_dev *hdev, void *data)
>> >>                                              &own_addr_type);
>> >>         if (err)
>> >>                 goto done;
>> >> +
>> >> +       /* Mark create connection in flight so hci_cancel_connect_=
sync() can
>> >> +        * cancel it while blocking on the connection complete eve=
nt.
>> >> +        */
>> >> +       set_bit(HCI_CONN_CREATE, &conn->flags);
>> >> +
>> >>         /* Send command LE Extended Create Connection if supported=
 */
>> >>         if (use_ext_conn(hdev)) {
>> >>                 err =3D hci_le_ext_create_conn_sync(hdev, conn, ow=
n_addr_type);
>> >> @@ -6703,11 +6715,14 @@ static int hci_le_create_conn_sync(struct =
hci_dev *hdev, void *data)
>> >>                                        conn->conn_timeout, NULL);
>> >>
>> >>  done:
>> >> +       clear_bit(HCI_CONN_CREATE, &conn->flags);
>> >> +
>> >>         if (err =3D=3D -ETIMEDOUT)
>> >>                 hci_le_connect_cancel_sync(hdev, conn, 0x00);
>> >>
>> >>         /* Re-enable advertising after the connection attempt is f=
inished. */
>> >>         hci_resume_advertising_sync(hdev);
>> >> +       hci_conn_put(conn);
>> >>         return err;
>> >>  }
>> >>
>> >> @@ -6982,10 +6997,25 @@ static int hci_acl_create_conn_sync(struct=
 hci_dev *hdev, void *data)
>> >>         else
>> >>                 cp.role_switch =3D 0x00;
>> >>
>> >> -       return __hci_cmd_sync_status_sk(hdev, HCI_OP_CREATE_CONN,
>> >> -                                       sizeof(cp), &cp,
>> >> -                                       HCI_EV_CONN_COMPLETE,
>> >> -                                       conn->conn_timeout, NULL);
>> >> +       /* Hold a reference so conn stays valid for the HCI_CONN_C=
REATE
>> >> +        * clear_bit() below.
>> >> +        */
>> >> +       hci_conn_get(conn);
>> >> +
>> >> +       /* Mark create connection in flight so hci_cancel_connect_=
sync() can
>> >> +        * cancel it while blocking on the connection complete eve=
nt.
>> >> +        */
>> >> +       set_bit(HCI_CONN_CREATE, &conn->flags);
>> >> +
>> >> +       err =3D __hci_cmd_sync_status_sk(hdev, HCI_OP_CREATE_CONN,
>> >> +                                      sizeof(cp), &cp,
>> >> +                                      HCI_EV_CONN_COMPLETE,
>> >> +                                      conn->conn_timeout, NULL);
>> >> +
>> >> +       clear_bit(HCI_CONN_CREATE, &conn->flags);
>> >> +       hci_conn_put(conn);
>> >> +
>> >> +       return err;
>> >>  }
>> >>
>> >>  int hci_connect_acl_sync(struct hci_dev *hdev, struct hci_conn *c=
onn)
>> >> @@ -7039,20 +7069,62 @@ int hci_connect_le_sync(struct hci_dev *hd=
ev, struct hci_conn *conn)
>> >>
>> >>  int hci_cancel_connect_sync(struct hci_dev *hdev, struct hci_conn=
 *conn)
>> >>  {
>> >> -       if (conn->state !=3D BT_OPEN)
>> >> -               return -EINVAL;
>> >> +       struct hci_cmd_sync_work_entry *entry;
>> >> +       hci_cmd_sync_work_func_t func =3D NULL;
>> >> +       hci_cmd_sync_work_destroy_t destroy =3D NULL;
>> >> +       int create_flag =3D -1;
>> >> +       int err =3D -EBUSY;
>> >>
>> >>         switch (conn->type) {
>> >>         case ACL_LINK:
>> >> -               return !hci_cmd_sync_dequeue_once(hdev,
>> >> -                                                 hci_acl_create_c=
onn_sync,
>> >> -                                                 conn, NULL);
>> >> +               func =3D hci_acl_create_conn_sync;
>> >> +               create_flag =3D HCI_CONN_CREATE;
>> >> +               break;
>> >>         case LE_LINK:
>> >> -               return !hci_cmd_sync_dequeue_once(hdev, hci_le_cre=
ate_conn_sync,
>> >> -                                                 conn, create_le_=
conn_complete);
>> >> +               func =3D hci_le_create_conn_sync;
>> >> +               destroy =3D create_le_conn_complete;
>> >> +               create_flag =3D HCI_CONN_CREATE;
>> >> +               break;
>> >> +       case CIS_LINK:
>> >> +               /* LE Create CIS is shared by the whole CIG and ca=
nnot be
>> >> +                * dequeued per-connection; only cancel it in-flig=
ht below.
>> >> +                */
>> >> +               create_flag =3D HCI_CONN_CREATE_CIS;
>> >
>> > Instead of doing everything in the same function, it probably makes
>> > more sense to add dedicated functions for each type, for example,
>> > `hci_acl_cancel_create_conn_sync`, etc.
>> >
>>
>> int hci_cancel_connect_sync(struct hci_dev *hdev, struct hci_conn *co=
nn)
>> {
>>         switch (conn->type) {
>>         case ACL_LINK:
>>                 return hci_cancel_create_conn_sync(hdev, conn, HCI_CO=
NN_CREATE,
>>                                                    hci_acl_create_con=
n_sync,
>>                                                    NULL);
>>         case LE_LINK:
>>                 return hci_cancel_create_conn_sync(hdev, conn, HCI_CO=
NN_CREATE,
>>                                                    hci_le_create_conn=
_sync,
>>                                                    create_le_conn_com=
plete);
>>         case CIS_LINK:
>>                 return hci_cancel_create_conn_sync(hdev, conn,
>>                                                    HCI_CONN_CREATE_CI=
S, NULL,
>>                                                    NULL);
>>         default:
>>                 return -ENOENT;
>>         }
>> }
>>
>> I would like to have something like this.
>> hci_acl_cancel_create_conn_sync will have an unnecessary wrapper.
>> What do you think?
>
> No, just do what I said. Things like hci_cis_cancel_create_conn_sync
> are actually quite different on their own. In fact, if we handle more
> variants of conn->type the differences will actually become more
> pronounced so let's not pretend they are similar.
>

OK, will do.

>> >> +               break;
>> >> +       default:
>> >> +               return -ENOENT;
>> >>         }
>> >>
>> >> -       return -ENOENT;
>> >> +       /* The create command is either still queued or in flight.=
 Hold
>> >> +        * cmd_sync_work_lock across the test and the cancel: the =
worker takes
>> >> +        * this lock to dequeue every entry, so while it is held n=
o other command
>> >> +        * can become pending, which keeps hci_cmd_sync_cancel() f=
rom racing with
>> >> +        * completion and cancelling an unrelated command.
>> >> +        */
>> >> +       mutex_lock(&hdev->cmd_sync_work_lock);
>> >> +
>> >> +       /* The flag is set while the worker blocks on the connecti=
on complete
>> >> +        * event, so if it is set this connection owns the pending=
 request.
>> >> +        */
>> >> +       if (create_flag >=3D 0 && test_bit(create_flag, &conn->fla=
gs)) {
>> >> +               hci_cmd_sync_cancel(hdev, ECANCELED);
>> >> +               goto unlock;
>> >> +       }
>> >> +
>> >> +       /* Otherwise it may still be queued; dequeue it. A success=
ful dequeue
>> >> +        * means it never started, so there is nothing to disconne=
ct.
>> >> +        */
>> >> +       if (func) {
>> >> +               entry =3D _hci_cmd_sync_lookup_entry(hdev, func, c=
onn, destroy);
>> >> +               if (entry) {
>> >> +                       _hci_cmd_sync_cancel_entry(hdev, entry, -E=
CANCELED);
>> >> +                       err =3D 0;
>> >> +               }
>> >> +       }
>> >> +
>> >> +unlock:
>> >> +       mutex_unlock(&hdev->cmd_sync_work_lock);
>> >> +       return err;
>> >>  }
>> >>
>> >>  int hci_le_conn_update_sync(struct hci_dev *hdev, struct hci_conn=
 *conn,
>> >> --
>> >> 2.54.0
>> >>
>> >
>> >
>> > --
>> > Luiz Augusto von Dentz
>>
>> Best,
>> Siwei
>
>
>
> --=20
> Luiz Augusto von Dentz

Best,
Siwei
