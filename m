Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20121220080447.GA561@x220>
References: <CAFOXTdcaRvGHesU_J7rW93Yp_5d438+x5xryCzAhY9QQL_-Y4Q@mail.gmail.com>
	<20121220080447.GA561@x220>
Date: Thu, 20 Dec 2012 10:02:19 +0100
Message-ID: <CAFOXTde8iSouGKEVZKG-egvPUr4LAyLnFigVa6avhpqTjXNq8A@mail.gmail.com>
Subject: Re: Authentication Rejected when pairing stereo headset
From: Andrey Voropaev <voropaev.andrey@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I've copied the output from hcidump -w to http://vandal.sdf-eu.org/hcidump.file

So far, I'm not sure how to add -d switch to bluetoothd. It is started
via dbus and this monster is not familiar to me. Can you please tell
me, which file should I edit to add the switch?

Andrey

On Thu, Dec 20, 2012 at 9:04 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Andrey,
>
> On Thu, Dec 20, 2012, Andrey Voropaev wrote:
>> when I try 'simple-agent hci0 XX:XX:XX' I always get error
>>
>> Creating device failed: org.bluez.Error.AuthenticationRejected:
>> Authentication Rejected
>>
>> I'm doing everything as root, so what could be the reason for
>> "Authentication Rejected"? Incompatible hardware? Wrong configuration?
>>
>> In which direction should I be searching?
>
> The bluetoothd debug logs (run with -d switch) would be interesting as
> well as the HCI level trace (for which you can use e.g. hcidump).
>
> Johan
