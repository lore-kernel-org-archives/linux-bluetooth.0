Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <32156A77-A9BF-4542-8E26-61A398273B53@holtmann.org>
References: <1417708419-25772-1-git-send-email-luiz.dentz@gmail.com>
	<32156A77-A9BF-4542-8E26-61A398273B53@holtmann.org>
Date: Thu, 4 Dec 2014 23:15:16 +0200
Message-ID: <CABBYNZLbStqhwa3W+457Fj-dTL43mzE0+pfiBKzJA9FmEeVvEw@mail.gmail.com>
Subject: Re: [RFC BlueZ] shared/mgmt: Remove unnecessary code
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Dec 4, 2014 at 9:31 PM, Marcel Holtmann <marcel@holtmann.org> wrote=
:
> Hi Luiz,
>
>> This flags were added because calling function like queue_foreach were
>> not safe as the callbacks may remove or destroy the queue before
>> returning but this has been fixed and it is now safe to do that.
>> ---
>> src/shared/mgmt.c | 89 +++++++------------------------------------------=
------
>> 1 file changed, 11 insertions(+), 78 deletions(-)
>>
>> diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
>> index 5dae7a9..ec574c9 100644
>> --- a/src/shared/mgmt.c
>> +++ b/src/shared/mgmt.c
>> @@ -51,9 +51,6 @@ struct mgmt {
>>       struct queue *notify_list;
>>       unsigned int next_request_id;
>>       unsigned int next_notify_id;
>> -     bool need_notify_cleanup;
>> -     bool in_notify;
>> -     bool destroyed;
>
> this makes no sense to me. The handling he is for reentrant support. So a=
 lot of this handling is needed. You want to be able to remove notification=
s handlers while in callback or the other way around. We know that this is =
needed since years back we needed that with oFono and GLib. So just claimin=
g queue_foreach has some magic fix is not going to do it.

That not really magic fix, the queue now protects entries with a
reference during callback calls (it is not yet applied though), it is
a much more common protection for re-entrant code, or well at least
more common than using one flag to tell it on callback, another to do
the cleaning later and yet another one to tell the entry has been
removed already. Note that destroyed flag was not really necessary to
begin with and I could probably have it in a differen patch since it
is just a case of using mgmt_ref/mgmt_unref to protect the region
where callbacks can be called.

> Especially since some of the corner cases in mgmt.c might not be hit sinc=
e bluetoothd does not exercise them. It does not mean they are not there.

Im planning to add more unit tests for this as well, but given the
pattern is pretty much known even src/shared/io-mainloop.c does a
similar thing, from what I tested from mgmt-tester to android-tester
none had regressions with these changes but perhaps they don't really
exercise everything as you suggested.

> I am also not really in favor of just hacking src/shared/queue.c without =
considering the implications to ELL and how things are done. This is not a =
playground for quickly hacking stuff together. The long term goal is to run=
 bluetoothd on top of ELL.

That could learn how to protect entries and we could add the same unit
tests which we already have in BlueZ.


--=20
Luiz Augusto von Dentz
