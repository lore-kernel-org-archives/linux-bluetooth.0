Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120301091024.GC25627@aemeltch-MOBL1>
References: <1327955189-4604-1-git-send-email-ulisses@profusion.mobi>
	<20120301091024.GC25627@aemeltch-MOBL1>
Date: Thu, 1 Mar 2012 10:34:41 -0300
Message-ID: <CAA37ikafkZf1O-R+-G=oqbuwH4-Au8DDaeoCpemk9YUOUfM_pg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] Bluetooth: Remove usage of __cancel_delayed_work()
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	Ulisses Furquim <ulisses@profusion.mobi>,
	linux-bluetooth@vger.kernel.org, padovan@profusion.mobi
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Mar 1, 2012 at 6:10 AM, Andrei Emeltchenko
<andrei.emeltchenko.news@gmail.com> wrote:
> Hi All,
>
> On Mon, Jan 30, 2012 at 06:26:28PM -0200, Ulisses Furquim wrote:
>> __cancel_delayed_work() is being used in some paths where we cannot
>> sleep waiting for the delayed work to finish. However, that function
>> might return while the timer is running and the work will be queued
>> again. Replace the calls with safer cancel_delayed_work() version
>> which spins until the timer handler finishes on other CPUs and
>> cancels the delayed work.
>>
>> Signed-off-by: Ulisses Furquim <ulisses@profusion.mobi>

Well, these comments are not really related to this specific patch.
This change was just a replace of functions to cancel delayed work.

> I have some questions about delayed_work usage:
>
> When setting timer with l2cap_set_timer() we hold_chan if work may be
> running. So if previous work is cancelled OK we do not hold chan.
>
> Didn't we miss hold_chan here?
>
> Then in l2cap_clear_chan we put_chan if work cancelled OK, otherwise
> put_chan is done in delayed_work so we always put_chan.
>
> I am actually seeing some crashes in rare cases related to delayed work.

Do you have a log or something? Have you added the debug info to check
hold/put usage? It'd be good to really understand the problem and fix
it. It might be we're trying to be overly smart here and left some
races. This code is very similar (if not equal) to the one we had
before with timers.

Regards,

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
