Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9F263B9
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 17:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750353385; cv=none; b=pJacCrhWQXi9O6P3hmSLTTZnPQmrlmh97boFeaDwYFtX83WUJPa0EsT8N2qC6aAqkldQPMhoQ6/vludaxFltB0lkSKYhD8Senw11IHBdDGaQKvVWErHuWfSf8UHLt1ZdEDhT+6X+7x6FB+LmeTqxp1/y8L0tYPUxV80QMdiFR0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750353385; c=relaxed/simple;
	bh=JC23AZnrd0/q2EgLDnFtpPnyLBJFlocYw/+udgXwb38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SgG+Cq6iFL7hhuY5/vYijZxXWyIZVoRMraXGRnsT/+BL9WVptx4xS0WipXJZPp5GMl8otlHLNOizpR/kAOgaHPZAAnZ1cFM2rNU7YuPIemfyJ+j3E5GnJy8j/OGcDD9UMQd0kVgGE0Ef2KLap982lWdRB1R8/3rAjmQXF1j12cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jt0Ql10B; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jt0Ql10B"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-553b16a0e38so1093963e87.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 10:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750353381; x=1750958181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ACaFuTNhvFpfR5YU5QsPdBnmz97tvEFH4EtgAhY4Xk=;
        b=jt0Ql10B/Qy99Mz98MqOR0O1AccOB3oUx0LWBMNHSj+cQy7mU94/IY9eZXCtm9dHCA
         xt7PyidHK1kYFm4loPRX5hkvSZc643JBr5Y1JlkHAwVBZYzwJ9YYR75Nxj2xZMP+2xP3
         zUU4Sc0nx/8coA7bm4UzbHjxvPU1KKdxUWYwc9HF7x4guJkH3JPm3cUQC9555MtXVt4B
         gfZCjJQkfz7OL6S5hAlYRIwtqKXArWccsynHc0ZErsSV3/kyzzjQqDeP/vTsfgQE2CdX
         CqjnbSw4xuSJf3JjMj0hoigVB0i+qukX+2GaO7YKPbkj9eShkgrihhCQUda4iiuH08C2
         o7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750353381; x=1750958181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ACaFuTNhvFpfR5YU5QsPdBnmz97tvEFH4EtgAhY4Xk=;
        b=vjJz8RFJFFsU65Q4KUXDNI85es9JupMYNavfL+cQ3rvF0+nPMRtXRMLkbZSx+QPpew
         6h8h7Qvfvwfahuz8QSQwEDgyi1DUCbWSRsACiLrcChyd0T/lCEt6WaMphEGorvJwd1mo
         3Y8KObH5DNF4ieSKeDD0z/g3JZdG5ZA8q/JexQfPhXS1zuIBtTAzqSu7J505ZTh/a4cL
         E3GCe4mG+53nQAa9G/viuYc6/8iT6sd9GMPcXMtRMefrK+WbmP8z6hCmzLe26Xq69KFp
         pMSdERlljR4ooRo/BZTjhaaO+zDb8Ab0kdjK4uNhm/55ciA1Eh75kffNNqn9qe4ePu2z
         4pgg==
X-Gm-Message-State: AOJu0YwocCVJod6O7YZF8VyANSsdJo5/s74mUsUOsRL3J3MzpcYrlY/S
	boOkFEFsK4xirgBebJ7ceLENmfAcg9Qn27XDw4GXXXDVClR8u2xuqoTgg2CpvonvHvqBaIob6KX
	uzzAPLweY+MmtjRmTHIcKmeMVAlR1yJuW0mbOJR4=
X-Gm-Gg: ASbGncshQ57C9J50ZCn3Gk7uH7CmWIc45jagPX2+g7YTtm6w484yJ2/mftiMs8O4LGt
	OBGKGRERTk0e4S2bUuKF16gwxonK/qy3WcSi3wRAmiKHvToahWJhzcKifyRtqJ/Tr93XSpPGZQa
	T5d60J36Fx0un5zgBAEh9Uf5NpFL3n/+GKhYSjrgaOPbIEBW4yxxqR
