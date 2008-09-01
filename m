Return-Path: <cyrus@holtmann.org>
Message-ID: <48BC6CEC.8040602@pook.es>
Date: Tue, 02 Sep 2008 00:30:04 +0200
From: Stuart Pook <linux-bluetooth4@pook.es>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: bluez 4.2 + linux 2.6.27-rc5 -> no audio interface
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

I decided to try bluez-4.2 with my Jabra JX10 Bluetooth headset. I ran
bluetoothd. It says that it has registered interfaces for
org.bluez.network.Router, org.bluez.network.Hub, org.bluez.network.Peer
and org.bluez.serial.ProxyManager but nothing about an audio service. It
does load the /usr/local/lib/bluetooth/plugins/audio.so plugin. The
python script bluez-4.2/audio/test-audio says
"org.freedesktop.DBus.Error.UnknownMethod: Method "ActivateService" with
signature "s" on interface "org.bluez.Manager" doesn't exist".

Running arecord just says "BT_GETCAPABILITIES failed : Input/output
error(5)".

I created /etc/bluetooth/audio.conf and modified my ~/.asoundrc.

What else do I need to do to get bluetooth audio working?

I am running linux 2.6.27-rc5 because I want to try the new btusb driver
and it's SCO over USB support.

In
http://[2001:4860:0:1001::28]/search?q=cache:AJmIOP3i9YIJ:pastebin.ca/raw/1094961+bluetoothd+Registered+interface+org.bluez&hl=en&ct=clnk&cd=15 

I saw that bluetoothd can say "Registered interface
org.bluez.audio.Headset on path /org/bluez/hci0/dev_". Does it have to
contact the bluetooth headset before registering the
org.bluez.audio.Headset interface?

When I run bluetoothd, dbus-monitor --system says "
interface=org.bluez.Manager; member=AdapterAdded".

src/test-discovery, src/test-device, and src/test-adapter all work.

Any help would be most welcome.

thanks
Stuart

PS I also tried creating /etc/bluetooth/rfcomm.conf but I don't really
know what to put in it.

