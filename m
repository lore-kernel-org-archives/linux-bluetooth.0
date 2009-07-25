Return-Path: <cyrus@holtmann.org>
Message-ID: <4A6B853D.4040802@autonetmobile.com>
Date: Sat, 25 Jul 2009 15:20:45 -0700
From: Doug Moeller <dmoeller@autonetmobile.com>
MIME-Version: 1.0
To: Bastien Nocera <hadess@hadess.net>
CC: David Stockwell <dstockwell@frequency-one.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: "org.bluez.Adapter" doesn't exist
References: <1248254976-12090-1-git-send-email-gustavo@las.ic.unicamp.br>	 <1248254976-12090-2-git-send-email-gustavo@las.ic.unicamp.br>	 <1248256296.28545.124.camel@violet> <4A6A59F6.5000102@autonetmobile.com>	 <630BE65F03C54798A34D8F9364A9C25D@freqonedev> <1248504750.23466.6981.camel@localhost.localdomain>
In-Reply-To: <1248504750.23466.6981.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

That worked.   Thanks very much for the helpful hints.  If I could 
indulge for one more question please.

When I try and connect my bluetooth audio device(Sony Xplod Car Stereo) 
to my system running bluez it fails and I don't understand what's 
wrong.  It seems like the connection gets made fine (see dump below),  
but bluetoothd closes it right away as if it doesn't know what to do 
next.   (Unfortunately,  I'm not able to install python on my system so 
I fear I'm missing out on some helpful tools)

I'm guessing that the instructions at 
http://wiki.bluez.org/wiki/HOWTO/AudioDevices aren't current any more.

Much appreciated.

-Doug

Here's a dump.


# hcidump -a -V -i hci0
HCI sniffer - Bluetooth packet analyzer ver 1.42
device: hci0 snap_len: 1028 filter: 0xffffffff
 > HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:1A:80:4F:31:38 class 0x340408 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:1A:80:4F:31:38 role 0x01
    Role: Slave
 > HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
 > HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 11 bdaddr 00:1A:80:4F:31:38 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 11
 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
 > HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 11
    Features: 0xff 0xff 0x8f 0x78 0x18 0x18 0x00 0x80
 > HCI Event: Max Slots Change (0x1b) plen 3
    handle 11 slots 5
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:1A:80:4F:31:38 mode 2 clkoffset 0x0000
 > HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
 > HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:1A:80:4F:31:38 name 'Xplod'
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 11 reason 0x13
    Reason: Remote User Terminated Connection
 > HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 11 reason 0x16
    Reason: Connection Terminated by Local Host

Here's Bluetoothd output

# bluetoothd -dn
bluetoothd[4971]: Bluetooth daemon 4.46
bluetoothd[4971]: Enabling debug information
bluetoothd[4971]: parsing main.conf
bluetoothd[4971]: discovto=0
bluetoothd[4971]: pairto=0
bluetoothd[4971]: pageto=8192
bluetoothd[4971]: name=Autonet-%h
bluetoothd[4971]: class=0x000100
bluetoothd[4971]: discov_interval=0
bluetoothd[4971]: Key file does not have key 'DeviceID'
bluetoothd[4971]: Starting SDP server
bluetoothd[4971]: Loading builtin plugins
bluetoothd[4971]: Loading service plugin
bluetoothd[4971]: Loading hciops plugin
bluetoothd[4971]: Loading hal plugin
bluetoothd[4971]: Loading storage plugin
bluetoothd[4971]: Loading plugins /usr/local/lib/bluetooth/plugins
bluetoothd[4971]: Loading network plugin
bluetoothd[4971]: Loading serial plugin
bluetoothd[4971]: Loading input plugin
bluetoothd[4971]: Loading audio plugin
bluetoothd[4971]: register_interface: path /org/bluez/4971/any
bluetoothd[4971]: Registered interface org.bluez.Service on path 
/org/bluez/4971/any
bluetoothd[4971]: Unix socket created: 7
bluetoothd[4971]: audio.conf: Key file does not have key 'AutoConnect'
bluetoothd[4971]: audio.conf: Key file does not have key 'MaxConnected'
bluetoothd[4971]: Telephony plugin initialized
bluetoothd[4971]: HFP AG features: "Ability to reject a call" "Enhanced 
call status" "Extended Error Result Codes"
bluetoothd[4971]: Parsing /etc/bluetooth/input.conf failed: No such file 
or directory
bluetoothd[4971]: Parsing /etc/bluetooth/network.conf failed: No such 
file or directory
bluetoothd[4971]: Config options: InterfacePrefix=bnep%d, 
PANU_Script=(null), GN_Script=(null), NAP_Script=(null), 
GN_Interface=pan0, NAP_Interface=pan1, Security=true
bluetoothd[4971]: Can't create GN bridge
bluetoothd[4971]: HCI dev 0 registered
bluetoothd[4971]: child 4974 forked
bluetoothd[4971]: btd_adapter_ref(0xb9a70638): ref=1
bluetoothd[4971]: Entering main loop
bluetoothd[4971]: child 4974 exited
bluetoothd[4971]: HCI dev 0 up
bluetoothd[4971]: Starting security manager 0
bluetoothd[4971]: register_interface: path /org/bluez/4971/hci0
bluetoothd[4971]: Registered interface org.bluez.Service on path 
/org/bluez/4971/hci0
bluetoothd[4971]: headset_server_probe: path /org/bluez/4971/hci0
bluetoothd[4971]: btd_adapter_ref(0xb9a70638): ref=2
bluetoothd[4971]: audio_adapter_ref(0xb9a70308): ref=1
bluetoothd[4971]: Adding record with handle 0x10000
bluetoothd[4971]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[4971]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[4971]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[4971]: Record pattern UUID 00001108-0000-1000-8000-00805f9
bluetoothd[4971]: Record pattern UUID 00001112-0000-1000-8000-00805f9
bluetoothd[4971]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[4971]: audio.conf: Key file does not have key 'SCORouting'
bluetoothd[4971]: Adding record with handle 0x10001
bluetoothd[4971]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[4971]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[4971]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[4971]: Record pattern UUID 0000111e-0000-1000-8000-00805f9
bluetoothd[4971]: Record pattern UUID 0000111f-0000-1000-8000-00805f9
bluetoothd[4971]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[4971]: Changing service classes to 0x400100
bluetoothd[4971]: a2dp_server_probe: path /org/bluez/4971/hci0
bluetoothd[4971]: audio_adapter_ref(0xb9a70308): ref=2
bluetoothd[4971]: audio.conf: Key file does not have key 'Enable'
bluetoothd[4971]: audio.conf: Key file does not have key 'Disable'
bluetoothd[4971]: audio.conf: Key file does not have key 'SBCSources'
bluetoothd[4971]: audio.conf: Key file does not have key 'MPEG12Sources'
bluetoothd[4971]: audio.conf: Key file does not have key 'SBCSinks'
bluetoothd[4971]: audio.conf: Key file does not have key 'MPEG12Sinks'
bluetoothd[4971]: SEP 0xb9a715a0 registered: type:0 codec:0 seid:1
bluetoothd[4971]: Adding record with handle 0x10002
bluetoothd[4971]: Record pattern UUID 00000019-0000-1000-8000-00805f9
bluetoothd[4971]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[4971]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[4971]: Record pattern UUID 0000110a-0000-1000-8000-00805f9
bluetoothd[4971]: Record pattern UUID 0000110d-0000-1000-8000-00805f9
bluetoothd[4971]: Changing service classes to 0x480100
bluetoothd[4971]: avrcp_server_probe: path /org/bluez/4971/hci0
bluetoothd[4971]: audio_adapter_ref(0xb9a70308): ref=3
bluetoothd[4971]: Adding record with handle 0x10003
bluetoothd[4971]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[4971]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[4971]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[4971]: Record pattern UUID 0000110c-0000-1000-8000-00805f9
bluetoothd[4971]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[4971]: Changing service classes to 0x480100
bluetoothd[4971]: Adding record with handle 0x10004
bluetoothd[4971]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[4971]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[4971]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[4971]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[4971]: Changing service classes to 0x480100
bluetoothd[4971]: btd_adapter_ref(0xb9a70638): ref=3
bluetoothd[4971]: proxy_probe: path /org/bluez/4971/hci0
bluetoothd[4971]: btd_adapter_ref(0xb9a70638): ref=4
bluetoothd[4971]: Registered interface org.bluez.SerialProxyManager on 
path /org/bluez/4971/hci0
bluetoothd[4971]: network_server_probe: path /org/bluez/4971/hci0
bluetoothd[4971]: btd_adapter_ref(0xb9a70638): ref=5
bluetoothd[4971]: Adding record with handle 0x10005
bluetoothd[4971]: Record pattern UUID 0000000f-0000-1000-8000-00805f9
bluetoothd[4971]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[4971]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[4971]: Record pattern UUID 00001115-0000-1000-8000-00805f9
bluetoothd[4971]: Changing service classes to 0x4a0100
bluetoothd[4971]: register_server_record: got record id 0x10005
bluetoothd[4971]: Registered interface org.bluez.NetworkPeer on path 
/org/bluez/4971/hci0
bluetoothd[4971]: network_server_probe: path /org/bluez/4971/hci0
bluetoothd[4971]: Adding record with handle 0x10006
bluetoothd[4971]: Record pattern UUID 0000000f-0000-1000-8000-00805f9
bluetoothd[4971]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[4971]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[4971]: Record pattern UUID 00001117-0000-1000-8000-00805f9
bluetoothd[4971]: Changing service classes to 0x4a0100
bluetoothd[4971]: register_server_record: got record id 0x10006
bluetoothd[4971]: Registered interface org.bluez.NetworkHub on path 
/org/bluez/4971/hci0
bluetoothd[4971]: network_server_probe: path /org/bluez/4971/hci0
bluetoothd[4971]: Adding record with handle 0x10007
bluetoothd[4971]: Record pattern UUID 0000000f-0000-1000-8000-00805f9
bluetoothd[4971]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[4971]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[4971]: Record pattern UUID 00001116-0000-1000-8000-00805f9
bluetoothd[4971]: Changing service classes to 0x4a0100
bluetoothd[4971]: register_server_record: got record id 0x10007
bluetoothd[4971]: Registered interface org.bluez.NetworkRouter on path 
/org/bluez/4971/hci0
bluetoothd[4971]: Adapter /org/bluez/4971/hci0 has been enabled
bluetoothd[4971]: Failed to access HAL
bluetoothd[4971]: Agent registered for hci0 at :1.26:/org/bluez/pinagent
bluetoothd[4971]: adapter_get_device(00:1A:80:4F:31:38)
bluetoothd[4971]: adapter_create_device(00:1A:80:4F:31:38)
bluetoothd[4971]: Creating device /org/bluez/4971/hci0/dev_00_1A_80_4F_31_38
bluetoothd[4971]: btd_device_ref(0xb9a743e0): ref=1
bluetoothd[4971]: Removing temporary device 
/org/bluez/4971/hci0/dev_00_1A_80_4F_31_38
bluetoothd[4971]: Removing device /org/bluez/4971/hci0/dev_00_1A_80_4F_31_38
bluetoothd[4971]: btd_device_unref(0xb9a743e0): ref=0
bluetoothd[4971]: device_free(0xb9a743e0)


Here's my .asoundrc

# more .asoundrc
pcm.bluetooth {
   type bluetooth
   device 00:1A:80:4F:31:38
}

Here's my audio.conf

# more audio.conf
# Configuration file for the audio service

# This section contains options which are not specific to any
# particular interface
[General]

# Switch to master role for incoming connections (defaults to true)
Master=false

# If we want to disable support for specific services
# Defaults to supporting all implemented services
#Disable=Control,Source

# SCO routing. Either PCM or HCI (in which case audio is routed to/from 
ALSA)
# Defaults to HCI
#SCORouting=PCM

