Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <3E482A6F-C48C-4297-A203-6D3E26AFFDA7@holtmann.org>
References: <1412028964-5298-1-git-send-email-armansito@chromium.org>
	<12072518.xz8sZz3RZr@uw000953>
	<CAHrH25SU4CMDJGukOpAzP7ZSgV3qLWBWx7+3+e7wHzX=EoL=ZA@mail.gmail.com>
	<E68A0F43-AD5C-4ED5-8724-3E43D064F5BA@holtmann.org>
	<CAHrH25TT+jSUKy_r4Pmfo5EHqQBi1hB1Hu7Qq2DQm32Y99z_FA@mail.gmail.com>
	<3E482A6F-C48C-4297-A203-6D3E26AFFDA7@holtmann.org>
Date: Wed, 1 Oct 2014 08:32:29 -0700
Message-ID: <CAHrH25RRDgorEmBUH0yfTaL8VgLoe2v6E2Vm7W-6Sqgrcgo3zw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] core: Reduce RSSI delta threshold for RSSI property
 updates on Device1.
From: Arman Uguray <armansito@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Szymon Janc <szymon.janc@tieto.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> the D-Bus API have all been designed with user interaction in mind. So it makes sense to impose this kind of extra thresholds. That is why you can map D-Bus things 1:1 to your UI and it will all nicely work.
>

I guess this falls into the overall question of designing an
application API vs an API for system UI. I always look at the D-Bus
API as an application API where system UI is one specific application.
In the end, we should be able to build use cases that require more
fine-tuned RSSI updates.

I don't know if the RSSI property of Device1 is the right thing to use
for this, though I still find it strange that it's hardwired to serve
system UI only.

In any case, I'm open to suggestions. Could we perhaps introduce a new
API for RSSI updates? Or a new property maybe? Perhaps we could expose
a property that sets the RSSI update threshold? Something like:

   int16 RSSIUpdateThreshold  [readwrite]

        Defines the minimum amount of change required (in dBm) for the
RSSI property of a device
        to be updated. Set to 8 dBm by default.

And this would be a property on Adapter1. I'm mostly thinking out loud
here though, so this may not be the best answer.

Cheers,
Arman
