Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794250325;
	b=YKAiFrlhf7VNjX9higPQYQTH+TMR0kJ0Ou/ih7EthKYo/KF1Szup9MesWf6IjWC0XMz8
	 CPbPGffdsMU1m2Ml6KTzak9MRfQfvAVkfUr09Glk9IfQGCN7AcKsgZsqWNUGTK/3H4+7U
	 WlQvekbXosWSPX+t6JGxJdpj+sjolzwYYzBz/s3sRo0vgy3BoXvSovHCdyLYVK8CKZKfW
	 k2bEnCwHqbeWbtv4zOMkAUxE7+JtWF8GEpLp84u7Qc+rdohrd8ivFJy45TdXv3D+7czS2
	 uj33CZugNn+FUhU74tOYt1Sa9KTTK8RIuIT8hVEbgFHxoUKKgUUDAAD8nfBqeSSLY5g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794250325;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=7c8+phLoXYZrE8cOaqBv/1uGhkQ9Ws+f7SgvvClsdKQ=;
	b=k5K74OC/iuMcgmBL0qvNxJK5wbRqrU0HUvZqfU7ZQ55WbTA3qX6o8sc5iqqf9HNAHT1b
	 Vqiv56kk9Ev9v2Fk+oPWWXHbfwT73nd3lS7ccH6GMgy88tQsy8ZI4JzlNktKh+XULCYRF
	 7sWQb2lIqHMnZMy20qy6KOdh8vz81FTeFdacgOL6aXO8Tp3wfp3KhsldPdfzUHRHFcsr2
	 w0umUt0E5iMgpZz7RHj7ni+Bad2162+WqJTzsspbM8ldBm7i4sauwx+pWIaqC1DqWKPUb
	 R1Iw9kInOJmjtvPoDZdrROp1Hb90ZBppDEtw3o+0qa4qlpZ0FyYRVESGZWvXmXUluZg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C7Eotg+s;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D839A606A31C
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Nov 2026 18:52:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D839A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C7Eotg+s
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8b335eeb340so9435067b3.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Nov 2026 10:52:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794250324; cv=none;
        d=google.com; s=arc-20260327;
        b=nXeqhOjUDiKZOzg17cC32hG3wF0Tjv7AYJjb4roXaLjyc5jLY4z9TZjOXEPCKoXWzu
         XFcQezLlSHnPvJzcl22qlbT//cjzDH4vMMNfraFOJTnagPOv9IXH/1CS4ODAblRdl/oh
         hv3NP5j+zhlRDrnfhEq8/8HE3MouJrGfyCDdMHONbF7uA7YCzK6u77pt7/648Ul/chTE
         6Rl3i5KDvCBUuOtId/dunuL0XM8FmT8sZDRCYnM7JprxJkZ+Hzj+FnVAQnHFpZz/rLVV
         inCa3NNeFLwg0yVNzSd4it9nNVAwgGhOjBAg/5oD5jbGenyshIbU52mBxrrq1YvYdw9M
         MlFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7c8+phLoXYZrE8cOaqBv/1uGhkQ9Ws+f7SgvvClsdKQ=;
        fh=WI9rGGmeoU53TQQa1W0NZzMBG9rI+H9+fRYIaDuw290=;
        b=IiwGJ2K4noxkiHaV249PTg9XelLqJmxQeFKIDja1FvieVNGU8bVhNaoYW7bijgF/gu
         EspkYXiNZWv/ikGVcIuMoV5UqFn+iUDSLsIgqN2DPIxISmJlUxqG4altSN/FjRDaAkOt
         ma9qq8KzsQkwmk9XDNN9PFhXd5iRv3I5VgxOCMm1k3xYNu/2Jofz1A/0hgtCNjhoS/Kh
         ed0fy7+EfKgjDNQroDdpEqnyalt23eGM5VSO7FZk5P0APnd75RphZictOQ8TZmZGJpVU
         Vs9LE7IhDtZTBl1hj78FUgFQyIfjuDajFR4k7rMdr5w+pEetQlkXFsCXJ6rzvMJ7ZItY
         Vccw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794250324; x=1794855124; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7c8+phLoXYZrE8cOaqBv/1uGhkQ9Ws+f7SgvvClsdKQ=;
        b=C7Eotg+sf4TWoAopEpgpS9uzN2IrDEERuyYtuFObt766knNQ/oegNCrwIJ5CBNO3KG
         kCF4jJ6Y5dL3JiIsNcF+F7vkztB2TtmodNJg0nFvIi+IFpsqM7n7rdY5IajwAw7aeb5E
         PJjOCu+uAGVpIRJxH6ytMCUisjlxft+IXBoVv9KALg/Z1CNjwse2qS+NRrg1x7lMMqsa
         X3yQ3oA3THbji2+YIcrqAHBL4OcwFYvt2nrds1/ymFYei6A2Hw/MhURepewFBE0BwbXE
         NfaScjjSgMWIkjytlzrZUug5AxzAr7jlOUfihA+6zOYrJ97YaHkgbMdmrI+9rny51lmH
         78qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794250324; x=1794855124;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7c8+phLoXYZrE8cOaqBv/1uGhkQ9Ws+f7SgvvClsdKQ=;
        b=hlIbEa5ggit5f3Jahp0hxDKMFuEtYPXluuNawmv84lwPIqz6GIFDfea8l7aTkgfRVX
         nQGjK7F/eWc5rJi0ooUOVCjCx8Blm0j8mz6yh5x5bazI9VN3ciuQNqpYrMkMm/Ysc6U7
         SZEiSlnFEFYg7ak9e0nqzoTj4zLn8R63WpPhuxbuojTGs3YS+pPdJoqQWtUfXpxWFAfg
         b1LqNEVAPSIXbWJSHS1/enTa28JrBjYzEzTxq7l1Z9OXReB/un1ZUEHTdaQgsgcMCpQf
         6aHYeDal7Y+9m4tcnf40K4HQwSFzv7ZhGthVRvRablYvE3odcgmJBZ+zFg7MezAWeFkJ
         dWNA==
