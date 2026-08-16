Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365B213D891;
	Sun, 16 Aug 2026 11:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786879158; cv=pass; b=Gs6waN14KN2T6+OMjAuocVwiJhSVPEwMyx+YfF/oFtgK40xoxqM/uuaw5R0D5ybO+fgeMV2gb6ZOTUDal5gm7GUGCwAoARvkISGL0Uy1rdLlah11drICZQ9skNFu8f1gEbLw0IE251LDpKGzEyoyTAVqqKNuT3IolkigiEdiRMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786879158; c=relaxed/simple;
	bh=X8NJ9IJOR/+Kfg1TA/ssr9rmNxISWA/JkvYgkWLNFnw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RaHAZ+/H6a8ZjB6KjJp+8My2rIbtTnBhtyh21KrepnQgOZx3qWp8zX4sWjsUE73Ah5fxnOT+aR7sPrRT213lkHjIdd+oWqN2wbsZX7WNyPm9luGQzrVZXa3BH3omCOLe8sqJO+zCAjSGK964U8vHPtXQBbNpAo83sNfcceFsink=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=J5sk9nHQ; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="J5sk9nHQ"
Received: from [192.168.1.195] (unknown [IPv6:2a03:1b20:1:f410::de01])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4hND4Q6PDNz49PsK;
	Sun, 16 Aug 2026 14:19:02 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1786879143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Eyl0ljUfVjkIZzAFlUHyv+KAG+WOE1qzUaL/ZN+1SjM=;
	b=J5sk9nHQSIJ6mjqygTjrXVOU2lHRvF2yDv6ZDwukXL04jjfdWL86arSQapFvaD/OO71Ed3
	9tzU7X6vodXaUL4tJzw0INMadctnW819KzIWOz7FRr62Krn90sdVWT16qR2I/5Jjyezp7R
	sqyMQyEU1h7Fq9B0kUGlXmkyrFJ+2uk67wrD1vB3Sc+ccfljzXy4FsbXWtWNi0ixhWGPW1
	VTklGgpC+6yAiO66YQXUtvgNpXp/XRrN6mD/YEsOBiDnq4z8Og3Rd580LOZir4j6RHXd/B
	CQSF/P5aMusYn0U0OuQYBJiVE5/KK0mBC9aEpOlc4GgYhJqeMycvJuZ6jwmM6w==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1786879143;
	b=Zjf7NapKFSMVyw7EQ6MC2Bgdff1VzMDbeMa+Ir913l5gCOUjB2gfN6H/hPFxtdzhwCnn5P
	S0R+o9CCFRZFd3RspKpT0SFEC9PbzSTp5qsa07bY3Fao7J/GtltbO7L1slwXaeUTnJRuit
	ZVrEeyGnAyJ1B5091LybB+BLP9HyO7M/Z8V7EGXDzqT5qfpVkJnU2NZpEtS2e2kd2qlX6w
	7GWPp0E5cmN+JIg8dPMQokUs8kH6z6yq5pCB3Ij+5kFD9cNfluuvkJHnFvErHBWdoNJZyW
	M8RH84SYVV8gprrWAH/0M1O/MNtoAreIgkhda8SEka7+mtz2TW6C2I4XYaZlvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1786879143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Eyl0ljUfVjkIZzAFlUHyv+KAG+WOE1qzUaL/ZN+1SjM=;
	b=sBJ4dTwOhvxSvp3Oi9UFjfmgENZ/MiSCbHo3mFYHge/TyYwLhdNAO0Mfd6M3OHVl9Uifvf
	fGPv3ZOqEmdGDsezkQBirP7yM3H7jqXq7F8N3Adr8ik4mTtPbjph5jSfu9PnMHZm2NEX+v
	Q/pWpVMJUEKYlkSioQQAINh/Ck0bX4ode7A01DC869RZyeTzssIvY+pJmDi8q6Jmowfq2I
	bMfiZO9gCi8YD8gp70Vx/rPmsDia+gRfv+/2GbFIAsqdaYzzgpiqXqAb106j9pC+wDDsaL
	44pIo3ztlFAyCxS3Wg6br2wThfGWQvNJr/sPaEJK4//+7K1a4QPbA+TwqYi7Kw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <108c76a0ee67b795dee6dccd713ebcd685fe33c7.camel@iki.fi>
Subject: Re: [PATCH RESEND] Bluetooth: hci_core: add lockdep check to
 hci_conn lookups
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linux-kernel@vger.kernel.org
Date: Sun, 16 Aug 2026 14:19:00 +0300
In-Reply-To: <2be38d111362590f45776a0bc114f7890906ead9.1786875148.git.pav@iki.fi>
References: 
	<2be38d111362590f45776a0bc114f7890906ead9.1786875148.git.pav@iki.fi>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

