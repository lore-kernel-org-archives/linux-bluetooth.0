Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4A3253B78
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Mar 2025 18:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741201110; cv=none; b=NC5e03oGh0T0goX46CtGLMueILwZfN6psBB6zT9pwdvRwxl3KnOakHShR/sKDtBIpdVWNYt+XNnHyldfOmAxzzqhXdUHYZVu8CSpxvwM4PQLzfIN2VasIdxbm8qV83vIpotVbN8+/ionKMXPS381vyedurWCBY/beHY7TQ8WXLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741201110; c=relaxed/simple;
	bh=6bpEIE21dWNHaM0IUOp0/sYw8v9x7/+/NrJ8Qgfdlr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BxnLagYYyrZfqJYIC/su239BnK6Ht2vt3p8ymE5hBz1y1ysDUwOF66HH9LidYJzOoaOvF+d5lbX4JLw9BeCj2aafGjxQ6BjcRjMWg3zFpNu2NzNOkX7HYL8TTItDIBhjSuWrm2edz8dqIfi87Wuovtt0WSw2mK0vSk5ub9ImCJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALQBi9dW; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALQBi9dW"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5495888f12eso5322377e87.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Mar 2025 10:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741201107; x=1741805907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Zli9OA2e8e1BIInjBhiDH9bjxEHTZScbi+e2B+2twQ=;
        b=ALQBi9dWQ4O8Xgkqnl1fxb2UsLxZ04wpryPZ2dLoRdnTOhVtXL4+lH6630xp89DISS
         CpcTqhZ/uJFKWfCDFGIr/uBPwwa73VwhkPlSKghb0WfOiUjRurCMxm6+BxmjMs7Q9DW8
         PvEzumMUIRHGzWpkiZ+o7HDPXyxwYiWRwy3wiiwV5+nvd93sJZSDpk+jAABDd8+dN+KH
         tY9JBsGHVZmEtLXVUgNehdyN6a85E5eGII900PROVl1S1QqHuCr2wZ0PPE3qL6+RPsso
         m/vdyVo5L/5STwNhTcdlFzJEUE5UUHjskq6HHyIWJK6UE/WdScquffjjJDqxkKVD9NcJ
         4QMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741201107; x=1741805907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Zli9OA2e8e1BIInjBhiDH9bjxEHTZScbi+e2B+2twQ=;
        b=dD4117cpTgic6jUn4an0kpMfj0UhIXBUhP5V9XeYnd4VmbwuOlTUoNNkefTE8GLAmn
         uCbOOzaTZcJUevf1m0VgORspP3vJJR7604BOONgDxIsnrlYl1sk08qehaRVb+DAWyOBR
         gagQHIb/yfxtg4SY2IRIrGcCiweYWJW0WvlkyZZiZxXJ/iga41WEjFqMQaS4nX/QFA6w
         8zvjH+XTjF3Jxc8UsW1lcfoqOHP+guARp+E9XjHZUw1FP8TrmXOm0+PrTszJgIBIDj2l
         gsAyNSwKR2Lx/sW6kBoBI8DPAuWvddYrTk8Z5GSk2URVsOjJxaF+hzmRHW7+aUvtHdvJ
         QSAA==
X-Gm-Message-State: AOJu0Yz0lJeS+hD/0L51jIt+LvzMgevqAr4f8NbzXQW1m2Iuz/2AAnQ7
	keZaOHSI4an9adUsoGKe9eMF275yQ7Sx6rTLoYzkDSGEYvx/UMLvbZWOUTLuPYDtp28Q85oSXLa
	G6r4Fz7EAnL7npHMQ+MEAcK286uA=
X-Gm-Gg: ASbGnctYDbxrHK5+eE83Dpb57ZGaxvKZHoRhWTNTkpGN15wk8CXIg3VBUFRNhkDB+hj
	MVcLHLB6RSGlIX6Hw+IiuU6JymmjkoAxzJ0CSWFuT5t1ivCNYT+BT7dK+FeFdXg2DE0nCG8jxcc
	IArpGWdy9rC/+/u0U7GuKxRVt4
X-Google-Smtp-Source: AGHT+IEtWhTkzzL2xAPaBCS9qy5WHh2yojXAHnfl2/8H6D2q8EAdb/9uF8gA4rQ494WRHTncKJX19CEL9GUZ0mcUCd0=
X-Received: by 2002:a05:6512:304d:b0:540:1f7d:8bce with SMTP id
 2adb3069b0e04-5497d37709amr1443787e87.38.1741201106714; Wed, 05 Mar 2025
 10:58:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1b2a8e408573624a7b5e5e792c7e89c8315811e3.1741190102.git.pav@iki.fi>
 <7cc0c544b498337e6591610be16e9361687e0196.1741190102.git.pav@iki.fi>
