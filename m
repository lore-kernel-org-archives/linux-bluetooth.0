Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F763E0097
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 16:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861300; cv=pass; b=WrubKBvbbg13JZcdsagYfCMCPelfl/TR/d44E6D30UkAALJo3E9khhsyBuNAE1VNBVMb90pGZVDM8GGH+UfQLkfJHtRXktpuL+sVLeUsamkQChmQV40XwsF+aCFnuWkYbQcARlep9E6DsMyeqfHOegSAErhg2whuJvPoH6nQ1Qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861300; c=relaxed/simple;
	bh=7t5kLbl/UZJ6cD3DAaWZIhowuyrXFj+3XTaKtfytOsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qrGE1xZG3bQ8CrgVVhVWwx1wozBGsitUi8fE4quSZxRDD7H4er93vwKHv7nnWSN/7jdnZZ7y4IzNnq/JpoJ5qhpNiPuvvrEihAfFgZchrT+QZhTMAh9nXL4MZDziqYdyfXR4ls1K55cxdPHfXOKBCoaQEv+I7+2B+ca1DtM6Hsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBpi14RZ; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBpi14RZ"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-651bc83e74aso12864816d50.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 09:08:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778861297; cv=none;
        d=google.com; s=arc-20240605;
        b=K6HxDuzl562EBSS0+J8GP8SZ2n9ARwYMIOvwS11z+nByOwVRI/unRMu3RX6soEBcMc
         we+CKIFyirYzAKuirBDV7gQgCDOtqvt1Fw3rrgUEoSZQRXr4PdCmNWBV+gWLibKEp/WV
         ieYq/H0Zun20MuAUuTjG0jH4p+wrKysCU5NH8MZcXKGHzysZIcpS8+3BSCPDrxieO9sG
         ypW1pMCShTeDcuBsj5P8tgGI7kV2gj5fcaPxjcq9uM20dmEJ+CVflcEzlaPaf5JALK19
         +GF9VwmWgU2/lGTL2H+Y/qU7OmMezVVgoYT2WqMZcOwamkqeXP4juU0VvBpKL/W8R764
         skGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=etWtIX5UhNNjCclgBMUtcF9H6RUdCFm4B4jOE4R5mSI=;
        fh=u2YWXGZNK/xm3JAze7ZIUhjUewTfMMZwPtUBmGcN+FY=;
        b=MrSvYtYXdUe8Rsu5GH4xua8ymTyIme/ATRIVMjTINupbR/qrLH3K09ao7l28kjvp1I
         6GYB4U/kt30B67OiJAjXq7VxCVYvSPvAzj4UzzfeZdwn3RuKJm/RE2QzBvnEgEBqqdX9
         dc3uQ1U72e8oe7JqTqJxr9dTWMB+A0rPkFhxxguYZzgQarFfiFJU9t3zT1oN4SJDSy14
         ltffrm0fn6l0M0O853RML1aUgf0DeifPuS7j4k1sbvITvqWJcsaBDX5mW42BKosnja4l
         3SXel8MRjG1pGL0GAO+0ThS7whmLO6bUiyGuEJAyNjlViaypCYLIL3wEBDT02Y19XQWq
         WqUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778861297; x=1779466097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etWtIX5UhNNjCclgBMUtcF9H6RUdCFm4B4jOE4R5mSI=;
        b=gBpi14RZdhhHjNbboStTjszFKViTtvqc7Gj+6slDxI8D3JTrrE7UGI/8DDtoZFymB8
         rFlcZHiPVjSKYl3eaDgab/OGQ6VoRMQEC9K+jBbPU45lB0NIPyfx+OiK0AUDaFm6jX0s
         5v4xbB2ZNm3sy44/rlvdAZGy0hb9s+3rJEXHMdZi+YLgz3wsgnBzs7WfA3+kWmhTMkpf
         ve0Dvn7yFxIrkF+Cg11Q6V/2mIiVDHUmodGkjS8L1b1AQPebHrGqN96TGDFQUp1esT+4
         FZsdhbWFXJNxzkfLyOS1tEFZvBXS7q2D9wye7eLcPwW9zA8hc5kgE8VEfDeC6gJB0/Ew
         REAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778861297; x=1779466097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=etWtIX5UhNNjCclgBMUtcF9H6RUdCFm4B4jOE4R5mSI=;
        b=ajNO7HTCmC37mdhpRP1ONIvU3ndJPB5xNLayLAeYBKujEnuxiWxXWgTWgxa3uBPwRA
         zg6pqTeL8pn5TvCX0ZF4jCXOKGzjfsJa5MEfZwipUHyVIR0BiSau7aV+KGm1iCc4NqW9
         5Lq5G0ccouaKVkRCoCxjhM3LtEByw2e726fLjDz/vRvDXI8vyeYvaDMpCCG9oDSOvgaE
         8CPPMgmpM9+17mda4CNEW4nOT+SDadR+LtO1jp4yMNtKfKUJkSJUansVf5GvK++9bpCd
         x9l4Pc2NeoWJcgB3HkLzZG5UwWwz/S5dTZ+pFCBWKu5Rrk8fV4rd89mCqDbJzgK4L4bK
         wciw==
