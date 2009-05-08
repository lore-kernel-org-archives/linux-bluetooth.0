Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <5d223510905071317w41aed1d1k21dd46d824b2e0ee@mail.gmail.com>
References: <5d223510905060754p70b53725u52963a0b41c82788@mail.gmail.com>
	 <363123.87568.qm@web95416.mail.in2.yahoo.com>
	 <5d223510905070559q320fed9do34252e99473e1acf@mail.gmail.com>
	 <369400.87206.qm@web95405.mail.in2.yahoo.com>
	 <5d223510905071304x4ed3ecd8jdbcfa053b96d81d0@mail.gmail.com>
	 <5d223510905071317w41aed1d1k21dd46d824b2e0ee@mail.gmail.com>
Date: Fri, 8 May 2009 13:56:05 -0300
Message-ID: <5d223510905080956r395f6332i115014641f612c8c@mail.gmail.com>
Subject: Re: HSP and HFP no sound
From: Rafael Seste <rseste@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
To: unlisted-recipients:; (no To-header on input)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Now I got the hcidump packet:

As we can see it was send only one SCO data packet with handler 92
which is the same that appear in bluethoothd output:
bluetoothd[1475]: No matching connection found for handle 92

I installed a customizer kernel to fit in 2MB partition, so its
missing a lot of drivers.
Is it necessary others drivers than the bluetooth? like sounds and usb
that are not dependent???

tks,
Rafael

Receiving call:

> ACL data: handle 14 flags 0x02 dlen 27
> ACL data: handle 14 flags 0x01 dlen 9
   L2CAP(d): cid 0x0040 len 32 [psm 3]
     RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 28 fcs 0x3e
> HCI Event: Mode Change (0x14) plen 6
> HCI Event: Max Slots Change (0x1b) plen 3
> ACL data: handle 14 flags 0x02 dlen 12
   L2CAP(d): cid 0x0040 len 8 [psm 3]
     RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
     dlci 26 fc 0 rtc 1 rtr 1 ic 1 dv 0 b1 1 b2 0 b3 0 len 3
< ACL data: handle 14 flags 0x02 dlen 12
   L2CAP(d): cid 0x0040 len 8 [psm 3]
     RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
     dlci 26 fc 0 rtc 1 rtr 1 ic 1 dv 0 b1 1 b2 0 b3 0 len 3
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 14 flags 0x02 dlen 44
   L2CAP(d): cid 0x0040 len 40 [psm 3]
     RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 36 fcs 0x3e
< ACL data: handle 14 flags 0x02 dlen 12
   L2CAP(d): cid 0x0040 len 8 [psm 3]
     RFCOMM(d): UIH: cr 1 dlci 26 pf 0 ilen 4 fcs 0xe4
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 14 flags 0x02 dlen 12
   L2CAP(d): cid 0x0040 len 8 [psm 3]
     RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
     dlci 26 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 1 b2 0 b3 1 len 0
< ACL data: handle 14 flags 0x02 dlen 12
   L2CAP(d): cid 0x0040 len 8 [psm 3]
     RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
     dlci 26 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 1 b2 0 b3 1 len 0
> HCI Event: Max Slots Change (0x1b) plen 3
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Connect Request (0x04) plen 10
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Connect Complete (0x03) plen 11
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
> ACL data: handle 14 flags 0x02 dlen 9
> ACL data: handle 14 flags 0x01 dlen 6
   L2CAP(d): cid 0x0040 len 11 [psm 3]
     RFCOMM(d): UIH: cr 0 dlci 26 pf 1 ilen 6 fcs 0x22 credits 1
> ACL data: handle 14 flags 0x02 dlen 9
> ACL data: handle 14 flags 0x01 dlen 9
> ACL data: handle 14 flags 0x01 dlen 4
   L2CAP(d): cid 0x0040 len 18 [psm 3]
     RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 14 fcs 0x3e
> ACL data: handle 14 flags 0x02 dlen 9
> ACL data: handle 14 flags 0x01 dlen 9
> ACL data: handle 14 flags 0x01 dlen 9
> ACL data: handle 14 flags 0x01 dlen 9
   L2CAP(d): cid 0x0040 len 32 [psm 3]
     RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 28 fcs 0x3e
