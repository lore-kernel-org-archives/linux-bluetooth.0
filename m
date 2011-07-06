Return-Path: <cyrus@holtmann.org>
Message-Id: <7.0.1.0.2.20110706214918.03262000@gmx.net>
Date: Wed, 06 Jul 2011 21:54:51 +0200
To: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
From: Peter Kornatowski <pkorn@gmx.net>
Subject: Re: Media API with more than one headset
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <7.0.1.0.2.20110629214327.0321b4e0@gmx.net>
References: <7.0.1.0.2.20110622230344.031f5790@gmx.net>
 <BANLkTikuRgeFW-fXckR4ST14idxPSmNP7g@mail.gmail.com>
 <7.0.1.0.2.20110627205517.03250550@gmx.net>
 <BANLkTinFieuN8HSLu8-pTaMix9r48d6HBw@mail.gmail.com>
 <BANLkTimMQcjj3A=cNaUWY4xByY2WrhA9RA@mail.gmail.com>
 <BANLkTiknkbZcS2AASzS_qeXbNJ3_Qa2e1A@mail.gmail.com>
 <7.0.1.0.2.20110629214327.0321b4e0@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

At 22:08 29.06.2011, Peter Kornatowski wrote:
>Hi,
>
>At 00:16 29.06.2011, Lukasz Rymanowski wrote:
>>Hi Luiz,
>>
>>On Tue, Jun 28, 2011 at 11:48 PM, Luiz Augusto von Dentz
>><luiz.dentz@gmail.com> wrote:
>> > Hi Lukasz,
>> >
>> > On Tue, Jun 28, 2011 at 11:07 PM, Lukasz Rymanowski
>> > <lukasz.rymanowski@gmail.com> wrote:
>> >> Hi Peter,
>> >>
>> >> Can you try attached patch ?
>> >> At least you should not lose audio on all the headsets when
>> >> disconnecting one of them.
>> >
>> > Good catch, the headset watch is not registered per device so we have
>> > to do the matching inside the callback like you did, one thing that
>> > perhaps is worth doing is to make the matching before the switch so if
>> > the endpoint has a device then we match it with the device given to
>> > the callback.
>>
>>I thought about it but we can do matching only if transport exist.
>>Second thing is that in state HEADSET_STATE_CONNECTING we are actually
>>interested to do something if transport does not exist yet (look into
>>media_endpoint_set_configuration() )
>>So it looks like different states have different approach.
>>Anyway, let's wait for test result.
>
>
>OK, so the disconnect problem is fixed with the patch. So when one 
>headset disconnects, the other ones stay in playing mode.
>But there are still some issues with (re)connecting headsets into 
>playing mode:
>
>1. When there are at least two "free" endpoints registered and a 
>headset connects, you get an "Operation Not Authorized" (with the 
>simple-endpoint script and with my C-code) and a bluetoothd segfault 
>(just with the simple-endpoint script) when you try to call 
>"Acquire" to put the headset in playing mode and get the fd.
>For example: Register 3 endpoints with the script by modifying it like this:
>
>         path1 = manager.FindAdapter(sys.argv[1])
>         media1 = dbus.Interface(bus.get_object("org.bluez", path1), 
> "org.bluez.Media")
>         path1 = "/test/endpoint1"
>         endpoint1 = Endpoint(bus, path1)
>         path2 = manager.FindAdapter(sys.argv[2])
>         media2 = dbus.Interface(bus.get_object("org.bluez", path2), 
> "org.bluez.Media")
>         path2 = "/test/endpoint2"
>         endpoint2 = Endpoint(bus, path2)
>         path3 = manager.FindAdapter(sys.argv[3])
>         media3 = dbus.Interface(bus.get_object("org.bluez", path3), 
> "org.bluez.Media")
>         path3 = "/test/endpoint3"
>         endpoint3 = Endpoint(bus, path3)
>         mainloop = gobject.MainLoop()
>         properties = dbus.Dictionary({ "UUID" : HFP_AG_UUID, 
> "Codec" : PCM_CODEC, "Capabilities" :  PCM_CONFIGURATION })
>         print properties
>         media1.RegisterEndpoint(path1, properties)
>         media2.RegisterEndpoint(path2, properties)
>         media3.RegisterEndpoint(path3, properties)
>         mainloop.run()
>
>Don't forget to add calling "Acquire" in SetConfiguration like this 
>(see my first mail):
>         media_transport = 
> dbus.Interface(bus.get_object("org.bluez", transport), 
> "org.bluez.MediaTransport")
>         media_transport.Acquire("rw", reply_handler=acquire_cb, 
> error_handler=acquire_error)
>
>Then connect a headset and you get:
>
>./simple-endpoint hci0 hci1 hci2
>dbus.Dictionary({'Codec': dbus.Byte(0), 'UUID': 
>'0000111F-0000-1000-8000-00805F9B34FB', 'Capabilities': 
>dbus.Array([], signature=dbus.Signature('ay'))}, signature=None)
>SetConfiguration (/org/bluez/7917/hci0/dev_00_23_7F_45_2A_6C/fd0, 
>dbus.Dictionary({dbus.String(u'NREC'): dbus.Boolean(True, 
>variant_level=1), dbus.String(u'UUID'): 
>dbus.String(u'0000111F-0000-1000-8000-00805F9B34FB', 
>variant_level=1), dbus.String(u'InbandRingtone'): dbus.Boolean(True, 
>variant_level=1), dbus.String(u'Codec'): dbus.Byte(0, 
>variant_level=1), dbus.String(u'Routing'): dbus.String(u'HCI', 
>variant_level=1), dbus.String(u'Device'): 
>dbus.ObjectPath('/org/bluez/7917/hci0/dev_00_23_7F_45_2A_6C', 
>variant_level=1), dbus.String(u'Configuration'): dbus.Array([], 
>signature=dbus.Signature('y'), variant_level=1)}, 
>signature=dbus.Signature('sv')))
>SetConfiguration (/org/bluez/7917/hci0/dev_00_23_7F_45_2A_6C/fd1, 
>dbus.Dictionary({dbus.String(u'NREC'): dbus.Boolean(True, 
>variant_level=1), dbus.String(u'UUID'): 
>dbus.String(u'0000111F-0000-1000-8000-00805F9B34FB', 
>variant_level=1), dbus.String(u'InbandRingtone'): dbus.Boolean(True, 
>variant_level=1), dbus.String(u'Codec'): dbus.Byte(0, 
>variant_level=1), dbus.String(u'Routing'): dbus.String(u'HCI', 
>variant_level=1), dbus.String(u'Device'): 
>dbus.ObjectPath('/org/bluez/7917/hci0/dev_00_23_7F_45_2A_6C', 
>variant_level=1), dbus.String(u'Configuration'): dbus.Array([], 
>signature=dbus.Signature('y'), variant_level=1)}, 
>signature=dbus.Signature('sv')))
>SetConfiguration (/org/bluez/7917/hci0/dev_00_23_7F_45_2A_6C/fd2, 
>dbus.Dictionary({dbus.String(u'NREC'): dbus.Boolean(True, 
>variant_level=1), dbus.String(u'UUID'): 
>dbus.String(u'0000111F-0000-1000-8000-00805F9B34FB', 
>variant_level=1), dbus.String(u'InbandRingtone'): dbus.Boolean(True, 
>variant_level=1), dbus.String(u'Codec'): dbus.Byte(0, 
>variant_level=1), dbus.String(u'Routing'): dbus.String(u'HCI', 
>variant_level=1), dbus.String(u'Device'): 
>dbus.ObjectPath('/org/bluez/7917/hci0/dev_00_23_7F_45_2A_6C', 
>variant_level=1), dbus.String(u'Configuration'): dbus.Array([], 
>signature=dbus.Signature('y'), variant_level=1)}, 
>signature=dbus.Signature('sv')))
>Acquire failed: org.bluez.Error.NotAuthorized: Operation Not Authorized
>
>In addition, bluetoothd segfaults: bluetoothd[7917]: segfault at 4d 
>ip b7589e11 sp bfe4f190 error 4 in libdbus-1.so.3.5.5[b7576000+3c000]
>
>With my C-code I also get "Operation Not Authorized", but not the 
>segfault. See attached logs "hs_connect_python_onp.syslog" and 
>"hs_connect_c_onp.syslog".
>
>
>2. This problem occurs just in my C-code: There are 3 endpoints and 
>3 headsets are in playing mode. I turn off 1 headset, it disconnects 
>and after some time I turn it on again. It reconnects and is 
>automatically put back in playing mode because bluez calls 
>SetConfiguration (probably because there is only 1 "free" endpoint 
>it calls on the right one) and there "Acquire" is called and the 
>headset goes into playing mode. At least this is how it works with 
>the simple-endpoint script (log for that ist 
>"hs_reconnect_python.syslog"). But in my C-code (although it makes 
>exactly the same as the python-script), I always get 
>"bluetoothd[28181]: sco_bind: Address already in use (98)" (see 
>"hs_reconnect_c.syslog"). Only when trying to put it in playing mode 
>for the first time after application start it works fine. Any ideas?
>
>
>
>> >
>> >
>> > --
>> > Luiz Augusto von Dentz
>> >
>>
>>/Lukasz
>>--
>
>Thanks,
>Peter

I downloaded and checked the new bluez version 4.95. I'm wondering 
why the patch of Lukasz didn't get applied? As I wrote in my last 
e-mail, it works for not losing playing mode of all headsets when 
disconnecting just one.

Did someone of you had a chance to look into the other problems I 
wrote about in my last e-mail? This would help me a lot.

Thanks,
Peter 

