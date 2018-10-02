Return-Path: <SRS0=6kNt=MO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32284C43143
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Oct 2018 11:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D71A220652
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Oct 2018 11:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3Scevb9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D71A220652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbeJBSKy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Oct 2018 14:10:54 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:46344 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbeJBSKy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Oct 2018 14:10:54 -0400
Received: by mail-oi1-f172.google.com with SMTP id k64-v6so1166725oia.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Oct 2018 04:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Psz9rRywNCVeRJCHVIL2ANI48xLHsn8fmfqXt8bXIs=;
        b=h3Scevb9hiPAcF7DK3v7aBDxVvRPbClNUSb7TIpV0Vqw0AqEdUkJ4OOvlcY5QCXy6B
         PIK3jm+4oqBgEoZIQG1bFUt0a2BVl5uU3TfTiosFmME1+0F+Ddib/jnDhOuO7WNpwDX/
         A7d+cvE1jbly2rzvPT6ea2ACnwbTd6EL70j1E1cSMnFZQm/EOP9rAvPCjyZ7A0BHzfZL
         CQdllboKJjEN3KKoIaekShSdRZ+LB0iVFwyHAWIwluKCiE8uw/LefN/OJCChDY3x1hfV
         NpSNcRHcgQFloF2AM2riIwYaXW0+HKV56569tiAKDHp6TQ+cArrniG7ocoQ/zYPAWtbb
         SHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Psz9rRywNCVeRJCHVIL2ANI48xLHsn8fmfqXt8bXIs=;
        b=G6kDB7lDACVqBem2SN+7E9GVbWgB27goT9ft/S6EGJEx3Ocp5SMW2gkLcC5HYsK+cO
         fmFxnml2iNMAd/zzfO79q0oZs2+dButzSSN1TZQmetxt6M0+dhi8sowiaWNwDV5I+VQr
         BikkO2A/ncconzIekSi7235nOOx3z3Eym2v42oiNz8SfR6dCHwkkR/PfSxYyymQIO7MV
         127st+KY4ykYa75fSbq3u7noc8gUXwGjev6MWAxnbKX7S4ekGjLYSctIajzS873JSedH
         hno5OiSAvLpzzd6lIhV0NNCe3m7JX81yWaDOftBfsfMwgTL2FHe6kjHBTyeNOTSwED/u
         rPcg==
X-Gm-Message-State: ABuFfohlcrhPge/T0Uz+SzUHfSwU7gfslFJdEfxLFZxSqVT9hyaKkMnu
        RIEp6QmcpA9LXPxzubufSio/UkXgR5aj6cfpO/ifc6Dk
X-Google-Smtp-Source: ACcGV60Wg7SqaSRaCqXyTmeLZ5WwMEFodk6RJznTNrbHUrjAcnLc544DOEaEs4PTKV4HarSFNLyHyyo2Fx288h+2nFs=
X-Received: by 2002:aca:60c1:: with SMTP id u184-v6mr6586228oib.99.1538479684747;
 Tue, 02 Oct 2018 04:28:04 -0700 (PDT)
MIME-Version: 1.0
References: <CADckva-V-8PeMDAVxJFFuVcq1zppCBEqrJdwH32PPf1nKVw=CQ@mail.gmail.com>
 <CADckva9qPjqEjH=06cCLkkgJi+qYbR6cz5ki3whXOV1qP5BRvg@mail.gmail.com>
 <CABBYNZKaJc46C4Phu5HE18JXcYjfdD_kxS5Q7hOJJC4ZTsTyQA@mail.gmail.com> <CADckva9c-Nw85gH3yRBEvu_OD+J7EcccAjBZHB8ZQw92CndQZA@mail.gmail.com>
In-Reply-To: <CADckva9c-Nw85gH3yRBEvu_OD+J7EcccAjBZHB8ZQw92CndQZA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 2 Oct 2018 14:27:52 +0300
Message-ID: <CABBYNZ+CmQ7KvjgDZzZ7sRPxLMmLi0L7pfMVEgz359Rb-Phwwg@mail.gmail.com>
Subject: Re: Registering a profile
To:     neil.benn@ziath.com
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Neil,
On Tue, Oct 2, 2018 at 1:39 PM Neil Benn <neil.benn@ziath.com> wrote:
>
> Hello,
>
>   Thanks for that; I'll change the config file for this and for the
> name can that be in the main.conf file?  The same for the
> discoverable; set the timeout to zero - there is no security needed
> for this device at all.  Can this all be done with the conf file?
>
>   On the connection; yes it connects.  This is a HID device connecting
> via L2CAP with the interrupt on 19 and the control on 17 and the
> windows PC correctly connects to the device, queries the service
> record, identifies it as a HID and connects on both the control and
> interrupt psm ports but none of the dbus methods are being called.  At
> the moment I am using the pybluez library with the BluetoothSocket and
> calling listen and accept which is a bit 'manual'.  To detect a
> disconnect I'm calling hcitool con and parsing the response - which is
> again a bit manual.  Please see below for my current 'hack':

