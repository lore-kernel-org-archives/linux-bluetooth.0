Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAF4C43334
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jul 2022 08:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbiGVIYm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Jul 2022 04:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbiGVIYl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Jul 2022 04:24:41 -0400
Received: from giacobini.uberspace.de (giacobini.uberspace.de [185.26.156.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944799E2B5
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jul 2022 01:24:38 -0700 (PDT)
Received: (qmail 14264 invoked by uid 990); 22 Jul 2022 08:24:36 -0000
Authentication-Results: giacobini.uberspace.de;
        auth=pass (plain)
Message-ID: <14882455-c7c4-8e70-09d0-780308cf67f9@eknoes.de>
Date:   Fri, 22 Jul 2022 10:24:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [BUG] Null pointer deref in aosp_do_open/msft_do_open
Content-Language: en-US
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <01bb77a3-f138-7488-9ca9-71ec4f7d21a7@eknoes.de>
 <CABBYNZ+015snDMtHOKox1iJrpdR3Jp8kXYCujMT=UNjjnDTzQA@mail.gmail.com>
From:   =?UTF-8?Q?S=c3=b6nke_Huster?= <soenke.huster@eknoes.de>
In-Reply-To: <CABBYNZ+015snDMtHOKox1iJrpdR3Jp8kXYCujMT=UNjjnDTzQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: /
X-Rspamd-Report: MIME_GOOD(-0.1) BAYES_HAM(-0.718156) SUSPICIOUS_RECIPS(1.5)
X-Rspamd-Score: 0.681843
Received: from unknown (HELO unkown) (::1)
        by giacobini.uberspace.de (Haraka/2.8.28) with ESMTPSA; Fri, 22 Jul 2022 10:24:36 +0200
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On 21.07.22 19:52, Luiz Augusto von Dentz wrote:
> Hi Sönke,
> 
> On Thu, Jul 21, 2022 at 3:16 AM Sönke Huster <soenke.huster@eknoes.de> wrote:
>>
>> Hi,
>>
>> My fuzzer found two null pointer exceptions in aosp_do_open and msft_do_open, both triggered by the
>> same frame sequence on the current bluetooth-next master.
>>
>>       BUG: kernel NULL pointer dereference, address: 0000000000000070
>>       #PF: supervisor read access in kernel mode
>>       #PF: error_code(0x0000) - not-present page
>>       PGD 0 P4D 0
>>       Oops: 0000 [#1] PREEMPT SMP NOPTI
>>       CPU: 0 PID: 41 Comm: kworker/u3:0 Not tainted 5.18.0-rc7-00850-g33b44d809538 #1
>>       Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
>>       Workqueue: hci0 hci_power_on
>>       RIP: 0010:aosp_do_open+0x7e/0x230
>>       Call Trace:
>>        <TASK>
>>        hci_dev_open_sync+0x98b/0x1060
>>        hci_power_on+0x84/0x350
>>        process_one_work+0x2a6/0x5d0
>>        worker_thread+0x4a/0x3d0
>>        ? process_one_work+0x5d0/0x5d0
>>        kthread+0xed/0x120
>>        ? kthread_complete_and_exit+0x20/0x20
>>        ret_from_fork+0x22/0x30
>>        </TASK>
>>
>> The null pointer deref occurs in the skb length check (net/bluetooth/aosp.c:64), the skb returned
>> previously by __hci_cmd_sync is null:
>>
>>         /* LE Get Vendor Capabilities Command */
>>         skb = __hci_cmd_sync(hdev, hci_opcode_pack(0x3f, 0x153), 0, NULL,
>>                              HCI_CMD_TIMEOUT);
>>         if (IS_ERR(skb)) {
>>                 bt_dev_err(hdev, "AOSP get vendor capabilities (%ld)",
>>                            PTR_ERR(skb));
>>                 return;
>>         }
>>
>>         /* A basic length check */
>>         if (skb->len < VENDOR_CAPA_BASE_SIZE)
>>
>> Bisected to: [d0b137062b2de75b264b84143d21c98abc5f5ad2] Bluetooth: hci_sync: Rework init stages
>>
>> It occurs when an AOSP resp. MSFT capable controller sends the following two different
>> Command Status (0x0f) for Reset (0x0c03) on initialization:
>>
>> Status Octet: Unknown HCI Command (0x01)
>> 0000   04 0f 04 01 02 03 0c
>>
>> Status Octet: Pending (0x00)
>> 0000   04 0f 04 00 02 03 0c
>>
>> The problem seems to be that __hci_cmd_sync returns null, and not an PTR_ERR. The affected code
>> for msft_do_open is similar (msft.c:128ff):
>>
>>         skb = __hci_cmd_sync(hdev, hdev->msft_opcode, sizeof(cp), &cp,
>>                              HCI_CMD_TIMEOUT);
>>         if (IS_ERR(skb)) {
>>                 bt_dev_err(hdev, "Failed to read MSFT supported features (%ld)",
>>                            PTR_ERR(skb));
>>                 return false;
>>         }
>>
>>         if (skb->len < sizeof(*rp)) {
>>
>> Which one is triggered depends on the device reporting itself as either AOSP or MSFT capable.
>> If it indicates both, it depends on timing.
>>
>> I think that can only be triggered by a malicious or broken Bluetooth controller, but there
>> might be an underlying issue with __hci_cmd_sync returning null instead of an ERR_PTR.
> 
> Yep that is most likely a Command Status being returned which isn't
> expected for the commands above:
> 
>     /* If command return a status event skb will be set to NULL as there are
>      * no parameters, in case of failure IS_ERR(skb) would have be set to
>      * the actual error would be found with PTR_ERR(skb).
>      */
>     if (!skb)
>         return 0;
> 

Sorry, I could not reconstruct the contents of this comment from the code and did not see that comment.
Thus, I thought there is an underlying error in the command response handling.

> So perhaps we should convert these checks to IS_ERR_OR_NULL.

OK, I'll submit a patch today.

> 
>> Best
>> Sönke
> 
> 
> 
