Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14E7CD6E7D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Oct 2023 15:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235072AbjJKPLh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Oct 2023 11:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbjJKPLf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Oct 2023 11:11:35 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCF99D
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Oct 2023 08:11:33 -0700 (PDT)
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:4::d001])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav@iki.fi)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4S5GSg3BGKz49PwY;
        Wed, 11 Oct 2023 18:11:28 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1697037091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=kS66O6ugsbW7X2gesO2DutqekZ/kWxGYUDSh4oNnXxw=;
        b=FXTCiPSOCISzBqIozjWBasfPUtYnpE7GGIeha4mYbM50e98gUTE9X3YPVZbKsGu/R6spIb
        I9zyyW3phcZk1y1bktfl4wssaMcLr+h/733zy4eSG3YA9j0fgENMU4NLBe7XX/TQwecsT5
        Oyusi1yBhWennkTvYe7TcyUTIF43TgMNKTClZQZwH6+rPdue8aN9mu2h4l5HLxFopLx1ul
        695kk7u2Gwmnj4ZLqjdZKWWJuQQ4tjVtdb40+uqHQmrJI8IwyPI9b4QMNI/Vb+T//LmFWw
        SwMida+vgWyv5fImfHTXxPJeru0l6DnnBBx8yUl4u583glWVTlQdhlP+dYQSaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1697037091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=kS66O6ugsbW7X2gesO2DutqekZ/kWxGYUDSh4oNnXxw=;
        b=lpZztCbMe00WJEkTEEAdixAuOXAc0dDjmOK7aCun0u8phVlTiCc0H/KNkDR/iAGxHY4yJW
        g252xq5JoJgcOV0kE5gJLA2qKd4oxR+L9u0jIxnFWyi7BfQFWNCa2bTfVAHH3ThGQhf5we
        ETiA/CvighA5XNg02/VkybO5cvdpAzIfVEd9hgrDOo1mhX7pk8Z0qHzWZyB5x2dUiq9w+A
        Tf+quBlmNOFk5TLF02ZUXniVzaH2x+R7P2C0N1oVSCMbCxTvWHyiKuHPPr+fsXK2sJZLPr
        JTPe+egK4lxtrJ/FtiZ2MJu+taJ86ukz34Sc9RPfpkYecjHmt5jJgw7BYbpAcg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1697037091; a=rsa-sha256;
        cv=none;
        b=vbsuETZd7mlJ4f9nNS0hjjVkcHZwdNcixXDIWQXd5B6p6YMC10M/G73KFcWYh6coaHERuu
        MZuZX27Z+GL7tyNkYzQQ5t5YROLTlc9b3WSq1l9cW1T6orWK9l2j77NMc9/t9G+OZc5ZwP
        2dc2y4M+U0pk4h5pXIgQUJAkP9x6In5XhW0vXIblF6Eh4RJFIJmcw/t9+Kyr2bjSFVnmNl
        q+gKrQEWM5kpz06s8XmrKeAIoJQxmzN/VXjxv73SBGJlq9H9G48YKjk9C8+cTQv7+k/Ftc
        7hVukzbk8wRmrzcvDbebLiunxadFAkLf85hTlS3SmFus2hJ+xFkY2Ra3mQjdeg==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <c278724b19ef43f58bc7940b202fcd4638906e5f.camel@iki.fi>
Subject: Re: [PATCH] Bluetooth: Make handle of hci_conn be unique
From:   Pauli Virtanen <pav@iki.fi>
To:     Ziyang Xuan <william.xuanziyang@huawei.com>,
        linux-bluetooth@vger.kernel.org
Date:   Wed, 11 Oct 2023 18:11:27 +0300
In-Reply-To: <20231011095731.1947052-1-william.xuanziyang@huawei.com>
References: <20231011095731.1947052-1-william.xuanziyang@huawei.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 (3.50.0-1.fc39) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

