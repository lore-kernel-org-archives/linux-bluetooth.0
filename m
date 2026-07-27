Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1CC3DA5A0
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 19:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785182343; cv=pass; b=X4RgNzoids1Q8h2A8hxL4zJatY7e7F1QeSVYdXbUhNUkRH4AIdb135DBKhKoCtw+EC+c7ShBOk2zRq5I/Q5RuZUbO1Dws1Yz3eSB4KAvatV6WHdrI+0atYXBr/1snAdBX3lz2eLHVJ/efCZIggKjPBzPfofgaFJjUflY9NfQRRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785182343; c=relaxed/simple;
	bh=/MiVDBQt9ZMYK54F5gjAbEf6GyoJTsVsaI0o2O2QZMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sJMT1dPOZyJ7SeYPi/qKttHKu0jtVg80qMI+zqj/1N3H+CjpHFk2mCM5zTNz3DJtuQswPafy3CMEKf3p/IhDknq0sbHy4Zgqr5bPuQszJ90aPqFYdMbbLIjXpM+bqEkLSHTBYXlOyJcwE1bFfyH95TtL+BSBmrb/vYOq8Et30Bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WspllgJF; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WspllgJF"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-80c5cb9a888so30131137b3.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 12:58:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785182338; cv=none;
        d=google.com; s=arc-20260327;
        b=mbEw9/X7esD3YIen/owDGaiC9Cj5LGxMEs7EE6ZoyJTUsvxp75SlYWk4ajMfUIYIp9
         LnSqO5IBEK75pxn1NiHHISxz6tTlUYJeyNnd6iGHvGCt1L67Kxtnh9TqrmIXYUG0Vodp
         xU2Y+nA5VXoMDTLozIbUG3k+XVLt0h+vQ1buWYCQ84vpzVVgsqKFW1cEMSUpxuk8UYNe
         kaYplgaRzUvFmyxvqBxxUvIyUwxaNnwBy+xg7Oe+UYC6AizzkfJ+704JgnyFktmuVFLw
         KdR7LZJFuJafXvfy38l+SCCVyQsUwxYRt/p7YbDUBEjCSgSxRKl10Ps/dFkj34srUgu4
         ZkUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FrzSjjnTcGEK04c5Z1ydE4wgMCKLKn9OhgKvKlgiNW0=;
        fh=j5fHPlGjJPYHiVqv+jakRXmEJnGRQwBq+rBhbLiOOrc=;
        b=SKG03SNNsA3DnDAJ+R7IA4XduM76y0vmLX/O/kcqBBTDp3yN+iaL8UoUJxv2RUHvxe
         +94Tl6mRrU3VuoLMxegtqQan0KjlG89xvBVQXP6ewHdlN5G4GAKEKLC50/JZ5G19jltF
         OlrXLve0udrhj91WAdMI7RwO3iTbPA+XvZVsNhrTRlzrwuYFu7F1k7NEaMcvdc7zBCc3
         76toAUDVoTtuyKO43o/c8QopCCvMnlfImxtsEglElRqF19xxkYQr+E8dU/sT8Br5Vg8o
         kHeLyAZQXClDI/Juup7+7BlCGYwWEIXGpSgDBJgrXAbAmEygcw386u4QcY9wQyNn5epj
         QHyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785182338; x=1785787138; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FrzSjjnTcGEK04c5Z1ydE4wgMCKLKn9OhgKvKlgiNW0=;
        b=WspllgJFisRMkxAnx7W7WOgcPfL2cEdVuEyiwe23IWK8rvd3UvlXr6xYf+gT6u7PuU
         hQX9wufAblVj0eoRUgmqO4V7YLZqizfTeKYtvRIjnxeilE7NuOiD7pIK8tusvdfGugZ6
         dZm7LANxtOTJ+VaQSbdSN2yefuUeb1hBIhwE4LvJpClAZSzjhXrXp/7w3UORJHCmogLV
         f/7YoBVAl/mlciu/c1vS5UKyqQ2UCCFHA9SlMvoU6UuU7VdBuHHC3f5FrwtEGhvOrMth
         eYm1+btFyU56vEMola6/8J4A0y8e5MHkZ47wQGuInuv4jQLww6DKONHMZgSruRqQp40f
         k+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785182338; x=1785787138;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FrzSjjnTcGEK04c5Z1ydE4wgMCKLKn9OhgKvKlgiNW0=;
        b=JjDmQKbRp9yGX16UhOqGp/AhvPkw2O1iBc9lgsj1w9WMrSU1YsnMifWzxyushKxCjU
         JlEIFKA/MvK1nvKnErIbhvA8+TmdPHeOyaI+xFUsnh5q5wanKf2pFemA8QTKcMe1M6CZ
         Gzs0v1tmqwxlo5yX2URi4rMzsmu43SeZmgi4MIgQiLdSnlVbgIFjBAWfd3fIddOlxq2Q
         zo6J6qxp9bTV5ogS+XvxMVs2QFhhumOooL3tpNujMHEc+eJqMmSXQSNaWLiWngawjocP
         C8E+9DOfDjOoPDcIXyNWqs1RXGWETx0bJFvMDBwHQi+dNfzUJr9eUG/i+PQFEYJd4r7B
         vvIQ==
