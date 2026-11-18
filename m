Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795014291;
	b=Ib4BD61AO9BsxaI0beAOhVdIDMKmBPnwDmxZB5Wk91gR06vfzssZngA3ufMO6wELTnQi
	 P1xjIn95N/g0lffCwjJKarU9VEoI9qT8dB2VaoboyMpZDbTLU9Wqva3/Hc/JIe5YrFhbY
	 g0jGAad8JwS4RShXHBfB8lgVfg9GspGlw81Id4cLmLr3W5SJAiv30wyNw6mRJxGFami6F
	 yqRJ91pZX6K1Tctz69E6R/rqCpgYm3xPY96li1nkOlknOzIyeT2eanE6gM8L/iXmhdmVX
	 /zgAkkFC+roQirQPcH9hs41S915jN0XGRXnGbytptBLRS+cFGeOo4fePDlFiGC6mazw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795014291;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=aVkgZI5WzXBjI0U2/Ez70OukDr3k+IEZoOwPZzKltZE=;
	b=k5x8ubE899UOut1ql9Mxhys2I2v1qx6tL6u3UtwGc301tLbwDMB6VEBZonuOQ7TFil+0
	 c8dQ0cs3Vbz5GQ9vJW6ERGDr5yZKYlyLuQMAnrPZH7SFYEofxy3tlntIcMI62N2hJ4POV
	 H2sUyp0RnDD/awYSlmEDlTUM+zGFXRnbOEUbwL1eH+elFGfRc9CIVbyGpYbaNVS/3lgMh
	 yEJGIz8RfVCVWzYIHFwdQ5wi9At9ix2zp33CODMdMtEWqhnwMXXLrVPivVCQ9AeTLStaZ
	 pZZ6IW0bCW1FDW9Zu17MYFls0oD5Ao9zB+zBuGHXH3P0UXT3Op8L+DiwqInMZXF7znA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pZ+Zyh9v;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.45
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BE5606A339
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 15:04:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8BE5606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pZ+Zyh9v
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-67be9601f31so950962d50.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 07:04:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795014290; cv=none;
        d=google.com; s=arc-20260327;
        b=MOlb5LrrNTLV1WumsI86uLTzvoUQTXFVDzU7AImbxgqwz+8sOsTWljLIdajVTL2Mjk
         vmw8aeLtNrlYvMjccZ/aCskc2zvueo7SA1tfaMp4gTsnbhmtivuFA3nOgqqzYxM3YbDy
         5EIuZHuSx8e9miHQ9fzWqtv+ysgqC0/QjdCIWcjXTtMAaY3RJ+v4p+QEHbj5xQK4y4yA
         9uVK8cho0rlF1DRxuBwoCMglT1bdmWi4IRyw5TDgwk9AZ3SbeHx+r08SRlB+61DuRDjT
         AJ60uvUwugWU67qJf68l7O6jlMXrtbamdLY54J+XtkQKh2RYm1xEMBCAfQeepruHTloG
         8OqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aVkgZI5WzXBjI0U2/Ez70OukDr3k+IEZoOwPZzKltZE=;
        fh=rCBNvKLXfITj05b+lml9g3UPSEjZhZdMrKcAykGPjDo=;
        b=VCjMnFsSCBPt2nC7rw8ynyTRp4Hy9vZ9wdqGbtxmAlpAUP5H8REHU0CJdkIR3HGI6P
         XSqRBfYHiMzXd5A/gLj9kCYAZhTcTmcM4+woNJSo/FFxF8A2060YeWXCPKPx6TZlyPGD
         M+NO2wnr0L6lDIXoiTh80iHYzZekdj9rmhLu93VvgcXX/X/jnOWUpmqVq6AN1/XzZ5w7
         K0b0CfqdTQIGih7dAM0ZZ8xHZ+c27Lgxwp8xL2399TupR0tnSUUOR9TguByo2Mb/cY15
         /1tkuxOqGDr2mGlVYdOX9/8zc6upWpYQuRq81p4jU7f4uQmAR8Kwt3FKPwhaFW+uUrzs
         MoEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795014290; x=1795619090; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aVkgZI5WzXBjI0U2/Ez70OukDr3k+IEZoOwPZzKltZE=;
        b=pZ+Zyh9vuL4v0OstGRwNpz/3FR4eWlGndF30aLm4+wsFMJvg+WY/N8Dp4U+flhDoo3
         pxsLSANXntDdfvBY+JcZXIKzpW/55jOL/5Mu5ZDxOdU6EVASJQ4mD+RoE+/5fskY7T+M
         jCji7pU3hfNUodfKll6jgxeC2d7VZP5VUGPAvH20HNYDNapTL7qOaLQtxmk0AI7SrxFs
         bhmF5Ol4ItCl9hDdIWd2OPXhvitHhwVerNx4iaAZnOecAOs2rajOZ0XMhk8nqvhdMFDR
         x/tB6Lo7LR7dAaEIi2rVBXhCYz94j+/FCwKOGJCHiCQa7maID3DivPu1eq7NGnAGX9gc
         HYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795014290; x=1795619090;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aVkgZI5WzXBjI0U2/Ez70OukDr3k+IEZoOwPZzKltZE=;
        b=cAUrAfil1PqUBjISO8P7y8JQJ/bcfXbMrkbqxo2qUhLEiyccLc3Vf+WKtnt2fKWKq/
         IFLX+92pM/JNlk9qWR4ZtTcFyjl0H8/mQfWVHf02uDTf417dPUMesBDOkoPcm4FtBe/R
         205nL/XMPGTrQaEh/Mhk4+P66NnJSsZv/5cw2Owk12Ve9AC0sbMcv/fOEHOa9J/uTPEE
         NaC5fFeziQSPTEKf1x6LedGOgxd6jqfVo502aQu9ysybiRtvbDQPwHkuSap12Eczui7Y
         Ou7M0gAqBNhI01GtXTkoJTbOwD5Odv9cd7XhM8OCGa8+sqNNjhxQTeTyxrK+EmGE0bUb
         HKRg==
