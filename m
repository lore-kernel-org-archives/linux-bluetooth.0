Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D190E306B1B
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 14:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788876052; cv=pass; b=K+owlRsaF8xQc/Rq0hwmZqQm7cosrZXChjYPRcFhZsYmYFs2LUL8DE7z8X1aD4qJ3P8i0J7RhAYsTh9TAr9DTyHlax8IJQr18AGARDcrCLAtL0SWyuAMufuyIzLuRhFktwfAWHaT5B7ctoiwXjEnOchKf3MRrpf18NJWQX0fozA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788876052; c=relaxed/simple;
	bh=iPjwqdkAoSQfhEH46iMs8ytY7do3IzdmRx6c6+kJVJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AElKcZqNE+edYm0UoAbYP2/BweZTASznsYmT88qhgFTOn1n7tHIjCm+EfldtKritAsP2Ca2RRcOAHZ/AbjLoXpUQc6I6BxUG41kQCHHky75ssCzKQcheSDynFIieUX+H07r4WfwtqGvLV0SbmcQcPn2C4tG/o7k2Bga9rkLXPGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pwJhGDYn; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pwJhGDYn"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-857ff9fef54so41578367b3.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Sep 2026 07:00:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788876035; cv=none;
        d=google.com; s=arc-20260327;
        b=n3FzZB1SPSgRS+EXWki/efPLD6znptHe8LdWPdrjlAlVdavas5/Tovze8X7vOoNXtF
         0CAa7nFtEYhcWaF2QhLzcYl1emD79kWWAT7lADc1nqzgxzMoMoHEgzBMAMrjPST5yxDy
         Z2fkA/bctqGI3IxJDDjH8uCoBAv2wo+0BjIKj3XeUyIXgRM7gl8+V3fW449Egklufs/u
         YuFDNBaeW+dqi0tXGtuotSXGzQdPH26Ce9P818cL+wLH//sy71AhLgTjJAtzBsZReti+
         VfTmvoQTDK+Ho6NeaeyCfdpM3QrFbLw0S5zX2L2DOGpdpnQOGdTfqvYMM1jbM7L1cn5K
         z9aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k640zG7BWa9KUAoBYdvfQi2mkX3cXyctSPNiuSYngu4=;
        fh=ZlY1jdqy5/pVxUnJtKG2g1CIFBfthpqpQGTM3Nmhetk=;
        b=S2EONRRXgAkl0apV/27ZeN7pw6dERy5FhIeuInNaqPRSDYYzQ943Oc5hRsNOzfjzFX
         846I4bFJxoBuSQXCk16ZRssTSTYqrL82lx/wNf8fWizaw1oY5VzwDHaHgqwa2cDP2Cs8
         vM0OcpDunn3zlqizKqjBiZbDFwkuzFQpVYz3uSHYevqKZxAgDNA6CxbrQYA+rUrbWnai
         QOklsNXv8NvbEawAp+VF3y/QQPJ4PspHyOjHwcXJFNLbM6KnKeYfux90vl1Pxtt3JWVV
         pr2TTCOM5lUHyP/YRD0VoZTzSUPCO33hfN56t8LRArmmpUw9Ol6wGmCX+V9/UVRfR7CP
         N16g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788876035; x=1789480835; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k640zG7BWa9KUAoBYdvfQi2mkX3cXyctSPNiuSYngu4=;
        b=pwJhGDYnQVQgFCQ+pf9Zod0iTnE9eeHu/YETKfvDqyg+bzA7DM3LewrnPxt2C2P9WY
         rINGvdJU/JukZN777J99BGxx1nMRlx5MSkMYctxUWWx5JjI558Ykz2oQ5ICNUJNKGepm
         QUmaiVjoS5Oes1ENPA9Z4upq84P/J/MNG5Sp93p7CXA5M93bbUtLjV94SIQ1JWZAv+qW
         0d9fZiLnoPppvlc11uo834qKdyg2z/nAM/q6OcBSwROs/glgTZdfwSRPP2I4RijMf6Zn
         AHw+zPLuj7nW16AE6TJwzgwIp2vIJUg/BFp2/OF+To+jQflUnAjSODcampziMHiY1yfy
         c5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788876035; x=1789480835;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k640zG7BWa9KUAoBYdvfQi2mkX3cXyctSPNiuSYngu4=;
        b=iHp9i1UUpOBv909jRJX9t7RojUfJU0vixDhMz6EYpg+LqtRXQdWRGApp6OV6ljdX4Z
         IkJTG5broaUO8ZkyU6HvFRe3umANIxazYTuv4G1lTHSh5fCs5bUWTXU7kOdzhDhkmnf8
         kY/swmypxWMS9KScs0/OhGpHM/Conj6MkYBqe4NYmC5U4N6YC7Rw+C3e44lto7gGY1MY
         cfcm5f/88iLWSSgkt8WicKc1umZVr//BgMkHvllLhEWrynaAeKrNlp/mAtYDppAlJS/t
         JWcdhDgwP1j/SWKzTRedBRkVbOT8nZw4qkVAB3y76bz6/r5a/PPekkdR/weLHVj/u7r9
         e83Q==
