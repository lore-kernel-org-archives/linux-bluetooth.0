Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABUK1ahRsy+JtP-pqTcHeVSD=OxQ=_Yb29gCKZCzxxa-httdmw@mail.gmail.com>
References: <CABUK1ahRsy+JtP-pqTcHeVSD=OxQ=_Yb29gCKZCzxxa-httdmw@mail.gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Sat, 21 Jul 2012 13:45:59 -0300
Message-ID: <CAMOw1v4U5t+_4hC4PSKy1H5d1dgBpieCXKBy+P7vH2yZ0dMJNg@mail.gmail.com>
Subject: Re: AVRCPv1.3 NOTIFY from CT per notification from TG
To: Pavan Savoy <pavan_savoy@sify.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pavan,

On Fri, Jul 20, 2012 at 5:39 PM, Pavan Savoy <pavan_savoy@sify.com> wrote:
> Hi,
>
> Went through the archives, don't see this being discussed.
> I read the AVRCPv1.3 spec section mentioned below and to me it looks
> like it's been implemented the way it is supposed to be, However, the
> question is WHY ?
>
>         /* Unregister event as per AVRCP 1.3 spec, section 5.4.2 */
>         player->registered_events ^= 1 << id;
>
> Does that mean - A car-kit product would keep asking for new
> notifications time and again ? That too, It needs to be requesting for
> notification for each individual EVENT_ID again and again ? Since 1
> notification request is good for 1 notification & for 1 particular
> event ?

Yes, TG side can't send an event CT was not registered to. And that
means we have to remove the registered event after it has been
generated. It's indeed not well designed IMO, but it is what other
devices are supposed to implement. Once they receive a notification,
if they are still interested in a certain even, they register again to
that event. It's racy, but devices out there use it expecting this
behavior.

>
> Wouldn't this make the devices more chatty then they are supposed to
> be? Why not enable/disable notifications - And capability to OR
> various event IDs ?

Not sure I understand what you mean here.


Lucas De Marchi
