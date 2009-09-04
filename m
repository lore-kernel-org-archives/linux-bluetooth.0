Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 Sep 2009 09:31:43 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Peter Hurley <phurley@charter.net>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: [4.48] SDP Discovery not reset on error
Message-ID: <20090904063104.GA23278@jh-x301>
References: <4AA08357.7050903@charter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4AA08357.7050903@charter.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

On Thu, Sep 03, 2009, Peter Hurley wrote:
> I believe that SDP Discovery initiated during rfcomm_connect is left in  
> an inconsistent state when there is an error (such as when the remote  
> device is off).
>
> In the log capture below, an attempt to connect (via  
> gnome-bluetooth/bluetooth-applet) to the headset fails because the  
> device is off.  When the device is turned back on, and another attempt  
> is made to connect, SDP discovery fails again (Operation already in  
> progress).
>
>> Sep  3 21:21:52 dev-wkstn bluetoothd[2724]: State changed /org/bluez/2724/hci0/dev_00_0D_FD_1E_99_30: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
>> Sep  3 21:21:57 dev-wkstn bluetoothd[2724]: adapter_get_device(00:0D:FD:1E:99:30)
>> Sep  3 21:21:57 dev-wkstn bluetoothd[2724]: Unable to get service record: Host is down (112)
>> Sep  3 21:21:57 dev-wkstn bluetoothd[2724]: telephony-dummy: device 0x7f71751e8230 disconnected
>> Sep  3 21:21:57 dev-wkstn bluetoothd[2724]: State changed /org/bluez/2724/hci0/dev_00_0D_FD_1E_99_30: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_DISCONNECTED
>> Sep  3 21:23:00 dev-wkstn bluetoothd[2724]: State changed /org/bluez/2724/hci0/dev_00_0D_FD_1E_99_30: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
>> Sep  3 21:23:00 dev-wkstn bluetoothd[2724]: Unable to get service record: Operation already in progress (114)
>> Sep  3 21:23:00 dev-wkstn bluetoothd[2724]: telephony-dummy: device 0x7f71751e8230 disconnected
>> Sep  3 21:23:00 dev-wkstn bluetoothd[2724]: State changed /org/bluez/2724/hci0/dev_00_0D_FD_1E_99_30: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_DISCONNECTED
>
> Initially I was thinking that bt_cancel_discovery() needed to be called  
> or that cleanup in one of the failed: targets in the series of functions  
> and callbacks in common/glib_helper.c was the problem, but after a quick  
> scan perhaps the problem lies on the SDP server side? Suggestions?

You might want to take a hcidump output of the second connect failure,
i.e. run "hcidump -XV" as root while trying to connect. It would also be
interesting to know if this is reproducable with later BlueZ versions like
4.52. I tried to do a few quick tests with it but was unable to reproduce
the issue.

Johan
