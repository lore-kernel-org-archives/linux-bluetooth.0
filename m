Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB9F883A
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Nov 2023 03:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Nsu3BO6+"
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295BC172B
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Nov 2023 19:52:46 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c5071165d5so7993651fa.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Nov 2023 19:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699847564; x=1700452364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R2Ba75TdlPt7Z2RrqQMLKTEn0hWJE90MtU1weLPwhwY=;
        b=Nsu3BO6+7QNYyiDXE8nM4MxgAwGWxztbng51+yxRiMAy7DoBu+qLDTvhyWyvC1p0WL
         ZULhempdLMU+vJqYrke9wawfN5ZVbpr4nfqTukNxNar7sjcG8BYVmCUqxsdBc1BnLu22
         K/gBMSZgRO15dcaM26qOiwVYJ91pjburBQtoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699847564; x=1700452364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R2Ba75TdlPt7Z2RrqQMLKTEn0hWJE90MtU1weLPwhwY=;
        b=irhVhaX9YttbJKLGmDf6TcFCrxNXYysiOMx7BFeHywDlmo9vn8JJwMRHBKBruYg6Az
         HTyRaRyr48CB7xVw/n7bJ6EioTO1pARrvFXQVkyUdU05cTDMMbNM4onHyNiesEtR94D9
         GIPOgC3UVx+GgumGPIocTkrtLHvObcOdHAwb0E2QkZKgUvzMeQtdxe+QlDvqwjc3NrNC
         tXbgwG4GZZ2rbDg9Lap6qP2KaDlCeHa1RtNUJyKu3YikTa4JY4mWHTY+q9TYdtetiO+n
         B1JYdBEjgWbNX1KsOGc2WiD8JMI6O7T56KYLOXpVpVwBYBwI2Pw9xotonWdB/29PsOr9
         HcHw==
X-Gm-Message-State: AOJu0Yw9eBOoF1oWJ2Y36/F1TBYF+tWgx4aaXIQZVeLZ4Jx+NQ+yeVAG
	vbbtmZTSfuyLzeeXx2n0TuyP2WqPVi5r3pFEjKcjgzrg
X-Google-Smtp-Source: AGHT+IFfpfo2GHtEj5Av/5qx8F/YcTeiDDm4WNdOh2ayJDN/r8JNBeDWGQln4ZzVDc2dK8H522Xzwg==
X-Received: by 2002:a2e:a7d4:0:b0:2c5:3139:2d04 with SMTP id x20-20020a2ea7d4000000b002c531392d04mr4485694ljp.47.1699847563623;
        Sun, 12 Nov 2023 19:52:43 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id z16-20020a2e8850000000b002c4e38436edsm843679ljj.8.2023.11.12.19.52.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 19:52:42 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2c83d37a492so15775051fa.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Nov 2023 19:52:42 -0800 (PST)
X-Received: by 2002:a2e:71a:0:b0:2c5:38d:f80b with SMTP id 26-20020a2e071a000000b002c5038df80bmr3466960ljh.6.1699847561710;
 Sun, 12 Nov 2023 19:52:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231110014605.2068231-1-yinghsu@chromium.org>
In-Reply-To: <20231110014605.2068231-1-yinghsu@chromium.org>
From: Ying Hsu <yinghsu@chromium.org>
Date: Mon, 13 Nov 2023 11:52:05 +0800
X-Gmail-Original-Message-ID: <CAAa9mD3T-ey_3LQ8vsC60f1er4xMrELyJwJsY6QpG=b_xYRKgQ@mail.gmail.com>
Message-ID: <CAAa9mD3T-ey_3LQ8vsC60f1er4xMrELyJwJsY6QpG=b_xYRKgQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] Bluetooth: Fix deadlock in vhci_send_frame
To: linux-bluetooth@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, arkadiusz.bokowy@gmail.com
Cc: linux-kernel@vger.kernel.org, chromeos-bluetooth-upstreaming@chromium.org, 
	johan.hedberg@gmail.com, marcel@holtmann.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz and Arkadiusz,

