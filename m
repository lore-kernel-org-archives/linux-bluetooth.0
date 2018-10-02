Return-Path: <SRS0=6kNt=MO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE741C43143
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Oct 2018 08:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B00C20684
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Oct 2018 08:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlUKFhFm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B00C20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbeJBPT4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:19:56 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:46215 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbeJBPT4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Oct 2018 11:19:56 -0400
Received: by mail-ot1-f49.google.com with SMTP id o21so795495otb.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Oct 2018 01:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tu0EKwiPlYw7jyLzHSsNRZJUq+Xah8Kume5gfbap2WM=;
        b=mlUKFhFm9Q8uL+A+I9oN35omiaRJUjoZEKb6kQMc93uk/urqY888kyY8jY6zP3HxMi
         eLBXqwH98NI4RlywiZOt/88kD2ttpnfM847A/EefTf2/sbxDkZsL0T6WYsuyfwHksUmQ
         HKvtf2jcnW19rqLPKCDt4ABsm30NxsEcHkKkebLBA6w01J2NLZxL6RbUTSmZJWQKmSCZ
         rMs92q5EYsV9JNbDI9s/9TJpo2eqAX56tX0bYCU2ehk/bgUHDBs0pFiunFxWXIQHTkuQ
         jDgmpB2J7EERafITOr8DFoEjtkMTrhSbJRh23eDkrLtZqMKvsL0n5kL97Gttlxu3qczy
         EwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tu0EKwiPlYw7jyLzHSsNRZJUq+Xah8Kume5gfbap2WM=;
        b=tkL8ftk85AKu5nRXr5i8mr7K4VTximRdSjlVMs5PgkHQjmZkaT6xvrBPwv4lQk4OcS
         OwZ57/IjCxu8FC3hZbNDjV9HwHBGIymoZm+lsqO/l9ZbYl5ymiCQPq5YhbRedisYKOkj
         yXJSzvJ9uHX2sCqM+M7nxkuVXoMA2P6ZHG+xCrfuEpCQmfRUPDBmBSeDFFjjwy/tTc34
         r6BLZ4uomwW11K6KiJmQscovm/HwHvotW6ml8SKA+pY/XVe7fJd82I0Z16xPwT6nDo5p
         LQHi+lythOGgHHJm9qa4NOGoMGVdQ8LWCE0OzRosGILx4JfYzJ6Kp5FPLZ3VnPG7n8vf
         U4Dw==
X-Gm-Message-State: ABuFfoidqrzvLh4IzvYGopqmS5taYAPT0NbW/H96y4fEW+DzD5/lLr4x
        3lQ6OVpgCW8mevkZshi4R911LcR/Ha5cfZ26b+e6Mw==
X-Google-Smtp-Source: ACcGV62t3wMdTyJImVLTxTJAXV+aD4f4mAvwNuXnMpHFyXwcaV6fRyCAwcWe7171ex2i2y8WxX4j24sn0BKX245eX48=
X-Received: by 2002:a9d:542:: with SMTP id 60-v6mr9354968otw.71.1538469468358;
 Tue, 02 Oct 2018 01:37:48 -0700 (PDT)
MIME-Version: 1.0
References: <CADckva-V-8PeMDAVxJFFuVcq1zppCBEqrJdwH32PPf1nKVw=CQ@mail.gmail.com>
 <CADckva9qPjqEjH=06cCLkkgJi+qYbR6cz5ki3whXOV1qP5BRvg@mail.gmail.com>
In-Reply-To: <CADckva9qPjqEjH=06cCLkkgJi+qYbR6cz5ki3whXOV1qP5BRvg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 2 Oct 2018 11:37:36 +0300
Message-ID: <CABBYNZKaJc46C4Phu5HE18JXcYjfdD_kxS5Q7hOJJC4ZTsTyQA@mail.gmail.com>
Subject: Re: Registering a profile
To:     neil.benn@ziath.com
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Neil,
On Tue, Oct 2, 2018 at 1:32 AM Neil Benn <neil.benn@ziath.com> wrote:
>
> Hello,
>
>   I've been running a dbus-monitor and I can't see the interface being
> called of 'org.bluez.Profile1' - I can see 'org.bluez.Device1' and
> I've tried listening to that interface and also on the path with
> dev_<ADAPTER-MAC> but I'm clearly doing something fundamentally wrong.
> IF anyone has any advance I'd be very grateful and there is 100 rep
> points up on Stack Overflow for any advice too!
>
>   Thanks; it's late here and I'll not be home till gone 1am so I'll be off now!
>
> Cheers,
>
> Neil
> On Fri, 28 Sep 2018 at 23:38, Neil Benn <neil.benn@ziath.com> wrote:
> >
> > Hello,
> >
> >   I'm trying to setup a RPi0 operating a Bluetooth device; I've setup
> > the device using the following call:
> > ---
> >     #configure the bluetooth hardware device
> >     def init_bt_device(self):
> >
> >         print("Configuring for name " + BTKbDevice.MY_DEV_NAME)
> >
> >         #set the device class to a barcode scanner and set the name
> >         os.system("hciconfig hcio class 0x002560")
> >         os.system("hciconfig hcio name " + BTKbDevice.MY_DEV_NAME)
> >
> >         #make the device discoverable
> >         os.system("hciconfig hcio piscan")
> >