X-Gm-Message-State: AOJu0YyBAbxAi3x2M+RZMzEUp6RCR6tLDNFtK1g3IZ37EmHWmXkhu7HK
	c5mBNEGGEIsxYoxybtXDCf0waliXpjMiSRF44dGARqzvRzFfFr3XJWC/YVf2YooI+vzj2r8ban8
	9Tcl0AXUmQAbw/IDvtSMHamR1DAcs71dJYI/F
X-Gm-Gg: AR+sD13EZ3SoTjHzZi7UkDLmDJ8I0L9zrsjOK62V2pZvEs6oRjVjU4m9i0Iw55cwhvQ
	ZaR7iRaUYqDOPtuAwiiOXubiRilzFQaua+suchA+9aGB+YFULgxjQY6jRLS5O2h8WqrIF8FwEz+
	yVTq4f0mKkKRv/Q5ET8c4B46c0jAOuZmwz4SF4eOkbbwAOrAUQnla4fOu/+ssXAxFaGskrv6XhB
	FnwO0KIIZebSaNPXCRTwTZyJWU65pM4WV5UODmSkjCuXmk/gUb0KGdmEyE+Fy4ZsOrFqxWy3/6V
	JqT0Fyizj4hDZRaX0yus89dqr/wHSQDgTKMWKBLfKkLBd52shhOe
X-Received: by 2002:a05:690c:b1e:b0:80d:5978:9730 with SMTP id
 00721157ae682-81f93a55a5amr4645637b3.43.1785182337540; Mon, 27 Jul 2026
 12:58:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260725201856.2142333-1-matthew.schwartz@linux.dev> <20260725201856.2142333-2-matthew.schwartz@linux.dev>
In-Reply-To: <20260725201856.2142333-2-matthew.schwartz@linux.dev>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 27 Jul 2026 15:58:46 -0400
X-Gm-Features: AUfX_mwpJCwgjjK1HAjAT99jx-0ciQdrP-JXBgfBwHq2VWK6YmuFZChyATW2ugg
Message-ID: <CABBYNZLaSBPDbbWUVm2r57aTp8eikutNYKTW7csDjQcq1F9Fpg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] adapter: Add btd_adapter_may_wake()
To: Matthew Schwartz <matthew.schwartz@linux.dev>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matthew,

