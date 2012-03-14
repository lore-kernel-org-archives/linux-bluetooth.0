Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_Ph1Ax_BJUVz3UsLvzLQnA1uH5n8p=ihNc-KHuxoCVoHw@mail.gmail.com>
References: <1331214279-27521-1-git-send-email-arik@wizery.com> <CAJdJm_Ph1Ax_BJUVz3UsLvzLQnA1uH5n8p=ihNc-KHuxoCVoHw@mail.gmail.com>
From: Arik Nemtsov <arik@wizery.com>
Date: Wed, 14 Mar 2012 14:09:21 +0200
Message-ID: <CA+XVXffwWs8XYNT30NeRCT1hUGg-q5VD7X9k-NJfm6T9p8YjXw@mail.gmail.com>
Subject: Re: [PATCH 1/2] device: don't auto-connect on disc-cb attio callback registration
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Mar 14, 2012 at 14:03, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Arik,
>
> On Thu, Mar 8, 2012 at 9:44 AM, Arik Nemtsov <arik@wizery.com> wrote:
>> If a device is already connected, don't auto-connect if we register
>> a disconnect-only attio callback. This will obviously fail.
>> ---
>>  src/device.c |   13 +++++++++----
>>  1 files changed, 9 insertions(+), 4 deletions(-)
>
> I can't see why this patch is necessary. attio_connected() seems to
> properly check that device->cfunc is set before calling it.
>
> Can you explain why you need it?

Before this patch, if we register a disconnect-only attio callback
(cfunc is NULL) when the device is connected, it will cause this line
to be called:

		device->auto_id = g_idle_add_full(G_PRIORITY_DEFAULT_IDLE,
						att_connect, device,
						att_connect_dispatched);

I guess the code wasn't really tested with a disconnect-only attio
callback. I think I added the first such callback in the proximity
reporter profiles.

Arik