X-Forwarded-Encrypted: i=1; AKwUvByHi9Pr4MS6phf0oBAZJpJVlwKOqZ6xRErsXVesEtvm+J/qiuGglh/xyDTu4Jxa9oNGo2py3+Ocy7zDAdyfqLg=@vger.kernel.org
X-Gm-Message-State: AFuF++nzT9gvXEu1v81Na/9wcO933qh1zbLjz488QKvcjFmnO+vzqPu7
	AeecEWLi0kpTHBWkzFZIorJPtPFdt48J5mL7zzxBlGZpBbR2S1ydCYRH0XhjnIIaSI4LG+ElD1c
	0gy8ciG8vaooMpIGFcdVGwwf4pCyCKOfpT7CoYgpWjQ==
X-Gm-Gg: AYBFou1pBaXTVEd/Mr6bShAHORog/Pdj+KfmBoGbYizDHMnsNiaF83AURVwzAjkIBkW
	vMbQAKUPMVpR0ys3L9i5QrSYt+b/rU1goryaPwUjhY3qSg0lxUd596aNsyZxYKOE7uui6TGa5IA
	DGTWZ4JV96P+FQ0iLcLQDC4qR2o76ufVmrQN+SRYs/BrFuV18UWuLTV81QPMfcY6jGb0cJef67p
	ap6Jiviyn91ld0KDTFxo0dVXJ3RH6NbJaSURPslpWhQGCDSddAPYfBugzYIJ8/IhImBbSdqnh4U
	6cSi/MHvSNVsRN6rqWjOQemblM5izsiRU4AUzZGQZwWloUlhataNT52jSL7gB3AXZ2rVVEu+nrh
	rg0nkXfHU5OLJTHQsk6zZNODXaqXZwlxJypW4dBQ=
X-Received: by 2002:a05:690c:39b:b0:873:5bb2:6c07 with SMTP id
 00721157ae682-8735bb26d1emr73936247b3.49.1788876034932; Tue, 08 Sep 2026
 07:00:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908012048.3681904-2-radek@podgorny.cz> <20260908012048.3681904-4-radek@podgorny.cz>
In-Reply-To: <20260908012048.3681904-4-radek@podgorny.cz>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 8 Sep 2026 10:00:23 -0400
X-Gm-Features: AcwNN1W7GZwfE2YnHeV3w1UncZu_mUSOdDvGCSKK7fOIS_oUcTprOZz8V7pe5T0
Message-ID: <CABBYNZ+nWb0m=qMvxADM2HvuLhopxG7L+io2JTmGXQM51YOYhA@mail.gmail.com>
Subject: Re: [PATCH 2/2] Bluetooth: put the peer's on-air address on air when
 we cannot resolve
