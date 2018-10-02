Return-Path: <SRS0=6kNt=MO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E36EC43143
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Oct 2018 12:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D5262064E
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Oct 2018 12:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziath-com.20150623.gappssmtp.com header.i=@ziath-com.20150623.gappssmtp.com header.b="e+xtUSVz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D5262064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziath.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbeJBTMV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Oct 2018 15:12:21 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:37283 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbeJBTMU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Oct 2018 15:12:20 -0400
Received: by mail-lf1-f41.google.com with SMTP id a82-v6so1269329lfa.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Oct 2018 05:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziath-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QHFm63fNV4NV9xXL6hTqVqO6hZLpuqWHaCDyWmmoR0w=;
        b=e+xtUSVzQSX8AJMYSbEXrTnvXwE7uIJEvEZ/doQxW5zusvPRnvZYnN8VJJDyvT8tNB
         ucRhEMrCUKanjw+QUya4t0URdHtOKA7kuI2YA0o3usg+0nU8tKyb/HJJ2T5OEqd+unG2
         9PldQRfbdm6/MQ7/6GFEaHOvLjsjvojrZNyriDp99mRvEGLo7AHKhmM0wXn0yej3PtDC
         sK+v+HkTCyAEcBbjbU/5YOIXCYMJqJTsjiGzDKZddPCNuxAKtgGj29JpD/ut3QR5hJPS
         ahHmj+gI96G9fEWIvVShViLJGdkan9/kIh9VnkUMc7hm+S7X9d27RwMLZdnzFzJB3wJ5
         sK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QHFm63fNV4NV9xXL6hTqVqO6hZLpuqWHaCDyWmmoR0w=;
        b=EtTfv6RYnBKbirIMmBR67H9MJLOMJdrUVGOLPWT1BHl/zA4Qcc8ZQHKxfVTVfquKzk
         sfq2xnnhQL7qMSOAl0KTfrr5gQqFCZZNaLrQdRm3KUrl64XCpO1o6x9ns58E/GPO+l6d
         Iin/yrZnmwl9DeRzyAGVzKeRfFS2zUqdEZsHFYt9h6ZF24FgKyJv88hrFYYWpCOcWxBW
         fyPopjWuNxbvcujAGfE/Sb3VU7pBx98JVo6Vs2uoWzss58HqJr37wSpHZMZ9V8DSihwM
         fHblkj0IliXJ3h1DSb/Bcml5bX5RkpoK/X2HBcs8cwthKc4jMFWNRwafXpFkkUdRq2Zl
         Cnqw==
X-Gm-Message-State: ABuFfohxfXogKzP5/ohPJspuhbl5RVuSf+6s9g/oGCngM2U5Zmit6Isv
        sM5adykLEjDDfGF6xCrTLEcWkTTWXjMKEuKtymGsCA==
X-Google-Smtp-Source: ACcGV62S1jBWkJrmzpmXWuf5gDfy4vqKDfsZHJanHPauHvCJ4Cp7swjgUdxwMZ9odiJJiA4cfNkyyiBdsUF3ipCsQP0=
X-Received: by 2002:a19:c189:: with SMTP id r131-v6mr7818636lff.59.1538483351895;
 Tue, 02 Oct 2018 05:29:11 -0700 (PDT)
MIME-Version: 1.0
References: <CADckva-V-8PeMDAVxJFFuVcq1zppCBEqrJdwH32PPf1nKVw=CQ@mail.gmail.com>
 <CADckva9qPjqEjH=06cCLkkgJi+qYbR6cz5ki3whXOV1qP5BRvg@mail.gmail.com>
 <CABBYNZKaJc46C4Phu5HE18JXcYjfdD_kxS5Q7hOJJC4ZTsTyQA@mail.gmail.com>
 <CADckva9c-Nw85gH3yRBEvu_OD+J7EcccAjBZHB8ZQw92CndQZA@mail.gmail.com> <CABBYNZ+CmQ7KvjgDZzZ7sRPxLMmLi0L7pfMVEgz359Rb-Phwwg@mail.gmail.com>
