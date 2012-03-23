Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120323143321.GG10249@aemeltch-MOBL1>
References: <1332247868-32396-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<CAA37ikb1wi8F8EZ8FU3wYyq_DDgcWMbePp0tkkkXD=hgpmU5mw@mail.gmail.com>
	<20120321081523.GC11911@aemeltch-MOBL1>
	<CAA37ikZzBg2W=YeOgwD8xfTHmpTPff-k0=P91NcwjLP9TjHmjQ@mail.gmail.com>
	<20120323143321.GG10249@aemeltch-MOBL1>
Date: Fri, 23 Mar 2012 19:10:20 -0300
Message-ID: <CAA37ikYbkDeDwAhKKUEyxMngX6ZiX1Jj886agUAcvy+j-R9wnQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Simplify L2CAP timer logic
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>,
	Ulisses Furquim <ulisses@profusion.mobi>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Mar 23, 2012 at 11:33 AM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> Hi Ulisses,
>
> On Thu, Mar 22, 2012 at 04:00:38PM -0300, Ulisses Furquim wrote:
>> >> > Simplify L2CAP timers logic. Previous logic was hard to understand.
>> >> > Now we always hold(chan) when setting up timer and put(chan) only
>> >> > if work pending and we successfully cancel delayed work.
>> >> >
>> >> > If delayed work is executing it will put(chan) itself.
>> >>
>> >> The description is a lot better, thanks. However, I don't see why this
>> >> change is an improvement. The old code could be hard to read but then
>> >> we need probably some comments to clarify it, just that IMHO.
>> >
>> > Agree with you here.
>> >
>> > After further investigation I think that current code is OK, Gustavo could
>> > you revert the patch.
>>
>> Thank you for checking this. What about a patch from you documenting
>> this? I already saw your commit with the missing _put(chan) in the
>> workers, which was great, thanks.
>
> I've just sent a patch with comments how timers work.

Yes, it looks good, thanks. Marcel was faster and already acked it.

Best regards,

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
