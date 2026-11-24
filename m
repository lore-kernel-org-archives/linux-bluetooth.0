Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795538121;
	b=AkKrv7BpI01efOMI36heip8+AfWMhb459Fr9hiEnf5CYfSCdW9gGNixnj+CGFW9X6SKO
	 hQMMdaf+7FiGVa0YlPGZ9txUosvuMUviDGhYV0s5pFdNjHCrvjVKD/BJCpm3UWeSzfWgU
	 EotwbGEIhmLwrQmE9ThHS+vfGLBK0ht0E9GSPzQd04AnXJx1gs4eEoKVQarTaHbIQoWqe
	 zziFW50SSdy/sLtSUEnphy1e3sCJ3LDZ+xIH98KxTLslx2cTxW2qAunAlR8kbIsyfpU1q
	 8t1kVyyQKejXo4nAGkrNh+RgsX89LDLmkhh66nmVHu3JTLA3b5wWDHdUQLuaHD0euOw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795538121;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Q1q2fcn9fQHuOJd5rAEfOkFeJSM6fAoxK5VQa+ilSls=;
	b=RNInrBf3X+6XNNxqJi36w/Wkj6nYmnSwIqfh88hzVizrkoAJwacveMg1CDWLPYvXBjNA
	 bWwTr+bpMbkJ7dyhIg6+KBRP7JtPmgMiYeUn1wG7x4cAFltKFOxKPRh+MuUOMZFmsFO6j
	 fvgoK9vkw9o494RqSs6MK8ighxaRaa7IZC8d3Qfl/4gebmreR7X58X0N0DZio+629bjwV
	 fpckNur8g/RaBKrrmIyXKlJi94uv8LDfzIgrBdThOmG6M/LnR2VEuN+7Gx236cnd+LmkS
	 incflESo8uInUKC+7hWOtA5sxgZea6lfkQJpc4DTWgx3UNYJFSRuFrIPSI+F574A05Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=04L5qKV7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.171
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F25606A323
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 16:35:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57F25606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=04L5qKV7
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8b4ea3c5afaso32019087b3.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 08:35:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795538120; cv=none;
        d=google.com; s=arc-20260327;
        b=IzsIE+MrcDxflQuO8/BO5+arcBEX4xvisKr5ApqVCGT40a7rUkVhAbvdewsABYxreo
         T9Bq1kuEmZHLW+b0aJ7Va8KSNuXjM6fY59dM1gJt8BBfHEiQxwur0HfA9Lp+iSPeAKY1
         GLFzr6Er7Cl/EeMSdH82v6zkG9hKbt+9aq/o30i1hni8Z1I8AouumZppfQ+9ziCvnMYM
         blFmCv9KW51icMlEb25uS6esboC3wA/8E8eoWvhErEXMk8wdvHQyHP6b24m27xHe2i6e
         JwD/ZIjaslunPNrVG8OxDCOedReJdhVhY2tVnx9Q/De4BfW/meH853vG8wVMBuWyALwz
         63aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q1q2fcn9fQHuOJd5rAEfOkFeJSM6fAoxK5VQa+ilSls=;
        fh=c7qQ970vRGoBLczBxOZOp4N563LsSYIlfhryj848jTU=;
        b=LkYXGsopytGkEtCkwDjdrMHrY0eYAA2TUmQTr7ZAzRdtsGogr2B9KV0r+gnIO7Av4Y
         wB5+r609Cy+QSIgD41drA5KD1stJmLN1urcHBf9G0oc7SWrNKgbjlrJziYE6j2IBzlsF
         iT2BHOXoCVBBJSBkCEw09ND9KCe82/nzkHZOp2fvCOJNiNFBOYrW53UDZcQ03Q/BsZLV
         hfC8H97b8Z3XXGS4nq33QTTVdYfslHZwp3/NJkX28uJSrVWps2lSRYc1k3/J8YohznEp
         7/qCS9W6+rdCyRldmn5lXT79xfJq/HwAZ5+gbI3119QqEjwWDRy2VnBk3GXbzkEpEuL5
         Eb/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795538120; x=1796142920; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q1q2fcn9fQHuOJd5rAEfOkFeJSM6fAoxK5VQa+ilSls=;
        b=04L5qKV7f1wXxeDhtgn0RuTHsfVXFVqiIjdVBavsJIo5maITe43jK/Kt7+BheWgJ4G
         K3ETEJtA/5um/qVhM7s9S5J+BqnAqN4NEVoXmmWePjlmvYh/+uCD3Vo0ilgJpq1AKgjN
         C5z+ng/lTZdixDOgst3s5PTu8Hjejg5jDOkFHIRsl2kZvorh4RjV21U0azg5pr16jbVI
         BNFiYg/n9WZkW6/pZzIGq1vGV6b8lmbZowlDscaihmP1T9tpklX5CjuyGJ8ra7Gtj3TZ
         14PkP0b8NJh61omrqD0TwEhADLNG5Hxrmk4EbZlAe2rAghMiK5ShgUf/SkxOnEuDk3HS
         WfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795538120; x=1796142920;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q1q2fcn9fQHuOJd5rAEfOkFeJSM6fAoxK5VQa+ilSls=;
        b=zI1owqDCvs5jJJPm2+HJqPadSaFtXUxuOOtpyRrVK534MAl/Nx12MKMjy8HWG6+Btt
         OWABTM2tXB/qpc9WeJDiUsArdK+fijpEtQcQCSdPDLVv5mX3mOkrYaOcuWwApmrkogGb
         OWZ7I2BY9Rvnx63Cc1Gf32lplo5d5zD4YSX8fupm+vCt6piutxRx1KppxEYrDmzbbHvL
         lKL4UqxTTyv1bXkpp3v5fuC6RFegx0dtVKZRyJu3gGJyGVQewQrVO69pr5hcBBLsE1fa
         NWJ27GJVzGvBgW9z+99lY+scSAsic4MtzuBSyt9onelBy6ntyQQnQC7/vnS1kuCvXrCO
         lrAA==
