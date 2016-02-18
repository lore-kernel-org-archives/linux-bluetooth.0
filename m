Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jon Hoffman <Jon.Hoffman@myfuelmaster.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Thu, 18 Feb 2016 13:38:39 -0500
Subject: RE: Bluetooth PAN Connection - NAP and GN
Message-ID: <3916CF28FA2C014B862815C318D03FF5A0A7493B33@Courier.syntech.org>
References: <3916CF28FA2C014B862815C318D03FF5A0A7493B03@Courier.syntech.org>
 <2478946.W935PEPn7x@ix>
 <3916CF28FA2C014B862815C318D03FF5A0A7493B1E@Courier.syntech.org>
 <3916CF28FA2C014B862815C318D03FF5A0A7493B20@Courier.syntech.org>
In-Reply-To: <3916CF28FA2C014B862815C318D03FF5A0A7493B20@Courier.syntech.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Can someone tell me the proper channel to report a bug for the issue I am having?  I have confirmed that the same issue happens with the broadcomm BCM20702,
Realtek RTL8723 and a Cambridge Silicon Radio Bluetooth dongle.  Setting up a NAP works on all three devices while the GN gives the error that I documented in this e-mail thread.  I have also verified that the error occurs on the 4.4 and 4.2 kernel.   The bluez versions that I am using is the 5.35 and 5.23.

Thanks,

Jon

