Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950F73537F2
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Mar 2026 17:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772558659; cv=pass; b=BZEniuq/9P9FhSnD/44CcJxf4J8SQ/Tz04odZCmUALS1wqlFtPsLNoblFSsbM9JpSfn6lVh64FAEscgD5Ue7cOc5rDpA3Tw7gCBeAUhG5sbE0UXSb6i1W2rknMLmY9luyt5rzzJUmlTTrnIoXUEDtkwI2oz1+EBhd87zw7MR+BA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772558659; c=relaxed/simple;
	bh=B6YOCeSFQ2rsqxfOf/O8CY+/Zkr6v24cuVLrZnmFzc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S6L3G8UqYlXcQTnytpcCw5rQOB0QqdO1ppWggsDKZxYSOWqc0IB0EC9e/PN169YFuzauMXwMrSpzhLNVa+xzQr+a5giZj4Ttpwi0/mtmLQf+wvnKz2RPdcZemo45uG6JX/IAHdu/lMGaoTYy6Sn0dUQ29phlDEEjmVtgNXRvSZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UlvxQDOK; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlvxQDOK"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64ad8435f46so5571371d50.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Mar 2026 09:24:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772558657; cv=none;
        d=google.com; s=arc-20240605;
        b=FjPO+lO7HHSi4ZmLnL9EQuwmu0R1/byhHahs7Xap4RlSv9/dRNoTOOu6aj5Ngr5dm1
         s+4JO+WtILC2PEPkijKWFxeqTiH1Xv5D6jqEn4QuvbNdIaOxfpPpE4hgglsqy3UFJAdt
         AYuWQk9VIdFalIDLjFeSRyUcPJ6fXVOQ+xm4AkYRh8Iuz1rQVP/wHohIHDAl/zhCGvvv
         GkD1P8MgYA+X63zC0WQXG4li8tkWf6hRWE2zYYB2xDeeNlW9ug4h4ap0CJAjPRTHcZws
         6Lhv8lMxjmcH5WrhyOuQRd+gLw27LQmLJ4a2BXYK2A6mVU3050vDejl7fWO+j69auisJ
         1XuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FGQnnUHZ8cQVJT3SQ9nsyIiI0AfZazDKS5NWCFuKREY=;
        fh=V2TUQDdjQ2OP1oZeJblN8AyhSa2GvhvjkcdpHi1Q35I=;
        b=OVbxRA9bZDd2PefrcPu4wfWEoqguomQmPGPLBYhW2sAxG2Tc5IrKUPzkXF+//uCbMY
         Ru/cL/aowp1OGDmPYRwd5iRuJ1LyoRRTlupDhTcH4/wO9AFs948LdELPk871Rv2oDgWC
         UXQut5Udn5aFxpjg3d+Y0uUSaYvJABYmkVTOtvGCp42Kww9uVrSrpivAvgP9MQtcm0RQ
         VJeFYQFxP3RQe+kfbexZc3+RdaiOIHGODAczdYruvW44gK+VwE89cuZ+c4Gr9Yi2tiVe
         6H4qPyBvCGOg7t4jmveInuy6SyVTcLMPyIuuCOWkxJNECct5PuyZJtoO9+J7oKrZ03zA
         T3Vw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772558657; x=1773163457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGQnnUHZ8cQVJT3SQ9nsyIiI0AfZazDKS5NWCFuKREY=;
        b=UlvxQDOKoxxlTaK7pBbpXMZc9gFtUgXWeadKqTeflyCEMJzfUDKc0K6/BUYp/ZmDfi
         5BRN9lXbyHQw7YwPvvU4JjKZiaCf/duC1w5gNq208gTBbtUh3jbHKFPUAqMRxOUyDGAs
         5Uavfdl1+2OPorTmRpw//DT936kxv/VCSe07R0CJjhp4NlXBW0q24pe4bwg/UrN03NYR
         JiQS6j5OjwIgg9f7BfgArJWegDE0S7pvm0vQ9nBW974Ptx829GnXXtK7QwNp/ImxKsKi
         1l+htXGoDt1/dA0f3Uq89cBQIusK3NZsncngwlWLTx7M/674HK+lIeMv72iwMysj96RF
         tmDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772558657; x=1773163457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FGQnnUHZ8cQVJT3SQ9nsyIiI0AfZazDKS5NWCFuKREY=;
        b=ieYSZOqiKeuk8zbQ79jExB+Uj2tiNH1YWX4NW3Iafv1KXG04mZ5gkgYIYLlnbjLWzl
         8sHQ6/NyMZm/L+VYi91bk74EH2kbfCXLC22oBvHdJSOee3Syt4x8/GTkCdrmIUG53dFo
         i8OW1TiOE39h1N5HUbkDPjTtAnCxGTPh0qPXdzBnflaYbYsdLrWG6fTcSlme5ok8OmCG
         P1XSRRrkadhW1/He8Mpc7EpSU7TIHGff+BOt2qt/DJM3Lvble9vvONFhWnIJV8QE8zcq
         BSG8yuyVOiMQ5EnsZCqzdgf9P7wM/UkajhNhIHxLihuSTQenNhOFmH3/rqk6KTHOlhBE
         JTxw==
