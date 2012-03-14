Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_NXZMwVtORcCX8tRF4zy-6k3KVF7i1a1WBNmWiDZS7fxA@mail.gmail.com>
References: <1331214279-27521-1-git-send-email-arik@wizery.com>
 <1331214279-27521-2-git-send-email-arik@wizery.com> <CAJdJm_NXZMwVtORcCX8tRF4zy-6k3KVF7i1a1WBNmWiDZS7fxA@mail.gmail.com>
From: Arik Nemtsov <arik@wizery.com>
Date: Wed, 14 Mar 2012 14:11:20 +0200
Message-ID: <CA+XVXfeBUaxBb1htPfZV_yiecedpvCWwuc91GXsYppxzKwTBog@mail.gmail.com>
Subject: Re: [PATCH 2/2] Revert "core: Add provision for terminating an ATT connection"
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Mar 14, 2012 at 14:08, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Arik,
>
> On Thu, Mar 8, 2012 at 9:44 AM, Arik Nemtsov <arik@wizery.com> wrote:
>> This reverts commit f89a77478af78d41c80ab7605662382b9e4e1c36.
>>
>> This is not needed and actually introduces a bug. When the "Disconnect"
>> API of device is called device->attrib is unref-ed via a watch set on
>> G_IO_HUP. The channel is shutdown when the last reference is removed.
>>
>> The code introduced here shuts down the channel and prevents the watch
>> from getting called. This means we leak a reference to device->attrib.
>> This can cause a number of bad things. For example, if the device is
>> temporary, it will never be freed, and we won't be able to pair to it
>> again.
>> ---
>>  src/device.c |    8 --------
>>  1 files changed, 0 insertions(+), 8 deletions(-)
>
> While I agree with your explanation, we still need a way to for link
> disconnection. There is a Disconnect command on mgmt API that may be
> used for this (I suppose there is a similar one for hciops). This way
> the HUP watches will be called because disconnection will be initiated
> by the kernel.
>

The current disconnect command (exposed via D-Bus as
Device.Disconnect()) works just fine for me.

Arik
