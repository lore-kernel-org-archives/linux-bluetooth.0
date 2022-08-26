Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C363ECAAA3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Aug 2022 06:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245008AbiHZG1Q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Aug 2022 02:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245002AbiHZG1N (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Aug 2022 02:27:13 -0400
Received: from giacobini.uberspace.de (giacobini.uberspace.de [185.26.156.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC58D11CE
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Aug 2022 23:27:09 -0700 (PDT)
Received: (qmail 20068 invoked by uid 990); 26 Aug 2022 06:27:07 -0000
Authentication-Results: giacobini.uberspace.de;
        auth=pass (plain)
Message-ID: <3beb22a0-2226-5d7f-b4ed-108094abee9a@eknoes.de>
Date:   Fri, 26 Aug 2022 08:27:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <5a667caf-642f-11d5-f4a4-6a73ed5742fa@eknoes.de>
 <CABBYNZJE4fLS+BaPL2SRU5O+A6v9hEPHf0p-Pv-R3eWNDxsqFg@mail.gmail.com>
From:   =?UTF-8?Q?S=c3=b6nke_Huster?= <soenke.huster@eknoes.de>
Subject: Re: [BUG] UAF and null pointer deref due to
 hci_le_cis_estabilished_evt / hci_le_create_big_complete_evt
In-Reply-To: <CABBYNZJE4fLS+BaPL2SRU5O+A6v9hEPHf0p-Pv-R3eWNDxsqFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -
X-Rspamd-Report: MIME_GOOD(-0.1) BAYES_HAM(-1.093528)
X-Rspamd-Score: -1.193528
Received: from unknown (HELO unkown) (::1)
        by giacobini.uberspace.de (Haraka/2.8.28) with ESMTPSA; Fri, 26 Aug 2022 08:27:06 +0200
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On 25.08.22 20:58, Luiz Augusto von Dentz wrote:
> Hi Sönke,
> 
> On Thu, Aug 25, 2022 at 8:08 AM Sönke Huster <soenke.huster@eknoes.de> wrote:
>>
>> Hi,
>>
>>
>>
>> While fuzzing I found several crashes similar to the following:
>>
>>
>>         [    5.345731] sysfs: cannot create duplicate filename '/devices/virtual/bluetooth/hci0/hci0:0'
>>
>>         [...]
>>
>>         [    5.430464] BUG: KASAN: use-after-free in klist_add_tail+0x1bd/0x200
>>
>>         [    5.430464] Write of size 8 at addr ffff88800bfcc468 by task kworker/u3:1/43
>>
>>         [    5.430464]
>>
>>         [    5.430464] CPU: 0 PID: 43 Comm: kworker/u3:1 Not tainted 5.19.0-12855-g13f222680b8f #2
>>
>>         [    5.430464] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
>>
>>         [    5.430464] Workqueue: hci0 hci_rx_work
>>
>>         [    5.430464] Call Trace:
>>
>>         [    5.430464]  <TASK>
>>
>>         [    5.430464]  dump_stack_lvl+0x45/0x5d
>>
>>         [    5.430464]  print_report.cold+0x5e/0x5e5
>>
>>         [    5.430464]  kasan_report+0xb1/0x1c0
>>
>>         [    5.430464]  klist_add_tail+0x1bd/0x200
>>
>>         [    5.430464]  device_add+0xa6b/0x1b80
>>
>>         [    5.430464]  hci_conn_add_sysfs+0x91/0x110
>>
>>         [    5.430464]  le_conn_complete_evt+0x117f/0x17d0
>>
>>         [    5.430464]  hci_le_conn_complete_evt+0x226/0x2c0
>>
>>         [    5.430464]  hci_le_meta_evt+0x2c0/0x4a0
>>
>>         [    5.430464]  hci_event_packet+0x636/0xf60
>>
>>         [    5.430464]  hci_rx_work+0xa8c/0x1000
>>
>>         [    5.430464]  process_one_work+0x8df/0x1530
>>
>>         [    5.430464]  worker_thread+0x575/0x11a0
>>
>>         [    5.430464]  kthread+0x29d/0x340
>>
>>         [    5.430464]  ret_from_fork+0x22/0x30
>>
>>         [    5.430464]  </TASK>
>>
>>         [    5.430464]
>>
>>         [    5.430464] Allocated by task 44:
>>
>>         [    5.430464]  kasan_save_stack+0x1e/0x40
>>
>>         [    5.430464]  __kasan_kmalloc+0x81/0xa0
>>
>>         [    5.430464]  device_add+0xcae/0x1b80
>>
>>         [    5.430464]  hci_conn_add_sysfs+0x91/0x110
>>
>>         [    5.430464]  le_conn_complete_evt+0x117f/0x17d0
>>
>>         [    5.430464]  hci_le_conn_complete_evt+0x226/0x2c0
>>
>>         [    5.430464]  hci_le_meta_evt+0x2c0/0x4a0
>>
>>         [    5.430464]  hci_event_packet+0x636/0xf60
>>
>>         [    5.430464]  hci_rx_work+0xa8c/0x1000
>>
>>         [    5.430464]  process_one_work+0x8df/0x1530
>>
>>         [    5.430464]  worker_thread+0x575/0x11a0
>>
>>         [    5.430464]  kthread+0x29d/0x340
>>
>>         [    5.430464]  ret_from_fork+0x22/0x30
>>
>>         [    5.430464]
>>
>>         [    5.430464] Freed by task 43:
>>
>>         [    5.430464]  kasan_save_stack+0x1e/0x40
>>
>>         [    5.430464]  kasan_set_track+0x21/0x30
>>
>>         [    5.430464]  kasan_set_free_info+0x20/0x40
>>
>>         [    5.430464]  __kasan_slab_free+0x108/0x190
>>
>>         [    5.430464]  kfree+0xa9/0x360
>>
>>         [    5.430464]  device_add+0x33a/0x1b80
>>
>>         [    5.430464]  hci_conn_add_sysfs+0x91/0x110
>>
>>         [    5.430464]  hci_le_cis_estabilished_evt+0x517/0xa70
>>
>>         [    5.430464]  hci_le_meta_evt+0x2c0/0x4a0
>>
>>         [    5.430464]  hci_event_packet+0x636/0xf60
>>
>>         [    5.430464]  hci_rx_work+0xa8c/0x1000
>>
>>         [    5.430464]  process_one_work+0x8df/0x1530
>>
>>         [    5.430464]  worker_thread+0x575/0x11a0
>>
>>         [    5.430464]  kthread+0x29d/0x340
>>
>>         [    5.430464]  ret_from_fork+0x22/0x30
>>
>>
>>
>> I think I fixed a similar issue in d5ebaa7c5f6f ("Bluetooth: hci_event: Ignore multiple conn complete events"). Here, the problem was that multiple connection complete events for the same handle called hci_conn_add_sysfs multiple times, but if it is called with an existing connection conn->dev->p is freed.
>>
>> This is because device_add is called - its documentation contains this sentence: "Do not call this routine or device_register() more than once for any device structure".
>>
>>
>>
>> This here is similar: First, an hci_le_conn_complete_evt creates a new connection.
>>
>> Afterwards, an hci_le_cis_estabilished_evt with the same handle finds that connection, and tries to add it to sysfs again, freeing conn->dev->p. Now, an event that might use that connection such as here the hci_le_conn_complete_evt triggers a use after free.
>>
>>
>>
>> I bisected this bug and it was introduced with  26afbd826ee3 ("Bluetooth: Add initial implementation of CIS connections").
>>
>>
>>
>> The same happens with hci_le_create_big_complete_evt: Here, multiple events trigger the following bug:
>>
>>
>>
>>         [    6.898080] BUG: kernel NULL pointer dereference, address: 0000000000000058
>>
>>         [    6.898081] #PF: supervisor read access in kernel mode
>>
>>         [    6.898083] #PF: error_code(0x0000) - not-present page
>>
>>         [    6.898085] Oops: 0000 [#1] PREEMPT SMP NOPTI
>>
>>         [    6.898090] Workqueue: hci0 hci_rx_work
>>
>>         [    6.898092] RIP: 0010:klist_next+0x12/0x160
>>
>>         [    6.898128] Call Trace:
>>
>>         [    6.898129]  <TASK>
>>
>>         [    6.898130]  ? bt_link_release+0x20/0x20
>>
>>         [    6.898133]  device_find_child+0x37/0xa0
>>
>>         [    6.898136]  hci_conn_del_sysfs+0x71/0xa0
>>
>>         [    6.898138]  hci_conn_cleanup+0x17a/0x2c0
>>
>>         [    6.898141]  hci_conn_del+0x14a/0x240
>>
>>         [    6.898144]  hci_le_create_big_complete_evt+0x3d8/0x470
>>
>>         [    6.898146]  ? hci_le_remote_feat_complete_evt+0x3e0/0x3e0
>>
>>         [    6.898148]  hci_le_meta_evt+0x155/0x230
>>
>>         [    6.898150]  hci_event_packet+0x328/0x820
>>
>>         [    6.898152]  ? hci_conn_drop+0x100/0x100
>>
>>         [    6.898155]  hci_rx_work+0x725/0xb70
>>
>>         [    6.898157]  process_one_work+0x2a6/0x5d0
>>
>>         [    6.898160]  worker_thread+0x4a/0x3e0
>>
>>         [    6.898162]  ? process_one_work+0x5d0/0x5d0
>>
>>         [    6.898164]  kthread+0xed/0x120
>>
>>         [    6.898165]  ? kthread_complete_and_exit+0x20/0x20
>>
>>         [    6.898167]  ret_from_fork+0x22/0x30
>>
>>         [    6.898170]  </TASK>
>>
>>
>>
>> I bisected this bug and it was introduced with eca0ae4aea66 ("Bluetooth: Add initial implementation of BIS connections").
>>
>>
>>
>> I am not really sure how to solve that. As far as I understand, previously we simply set an unused handle as connection handle, and checked for that before setting the correct handle and adding it to sysfs. But here, adding it to sysfs seems to happen in a different function and the handle is already set.
> 
> We should probably check if link-type, if it is an ISO link it shall
> not be created via Connection Complete events and they have their own
> events to create that.
> 

But then the problem of duplicate hci_le_cis_estabilished_evt / hci_le_create_big_complete_evt still exists, isn't it? For example if the connection is created through a hci_le_cis_req_evt, and afterwards two hci_le_cis_estabilished_evt arrive, the second event calls hci_conn_add_sysfs a second time which frees parts of the device structure.

>> Best
>> Sönke
> 
> 
> 
