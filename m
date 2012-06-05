Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <201206040917.56331.szymon.janc@tieto.com>
References: <1338507556-10920-1-git-send-email-andre.guedes@openbossa.org>
	<20120601230918.GH24769@joana>
	<201206040917.56331.szymon.janc@tieto.com>
Date: Tue, 5 Jun 2012 16:01:42 -0300
Message-ID: <CACJA=fWSwywNBrZ_-JNjEXa8nhzYi6gwQ8xnrguErRyYc6gh1w@mail.gmail.com>
Subject: Re: [RFC] Bluetooth: Fix compile warning in l2cap_core.c
From: Andre Guedes <andre.guedes@openbossa.org>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: Szymon Janc <szymon.janc@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Mon, Jun 4, 2012 at 4:17 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
> Hi,
>
>> * Andre Guedes <andre.guedes@openbossa.org> [2012-05-31 20:39:16 -0300]:
>>
>> > This patch fixes the following warning reported by gcc 4.7.0:
>> >
>> > net/bluetooth/l2cap_core.c: In function 'l2cap_config_rsp':
>> > net/bluetooth/l2cap_core.c:3302:13: warning: 'rfc.max_pdu_size' may be used uninitialized in this function [-Wmaybe-uninitialized]
>> > net/bluetooth/l2cap_core.c:3266:24: note: 'rfc.max_pdu_size' was declared here
>> > net/bluetooth/l2cap_core.c:3298:25: warning: 'rfc.monitor_timeout' may be used uninitialized in this function [-Wmaybe-uninitialized]
>> > net/bluetooth/l2cap_core.c:3266:24: note: 'rfc.monitor_timeout' was declared here
>> > net/bluetooth/l2cap_core.c:3297:25: warning: 'rfc.retrans_timeout' may be used uninitialized in this function [-Wmaybe-uninitialized]
>> > net/bluetooth/l2cap_core.c:3266:24: note: 'rfc.retrans_timeout' was declared here
>> > net/bluetooth/l2cap_core.c:3295:2: warning: 'rfc.mode' may be used uninitialized in this function [-Wmaybe-uninitialized]
>> > net/bluetooth/l2cap_core.c:3266:24: note: 'rfc.mode' was declared here
>>
>> So I think this is a false positive, I've seen this warning here for more than
>> a month, since I updated to fedora 17.
>> At some people will disable this warning in the kernel compile process if this
>> appear in others places in the kernel as false positive too.
>
> What if remote device misbehaves and sends bogus L2CAP_CONF_RFC i.e. with wrong length?

I'm not sure this is a false positive. If remote device misbehaves and
sends bogus L2CAP_CONF_RFC with wrong length (as Szymon said) we go to
"done" label and 'rfc' is used uninitialized.

BR,

Andre
