Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49696C2B9F4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Jun 2021 17:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23B3F6023E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Jun 2021 17:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235569AbhFNRax (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Jun 2021 13:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235553AbhFNRaw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Jun 2021 13:30:52 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8203EC061767
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jun 2021 10:28:34 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id m9so16567681ybo.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jun 2021 10:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mAQKd8DmVmuefsPKPOvnnlECnXA2MB5bd8cxixwlwNE=;
        b=AuHtaMbDlYjn88067oztJ9KFk0/xGRS4cgofRwPPkpSQ5kQASvqk2or8/BN7iV+OVj
         3AnSGUfN6DAJ7O1Vu20kniwQNb3KabvoCwufQwyWSqmp7C9w0aHk+7pYeiCTs5VAw4al
         5xX9nLnDq4gbnveigx8zqueHE0rZA+om4tIfiLob8HZkXUVeqsDUI9TJbo/ZtrKOf4oq
         eKEXkTFbqGEJWAnXMUbTCkOn+pgRtmt5uJm0JqRIvtUak5FYa7ro7mx5dX/tTWIJyzTL
         6FXLEchHSpQEgSsxIONtDL9lxBKS96mZOokfyhFduXmLKT4R8Y4rHw8sIevdtyEVMr0+
         K9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mAQKd8DmVmuefsPKPOvnnlECnXA2MB5bd8cxixwlwNE=;
        b=AkTahjoIXun0Rpg1abaOxGCG/u1CazIerfN8L+HDBPcP5z6x7SDeov4hJXZ+6SSoK1
         K6bTC68Z9EinukFTZmXWuPJOgjdm4ZrG/Pa3ONRokSOl2uQqRBuz1AsIaQZ5uuDKR8FG
         vMoul1hW+cULMf+3UGVGmyBEdh8+EDfle9psaXATZnv7NIYBZ6RgxfGWY8MAe0nMyMrV
         yu8VTr3A0km2z08O5WXICKHmf4QPeI2W1X1dDKqP9RYEKzeT08Qwkq7yx4At3GzshuXn
         obtihEYYttV5uMSd/0DVY6QFk0ugsvQrdkDHEbzE5YnEXWMASj8bDawErItu8pmmIVRx
         xuCw==
X-Gm-Message-State: AOAM532Cflf8oMQhBJx8p7jZz+QN4vsB9zBlT+GtVEW4KJz+rMQ7EbbW
        NDsTW3l6corTH484BwpsRH3pC2Dnnjk2M9qQXeyfGsZHEy0=
X-Google-Smtp-Source: ABdhPJzFeQ0I2sUE4lJpjJ38gZalz5b40eyjVvcW6LHA+7xZKZEP/J5QvnWmhacEOYBTSgEqxURXjOHqlHC+Z183upA=
X-Received: by 2002:a25:c60a:: with SMTP id k10mr23544560ybf.264.1623691713660;
 Mon, 14 Jun 2021 10:28:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAFJ_xbpkmBv4O8EPN0DRNYEzBEFcm1dj+ae765626nd+PPbo3Q@mail.gmail.com>
In-Reply-To: <CAFJ_xbpkmBv4O8EPN0DRNYEzBEFcm1dj+ae765626nd+PPbo3Q@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 14 Jun 2021 10:28:22 -0700
Message-ID: <CABBYNZL-qvNyeATZcaK2v3jia66o4Rn_0fsPfZg1euOJqo8-ug@mail.gmail.com>
Subject: Re: PROBLEM: Crash after Bluetooth: SMP: Convert BT_ERR/BT_DBG to bt_dev_err/bt_dev_dbg
To:     Lukasz Majczak <lma@semihalf.com>, "An, Tedd" <tedd.an@intel.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>, upstream@semihalf.com,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Alex Levin <levinale@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Lukasz,

On Mon, Jun 14, 2021 at 6:32 AM Lukasz Majczak <lma@semihalf.com> wrote:
>
> Hi,
>
> I was testing v5.13-rc5 and I have noticed it sometimes crashes giving
> the following logs:
>
> [   13.886255] Bluetooth: rfcomm_init() RFCOMM ver 1.11
> [   14.654758] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [   14.662562] #PF: supervisor read access in kernel mode
> [   14.668319] #PF: error_code(0x0000) - not-present page
> [   14.674080] PGD 0 P4D 0
> [   14.676923] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [   14.681802] CPU: 0 PID: 2647 Comm: kworker/u17:2 Tainted: G     U
>          5.13.0-rc5 #2
> [   14.691052] Hardware name: Google Delbin/Delbin, BIOS
> Google_Delbin.13672.156.3 05/14/2021
> [   14.700289] Workqueue: hci0 hci_rx_work [bluetooth]
> [   14.705776] RIP: 0010:smp_new_conn_cb+0xd/0xb0 [bluetooth]
> [   14.711920] Code: 47 c5 6b c0 48 89 d9 31 c0 e8 aa 31 00 00 48 8b
> 3b be 13 00 00 00 5b 5d e9 8d b4 fc ff 55 48 89 e5 41 56 53 49 89 fe
> 48 8b 07 <48> 8b 00 48 8b 90 c0 05 00 00 48 83 c2 48 48 c7 c7 53 c58
> [   14.732905] RSP: 0018:ffffba9fc2a5bc88 EFLAGS: 00010246
> [   14.738755] RAX: 0000000000000000 RBX: 0000000000000002 RCX: ffff9f373f23ad00
> [   14.746748] RDX: 0000000000000000 RSI: ffffffff88df7c90 RDI: ffff9f3760e51c00
> [   14.754718] RBP: ffffba9fc2a5bc98 R08: 0000000000000000 R09: fefefefefefefeff
> [   14.762678] R10: 0000000000000018 R11: ffffffffc06a93d3 R12: ffff9f37344fe000
> [   14.770657] R13: ffff9f3760e51f28 R14: ffff9f3760e51c00 R15: ffff9f3757aab540
> [   14.778625] FS:  0000000000000000(0000) GS:ffff9f3878000000(0000)
> knlGS:0000000000000000
> [   14.787672] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   14.794099] CR2: 0000000000000000 CR3: 000000012e6dc003 CR4: 0000000000770ef0
> [   14.802070] PKRU: 55555554
> [   14.805087] Call Trace:
> [   14.807815]  l2cap_connect_cfm+0x15b/0x3b1 [bluetooth]
> [   14.813574]  hci_le_meta_evt+0x8c2/0xb76 [bluetooth]
> [   14.819136]  ? newidle_balance+0x200/0x36f
> [   14.823724]  hci_event_packet+0x6f1/0x844 [bluetooth]
> [   14.829383]  hci_rx_work+0x121/0x338 [bluetooth]
> [   14.834557]  process_one_work+0x1b9/0x368
> [   14.839038]  worker_thread+0x213/0x372
> [   14.843222]  ? _raw_spin_unlock_irqrestore+0x12/0x2c
> [   14.848782]  kthread+0x150/0x15f
> [   14.852384]  ? pr_cont_work+0x58/0x58
> [   14.856477]  ? kthread_blkcg+0x31/0x31
> [   14.860663]  ret_from_fork+0x1f/0x30
> [   14.864655] Modules linked in: rfcomm cmac algif_hash
> algif_skcipher af_alg vhost_vsock vhost vhost_iotlb
> vmw_vsock_virtio_transport_common vsock uinput mei_hdcp xt_cgroup
> btusb cdc_ether usbnet btrtl s1
> [   14.864691]  iwlwifi cfg80211 joydev
> [   14.968673] gsmi: Log Shutdown Reason 0x03
> [   14.973278] CR2: 0000000000000000
> [   14.976991] ---[ end trace 9e1b3a2966a93e69 ]---
> [   14.984499] RIP: 0010:smp_new_conn_cb+0xd/0xb0 [bluetooth]
> [   14.990648] Code: 47 c5 6b c0 48 89 d9 31 c0 e8 aa 31 00 00 48 8b
> 3b be 13 00 00 00 5b 5d e9 8d b4 fc ff 55 48 89 e5 41 56 53 49 89 fe
> 48 8b 07 <48> 8b 00 48 8b 90 c0 05 00 00 48 83 c2 48 48 c7 c7 53 c58
> [   15.011645] RSP: 0018:ffffba9fc2a5bc88 EFLAGS: 00010246
> [   15.017481] RAX: 0000000000000000 RBX: 0000000000000002 RCX: ffff9f373f23ad00
> [   15.025449] RDX: 0000000000000000 RSI: ffffffff88df7c90 RDI: ffff9f3760e51c00
> [   15.033418] RBP: ffffba9fc2a5bc98 R08: 0000000000000000 R09: fefefefefefefeff
> [   15.041387] R10: 0000000000000018 R11: ffffffffc06a93d3 R12: ffff9f37344fe000
> [   15.049361] R13: ffff9f3760e51f28 R14: ffff9f3760e51c00 R15: ffff9f3757aab540
> [   15.057336] FS:  0000000000000000(0000) GS:ffff9f3878000000(0000)
> knlGS:0000000000000000
> [   15.066380] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   15.072797] CR2: 0000000000000000 CR3: 000000012e6dc003 CR4: 0000000000770ef0
> [   15.080768] PKRU: 55555554
> [   15.083775] Kernel panic - not syncing: Fatal exception
> [   15.089661] Kernel Offset: 0x6a00000 from 0xffffffff81000000
> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [   15.102110] gsmi: Log Shutdown Reason 0x02
> [   15.108941] ACPI MEMORY or I/O RESET_REG.
>
> After short debug it pointed to the commit:
>
> commit 2e1614f7d61e407f1a8e7935a2903a6fa3cb0b11
> Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Date:   Mon Mar 15 14:39:29 2021 -0700
>
>     Bluetooth: SMP: Convert BT_ERR/BT_DBG to bt_dev_err/bt_dev_dbg
>
> In my case it looks like "conn" appears to be NULL,
> at the following call (function: smp_new_conn_cb, net/bluetooth/smp.c)
> bt_dev_dbg(pchan->conn->hcon->hdev, "created chan %p", chan);

Just sent a patch for it, looks like our CI doesn't enable debug logs
so we were not able to test it properly.

-- 
Luiz Augusto von Dentz
