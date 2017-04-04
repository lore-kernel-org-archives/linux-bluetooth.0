Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Wong, Joshua Weng Onn" <joshua.weng.onn.wong@intel.com>
To: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Subject: RE: Bluetooth PAN Connection - NAP and GN
Date: Tue, 4 Apr 2017 07:51:36 +0000
Message-ID: <E3B98393E6037849B63EA428240A65136126D7@PGSMSX103.gar.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> > > > On Tuesday 09 February 2016 13:17:56 Jon Hoffman wrote:
> > > > > Hello,
> > > > > I am hoping that someone on this list can tell me what I am
> > > > > doing wrong or at least point me in the right direction.
> > > > >
> > > > > As part of a number of proof-of-concepts, I am trying to setup a
> > > > > PAN between two devices.  For this particular proof-of-concepts
> > > > > I am trying to setup a Bluetooth Legacy connection.  I have
> > > > > successfully setup this connection using the NAP scenario
> > > > > however we are not looking to route anything outside of
> > > > > connection.  Since we do not want to route (security also says
> > > > > we need to disable
> > > > > routing) we would prefer to use either a GN (Group Ad-Hoc
> > > > > Network) or a PANU-PANU connection however I have been unable to
> > > get
> > > > > this to work.
> > > > >
> > > > > My slave device (where the server is being setup at) is running
> > > > > the Linux kernel 4.4 (also tried it on a 4.1.13 kernel) with
> > > > > Bluez
> > > > > 5.35 (tried it with 5.23 on the 4.1.13 kernel).  I have tried
> > > > > three master devices (device making the connection) and have the
> > > > > same issue with all
> > > > three.  They are:
> > > > > -Linux kernel 4.1.13 with bluez 5.23 using blueman as the UI
> > > > >   -Windows 10
> > > > >   -iOS 9.2.1
> > > > >
> > > > > I have run hcidump to see what is going on during the
> > > > > pairing/connection of the NAP connection and also the GN
> > > > > connection to
> > > > see what is different.
> > > > > Below are sniplets of what I am seeing.  For the NAP connection
> > > > > I am seeing
> > > > > this:
> > > > >
> > > > > information about the NAP from the hcidump
> > > > >            record #6
> > > > >               aid 0x0000 (SrvRecHndl)
> > > > >                  uint 0x10007
> > > > >               aid 0x0001 (SrvClassIDList)
> > > > >                  < uuid-16 0x1116 (NAP) >
> > > > >               aid 0x0004 (ProtocolDescList)
> > > > >                  < < uuid-16 0x0100 (L2CAP) uint 0xf > <
> > > > >                  uuid-16 0x000f (BNEP) uint 0x100 < uint 0x800
> > > > > uint
> > > > > 0x806 >
> > > > > > > aid 0x0005 (BrwGrpList)
> > > > >                  < uuid-16 0x1002 (PubBrwsGrp) >
> > > > >               aid 0x0006 (LangBaseAttrIDList)
> > > > >                  < uint 0x656e uint 0x6a uint 0x100 >
> > > > >               aid 0x0009 (BTProfileDescList)
> > > > >                  < < uuid-16 0x1116 (NAP) uint 0x100 > >
> > > > >               aid 0x0100 (SrvName)
> > > > >                  str "Network service"
> > > > >               aid 0x0101 (SrvDesc)
> > > > >                  str "Network service"
> > > > >               aid 0x030a (SecurityDescription)
> > > > >                  uint 0x1
> > > > >               aid 0x030b (NetAccessType)
> > > > >                  uint 0xfffe
> > > > >               aid 0x030c (MaxNetAccessRate)
> > > > >                  uint 0x0
> > > > >
> > > > > Then for the actual connection attempt I see this:
> > > > > > ACL data: handle 11 flags 0x02 dlen 12
> > > > >
> > > > >     L2CAP(s): Connect req: psm 15 scid 0x0041 < ACL data: handle
> > > > > 11 flags 0x00 dlen 16
> > > > >     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 1 statu=
s 2
> > > > >       Connection pending - Authorization pending < ACL data:
> > > > > handle
> > > > > 11 flags 0x00 dlen 16
> > > > >     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 statu=
s 0
> > > > >       Connection successful
> > > > >
> > > > > And after this my connection is established and all is well.
> > > > > For the GN network this is what I am seeing beginning with the
> > > > > information about the GN.
> > > > >
> > > > >            record #6
> > > > >               aid 0x0000 (SrvRecHndl)
> > > > >                  uint 0x10007
> > > > >               aid 0x0001 (SrvClassIDList)
> > > > >                  < uuid-16 0x1117 (GN) >
> > > > >               aid 0x0004 (ProtocolDescList)
> > > > >                  < < uuid-16 0x0100 (L2CAP) uint 0xf > <
> > > > >                  uuid-16 0x000f (BNEP) uint 0x100 < uint 0x800
> > > > > uint
> > > > > 0x806 >
> > > > > > > aid 0x0005 (BrwGrpList)
> > > > >                  < uuid-16 0x1002 (PubBrwsGrp) >
> > > > >               aid 0x0006 (LangBaseAttrIDList)
> > > > >                  < uint 0x656e uint 0x6a uint 0x100 >
> > > > >               aid 0x0009 (BTProfileDescList)
> > > > >                  < < uuid-16 0x1117 (GN) uint 0x100 > >
> > > > >               aid 0x0100 (SrvName)
> > > > >                  str "Network service"
> > > > >               aid 0x0101 (SrvDesc)
> > > > >                  str "Network service"
> > > > >               aid 0x030a (SecurityDescription)
> > > > >                  uint 0x1
> > > > >
> > > > > and when the connection is made I see this:
> > > > > > ACL data: handle 11 flags 0x02 dlen 12
> > > > >
> > > > >     L2CAP(s): Connect req: psm 15 scid 0x0041 < ACL data: handle
> > > > > 11 flags 0x00 dlen 16
> > > > >     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 1 statu=
s 2
> > > > >       Connection pending - Authorization pending < ACL data:
> > > > > handle
> > > > > 11 flags 0x00 dlen 16
> > > > >     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 3 statu=
s 0
> > > > >       Connection refused - security block
> > > >
> > > > This looks like connection was rejected due to missing authorizatio=
n.
> > > > Are you sure you have default agent registered in your system?
> > > >
> > > > Providing also 'bluetoothd -n -d'  logs would put some light on thi=
s issue.
> > > >
> > > > --
> > > > pozdrawiam
> > > > Szymon Janc
> > >
> > >
> > > Hello,
> > > Thank you for the reply.  Sorry for my inexperience but I believe I
> > > have the default agent registered because the NAP service works
> > > perfectly.  It is only the GN that does not work.  Would the agent
> > > be different and if so how would I verify?  I was elected to develop
> > > various proof of concepts for PAN over Bluetooth and Bluetooth Smart
> > > more for my networking/Sys- Admin/development background and not
> > > really for any Bluetooth experience.
> > > This is what is outputted from the 'bluetooth -n -d' when I register
> > > the GN
> > > service:
> > >
> > >
> > >      bluetoothd[3307]: src/adapter.c:adapter_service_add() /org/bluez=
/hci0
> > >      bluetoothd[3307]: src/sdpd-service.c:add_record_to_server()
> > > Adding record with handle 0x10009
> > >      bluetoothd[3307]: src/sdpd-service.c:add_record_to_server()
> > > Record pattern UUID 0000000f-0000-1000-8000-00805f9
> > >      bluetoothd[3307]: src/sdpd-service.c:add_record_to_server()
> > > Record pattern UUID 00000100-0000-1000-8000-00805f9
> > >      bluetoothd[3307]: src/sdpd-service.c:add_record_to_server()
> > > Record pattern UUID 00001002-0000-1000-8000-00805f9
> > >      bluetoothd[3307]: src/sdpd-service.c:add_record_to_server()
> > > Record pattern UUID 00001117-0000-1000-8000-00805f9
> > >      bluetoothd[3307]: src/adapter.c:adapter_service_insert()
> > /org/bluez/hci0
> > >      bluetoothd[3307]: src/adapter.c:add_uuid() sending add uuid
> > > command for index 0
> > >      bluetoothd[3307]:
> > > profiles/network/server.c:register_server_record() got record id 0x10=
009
> > >      bluetoothd[3307]: src/adapter.c:dev_class_changed_callback() Cla=
ss:
> > > 0x2e0000
> > >
> > > This is what I see when I attempt to connect to the service:
> > >
> > >      bluetoothd[3307]: src/adapter.c:connected_callback() hci0
> > > device 5C:F3:70:XX:XX:XX connected eir_len 13
> > >      bluetoothd[3307]: src/adapter.c:new_link_key_callback() hci0
> > > new key for 5C:F3:70:XX:XX:XX type 4 pin_len 0 store_hint 1
> > >      bluetoothd[3307]: src/device.c:device_set_bonded()
> > >      bluetoothd[3307]: src/device.c:device_bonding_complete()
> > > bonding
> > > (nil) status 0x00
> > >      bluetoothd[3307]: src/adapter.c:resume_discovery()
> > >      bluetoothd[3307]: src/adapter.c:dev_disconnected() Device
> > > 5C:F3:70:XX:XX:XX disconnected, reason 3
> > >      bluetoothd[3307]: src/adapter.c:adapter_remove_connection()
> > >      bluetoothd[3307]: plugins/policy.c:disconnect_cb() reason 3
> > >      bluetoothd[3307]: src/adapter.c:bonding_attempt_complete() hci0
> > > bdaddr 5C:F3:70:XX:XX:XX type 0 status 0xe
> > >      bluetoothd[3307]: src/device.c:device_bonding_complete()
> > > bonding
> > > (nil) status 0x0e
> > >      bluetoothd[3307]: src/device.c:device_bonding_failed() status 14
> > >      bluetoothd[3307]: src/adapter.c:resume_discovery()
> > >      bluetoothd[3307]: src/adapter.c:connected_callback() hci0
> > > device 5C:F3:70:XX:XX:XX connected eir_len 13
> > >      bluetoothd[3307]: profiles/network/server.c:confirm_event() BNEP=
:
> > > incoming connect from 5C:F3:70:XX:XX:XX
> > >      bluetoothd[3307]: src/adapter.c:dev_disconnected() Device
> > > 5C:F3:70:XX:XX:XX disconnected, reason 3
> > >      bluetoothd[3307]: src/adapter.c:adapter_remove_connection()
> > >      bluetoothd[3307]: plugins/policy.c:disconnect_cb() reason 3
> > >      bluetoothd[3307]: src/adapter.c:bonding_attempt_complete() hci0
> > > bdaddr 5C:F3:70:XX:XX:XX type 0 status 0xe
> > >      bluetoothd[3307]: src/device.c:device_bonding_complete()
> > > bonding
> > > (nil) status 0x0e
> > >      bluetoothd[3307]: src/device.c:device_bonding_failed() status 14
> > >      bluetoothd[3307]: src/adapter.c:resume_discovery()
> > >
> > > On the fourth line it looks like the bonding is coming back as nil
> > > which can't be good.  Is that the issue and what would cause that
> > > (sorry for the very basic questions)?
> > >
> > > Thanks for the help,
> > >
> > > Jon
> >
> > This morning I decided to run the bluetoothd in debug mode as Szymon
> > recommended and analyze output for the both the NAP (service that
> > works) and GN (service that does not work) services.  I also decided
> > that I would break it down into three parts:  Setting up the service,
> > Pairing and Connecting to the service.  Here are my results:
> >
> > Setting up the services:
> >      The output from setting up the services are almost identical.
> > The only difference is these lines:
> >      NAP service
> >          bluetoothd[1964]: src/sdpd-service.c:add_record_to_server()
> > Record pattern UUID 00001116-0000-1000-8000-00805f9
> >      GN service
> >          bluetoothd[1981]: src/sdpd-service.c:add_record_to_server()
> > Record pattern UUID 00001117-0000-1000-8000-00805f9
> >
> >      Here are the full results:
> >      NAP service
> >           bluetoothd[1964]: src/adapter.c:adapter_service_add() /org/bl=
uez/hci0
> >           bluetoothd[1964]: src/sdpd-service.c:add_record_to_server()
> > Adding record with handle 0x10009
> >           bluetoothd[1964]: src/sdpd-service.c:add_record_to_server()
> > Record pattern UUID 0000000f-0000-1000-8000-00805f9
> >           bluetoothd[1964]: src/sdpd-service.c:add_record_to_server()
> > Record pattern UUID 00000100-0000-1000-8000-00805f9
> >           bluetoothd[1964]: src/sdpd-service.c:add_record_to_server()
> > Record pattern UUID 00001002-0000-1000-8000-00805f9
> >           bluetoothd[1964]: src/sdpd-service.c:add_record_to_server()
> > Record pattern UUID 00001116-0000-1000-8000-00805f9
> >           bluetoothd[1964]: src/adapter.c:adapter_service_insert()
> > /org/bluez/hci0
> >           bluetoothd[1964]: src/adapter.c:add_uuid() sending add uuid
> > command for index 0
> >           bluetoothd[1964]:
> > profiles/network/server.c:register_server_record()
> > got record id 0x10009
> >           bluetoothd[1964]: src/adapter.c:dev_class_changed_callback() =
Class:
> > 0x2e0000
> >
> >      GN service
> >           bluetoothd[1981]: src/adapter.c:adapter_service_add() /org/bl=
uez/hci0
> >           bluetoothd[1981]: src/sdpd-service.c:add_record_to_server()
> > Adding record with handle 0x10009
> >           bluetoothd[1981]: src/sdpd-service.c:add_record_to_server()
> > Record pattern UUID 0000000f-0000-1000-8000-00805f9
> >           bluetoothd[1981]: src/sdpd-service.c:add_record_to_server()
> > Record pattern UUID 00000100-0000-1000-8000-00805f9
> >           bluetoothd[1981]: src/sdpd-service.c:add_record_to_server()
> > Record pattern UUID 00001002-0000-1000-8000-00805f9
> >           bluetoothd[1981]: src/sdpd-service.c:add_record_to_server()
> > Record pattern UUID 00001117-0000-1000-8000-00805f9
> >           bluetoothd[1981]: src/adapter.c:adapter_service_insert()
> > /org/bluez/hci0
> >           bluetoothd[1981]: src/adapter.c:add_uuid() sending add uuid
> > command for index 0
> >           bluetoothd[1981]:
> > profiles/network/server.c:register_server_record()
> > got record id 0x10009
> >           bluetoothd[1981]: src/adapter.c:dev_class_changed_callback() =
Class:
> > 0x2e0000
> >
> >
> > Pairing:
> >      These output from the pairing request, as expected is exactly the =
same.
> > Here is the full output:
> >      NAP service:
> >           bluetoothd[1964]: src/adapter.c:connected_callback() hci0
> > device
> > 5C:F3:70:66:43:58 connected eir_len 13
> >           bluetoothd[1964]: src/adapter.c:new_link_key_callback() hci0
> > new key for 5C:F3:70:66:43:58 type 4 pin_len 0 store_hint 1
> >           bluetoothd[1964]: src/device.c:device_set_bonded()
> >           bluetoothd[1964]: src/device.c:device_bonding_complete()
> > bonding
> > (nil) status 0x00
> >           bluetoothd[1964]: src/adapter.c:resume_discovery()
> >           bluetoothd[1964]: src/adapter.c:dev_disconnected() Device
> > 5C:F3:70:66:43:58 disconnected, reason 3
> >           bluetoothd[1964]: src/adapter.c:adapter_remove_connection()
> >           bluetoothd[1964]: plugins/policy.c:disconnect_cb() reason 3
> >           bluetoothd[1964]: src/adapter.c:bonding_attempt_complete()
> > hci0 bdaddr 5C:F3:70:66:43:58 type 0 status 0xe
> >           bluetoothd[1964]: src/device.c:device_bonding_complete()
> > bonding
> > (nil) status 0x0e
> >           bluetoothd[1964]: src/device.c:device_bonding_failed() status=
 14
