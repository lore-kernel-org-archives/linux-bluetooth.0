Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [RFC PATCH BlueZ] doc: Document Broadcaster/Observer API
Date: Tue, 17 Apr 2012 05:42:56 +0000
Message-ID: <F0070FBC0FB3174D8D11444EB2D5B0260B481B2F@DNCE05.ent.ti.com>
References: <1334192668-21433-1-git-send-email-anderson.lizardo@openbossa.org>
	<1334192668-21433-2-git-send-email-anderson.lizardo@openbossa.org>
	<F0070FBC0FB3174D8D11444EB2D5B0260B47F6DA@DNCE05.ent.ti.com>
 <CAJdJm_MMuZGpFLNO5iDLsLqDzGxMbb+0+YwUMfHqWjyzODd6Hw@mail.gmail.com>
In-Reply-To: <CAJdJm_MMuZGpFLNO5iDLsLqDzGxMbb+0+YwUMfHqWjyzODd6Hw@mail.gmail.com>
Content-Type: text/plain; charset="windows-1255"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Lizardo,

> -----Original Message-----
> From: Anderson Lizardo [mailto:anderson.lizardo@openbossa.org]
> Sent: Monday, April 16, 2012 3:11 PM
> To: Ganir, Chen
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: [RFC PATCH BlueZ] doc: Document Broadcaster/Observer API
> 
> Hi Chen,
> 
> On Mon, Apr 16, 2012 at 4:07 AM, Ganir, Chen <chen.ganir@ti.com> wrote:
> >> +             void RegisterBroadcaster(dict values)
> >> +
> >> +                     Set Advertising data for broadcast. Different
> >> +                     applications can register different Adv. data
> types,
> >> +                     and they are all concatenated to form the Adv.
> data.
> >> +                     Broadcasting is enabled as soon as the first
> >> +                     RegisterBroadcaster() call is made.
> >> +
> >> +                     Use UnregisterBroadcaster() to release Adv.
> data for
> >> +                     the application. Advertising data is also
> released
> >> when
> >> +                     application exits, and once the last
> Broadcaster
> >> exits,
> >> +                     advertising is disabled.
> >> +
> >> +                     Possible Errors:
> org.bluez.Error.InvalidArguments
> >> +                                      org.bluez.Error.Failed
> >> +
> > What if the data changes? What if I register for Service Data, and
> the service data changes? Do I need to RegisterBroadcaster again?
> 
> In this API, it needs to be called again. We need to clarify more
> these cases here. Will do for next version.
> 
I would suggest adding a new API, called UpdateBroadcastData() which will be used by a registered broadcaster to update it's broadcasting data. Using the same RegisterBroadcaster() will cause inconsistency between the regiseter/unregister functions which will break the logic - you may see many registerBroadcaster calls, but only one unregister call.

> >> +             void UnregisterBroadcaster()
> >> +
> >> +                     This method will release any previously set
> >> Advertising
> >> +                     data.
> >> +
> >> +                     Note that a broadcast procedure is shared
> between all
> >> +                     sessions, thus calling UnregisterBroadcaster()
> will
> >> +                     only release a single session.
> >> +
> >> +                     Possible errors: org.bluez.Error.Failed
> >> +
> >> +             void RegisterObserver(object agent, array{byte}
> data_types)
> >> +
> >> +                     Registers an observer agent to monitor
> broadcasts.
> >> This
> >> +                     agent will be notified whenever a broadcast is
> >> received
> >> +                     that contains any of selected Advertising data
> types.
> >> +
> >> +                     Possible errors:
> org.bluez.Error.InvalidArguments
> >> +
> > Will this automatically start the scanning for advertising?
> 
> Not sure yet :). It will depend on how the underlying mgmt API will
> work. There is a clear conflict/dependency here with BR/EDR/LE
> discovery.
> 
> > How will you combine this with the device search for dual mode
> devices?
> 
> One possibility if for RegisterObserver() to trigger a LE only
> discovery (using the existing mgmt API), then when some application
> triggers the dual mode discovery, it just switches to BR/EDR/LE. I
> suppose this is fully supported by current mgmt discovery API.
> 
> (note that I'm ignoring the scan parameters here for now; as explained
> on previous e-mail, it needs a broader discussion.)
> 
> >> +             void UnregisterObserver(object agent)
> >> +
> >> +                     Unregisters an observer. Broadcasts will not
> be
> >> +                     notified to this agent anymore.
> >> +
> >> +                     Possible errors:
> org.bluez.Error.InvalidArguments
> > Will unregistering ALL observers stop the scan for advertising ?
> 
> If there is no pending BR/EDR/LE discovery, yes. But I think this
> "detail" can be left out from the documentation. After unregister, the
> application will not receive any new broadcast information on the
> agent.
> 
> Thanks for your comments, we will fill the missing information and
> send a new version soon.
> 
> Best Regards,
> --
> Anderson Lizardo
> Instituto Nokia de Tecnologia - INdT
> Manaus - Brazil


Thanks,
Chen Ganir

