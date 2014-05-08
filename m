Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <A3E47A33-7BD7-40D7-8513-8AE8A1C13AC0@holtmann.org>
References: <1399555935-702-1-git-send-email-andrzej.kaczmarek@tieto.com>
 <1399555935-702-8-git-send-email-andrzej.kaczmarek@tieto.com> <A3E47A33-7BD7-40D7-8513-8AE8A1C13AC0@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Date: Thu, 8 May 2014 22:06:34 +0200
Message-ID: <CAF3PWx3cDTe6zwOvGXy6sWXDZSio-RtcXJrAGPoqq9oXCukNig@mail.gmail.com>
Subject: Re: [PATCH 7/8] Bluetooth: Avoid pooling TX power for LE links
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 8 May 2014 17:29, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Andrzej,
>
>> TX power for LE links is immutable thus we do not need to query for it
>> if already have value.
>
> can you include the part from the specification that clarifies this.

I'm not sure there's quote in spec that says this explicitly... iirc
there's explicit statement that it can be controlled on physical link
by LM for BR/EDR, but for LE I could not find such information. I
assume it does not change as otherwise TPS spec does not make sense.
But does my reasoning make sense? :-)

BR,
Andrzej
