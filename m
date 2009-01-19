Return-Path: <cyrus@holtmann.org>
Message-ID: <4974D9E1.7070003@suse.de>
Date: Mon, 19 Jan 2009 20:52:01 +0100
From: Tom Patzig <tpatzig@suse.de>
Reply-To: tpatzig@suse.de
MIME-Version: 1.0
To: Ilya Rubtsov <lusyaru@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: app doesn't recieve signal DeviceDisappeared
References: <49696D00.9030604@gmail.com> <1232292554.5095.26.camel@californication> <49739C4F.10905@gmail.com>
In-Reply-To: <49739C4F.10905@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

>> this might be a bug. Not many applications are actually making full use
>> of the DeviceDisappeared signal. Please run dbus-monitor and check if it
>> is really not present.
I also recognized, that the signal DeviceDisappeared never gets thrown.
I need this Signal for KBlueLock (Screen lock, when your BT device
disappeares)
Right now i have located the problem a little deeper and did some tests.
I am using bluez-4.27 and use the test-discovery script in the test
directory. I expanded the testscript, to also listen for the
DeviceDisappeared Signals.

With a normal discovery, the signal gets never thrown (dbus-monitor).
And the curious thing is, that the 'Discovering' value always switches
between true and false ... so the discovery gets enabled and disabled
automatically. But jhe told me, this is intended to provide a
PeriodicDiscovery.

In adapter.c there is a function 'void adapter_set_state(struct
btd_adapter *adapter, int state)'. This function anyhow clears the List
with out of reach (oor) devices, depending on the discovery state.
If i comment out this if clause 'if (!discov_active &&
adapter->oor_devices)' to not free the oor device list, the Signal gets
thrown properly.
It gets thrown only once and the list of oor devices is also freed after
that (dont know where).
So my guess is, that the 'discov_active' boolean is set wrong (?), so
that this if clause is reached, but it should not.

This variable gets set depending on macros PERIODIC_INQUIRY and
STD_INQUIRY. What are these ?
So maybe the state is set wrong, but i do not know what the state should be.

Also strange is, that this DeviceDisappeared signal (with commented out
freeing of the oor list) only works, if more than one devices are in the
area. Because of the automatic stop/start of the 'Discovering' value. If
your one and only device gets disappeared the 'Discovering' value
switches to false and never starts searching again ( so it does not
recognize, that the device disappeared). The Discovery starts again,
when you device is visible again ...

I hope this helps, to find the problem.
I would also fix it, but i do not know which discovery state must be set
and which not, and when the oor list has to be freed and when not.

Regards,

Tom
