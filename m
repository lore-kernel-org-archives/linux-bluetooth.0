Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AFCC47080
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Jun 2021 20:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 663A0610A8
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Jun 2021 20:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234766AbhFAUZt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Jun 2021 16:25:49 -0400
Received: from mga02.intel.com ([134.134.136.20]:18221 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234513AbhFAUZs (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Jun 2021 16:25:48 -0400
IronPort-SDR: DpY3dwjwPqLnFSwH3KLAbhWzv/k3bIYi1HwcMvLfrg2dH+TYhk2oKwsFKui3e6MCrJav+36nik
 S0VH3g3u66Hg==
X-IronPort-AV: E=McAfee;i="6200,9189,10002"; a="190745404"
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; 
   d="scan'208";a="190745404"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2021 13:24:06 -0700
IronPort-SDR: D6f3ZM3X1m4Mv0meGhSKo+xRMoJhtClkoSSzfTto/0JKXA4xWJ33C9jSW1grvULsJo5MO/dpSi
 Gw/bI53xsKEg==
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; 
   d="scan'208";a="474379718"
Received: from winkelru-mobl1.amr.corp.intel.com ([10.209.69.37])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2021 13:24:05 -0700
Message-ID: <b86289bb96ba971ef5a26b6a255b094cc2d7ffdc.camel@linux.intel.com>
Subject: Re: [RFC 5/5] Bluetooth: hci_sync: Make use of hci_cmd_sync_queue
 set 3
From:   Tedd Ho-Jeong An <tedd.an@linux.intel.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Date:   Tue, 01 Jun 2021 13:24:05 -0700
In-Reply-To: <20210528000136.52352-5-luiz.dentz@gmail.com>
References: <20210528000136.52352-1-luiz.dentz@gmail.com>
         <20210528000136.52352-5-luiz.dentz@gmail.com>
Organization: Intel Corporation
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Thu, 2021-05-27 at 17:01 -0700, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This make use of hci_cmd_sync_queue for the following MGMT commands:
> 
>     Add Device
>     Remove Device
> 
> Tested with:
> 
> mgmt-tester -s "Add Device"
> 
> Test Summary
> ------------
> Add Device - Invalid Params 1                        Passed       0.017 seconds
> Add Device - Invalid Params 2                        Passed       0.013 seconds
> Add Device - Invalid Params 3                        Passed       0.013 seconds
> Add Device - Invalid Params 4                        Passed       0.013 seconds
> Add Device - Success 1                               Passed       0.014 seconds
> Add Device - Success 2                               Passed       0.014 seconds
> Add Device - Success 3                               Passed       0.014 seconds
> Add Device - Success 4                               Passed       0.017 seconds
> Add Device - Success 5                               Passed       0.017 seconds
> Total: 9, Passed: 9 (100.0%), Failed: 0, Not Run: 0
> Overall execution time: 0.14 seconds
> 
> mgmt-tester -s "Remove Device"
> 
> Test Summary
> ------------
> Remove Device - Invalid Params 1                     Passed       0.153 seconds
> Remove Device - Invalid Params 2                     Passed       0.014 seconds
> Remove Device - Invalid Params 3                     Passed       0.013 seconds
> Remove Device - Success 1                            Passed       0.016 seconds
> Remove Device - Success 2                            Passed       0.017 seconds
> Remove Device - Success 3                            Passed       1.022 seconds
> Remove Device - Success 4                            Passed       1.021 seconds
> Remove Device - Success 5                            Passed       1.022 seconds
> Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0
> Overall execution time: 3.29 seconds
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/hci_sync.c | 606 ++++++++++++++++++++++++++++++++++++++-
>  net/bluetooth/hci_sync.h |   2 +
>  net/bluetooth/mgmt.c     |  19 +-
>  3 files changed, 622 insertions(+), 5 deletions(-)
> 

While running new test cases for checking LL Privacy (submitted the series to mailing list),
some test cases caused the kernel oops:

general protection fault, probably for non-canonical address 0xdead000000000116: 0000 [#1] PTI
CPU: 0 PID: 113 Comm: kworker/u3:2 Not tainted 5.12.0-g01861ba6bbe9-dirty #11
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
Workqueue: hci0 hci_cmd_sync_work
RIP: 0010:hci_passive_scan_sync.part.0+0xed/0x820
Code: 7c 24 13 00 75 12 48 8b 85 00 10 00 00 48 0f ba e0 29 0f 83 97 02 00 00 80 44 24 1e 01 4d 8b 3f 4c 39 3c 24 0f 84 25 01 00 00 <41> 0f b6 57 16 4d 8d 67 10 4c 89 ef 4c 89 e6 e8 2f 95 fb ff 41 0f
RSP: 0018:ffffad9400187dc8 EFLAGS: 00010202
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff8d0a01850ca8 RSI: ffff8d0a0186a210 RDI: ffff8d0a01850000
RBP: ffff8d0a01850000 R08: ffff8d0a01803ae6 R09: 0000000000004ffb
R10: 0000000078563412 R11: 3fffffffffffffff R12: ffff8d0a0186a210
R13: ffff8d0a01850cf8 R14: ffff8d0a01850d08 R15: dead000000000100
FS:  0000000000000000(0000) GS:ffffffff87846000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000558641956130 CR3: 00000000018a2000 CR4: 00000000000006f0
Call Trace:
 ? unblock_device+0xe0/0xe0
 hci_update_background_scan_sync+0x268/0x310
 hci_cmd_sync_work+0x91/0xe0
 process_one_work+0x19d/0x2f0
 worker_thread+0x5a/0x3b0
 ? rescuer_thread+0x330/0x330
 kthread+0x108/0x120
 ? __kthread_create_worker+0xf0/0xf0
 ret_from_fork+0x22/0x30
---[ end trace efd7eab9e13c521e ]---
RIP: 0010:hci_passive_scan_sync.part.0+0xed/0x820
Code: 7c 24 13 00 75 12 48 8b 85 00 10 00 00 48 0f ba e0 29 0f 83 97 02 00 00 80 44 24 1e 01 4d 8b 3f 4c 39 3c 24 0f 84 25 01 00 00 <41> 0f b6 57 16 4d 8d 67 10 4c 89 ef 4c 89 e6 e8 2f 95 fb ff 41 0f
RSP: 0018:ffffad9400187dc8 EFLAGS: 00010202
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff8d0a01850ca8 RSI: ffff8d0a0186a210 RDI: ffff8d0a01850000
RBP: ffff8d0a01850000 R08: ffff8d0a01803ae6 R09: 0000000000004ffb
R10: 0000000078563412 R11: 3fffffffffffffff R12: ffff8d0a0186a210
R13: ffff8d0a01850cf8 R14: ffff8d0a01850d08 R15: dead000000000100
FS:  0000000000000000(0000) GS:ffffffff87846000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000558641956130 CR3: 00000000018a2000 CR4: 00000000000006f0


However, it is not seen on the current bluetooth-next tree.

Regards,

Tedd

