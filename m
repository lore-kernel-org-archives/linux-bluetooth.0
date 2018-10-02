Return-Path: <SRS0=6kNt=MO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0730C43143
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Oct 2018 10:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F738204FD
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Oct 2018 10:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziath-com.20150623.gappssmtp.com header.i=@ziath-com.20150623.gappssmtp.com header.b="iOyj5sde"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F738204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziath.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbeJBRWZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Oct 2018 13:22:25 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:43943 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbeJBRWY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Oct 2018 13:22:24 -0400
Received: by mail-lf1-f41.google.com with SMTP id p34-v6so1025944lfg.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Oct 2018 03:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziath-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J1JTYGfkhpJlo9EPmmLKK3hGAjSFordli3+ERkZG8lk=;
        b=iOyj5sdeqP5Rtlp178QrXkp9LuhuaSC/zMjVwKtSQ3q6Hy6leeDgBcl0l+ZI+2tjMH
         2X66AEWo6CNeXCBLsQDmbSyRJZxsnk3WJcKPdFJxJDFUxcjNyiVmOZ68M8SyxdRKAfwo
         xNq2FTmiFpzl/+sJIsMFNP9ZHVCryE3R6aFrVliEfwXCDGDKCnljstZhuVAs/7yTDBrU
         QfYfoQYcyAel+dqGUMORNBdx/g6BoxmoPHnA9nwGpDJhneXMIgokjQTGHicRK1zoTbTa
         fITyE1dNoDDppLz+b0rrdT4lyC6WLfMr/mBRWBc7jrhAPhWtsz4ZcJ1sdpdVWwsJiCFI
         rl3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J1JTYGfkhpJlo9EPmmLKK3hGAjSFordli3+ERkZG8lk=;
        b=h3ho7TZRyuzOknJ0i+x4HyvJL9ynFivsP+ap2Kg/zaL4WqrjnQLxdo0iaAxGcTNqgU
         h59txvszjZgyy86Dt6Fz41VjZEIOPveLuPipKtUsBcBKmdNO7KHsPGsjajrXHCysDN0k
         yo39I0zP7AZNyfb4kTIeVliPVPnry6AP3DiipgY++ypXdOovLzhnPMSoEx6J2F04LMYn
         MhFYPI5qFBTp4cr1JaAPwELphYJ1mxzYgTxi6Qv8WVo/55CGJrLv8ebnk2DwjJ5dI1/+
         hT04tXIRmdg/1PTl1Pd+UnIgzm3TPEXENRGqV8WAe41SwKuTXNuINJTiEsI8piY6oOmp
         rZJQ==
X-Gm-Message-State: ABuFfojdoiFF2hvGBah1+0m6oeQ4XCxJ65l6tP9w8J965mFQgb3Oyjb7
        fw84eGfTwCg0j+ZoUdgb7dIac5nVq1+fK7CooBZFardURrcLzQ==
X-Google-Smtp-Source: ACcGV61Gj7aIaP/rc8dba6B5BE6eFtQ8tlxWsXqtm3hBbwBEp45U3ZLzAfWpFifQexSL25UUzQOmImP8KkTT5ZMjpF4=
X-Received: by 2002:a19:f817:: with SMTP id a23-v6mr7653651lff.67.1538476783954;
 Tue, 02 Oct 2018 03:39:43 -0700 (PDT)
MIME-Version: 1.0
References: <CADckva-V-8PeMDAVxJFFuVcq1zppCBEqrJdwH32PPf1nKVw=CQ@mail.gmail.com>
 <CADckva9qPjqEjH=06cCLkkgJi+qYbR6cz5ki3whXOV1qP5BRvg@mail.gmail.com> <CABBYNZKaJc46C4Phu5HE18JXcYjfdD_kxS5Q7hOJJC4ZTsTyQA@mail.gmail.com>
In-Reply-To: <CABBYNZKaJc46C4Phu5HE18JXcYjfdD_kxS5Q7hOJJC4ZTsTyQA@mail.gmail.com>
From:   Neil Benn <neil.benn@ziath.com>
Date:   Tue, 2 Oct 2018 11:39:30 +0100
Message-ID: <CADckva9c-Nw85gH3yRBEvu_OD+J7EcccAjBZHB8ZQw92CndQZA@mail.gmail.com>
Subject: Re: Registering a profile
To:     luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

  Thanks for that; I'll change the config file for this and for the
name can that be in the main.conf file?  The same for the
discoverable; set the timeout to zero - there is no security needed
for this device at all.  Can this all be done with the conf file?

  On the connection; yes it connects.  This is a HID device connecting