X-Gm-Message-State: APuU4Z+iPKlyEC3wMnQikUHupBPg85W8uTfb6CRbGEDVC6gDx8zJ9fAW
	+dcuarV/gOkrDX0XVPToL8mctN3CnuaLliDqQH9Mb7VGAgH9wCuODhAfy4WalRwYaDA0OfSHO12
	UkaEFC7kbghjUQprfepr7FnWMlqdo6ec=
X-Gm-Gg: AZFdTZeIXy0+nORKwXqizPKEc66Eoyz3ZTAd8TmpZ/1f/OgJomWqgek0na00dNF+t7c
	hN/BLOQwzV52ZVIr7z8tQUalQm1HqU3kZ1C404SCgecFNEIfs/W2a/2cWtQGtcRWjEwtjhfg5bX
	UBn7Ny2yroiLsYek8vpv1Pt9gORjYSE72bQ5bkx0WFZhfSOHYf5KLxrmHxfL/cXBabhHORYHTmV
	oE0rHqIwY/nv3BnojLZPTyMPQCWDGPceNmh1gK1jykku0h6ODFQ2tMIXVlwJmUwsk6/rnsIxF9h
	2y7X9x+M0GuaMqd9P3hv6ozD9Z/OBb4ztJeXREuwdWZwk5/BkkEpI+QBsci4aVTRums9jlJsZ0j
	VTA9veGBAmsTeHUNBho1K7FXFmbHV9jN664Ptmf49pRET36tZgblVUlrdeRvONFquosEX1IaL1h
	8sRzU2hp9c1r7lkIJtHSGQdSfiXo7Nn4FgUKOJNIx6N6anVJyUaO0SuyCVbYc=
X-Received: by 2002:a05:690e:4002:b0:67d:a6fc:6bb0 with SMTP id
 956f58d0204a3-67dd401f905mr1132743d50.89.1795014289981; Wed, 18 Nov 2026
 07:04:49 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118141438.308232-1-khidarlaminehamdi@gmail.com> <20261118141438.308232-2-khidarlaminehamdi@gmail.com>
