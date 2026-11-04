Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793803903;
	b=JuZzD2boaFRBCcWZfP3Igm4FGJk3NztpNqlwFYnpPal/IIlh++d6oCPmA/nMsLxkQyLY
	 498G8eQ7LQPjw2RU4lHJKrOdD3+HO64hEDomxUxQViwCiYMDBIuNpsdJxGZSpj62UmtQj
	 booS7Z7uPyqdqQaAK/6OJ2XJ1XLlh3O1bSgzEaprkAU9RtUM1SRZO5Umy6VAXL4osNHvD
	 XFh9u1uEgxS9981zDugcIlAap1d1SBz4+AmuDzQB4tih+lyyHsW2TemTLzTW9yWfzpaCS
	 coao5ye3WVNGDn9Dydm1TS5XldqZwBtIXU3EE1u2f5HcGs4TRhLnUVz22n06zvlP49g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793803903;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=KlMV/XWOLH5Lp9S17+M0Me/y6BklUFxP6uaDz/8Mgcc=;
	b=4NEHaYFoCudXI6SVL3OXnAbmws573IZwo1dOfUrbWpBcfSVkGOKnbSLhhQkuW6St5Gze
	 xznsHDJuySnGelWPixM9mhvwa4k26M0i+tcRb1Jy3oK9SlSr/r9d4sxI86jpvf19VMlkV
	 KvbqqfTfHx25AY+gdnaJ+9hQtKCZjS/ttwxXmkT7Khn+gpnIAG/4LXQbMQgCozS2ilGqC
	 ba7KT87BLNgEOabk+GIY8Xz9V1LIINsEuISqBgQGUCDmwt6prmBIph87Ubp8bd1jkBhW3
	 13hOm6Is4t1TmDLSovyCI2z5DHmiTf6zuT7zDrLvEtUekgG3xOUCSm4v8JTl8q/9unQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jDJX3pkk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2338D606A329
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 14:51:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2338D606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jDJX3pkk
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8b30477a320so6546007b3.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 06:51:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793803902; cv=none;
        d=google.com; s=arc-20260327;
        b=UI04S8wUIf5mHiZvHZblgrY6PvBSgwYC4r4RBiDxzKoQJ800wfsxFsIuw1kZIXGIo5
         MgvxOuWNnr8BQJXzpjJ240s8OSEj3eXeRUkO+tQ4OLGgxlNoP1PJqGTO8W4fDm13fJP8
         rbvtDxrHypl65pkQRXe6JgCeQ6zGc4/y6HaNa3k8jy7FHwpySXNu5+4ZTwdcxVGwnnx/
         7OJakPy6dBr1KRnlOhuTQxklLmLDeyKdBx1OlWFnjBGuA9SU5jJXmU8ghCCpkmM1F77X
         E73zIfaQ3H1AhTk4pg8JhJnKIlFz+6AORA2nAXYTG6kwWchu+rUeiugNgAQJmLCAYbn/
         KTXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KlMV/XWOLH5Lp9S17+M0Me/y6BklUFxP6uaDz/8Mgcc=;
        fh=aAYSL6ubG3WftpWDT4eQMxjjSuQ69z04FEwvjdsSM/o=;
        b=hb6PwbMgjkjSazQaVfvnV/qQiJheABzln3gOtqHb+whRe3PeENvYzMwQL9j1qCbIjb
         MBSO/7rA6yA/dVYzK2OC8Zz+FZCBR5F40pYvZjdhnMWyD7h0UAw8dc3kwNIDfw5qqfCy
         qgov65fsH/PO/UkfZOqlkkQbQt0jZrOaWQPukXUuU2K+jJRmd6/x7HTJz9WwLqQWv5uS
         /dD5Utr6jGCj8T8egp5cCshPEg5UTNYNFuFA3TNZO/g4ef7kE2wxzeRrpvHRTiAoDhrF
         NJGlpt6s7aBdAGXswpzNnjD1PuU8zMvqVpqTjyZe4wGz6zIhjmeaxunZFgUR9SKorZoL
         tkvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793803902; x=1794408702; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KlMV/XWOLH5Lp9S17+M0Me/y6BklUFxP6uaDz/8Mgcc=;
        b=jDJX3pkkUMvQQgJaHW2aiaXpcBCgr2hjKx/rtf7wGZI08ONCCRa7kl+sJSivBsT4r4
         Y82sdQAssKfWamiQpsHgOa9DKA3/BT43QT9VJxXiosdlJxng/TkebIAV2VnKV+6AQQCB
         6HBLrqwFt7LvmICsoTG0ufnDWdSjx8K3ypPfWtpYmb5Fa/Efznfa08Ud+qUqBpM+pn1j
         dl7KCXzcBV7CdWg5q5HKAeyyMOt4uAS8HJByGiIjWV2/X/Ew2jd3Ec/shSOwUAHMJztb
         6Z5rfqTFTFUqFMI4gNYe3WQDSla1LuqcF8B6v0k8WJnqx/5rU6xJkdU/IzbsP0ha9Ch4
         qxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793803902; x=1794408702;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KlMV/XWOLH5Lp9S17+M0Me/y6BklUFxP6uaDz/8Mgcc=;
        b=plQOWuvFSHSaIMFLFkkxTeobkdRzbb8sTSvbkgxP04el2zOynSfaPqSJuAfphaaAse
         0BET4EiDuBP+21+7OIgvMV4yEiOCNcMa+pR4Q19HO8y1NOPSfMCVsB9kISRaE93E3+Jw
         upYBHNj8IgSTIeYiArrd8bETngGD3ZKujyFffVXjeQLgTfSp0psPHCF4lama62Nt2xYG
         cdD0s3K5+72RlfuDN9uqA9m3oeQfhhWlKWsrb6glx7cfoeMduykTNAEh9xtZgJHMW0fi
         oZI6dyDlj1JArQ+UIBEc2s8F1sojN/9HeMft1AVKCTADagu/gim9lLtYAB0O+FWzLk1L
         wAgA==