> -----Original Message-----
> From: Jon Hoffman
> Sent: Monday, February 15, 2016 10:27 AM
> To: 'Szymon Janc' <szymon.janc@codecoup.pl>
> Cc: linux-bluetooth@vger.kernel.org
> Subject: RE: Bluetooth PAN Connection - NAP and GN
>
> > > Hi,
> > >
> > > On Tuesday 09 February 2016 13:17:56 Jon Hoffman wrote:
> > > > Hello,
> > > > I am hoping that someone on this list can tell me what I am doing
> > > > wrong or at least point me in the right direction.
> > > >
> > > > As part of a number of proof-of-concepts, I am trying to setup a
> > > > PAN between two devices.  For this particular proof-of-concepts I
> > > > am trying to setup a Bluetooth Legacy connection.  I have
> > > > successfully setup this connection using the NAP scenario however
> > > > we are not looking to route anything outside of connection.  Since
> > > > we do not want to route (security also says we need to disable
> > > > routing) we would prefer to use either a GN (Group Ad-Hoc
> > > > Network) or a PANU-PANU connection however I have been unable to
> > get
> > > > this to work.
> > > >
> > > > My slave device (where the server is being setup at) is running
> > > > the Linux kernel 4.4 (also tried it on a 4.1.13 kernel) with Bluez
> > > > 5.35 (tried it with 5.23 on the 4.1.13 kernel).  I have tried
> > > > three master devices (device making the connection) and have the
> > > > same issue with all
> > > three.  They are:
> > > > -Linux kernel 4.1.13 with bluez 5.23 using blueman as the UI
> > > >   -Windows 10
> > > >   -iOS 9.2.1
> > > >
> > > > I have run hcidump to see what is going on during the
> > > > pairing/connection of the NAP connection and also the GN
> > > > connection to
> > > see what is different.
> > > > Below are sniplets of what I am seeing.  For the NAP connection I
> > > > am seeing
> > > > this:
> > > >
> > > > information about the NAP from the hcidump
> > > >            record #6
> > > >               aid 0x0000 (SrvRecHndl)
> > > >                  uint 0x10007
> > > >               aid 0x0001 (SrvClassIDList)
> > > >                  < uuid-16 0x1116 (NAP) >
> > > >               aid 0x0004 (ProtocolDescList)
> > > >                  < < uuid-16 0x0100 (L2CAP) uint 0xf > <
> > > >                  uuid-16 0x000f (BNEP) uint 0x100 < uint 0x800
> > > > uint
> > > > 0x806 >
> > > > > > aid 0x0005 (BrwGrpList)
> > > >                  < uuid-16 0x1002 (PubBrwsGrp) >
> > > >               aid 0x0006 (LangBaseAttrIDList)
> > > >                  < uint 0x656e uint 0x6a uint 0x100 >
> > > >               aid 0x0009 (BTProfileDescList)
> > > >                  < < uuid-16 0x1116 (NAP) uint 0x100 > >
> > > >               aid 0x0100 (SrvName)
> > > >                  str "Network service"
> > > >               aid 0x0101 (SrvDesc)
> > > >                  str "Network service"
> > > >               aid 0x030a (SecurityDescription)
> > > >                  uint 0x1
> > > >               aid 0x030b (NetAccessType)
> > > >                  uint 0xfffe
> > > >               aid 0x030c (MaxNetAccessRate)
> > > >                  uint 0x0
> > > >
> > > > Then for the actual connection attempt I see this:
> > > > > ACL data: handle 11 flags 0x02 dlen 12
> > > >
> > > >     L2CAP(s): Connect req: psm 15 scid 0x0041 < ACL data: handle
> > > > 11 flags 0x00 dlen 16
> > > >     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 1 status 2
> > > >       Connection pending - Authorization pending < ACL data:
> > > > handle
> > > > 11 flags 0x00 dlen 16
> > > >     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
> > > >       Connection successful
> > > >
> > > > And after this my connection is established and all is well.  For
> > > > the GN network this is what I am seeing beginning with the
> > > > information about the GN.
> > > >
> > > >            record #6
> > > >               aid 0x0000 (SrvRecHndl)
> > > >                  uint 0x10007
> > > >               aid 0x0001 (SrvClassIDList)
> > > >                  < uuid-16 0x1117 (GN) >
> > > >               aid 0x0004 (ProtocolDescList)
> > > >                  < < uuid-16 0x0100 (L2CAP) uint 0xf > <
> > > >                  uuid-16 0x000f (BNEP) uint 0x100 < uint 0x800
> > > > uint
> > > > 0x806 >
> > > > > > aid 0x0005 (BrwGrpList)
> > > >                  < uuid-16 0x1002 (PubBrwsGrp) >
> > > >               aid 0x0006 (LangBaseAttrIDList)
> > > >                  < uint 0x656e uint 0x6a uint 0x100 >
> > > >               aid 0x0009 (BTProfileDescList)
> > > >                  < < uuid-16 0x1117 (GN) uint 0x100 > >
> > > >               aid 0x0100 (SrvName)
> > > >                  str "Network service"
> > > >               aid 0x0101 (SrvDesc)
> > > >                  str "Network service"
> > > >               aid 0x030a (SecurityDescription)
> > > >                  uint 0x1
> > > >
> > > > and when the connection is made I see this:
> > > > > ACL data: handle 11 flags 0x02 dlen 12
> > > >
> > > >     L2CAP(s): Connect req: psm 15 scid 0x0041 < ACL data: handle
> > > > 11 flags 0x00 dlen 16
> > > >     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 1 status 2
> > > >       Connection pending - Authorization pending < ACL data:
> > > > handle
> > > > 11 flags 0x00 dlen 16
> > > >     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 3 status 0
> > > >       Connection refused - security block
> > >
> > > This looks like connection was rejected due to missing authorization.
> > > Are you sure you have default agent registered in your system?
> > >
> > > Providing also 'bluetoothd -n -d'  logs would put some light on this issue.
> > >
> > > --
> > > pozdrawiam
> > > Szymon Janc
> >
> >
> > Hello,
> > Thank you for the reply.  Sorry for my inexperience but I believe I
> > have the default agent registered because the NAP service works
> > perfectly.  It is only the GN that does not work.  Would the agent be
> > different and if so how would I verify?  I was elected to develop
> > various proof of concepts for PAN over Bluetooth and Bluetooth Smart
> > more for my networking/Sys- Admin/development background and not
> > really for any Bluetooth experience.
> > This is what is outputted from the 'bluetooth -n -d' when I register
> > the GN
> > service:
> >
> >
> >      bluetoothd[3307]: src/adapter.c:adapter_service_add() /org/bluez/hci0
> >      bluetoothd[3307]: src/sdpd-service.c:add_record_to_server()
> > Adding record with handle 0x10009
> >      bluetoothd[3307]: src/sdpd-service.c:add_record_to_server()
> > Record pattern UUID 0000000f-0000-1000-8000-00805f9
> >      bluetoothd[3307]: src/sdpd-service.c:add_record_to_server()
> > Record pattern UUID 00000100-0000-1000-8000-00805f9
> >      bluetoothd[3307]: src/sdpd-service.c:add_record_to_server()
> > Record pattern UUID 00001002-0000-1000-8000-00805f9
> >      bluetoothd[3307]: src/sdpd-service.c:add_record_to_server()
> > Record pattern UUID 00001117-0000-1000-8000-00805f9
> >      bluetoothd[3307]: src/adapter.c:adapter_service_insert()
> /org/bluez/hci0
> >      bluetoothd[3307]: src/adapter.c:add_uuid() sending add uuid
> > command for index 0
> >      bluetoothd[3307]:
> > profiles/network/server.c:register_server_record() got record id 0x10009
> >      bluetoothd[3307]: src/adapter.c:dev_class_changed_callback() Class:
> > 0x2e0000
> >
> > This is what I see when I attempt to connect to the service:
> >
> >      bluetoothd[3307]: src/adapter.c:connected_callback() hci0 device
> > 5C:F3:70:XX:XX:XX connected eir_len 13
> >      bluetoothd[3307]: src/adapter.c:new_link_key_callback() hci0 new
> > key for 5C:F3:70:XX:XX:XX type 4 pin_len 0 store_hint 1
> >      bluetoothd[3307]: src/device.c:device_set_bonded()
> >      bluetoothd[3307]: src/device.c:device_bonding_complete() bonding
> > (nil) status 0x00
> >      bluetoothd[3307]: src/adapter.c:resume_discovery()
> >      bluetoothd[3307]: src/adapter.c:dev_disconnected() Device
> > 5C:F3:70:XX:XX:XX disconnected, reason 3
> >      bluetoothd[3307]: src/adapter.c:adapter_remove_connection()
> >      bluetoothd[3307]: plugins/policy.c:disconnect_cb() reason 3
> >      bluetoothd[3307]: src/adapter.c:bonding_attempt_complete() hci0
> > bdaddr 5C:F3:70:XX:XX:XX type 0 status 0xe
> >      bluetoothd[3307]: src/device.c:device_bonding_complete() bonding
> > (nil) status 0x0e
> >      bluetoothd[3307]: src/device.c:device_bonding_failed() status 14
> >      bluetoothd[3307]: src/adapter.c:resume_discovery()
> >      bluetoothd[3307]: src/adapter.c:connected_callback() hci0 device
> > 5C:F3:70:XX:XX:XX connected eir_len 13
> >      bluetoothd[3307]: profiles/network/server.c:confirm_event() BNEP:
> > incoming connect from 5C:F3:70:XX:XX:XX
> >      bluetoothd[3307]: src/adapter.c:dev_disconnected() Device
> > 5C:F3:70:XX:XX:XX disconnected, reason 3
> >      bluetoothd[3307]: src/adapter.c:adapter_remove_connection()
> >      bluetoothd[3307]: plugins/policy.c:disconnect_cb() reason 3
> >      bluetoothd[3307]: src/adapter.c:bonding_attempt_complete() hci0
> > bdaddr 5C:F3:70:XX:XX:XX type 0 status 0xe
> >      bluetoothd[3307]: src/device.c:device_bonding_complete() bonding
> > (nil) status 0x0e
> >      bluetoothd[3307]: src/device.c:device_bonding_failed() status 14
> >      bluetoothd[3307]: src/adapter.c:resume_discovery()
> >
> > On the fourth line it looks like the bonding is coming back as nil
> > which can't be good.  Is that the issue and what would cause that
> > (sorry for the very basic questions)?
> >
> > Thanks for the help,
> >
> > Jon
>
> This morning I decided to run the bluetoothd in debug mode as Szymon
> recommended and analyze output for the both the NAP (service that works)
> and GN (service that does not work) services.  I also decided that I would
> break it down into three parts:  Setting up the service, Pairing and Connecting
> to the service.  Here are my results:
>
> Setting up the services:
>      The output from setting up the services are almost identical.  The only
> difference is these lines:
>      NAP service
>          bluetoothd[1964]: src/sdpd-service.c:add_record_to_server() Record
> pattern UUID 00001116-0000-1000-8000-00805f9
>      GN service
>          bluetoothd[1981]: src/sdpd-service.c:add_record_to_server() Record
> pattern UUID 00001117-0000-1000-8000-00805f9
>
>      Here are the full results:
>      NAP service
>           bluetoothd[1964]: src/adapter.c:adapter_service_add() /org/bluez/hci0
>           bluetoothd[1964]: src/sdpd-service.c:add_record_to_server() Adding
> record with handle 0x10009
>           bluetoothd[1964]: src/sdpd-service.c:add_record_to_server() Record
> pattern UUID 0000000f-0000-1000-8000-00805f9
>           bluetoothd[1964]: src/sdpd-service.c:add_record_to_server() Record
> pattern UUID 00000100-0000-1000-8000-00805f9
>           bluetoothd[1964]: src/sdpd-service.c:add_record_to_server() Record
> pattern UUID 00001002-0000-1000-8000-00805f9
>           bluetoothd[1964]: src/sdpd-service.c:add_record_to_server() Record
> pattern UUID 00001116-0000-1000-8000-00805f9
>           bluetoothd[1964]: src/adapter.c:adapter_service_insert()
> /org/bluez/hci0
>           bluetoothd[1964]: src/adapter.c:add_uuid() sending add uuid command
> for index 0
>           bluetoothd[1964]: profiles/network/server.c:register_server_record()
> got record id 0x10009
>           bluetoothd[1964]: src/adapter.c:dev_class_changed_callback() Class:
> 0x2e0000
>
>      GN service
>           bluetoothd[1981]: src/adapter.c:adapter_service_add() /org/bluez/hci0
>           bluetoothd[1981]: src/sdpd-service.c:add_record_to_server() Adding
> record with handle 0x10009
>           bluetoothd[1981]: src/sdpd-service.c:add_record_to_server() Record
> pattern UUID 0000000f-0000-1000-8000-00805f9
>           bluetoothd[1981]: src/sdpd-service.c:add_record_to_server() Record
> pattern UUID 00000100-0000-1000-8000-00805f9
>           bluetoothd[1981]: src/sdpd-service.c:add_record_to_server() Record
> pattern UUID 00001002-0000-1000-8000-00805f9
>           bluetoothd[1981]: src/sdpd-service.c:add_record_to_server() Record
> pattern UUID 00001117-0000-1000-8000-00805f9
>           bluetoothd[1981]: src/adapter.c:adapter_service_insert()
> /org/bluez/hci0
>           bluetoothd[1981]: src/adapter.c:add_uuid() sending add uuid command
> for index 0
>           bluetoothd[1981]: profiles/network/server.c:register_server_record()
> got record id 0x10009
>           bluetoothd[1981]: src/adapter.c:dev_class_changed_callback() Class:
> 0x2e0000
>
>
> Pairing:
>      These output from the pairing request, as expected is exactly the same.
> Here is the full output:
>      NAP service:
>           bluetoothd[1964]: src/adapter.c:connected_callback() hci0 device
> 5C:F3:70:66:43:58 connected eir_len 13
>           bluetoothd[1964]: src/adapter.c:new_link_key_callback() hci0 new key
> for 5C:F3:70:66:43:58 type 4 pin_len 0 store_hint 1
>           bluetoothd[1964]: src/device.c:device_set_bonded()
>           bluetoothd[1964]: src/device.c:device_bonding_complete() bonding
> (nil) status 0x00
>           bluetoothd[1964]: src/adapter.c:resume_discovery()
>           bluetoothd[1964]: src/adapter.c:dev_disconnected() Device
> 5C:F3:70:66:43:58 disconnected, reason 3
>           bluetoothd[1964]: src/adapter.c:adapter_remove_connection()
>           bluetoothd[1964]: plugins/policy.c:disconnect_cb() reason 3
>           bluetoothd[1964]: src/adapter.c:bonding_attempt_complete() hci0
> bdaddr 5C:F3:70:66:43:58 type 0 status 0xe
>           bluetoothd[1964]: src/device.c:device_bonding_complete() bonding
> (nil) status 0x0e
>           bluetoothd[1964]: src/device.c:device_bonding_failed() status 14
>           bluetoothd[1964]: src/adapter.c:resume_discovery()
>
>
>      GN service:
>           bluetoothd[1981]: src/adapter.c:connected_callback() hci0 device
> 5C:F3:70:66:43:58 connected eir_len 13
>           bluetoothd[1981]: src/adapter.c:new_link_key_callback() hci0 new key
> for 5C:F3:70:66:43:58 type 4 pin_len 0 store_hint 1
>           bluetoothd[1981]: src/device.c:device_set_bonded()
>           bluetoothd[1981]: src/device.c:device_bonding_complete() bonding
> (nil) status 0x00
>           bluetoothd[1981]: src/adapter.c:resume_discovery()
>           bluetoothd[1981]: src/adapter.c:dev_disconnected() Device
> 5C:F3:70:66:43:58 disconnected, reason 3
>           bluetoothd[1981]: src/adapter.c:adapter_remove_connection()
>           bluetoothd[1981]: plugins/policy.c:disconnect_cb() reason 3
>           bluetoothd[1981]: src/adapter.c:bonding_attempt_complete() hci0
> bdaddr 5C:F3:70:66:43:58 type 0 status 0xe
>           bluetoothd[1981]: src/device.c:device_bonding_complete() bonding
> (nil) status 0x0e
>           bluetoothd[1981]: src/device.c:device_bonding_failed() status 14
>           bluetoothd[1981]: src/adapter.c:resume_discovery()
>
> Connecting:
>      The output from the connecting request, also as expected, is quite a bit
> different.  The first two lines are the same but then they differ.  The output
> from the NAP service indicates that the service is supported within Bluez
> (profiles/network/bnep.c:bnep_getsuppfeat() supported features: 0x1)
> while the GN service receives a disconnect
> (src/adapter.c:dev_disconnected() Device 5C:F3:70:66:43:58 disconnected,
> reason 3).  Here is the full output:
>      NAP service:
>           bluetoothd[1964]: src/adapter.c:connected_callback() hci0 device
> 5C:F3:70:66:43:58 connected eir_len 13
>           bluetoothd[1964]: profiles/network/server.c:confirm_event() BNEP:
> incoming connect from 5C:F3:70:66:43:58
>           bluetoothd[1964]: profiles/network/bnep.c:bnep_getsuppfeat()
> supported features: 0x1
>           bluetoothd[1964]: bnep: bridge pan0: interface enx5cf37066433d added
>
>      GN service:
>           bluetoothd[1981]: src/adapter.c:connected_callback() hci0 device
> 5C:F3:70:66:43:58 connected eir_len 13
>           bluetoothd[1981]: profiles/network/server.c:confirm_event() BNEP:
> incoming connect from 5C:F3:70:66:43:58
>           bluetoothd[1981]: src/adapter.c:dev_disconnected() Device
> 5C:F3:70:66:43:58 disconnected, reason 3
>           bluetoothd[1981]: src/adapter.c:adapter_remove_connection()
>           bluetoothd[1981]: plugins/policy.c:disconnect_cb() reason 3
>           bluetoothd[1981]: src/adapter.c:bonding_attempt_complete() hci0
> bdaddr 5C:F3:70:66:43:58 type 0 status 0xe
>           bluetoothd[1981]: src/device.c:device_bonding_complete() bonding
> (nil) status 0x0e
>           bluetoothd[1981]: src/device.c:device_bonding_failed() status 14
>           bluetoothd[1981]: src/adapter.c:resume_discovery()
>
>
> Looking at this output it appears to me, please correct me if I am wrong, that
> Bluez 5.35 does not support the Group Network (GN) scenario within the
> PAN profile.  I came to that conclusion because within the NAP scenario it
> reaches the bnep_getsuppfeat() method which I assume is the get
> supported feature while within the GN scenario it does not.  If that is the
> case, should I file a bug?  However if I am wrong, can someone tell me what
> is going wrong.
> Thanks for the help and any advice would be appreciated.
>
> Jon
