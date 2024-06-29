Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2F62E3EE
	for <linux-bluetooth@vger.kernel.org>; Sat, 29 Jun 2024 10:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719655672; cv=pass; b=ZB7jXJapl6GCzCEyUJkcQ0Oa2qECC9b6QIzuDf3bQIJM7EepWjRIrR1gmoejs6NK80lJOs6llf/r9DQ6I8TjVaHJ5mA8KOQKqCREpx9NhFjQK7A7ztGu06Nbqg3mPaOZksJM7V3vHjU9MFr9S+5OLnSh2cj1iPpNFQaZ5fsTdKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719655672; c=relaxed/simple;
	bh=71YtXqVYk8lHzrHBW/gLjJVJ7hF34+z+c/9Za9AsVR0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l+UN/l0BiF5MW3nVwZ/O+VymFsNYmd+9rdoGeErEiodwV9d9A154nB5v3J+JoicnVG4zF8kFdvZbW7NAw5e0IODFiLW4xtesR03we+/CamFQjsxef2I+KiiPdCllCsUQI7mRc5pgT0jp+5ul5p4Kl8qM19bci00ezAaoqzuNuM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=Z1xUK/SS; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="Z1xUK/SS"
Received: from monolith.lan (91-152-121-138.elisa-laajakaista.fi [91.152.121.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4WB7KG5lJwz49Q35;
	Sat, 29 Jun 2024 13:07:46 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1719655667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2koLoXKZ2fqxMNIDnoEzx9vG3ZkhF5x30EVh/JIMlqw=;
	b=Z1xUK/SSxtup4Xx7a95hkPyMv36R/C3iiXWfolqP/hmS7EOpwl3PQytV6IcCXmsws1WF8c
	mg2rRB8rTHMco0DrPCeL17pmJwVhVsCBSLZJ9LiQ5d3Yu7ircBw4ESeMqzFmrtjbBZ4yCp
	Wj1zGsqyGWmZD5BVHRAkTcVuHTco/A0NpN8cnk2/+lWARecIPdi3JX8XzNN5c1MptItZBH
	ta3aBuLr7WqgMZRIk5ho3/zjQ/nfaa2JPP6TjQf8gbto2ookOiFnSLiBAhqB21xPlZeP/X
	IHw3UclpYg9yabTtz5KtuPj6xYfar3Nn8cjC8y87l4XJogAqdWAi7tZZiKZkbQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1719655667; a=rsa-sha256;
	cv=none;
	b=d9SfFmSfXaABIIRIbD7I+PqwAKIzBDH5ZAV6vCEAgWYYRImTVrS8KQjlFI6AHMF+uU+AcU
	PfitcEkiwQfNLDv/p8eZHk6MHM8qazURU7vwYkJLezKlnF+ExFpyVafz/b8bgvjxJ7DDEH
	EBMaW38i6wNuEeVKi1U+8IqVNWoR8JzV81tum8qIAgQsNoNMpCTsZibBz86EqHrenu7cQ7
	ZeS26i7PrYnLFfpqdFwfkSa9zkD6TpqARULop+gjy/Lyu32+Uo+3P5z/D/Z/UgSUdDPXsT
	/9ykOTGi3ZD2OSFnJUNa2yVYjUnz0Oe18eXT0F53zeKh81G1E3vbVAjvQwmIIA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1719655666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2koLoXKZ2fqxMNIDnoEzx9vG3ZkhF5x30EVh/JIMlqw=;
	b=oGnZtXY640ydoSz0wMgC5xFMOrYC4bNparzz+RJpiVXLjWyFX2YyzLcSyCGqwPfonfJ8sA
	rdrSwxSLeYrycnEMfp1TfqYmIk7MlBtl/n3jgZFEsJzna6nJVyXhqFOxQXJ4VFj/L2T2Zb
	vpXQDzxKrWag4Y9zG7Jrf2iF0/gq4T2eGgu3P3T4OUc0nwdOwaSbwxQWJDi3NDzHuFyekH
	YHpCYGDI1lVGMEumTgMcR6nVnsnixooS9+Rp1fFERMsx55hSWSmzbQcK8CltXEFZg6o6Zp
	HaU5pktS5l07dwX9RAJTORbLhFNJmcHRJVnjmAYKMXt2NIw3HI0q5yg7Q4IwJg==
Message-ID: <a9609dd3d0cb3b8c3fd387efe8a81eddc821be0f.camel@iki.fi>
Subject: Re: [PATCH v1] Bluetooth: Fix double free in hci_req_sync_complete
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Date: Sat, 29 Jun 2024 13:07:46 +0300
In-Reply-To: <20240624144911.3817479-1-luiz.dentz@gmail.com>
References: <20240624144911.3817479-1-luiz.dentz@gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Luiz,

ma, 2024-06-24 kello 10:49 -0400, Luiz Augusto von Dentz kirjoitti:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>=20
> This fixes the following race:
>=20
> cpu1                       cpu2
> =3D=3D=3D=3D                       =3D=3D=3D=3D
>                            sock_ioctl
>                            sock_do_ioctl
>                            hci_sock_ioctl
> hci_rx_work                hci_dev_cmd
> hci_event_packet           hci_req_sync
> req_complete_skb           __hci_req_sync
> hci_req_sync_complete
>=20
> If hci_rx_work executes before __hci_req_sync releases req_skb, everythin=
g
> is normal, otherwise it will result in double free of req_skb.
>=20
> This replaces the usage of hci_req_sync with hci_cmd_sync_status.
>=20
> Fixes: 45d355a926ab ("Bluetooth: Fix memory leak in hci_req_sync_complete=
()")
> Reported-and-tested-by: syzbot+35ebc808442df6420eae@syzkaller.appspotmail=
.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D35ebc808442df6420eae
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  include/net/bluetooth/hci_sync.h |  2 +
>  net/bluetooth/hci_core.c         | 72 ++++++++------------------------
>  net/bluetooth/hci_sync.c         | 13 ++++++
>  3 files changed, 33 insertions(+), 54 deletions(-)
>=20
> diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci=
_sync.h
> index b49057bbdf23..20168732f20e 100644
> --- a/include/net/bluetooth/hci_sync.h
> +++ b/include/net/bluetooth/hci_sync.h
> @@ -38,6 +38,8 @@ int __hci_cmd_sync_status(struct hci_dev *hdev, u16 opc=
ode, u32 plen,
>  int __hci_cmd_sync_status_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
>  			     const void *param, u8 event, u32 timeout,
>  			     struct sock *sk);
> +int hci_cmd_sync_status(struct hci_dev *hdev, u16 opcode, u32 plen,
> +			const void *param, u32 timeout);

In this patch, this function is unused?

> =20
>  void hci_cmd_sync_init(struct hci_dev *hdev);
>  void hci_cmd_sync_clear(struct hci_dev *hdev);
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index d541cbb991eb..144e85ebfbdb 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -63,50 +63,6 @@ DEFINE_MUTEX(hci_cb_list_lock);
>  /* HCI ID Numbering */
>  static DEFINE_IDA(hci_index_ida);
> =20
> -static int hci_scan_req(struct hci_request *req, unsigned long opt)
> -{
> -	__u8 scan =3D opt;
> -
> -	BT_DBG("%s %x", req->hdev->name, scan);
> -
> -	/* Inquiry and Page scans */
> -	hci_req_add(req, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
> -	return 0;
> -}
> -
> -static int hci_auth_req(struct hci_request *req, unsigned long opt)
> -{
> -	__u8 auth =3D opt;
> -
> -	BT_DBG("%s %x", req->hdev->name, auth);
> -
> -	/* Authentication */
> -	hci_req_add(req, HCI_OP_WRITE_AUTH_ENABLE, 1, &auth);
> -	return 0;
> -}
> -
> -static int hci_encrypt_req(struct hci_request *req, unsigned long opt)
> -{
> -	__u8 encrypt =3D opt;
> -
> -	BT_DBG("%s %x", req->hdev->name, encrypt);
> -
> -	/* Encryption */
> -	hci_req_add(req, HCI_OP_WRITE_ENCRYPT_MODE, 1, &encrypt);
> -	return 0;
> -}
> -
> -static int hci_linkpol_req(struct hci_request *req, unsigned long opt)
> -{
> -	__le16 policy =3D cpu_to_le16(opt);
> -
> -	BT_DBG("%s %x", req->hdev->name, policy);
> -
> -	/* Default link policy */
> -	hci_req_add(req, HCI_OP_WRITE_DEF_LINK_POLICY, 2, &policy);
> -	return 0;
> -}
> -
>  /* Get HCI device by index.
>   * Device is held on return. */
>  struct hci_dev *hci_dev_get(int index)
> @@ -735,6 +691,7 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
>  {
>  	struct hci_dev *hdev;
>  	struct hci_dev_req dr;
> +	__le16 policy;
>  	int err =3D 0;
> =20
>  	if (copy_from_user(&dr, arg, sizeof(dr)))
> @@ -761,8 +718,8 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
> =20
>  	switch (cmd) {
>  	case HCISETAUTH:
> -		err =3D hci_req_sync(hdev, hci_auth_req, dr.dev_opt,
> -				   HCI_INIT_TIMEOUT, NULL);
> +		err =3D __hci_cmd_sync_status(hdev, HCI_OP_WRITE_AUTH_ENABLE,
> +					    1, &dr.dev_opt, HCI_CMD_TIMEOUT);

These probably were intended to use hci_cmd_sync_status that has the
locking?

>  		break;
> =20
>  	case HCISETENCRYPT:
> @@ -773,19 +730,23 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
> =20
>  		if (!test_bit(HCI_AUTH, &hdev->flags)) {
>  			/* Auth must be enabled first */
> -			err =3D hci_req_sync(hdev, hci_auth_req, dr.dev_opt,
> -					   HCI_INIT_TIMEOUT, NULL);
> +			err =3D __hci_cmd_sync_status(hdev,
> +						    HCI_OP_WRITE_AUTH_ENABLE,
> +						    1, &dr.dev_opt,
> +						    HCI_CMD_TIMEOUT);
>  			if (err)
>  				break;
>  		}
> =20
> -		err =3D hci_req_sync(hdev, hci_encrypt_req, dr.dev_opt,
> -				   HCI_INIT_TIMEOUT, NULL);
> +		err =3D __hci_cmd_sync_status(hdev, HCI_OP_WRITE_ENCRYPT_MODE,
> +					    1, &dr.dev_opt,
> +					    HCI_CMD_TIMEOUT);
>  		break;
> =20
>  	case HCISETSCAN:
> -		err =3D hci_req_sync(hdev, hci_scan_req, dr.dev_opt,
> -				   HCI_INIT_TIMEOUT, NULL);
> +		err =3D __hci_cmd_sync_status(hdev, HCI_OP_WRITE_SCAN_ENABLE,
> +					    1, &dr.dev_opt,
> +					    HCI_CMD_TIMEOUT);
> =20
>  		/* Ensure that the connectable and discoverable states
>  		 * get correctly modified as this was a non-mgmt change.
> @@ -795,8 +756,11 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
>  		break;
> =20
>  	case HCISETLINKPOL:
> -		err =3D hci_req_sync(hdev, hci_linkpol_req, dr.dev_opt,
> -				   HCI_INIT_TIMEOUT, NULL);
> +		policy =3D cpu_to_le16(dr.dev_opt);
> +
> +		err =3D __hci_cmd_sync_status(hdev, HCI_OP_WRITE_DEF_LINK_POLICY,
> +					    2, &policy,
> +					    HCI_CMD_TIMEOUT);
>  		break;
> =20
>  	case HCISETLINKMODE:
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index eff648853ae1..ccad43f10415 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -280,6 +280,19 @@ int __hci_cmd_sync_status(struct hci_dev *hdev, u16 =
opcode, u32 plen,
>  }
>  EXPORT_SYMBOL(__hci_cmd_sync_status);
> =20
> +int hci_cmd_sync_status(struct hci_dev *hdev, u16 opcode, u32 plen,
> +			const void *param, u32 timeout)
> +{
> +	int err;
> +
> +	hci_req_sync_lock(hdev);
> +	err =3D __hci_cmd_sync_status(hdev, opcode, plen, param, timeout);
> +	hci_req_sync_unlock(hdev);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL(hci_cmd_sync_status);
> +
>  static void hci_cmd_sync_work(struct work_struct *work)
>  {
>  	struct hci_dev *hdev =3D container_of(work, struct hci_dev, cmd_sync_wo=
rk);

--=20
Pauli Virtanen