su, 2026-08-16 kello 13:26 +0300, Pauli Virtanen kirjoitti:
> Add lockdep check for RCU || hdev->lock in hci_conn_hash lookups that
> return hci_conn pointer, as dereferencing that without locks can be
> TOCTOU issue. It used to be several callsites did not hold appropriate
> locks.

https://sashiko.dev/#/patchset/2be38d111362590f45776a0bc114f7890906ead9.178=
6875148.git.pav%40iki.fi

Sashiko review complains about HCI_CONN_HASH_LOCKDEP_CHECK() added to
wrong functions.

It applied the patch to bluetooth/master, instead of bluetooth-
next/master as intended.

Apparently the patch applies with fuzz also to bluetooth/master, but
some of the added HCI_CONN_HASH_LOCKDEP_CHECK land in wrong functions
there.

> The check is equivalent to removing rcu_read_lock() and doing instead
> list_for_each_entry_rcu(c, &h->list, list, lockdep_is_held(&hdev->lock))
> Although there should not be any remaining callsites without locks,
> don't remove the rcu_read_lock() for now, and just add the warning here.
>=20
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
>=20
> Notes:
>     resend:
>     - no changes
>=20
>  include/net/bluetooth/hci_core.h | 44 ++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>=20
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index 4105c446ca98..c12cd6873f65 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1030,6 +1030,9 @@ static inline bool hci_conn_sc_enabled(struct hci_c=
onn *conn)
>  static inline void hci_conn_hash_add(struct hci_dev *hdev, struct hci_co=
nn *c)
>  {
>  	struct hci_conn_hash *h =3D &hdev->conn_hash;
> +
> +	lockdep_assert_held(&hdev->lock);
> +
>  	list_add_tail_rcu(&c->list, &h->list);
>  	switch (c->type) {
>  	case ACL_LINK:
> @@ -1060,6 +1063,8 @@ static inline void hci_conn_hash_del(struct hci_dev=
 *hdev, struct hci_conn *c)
>  {
>  	struct hci_conn_hash *h =3D &hdev->conn_hash;
> =20
> +	lockdep_assert_held(&hdev->lock);
> +
>  	list_del_rcu(&c->list);
>  	synchronize_rcu();
> =20
> @@ -1088,6 +1093,15 @@ static inline void hci_conn_hash_del(struct hci_de=
v *hdev, struct hci_conn *c)
>  	}
>  }
> =20
> +#ifdef CONFIG_PROVE_RCU
> +#define HCI_CONN_HASH_LOCKDEP_CHECK(hdev)				\
> +	RCU_LOCKDEP_WARN(!lockdep_is_held(&(hdev)->lock) &&		\
> +			 !rcu_read_lock_held(),				\
> +			 "suspicious hci_conn locking")
> +#else
> +#define HCI_CONN_HASH_LOCKDEP_CHECK(hdev) do { } while (0 && (hdev))
> +#endif
> +
>  static inline unsigned int hci_conn_num(struct hci_dev *hdev, __u8 type)
>  {
>  	struct hci_conn_hash *h =3D &hdev->conn_hash;
> @@ -1169,6 +1183,8 @@ static inline struct hci_conn *hci_conn_hash_lookup=
_bis(struct hci_dev *hdev,
>  	struct hci_conn_hash *h =3D &hdev->conn_hash;
>  	struct hci_conn  *c;
> =20
> +	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
> +
>  	rcu_read_lock();
> =20
>  	list_for_each_entry_rcu(c, &h->list, list) {
> @@ -1191,6 +1207,8 @@ hci_conn_hash_lookup_create_pa_sync(struct hci_dev =
*hdev)
>  	struct hci_conn_hash *h =3D &hdev->conn_hash;
>  	struct hci_conn  *c;
> =20
> +	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
> +
>  	rcu_read_lock();
> =20
>  	list_for_each_entry_rcu(c, &h->list, list) {
> @@ -1217,6 +1235,8 @@ hci_conn_hash_lookup_per_adv_bis(struct hci_dev *hd=
ev,
>  	struct hci_conn_hash *h =3D &hdev->conn_hash;
>  	struct hci_conn  *c;
> =20
> +	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
> +
>  	rcu_read_lock();
> =20
>  	list_for_each_entry_rcu(c, &h->list, list) {
> @@ -1241,6 +1261,8 @@ static inline struct hci_conn *hci_conn_hash_lookup=
_handle(struct hci_dev *hdev,
>  	struct hci_conn_hash *h =3D &hdev->conn_hash;
>  	struct hci_conn  *c;
> =20
> +	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
> +
>  	rcu_read_lock();
> =20
>  	list_for_each_entry_rcu(c, &h->list, list) {
> @@ -1260,6 +1282,8 @@ static inline struct hci_conn *hci_conn_hash_lookup=
_ba(struct hci_dev *hdev,
>  	struct hci_conn_hash *h =3D &hdev->conn_hash;
>  	struct hci_conn  *c;
> =20
> +	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
> +
>  	rcu_read_lock();
> =20
>  	list_for_each_entry_rcu(c, &h->list, list) {
> @@ -1281,6 +1305,8 @@ static inline struct hci_conn *hci_conn_hash_lookup=
_role(struct hci_dev *hdev,
>  	struct hci_conn_hash *h =3D &hdev->conn_hash;
>  	struct hci_conn  *c;
> =20
> +	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
> +
>  	rcu_read_lock();
> =20
>  	list_for_each_entry_rcu(c, &h->list, list) {
> @@ -1302,6 +1328,8 @@ static inline struct hci_conn *hci_conn_hash_lookup=
_le(struct hci_dev *hdev,
>  	struct hci_conn_hash *h =3D &hdev->conn_hash;
>  	struct hci_conn  *c;
> =20
> +	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
> +
>  	rcu_read_lock();
> =20
>  	list_for_each_entry_rcu(c, &h->list, list) {
> @@ -1328,6 +1356,8 @@ static inline struct hci_conn *hci_conn_hash_lookup=
_cis(struct hci_dev *hdev,
>  	struct hci_conn_hash *h =3D &hdev->conn_hash;
>  	struct hci_conn  *c;
> =20
> +	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
> +
>  	rcu_read_lock();
> =20
>  	list_for_each_entry_rcu(c, &h->list, list) {
> @@ -1360,6 +1390,8 @@ static inline struct hci_conn *hci_conn_hash_lookup=
_cig(struct hci_dev *hdev,
>  	struct hci_conn_hash *h =3D &hdev->conn_hash;
>  	struct hci_conn  *c;
> =20
> +	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
> +
>  	rcu_read_lock();
> =20
>  	list_for_each_entry_rcu(c, &h->list, list) {
> @@ -1383,6 +1415,8 @@ static inline struct hci_conn *hci_conn_hash_lookup=
_big(struct hci_dev *hdev,
>  	struct hci_conn_hash *h =3D &hdev->conn_hash;
>  	struct hci_conn  *c;
> =20
> +	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
> +
>  	rcu_read_lock();
> =20
>  	list_for_each_entry_rcu(c, &h->list, list) {
> @@ -1407,6 +1441,8 @@ hci_conn_hash_lookup_big_sync_pend(struct hci_dev *=
hdev,
>  	struct hci_conn_hash *h =3D &hdev->conn_hash;
>  	struct hci_conn  *c;
> =20
> +	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
> +
>  	rcu_read_lock();
> =20
>  	list_for_each_entry_rcu(c, &h->list, list) {
> @@ -1431,6 +1467,8 @@ hci_conn_hash_lookup_big_state(struct hci_dev *hdev=
, __u8 handle, __u16 state,
>  	struct hci_conn_hash *h =3D &hdev->conn_hash;
>  	struct hci_conn  *c;
> =20
> +	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
> +
>  	rcu_read_lock();
> =20
>  	list_for_each_entry_rcu(c, &h->list, list) {
> @@ -1454,6 +1492,8 @@ hci_conn_hash_lookup_pa_sync_big_handle(struct hci_=
dev *hdev, __u8 big)
>  	struct hci_conn_hash *h =3D &hdev->conn_hash;
>  	struct hci_conn  *c;
> =20
> +	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
> +
>  	rcu_read_lock();
> =20
>  	list_for_each_entry_rcu(c, &h->list, list) {
> @@ -1477,6 +1517,8 @@ hci_conn_hash_lookup_pa_sync_handle(struct hci_dev =
*hdev, __u16 sync_handle)
>  	struct hci_conn_hash *h =3D &hdev->conn_hash;
>  	struct hci_conn  *c;
> =20
> +	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
> +
>  	rcu_read_lock();
> =20
>  	list_for_each_entry_rcu(c, &h->list, list) {
> @@ -1546,6 +1588,8 @@ static inline struct hci_conn *hci_lookup_le_connec=
t(struct hci_dev *hdev)
>  	struct hci_conn_hash *h =3D &hdev->conn_hash;
>  	struct hci_conn  *c;
> =20
> +	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
> +
>  	rcu_read_lock();
> =20
>  	list_for_each_entry_rcu(c, &h->list, list) {

--=20
Pauli Virtanen