X-Forwarded-Encrypted: i=1; AL+hErGkXtf8piDmpzv+YiD5865CqGPcRlXFtqrqZI7D21JXt3Ei7fsMG0aWHq+JBozSx6IuodZ5rr7x3PhtizxfIjw=@vger.kernel.org
X-Gm-Message-State: APuU4Z95+SpVJrBl4U4OMoa8t5R1khuuK2FA8um8F9rNM8Qzrz6TqHTc
	QWiabKeOLA4oq/ekVK0PRaOfvvgfnNUkPEmSp/PBjlotokGpX/KiyvjaMxAEceGg2Ueaxh2azOL
	KnTchBIsgi6tnd4LOLF3rytiXZs6bI3s7jg==
X-Gm-Gg: AYBFou08WY5va+bCvnWH0sOC/Dkv0oKXLyTsM+bYXVd3/5FiDBVPAw9EMwKgvn2LJRX
	KQXr9hhc+WemAJgJ0cUZTAtRpb8TE2hJCqjYDVXtdrp4vKIA4ZcLg0tWV1gjWcog2MPntd70MTf
	iiUqJNZExCFJ4c8/JG0Z0pgd5RTm7GY797WtCg0/5VoxoO17tOn49oBp5/jzPFJs8iKG/EJgInm
	HNrGNphnGtJlJNvhdnnOD7hVONUhuKMyOfZXheU4Mh5UgaPcJsBJsyUVsmBrK5VrPBSXuGQSFsR
	4IX7pFgjjrQaO6tOsm/6DTgu3GWovmKVZPnICVO26T4lOD9kmEzvpfBK5FxU68rVKTleOGJGSZS
	OK1PiuieKChZ9xxsN7cDv+JgqbxOuU5C9doM/sjiDynn8D9cycTytMx+wafxW9XQNl6/DUdKPiW
	wKcSlPTD96ni2HvyrUTueiTgTEP5YLN9Y2HgFHIy5948Q5BlxZRVK5FCjg
X-Received: by 2002:a05:690c:a057:b0:8b3:150b:43dd with SMTP id
 00721157ae682-8b392b553camr1186047b3.77.1794250323766; Mon, 09 Nov 2026
 10:52:03 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109-for-upstream-le-conn-params-rpa-v3-1-ad1225bb0b8f@podgorny.cz>
In-Reply-To: <20261109-for-upstream-le-conn-params-rpa-v3-1-ad1225bb0b8f@podgorny.cz>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 9 Nov 2026 13:51:52 -0500
X-Gm-Features: AclHuK-9cI713_BUVjsqlZUPAWvBuIdns_ZlMJT9KuYyfrTuAGPZ0iXdSfX85VM
Message-ID: <CABBYNZLFtpr8xFjnimRZ9VKOsEgUV-Gzf61bomK4u+SMEyqBxA@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: find an RPA peer's connection parameters by
 its identity