X-Google-Smtp-Source: AGHT+IH99uFBiUDdHKtowo7OwTN5+LwdnLQ1jEc1ph+G/6MRa/oMiNfEgadIYBb39yjtWGHBApwnDNmuV/rTnb7+Zl4=
X-Received: by 2002:a05:6512:308f:b0:553:2c58:f96f with SMTP id
 2adb3069b0e04-553e3ba742bmr9852e87.1.1750353380856; Thu, 19 Jun 2025 10:16:20
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619153120.126315-1-k.samburskiy@omp.ru> <20250619153120.126315-3-k.samburskiy@omp.ru>
In-Reply-To: <20250619153120.126315-3-k.samburskiy@omp.ru>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 19 Jun 2025 13:16:07 -0400
X-Gm-Features: AX0GCFtpv93BkwIomlbjEtfXGQ3aqMmTO0KZcE9sahAZ4CCuq9waePdN98NgONc
Message-ID: <CABBYNZ+CLUV9Ny3GuXoeEuVXKtENPRdCq+jFZdriXMyksmL+8w@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] test-vcp: free server-side bt_vcp on test teardown
To: Kirill Samburskiy <k.samburskiy@omp.ru>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kirill,

On Thu, Jun 19, 2025 at 11:34=E2=80=AFAM Kirill Samburskiy <k.samburskiy@om=
p.ru> wrote:
>
> Shutdown tester IO before freeing bt_att instance to trigger its IO
> disconnection callbacks. This detaches bt_vcp instance created by
> vcp_get_session function, and executes detach callback registered
> through bt_vcp_register that frees memory used by this bt_vcp instance.
> This prevents the test from failing in some environments.

I guess this should close the following issues:

https://github.com/bluez/bluez/issues/726
https://github.com/bluez/bluez/issues/683

> ---
>  unit/test-vcp.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/unit/test-vcp.c b/unit/test-vcp.c
> index 6a61ea2c4..04254700b 100644
> --- a/unit/test-vcp.c
> +++ b/unit/test-vcp.c
> @@ -38,6 +38,7 @@ struct test_data {
>         struct queue *ccc_states;
>         size_t iovcnt;
>         struct iovec *iov;
> +       unsigned int vcp_id;
>  };
>
>  struct notify {
> @@ -78,9 +79,9 @@ static void print_debug(const char *str, void *user_dat=
a)
>                 tester_debug("%s%s", prefix, str);
>  }
>
> -static void test_teardown(const void *user_data)
> +static gboolean test_teardown_finish(gpointer user_data)
>  {
> -       struct test_data *data =3D (void *)user_data;
> +       struct test_data *data =3D user_data;
>
>         bt_vcp_unref(data->vcp);
>         bt_gatt_server_unref(data->server);
> @@ -90,7 +91,16 @@ static void test_teardown(const void *user_data)
>
>         queue_destroy(data->ccc_states, free);
>
> +       bt_vcp_unregister(data->vcp_id);
>         tester_teardown_complete();
> +
> +       return FALSE;
> +}
> +
> +static void test_teardown(const void *user_data)
> +{
> +       tester_shutdown_io();
> +       g_idle_add(test_teardown_finish, (void *) user_data);
>  }
>
>  static bool ccc_state_match(const void *a, const void *b)
> @@ -163,6 +173,15 @@ done:
>                                                         sizeof(value));
>  }
>
> +static void vcp_client_attached(struct bt_vcp *vcp, void *user_data)
> +{
> +}
> +
> +static void vcp_client_detached(struct bt_vcp *vcp, void *user_data)
> +{
> +       bt_vcp_unref(vcp);

Hmm, are the multiple references to vcp that makes
test_teardown_finish not to free on bt_vcp_unref?

> +}
> +
>  static void test_server(const void *user_data)
>  {
>         struct test_data *data =3D (void *)user_data;
> @@ -188,6 +207,9 @@ static void test_server(const void *user_data)
>         data->vcp =3D bt_vcp_new(data->db, NULL);
>         g_assert(data->vcp);
>
> +       data->vcp_id =3D bt_vcp_register(vcp_client_attached,
> +                                               vcp_client_detached, NULL=
);
> +
>         data->server =3D bt_gatt_server_new(data->db, att, 64, 0);
>         g_assert(data->server);
>
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
