Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793396108;
	b=NujB7K1JVYRhxNfHhjwcuGj2UpzV8oVJVFWu7W8hMV/qgUu+X7Em6GnQXlJio3HUVSKu
	 i2McNCEpsnUIlTAQty09LDDeTPb6hcEtAt0qk3C8npdULF8yQYVWc/xM3VKDYVfbshcWE
	 gXwJnEhoStkdT6kWwteFiThUO0ps24w2lGIRVMYc9bE7AJVsRkf5xM9t7CHUyvWWOXsU2
	 klHfyOvNdpe+2W+I3ob/LImpTw9tUl99BViimrcFKsKOjEwTTqq5V05HdEXyuwTN0QK3X
	 Tafbcq+cxRik48DmbgqqFDyUhPorUa9/n0GYnOFv3aog6obN4bJ+f+7z72MOIR3dGpQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793396108;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Content-Type:Content-Transfer-Encoding;
	bh=pKSqMRpn2t/7aoSyz8xHnAI/dP2eM5jfEv3yUjbshlg=;
	b=qT4BzxKGaSca46fEKDHYtvhhWvsevxE7cdHSoen6Lmk2xT4bboPkPr7demTHLKLLF01+
	 rKFhCvOJeRLOiah98wY1bO2p+j+ai6J0typ68F397/xl5ugIC5+u7RDUepkgBazmfWkLt
	 7fi4NXTdQUI1P1gvi4xQLLjXPBIMgqEh4F1zs32CsL49TXQ5FLz48A8+TQc4ZrjT7o/18
	 k8LbudNd1xZCd0vI8LmZcPeP6w8L4WzdzeCAlxYUaxmVeqc5H30E4M0FKb+dzo0hxak3f
	 pguNGd1JvnQM40jqfKSOr34HYPkJoA/2ZVJR84H/J+CV0kJtFb8fEConw408zY7hdnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="AsiJe/pg";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E686606A33D
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 21:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E686606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AsiJe/pg
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8b0a921ee46so11662747b3.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 14:35:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793396107; cv=none;
        d=google.com; s=arc-20260327;
        b=BBbYrOyU1eDY8G4hPYWUfylDRgiJSmZZXGihm4zF2R0wCI1zutF1j/lN8kEoxkq8SC
         uBZoLuaaQOBxHwnMeLRuYwsItFJGwPBABg+AfjH3aHYoPyZWAUnwZB6E2K/td6mzNENT
         8qmFmfSA8kLN5s2kv7YGjsTvWaOjbksZzt+vnHsn3XBKepXUFAoBPS09PsacvXL4Up24
         Xh0kE940JXQE7Tt50zcfykClo0rJgAxhXcYPaideuJKq8cLFNC34VDRv/87G/vxA2mGF
         64Toc8RaZn+o0O6xGwhOEQuM/agTjnMifyQX+l7nMeCCHOwKHQzyN7yqktSPedOO+3Rv
         rb4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pKSqMRpn2t/7aoSyz8xHnAI/dP2eM5jfEv3yUjbshlg=;
        fh=4lGQI6056MBa4/oovMyIYaKLn+Wz/24RGvUivMmQP8E=;
        b=qYm+AAKkzcKmxcLjvRJo+Tj88pl+2cbpBRat0RcsI80RTiOZhZv61+lnj/0QbB/XW2
         HTIkzOczgq3p3TAHT8Ogr1ohXHXBfpp7LSR9e3mj2+JzU1RG+XaZRJDIZVV7h/wl5CN0
         eYP0MeYiWfUVnO3G52d/Pw9ImYQNZTWl0foIQf+9X4HrcqJFo0+4g0tljMu0JNegASqQ
         Cgi8wGdt3FgTdJKzm13J5GMIpZGA2d65LtH1zOn7wPBOyNvYGfYe4N0P3Vs3AoRv3fSL
         cDrDeAxeiZDkJMgTlgX3VqiYI9Toq8gwx4HHW9THRBfXP0gv/iDzvfdHUXIiJd1JT6hB
         Wo+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793396107; x=1794000907; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pKSqMRpn2t/7aoSyz8xHnAI/dP2eM5jfEv3yUjbshlg=;
        b=AsiJe/pg9XzJk5egx2lPJ5bVLlvgFy0CZScdiH7Pv+Xg98cwHWMG+GRIWazYr9tTrT
         3RxqkiHNeqlmYy1sUUfVFiNT8ANVvf1VGuB8Jur83vvlmxzWU3l+K/5U0CD/3xT9JRn0
         S01DnDX0ZNoap/6W7sKcccM15On+z9qZIyMzOPQIx78KtiyzHnMy26uHDm0gbv0Z0iff
         VNzdylgBijRuAgW8uX4+TIhp/EsXAsreMmYHTyRBBvtP0+r0KI4bPu2ISwPybl+UDYAQ
         wyJDaiqokkoI+Zi0/zXfYIJNATUmLxriTmdxYksL2Ik0lq+B5yc8jkAyudhWQnioLdiJ
         NaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793396107; x=1794000907;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pKSqMRpn2t/7aoSyz8xHnAI/dP2eM5jfEv3yUjbshlg=;
        b=cyukVcvW8TW3OLPVgcM0lFOePoDbH+Y8h4VXjeEdBq/1e9h1T7Gc+RkUo/FOVJUeav
         t/oP6mJQ0kyWEcjgUIMfT9hK33FGAKIcfWa689aaF2Vcvn1CYM+2sl0C/GwzvNVYl9Ik
         kTbNIUx/Ftl8t1EMqCI3uhavKvkVL4yyDBIPmYjnQpSC82RRmc56+jmhe+T7k4YiJrsE
         H/a4QC3dC+N+yUormlENEp0ZrGB60m0g3+jxcG8qfv+gSfWfrAmYO5rTiVWYNKch4hCi
         YWcyl8quFettzpKsPD6Loi9O/OSuwvIcMR5ZbxU9Ulkqjs5Qhp04t0x6C9DQ9iq5rY0n
         xQrg==
