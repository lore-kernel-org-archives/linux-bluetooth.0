Return-Path: <SRS0=6kNt=MO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBA7C43143
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Oct 2018 08:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E94B120878
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Oct 2018 08:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tsKBwRYt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E94B120878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbeJBPft (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:35:49 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:42117 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbeJBPfs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Oct 2018 11:35:48 -0400
Received: by mail-oi1-f174.google.com with SMTP id w81-v6so878618oiw.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Oct 2018 01:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2KPP35cvIcGDxHseGYN6rOIYY+Cwq20ZI4KqoJVDsUw=;
        b=tsKBwRYtDxvsFyCn7x0Eaa03zn2whzn69gNWaS0fNavgHrGYi5kwaEfHJh46h/QXJ7
         hMJ46CpsrqIpkblLPrmQBkc6Avl8sfRyzMA3pGTxhltCf9QlOsHnBczNymLI37fQt6h1
         tlM+Ok2x6G544UDrGcEyQA0KzTJWejxlCGCRz/+WiuR7+hRf2nNJ2f82y/DBIu++1jZK
         Ue/YBwf6SYcFmaBbZ4rtfCmCcCHMroVBacA1+vb4qTKjA9HExRvKotL3ibGyDSnNc/kq
         uPGkSGMzPSW9xkgQhSit36LpyJnptJKOcDx+aubVaKARkLhhxS/UIqIRVzkwb0/Rc+RT
         RfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2KPP35cvIcGDxHseGYN6rOIYY+Cwq20ZI4KqoJVDsUw=;
        b=oxZI8K+l+1CmORY75rRQnOi+n3JHktbQAWGFOPLY+yctWh4aIgRWhX8E/rIHGpeq29
         VDFiv/nNTDfYB17Bh9LXJ9EbZEXawOYsqTkaF+buXsBv/tce3o0mMiQRuGNBciv/uCLS
         tiKmzM/BZXgfzlfaCxg40S91gyd06KCGU2MsCicortfstgSa4LKJIyKo+vzyHmSLv0e1
         xppKbAOlQTqrF5VWMCaJaD2E9tCtCnyfWdixGxe3+WW88EocKPDGy7mnWmFDjEcxaBZ9
         FQb4QbONxa8YmLH3y5+l14/sx9PWi5ptO9Aqz75s98XEQQAmJYNZrXrDGyTljB7qO+s1
         DMhA==
X-Gm-Message-State: ABuFfohsjPetjtpzQbgn16b7FewAFoUdm6SKHT611QbUB+ZnwuHq7VP/
        8DFxBj5AiyN/hfkMCwPm2+nONNVjwx5lFqBEVCywsewe
X-Google-Smtp-Source: ACcGV63buvXe4ZMqXlUVJ9bUFKCnZBk/r5j3RjnvMvBVJtmSZuqXPkwdAkX+ishDZYM9us60vxj5cgAODiAuNxlGmos=
X-Received: by 2002:aca:c2c1:: with SMTP id s184-v6mr6440233oif.117.1538470416889;
 Tue, 02 Oct 2018 01:53:36 -0700 (PDT)
MIME-Version: 1.0
References: <20181001102430.GA6708@amd> <CAAu3APYAmr9M5NQkvqsG1-J_zn=Jiq4M18NYLx50WAAU3eb93w@mail.gmail.com>
In-Reply-To: <CAAu3APYAmr9M5NQkvqsG1-J_zn=Jiq4M18NYLx50WAAU3eb93w@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 2 Oct 2018 11:53:24 +0300
Message-ID: <CABBYNZ+R5M+gDyFZ6+fuJyXtNbvPiM7bh+BVeYQOn8oP9JJgSQ@mail.gmail.com>
Subject: Re: low energy: does gatt client/server work in current version? How
 to test?
To:     Barry Byford <31baz66@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Barry, Pavel,

On Mon, Oct 1, 2018 at 4:53 PM Barry Byford <31baz66@gmail.com> wrote:
>
> There has been a discussion on the mailing previously that covered some of this.
>
> Is there anything in this thread that helps:
> https://marc.info/?t=149208458400001&r=1&w=2
>
> On Mon, 1 Oct 2018 at 11:25, Pavel Machek <pavel@ucw.cz> wrote:
> >
> > Hi!
> >
> > I'm trying to get gatt client/server to run; my ultimate goal is to
> > turn Linux machine into "low-energy device", providing services
> > similar to heartbeat measurement.
> >
> > I do have existing qt application (running on Android and PC) I'd like
> > "device" to talk to.
> >
> > TODO says:
> >
> > - Add complete GATT test coverage in unit/test-gatt following the GATT
> >   test
> >     spec. This could use shared/gatt-client and shared/gatt-server at
> >   the same
> >     time to test both against each other. We should definitely have
> >   tests for
> >     gatt-server and gatt-client simultaneously on one side of the
> >   connection.
> >
> >   Priority: High
> >     Complexity: C4
> >
> > Which tells me that maybe I should consider helping with that. But so
> > far I was not able to get it to work...

This is unit testing with a socket pair, so I don't think it has
anything to do with what follows bellow.

> > I can use gatt-server and connect to it using gatttool, but depending
> > on details during the server start (?) and phase of moon, either
> > device is not enumerated by the QT code, or it is not detected as
> > low-energy device, or no UUIDs are detected.
> >
> > My attempt at launching server is below (using python gatt-server, (1)
> > ). I was doing "hciconfig leadv 0" manually at some point.
> >
> > Using hciconfig while bluetoothd is running sounds kind-of
> > dangerous. Stackoverflow (2) suggests using btmgmt (3) instead, and
> > things got slightly different, but did not start to work for me. Is
> > there documentation how to get this to work somewhere?

Have a look at bluetoothctl first, all the necessary commands are
there to enable to act as peripheral:

Menu advertise:
Available commands:
-------------------
uuids [uuid1 uuid2 ...]                           Set/Get advertise uuids
service [uuid] [data=xx xx ...]                   Set/Get advertise service data
manufacturer [id] [data=xx xx ...]                Set/Get advertise
manufacturer data
data [type] [data=xx xx ...]                      Set/Get advertise data
discoverable [on/off]                             Set/Get advertise discoverable
discoverable-timeout [seconds]                    Set/Get advertise
discoverable timeout
tx-power [on/off]                                 Show/Enable/Disable
TX power to be advertised
name [on/off/name]                                Configure local name
to be advertised
appearance [on/off/value]                         Configure custom
appearance to be advertised
duration [seconds]                                Set/Get advertise duration
timeout [seconds]                                 Set/Get advertise timeout
clear [uuids/service/manufacturer/config-name...] Clear advertise config

GATT Services can be registered with:

Menu gatt:
Available commands:
-------------------
list-attributes [dev]                             List attributes
select-attribute <attribute/UUID>                 Select attribute
attribute-info [attribute/UUID]                   Select attribute
read [offset]                                     Read attribute value
write <data=xx xx ...> [offset]                   Write attribute value
acquire-write                                     Acquire Write file descriptor
release-write                                     Release Write file descriptor
acquire-notify                                    Acquire Notify file descriptor
release-notify                                    Release Notify file descriptor
notify <on/off>                                   Notify attribute value
register-application [UUID ...]                   Register profile to connect
unregister-application                            Unregister profile
register-service <UUID>                           Register application service.
unregister-service <UUID/object>                  Unregister application service
register-includes <UUID>                          Register as Included
service in.
unregister-includes <Service-UUID><Inc-UUID>      Unregister Included service.
register-characteristic <UUID> <Flags=read,write,notify...>  Register
application characteristic
unregister-characteristic <UUID/object>           Unregister
application characteristic
register-descriptor <UUID> <Flags=read,write...>  Register application
descriptor
unregister-descriptor <UUID/object>               Unregister
application descriptor

> > Thanks and best regards,
> >                                                         Pavel
> >
> > (3)
> > sudo tools/btmgmt -i hci0 power off
> > sudo tools/btmgmt -i hci0 le on
> > sudo tools/btmgmt -i hci0 connectable on
> > sudo tools/btmgmt -i hci0 name "some friendly name"
> > sudo tools/btmgmt -i hci0 advertising on
> > sudo tools/btmgmt -i hci0 power on
> > tools/btgatt-server -i hci0 -s low -t public -r -v

No need to use btmgmt, applications should use the D-Bus API which has
pretty much everything you are doing with btmgmt.

> > (2)
> > https://stackoverflow.com/questions/29128586/bluetooth-low-energy-in-c-using-bluez-to-create-a-gatt-server#31030321
> >
> > (1)
> > #!/usr/bin/python3
> > # -*- python -*-
> >
> > import os
> > import re
> > import time
> >
> > def pcmd(c):
> >     return os.popen(c).readline()[:-1]
> >
> > class Ble:
> >     def down(m):
> >         print("Shutting down BLEE")
> >         os.system("sudo killall bluetoohd")
> >         os.system("sudo killall gatt-server")
> >         os.system("sudo hciconfig hci0 down")
> >
> >     def up(m):
> >         print("Starting up BLEE")
> >         os.system("sudo ../bluez/src/bluetoothd -d -n &")
> >         time.sleep(2)
> >         os.system("sudo ./gatt-server &")

bluetoothd is already acting as a GATT server.

> >         time.sleep(2)
> >         os.system("sudo hciconfig hci0 up")
> >         ##os.system("../bluez/test/example-gatt-server &")
> >         while True:
> >             #os.system("sudo hciconfig hci0 leadv 0")

You may want to use example-advertisement instead of calling hciconfig.

> >             time.sleep(5)
> >
> >     def run(m):
> >         m.down()
> >         time.sleep(1)
> >         m.up()
> >
> > b = Ble()
> > b.run()
> >
> >
> >
> >                                                                         Pavel
> > --
> > (english) http://www.livejournal.com/~pavelmachek
> > (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html



-- 
Luiz Augusto von Dentz
