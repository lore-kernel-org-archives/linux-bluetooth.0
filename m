Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Alex Deymo <deymo@chromium.org>
Date: Wed, 29 May 2013 18:57:45 -0700
Message-ID: <CAGd9gwhg507Me7JmrJF+it5U8JeXrCqx1gdXNHz8EopfsWFDhQ@mail.gmail.com>
Subject: Temporary devices
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	keybuk <keybuk@chromium.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello ML,

I have a problem with the lifetime of a device object in the
bluetoothd. When you scan for devices they first appear as temporary
devices (device_is_temporary()==true), and attempting to pair to a
given device will mark it as not temporary. The problem is that if the
pair fails, for example because the device is no longer in range or is
off, the device keeps its non-temporary status.

When this happens, the device status is as follows:
* Remove_temp_devices() will never remove it after the timeout, since
it is not temporary.
* The device's profiles are unknown because the device was never
paired and thus, the device is not stored on disk (we just know the
name on the ADAPTER_ADDR/cache/DEVICE_ADDR file)...
* Because of this, a bluetoothd restart will discard that device in
the new process, meaning that the device was in fact a temporary
device... but the device will stay there in the device list forever
(until we Remove it).

I tried to set the temporary property back to true when the pairing
fails (and is not connected, nor trusted, etc ....) but I see a lot of
other problems with that approach. In general... I don't get why we
need the "temporary" field itself... temporary should be derived from
properties like bonded, connected, trusted and some sort of
"LastSeen".

Thinking about this, I propose to add the already mentioned "LastSeen"
property to the Device1 interface and let the client handle what's the
right thing to show to the user in a meaningful order. The other thing
we could do is to get rid of the explicit "temporary" property and
make it just a function of the other mentioned properties. Basically,
bluetoothd should get rid of a device when nobody cares about it (is
not connected, not trusted nor paired, etc) and we didn't heard from
it in the last N minutes.
Any thoughts?

Thanks,
Alex.
