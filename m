Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EA728682
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 16:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772037543; cv=pass; b=i5P/UeemgqMB/jDFzirt8wUJrNj1jFHMDqFFvWoxcXC6k9+ovLhn18k/OZS93rnpcUhQRmr1SJRf0mzxapenzs+xRbAmikUIL3/Lv/7lG6toxdAfRigWtY/QRUKPz4+FEEGkT8NkB6rAOcjNAXe281WIR2ZtSbzSUJG2QFQ/ya4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772037543; c=relaxed/simple;
	bh=FCmWZl/TLnhr+/NmW9grJ69c2wnmYTDCkP9CkEYsbUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AOG94HQxEZ9gG4KaC8U+pr6VOVJrdpE7St9o/jLBgBg6wzgmTdEGPTk3PkeW2uJdSoof3NhNiOetGweCmp0hApNTFKU5ymr9ogALcl2yWqQ+YMMmEYS2nOx9OoKB5Z4JjXcOQSJ900LGIlDg7DFj+L54QostvhR68Q8TlJmwVc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMMIeDW8; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMMIeDW8"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64ca9ec3ee7so875918d50.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 08:39:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772037541; cv=none;
        d=google.com; s=arc-20240605;
        b=kom73XXZAmEOqAlCGL72X1S2VeswUrNNPUD2ALMye41l2tsHcfCMXI9A5K4154HsKr
         9qmjsxBHEWwe3QqLHywlyJCzGCBKpPtJFnrbLoLUNyu22Mx+op3zxX4UIAKQM0aUPwOi
         UcH3uMpmMavnUndanLfjGW6jVlc7lFdoXl/jEKOXIQQD8ENhUJ3QM003OcF2m8XOk7p4
         dfuZNWagfMLFStBCAzjVZBPqFYZk5dA8G9Y0aWB54idqgvH+tggDR6yx5gxTBJQYRLhT
         LRPEse0Xlyqr/L2fZL8rt7tfHmI9Vrirlfel8qKlfGZB3Ulnnr7k2dDs782K6wJBuVfu
         r+vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SjjAFAIyei7mtXxJzx271wnsh6s7jdr54AP9mMmchZI=;
        fh=kQa6Wv+jZCCo0Dk13pUerCaj03ZHdzDdDvtl5YYmgPQ=;
        b=cbTx8pIv8tYj8W4nZgkYDXIWcTZMFnATjFjWVPHiHCOV+m5IcdO59Mz10sMOxyFTaL
         KoXHdeo6tKlL0iQRad4dC36ef0noBOt3/4Gu+fIcAYV7lSYebxU7o5dwhVFz0w23gfLs
         8pRXNJw0hoc5w3VPDh4pXq1aWZyf4fmS1HIqrtBdBor/pQacp7xOKKkb9K29MCYgEGat
         9idLrOsi9DUMJvjKs0aBlYcKn4bIUIAH9uvhhHKL7pNmilRUUTK/TEJslja5PVsrB4Mt
         wBRw1opLeJ/wBcY4HZIcMfLhVi68EubpGi0NRa/Kw+4v8Rj0jIPKYPnivn1yD3WEX7mP
         s9LA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772037541; x=1772642341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjjAFAIyei7mtXxJzx271wnsh6s7jdr54AP9mMmchZI=;
        b=BMMIeDW8lmvxepSaxsqnYCvUkAKRZaMP7bwvKQpYDz0vt2q2Sf0yOb2x45UihGyTcW
         XZisK1WEaUhqE5hs/+BKhy7QXxsd0VGllSwAW98OxnlvUIw2Pf/Ae5Q0GUgr//n/353v
         9P4V9Tjhh1P+TpWXl3K6O4cXPQkX8w3Mud+5adDxm2FRSOBPj+EnglZFphUR2gnjnACn
         qiIHV7kiNmgo+KNdljeWdNkn17Dxr4kIQj8WcdwU/8Lb+MVXY7uRKRYq3pJt1BSzwITG
         141MNC2ESpg4TmHvpXvAI+8d/oGXFCzEq5oxQ0vH+o0a1NkZTF8WV3OciBhAvFdz/fLh
         tXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772037541; x=1772642341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SjjAFAIyei7mtXxJzx271wnsh6s7jdr54AP9mMmchZI=;
        b=HrDygq/TAbA9QUBnd+fU2HUyb2fj0ekTeJt3xMIxDwGEc9QW5EKDqhFRZKqh681aTL
         yrasBA0nlcFFdU21qNXsNFCOx1c2x0FiitTO8WguT4BVIZcoEako2IzgGCr9T9gUQ2sv
         sG+oHeLwexCYlCPT76DRw82kAVwnW++HgCp4k+6EnmJ0NxAJ73DbWyvGWORkrQr9168h
         d96N8QzvghhCkqiQSRVbnGZDlxdRJ1Vva46XN7B5NLu240OlVTNL20yY8jzn+KFp8Il+
         l1qX+ATH5uJWxb3iX8O5O7sO4aEa1LCjF7aejWasmH0zBiqe0t9p/mh/g7vdiWIHiFhv
         LX3A==