# Automatically connect both A2DP and HFP/HSP profiles for incoming
# connections. Some headsets that support both profiles will only 
connect the
# other one automatically so the default setting of true is usually a good
# idea.
#AutoConnect=true

# Headset interface specific options (i.e. options which affect how the 
audio
# service interacts with remote headset devices)
[Headset]

# Set to true to support HFP, false means only HSP is supported
# Defaults to true
HFP=true

# Maximum number of connected HSP/HFP devices per adapter. Defaults to 1
MaxConnections=1

# Just an example of potential config options for the other interfaces
[A2DP]
#SBCSources=1
#MPEG12Sources=0














Bastien Nocera wrote:
> On Fri, 2009-07-24 at 21:19 -0500, David Stockwell wrote:
>   
>> Hello, Doug
>>
>> From: "Doug Moeller" <dmoeller@autonetmobile.com>
>>     
>>> I've been beating my head against this for hours.  My end game is to 
>>> get Bluetooth audio going,  but I'm stuck just trying to get the 
>>> interface discoverable.  If anyone is willing to share any clues I'd 
>>> really appreciate it.
>>>
>>> -Doug
>>>
>>>
>>> # dbus-send --system --type=method_call --print-reply --dest=org.bluez 
>>> /org/bluez/hci0 org.bluez.Adapter.GetMode
>>> Error org.freedesktop.DBus.Error.UnknownMethod: Method "GetMode" with 
>>> signature "" on interface "org.bluez.Adapter" doesn't exist
>>>
>>>
>>> Bluetoothd output
>>>
>>>
>>> # bluetoothd -dn
>>> bluetoothd[18625]: Bluetooth daemon 4.38
>>>       
>> First thing I would look at is catching up with the current version of 
>> the BT daemon, which is now 4.46 (BlueZ is a work in progress).
>>     
>
> BlueZ is as much a work in progress as any other piece of software. It's
> supposed to be stable, and isn't the cause of the problems anyway.
>
> The object path is wrong. Try using D-Feet to see the object paths.
> (hint: it should read /org/bluez/$(pidof bluetoothd)/hci0)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>   