X-Forwarded-Encrypted: i=1; AFNElJ8CKIB5kM71Bogm5rg31nKD7d0D54uPwJvzU37wQvHu2unloUW7ZO4r8+ITf+cVyRRblokCXWZUmUivWo1yfJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwseHHWqm6sp43+jOYIEquHB0WPmDltzdCTPb3suw5EU51ddXDb
	eLTahGBN/phU3jmengcIWx6z8PgUeoJnBVLmrN/bbNjLOPXu+MRCBp72CnJ7hBrye+4U1sLh+PH
	OkIbLINhXJbHQ4+46fzQtmoMW7AIm5hY=
X-Gm-Gg: Acq92OGgkmLL82HzSfJtbcAz6oFgoObGPfrz/tFI24hLcVsaSf7SxjWIBXheRY/pFuU
	eMXTL/Rn3bm3HsbITiIIPSj0oMHAMsbp+KmzkcoZ5gqrwFEalANAN5EN8ACAZsy7+YNUr7GWrFZ
	UFOwEKHfdGsZGwW6jtDdMf32ic6nuaP1aN+tLMKvcfSW7ajYf2z0RYQbCKd6jDcZ8ZrqS5n8pv+
	kMGBgyjmf9qmRGFuxmi3lzND3rE9ubixoUEGsdR2aYUhkuVH2Bf7QgFBqteLE2q8FgJmaaZ03jB
	NWES6bJTAE5n7yJvhQg9+obKaqZj7D4zOHczk7k/PusfcyDwiACMSqE+T+656e8X9X56pw==
X-Received: by 2002:a05:690e:43d3:b0:658:ac79:ad4d with SMTP id
 956f58d0204a3-65e22869b53mr3588378d50.47.1778861297407; Fri, 15 May 2026
 09:08:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABBYNZLjreYY_BczAQr2G6L=iJjBYKksFp53CairG-6V0Cb0EA@mail.gmail.com>
 <20260515140548.393865-1-w15303746062@163.com>