: root@kooka; bluetoothd -dn
bluetoothd[4160]: Bluetooth daemon
bluetoothd[4160]: Enabling debug information
bluetoothd[4160]: parsing main.conf
bluetoothd[4160]: offmode=NoScan
bluetoothd[4160]: discovto=0
bluetoothd[4160]: pageto=8192
bluetoothd[4160]: name=%h-%d
bluetoothd[4160]: class=0x000100
bluetoothd[4160]: Starting SDP server
bluetoothd[4160]: Adding rec : 0xb8bcaa98
bluetoothd[4160]: with handle : 0x1
bluetoothd[4160]: Adding rec : 0xb8bcca80
bluetoothd[4160]: with handle : 0x0
bluetoothd[4160]: Service classes 0x00
bluetoothd[4160]: Loading plugins /usr/local/lib/bluetooth/plugins
bluetoothd[4160]: /usr/local/lib/bluetooth/plugins/audio.so
bluetoothd[4160]: Unix socket created: 11
bluetoothd[4160]: /usr/local/lib/bluetooth/plugins/serial.so
bluetoothd[4160]: /usr/local/lib/bluetooth/plugins/network.so
bluetoothd[4160]: Parsing /etc/bluetooth/network.conf failed: No such
file or directory
bluetoothd[4160]: Config options: InterfacePrefix=bnep%d,
PANU_Script=(null), GN_Script=(null), NAP_Script=(null),
GN_Interface=pan0, NAP_Interface=pan1, Security=true
bluetoothd[4160]: bridge pan0 created
bluetoothd[4160]: /usr/local/lib/bluetooth/plugins/input.so
bluetoothd[4160]: input.conf: Key file does not have key 'IdleTimeout'
bluetoothd[4160]: HCI dev 0 registered
bluetoothd[4160]: HCI dev 0 already up
bluetoothd[4160]: headset_server_probe: path /org/bluez/hci0
bluetoothd[4160]: Couldn't find record for : 0x10000
bluetoothd[4160]: Adding record with handle 0x10000
bluetoothd[4160]: Adding rec : 0xb8bcf760
bluetoothd[4160]: with handle : 0x10000
bluetoothd[4160]: Service classes 0x00
bluetoothd[4160]: a2dp_server_probe: path /org/bluez/hci0
bluetoothd[4160]: SEP 0xb8bcd3b8 registered: type:0 codec:0 seid:1
bluetoothd[4160]: Couldn't find record for : 0x10001
bluetoothd[4160]: Adding record with handle 0x10001
bluetoothd[4160]: Adding rec : 0xb8bcd8a0
bluetoothd[4160]: with handle : 0x10001
bluetoothd[4160]: Service classes 0x08
bluetoothd[4160]: avrcp_server_probe: path /org/bluez/hci0
bluetoothd[4160]: Couldn't find record for : 0x10002
bluetoothd[4160]: Adding record with handle 0x10002
bluetoothd[4160]: Adding rec : 0xb8bcd5c0
bluetoothd[4160]: with handle : 0x10002
bluetoothd[4160]: Service classes 0x08
bluetoothd[4160]: Couldn't find record for : 0x10003
bluetoothd[4160]: Adding record with handle 0x10003
bluetoothd[4160]: Adding rec : 0xb8bcdd58
bluetoothd[4160]: with handle : 0x10003
bluetoothd[4160]: Service classes 0x08
bluetoothd[4160]: proxy_probe: path /org/bluez/hci0
bluetoothd[4160]: Registered interface org.bluez.serial.ProxyManager on
path /org/bluez/hci0
bluetoothd[4160]: network_server_probe: path /org/bluez/hci0
bluetoothd[4160]: Couldn't find record for : 0x10004
bluetoothd[4160]: Adding record with handle 0x10004
bluetoothd[4160]: Adding rec : 0xb8bd05c0
bluetoothd[4160]: with handle : 0x10004
bluetoothd[4160]: Service classes 0x0a
bluetoothd[4160]: register_server_record: got record id 0x10004
bluetoothd[4160]: Registered interface org.bluez.network.Peer on path
/org/bluez/hci0
bluetoothd[4160]: network_server_probe: path /org/bluez/hci0
bluetoothd[4160]: Couldn't find record for : 0x10005
bluetoothd[4160]: Adding record with handle 0x10005
bluetoothd[4160]: Adding rec : 0xb8bd0be8
bluetoothd[4160]: with handle : 0x10005
bluetoothd[4160]: Service classes 0x0a
bluetoothd[4160]: register_server_record: got record id 0x10005
bluetoothd[4160]: Registered interface org.bluez.network.Hub on path
/org/bluez/hci0
bluetoothd[4160]: network_server_probe: path /org/bluez/hci0
bluetoothd[4160]: Couldn't find record for : 0x10006
bluetoothd[4160]: Adding record with handle 0x10006
bluetoothd[4160]: Adding rec : 0xb8bd1210
bluetoothd[4160]: with handle : 0x10006
bluetoothd[4160]: Service classes 0x0a
bluetoothd[4160]: register_server_record: got record id 0x10006
bluetoothd[4160]: Registered interface org.bluez.network.Router on path
/org/bluez/hci0
bluetoothd[4160]: Creating device /org/bluez/hci0/dev_00_14_A7_74_xx_xx
bluetoothd[4160]: Creating device /org/bluez/hci0/dev_00_03_89_B7_xx_xx
bluetoothd[4160]: Creating device /org/bluez/hci0/dev_00_0A_94_94_xx_xx
bluetoothd[4160]: Creating device /org/bluez/hci0/dev_00_03_89_DC_xx_xx
bluetoothd[4160]: Creating device /org/bluez/hci0/dev_00_03_89_DC_xx_xx
bluetoothd[4160]: Creating device /org/bluez/hci0/dev_00_03_89_FE_xx_xx
bluetoothd[4160]: Creating device /org/bluez/hci0/dev_00_0E_6D_8F_xx_xx
bluetoothd[4160]: Creating device /org/bluez/hci0/dev_00_17_E5_E6_xx_xx
bluetoothd[4160]: Creating device /org/bluez/hci0/dev_00_17_E5_16_xx_xx
bluetoothd[4160]: Creating device /org/bluez/hci0/dev_00_17_E5_0C_xx_xx
bluetoothd[4160]: Creating device /org/bluez/hci0/dev_00_1A_45_2F_xx_xx
bluetoothd[4160]: Adapter /org/bluez/hci0 has been enabled
bluetoothd[4160]: Starting security manager 0
bluetoothd[4160]: child 4162 exited
bluetoothd[4160]: child 4164 exited
bluetoothd[4160]: Accepted new client connection on unix socket (fd=20)
bluetoothd[4160]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[4160]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[4160]: Unix client disconnected (fd=20)
bluetoothd[4160]: Accepted new client connection on unix socket (fd=20)
bluetoothd[4160]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[4160]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[4160]: Unix client disconnected (fd=20)
.....


