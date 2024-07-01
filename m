Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3FC16D9CC
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jul 2024 16:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719850805; cv=none; b=s4NsJs4yQYZBh9C3OOr7YeKlYVaSZDMXNk9qEWFsbgfuKX8fMA7rBh8OKuHxwZ75Of1+UHR9Y7lU/oImBtFIBOHOQXNyZ6Rs3KbQLG7NNV6FYh4jayuQUPWW7lUAuRCUuI5bTawj+pkdJI34fpO9oLzOmw7HqUiu9ZF7yMkQ2jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719850805; c=relaxed/simple;
	bh=XZOLFpPvxdQ1RmoszPptqKB/oo+hPa+WYSBIGmXMwuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nWJb7+HmoY9HJLgTu6uHgRAnp17Duclxy6hTMuOtBdHCGthxkR3qY8alHd6Lwi6RMTZMqgY1q8lvKSZitSOX7Xh84TZrlNWiQ/3+Jfx2j2IFp9mY881EVNaJz59Eyuw6n8qqhj8ItV73lpbUwEr7pfTJfM0mR+vHUgO1pA84dRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJhLIhkf; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJhLIhkf"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ec595d0acbso39137451fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jul 2024 09:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719850802; x=1720455602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4pEMZ25bvtzjDWXm4vBpQ4CsvcuqGbCTGpa9TltDIM=;
        b=AJhLIhkfpZYqw+W64HB8b4cZCpA6R8sYG2rDTRTvdJFgW5gPcB5azwlnxDH/ejLKxp
         YQF8GsMPKycrdWVoDdd76jKHh9UV1aqailRLkcbB0xgM7Q2l0BGKfg/x6GlVPxrZg3TP
         Iyx4tFvf25Y34XQZClwZUijbp7NNRd9PdANlGlKzewvgVKH3X86BSC8DQBdtZUqwYZIR
         lUQhz/0zgv1romimYewRbrCQEHY5Z4SKB6CsF6fyTH5u0XPIQkKlXThA5nJ51J/4fSdQ
         DDZaMA8XZVGvEILY9axGeaPdO+Ep+aMJUYCw6i+IgkOn1r4DMAU/d21W/zcFbvCHNLji
         rvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719850802; x=1720455602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V4pEMZ25bvtzjDWXm4vBpQ4CsvcuqGbCTGpa9TltDIM=;
        b=rXNSo1VmAeku0iCZ+5+ZRji+SrNPn1s4Mj2C+z7p26dwbc0CRxL94mk2IyRBt2TL8L
         gWfyGm1RT8M7jf/0c7axc8FwfvJWZbPSCARiUdzjPY9Oe0q9EyPhTpFtdYW71Fi7HrVD
         fgA3BohKxjtu3kXSWzSdyccOm+AeKuQX357Os9G4etGqRyWZnRdw9LvjA0X0z06N583z
         /IZFxlJK5OP9v/G7MBCnNUEBF3xydvc/0yp+NipLNilqleTjtaoAzrMU75zZqS13WdbD
         dkqBmmDfLwptOmSrhDIz5rqxBhv6rUePvc4HM9l6I1mE7+hZMDiJwLLug3LZwr6vX03F
         MgPA==
X-Gm-Message-State: AOJu0Yz8QFSGf6a2U3WnG20yMXrV47LKwd8yVEtlGPtnE6B/zrGlcDVR
	4Vb63oCH+ZoYdi9Qbs7nORX9Us1ocP0aQNUyAd1dNp+BhZWubOUcVTdv2vL+m8lEJbsiPV2bcu5
	Pk1i5+yxCqqc5mqyCiTzjo2DrHMSxUov6
X-Google-Smtp-Source: AGHT+IEx84jFU9OGD4VDx3W3hZOADBN9lsf6zSgcEI7hGTI4TyTeYj6FmH9+ga8/FLXaR7D5a+Sw8OtVsa61PcDcnkU=
X-Received: by 2002:a05:651c:2203:b0:2ee:4623:93e with SMTP id
 38308e7fff4ca-2ee5e393f39mr59488621fa.20.1719850801536; Mon, 01 Jul 2024
 09:20:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701101243.2902-1-zhaochengyi@uniontech.com>
