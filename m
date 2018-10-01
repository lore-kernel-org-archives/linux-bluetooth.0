Return-Path: <SRS0=AfC+=MN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBD9C43143
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Oct 2018 22:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F33202145D
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Oct 2018 22:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziath-com.20150623.gappssmtp.com header.i=@ziath-com.20150623.gappssmtp.com header.b="vkNlaxiI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F33202145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziath.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbeJBFKB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Oct 2018 01:10:01 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:40307 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbeJBFKB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Oct 2018 01:10:01 -0400
Received: by mail-lj1-f180.google.com with SMTP id r83-v6so13730145ljr.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Oct 2018 15:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziath-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=URaC8IGp67QueVVNhthfsT6hscPA2Wf8vizkvGEJEcg=;
        b=vkNlaxiIwgc/cykdfBVdYBEYTqp3lTFDAuhc9ck0eWTEt6ok+igCcchJHyp5TOts6A
         a6HNhQeuEjt5Q2peZc3CF3Wp+4SztdIKmK82Skbf5dyAPyQtX11Lt1puhaa9448w5OD6
         TOpL/m4Yu1B9cFYOSoknNygT7oAMBdIQP4npJ8hx5h4v208AtnWnkoyM9e9Cc232qeiu
         plvixM+laW7xuka4P6KfGbhc1/4QFCXGxoxedg+IdnZ2qXwYNdx1M4YfUk51Lyifon5u
         bCdkeuA+db4Njh3WDqhMutWgcWRitD4AQ7MVKjlYG7N1ryJyGyVMN0p2TJcdaE0K+g4y
         yWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=URaC8IGp67QueVVNhthfsT6hscPA2Wf8vizkvGEJEcg=;
        b=N0ZdM2mkCw2tnafZRA1CCMScVAzds4CceunxomyHZethEE1kzvSYpZQXbMZxoYiICQ
         Q1mZYr70w7tAzEw9YxdMjxO28sHobhzkzAPalUUE7oEUrKP3Rt11snXdv83hlhR6YPAv
         5NVviyKB6kYGkP3JVuk2yTY4QC2EjPNjcGXmLCIM3DiXKnGfxFTOLqE7hM16NhmeYQw/
         ZhQktgGn6794AErJHq0vhw6XoGu/JtggBM8I0MJw+Wek64WTkkT3vgp1hz5zO0HnPo8j
         0YmrZAF8qe9so/IzpeXJKOyVaqTacZAOmMhZPdao3OXP9VTGRFUXSVTUzxDCq1MbDgUr
         xp9Q==
X-Gm-Message-State: ABuFfoijWsUSeR4f/FLLC1JZNn3/cz2AnO3BuG8dFH32SleW8yA+o7B5
        d/tf4qNCI6bB7Ts4xGRaayn/gTxL8CSBwlldEUZ2Jin66CrHg1Un
X-Google-Smtp-Source: ACcGV61gLZe+oESvEcYcx36zH5hRATH7aW69jYhDzTNrD55PH7RH+pyeyvLdJoreNBnCtZJ6Rq6fCiVv7FIQ7H5R8eA=
X-Received: by 2002:a2e:544f:: with SMTP id y15-v6mr8356951ljd.51.1538432998544;
 Mon, 01 Oct 2018 15:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <CADckva-V-8PeMDAVxJFFuVcq1zppCBEqrJdwH32PPf1nKVw=CQ@mail.gmail.com>
In-Reply-To: <CADckva-V-8PeMDAVxJFFuVcq1zppCBEqrJdwH32PPf1nKVw=CQ@mail.gmail.com>
From:   Neil Benn <neil.benn@ziath.com>
Date:   Mon, 1 Oct 2018 23:29:46 +0100
Message-ID: <CADckva9qPjqEjH=06cCLkkgJi+qYbR6cz5ki3whXOV1qP5BRvg@mail.gmail.com>
Subject: Re: Registering a profile
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

  I've been running a dbus-monitor and I can't see the interface being