To: Radek Podgorny <radek@podgorny.cz>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Radek,

On Mon, Sep 7, 2026 at 7:21=E2=80=AFPM Radek Podgorny <radek@podgorny.cz> w=
rote:
>
> An identity address only reaches a peer that is advertising an RPA if the
> controller resolves on our behalf. Where it cannot, the host has to put t=
he
> peer's on-air address on air itself.
>
> hci_connect_le() used to do exactly that, swapping the caller's identity
> address for the peer's cached RPA before creating the connection:
>
>         irk =3D hci_find_irk_by_addr(hdev, dst, dst_type);
>         if (irk && bacmp(&irk->rpa, BDADDR_ANY)) {
>                 dst =3D &irk->rpa;
>                 dst_type =3D ADDR_LE_DEV_RANDOM;
>         }
>
> __hci_conn_add() now resolves that RPA back to the identity address when =
it
> stores it, so the swap no longer survives into conn->dst and the identity
> address is what goes out. Storing the identity is right for host
> bookkeeping, but nothing translates it again on the way to the controller=
.
>
> A peer advertising an RPA cannot answer an identity address, so the attem=
pt
> burns a full create-connection timeout. That is not merely a slow connect=
:
> a controller without extended scanning cannot scan while it is initiating=
,
> so every dead attempt also takes the scanner off the air for the whole
> timeout.
>
> Measured on a CYW43438, which reports neither LL Privacy nor extended
> advertising (LE features 3f 00 00 08 00 00 00 00), against a peer
> advertising a resolvable private address the host holds the IRK for, with
> the connection requested on the peer's identity address:
>
>   before: LE Create Connection to the identity address, public type
>           1.61s -> 22.07s, then LE Create Connection Cancel
>           LE Connection Complete: Unknown Connection Identifier (0x02)
>   after:  LE Create Connection to the peer's RPA, random type
>           LE Connection Complete: Success

Ok, the problem is then that we are trying to an indentity address to
connect when LL Privacy is not supported, so we probably can just
revert to use the private address at hci_conn_add in LL Pirvacy is not
supported or we didn't program the address in the resolving list.

> Advertising reports reaching the host per second, same window, same five
> unrelated devices on the adapter:
>
>   before   1s:2   [nothing from 2s through 21s]   22s:5  23s:3
>   after    0s:11 1s:5 2s:2 3s:5 4s:3 5s:4 ... 21s:2 22s:1 23s:2
>
> One dead connect costs twenty seconds of scanning for every device on the
> adapter, not just the one being dialled. Enough of them in a row and the
> host's advertisement monitor sees nothing for long enough to power-cycle
> the adapter, dropping every link on it.
>
> Choose the address to dial rather than assuming conn->dst:
>
>   - if the controller is resolving and this peer's IRK is programmed, the
>     identity address is correct and the resolving list translates it.
>     Testing ll_privacy_capable() alone is not enough: it reports the
>     feature bit, not whether resolution is switched on and not whether th=
is
>     peer is in the list. Resolution is cleared with the other volatile
>     flags on power-off and switched off again while suspend pauses
>     scanning, and a peer's IRK is only programmed along the accept list
>     path, so a direct-connect target, a peer without
>     HCI_CONN_FLAG_ADDRESS_RESOLUTION, and one that did not fit in a full
>     list are all absent from it;
>   - a dst that is already a private address is what the peer is on air wi=
th
>     and needs no translation;
>   - otherwise use the last RPA resolved for this peer, while it is still
>     fresh. A stale RPA is worse than none: the peer has already rotated
>     away from it.
>
> The first branch was measured on an Intel controller that does report LL
> Privacy. With the peer's IRK programmed into the controller's resolving
> list the host puts the identity address on air and the controller
> translates it, reporting Resolved Public with the peer's RPA
> 6D:CA:DB:24:14:E9 in LE Enhanced Connection Complete. With the peer
> absent from the list the same setup dials that RPA itself.
>
> The address is chosen once in hci_le_create_conn_sync() and handed to
> whichever command builder runs, the same way own_addr_type already is, so
> the two paths cannot disagree.
>
> Store the chosen address in conn->dst when it is not already there. The
> connection complete event names the address that was dialled and
> hci_conn_hash_lookup_role() finds a connection by conn->dst, so leaving t=
he
> identity address behind would make the event miss this connection and add=
 a
