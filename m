Return-Path: <SRS0=6kNt=MO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666C8C004D2
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Oct 2018 18:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B7972083F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Oct 2018 18:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziath-com.20150623.gappssmtp.com header.i=@ziath-com.20150623.gappssmtp.com header.b="KAGDK58g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B7972083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziath.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbeJCBQl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Oct 2018 21:16:41 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:44987 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbeJCBQl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Oct 2018 21:16:41 -0400
Received: by mail-lj1-f182.google.com with SMTP id v6-v6so2680354ljc.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Oct 2018 11:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziath-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d02dCpr61MQdq0ZsFBSjeITPQxywsz/M9eZBNioL8Ao=;
        b=KAGDK58gPmEgE4posGuPg85x/cMVUY92ETVjM5revZy6GLCwg/R2w5Y0akWazzt7EF
         tGxFR9r+fBgBiHypdb75rPWcRSjwofNdoTv6ePiKkPBTjW7MGwfHWNz3wSVtiRu5ZVTg
         Twk/ftOdYUK9eD1+9f1RPKUqaPVL/PAwApdofAWIkKld3+mGCLM2w+3Ua97XL8T2QpdJ
         I0LuvoXtR5/eBBLMjM2r26zA54qWR8Yb3dqPCK/oxyJO3I0I0Z4zlXtGpWxOD6CMX2ff
         5e5pXVWKAh26HETN1NjIReWrpxj83lDuzd4rEgSLZLoWQgPzPvW+qVx6EN/AIdwbdikr
         +g3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d02dCpr61MQdq0ZsFBSjeITPQxywsz/M9eZBNioL8Ao=;
        b=F7kv2RbT6JruretXqBQ4m3dKOB7/JGghUoAfTj91jO0jLIOcx2p9jOdB9HDi688RDV
         kty7gQa6p0YZ/OhKbfRR9HVcaICLrXesFAr3gfbB38M5oWIxt/s3ZyXVJYAs53b5qR2d
         T/ltcHc+Sd0AytPOzIj8deoe+PYni0g3d2+tRN98aFTejOfbso2v2RvxtHafFsg6fDwt
         uhAqlM7nPGSu8/qrS+TE7o8f5BNL9ktjMH/LdrkLUUykGtkwavg4OgylnEaTVccQvcGu
         iRksfXiaJO7SzkBl1H/hWoIt5OfxRU0qlJQJxBCjmEvjCUUW/5plXaThjHFZq9wwaBJ4
         wsMw==
X-Gm-Message-State: ABuFfohtuTCuBxceUBo6X6nV56BtJa/4/Q1KNY2JHq4kTsAUtoGa2Zxd
        cuSyDk+HPtKzrFoYfgLY6g7275Nxrwg7Piy0dFlZlA==
X-Google-Smtp-Source: ACcGV618PDq5/fiK6Tegmr3ZgeYLaIWOAjm9pmRWgNumaz3XG4t1kMqvCwEmxzLlXTC82Q4B4y9RfRTeigBBzGNTJag=
X-Received: by 2002:a2e:5159:: with SMTP id b25-v6mr11034348lje.156.1538505114583;
 Tue, 02 Oct 2018 11:31:54 -0700 (PDT)
MIME-Version: 1.0
References: <CADckva-V-8PeMDAVxJFFuVcq1zppCBEqrJdwH32PPf1nKVw=CQ@mail.gmail.com>
 <CADckva9qPjqEjH=06cCLkkgJi+qYbR6cz5ki3whXOV1qP5BRvg@mail.gmail.com>
 <CABBYNZKaJc46C4Phu5HE18JXcYjfdD_kxS5Q7hOJJC4ZTsTyQA@mail.gmail.com>
 <CADckva9c-Nw85gH3yRBEvu_OD+J7EcccAjBZHB8ZQw92CndQZA@mail.gmail.com>
 <CABBYNZ+CmQ7KvjgDZzZ7sRPxLMmLi0L7pfMVEgz359Rb-Phwwg@mail.gmail.com>
 <CADckva_Xsa4euhy27qHQSQas2aoMKnK0pSvWndjoxLq2gohdTg@mail.gmail.com>
 <CABBYNZ+x2jzBRVNuLp-BpOAbdMk+xayrR61edPs2pEJ22cRFhw@mail.gmail.com> <CAAu3APae6fWN6U5-+ohubUk6JQH7Urvox2CVU9WHJexD3h+upg@mail.gmail.com>
