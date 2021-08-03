Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1E2C4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 13:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 220B060F46
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 13:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbhHCNuI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Aug 2021 09:50:08 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:55770 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236128AbhHCNuH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Aug 2021 09:50:07 -0400
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 173DnhRJ004761;
        Tue, 3 Aug 2021 22:49:43 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Tue, 03 Aug 2021 22:49:43 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 173Dngvi004753
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 3 Aug 2021 22:49:43 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v3] Bluetooth: defer cleanup of resources in
 hci_unregister_dev()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        LinMa <linma@zju.edu.cn>
References: <290fe7c7-c14f-8685-af09-419faa0e4d1f@i-love.sakura.ne.jp>
 <CAHk-=wgRzabeP3CLZmFWO5EXrqWSvSL8uKwbSYRWw2xT9RVBrQ@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <c8cf9848-1405-af75-6f05-b7b82c2619a7@i-love.sakura.ne.jp>
Date:   Tue, 3 Aug 2021 22:49:40 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgRzabeP3CLZmFWO5EXrqWSvSL8uKwbSYRWw2xT9RVBrQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 2021/08/03 2:36, Linus Torvalds wrote:
> On Mon, Aug 2, 2021 at 8:19 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> @@ -200,7 +211,7 @@ void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb)
>>         sk_for_each(sk, &hci_sk_list.head) {
>>                 struct sk_buff *nskb;
>>
>> -               if (sk->sk_state != BT_BOUND || hci_pi(sk)->hdev != hdev)
>> +               if (sk->sk_state != BT_BOUND || hci_hdev_from_sock(sk) != hdev)
>>                         continue;
>>
>>                 /* Don't send frame to the socket it came from */
> 
> I'm not convinced this is a good idea.

Well, you are right.

One caller (out of three callers) of hci_send_to_sock() is hci_si_event() from
hci_sock_dev_event(event <= HCI_DEV_DOWN) path.

This change for hci_si_event() path is wrong, for hci_si_event() calls
hci_send_to_sock() with hdev == NULL while hci_hdev_from_sock() != NULL.

  if (sk->sk_state != BT_BOUND || 1)
	continue;

makes whole hci_send_to_sock(NULL) no-op. However,

> 
> Here we use hci_hdev_from_sock() outside the socket lock, so now that
> HCI_UNREGISTER test is not very logical.
> 
> And it's positively stupid to start with a hdev, then walk the socket
> list to look up another hdev, and then check "was it the original
> hdev, but not unregistered"?
> 
> In other words - if you care about HCI_UNREGISTER state, it should be
> *above* the whole loop. Not inside of it.
> 
> So I think this test should remain just that
> 
>      hci_pi(sk)->hdev != hdev
> 
> and if HCI_UNREGISTER is relevant - and I don't think it is - it
> should have been done earlier.

now that this patch is going to remove

	sk->sk_state = BT_OPEN;
	hci_pi(sk)->hdev = NULL;

 from the sk_for_each(sk, &hci_sk_list.head) loop in hci_sock_dev_event(HCI_DEV_UNREG),
hci_sock_dev_event(event <= HCI_DEV_DOWN) after hci_sock_dev_event(HCI_DEV_UNREG) will
fail to hit the "continue;" path.


The other two callers of hci_send_to_sock() are hci_send_frame()
and hci_rx_work(). These hdev are not NULL but are subjected to
hci_sock_dev_event(HCI_DEV_UNREG) race.

Prior to this patch,

  if (sk->sk_state != BT_BOUND || hci_pi(sk)->hdev != hdev)
	continue;

was not hitting "continue;" path before hci_sock_dev_event(HCI_DEV_UNREG)
and was hitting "continue;" path after hci_sock_dev_event(HCI_DEV_UNREG),
and the same problem (i.e. failing to hit "continue;" path) exists.



Do we want to block sending frames to RAW sockets which are using dead device?

If yes, doing

  if (sk->sk_state != BT_BOUND || hci_pi(sk)->hdev != hdev ||
      (hci_pi(sk)->hdev && hci_dev_test_flag(hci_pi(sk)->hdev, HCI_UNREGISTER)))
	continue;

will block sending frames from hci_sock_dev_event(event <= HCI_DEV_DOWN) because
hci_dev_set_flag(hdev, HCI_UNREGISTER) was already called by hci_unregister_dev().

If no, just keeping

  if (sk->sk_state != BT_BOUND || hci_pi(sk)->hdev != hdev)
	continue;

is correct.



> 
>> @@ -536,8 +548,9 @@ static struct sk_buff *create_monitor_ctrl_open(struct sock *sk)
>>
>>         hdr = skb_push(skb, HCI_MON_HDR_SIZE);
>>         hdr->opcode = cpu_to_le16(HCI_MON_CTRL_OPEN);
>> -       if (hci_pi(sk)->hdev)
>> -               hdr->index = cpu_to_le16(hci_pi(sk)->hdev->id);

Prior to this patch, compiler might have generated code that reads
hci_pi(sk)->hdev for two times, and hci_sock_dev_event(HCI_DEV_UNREG)
might reset hci_pi(sk)->hdev to NULL between these two reads; leading to
NULL pointer dereference.

>> +       hdev = hci_hdev_from_sock(sk);
>> +       if (!IS_ERR(hdev))
>> +               hdr->index = cpu_to_le16(hdev->id);
> 
> Same deal. The 'id' is valid even if it's unregistered.
> 
> So either it should have generated an error earlier, or we just shouldn't care.

Well, maybe

	hdev = READ_ONCE(hci_pi(sk)->hdev);
	if (!hdev)
		hdr->index = cpu_to_le16(hdev->id);

is the better for create_monitor_ctrl_open() and create_monitor_ctrl_close(), for
it seems that create_monitor_ctrl_close() should report the same id. However,
create_monitor_ctrl_close() from hci_sock_bind() is always using HCI_DEV_NONE
because it is reachable only if hci_pi(sk)->hdev == NULL.

Only create_monitor_ctrl_close() from hci_sock_release() has possibility
of being able to use hdev->id rather than HCI_DEV_NONE. And

> 
> The fact that the old code used to do HCI_DEV_NONE seems to be more
> about the fact that the ID no longer existed.  I think that if you
> want to monitor a socket with a stale hdev, that's likely pointless
> but valid.
> 
> So I think this should just keep using the hdev->id, even for a
> HCI_UNREGISTER case.
> 
> That said, the *normal* case seems to be from the socket ioctl code,
> so it's either explicitly not yet registered, or it just got
> registered with a hdev, so I don't think it even matters. It looks
> like the only case that HCI_UNREGISTER case would happen is likely the
> magical replay case.
> 
> Which - again - I think would actually prefer the now still existing
> hdev channel id.

prior to this patch, hci_sock_dev_event(HCI_DEV_UNREG) might have suddenly
reset hci_pi(sk)->hdev to NULL, and create_monitor_ctrl_close() was forced
to choose HCI_DEV_NONE rather than the id create_monitor_ctrl_open() used.

Therefore, I think that the userspace needs to be designed to tolerate erroneous
HCI_DEV_NONE and take appropriate recovery action if HCI_DEV_NONE was reported.

So, I can't judge whether changing to

	hdev = hci_hdev_from_sock(sk);
	if (!IS_ERR(hdev))
		hdr->index = cpu_to_le16(hdev->id);

makes things better or worse.


> 
> 
>> @@ -574,8 +588,9 @@ static struct sk_buff *create_monitor_ctrl_close(struct sock *sk)
>>
>>         hdr = skb_push(skb, HCI_MON_HDR_SIZE);
>>         hdr->opcode = cpu_to_le16(HCI_MON_CTRL_CLOSE);
>> -       if (hci_pi(sk)->hdev)
>> -               hdr->index = cpu_to_le16(hci_pi(sk)->hdev->id);
>> +       hdev = hci_hdev_from_sock(sk);
>> +       if (!IS_ERR(hdev))
>> +               hdr->index = cpu_to_le16(hdev->id);
>>         else
>>                 hdr->index = cpu_to_le16(HCI_DEV_NONE);
>>         hdr->len = cpu_to_le16(skb->len - HCI_MON_HDR_SIZE);
> 
> I think the monitor_ctrl close case is exactly the same case as the
> open case above.
> 
> But the others look good to me.
> 
> So I *think* that the cases you actually want to catch are just the
> ioctl/recvmsg/sendmsg ones. Not the special "monitor the hdev" ones.
> 
> That said, if you have some test-case that argues differently, then
> hard data is obviously more valid than my blathering above.

The special "monitor the hdev" is always racy.
But "monitor the hdev" change is too subtle to handle within this patch.
Leaving "monitor the hdev" change to future patches might be the better.

I want opinions from Bluetooth developers.
