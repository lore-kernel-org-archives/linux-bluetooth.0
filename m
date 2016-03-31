Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5651FA03-C997-4DA3-B6F1-5AF85BCDC270@gmail.com>
References: <F0CC57E5-9193-483D-A2DF-33254216E6AD@gmail.com>
	<CFBCE3E1-9F51-4C87-A4BF-0D8B01C737B4@gmail.com>
	<5651FA03-C997-4DA3-B6F1-5AF85BCDC270@gmail.com>
Date: Thu, 31 Mar 2016 11:12:16 +0300
Message-ID: <CABBYNZJ7Mro+RAQ-QMYWc8=tTbw1tvU4Xwqg9Q6vzMeUs9f4CQ@mail.gmail.com>
Subject: Re: Async mismatch?
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Travis Griggs <travisgriggs@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Travis,

On Tue, Mar 29, 2016 at 2:38 AM, Travis Griggs <travisgriggs@gmail.com> wrote:
> As I try to “read the source” to figure out why my python dbus callbacks aren’t working as expected, I noted that the C source code refers to a GDBUS_EXPERIMENTAL_ASYNC_METHOD for the WriteValue method.
>
> I also noticed when I looked at the documentation for the @dbus.service.method decorator, that one of the arguments is an async callback. It seemed odd to me that it wasn’t being set. Is this a funny coincidence, two different meanings of the async word, or would it explain why these two variants of a WriteValue behavior differently:
>
> 1)       def WriteValue(self, value):
>                 print(value)
>                 seq = bytes(0 + x for x in value)
>                 myOtherModule.myFunction(seq)
>                 print("dispatched”)
>
>  only prints
>
> dbus.Array([dbus.Byte(1), dbus.Byte(2), dbus.Byte(3), dbus.Byte(4), dbus.Byte(5), dbus.Byte(6), dbus.Byte(7), dbus.Byte(8)], signature=dbus.Signature('y’))

Perhaps it is blocking in your function for some reason?

>
> But 2)  def WriteValue(self, value):
>                 print(value)
>                 seq = bytes(0 + x for x in value)
>              #    myOtherModule.myFunction(seq) <<— COMMENTED OUT
>                 print("dispatched”)
>
> now prints
>
> dbus.Array([dbus.Byte(1), dbus.Byte(2), dbus.Byte(3), dbus.Byte(4), dbus.Byte(5), dbus.Byte(6), dbus.Byte(7), dbus.Byte(8)], signature=dbus.Signature('y’))
> dispatched
>
> (it finished).
>
> I wondered if it was a timeout thing, but it appears that the timeout is set at 300 seconds? Which seems really long, I note that dbus appears to have a default timeout if you just pass -1 here, why not use that?--

The timeout is local to the caller so it makes no difference to the
receiving end since the timeout is not send within the message, and
yes the daemon uses the default timeout before giving up so I suppose
the 300 seconds is not related to bluetoothd.

-- 
Luiz Augusto von Dentz