X-Forwarded-Encrypted: i=1; AL+hErEhMS2r0Mbi62GKEaWzXm/0/wh9U5dQ1vsoIz8W2GRJwxt1LZ8QWfXbHCU4j0V//81+yGldCYbcrkvTbp/5UkA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9RP/xMSLmYOHi3P1SUGOkJZu/sRtHuIMD1Sz/Cyrkx+p/Y2fK7
	w+ddFjkerlI3Jp3ghK/BRqiIvZIUDnFhak53lUn19695XRiOBcRDubTpok/YJ1Q5kl0z92YryiR
	tVZx6/ua1Q00knesmtii/4sMS8J2Ly0A=
X-Gm-Gg: AZFdTZf0E9BwvxXkEjyITpKV3CfpDFdcYYZVJyxxu17m4G3h/2XZg0/DSBX7JdMP+Lr
	nbIH7NFyWCMvbBmoZB7edM9y2QKRcDL+P09NAdc9EkcAqV0EsVOz4dNw6SSZJsCS+xar/oR5WMy
	RIYUHfgtOWZ/JURp4zMRgvJVB6nvO6SzXFszVnq/ETxv4Kw6JE+jvnFLJqovcTKP9y0bmnp9+Ge
	nq/e5rX4q5QKXA9f5DWhylr1unMq6vcaW37u+/dJ3d5+rZqmI7bXLVFDMtQw1h5PkcIDIbuCkeq
	ddlsFNWLoyNxQggKP64bhHDN+qWZ9vs7IbH2AEA7vgiSJl57qCMyTH1ObfnK+MqPvj3gGmBZck9
	r92Pn+jStPQqG+ANuDBma8NG3ve49cD11JSy2LKdCa6NjDJTwuH/DZhvDKEFv8YhsyZgAQbj+aF
	gyASmLSUiiVccGHS6hUPDXLL1fOB0AKfT+cZsBX6PBOmSOuP/zYglHgsPghotL1dBg1EoSsrE5b
	EAQ0A==
