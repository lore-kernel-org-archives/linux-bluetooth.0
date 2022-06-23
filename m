Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8078EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jun 2022 07:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiFWHDs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Jun 2022 03:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiFWHDr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Jun 2022 03:03:47 -0400
Received: from giacobini.uberspace.de (giacobini.uberspace.de [185.26.156.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A7B4507F
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jun 2022 00:03:44 -0700 (PDT)
Received: (qmail 19597 invoked by uid 990); 23 Jun 2022 07:03:42 -0000
Authentication-Results: giacobini.uberspace.de;
        auth=pass (plain)
Message-ID: <ac96406e-9c99-510e-4e59-9d700d913446@eknoes.de>
Date:   Thu, 23 Jun 2022 09:03:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: Unexplained calls to hci_conn_add_sysfs()
Content-Language: en-US
To:     John Klug <John.Klug@multitech.com>,
        Linux-Bluetooth MailingList <linux-bluetooth@vger.kernel.org>
References: <SJ0PR13MB5755C82B210AF2FFC96C2A1AFEB29@SJ0PR13MB5755.namprd13.prod.outlook.com>
From:   =?UTF-8?Q?S=c3=b6nke_Huster?= <soenke.huster@eknoes.de>
In-Reply-To: <SJ0PR13MB5755C82B210AF2FFC96C2A1AFEB29@SJ0PR13MB5755.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: --
X-Rspamd-Report: BAYES_HAM(-2.934163) MIME_GOOD(-0.1) R_MIXED_CHARSET(0.714285)
X-Rspamd-Score: -2.319877
Received: from unknown (HELO unkown) (::1)
        by giacobini.uberspace.de (Haraka/2.8.28) with ESMTPSA; Thu, 23 Jun 2022 09:03:41 +0200
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi John,

On 23.06.22 01:39, John Klug wrote:
> Kernel v5.4.199, Bluez 5.64.
> 
> We are using btattach.  We are not seeing btattach going away, nor are we seeing a new one added (we would not expect this to happen).
> 
> But we are seeing periodic messages:
> 
> Jun 22 18:26:14 ecc8 user.err kernel: debugfs: Directory '0' with parent 'hci0' already present!
> Jun 22 18:26:14 ecc8 user.warn kernel: sysfs: cannot create duplicate filename '/devices/platform/ahb/700000.ehci/usb1/1-2/1-2.4/1-2.4:1.0/tty/ttyACM0/hci0/hci0:0'
> Jun 22 18:26:14 ecc8 user.warn kernel: CPU: 0 PID: 67 Comm: kworker/u3:0 Tainted: G           O      5.4.199 #1 
> Jun 22 18:26:14 ecc8 user.warn kernel: Hardware name: Atmel AT91SAM9
> Jun 22 18:26:14 ecc8 user.warn kernel: Workqueue: hci0 hci_rx_work [bluetooth]
> Jun 22 18:26:14 ecc8 user.warn kernel: [<c000f9e4>] (unwind_backtrace) from [<c000d3a0>] (show_stack+0x10/0x14)
> Jun 22 18:26:14 ecc8 user.warn kernel: [<c000d3a0>] (show_stack) from [<c014132c>] (sysfs_warn_dup+0x4c/0x60)
> Jun 22 18:26:14 ecc8 user.warn kernel: [<c014132c>] (sysfs_warn_dup) from [<c0141430>] (sysfs_create_dir_ns+0xb4/0xc4)
> Jun 22 18:26:14 ecc8 user.warn kernel: [<c0141430>] (sysfs_create_dir_ns) from [<c058d790>] (kobject_add_internal+0x148/0x338)
> Jun 22 18:26:14 ecc8 user.warn kernel: [<c058d790>] (kobject_add_internal) from [<c058d9fc>] (kobject_add+0x7c/0x8c)
> Jun 22 18:26:14 ecc8 user.warn kernel: [<c058d9fc>] (kobject_add) from [<c0334630>] (device_add+0x140/0x590)
> Jun 22 18:26:14 ecc8 user.warn kernel: [<c0334630>] (device_add) from [<bf103178>] (hci_conn_add_sysfs+0x50/0xb0 [bluetooth])
> Jun 22 18:26:14 ecc8 user.warn kernel: [<bf103178>] (hci_conn_add_sysfs [bluetooth]) from [<bf0edf94>] (le_conn_complete_evt+0x33c/0x3fc [bluetooth])
> Jun 22 18:26:14 ecc8 user.warn kernel: [<bf0edf94>] (le_conn_complete_evt [bluetooth]) from [<bf0f158c>] (hci_le_meta_evt+0x118/0xb10 [bluetooth])
> Jun 22 18:26:14 ecc8 user.warn kernel: [<bf0f158c>] (hci_le_meta_evt [bluetooth]) from [<bf0f41b0>] (hci_event_packet+0x222c/0x2854 [bluetooth])
> Jun 22 18:26:14 ecc8 user.warn kernel: [<bf0f41b0>] (hci_event_packet [bluetooth]) from [<bf0e4d94>] (hci_rx_work+0x1bc/0x348 [bluetooth])
> Jun 22 18:26:14 ecc8 user.warn kernel: [<bf0e4d94>] (hci_rx_work [bluetooth]) from [<c002c024>] (process_one_work+0x180/0x220)
> Jun 22 18:26:14 ecc8 user.warn kernel: [<c002c024>] (process_one_work) from [<c002ca58>] (worker_thread+0x27c/0x348)
> Jun 22 18:26:14 ecc8 user.warn kernel: [<c002ca58>] (worker_thread) from [<c0031acc>] (kthread+0x130/0x13c)
> Jun 22 18:26:14 ecc8 user.warn kernel: [<c0031acc>] (kthread) from [<c00090e0>] (ret_from_fork+0x14/0x34)
> Jun 22 18:26:14 ecc8 user.warn kernel: Exception stack(0xc6075fb0 to 0xc6075ff8)
> Jun 22 18:26:14 ecc8 user.warn kernel: 5fa0:                                     00000000 00000000 00000000 00000000
> Jun 22 18:26:14 ecc8 user.warn kernel: 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> Jun 22 18:26:14 ecc8 user.warn kernel: 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> 
> Is this to be expected?  If not, how can I track this one down?

I submitted a patch to fix this (?) and similar issues some months ago, can you check whether applying it helps?
It seems it is currently not in the stable 5.4 release.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d5ebaa7c5f6f688959e8d40840b2249ede63b8ed