In-Reply-To: <CABBYNZ+CmQ7KvjgDZzZ7sRPxLMmLi0L7pfMVEgz359Rb-Phwwg@mail.gmail.com>
From:   Neil Benn <neil.benn@ziath.com>
Date:   Tue, 2 Oct 2018 13:28:58 +0100
Message-ID: <CADckva_Xsa4euhy27qHQSQas2aoMKnK0pSvWndjoxLq2gohdTg@mail.gmail.com>
Subject: Re: Registering a profile
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

  Thanks for that please see inline below:


On Tue, 2 Oct 2018, 12:28 Luiz Augusto von Dentz, <luiz.dentz@gmail.com> wrote:
>
> Hi Neil,
> On Tue, Oct 2, 2018 at 1:39 PM Neil Benn <neil.benn@ziath.com> wrote:
> >
> > Hello,
> >
> >   Thanks for that; I'll change the config file for this and for the
> > name can that be in the main.conf file?  The same for the
> > discoverable; set the timeout to zero - there is no security needed
> > for this device at all.  Can this all be done with the conf file?
> >
> >   On the connection; yes it connects.  This is a HID device connecting
> > via L2CAP with the interrupt on 19 and the control on 17 and the
> > windows PC correctly connects to the device, queries the service
> > record, identifies it as a HID and connects on both the control and
> > interrupt psm ports but none of the dbus methods are being called.  At
> > the moment I am using the pybluez library with the BluetoothSocket and
> > calling listen and accept which is a bit 'manual'.  To detect a
> > disconnect I'm calling hcitool con and parsing the response - which is
> > again a bit manual.  Please see below for my current 'hack':
>
> I don't think that will work since the input plugin is already
> listening in those PSM,

It does connect and work but it doesn't register the profile.  If I
don't register the profile the default name in the config is used
>
> in fact I don't think RegisterProfile would
> parse the values from the record since you don't seem to be using the
> PSM:
>
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/profile-api.txt#n54


The PSM is defined in the service record
>
>
>
> Btw, why would you want to replace the HID profile? Is that not working?

I'm using an sdp profile provided in some sample code I found, is
there a default one that is supported?  Is that default one selected
when I pick my uuid?

  If so then I think it has been overcomplicated by this sdp profile?