ke, 2023-10-11 kello 17:57 +0800, Ziyang Xuan kirjoitti:
> The handle of new hci_conn is always HCI_CONN_HANDLE_MAX + 1 if
> the handle of the first hci_conn entry in hci_dev->conn_hash->list
> is not HCI_CONN_HANDLE_MAX + 1. Use ida to manage the allocation of
> hci_conn->handle to make it be unique.
>=20
> Fixes: 9f78191cc9f1 ("Bluetooth: hci_conn: Always allocate unique handles=
")
> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
> ---
>  include/net/bluetooth/hci_core.h |  2 ++
>  net/bluetooth/hci_conn.c         | 30 +++++++++++++-----------------
>  net/bluetooth/hci_core.c         |  3 +++
>  3 files changed, 18 insertions(+), 17 deletions(-)
>=20
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index f36c1fd5d64e..a0c0e12e3a18 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -350,6 +350,8 @@ struct hci_dev {
>  	struct list_head list;
>  	struct mutex	lock;
> =20
> +	struct ida	unset_handle_ida;
> +
>  	const char	*name;
>  	unsigned long	flags;
>  	__u16		id;
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 974631e652c1..6ec161bf569a 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -153,6 +153,9 @@ static void hci_conn_cleanup(struct hci_conn *conn)
> =20
>  	hci_conn_hash_del(hdev, conn);
> =20
> +	if (HCI_CONN_HANDLE_UNSET(conn->handle))
> +		ida_free(&hdev->unset_handle_ida, conn->handle);
> +

The conn handle is replaced in hci_conn_set_handle, so old handle from
IDA probably should be freed there too.

Sorry, didn't notice this on the first round.

le_conn_complete_evt also doesn't use hci_conn_set_handle but probably
should, which now starts to matter more.

>  	if (conn->cleanup)
>  		conn->cleanup(conn);
> =20
> @@ -929,29 +932,17 @@ static void cis_cleanup(struct hci_conn *conn)
>  	hci_le_remove_cig(hdev, conn->iso_qos.ucast.cig);
>  }
> =20
> -static u16 hci_conn_hash_alloc_unset(struct hci_dev *hdev)
> +static int hci_conn_hash_alloc_unset(struct hci_dev *hdev)
>  {
> -	struct hci_conn_hash *h =3D &hdev->conn_hash;
> -	struct hci_conn  *c;
> -	u16 handle =3D HCI_CONN_HANDLE_MAX + 1;
> -
> -	rcu_read_lock();
> -
> -	list_for_each_entry_rcu(c, &h->list, list) {
> -		/* Find the first unused handle */
> -		if (handle =3D=3D 0xffff || c->handle !=3D handle)
> -			break;
> -		handle++;
> -	}
> -	rcu_read_unlock();
> -
> -	return handle;
> +	return ida_alloc_range(&hdev->unset_handle_ida, HCI_CONN_HANDLE_MAX + 1=
,
> +			       U16_MAX, GFP_ATOMIC);
>  }
> =20
>  struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *=
dst,
>  			      u8 role)
>  {
>  	struct hci_conn *conn;
> +	int handle;
> =20
>  	BT_DBG("%s dst %pMR", hdev->name, dst);
> =20
> @@ -961,7 +952,12 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, =
int type, bdaddr_t *dst,
> =20
>  	bacpy(&conn->dst, dst);
>  	bacpy(&conn->src, &hdev->bdaddr);
> -	conn->handle =3D hci_conn_hash_alloc_unset(hdev);
> +	handle =3D hci_conn_hash_alloc_unset(hdev);
> +	if (unlikely(handle < 0)) {
> +		kfree(conn);
> +		return NULL;
> +	}
> +	conn->handle =3D handle;
>  	conn->hdev  =3D hdev;
>  	conn->type  =3D type;
>  	conn->role  =3D role;
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 195aea2198a9..65601aa52e0d 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2535,6 +2535,8 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
>  	mutex_init(&hdev->lock);
>  	mutex_init(&hdev->req_lock);
> =20
> +	ida_init(&hdev->unset_handle_ida);
> +
>  	INIT_LIST_HEAD(&hdev->mesh_pending);
>  	INIT_LIST_HEAD(&hdev->mgmt_pending);
>  	INIT_LIST_HEAD(&hdev->reject_list);
> @@ -2789,6 +2791,7 @@ void hci_release_dev(struct hci_dev *hdev)
>  	hci_codec_list_clear(&hdev->local_codecs);
>  	hci_dev_unlock(hdev);
> =20
> +	ida_destroy(&hdev->unset_handle_ida);
>  	ida_simple_remove(&hci_index_ida, hdev->id);
>  	kfree_skb(hdev->sent_cmd);
>  	kfree_skb(hdev->recv_event);

--=20
Pauli Virtanen
