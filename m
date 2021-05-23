Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842B0C4707A
	for <linux-bluetooth@archiver.kernel.org>; Sun, 23 May 2021 06:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57BA3610A2
	for <linux-bluetooth@archiver.kernel.org>; Sun, 23 May 2021 06:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbhEWGFS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 23 May 2021 02:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbhEWGFR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 23 May 2021 02:05:17 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8CEC061574
        for <linux-bluetooth@vger.kernel.org>; Sat, 22 May 2021 23:03:51 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id r7so11360027ybs.10
        for <linux-bluetooth@vger.kernel.org>; Sat, 22 May 2021 23:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=fQb+nW1GH4h5YDJ2OIoV7QP/+w8p8O7rkP2W5SrLhJo=;
        b=c8eI0YYcM6suUGFr4dWdwO+KFZZG3/OCgkNl9Z8OFmSJ3GYuC8r9vN9ezBazL+SBfm
         5DdnVSTLwBr4aJUY8dadDExESVg0Lsu+KXIjcOMLIy5iF3OpiIkZnDilsDD+gXeW5wyL
         EAnoU0CXFA/MxA0R5b/pZi9/qTPzyNDiq/PWOLIQv3NA4NO0Nwa8JKWMLtI8j/fS/Xj/
         mLyigtPHNeYUIRhXbUnLxVYMMsmeti2DqYGFP4B2c3Xj9vXwsMVLDO3H3T85vRfEKfyx
         zFLCGlYPS+3PTuVstTu3SsvAeQ+YZr3Q28mAosypjo7EPL7tA+3iKpWoyXAJWL33yU5N
         itwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=fQb+nW1GH4h5YDJ2OIoV7QP/+w8p8O7rkP2W5SrLhJo=;
        b=ao/R/VrOdHLZysuSUdz/a/it70BfPgiXzWI37Poor6Dn4a6znHLPWi14gAlk/KJ4qS
         OO7kdbwKB7iLvzjoEXSWs/E7z3EJ7rnKIwXJe+UBxIcwMJUXz3/Bgq5iasKZggtAYTcI
         iNOaBrIu8+pRT43nfHFSZA2f0AFA3U6P9LbHRH0TyC3/7ji9w6kDO6GfJ9lJLQoioivl
         Z3jXVziftXm1MG9UhJdrhuDBFwhtQjovrreIJ+Wv1t+K5ydxDnpM5dKH8FlwPnjX2HeY
         b63mdCt6AHJ4LM/tZaMKcUwVKJKl42RINIKblf4THVp2pqpxJW+2VHANRq6yY8v3BNtk
         d05w==
X-Gm-Message-State: AOAM532pPULZLH0Qg9ZN9EQNri2qf1qYh/aOkLH8Y/vzp5l2mH4bhtjA
        3GDrSZ7UhgSYnHgsKPhEchySe8SSBtZGEGH8UPouNy9+8Cc=
X-Google-Smtp-Source: ABdhPJwyx7DN0RrfSVkbVI/ZSEYiNZWIjT6OlwPhaFBaS0tU16aZggZVydTyU2YT5GGt+JlT/wXMC3j4yqbSXdzqGRA=
X-Received: by 2002:a25:cf42:: with SMTP id f63mr27479826ybg.277.1621749830709;
 Sat, 22 May 2021 23:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAJjojJtJC14p-2Y3FLHiciHhuKptnR92zHj2rig3EFx29auF8A@mail.gmail.com>
In-Reply-To: <CAJjojJtJC14p-2Y3FLHiciHhuKptnR92zHj2rig3EFx29auF8A@mail.gmail.com>
From:   Lin Horse <kylin.formalin@gmail.com>
Date:   Sun, 23 May 2021 14:03:39 +0800
Message-ID: <CAJjojJtoh3MnRwK835+HDmdmn9n+rsM8FSKaq5PHZZUEznoA-g@mail.gmail.com>
Subject: Fwd: Old OOB read bug can cause info leak
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