X-Gm-Message-State: AOJu0YzNiP4702DWbr7Oa+5HMD80uM6VynPeF3sRbYL6ZTISOMucpNHb
	qSNsUqW0oreR7CBGCIbf39hTIE+udt3/e0lp+gnZrEMEKWDeCf7Bg3cjw9PiZsvtcCar7CtwLJa
	I3bdJ3sgcp0v+Q6OVIlUv1RDum0CUKvmPPRqT
X-Gm-Gg: ATEYQzxE+QyhNwYQMWnV9V/W/HJrss45XHWJzHVsOLEyF2Rdc2hItFCAjHqL6safO/i
	12UqVg5djVYb40G/KIEbW+kDJcsCpzfc6I6qCE6f1iPzk1YDYqwsGVfMvCEiXfOUUKcQOjLmuve
	mOs7FBhpxsDDwcg6oT6GrhTWhVvRxNWhtRJvP+GV/6NEMfoBSLSAf9M3t+7JdMPSyERofcVZn2e
	zzO7fBWiwq5ZDQTxviJ6z0R1HBmerI9yVysqbQpC/4SLx6d2GyL5kRd5OHn5/IBlJwuvsBLWGUx
	uTKVvBya3y//uF1qp6X9FcWAAU3C2GgiYkg6oaEKgEW6E0zqKeXHFnxCRROgso1w2qzRlN3hE/y
	qpw==
X-Received: by 2002:a53:ecd3:0:b0:64a:de2a:e6f5 with SMTP id
 956f58d0204a3-64cb22da365mr789684d50.21.1772037540808; Wed, 25 Feb 2026
 08:39:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225161715.20394-1-ceggers@arri.de> <20260225161715.20394-11-ceggers@arri.de>
In-Reply-To: <20260225161715.20394-11-ceggers@arri.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 25 Feb 2026 11:38:49 -0500
X-Gm-Features: AaiRm51OUaPSrfMu0jn9hIB88Zy9lUkC54RhoYS2VO6bVfIJOgu1q5FqURhSLuo
Message-ID: <CABBYNZLgQWy_+gZmWXRmQx1g7P3pT3=ZLjFa7FuUnpWH4Huf3g@mail.gmail.com>
Subject: Re: [PATCH BlueZ 11/12] agent: move defines and parsing for I/O
 capability to shared/mgnt
To: Christian Eggers <ceggers@arri.de>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Wed, Feb 25, 2026 at 11:22=E2=80=AFAM Christian Eggers <ceggers@arri.de>=
 wrote:
>
> Allow reusing in client/mgmt.c (next commit)
> ---
>  src/adapter.c     |  6 +++---
>  src/agent.c       | 24 ++++--------------------
>  src/agent.h       |  7 -------
>  src/device.c      |  7 ++++---

Shared changed should be sent separately since its license (LGPL) is
different than the daemon (GPL).

