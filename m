Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794412037;
	b=Kgz8h8kPwRbYEBtAaAWLLbZmVzDaSz3+KdwmDFqFCgGw9ns0n2sm/chycjovAFrcdgSv
	 bY38/UIarEhyqR20JspU9Q4JAN2vfohQozwLODD6eTAVruf59jMf1/Qt2CWQbIpHUmOFH
	 5tzaWznSfSGvpMqRfYFXpJnNAu84krLwwj+M0yQkTkMTKJXt/LMUhtOhkUZKg0QZ0Nlgh
	 C5jKxj5xtJ1Kq/SSmxv4cAjXvxpLBIDduW3DkCSy/w7T8sHF2vZe6uuxWUrpjw4rLXSpi
	 0ys2YTs+muzXXHHKMVhEoK/lGMv5vTVJIsCNNdZmS3Rm6xQklCgR/n6/12HCL3LkO+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794412037;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=gTIEVjWRbcXMUtFL056Db+CbKeOeDXsJc+PUgW19Q1k=;
	b=31UYznHSWDD1JqBK3taQQgbJX0plvOfXKqRGEHzkIfEhXQkTK22XGWCTeTftm9XwUqqN
	 Qh9km9wHT1lhZzsxlrw1OMMpljree9TBqrgMx6mDkblSPG0RhVz+pyyWEN1z/2Yv0Lyo1
	 mVjz6gjVmMpgvz8xYS7Qn492/CszIY+qZd8M4vZfTGSOS/P5ZC9oMNWrC1FW0GtYW0SaU
	 8Z5C55OOXZ18migxHs85heyAjDlK2vyaysZ2pWoMvkhCZd3zaz+fkrNjhTTfFEIkv3LjI
	 o+Xzq/Kg5k5QIN5syiCN6SC49Ri8rUYsRmJfYrJjwT04KY7id9BnuqYtYtruBApCH7g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P4YF2PGi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBBA606A32A
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 15:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FBBA606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P4YF2PGi
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-67be9601f48so167123d50.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 07:47:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794412036; cv=none;
        d=google.com; s=arc-20260327;
        b=T7+tiHzI7ho2E1+q2wEtUR+2/fColqv7jksMSn2kIZmHKMfRY4i774pnDwSvzwOShK
         L4d93CiqkdVpmUS0dsSOz2sylGcBa3uy6PtvDj4AyOFGO77dU9y2I6gnh3ZG6aBpqutg
         kRW2FnEfrD/GnQ5UhOU8LJvEJmplpWVubBfUB9TSTz7mem4M2/UcScmT3Ir5igyukwbj
         a+ZYK35i3htnTMbRzk9i539oti/gNQdXz0g0wa4uvO714/GsB5sMbN48AaheTqVqOFSq
         dB5wZNYAK88Uz3RULO8w//p5OlbREmRE2oaRSqhNVUO+9lUDQfdW2ggYP4VVUKp+dSEk
         oXzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gTIEVjWRbcXMUtFL056Db+CbKeOeDXsJc+PUgW19Q1k=;
        fh=Ca5a8utZiKF3gy/yEam5pubj+3vWOPdRvkbhypp2p2I=;
        b=sRXd9alXTzQaNL5v1hjRFxwlSzkCt9543KfEPt/pQjQBj53uqy8envWn8snfnSZR78
         gB1E4mLMv3HF3dyHho+1ABSkyCW5w5HrcUAsjxr3KgNaAW6ePyFlew9Kl/hlqIYIScbe
         6r/DWGGJwgo8csPIWHoADrBGrA4mu8YCRd5PZzr6kY3lKIEU5ZnpaKLYld9np0tuuoFc
         jUErAzqxQ7fC03e284tauFu2N8nxg2VIALf0Ufitxo4Xf/WHLCgAPgo/IWfWBaz8L858
         3njpngU2zZHuzLaWyasRP2tafWB22eEtLFk3tWkHoaLWoLdP38fvK1fWdXkjGbgbGCNb
         vOCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794412036; x=1795016836; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gTIEVjWRbcXMUtFL056Db+CbKeOeDXsJc+PUgW19Q1k=;
        b=P4YF2PGityjgRW/8gZFtbuHFfl6Xal2yZlegsAX0VoGbfFhVFk1HGO6hWCto5xA6Yy
         Xp7xMKhRmyokYR2TegIRM+k4FTnVhGrItVDHsINGtgfdxmJc1QLA02lPx+WxIvukamsk
         vg8zmre6cw3G+qFEQiiLx2+v+dLWec4PdFPg92geGmNLrpgJuHaeMorhTtzTgPJ7WCOR
         suK0+421gV6nzjSkQrbphCXP1GwV04jwJBRCFZbdeaccoAW0PoFQRkwHLroFFQRaio65
         3d8Z2Ousrb9Ua0rg9BKJbyW5hYdle1A3nlchPhnFdboQlFfOIVAk7XM8Dthn7UCwxUKo
         QuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794412036; x=1795016836;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gTIEVjWRbcXMUtFL056Db+CbKeOeDXsJc+PUgW19Q1k=;
        b=EWz/7nsNPLnWumQsI9lFlHp0tzR7NK7S4jDz+GZ5tzDO6GfAfqEIiESKdSMQvZjvnl
         ZVofp82OBU0FwoAFXWu4BOSPL0L4NSOwLKxdnVAns0bJqQ3JTB7SJXl+qWn3ZPNySAHx
         Rgzwk+KVQicUzSw4PbZ/iQmWYOwOfGBe/Xjw43uITam9bEdXpdd2oiSyUHdBGs8XiCGM
         2TZYP1fLjht9WCNCS82DI3aQnovZyctZEjBd4jfuJLJ89HIjtv8MO0Q0F3xggMl74zzJ
         HQ5PyIqNAxG+REBHxbhKxYtfSmHxcDb3L/0aYhY0qjLB7rwNg45pE24qZzz9wB4SXDe4
         gd5Q==
