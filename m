Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36F73D25CB
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 12:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778848691; cv=pass; b=REVDCzJQzV9O/BE8Pz+TuPerzNongUxPq8baIlugygDPiLs+1O0FQyU4rH4fiYrXMeRbDoaRiFD7/InMZVQqw7UGeypqeqsZDoUZ1A4X1003i3lli9yO9GbPiHalMK9wiB2xBT4HRlw0dLYqxFDOUVQOUAV8fgo8bwpba6jG68c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778848691; c=relaxed/simple;
	bh=uUm1+vPKAawVjOiJgNJ7LCFjNddZhopNdukMhxVFjMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WYYfxOQOGxty4U2CW4qSbOVqtG8xPwKChYSisqTzBsAVD5WI8OiMAoVNt3x7S4qODcXATlWlYV9/08wLHQWwkWX/rD28v0JETOfTJx4bXVDElfaTICuYYmexFRZADwXZbhXUnrVxJ62TaVLjKpxK3Oa4RNW3VZUrUNvMj/3eHTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qlJArw/k; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qlJArw/k"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-65c305f381eso12808743d50.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 05:38:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778848689; cv=none;
        d=google.com; s=arc-20240605;
        b=f55or3Z87GwSKMizm84C+5yRFMweE/P8E2NvBELEeZEle/4iQ/RFTpt8zfXm05EMOZ
         OuHX9DyFb3kzw5glwHJLqeSKg3NTDd1Y0m7V5rRLaONBfcW9qocIF5RB8BF5wk9Jruht
         QPcw0A3m5ARhBTIYUyFTdcY8HsRR/oKEw7wKL0R0HcK/N4zUDEsQrkSUdkjF73EnmmEC
         bNftaj1riRsBAhFp7F3o9fOvPBLNMI2bEwjXlhdHumSw45jvtHzqzruhATRMwnTlo+/j
         NkYfQlh9dl9457WClklCaCHbwTi3BPmZ1np8HdzBjaD1O/R8mPc2qvH/S/gp8G/tueWz
         KI7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VP5YCpspQORwjSvDQCKN487lTY4JiFEf6+8HukEzf0U=;
        fh=OUnsjSnk4FYULc6i6XdDtkWYhLrNmmPVuosir0O1H6Y=;
        b=eCy1t0UDyxG7pdxqv0Z/5DbLm9mqyGxu5dw6eEep1vklySrFtwSH0U77AIjEz5PJn/
         VO6E5jimc9DwcfrHDoOqyC0ANOZwJprJdzJLVHFZ3JLF8J3GMq9pye5fdHrN881H8gjO
         0CrhNmhL909rCyRG7K3ogxe29HCBjmBxpPVJw3PyhjdyAgpdcY3HD+3ZukyADU9DM9Ww
         +UEOwI9O8oiNwtPC+FRwvCPqJnUJX+w4fBXwMr/YIndUsxgj+z+4U0KMyJHnC/P8p2PB
         XnaA4mP9HbmrnqV+6QWKipSueYKCKYtNJ1oF9BxIVj1+za8nKLvx0ohqsumbb1tjEquJ
         +yrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778848689; x=1779453489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VP5YCpspQORwjSvDQCKN487lTY4JiFEf6+8HukEzf0U=;
        b=qlJArw/kMR1FCUGHI5BNTmj/e9MRsDxxiNcB1qO/V3BHJU2QbYAaB0Ujn2zH9Asyag
         f5gyfMlsQHg6Ixixnr70+2TPNWTkJxsWkLqDHNwCcNUAI112D0focfYhE/IQGZ0k4KKq
         KK1f5M9wS22I/cTbzIxcEpRKJlWF6IxrxzYcs3dVuPWSCpAW/nSmJSpHy7/B1o6JNLvD
         Y9bAzVKyHsJszFVwK0kGBklspknU+KEjr3JJ3JMDqfHR33rmcO3yuPeHTtrefODvVawY
         YKy3u/E19bjPPVnMSmxAGckqb1bNq43Og6GJL19vuHzfXXETUSRLAJeqqmsLwIUvyBYc
         hc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778848689; x=1779453489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VP5YCpspQORwjSvDQCKN487lTY4JiFEf6+8HukEzf0U=;
        b=ZpBDVs6a13BaoVDtWN2Vswr+68dg79BghIjsU3HkbLTxTHUakV8HR2AJb3jpgHTx5z
         sVW1nUDpWTijaG441CMbPHEynmJ4QE3fCQDA2pvbCL9Nc1drx0qfg2GAJuIWkpF9TbjZ
         kZCxWBAaTWvTIgIZVzTmJOh0OrvwAYEBr/f/c4MBzkWPisVzw88WcQ+s852dFQwGUN7S
         hwWloRnfMZhEnsZAotbW5P69ibnWZC/lFeJeTiNbEhwOQ3yXR2M8YfEhjMNe5UJKJvjP
         gGR+SC/hHaJfEncSyYNdrmj1oG5HsQUuNFMCjbRUOB4paqXkwnXT77JjOYODyktNN2SW
         8sPQ==