>  src/shared/mgmt.c | 32 ++++++++++++++++++++++++++++++++
>  src/shared/mgmt.h | 10 ++++++++++
>  6 files changed, 53 insertions(+), 33 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 9bb1950a9f7d..bfabdf9a62ef 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -9156,7 +9156,7 @@ int adapter_set_io_capability(struct btd_adapter *a=
dapter, uint8_t io_cap)
>         struct mgmt_cp_set_io_capability cp;
>
>         if (!btd_opts.pairable) {
> -               if (io_cap =3D=3D IO_CAPABILITY_INVALID) {
> +               if (io_cap =3D=3D MGMT_IO_CAPABILITY_INVALID) {
>                         if (adapter->current_settings & MGMT_SETTING_BOND=
ABLE)
>                                 set_mode(adapter, MGMT_OP_SET_BONDABLE, 0=
x00);
>
> @@ -9165,8 +9165,8 @@ int adapter_set_io_capability(struct btd_adapter *a=
dapter, uint8_t io_cap)
>
>                 if (!(adapter->current_settings & MGMT_SETTING_BONDABLE))
>                         set_mode(adapter, MGMT_OP_SET_BONDABLE, 0x01);
> -       } else if (io_cap =3D=3D IO_CAPABILITY_INVALID)
> -               io_cap =3D IO_CAPABILITY_NOINPUTNOOUTPUT;
> +       } else if (io_cap =3D=3D MGMT_IO_CAPABILITY_INVALID)
> +               io_cap =3D MGMT_IO_CAPABILITY_NOINPUTNOOUTPUT;
>
>         memset(&cp, 0, sizeof(cp));
>         cp.io_capability =3D io_cap;
> diff --git a/src/agent.c b/src/agent.c
> index 3696575b83e6..794f81ebf18a 100644
> --- a/src/agent.c
> +++ b/src/agent.c
> @@ -35,6 +35,7 @@
>  #include "adapter.h"
>  #include "device.h"
>  #include "agent.h"
> +#include "shared/mgmt.h"
>  #include "shared/queue.h"
>
>  #define REQUEST_TIMEOUT (60 * 1000)            /* 60 seconds */
> @@ -131,7 +132,7 @@ static void set_io_cap(struct btd_adapter *adapter, g=
pointer user_data)
>         if (agent)
>                 io_cap =3D agent->capability;
>         else
> -               io_cap =3D IO_CAPABILITY_INVALID;
> +               io_cap =3D MGMT_IO_CAPABILITY_INVALID;
>
>         adapter_set_io_capability(adapter, io_cap);
>  }
> @@ -944,23 +945,6 @@ static void agent_destroy(gpointer data)
>         agent_unref(agent);
>  }
>
> -static uint8_t parse_io_capability(const char *capability)
> -{
> -       if (g_str_equal(capability, ""))
> -               return IO_CAPABILITY_KEYBOARDDISPLAY;
> -       if (g_str_equal(capability, "DisplayOnly"))
> -               return IO_CAPABILITY_DISPLAYONLY;
> -       if (g_str_equal(capability, "DisplayYesNo"))
> -               return IO_CAPABILITY_DISPLAYYESNO;
> -       if (g_str_equal(capability, "KeyboardOnly"))
> -               return IO_CAPABILITY_KEYBOARDONLY;
> -       if (g_str_equal(capability, "NoInputNoOutput"))
> -               return IO_CAPABILITY_NOINPUTNOOUTPUT;
> -       if (g_str_equal(capability, "KeyboardDisplay"))
> -               return IO_CAPABILITY_KEYBOARDDISPLAY;
> -       return IO_CAPABILITY_INVALID;
> -}
> -
>  static DBusMessage *register_agent(DBusConnection *conn,
>                                         DBusMessage *msg, void *user_data=
)
>  {
> @@ -979,8 +963,8 @@ static DBusMessage *register_agent(DBusConnection *co=
nn,
>                                                 DBUS_TYPE_INVALID) =3D=3D=
 FALSE)