< SCO data: handle 92 flags 0x00 dlen 48
> ACL data: handle 14 flags 0x02 dlen 9
> ACL data: handle 14 flags 0x01 dlen 9
> ACL data: handle 14 flags 0x01 dlen 4
   L2CAP(d): cid 0x0040 len 18 [psm 3]
     RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 14 fcs 0x3e

hang up

> ACL data: handle 14 flags 0x02 dlen 9
> ACL data: handle 14 flags 0x01 dlen 9
> ACL data: handle 14 flags 0x01 dlen 4
   L2CAP(d): cid 0x0040 len 18 [psm 3]
     RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 14 fcs 0x3e
> ACL data: handle 14 flags 0x02 dlen 9
> ACL data: handle 14 flags 0x01 dlen 9
> ACL data: handle 14 flags 0x01 dlen 4
   L2CAP(d): cid 0x0040 len 18 [psm 3]
     RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 14 fcs 0x3e
> ACL data: handle 14 flags 0x02 dlen 9
> ACL data: handle 14 flags 0x01 dlen 9
> ACL data: handle 14 flags 0x01 dlen 4
   L2CAP(d): cid 0x0040 len 18 [psm 3]
     RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 14 fcs 0x3e
> HCI Event: Disconn Complete (0x05) plen 4
> HCI Event: Max Slots Change (0x1b) plen 3
> HCI Event: Max Slots Change (0x1b) plen 3
> HCI Event: Mode Change (0x14) plen 6
--
Rafael S. Seste

