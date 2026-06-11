Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F35F3FBA7
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 15:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781190487; cv=none; b=b30w7MA5tvAfyz7XGJgaxLumsVjWwWS92emBuVvlFf4zYo3d/9UteavuNf+izqDIMDs6tM97FFPccCd7QsqR1W9p4cz/bNA0hjJzgn7DVdtRLF3gml2rsqK1dNN/WSE3ywdImM8aByk22tDMMVzL4hypnOI2vj8N774Xb8etGvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781190487; c=relaxed/simple;
	bh=JIvIU1/2IbuTOpveHETWJGSZrgFyDA0eotBnP/MiGG4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Bs+LMtkFWaaG0vEmEcJhaD/8jBLXORlR0noTml/HbC/bNVxCVBoRlM2axgpxdYX2u+/Yi7a94nYOh4urDa8AI2SgOc4+552Tq1eNQJZKMW69IZRGbsBLrkcMKQr1rdpPDyhMjjsmbjj2IQs3F4eR3zmDuPT5zLwsMvM7StyVFfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=iVQt+g2V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AazSO5qV; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="iVQt+g2V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AazSO5qV"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id C7745EC0180;
	Thu, 11 Jun 2026 11:08:04 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-03.internal (MEProxy); Thu, 11 Jun 2026 11:08:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781190484;
	 x=1781276884; bh=rysfYVvgJ4gJlmJ4vBWLu5scVWfjTCCDIM6wuGKhjME=; b=
	iVQt+g2V8K1n2jEAGaSq3KjvUCvWrnCmss6Ky6YQj71yGcC3LBJTohtQC+hNJY7Z
	Cnb41PsZJubmH7VY9fDE6+wHNeUZDCglEY9Ou5NyWv7lkXqEDl5kaINfWe5wSpWK
	Zj0qa0DiE9HLSMfC3+yQ6r8KhxhfdqlPj6kFRdcF7EF8TNICmyUomoc+/uYoh0Pq
	sIQgiJRP4w6jEsR5FQ1tAotXmC4b/gI/b/euPioA2CpDQ7gJyJ317SrxprldeSYo
	MAc1mSrghNdhatcppPtOMIqZ+ZlsAiUG+Nvobhmxm0KvXloSaH7W1IGZJKz1PIT4
	4JdTRXlgMDfKPGwrNKvslw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781190484; x=
	1781276884; bh=rysfYVvgJ4gJlmJ4vBWLu5scVWfjTCCDIM6wuGKhjME=; b=A
	azSO5qV82NblzIUFiP2nIy9dWlC00JL9FANnKZkzOgrXh8FphbaTccXHcaUJuuPQ
	8xM+Ohr5AYNAMcg3TARILOi6q8NPeXHzPwURfzzxcIeGz37GpLwEXfV8juBbRoew
	S/gDtmZasDflPawkNsZzStyVGMENctfYW4uPj0xR8OtTVJqEsMjfntBjE/BPqaTX
	nO6iL38wCUUoKJrLkZYDZn9UBhbaf1V2iV1dFR8cKKFxCQTmWZ3Y2LO2In9CnxGS
	PopqWvABF4xJB881vumfJ+/Pg8wVcGpb6sFY6cyFCWqEzZqVv5BDQt7EBMuFcTyD
	AvYl8nPfUdrmiIl+EAU5w==
X-ME-Sender: <xms:VM8qai_6cj3vyhY1uTONoL3Mzg9NQ3FONBQqWOmGG-pwIbk4nNtr1w>
    <xme:VM8qatiTnbfLh8qwi8vPuzefj-N3mG4ewqNJ7XQU_y96YP0TMveyM4bLSUORXp49N
    -0o8ELyMxy_LjXIb9jtW_MPxJcZb40SE5tF6A_B_9KpnFc_b2n-fg>
X-ME-Proxy-Cause: dmFkZTGhe1JYk4TNyRL/5jpL02+H0/sF/uQSbO1+AX4NpAr2YW/C4imB2g2C/2mCfH74Et
    OSIhxArOtsVmmLcgnzlYomkMzNWE0v/QBmAAx8CFgww6otrx+ckoAUdvq6lToVBRj3ha9q
    r193oCuoNJBKeQa+mAzDHEEBs86LbW5p+GV3iAMLk43e/0XU5DHMsYz536CBJOlcP7IdCR
    zyjjJ6vKM3ZcnaVoipiNTichfpG4cmRKk2EYBKzOESyY5Ehm2csdAUGwfGrqyqHMyjTvgn
    6SRMOAp2sp8qt0Ref0RIBk1KUTPEhaXbZiolPSvhr4XFBji8vPm0PI+YLdZYHKZ36CBCp3
    1MuQRrz/0NZKyTrUasogvQp+OfT5nUD7Y1nb1p8hVwZe3oKH0pPQUuBmDnamMI8NiJpaFA
    pMP4ypfDrTfGVv8MH7RXhetWyfEY+K1bgmL8iJOqgoeFEiKvpQSFSEBf+I67YXu9lTDN7h
    ioCaCjsY9N1mNWWOLbnL7iku+nwfbDbRxLm7XZ8JziU7n+AgBRMWO2TtBGDc6Vfr09JsOB
    rPTCK+RjM7DpEt3CCiTYfanZSHHKT87p9/sUKwr0XQ0BQbMK+9j/CWEW7qPlY67Wj2GMlc
    TdJ5OGKdLhEhGuRKL9QnD7LAimHR3kH80BC3doUVR7YhaeY/ZvoJNoIcu4HA