How do I use the default in-built profile - is it just the uuid?
On Tue, 2 Oct 2018 at 12:28, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Neil,
> On Tue, Oct 2, 2018 at 1:39 PM Neil Benn <neil.benn@ziath.com> wrote:
> >
> > Hello,
> >
> >   Thanks for that; I'll change the config file for this and for the
> > name can that be in the main.conf file?  The same for the
> > discoverable; set the timeout to zero - there is no security needed
> > for this device at all.  Can this all be done with the conf file?
> >
> >   On the connection; yes it connects.  This is a HID device connecting
> > via L2CAP with the interrupt on 19 and the control on 17 and the
> > windows PC correctly connects to the device, queries the service
> > record, identifies it as a HID and connects on both the control and
> > interrupt psm ports but none of the dbus methods are being called.  At
> > the moment I am using the pybluez library with the BluetoothSocket and
> > calling listen and accept which is a bit 'manual'.  To detect a
> > disconnect I'm calling hcitool con and parsing the response - which is
> > again a bit manual.  Please see below for my current 'hack':
>
> I don't think that will work since the input plugin is already
> listening in those PSM, in fact I don't think RegisterProfile would
> parse the values from the record since you don't seem to be using the
> PSM:
>
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/profile-api.txt#n54
>
> Btw, why would you want to replace the HID profile? Is that not working?
>
> > ---
> >     #listen for incoming client connections
> >     #ideally this would be handled by the Bluez 5 profile
> >     #but that didn't seem to work
> >     def listen(self):
> >
> >         print("Waiting for connections")
> >         self.scontrol=BluetoothSocket(L2CAP)
> >         self.sinterrupt=BluetoothSocket(L2CAP)
> >
> >         self.scontrol.bind((self.MY_ADDRESS,self.P_CTRL))
> >         self.sinterrupt.bind((self.MY_ADDRESS,self.P_INTR ))
> >         #Start listening on the server sockets
> >         self.scontrol.listen(1) # Limit of 1 connection
> >         self.sinterrupt.listen(1)
> >
> >         self.ccontrol,cinfo = self.scontrol.accept()
> >         self.controlClientMac = cinfo[0]
> >         self.controlClientPsm = cinfo[1]
> >         print ('control is ' + self.controlClientMac + " " +
> > str(self.controlClientPsm))
> >
> >         self.cinterrupt, cinfo = self.sinterrupt.accept()
> >         self.interruptClientMac = cinfo[0]
> >         self.interruptClientPsm = cinfo[1]
> >         print ('interrupt is ' + self.interruptClientMac + " " +
> > str(self.interruptClientPsm))
> >
> >         thread.start_new_thread(self.check_connection, ())
> >
> >     def check_connection(self):
> >         halt = False
> >         while not halt:
> >             stdoutdata = subprocess.check_output(["hcitool", "con"])
> >
> >             if self.controlClientMac in stdoutdata.split():
> >                 time.sleep(0.1)
> >             else:
> >                 print('got disconnection')
> >                 self.scontrol.shutdown(2);
> >                 self.sinterrupt.shutdown(2)
> >                 halt = True
> >         thread.start_new_thread(self.listen, ())
> >
> >   Obviously this is a very clumsy way of doing it and calling back on
> > the profile is the correct way to do it, I just can't work out why the
> > profile is not being called.  I'm trying to spy on the dbus comms to
> > see if anything is being sent but I can't see any bluez profile
> > messages being sent at all.  Thanks for your response and any advice
> > is greatly appreciated.
> >
> > Cheers,
> >
> > Neil
> > On Tue, 2 Oct 2018 at 09:37, Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Neil,
> > > On Tue, Oct 2, 2018 at 1:32 AM Neil Benn <neil.benn@ziath.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > >   I've been running a dbus-monitor and I can't see the interface being
> > > > called of 'org.bluez.Profile1' - I can see 'org.bluez.Device1' and
> > > > I've tried listening to that interface and also on the path with
> > > > dev_<ADAPTER-MAC> but I'm clearly doing something fundamentally wrong.
> > > > IF anyone has any advance I'd be very grateful and there is 100 rep
> > > > points up on Stack Overflow for any advice too!
> > > >
> > > >   Thanks; it's late here and I'll not be home till gone 1am so I'll be off now!
> > > >
> > > > Cheers,
> > > >
> > > > Neil
> > > > On Fri, 28 Sep 2018 at 23:38, Neil Benn <neil.benn@ziath.com> wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > >   I'm trying to setup a RPi0 operating a Bluetooth device; I've setup
> > > > > the device using the following call:
> > > > > ---
> > > > >     #configure the bluetooth hardware device
> > > > >     def init_bt_device(self):
> > > > >
> > > > >         print("Configuring for name " + BTKbDevice.MY_DEV_NAME)
> > > > >
> > > > >         #set the device class to a barcode scanner and set the name
> > > > >         os.system("hciconfig hcio class 0x002560")
> > > > >         os.system("hciconfig hcio name " + BTKbDevice.MY_DEV_NAME)
> > > > >
> > > > >         #make the device discoverable
> > > > >         os.system("hciconfig hcio piscan")
> > > > >
> > >
> > > You shouldn't be using hciconfig, instead do the following:
> > >
> > > The class is automatically set by bluetoothd based on the
> > > services/profiles registered and the setting in the main.conf:
> > >
> > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/main.conf#n9
> > >
> > > For the name use D-Bus property Alias:
> > >
> > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/adapter-api.txt#n216
> > >
> > > To make the adapter discoverable use D-Bus property Discoverable:
> > >
> > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/adapter-api.txt#n252
> > >
> > >
> > >
> > > > >   Then after that I attempt to setup the profile using the following code:
> > > > > ---
> > > > >     #set up a bluez profile to advertise device capabilities from a
> > > > > loaded service record
> > > > >     def init_bluez_profile(self):
> > > > >
> > > > >         print("Configuring Bluez Profile")
> > > > >
> > > > >         #setup profile options
> > > > >         service_record=self.read_sdp_service_record()
> > > > >
> > > > >         opts = {
> > > > >             "ServiceRecord":service_record,
> > > > >             "Role":"server",
> > > > >             "RequireAuthentication":False,
> > > > >             "RequireAuthorization":False,
> > > > >             "Name":BTKbDevice.MY_DEV_NAME,
> > > > >             "AutoConnect":True
> > > > >         }
> > > > >
> > > > >         #retrieve a proxy for the bluez profile interface
> > > > >         bus = dbus.SystemBus()
> > > > >         self.manager =
> > > > > dbus.Interface(bus.get_object("org.bluez","/org/bluez"),
> > > > > "org.bluez.ProfileManager1")
> > > > >         self.profile = BTKbBluezProfile(bus, BTKbDevice.PROFILE_DBUS_PATH)
> > > > >         self.manager.RegisterProfile(BTKbDevice.PROFILE_DBUS_PATH,
> > > > > BTKbDevice.UUID, opts)
> > > > >         print("Profile registered ")
> > > > > ---
> > > > >   The sdp record is available from https://textuploader.com/dv8xt.
> > > > > The profile in question is basically the same as the one defined in
> > > > > the test-profile as shown below:
> > > > > ---
> > > > > class BTKbBluezProfile(dbus.service.Object):
> > > > >     fd = -1
> > > > >
> > > > >     @dbus.service.method("org.bluez.Profile1",
> > > > >                                     in_signature="", out_signature="")
> > > > >     def Release(self):
> > > > >             print("Release")
> > > > >             mainloop.quit()
> > > > >
> > > > >     @dbus.service.method("org.bluez.Profile1",
> > > > >                                     in_signature="", out_signature="")
> > > > >     def Cancel(self):
> > > > >             print("Cancel")
> > > > >
> > > > >     @dbus.service.method("org.bluez.Profile1", in_signature="oha{sv}",
> > > > > out_signature="")
> > > > >     def NewConnection(self, path, fd, properties):
> > > > >             self.fd = fd.take()
> > > > >             print("NewConnection(%s, %d)" % (path, self.fd))
> > > > >             for key in properties.keys():
> > > > >                     print ('key ' + key + ' value ' + properties[key])
> > > > >                     if key == "Version" or key == "Features":
> > > > >                             print("  %s = 0x%04x" % (key, properties[key]))
> > > > >                     else:
> > > > >                             print("  %s = %s" % (key, properties[key]))
> > > > >
> > > > >     @dbus.service.method("org.bluez.Profile1", in_signature="o",
> > > > > out_signature="")
> > > > >     def RequestDisconnection(self, path):
> > > > >             print("RequestDisconnection(%s)" % (path))
> > > > >
> > > > >             if (self.fd > 0):
> > > > >                     os.close(self.fd)
> > > > >                     self.fd = -1
> > > > >
> > > > >     def __init__(self, bus, path):
> > > > >             dbus.service.Object.__init__(self, bus, path)
> > > > > ---
> > > > >   However it seems like the profile is not being registered, or least
> > > > > the methods in the profile are not being called.  I'm sorry to ask
> > > > > such a basic question but can someone please point me in the right
> > > > > direction as to why the profile is either not being registered or the
> > > > > callbacks on the profile are not being called.
> > >
> > > They would be called only when there is a connection to the profile,
> > > did you actually connect? If this is something like a serial port the
> > > remote should lookup the SDP record and connect to the channel listed
> > > there.
> > >
> > > > >   Thank you very much for reading this far and any and all help is
> > > > > most appreciated!
> > > > >
> > > > > Cheers,
> > > > >
> > > > > Neil
> > > > >
> > > > > --
> > > > >
> > > > > Neil Benn MSc
> > > > > Ziath Ltd
> > > > > Phone: +44 (0) 1223 855021
> > > > > http://www.ziath.com
> > > > >
> > > > > Please consider the environment before printing this email.
> > > >
> > > >
> > > >
> > > > --
> > > >
> > > > Neil Benn MSc
> > > > Ziath Ltd
> > > > Phone: +44 (0) 1223 855021
> > > > http://www.ziath.com
> > > >
> > > > Please consider the environment before printing this email.
> > > >
> > > > Follow us on Facebook, Twitter or LinkedIn
> > > >
> > > > IMPORTANT NOTICE: This message, including any attached documents, is
> > > > intended only for the use of the individual or entity to which it is
> > > > addressed, and may contain information that is privileged,
> > > > confidential and exempt from disclosure under applicable law. If the
> > > > reader of this message is not the intended recipient, or the employee
> > > > or agent responsible for delivering the message to the intended
> > > > recipient, you are hereby notified that any dissemination,
> > > > distribution or copying of this communication is strictly prohibited.
> > > > If you have received this communication in error, please notify Ziath
> > > > Ltd immediately by email at info@ziath.com. Thank you.
> > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
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