> >           bluetoothd[1964]: src/adapter.c:resume_discovery()
> >
> >
> >      GN service:
> >           bluetoothd[1981]: src/adapter.c:connected_callback() hci0
> > device
> > 5C:F3:70:66:43:58 connected eir_len 13
> >           bluetoothd[1981]: src/adapter.c:new_link_key_callback() hci0
> > new key for 5C:F3:70:66:43:58 type 4 pin_len 0 store_hint 1
> >           bluetoothd[1981]: src/device.c:device_set_bonded()
> >           bluetoothd[1981]: src/device.c:device_bonding_complete()
> > bonding
> > (nil) status 0x00
> >           bluetoothd[1981]: src/adapter.c:resume_discovery()
> >           bluetoothd[1981]: src/adapter.c:dev_disconnected() Device
> > 5C:F3:70:66:43:58 disconnected, reason 3
> >           bluetoothd[1981]: src/adapter.c:adapter_remove_connection()
> >           bluetoothd[1981]: plugins/policy.c:disconnect_cb() reason 3
> >           bluetoothd[1981]: src/adapter.c:bonding_attempt_complete()
> > hci0 bdaddr 5C:F3:70:66:43:58 type 0 status 0xe
> >           bluetoothd[1981]: src/device.c:device_bonding_complete()
> > bonding
> > (nil) status 0x0e
> >           bluetoothd[1981]: src/device.c:device_bonding_failed() status=
 14