X-Gm-Message-State: AFq9FYL/FiMEzYrF8x2/vqmmZmWP8T1jtir6Uzka1/6hzLpe2/3sHvsP
	7pRC0w6QCw9rrhgLp9cMki0DvJyoXHpKqtKdHXFS9w8njQPAmHFyJp87L2HdP5SlB/x2xnitKXs
	iVg2gskdOauXC4B9PbnK5CKXsipgotyyJkg13
X-Gm-Gg: AYBFou36DnHt/fgRL0jkUUFUWr5iqHaHaQAbcDV7tRkNC07AOKgxGE+6KQ9KyhmfMK2
	akgbojSej3ea3SlWtIqurPK36wp5e9Qb2aaty5xh1Ax7XXJH8gOT8wbaYPFIiUmQDDXXqNexvgR
	LhUFFBJjlVpQA2wRVgIn+bZVeoO2ydWYpc0OI8OIYKw5nxhUShciEdnU/EGvaaAvsMe2yogy3he
	OXT+QfSNkvtsSPpYJx9W1fgMhbnKVsuGrbhVUS8t8tobZTXa4fITjUwcp6d85NyB0GuGGFFmvd4
	qLeBwBxoo+/ubMAjBm0M53l7mH1jfZDI0M+YWAhqYY7qdqpjxhrZwFk4kqb42ZcD3ICVNU3HYXu
	4AmgN6KXqYZFrvSmO0FJzZ2y5eTXACXGduOHxHGo9ssiNnFdAFIrsBd1cm34LnEabk9NrYigzTG
	zypMUneJq/Y3yp9y9+ALhgUlbzxb+u75bjguEseEZGHtvv69oHD8U/xeoVnY0=
X-Received: by 2002:a05:690c:a905:10b0:89a:63da:fab2 with SMTP id
 00721157ae682-8b2b67ea799mr15729487b3.109.1793396107004; Fri, 30 Oct 2026
 14:35:07 -0700 (PDT)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030212940.753771-1-luiz.dentz@gmail.com> <20261030212940.753771-5-luiz.dentz@gmail.com>