In-Reply-To: <20240701101243.2902-1-zhaochengyi@uniontech.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 1 Jul 2024 12:19:48 -0400
Message-ID: <CABBYNZK8ZvoHCQjo=rj7yt-0omZ8zgTFOueCvL5KoghhY_1nwA@mail.gmail.com>
Subject: Re: [PATCH] adapter: Add retry when bonding device returns connection failure
To: Chengyi Zhao <zhaochengyi@uniontech.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 1, 2024 at 6:13=E2=80=AFAM Chengyi Zhao <zhaochengyi@uniontech.=
com> wrote:
>
> When a user initiates pairing with a BLE Bluetooth mouse,
> MGMT_STATUS_CONNECT_FAILED(0x04) is returned with a low
> probability, resulting in pairing failure. To improve
> user experience, retry bonding is performed when
> MGMT_STATUS_CONNECT_FAILED is returned.
>
> Just retry once when MGMT_STATUS_CONNECT_FAILED occurs
> because this status may be continuously returned.
>
> Debug log:
> bluetoothd[1539]: src/adapter.c:pair_device_complete() Connect Failed
> (0x04)
> bluetoothd[1539]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr
> DD:EC:0F:57:A9:2E type 2 status 0x4
> bluetoothd[1539]: src/device.c:device_bonding_complete() bonding
> 0x5591f87230 status 0x04
> bluetoothd[1539]: src/device.c:btd_device_set_temporary() temporary 1
> bluetoothd[1539]: src/device.c:device_bonding_failed() status 4
>
> HCI package:
> Frame 2969: 7 bytes on wire (56 bits), 7 bytes captured (56 bits)
> Bluetooth
> Bluetooth HCI H4
> Bluetooth HCI Event - Disconnect Complete
> Event Code: Disconnect Complete (0x05)
> Parameter Total Length: 4
> Status: Success (0x00)
> Connection Handle: 0x0040
> Reason: Connection Failed to be Established (0x3e)
> ---
>  src/adapter.c |  4 ++++
>  src/device.c  | 24 ++++++++++++++++++++++++
>  src/device.h  |  2 ++
>  3 files changed, 30 insertions(+)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index bb49a1eca..574fa7665 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -8371,6 +8371,10 @@ static void bonding_attempt_complete(struct btd_ad=
apter *adapter,
>                 }
>         }
>
> +       /* Retry once when status is MGMT_STATUS_CONNECT_FAILED */
> +       if (device && device_bonding_check_connection(device, status))
> +               return;
> +
>         /* Ignore disconnects during retry. */
>         if (status =3D=3D MGMT_STATUS_DISCONNECTED &&
>                                         device && device_is_retrying(devi=
ce))
> diff --git a/src/device.c b/src/device.c
> index 097b1fbba..12fabbff1 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -290,6 +290,8 @@ struct btd_device {
>         time_t          name_resolve_failed_time;
>
>         int8_t          volume;
> +
> +       uint8_t bonding_status;
>  };
>
>  static const uint16_t uuid_list[] =3D {
> @@ -6559,6 +6561,28 @@ bool device_remove_svc_complete_callback(struct bt=
d_device *dev,
>         return false;
>  }
>
> +gboolean device_bonding_check_connection(struct btd_device *device,
> +                                                               uint8_t s=
tatus)
> +{
> +       if (status =3D=3D MGMT_STATUS_CONNECT_FAILED) {
> +
> +               if (device->bonding_status !=3D MGMT_STATUS_CONNECT_FAILE=
D) {
> +                       device->bonding_status =3D MGMT_STATUS_CONNECT_FA=
ILED;
> +
> +                       DBG("status is 0x%x, retry once.", status);
> +
> +                       if (device_bonding_attempt_retry(device) =3D=3D 0=
)
> +                               return TRUE;
> +               }
> +       } else {
> +               device->bonding_status =3D status;
> +
> +               DBG("device->bonding_status is 0x%x.", device->bonding_st=
atus);
> +       }
> +
> +       return FALSE;
> +}
> +
>  gboolean device_is_bonding(struct btd_device *device, const char *sender=
)
>  {
>         struct bonding_req *bonding =3D device->bonding;
> diff --git a/src/device.h b/src/device.h
> index 0794f92d0..7c269cc4d 100644
> --- a/src/device.h
> +++ b/src/device.h
> @@ -111,6 +111,8 @@ uint8_t btd_device_get_bdaddr_type(struct btd_device =
*dev);
>  bool device_is_retrying(struct btd_device *device);
>  void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_t=
ype,
>                                                         uint8_t status);
> +gboolean device_bonding_check_connection(struct btd_device *device,
> +                                                       uint8_t status);
>  gboolean device_is_bonding(struct btd_device *device, const char *sender=
);
>  void device_bonding_attempt_failed(struct btd_device *device, uint8_t st=
atus);
>  void device_bonding_failed(struct btd_device *device, uint8_t status);
> --
> 2.20.1

Here is what Ive actually had in mind:

diff --git a/src/adapter.c b/src/adapter.c
index bb49a1ecad23..f1cc4f2ed25a 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -8363,12 +8363,17 @@ static void bonding_attempt_complete(struct
btd_adapter *adapter,
        else
                device =3D btd_adapter_find_device(adapter, bdaddr, addr_ty=
pe);

-       if (status =3D=3D MGMT_STATUS_AUTH_FAILED && adapter->pincode_reque=
sted) {
-               /* On faliure, issue a bonding_retry if possible. */
+       switch (status) {
+       case MGMT_STATUS_AUTH_FAILED:
+               if (!adapter->pincode_requested)
+                       break;
+       /* fall through */
+       case MGMT_STATUS_CONNECT_FAILED:
                if (device !=3D NULL) {
                        if (device_bonding_attempt_retry(device) =3D=3D 0)
                                return;
                }
+               break;
        }

        /* Ignore disconnects during retry. */


--=20
Luiz Augusto von Dentz
