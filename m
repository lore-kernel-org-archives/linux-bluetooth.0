Return-Path: <jirislaby@gmail.com>
Subject: Re: net/bluetooth: workqueue destruction WARNING in
 hci_unregister_dev
To: Tejun Heo <tj@kernel.org>, Dmitry Vyukov <dvyukov@google.com>
References: <20160311171205.GB24046@htj.duckdns.org>
 <56EA9C4D.2080803@suse.cz> <20160318205231.GO20028@mtj.duckdns.org>
 <56F01A1C.40208@suse.cz> <56F0FDCE.1040701@suse.cz>
 <CACT4Y+b+9Ubsbfs58nHAraG+7iXRBkrn=XyCTPDJLike7w-mjQ@mail.gmail.com>
 <CACT4Y+Zs6vkjHo9qHb4TrEiz3S4+quvvVQ9VWvj2Mx6pETGb9Q@mail.gmail.com>
 <20160905130832.GD20784@mtj.duckdns.org>
 <CACT4Y+axnBPkUpMyUC74TFwq-_3Aia-fQRoSSBwbZuiguhjEaA@mail.gmail.com>
 <CACT4Y+Z2dP--yr5oJYPnAmTtzJDHbR6h=6d0nSdg6KB-qseEzg@mail.gmail.com>
 <20160913153520.GC21123@htj.duckdns.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Gustavo Padovan <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 linux-bluetooth <linux-bluetooth@vger.kernel.org>,
 netdev <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 syzkaller <syzkaller@googlegroups.com>, Kostya Serebryany <kcc@google.com>,
 Alexander Potapenko <glider@google.com>, Eric Dumazet <edumazet@google.com>,
 Takashi Iwai <tiwai@suse.com>
From: Jiri Slaby <jslaby@suse.cz>
Message-ID: <c70c2e6f-1451-0705-db14-71bc022102c6@suse.cz>
Date: Tue, 13 Sep 2016 20:14:40 +0200
MIME-Version: 1.0
In-Reply-To: <20160913153520.GC21123@htj.duckdns.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-bluetooth.vger.kernel.org>

On 09/13/2016, 05:35 PM, Tejun Heo wrote:
> Hello,
> 
> On Sat, Sep 10, 2016 at 11:33:48AM +0200, Dmitry Vyukov wrote:
>> Hit the WARNING with the patch. It showed "Showing busy workqueues and
>> worker pools:" after the WARNING, but then no queue info. Was it
>> already destroyed and removed from the list?...
> 
> Hmm...  It either means that the work item which was in flight when
> WARN_ON() ran finished by the time the debug printout got to it or
> that it's something unrelated to busy work items.
> 
>> [ 198.113838] WARNING: CPU: 2 PID: 26691 at kernel/workqueue.c:4042
>> destroy_workqueue+0x17b/0x630
> 
> I don't seem to have the same source code that you have.  Which exact
> WARN_ON() is this?

I assume Dmitry sees the same what I am still seeing, so I reported this
some time ago:
https://lkml.org/lkml/2016/3/21/492

This warning is trigerred there and still occurs with "HEAD":
  (pwq != wq->dfl_pwq) && (pwq->refcnt > 1)
and the state dump is in the log empty too:
destroy_workqueue: name='hci0' pwq=ffff88006b5c8f00
wq->dfl_pwq=ffff88006b5c9b00 pwq->refcnt=2 pwq->nr_active=0 delayed_works:
  pwq 13:
 cpus=2-3 node=1 flags=0x4 nice=-20 active=0/1
    in-flight: 2669:wq_barrier_func

thanks,
-- 
js
suse labs