On Thu, May 7, 2009 at 5:17 PM, Rafael Seste <rseste@gmail.com> wrote:
>
> Looking at the output that I post, I found this logs:
>
> bluetoothd[1475]: headset_probe: path /org/bluez/1475/hci0/dev_00_1D_FD_E4_42_FF
> bluetoothd[1475]: probe failed with driver input-headset for device
> /org/bluez/1475/hci0/dev_00_1D_FD_E4_42_FF
>
> and a lot of this
>
> audio handle_uuid: server not enabled for
> 00001112-0000-1000-8000-00805f9b34fb (0x1112)
>
> Anybody knows what are the meaning of these logs??
>
>
> tks,
> Rafael
>
> On Thu, May 7, 2009 at 5:04 PM, Rafael Seste <rseste@gmail.com> wrote:
> > Balaji,
> >
> > I didn't have any experience like you describe.
> > I only connect my cell phone using asterisk, but it only works on
> > bluez 2.x now with bluez 4.32 it is not working.
> >
> > I found this post that may help you...
> > http://www.linuxquestions.org/questions/linux-hardware-18/jabra-bt2010-bluetooth-headset-and-linux-709819/#post3468686
> >
> > tks
> > Rafael
> >
> > On Thu, May 7, 2009 at 10:21 AM, balaji palaniswami
> > <balaji_palaniswami@yahoo.com> wrote:
> >>
> >> Hello Rafael ,
> >>
> >> Thanks for your output.
> >> Now i am trying to upgrade bluez stack from 4.12 defualt to 4.38 top of tree.
> >>
> >> OS :Ubuntu 8.10
> >> Bluetooth dongle :Broadcom
> >> Head set :Jabra B160
> >> Skype version :2.0.0.72
> >>
> >> I just upgraded from  Bluez 4.12 to 4.38 .In 4.38 bluez , i am able to pair the dongle with headset
> >> but i have no luck to hear test call from skype.I captured hcidump and looked into that
> >> it terminated with Disconnection after pairing.Once i started the skype there is no l2cap connection establishment.but it is working fine in 4.17. I will post dump for your analysis.
> >>
> >> Can you share your experience regarding this?
> >>
> >> Thanks,
> >> Balaji.P
> >>
> >>
> >> ----- Original Message ----
> >> From: Rafael Seste <rseste@gmail.com>
> >> To: balaji palaniswami <balaji_palaniswami@yahoo.com>
> >> Cc: linux-bluetooth@vger.kernel.org
> >> Sent: Thursday, 7 May, 2009 6:29:34 PM
> >> Subject: Re: HSP and HFP no sound
> >>
> >> Hi Balaji,
> >>
> >> here is the initialization output:
> >>
> >> bluetoothd[1475]: Bluetooth daemon
> >> bluetoothd[1475]: Enabling debug information
> >> bluetoothd[1475]: parsing main.conf
> >> bluetoothd[1475]: discovto=0
> >> bluetoothd[1475]: pairto=0
> >> bluetoothd[1475]: pageto=8192
> >> bluetoothd[1475]: name=Sheeva
> >> bluetoothd[1475]: class=0x100204
> >> bluetoothd[1475]: inqmode=0
> >> bluetoothd[1475]: Key file does not have key 'DeviceID'
> >> bluetoothd[1475]: Starting SDP server
> >> bluetoothd[1475]: Loading plugins /usr/lib/bluetooth/plugins
> >> bluetoothd[1475]: Unix socket created: 11
> >> bluetoothd[1475]: audio.conf: Key file does not have key 'MaxConnected'
> >> bluetoothd[1475]: Telephony plugin initialized
> >> bluetoothd[1475]: HFP AG features: "Ability to reject a call"
> >> "Enhanced call status" "Extended Error Result Codes"
> >> bluetoothd[1475]: Starting experimental netlink support
> >> bluetoothd[1475]: Failed to find Bluetooth netlink family
> >> bluetoothd[1475]: register_interface: path /org/bluez/1475/any
> >> bluetoothd[1475]: Registered interface org.bluez.Service on path
> >> /org/bluez/1475/any
> >> bluetoothd[1475]: /etc/bluetooth/network.conf: Key file does not have
> >> key 'Disable'
> >> bluetoothd[1475]: /etc/bluetooth/network.conf: Key file does not have
> >> key 'DisableSecurity'
> >> bluetoothd[1475]: /etc/bluetooth/network.conf: Key file does not have
> >> key 'Interface'
> >> bluetoothd[1475]: /etc/bluetooth/network.conf: Key file does not have
> >> key 'Interface'
> >> bluetoothd[1475]: /etc/bluetooth/network.conf: Key file does not have
> >> key 'Interface'
> >> bluetoothd[1475]: Config options: InterfacePrefix=bnep%d,
> >> PANU_Script=(null), GN_Script=(null), NAP_Script=(null),
> >> GN_Interface=pan0, NAP_Interface=pan1, Security=true
> >> bluetoothd[1475]: Failed to open control socket: Protocol not supported (93)
> >> bluetoothd[1475]: Can't init bnep module
> >> bluetoothd[1475]: input.conf: Key file does not have key 'IdleTimeout'
> >> bluetoothd[1475]: HCI dev 0 registered
> >> bluetoothd[1475]: child 1476 forked
> >> bluetoothd[1475]: HCI dev 0 up
> >> bluetoothd[1475]: Starting security manager 0
> >> bluetoothd[1475]: headset_server_probe: path /org/bluez/1475/hci0
> >> bluetoothd[1475]: audio.conf: Key file does not have key 'Master'
> >> bluetoothd[1475]: Adding record with handle 0x10000
> >> bluetoothd[1475]: Record pattern UUID 00000003-0000-1000-8000-00805f9
> >> bluetoothd[1475]: Record pattern UUID 00000100-0000-1000-8000-00805f9
> >> bluetoothd[1475]: Record pattern UUID 00001002-0000-1000-8000-00805f9
> >> bluetoothd[1475]: Record pattern UUID 00001108-0000-1000-8000-00805f9
> >> bluetoothd[1475]: Record pattern UUID 00001112-0000-1000-8000-00805f9
> >> bluetoothd[1475]: Record pattern UUID 00001203-0000-1000-8000-00805f9
> >> bluetoothd[1475]: audio.conf: Key file does not have key 'SCORouting'
> >> bluetoothd[1475]: Adding record with handle 0x10001
> >> bluetoothd[1475]: Record pattern UUID 00000003-0000-1000-8000-00805f9
> >> bluetoothd[1475]: Record pattern UUID 00000100-0000-1000-8000-00805f9
> >> bluetoothd[1475]: Record pattern UUID 00001002-0000-1000-8000-00805f9
> >> bluetoothd[1475]: Record pattern UUID 0000111e-0000-1000-8000-00805f9
> >> bluetoothd[1475]: Record pattern UUID 0000111f-0000-1000-8000-00805f9
> >> bluetoothd[1475]: Record pattern UUID 00001203-0000-1000-8000-00805f9
> >> bluetoothd[1475]: Changing service classes to 0x400204
> >> bluetoothd[1475]: a2dp_server_probe: path /org/bluez/1475/hci0
> >> bluetoothd[1475]: audio.conf: Key file does not have key 'Disable'
> >> bluetoothd[1475]: audio.conf: Key file does not have group 'A2DP'
> >> bluetoothd[1475]: audio.conf: Key file does not have group 'A2DP'
> >> bluetoothd[1475]: audio.conf: Key file does not have group 'A2DP'
> >> bluetoothd[1475]: audio.conf: Key file does not have group 'A2DP'
> >> bluetoothd[1475]: audio.conf: Key file does not have key 'Master'
> >> bluetoothd[1475]: SEP 0x2a04fc08 registered: type:0 codec:0 seid:1
> >> bluetoothd[1475]: Adding record with handle 0x10002
> >> bluetoothd[1475]: Record pattern UUID 00000019-0000-1000-8000-00805f9
> >> bluetoothd[1475]: Record pattern UUID 00000100-0000-1000-8000-00805f9
> >> bluetoothd[1475]: Record pattern UUID 00001002-0000-1000-8000-00805f9
> >> bluetoothd[1475]: Record pattern UUID 0000110a-0000-1000-8000-00805f9
> >> bluetoothd[1475]: Record pattern UUID 0000110d-0000-1000-8000-00805f9
> >> bluetoothd[1475]: Changing service classes to 0x480204
> >> bluetoothd[1475]: avrcp_server_probe: path /org/bluez/1475/hci0
> >> bluetoothd[1475]: audio.conf: Key file does not have key 'Master'
> >> bluetoothd[1475]: Adding record with handle 0x10003
> >> bluetoothd[1475]: Record pattern UUID 00000017-0000-1000-8000-00805f9
> >> bluetoothd[1475]: Record pattern UUID 00000100-0000-1000-8000-00805f9
> >> bluetoothd[1475]: Record pattern UUID 00001002-0000-1000-8000-00805f9
> >> bluetoothd[1475]: Record pattern UUID 0000110c-0000-1000-8000-00805f9
> >> bluetoothd[1475]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
> >> bluetoothd[1475]: Changing service classes to 0x480204
> >> bluetoothd[1475]: Adding record with handle 0x10004
> >> bluetoothd[1475]: Record pattern UUID 00000017-0000-1000-8000-00805f9
> >> bluetoothd[1475]: Record pattern UUID 00000100-0000-1000-8000-00805f9
> >> bluetoothd[1475]: Record pattern UUID 00001002-0000-1000-8000-00805f9
> >> bluetoothd[1475]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
> >> bluetoothd[1475]: Changing service classes to 0x480204
> >> bluetoothd[1475]: proxy_probe: path /org/bluez/1475/hci0
> >> bluetoothd[1475]: Registered interface org.bluez.SerialProxyManager on
> >> path /org/bluez/1475/hci0
> >> bluetoothd[1475]: register_interface: path /org/bluez/1475/hci0
> >> bluetoothd[1475]: Registered interface org.bluez.Service on path
> >> /org/bluez/1475/hci0
> >> bluetoothd[1475]: Creating device /org/bluez/1475/hci0/dev_00_1D_FD_E4_42_FF
> >> bluetoothd[1475]: Probe drivers for /org/bluez/1475/hci0/dev_00_1D_FD_E4_42_FF
> >> bluetoothd[1475]: adapter_get_device(00:1D:FD:E4:42:FF)
> >> bluetoothd[1475]: audio handle_uuid: server not enabled for
> >> 00001112-0000-1000-8000-00805f9b34fb (0x1112)
> >> bluetoothd[1475]: audio handle_uuid: server not enabled for
> >> 0000111f-0000-1000-8000-00805f9b34fb (0x111f)
> >> bluetoothd[1475]: audio handle_uuid: server not enabled for
> >> 0000110a-0000-1000-8000-00805f9b34fb (0x110a)
> >> bluetoothd[1475]: Found AV Target
> >> bluetoothd[1475]: Registered interface org.bluez.Control on path
> >> /org/bluez/1475/hci0/dev_00_1D_FD_E4_42_FF
> >> bluetoothd[1475]: Found AV Remote
> >> bluetoothd[1475]: serial_probe: path
> >> /org/bluez/1475/hci0/dev_00_1D_FD_E4_42_FF:
> >> 00000002-0000-1000-8000-0002ee000002
> >> bluetoothd[1475]: Registered interface org.bluez.Serial on path
> >> /org/bluez/1475/hci0/dev_00_1D_FD_E4_42_FF
> >> bluetoothd[1475]: serial_probe: path
> >> /org/bluez/1475/hci0/dev_00_1D_FD_E4_42_FF:
> >> 00001101-0000-1000-8000-00805f9b34fb
> >> bluetoothd[1475]: serial_probe: path
> >> /org/bluez/1475/hci0/dev_00_1D_FD_E4_42_FF:
> >> 00001103-0000-1000-8000-00805f9b34fb
> >> bluetoothd[1475]: serial_probe: path
> >> /org/bluez/1475/hci0/dev_00_1D_FD_E4_42_FF:
> >> 00001105-0000-1000-8000-00805f9b34fb
> >> bluetoothd[1475]: serial_probe: path
> >> /org/bluez/1475/hci0/dev_00_1D_FD_E4_42_FF:
> >> 00001106-0000-1000-8000-00805f9b34fb
> >> bluetoothd[1475]: serial_probe: path
> >> /org/bluez/1475/hci0/dev_00_1D_FD_E4_42_FF:
> >> 00001112-0000-1000-8000-00805f9b34fb
> >> bluetoothd[1475]: serial_probe: path
> >> /org/bluez/1475/hci0/dev_00_1D_FD_E4_42_FF:
> >> 0000111f-0000-1000-8000-00805f9b34fb
> >> bluetoothd[1475]: serial_probe: path
> >> /org/bluez/1475/hci0/dev_00_1D_FD_E4_42_FF:
> >> 0000112d-0000-1000-8000-00805f9b34fb
> >> bluetoothd[1475]: serial_probe: path
> >> /org/bluez/1475/hci0/dev_00_1D_FD_E4_42_FF:
> >> 0000112f-0000-1000-8000-00805f9b34fb
> >> bluetoothd[1475]: serial_probe: path
> >> /org/bluez/1475/hci0/dev_00_1D_FD_E4_42_FF:
> >> 00005002-0000-1000-8000-0002ee000001
> >> bluetoothd[1475]: serial_probe: path
> >> /org/bluez/1475/hci0/dev_00_1D_FD_E4_42_FF:
> >> 00005557-0000-1000-8000-0002ee000001
> >> bluetoothd[1475]: serial_probe: path
> >> /org/bluez/1475/hci0/dev_00_1D_FD_E4_42_FF:
> >> 00005601-0000-1000-8000-0002ee000001
> >> bluetoothd[1475]: headset_probe: path /org/bluez/1475/hci0/dev_00_1D_FD_E4_42_FF
> >> bluetoothd[1475]: probe failed with driver input-headset for device
> >> /org/bluez/1475/hci0/dev_00_1D_FD_E4_42_FF
> >> bluetoothd[1475]: Creating device /org/bluez/1475/hci0/dev_00_21_FB_B4_45_07
> >> bluetoothd[1475]: Probe drivers for /org/bluez/1475/hci0/dev_00_21_FB_B4_45_07
> >> bluetoothd[1475]: adapter_get_device(00:21:FB:B4:45:07)
> >> bluetoothd[1475]: audio handle_uuid: server not enabled for
> >> 00001112-0000-1000-8000-00805f9b34fb (0x1112)
> >> bluetoothd[1475]: audio handle_uuid: server not enabled for
> >> 0000111f-0000-1000-8000-00805f9b34fb (0x111f)
> >> bluetoothd[1475]: audio handle_uuid: server not enabled for
> >> 0000110a-0000-1000-8000-00805f9b34fb (0x110a)
> >> bluetoothd[1475]: Found AV Target
> >> bluetoothd[1475]: Registered interface org.bluez.Control on path
> >> /org/bluez/1475/hci0/dev_00_21_FB_B4_45_07
> >> bluetoothd[1475]: Found AV Target
> >> bluetoothd[1475]: serial_probe: path
> >> /org/bluez/1475/hci0/dev_00_21_FB_B4_45_07:
> >> 00001101-0000-1000-8000-00805f9b34fb
> >> bluetoothd[1475]: Registered interface org.bluez.Serial on path
> >> /org/bluez/1475/hci0/dev_00_21_FB_B4_45_07
> >> bluetoothd[1475]: serial_probe: path
> >> /org/bluez/1475/hci0/dev_00_21_FB_B4_45_07:
> >> 00001105-0000-1000-8000-00805f9b34fb
> >> bluetoothd[1475]: serial_probe: path
> >> /org/bluez/1475/hci0/dev_00_21_FB_B4_45_07:
> >> 00001106-0000-1000-8000-00805f9b34fb
> >> bluetoothd[1475]: serial_probe: path
> >> /org/bluez/1475/hci0/dev_00_21_FB_B4_45_07:
> >> 00001112-0000-1000-8000-00805f9b34fb
> >> bluetoothd[1475]: serial_probe: path
> >> /org/bluez/1475/hci0/dev_00_21_FB_B4_45_07:
> >> 0000111f-0000-1000-8000-00805f9b34fb
> >> bluetoothd[1475]: headset_probe: path /org/bluez/1475/hci0/dev_00_21_FB_B4_45_07
> >> bluetoothd[1475]: probe failed with driver input-headset for device
> >> /org/bluez/1475/hci0/dev_00_21_FB_B4_45_07
> >> bluetoothd[1475]: Adapter /org/bluez/1475/hci0 has been enabled
> >> bluetoothd[1475]: child 1476 exited
> >> bluetoothd[1475]: Failed to access HAL
> >>
> >> here is the output to pair the cell phone.
> >>
> >> bluetoothd[1475]: adapter_get_device(00:1D:FD:E4:42:FF)
> >> bluetoothd[1475]: link_key_request (sba=00:19:5D:0F:53:07,
> >> dba=00:1D:FD:E4:42:FF)
> >> bluetoothd[1475]: kernel auth requirements = 0x00
> >> bluetoothd[1475]: stored link key type = 0x00
> >>
> >> During the call, this was the output:
> >>
> >> bluetoothd[1475]: No matching connection found for handle 92
> >>
> >> and here is the finalization output:
> >>
> >> bluetoothd[1475]: Removing adapter /org/bluez/1475/hci0
> >> bluetoothd[1475]: headset_server_remove: path /org/bluez/1475/hci0
> >> bluetoothd[1475]: Removing record with handle 0x10000
> >> bluetoothd[1475]: Removing record with handle 0x10001
> >> bluetoothd[1475]: a2dp_server_remove: path /org/bluez/1475/hci0
> >> bluetoothd[1475]: Removing record with handle 0x10002
> >> bluetoothd[1475]: avrcp_server_remove: path /org/bluez/1475/hci0
> >> bluetoothd[1475]: Removing record with handle 0x10004
> >> bluetoothd[1475]: Removing record with handle 0x10003
> >> bluetoothd[1475]: proxy_remove: path /org/bluez/1475/hci0
> >> bluetoothd[1475]: unregister_interface: path /org/bluez/1475/hci0
> >> bluetoothd[1475]: Removing device /org/bluez/1475/hci0/dev_00_1D_FD_E4_42_FF
> >> bluetoothd[1475]: Unregistered interface org.bluez.Control on path
> >> /org/bluez/1475/hci0/dev_00_1D_FD_E4_42_FF
> >> bluetoothd[1475]: serial_remove: path /org/bluez/1475/hci0/dev_00_1D_FD_E4_42_FF
> >> bluetoothd[1475]: Unregistered interface org.bluez.Serial on path
> >> /org/bluez/1475/hci0/dev_00_1D_FD_E4_42_FF
> >> bluetoothd[1475]: Removing device /org/bluez/1475/hci0/dev_00_21_FB_B4_45_07
> >> bluetoothd[1475]: Unregistered interface org.bluez.Control on path
> >> /org/bluez/1475/hci0/dev_00_21_FB_B4_45_07
> >> bluetoothd[1475]: serial_remove: path /org/bluez/1475/hci0/dev_00_21_FB_B4_45_07
> >> bluetoothd[1475]: Unregistered interface org.bluez.Serial on path
> >> /org/bluez/1475/hci0/dev_00_21_FB_B4_45_07
> >> bluetoothd[1475]: Cleanup plugins
> >> bluetoothd[1475]: unregister_interface: path /org/bluez/1475/any
> >> bluetoothd[1475]: Stopping SDP server
> >> bluetoothd[1475]: Exit
> >>
> >> I hope this can help.
> >>
> >> Tks
> >> Rafael
> >>
> >>
> >> On Wed, May 6, 2009 at 11:48 PM, balaji palaniswami
> >> <balaji_palaniswami@yahoo.com> wrote:
> >>>
> >>> Hi Rafael ,
> >>>
> >>> root@debian:/var/log# bluetoothd -dn
> >>> bluetoothd[1535]: Bluetooth daemon
> >>> bluetoothd[1535]: Enabling debug information
> >>> bluetoothd[1535]: parsing main.conf
> >>> bluetoothd[1535]: discovto=0
> >>> bluetoothd[1535]: pairto=0
> >>> bluetoothd[1535]: pageto=8192
> >>> bluetoothd[1535]: name=Sheeva
> >>> bluetoothd[1535]: class=0x100204
> >>> bluetoothd[1535]: inqmode=0
> >>> bluetoothd[1535]: Key file does not have key 'DeviceID'
> >>> bluetoothd[1535]: Unable to get on D-Bus
> >>>
> >>>
> >>>
> >>> From above log message , daemon is not able to get dbus instance because another bluetooth daemon is already running .
> >>> so stop the already running bluetooth dameon by service stop bluetooth
> >>> then start bluetooth -d -n
> >>>
> >>> Please share your output
> >>> Thanks,
> >>> Balaji.P
> >>>
> >>>
> >>> ----- Original Message ----
> >>> From: Rafael Seste <rseste@gmail.com>
> >>> To: linux-bluetooth@vger.kernel.org
> >>> Sent: Wednesday, 6 May, 2009 8:24:41 PM
> >>> Subject: HSP and HFP no sound
> >>>
> >>> Hi
> >>>
> >>> I'm trying to make bluetooth work in a embedded hw its an arm. I'm
> >>> using HSP and HFP.
> >>> I can scan, pair, make and receive calls but I can hear no sound in
> >>> both directions.
> >>>
> >>> I'm posting some information:
> >>>
> >>> root@debian:/var/log# uname -a
> >>> Linux debian 2.6.22.18 #3 Tue May 5 15:51:47 BRT 2009 armv5tejl GNU/Linux
> >>>
> >>> root@debian:/var/log# apt-cache policy bluez
> >>> bluez:
> >>>  Installed: 4.32-0ubuntu4
> >>>  Candidate: 4.32-0ubuntu4
> >>>  Version table:
> >>> *** 4.32-0ubuntu4 0
> >>>        500 http://ports.ubuntu.com jaunty/main Packages
> >>>        100 /var/lib/dpkg/status
> >>>
> >>> root@debian:/var/log# vi syslog
> >>> May  6 09:34:53 debian kernel: usb 1-1: new full speed USB device
> >>> using ehci_marvell and address 3
> >>> May  6 09:34:53 debian kernel: usb 1-1: configuration #1 chosen from 1 choice
> >>> May  6 09:34:53 debian bluetoothd[1235]: HCI dev 0 registered
> >>> May  6 09:34:54 debian bluetoothd[1235]: HCI dev 0 up
> >>> May  6 09:34:54 debian bluetoothd[1235]: Starting security manager 0
> >>> May  6 09:34:54 debian bluetoothd[1235]: rfcomm_bind: Address already
> >>> in use (98)
> >>> May  6 09:34:54 debian bluetoothd[1235]: audio-headset: Operation not
> >>> permitted (1)
> >>> May  6 09:34:54 debian bluetoothd[1235]: l2cap_bind: Address already in use (98)
> >>> May  6 09:34:54 debian bluetoothd[1235]: audio-a2dp: Operation not permitted (1)
> >>> May  6 09:34:54 debian bluetoothd[1235]: Registered interface
> >>> org.bluez.SerialProxyManager on path /org/bluez/1235/hci0
> >>> May  6 09:34:54 debian bluetoothd[1235]: Registered interface
> >>> org.bluez.Service on path /org/bluez/1235/hci0
> >>> May  6 09:34:54 debian bluetoothd[1235]: Registered interface
> >>> org.bluez.Control on path /org/bluez/1235/hci0/dev_00_1D_FD_E4_42_FF
> >>> May  6 09:34:54 debian bluetoothd[1235]: Registered interface
> >>> org.bluez.Serial on path /org/bluez/1235/hci0/dev_00_1D_FD_E4_42_FF
> >>> May  6 09:34:54 debian bluetoothd[1235]: probe failed with driver
> >>> input-headset for device /org/bluez/1235/hci0/dev_00_1D_FD_E4_42_FF
> >>> May  6 09:34:54 debian bluetoothd[1235]: Registered interface
> >>> org.bluez.Control on path /org/bluez/1235/hci0/dev_00_21_FB_B4_45_07
> >>> May  6 09:34:54 debian bluetoothd[1235]: Registered interface
> >>> org.bluez.Serial on path /org/bluez/1235/hci0/dev_00_21_FB_B4_45_07
> >>> May  6 09:34:54 debian bluetoothd[1235]: probe failed with driver
> >>> input-headset for device /org/bluez/1235/hci0/dev_00_21_FB_B4_45_07
> >>> May  6 09:34:54 debian bluetoothd[1235]: Adapter /org/bluez/1235/hci0
> >>> has been enabled
> >>> May  6 09:34:54 debian bluetoothd[1235]: Failed to access HAL
> >>>
> >>> root@debian:/var/log# hciconfig -a
> >>> hci0:   Type: USB
> >>>        BD Address: 00:19:5D:0F:53:07 ACL MTU: 672:3 SCO MTU: 48:1
> >>>        UP RUNNING PSCAN
> >>>        RX bytes:4082 acl:51 sco:0 events:157 errors:0
> >>>        TX bytes:1715 acl:52 sco:0 commands:72 errors:0
> >>>        Features: 0xff 0x3e 0x85 0x30 0x18 0x18 0x00 0x00
> >>>        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
> >>>        Link policy: RSWITCH HOLD SNIFF PARK
> >>>        Link mode: SLAVE ACCEPT
> >>>        Name: 'Sheeva'
> >>>        Class: 0x480204
> >>>        Service Classes: Capturing, Telephony
> >>>        Device Class: Phone, Cellular
> >>>        HCI Ver: 1.2 (0x2) HCI Rev: 0x1f4 LMP Ver: 1.2 (0x2) LMP Subver: 0x1f4
> >>>        Manufacturer: Integrated System Solution Corp. (57)
> >>>
> >>>
> >>> root@debian:/var/log# hciconfig hci0 voice
> >>> hci0:   Type: USB
> >>>        BD Address: 00:19:5D:0F:53:07 ACL MTU: 672:3 SCO MTU: 48:1
> >>>        Voice setting: 0x0060 (Default Condition)
> >>>        Input Coding: Linear
> >>>        Input Data Format: 2's complement
> >>>        Input Sample Size: 16 bit
> >>>        # of bits padding at MSB: 0
> >>>
> >>> root@debian:/var/log# bluetoothd -dn
> >>> bluetoothd[1535]: Bluetooth daemon
> >>> bluetoothd[1535]: Enabling debug information
> >>> bluetoothd[1535]: parsing main.conf
> >>> bluetoothd[1535]: discovto=0
> >>> bluetoothd[1535]: pairto=0
> >>> bluetoothd[1535]: pageto=8192
> >>> bluetoothd[1535]: name=Sheeva
> >>> bluetoothd[1535]: class=0x100204
> >>> bluetoothd[1535]: inqmode=0
> >>> bluetoothd[1535]: Key file does not have key 'DeviceID'
> >>> bluetoothd[1535]: Unable to get on D-Bus
> >>>
> >>>
> >>>
> >>> --
> >>> Rafael S. Seste
> >>> Eng Computação - Unicamp
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> >>> the body of a message to majordomo@vger.kernel.org
> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>>
> >>>
> >>>
> >>>      Cricket on your mind? Visit the ultimate cricket website. Enter http://beta.cricket.yahoo.com
> >>>
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> >>> the body of a message to majordomo@vger.kernel.org
> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>>
> >>
> >>
> >>
> >> --
> >> Rafael S. Seste
> >> Eng Computação - Unicamp
> >>
> >>
> >>
> >>      Cricket on your mind? Visit the ultimate cricket website. Enter http://beta.cricket.yahoo.com
> >>
> >>
> >
>
>
>
> --
> Rafael S. Seste
> Eng Computação - Unicamp



--
Rafael S. Seste
Eng Computação - Unicamp
