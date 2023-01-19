Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE05C00A5A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Jan 2023 04:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjASE20 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Jan 2023 23:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjASEO5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Jan 2023 23:14:57 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7736E809
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jan 2023 20:07:21 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 188so1015116ybi.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jan 2023 20:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BCYkKeaP0jpVwQ8PgtIJinHX+eSBvpLg3ojcQ1oF/Ro=;
        b=DQ8xsFbg40VQSpUYSCp3M7adIOAQ/xloUcFt0bsMI4sigJnhUI34j3uZjCctS+O+pS
         /25Kd93wd1zBhM6Sb9A5K3zpHQGuuXV69FQuQLzqc4yXBG2mTQ+FNA1NN/KYQu0us0TE
         RZc/BqjEWINAffVNeikD6R226jU14gi2YJnvah5ATZYA4Izi7GdzHYx/A/bbcv9f0oDO
         ZU5IyZ43EGV/LOYGJuzGmrp4TUKertL4ooY0Uj1m1758hJF1Bf7hhGBLkcsHirH6FbEC
         lMdkxcadtf0Xuy2QJda88eSIpj9UjCIffmc2YT7wZWIebCYL244IwHJYkdWraxVRIrPV
         XcDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BCYkKeaP0jpVwQ8PgtIJinHX+eSBvpLg3ojcQ1oF/Ro=;
        b=yL+YOKPXtBLPVlHCC/lUeSBcRiJ9WAe1diUZccngVBZxtkRUaUekZ33ug2W8ogP7Lg
         6Qi12iAZzPbyNJt+FrVa1KHY2B2jgLmxCAG3PVF2vSAeDhexUQ52PAIwKJp/4PcmDH94
         yYk7C/hMQnzyKmnMzXbRIwvYZoVCoRgUPU6VYq0KqReOoGFOOqjbRANGz7lgBKGirBNN
         TreCmgkU8SQSnwTUcon1mi1BRgChU4i7+HgqLdi68ofnywlU95SfYjvIekXpuzcqkUeH
         nr/1pq4ZQeARZtbN3XK8Zc4dVMzhJwGGOkDpg67yZtjrj6qmgYEJ9BpDvtq7K0cBxN06
         sF0A==
X-Gm-Message-State: AFqh2kpqEB3YJg0ReGAm4vkQo7ca7NlPO0oZqqpIafk6on9sqqA/VCyT
        sDMioE3hDChn7TRHltpka6IRaQtk2DiUZRkpKYCRKIkn8WufERbc
X-Google-Smtp-Source: AMrXdXtlMAARAjdaTqQdrEJ4TL1oLq95aXetHxyR87JDNVY7nrguLBt5bMBZAAFS1Ql9Bk4lod6pv+ESowetYzAU5o4=
X-Received: by 2002:a0d:f446:0:b0:4fb:4e3e:e01a with SMTP id
 d67-20020a0df446000000b004fb4e3ee01amr665ywf.55.1674100685096; Wed, 18 Jan
 2023 19:58:05 -0800 (PST)
MIME-Version: 1.0
References: <20230119013405.3870506-1-iam@sung-woo.kim> <20230119014057.3879476-1-iam@sung-woo.kim>
In-Reply-To: <20230119014057.3879476-1-iam@sung-woo.kim>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 19 Jan 2023 04:57:54 +0100
Message-ID: <CANn89iLoaar8Oo8QzmHban=5ju46Q4HqMqAs4WhcW1PZxKRqEg@mail.gmail.com>
Subject: Re: BUG: KASAN: null-ptr-deref in _raw_spin_lock_bh+0x4c/0xc0
To:     Sungwoo Kim <iam@sung-woo.kim>
Cc:     benquike@gmail.com, davem@davemloft.net, daveti@purdue.edu,
        johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com, marcel@holtmann.org, netdev@vger.kernel.org,
        pabeni@redhat.com, wuruoyu@me.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, Jan 19, 2023 at 2:41 AM Sungwoo Kim <iam@sung-woo.kim> wrote:
>
> Write of size 4 at addr 0000000000000098 by task kworker/u3:0/76
>
> CPU: 0 PID: 76 Comm: kworker/u3:0 Not tainted 6.1.0-rc2 #129
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> Workqueue: hci0 hci_rx_work
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x7b/0xb3
>  print_report+0xed/0x200
>  ? __virt_addr_valid+0x5c/0x240
>  ? kasan_addr_to_slab+0xd/0xa0
>  ? _raw_spin_lock_bh+0x4c/0xc0
>  kasan_report+0xd3/0x100
>  ? _raw_spin_lock_bh+0x4c/0xc0
>  kasan_check_range+0x2d3/0x310
>  __kasan_check_write+0x14/0x20
>  _raw_spin_lock_bh+0x4c/0xc0
>  lock_sock_nested+0x3f/0x160
>  ? queue_work_on+0x90/0xd0
>  l2cap_sock_set_shutdown_cb+0x3d/0x60
>  l2cap_disconnect_req+0x1e3/0x2e0
>  l2cap_bredr_sig_cmd+0x3d2/0x5ec0
>  ? vprintk_emit+0x29b/0x4d0
>  ? vprintk_default+0x2b/0x30
>  ? vprintk+0xdc/0x100
>  ? _printk+0x67/0x85
>  ? bt_err+0x7f/0xc0
>  ? bt_err+0x9a/0xc0
>  l2cap_recv_frame+0x7bc/0x4e10
>  ? _printk+0x67/0x85
>  ? bt_err+0x7f/0xc0
>  ? __wake_up_klogd+0xc4/0xf0
>  l2cap_recv_acldata+0x327/0x650
>  ? hci_conn_enter_active_mode+0x1b7/0x1f0
>  hci_rx_work+0x6b7/0x7c0
>  process_one_work+0x461/0xaf0
>  worker_thread+0x5f8/0xba0
>  kthread+0x1c5/0x200
>  ? process_one_work+0xaf0/0xaf0
>  ? kthread_blkcg+0x90/0x90
>  ret_from_fork+0x1f/0x30
>  </TASK>

If you plan sending more stack traces like that in the future, always
run scripts/decode_stacktrace.sh
so that the public report includes symbols.

Thanks.
