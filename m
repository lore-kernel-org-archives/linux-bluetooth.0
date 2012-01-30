Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1327958996.1955.162.camel@aeonflux>
References: <1327955189-4604-1-git-send-email-ulisses@profusion.mobi>
	<1327958996.1955.162.camel@aeonflux>
Date: Mon, 30 Jan 2012 19:42:11 -0200
Message-ID: <CAA37ika5CN7vRzrWQHR3s7t7R-tT-e3dq3kfLQ6Zvnun8mE+bA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] Bluetooth: Remove usage of __cancel_delayed_work()
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Jan 30, 2012 at 7:29 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Ulisses,
>
>> __cancel_delayed_work() is being used in some paths where we cannot
>> sleep waiting for the delayed work to finish. However, that function
>> might return while the timer is running and the work will be queued
>> again. Replace the calls with safer cancel_delayed_work() version
>> which spins until the timer handler finishes on other CPUs and
>> cancels the delayed work.
>>
>> Signed-off-by: Ulisses Furquim <ulisses@profusion.mobi>
>> ---
>
> I have the feeling that I already looked at this patch before. And given
> that it is v4, that might be true actually ;)
>
> Use the space between --- and diffstat to have some small changelog so I
> know what was different to the previous version.

Yes, you already seen this but I removed part of the patch to fix
another problem. Sorry, forgot to include a message so you could know
what has changed.

>> =A0include/net/bluetooth/l2cap.h | =A0 =A04 ++--
>> =A0net/bluetooth/l2cap_core.c =A0 =A0| =A0 =A06 +++---
>> =A02 files changed, 5 insertions(+), 5 deletions(-)
>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
>
> Regards
>
> Marcel

Regards,

--=20
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