X-ME-Proxy: <xmx:VM8qahpLvHiOpESTjJHnr47Gg24q6x-BkYg-2k26OgWXCK0kFyL75g>
    <xmx:VM8qahmfd4Obk69rXQnEJ-hnbEcI8m1wNUjidBMQnYeS3qQq3PUAgQ>
    <xmx:VM8qalyxsbU0AZj74pU8kKPmLo6dfiy87JxMdIBaJ6u9T5WtudHlew>
    <xmx:VM8qapkXaehI_riJGBixzmEVNtwdVa03ZCw21wJUJi17cIki_psFzQ>
    <xmx:VM8qaiSS6bDjJymzgRclbxB8LpPb695U0qeOZsERzhGQpTkKF0nEu6Jb>
Feedback-ID: if72e4b10:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 97188216008B; Thu, 11 Jun 2026 11:08:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aze8-ILGPtOs
Date: Thu, 11 Jun 2026 11:07:42 -0400
From: "Siwei Zhang" <oss@fourdim.xyz>
To: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <18d67760-9dee-453c-92e4-9d6539fcdc4d@app.fastmail.com>
In-Reply-To: <20260611150628.2164737-1-oss@fourdim.xyz>
References: <20260611150628.2164737-1-oss@fourdim.xyz>
Subject: Re: [PATCH v2] Bluetooth: hci_conn: Fix null ptr deref in hci_abort_conn()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Thu, Jun 11, 2026, at 11:06 AM, Siwei Zhang wrote:
> hci_abort_conn() read hci_skb_event(hdev->sent_cmd) when a connection
> was pending, but hdev->sent_cmd can be NULL while req_status is still
> HCI_REQ_PEND, leading to a NULL pointer dereference and a general
> protection fault from the hci_rx_work() receive path.
>
> Instead of inspecting hdev->sent_cmd, track the in-flight create
> connection command with a new per-connection HCI_CONN_CREATE_CONN flag
> and route all cancellation through hci_cancel_connect_sync(), which
> dequeues the command if still queued, or cancels the pending request if
> this connection owns the in-flight create command. CIS uses the same
> path via the existing HCI_CONN_CREATE_CIS flag.
>
> Fixes: a13f316e90fd ("Bluetooth: hci_conn: Consolidate code for 
> aborting connections")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
> ---
>  include/net/bluetooth/hci_core.h |  1 +
>  net/bluetooth/hci_conn.c         | 21 ++----------
>  net/bluetooth/hci_sync.c         | 58 +++++++++++++++++++++++++-------
>  3 files changed, 50 insertions(+), 30 deletions(-)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index aa600fbf9a53..c90ca6173680 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -988,6 +988,7 @@ enum {
>  	HCI_CONN_AUTH_FAILURE,
>  	HCI_CONN_PER_ADV,
>  	HCI_CONN_BIG_CREATED,
> +	HCI_CONN_CREATE_CONN,
>  	HCI_CONN_CREATE_CIS,
>  	HCI_CONN_CREATE_BIG_SYNC,
>  	HCI_CONN_BIG_SYNC,
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 54eabaa46960..eba4a548bef5 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -3181,26 +3181,11 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
> 
>  	conn->abort_reason = reason;
> 
> -	/* If the connection is pending check the command opcode since that
> -	 * might be blocking on hci_cmd_sync_work while waiting its respective
> -	 * event so we need to hci_cmd_sync_cancel to cancel it.
> -	 *
> -	 * hci_connect_le serializes the connection attempts so only one
> -	 * connection can be in BT_CONNECT at time.
> +	/* Cancel the connect attempt. A return of 0 means the create command
> +	 * was still queued and got dequeued, so there is nothing to 
> disconnect.
>  	 */
> -	if (conn->state == BT_CONNECT && READ_ONCE(hdev->req_status) == 
> HCI_REQ_PEND) {
> -		switch (hci_skb_event(hdev->sent_cmd)) {
> -		case HCI_EV_CONN_COMPLETE:
> -		case HCI_EV_LE_CONN_COMPLETE:
> -		case HCI_EV_LE_ENHANCED_CONN_COMPLETE:
> -		case HCI_EVT_LE_CIS_ESTABLISHED:
> -			hci_cmd_sync_cancel(hdev, ECANCELED);
> -			break;
> -		}
> -	/* Cancel connect attempt if still queued/pending */
> -	} else if (!hci_cancel_connect_sync(hdev, conn)) {
> +	if (!hci_cancel_connect_sync(hdev, conn))
>  		return 0;
> -	}
> 
>  	/* Run immediately if on cmd_sync_work since this may be called
>  	 * as a result to MGMT_OP_DISCONNECT/MGMT_OP_UNPAIR which does
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index df23245d6ccd..08917b8167de 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -6668,6 +6668,12 @@ static int hci_le_create_conn_sync(struct 
> hci_dev *hdev, void *data)
>  					     &own_addr_type);
>  	if (err)
>  		goto done;
> +
> +	/* Mark create connection in flight so hci_cancel_connect_sync() can
> +	 * cancel it while blocking on the connection complete event.
> +	 */
> +	set_bit(HCI_CONN_CREATE_CONN, &conn->flags);
> +
>  	/* Send command LE Extended Create Connection if supported */
>  	if (use_ext_conn(hdev)) {
>  		err = hci_le_ext_create_conn_sync(hdev, conn, own_addr_type);
> @@ -6703,6 +6709,8 @@ static int hci_le_create_conn_sync(struct hci_dev 
> *hdev, void *data)
>  				       conn->conn_timeout, NULL);
> 
>  done:
> +	clear_bit(HCI_CONN_CREATE_CONN, &conn->flags);
> +
>  	if (err == -ETIMEDOUT)
>  		hci_le_connect_cancel_sync(hdev, conn, 0x00);
> 
> @@ -6982,10 +6990,19 @@ static int hci_acl_create_conn_sync(struct 
> hci_dev *hdev, void *data)
>  	else
>  		cp.role_switch = 0x00;
> 
> -	return __hci_cmd_sync_status_sk(hdev, HCI_OP_CREATE_CONN,
> -					sizeof(cp), &cp,
> -					HCI_EV_CONN_COMPLETE,
> -					conn->conn_timeout, NULL);
> +	/* Mark create connection in flight so hci_cancel_connect_sync() can
> +	 * cancel it while blocking on the connection complete event.
> +	 */
> +	set_bit(HCI_CONN_CREATE_CONN, &conn->flags);
> +
> +	err = __hci_cmd_sync_status_sk(hdev, HCI_OP_CREATE_CONN,
> +				       sizeof(cp), &cp,
> +				       HCI_EV_CONN_COMPLETE,
> +				       conn->conn_timeout, NULL);
> +
> +	clear_bit(HCI_CONN_CREATE_CONN, &conn->flags);
> +
> +	return err;
>  }
> 
>  int hci_connect_acl_sync(struct hci_dev *hdev, struct hci_conn *conn)
> @@ -7039,20 +7056,37 @@ int hci_connect_le_sync(struct hci_dev *hdev, 
> struct hci_conn *conn)
> 
>  int hci_cancel_connect_sync(struct hci_dev *hdev, struct hci_conn *conn)
>  {
> -	if (conn->state != BT_OPEN)
> -		return -EINVAL;
> +	hci_cmd_sync_work_func_t func = NULL;
> +	hci_cmd_sync_work_destroy_t destroy = NULL;
> +	int create_flag = -1;
> 
>  	switch (conn->type) {
>  	case ACL_LINK:
> -		return !hci_cmd_sync_dequeue_once(hdev,
> -						  hci_acl_create_conn_sync,
> -						  conn, NULL);
> +		func = hci_acl_create_conn_sync;
> +		create_flag = HCI_CONN_CREATE_CONN;
> +		break;
>  	case LE_LINK:
> -		return !hci_cmd_sync_dequeue_once(hdev, hci_le_create_conn_sync,
> -						  conn, create_le_conn_complete);
> +		func = hci_le_create_conn_sync;
> +		destroy = create_le_conn_complete;
> +		create_flag = HCI_CONN_CREATE_CONN;
> +		break;
> +	case CIS_LINK:
> +		/* LE Create CIS is shared by the whole CIG and cannot be
> +		 * dequeued per-connection; only cancel it in-flight below.
> +		 */
> +		create_flag = HCI_CONN_CREATE_CIS;
> +		break;
> +	default:
> +		return -ENOENT;
>  	}
> 
> -	return -ENOENT;
> +	if (func && hci_cmd_sync_dequeue_once(hdev, func, conn, destroy))
> +		return 0;
> +
> +	if (create_flag >= 0 && test_bit(create_flag, &conn->flags))
> +		hci_cmd_sync_cancel(hdev, ECANCELED);
> +
> +	return -EBUSY;
>  }
> 
>  int hci_le_conn_update_sync(struct hci_dev *hdev, struct hci_conn *conn,
> -- 
> 2.54.0

Sorry, please ignore this. Wrong patch.