You shouldn't be using hciconfig, instead do the following:

The class is automatically set by bluetoothd based on the
services/profiles registered and the setting in the main.conf:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/main.conf#n9

For the name use D-Bus property Alias:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/adapter-api.txt#n216

To make the adapter discoverable use D-Bus property Discoverable:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/adapter-api.txt#n252



> >   Then after that I attempt to setup the profile using the following code:
> > ---
> >     #set up a bluez profile to advertise device capabilities from a
> > loaded service record
> >     def init_bluez_profile(self):
> >
> >         print("Configuring Bluez Profile")
> >
> >         #setup profile options
> >         service_record=self.read_sdp_service_record()
> >
> >         opts = {
> >             "ServiceRecord":service_record,
> >             "Role":"server",
> >             "RequireAuthentication":False,
> >             "RequireAuthorization":False,
> >             "Name":BTKbDevice.MY_DEV_NAME,
> >             "AutoConnect":True
> >         }
> >
> >         #retrieve a proxy for the bluez profile interface
> >         bus = dbus.SystemBus()
> >         self.manager =
> > dbus.Interface(bus.get_object("org.bluez","/org/bluez"),
> > "org.bluez.ProfileManager1")
> >         self.profile = BTKbBluezProfile(bus, BTKbDevice.PROFILE_DBUS_PATH)
> >         self.manager.RegisterProfile(BTKbDevice.PROFILE_DBUS_PATH,
> > BTKbDevice.UUID, opts)
> >         print("Profile registered ")
> > ---
> >   The sdp record is available from https://textuploader.com/dv8xt.
> > The profile in question is basically the same as the one defined in
> > the test-profile as shown below:
> > ---
> > class BTKbBluezProfile(dbus.service.Object):
> >     fd = -1
> >
> >     @dbus.service.method("org.bluez.Profile1",
> >                                     in_signature="", out_signature="")
> >     def Release(self):
> >             print("Release")
> >             mainloop.quit()
> >
> >     @dbus.service.method("org.bluez.Profile1",
> >                                     in_signature="", out_signature="")
> >     def Cancel(self):
> >             print("Cancel")
> >
> >     @dbus.service.method("org.bluez.Profile1", in_signature="oha{sv}",
> > out_signature="")
> >     def NewConnection(self, path, fd, properties):
> >             self.fd = fd.take()
> >             print("NewConnection(%s, %d)" % (path, self.fd))
> >             for key in properties.keys():
> >                     print ('key ' + key + ' value ' + properties[key])
> >                     if key == "Version" or key == "Features":
> >                             print("  %s = 0x%04x" % (key, properties[key]))
> >                     else:
> >                             print("  %s = %s" % (key, properties[key]))
> >
> >     @dbus.service.method("org.bluez.Profile1", in_signature="o",
> > out_signature="")
> >     def RequestDisconnection(self, path):
> >             print("RequestDisconnection(%s)" % (path))
> >
> >             if (self.fd > 0):
> >                     os.close(self.fd)
> >                     self.fd = -1
> >
> >     def __init__(self, bus, path):
> >             dbus.service.Object.__init__(self, bus, path)
> > ---
> >   However it seems like the profile is not being registered, or least
> > the methods in the profile are not being called.  I'm sorry to ask
> > such a basic question but can someone please point me in the right
> > direction as to why the profile is either not being registered or the
> > callbacks on the profile are not being called.

They would be called only when there is a connection to the profile,
did you actually connect? If this is something like a serial port the
remote should lookup the SDP record and connect to the channel listed
there.

> >   Thank you very much for reading this far and any and all help is
> > most appreciated!
> >
> > Cheers,
> >
> > Neil
> >
> > --
> >
> > Neil Benn MSc
> > Ziath Ltd
> > Phone: +44 (0) 1223 855021
> > http://www.ziath.com
> >
> > Please consider the environment before printing this email.
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