In-Reply-To: <20261030212940.753771-5-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 30 Oct 2026 17:34:54 -0400
X-Gm-Features: AclHuK884XTzPKn_V_n3IbLt2mF3cVK-DNRin61bvNN0GkwQ8h1nYbHS_IL9EZA
Message-ID: <CABBYNZJLeZumbUiZuKROwCZeGCG2wvdNTYtw+-jEr8bZX+a2BA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 04/10] adapter: Don't return Busy when a pending
 change sets the same value
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi @Pauli Virtanen

On Fri, Oct 30, 2026 at 5:29=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Registering an agent sets the adapter bondable, so setting Pairable
> right after, e.g. with "pairable on" in bluetoothctl as soon as it
> registered its default agent, fails with Busy although the pending
> change already does what was requested.
>
> Track the value of pending changes, and when a request sets the same
> value, reply to it once the pending change completed with its result,
> without sending the command again. Opposing requests still fail with
> Busy.
>
> Fixes: 348feb005a12 ("adapter: Return Busy error when setting is pending"=
)
> Assisted-by: Claude:claude-opus-5-5
> ---
>  src/adapter.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 77 insertions(+), 4 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index edd2fdaf4db9..3c0895d1e241 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -280,6 +280,8 @@ struct btd_adapter {
>         char *short_name;               /* controller short name */
>         uint32_t supported_settings;    /* controller supported settings =
*/
>         uint32_t pending_settings;      /* pending controller settings */
> +       uint32_t pending_values;        /* values of pending settings */
> +       struct queue *pending_props;    /* requests waiting a pending set=
ting */
>         uint32_t power_state;           /* the power state */
>         uint32_t current_settings;      /* current controller settings */
>
> @@ -745,6 +747,44 @@ struct set_mode_data {
>         uint8_t value;
>  };
>
> +struct pending_prop {
> +       uint32_t setting;
> +       GDBusPendingPropertySet id;
> +       uint8_t status;
> +};
> +
> +static bool reply_pending_prop(const void *data, const void *match_data)
> +{
> +       const struct pending_prop *prop =3D data;
> +       const struct pending_prop *done =3D match_data;
> +
> +       if (!(prop->setting & done->setting))
> +               return false;
> +
> +       if (done->status =3D=3D MGMT_STATUS_SUCCESS)
> +               g_dbus_pending_property_success(prop->id);
> +       else if (done->status =3D=3D MGMT_STATUS_RFKILLED)
> +               g_dbus_pending_property_error(prop->id,
> +                                       ERROR_INTERFACE ".Blocked",
> +                                       mgmt_errstr(done->status));
> +       else
> +               g_dbus_pending_property_error(prop->id,
> +                                       ERROR_INTERFACE ".Failed",
> +                                       mgmt_errstr(done->status));
> +
> +       return true;
> +}
> +
> +/* Reply to the requests that waited for a pending setting change */
> +static void reply_pending_props(struct btd_adapter *adapter,
> +                                       uint32_t setting, uint8_t status)
> +{
> +       struct pending_prop done =3D { .setting =3D setting, .status =3D =
status };
> +
> +       queue_remove_all(adapter->pending_props, reply_pending_prop, &don=
e,
> +                                                                       f=
ree);
> +}
> +
>  static void set_mode_complete(uint8_t status, uint16_t length,
>                                         const void *param, void *user_dat=
a)
>  {
> @@ -761,6 +801,7 @@ static void set_mode_complete(uint8_t status, uint16_=
t length,
>                 if (status !=3D MGMT_STATUS_RFKILLED &&
>                     data->setting & MGMT_SETTING_POWERED)
>                         reset_power_state_target(adapter, data->value);
> +               reply_pending_props(adapter, data->setting, status);
>                 return;
>         }
>
> @@ -770,6 +811,7 @@ static void set_mode_complete(uint8_t status, uint16_=
t length,
>          * event handling functions here.
>          */
>         new_settings_callback(adapter->dev_id, length, param, adapter);
> +       reply_pending_props(adapter, data->setting, status);
>  }
>
>  static void remove_temporary_devices(struct btd_adapter *adapter)
> @@ -785,6 +827,17 @@ static void remove_temporary_devices(struct btd_adap=
ter *adapter)
>         }
>  }
>
> +static void set_pending(struct btd_adapter *adapter, uint32_t setting,
> +                                                       uint8_t value)
> +{
> +       adapter->pending_settings |=3D setting;
> +
> +       if (value)
> +               adapter->pending_values |=3D setting;
> +       else
> +               adapter->pending_values &=3D ~setting;
> +}
> +
>  static bool set_mode(struct btd_adapter *adapter, uint16_t opcode,
>                                                         uint8_t mode)
>  {
> @@ -828,7 +881,7 @@ static bool set_mode(struct btd_adapter *adapter, uin=
t16_t opcode,
>         if (mgmt_send(adapter->mgmt, opcode,
>                                 adapter->dev_id, sizeof(cp), &cp,
>                                 set_mode_complete, data, g_free) > 0) {
> -               adapter->pending_settings |=3D setting;
> +               set_pending(adapter, setting, mode);
>                 return true;
>         }
>         g_free(data);
> @@ -3149,6 +3202,7 @@ static void property_set_mode_complete(uint8_t stat=
us, uint16_t length,
>                 if (status !=3D MGMT_STATUS_RFKILLED &&
>                     data->setting & MGMT_SETTING_POWERED)
>                         reset_power_state_target(adapter, data->value);
> +               reply_pending_props(adapter, data->setting, status);
>                 return;
>         }
>
> @@ -3160,6 +3214,7 @@ static void property_set_mode_complete(uint8_t stat=
us, uint16_t length,
>          * event handling functions here.
>          */
>         new_settings_callback(adapter->dev_id, length, param, adapter);
> +       reply_pending_props(adapter, data->setting, status);
>  }
>
>  static void clear_discoverable(struct btd_adapter *adapter)
> @@ -3199,9 +3254,23 @@ static void property_set_mode(struct btd_adapter *=
adapter, uint32_t setting,
>
>         dbus_message_iter_get_basic(value, &enable);
>
> +       /* A pending change, e.g. bondable set when an agent registers,
> +        * already does what is requested if it sets the same value: repl=
y
> +        * once it completed instead of sending the command again.
> +        */
>         if (adapter->pending_settings & setting) {
> -               g_dbus_pending_property_error(id, ERROR_INTERFACE ".Busy"=
,
> -                                               NULL);
> +               struct pending_prop *prop;
> +
> +               if (!!(adapter->pending_values & setting) !=3D !!enable) =
{
> +                       g_dbus_pending_property_error(id,
> +                                               ERROR_INTERFACE ".Busy", =
NULL);
> +                       return;
> +               }
> +
> +               prop =3D new0(struct pending_prop, 1);
> +               prop->setting =3D setting;
> +               prop->id =3D id;
> +               queue_push_tail(adapter->pending_props, prop);
>                 return;
>         }
>
> @@ -3289,7 +3358,7 @@ static void property_set_mode(struct btd_adapter *a=
dapter, uint32_t setting,
>
>         if (mgmt_send(adapter->mgmt, opcode, adapter->dev_id, len, param,
>                         property_set_mode_complete, data, g_free) > 0) {
> -               adapter->pending_settings |=3D setting;
> +               set_pending(adapter, setting, mode);
>                 return;
>         }
>
> @@ -6244,6 +6313,9 @@ static void adapter_free(gpointer user_data)
>
>         queue_destroy(adapter->exp_pending, cancel_exp_pending);
>
> +       reply_pending_props(adapter, UINT32_MAX, MGMT_STATUS_FAILED);
> +       queue_destroy(adapter->pending_props, NULL);
> +
>         /*
>          * Unregister all handlers for this specific index since
>          * the adapter bound to them is no longer valid.
> @@ -7311,6 +7383,7 @@ static struct btd_adapter *btd_adapter_new(uint16_t=
 index)
>         adapter->auths =3D g_queue_new();
>         adapter->exps =3D queue_new();
>         adapter->exp_pending =3D queue_new();
> +       adapter->pending_props =3D queue_new();
>
>         return btd_adapter_ref(adapter);
>  }
> --
> 2.56.0

This one should address the same problem you had with test:
functional: retry pairable when Busy. Let me know if you still want to
merge that one first or you are fine with the reply waiting the
command to complete.

--=20
Luiz Augusto von Dentz