X-Gm-Message-State: APuU4Z9biLXc9Ec/OJraC+MPvg56pn2md2E3TcaApgWmpsLj2yia7zCG
	crttgDtuJzUEFvDo480GXXGnq50wR+qgaGnashOC/daXRaHisLMObicYQhfVC5AbHA+BlxVlMKc
	Nu2JelxVRmVHZbvx/jFnwQi2gaMwtWNls5g==
X-Gm-Gg: AYBFou3k/JaVGLqGfNdfdAG4RupQdkQUshNFxiiUV0qn0V6yQkWXXlK9HGQoVeS8LJm
	8XaagBSJ254iZ8zQy46aGBbz4xz5KShE07ZaQgQaOU1fYqtCFJH0Ri4NyS9DJdjtLT+GlEUyms3
	wbgZCPaOvzbvNHNDILbk9Frit0W5IToMgW5zaZCmxe5tzshsa1VUXi28Dwq8ygW3zL215yKr+lZ
	e1jEpW8Vsgn16rcLN5faG5WAAGPXelBlTLrC3V7iDxrP9wkbzehSSsvDHaSIhxfFsym7eoH7fJg
	YE18d2FbjFMr1rmlueT0XcHypY5U+S4yiY0FO1DUYttphwDnV+sEZ2QmsuOG5w1cWdEPN112Hjn
	PQBnshRON9RlmDOr6BlNn/RFLWKS0785Jf86EKMrddg1Aic0sr1yTHSYT/kWm/uL/ontZph6LHU
	E86OPsmakupinTY3yY1wHzXFOlSRJfCTb6MZJSlVyx6UmXeJ2S3Ocve2LKYf8C8Pgg7EMmrkLJ1
	eztcQ==
X-Received: by 2002:a05:690e:168d:b0:677:d419:3a54 with SMTP id
 956f58d0204a3-67c67f1cfafmr2052813d50.28.1794412036280; Wed, 11 Nov 2026
 07:47:16 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111010940.728149-1-weihong.guan@gmail.com> <20261111010940.728149-4-weihong.guan@gmail.com>
In-Reply-To: <20261111010940.728149-4-weihong.guan@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 11 Nov 2026 10:47:04 -0500
X-Gm-Features: AclHuK9ygLoshhXflt-8S3TeJbm6q3TmPenqO291w9Lk7axKFHhxVqfNcF8b2QQ
Message-ID: <CABBYNZLOMQxS4dRQxQaS_bS71p6YWS4We79bQ--A3dapEYRK0A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] Bluetooth: hci_event: Find the instance owning a
 terminated advertising set
To: Weihong Guan <weihong.guan@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Weihong,

