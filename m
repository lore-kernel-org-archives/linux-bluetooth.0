Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <501BC282.9070509@linux.intel.com>
References: <501BC0D5.8080403@linux.intel.com>
	<501BC282.9070509@linux.intel.com>
Date: Thu, 9 Aug 2012 15:29:18 +0100
Message-ID: <CAJ2qBzaLyPiwEcd2n5Kdu_Y4KMpYjvjGo+Ddk3RC1Cf6_k=K9A@mail.gmail.com>
Subject: Re: RFCOMM disconnection problem
From: Dean Jenkins <djenkins@mvista.com>
To: Frederic Danis <frederic.danis@linux.intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 3 August 2012 13:22, Frederic Danis <frederic.danis@linux.intel.com> wrote:
> On 03/08/2012 14:15, Frederic Danis wrote:
>>
>> Hello,
>>
>> When I try to disconnect Blue Stereo 200 headset (from mrhandsfree) from
>> my PC, if headset was the initiator of the connection, the low level
>> (ACL) is not disconnected.
>> The device is still visible whith "hcitool con".
>>
>> This happens with BlueZ 4.98 or from git upstream, and kernel 3.4.6.
>> There is no disconnection problem with kernel 3.2.
>>
>> I also try to revert change "Bluetooth: Fix RFCOMM session reference
>> counting issue" (commit cf33e7 in linux-stable.git) from Octavian
>> Purdila in kernel 3.4.6.
>> With this kernel I do not get disconnection problem.
>>
>> You can find attached hcidump traces.
>
>
> Make a mistake, this was kernel log for l2cap and rfcomm.
>
> Find attached hcidump traces.
>
> Fred
>
>
> --
> Frederic Danis                            Open Source Technology Center
> frederic.danis@intel.com                              Intel Corporation
>

Hi Fred,

IMHO, kernel.org's rfcomm session refcnt is fundamentally broken and
is in fact redundant. Search back in the mailing list for my previous
proposed fixes.

One obvious failure of the rfcomm session refcnt is that the refcnt
counter either starts with a value of 0 or 1 depending on which peer
initiated the connection request, that is wrong. The initiator
direction is not relevant for the session as connect and disconnect
are independent events. The refcnt should start with a value of 1 in
all cases.

I am using a 2-core ARM environment that is under high processor
loading. The rfcomm session refcnt caused kernel crashes. I used a
2.6.34 kernel but the latest 3.5-RC1 still has the poor rfcomm code.
My solution was to remove the rfcomm session refcnt and to ensure that
the freeing of the rfcomm session pointer was propagated through-out
the rfcomm core code. Some kernel crashes were due to reuse of the
freed rfcomm session pointer.

I intend to release a patchset of rfcomm fixes.

Therefore, IMHO the fix "Bluetooth: Fix RFCOMM session reference
counting issue" (commit cf33e7 in linux-stable.git) from Octavian
Purdila in kernel 3.4.6 is in fact not fixing the root cause and
introduces a misbehaviour of the refcnt. In our project, we rejected
this commit because disconnections failed.

Regards,
Dean

-- 
Dean Jenkins
Embedded Software Engineer
Professional Services UK/EMEA
MontaVista Software, LLC