X-Forwarded-Encrypted: i=1; AFNElJ8RbKwz+1wl59ZGudUYiNuwJpDZf4Mlml/7IAdfVnxEqi0hOgFoIH1sMVht0xWL0oFzP1qStkK3qxJ7TGQ7YMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjqYhaklJEt9hWtYq4tmWyMWmHjQs3E/WR1/ZnLjuQapLnnjAd
	HHo26qbOy89/7SNwpjQS/8x+++KoqCJi24Atjb2nMqBdl07eL4PsZ++KRMu+ovFVhz/5MiC51h4
	x8Ex8huFqYcAmvpYHIbA2L89vkPyQcwa6/o8n
X-Gm-Gg: Acq92OFtwvyd4lw6Qj89Il4OFxnyI2aZ6I9CVYHz1eQOWVdbRLO5uGyc4qQKMLS3RdL
	IlgMPt88CknKf4bI9H7MALaTbQhXGbE8+qKSPIkPMH5c+EHxGGBe81cXePPAo6V3SOV2KVyDwN/
	mLs0xDUUrc3ukMdJrmxx9+iC0DawUd6ENQsTdhnap4b46cUOPD7Xl5TCQEOLYQNjdEWTVFm/cgA
	ayuwz0tOrFkvfIdYZ6CYr8WnBBJ0SyjU/ZSc40y7IvRmqjEc93SURJGsNOJEqHVpf4A/o8NuyYD
	UwizOOe8QeCzxjOM+obtsbtgLCQyCJfu0Mu5DhyWjn9pu+M/pO3sbgZ7xK9oVEzoISUCtzZxYDa
	dG0hx
X-Received: by 2002:a05:690e:429c:10b0:65c:5fdb:e97e with SMTP id
 956f58d0204a3-65e226688d4mr3129213d50.11.1778848688513; Fri, 15 May 2026
 05:38:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513064547.352601-1-w15303746062@163.com>
In-Reply-To: <20260513064547.352601-1-w15303746062@163.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 15 May 2026 08:37:57 -0400
X-Gm-Features: AVHnY4LFlpopLYzSmAZHruAtmz5zLKfogXDk37fsSmI8BfYu6KcukqYXViunKCY
Message-ID: <CABBYNZLjreYY_BczAQr2G6L=iJjBYKksFp53CairG-6V0Cb0EA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_uart: fix UAF in hci_uart_tty_close()
To: w15303746062@163.com
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 13, 2026 at 2:46=E2=80=AFAM <w15303746062@163.com> wrote:
>
> From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
>
> A Use-After-Free (UAF) vulnerability and a subsequent General Protection
> Fault (GPF) were observed in h5_recv() due to a race condition between
> the initialization of the HCI UART line discipline and concurrent TTY
> hangup via TIOCVHANGUP.
>
> The issue arises because the workqueues (init_ready and write_work) are
> only cancelled if the HCI_UART_PROTO_READY flag is set. However, during
> the protocol initialization phase (HCI_UART_PROTO_INIT), the underlying
> protocol (e.g., H5) may schedule work (such as sending sync/config
> packets). If a hangup occurs before the setup completes and the READY
> flag is set, hci_uart_tty_close() skips the cancel_work_sync() calls
> and proceeds to free the `hu` struct.
>
> When the delayed workqueue finally executes, it blindly dereferences
> the freed `hu` struct, causing ODEBUG warnings and kernel panics.
>
> Fix this by moving the cancel_work_sync() calls outside the
> HCI_UART_PROTO_READY check, ensuring that any pending works are
> unconditionally cancelled before the hci_uart structure is freed.
>
> Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
> ---
>  drivers/bluetooth/hci_ldisc.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.=
c
> index 275ea865bc29..566e1c525ee2 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -544,14 +544,18 @@ static void hci_uart_tty_close(struct tty_struct *t=
ty)
>         if (hdev)
>                 hci_uart_close(hdev);
>
> +       /*
> +        * Always cancel workqueues unconditionally before freeing the hu
> +        * struct, as they might be active during the PROTO_INIT phase.
> +        */
> +       cancel_work_sync(&hu->init_ready);
> +       cancel_work_sync(&hu->write_work);

Can't we use disable_work_sync? If it frees up at the end, it's
probably best to disable it so it doesn't allow new submissions.

>         if (test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
>                 percpu_down_write(&hu->proto_lock);
>                 clear_bit(HCI_UART_PROTO_READY, &hu->flags);
>                 percpu_up_write(&hu->proto_lock);
>
> -               cancel_work_sync(&hu->init_ready);
> -               cancel_work_sync(&hu->write_work);
> -
>                 if (hdev) {
>                         if (test_bit(HCI_UART_REGISTERED, &hu->flags))
>                                 hci_unregister_dev(hdev);
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
