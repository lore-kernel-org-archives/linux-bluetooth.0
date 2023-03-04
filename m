Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6495CC678D5
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Mar 2023 22:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjCDWic (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 4 Mar 2023 17:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjCDWib (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 4 Mar 2023 17:38:31 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2407712841
        for <linux-bluetooth@vger.kernel.org>; Sat,  4 Mar 2023 14:38:30 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id g18so5964874ljl.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 04 Mar 2023 14:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BArKaig1zMj5sjQebgtS6UkCoAtDNxYIPD4ts2wBbdQ=;
        b=pXS6R/n7PAnoJzL2Z8gE2Qss4p6JDBAEs9HkEBWOge3mGPmfgF+CPuP5ToD+1TSBjb
         yUxO7f/1lhssFlhOkZ7da1rvErYvyv7qFcfPjOBPeyT8SsOoj6GWUhBun+BCscjDT0HE
         O/hroEsQemvBA/ZwUyuQGz2fFOGeYgQZ/HoI67QlSTkqtjZr3mexwhUo5Ydcxb6neUzF
         qLhzSKn8t1SeOTeSda7Sgw3+iADhxCVEcijUNNuEmOevDzdJMvCa8BsYPWEmCO3Z48e7
         Lbze7pCoP6yGsIVHYWBLugiN7BbWMW37G+i/z1R7WS5VkAd/KEIoiy0kszguF7rAN5eh
         p8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BArKaig1zMj5sjQebgtS6UkCoAtDNxYIPD4ts2wBbdQ=;
        b=Uu9EFRuobvutLPxSNjvm7IzhRSuD/iLEgiYmqcJrcCt9XAE8D5ZFUKSZQ2YLGAYOYq
         ZkarXB3yx/d8kgykBPspxSiFL44UIxlxtv56QaDrNNxNYSCspsJxcT98GILfKupsuL5T
         vzCQ2I561zcaF2y87gdq/dO/B1MV0ozEbygzVvgRFVlO0g3tdRJws3FLiddtvz0MxV0/
         SC0HT1w55AtcNs/M6S8wMOAG8w6yjNPw/MDZ5TL5yvk/fLjrgndfTqcdsWeN1crD9OBm
         YvN69IEu/g5zpEXgUqrli/0tTAe3u50X0915y7QEbxOAzeH6hSGb5yV9/5M5gFr39Azd
         bw9A==
X-Gm-Message-State: AO0yUKWw0l9kZBV8hIqMfCi0JfF9t+EyPb++g/4MWoK/PZdpAekUkFoe
        HYPIFmujaATsetcKYLk0thtShqI+JOmaEoTAOf8BUAjS
X-Google-Smtp-Source: AK7set9/a/m5uo76JfuJmo04Bn9j5KZLKMVf+Bv6inAL6nkMFr5Rws7OYbjGWPJx0+jHrr3zxTPN3HzFPsKZ8YkjVrU=
X-Received: by 2002:a05:651c:1681:b0:295:9a96:a5cc with SMTP id
 bd1-20020a05651c168100b002959a96a5ccmr1796804ljb.9.1677969508096; Sat, 04 Mar
 2023 14:38:28 -0800 (PST)
MIME-Version: 1.0
References: <20230303012742.1386291-1-luiz.dentz@gmail.com>
 <20230303012742.1386291-3-luiz.dentz@gmail.com> <83f20e7c05e16d62c6f88eeffeb5306853fd2adb.camel@iki.fi>
In-Reply-To: <83f20e7c05e16d62c6f88eeffeb5306853fd2adb.camel@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Sat, 4 Mar 2023 14:38:15 -0800
Message-ID: <CABBYNZJvF1YtzzwfRkg92vRf38+7pzzSA56evLESy8+BwCCUng@mail.gmail.com>
Subject: Re: [RFC 3/9] doc: Add set-api
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Sat, Mar 4, 2023 at 2:19=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi Luiz,
>
> to, 2023-03-02 kello 17:27 -0800, Luiz Augusto von Dentz kirjoitti:
> > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > >
> > > This adds set-api.rst which documents DeviceSet interface.
> > > ---
> > >  doc/set-api.rst | 53 +++++++++++++++++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 53 insertions(+)
> > >  create mode 100644 doc/set-api.rst
> > >
> > > diff --git a/doc/set-api.rst b/doc/set-api.rst
> > > new file mode 100644
> > > index 000000000000..17c5f93b6b86
> > > --- /dev/null
> > > +++ b/doc/set-api.rst
> > > @@ -0,0 +1,53 @@
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +BlueZ D-Bus DeviceSet API description
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +
> > > +DeviceSet interface
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +Service            org.bluez
> > > +Interface  org.bluez.DeviceSet1
> > > +Object path        [variable prefix]/{hci0,hci1,...}/set_{sirk}
> > > +
> > > +Methods
> > > +=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +**void Connect() [experimental]**
> > > +
> > > +   Connects all **devices** members of the set, each member is
> > > +   connected in sequence as they were added/loaded following the
> > > +   same proceedure as described in **Device1.Connect**.
> > > +
> > > +   Possible errors: org.bluez.Error.NotReady
> > > +                    org.bluez.Error.Failed
> > > +                    org.bluez.Error.InProgress
> > > +                    org.bluez.Error.AlreadyConnected
> > > +
> > > +**void Disconnect() [experimental]**
> > > +
> > > +   Disconnects all **devices** members of the set, each member is
> > > +   disconnected in sequence as they were connected following the
> > > +   same proceedure as described in **Device1.Disconnect**.
> > > +
> > > +   Possible errors: org.bluez.Error.NotConnected
> > > +
> > > +Properties
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +**bool AutoConnect [read-write, experimental]**
> > > +
> > > +   Indicates if the **devices** members of the set shall be automati=
cally
> > > +   connected once any of its members is connected.
> > > +
> > > +**array(object) Devices [ready-only, experimental]**
> > > +
> > > +   List of devices objects that are members of the set.
> > > +
> > > +**byte Size [read-only, experimental]**
> > > +
> > > +   Set members size.
> > > +
> > > +**byte Rank [read-only, experimental]**
> > > +
> > > +   Set members rank.
>
> It looks like rank is supposed to be a property of each set member
> device, not a constant property of the set like size.

Yep, Ive been debating putting a property called SetRank into the
Device interface.

> See CSIS 5.4: "The value of the Set Member Rank characteristic exposed
> by servers that are part of the same Coordinated Set shall be
> contiguous integers starting from 0x01 to the size of the Coordinated
> Set."
>
> So maybe should be something like
>
> **array(byte) Ranks [read-only, experimental]**

Or we actually sort the Devices list based on the rank, anyway Ive
been doing some modification like adding the Adapter object to
DeviceSet and a Set property to Device interface to make it easier to
locate its members, Im also planning to add support to the likes of
bluetoothctl.

>         Set member ranks.
>
> --
> Pauli Virtanen



--=20
Luiz Augusto von Dentz