:; ./bluez-4.2/audio/test-audio
Traceback (most recent call last):
    File "./bluez-4.2/audio/test-audio", line 10, in <module>
      conn = manager.ActivateService('audio')
    File "/var/lib/python-support/python2.5/dbus/proxies.py", line 68, in
__call__
      return self._proxy_method(*args, **keywords)
    File "/var/lib/python-support/python2.5/dbus/proxies.py", line 140,
in __call__
      **keywords)
    File "/var/lib/python-support/python2.5/dbus/connection.py", line
622, in call_blocking
      message, timeout)
dbus.exceptions.DBusException: org.freedesktop.DBus.Error.UnknownMethod:
Method "ActivateService" with signature "s" on interface
"org.bluez.Manager" doesn't exist


:; arecord -D JX10  -f S16_LE | wc -c
ALSA lib pcm_bluetooth.c:1619:(bluetooth_init) BT_GETCAPABILITIES failed
: Input/output error(5)
arecord: main:564: audio open error: Input/output error
0

:; less ~/.asoundrc
pcm.JX10 {
          type bluetooth
          device "00:1A:45:2F:xx:xx" # Jabra JX10 series 2
}
:; cat /etc/bluetooth/audio.conf
# Configuration file for the audio service

# This section contains options which are not specific to any
# particular interface
[General]

# Switch to master role for incoming connections (defaults to true)
Master=true

# If we want to disable support for specific services
# Defaults to supporting all implemented services
Disable=Control,Source

# SCO routing. Either PCM or HCI (in which case audio is routed to/from
ALSA)
# Defaults to HCI
SCORouting=PCM

# Headset interface specific options (i.e. options which affect how the
audio
# service interacts with remote headset devices)
[Headset]

# Set to true to support HFP (in addition to HSP only which is the default)
# Defaults to false
HFP=false

# HFP Gateway features
# Defaults to false
3WayCalling=false
EchoCancelNoiseCancel=false
VoiceRecognition=false
InBandRingtone=false
VoiceTags=false
RejectingCalls=false
EnhancedCallStatus=false
EnhancedCallControl=false
ExtendedErrorResultCodes=false

# Just an example of potential config options for the other interfaces
[A2DP]
SBCSources=1
MPEG12Sources=0
SBCSinks=
MPEG12Sinks=
:; cat /etc/bluetooth/main.conf
[General]

# List of plugins that should not be loaded on bluetoothd startup
#DisablePlugins = network,input

# Default adaper name
# %h - substituted for hostname
# %d - substituted for adapter id
Name = %h-%d

# Default device class. Only the major and minor device class bits are
# considered
Class = 0x000100

# How long to stay in discoverable mode before going back to
non-discoverable
# The value is in seconds. Default is 180, i.e. 3 minutes.
# 0 = disable timer, i.e. stay discoverable forever
DiscoverableTimeout = 0

# Use some other page timeout than the controller default one
# (16384 = 10 seconds)
PageTimeout = 8192

# Behaviour for Adapter.SetProperty("mode", "off")
# Possible values: "DevDown", "NoScan" (default)
OffMode = NoScan


:; uname -a
Linux kooka 2.6.27-rc5 #1 SMP Sat Aug 30 16:48:04 CEST 2008 i686 GNU/Linux

:; cat /etc/dbus-1/system.d/bluetooth.conf
<!-- This configuration file specifies the required security policies
       for Bluetooth core daemon to work. -->

<!DOCTYPE busconfig PUBLIC "-//freedesktop//DTD D-BUS Bus Configuration
1.0//EN"
   "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
<busconfig>

    <!-- ../system.conf have denied everything, so we just punch some