X-Received: by 2002:a05:690c:a409:20b0:8b1:8dae:e8a with SMTP id
 00721157ae682-8b52043cd97mr31267007b3.20.1795538120088; Tue, 24 Nov 2026
 08:35:20 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261124-for-upstream-le-conn-params-rpa-v4-0-f2dd5eb41f45@podgorny.cz>
 <20261124-for-upstream-le-conn-params-rpa-v4-2-f2dd5eb41f45@podgorny.cz>
In-Reply-To: <20261124-for-upstream-le-conn-params-rpa-v4-2-f2dd5eb41f45@podgorny.cz>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 24 Nov 2026 11:35:08 -0500
X-Gm-Features: Aa3M54oYGPSa1mat6D7LEK4uErs7ATZyYto1_uaeH_zD0QzKThEF3gVMCQ9BrgE
Message-ID: <CABBYNZKCSXsMb++hkgxk+Q8m1W1=+=Z_sgpaQFgWtnSJg8G43w@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] Bluetooth: connect to an RPA as to the identity
 behind it
To: Radek Podgorny <radek@podgorny.cz>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
	Johan Hedberg <johan.hedberg@intel.com>, Jakub Pawlowski <jpawlowski@google.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Radek,

On Tue, Nov 24, 2026 at 4:31=E2=80=AFAM Radek Podgorny <radek@podgorny.cz> =
wrote:
>
> A connect made to a peer's RPA through hci_connect_le_scan(), from Pair
> Device, an L2CAP socket or a CIS, looks for an existing connection by
> that RPA only. A bonded peer's established connection is kept under its
> identity, so the lookup misses it and a second hci_conn is created
> under the RPA, which waits until the connect times out. An L2CAP
> connect to the RPA of a connected peer does exactly that on v7.3.5.
> The connect also marks params under the RPA for itself, while the
> peer's advertising reports are resolved to its identity before
> check_pending_le_conn() looks params up, so it is never started either.
>
> Resolve an RPA to the identity first, through a new
> hci_rpa_to_identity(), so the connect proceeds as one made to the
> identity: it finds the peer's connection and marks the identity's
> params. hci_connect_le() still puts the RPA on air when the controller
> cannot resolve it. SMP can free the IRK without hdev->lock, so the
> identity is copied out under rcu_read_lock().
>
> A connection hci_connect_le() is already creating for the peer is kept
> under the RPA it dials, which the lookup by the identity now misses.
> Fall back to finding the peer's connection by its IRK, which also finds
> it after the peer has moved to a new RPA.
>
> Fixes: f75113a26008 ("Bluetooth: add hci_connect_le_scan")
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Radek Podgorny <radek@podgorny.cz>
> ---
>  include/net/bluetooth/hci_core.h |  2 ++
>  net/bluetooth/hci_conn.c         | 57 ++++++++++++++++++++++++++++++++++=
++++++
>  net/bluetooth/hci_core.c         | 20 ++++++++++++++
>  3 files changed, 79 insertions(+)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index 4aa0b49ae104..28eb79dd51f0 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1927,6 +1927,8 @@ int hci_bdaddr_list_del_with_irk(struct list_head *=
list, bdaddr_t *bdaddr,
>                                  u8 type);
>  void hci_bdaddr_list_clear(struct list_head *list);
>
> +void hci_rpa_to_identity(struct hci_dev *hdev, bdaddr_t **addr,
> +                        u8 *addr_type, bdaddr_t *id_addr);
>  struct hci_conn_params *hci_conn_params_lookup(struct hci_dev *hdev,
>                                                bdaddr_t *addr, u8 addr_ty=
pe);
>  struct hci_conn_params *hci_conn_params_add(struct hci_dev *hdev,
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 8638b7f8dee3..c1583cb6c28a 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -1520,6 +1520,54 @@ u8 hci_conn_set_handle(struct hci_conn *conn, u16 =
handle)
>         return 0;
>  }
>
> +/* A connection to a peer the controller cannot resolve is kept under th=
e
> + * peer's RPA until it completes, and the peer may have moved to a new R=
PA
> + * since. Match it by the peer's IRK instead of by address.
> + *
> + * This function requires the caller holds hdev->lock.
> + */
> +static struct hci_conn *le_conn_by_irk(struct hci_dev *hdev,
> +                                      const u8 irk_val[16])
> +{
> +       struct hci_conn_hash *h =3D &hdev->conn_hash;
> +       struct hci_conn *c;
> +
> +       rcu_read_lock();
> +       list_for_each_entry_rcu(c, &h->list, list) {
> +               if (c->type !=3D LE_LINK ||
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
> +/* Find the LE connection of the peer at addr by the peer's IRK, for whe=
n it
> + * is kept under one of the peer's RPAs instead of addr.
> + *
> + * This function requires the caller holds hdev->lock.
> + */
> +static struct hci_conn *le_conn_lookup_irk(struct hci_dev *hdev,
> +                                          bdaddr_t *addr, u8 addr_type)
> +{
> +       struct hci_conn *conn =3D NULL;
> +       struct smp_irk *irk;
> +
> +       rcu_read_lock();
> +       irk =3D hci_find_irk_by_addr(hdev, addr, addr_type);
> +       if (irk)
> +               conn =3D le_conn_by_irk(hdev, irk->val);
> +       rcu_read_unlock();
> +
> +       return conn;
> +}
> +
>  struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
>                                 u8 dst_type, bool dst_resolved, u8 sec_le=
vel,
>                                 u16 conn_timeout, u8 role, u8 phy, u8 sec=
_phy)
> @@ -1787,6 +1835,7 @@ struct hci_conn *hci_connect_le_scan(struct hci_dev=
 *hdev, bdaddr_t *dst,
>                                      enum conn_reasons conn_reason)
>  {
>         struct hci_conn *conn;
> +       bdaddr_t id_addr;
>
>         /* Let's make sure that le is enabled.*/
>         if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED)) {
> @@ -1796,6 +1845,12 @@ struct hci_conn *hci_connect_le_scan(struct hci_de=
v *hdev, bdaddr_t *dst,
>                 return ERR_PTR(-EOPNOTSUPP);
>         }
>
> +       /* Connect to the peer as if by its identity, under which its
> +        * connection and parameters are kept. hci_connect_le() puts its =
RPA
> +        * on air when the controller cannot resolve it.
> +        */
> +       hci_rpa_to_identity(hdev, &dst, &dst_type, &id_addr);
> +
>         /* Some devices send ATT messages as soon as the physical link is
>          * established. To be able to handle these ATT messages, the user=
-
>          * space first establishes the connection and then starts the pai=
ring
> @@ -1806,6 +1861,8 @@ struct hci_conn *hci_connect_le_scan(struct hci_dev=
 *hdev, bdaddr_t *dst,
>          * and return the object found.
>          */
>         conn =3D hci_conn_hash_lookup_le(hdev, dst, dst_type);
> +       if (!conn)
> +               conn =3D le_conn_lookup_irk(hdev, dst, dst_type);

Any reason why le_conn_lookup_irk is not incorporated into
hci_conn_hash_lookup_le? That would mean other plcares that want to
resolve a hci_conn to a peer always lookup by both address or irk not
just by address.

>         if (conn) {
>                 if (conn->pending_sec_level < sec_level)
>                         conn->pending_sec_level =3D sec_level;
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 024960e9af66..a87c92dccd4f 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2359,6 +2359,26 @@ int hci_bdaddr_list_del_with_irk(struct list_head =
*list, bdaddr_t *bdaddr,
>         return 0;
>  }
>
> +/* A peer we hold the IRK of is tracked under its identity address, so
> + * point *addr and *addr_type at the identity behind an RPA we can resol=
ve.
> + * SMP can free the IRK without hdev->lock, so the identity is copied to
> + * @id_addr before leaving the RCU read-side section.
> + */
> +void hci_rpa_to_identity(struct hci_dev *hdev, bdaddr_t **addr,
> +                        u8 *addr_type, bdaddr_t *id_addr)
> +{
> +       struct smp_irk *irk;
> +
> +       rcu_read_lock();
> +       irk =3D hci_get_irk(hdev, *addr, *addr_type);
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
>
> --
> 2.56.1
>


--=20
Luiz Augusto von Dentz
