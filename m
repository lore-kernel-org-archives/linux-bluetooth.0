Return-Path: <jirislaby@gmail.com>
Subject: Re: bluetooth: use-after-free in vhci_send_frame
To: Dmitry Vyukov <dvyukov@google.com>, Marcel Holtmann
 <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <CACT4Y+beTdUrUdwb1Drri=eFx5Cb9b4bT7uoyBMXHvxjvDxsVw@mail.gmail.com>
 <CACT4Y+YcwPCUYmc96Pq5ReZes4O64HdMqSGzmZJjvah7bqjTMQ@mail.gmail.com>
 <56DDAC0F.7060500@suse.cz>
Cc: syzkaller <syzkaller@googlegroups.com>, Kostya Serebryany
 <kcc@google.com>, Alexander Potapenko <glider@google.com>,
 Sasha Levin <sasha.levin@oracle.com>
From: Jiri Slaby <jslaby@suse.cz>
Message-ID: <56EC2922.9080103@suse.cz>
Date: Fri, 18 Mar 2016 17:13:22 +0100
MIME-Version: 1.0
In-Reply-To: <56DDAC0F.7060500@suse.cz>
Content-Type: text/plain; charset=iso-8859-2
List-ID: <linux-bluetooth.vger.kernel.org>

On 03/07/2016, 05:27 PM, Jiri Slaby wrote:
> On 03/04/2016, 10:15 AM, Dmitry Vyukov wrote:
>> Ping.
>> Just got another one on 4.5-rc6
> 
> FWIW I've just hit that too right now.
> 
> But I haven't hit it with 4.4 which I am fuzzing by the orders of
> magnitude longer.

Scratch that, it happened on 4.4.6 today.

thanks,
-- 
js
suse labs
