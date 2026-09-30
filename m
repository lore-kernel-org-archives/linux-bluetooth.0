Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F0B4E3259
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 13:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790774484; cv=pass; b=Z/GtwpiRkmyxVzmIxfb3wfCMUh1xodDZsIPr5MwFOqXxky9/UsRqNXf+EDc9BXOZCL7A56O/Ne//eo13cAKHlmDKC5u3T4G2eBZqoJ/rzmRT6kND98yhWsjZVhL7YfMDFX86Q7bOK5MwJN2fCVJahM8v2RwQOkIiGSTwLyjqSWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790774484; c=relaxed/simple;
	bh=GlIAb3zJuAEtHyZP+WhEnmhLL4aBGhQS/dvHdkcq8fs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hFuM0Oxb9pVR9Eei9G/YwI9bxHJr/xxoQtuloOiB+I49sbgxzcQbrN4KtQoQhDBF6snI3p9ogLAahTC+/7jEDhVHYuzk7hKGDDAAnZZyLi1vwrzpliCtQ2kCTYBp+BtKo293PJh+LfOl6xqKUPTl6E4AjslCMAj4jJVjC5IayuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pcaq+6aN; arc=pass smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pcaq+6aN"
Received: by mail-yx2-f40.google.com with SMTP id 956f58d0204a3-675686b026dso725330d50.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 06:21:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790774470; cv=none;
        d=google.com; s=arc-20260327;
        b=OczMmwatsDDrmM6rUyorXh3FC39x5qAo9cUDsf5nWaNyXZozQvZGL3OWfpdsUuVQzA
         M42ihYCsheaP79Ut19pOBc6U2662dgnQ5ZQ7+jx87+w/fqOq9RT72O2al8LhFTpjO5v2
         sNcT/QlrnCE6BOjkrRyyXWMypEGQGmhuvK9l0tWhILgGma59NV7+DP+o6hLmnDze8UUQ
         mIT/bM+5PpnaLvLISirZwAb4SFEFwrR/GAwuouRd0+Rxcp4ic9XBBvPP1xNkJYSaDxVr
         F2K30lRb37HzBjyuqCHRaZO40xuO2H9BNHh+ah6ioPVHwJBuHT47FfDRl6he6Pa8AwTU
         b/TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z66v1e7nmyRtCcxr9rUVmVhozcNgooz7I7OW8D2IvWs=;
        fh=dss+mvtVWWcCKjYBBjtoOwyfdbc8Dj1NBkicxxfSm3A=;
        b=QkWm1MdXNDAS4QdsRHF7AbeL5SoKHBt6eRdkY55ZLUAO/nOGxUse2TOVuiC1f14Tri
         41AxVPT6U82/oy4nnPWalJTzQMo5MfKKTzIC5qHQX2hfPwWmwnAW5XEN0pGJzOxkELoO
         BiWzWSUB7V1b2a1QWQ7xNPw+AJDxkusGd3TlmYQAAjwOPhdZFGlLjZlQZZma67R0FCH4
         wQL1i5bxpBrRAZt6St7YMKtfqZgurdg6cAXqf9vlCwp9ppjQrMVjNfaVy1If4LiRQgM+
         JZ1/t7zv7vu97nJHbUTaYzCOJdRjBXcFH3b98lgHjzTV5FDEEImlXXusynRSERBDYSHU
         Xsww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790774470; x=1791379270; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z66v1e7nmyRtCcxr9rUVmVhozcNgooz7I7OW8D2IvWs=;
        b=Pcaq+6aNdCJSqcArediU/Zg379TEkiI17CC8VN6hjy7ajS0FQsI0jSnT1JCYJc6MOw
         BIMZKzbEr6YKFhhTT+Pyx6JNNInoZZ/HiM3B8LdNNWsvuFIkBj4NBlq+61O5SnNR/iVC
         oqRBOZCA3YSS/l+asRHq9EdL+FM19d9fPk0FJuClSvLbOj0OdsFsic5fntsJNmPPSBWJ
         kp9INbtBZEu82cLVCPs8difHruDtjn7ihu5p1ShnhOfr/WEamG5th8iWQiXioY+0L45Y
         Nm+nSD7CzBURbfpoRmk2xPHMlVyXubHEBN+w9HyNjqCIb/IOHwnrettwFYYODgXYufbc
         A6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790774470; x=1791379270;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z66v1e7nmyRtCcxr9rUVmVhozcNgooz7I7OW8D2IvWs=;
        b=wq4+s/InA7IWIdshxVT95heBnW+RBtdZYQQE5/WvccxOMdELaxbrBTm6uxxz3tSdCh
         S22eRUtCOWaDDK/JYDARuIOoc9dxQtML+SaCbB6Y29/A1VhuaYEsnJeg5LqFQVUk3qHZ
         MKgcFmDtXyQlCU89pDUT8zpDovugpVN66geGcEVnjitT6ux0Mpv+9adkR38HtRhg2D0W
         NTOefOJT85YfTxy+LOePu6kmdaNy44ugZhztfxM1MdzJ88jCzxFsHuLMsNOHRa9jzgni
         7ZGSs03PH+ganPqSV4A4qGuqZLh7yWLiJ7h6eq3apImIhuNqRUDAx12oZpkCKtuUMDgG
         kUVA==