In-Reply-To: <20260515140548.393865-1-w15303746062@163.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 15 May 2026 12:08:05 -0400
X-Gm-Features: AVHnY4IVRNEVNxNgiAR03-73eocXaRC0pMA7aacCJ9NkP_1-TTMuYszH23iee7E
Message-ID: <CABBYNZ+r3gm37FW5WqE79bRp+x9UZsaCtyvfz_FdixqEucAxGw@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: hci_uart: fix UAF in hci_uart_tty_close()
To: w15303746062@163.com
Cc: pmenzel@molgen.mpg.de, marcel@holtmann.org, 
	linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, greg@kroah.com, stable@vger.kernel.org, 
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 15, 2026 at 10:06=E2=80=AFAM <w15303746062@163.com> wrote:
>
> From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
>
> A Use-After-Free (UAF) vulnerability and a subsequent kernel panic were
> observed in hci_uart_write_work() due to a race condition between the
> initialization of the HCI UART line discipline and concurrent TTY hangup.
>
> This issue was triggered by our custom device emulation and fuzzing
> framework (DevGen) on the v6.18 kernel. Due to the highly timing-dependen=
t
> nature of this race condition (requiring a precise interleaving of
> TIOCVHANGUP and protocol setup), Syzkaller failed to extract a reliable
> standalone C reproducer (reproducer is too unreliable: 0.00).
>
> The crash trace is as follows:
>   ODEBUG: free active (active state 0) object: ffff88804024e870 object ty=
pe: work_struct hint: hci_uart_write_work+0x0/0x940
>   WARNING: CPU: 0 PID: 338273 at lib/debugobjects.c:612 debug_print_objec=
t+0x1a2/0x2b0
>   ...
>   Call Trace:
>    <TASK>
>    debug_check_no_obj_freed+0x3ec/0x520
>    kfree+0x3f0/0x6c0
>    hci_uart_tty_close+0x127/0x2a0
>    tty_ldisc_close+0x113/0x1a0
>    tty_ldisc_kill+0x8e/0x150
>    tty_ldisc_hangup+0x3c1/0x730
>    __tty_hangup.part.0+0x3fd/0x8a0
>    tty_ioctl+0x120f/0x1690
>    __x64_sys_ioctl+0x18f/0x210
>    do_syscall_64+0xcb/0xfa0
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>    </TASK>
>
> The issue arises because the workqueues (init_ready and write_work) are
> only flushed/cancelled if the HCI_UART_PROTO_READY flag is set. However,
> during the protocol initialization phase (HCI_UART_PROTO_INIT), the
> underlying protocol may schedule work. If a hangup occurs before the setu=
p
> completes and the READY flag is set, hci_uart_tty_close() skips the
> teardown of these workqueues and proceeds to free the `hu` struct. When
> the scheduled work executes later, it blindly dereferences the freed `hu`
> struct.
>
> Fix this by moving the workqueue teardown outside the HCI_UART_PROTO_READ=
Y
> check. Furthermore, use disable_work_sync() instead of cancel_work_sync()
> to unconditionally disable the works. This ensures that any pending works
> are cancelled and no new submissions can occur before the hci_uart
> structure is freed. Note that hu->init_ready and hu->write_work are
> initialized in hci_uart_tty_open(), so it is always safe to call
> disable_work_sync() on them in hci_uart_tty_close(), even if the protocol
> was never fully attached.
>
> Fixes: 3b799254cf6f ("Bluetooth: hci_uart: Cancel init work before unregi=
stering")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
> ---
> Changes in v4:
> - Adopted Luiz's suggestion to use disable_work_sync() instead of
>   cancel_work_sync() to prevent new work submissions during teardown.
>
> Changes in v3:
> - Added 'Cc: stable' tag as requested by the stable bot.
>
> Changes in v2:
> - Added KASAN/ODEBUG crash trace.
>
>  drivers/bluetooth/hci_ldisc.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.=
c
> index 275ea865bc29..333c1e1503e8 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -544,14 +544,20 @@ static void hci_uart_tty_close(struct tty_struct *t=
ty)
>         if (hdev)
>                 hci_uart_close(hdev);
>
> +       /*
> +        * Disable workqueues unconditionally before freeing the hu
> +        * struct, as they might be active during the PROTO_INIT phase.
> +        * Using disable_work_sync() instead of cancel_work_sync()
> +        * ensures no new submissions can occur.
> +        */
> +       disable_work_sync(&hu->init_ready);
> +       disable_work_sync(&hu->write_work);

Looks like sashiko has a problem with these being after hci_uart_close:

https://sashiko.dev/#/patchset/20260515140548.393865-1-w15303746062%40163.c=
om

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


--=20
Luiz Augusto von Dentz
