Return-Path: <cyrus@holtmann.org>
Message-ID: <1359043779.6791.1.camel@dellpc>
Subject: Re: usb device removed from sysfs before input children devices
From: Karl Relton <karllinuxtest.relton@ntlworld.com>
To: linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org
Date: Thu, 24 Jan 2013 16:09:39 +0000
In-Reply-To: <1359035887.5482.1.camel@dellpc>
References: <1357759635.2872.9.camel@dellpc>
	 <1358281626.3998.29.camel@dellpc> <1359035887.5482.1.camel@dellpc>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2013-01-24 at 13:58 +0000, Karl Relton wrote:
> On Tue, 2013-01-15 at 20:27 +0000, Karl Relton wrote:
> > > The end result (for the user) is that even when the bluetooth
> > > mouse/keyboard is re-added, Xorg ignores it - thinking it is some
> > hoax
> > > duplicate device. The keyboard/mouse is then non-operational.
> > > 
> > 
> > Instrumenting the code suggests that the issue arises in a race
> > between:
> > 
> > hidp_session() in bluetooth/hidp/core.c
> > 
> > and
> > 
> > hci_unregister_dev() in bluetooth/hci_core.c
> > 
> > 

...

> > 
> > I can't figure out why there is such a delay for
> > input_unregister_device(). 
> 
> 
> The power_supply system seems to be triggering a lookup of battery
> 'capacity' in the input device. This calls into the driver, which deep
> down invokes more code in the 'hidp' module: hidp_get_raw_report()
> 
> This function tries to communicate with the bluetooth device (keyboard
> in my case), but because the device is being 'torn down' such
> communication fails. Accordingly hidp_get_raw_report has a 5 second
> timeout ... so this function stalls for 5 seconds until that timeout
> occurs.
> 
> 
> I would guess that for some reason, removing the 'hid' or associated
> 'input' device is leading to the power_supply code wanting to lookup the
> battery capacity which introduces a 5 second wait. This would delay
> hidp_session by 5 seconds ... in the mean time allowing
> hci_unregister_dev() to win the race and hence the hci device is removed
> before the input & hid devices.
> 

device_del is done on the battery device, called from
hidinput_cleanup_battery in hid-input.c.

This will generate a uevent which has the power_supply attributes added,
which invokes power_supply_show_property for 'capacity' which invokes
the hidp_get_raw_report (which stalls for 5 seconds).


Back in the days of linux 3.2, hid-input.c did not have any support for
batteries, so this chain of calls was never made, hence the race was won
by hidp_session() because it didn't have the 5 second delay injected.

Now with battery support added, the problem is manifest.

--

I think hidp_get_raw_report should abort if the devices is being 'torn
down' (and so not go into the 5 second wait). But also the race between
the two functions needs sorting, since sooner or later someone else will
get unlucky.