On Sat, Jul 25, 2026 at 4:19=E2=80=AFPM Matthew Schwartz
<matthew.schwartz@linux.dev> wrote:
>
> The kernel provides no interface for querying whether a controller is
> currently configured to wake the host from suspend. hci_register_dev()
> marks HCI_CONN_FLAG_REMOTE_WAKEUP as supported whenever a driver
> provides a wakeup callback, and btusb always does, so the supported
> flags reported through mgmt say nothing about the runtime setting. The
> value that matters, device_may_wakeup() on the underlying USB device,
> is only evaluated during the suspend flow, and the wakeup callback is
> not a pure query (btmtksdio's variant sends vendor HCI commands), so
> mgmt could not simply re-evaluate it on Get Device Flags without new
> kernel infrastructure.
>
> Add btd_adapter_may_wake(), which reconstructs what btusb reports by
> walking the adapter's sysfs ancestry to the closest USB device and
> reading its power/wakeup attribute. A missing attribute means the
> device cannot generate wake events at all, which is what btusb
> arranges for the fake CSR clones by clearing the USB device's wakeup
> capability. The attribute is read per call so that each query
> reflects the current setting.
>
> Only USB is handled. Controllers on other buses keep the current
> behavior. btmtksdio exposes the same attribute on its SDIO function
> device, but its wakeup callback can also depend on a vendor command.

I guess we should introduce some new mgmt setting that allows us to
detect whether the adapter is capable of waking up the system or not.
The tricky part is this being dynamically enabled/disabled with the
likes of:

echo "disabled" > /sys/bus/usb/devices/usb1/power/wakeup

So this would need to send MGMT_EV_NEW_SETTINGS reflecting the current
value of hdev->wakeup, which I don't know it really is worth the
trouble, or we should really hack together the sysfs entry like this,
or maybe we expose the sysfs entry of the device somehow so it is
known to bluetoothd via some mgmt event or something like that.

> Assisted-by: Claude:claude-fable-5
> ---
>  src/adapter.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  src/adapter.h |  1 +
>  2 files changed, 71 insertions(+)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index a56eafabe..65b394f82 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -563,6 +563,76 @@ uint8_t btd_adapter_get_address_type(struct btd_adap=
ter *adapter)
>         return adapter->bdaddr_type;
>  }
>
> +static bool sysfs_wakeup_enabled(const char *dir)
> +{
> +       char path[PATH_MAX];
> +       char *contents;
> +       bool enabled;
> +
> +       snprintf(path, sizeof(path), "%s/power/wakeup", dir);
> +
> +       /* A missing attribute means the device cannot wake the host */
> +       if (!g_file_get_contents(path, &contents, NULL, NULL))
> +               return false;
> +
> +       enabled =3D g_str_has_prefix(contents, "enabled");
> +
> +       g_free(contents);
> +
> +       return enabled;
> +}
> +
> +static bool sysfs_is_usb_device(const char *dir)
> +{
> +       char path[PATH_MAX];
> +
> +       /* USB devices expose idVendor, USB interfaces do not */
> +       snprintf(path, sizeof(path), "%s/idVendor", dir);
> +
> +       return g_file_test(path, G_FILE_TEST_EXISTS);
> +}
> +
> +/*
> + * Whether the controller is currently configured to wake the host from
> + * system suspend. btusb reports this to the kernel with
> + * device_may_wakeup() on the underlying USB device, which userspace
> + * controls through its power/wakeup attribute. Only USB is handled
> + * here. Controllers on other buses are assumed to be able to wake the
> + * host. The attribute is read on every call so that runtime changes
> + * are picked up.
> + */
> +bool btd_adapter_may_wake(struct btd_adapter *adapter)
> +{
> +       char path[PATH_MAX];
> +       char *dir;
> +       char *sep;
> +       bool may_wake =3D true;
> +
> +       snprintf(path, sizeof(path), "/sys/class/bluetooth/hci%u/device",
> +                                                       adapter->dev_id);
> +
> +       dir =3D realpath(path, NULL);
> +       if (!dir)
> +               return true;
> +
> +       while (g_str_has_prefix(dir, "/sys/devices/")) {
> +               if (sysfs_is_usb_device(dir)) {
> +                       may_wake =3D sysfs_wakeup_enabled(dir);
> +                       break;
> +               }
> +
> +               sep =3D strrchr(dir, '/');
> +               if (!sep)
> +                       break;
> +
> +               *sep =3D '\0';
> +       }
> +
> +       free(dir);
> +
> +       return may_wake;
> +}
> +
>  static void store_adapter_info(struct btd_adapter *adapter)
>  {
>         GKeyFile *key_file;
> diff --git a/src/adapter.h b/src/adapter.h
> index a9e1bbf66..ae0011ff7 100644
> --- a/src/adapter.h
> +++ b/src/adapter.h
> @@ -107,6 +107,7 @@ const char *adapter_get_path(struct btd_adapter *adap=
ter);
>  const bdaddr_t *btd_adapter_get_address(struct btd_adapter *adapter);
>  uint8_t btd_adapter_get_address_type(struct btd_adapter *adapter);
>  const char *btd_adapter_get_storage_dir(struct btd_adapter *adapter);
> +bool btd_adapter_may_wake(struct btd_adapter *adapter);
>
>  int adapter_service_add(struct btd_adapter *adapter, sdp_record_t *rec);
>  void adapter_service_remove(struct btd_adapter *adapter, uint32_t handle=
);
> --
> 2.55.0
>
>


--=20
Luiz Augusto von Dentz