To: Radek Podgorny <radek@podgorny.cz>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Radek,

On Mon, Nov 9, 2026 at 1:28=E2=80=AFPM Radek Podgorny <radek@podgorny.cz> w=
rote:
>
> A bonded peer's connection parameters are stored under its identity
> address, but hci_conn_params_lookup() matches only the exact address it
> is given, so a caller holding the peer's RPA misses the entry.
>
> hci_le_create_conn_sync() is such a caller: hci_connect_le() puts the
> peer's cached RPA in conn->dst, and __hci_conn_add() no longer converts
> it back when the controller cannot translate an identity address. The
> connection is then created with the controller-wide defaults in hdev
> instead of the peer's interval, latency and supervision timeout.
>
> Resolve an RPA to its identity in hci_conn_params_lookup(), so every
> caller finds the same entry whichever of the peer's addresses it holds.
> The identity is looked up instead of the RPA, not after it: Pair Device
> creates an entry under the RPA the peer had before bonding, and that
> entry stays behind with default parameters. Matching it first would hand
> it out for as long as the peer keeps that RPA. Such an entry is no
> longer reachable by its RPA once the IRK is known; it is cleared with
> the other disabled entries the next time all connection parameters are
> loaded. The IRK can be freed by SMP without hdev->lock, so its identity
> is copied out under rcu_read_lock().
>
> hci_conn_params_add() and hci_conn_params_del() go through the same
> lookup, so given a resolvable RPA they now act on the identity entry.
> hci_conn_params_add() also stores a new entry under the identity, or a
> later lookup by the identity or by a rotated RPA would miss it.
>
> The returned entry can therefore hold a different address type than
> the one the caller passed. load_conn_param() and load_conn_subrate()
> look up the connection by the entry's address with the caller's type;
> use the entry's type with it.
>
> A connect made to the peer's RPA, through hci_connect_le_scan() from
> Pair Device, an L2CAP socket or a CIS, now marks the identity entry for
> the explicit connect. When the peer advertises, check_pending_le_conn()
> calls hci_connect_le() with the resolved identity, but the scanning
> connection is still under the RPA, so the lookup by identity misses it
> and a second hci_conn is created. Look the scanning connection up by
> the peer's IRK instead, which also finds it after the peer has moved to
> a new RPA. Do so whether the host or the controller resolved the
> advertisement, and whether or not an RPA is cached for the peer: both
> lead to check_pending_le_conn() with the identity. The RPA dialled is
> copied out of the IRK under rcu_read_lock() for the same reason as
> above.
>
> Fixes: 4914c4998961 ("Bluetooth: put the peer's on-air address on air whe=
n we cannot resolve")
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Radek Podgorny <radek@podgorny.cz>
> ---
> v3 addresses the issues Sashiko raised on v2:
> https://sashiko.dev/#/patchset/20261104120138.1165715-1-radek%40podgorny.=
cz
>
> Tested on v7.3.1 (the flags test needs &c->flags there) with a
> Raspberry Pi CYW43455 central and a peer on a resolvable private
> address whose parameters are loaded under its identity: 7 of 7
> connects, one Create Connection each to the RPA, each carrying the
> identity's parameters. Not exercised: an RPA rotation between
> attempts, and the controller-resolved and no-cached-RPA cases of the
> scanning-connection lookup, which this controller and peer cannot reach.
>
> Per Documentation/process/generated-content.rst: the patch and this
> message were done with the Claude coding assistant (model as in the
> Assisted-by trailer). The prompts asked it to fix the issues Sashiko
> raised on v2, then to review the result following Sashiko's published
> review prompts and fix what that turned up. The author directed the work
> and reviewed the result.
> ---
> Changes in v3:
> - Look up the identity instead of the RPA, not after it, so an entry
>   left under the peer's pre-bonding RPA cannot shadow it
> - Copy the identity out of the IRK under rcu_read_lock(), since SMP can
>   free the IRK without hdev->lock
> - hci_conn_params_add() stores a new entry under the identity
> - load_conn_param() and load_conn_subrate(): look up the connection with
>   the entry's address type
> - hci_connect_le(): find the scanning connection of a connect made to
>   the peer's RPA by its IRK, so it is not duplicated once the identity
>   entry is pending, even after the peer has moved to a new RPA, and
>   also when the controller resolved the advertisement or no RPA is
>   cached for the peer. Kept in this patch, since on its own it would
>   leave a reference imbalance until the lookup is fixed
> - Rebased on bluetooth-next
> - Link to v2: https://patch.msgid.link/20261104120138.1165715-1-radek@pod=
gorny.cz
>
> Changes in v2:
> - Resolve the RPA inside hci_conn_params_lookup() rather than at the
>   hci_le_create_conn_sync() call site, as Luiz suggested, so no other
>   caller can miss the entry
> - Rebased on bluetooth-next
> - Link to v1: https://patch.msgid.link/20261101-for-upstream-le-conn-para=
ms-rpa-v1-1-988629a09bc9@podgorny.cz
> ---
>  net/bluetooth/hci_conn.c | 60 ++++++++++++++++++++++++++++++++++++++++--=
------
>  net/bluetooth/hci_core.c | 32 ++++++++++++++++++++++++++
>  net/bluetooth/mgmt.c     |  4 ++--
>  3 files changed, 84 insertions(+), 12 deletions(-)
>
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index eebd73988bf6..fddfeca9b02a 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -1502,12 +1502,42 @@ u8 hci_conn_set_handle(struct hci_conn *conn, u16=
 handle)
>         return 0;
>  }
>
> +/* A connect made to one of the peer's RPAs leaves its scanning object u=
nder
> + * that RPA when the controller cannot resolve it, and the peer may have
> + * moved to a new RPA since. Match it by the peer's IRK instead of by ad=
dress.
> + *
> + * This function requires the caller holds hdev->lock.
> + */
> +static struct hci_conn *le_scanning_conn_by_irk(struct hci_dev *hdev,
> +                                               const u8 irk_val[16])
> +{
> +       struct hci_conn_hash *h =3D &hdev->conn_hash;
> +       struct hci_conn *c;
> +
> +       rcu_read_lock();
> +       list_for_each_entry_rcu(c, &h->list, list) {
> +               if (c->type !=3D LE_LINK ||
> +                   !test_bit(HCI_CONN_SCANNING, c->flags) ||
> +                   !hci_bdaddr_is_rpa(&c->dst, c->dst_type))
> +                       continue;
> +
> +               if (smp_irk_matches(hdev, irk_val, &c->dst)) {
> +                       rcu_read_unlock();
> +                       return c;
> +               }
> +       }
> +       rcu_read_unlock();
> +
> +       return NULL;
> +}
> +
>  struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
>                                 u8 dst_type, bool dst_resolved, u8 sec_le=
vel,
>                                 u16 conn_timeout, u8 role, u8 phy, u8 sec=
_phy)
>  {
>         struct hci_conn *conn;
>         struct smp_irk *irk;
> +       bdaddr_t rpa;
>         int err;
>
>         /* Let's make sure that le is enabled.*/
> @@ -1533,25 +1563,35 @@ struct hci_conn *hci_connect_le(struct hci_dev *h=
dev, bdaddr_t *dst,
>         if (conn && !test_bit(HCI_CONN_SCANNING, conn->flags))
>                 return ERR_PTR(-EBUSY);
>
> -       /* Check if the destination address has been resolved by the cont=
roller
> -        * since if it did then the identity address shall be used.
> -        */
> -       if (!dst_resolved) {
> -               /* When given an identity address with existing identity
> -                * resolving key, the connection needs to be established
> -                * to a resolvable random address.
> +       rcu_read_lock();
> +       irk =3D hci_find_irk_by_addr(hdev, dst, dst_type);
> +       if (irk) {
> +               /* A connect made to one of the peer's RPAs is still scan=
ning
> +                * under that RPA, whatever address the peer is seen on n=
ow.
> +                */
> +               if (!conn)
> +                       conn =3D le_scanning_conn_by_irk(hdev, irk->val);
> +
> +               /* Check if the destination address has been resolved by =
the
> +                * controller since if it did then the identity address s=
hall
> +                * be used.
> +                *
> +                * Otherwise, when given an identity address with existin=
g
> +                * identity resolving key, the connection needs to be
> +                * established to a resolvable random address.
>                  *
>                  * Storing the resolvable random address is required here
>                  * to handle connection failures. The address will later
>                  * be resolved back into the original identity address
>                  * from the connect request.
>                  */
> -               irk =3D hci_find_irk_by_addr(hdev, dst, dst_type);
> -               if (irk && bacmp(&irk->rpa, BDADDR_ANY)) {
> -                       dst =3D &irk->rpa;
> +               if (!dst_resolved && bacmp(&irk->rpa, BDADDR_ANY)) {
> +                       bacpy(&rpa, &irk->rpa);
> +                       dst =3D &rpa;
>                         dst_type =3D ADDR_LE_DEV_RANDOM;
>                 }
>         }
> +       rcu_read_unlock();
>
>         if (conn) {
>                 /* dst may just have been swapped for the peer's RPA abov=
e, and
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index bfc5bdebc71a..c9f4f4038e0a 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2285,11 +2285,37 @@ int hci_bdaddr_list_del_with_irk(struct list_head=
 *list, bdaddr_t *bdaddr,
>         return 0;
>  }
>
> +/* A peer's connection parameters are kept under its identity address, s=
o
> + * point *addr and *addr_type at the identity behind an RPA we can resol=
ve.
> + * SMP can free the IRK without hdev->lock, so the identity is copied to
> + * @id_addr before leaving the RCU read-side section.
> + */
> +static void conn_params_resolve(struct hci_dev *hdev, bdaddr_t **addr,
> +                               u8 *addr_type, bdaddr_t *id_addr)
> +{
> +       struct smp_irk *irk;
> +
> +       if (!hci_bdaddr_is_rpa(*addr, *addr_type))
> +               return;
> +
> +       rcu_read_lock();
> +       irk =3D hci_find_irk_by_rpa(hdev, *addr);
> +       if (irk) {
> +               bacpy(id_addr, &irk->bdaddr);
> +               *addr =3D id_addr;
> +               *addr_type =3D irk->addr_type;
> +       }
> +       rcu_read_unlock();
> +}
> +
>  /* This function requires the caller holds hdev->lock */
>  struct hci_conn_params *hci_conn_params_lookup(struct hci_dev *hdev,
>                                                bdaddr_t *addr, u8 addr_ty=
pe)
>  {
>         struct hci_conn_params *params;
> +       bdaddr_t id_addr;
> +
> +       conn_params_resolve(hdev, &addr, &addr_type, &id_addr);
>
>         list_for_each_entry(params, &hdev->le_conn_params, list) {
>                 if (bacmp(&params->addr, addr) =3D=3D 0 &&
> @@ -2345,6 +2371,12 @@ struct hci_conn_params *hci_conn_params_add(struct=
 hci_dev *hdev,
>                                             bdaddr_t *addr, u8 addr_type)
>  {
>         struct hci_conn_params *params;
> +       bdaddr_t id_addr;
> +
> +       /* Store a new entry under the identity too, or lookups by the
> +        * identity or a later RPA would miss it.
> +        */
> +       conn_params_resolve(hdev, &addr, &addr_type, &id_addr);

Not following the comments on this one, why would we want a duplicate
entry for the same device? The comment say it is a new entry, but we
would lookup so both an RPA or identity shall now result in the same
hci_conn_params entry, so something is off here and we shouldn't
really need to do conn_params_resolve before lookup because lookup
itself does it anyway.

>         params =3D hci_conn_params_lookup(hdev, addr, addr_type);
>         if (params)
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 260ef2a45719..3bf62fa2e7c2 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -8265,7 +8265,7 @@ static int load_conn_param(struct sock *sk, struct =
hci_dev *hdev, void *data,
>                          * a connection update.
>                          */
>                         conn =3D hci_conn_hash_lookup_le(hdev, &hci_param=
->addr,
> -                                                      addr_type);
> +                                                      hci_param->addr_ty=
pe);
>                         if (conn && conn->role =3D=3D HCI_ROLE_MASTER &&
>                             (conn->le_conn_min_interval !=3D min ||
>                              conn->le_conn_max_interval !=3D max ||
> @@ -8380,7 +8380,7 @@ static int load_conn_subrate(struct sock *sk, struc=
t hci_dev *hdev, void *data,
>
>                         conn =3D hci_conn_hash_lookup_le(hdev,
>                                                        &hci_param->addr,
> -                                                      addr_type);
> +                                                      hci_param->addr_ty=
pe);
>                         if (conn && conn->state =3D=3D BT_CONNECTED &&
>                             (conn->le_rate_interval < min ||
>                              conn->le_rate_interval > max ||
>
> ---
> base-commit: 4c684359d8e17be11c7fdace223dd1801bd0f1b1
> change-id: 20261101-for-upstream-le-conn-params-rpa-f2334fb5dda7
>
> --
> Radek Podgorny <radek@podgorny.cz>
>


--=20
Luiz Augusto von Dentz
