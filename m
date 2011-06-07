Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110607150202.GA1952@dell.ccr.corp.intel.com>
References: <1305936645-15007-1-git-send-email-andre.guedes@openbossa.org>
	<1305936645-15007-6-git-send-email-andre.guedes@openbossa.org>
	<BANLkTin3Q1cO0-q50fEye7=7KHxTgKmhTg@mail.gmail.com>
	<20110607150202.GA1952@dell.ccr.corp.intel.com>
Date: Tue, 7 Jun 2011 11:32:29 -0400
Message-ID: <BANLkTim0KwYnN6w+R57TKoDVXnsePWTg8g@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] Bluetooth: Advertising entries lifetime
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Andre Guedes <andre.guedes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tue, Jun 7, 2011 at 11:02 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Luiz,
>
> On Tue, Jun 07, 2011, Luiz Augusto von Dentz wrote:
>> Maybe we should not trigger the timer if the we are connected to the
>> device, this would be very convenient if a disconnect happen for
>> unknown reason e.g. bug or crash so we can quickly reconnect without
>> having to scan again, once disconnected then we start the entry timer,
>> what do you think?
>
> Initially this sounds like a good idea, however almost all of the
> devices we've tested with automatically disable advertising when
> connected so an immediate reconnect attempt like that would fail in most
> cases.

Correct. And by reading the connection procedures from specs, looks
like this is intentional, because they leave the "connectable mode".
Devices which want to be reconnected (e.g. which have a pending
indication) should reenter connectable mode manually. The spec also
describes when the adapter should re-attempt connection establishment.
Therefore, this is GATT profile specific and IMHO we cannot hard-code
connection mode behavior on the kernel.

Vol. 3, Part C, Section 9 describes all the available operational modes.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