> >           bluetoothd[1981]: src/adapter.c:resume_discovery()
> >
> > Connecting:
> >      The output from the connecting request, also as expected, is
> > quite a bit different.  The first two lines are the same but then they
> > differ.  The output from the NAP service indicates that the service is
> > supported within Bluez
> > (profiles/network/bnep.c:bnep_getsuppfeat() supported features: 0x1)
> > while the GN service receives a disconnect
> > (src/adapter.c:dev_disconnected() Device 5C:F3:70:66:43:58
> > disconnected, reason 3).  Here is the full output:
> >      NAP service:
> >           bluetoothd[1964]: src/adapter.c:connected_callback() hci0
> > device
> > 5C:F3:70:66:43:58 connected eir_len 13
> >           bluetoothd[1964]: profiles/network/server.c:confirm_event() B=
NEP:
> > incoming connect from 5C:F3:70:66:43:58
> >           bluetoothd[1964]: profiles/network/bnep.c:bnep_getsuppfeat()
> > supported features: 0x1
> >           bluetoothd[1964]: bnep: bridge pan0: interface
> > enx5cf37066433d added
> >
> >      GN service:
> >           bluetoothd[1981]: src/adapter.c:connected_callback() hci0
> > device
> > 5C:F3:70:66:43:58 connected eir_len 13
> >           bluetoothd[1981]: profiles/network/server.c:confirm_event() B=
NEP:
> > incoming connect from 5C:F3:70:66:43:58
> >           bluetoothd[1981]: src/adapter.c:dev_disconnected() Device
> > 5C:F3:70:66:43:58 disconnected, reason 3
> >           bluetoothd[1981]: src/adapter.c:adapter_remove_connection()
> >           bluetoothd[1981]: plugins/policy.c:disconnect_cb() reason 3
> >           bluetoothd[1981]: src/adapter.c:bonding_attempt_complete()
> > hci0 bdaddr 5C:F3:70:66:43:58 type 0 status 0xe
> >           bluetoothd[1981]: src/device.c:device_bonding_complete()
> > bonding
> > (nil) status 0x0e
> >           bluetoothd[1981]: src/device.c:device_bonding_failed() status=
 14
