Return-Path: <cyrus@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Gateway profile
MIME-Version: 1.0
Message-ID: <OFE94D1A53.DDFBB6C0-ONC1257555.003EF4B2-C1257555.0042ACD7@aweurope.be>
From: Thierry Pierret <extern.Thierry.Pierret@awtce.be>
Date: Fri, 6 Feb 2009 13:08:15 +0100
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Leonid, hi to all,

I know this patch is not perfect and still has some issues. But since 
there is currently no alternative, I would like to use it on my iMX31 
platform. And if afterwards I can help with some improvements, it's 
worthy.
In the meantime, I have to dive in your code, the bluez code and in the 
buetooth specifications. Since I'm not an expert, neither for bluetooth 
and bluez, neither for sound, I would earn some time if I could get some 
answers already.

I installed the "Gateway Profile" patch on BlueZ 4.28 (with some minor 
corrections for the compilation).

1. First issue, only the "Handsfree" service is exported :

$ sdptool browse local
Browsing FF:FF:FF:00:00:00 ...
Service Name: Hands-free
Service RecHandle: 0x10000
Service Class ID List:
  "Handsfree" (0x111e)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 6
Profile Descriptor List:
  "Handsfree" (0x111e)
    Version: 0x0100

Here is the audio.conf file I use :

[General]
Master=true
Enable=Gateway
Disable=Headset;Sink;Source;Control
SCORouting=PCM

[Headset]
HFP=true
MaxConnected=1

I certainly miss something in my configuration in order to also get the 
Headset service exported.

2. Second issue, any attempt to connect the handsfree service from a 
mobile failed. The mobile ends in the paired state, but the handsfree 
device connection failed. Here is the full (annotated) ouput of the 
bluetoothd daemon.

bluetoothd[1772]: Bluetooth daemon
bluetoothd[1772]: Enabling debug information
bluetoothd[1772]: parsing main.conf
bluetoothd[1772]: discovto=0
bluetoothd[1772]: pairto=0
bluetoothd[1772]: pageto=8192
bluetoothd[1772]: name=%h-%d
bluetoothd[1772]: class=0x000100
bluetoothd[1772]: inqmode=0
bluetoothd[1772]: Key file does not have key 'DeviceID'
bluetoothd[1772]: Starting SDP server
bluetoothd[1772]: Loading plugins /usr/lib/bluetooth/plugins
bluetoothd[1772]: register_interface: path /org/bluez/1772/any
bluetoothd[1772]: Registered interface org.bluez.Service on path 
/org/bluez/1772/any
bluetoothd[1772]: Unix socket created: 10
bluetoothd[1772]: HCI dev 0 registered
bluetoothd[1772]: child 1773 forked
bluetoothd[1772]: HCI dev 0 already up
bluetoothd[1772]: Starting security manager 0
bluetoothd[1772]: register_interface: path /org/bluez/1772/hci0
bluetoothd[1772]: Registered interface org.bluez.Service on path 
/org/bluez/1772/hci0
bluetoothd[1772]: gateway_server_probe: path /org/bluez/1772/hci0
bluetoothd[1772]: Adding record with handle 0x10000
bluetoothd[1772]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[1772]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[1772]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[1772]: Record pattern UUID 0000111e-0000-1000-8000-00805f9
bluetoothd[1772]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[1772]: proxy_probe: path /org/bluez/1772/hci0
bluetoothd[1772]: Registered interface org.bluez.SerialProxyManager on 
path /org/bluez/1772/hci0
bluetoothd[1772]: Creating device 
/org/bluez/1772/hci0/dev_00_0E_ED_01_DA_66
bluetoothd[1772]: Probe drivers for 
/org/bluez/1772/hci0/dev_00_0E_ED_01_DA_66
bluetoothd[1772]: adapter_get_device(00:0E:ED:01:DA:66)
bluetoothd[1772]: audio handle_uuid: server not enabled for 
00001112-0000-1000-8000-00805F9B34FB (0x1112)
bluetoothd[1772]: Found Handsfree AG record
bluetoothd[1772]: serial_probe: path 
/org/bluez/1772/hci0/dev_00_0E_ED_01_DA_66: 
00000002-0000-1000-8000-0002ee000002
bluetoothd[1772]: Registered interface org.bluez.Serial on path 
/org/bluez/1772/hci0/dev_00_0E_ED_01_DA_66
bluetoothd[1772]: serial_probe: path 
/org/bluez/1772/hci0/dev_00_0E_ED_01_DA_66: 
00001101-0000-1000-8000-00805f9b34fb
bluetoothd[1772]: serial_probe: path 
/org/bluez/1772/hci0/dev_00_0E_ED_01_DA_66: 
00001103-0000-1000-8000-00805f9b34fb
bluetoothd[1772]: serial_probe: path 
/org/bluez/1772/hci0/dev_00_0E_ED_01_DA_66: 
00001105-0000-1000-8000-00805f9b34fb
bluetoothd[1772]: serial_probe: path 
/org/bluez/1772/hci0/dev_00_0E_ED_01_DA_66: 
00001106-0000-1000-8000-00805f9b34fb
bluetoothd[1772]: serial_probe: path 
/org/bluez/1772/hci0/dev_00_0E_ED_01_DA_66: 
00001112-0000-1000-8000-00805F9B34FB
bluetoothd[1772]: serial_probe: path 
/org/bluez/1772/hci0/dev_00_0E_ED_01_DA_66: 
0000111f-0000-1000-8000-00805f9b34fb
bluetoothd[1772]: serial_probe: path 
/org/bluez/1772/hci0/dev_00_0E_ED_01_DA_66: 
0000112d-0000-1000-8000-00805f9b34fb
bluetoothd[1772]: serial_probe: path 
/org/bluez/1772/hci0/dev_00_0E_ED_01_DA_66: 
00005002-0000-1000-8000-0002ee000001
bluetoothd[1772]: Adapter /org/bluez/1772/hci0 has been enabled
bluetoothd[1772]: child 1773 exited

