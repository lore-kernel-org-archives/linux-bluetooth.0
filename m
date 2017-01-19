Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZK+jBHP959i-P+mQ2fX3p0fdFBYAxP8967BwEHnj=m-vQ@mail.gmail.com>
References: <CAK-EfX=FkO9JSiQhE4WXeTTr3sw9WHDPVNr6pJmOXP1PgE0L5Q@mail.gmail.com>
 <CABBYNZK+jBHP959i-P+mQ2fX3p0fdFBYAxP8967BwEHnj=m-vQ@mail.gmail.com>
From: Vincent Scheib <scheib@google.com>
Date: Thu, 19 Jan 2017 11:52:56 -0800
Message-ID: <CAK-EfXn-ZB9erfz=MTB7dT2S86TNykPtgKOY-CuUr=KJTy87aA@mail.gmail.com>
Subject: Re: GATT service blacklist
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jan 16, 2017 at 5:46 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> On Sat, Jan 14, 2017 at 6:38 AM, Vincent Scheib <scheib@google.com> wrote:
>> I just ran into this issue again (being blocked from accessing a standard
>> GATT service) when using bluez. I had an application accessing GATT
>> objects, and also the generic_access service. ...
>
> Well the general idea was to block access if there is a plugin already
> handling a certain service. Now you seem to be claiming this shouldn't
> be the case and any service can be accessed simultaneously by a plugin
> running in daemon process and an application, but I don't think this
> is always true and in some cases they may conflict, or just generate
> duplicated traffic.

Correct. Bluetooth devices are all required to have a generic_access
service, and I believe applications should be able to use the GATT
protocol to interact with that service. I think that the current
approach bluez has taken of trying to abstract this is a mistake.
There doesn't seem to be value added by doing so, but there is harm in
creating additional ways to interact, harming portability and
requiring more attention and custom code by application developers.

> Perhaps for GAP service itself it is fine to allow applications to
> access it, the problem is if we allow the application to set the name
> like you want does it notifies that do the daemon as well?

Yes. The same way multiple applications should be able to receive
notifications for one device.
