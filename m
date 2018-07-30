Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b22c52f2a72344e284ad555b13526f7f887354de.camel@hadess.net>
References: <20180727130218.16975-1-luiz.dentz@gmail.com> <b22c52f2a72344e284ad555b13526f7f887354de.camel@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 30 Jul 2018 09:53:56 +0300
Message-ID: <CABBYNZKjYdYJf6ZzhAa6JKWxJi5Y_+y-DO=nNBGYYkwXpOkQbw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] core: Add AlwaysPairable to main.conf
To: Bastien Nocera <hadess@hadess.net>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Jul 27, 2018 at 5:17 PM, Bastien Nocera <hadess@hadess.net> wrote:
> On Fri, 2018-07-27 at 16:02 +0300, Luiz Augusto von Dentz wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> This adds a new option called AlwaysPairable to main.conf, it can be
>> used to enable Adapter.Pairable even in case there is no Agent
>> available.
>>
>> Since that could be consider a security problem to allow pairing
>> without user's consent the option defaults to false.
>
> This seems to work as expected. After disabling the agent in
> bluetoothctl, and making the adapter discoverable, I can't start a
> pairing from an iPhone, as was tested.

Applied.

-- 
Luiz Augusto von Dentz