> >           bluetoothd[1981]: src/adapter.c:resume_discovery()
> >
> >
> > Looking at this output it appears to me, please correct me if I am
> > wrong, that Bluez 5.35 does not support the Group Network (GN)
> > scenario within the PAN profile.  I came to that conclusion because
> > within the NAP scenario it reaches the bnep_getsuppfeat() method which
> > I assume is the get supported feature while within the GN scenario it
> > does not.  If that is the case, should I file a bug?  However if I am
> > wrong, can someone tell me what is going wrong.
> > Thanks for the help and any advice would be appreciated.
>=20
> Can someone tell me the proper channel to report a bug for the issue I am
> having?  I have confirmed that the same issue happens with the broadcomm
> BCM20702,
> Realtek RTL8723 and a Cambridge Silicon Radio Bluetooth dongle.  Setting =
up a
> NAP works on all three devices while the GN gives the error that I docume=
nted in
> this e-mail thread.  I have also verified that the error occurs on the 4.=
4 and 4.2
> kernel.   The bluez versions that I am using is the 5.35 and 5.23.
>=20
> Thanks,

I would like to follow up with this issue. I am also testing the Group Netw=
ork (GN) with PANU using the following steps:

Master side:
1. ./test-gn (registers the UUID service 0x1117 for GN)
2. Perform pairing between the master and slave device via bluetoothctl