# Passkey agent started
bluetoothd[1772]: Agent registered for hci0 at :1.4:/org/bluez/agent_1782

# Attempt from a mobile (Nokia 6810) to connect the handsfree device
bluetoothd[1772]: adapter_get_device(00:0E:ED:01:DA:66)
bluetoothd[1772]: adapter_create_device(00:0E:ED:01:DA:66)
bluetoothd[1772]: Creating device 
/org/bluez/1772/hci0/dev_00_0E_ED_01_DA_66
bluetoothd[1772]: pin_code_request (sba=00:02:5B:00:A5:A5, 
dba=00:0E:ED:01:DA:66)
bluetoothd[1772]: adapter_get_device(00:0E:ED:01:DA:66)
bluetoothd[1772]: /org/bluez/1772/hci0/dev_00_0E_ED_01_DA_66: requesting 
agent authentication
Agent_message was called!
Agent called: RequestPinCode
Device path = /org/bluez/1772/hci0/dev_00_0E_ED_01_DA_66
Agent has been released
bluetoothd[1772]: link_key_notify (sba=00:02:5B:00:A5:A5, 
dba=00:0E:ED:01:DA:66)
bluetoothd[1772]: adapter_get_device(00:0E:ED:01:DA:66)
bluetoothd[1772]: hcid_dbus_bonding_process_complete: status=00
bluetoothd[1772]: setting timer for reverse service discovery
bluetoothd[1772]: adapter_get_device(00:0E:ED:01:DA:66)
bluetoothd[1772]: Probe drivers for 
/org/bluez/1772/hci0/dev_00_0E_ED_01_DA_66
bluetoothd[1772]: audio handle_uuid: server not enabled for 
00001112-0000-1000-8000-00805F9B34FB (0x1112)
bluetoothd[1772]: serial_probe: path 
/org/bluez/1772/hci0/dev_00_0E_ED_01_DA_66: 
00001112-0000-1000-8000-00805F9B34FB
bluetoothd[1772]: Registered interface org.bluez.Serial on path 
/org/bluez/1772/hci0/dev_00_0E_ED_01_DA_66
bluetoothd[1772]: Probe drivers for 
/org/bluez/1772/hci0/dev_00_0E_ED_01_DA_66
bluetoothd[1772]: audio handle_uuid: server not enabled for 
00001112-0000-1000-8000-00805f9b34fb (0x1112)
bluetoothd[1772]: Found Handsfree AG record
bluetoothd[1772]: serial_probe: path 
/org/bluez/1772/hci0/dev_00_0E_ED_01_DA_66: 
00001105-0000-1000-8000-00805f9b34fb
bluetoothd[1772]: serial_probe: path 
/org/bluez/1772/hci0/dev_00_0E_ED_01_DA_66: 
00001106-0000-1000-8000-00805f9b34fb
bluetoothd[1772]: serial_probe: path 
/org/bluez/1772/hci0/dev_00_0E_ED_01_DA_66: 
00001103-0000-1000-8000-00805f9b34fb
bluetoothd[1772]: serial_probe: path 
/org/bluez/1772/hci0/dev_00_0E_ED_01_DA_66: 
00001101-0000-1000-8000-00805f9b34fb
bluetoothd[1772]: serial_probe: path 
/org/bluez/1772/hci0/dev_00_0E_ED_01_DA_66: 
00001101-0000-1000-8000-00805f9b34fb
bluetoothd[1772]: serial_probe: path 
/org/bluez/1772/hci0/dev_00_0E_ED_01_DA_66: 
0000111f-0000-1000-8000-00805f9b34fb
bluetoothd[1772]: serial_probe: path 
/org/bluez/1772/hci0/dev_00_0E_ED_01_DA_66: 
00001112-0000-1000-8000-00805f9b34fb
bluetoothd[1772]: serial_probe: path 
/org/bluez/1772/hci0/dev_00_0E_ED_01_DA_66: 
00000002-0000-1000-8000-0002ee000002
bluetoothd[1772]: serial_probe: path 
/org/bluez/1772/hci0/dev_00_0E_ED_01_DA_66: 
00005002-0000-1000-8000-0002ee000001
bluetoothd[1772]: serial_probe: path 
/org/bluez/1772/hci0/dev_00_0E_ED_01_DA_66: 
0000112d-0000-1000-8000-00805f9b34fb

What's wrong ? I need support.

Thanks in advance for your help.
Regards.

Thierry
