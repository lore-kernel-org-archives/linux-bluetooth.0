Return-Path: <SRS0=5peh=MK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276DDC64E93
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Sep 2018 22:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8367206B8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Sep 2018 22:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziath-com.20150623.gappssmtp.com header.i=@ziath-com.20150623.gappssmtp.com header.b="yO9WtQ1u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8367206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziath.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbeI2FEb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 29 Sep 2018 01:04:31 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:34595 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbeI2FEb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 29 Sep 2018 01:04:31 -0400
Received: by mail-lf1-f50.google.com with SMTP id y10-v6so6144612lfj.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Sep 2018 15:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziath-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=RTq1OKP5eBXLQuDLd6fxb1FapgILNrcgyQK5XTA/nJc=;
        b=yO9WtQ1uG49eLe9pvrY3aPWpedK/l+joVWkw6gMn1Vhd95hKQJpIfpguItfIZ53RbP
         ELH8JDCKfcVuAsAanIf16gYv/M7v7AvA0yDE/VRDX7vIc9J7852g8BkNCYDJNzw1tFyP
         TjoKCsb6Kry2nqthhDNA4Uq3LlX8b+I5CbnkSVRkaZwCBEd9XphSeMZiYTKS/CiJr1+g
         KvxyK+dc00/zmk+n/Dv+lYE8zQsKLB0ZhDe+x9UHHLvWFZiS3Cnzt9uuMCCKsvMlruXH
         fZy9mvZYiHKtfrw5rAW1L8yKKTcBcZ7MYPm3KxoZf/e9vv0S9rzHQ309gLNerUBoY90b
         07gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=RTq1OKP5eBXLQuDLd6fxb1FapgILNrcgyQK5XTA/nJc=;
        b=ShkRmLoR0EKvyNtr+m0p84G1Ef5s2tUzcc5jb9TkyKB4QDhzn0WyIPgV6yenYHVlIa
         agdO96mSnh/0ZRpeoVtUxw4dxZf+RLtxukHV+sbKhUIbbfIqUI7+HbEoiNHmL4N96tYl
         c5+Q0wQYABnWQD30nrrQI8UekRjVQWztT/Zf/Q1ATqeCw6w3oJTQoDwg62iTwt1kGRS6
         WPJ103P5XwmMEke51dD1WoXa35qZIi04gD8QQlIqV22KMVwznbAdi4XwYxnXlmASkX1t
         /AWKn193N3Gsfs0S4Uj9CjmVaer3NGPihD64LNWOkiYoojmC6puPWwVlDLNN/hZUxgYt
         zE7Q==
X-Gm-Message-State: ABuFfojOFM4yyWKgHi2R2lcHeBpbFHkXJ7FUNV6Cm+ujczUHsSNfhv6y
        MUFDJuKggJu6S4ZDFeO0ypgBrD3p3zbZKCpK7IeOxefKxBBoxA==
X-Google-Smtp-Source: ACcGV62bly9qdX2MInNYP3zBoMo0iYB9F3bjpGA8yy8Kw6Ku6PMSB8KXN7OT3v5KWoPxD7Rw4SktBIwkqkdmFZlsiRY=
X-Received: by 2002:a19:c189:: with SMTP id r131-v6mr286132lff.59.1538174315950;
 Fri, 28 Sep 2018 15:38:35 -0700 (PDT)
MIME-Version: 1.0
From:   Neil Benn <neil.benn@ziath.com>
Date:   Fri, 28 Sep 2018 23:38:16 +0100
Message-ID: <CADckva-V-8PeMDAVxJFFuVcq1zppCBEqrJdwH32PPf1nKVw=CQ@mail.gmail.com>
Subject: Registering a profile
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

  I'm trying to setup a RPi0 operating a Bluetooth device; I've setup
the device using the following call:
---
    #configure the bluetooth hardware device
    def init_bt_device(self):

        print("Configuring for name " + BTKbDevice.MY_DEV_NAME)

        #set the device class to a barcode scanner and set the name
        os.system("hciconfig hcio class 0x002560")
        os.system("hciconfig hcio name " + BTKbDevice.MY_DEV_NAME)

        #make the device discoverable
        os.system("hciconfig hcio piscan")

  Then after that I attempt to setup the profile using the following code:
---
    #set up a bluez profile to advertise device capabilities from a
loaded service record
    def init_bluez_profile(self):

        print("Configuring Bluez Profile")

        #setup profile options
        service_record=self.read_sdp_service_record()

        opts = {
            "ServiceRecord":service_record,
            "Role":"server",
            "RequireAuthentication":False,
            "RequireAuthorization":False,
            "Name":BTKbDevice.MY_DEV_NAME,
            "AutoConnect":True
        }

        #retrieve a proxy for the bluez profile interface
        bus = dbus.SystemBus()
        self.manager =
dbus.Interface(bus.get_object("org.bluez","/org/bluez"),
"org.bluez.ProfileManager1")
        self.profile = BTKbBluezProfile(bus, BTKbDevice.PROFILE_DBUS_PATH)
        self.manager.RegisterProfile(BTKbDevice.PROFILE_DBUS_PATH,
BTKbDevice.UUID, opts)
        print("Profile registered ")
---
  The sdp record is available from https://textuploader.com/dv8xt.
The profile in question is basically the same as the one defined in
the test-profile as shown below:
---
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
  However it seems like the profile is not being registered, or least
the methods in the profile are not being called.  I'm sorry to ask
such a basic question but can someone please point me in the right
direction as to why the profile is either not being registered or the
callbacks on the profile are not being called.

  Thank you very much for reading this far and any and all help is
most appreciated!

Cheers,

Neil

-- 

Neil Benn MSc
Ziath Ltd
Phone: +44 (0) 1223 855021
http://www.ziath.com

Please consider the environment before printing this email.
