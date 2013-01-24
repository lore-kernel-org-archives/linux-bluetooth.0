Return-Path: <cyrus@holtmann.org>
Message-ID: <1359035887.5482.1.camel@dellpc>
Subject: Re: usb device removed from sysfs before input children devices
From: Karl Relton <karllinuxtest.relton@ntlworld.com>
To: linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org
Date: Thu, 24 Jan 2013 13:58:07 +0000
In-Reply-To: <1358281626.3998.29.camel@dellpc>
References: <1357759635.2872.9.camel@dellpc>
	 <1358281626.3998.29.camel@dellpc>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2013-01-15 at 20:27 +0000, Karl Relton wrote:
> > The end result (for the user) is that even when the bluetooth
> > mouse/keyboard is re-added, Xorg ignores it - thinking it is some
> hoax
> > duplicate device. The keyboard/mouse is then non-operational.
> > 
> 
> Instrumenting the code suggests that the issue arises in a race
> between:
> 
> hidp_session() in bluetooth/hidp/core.c
> 
> and
> 
> hci_unregister_dev() in bluetooth/hci_core.c
> 
> 
> Basically hci_unregister_dev() does a hci_dev_do_close() which in turn
> shuts down the hidp connection. This causes hidp_session() running in
> another thread to go into its cleanup phase, which is where the input
> children devices are unregistered.
> 
> HOWEVER:
> 1) For some reason input_unregister_device() seems to stall some 3-5
> seconds on my system before removing the input device
> 2) In parallel hci_unregister_dev() ploughs on, and progresses to
> remove
> its hdev (hci<n> device) regardless, without waiting for
> hidp_session()
> to complete.
> 
> I can't figure out why there is such a delay for
> input_unregister_device(). 


The power_supply system seems to be triggering a lookup of battery
'capacity' in the input device. This calls into the driver, which deep
down invokes more code in the 'hidp' module: hidp_get_raw_report()

This function tries to communicate with the bluetooth device (keyboard
in my case), but because the device is being 'torn down' such
communication fails. Accordingly hidp_get_raw_report has a 5 second
timeout ... so this function stalls for 5 seconds until that timeout
occurs.


I would guess that for some reason, removing the 'hid' or associated
'input' device is leading to the power_supply code wanting to lookup the
battery capacity which introduces a 5 second wait. This would delay
hidp_session by 5 seconds ... in the mean time allowing
hci_unregister_dev() to win the race and hence the hci device is removed
before the input & hid devices.


