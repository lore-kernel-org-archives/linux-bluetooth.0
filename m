Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E22FC432BE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 03:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72C70601FE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 03:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238561AbhHEDpW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Aug 2021 23:45:22 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:56374
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232113AbhHEDpV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Aug 2021 23:45:21 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 11BA73F35C
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Aug 2021 03:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628135107;
        bh=APPuhfsQfqQEMobjGYPZbM2beq7YPUNg/7gJvMYzqEQ=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=k8FkWpuWU6RVUROcm4UJeUpMEfhfTleKouatsYloqzfDTd74Pcmhrn5ZSlqM37nn2
         2Z8CgQL/uM4cAGcuNyF30ImOg1UvllPEYgdVpDfKgm5cYohPFCsBtmau+PkbrLmtTh
         eXkq514pru53dFZp7+z6gPVeizJVT93TS0QY0C1IVn4yq5nhPsJjOxOTmY33aAUGxz
         sKSbWAeJ8Petu1M2Bd9AJOZ8ifFxmecpH8SZYtzu8MkaJJEh1He+qa7jaRNAVrBtIJ
         dhPzEqi1B5C4cmutra0f/BSoNL2uEAdTsURUVpqhG9V2UaVWXzGrPxIruvoVLk/UCD
         ld856R9E++8lA==
Received: by mail-ed1-f70.google.com with SMTP id cm18-20020a0564020c92b02903bc7f21d540so2475789edb.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Aug 2021 20:45:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=APPuhfsQfqQEMobjGYPZbM2beq7YPUNg/7gJvMYzqEQ=;
        b=JUBXzsbGJ20xZHpXHuLjdijl3MsMIs73L2mp9B9g7sp9jtcAwLK59MkD7sHUnGJjHR
         EZzIIw11+8/lw4M+fjIf2+Z++pm0hVMsXpQTHMb95RCxUPJID1ikHOzfca9v8NkcYUTG
         gwZ+CGDdlLizlQasgzMmalb2MV7MT1Pe4RpByUbSnkdw0OnaiS6HFk6nqB/4h2Wxw5vt
         LiBaiu9jobOG7bxtFy2zfTpZ2tVO/p5AYjygV0KjbEpklzsh4E/43vTMkLPRc6+DPvbe
         I3O1wfWk44CvA8t/iX3/+7kA5D/xMnDA4GTEYRDxZ0H6riVRucswkPDA1rE+HNiuQwZr
         MbnQ==
X-Gm-Message-State: AOAM530fCyF7pgkxLFqdX/r6ZGPgvEd4Giw+poXwQn7/89cWGzL/t1yF
        zIoWd9x6WIBVO3OEbptFCe8a97YGQgX69uJcVPccomA/aIavCR3TCljb0qF50aL7psfjcoquolK
        ehXcSIBiE9UfttEIXd/il+ifSLGP5YjHyM9qFwF62pk1F8QBT4yfX+bnbno3EFw==
X-Received: by 2002:a17:906:4e52:: with SMTP id g18mr2646046ejw.432.1628135106722;
        Wed, 04 Aug 2021 20:45:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJs7u574RmyzXvUoIjt5iNmjnIw4M3B7uVx7H1vvmyilGjodSKKXJCaZP1PbcOo+n1gu13DGiBpmXYHSHP1GI=
X-Received: by 2002:a17:906:4e52:: with SMTP id g18mr2646023ejw.432.1628135106429;
 Wed, 04 Aug 2021 20:45:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210514071452.25220-1-kai.heng.feng@canonical.com>
 <20210802030538.2023-1-hdanton@sina.com> <CAAd53p4NO3KJkn2Zp=hxQOtR8vynkJpcPmNtwv2R6z=zei056Q@mail.gmail.com>
 <20210803074722.2383-1-hdanton@sina.com> <CAAd53p6wi7pk6yFgTnG-JDd9e4zCn3F40bioYyGbAqYg5kMHZQ@mail.gmail.com>
 <20210805030024.2603-1-hdanton@sina.com>
In-Reply-To: <20210805030024.2603-1-hdanton@sina.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 5 Aug 2021 11:44:50 +0800
Message-ID: <CAAd53p439uW9D1rK07JUQFhVfs1FCvm_rECExp0JmzFHB7dGNg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Shutdown controller after workqueues are
 flushed or cancelled