I appreciate the effort you put into ensuring the quality of the
kernel, if it looks like the review might need more time, could we
consider reverting commit 92d4abd66f70 ("Bluetooth: vhci: Fix race
when opening vhci device") in the interim? This would help maintain
stability until the new patch is approved.

Best regards,
Ying


On Fri, Nov 10, 2023 at 9:46=E2=80=AFAM Ying Hsu <yinghsu@chromium.org> wro=
te:
>
> syzbot found a potential circular dependency leading to a deadlock:
>     -> #3 (&hdev->req_lock){+.+.}-{3:3}:
>     __mutex_lock_common+0x1b6/0x1bc2 kernel/locking/mutex.c:599
>     __mutex_lock kernel/locking/mutex.c:732 [inline]
>     mutex_lock_nested+0x17/0x1c kernel/locking/mutex.c:784
>     hci_dev_do_close+0x3f/0x9f net/bluetooth/hci_core.c:551
>     hci_rfkill_set_block+0x130/0x1ac net/bluetooth/hci_core.c:935
>     rfkill_set_block+0x1e6/0x3b8 net/rfkill/core.c:345
>     rfkill_fop_write+0x2d8/0x672 net/rfkill/core.c:1274
>     vfs_write+0x277/0xcf5 fs/read_write.c:594
>     ksys_write+0x19b/0x2bd fs/read_write.c:650
>     do_syscall_x64 arch/x86/entry/common.c:55 [inline]
>     do_syscall_64+0x51/0xba arch/x86/entry/common.c:93
>     entry_SYSCALL_64_after_hwframe+0x61/0xcb
>
>     -> #2 (rfkill_global_mutex){+.+.}-{3:3}:
>     __mutex_lock_common+0x1b6/0x1bc2 kernel/locking/mutex.c:599
>     __mutex_lock kernel/locking/mutex.c:732 [inline]
>     mutex_lock_nested+0x17/0x1c kernel/locking/mutex.c:784
>     rfkill_register+0x30/0x7e3 net/rfkill/core.c:1045
>     hci_register_dev+0x48f/0x96d net/bluetooth/hci_core.c:2622
>     __vhci_create_device drivers/bluetooth/hci_vhci.c:341 [inline]
>     vhci_create_device+0x3ad/0x68f drivers/bluetooth/hci_vhci.c:374
>     vhci_get_user drivers/bluetooth/hci_vhci.c:431 [inline]
>     vhci_write+0x37b/0x429 drivers/bluetooth/hci_vhci.c:511
>     call_write_iter include/linux/fs.h:2109 [inline]
>     new_sync_write fs/read_write.c:509 [inline]
>     vfs_write+0xaa8/0xcf5 fs/read_write.c:596
>     ksys_write+0x19b/0x2bd fs/read_write.c:650
>     do_syscall_x64 arch/x86/entry/common.c:55 [inline]
>     do_syscall_64+0x51/0xba arch/x86/entry/common.c:93
>     entry_SYSCALL_64_after_hwframe+0x61/0xcb
>
>     -> #1 (&data->open_mutex){+.+.}-{3:3}:
>     __mutex_lock_common+0x1b6/0x1bc2 kernel/locking/mutex.c:599
>     __mutex_lock kernel/locking/mutex.c:732 [inline]
>     mutex_lock_nested+0x17/0x1c kernel/locking/mutex.c:784
>     vhci_send_frame+0x68/0x9c drivers/bluetooth/hci_vhci.c:75
>     hci_send_frame+0x1cc/0x2ff net/bluetooth/hci_core.c:2989
>     hci_sched_acl_pkt net/bluetooth/hci_core.c:3498 [inline]
>     hci_sched_acl net/bluetooth/hci_core.c:3583 [inline]
>     hci_tx_work+0xb94/0x1a60 net/bluetooth/hci_core.c:3654
>     process_one_work+0x901/0xfb8 kernel/workqueue.c:2310
>     worker_thread+0xa67/0x1003 kernel/workqueue.c:2457
>     kthread+0x36a/0x430 kernel/kthread.c:319
>     ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298
>
>     -> #0 ((work_completion)(&hdev->tx_work)){+.+.}-{0:0}:
>     check_prev_add kernel/locking/lockdep.c:3053 [inline]
>     check_prevs_add kernel/locking/lockdep.c:3172 [inline]
>     validate_chain kernel/locking/lockdep.c:3787 [inline]
>     __lock_acquire+0x2d32/0x77fa kernel/locking/lockdep.c:5011
>     lock_acquire+0x273/0x4d5 kernel/locking/lockdep.c:5622
>     __flush_work+0xee/0x19f kernel/workqueue.c:3090
>     hci_dev_close_sync+0x32f/0x1113 net/bluetooth/hci_sync.c:4352
>     hci_dev_do_close+0x47/0x9f net/bluetooth/hci_core.c:553
>     hci_rfkill_set_block+0x130/0x1ac net/bluetooth/hci_core.c:935
>     rfkill_set_block+0x1e6/0x3b8 net/rfkill/core.c:345
>     rfkill_fop_write+0x2d8/0x672 net/rfkill/core.c:1274
>     vfs_write+0x277/0xcf5 fs/read_write.c:594
>     ksys_write+0x19b/0x2bd fs/read_write.c:650
>     do_syscall_x64 arch/x86/entry/common.c:55 [inline]
>     do_syscall_64+0x51/0xba arch/x86/entry/common.c:93
>     entry_SYSCALL_64_after_hwframe+0x61/0xcb
>
> This change removes the need for acquiring the open_mutex in
> vhci_send_frame, thus eliminating the potential deadlock while
> maintaining the required packet ordering.
>
> Fixes: 92d4abd66f70 ("Bluetooth: vhci: Fix race when opening vhci device"=
)
> Signed-off-by: Ying Hsu <yinghsu@chromium.org>
> ---
> Tested this commit using a C reproducer on qemu-x86_64.
>
>  drivers/bluetooth/hci_vhci.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
> index f3892e9ce800..572d68d52965 100644
> --- a/drivers/bluetooth/hci_vhci.c
> +++ b/drivers/bluetooth/hci_vhci.c
> @@ -11,6 +11,7 @@
>  #include <linux/module.h>
>  #include <asm/unaligned.h>
>
> +#include <linux/atomic.h>
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/slab.h>
> @@ -44,6 +45,7 @@ struct vhci_data {
>         bool wakeup;
>         __u16 msft_opcode;
>         bool aosp_capable;
> +       atomic_t initialized;
>  };
>
>  static int vhci_open_dev(struct hci_dev *hdev)
> @@ -75,11 +77,10 @@ static int vhci_send_frame(struct hci_dev *hdev, stru=
ct sk_buff *skb)
>
>         memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
>
> -       mutex_lock(&data->open_mutex);
>         skb_queue_tail(&data->readq, skb);
> -       mutex_unlock(&data->open_mutex);
>
> -       wake_up_interruptible(&data->read_wait);
> +       if (atomic_read(&data->initialized))
> +               wake_up_interruptible(&data->read_wait);
>         return 0;
>  }
>
> @@ -464,7 +465,8 @@ static int __vhci_create_device(struct vhci_data *dat=
a, __u8 opcode)
>         skb_put_u8(skb, 0xff);
>         skb_put_u8(skb, opcode);
>         put_unaligned_le16(hdev->id, skb_put(skb, 2));
> -       skb_queue_tail(&data->readq, skb);
> +       skb_queue_head(&data->readq, skb);
> +       atomic_inc(&data->initialized);
>
>         wake_up_interruptible(&data->read_wait);
>         return 0;
> --
> 2.43.0.rc0.421.g78406f8d94-goog
>
