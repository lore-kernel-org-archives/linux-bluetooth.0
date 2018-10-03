Return-Path: <SRS0=yBkr=MP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD90C00449
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Oct 2018 18:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E438820835
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Oct 2018 18:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOkAK86Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E438820835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbeJDA60 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Oct 2018 20:58:26 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:35725 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbeJDA60 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Oct 2018 20:58:26 -0400
Received: by mail-ot1-f52.google.com with SMTP id j9-v6so6507137otl.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Oct 2018 11:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kvzl8gAopJbzq0eGtlNeNEct057q6SqpIFXJuGnrKVs=;
        b=OOkAK86QaXQEVN+DOcdD7UzmQmxwbMeELlTuupzerW4KBZuX+70nNu1VHfX00QWg3m
         +MZFkZNLh/dK5EwsgPYMigJ+nu4+tclU6dcvZNyaejMY5ZPGzjQV5i9r8DnShuNCqhPs
         /ikj5Mf06A1LUDN5UCF4S7kRi9Rw+UmIXqxbbnl61na+FjaTekeR4TehzglZFQLrPNeP
         4i1bHt4WiiV0TYl67aDMXvNG0YT8WsnhgdqYZ4JTVviF9mwzFBeF4ZWv4Ffcaw+5ClOQ
         H9a63aGBQmw7Jx6sZekBTk7A8mOd+UuHSVzDLwRDsdgyCNwXeJG5ijyBX0n4KQiH7ga2
         seqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kvzl8gAopJbzq0eGtlNeNEct057q6SqpIFXJuGnrKVs=;
        b=Sqkel0Oi4+yu7aznNQpQUGC6+g8YbKtaxd6W9UN76q8ajcBC3YlNmRHHS0ui75oZkh
         pXgByn6y5OFfqZGzg0RL0ydTKHH7GtJslruFiEWZjTIEHPFGqiIG00XTjuixOXgg8uGA
         tzZHLvVfeysrLGlCxUNJMrlTmcgNVB2OiQw+oAUzEcnHbzwAt7FQLnaCqnq2GkAn8XB/
         9hgB5zDouPMchWIp0mULtuhzOwzI3aP0VvrMlz3F1qaPbBu3QxD/5LZrNJ07yOZnReA7
         wa4mqn7lAFnbxle3/cCNnU1He/RUKpP0IlaCU9YJPsYqGS7Tlq35mIGuqFz2+yx31XCG
         0W/Q==
X-Gm-Message-State: ABuFfoiB5b087J308kk6vC9mtO/LAkVdzG2pkXEHqFn+IFmLWLFrAfGq
        WHtsG0cF2mByWYXq6rODA6VD17Z38mCcI7ukPFYGbw==
X-Google-Smtp-Source: ACcGV605YKSAxBciVJaYSZuDMLdn1ItSfgwTs2Ue2MtTvqLqWHThhqPfYqGcm6uKDP/1p/4Bq3GrF+yqruDBH7bKP08=
X-Received: by 2002:a9d:fa4:: with SMTP id d33-v6mr1631007otd.84.1538590135234;
 Wed, 03 Oct 2018 11:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <CADckva-V-8PeMDAVxJFFuVcq1zppCBEqrJdwH32PPf1nKVw=CQ@mail.gmail.com>
 <CADckva9qPjqEjH=06cCLkkgJi+qYbR6cz5ki3whXOV1qP5BRvg@mail.gmail.com>
 <CABBYNZKaJc46C4Phu5HE18JXcYjfdD_kxS5Q7hOJJC4ZTsTyQA@mail.gmail.com>
 <CADckva9c-Nw85gH3yRBEvu_OD+J7EcccAjBZHB8ZQw92CndQZA@mail.gmail.com>
 <CABBYNZ+CmQ7KvjgDZzZ7sRPxLMmLi0L7pfMVEgz359Rb-Phwwg@mail.gmail.com>
 <CADckva_Xsa4euhy27qHQSQas2aoMKnK0pSvWndjoxLq2gohdTg@mail.gmail.com>
 <CABBYNZ+x2jzBRVNuLp-BpOAbdMk+xayrR61edPs2pEJ22cRFhw@mail.gmail.com>
 <CAAu3APae6fWN6U5-+ohubUk6JQH7Urvox2CVU9WHJexD3h+upg@mail.gmail.com>
 <CABBYNZKD7CVFj=ncqi0Xk0qvQNxMHv-NzHoDzDQLtXSbFOMycg@mail.gmail.com>
 <CADckva9RVVk-+8pAvqFwDd0DWL-uyKjQZ1_1JPATUa4CFNOLcg@mail.gmail.com>
 <CABBYNZK-L1_JEyr+CExiDYNkLF6TcT0HZrRN7QNngj9sns+OiQ@mail.gmail.com> <CADckva-05mb_=ZjhqVZthq5BOYF1aYuYjtD901Nh1gY39rghHw@mail.gmail.com>
In-Reply-To: <CADckva-05mb_=ZjhqVZthq5BOYF1aYuYjtD901Nh1gY39rghHw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 3 Oct 2018 21:08:42 +0300
Message-ID: <CABBYNZJY1pCTgBQbYvAvszX=2EYjLXve24hvgdfAxjs1NbU-Lg@mail.gmail.com>
Subject: Re: Registering a profile
To:     neil.benn@ziath.com
Cc:     Barry Byford <31baz66@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Neil,