To:     Hillf Danton <hdanton@sina.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bluez <linux-bluetooth@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, Aug 5, 2021 at 11:00 AM Hillf Danton <hdanton@sina.com> wrote:
>
> On Wed, 4 Aug 2021 22:35:43 +0800 Kai-Heng Feng wrote:
> >On Tue, Aug 3, 2021 at 3:47 PM Hillf Danton <hdanton@sina.com> wrote:
> >>
> >> On Tue, 3 Aug 2021 14:45:07 +0800 Kai-Heng Feng wrote:
> >> >On Mon, Aug 2, 2021 at 11:05 AM Hillf Danton <hdanton@sina.com> wrote:
> >> >>
> >> >> Given the skb_get in hci_req_sync_complete makes it safe to free skb on
> >> >> driver side, I doubt this patch is the correct fix as it is.
> >> >
> >> >Some workqueues are still active.
> >> >The shutdown() should be called at least after hci_request_cancel_all().
> >>
> >> What is muddy then is how active workqueues prevent skb_get from protecting
> >> kfree_skb. Can you spot what workqueue it is?
> >
> >I managed to reproduce the issue with another kernel splat:
> >------------[ cut here ]------------
> >kernel BUG at mm/slub.c:321!
> >invalid opcode: 0000 [#1] SMP NOPTI
> >CPU: 2 PID: 2208 Comm: kworker/u9:3 Not tainted 5.14.0-rc4+ #16
> >Hardware name: HP HP ProBook 650 G8 Notebook PC/87ED, BIOS T74 Ver.
> >01.03.04 01/07/2021
> >Workqueue: hci0 discov_update [bluetooth]
> >RIP: 0010:__slab_free+0x20c/0x3a0
> >Code: 00 44 0f b6 54 24 1a 8b 74 24 14 44 0f b6 4c 24 1b 44 8b 44 24
> >1c 48 89 44 24 08 48 8b 54 24 20 48 8b 7c 24 28 e9 ad fe ff ff <0f> 0b
> >49 3b 54 24 28 0f 85 6b ff ff ff 49 89 5c 24 20 49 89 4c 24
> >RSP: 0018:ffffaa0e4164fc50 EFLAGS: 00010246
> >RAX: ffff9cc9a217e668 RBX: ffff9cc9a217e600 RCX: ffff9cc9a217e600
> >RDX: 000000008010000e RSI: ffffd09044885f80 RDI: ffff9cc980e96500
> >RBP: ffffaa0e4164fd00 R08: 0000000000000001 R09: ffffffff885b3a4e
> >R10: ffff9cc999aab800 R11: ffff9cc9a217e600 R12: ffffd09044885f80
> >R13: ffff9cc9a217e600 R14: ffff9cc980e96500 R15: ffff9cc9a217e600
> >FS:  0000000000000000(0000) GS:ffff9cca2b900000(0000) knlGS:0000000000000000
> >CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >CR2: 00007ffe164d5b98 CR3: 000000013f410002 CR4: 0000000000770ee0
> >PKRU: 55555554
> >Call Trace:
> > ? psi_task_switch+0xc3/0x1e0
> > ? __switch_to_asm+0x36/0x70
> > ? skb_free_head+0x67/0x80
> > kmem_cache_free+0x370/0x3d0
> > ? kfree_skbmem+0x4e/0x90
> > kfree_skbmem+0x4e/0x90
> > kfree_skb+0x47/0xb0
> > __hci_req_sync+0x134/0x2a0 [bluetooth]
> > ? wait_woken+0x70/0x70
> > discov_update+0x2ae/0x310 [bluetooth]
> > process_one_work+0x21d/0x3c0
> > worker_thread+0x53/0x420
> > ? process_one_work+0x3c0/0x3c0
> > kthread+0x127/0x150
> > ? set_kthread_struct+0x50/0x50
> > ret_from_fork+0x1f/0x30
>
> [...]
>
> >
> >So hci_request_cancel_all() -> cancel_work_sync(&hdev->discov_update)
> >and can prevent the race from happening.
>
> Given
>
> __hci_req_sync
>   err = hci_req_run_skb(&req, hci_req_sync_complete);
>   kfree_skb(hdev->req_skb);
>
> hci_req_sync_complete
>   if (skb)
>         hdev->req_skb = skb_get(skb);
>
> once more skb_get makes the above race hard to understand, though it should
> better check error before freeing skb there to avoid blind free.
>
> >
> >And the kernel splat is just one symptom of the issue, most of the
>
> It fails to support your reasoning so far.

How? Most of the time the BT controller can't be brought up again
after shutdown(), and we need to stop other activities before that.
What other reasoning is expected?

Kai-Heng

>
> >time it's just "Bluetooth: hci0: HCI reset during shutdown failed" in
> >dmesg.
> >
> >Kai-Heng
>
>
> +++ x/net/bluetooth/hci_request.c
> @@ -257,8 +257,10 @@ int __hci_req_sync(struct hci_dev *hdev,
>                 break;
>         }
>
> -       kfree_skb(hdev->req_skb);
> -       hdev->req_skb = NULL;
> +       if (!err) {
> +               kfree_skb(hdev->req_skb);
> +               hdev->req_skb = NULL;
> +       }
>         hdev->req_status = hdev->req_result = 0;
>
>         bt_dev_dbg(hdev, "end: err %d", err);
