Return-Path: <SRS0=otBP=MV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C542C64EB0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Oct 2018 21:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC056214C4
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Oct 2018 21:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTWNxeso"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC056214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbeJJE2v (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Oct 2018 00:28:51 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:37715 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeJJE2v (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Oct 2018 00:28:51 -0400
Received: by mail-io1-f47.google.com with SMTP id m16-v6so2315224ioj.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Oct 2018 14:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lvb5xkJKq6x0ps4YlU/tFx6sMZA6eu6A/6rzbPybjyE=;
        b=cTWNxesonyz+Au9bZpa4EhR4/0082L0y1IqOrOuDukw1qn1vEWJHDVp49vDRTV+IZK
         4pItPtm2ejGEEzDbgRNIZ/DHMXNHSs7upF5Jlf5twfultdT2skCyllbE4hMXIKec+MOJ
         C51/T6pphRaVMMfmKtFR27sqsSS0KH96UGaE5KuafXo4Xl1ed7jyHiWqyqfIXImWYNyG
         K4y3/HaO4C1N0B8jgeHSog7Zvokp3OatkigapnWAnwoPRJgcz3I2wjD3klRvmogx60VP
         UrpdQPcwPxcLMvIhdIZ36hbQqohExbmN8gdkwzMWXGlcPlGsoHDGYmS/IKw5BNBLBrt/
         +oqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lvb5xkJKq6x0ps4YlU/tFx6sMZA6eu6A/6rzbPybjyE=;
        b=OF8RXtTWI3ZV2DXogjjZpXnf8X68kE/4uasGUrdwpgj/B5DzBUUKoSzZs3DaFY4eRX
         COJRC8se8UNvM3ZorgRBPE9N3fD2XXrVPlqErEaAhIAIegI1lpbObIooios2YmqycQ9e
         vLH8VHNBrJIb+2BfzJozL7gAb6IkmuHYA9Wgy8GIURMhh8gftq6bD9OKp1rxKHhphR6w
         eIVgyQmcprVDEiscKMtK/PvKoJbjboeIetW5bKr5j1saBcH7lX0DFfE1PWsVdpUc8sfe
         Gvm3yEwMDW3s8wtwlh3VZhgAYmS2S7AEmDHRgu0a3ueHjK7YsuLaAgVeZZlTB7V8QhaG
         mISw==
X-Gm-Message-State: ABuFfojcsijBr46CV1OROsB5tNxnOeqFt096fUzEoSl2AafplJyvW3HT
        Y9qhipds+TjtPMjabbHW8FELxonNeS7EjFTejnM=
X-Google-Smtp-Source: ACcGV62Rji4UpZ6ktVJYZB1fiwi6TYHdeDnjLccmexHhbLfhU4cNUBcVsRVjGmPRmq0viRGyujWkWyC9nciH3bksKNc=
X-Received: by 2002:a6b:3b92:: with SMTP id i140-v6mr18322981ioa.290.1539119400558;
 Tue, 09 Oct 2018 14:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <7246fd0d-022f-0d7b-ab09-1030ac06e0fa@chicoree.fr>
 <CAAu3APYwnuB+XTuo3jOX=HFsFLWd2X-HW6YdfYnmn51fah=_ag@mail.gmail.com> <6a77b228-2603-3413-7ffb-fb8f178a09f1@chicoree.fr>
In-Reply-To: <6a77b228-2603-3413-7ffb-fb8f178a09f1@chicoree.fr>
From:   Barry Byford <31baz66@gmail.com>
Date:   Tue, 9 Oct 2018 22:09:49 +0100
Message-ID: <CAAu3APaJ3XyPnSuE8UUxW7N8fqcOVd6xKB0hYcd3svV=x5dO0A@mail.gmail.com>
Subject: Re: Serial communication over BT using the DBus API
To:     sylvain@chicoree.fr
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, 9 Oct 2018 at 21:56, Sylvain Leroux <sylvain@chicoree.fr> wrote:
>
> Hi Barry,
>
> Thanks for the reply:
>
> On 10/09/2018 10:30 PM, Barry Byford wrote:
> > You might want to take a look at the Bluedot library that has used the
> > DBus API to communicate over the Serial Port Profile.
> > Server:
> > https://github.com/martinohanlon/BlueDot/blob/master/bluedot/btcomm.py#L141
> > Client:
> > https://github.com/martinohanlon/BlueDot/blob/master/bluedot/btcomm.py#L466
> >
> > The main section using DBus is in:
> > https://github.com/martinohanlon/BlueDot/blob/master/bluedot/utils.py
>
> I started to explore the bluedot sources. From what I understand, I need
> in the shell something like the `register_spp` function
> (https://github.com/martinohanlon/BlueDot/blob/master/bluedot/utils.py#L101)
>
>
> I'm currently investigating how I could use `busctl` to reproduce that
> behavior.

Not my area of expertise but it seems like it might be difficult
because there would be no event loop.
Hopefully someone else can jump in on that point.

>
> I noticed the function mostly send some XML description to the
> `org.bluez.ProfileManager1` interface (see code below).

The author has decided to do it that way. You don't have to. Here is a
different example:
https://gist.github.com/ukBaz/217875c83c2535d22a16ba38fc8f2a91#file-spp-profile

> There are a
> couple of hard coded constants in the code, including the UUID
> "00001101-0000-1000-8000-00805f9b34fb". Are those "well known" values I
> can blindly use?

That UUID refers to the Serial Port Profile. You can see the full list
of assigned numbers at:
https://www.bluetooth.com/specifications/assigned-numbers/service-discovery


>
>
> - Sylvain
>
>
> ----
> def register_spp(port):
>
>     service_record = """
>     <?xml version="1.0" encoding="UTF-8" ?>
>     <record>
>       <attribute id="0x0001">
>         <sequence>
>           <uuid value="0x1101"/>
>         </sequence>
>       </attribute>
>       <attribute id="0x0004">
>         <sequence>
>           <sequence>
>             <uuid value="0x0100"/>
>           </sequence>
>           <sequence>
>             <uuid value="0x0003"/>
>             <uint8 value="{}" name="channel"/>
>           </sequence>
>         </sequence>
>       </attribute>
>       <attribute id="0x0100">
>         <text value="Serial Port" name="name"/>
>       </attribute>
>     </record>
>     """.format(port)
>
>     bus = dbus.SystemBus()
>
>     manager = dbus.Interface(bus.get_object(SERVICE_NAME, "/org/bluez"),
> PROFILE_MANAGER)
>
>     path = "/bluez"
>     uuid = "00001101-0000-1000-8000-00805f9b34fb"
>     opts = {
> #        "AutoConnect" : True,
>         "ServiceRecord" : service_record
>     }
>
>     try:
>         manager.RegisterProfile(path, uuid, opts)
>     except dbus.exceptions.DBusException as e:
>         #the spp profile has already been registered, ignore
>         if str(e) != "org.bluez.Error.AlreadyExists: Already Exists":
>             raise(e)
> ----
