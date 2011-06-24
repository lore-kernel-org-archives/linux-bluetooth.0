Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTim60FHUp0B+2LkrsEG9vW4awFvvwQ@mail.gmail.com>
References: <1308661408-8364-1-git-send-email-sancane@gmail.com>
	<C521DA9B-E3C6-46F2-834E-6E33C12B18C7@signove.com>
	<BANLkTikNQac7UsMgKdnoVR7kVQSV6tVn6g@mail.gmail.com>
	<A2B092BC-BE3C-4C0A-917D-0253EF23943A@signove.com>
	<BANLkTik9muPgh_Xx3UTh7rEpzj-C7fVxuQ@mail.gmail.com>
	<544C7016-5346-4C99-AEA9-C91AA84E3A42@signove.com>
	<BANLkTim60FHUp0B+2LkrsEG9vW4awFvvwQ@mail.gmail.com>
Date: Fri, 24 Jun 2011 17:41:41 -0400
Message-ID: <BANLkTi=VkwnSCTMFyYiuzPQphvjYQ-befg@mail.gmail.com>
Subject: Re: [RFC] Health Thermometer Profile API
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Santiago Carot <sancane@gmail.com>
Cc: Elvis Pfutzenreuter <epx@signove.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Fri, Jun 24, 2011 at 6:06 AM, Santiago Carot <sancane@gmail.com> wrote:
> Coming back to this issue. I was just wondering that we may not need
> worried about this issue because the same case may occurs at GATT
> level. I mean, an application using GATT could disturb the behaviour
> of other one when it enables/disables characteristics.

Actually, the current D-Bus "generic" GATT API does not enable/disable
notifications (it assumes it has been enabled by some other mean, e.g.
using gatttool). I had a patch to enable it when the first D-Bus
client was interested on a characteristic (disabling was not possible
yet), but it has not been submitted upstream (we are currently
focusing on the core API for profiles AKA "attio driver").

So, as of now, some application using the generic D-Bus API will not
affect the profile specific behavior, as it can only read/write
characteristic values, and watch for already enabled
notifications/indications.

> Because of any application can enable/disable characteristics we don't
> need to worry about to manage this in the Thermometer API. Remember
> that in other threads in the mailing list people were speaking about
> making a D-Bus API for GATT. Those applications using GATT could
> enable notification for measures and disable it. On account of this,
> it will be inevitable collisions in the use cases.

I think we should adopt a refcount like behavior for
notifications/indications, and bluez core should manage this. IOW,
applications registered over d-bus grab a counter, on the first ref()
the notification/indication is enabled on peer device, on last unref()
it is disabled.

My two cents,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
