Return-Path: <cyrus@holtmann.org>
Message-ID: <50445E09.9000909@tieto.com>
Date: Mon, 3 Sep 2012 09:36:41 +0200
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 0/7] RFC: proximity cleanup
References: <1346417314-25109-1-git-send-email-andrzej.kaczmarek@tieto.com> <CAJdJm_OxOaVeU=WS5RfprUBOj4wsoMMVwS9vH8S7ogxR1QPdsw@mail.gmail.com>
In-Reply-To: <CAJdJm_OxOaVeU=WS5RfprUBOj4wsoMMVwS9vH8S7ogxR1QPdsw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

On 08/31/2012 06:17 PM, Anderson Lizardo wrote:
> Hi Andrzej,
>
> On Fri, Aug 31, 2012 at 8:48 AM, Andrzej Kaczmarek
> <andrzej.kaczmarek@tieto.com> wrote:
>> Hi,
>>
>> Here are few patches to cleanup proximity profile code a bit which seem to
>> keep track of some data which are redundant and has minor issue with device
>> driver registration.
>>
>> Most cleanup is done in patch #3 which removes tracking of DBusConnection
>> across whole plugin and simply uses get_dbus_connection() wherever necessary.
>> This is different than other profile plugins do, but reduces code size and
>> memory footprint a bit so can be done for other plugins as well if accepted.
>
> While some cleanups here are very welcome, I'm worried that you are
> cleaning up things before finishing the Proximity Reporter
> implementation. Power Level characteristic for instance is currently a
> stub, how do you plan to store it per adapter, without the struct
> reporter_adapter?

Ah, I didn't find it on TODO so assumed it's complete. But you're right, 
it probably should not be removed.

> Therefore I suggest you split the "trivial" cleanups from the removal
> of struct reporter_adapter.

Please just consider patches #6 and #7 as invalid for now, I think 
there's no point in sending #1-5 once more until there are some comments 
to fix.

> BTW, do you have plans to add more features to the Proximity Reporter
> implementation?

No plans at the moment, but perhaps I'll take a look on this in more 
details after HRP is finished (v2 will be sent soon).

BR,
Andrzej

