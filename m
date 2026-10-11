Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39854078E9;
	Sun, 11 Oct 2026 22:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791756273; cv=pass; b=Ha9oE4pRwl7FYhnbEwIR1XgV+oX2Ix4asUCA+cvyUnqclD9DEt5zAhf0fHAziC60UCCox1rfHUtPaA4OyvjRLxgImhgPQkX1pZnvMoo3g1gtQoTrs7D+ULYhZ+j5VOhRK+CUd8wv4Og9lsZ0zB1T0ZA4aULcs17srbciZd5AyP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791756273; c=relaxed/simple;
	bh=+E+2yPgFM52Q4uUx03FSXevjJs548RDbo2S2HZVICHU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KIzjyr2vpFetPj85G9JyIp3DAVlyTWyE3RO0fODvK6u20fKXWMkD2DKJwyrkIKQOyi0fqa8avKyYo+qHk6UDuMJn2XhiO9beNqZcv7hBXx5pXdJO2D3JOEvaBrAA3F6GJYjB8IVpdq3QW9e8++cgTqJmr8SctTXbz9LyQBVw6wU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=bOupf8V6; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="bOupf8V6"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4j2vl65MRgz49Q5C;
	Mon, 12 Oct 2026 01:04:18 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1791756259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iWg436DeMZU6ANCjEa6hiyibWCA1FIbSGXviILsJimo=;
	b=bOupf8V6+kvJ94BcL2hnMSSwF+B+7AiJx7O5snAEe/Re6TwQR6SnkOM8cWE3kOk7kIwQYe
	uXR/VrSuvezK1Strn/ah8L5atcigO40kNg+JwJ1b/KBmSGFugbSSwK/QDFhsojIfOtEFD5
	6Svj5VIKVtHFaeJyZzMPFO9tVTXpb2+8qPqkvWwwE//qDLJX2DvW85jGTJ34OPrEmvaHMi
	zeRTy6hTTfq7nCpUvYVtfObW7mQx/g1tLKnUgfetaC5Ms6pSmAWNBcrl0BXAyNcYk+oX6i
	k4+CUYPaZhKBcGw0Fj12OR92fbM9Dvtdgm5Nx3ivLLmuHcKk9RX2LLc5gZNs7Q==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1791756259;
	b=afTdXzgOFPnReesgoe4R1DMyngwgyKAzEOxLFvQu3fNa3xOSEHcyxa2S4LGmrf7ll52zOO
	j3dPuqHqbqIme9Mah6wa+iF1z+ZgmYHGvNaq7pKbhZc3vc8u42OWr7XFddh89i61S7Gbqz
	G4YomG7S6JVACTnhKGYHftIt0nesTsX3O0HJQJawblDL6aLYIMUQTSTfbnUqIS8D52hZ+I
	v7lM4Xzt6WEDFdeJX4ybzF7WJyFYzxdFEvZNogCSgZxqwqfQwDu8XNunzNADXkUHYNGMmg
	o5UAND0v91bMnAn2LQQAWCjQ6d7PQ9wd3psP1aML8KHgVuZiVqGG0LyA0DyWwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1791756259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iWg436DeMZU6ANCjEa6hiyibWCA1FIbSGXviILsJimo=;
	b=Xi5Wotm9ZEGWkAg/ZPnDhm4akTwBkmeJEKb9M0H1gHa20MZHOjrx+f72Wy1wPD6GSSxVnH
	bL5O4yuuphnfqxEIS8uIPhjjXYTz0p+KCnStMPDB/82T4ZJjqtp4YOA0ewbxSnitb11b7u
	tp1ATyBbi+5ln817S0fexu/FKawSuYD1Uj6S37JneD6R6Pqb8+PBEnsXje493QGh6esiIl
	6hJGdYAvYt+h2SAR1EYW2Q5dxFak0epaoj27wYL+wYx+0BJX5IV3YX3xlOkfZ0/B3ba/yh
	P/qWnkKkcLpD1j791MfBuNf0HL4m1w03eMKAC46bhGUTVAWUeENHzzPp/JCUTw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <371ebeea33645a196092fc515bdd598b2e9d1e04.camel@iki.fi>
Subject: Re: [PATCH 1/2] Bluetooth: hci_sync: add request wait hook for
 __hci_cmd_sync_sk
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linux-kernel@vger.kernel.org
Date: Mon, 12 Oct 2026 01:04:17 +0300
In-Reply-To: <fda2d67929dd3888eecaf1faaa97b3f3c16829ed.1791750397.git.pav@iki.fi>
References: <cover.1791750397.git.pav@iki.fi>
	 <fda2d67929dd3888eecaf1faaa97b3f3c16829ed.1791750397.git.pav@iki.fi>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

