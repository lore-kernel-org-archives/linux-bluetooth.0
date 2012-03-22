Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120321081523.GC11911@aemeltch-MOBL1>
References: <1332247868-32396-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<CAA37ikb1wi8F8EZ8FU3wYyq_DDgcWMbePp0tkkkXD=hgpmU5mw@mail.gmail.com>
	<20120321081523.GC11911@aemeltch-MOBL1>
Date: Thu, 22 Mar 2012 16:00:38 -0300
Message-ID: <CAA37ikZzBg2W=YeOgwD8xfTHmpTPff-k0=P91NcwjLP9TjHmjQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Simplify L2CAP timer logic
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>,
	Ulisses Furquim <ulisses@profusion.mobi>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, Mar 21, 2012 at 5:15 AM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> Hi Ulisses,
>
> On Tue, Mar 20, 2012 at 04:56:11PM -0300, Ulisses Furquim wrote:
>> Hi Andrei,
>>
>> On Tue, Mar 20, 2012 at 9:51 AM, Andrei Emeltchenko
>> <Andrei.Emeltchenko.news@gmail.com> wrote:
>> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>> >
>> > Simplify L2CAP timers logic. Previous logic was hard to understand.
>> > Now we always hold(chan) when setting up timer and put(chan) only
>> > if work pending and we successfully cancel delayed work.
>> >
>> > If delayed work is executing it will put(chan) itself.
>>
>> The description is a lot better, thanks. However, I don't see why this
>> change is an improvement. The old code could be hard to read but then
>> we need probably some comments to clarify it, just that IMHO.
>
> Agree with you here.
>
> After further investigation I think that current code is OK, Gustavo could
> you revert the patch.

Thank you for checking this. What about a patch from you documenting
this? I already saw your commit with the missing _put(chan) in the
workers, which was great, thanks.

Regards,

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