In-Reply-To: <CAAu3APae6fWN6U5-+ohubUk6JQH7Urvox2CVU9WHJexD3h+upg@mail.gmail.com>
From:   Neil Benn <neil.benn@ziath.com>
Date:   Tue, 2 Oct 2018 19:31:42 +0100
Message-ID: <CADckva_o6516E9vmpaZ1qJbZBP0=FHRhVEQPz24SycAx9MZj1Q@mail.gmail.com>
Subject: Re: Registering a profile
To:     31baz66@gmail.com
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

  Thanks for all the advice; sorry I didn't get back earlier - been
stuck on other jobs covering for people off sick.  I've not got the
main.conf of:

Name = DataPaqWalk
Class = 0x002650
DiscoverableTimeout = 0
PairableTimeout = 0
AutoConnectTimeout = 60
ReconnectAttempts=7
ReconnectIntervals=1,2,4,8,16,32,64
AutoEnable=true

  When I bring up bluetoothd in debug I can see that the name is now
picked up from the conf file:

bluetoothd[579]: src/adapter.c:btd_adapter_new() Major class: 6
bluetoothd[579]: src/adapter.c:btd_adapter_new() Minor class: 20
...
bluetoothd[579]: src/adapter.c:local_name_changed_callback() Name: DataPaqWalk
bluetoothd[579]: src/adapter.c:local_name_changed_callback() Short name:
bluetoothd[579]: src/adapter.c:local_name_changed_callback() Current
alias: DataPaqWalk

  The code is now _much_ simpler:

---
class BTKbDevice():

    #define some constants
    P_CTRL =17  #Service port - must match port configured in SDP record
    P_INTR =19  #Interrrupt port - must match port configured in SDP record
    PROFILE_DBUS_PATH="/bluez/yaptb/btkb_profile" #dbus path of  the
bluez profile we will create
    UUID="00001124-0000-1000-8000-00805f9b34fb"


    def __init__(self):

        print("Setting up BT device")
        self.init_bluez_profile()


    #set up a bluez profile to advertise device capabilities from a
loaded service record
    def init_bluez_profile(self):
        bus = dbus.SystemBus()

        print ("setting adapter to discoverable")
        self.adapter =
dbus.Interface(bus.get_object("org.bluez","/org/bluez"),
"org.bluez.Adapter1")
        self.adapter.Discoverable =True

        print("Configuring Bluez Profile")

        opts = {
            "Role":"server",
            "AutoConnect":True
        }

        self.manager =
dbus.Interface(bus.get_object("org.bluez","/org/bluez"),
"org.bluez.ProfileManager1")
        self.profile = BTKbBluezProfile(bus,
BTKbDevice.PROFILE_DBUS_PATH)#BTKbDevice.PROFILE_DBUS_PATH)
        self.manager.RegisterProfile(BTKbDevice.PROFILE_DBUS_PATH,
BTKbDevice.UUID, opts)
        print("Profile registered ")

class BTKbBluezProfile(dbus.service.Object):
    fd = -1

    @dbus.service.method("org.bluez.Profile1",
                                    in_signature="", out_signature="")
    def Release(self):
            print("Release")
            mainloop.quit()

    @dbus.service.method("org.bluez.Profile1",
                                    in_signature="", out_signature="")
    def Cancel(self):
            print("Cancel")

    @dbus.service.method("org.bluez.Profile1", in_signature="oha{sv}",
out_signature="")
    def NewConnection(self, path, fd, properties):
            self.fd = fd.take()
            print("NewConnection(%s, %d)" % (path, self.fd))
            for key in properties.keys():
                    print ('key ' + key + ' value ' + properties[key])
                    if key == "Version" or key == "Features":
                            print("  %s = 0x%04x" % (key, properties[key]))
                    else:
                            print("  %s = %s" % (key, properties[key]))



    @dbus.service.method("org.bluez.Profile1", in_signature="o",
out_signature="")
    def RequestDisconnection(self, path):
            print("RequestDisconnection(%s)" % (path))

            if (self.fd > 0):
                    os.close(self.fd)
                    self.fd = -1

    def __init__(self, bus, path):
            dbus.service.Object.__init__(self, bus, path)
---

  There is a bit more code but this is the main part and it executes
and I can see activity on the bluetoothd log:

bluetoothd[579]: src/profile.c:register_profile() sender :1.11
bluetoothd[579]: src/profile.c:create_ext() Created
":1.11/bluez/yaptb/btkb_profile/00001124-0000-1000-8000-00805f9b34fb"
bluetoothd[579]: src/profile.c:ext_adapter_probe()
":1.11/bluez/yaptb/btkb_profile/00001124-0000-1000-8000-00805f9b34fb"
probed
bluetoothd[579]: src/adapter.c:adapter_service_add() /org/bluez/hci0
bluetoothd[579]: src/sdpd-service.c:add_record_to_server() Adding
record with handle 0x10003
bluetoothd[579]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[579]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[579]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00001124-0000-1000-8000-00805f9
bluetoothd[579]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
bluetoothd[579]: src/adapter.c:add_uuid() sending add uuid command for index 0

  However but when I attempt to connect from the Windows PC it cannot
find the Raspberry Pi0W so it is no longer discoverable - I'm missing
something here; do you have any idea what it is?  Note that when I've
got this done I'm going to write it up and publish it so that should
help others after me.

  Thanks for your advice.

Cheers,

Neil
On Tue, 2 Oct 2018 at 15:57, Barry Byford <31baz66@gmail.com> wrote:
>
> Hi Luiz,
>
> On Tue, 2 Oct 2018 at 13:48, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Neil,
> > On Tue, Oct 2, 2018 at 3:29 PM Neil Benn <neil.benn@ziath.com> wrote:
> > >
> > > Hello,
> > >
> > >   Thanks for that please see inline below:
> > >
> > >
> > > On Tue, 2 Oct 2018, 12:28 Luiz Augusto von Dentz, <luiz.dentz@gmail.com> wrote:
> > > >
> > > > Hi Neil,
> > > > On Tue, Oct 2, 2018 at 1:39 PM Neil Benn <neil.benn@ziath.com> wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > >   Thanks for that; I'll change the config file for this and for the
> > > > > name can that be in the main.conf file?  The same for the
> > > > > discoverable; set the timeout to zero - there is no security needed
> > > > > for this device at all.  Can this all be done with the conf file?
> > > > >
> > > > >   On the connection; yes it connects.  This is a HID device connecting
> > > > > via L2CAP with the interrupt on 19 and the control on 17 and the
> > > > > windows PC correctly connects to the device, queries the service
> > > > > record, identifies it as a HID and connects on both the control and
> > > > > interrupt psm ports but none of the dbus methods are being called.  At
> > > > > the moment I am using the pybluez library with the BluetoothSocket and
> > > > > calling listen and accept which is a bit 'manual'.  To detect a
> > > > > disconnect I'm calling hcitool con and parsing the response - which is
> > > > > again a bit manual.  Please see below for my current 'hack':
> > > >
> > > > I don't think that will work since the input plugin is already
> > > > listening in those PSM,
> > >
> > > It does connect and work but it doesn't register the profile.  If I
> > > don't register the profile the default name in the config is used
> > > >
> > > > in fact I don't think RegisterProfile would
> > > > parse the values from the record since you don't seem to be using the
> > > > PSM:
> > > >
> > > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/profile-api.txt#n54
> > >
> > >
> > > The PSM is defined in the service record
> > > >
> > > >
> > > >
> > > > Btw, why would you want to replace the HID profile? Is that not working?
> > >
> > > I'm using an sdp profile provided in some sample code I found, is
> > > there a default one that is supported?  Is that default one selected
> > > when I pick my uuid?
> >
> > You are not suppose to use existing UUIDs that the daemon already
> > registers, the fact that you are able to register it without cause a
> > problem might be a bug and we should probably check if the UUID is
> > already registered and fail if it does.
> >
> > The HID profile is implementation is under profiles/input/, it
> > actually hooks with kernel HID drivers.
> >
> > If you just want to test it you should probably have a look at
> > test-profile in python:
>
> Do you have any example invocations of test-profile for common profiles?
>
> It can be difficult to know where the issue is if you are not
> confident with what settings should work.
>
> >
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test/test-profile
> >
> > >   If so then I think it has been overcomplicated by this sdp profile?
> > > How do I use the default in-built profile - is it just the uuid?
> > > On Tue, 2 Oct 2018 at 12:28, Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > Hi Neil,
> > > > On Tue, Oct 2, 2018 at 1:39 PM Neil Benn <neil.benn@ziath.com> wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > >   Thanks for that; I'll change the config file for this and for the
> > > > > name can that be in the main.conf file?  The same for the
> > > > > discoverable; set the timeout to zero - there is no security needed
> > > > > for this device at all.  Can this all be done with the conf file?
> > > > >
> > > > >   On the connection; yes it connects.  This is a HID device connecting
> > > > > via L2CAP with the interrupt on 19 and the control on 17 and the
> > > > > windows PC correctly connects to the device, queries the service
> > > > > record, identifies it as a HID and connects on both the control and
> > > > > interrupt psm ports but none of the dbus methods are being called.  At
> > > > > the moment I am using the pybluez library with the BluetoothSocket and
> > > > > calling listen and accept which is a bit 'manual'.  To detect a
> > > > > disconnect I'm calling hcitool con and parsing the response - which is
> > > > > again a bit manual.  Please see below for my current 'hack':
> > > >
> > > > I don't think that will work since the input plugin is already
> > > > listening in those PSM, in fact I don't think RegisterProfile would
> > > > parse the values from the record since you don't seem to be using the
> > > > PSM:
> > > >
> > > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/profile-api.txt#n54
> > > >
> > > > Btw, why would you want to replace the HID profile? Is that not working?
> > > >
> > > > > ---
> > > > >     #listen for incoming client connections
> > > > >     #ideally this would be handled by the Bluez 5 profile
> > > > >     #but that didn't seem to work
> > > > >     def listen(self):
> > > > >
> > > > >         print("Waiting for connections")
> > > > >         self.scontrol=BluetoothSocket(L2CAP)
> > > > >         self.sinterrupt=BluetoothSocket(L2CAP)
> > > > >
> > > > >         self.scontrol.bind((self.MY_ADDRESS,self.P_CTRL))
> > > > >         self.sinterrupt.bind((self.MY_ADDRESS,self.P_INTR ))
> > > > >         #Start listening on the server sockets
> > > > >         self.scontrol.listen(1) # Limit of 1 connection
> > > > >         self.sinterrupt.listen(1)
> > > > >
> > > > >         self.ccontrol,cinfo = self.scontrol.accept()
> > > > >         self.controlClientMac = cinfo[0]
> > > > >         self.controlClientPsm = cinfo[1]
> > > > >         print ('control is ' + self.controlClientMac + " " +
> > > > > str(self.controlClientPsm))
> > > > >
> > > > >         self.cinterrupt, cinfo = self.sinterrupt.accept()
> > > > >         self.interruptClientMac = cinfo[0]
> > > > >         self.interruptClientPsm = cinfo[1]
> > > > >         print ('interrupt is ' + self.interruptClientMac + " " +
> > > > > str(self.interruptClientPsm))
> > > > >
> > > > >         thread.start_new_thread(self.check_connection, ())
> > > > >
> > > > >     def check_connection(self):
> > > > >         halt = False
> > > > >         while not halt:
> > > > >             stdoutdata = subprocess.check_output(["hcitool", "con"])
> > > > >
> > > > >             if self.controlClientMac in stdoutdata.split():
> > > > >                 time.sleep(0.1)
> > > > >             else:
> > > > >                 print('got disconnection')
> > > > >                 self.scontrol.shutdown(2);
> > > > >                 self.sinterrupt.shutdown(2)
> > > > >                 halt = True
> > > > >         thread.start_new_thread(self.listen, ())
> > > > >
> > > > >   Obviously this is a very clumsy way of doing it and calling back on
> > > > > the profile is the correct way to do it, I just can't work out why the
> > > > > profile is not being called.  I'm trying to spy on the dbus comms to
> > > > > see if anything is being sent but I can't see any bluez profile
> > > > > messages being sent at all.  Thanks for your response and any advice
> > > > > is greatly appreciated.
> > > > >
> > > > > Cheers,
> > > > >
> > > > > Neil
> > > > > On Tue, 2 Oct 2018 at 09:37, Luiz Augusto von Dentz
> > > > > <luiz.dentz@gmail.com> wrote:
> > > > > >
> > > > > > Hi Neil,
> > > > > > On Tue, Oct 2, 2018 at 1:32 AM Neil Benn <neil.benn@ziath.com> wrote:
> > > > > > >
> > > > > > > Hello,
> > > > > > >
> > > > > > >   I've been running a dbus-monitor and I can't see the interface being
> > > > > > > called of 'org.bluez.Profile1' - I can see 'org.bluez.Device1' and
> > > > > > > I've tried listening to that interface and also on the path with
> > > > > > > dev_<ADAPTER-MAC> but I'm clearly doing something fundamentally wrong.
> > > > > > > IF anyone has any advance I'd be very grateful and there is 100 rep
> > > > > > > points up on Stack Overflow for any advice too!
> > > > > > >
> > > > > > >   Thanks; it's late here and I'll not be home till gone 1am so I'll be off now!
> > > > > > >
> > > > > > > Cheers,
> > > > > > >
> > > > > > > Neil
> > > > > > > On Fri, 28 Sep 2018 at 23:38, Neil Benn <neil.benn@ziath.com> wrote:
> > > > > > > >
> > > > > > > > Hello,
> > > > > > > >
> > > > > > > >   I'm trying to setup a RPi0 operating a Bluetooth device; I've setup
> > > > > > > > the device using the following call:
> > > > > > > > ---
> > > > > > > >     #configure the bluetooth hardware device
> > > > > > > >     def init_bt_device(self):
> > > > > > > >
> > > > > > > >         print("Configuring for name " + BTKbDevice.MY_DEV_NAME)
> > > > > > > >
> > > > > > > >         #set the device class to a barcode scanner and set the name
> > > > > > > >         os.system("hciconfig hcio class 0x002560")
> > > > > > > >         os.system("hciconfig hcio name " + BTKbDevice.MY_DEV_NAME)
> > > > > > > >
> > > > > > > >         #make the device discoverable
> > > > > > > >         os.system("hciconfig hcio piscan")
> > > > > > > >
> > > > > >
> > > > > > You shouldn't be using hciconfig, instead do the following:
> > > > > >
> > > > > > The class is automatically set by bluetoothd based on the
> > > > > > services/profiles registered and the setting in the main.conf:
> > > > > >
> > > > > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/main.conf#n9
> > > > > >
> > > > > > For the name use D-Bus property Alias:
> > > > > >
> > > > > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/adapter-api.txt#n216
> > > > > >
> > > > > > To make the adapter discoverable use D-Bus property Discoverable:
> > > > > >
> > > > > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/adapter-api.txt#n252
> > > > > >
> > > > > >
> > > > > >
> > > > > > > >   Then after that I attempt to setup the profile using the following code:
> > > > > > > > ---
> > > > > > > >     #set up a bluez profile to advertise device capabilities from a
> > > > > > > > loaded service record
> > > > > > > >     def init_bluez_profile(self):
> > > > > > > >
> > > > > > > >         print("Configuring Bluez Profile")
> > > > > > > >
> > > > > > > >         #setup profile options
> > > > > > > >         service_record=self.read_sdp_service_record()
> > > > > > > >
> > > > > > > >         opts = {
> > > > > > > >             "ServiceRecord":service_record,
> > > > > > > >             "Role":"server",
> > > > > > > >             "RequireAuthentication":False,
> > > > > > > >             "RequireAuthorization":False,
> > > > > > > >             "Name":BTKbDevice.MY_DEV_NAME,
> > > > > > > >             "AutoConnect":True
> > > > > > > >         }
> > > > > > > >
> > > > > > > >         #retrieve a proxy for the bluez profile interface
> > > > > > > >         bus = dbus.SystemBus()
> > > > > > > >         self.manager =
> > > > > > > > dbus.Interface(bus.get_object("org.bluez","/org/bluez"),
> > > > > > > > "org.bluez.ProfileManager1")
> > > > > > > >         self.profile = BTKbBluezProfile(bus, BTKbDevice.PROFILE_DBUS_PATH)
> > > > > > > >         self.manager.RegisterProfile(BTKbDevice.PROFILE_DBUS_PATH,
> > > > > > > > BTKbDevice.UUID, opts)
> > > > > > > >         print("Profile registered ")
> > > > > > > > ---
> > > > > > > >   The sdp record is available from https://textuploader.com/dv8xt.
> > > > > > > > The profile in question is basically the same as the one defined in
> > > > > > > > the test-profile as shown below:
> > > > > > > > ---
> > > > > > > > class BTKbBluezProfile(dbus.service.Object):
> > > > > > > >     fd = -1
> > > > > > > >
> > > > > > > >     @dbus.service.method("org.bluez.Profile1",
> > > > > > > >                                     in_signature="", out_signature="")
> > > > > > > >     def Release(self):
> > > > > > > >             print("Release")
> > > > > > > >             mainloop.quit()
> > > > > > > >
> > > > > > > >     @dbus.service.method("org.bluez.Profile1",
> > > > > > > >                                     in_signature="", out_signature="")
> > > > > > > >     def Cancel(self):
> > > > > > > >             print("Cancel")
> > > > > > > >
> > > > > > > >     @dbus.service.method("org.bluez.Profile1", in_signature="oha{sv}",
> > > > > > > > out_signature="")
> > > > > > > >     def NewConnection(self, path, fd, properties):
> > > > > > > >             self.fd = fd.take()
> > > > > > > >             print("NewConnection(%s, %d)" % (path, self.fd))
> > > > > > > >             for key in properties.keys():
> > > > > > > >                     print ('key ' + key + ' value ' + properties[key])
> > > > > > > >                     if key == "Version" or key == "Features":
> > > > > > > >                             print("  %s = 0x%04x" % (key, properties[key]))
> > > > > > > >                     else:
> > > > > > > >                             print("  %s = %s" % (key, properties[key]))
> > > > > > > >
> > > > > > > >     @dbus.service.method("org.bluez.Profile1", in_signature="o",
> > > > > > > > out_signature="")
> > > > > > > >     def RequestDisconnection(self, path):
> > > > > > > >             print("RequestDisconnection(%s)" % (path))
> > > > > > > >
> > > > > > > >             if (self.fd > 0):
> > > > > > > >                     os.close(self.fd)
> > > > > > > >                     self.fd = -1
> > > > > > > >
> > > > > > > >     def __init__(self, bus, path):
> > > > > > > >             dbus.service.Object.__init__(self, bus, path)
> > > > > > > > ---
> > > > > > > >   However it seems like the profile is not being registered, or least
> > > > > > > > the methods in the profile are not being called.  I'm sorry to ask
> > > > > > > > such a basic question but can someone please point me in the right
> > > > > > > > direction as to why the profile is either not being registered or the
> > > > > > > > callbacks on the profile are not being called.
> > > > > >
> > > > > > They would be called only when there is a connection to the profile,
> > > > > > did you actually connect? If this is something like a serial port the
> > > > > > remote should lookup the SDP record and connect to the channel listed
> > > > > > there.
> > > > > >
> > > > > > > >   Thank you very much for reading this far and any and all help is
> > > > > > > > most appreciated!
> > > > > > > >
> > > > > > > > Cheers,
> > > > > > > >
> > > > > > > > Neil
> > > > > > > >
> > > > > > > > --
> > > > > > > >
> > > > > > > > Neil Benn MSc
> > > > > > > > Ziath Ltd
> > > > > > > > Phone: +44 (0) 1223 855021
> > > > > > > > http://www.ziath.com
> > > > > > > >
> > > > > > > > Please consider the environment before printing this email.
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
> > > > >
> > > > >
> > > > >
> > > > > --
> > > > >
> > > > > Neil Benn MSc
> > > > > Ziath Ltd
> > > > > Phone: +44 (0) 1223 855021
> > > > > http://www.ziath.com
> > > > >
> > > > > Please consider the environment before printing this email.
> > > > >
> > > > > Follow us on Facebook, Twitter or LinkedIn
> > > > >
> > > > > IMPORTANT NOTICE: This message, including any attached documents, is
> > > > > intended only for the use of the individual or entity to which it is
> > > > > addressed, and may contain information that is privileged,
> > > > > confidential and exempt from disclosure under applicable law. If the
> > > > > reader of this message is not the intended recipient, or the employee
> > > > > or agent responsible for delivering the message to the intended
> > > > > recipient, you are hereby notified that any dissemination,
> > > > > distribution or copying of this communication is strictly prohibited.
> > > > > If you have received this communication in error, please notify Ziath
> > > > > Ltd immediately by email at info@ziath.com. Thank you.
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



-- 

Neil Benn MSc
Ziath Ltd
Phone: +44 (0) 1223 855021
http://www.ziath.com

Please consider the environment before printing this email.

Follow us on Facebook, Twitter or LinkedIn

IMPORTANT NOTICE: This message, including any attached documents, is
intended only for the use of the individual or entity to which it is
addressed, and may contain information that is privileged,
confidential and exempt from disclosure under applicable law. If the
reader of this message is not the intended recipient, or the employee
or agent responsible for delivering the message to the intended
recipient, you are hereby notified that any dissemination,
distribution or copying of this communication is strictly prohibited.
If you have received this communication in error, please notify Ziath
Ltd immediately by email at info@ziath.com. Thank you.