su, 2026-10-11 kello 23:39 +0300, Pauli Virtanen kirjoitti:
> Support doing something after hci_sync request event wait is armed, but
> before wait starts. Currently hci_req_sync_run() queues cmd_work, which
> sets hdev->req_skb and arms the wait, but hci_sync does not see when
> this occurs.
>=20
> This is needed by BIS PAST (separate patch) to signal userspace when
> kernel starts waiting for PAST Received.
>=20
> Introduce new pending hdev->req_status state HCI_REQ_QUEUE. cmd_work
> transitions QUEUE -> PEND after setting hdev->req_skb which is where
> event wait starts.
>=20
> Fire the wait hook when __hci_cmd_sync_sk() has started waiting for its
> event, and if that fails. If no wait hook, start directly with PEND, to
> avoid the extra req_wait_q wakeup.
>=20
> Rename the function to __hci_cmd_sync_sk_run(), add small wrappers to
> preserve old API.

On Sashiko review:

wait_func(hdev, wait_data, -EAGAIN); if the waited-for event arrives
before hci_sync sees QUEUE->PEND transition was intentional. Because
for PAST, I think we don't want to signal Syncinfo Request if we know
we already got the PA sync.

AFAICS it is not really issue more generally, as the wait callback can
do what it wants with the -EAGAIN.

***

Sashiko review: """Could the lack of memory barriers around req_status
lead to a data race here where we read stale data or a NULL req_rsp?=C2=A0
In hci_cmd_sync_complete(), the producer writes hdev->req_result =3D
result and updates req_status to HCI_REQ_DONE using WRITE_ONCE()
without a write memory barrier (like smp_store_release()).
Additionally, the payload hdev->req_rsp is assigned after req_status is
updated to HCI_REQ_DONE.=C2=A0When __hci_cmd_sync_sk_run() evaluates the
wait condition, it reads req_status without an acquire barrier
(smp_load_acquire()). If the CPU reorders the loads, could a concurrent
consumer observe HCI_REQ_DONE but read a NULL req_rsp because the
producer hasn't assigned it yet? If so, it seems the consumer would
erroneously return -ENODATA and leak the actual skb."""

I think the lack of explicit synchronization between
hci_cmd_sync_complete() in hdev->workqueue writing and
__hci_cmd_sync_sk() reading is potentially a real issue, but it is pre-
existing behavior and I don't think this patch touches that.

For memory barriers, Documentation/memory-barriers.txt:2294 seems to
say hci_cmd_sync_complete() is not right. Maybe the hdev->req_* should
have a guarding lock to make reasoning simpler.

> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
>  include/net/bluetooth/hci_sync.h | 10 +++-
>  net/bluetooth/hci_core.c         |  9 +++-
>  net/bluetooth/hci_sync.c         | 87 +++++++++++++++++++++++++-------
>  3 files changed, 86 insertions(+), 20 deletions(-)
>=20
> diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci=
_sync.h
> index 59cb918d1405..71736690ea7f 100644
> --- a/include/net/bluetooth/hci_sync.h
> +++ b/include/net/bluetooth/hci_sync.h
> @@ -9,8 +9,11 @@
>  #define PTR_UINT(_ptr)			((uintptr_t)((void *)_ptr))
> =20
>  #define HCI_REQ_DONE	  0
> -#define HCI_REQ_PEND	  1
> -#define HCI_REQ_CANCELED  2
> +#define HCI_REQ_QUEUE	  BIT(0)
> +#define HCI_REQ_PEND	  (HCI_REQ_QUEUE | BIT(1))
> +#define HCI_REQ_CANCELED  BIT(2)
> +
> +#define HCI_REQ_PENDING(req_status) (!!((req_status) & HCI_REQ_PEND))
> =20
>  #define hci_req_sync_lock(hdev)   mutex_lock(&hdev->req_lock)
>  #define hci_req_sync_unlock(hdev) mutex_unlock(&hdev->req_lock)
> @@ -25,6 +28,9 @@ struct hci_request {
>  	int			err;
>  };
> =20
> +typedef void (*hci_request_wait_start_t)(struct hci_dev *hdev, void *dat=
a,
> +					 int err);
> +
>  typedef int (*hci_cmd_sync_work_func_t)(struct hci_dev *hdev, void *data=
);
>  typedef void (*hci_cmd_sync_work_destroy_t)(struct hci_dev *hdev, void *=
data,
>  					    int err);
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 209244fd9391..b9214eaffd2a 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -4183,11 +4183,18 @@ static int hci_send_cmd_sync(struct hci_dev *hdev=
, struct sk_buff *skb)
>  		kfree_skb(skb);
>  	}
> =20
> -	if (READ_ONCE(hdev->req_status) =3D=3D HCI_REQ_PEND &&
> +	if (HCI_REQ_PENDING(READ_ONCE(hdev->req_status)) &&
>  	    !hci_dev_test_and_set_flag(hdev, HCI_CMD_PENDING)) {
>  		hci_dev_lock(hdev);
> +
>  		kfree_skb(hdev->req_skb);
>  		hdev->req_skb =3D skb_get(hdev->sent_cmd);
> +
> +		if ((bt_cb(hdev->req_skb)->hci.req_flags & HCI_REQ_SKB) &&
> +		    cmpxchg(&hdev->req_status, HCI_REQ_QUEUE,
> +			    HCI_REQ_PEND) =3D=3D HCI_REQ_QUEUE)
> +			wake_up_interruptible(&hdev->req_wait_q);
> +
>  		hci_dev_unlock(hdev);
>  	}
> =20
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index efbd2e5387c0..058daf1f16df 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -25,7 +25,7 @@ static void hci_cmd_sync_complete(struct hci_dev *hdev,=
 u8 result, u16 opcode,
>  {
>  	bt_dev_dbg(hdev, "result 0x%2.2x", result);
> =20
> -	if (READ_ONCE(hdev->req_status) !=3D HCI_REQ_PEND)
> +	if (!HCI_REQ_PENDING(READ_ONCE(hdev->req_status)))
>  		return;
> =20
>  	hdev->req_result =3D result;
> @@ -155,13 +155,16 @@ static void hci_request_init(struct hci_request *re=
q, struct hci_dev *hdev)
>  }
> =20
>  /* This function requires the caller holds hdev->req_lock. */
> -struct sk_buff *__hci_cmd_sync_sk(struct hci_dev *hdev, u16 opcode, u32 =
plen,
> -				  const void *param, u8 event, u32 timeout,
> -				  struct sock *sk)
> +static struct sk_buff *__hci_cmd_sync_sk_run(struct hci_dev *hdev, u16 o=
pcode,
> +					     u32 plen, const void *param,
> +					     u8 event, u32 timeout,
> +					     struct sock *sk,
> +					     hci_request_wait_start_t wait_func,
> +					     void *wait_data)
>  {
>  	struct hci_request req;
>  	struct sk_buff *skb;
> -	int err =3D 0;
> +	long err =3D 0;
> =20
>  	bt_dev_dbg(hdev, "Opcode 0x%4.4x", opcode);
> =20
> @@ -169,29 +172,58 @@ struct sk_buff *__hci_cmd_sync_sk(struct hci_dev *h=
dev, u16 opcode, u32 plen,
> =20
>  	hci_cmd_sync_add(&req, opcode, plen, param, event, sk);
> =20
> -	WRITE_ONCE(hdev->req_status, HCI_REQ_PEND);
> +	WRITE_ONCE(hdev->req_status, wait_func ? HCI_REQ_QUEUE : HCI_REQ_PEND);
> =20
>  	err =3D hci_req_sync_run(&req);
> -	if (err < 0)
> +	if (err < 0) {
> +		if (wait_func)
> +			wait_func(hdev, wait_data, err);
>  		return ERR_PTR(err);
> +	}
> +
> +	if (wait_func) {
> +		/* Sleep until we have started waiting for the event */
> +		err =3D wait_event_interruptible_timeout(hdev->req_wait_q,
> +						       READ_ONCE(hdev->req_status) !=3D HCI_REQ_QUEUE,
> +						       timeout);
> +		if (err <=3D 0 || !HCI_REQ_PENDING(READ_ONCE(hdev->req_status)))
> +			goto check_state;
> +
> +		wait_func(hdev, wait_data, 0);
> +		wait_func =3D NULL;
> +
> +		timeout =3D err;
> +	}
> =20
>  	err =3D wait_event_interruptible_timeout(hdev->req_wait_q,
> -					       READ_ONCE(hdev->req_status) !=3D HCI_REQ_PEND,
> +					       !HCI_REQ_PENDING(READ_ONCE(hdev->req_status)),
>  					       timeout);
> =20
> -	if (err =3D=3D -ERESTARTSYS)
> +check_state:
> +	if (err =3D=3D -ERESTARTSYS) {
> +		if (wait_func)
> +			wait_func(hdev, wait_data, -EINTR);
>  		return ERR_PTR(-EINTR);
> +	}
> =20
>  	switch (READ_ONCE(hdev->req_status)) {
>  	case HCI_REQ_DONE:
> +		if (wait_func)
> +			wait_func(hdev, wait_data, -EAGAIN);
>  		err =3D -bt_to_errno(hdev->req_result);
>  		break;
> =20
>  	case HCI_REQ_CANCELED:
> -		err =3D -hdev->req_result;
> +		if (wait_func)
> +			wait_func(hdev, wait_data, -ECANCELED);
> +		err =3D -(long)hdev->req_result;
> +		if (!IS_ERR_VALUE(err))
> +			err =3D -ECANCELED;
>  		break;
> =20
>  	default:
> +		if (wait_func)
> +			wait_func(hdev, wait_data, -ETIMEDOUT);
>  		err =3D -ETIMEDOUT;
>  		break;
>  	}
> @@ -201,7 +233,7 @@ struct sk_buff *__hci_cmd_sync_sk(struct hci_dev *hde=
v, u16 opcode, u32 plen,
>  	skb =3D hdev->req_rsp;
>  	hdev->req_rsp =3D NULL;
> =20
> -	bt_dev_dbg(hdev, "end: err %d", err);
> +	bt_dev_dbg(hdev, "end: err %ld", err);
> =20
>  	if (err < 0) {
>  		kfree_skb(skb);
> @@ -216,6 +248,15 @@ struct sk_buff *__hci_cmd_sync_sk(struct hci_dev *hd=
ev, u16 opcode, u32 plen,
> =20
>  	return skb;
>  }
> +
> +/* This function requires the caller holds hdev->req_lock. */
> +struct sk_buff *__hci_cmd_sync_sk(struct hci_dev *hdev, u16 opcode, u32 =
plen,
> +				  const void *param, u8 event, u32 timeout,
> +				  struct sock *sk)
> +{
> +	return __hci_cmd_sync_sk_run(hdev, opcode, plen, param, event, timeout,
> +				     sk, NULL, NULL);
> +}
>  EXPORT_SYMBOL(__hci_cmd_sync_sk);
> =20
>  /* This function requires the caller holds hdev->req_lock. */
> @@ -255,14 +296,17 @@ struct sk_buff *__hci_cmd_sync_ev(struct hci_dev *h=
dev, u16 opcode, u32 plen,
>  EXPORT_SYMBOL(__hci_cmd_sync_ev);
> =20
>  /* This function requires the caller holds hdev->req_lock. */
> -int __hci_cmd_sync_status_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
> -			     const void *param, u8 event, u32 timeout,
> -			     struct sock *sk)
> +static int __hci_cmd_sync_status_sk_run(struct hci_dev *hdev, u16 opcode=
,
> +					u32 plen, const void *param, u8 event,
> +					u32 timeout, struct sock *sk,
> +					hci_request_wait_start_t wait_func,
> +					void *wait_data)
>  {
>  	struct sk_buff *skb;
>  	u8 status;
> =20
> -	skb =3D __hci_cmd_sync_sk(hdev, opcode, plen, param, event, timeout, sk=
);
> +	skb =3D __hci_cmd_sync_sk_run(hdev, opcode, plen, param, event, timeout=
,
> +				    sk, wait_func, wait_data);
> =20
>  	/* If command return a status event, skb will be set to -ENODATA */
>  	if (skb =3D=3D ERR_PTR(-ENODATA))
> @@ -281,6 +325,15 @@ int __hci_cmd_sync_status_sk(struct hci_dev *hdev, u=
16 opcode, u32 plen,
> =20
>  	return status;
>  }
> +
> +/* This function requires the caller holds hdev->req_lock. */
> +int __hci_cmd_sync_status_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
> +			     const void *param, u8 event, u32 timeout,
> +			     struct sock *sk)
> +{
> +	return __hci_cmd_sync_status_sk_run(hdev, opcode, plen, param, event,
> +					    timeout, sk, NULL, NULL);
> +}
>  EXPORT_SYMBOL(__hci_cmd_sync_status_sk);
> =20
>  int __hci_cmd_sync_status(struct hci_dev *hdev, u16 opcode, u32 plen,
> @@ -679,7 +732,7 @@ void hci_cmd_sync_cancel(struct hci_dev *hdev, int er=
r)
>  {
>  	bt_dev_dbg(hdev, "err 0x%2.2x", err);
> =20
> -	if (READ_ONCE(hdev->req_status) =3D=3D HCI_REQ_PEND) {
> +	if (HCI_REQ_PENDING(READ_ONCE(hdev->req_status))) {
>  		hdev->req_result =3D err;
>  		WRITE_ONCE(hdev->req_status, HCI_REQ_CANCELED);
> =20
> @@ -697,7 +750,7 @@ void hci_cmd_sync_cancel_sync(struct hci_dev *hdev, i=
nt err)
>  {
>  	bt_dev_dbg(hdev, "err 0x%2.2x", err);
> =20
> -	if (READ_ONCE(hdev->req_status) =3D=3D HCI_REQ_PEND) {
> +	if (HCI_REQ_PENDING(READ_ONCE(hdev->req_status))) {
>  		/* req_result is __u32 so error must be positive to be properly
>  		 * propagated.
>  		 */

--=20
Pauli Virtanen
