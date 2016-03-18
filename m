Return-Path: <jirislaby@gmail.com>
Subject: Re: bluetooth: use-after-free in vhci_send_frame
To: Marcel Holtmann <marcel@holtmann.org>, Dmitry Vyukov <dvyukov@google.com>
References: <CACT4Y+beTdUrUdwb1Drri=eFx5Cb9b4bT7uoyBMXHvxjvDxsVw@mail.gmail.com>
 <CACT4Y+YcwPCUYmc96Pq5ReZes4O64HdMqSGzmZJjvah7bqjTMQ@mail.gmail.com>
 <56DDAC0F.7060500@suse.cz>
 <8FB90CCF-CB45-44C9-BF62-CFEE2B2B7CC5@holtmann.org>
 <CACT4Y+Y25MbZ9nvfTuW9imKV9B9-cpfZGK8orXuVwE6d_f4zQA@mail.gmail.com>
 <054BECDB-E7C1-4241-B298-FED0CEE6F3B2@holtmann.org>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 linux-bluetooth <linux-bluetooth@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, syzkaller <syzkaller@googlegroups.com>,
 Kostya Serebryany <kcc@google.com>, Alexander Potapenko <glider@google.com>,
 Sasha Levin <sasha.levin@oracle.com>
From: Jiri Slaby <jslaby@suse.cz>
Message-ID: <56EC33D5.40008@suse.cz>
Date: Fri, 18 Mar 2016 17:59:01 +0100
MIME-Version: 1.0
In-Reply-To: <054BECDB-E7C1-4241-B298-FED0CEE6F3B2@holtmann.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-bluetooth.vger.kernel.org>

On 03/08/2016, 07:32 PM, Marcel Holtmann wrote:
> that means very little to me actually. So is the real issue caused by opening /dev/vhci or is that theoretical one via some internal kernel compile time feature.

Hi, what do you think about this one?

--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -196,6 +196,11 @@ static inline ssize_t vhci_get_user(stru

                cancel_delayed_work_sync(&data->open_timeout);

+               if (data->hdev) {
+                       kfree_skb(skb);
+                       return -EBADFD;
+               }
+
                opcode = *((__u8 *) skb->data);
                skb_pull(skb, 1);


open_timeout could be in progress (raced with us) and _sync cancel
waited for vhci_create_device to actually finish and create the device
the second time.

thanks,
-- 
js
suse labs