Slave side:
1. Accept the pairing via bluetoothctl
2. ./test-network <MASTER_BT_MAC> gn

On btmon, I observe an output which says "Connection refused - security blo=
ck" which is the same message encountered by Jon.

> ACL Data RX: Handle 1 flags 0x02 dlen 16                                [=
hci0] 6608.309405
      L2CAP: Connection Response (0x03) ident 3 len 8
        Destination CID: 64
        Source CID: 64
        Result: Connection pending (0x0001)
        Status: Authorization pending (0x0002)
> ACL Data RX: Handle 1 flags 0x02 dlen 16                                [=
hci0] 6608.364566
      L2CAP: Connection Response (0x03) ident 3 len 8
        Destination CID: 64
        Source CID: 64
        Result: Connection refused - security block (0x0003)
        Status: No further information available (0x0000)
< HCI Command: Disconnect (0x01|0x0006) plen 3                            [=
hci0] 6610.367786
        Handle: 1
        Reason: Remote User Terminated Connection (0x13)
> HCI Event: Command Status (0x0f) plen 4                                 [=
hci0] 6610.368878
      Disconnect (0x01|0x0006) ncmd 1
        Status: Success (0x00)
> HCI Event: Disconnect Complete (0x05) plen 4                            [=
hci0] 6610.420389
        Status: Success (0x00)
        Handle: 1
        Reason: Connection Terminated By Local Host (0x16)
@ Device Disconnected: 74:C6:3B:AB:68:E0 (0) reason 2

I have added the Network1 and NetworkServer1 interfaces in my dbus configur=
ation file in /etc/dbus-1/system.d/bluetooth.conf on both the master and sl=
ave device but am still facing the message.
I have also trusted each device via bluetoothctl on the master and slave.

Has anyone successfully tested out this PAN scenario involving GN and PANU =
connection? What additional settings should we change to create this connec=
tion?

Thank you.

~Joshua
