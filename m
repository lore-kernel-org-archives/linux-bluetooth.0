Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: Paired LE HoG devices are unable to reconnect to BlueZ host when discovery is active
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAGXr9JEPv+onq6+WZTJ46oRtnrOJBPVQToKA82E84Sg9eSOP5A@mail.gmail.com>
Date: Mon, 27 Jan 2014 19:35:51 +0100
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <0917292A-A70F-44FB-ABBD-1C0F52A1FC15@holtmann.org>
References: <CAGXr9JEPv+onq6+WZTJ46oRtnrOJBPVQToKA82E84Sg9eSOP5A@mail.gmail.com>
To: Petri Gynther <pgynther@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Petri,

> With BlueZ 5.13, I've noticed that previously paired LE HoG devices
> are unable to reconnect to the host when device discovery is active on
> the BT interface.
> 
> Steps to reproduce:
> 1. Pair LE HoG device with BlueZ 5.13 host.
> 2. Verify that keypresses from HoG device are delivered to uHID input pipeline.
> 3. Let HoG device disconnect from host (due to inactivity timeout).
> 4. Press key on HoG device. At this point, it reconnects to host fine.
> 5. Let HoG device disconnect from host again.
> 6. Start "test-discovery" script.
> 7. Press key on HoG device => it does not reconnect to host.
> 8. Kill "test-discovery" script.
> 9. Press key on HoG device => it now reconnects to host successfully.
> 
> It looks to me that the root cause is in src/adapter.c:update_found_devices()
> 
>        /*
>         * Only if at least one client has requested discovery, maintain
>         * list of found devices and name confirming for legacy devices.
>         * Otherwise, this is an event from passive discovery and we
>         * should check if the device needs connecting to.
>         */
>        if (!adapter->discovery_list)
>                goto connect_le;
> 
>        if (g_slist_find(adapter->discovery_found, dev))
>                return;
> 
> When (active) discovery is on, adapter->discovery_list != NULL, and
> g_slist_find(adapter->discovery_found, dev) will obviously find this
> device since it is already paired. So, we end up returning from the
> function without an attempt to reconnect to the previously paired LE
> device.
> 
> What would be the right fix here? Stop discovery before attempting to
> reconnect to the LE device?

I think that the intention was to allow the active discovery complete before we try to connect to any known devices. You are obviously correct that a known device is as good when it is found during active discovery as when found during background scan.

So I get the feeling that what should happen is that if we find a known device during the discovery phase (I am talking about the phase from mgmt in the kernel), put it on the list of to be connected devices. Once the kernel completes its discovery, then attempt to connect that found devices. After that continue with the discovery.

Remember that the kernel discovery phase it one-time shot and the one triggered from D-Bus is continues. I think that is why you are seeing this problem in the first place.

This is something that the auto-connect patches for the kernel would obviously fix. Since that is the right place to get this fixed. Inside bluetoothd this gets a bit messy, but we should do our best to interrupt the discovery phase to allow auto-connections.

Just a small warning that this of course only possible for controllers that support scanning and connections at the same time. For some controllers this would be clearly limited. Not that I have seen these controllers used, but potentially they could exist.

That is the best answer I have right now. So yes, we should get this fixed since that behavior is just not helpful for general usage.

Regards

Marcel