On Wed, Oct 3, 2018 at 6:28 PM Neil Benn <neil.benn@ziath.com> wrote:
>
> Hello,
>
>   I understand that which is why I didn't prusue it.  My guess is that
> the old code basically wasn't registering the profile so I guess that
> the PSMs were not taken and it explains why I could directly connect
> to the sockets via pyBluez - the issue here is that this was 'hacky'
> and there was no way I could rebind to a paired device after losing
> connection.
>
>   I tried with SPP with the following main.conf:
>
> Name = DataPaqWalk
> DiscoverableTimeout = 0
> PairableTimeout = 0
> ReconnectAttempts=7
> ReconnectIntervals=1,2,4,8,16,32,64
> AutoEnable=true
>
>   The code is now:
>
> ---
> #!/usr/bin/python
> #
> # YAPTB Bluetooth keyboard emulator DBUS Service
> #
> # Adapted from
> # www.linuxuser.co.uk/tutorials/emulate-bluetooth-keyboard-with-the-raspberry-pi
> #
> #
>
> #from __future__ import absolute_import, print_function, unicode_literals
> from __future__ import absolute_import, print_function
>
> import os
> import sys
> import uuid
> import dbus
> import dbus.service
> import dbus.mainloop.glib
> import time
> import bluetooth
> import thread
> import subprocess
> import traceback
> from bluetooth import *
>
> from dbus.mainloop.glib import DBusGMainLoop
>
> try:
>   from gi.repository import GObject
> except ImportError:
>   import gobject as GObject
>
> #
> #define a bluez 5 profile object for our keyboard
> #
> class BTKbBluezProfile(dbus.service.Object):
>     fd = -1
>
>     @dbus.service.method("org.bluez.Profile1",
>                                     in_signature="", out_signature="")
>     def Release(self):
>         print("Release")
>         mainloop.quit()
>
>     @dbus.service.method("org.bluez.Profile1",
>                                     in_signature="", out_signature="")
>     def Cancel(self):
>         print("Cancel")
>
>     @dbus.service.method("org.bluez.Profile1", in_signature="oha{sv}",
> out_signature="")
>     def NewConnection(self, path, fd, properties):
>         print ('NewConnection')
>         self.fd = fd.take()
>         print("NewConnection(%s, %d)" % (path, self.fd))
>         for key in properties.keys():
>                 print ('key ' + key + ' value ' + properties[key])
>                 if key == "Version" or key == "Features":
>                         print("  %s = 0x%04x" % (key, properties[key]))
>                 else:
>                         print("  %s = %s" % (key, properties[key]))
>
>
>
>     @dbus.service.method("org.bluez.Profile1", in_signature="o",
> out_signature="")
>     def RequestDisconnection(self, path):
>             print("RequestDisconnection(%s)" % (path))
>
>             if (self.fd > 0):
>                     os.close(self.fd)
>                     self.fd = -1
>
>     def __init__(self, bus, path):
>             dbus.service.Object.__init__(self, bus, path)
>
>
> #
> #create a bluetooth device to emulate a HID keyboard,
> # advertize a SDP record using our bluez profile class
> #
> class BTKbDevice():
>
>     #define some constants
>     P_CTRL =17  #Service port - must match port configured in SDP record
>     P_INTR =19  #Interrrupt port - must match port configured in SDP record
>     PROFILE_DBUS_PATH="/bluez/yaptb/btkb_profile" #dbus path of  the
> bluez profile we will create
>     UUID='00001101-0000-1000-8000-00805f9b34fb'
>     #UUID="00001124-0000-1000-8000-00805f9b34fb"
>
>
>     def __init__(self):
>
>         print("Setting up BT device")
>         self.init_bluez_profile()
>
>
>     #set up a bluez profile to advertise device capabilities from a
> loaded service record
>     def init_bluez_profile(self):
>
>         bus = dbus.SystemBus()
>
>         print ("setting adapter to discoverable")
>         self.adapter =
> dbus.Interface(bus.get_object("org.bluez","/org/bluez"),
> "org.bluez.Adapter1")
>         self.adapter.Discoverable = True
>
>         print("Configuring Bluez Profile")
>
>         opts = {
>             "Role":"server"
>         }

No PSM/Channel, how do you expect the remote device to connect to you?

>         self.manager =
> dbus.Interface(bus.get_object("org.bluez","/org/bluez"),
> "org.bluez.ProfileManager1")
>         self.profile = BTKbBluezProfile(bus,
> BTKbDevice.PROFILE_DBUS_PATH)#BTKbDevice.PROFILE_DBUS_PATH)
>         self.manager.RegisterProfile(BTKbDevice.PROFILE_DBUS_PATH,
> BTKbDevice.UUID, opts)
>         print("Profile registered ")
>
>     #send a string to the bluetooth host machine
>     def send_string(self,message):
>          self.cinterrupt.send(message)
>
>
> #define a dbus service that emulates a bluetooth keyboard
> #this will enable different clients to connect to and use
> #the service
> class BTKbService(dbus.service.Object):
>
>     def __init__(self):
>
>         print("Setting up service")
>         bus = dbus.SystemBus()
>         #set up as a dbus service
>         bus_name=dbus.service.BusName("org.yaptb.btkbservice",bus)
>         dbus.service.Object.__init__(self,bus_name,"/org/yaptb/btkbservice")
>         self.device= BTKbDevice();
>
>
>     @dbus.service.method('org.yaptb.btkbservice', in_signature='yay')
>     def send_keys(self,modifier_byte,keys):
>         cmd_str=""
>         cmd_str+=chr(0xA1)
>         cmd_str+=chr(0x01)
>         cmd_str+=chr(modifier_byte)
>         cmd_str+=chr(0x00)
>
>         count=0
>         for key_code in keys:
>             if(count<6):
>                 cmd_str+=chr(key_code)
>             count+=1
>
>         self.device.send_string(cmd_str);
>
>
>
> #main routine
> if __name__ == "__main__":
>     mainloop = GObject.MainLoop()
>     # we an only run as root
>     if not os.geteuid() == 0:
>        sys.exit("Only root can run this script")
>
>     DBusGMainLoop(set_as_default=True)
>     myservice = BTKbService();
>     mainloop.run()
> ---
>
>   This does the same as for an HID; no events are fired on the dbus;
> bluetoothd gives:
>
> bluetoothd[651]: src/adapter.c:connected_callback() hci0 device
> C8:FF:28:79:05:D4 connected eir_len 5
> bluetoothd[651]: src/adapter.c:new_link_key_callback() hci0 new key
> for C8:FF:28:79:05:D4 type 4 pin_len 0 store_hint 1
> bluetoothd[651]: src/device.c:device_set_bonded()
> bluetoothd[651]: src/device.c:device_bonding_complete() bonding (nil)
> status 0x00
> bluetoothd[651]: src/adapter.c:resume_discovery()
> bluetoothd[651]: src/adapter.c:dev_disconnected() Device
> C8:FF:28:79:05:D4 disconnected, reason 3
> bluetoothd[651]: src/adapter.c:adapter_remove_connection()
> bluetoothd[651]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr
> C8:FF:28:79:05:D4 type 0 status 0xe
> bluetoothd[651]: src/device.c:device_bonding_complete() bonding (nil)
> status 0x0e
> bluetoothd[651]: src/device.c:device_bonding_failed() status 14
> bluetoothd[651]: src/adapter.c:resume_discovery()
>
>   The device itself connects and disconnects after a second or so:
>
> [bluetooth]# discoverable on
> Changing discoverable on succeeded
> [bluetooth]# power on
> Changing power on succeeded
> [CHG] Controller B8:27:EB:14:FB:B1 Powered: yes
> [CHG] Device C8:FF:28:79:05:D4 Connected: yes
> [CHG] Device C8:FF:28:79:05:D4 Connected: no
> [bluetooth]#
>
>   So I'm getting the same thing.  In the longer run I'll need HID
> because I'm making a HID device; maybe as you say I can disable the
> input plugin and connect the PSM but I'll still need to capture the
> connected/disconnected events.  Sorry to keep posting; your help is
> very much appreciated - as I said; I will return the code back when it
> is working.  Any ideas?