X-Gm-Message-State: AFq9FYIgXqxv21V1BoIpijAWEWpjV5o7KUGlMxHEJoeadVZeGp/Gj+wE
	jWK9sfPm6mnYYjETPJrPWdBMFdAEMlFgHNSh92PRlBaUsuPcpPvAt8M+RPjkRVm2CNw50PtK0SJ
	Bzrg/OMHKDTJBRQr5+lVk322Nld80aSw=
X-Gm-Gg: AYBFou3YW90LopBmq+bXeCvgQLn3jFTcdSsa15hMkVroRz/qZk7ZsLw+W3chkjZ3xn5
	NkAEmAlfATAt5YzN9mGbBRC9YzaWRt8YQmXx5pIeyrsa1sj/JQLgeh+zVNZRe4JKLkerBEjcecO
	uaQwPXt9CCitnWOebL10tVxqg5XKTjWVWBcCxj8FeHZqd3dOelk24xg5mlt1FW2GKwDA66MdMRl
	Fza5WFayI0W7Bi8vhw1HBQv0fYli70RNo2OayyQRjJv7vITGNMVtI+obJCZyc9KB9QzhG1TKP/8
	wl4at865/vTZxBqRHR82EVixzJ7L0ixTEQpojyA00j3qXvJVbsvWc3915j7R85zleAtF/NPFJuH
	Im+sx/TudD/N/P01n/krHtbiwQYfQJtqPNEDgpQyjFl1rVwNSag==
X-Received: by 2002:a05:690c:e205:20b0:8a7:ef2a:ff9c with SMTP id
 00721157ae682-8ac94db7632mr3236657b3.2.1790774469574; Wed, 30 Sep 2026
 06:21:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928223815.11936-1-kevin@simpleble.org>
In-Reply-To: <20260928223815.11936-1-kevin@simpleble.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 30 Sep 2026 09:20:57 -0400
X-Gm-Features: AclHuK-FPQ_UsXzh7sEA-jxSjxjDRmPDOr7LLYKeQMjECqaUOM11_15o7ZxQq3A
Message-ID: <CABBYNZKebai0bQZ4Z_0+P6LwWN=-jniRMN0vctYTD0TC=y36cw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/3] Add Connectable property to org.bluez.Device
To: Kevin Dewald <kevin@simpleble.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kevin,

On Mon, Sep 28, 2026 at 6:39=E2=80=AFPM Kevin Dewald <kevin@simpleble.org> =
wrote:
>
> bluetoothd records whether each advertising report was connectable,
> from the Device Found event's Not Connectable flag, and uses it
> internally, for example to pick the bearer to connect and to drop
> temporary non-connectable devices when discovery stops. Applications
> cannot read it over D-Bus, so they have to guess, e.g. from whether the
> device has a name, which is wrong for named beacons and for unnamed
> peripherals.
>
> This series exposes it as a read-only Connectable property on
> org.bluez.Device1, emitted when it first becomes known and whenever it
> changes, and prints it in bluetoothctl info.
>
> Tested with an nRF52840 switching between ADV_IND, ADV_SCAN_IND and
> ADV_NONCONN_IND advertising: the property follows each change,
> including PropertiesChanged in both directions on a device kept by
> continuous discovery.
>
> Kevin Dewald (3):
>   org.bluez.Device: Add Connectable property
>   device: Add Connectable property
>   client: Print Connectable in info
>
>  client/main.c            |  1 +
>  doc/org.bluez.Device.rst | 11 +++++++++++
>  src/device.c             | 36 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 48 insertions(+)
>
> --
> 2.54.0 (Apple Git-157)

This is already exposed via AdvertisingFlags:

https://github.com/bluez/bluez/blob/master/doc/org.bluez.Device.rst#arrayby=
te-advertisingflags-readonly

bluetoothctl does already gray the devices that are not considered
discoverable, see:

commit 815f779aa8e477e399b78f03c0ea0e75f0270c4a
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Mon Mar 6 16:48:43 2023 -0800

    client: Use AdvertisingFlags when available

    This prints devices not discoverable in grey so the user are able to
    distict when for example set members are actually visible.


--=20
Luiz Augusto von Dentz
