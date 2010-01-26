Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4B5433F1.9090706@gmail.com>
References: <4B5433F1.9090706@gmail.com>
Date: Tue, 26 Jan 2010 12:36:09 -0200
Message-ID: <f9d4bd31001260636l2051c702wd6c6845f2cd851bf@mail.gmail.com>
Subject: Re: Bluez question about new profiles delopment
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: sancane <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jan 18, 2010 at 8:12 AM, sancane <sancane@gmail.com> wrote:
> Hi,
> I want to develop a new bluetooth profiles for blueZ basing on my
> recently experience gained with my prototype implementation of MCAP &
> HDP (http://openhealth.morfeo-project.org). My goal is integrate above
> profiles using the BlueZ architecture, but i have some question to do.
>
> * I don't have clear what is the difference between implement a new
> bluetooth profile (for example MCAP) like a Service or implement it like
> a Plugin. What exactly a plugin is?
>
> I open to any suggestion about the architecture integration of MCAP and
> HDP. You can contact with me by email or at irc.freenode.net (i'm sancane).
>
> Any ideas are welcome.
>
> Best regards.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Hi Sacane,

In general Bluetooth profiles/services are implemented as a plugin,
making it easy to enable or disable it. Both roles are implemented in
the same plugin, if you are implementing a server you need to register
an adapter driver, or a device driver for client side. See the network
plugin for example, it is necessary register the NAP adapter driver to
register the services exported by the NAP and the device driver to
represent the client. For this last case, the client exports a D-Bus
API to allow other applications to control BT PAN connections.

IMHO, MCAP features could implemented as a library. For HDP you will
need to implement new plugin containing adapter(local BT adapter)
driver and device(represents the remote BT device) drivers. HDP has
some roles and configurations that are confuse to me at the moment.
According to the HDP SPEC, both(source and sink) can be the initiator
of the connections, this can be a little bit tricky. The common
scenario is: health device acting as source and PC/mobile device
acting as sink.

You can concentrate the effort to define the sink role first, since it
will be where BlueZ will be running.

Do you have an API to suggest?


Regards,
Claudio