In-Reply-To: <7cc0c544b498337e6591610be16e9361687e0196.1741190102.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 5 Mar 2025 13:58:14 -0500
X-Gm-Features: AQ5f1JqbjhGEO3b_Ql6WkLx5nporZGsRtuC6YNiBtrwpWYaKr1Es3Ri743k_Jf0
Message-ID: <CABBYNZ+rW_Wh+dVL9fF8uvNiQdt5351PoMR3Mb9-G8OaVWzwxQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 3/3] sco-tester: check sent SCO data is received at bthost
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Wed, Mar 5, 2025 at 10:58=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> When sending data, also check that the data is received by bthost.
> ---
>  tools/sco-tester.c | 47 ++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 45 insertions(+), 2 deletions(-)
>
> diff --git a/tools/sco-tester.c b/tools/sco-tester.c
> index 7f37ca5cf..9886481ff 100644
> --- a/tools/sco-tester.c
> +++ b/tools/sco-tester.c
> @@ -318,10 +318,51 @@ static void client_connectable_complete(uint16_t op=
code, uint8_t status,
>                 tester_setup_complete();
>  }
>
> +static void bthost_recv_data(const void *buf, uint16_t len, uint8_t stat=
us,
> +                                                               void *use=
r_data)
> +{
> +       struct test_data *data =3D user_data;
> +       const struct sco_client_data *scodata =3D data->test_data;

I had to add the following change in order to pass with these changes:

+       /* Ignore empty packet as that is used to confirm NOCP is being
+        * generated.
+        */
+       if (!len)
+               return;
+

Now I wonder if this may be a problem since it does show up as a data
packet even though it is empty, I guess for the purpose of HFP
streaming it shouldn't cause problems but if someone attempts to do
packet based checks like this it may stop working.

> +       --data->step;
> +
> +       tester_print("Client received %u bytes of data", len);
> +
> +       if (scodata->send_data && (scodata->data_len !=3D len ||
> +                       memcmp(scodata->send_data, buf, len)))
> +               tester_test_failed();
> +       else if (!data->step)
> +               tester_test_passed();
> +}
> +
> +static void bthost_sco_disconnected(void *user_data)
> +{
> +       struct test_data *data =3D user_data;
> +
> +       tester_print("SCO handle 0x%04x disconnected", data->handle);
> +
> +       data->handle =3D 0x0000;
> +}
> +
> +static void sco_new_conn(uint16_t handle, void *user_data)
> +{
> +       struct test_data *data =3D user_data;
> +       struct bthost *host;
> +
> +       tester_print("New client connection with handle 0x%04x", handle);
> +
> +       data->handle =3D handle;
> +
> +       host =3D hciemu_client_get_host(data->hciemu);
> +       bthost_add_sco_hook(host, data->handle, bthost_recv_data, data,
> +                               bthost_sco_disconnected);
> +}
> +
>  static void setup_powered_callback(uint8_t status, uint16_t length,
>                                         const void *param, void *user_dat=
a)
>  {
>         struct test_data *data =3D tester_get_data();
> +       const struct sco_client_data *scodata =3D data->test_data;
>         struct bthost *bthost;
>
>         if (status !=3D MGMT_STATUS_SUCCESS) {
> @@ -334,6 +375,9 @@ static void setup_powered_callback(uint8_t status, ui=
nt16_t length,
>         bthost =3D hciemu_client_get_host(data->hciemu);
>         bthost_set_cmd_complete_cb(bthost, client_connectable_complete, d=
ata);
>         bthost_write_scan_enable(bthost, 0x03);
> +
> +       if (scodata && scodata->send_data)
> +               bthost_set_sco_cb(bthost, sco_new_conn, data);
>  }
>
>  static void setup_powered(const void *test_data)
> @@ -740,8 +784,6 @@ static gboolean sco_connect_cb(GIOChannel *io, GIOCon=
dition cond,
>                 ssize_t ret =3D 0;
>                 unsigned int count;
>
> -               data->step =3D 0;
> -
>                 sco_tx_timestamping(data, io);
>
>                 tester_print("Writing %u*%u bytes of data",
> @@ -751,6 +793,7 @@ static gboolean sco_connect_cb(GIOChannel *io, GIOCon=
dition cond,
>                         ret =3D write(sk, scodata->send_data, scodata->da=
ta_len);
>                         if (scodata->data_len !=3D ret)
>                                 break;
> +                       data->step++;
>                 }
>                 if (scodata->data_len !=3D ret) {
>                         tester_warn("Failed to write %u bytes: %zu %s (%d=
)",
> --
> 2.48.1
>
>


--=20
Luiz Augusto von Dentz
