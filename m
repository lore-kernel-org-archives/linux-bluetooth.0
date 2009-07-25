Return-Path: <cyrus@holtmann.org>
Message-ID: <630BE65F03C54798A34D8F9364A9C25D@freqonedev>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "Doug Moeller" <dmoeller@autonetmobile.com>
Cc: <linux-bluetooth@vger.kernel.org>
References: <1248254976-12090-1-git-send-email-gustavo@las.ic.unicamp.br>	 <1248254976-12090-2-git-send-email-gustavo@las.ic.unicamp.br> <1248256296.28545.124.camel@violet> <4A6A59F6.5000102@autonetmobile.com>
Subject: Re: "org.bluez.Adapter" doesn't exist
Date: Fri, 24 Jul 2009 21:19:14 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello, Doug

From: "Doug Moeller" <dmoeller@autonetmobile.com>
> I've been beating my head against this for hours.  My end game is to 
> get Bluetooth audio going,  but I'm stuck just trying to get the 
> interface discoverable.  If anyone is willing to share any clues I'd 
> really appreciate it.
>
> -Doug
>
>
> # dbus-send --system --type=method_call --print-reply --dest=org.bluez 
> /org/bluez/hci0 org.bluez.Adapter.GetMode
> Error org.freedesktop.DBus.Error.UnknownMethod: Method "GetMode" with 
> signature "" on interface "org.bluez.Adapter" doesn't exist
>
>
> Bluetoothd output
>
>
> # bluetoothd -dn
> bluetoothd[18625]: Bluetooth daemon 4.38

First thing I would look at is catching up with the current version of 
the BT daemon, which is now 4.46 (BlueZ is a work in progress).

Also what kernel version and distro are you running?

Finally, what is contained in audio.conf?  The fact that it is calling 
again and again for A2DP looks suspicious.

Mind you, I am not an expert, I am implementing AVRCP+Metadata, and have 
run into many other issues...  But, let's start there.


David Stockwell