>                 return btd_error_invalid_args(msg);
>
> -       cap =3D parse_io_capability(capability);
> -       if (cap =3D=3D IO_CAPABILITY_INVALID)
> +       cap =3D mgmt_parse_io_capability(capability);
> +       if (cap =3D=3D MGMT_IO_CAPABILITY_INVALID)
>                 return btd_error_invalid_args(msg);
>
>         agent =3D agent_create(sender, path, cap);
> diff --git a/src/agent.h b/src/agent.h
> index bd0502030fa0..03731756849c 100644
> --- a/src/agent.h
> +++ b/src/agent.h
> @@ -9,13 +9,6 @@
>   *
>   */
>
> -#define IO_CAPABILITY_DISPLAYONLY      0x00
> -#define IO_CAPABILITY_DISPLAYYESNO     0x01
> -#define IO_CAPABILITY_KEYBOARDONLY     0x02
> -#define IO_CAPABILITY_NOINPUTNOOUTPUT  0x03
> -#define IO_CAPABILITY_KEYBOARDDISPLAY  0x04
> -#define IO_CAPABILITY_INVALID          0xFF
> -
>  struct agent;
>
>  typedef void (*agent_cb) (struct agent *agent, DBusError *err,
> diff --git a/src/device.c b/src/device.c
> index 0ef7dcc244d2..f7a84b807878 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -43,6 +43,7 @@
>  #include "src/shared/gatt-client.h"
>  #include "src/shared/gatt-server.h"
>  #include "src/shared/ad.h"
> +#include "src/shared/mgmt.h"
>  #include "src/shared/timeout.h"
>  #include "btio/btio.h"
>  #include "bluetooth/mgmt.h"
> @@ -3375,7 +3376,7 @@ static DBusMessage *pair_device(DBusConnection *con=
n, DBusMessage *msg,
>         if (agent)
>                 io_cap =3D agent_get_io_capability(agent);
>         else
> -               io_cap =3D IO_CAPABILITY_NOINPUTNOOUTPUT;
> +               io_cap =3D MGMT_IO_CAPABILITY_NOINPUTNOOUTPUT;
>
>         bonding =3D bonding_request_new(msg, device, bdaddr_type, agent);
>
> @@ -6544,7 +6545,7 @@ static void att_connect_cb(GIOChannel *io, GError *=
gerr, gpointer user_data)
>         if (device->bonding->agent)
>                 io_cap =3D agent_get_io_capability(device->bonding->agent=
);
>         else
> -               io_cap =3D IO_CAPABILITY_NOINPUTNOOUTPUT;
> +               io_cap =3D MGMT_IO_CAPABILITY_NOINPUTNOOUTPUT;
>
>         err =3D adapter_create_bonding(device->adapter, &device->bdaddr,
>                                         device->bdaddr_type, io_cap);
> @@ -7452,7 +7453,7 @@ static gboolean device_bonding_retry(gpointer data)
>         if (bonding->agent)
>                 io_cap =3D agent_get_io_capability(bonding->agent);
>         else
> -               io_cap =3D IO_CAPABILITY_NOINPUTNOOUTPUT;
> +               io_cap =3D MGMT_IO_CAPABILITY_NOINPUTNOOUTPUT;
>
>         err =3D adapter_bonding_attempt(adapter, &device->bdaddr,
>                                 device->bdaddr_type, io_cap);
> diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
> index 6a7eb5798cb8..300abbae1c50 100644
> --- a/src/shared/mgmt.c
> +++ b/src/shared/mgmt.c
> @@ -81,6 +81,20 @@ struct mgmt_tlv_list {
>         uint16_t size;
>  };
>
> +struct arg_table {
> +       const char *name;
> +       unsigned value;
> +};
> +
> +static const struct arg_table iocap_arguments[] =3D {
> +       { "DisplayOnly", MGMT_IO_CAPABILITY_DISPLAYONLY },
> +       { "DisplayYesNo", MGMT_IO_CAPABILITY_DISPLAYYESNO },
> +       { "KeyboardOnly", MGMT_IO_CAPABILITY_KEYBOARDONLY },
> +       { "NoInputNoOutput", MGMT_IO_CAPABILITY_NOINPUTNOOUTPUT },
> +       { "KeyboardDisplay", MGMT_IO_CAPABILITY_KEYBOARDDISPLAY },
> +       { NULL, 0}
> +};
> +
>  static void destroy_request(void *data)
>  {
>         struct mgmt_request *request =3D data;
> @@ -1039,3 +1053,21 @@ uint16_t mgmt_get_mtu(struct mgmt *mgmt)
>
>         return mgmt->mtu;
>  }
> +
> +uint8_t mgmt_parse_io_capability(const char *capability)
> +{
> +       const char *arg;
> +       int index =3D 0;
> +
> +       if (!strcmp(capability, ""))
> +               return MGMT_IO_CAPABILITY_KEYBOARDDISPLAY;
> +
> +       while ((arg =3D iocap_arguments[index].name)) {
> +               if (!strncmp(arg, capability, strlen(capability)))
> +                       return iocap_arguments[index].value;
> +
> +               index++;
> +       }
> +
> +       return MGMT_IO_CAPABILITY_INVALID;
> +}
> diff --git a/src/shared/mgmt.h b/src/shared/mgmt.h
> index 2629fbd59cf6..a4c30075f7b7 100644
> --- a/src/shared/mgmt.h
> +++ b/src/shared/mgmt.h
> @@ -13,6 +13,14 @@
>
>  #define MGMT_VERSION(v, r) (((v) << 16) + (r))
>
> +#define MGMT_IO_CAPABILITY_DISPLAYONLY         0x00
> +#define MGMT_IO_CAPABILITY_DISPLAYYESNO                0x01
> +#define MGMT_IO_CAPABILITY_KEYBOARDONLY                0x02
> +#define MGMT_IO_CAPABILITY_NOINPUTNOOUTPUT     0x03
> +#define MGMT_IO_CAPABILITY_KEYBOARDDISPLAY     0x04
> +#define MGMT_IO_CAPABILITY_INVALID             0xFF

Perhaps this should be an enum to ensure things like switch statements
do check for unhandled values.

> +
> +
>  typedef void (*mgmt_destroy_func_t)(void *user_data);
>
>  struct mgmt;
> @@ -89,3 +97,5 @@ bool mgmt_unregister_index(struct mgmt *mgmt, uint16_t =
index);
>  bool mgmt_unregister_all(struct mgmt *mgmt);
>
>  uint16_t mgmt_get_mtu(struct mgmt *mgmt);
> +
> +uint8_t mgmt_parse_io_capability(const char *capability);
> --
> 2.51.0
>
>


--=20
Luiz Augusto von Dentz