via L2CAP with the interrupt on 19 and the control on 17 and the
windows PC correctly connects to the device, queries the service
record, identifies it as a HID and connects on both the control and
interrupt psm ports but none of the dbus methods are being called.  At
the moment I am using the pybluez library with the BluetoothSocket and
calling listen and accept which is a bit 'manual'.  To detect a
disconnect I'm calling hcitool con and parsing the response - which is
again a bit manual.  Please see below for my current 'hack':

---
    #listen for incoming client connections
    #ideally this would be handled by the Bluez 5 profile
    #but that didn't seem to work
    def listen(self):

        print("Waiting for connections")
        self.scontrol=BluetoothSocket(L2CAP)
        self.sinterrupt=BluetoothSocket(L2CAP)

        self.scontrol.bind((self.MY_ADDRESS,self.P_CTRL))
        self.sinterrupt.bind((self.MY_ADDRESS,self.P_INTR ))
        #Start listening on the server sockets
        self.scontrol.listen(1) # Limit of 1 connection
        self.sinterrupt.listen(1)

        self.ccontrol,cinfo = self.scontrol.accept()
        self.controlClientMac = cinfo[0]
        self.controlClientPsm = cinfo[1]
        print ('control is ' + self.controlClientMac + " " +
str(self.controlClientPsm))

        self.cinterrupt, cinfo = self.sinterrupt.accept()
        self.interruptClientMac = cinfo[0]
        self.interruptClientPsm = cinfo[1]
        print ('interrupt is ' + self.interruptClientMac + " " +
str(self.interruptClientPsm))

        thread.start_new_thread(self.check_connection, ())

    def check_connection(self):
        halt = False
        while not halt:
            stdoutdata = subprocess.check_output(["hcitool", "con"])

            if self.controlClientMac in stdoutdata.split():
                time.sleep(0.1)
            else:
                print('got disconnection')
                self.scontrol.shutdown(2);
                self.sinterrupt.shutdown(2)
                halt = True
        thread.start_new_thread(self.listen, ())

  Obviously this is a very clumsy way of doing it and calling back on
the profile is the correct way to do it, I just can't work out why the
profile is not being called.  I'm trying to spy on the dbus comms to
see if anything is being sent but I can't see any bluez profile
messages being sent at all.  Thanks for your response and any advice
is greatly appreciated.

Cheers,

