Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE17194A73;
	Thu, 19 Dec 2024 19:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734635906; cv=none; b=cF8JGeQmI9U6D9++COV3n4UQa8OOwbHc7kZ4N34irN7K+gbm2O0D+riDSatk+9QPbpoIR3GezB5ebVS56wztZtLXcbfhrE4QNO3E3H/vhaMdE63T3k6X9C4A9lpGq3V+01F24qUqfIXRH8T6QmF3I39zcV92jfqVQ105xf4wnNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734635906; c=relaxed/simple;
	bh=gsFITovRAUCz48Qpkem36KKK/09MvlsvdGyC+5kn3Dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qBYhSWwPHx6Nlk6yLaMJ8ov1wtx8mOWyelurZIYINvDoSjesMn/3J/gVD2wg5q0Xw2V/3QUJEWtbRXzjuknXn9Fi03GWJjjsjBdeq6CBH+SKxL9b3K+hBtyCuR8DmyO+4BeWbkYW3EcCFgT8xtV4DFAoXIt3G0Q3FOxk5vvkdN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WP7l6A78; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WP7l6A78"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30227c56b11so12477821fa.3;
        Thu, 19 Dec 2024 11:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734635903; x=1735240703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qeqm8/fpmY0PJBD1X3xTDPRGYg3W0OXKSs0TSek86QM=;
        b=WP7l6A78ulHHJr6mAKOLvbupSNvv9aD9RqG+++qCb1Wr3yf+ks1wv1rRh4u//3ykCz
         GeJRseNWjPdH2+NmIuJWmeSmaJs57pns/SG8ffIG8aX89DQMhhPTD0YFnI0Fh3IUQ+h1
         E+0rMwjJ2oFj7SkUHqxOOMIHNYI/+MCaYTibwuv1ndvO0G5w/WF6xIrEjdW8SyWRVBFP
         gWtZqQ1Rnr0z1s2i9ftTQeLVyqfek3IwP7skBbm0d24+3RZi/1c0BBGG6ekcSKoVARsy
         iMyvGHXQA4JydG4csueeVE50gkfuQy5YSwi+4vUdFY9eVIHI8rsuEmsnevdMC7LP9vg2
         zWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734635903; x=1735240703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qeqm8/fpmY0PJBD1X3xTDPRGYg3W0OXKSs0TSek86QM=;
        b=c47a38fZQMR1U3G0mFE3bm1sdfXo9K9k9WDjRzlNV5oJtg+6niLOpsgGs2a25DEcHi
         3huRGS+BoZiTZLBVsS05rIZCiOscoF0dHCPh0V9npHZ7oV6++90mdXCVpC4XYqe7xLL6
         l7QNYCZdKX9Gbw8XgHsG72VKeT7c3F2thilmTs7lbXkafnjeq8DyVamFGnmPU6YbQ1f5
         h99ENKFSyQev0eUgDMdRf2RrFdzdrzS6yJtMHzDpeBAZkm3AA6zjc+VsUEmVjeyHfFh+
         LEq6oLhOeyW0wfjGssekPt5yZQzYOEgEuCJTgoCQifRFVNx5MR2yTNqvwWReebNpe7FX
         1MvQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7eXuosU5sSxnm3J6gvmWxo4LNinaBn2m/oZa0zIWj6lyfp9YmzgGcnsoRZTRASHo9zWJ8beQeGlHodV0U@vger.kernel.org, AJvYcCX97jI7+kut+whkl/72lJAvjyuDfZVVMG5tx7MnqYv5KzY8Gc6W7mK34Wlm5fMmFIl/D/8/PjOhTGo6xwFNc9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVu0NPbuDn0k6odc+OK1pAhAAyn5lwOxaJ5BqPZ3LNDqVmHnOq
	nJfXJ/dk7UIVtVexl8/L2yHfZO8WxH/UfYBjmNt2Upu0+bjiydq1d+XeCDzZcqIugCrF9/2yNqJ
	U7CfLh1adEMR4PcF0XDzUi9aXGtTrbL6v
X-Gm-Gg: ASbGncvBXEha9OGJwQkMsnqYR9z+GrxHy7Ey+nRgbMpdoR7/LB7JNli/l/gRGffJkNp
	QmuXoyGQ3h49xuzk+aJn/N52fjfuFr4KUIsWmSK0=
X-Google-Smtp-Source: AGHT+IHYhFEYW2GDb6SYAg+bDRIfVX9CwplULnliHANZ719sCutZcHEzvg1AnOlXFaA5xSNZwgkSyPPKntoujHy6mgM=
X-Received: by 2002:a2e:bba5:0:b0:302:40ec:a1b3 with SMTP id
 38308e7fff4ca-30468577a8emr635951fa.21.1734635902320; Thu, 19 Dec 2024
 11:18:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d159c57f-8490-4c26-79da-6ad3612c4a14@salutedevices.com>
In-Reply-To: <d159c57f-8490-4c26-79da-6ad3612c4a14@salutedevices.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 19 Dec 2024 14:18:09 -0500
Message-ID: <CABBYNZLa9amkcQzqRyiCK7acKeXiPLkfX8thMonQhXN+5PnmmQ@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: hci_uart: fix race during initialization
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, oxffffaa@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@salutedevices.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arseniy,

On Tue, Dec 17, 2024 at 3:12=E2=80=AFAM Arseniy Krasnov
<avkrasnov@salutedevices.com> wrote:
>
> 'hci_register_dev()' calls power up function, which is executed by
> kworker - 'hci_power_on()'. This function does access to bluetooth chip
> using callbacks from 'hci_ldisc.c', for example 'hci_uart_send_frame()'.
> Now 'hci_uart_send_frame()' checks 'HCI_UART_PROTO_READY' bit set, and
> if not - it fails. Problem is that 'HCI_UART_PROTO_READY' is set after
> 'hci_register_dev()', and there is tiny chance that 'hci_power_on()' will
> be executed before setting this bit. In that case HCI init logic fails.
>
> Patch moves setting of 'HCI_UART_PROTO_READY' before calling function
> 'hci_uart_register_dev()'.
>
> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> ---
>  Changelog v1->v2:
>  * Move 'set_bit()' before 'hci_uart_register_dev()' instead of
>    adding new bit 'HCI_UART_PROTO_INIT'.

What drivers/controllers this was tested with? I want to make sure
this doesn't cause regressions to other drivers if there are perhaps
some drivers assuming HCI_UART_PROTO_READY was set in a certain order.

>  drivers/bluetooth/hci_ldisc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.=
c
> index 30192bb083549..07b9aa09bbe2e 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -704,12 +704,13 @@ static int hci_uart_set_proto(struct hci_uart *hu, =
int id)
>
>         hu->proto =3D p;
>
> +       set_bit(HCI_UART_PROTO_READY, &hu->flags);
> +
>         err =3D hci_uart_register_dev(hu);
>         if (err) {
>                 return err;
>         }
>
> -       set_bit(HCI_UART_PROTO_READY, &hu->flags);
>         return 0;
>  }
>
> --
> 2.30.1



--=20
Luiz Augusto von Dentz