I don't think that will work since the input plugin is already
listening in those PSM, in fact I don't think RegisterProfile would
parse the values from the record since you don't seem to be using the
PSM:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/profile-api.txt#n54

Btw, why would you want to replace the HID profile? Is that not working?

> ---
>     #listen for incoming client connections
>     #ideally this would be handled by the Bluez 5 profile
>     #but that didn't seem to work
>     def listen(self):
>
>         print("Waiting for connections")
>         self.scontrol=BluetoothSocket(L2CAP)
>         self.sinterrupt=BluetoothSocket(L2CAP)
>
>         self.scontrol.bind((self.MY_ADDRESS,self.P_CTRL))
>         self.sinterrupt.bind((self.MY_ADDRESS,self.P_INTR ))
>         #Start listening on the server sockets
>         self.scontrol.listen(1) # Limit of 1 connection
>         self.sinterrupt.listen(1)
>
>         self.ccontrol,cinfo = self.scontrol.accept()
>         self.controlClientMac = cinfo[0]
>         self.controlClientPsm = cinfo[1]
>         print ('control is ' + self.controlClientMac + " " +
> str(self.controlClientPsm))
>
>         self.cinterrupt, cinfo = self.sinterrupt.accept()
>         self.interruptClientMac = cinfo[0]
>         self.interruptClientPsm = cinfo[1]
>         print ('interrupt is ' + self.interruptClientMac + " " +
> str(self.interruptClientPsm))
>
>         thread.start_new_thread(self.check_connection, ())
>
>     def check_connection(self):
>         halt = False
>         while not halt:
>             stdoutdata = subprocess.check_output(["hcitool", "con"])
>
>             if self.controlClientMac in stdoutdata.split():
>                 time.sleep(0.1)
>             else:
>                 print('got disconnection')
>                 self.scontrol.shutdown(2);
>                 self.sinterrupt.shutdown(2)
>                 halt = True
>         thread.start_new_thread(self.listen, ())
>
>   Obviously this is a very clumsy way of doing it and calling back on
> the profile is the correct way to do it, I just can't work out why the
> profile is not being called.  I'm trying to spy on the dbus comms to
> see if anything is being sent but I can't see any bluez profile
> messages being sent at all.  Thanks for your response and any advice
> is greatly appreciated.
>
> Cheers,
>
> Neil
> On Tue, 2 Oct 2018 at 09:37, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Neil,
> > On Tue, Oct 2, 2018 at 1:32 AM Neil Benn <neil.benn@ziath.com> wrote:
> > >
> > > Hello,
> > >
> > >   I've been running a dbus-monitor and I can't see the interface being
> > > called of 'org.bluez.Profile1' - I can see 'org.bluez.Device1' and
> > > I've tried listening to that interface and also on the path with
> > > dev_<ADAPTER-MAC> but I'm clearly doing something fundamentally wrong.
> > > IF anyone has any advance I'd be very grateful and there is 100 rep
> > > points up on Stack Overflow for any advice too!
> > >
> > >   Thanks; it's late here and I'll not be home till gone 1am so I'll be off now!
> > >
> > > Cheers,
> > >
> > > Neil
> > > On Fri, 28 Sep 2018 at 23:38, Neil Benn <neil.benn@ziath.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > >   I'm trying to setup a RPi0 operating a Bluetooth device; I've setup
> > > > the device using the following call:
> > > > ---
> > > >     #configure the bluetooth hardware device
> > > >     def init_bt_device(self):
> > > >
> > > >         print("Configuring for name " + BTKbDevice.MY_DEV_NAME)
> > > >
> > > >         #set the device class to a barcode scanner and set the name
> > > >         os.system("hciconfig hcio class 0x002560")
> > > >         os.system("hciconfig hcio name " + BTKbDevice.MY_DEV_NAME)
> > > >
> > > >         #make the device discoverable
> > > >         os.system("hciconfig hcio piscan")
> > > >
> >
> > You shouldn't be using hciconfig, instead do the following:
> >
> > The class is automatically set by bluetoothd based on the
> > services/profiles registered and the setting in the main.conf:
> >
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/main.conf#n9
> >
> > For the name use D-Bus property Alias:
> >
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/adapter-api.txt#n216
> >
> > To make the adapter discoverable use D-Bus property Discoverable:
> >
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/adapter-api.txt#n252
> >
> >
> >
> > > >   Then after that I attempt to setup the profile using the following code:
> > > > ---
> > > >     #set up a bluez profile to advertise device capabilities from a
> > > > loaded service record
> > > >     def init_bluez_profile(self):
> > > >
> > > >         print("Configuring Bluez Profile")
> > > >
> > > >         #setup profile options
> > > >         service_record=self.read_sdp_service_record()
> > > >
> > > >         opts = {
> > > >             "ServiceRecord":service_record,
> > > >             "Role":"server",
> > > >             "RequireAuthentication":False,
> > > >             "RequireAuthorization":False,
> > > >             "Name":BTKbDevice.MY_DEV_NAME,
> > > >             "AutoConnect":True
> > > >         }
> > > >
> > > >         #retrieve a proxy for the bluez profile interface
> > > >         bus = dbus.SystemBus()
> > > >         self.manager =
> > > > dbus.Interface(bus.get_object("org.bluez","/org/bluez"),
> > > > "org.bluez.ProfileManager1")
> > > >         self.profile = BTKbBluezProfile(bus, BTKbDevice.PROFILE_DBUS_PATH)
> > > >         self.manager.RegisterProfile(BTKbDevice.PROFILE_DBUS_PATH,
> > > > BTKbDevice.UUID, opts)
> > > >         print("Profile registered ")
> > > > ---
> > > >   The sdp record is available from https://textuploader.com/dv8xt.
> > > > The profile in question is basically the same as the one defined in
> > > > the test-profile as shown below:
> > > > ---
> > > > class BTKbBluezProfile(dbus.service.Object):
> > > >     fd = -1
> > > >
> > > >     @dbus.service.method("org.bluez.Profile1",
> > > >                                     in_signature="", out_signature="")
> > > >     def Release(self):
> > > >             print("Release")
> > > >             mainloop.quit()
> > > >
> > > >     @dbus.service.method("org.bluez.Profile1",
> > > >                                     in_signature="", out_signature="")
> > > >     def Cancel(self):
> > > >             print("Cancel")
> > > >
> > > >     @dbus.service.method("org.bluez.Profile1", in_signature="oha{sv}",
> > > > out_signature="")
> > > >     def NewConnection(self, path, fd, properties):
> > > >             self.fd = fd.take()
> > > >             print("NewConnection(%s, %d)" % (path, self.fd))
> > > >             for key in properties.keys():
> > > >                     print ('key ' + key + ' value ' + properties[key])
> > > >                     if key == "Version" or key == "Features":
> > > >                             print("  %s = 0x%04x" % (key, properties[key]))
> > > >                     else:
> > > >                             print("  %s = %s" % (key, properties[key]))
> > > >
> > > >     @dbus.service.method("org.bluez.Profile1", in_signature="o",
> > > > out_signature="")
> > > >     def RequestDisconnection(self, path):
> > > >             print("RequestDisconnection(%s)" % (path))
> > > >
> > > >             if (self.fd > 0):
> > > >                     os.close(self.fd)
> > > >                     self.fd = -1
> > > >
> > > >     def __init__(self, bus, path):
> > > >             dbus.service.Object.__init__(self, bus, path)
> > > > ---
> > > >   However it seems like the profile is not being registered, or least
> > > > the methods in the profile are not being called.  I'm sorry to ask
> > > > such a basic question but can someone please point me in the right
> > > > direction as to why the profile is either not being registered or the
> > > > callbacks on the profile are not being called.
> >
> > They would be called only when there is a connection to the profile,
> > did you actually connect? If this is something like a serial port the
> > remote should lookup the SDP record and connect to the channel listed
> > there.
> >
> > > >   Thank you very much for reading this far and any and all help is
> > > > most appreciated!
> > > >
> > > > Cheers,
> > > >
> > > > Neil
> > > >
> > > > --
> > > >
> > > > Neil Benn MSc
> > > > Ziath Ltd
> > > > Phone: +44 (0) 1223 855021
> > > > http://www.ziath.com
> > > >
> > > > Please consider the environment before printing this email.
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