On Tue, Nov 10, 2026 at 8:09=E2=80=AFPM Weihong Guan <weihong.guan@gmail.co=
m> wrote:
>
> hci_le_ext_adv_term_evt() looks the instance up by the event's handle,
> but when the controller supports a single advertising set,
> hci_add_adv_instance() gives instance 1 handle 0x00, which is also the
> handle of Global Advertising. For instance 1 the event then finds no
> instance, and:
>
>  - a connection from it gets hdev->random_addr as its responder
>    address, rather than the instance's random address, which SMP then
>    checks against;
>  - the connection stores handle 0x00 in conn->adv_instance, which is
>    later restored as hdev->cur_adv_instance, so after the disconnection
>    instance 0 is re-enabled rather than instance 1;
>  - when the set terminates with an error, instance 0 is removed rather
>    than instance 1, so instance 1 stays with no
>    MGMT_EV_ADVERTISING_REMOVED.
>
> Find the instance owning the set: for handle 0x00 the instance enabled
> on it, as hci_le_ext_adv_set_enabled() tracks, and use its instance
> number and random address. Global Advertising, and any other handle,
> are handled as before.
>
> Fixes: e77f43d531af ("Bluetooth: hci_core: Fix not handling hdev->le_num_=
of_adv_sets=3D1")
> Assisted-by: Claude:claude-opus-5.5
> Signed-off-by: Weihong Guan <weihong.guan@gmail.com>
> ---
>  net/bluetooth/hci_event.c | 42 +++++++++++++++++++++++++++++----------
>  1 file changed, 31 insertions(+), 11 deletions(-)
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index f0ce124bb..33ff6cd80 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -6179,6 +6179,26 @@ static void hci_le_pa_sync_lost_evt(struct hci_dev=
 *hdev, void *data,
>         hci_dev_unlock(hdev);
>  }
>
> +/* The instance advertising on the set identified by handle. Handle 0x00=
 may
> + * be shared by Global Advertising and an instance, e.g. instance 1 when=
 the
> + * controller supports a single advertising set, in which case the insta=
nce
> + * enabled on it, if any, owns the set (see hci_le_ext_adv_set_enabled()=
).
> + */
> +static struct adv_info *hci_le_ext_adv_owner(struct hci_dev *hdev, u8 ha=
ndle)
> +{
> +       struct adv_info *adv;
> +
> +       if (handle)
> +               return hci_find_adv_instance(hdev, handle);
> +
> +       list_for_each_entry(adv, &hdev->adv_instances, list) {
> +               if (!adv->handle && adv->enabled)
> +                       return adv;
> +       }
> +
> +       return NULL;
> +}
> +
>  static void hci_le_ext_adv_term_evt(struct hci_dev *hdev, void *data,
>                                     struct sk_buff *skb)
>  {
> @@ -6202,15 +6222,18 @@ static void hci_le_ext_adv_term_evt(struct hci_de=
v *hdev, void *data,
>
>         hci_dev_lock(hdev);
>
> -       adv =3D hci_find_adv_instance(hdev, ev->handle);
> +       adv =3D hci_le_ext_adv_owner(hdev, ev->handle);
>
>         if (ev->status) {
> +               u8 instance;
> +
>                 if (!adv)
>                         goto unlock;
>
>                 /* Remove advertising as it has been terminated */
> -               hci_remove_adv_instance(hdev, ev->handle);
> -               mgmt_advertising_removed(NULL, hdev, ev->handle);
> +               instance =3D adv->instance;
> +               hci_remove_adv_instance(hdev, instance);
> +               mgmt_advertising_removed(NULL, hdev, instance);

While it seems sashiko didn't find any new problems I wonder if we can
eliminate the double lookup since hci_remove_adv_instance will attempt
to lookup again the instance, so instead of calling it perhaps we
could free the adv_info directly or via a helper shared with
hci_remove_adv_instance.

>
>                 list_for_each_entry_safe(adv, n, &hdev->adv_instances, li=
st) {
>                         if (adv->enabled)
> @@ -6227,22 +6250,19 @@ static void hci_le_ext_adv_term_evt(struct hci_de=
v *hdev, void *data,
>
>         conn =3D hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->conn=
_handle));
>         if (conn) {
> -               /* Store handle in the connection so the correct advertis=
ing
> -                * instance can be re-enabled when disconnected.
> +               /* Store the instance in the connection so the correct
> +                * advertising instance can be re-enabled when disconnect=
ed.
>                  */
> -               conn->adv_instance =3D ev->handle;
> +               conn->adv_instance =3D adv ? adv->instance : ev->handle;
>
>                 if (hdev->adv_addr_type !=3D ADDR_LE_DEV_RANDOM ||
>                     bacmp(&conn->resp_addr, BDADDR_ANY))
>                         goto unlock;
>
> -               if (!ev->handle) {
> -                       bacpy(&conn->resp_addr, &hdev->random_addr);
> -                       goto unlock;
> -               }
> -
>                 if (adv)
>                         bacpy(&conn->resp_addr, &adv->random_addr);
> +               else if (!ev->handle)
> +                       bacpy(&conn->resp_addr, &hdev->random_addr);
>         }
>
>  unlock:
> --
> 2.47.3
>


--=20
Luiz Augusto von Dentz