X-Forwarded-Encrypted: i=1; AKwUvBzjdi9zGQauR7roe685PQ5UAWcJIhoFMwnsyZxmF+doM4f36vMJFiDX7iqgJ+g/wj3hOtZq5oSnE9rITVwXXyk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/gXnbt+BGDf1xPdd1Ixc1E9iuM8KT0owQ6UmFriE2ePHsUQqKb
	doksc63UHi37kWJx7XC/tJgWHD4yoRb2x0PLMRa+Bx1cJ3m5K4A7W4snWRyLMp0wNIMbSUv8HMH
	zTfPiaLtqtLYUI63nwhD2Z+lIEehbhEE=
X-Gm-Gg: AYBFou2t4v+Ou0P/ly1Xqa/VOBIDPk4YLcRVgaFnpvjbepdaDerFRkvBpfmRTAJAoY0
	MwfgcY0LxZoKhznsfZ0WwW0JB4ejvyjnziG0rm8a7Bt9cgmddy3R2seDyUGsueYbr9e8zoSOvM9
	Bb20vN5jRtbPLzLWns0u35bPG9qh+jkyuTxPhK4C1fUmRE9T1dDWTp83yqWBkOiietq0IQe87Iz
	6SVpgHsyVzKaVEICCQfDsbk3aEeTF1Vdy6uA+OHbOKuy97FEInG70vQ1EyTVWriikhggk265NOC
	JohU9potbKjbvtlqvi2yuXj9fWvzUatj0FP3VPOjuqjM54fVx5M+FoCCfgQcFuyGArgez5itkFH
	jV30zsUBmGhBnW/oa9YG/exDM5icRzTIJrWmTOX7lNcOnBTdxuTSmmUcQ7ZnhZw+YrjPIEicxSy
	igZdcVdcihJTOCtXKpw9bcaU1oBmRxeK+MB2cZ7+mOi5sHCVKgunOuV8D/
X-Received: by 2002:a05:690c:7107:b0:8b2:e86a:8f11 with SMTP id
 00721157ae682-8b2e86a98c7mr53940707b3.47.1793803898497; Wed, 04 Nov 2026
 06:51:38 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104120138.1165715-1-radek@podgorny.cz>
In-Reply-To: <20261104120138.1165715-1-radek@podgorny.cz>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 4 Nov 2026 09:51:27 -0500
X-Gm-Features: AclHuK-Nn9lQIytK-gDLUH1LcIsaOJHK0BBKUS0y8zeOsq_7IqOseA2aP3DPxQg
Message-ID: <CABBYNZKTROzNKZGRcU+hFu4XfgUZzPtkJ79vOrReUTtkDHrDAQ@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: find an RPA peer's connection parameters by
 its identity