holes -->

    <policy user="root">
      <allow own="org.bluez"/>
    </policy>

    <policy at_console="true">
      <allow send_path="/"/>
      <allow send_path="/org/bluez"/>

      <allow send_destination="org.bluez.Manager"/>
      <allow receive_sender="org.bluez.Manager"/>

      <allow send_destination="org.bluez.Adapter"/>
      <allow receive_sender="org.bluez.Adapter"/>

      <allow send_destination="org.bluez.Device"/>
      <allow receive_sender="org.bluez.Device"/>
    </policy>

: root@kooka;  dbus-monitor  --system
signal sender=org.freedesktop.DBus -> dest=:1.78
path=/org/freedesktop/DBus; interface=org.freedesktop.DBus;
member=NameAcquired
     string ":1.78"
signal sender=org.freedesktop.DBus -> dest=(null destination)
path=/org/freedesktop/DBus; interface=org.freedesktop.DBus;
member=NameOwnerChanged
     string "org.bluez"
     string ":1.76"
     string ""
signal sender=org.freedesktop.DBus -> dest=(null destination)
path=/org/freedesktop/DBus; interface=org.freedesktop.DBus;
member=NameOwnerChanged
     string ":1.76"
     string ":1.76"
     string ""
signal sender=org.freedesktop.DBus -> dest=(null destination)
path=/org/freedesktop/DBus; interface=org.freedesktop.DBus;
member=NameOwnerChanged
     string ":1.79"
     string ""
     string ":1.79"
signal sender=org.freedesktop.DBus -> dest=(null destination)
path=/org/freedesktop/DBus; interface=org.freedesktop.DBus;
member=NameOwnerChanged
     string "org.bluez"
     string ""
     string ":1.79"
signal sender=:1.79 -> dest=(null destination) path=/;
interface=org.bluez.Manager; member=AdapterAdded
     object path "/org/bluez/hci0"
signal sender=:1.79 -> dest=(null destination) path=/org/bluez/hci0;
interface=org.bluez.Adapter; member=PropertyChanged
     string "Mode"
     variant       string "off"
signal sender=:1.79 -> dest=(null destination) path=/;
interface=org.bluez.Manager; member=DefaultAdapterChanged
     object path "/org/bluez/hci0"

:; src/test-discovery
[ 00:16:AE:xx:xx:xx ]
     RSSI = 0
     Name = Livebox-A328
     Class = 0x520300
     Address = 00:xx:xx:xx:xx:xx
:;  src/test-device name 00:1A:45:2F:xx:xx
Jabra JX10 series 2
:; src/test-device class 00:1A:45:2F:xx:xx
0x200404
:; src/test-device trusted 00:1A:45:2F:xx:xx
0
:; src/test-adapter address
00:0C:xx:xx:xx:xx

:; network/test-network
Traceback (most recent call last):
   File "network/test-network", line 10, in <module>
     conn = manager.ActivateService('network')
   File "/var/lib/python-support/python2.5/dbus/proxies.py", line 68, in 
__call__
     return self._proxy_method(*args, **keywords)
   File "/var/lib/python-support/python2.5/dbus/proxies.py", line 140, 
in __call__
     **keywords)
   File "/var/lib/python-support/python2.5/dbus/connection.py", line 
622, in call_blocking
     message, timeout)
dbus.exceptions.DBusException: org.freedesktop.DBus.Error.UnknownMethod: 
Method "ActivateService" with signature "s" on interface 
"org.bluez.Manager" doesn't exist

:; serial/test-serial
Traceback (most recent call last):
   File "serial/test-serial", line 12, in <module>
     conn = manager.ActivateService('serial')
   File "/var/lib/python-support/python2.5/dbus/proxies.py", line 68, in 
__call__
     return self._proxy_method(*args, **keywords)
   File "/var/lib/python-support/python2.5/dbus/proxies.py", line 140, 
in __call__
     **keywords)
   File "/var/lib/python-support/python2.5/dbus/connection.py", line 
622, in call_blocking
     message, timeout)
dbus.exceptions.DBusException: org.freedesktop.DBus.Error.UnknownMethod: 
Method "ActivateService" with signature "s" on interface 
"org.bluez.Manager" doesn't exist

