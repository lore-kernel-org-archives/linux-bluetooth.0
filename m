Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJZtU23ryoE6BUoDWD-BQMpahhVJn8rPDYn-1UX-=VOeQ@mail.gmail.com>
References: <CAMj0Yyu7Ot6xzCxTh0puAuVeV-jBuspSDMLxg_R0Y4V068zHhg@mail.gmail.com>
 <CABBYNZJnSZtmEkBb8T4urYhHw2+pqAKu77d_g3_eJ1nw=02D7A@mail.gmail.com>
 <CAMj0Yys1efPQoZPPHbPKs54c9DFWRfFjhkt4Pe3K-fYaZZiarw@mail.gmail.com>
 <CABBYNZLNzLx0+BGgLzubwOHUaMcyde6bL1hhxrHtfskt9OGbzg@mail.gmail.com>
 <CAMj0YytVTxHLY-Mkrjy9PEvNPVd-2GmX9vAK5PeLVo+kSCvAZw@mail.gmail.com>
 <CANBo3n9=-VeFh2EAwm5EcSHgBuZUzFyJDwMZDR29wwKrmgKvVg@mail.gmail.com>
 <CAMj0YytkTtekdgHnZSWbHW+zwdANvMNjgaKfym6a4n5mKWaM_Q@mail.gmail.com>
 <CAMj0Yyu1CKr934V0jcFeeY9QEYSMoS6XO+3hjQNshGE4pFe2cg@mail.gmail.com>
 <CANBo3n_NVJCha8qLAan_9yEmk_9HPuaXK96MDT8S4DTqp=_y-w@mail.gmail.com>
 <CAMj0YyuTWMxc0xJZp=z-7smmtXNtiOMy-FS4d7ePH1s-C+hVCQ@mail.gmail.com>
 <CAMj0Yyu_uh9s8rhSa36T73PRRzGNubs1f_kLYFngmFS6hH-swA@mail.gmail.com> <CABBYNZJZtU23ryoE6BUoDWD-BQMpahhVJn8rPDYn-1UX-=VOeQ@mail.gmail.com>
From: Ajay Parashar <ajay.parasha@gmail.com>
Date: Sat, 20 Aug 2016 10:31:39 +0530
Message-ID: <CAMj0YytVoPYjLaDO31KOURK4m1b-aS6E+jFbS_xjFzU8M8ARbw@mail.gmail.com>
Subject: Re: BT PAN Connection - NAP with PANU ?
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: bharat panda <bharat22bhusan@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Aug 16, 2016 at 6:41 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Ajay,
>
>>> Hi Bharat,
>>>
>>> I hope this issue has resolve at your end?
>>>
>>> i did the change as suggested by you but it did not resolve the issue.
>>> For your reference i am attaching bluetooth.conf with my change at
>>> line number 21,  can you please confirm is this the only change
>>> required ? or some more changes need to do ?
>>>
>>> I have 1 more question the interfaces name mentioned in
>>> bluetooth.conf does not match with my set up. Again i am attaching
>>> snapshot of my setup.
>>>
>>> Please let me know how this issue can be resolved at my end ?
>>>
>>> Regards
>>> Ajay
>>
>> Hi,
>>
>> Can you please provide update regarding this issue?
>> How can i solve this , i am very much locked here.
>
> Usage: ./test-network <address> [service]
>
> There should be a device object for the given address and it must
> implement org.bluez.Network1 interface, if that doesn't exist than it
> is probably due to missing SDP record.
>
> --
> Luiz Augusto von Dentz

Hi Luiz,

Thanks a lot for pointing  the right direction.
Issue was bad sequence of steps execution, i was doing pairing first
and then executing NAP server.

Now first i am executing NAP server and then pairing, so that both
devices have knowledge of NAP service.
I confirmed that this issue has resolved @ my end.

Thanks & Regards
Ajay Parashar