called of 'org.bluez.Profile1' - I can see 'org.bluez.Device1' and
I've tried listening to that interface and also on the path with
dev_<ADAPTER-MAC> but I'm clearly doing something fundamentally wrong.
IF anyone has any advance I'd be very grateful and there is 100 rep
points up on Stack Overflow for any advice too!

  Thanks; it's late here and I'll not be home till gone 1am so I'll be off now!

Cheers,

Neil
On Fri, 28 Sep 2018 at 23:38, Neil Benn <neil.benn@ziath.com> wrote:
>
> Hello,
>
>   I'm trying to setup a RPi0 operating a Bluetooth device; I've setup
> the device using the following call:
> ---
>     #configure the bluetooth hardware device
>     def init_bt_device(self):
>
>         print("Configuring for name " + BTKbDevice.MY_DEV_NAME)
>
>         #set the device class to a barcode scanner and set the name
>         os.system("hciconfig hcio class 0x002560")
>         os.system("hciconfig hcio name " + BTKbDevice.MY_DEV_NAME)
>
>         #make the device discoverable
>         os.system("hciconfig hcio piscan")
>
>   Then after that I attempt to setup the profile using the following code:
> ---
>     #set up a bluez profile to advertise device capabilities from a
> loaded service record
>     def init_bluez_profile(self):
>
>         print("Configuring Bluez Profile")
>
>         #setup profile options
>         service_record=self.read_sdp_service_record()
>
>         opts = {
>             "ServiceRecord":service_record,
>             "Role":"server",
>             "RequireAuthentication":False,
>             "RequireAuthorization":False,
>             "Name":BTKbDevice.MY_DEV_NAME,
>             "AutoConnect":True
>         }
>
>         #retrieve a proxy for the bluez profile interface
>         bus = dbus.SystemBus()
>         self.manager =
> dbus.Interface(bus.get_object("org.bluez","/org/bluez"),
> "org.bluez.ProfileManager1")
>         self.profile = BTKbBluezProfile(bus, BTKbDevice.PROFILE_DBUS_PATH)
>         self.manager.RegisterProfile(BTKbDevice.PROFILE_DBUS_PATH,
> BTKbDevice.UUID, opts)
>         print("Profile registered ")
> ---
>   The sdp record is available from https://textuploader.com/dv8xt.
> The profile in question is basically the same as the one defined in
> the test-profile as shown below:
> ---
> class BTKbBluezProfile(dbus.service.Object):
>     fd = -1
>
>     @dbus.service.method("org.bluez.Profile1",
>                                     in_signature="", out_signature="")
>     def Release(self):
>             print("Release")
>             mainloop.quit()
>
>     @dbus.service.method("org.bluez.Profile1",
>                                     in_signature="", out_signature="")
>     def Cancel(self):
>             print("Cancel")
>
>     @dbus.service.method("org.bluez.Profile1", in_signature="oha{sv}",
> out_signature="")
>     def NewConnection(self, path, fd, properties):
>             self.fd = fd.take()
>             print("NewConnection(%s, %d)" % (path, self.fd))
>             for key in properties.keys():
>                     print ('key ' + key + ' value ' + properties[key])
>                     if key == "Version" or key == "Features":
>                             print("  %s = 0x%04x" % (key, properties[key]))
>                     else:
>                             print("  %s = %s" % (key, properties[key]))
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
> ---
>   However it seems like the profile is not being registered, or least
> the methods in the profile are not being called.  I'm sorry to ask
> such a basic question but can someone please point me in the right
> direction as to why the profile is either not being registered or the
> callbacks on the profile are not being called.
>
>   Thank you very much for reading this far and any and all help is
> most appreciated!
>
> Cheers,
>
> Neil
>
> --
>
> Neil Benn MSc
> Ziath Ltd
> Phone: +44 (0) 1223 855021
> http://www.ziath.com
>
> Please consider the environment before printing this email.



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