An old problem, which is being told or reported many times, shall be
raised here again. The point here is that this old bug can do harm and
should be fixed.

I was told that "the whole hci_event.c file is buggy and has been
known for years". This is because of the *Forced Type Conversion* in
all events handler functions. That is, these functions directly turn
the skb->data to another struct without any sanity checks. Hence, when
there are some operations that access the converted structs, OOB
access occurs.

This phenomenon has been discussed several times. Even the syzbot
found several misbehaviors.
- out of bounds read in hci_le_direct_adv_report_evt
(https://groups.google.com/g/syzkaller-lts-bugs/c/fqfVDl0SRnQ/m/b19iKC4LAwAJ)
- out of bounds read in hci_le_ext_adv_report_evt
(https://groups.google.com/g/syzkaller/c/VRLy9k6ATAo/m/Kxqjvn4JBAAJ)

and old war here: https://linuxlists.cc/l/15/linux-bluetooth/t/3072736

However, these bugs are still not properly fixed because the
developers are not aware of the harmfulness.

In this mail, I will talk about the potential info leak exploits based
on this OOB vulnerability in function hci_cc_read_local_name().


=*=*=*=*=*=*=*=*=  BUG DETAILS  =*=*=*=*=*=*=*=*=

static void hci_cc_read_local_name(struct hci_dev *hdev, struct sk_buff *skb)
{
    struct hci_rp_read_local_name *rp = (void *) skb->data; // {1}

    BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);

    if (rp->status)
        return;

    if (hci_dev_test_flag(hdev, HCI_SETUP) ||
       hci_dev_test_flag(hdev, HCI_CONFIG))
       memcpy(hdev->dev_name, rp->name, HCI_MAX_NAME_LENGTH); // {2}
    }

The mark-{1} code directly convert the skb->data to struct
hci_rp_read_local_name, without any sanity check. This dedicated
struct, hci_rp_read_local_name, owns a large buffer.

struct hci_rp_read_local_name {
    __u8     status;
    __u8     name[HCI_MAX_NAME_LENGTH]; // 248 bytes
} __packed;

Think about this: the controller emits the HCI_EV_CMD_COMPLETE event
of HCI_OP_READ_LOCAL_NAME opcode to the host, however, with a
malformed packet. The size of the crafted packet is smaller than the
expected size of struct hci_rp_read_local_name.

The driver in the host will allocate sk_buff for this packet and this
wrong size packet will be delivered to the vulnerable function
hci_cc_read_local_name(). The mark-{2} code hence will trigger
Out-Of-Bound Read vulnerability and hence read unexpected kernel heap
values into hdev->dev_name.

=*=*=*=*=*=*=*=*=  BUG EXPLOITS  =*=*=*=*=*=*=*=*=

To trigger this OOB, the attacker doesn't need any extra privilege.
That is because the Linux kernel only ask for the (NET_ADMIN)
privilege when users want to wake up the controller and ask for
nothing when the controller is being attached. The attacker can attach
a malicious controller through the pseudo-TTY device in userspace,
which is an equivalence of the VHCI driver.

Dislike the previous adv_report functions, this
hci_cc_read_local_name() will copy some unexpected heap contents into
the hdev->dev_name and can be accessed by any users through HCI
management layer.

Relevant function call trace is:
hci_sock_sendmsg() -> hci_mgmt_cmd() -> read_controller_info()

After these, any users can access the hdev->dev_name and get the
content from the unexpected OOB read. In my experiment, the exploit
can steal memory contents from slab objects in kmalloc-1k cache
stably.


=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=

In last month, Luiz proposed a great solution to fix all possible
problems caused by the forced type conversions
(https://lore.kernel.org/linux-bluetooth/20210419171257.3865181-3-luiz.dentz@gmail.com/).
Hope the community can settle down this old issue and prevent
attackers adopt the vulnerability to leak kernel memory or do other
bad things.

Regards
Lin Ma