Neil
On Tue, 2 Oct 2018 at 09:37, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Neil,
> On Tue, Oct 2, 2018 at 1:32 AM Neil Benn <neil.benn@ziath.com> wrote:
> >
> > Hello,
> >
> >   I've been running a dbus-monitor and I can't see the interface being
> > called of 'org.bluez.Profile1' - I can see 'org.bluez.Device1' and
> > I've tried listening to that interface and also on the path with
> > dev_<ADAPTER-MAC> but I'm clearly doing something fundamentally wrong.
> > IF anyone has any advance I'd be very grateful and there is 100 rep
> > points up on Stack Overflow for any advice too!
> >
> >   Thanks; it's late here and I'll not be home till gone 1am so I'll be off now!
> >
> > Cheers,
> >
> > Neil
> > On Fri, 28 Sep 2018 at 23:38, Neil Benn <neil.benn@ziath.com> wrote:
> > >
> > > Hello,
> > >
> > >   I'm trying to setup a RPi0 operating a Bluetooth device; I've setup
> > > the device using the following call:
> > > ---
> > >     #configure the bluetooth hardware device
> > >     def init_bt_device(self):
> > >
> > >         print("Configuring for name " + BTKbDevice.MY_DEV_NAME)
> > >
> > >         #set the device class to a barcode scanner and set the name
> > >         os.system("hciconfig hcio class 0x002560")
> > >         os.system("hciconfig hcio name " + BTKbDevice.MY_DEV_NAME)
> > >
> > >         #make the device discoverable
> > >         os.system("hciconfig hcio piscan")
> > >
>
> You shouldn't be using hciconfig, instead do the following:
>
> The class is automatically set by bluetoothd based on the
> services/profiles registered and the setting in the main.conf:
>
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/main.conf#n9
>
> For the name use D-Bus property Alias:
>
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/adapter-api.txt#n216
>
> To make the adapter discoverable use D-Bus property Discoverable:
>
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/adapter-api.txt#n252
>
>
>
> > >   Then after that I attempt to setup the profile using the following code:
> > > ---
> > >     #set up a bluez profile to advertise device capabilities from a
> > > loaded service record
> > >     def init_bluez_profile(self):
> > >
> > >         print("Configuring Bluez Profile")
> > >
> > >         #setup profile options
> > >         service_record=self.read_sdp_service_record()
> > >
> > >         opts = {
> > >             "ServiceRecord":service_record,
> > >             "Role":"server",
> > >             "RequireAuthentication":False,
> > >             "RequireAuthorization":False,
> > >             "Name":BTKbDevice.MY_DEV_NAME,
> > >             "AutoConnect":True
> > >         }
> > >
> > >         #retrieve a proxy for the bluez profile interface
> > >         bus = dbus.SystemBus()
> > >         self.manager =
> > > dbus.Interface(bus.get_object("org.bluez","/org/bluez"),
> > > "org.bluez.ProfileManager1")
> > >         self.profile = BTKbBluezProfile(bus, BTKbDevice.PROFILE_DBUS_PATH)
> > >         self.manager.RegisterProfile(BTKbDevice.PROFILE_DBUS_PATH,
> > > BTKbDevice.UUID, opts)
> > >         print("Profile registered ")
> > > ---
> > >   The sdp record is available from https://textuploader.com/dv8xt.
> > > The profile in question is basically the same as the one defined in
> > > the test-profile as shown below:
> > > ---
> > > class BTKbBluezProfile(dbus.service.Object):
> > >     fd = -1
> > >
> > >     @dbus.service.method("org.bluez.Profile1",
> > >                                     in_signature="", out_signature="")
> > >     def Release(self):
> > >             print("Release")
> > >             mainloop.quit()
> > >
> > >     @dbus.service.method("org.bluez.Profile1",
> > >                                     in_signature="", out_signature="")
> > >     def Cancel(self):
> > >             print("Cancel")
> > >
> > >     @dbus.service.method("org.bluez.Profile1", in_signature="oha{sv}",
> > > out_signature="")
> > >     def NewConnection(self, path, fd, properties):
> > >             self.fd = fd.take()
> > >             print("NewConnection(%s, %d)" % (path, self.fd))
> > >             for key in properties.keys():
> > >                     print ('key ' + key + ' value ' + properties[key])
> > >                     if key == "Version" or key == "Features":
> > >                             print("  %s = 0x%04x" % (key, properties[key]))
> > >                     else:
> > >                             print("  %s = %s" % (key, properties[key]))
> > >
> > >     @dbus.service.method("org.bluez.Profile1", in_signature="o",
> > > out_signature="")
> > >     def RequestDisconnection(self, path):
> > >             print("RequestDisconnection(%s)" % (path))
> > >
> > >             if (self.fd > 0):
> > >                     os.close(self.fd)
> > >                     self.fd = -1
> > >
> > >     def __init__(self, bus, path):
> > >             dbus.service.Object.__init__(self, bus, path)
> > > ---
> > >   However it seems like the profile is not being registered, or least
> > > the methods in the profile are not being called.  I'm sorry to ask
> > > such a basic question but can someone please point me in the right
> > > direction as to why the profile is either not being registered or the
> > > callbacks on the profile are not being called.
>
> They would be called only when there is a connection to the profile,
> did you actually connect? If this is something like a serial port the
> remote should lookup the SDP record and connect to the channel listed
> there.
>
> > >   Thank you very much for reading this far and any and all help is
> > > most appreciated!
> > >
> > > Cheers,
> > >
> > > Neil
> > >
> > > --
> > >
> > > Neil Benn MSc
> > > Ziath Ltd
> > > Phone: +44 (0) 1223 855021
> > > http://www.ziath.com
> > >
> > > Please consider the environment before printing this email.
> >
> >
> >
> > --
> >
> > Neil Benn MSc
> > Ziath Ltd
> > Phone: +44 (0) 1223 855021
> > http://www.ziath.com
> >
> > Please consider the environment before printing this email.
> >
> > Follow us on Facebook, Twitter or LinkedIn
> >
> > IMPORTANT NOTICE: This message, including any attached documents, is
> > intended only for the use of the individual or entity to which it is
> > addressed, and may contain information that is privileged,
> > confidential and exempt from disclosure under applicable law. If the
> > reader of this message is not the intended recipient, or the employee
> > or agent responsible for delivering the message to the intended
> > recipient, you are hereby notified that any dissemination,
> > distribution or copying of this communication is strictly prohibited.
> > If you have received this communication in error, please notify Ziath
> > Ltd immediately by email at info@ziath.com. Thank you.
>
>
>
> --
> Luiz Augusto von Dentz



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