In-Reply-To: <20261118141438.308232-2-khidarlaminehamdi@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 18 Nov 2026 10:04:38 -0500
X-Gm-Features: AclHuK9oD8iIMCr--oNs7MUjBcqE5215_v-lErq2F3YgMK2gIudPLmjFYn0vJac
Message-ID: <CABBYNZ+Xo9MjLWQX6SZv2wprzpyKfPnGZYjkV_S1yHsYM+o6aQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] profile: Add paired_only flag
To: AuthenticSm1les <khidarlaminehamdi@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 18, 2026 at 9:18=E2=80=AFAM AuthenticSm1les
<khidarlaminehamdi@gmail.com> wrote:
>
> Some profiles talk to remote services that need an encrypted link.
> When an unpaired device connects to us, for example a phone checking a
> GATT advertisement, those profiles still get probed, their reads fail
> with Insufficient Authentication and bt_att bumps the security level.
> The phone then pops up a pairing request the user never asked for.
>
> Add a paired_only flag to btd_profile. service_accept() skips such
> profiles unless the device is paired, on either bearer, or bonding.
> device_bonding_complete() accepts them once pairing is done, so there
> is no need to reconnect.
> ---
>  src/device.c  | 29 +++++++++++++++++++++++++++++
>  src/profile.h |  7 +++++++
>  src/service.c | 13 +++++++++++++
>  3 files changed, 49 insertions(+)
>
> diff --git a/src/device.c b/src/device.c
> index 36a980d1e..9b410a913 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -4922,6 +4922,28 @@ static void device_accept_gatt_profiles(struct btd=
_device *device)
>         g_slist_free(services);
>  }
>
> +static void device_accept_paired_only_profiles(struct btd_device *device=
)
> +{
> +       GSList *l;
> +       bool initiator =3D btd_device_is_initiator(device);
> +       GSList *services;
> +
> +       if (!device->client)
> +               return;
> +
> +       services =3D g_slist_copy(device->services);
> +       services =3D btd_profile_sort_list(services, get_service_profile,=
 NULL);
> +
> +       for (l =3D services; l !=3D NULL; l =3D g_slist_next(l)) {
> +               struct btd_service *service =3D l->data;
> +
> +               if (btd_service_get_profile(service)->paired_only)
> +                       service_accept(service, initiator);
> +       }
> +
> +       g_slist_free(services);
> +}
> +
>  static void device_remove_gatt_service(struct btd_device *device,
>                                                 struct gatt_db_attribute =
*attr)
>  {
> @@ -7582,6 +7604,13 @@ void device_bonding_complete(struct btd_device *de=
vice, uint8_t bdaddr_type,
>
>         device_set_paired(device, bdaddr_type);
>
> +       /* Profiles that require pairing were turned away while unpaired.
> +        * They are GATT based, so start them once the LE services are kn=
own,
> +        * whichever bearer the pairing was done on.
> +        */
> +       if (device->le_state.svc_resolved)
> +               device_accept_paired_only_profiles(device);
> +
>         /* If services are already resolved just reply to the pairing
>          * request
>          */
> diff --git a/src/profile.h b/src/profile.h
> index 270f09ea2..add55fdef 100644
> --- a/src/profile.h
> +++ b/src/profile.h
> @@ -61,6 +61,13 @@ struct btd_profile {
>          */
>         bool testing;
>
> +       /* Indicates the profile shall only be accepted on devices that a=
re
> +        * paired or being paired. Use it for profiles whose remote servi=
ce
> +        * requires an encrypted link, so that a peer that connects to us
> +        * unpaired is not prompted to pair by our attempts to read it.
> +        */
> +       bool paired_only;
> +
>         /* Indicates the profile should be ordered after profiles providi=
ng
>          * these remote uuids when connecting. The callback function is c=
alled
>          * when all uuids have finished connecting (successfully or not).
> diff --git a/src/service.c b/src/service.c
> index 8301b1ead..6b35a407c 100644
> --- a/src/service.c
> +++ b/src/service.c
> @@ -301,6 +301,19 @@ int service_accept(struct btd_service *service, bool=
 initiator)
>                 return -ECONNABORTED;
>         }
>
> +       /* Pairing on either bearer counts: the user chose to pair the de=
vice,
> +        * so a missing LE key may be completed when the profile needs it=
.
> +        */
> +       if (service->profile->paired_only &&
> +                       !device_is_paired(service->device, BDADDR_BREDR) =
&&
> +                       !device_is_paired(service->device,
> +                               btd_device_get_bdaddr_type(service->devic=
e)) &&
> +                       !device_is_bonding(service->device, NULL)) {
> +               DBG("%s requires pairing: not accepting yet",
> +                                               service->profile->name);
> +               return -ECONNREFUSED;
> +       }
> +
>         service->initiator =3D initiator;
>         add_depends(service);
>
> --
> 2.56.1

Nack, on demand pairing needs to be supported beside this probably
breaks server role as well since it won't be probed until the device
pairs but that is not what you are really doing here instead it just
doesn't call the accept callback, that perhaps can be done by checking
if btd_opts.gatt_client is false then the connection cannot be
accepted, but that is already the case so I suspect the problem is
that you are initiating the connection (aka central) thus why
disabling the GATT client doesn't work:

if (!btd_device_is_initiator(device) && !btd_opts.gatt_client) {
DBG("GATT client disabled: skipping GATT client");
return;
}

For this to work as intended you will need to be the peripheral, or we
need to remove the check for btd_device_is_initiator but it may have
other implications since that would stop the central from resolving
services, etc. We can try changing [GATT] Client to accept role as
well, so you can say Client =3D central (disables peripheral requests)
Client =3D peripheral (disables central requests) and Client =3D false
(disable all requests).

Anyway, this all seems way too complicated compared to just disabling
all plugins that you don't need to use.

--=20
Luiz Augusto von Dentz