> bluetoothd[18625]: Enabling debug information
> bluetoothd[18625]: parsing main.conf
> bluetoothd[18625]: discovto=0
> bluetoothd[18625]: pairto=0
> bluetoothd[18625]: pageto=8192
> bluetoothd[18625]: name=%h-%d
> bluetoothd[18625]: class=0x000100
> bluetoothd[18625]: inqmode=0
> bluetoothd[18625]: Key file does not have key 'DeviceID'
> bluetoothd[18625]: Starting SDP server
> bluetoothd[18625]: Loading builtin plugins
> bluetoothd[18625]: Loading service plugin
> bluetoothd[18625]: Loading hciops plugin
> bluetoothd[18625]: Loading hal plugin
> bluetoothd[18625]: Loading storage plugin
> bluetoothd[18625]: Loading plugins /usr/local/lib/bluetooth/plugins
> bluetoothd[18625]: Loading audio plugin
> bluetoothd[18625]: Loading serial plugin
> bluetoothd[18625]: Loading input plugin
> bluetoothd[18625]: register_interface: path /org/bluez/18625/any
> bluetoothd[18625]: Registered interface org.bluez.Service on path 
> /org/bluez/18625/any
> bluetoothd[18625]: input.conf: Key file does not have key 
> 'IdleTimeout'
> bluetoothd[18625]: Unix socket created: 7
> bluetoothd[18625]: audio.conf: Key file does not have key 
> 'AutoConnect'
> bluetoothd[18625]: audio.conf: Key file does not have key 
> 'MaxConnected'
> bluetoothd[18625]: Telephony plugin initialized
> bluetoothd[18625]: HFP AG features: "Ability to reject a call" 
> "Enhanced call status" "Extended Error Result Codes"
> bluetoothd[18625]: HCI dev 0 registered
> bluetoothd[18625]: child 18626 forked
> bluetoothd[18625]: HCI dev 0 up
> bluetoothd[18625]: Starting security manager 0
> bluetoothd[18625]: periodic_inquiry_exit at adapter startup
> bluetoothd[18625]: register_interface: path /org/bluez/18625/hci0
> bluetoothd[18625]: Registered interface org.bluez.Service on path 
> /org/bluez/18625/hci0
> bluetoothd[18625]: proxy_probe: path /org/bluez/18625/hci0
> bluetoothd[18625]: Registered interface org.bluez.SerialProxyManager 
> on path /org/bluez/18625/hci0
> bluetoothd[18625]: headset_server_probe: path /org/bluez/18625/hci0
> bluetoothd[18625]: audio.conf: Key file does not have key 'Master'
> bluetoothd[18625]: Adding record with handle 0x10000
> bluetoothd[18625]: Record pattern UUID 00000003-0000-1000-8000-00805f9
> bluetoothd[18625]: Record pattern UUID 00000100-0000-1000-8000-00805f9
> bluetoothd[18625]: Record pattern UUID 00001002-0000-1000-8000-00805f9
> bluetoothd[18625]: Record pattern UUID 00001108-0000-1000-8000-00805f9
> bluetoothd[18625]: Record pattern UUID 00001112-0000-1000-8000-00805f9
> bluetoothd[18625]: Record pattern UUID 00001203-0000-1000-8000-00805f9
> bluetoothd[18625]: audio.conf: Key file does not have key 'SCORouting'
> bluetoothd[18625]: Adding record with handle 0x10001
> bluetoothd[18625]: Record pattern UUID 00000003-0000-1000-8000-00805f9
> bluetoothd[18625]: Record pattern UUID 00000100-0000-1000-8000-00805f9
> bluetoothd[18625]: Record pattern UUID 00001002-0000-1000-8000-00805f9
> bluetoothd[18625]: Record pattern UUID 0000111e-0000-1000-8000-00805f9
> bluetoothd[18625]: Record pattern UUID 0000111f-0000-1000-8000-00805f9
> bluetoothd[18625]: Record pattern UUID 00001203-0000-1000-8000-00805f9
> bluetoothd[18625]: a2dp_server_probe: path /org/bluez/18625/hci0
> bluetoothd[18625]: audio.conf: Key file does not have key 'Disable'
> bluetoothd[18625]: audio.conf: Key file does not have group 'A2DP'
> bluetoothd[18625]: audio.conf: Key file does not have group 'A2DP'
> bluetoothd[18625]: audio.conf: Key file does not have group 'A2DP'
> bluetoothd[18625]: audio.conf: Key file does not have group 'A2DP'
> bluetoothd[18625]: audio.conf: Key file does not have key 'Master'
> bluetoothd[18625]: SEP 0xb9b81478 registered: type:0 codec:0 seid:1
> bluetoothd[18625]: Adding record with handle 0x10002
> bluetoothd[18625]: Record pattern UUID 00000019-0000-1000-8000-00805f9
> bluetoothd[18625]: Record pattern UUID 00000100-0000-1000-8000-00805f9
> bluetoothd[18625]: Record pattern UUID 00001002-0000-1000-8000-00805f9
> bluetoothd[18625]: Record pattern UUID 0000110a-0000-1000-8000-00805f9
> bluetoothd[18625]: Record pattern UUID 0000110d-0000-1000-8000-00805f9
> bluetoothd[18625]: avrcp_server_probe: path /org/bluez/18625/hci0
> bluetoothd[18625]: audio.conf: Key file does not have key 'Master'
> bluetoothd[18625]: Adding record with handle 0x10003
> bluetoothd[18625]: Record pattern UUID 00000017-0000-1000-8000-00805f9
> bluetoothd[18625]: Record pattern UUID 00000100-0000-1000-8000-00805f9
> bluetoothd[18625]: Record pattern UUID 00001002-0000-1000-8000-00805f9
> bluetoothd[18625]: Record pattern UUID 0000110c-0000-1000-8000-00805f9
> bluetoothd[18625]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
> bluetoothd[18625]: Adding record with handle 0x10004
> bluetoothd[18625]: Record pattern UUID 00000017-0000-1000-8000-00805f9
> bluetoothd[18625]: Record pattern UUID 00000100-0000-1000-8000-00805f9
> bluetoothd[18625]: Record pattern UUID 00001002-0000-1000-8000-00805f9
> bluetoothd[18625]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
> bluetoothd[18625]: Changing service classes to 0x480100
> bluetoothd[18625]: Adapter /org/bluez/18625/hci0 has been enabled
> bluetoothd[18625]: Changing service classes to 0x480100
> bluetoothd[18625]: Entering main loop
> bluetoothd[18625]: child 18626 exited
> bluetoothd[18625]: Failed to access HAL