To: Radek Podgorny <radek@podgorny.cz>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Radek,

On Wed, Nov 4, 2026 at 7:07=E2=80=AFAM Radek Podgorny <radek@podgorny.cz> w=
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
> Resolve the RPA in hci_conn_params_lookup() when the exact match fails,
> so every caller finds the same entry whichever of the peer's addresses
> it holds. The exact match is tried first, so an entry stored under an
> RPA is still found as before.
>
> hci_conn_params_add() and hci_conn_params_del() look up through the
> same function, so given a resolvable RPA they now act on the peer's
> identity entry instead of creating or missing a separate one.
>
> Fixes: 4914c4998961 ("Bluetooth: put the peer's on-air address on air whe=
n we cannot resolve")
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Radek Podgorny <radek@podgorny.cz>
> ---
> Changes in v2:
> - Resolve the RPA inside hci_conn_params_lookup() rather than at the
>   hci_le_create_conn_sync() call site, as Luiz suggested, so no other
>   caller can miss the entry
> - Exact match still first, so entries stored under an RPA are unchanged.
>   I weighed inlining this as one pass matching either address, but that
>   lets list order rather than exactness decide between an RPA entry and
>   an identity entry, and resolves the IRK on every RPA lookup; a small
>   helper scanned twice seemed cleaner
> - Rebased on bluetooth-next
> - Link to v1: https://patch.msgid.link/20261101-for-upstream-le-conn-para=
ms-rpa-v1-1-988629a09bc9@podgorny.cz
>
> Tested on the author's van (BCM4345C0 against a bonded peer that
> rotates RPAs): with v2 the peer's stored connection parameters are used
> again. bluetooth-next itself was only build-tested.
>
> Per Documentation/process/generated-content.rst: the patch and this
> message were done with the Claude coding assistant (model as in the
> Assisted-by trailer). The prompts asked it to fix the lookup miss named
> in the on-air address review and, for v2, to move the fix into
> hci_conn_params_lookup() per review. The author directed the work,
> reviewed the result and tested it on the van.
> ---
>  net/bluetooth/hci_core.c | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index bfc5bdebc71a2..2dc12c01c4dc1 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2285,9 +2285,8 @@ int hci_bdaddr_list_del_with_irk(struct list_head *=
list, bdaddr_t *bdaddr,
>         return 0;
>  }
>
> -/* This function requires the caller holds hdev->lock */
> -struct hci_conn_params *hci_conn_params_lookup(struct hci_dev *hdev,
> -                                              bdaddr_t *addr, u8 addr_ty=
pe)
> +static struct hci_conn_params *conn_params_find(struct hci_dev *hdev,
> +                                               bdaddr_t *addr, u8 addr_t=
ype)
>  {
>         struct hci_conn_params *params;
>
> @@ -2301,6 +2300,27 @@ struct hci_conn_params *hci_conn_params_lookup(str=
uct hci_dev *hdev,
>         return NULL;
>  }
>
> +/* This function requires the caller holds hdev->lock */
> +struct hci_conn_params *hci_conn_params_lookup(struct hci_dev *hdev,
> +                                              bdaddr_t *addr, u8 addr_ty=
pe)
> +{
> +       struct hci_conn_params *params;
> +       struct smp_irk *irk;
> +
> +       params =3D conn_params_find(hdev, addr, addr_type);
> +       if (params)
> +               return params;
> +
> +       /* A bonded peer's parameters are stored under its identity addre=
ss,
> +        * so an RPA that resolves to it finds the same entry.
> +        */
> +       irk =3D hci_get_irk(hdev, addr, addr_type);
> +       if (!irk)
> +               return NULL;
> +
> +       return conn_params_find(hdev, &irk->bdaddr, irk->addr_type);
> +}
> +
>  /* This function requires the caller holds hdev->lock or rcu_read_lock *=
/
>  struct hci_conn_params *hci_pend_le_action_lookup(struct list_head *list=
,
>                                                   bdaddr_t *addr, u8 addr=
_type)
>
> base-commit: 3f425f95ba3923d605f6a8b382e8fcdc59d479db
> --
> 2.56.0

Sashiko flagged quite a few issues, please have a look and lets
resolve them before merging:
https://sashiko.dev/#/patchset/20261104120138.1165715-1-radek%40podgorny.cz

--=20
Luiz Augusto von Dentz