> second one while this one waits out its timeout. le_conn_complete_evt()
> resolves the address back to the identity once the link is up, which is t=
he
> same round trip hci_connect_le() has always relied on.
>
> Fixes: 14b06c3a88f7 ("Bluetooth: HCI: Always use the identity address whe=
n initializing a connection")
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Radek Podgorny <radek@podgorny.cz>
> ---
>  net/bluetooth/hci_sync.c | 82 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 75 insertions(+), 7 deletions(-)
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 5376ade2cdc1..136d801baa85 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -6794,8 +6794,60 @@ static void set_ext_conn_params(struct hci_conn *c=
onn,
>         p->max_ce_len =3D cpu_to_le16(0x0000);
>  }
>
> +/* An RPA resolved more recently than this is taken to still be what the=
 peer
> + * is on air with. The spec-recommended rotation period is the best esti=
mate
> + * the host has; a stale RPA costs one failed connect, while falling bac=
k to an
> + * identity address the controller cannot translate costs a full
> + * create-connection timeout that cannot succeed.
> + */
> +#define HCI_RPA_FRESH_TIMEOUT secs_to_jiffies(HCI_DEFAULT_RPA_TIMEOUT)

Not really following why this is needed though, we always scan before
connecting, so perhaps we need to update the rpa whenever we resolve
at process_adv_report:

/* Check if we need to convert to identity address */
irk =3D hci_get_irk(hdev, bdaddr, bdaddr_type);
if (irk) {
bdaddr =3D &irk->bdaddr;
bdaddr_type =3D irk->addr_type;
}

So we do translate the advertisements to back to the identity address,
but we don't update the irk->rpa, which is probably what shall be used
in case the controller cannot resolve.

> +/* Pick the address to put on air for an outgoing LE connection.
> + *
> + * hci_conn_add() stores the peer identity address whenever an IRK resol=
ves,
> + * which is what host bookkeeping wants but not what reaches the peer: a=
n
> + * identity address only gets there if the controller resolves on our be=
half.
> + * Prefer an address the peer has actually been seen using.
> + *
> + * This function requires the caller holds hdev->lock.
> + */
> +static void hci_conn_select_peer_addr(struct hci_dev *hdev,
> +                                     struct hci_conn *conn,
> +                                     bdaddr_t *peer_addr, u8 *peer_addr_=
type)
> +{
> +       struct smp_irk *irk;
> +
> +       /* conn->dst is right both when the controller translates it for =
us and
> +        * when it is already a private address.
> +        */
> +       bacpy(peer_addr, &conn->dst);
> +       *peer_addr_type =3D conn->dst_type;
> +
> +       /* Supporting LL Privacy is not enough: resolution has to be swit=
ched on
> +        * and this peer's IRK actually programmed, which only happens al=
ong the
> +        * accept list path.
> +        */
> +       if (hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION) &&
> +           hci_bdaddr_list_lookup_with_irk(&hdev->le_resolv_list, &conn-=
>dst,
> +                                           conn->dst_type))
> +               return;
> +
> +       if (hci_bdaddr_is_rpa(&conn->dst, conn->dst_type))
> +               return;
> +
> +       irk =3D hci_find_irk_by_addr(hdev, &conn->dst, conn->dst_type);
> +       if (!irk || !bacmp(&irk->rpa, BDADDR_ANY) ||
> +           !time_before(jiffies, READ_ONCE(irk->rpa_jiffies) +
> +                                 HCI_RPA_FRESH_TIMEOUT))
> +               return;
> +
> +       bacpy(peer_addr, &irk->rpa);
> +       *peer_addr_type =3D ADDR_LE_DEV_RANDOM;
> +}
> +
>  static int hci_le_ext_create_conn_sync(struct hci_dev *hdev,
> -                                      struct hci_conn *conn, u8 own_addr=
_type)
> +                                      struct hci_conn *conn, u8 own_addr=
_type,
> +                                      bdaddr_t *peer_addr, u8 peer_addr_=
type)
>  {
>         struct hci_cp_le_ext_create_conn *cp;
>         struct hci_cp_le_ext_conn_param *p;
> @@ -6807,8 +6859,8 @@ static int hci_le_ext_create_conn_sync(struct hci_d=
ev *hdev,
>
>         memset(cp, 0, sizeof(*cp));
>
> -       bacpy(&cp->peer_addr, &conn->dst);
> -       cp->peer_addr_type =3D conn->dst_type;
> +       bacpy(&cp->peer_addr, peer_addr);
> +       cp->peer_addr_type =3D peer_addr_type;
>         cp->own_addr_type =3D own_addr_type;
>
>         plen =3D sizeof(*cp);
> @@ -6849,7 +6901,8 @@ static int hci_le_create_conn_sync(struct hci_dev *=
hdev, void *data)
>  {
>         struct hci_cp_le_create_conn cp;
>         struct hci_conn_params *params;
> -       u8 own_addr_type;
> +       u8 own_addr_type, peer_addr_type;
> +       bdaddr_t peer_addr;
>         int err;
>         struct hci_conn *conn =3D data;
>
> @@ -6927,9 +6980,24 @@ static int hci_le_create_conn_sync(struct hci_dev =
*hdev, void *data)
>          */
>         set_bit(HCI_CONN_CREATE, &conn->flags);
>
> +       hci_dev_lock(hdev);
> +       hci_conn_select_peer_addr(hdev, conn, &peer_addr, &peer_addr_type=
);
> +
> +       /* The connection complete event names the address that was diall=
ed and
> +        * hci_conn_hash_lookup_role() finds a connection by conn->dst, s=
o
> +        * leaving the identity address there would make the event miss t=
his
> +        * connection and build a second one. Follow the dialled address
> +        * instead; le_conn_complete_evt() resolves it back once the link=
 is
> +        * up.
> +        */
> +       bacpy(&conn->dst, &peer_addr);
> +       conn->dst_type =3D peer_addr_type;
> +       hci_dev_unlock(hdev);
> +
>         /* Send command LE Extended Create Connection if supported */
>         if (use_ext_conn(hdev)) {
> -               err =3D hci_le_ext_create_conn_sync(hdev, conn, own_addr_=
type);
> +               err =3D hci_le_ext_create_conn_sync(hdev, conn, own_addr_=
type,
> +                                                 &peer_addr, peer_addr_t=
ype);
>                 goto done;
>         }
>
> @@ -6938,8 +7006,8 @@ static int hci_le_create_conn_sync(struct hci_dev *=
hdev, void *data)
>         cp.scan_interval =3D cpu_to_le16(hdev->le_scan_int_connect);
>         cp.scan_window =3D cpu_to_le16(hdev->le_scan_window_connect);
>
> -       bacpy(&cp.peer_addr, &conn->dst);
> -       cp.peer_addr_type =3D conn->dst_type;
> +       bacpy(&cp.peer_addr, &peer_addr);
> +       cp.peer_addr_type =3D peer_addr_type;
>         cp.own_address_type =3D own_addr_type;
>         cp.conn_interval_min =3D cpu_to_le16(conn->le_conn_min_interval);
>         cp.conn_interval_max =3D cpu_to_le16(conn->le_conn_max_interval);
> --
> 2.55.0
>


--=20
Luiz Augusto von Dentz