ACL link does not mean it is connected to your profile, since you
don't register any all your profile does is expose a SDP record which
by itself don't allow any connections. I had at least 3 examples on
how profiles are using the interface, had you look at that? The only
difference is that they are in C but the usage is pretty similar, note
though that you need a conterpart that do lookup for the SDP record
and connect to the PSM/Channel. Also no need to keep pasting the same
code over and over, it is quite clear it is not working, what you
should be looking for is HCI trace of what the remote is trying to do
when connecting, usually it start by doing a SDP search for the UUIDs
it want to connect followed by L2CAP/RFCOMM connection.

>   Thanks.
>
> Cheers,
>
> Neil
> On Wed, 3 Oct 2018 at 15:04, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Neil,
> > On Wed, Oct 3, 2018 at 4:49 PM Neil Benn <neil.benn@ziath.com> wrote:
> > >
> > > Hello,
> > >
> > >   Thanks; I followed Barry's example on making the device discoverable
> > > via bluetoothd and that can now be found so the profile is registered
> > > without needing the sdp_record.  However the profile isn't getting
> > > callbacks still except in one case where I kill the bluetoothd process
> > > and the release method on the profile is called which is strange.
> > >
> > >   Looking at the output from dbus when a connection happens; we have
> > > the following:
> > >
> > > signal time=1538574206.428425 sender=:1.0 -> destination=(null
> > > destination) serial=314 path=/org/freedesktop/systemd1;
> > > interface=org.freedesktop.systemd1.Manager; member=UnitNew
> > >    string "sys-devices-platform-soc-20201000.serial-tty-ttyAMA0-hci0-hci0:11.device"
> > >    object path "/org/freedesktop/systemd1/unit/sys_2ddevices_2dplatform_2dsoc_2d20201000_2eserial_2dtty_2dttyAMA0_2dhci0_2dhci0_3a11_2edevice"
> > > signal time=1538574206.431862 sender=:1.0 -> destination=(null
> > > destination) serial=315 path=/org/freedesktop/systemd1;
> > > interface=org.freedesktop.systemd1.Manager; member=UnitNew
> > >    string "sys-subsystem-bluetooth-devices-hci0:11.device"
> > >    object path "/org/freedesktop/systemd1/unit/sys_2dsubsystem_2dbluetooth_2ddevices_2dhci0_3a11_2edevice"
> > > signal time=1538574206.463318 sender=:1.22 -> destination=(null
> > > destination) serial=17 path=/org/bluez/hci0/dev_C8_FF_28_79_05_D4;
> > > interface=org.freedesktop.DBus.Properties; member=PropertiesChanged
> > >    string "org.bluez.Device1"
> > >    array [
> > >       dict entry(
> > >          string "Connected"
> > >          variant             boolean true
> > >       )
> > >    ]
> > >    array [
> > >    ]
> > > signal time=1538574210.618465 sender=:1.22 -> destination=(null
> > > destination) serial=18 path=/org/bluez/hci0/dev_C8_FF_28_79_05_D4;
> > > interface=org.freedesktop.DBus.Properties; member=PropertiesChanged
> > >    string "org.bluez.Device1"
> > >    array [
> > >       dict entry(
> > >          string "Connected"
> > >          variant             boolean false
> > >       )
> > >    ]
> > >    array [
> > >    ]
> > > signal time=1538574210.629705 sender=:1.0 -> destination=(null
> > > destination) serial=316
> > > path=/org/freedesktop/systemd1/unit/sys_2dsubsystem_2dbluetooth_2ddevices_2dhci0_3a11_2edevice;
> > > interface=org.freedesktop.DBus.Properties; member=PropertiesChanged
> > >    string "org.freedesktop.systemd1.Device"
> > >    array [
> > >       dict entry(
> > >          string "SysFSPath"
> > >          variant             string
> > > "/sys/devices/platform/soc/20201000.serial/tty/ttyAMA0/hci0/hci0:11"
> > >       )
> > >    ]
> > >    array [
> > >    ]
> > > signal time=1538574210.640715 sender=:1.0 -> destination=(null
> > > destination) serial=317
> > > path=/org/freedesktop/systemd1/unit/sys_2dsubsystem_2dbluetooth_2ddevices_2dhci0_3a11_2edevice;
> > > interface=org.freedesktop.DBus.Properties; member=PropertiesChanged
> > >    string "org.freedesktop.systemd1.Unit"
> > >    array [
> > >       dict entry(
> > >          string "ActiveState"
> > >          variant             string "inactive"
> > >       )
> > >       dict entry(
> > >          string "SubState"
> > >          variant             string "dead"
> > >       )
> > >       dict entry(
> > >          string "StateChangeTimestamp"
> > >          variant             uint64 1538574210626509
> > >       )
> > >       dict entry(
> > >          string "StateChangeTimestampMonotonic"
> > >          variant             uint64 2940864110
> > >       )
> > >       dict entry(
> > >          string "InactiveExitTimestamp"
> > >          variant             uint64 1538574206426852
> > >       )
> > >       dict entry(
> > >          string "InactiveExitTimestampMonotonic"
> > >          variant             uint64 2936664452
> > >       )
> > >       dict entry(
> > >          string "ActiveEnterTimestamp"
> > >          variant             uint64 1538574206426852
> > >       )
> > >       dict entry(
> > >          string "ActiveEnterTimestampMonotonic"
> > >          variant             uint64 2936664452
> > >       )
> > >       dict entry(
> > >          string "ActiveExitTimestamp"
> > >          variant             uint64 1538574210626509
> > >       )
> > >       dict entry(
> > >          string "ActiveExitTimestampMonotonic"
> > >          variant             uint64 2940864110
> > >       )
> > >       dict entry(
> > >          string "InactiveEnterTimestamp"
> > >          variant             uint64 1538574210626509
> > >       )
> > >       dict entry(
> > >          string "InactiveEnterTimestampMonotonic"
> > >          variant             uint64 2940864110
> > >       )
> > >       dict entry(
> > >          string "Job"
> > >          variant             struct {
> > >                uint32 0
> > >                object path "/"
> > >             }
> > >       )
> > >       dict entry(
> > >          string "ConditionResult"
> > >          variant             boolean false
> > >       )
> > >       dict entry(
> > >          string "AssertResult"
> > >          variant             boolean false
> > >       )
> > >       dict entry(
> > >          string "ConditionTimestamp"
> > >          variant             uint64 0
> > >       )
> > >       dict entry(
> > >          string "ConditionTimestampMonotonic"
> > >          variant             uint64 0
> > >       )
> > >       dict entry(
> > >          string "AssertTimestamp"
> > >          variant             uint64 0
> > >       )
> > >       dict entry(
> > >          string "AssertTimestampMonotonic"
> > >          variant             uint64 0
> > >       )
> > >    ]
> > >    array [
> > >    ]
> > > signal time=1538574210.668073 sender=:1.0 -> destination=(null
> > > destination) serial=318 path=/org/freedesktop/systemd1;
> > > interface=org.freedesktop.systemd1.Manager; member=UnitRemoved
> > >    string "sys-subsystem-bluetooth-devices-hci0:11.device"
> > >    object path "/org/freedesktop/systemd1/unit/sys_2dsubsystem_2dbluetooth_2ddevices_2dhci0_3a11_2edevice"
> > > signal time=1538574210.670654 sender=:1.0 -> destination=(null
> > > destination) serial=319
> > > path=/org/freedesktop/systemd1/unit/sys_2ddevices_2dplatform_2dsoc_2d20201000_2eserial_2dtty_2dttyAMA0_2dhci0_2dhci0_3a11_2edevice;
> > > interface=org.freedesktop.DBus.Properties; member=PropertiesChanged
> > >    string "org.freedesktop.systemd1.Device"
> > >    array [
> > >       dict entry(
> > >          string "SysFSPath"
> > >          variant             string
> > > "/sys/devices/platform/soc/20201000.serial/tty/ttyAMA0/hci0/hci0:11"
> > >       )
> > >    ]
> > >    array [
> > >    ]
> > > signal time=1538574210.677890 sender=:1.0 -> destination=(null
> > > destination) serial=320
> > > path=/org/freedesktop/systemd1/unit/sys_2ddevices_2dplatform_2dsoc_2d20201000_2eserial_2dtty_2dttyAMA0_2dhci0_2dhci0_3a11_2edevice;
> > > interface=org.freedesktop.DBus.Properties; member=PropertiesChanged
> > >    string "org.freedesktop.systemd1.Unit"
> > >    array [
> > >       dict entry(
> > >          string "ActiveState"
> > >          variant             string "inactive"
> > >       )
> > >       dict entry(
> > >          string "SubState"
> > >          variant             string "dead"
> > >       )
> > >       dict entry(
> > >          string "StateChangeTimestamp"
> > >          variant             uint64 1538574210626572
> > >       )
> > >       dict entry(
> > >          string "StateChangeTimestampMonotonic"
> > >          variant             uint64 2940864171
> > >       )
> > >       dict entry(
> > >          string "InactiveExitTimestamp"
> > >          variant             uint64 1538574206426942
> > >       )
> > >       dict entry(
> > >          string "InactiveExitTimestampMonotonic"
> > >          variant             uint64 2936664542
> > >       )
> > >       dict entry(
> > >          string "ActiveEnterTimestamp"
> > >          variant             uint64 1538574206426942
> > >       )
> > >       dict entry(
> > >          string "ActiveEnterTimestampMonotonic"
> > >          variant             uint64 2936664542
> > >       )
> > >       dict entry(
> > >          string "ActiveExitTimestamp"
> > >          variant             uint64 1538574210626572
> > >       )
> > >       dict entry(
> > >          string "ActiveExitTimestampMonotonic"
> > >          variant             uint64 2940864171
> > >       )
> > >       dict entry(
> > >          string "InactiveEnterTimestamp"
> > >          variant             uint64 1538574210626572
> > >       )
> > >       dict entry(
> > >          string "InactiveEnterTimestampMonotonic"
> > >          variant             uint64 2940864171
> > >       )
> > >       dict entry(
> > >          string "Job"
> > >          variant             struct {
> > >                uint32 0
> > >                object path "/"
> > >             }
> > >       )
> > >       dict entry(
> > >          string "ConditionResult"
> > >          variant             boolean false
> > >       )
> > >       dict entry(
> > >          string "AssertResult"
> > >          variant             boolean false
> > >       )
> > >       dict entry(
> > >          string "ConditionTimestamp"
> > >          variant             uint64 0
> > >       )
> > >       dict entry(
> > >          string "ConditionTimestampMonotonic"
> > >          variant             uint64 0
> > >       )
> > >       dict entry(
> > >          string "AssertTimestamp"
> > >          variant             uint64 0
> > >       )
> > >       dict entry(
> > >          string "AssertTimestampMonotonic"
> > >          variant             uint64 0
> > >       )
> > >    ]
> > >    array [
> > >    ]
> > > signal time=1538574210.699336 sender=:1.0 -> destination=(null
> > > destination) serial=321 path=/org/freedesktop/systemd1;
> > > interface=org.freedesktop.systemd1.Manager; member=UnitRemoved
> > >    string "sys-devices-platform-soc-20201000.serial-tty-ttyAMA0-hci0-hci0:11.device"
> > >    object path "/org/freedesktop/systemd1/unit/sys_2ddevices_2dplatform_2dsoc_2d20201000_2eserial_2dtty_2dttyAMA0_2dhci0_2dhci0_3a11_2edevice"
> > >
> > >   So there are events being fired just not the ones that connect to my
> > > registered profile.  In addition I've tried to register the profile
> > > and listen for connections on the device PSM of 17 and 19 which HID
> > > uses but nothing happens there either - though I'm not sure this is
> > > the best way to communicate as it feels 'wrong' tbh.
> >
> > Have you read my responses? It _wont_ work for these PSMs, those are
> > already taken by the daemon except if you are not loading the input
> > plugin. Can't you try with something simpler like SPP, which is what
> > this interface is for?
> >
> > >   Thanks again - I'm still basically not getting any events fired on
> > > the profile except for Release which isn't really that useful as it
> > > only notifies me if the bluetooth stack goes down!
> > >
> > >   Any ideas?
> > >
> > > Cheers,
> > >
> > > Neil
> > > On Wed, 3 Oct 2018 at 11:35, Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > Hi Barry,
> > > > On Tue, Oct 2, 2018 at 5:57 PM Barry Byford <31baz66@gmail.com> wrote:
> > > > >
> > > > > Hi Luiz,
> > > > >
> > > > > On Tue, 2 Oct 2018 at 13:48, Luiz Augusto von Dentz
> > > > > <luiz.dentz@gmail.com> wrote:
> > > > > >
> > > > > > Hi Neil,
> > > > > > On Tue, Oct 2, 2018 at 3:29 PM Neil Benn <neil.benn@ziath.com> wrote:
> > > > > > >
> > > > > > > Hello,
> > > > > > >
> > > > > > >   Thanks for that please see inline below:
> > > > > > >
> > > > > > >
> > > > > > > On Tue, 2 Oct 2018, 12:28 Luiz Augusto von Dentz, <luiz.dentz@gmail.com> wrote:
> > > > > > > >
> > > > > > > > Hi Neil,
> > > > > > > > On Tue, Oct 2, 2018 at 1:39 PM Neil Benn <neil.benn@ziath.com> wrote:
> > > > > > > > >
> > > > > > > > > Hello,
> > > > > > > > >
> > > > > > > > >   Thanks for that; I'll change the config file for this and for the
> > > > > > > > > name can that be in the main.conf file?  The same for the
> > > > > > > > > discoverable; set the timeout to zero - there is no security needed
> > > > > > > > > for this device at all.  Can this all be done with the conf file?
> > > > > > > > >
> > > > > > > > >   On the connection; yes it connects.  This is a HID device connecting
> > > > > > > > > via L2CAP with the interrupt on 19 and the control on 17 and the
> > > > > > > > > windows PC correctly connects to the device, queries the service
> > > > > > > > > record, identifies it as a HID and connects on both the control and
> > > > > > > > > interrupt psm ports but none of the dbus methods are being called.  At
> > > > > > > > > the moment I am using the pybluez library with the BluetoothSocket and
> > > > > > > > > calling listen and accept which is a bit 'manual'.  To detect a
> > > > > > > > > disconnect I'm calling hcitool con and parsing the response - which is
> > > > > > > > > again a bit manual.  Please see below for my current 'hack':
> > > > > > > >
> > > > > > > > I don't think that will work since the input plugin is already
> > > > > > > > listening in those PSM,
> > > > > > >
> > > > > > > It does connect and work but it doesn't register the profile.  If I
> > > > > > > don't register the profile the default name in the config is used
> > > > > > > >
> > > > > > > > in fact I don't think RegisterProfile would
> > > > > > > > parse the values from the record since you don't seem to be using the
> > > > > > > > PSM:
> > > > > > > >
> > > > > > > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/profile-api.txt#n54
> > > > > > >
> > > > > > >
> > > > > > > The PSM is defined in the service record
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > Btw, why would you want to replace the HID profile? Is that not working?
> > > > > > >
> > > > > > > I'm using an sdp profile provided in some sample code I found, is
> > > > > > > there a default one that is supported?  Is that default one selected
> > > > > > > when I pick my uuid?
> > > > > >
> > > > > > You are not suppose to use existing UUIDs that the daemon already
> > > > > > registers, the fact that you are able to register it without cause a
> > > > > > problem might be a bug and we should probably check if the UUID is
> > > > > > already registered and fail if it does.
> > > > > >
> > > > > > The HID profile is implementation is under profiles/input/, it
> > > > > > actually hooks with kernel HID drivers.
> > > > > >
> > > > > > If you just want to test it you should probably have a look at
> > > > > > test-profile in python:
> > > > >
> > > > > Do you have any example invocations of test-profile for common profiles?
> > > >
> > > > test-profile is just a sample, but yes we do have many instances of
> > > > common profiles using RegisterProfile:
> > > >
> > > > OBEX Daemon:
> > > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/obexd/plugins/bluetooth.c#n256
> > > >
> > > > Ofono (HFP):
> > > > https://git.kernel.org/pub/scm/network/ofono/ofono.git/tree/plugins/bluez5.c#n104
> > > >
> > > > PulseAudio (HSP):
> > > > https://gitlab.freedesktop.org/pulseaudio/pulseaudio/blob/master/src/modules/bluetooth/backend-native.c#L332
> > > >
> > > > > It can be difficult to know where the issue is if you are not
> > > > > confident with what settings should work.
> > > >
> > > > Well test-profile is not exactly a library just a convenient sample on
> > > > how to use the interface, it was used mostly for testing SPP which is
> > > > quite common way to register external profiles. HID is probably a no
> > > > go due to reason already stated.
> > > >
> > > > > >
> > > > > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test/test-profile
> > > > > >
> > > > > > >   If so then I think it has been overcomplicated by this sdp profile?
> > > > > > > How do I use the default in-built profile - is it just the uuid?
> > > > > > > On Tue, 2 Oct 2018 at 12:28, Luiz Augusto von Dentz
> > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > >
> > > > > > > > Hi Neil,
> > > > > > > > On Tue, Oct 2, 2018 at 1:39 PM Neil Benn <neil.benn@ziath.com> wrote:
> > > > > > > > >
> > > > > > > > > Hello,
> > > > > > > > >
> > > > > > > > >   Thanks for that; I'll change the config file for this and for the
> > > > > > > > > name can that be in the main.conf file?  The same for the
> > > > > > > > > discoverable; set the timeout to zero - there is no security needed
> > > > > > > > > for this device at all.  Can this all be done with the conf file?
> > > > > > > > >
> > > > > > > > >   On the connection; yes it connects.  This is a HID device connecting
> > > > > > > > > via L2CAP with the interrupt on 19 and the control on 17 and the
> > > > > > > > > windows PC correctly connects to the device, queries the service
> > > > > > > > > record, identifies it as a HID and connects on both the control and
> > > > > > > > > interrupt psm ports but none of the dbus methods are being called.  At
> > > > > > > > > the moment I am using the pybluez library with the BluetoothSocket and
> > > > > > > > > calling listen and accept which is a bit 'manual'.  To detect a
> > > > > > > > > disconnect I'm calling hcitool con and parsing the response - which is
> > > > > > > > > again a bit manual.  Please see below for my current 'hack':
> > > > > > > >
> > > > > > > > I don't think that will work since the input plugin is already
> > > > > > > > listening in those PSM, in fact I don't think RegisterProfile would
> > > > > > > > parse the values from the record since you don't seem to be using the
> > > > > > > > PSM:
> > > > > > > >
> > > > > > > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/profile-api.txt#n54
> > > > > > > >
> > > > > > > > Btw, why would you want to replace the HID profile? Is that not working?
> > > > > > > >
> > > > > > > > > ---
> > > > > > > > >     #listen for incoming client connections
> > > > > > > > >     #ideally this would be handled by the Bluez 5 profile
> > > > > > > > >     #but that didn't seem to work
> > > > > > > > >     def listen(self):
> > > > > > > > >
> > > > > > > > >         print("Waiting for connections")
> > > > > > > > >         self.scontrol=BluetoothSocket(L2CAP)
> > > > > > > > >         self.sinterrupt=BluetoothSocket(L2CAP)
> > > > > > > > >
> > > > > > > > >         self.scontrol.bind((self.MY_ADDRESS,self.P_CTRL))
> > > > > > > > >         self.sinterrupt.bind((self.MY_ADDRESS,self.P_INTR ))
> > > > > > > > >         #Start listening on the server sockets
> > > > > > > > >         self.scontrol.listen(1) # Limit of 1 connection
> > > > > > > > >         self.sinterrupt.listen(1)
> > > > > > > > >
> > > > > > > > >         self.ccontrol,cinfo = self.scontrol.accept()
> > > > > > > > >         self.controlClientMac = cinfo[0]
> > > > > > > > >         self.controlClientPsm = cinfo[1]
> > > > > > > > >         print ('control is ' + self.controlClientMac + " " +
> > > > > > > > > str(self.controlClientPsm))
> > > > > > > > >
> > > > > > > > >         self.cinterrupt, cinfo = self.sinterrupt.accept()
> > > > > > > > >         self.interruptClientMac = cinfo[0]
> > > > > > > > >         self.interruptClientPsm = cinfo[1]
> > > > > > > > >         print ('interrupt is ' + self.interruptClientMac + " " +
> > > > > > > > > str(self.interruptClientPsm))
> > > > > > > > >
> > > > > > > > >         thread.start_new_thread(self.check_connection, ())
> > > > > > > > >
> > > > > > > > >     def check_connection(self):
> > > > > > > > >         halt = False
> > > > > > > > >         while not halt:
> > > > > > > > >             stdoutdata = subprocess.check_output(["hcitool", "con"])
> > > > > > > > >
> > > > > > > > >             if self.controlClientMac in stdoutdata.split():
> > > > > > > > >                 time.sleep(0.1)
> > > > > > > > >             else:
> > > > > > > > >                 print('got disconnection')
> > > > > > > > >                 self.scontrol.shutdown(2);
> > > > > > > > >                 self.sinterrupt.shutdown(2)
> > > > > > > > >                 halt = True
> > > > > > > > >         thread.start_new_thread(self.listen, ())
> > > > > > > > >
> > > > > > > > >   Obviously this is a very clumsy way of doing it and calling back on
> > > > > > > > > the profile is the correct way to do it, I just can't work out why the
> > > > > > > > > profile is not being called.  I'm trying to spy on the dbus comms to
> > > > > > > > > see if anything is being sent but I can't see any bluez profile
> > > > > > > > > messages being sent at all.  Thanks for your response and any advice
> > > > > > > > > is greatly appreciated.
> > > > > > > > >
> > > > > > > > > Cheers,
> > > > > > > > >
> > > > > > > > > Neil
> > > > > > > > > On Tue, 2 Oct 2018 at 09:37, Luiz Augusto von Dentz
> > > > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Hi Neil,
> > > > > > > > > > On Tue, Oct 2, 2018 at 1:32 AM Neil Benn <neil.benn@ziath.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Hello,
> > > > > > > > > > >
> > > > > > > > > > >   I've been running a dbus-monitor and I can't see the interface being
> > > > > > > > > > > called of 'org.bluez.Profile1' - I can see 'org.bluez.Device1' and
> > > > > > > > > > > I've tried listening to that interface and also on the path with
> > > > > > > > > > > dev_<ADAPTER-MAC> but I'm clearly doing something fundamentally wrong.
> > > > > > > > > > > IF anyone has any advance I'd be very grateful and there is 100 rep
> > > > > > > > > > > points up on Stack Overflow for any advice too!
> > > > > > > > > > >
> > > > > > > > > > >   Thanks; it's late here and I'll not be home till gone 1am so I'll be off now!
> > > > > > > > > > >
> > > > > > > > > > > Cheers,
> > > > > > > > > > >
> > > > > > > > > > > Neil
> > > > > > > > > > > On Fri, 28 Sep 2018 at 23:38, Neil Benn <neil.benn@ziath.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > Hello,
> > > > > > > > > > > >
> > > > > > > > > > > >   I'm trying to setup a RPi0 operating a Bluetooth device; I've setup
> > > > > > > > > > > > the device using the following call:
> > > > > > > > > > > > ---
> > > > > > > > > > > >     #configure the bluetooth hardware device
> > > > > > > > > > > >     def init_bt_device(self):
> > > > > > > > > > > >
> > > > > > > > > > > >         print("Configuring for name " + BTKbDevice.MY_DEV_NAME)
> > > > > > > > > > > >
> > > > > > > > > > > >         #set the device class to a barcode scanner and set the name
> > > > > > > > > > > >         os.system("hciconfig hcio class 0x002560")
> > > > > > > > > > > >         os.system("hciconfig hcio name " + BTKbDevice.MY_DEV_NAME)
> > > > > > > > > > > >
> > > > > > > > > > > >         #make the device discoverable
> > > > > > > > > > > >         os.system("hciconfig hcio piscan")
> > > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > You shouldn't be using hciconfig, instead do the following:
> > > > > > > > > >
> > > > > > > > > > The class is automatically set by bluetoothd based on the
> > > > > > > > > > services/profiles registered and the setting in the main.conf:
> > > > > > > > > >
> > > > > > > > > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/main.conf#n9
> > > > > > > > > >
> > > > > > > > > > For the name use D-Bus property Alias:
> > > > > > > > > >
> > > > > > > > > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/adapter-api.txt#n216
> > > > > > > > > >
> > > > > > > > > > To make the adapter discoverable use D-Bus property Discoverable:
> > > > > > > > > >
> > > > > > > > > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/adapter-api.txt#n252
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > > >   Then after that I attempt to setup the profile using the following code:
> > > > > > > > > > > > ---
> > > > > > > > > > > >     #set up a bluez profile to advertise device capabilities from a
> > > > > > > > > > > > loaded service record
> > > > > > > > > > > >     def init_bluez_profile(self):
> > > > > > > > > > > >
> > > > > > > > > > > >         print("Configuring Bluez Profile")
> > > > > > > > > > > >
> > > > > > > > > > > >         #setup profile options
> > > > > > > > > > > >         service_record=self.read_sdp_service_record()
> > > > > > > > > > > >
> > > > > > > > > > > >         opts = {
> > > > > > > > > > > >             "ServiceRecord":service_record,
> > > > > > > > > > > >             "Role":"server",
> > > > > > > > > > > >             "RequireAuthentication":False,
> > > > > > > > > > > >             "RequireAuthorization":False,
> > > > > > > > > > > >             "Name":BTKbDevice.MY_DEV_NAME,
> > > > > > > > > > > >             "AutoConnect":True
> > > > > > > > > > > >         }
> > > > > > > > > > > >
> > > > > > > > > > > >         #retrieve a proxy for the bluez profile interface
> > > > > > > > > > > >         bus = dbus.SystemBus()
> > > > > > > > > > > >         self.manager =
> > > > > > > > > > > > dbus.Interface(bus.get_object("org.bluez","/org/bluez"),
> > > > > > > > > > > > "org.bluez.ProfileManager1")
> > > > > > > > > > > >         self.profile = BTKbBluezProfile(bus, BTKbDevice.PROFILE_DBUS_PATH)
> > > > > > > > > > > >         self.manager.RegisterProfile(BTKbDevice.PROFILE_DBUS_PATH,
> > > > > > > > > > > > BTKbDevice.UUID, opts)
> > > > > > > > > > > >         print("Profile registered ")
> > > > > > > > > > > > ---
> > > > > > > > > > > >   The sdp record is available from https://textuploader.com/dv8xt.
> > > > > > > > > > > > The profile in question is basically the same as the one defined in
> > > > > > > > > > > > the test-profile as shown below:
> > > > > > > > > > > > ---
> > > > > > > > > > > > class BTKbBluezProfile(dbus.service.Object):
> > > > > > > > > > > >     fd = -1
> > > > > > > > > > > >
> > > > > > > > > > > >     @dbus.service.method("org.bluez.Profile1",
> > > > > > > > > > > >                                     in_signature="", out_signature="")
> > > > > > > > > > > >     def Release(self):
> > > > > > > > > > > >             print("Release")
> > > > > > > > > > > >             mainloop.quit()
> > > > > > > > > > > >
> > > > > > > > > > > >     @dbus.service.method("org.bluez.Profile1",
> > > > > > > > > > > >                                     in_signature="", out_signature="")
> > > > > > > > > > > >     def Cancel(self):
> > > > > > > > > > > >             print("Cancel")
> > > > > > > > > > > >
> > > > > > > > > > > >     @dbus.service.method("org.bluez.Profile1", in_signature="oha{sv}",
> > > > > > > > > > > > out_signature="")
> > > > > > > > > > > >     def NewConnection(self, path, fd, properties):
> > > > > > > > > > > >             self.fd = fd.take()
> > > > > > > > > > > >             print("NewConnection(%s, %d)" % (path, self.fd))
> > > > > > > > > > > >             for key in properties.keys():
> > > > > > > > > > > >                     print ('key ' + key + ' value ' + properties[key])
> > > > > > > > > > > >                     if key == "Version" or key == "Features":
> > > > > > > > > > > >                             print("  %s = 0x%04x" % (key, properties[key]))
> > > > > > > > > > > >                     else:
> > > > > > > > > > > >                             print("  %s = %s" % (key, properties[key]))
> > > > > > > > > > > >
> > > > > > > > > > > >     @dbus.service.method("org.bluez.Profile1", in_signature="o",
> > > > > > > > > > > > out_signature="")
> > > > > > > > > > > >     def RequestDisconnection(self, path):
> > > > > > > > > > > >             print("RequestDisconnection(%s)" % (path))
> > > > > > > > > > > >
> > > > > > > > > > > >             if (self.fd > 0):
> > > > > > > > > > > >                     os.close(self.fd)
> > > > > > > > > > > >                     self.fd = -1
> > > > > > > > > > > >
> > > > > > > > > > > >     def __init__(self, bus, path):
> > > > > > > > > > > >             dbus.service.Object.__init__(self, bus, path)
> > > > > > > > > > > > ---
> > > > > > > > > > > >   However it seems like the profile is not being registered, or least
> > > > > > > > > > > > the methods in the profile are not being called.  I'm sorry to ask
> > > > > > > > > > > > such a basic question but can someone please point me in the right
> > > > > > > > > > > > direction as to why the profile is either not being registered or the
> > > > > > > > > > > > callbacks on the profile are not being called.
> > > > > > > > > >
> > > > > > > > > > They would be called only when there is a connection to the profile,
> > > > > > > > > > did you actually connect? If this is something like a serial port the
> > > > > > > > > > remote should lookup the SDP record and connect to the channel listed
> > > > > > > > > > there.
> > > > > > > > > >
> > > > > > > > > > > >   Thank you very much for reading this far and any and all help is
> > > > > > > > > > > > most appreciated!
> > > > > > > > > > > >
> > > > > > > > > > > > Cheers,
> > > > > > > > > > > >
> > > > > > > > > > > > Neil
> > > > > > > > > > > >
> > > > > > > > > > > > --
> > > > > > > > > > > >
> > > > > > > > > > > > Neil Benn MSc
> > > > > > > > > > > > Ziath Ltd
> > > > > > > > > > > > Phone: +44 (0) 1223 855021
> > > > > > > > > > > > http://www.ziath.com
> > > > > > > > > > > >
> > > > > > > > > > > > Please consider the environment before printing this email.
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > --
> > > > > > > > > > >
> > > > > > > > > > > Neil Benn MSc
> > > > > > > > > > > Ziath Ltd
> > > > > > > > > > > Phone: +44 (0) 1223 855021
> > > > > > > > > > > http://www.ziath.com
> > > > > > > > > > >
> > > > > > > > > > > Please consider the environment before printing this email.
> > > > > > > > > > >
> > > > > > > > > > > Follow us on Facebook, Twitter or LinkedIn
> > > > > > > > > > >
> > > > > > > > > > > IMPORTANT NOTICE: This message, including any attached documents, is
> > > > > > > > > > > intended only for the use of the individual or entity to which it is
> > > > > > > > > > > addressed, and may contain information that is privileged,
> > > > > > > > > > > confidential and exempt from disclosure under applicable law. If the
> > > > > > > > > > > reader of this message is not the intended recipient, or the employee
> > > > > > > > > > > or agent responsible for delivering the message to the intended
> > > > > > > > > > > recipient, you are hereby notified that any dissemination,
> > > > > > > > > > > distribution or copying of this communication is strictly prohibited.
> > > > > > > > > > > If you have received this communication in error, please notify Ziath
> > > > > > > > > > > Ltd immediately by email at info@ziath.com. Thank you.
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > --
> > > > > > > > > > Luiz Augusto von Dentz
> > > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > --
> > > > > > > > >
> > > > > > > > > Neil Benn MSc
> > > > > > > > > Ziath Ltd
> > > > > > > > > Phone: +44 (0) 1223 855021
> > > > > > > > > http://www.ziath.com
> > > > > > > > >
> > > > > > > > > Please consider the environment before printing this email.
> > > > > > > > >
> > > > > > > > > Follow us on Facebook, Twitter or LinkedIn
> > > > > > > > >
> > > > > > > > > IMPORTANT NOTICE: This message, including any attached documents, is
> > > > > > > > > intended only for the use of the individual or entity to which it is
> > > > > > > > > addressed, and may contain information that is privileged,
> > > > > > > > > confidential and exempt from disclosure under applicable law. If the
> > > > > > > > > reader of this message is not the intended recipient, or the employee
> > > > > > > > > or agent responsible for delivering the message to the intended
> > > > > > > > > recipient, you are hereby notified that any dissemination,
> > > > > > > > > distribution or copying of this communication is strictly prohibited.
> > > > > > > > > If you have received this communication in error, please notify Ziath
> > > > > > > > > Ltd immediately by email at info@ziath.com. Thank you.
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > --
> > > > > > > > Luiz Augusto von Dentz
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > --
> > > > > > >
> > > > > > > Neil Benn MSc
> > > > > > > Ziath Ltd
> > > > > > > Phone: +44 (0) 1223 855021
> > > > > > > http://www.ziath.com
> > > > > > >
> > > > > > > Please consider the environment before printing this email.
> > > > > > >
> > > > > > > Follow us on Facebook, Twitter or LinkedIn
> > > > > > >
> > > > > > > IMPORTANT NOTICE: This message, including any attached documents, is
> > > > > > > intended only for the use of the individual or entity to which it is
> > > > > > > addressed, and may contain information that is privileged,
> > > > > > > confidential and exempt from disclosure under applicable law. If the
> > > > > > > reader of this message is not the intended recipient, or the employee
> > > > > > > or agent responsible for delivering the message to the intended
> > > > > > > recipient, you are hereby notified that any dissemination,
> > > > > > > distribution or copying of this communication is strictly prohibited.
> > > > > > > If you have received this communication in error, please notify Ziath
> > > > > > > Ltd immediately by email at info@ziath.com. Thank you.
> > > > > >
> > > > > >
> > > > > >
> > > > > > --
> > > > > > Luiz Augusto von Dentz
> > > >
> > > >
> > > >
> > > > --
> > > > Luiz Augusto von Dentz
> > >
> > >
> > >
> > > --
> > >
> > > Neil Benn MSc
> > > Ziath Ltd
> > > Phone: +44 (0) 1223 855021
> > > http://www.ziath.com
> > >
> > > Please consider the environment before printing this email.
> > >
> > > Follow us on Facebook, Twitter or LinkedIn
> > >
> > > IMPORTANT NOTICE: This message, including any attached documents, is
> > > intended only for the use of the individual or entity to which it is
> > > addressed, and may contain information that is privileged,
> > > confidential and exempt from disclosure under applicable law. If the
> > > reader of this message is not the intended recipient, or the employee
> > > or agent responsible for delivering the message to the intended
> > > recipient, you are hereby notified that any dissemination,
> > > distribution or copying of this communication is strictly prohibited.
> > > If you have received this communication in error, please notify Ziath
> > > Ltd immediately by email at info@ziath.com. Thank you.
> >
> >
> >
> > --
> > Luiz Augusto von Dentz
>
>
>
> --
>
> Neil Benn MSc
> Ziath Ltd
> Phone: +44 (0) 1223 855021
> http://www.ziath.com
>
> Please consider the environment before printing this email.
>
> Follow us on Facebook, Twitter or LinkedIn
>
> IMPORTANT NOTICE: This message, including any attached documents, is
> intended only for the use of the individual or entity to which it is
> addressed, and may contain information that is privileged,
> confidential and exempt from disclosure under applicable law. If the
> reader of this message is not the intended recipient, or the employee
> or agent responsible for delivering the message to the intended
> recipient, you are hereby notified that any dissemination,
> distribution or copying of this communication is strictly prohibited.
> If you have received this communication in error, please notify Ziath
> Ltd immediately by email at info@ziath.com. Thank you.



-- 
Luiz Augusto von Dentz