X-Gm-Message-State: AOJu0YzL+RZsN9qkB0pn4YTv3YfwIt9am84WQiuahY48yvUUY2R8gx9R
	8h0WGM7FYQOKMvpQDGU9eH0gFfiGGGnlEg2NAprjy9TXp9U0/lE6FAEYrV4MXCVymBOz7esNJKR
	VThWvgj08ansLSxrW4TMYeXFgsZgVoJA=
X-Gm-Gg: ATEYQzywdK8kkhc31fCQzlvv3ph8rTRMlmvPSsM+9j0Vi9gS/JK32a+P5MCtiblcnWJ
	pbZjc1EI4+5gO+uUuiVnOgBWEocufS6ynt6sIVof4CfUsYWVhCuaoXpIwNHBvgdIXr6oA6HODU8
	vaw0ik1iHP9HxOt7JwWlPH+/RnJwVicD4UY9fq8aDe47MpI0Mj0yXXV0JTbm7o2KKqyL9w3Bw/q
	9F1QBNEYBxSyoSB2ws1nzJVcDXHQcheD9IAjDGirmw7lqv56HHJekGDLlMHOkrJG5s+l4PyH+mw
	jx/+dUlp3erjEJoCSOhJwIarnRMmpi1aWcRtkMM/HVi16yLx8uF4TBasql6UN3YWKp2szg==
X-Received: by 2002:a05:690e:1708:b0:649:da44:78ad with SMTP id
 956f58d0204a3-64cc22892d1mr10699369d50.49.1772558657483; Tue, 03 Mar 2026
 09:24:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302233756.910702-1-dajid.morel@volvo.com>
In-Reply-To: <20260302233756.910702-1-dajid.morel@volvo.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 3 Mar 2026 12:24:06 -0500
X-Gm-Features: AaiRm537Qtf6Oo9vaHG4jybIB_yNsS9h3-F7KulcDv4XwI_MD8wc-gLIuxOT-Oc
Message-ID: <CABBYNZJtZZ7mHJinJY9ZfhfHbYUC9aEmoRx9ACz5R4HSwepyFg@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: Increase LE connection timeout for
 industrial sensors
To: Dajid MOREL <dajidp.morel@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Dajid MOREL <dajid.morel@volvo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dajid,

On Mon, Mar 2, 2026 at 6:43=E2=80=AFPM Dajid MOREL <dajidp.morel@gmail.com>=
 wrote:
>
> In an industrial IoT context at Volvo Group, we use TE Connectivity
> BLE pressure sensors. These sensors exhibit high latency during
> the initial LE connection handshake in noisy RF environments. The
> connection systematically fails on Ubuntu Core 22 (BlueZ) because the
> connection attempt is aborted too early.
>
> In the v2 thread, it was suggested that userspace (via setsockopt
> SO_SNDTIMEO) dictates the connection timeout (defaulting to 40s),
> suspecting that userspace was cutting the connection at 2 seconds,
> not the kernel.
>
> To verify this, an empirical test was conducted using the following
> Python/Bleak script to force the application timeout to 45.0 seconds:
>
>   import asyncio
>   from bleak import BleakClient, BleakScanner
>   import time
>
>   ADDRESS =3D "E8:C0:B1:D4:A3:3C"
>
>   async def test_connection():
>       device =3D await BleakScanner.find_device_by_address(ADDRESS, timeo=
ut=3D15.0)
>       start_time =3D time.time()
>       try:
>           # Forcing 45s timeout in userspace
>           async with BleakClient(device, timeout=3D45.0) as client:
>               print(f"Connected in {time.time() - start_time:.2f}s")
>       except Exception as e:
>           print(f"Failed after {time.time() - start_time:.2f}s: {e}")
>
>   asyncio.run(test_connection())
>
> 1. Result on UNMODIFIED Kernel: The userspace script patiently waited
>    for the full 45 seconds before raising a TimeoutError. If the kernel
>    had actually kept the radio connection attempt alive for those
>    45 seconds, the connection would have succeeded around the
>    12.5-second mark (as proven by the patched kernel test below).
>    The fact that it did not proves that the underlying HCI connection
>    attempt was aborted early by the kernel. Userspace was blind to this
>    abort and kept waiting in a vacuum.
>
> 2. Result on MODIFIED Kernel (with this patch): Using the exact same
>    userspace script (45.0s timeout), the connection successfully
>    established at the 12.51-second mark.
>
> Conclusion:
> This proves that the underlying HCI LE Connection creation is bound by
> a strict 2-second timeout derived from `conn_timeout` in `hci_conn.c`,
> and that userspace socket options do not override this hardcoded HCI
> abort in our stack. The sensor physically takes 12.5 seconds to
> handshake, making the 2-second kernel limit a hard blocker.

Well except if you can point us where the 2 second timeout is coming
from I don't see how this proves that there is a strict 2-second
timeout, in fact I already point you that in the previous thread, it
seems there is something programming the SO_SNDTIMEO to be 2 seconds
which is why you could only overcome it by hardcoding a 20 sec fixed
timeout, so you are actually introduce a strict timeout yourself with
this change, so application wouldn't be able to set their own timeout
when needed.

> This patch increases the hardcoded LE connection timeout to 20 seconds
> to provide a comfortable margin for handshake retries.
>
> Note: If the upstream preference is to not hardcode 20 seconds globally,
> I would be happy to submit a v5 that exposes this as a configurable
> module parameter (e.g., `le_conn_timeout`).
> ---
>  net/bluetooth/hci_conn.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index a47f5daffdbf..7edce4126900 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -1436,7 +1436,7 @@ struct hci_conn *hci_connect_le(struct hci_dev *hde=
v, bdaddr_t *dst,
>         }
>
>         conn->sec_level =3D BT_SECURITY_LOW;
> -       conn->conn_timeout =3D conn_timeout;
> +       conn->conn_timeout =3D msecs_to_jiffies(20000);
>         conn->le_adv_phy =3D phy;
>         conn->le_adv_sec_phy =3D sec_phy;
>
> @@ -1664,7 +1664,7 @@ struct hci_conn *hci_connect_le_scan(struct hci_dev=
 *hdev, bdaddr_t *dst,
>         set_bit(HCI_CONN_SCANNING, &conn->flags);
>         conn->sec_level =3D BT_SECURITY_LOW;
>         conn->pending_sec_level =3D sec_level;
> -       conn->conn_timeout =3D conn_timeout;
> +       conn->conn_timeout =3D msecs_to_jiffies(20000);
>         conn->conn_reason =3D conn_reason;
>
>         hci_update_passive_scan(hdev);
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
