Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A012C432BE
	for <linux-bluetooth@archiver.kernel.org>; Sun, 29 Aug 2021 18:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CF1160F39
	for <linux-bluetooth@archiver.kernel.org>; Sun, 29 Aug 2021 18:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235777AbhH2SNR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 29 Aug 2021 14:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhH2SNR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 29 Aug 2021 14:13:17 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B3CC061575
        for <linux-bluetooth@vger.kernel.org>; Sun, 29 Aug 2021 11:12:24 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id y34so26425335lfa.8
        for <linux-bluetooth@vger.kernel.org>; Sun, 29 Aug 2021 11:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=QeKlsgXj/fkw5z0goXRJNFqeU1/EXJaYLZmB7rAdZBg=;
        b=GQ2T9NsWxKC71mL8vVfu7W2wC04MouZ9fQJavzDB7ulpmJqye/gE024agIODAYQNrr
         uUBmClVKHxGq8DFjxTlh/Gok6mUzTZRhYMaubjSRmtJ2aRWOHaKakJ8eyD0WRBP6IJOU
         uBJN54RumatRE9eLxhb++ZJmpy2JE0LaNuLdmulV69cv1lywRZWnpbA/dWVpE4P9E2bn
         pLJLWm0XVLEsODbj6LVYerHPKAX8Xbsf6WcnyArItKtIbelCv7FS6MIr6/HgSV3jhjAi
         a2PG4cX9gWHeqKKl+SJ6dm+tIBGo+bkOxfX0jqgQFITpthIFLRCJRD5f3UK6vC5M09T0
         Rk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=QeKlsgXj/fkw5z0goXRJNFqeU1/EXJaYLZmB7rAdZBg=;
        b=lR/NZZyD0Hbiwd5H9FaKXClWJFbhDtsXPgQvncXVQFXY89JRsRsUYxHU9RkOIy2Of1
         eaakmUJBW6m59cKJpFBNNhIRO+Gr1CM5LJ1+KlJo64nHGI149ElvQlbsL2bHP6Am/6ue
         borXiuQE8zQ15FWVTvIfnNmF5ioFEYv414Gt7KM5ndI/M3AOYcX/QkjKpSpBoyCTItgl
         IJyCuv/Z7WluDwDyFRB+MWxFIoI+65FVF+mkOnu9GtAWdk14lvzlmd4eh3ZlL1Zmv3Ez
         bKuzT7B/S+NO9695Q4KbPSkBo9ZhFtpwJTzJSq7BpkESABrkrIyyhYCf0cAzFQi3DS4J
         RmWg==
X-Gm-Message-State: AOAM533Yxc2Ewl4JCypAal1MLHd2PTaecGz3rEe58SWnGTkHyNrkAD47
        si2QyFMt8MKNIQUJnCxt7mlc1kNNix8i0M4z3jfwfUzW+Qc=
X-Google-Smtp-Source: ABdhPJzsFMeaRDiSHnEy+y6M0fAOo2SSWVe5NDDvaGVDOjfsw80a2Yl+6bVaRWFGri0rAhVunDx1mt6RXbCtY7PBURY=
X-Received: by 2002:a19:e214:: with SMTP id z20mr14717115lfg.37.1630260742632;
 Sun, 29 Aug 2021 11:12:22 -0700 (PDT)
MIME-Version: 1.0
From:   Raul Piper <raulpblooper@gmail.com>
Date:   Sun, 29 Aug 2021 23:42:11 +0530
Message-ID: <CAEwN+MBfGUStGBkd7vHBMzu=vJqtEcOFsPb-ck+g=Rf=eyTxVw@mail.gmail.com>
Subject: Device doesnt show up on Ble Scanner - gatt-service example in tools
 folder as per Documentation(doc)
To:     linux-bluetooth@vger.kernel.org
Cc:     kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,
I tried cross compiling the bluez and ported it to my linux platform.I
think i have done it correctly as I am able to launch the gatt-service
example successfully but i am not able to view it on the Smartphone
app - blescanner or light blue.

Below are the logs :
===============================================
./gatt-service
gatt-service unique name: :1.18
Registered service: /service1
Registered service: /service2
Registered service: /service3
Get Primary: True
Get UUID: 00001802-0000-1000-8000-00805f9b34fb
Exist Includes: 00001802-0000-1000-8000-00805f9b34fb
Get Includes: 00001802-0000-1000-8000-00805f9b34fb
Includes path: /service3
Get Includes: /service2
Characteristic(00002a06-0000-1000-8000-00805f9b34fb): Get("Value")
Descriptor(8260c653-1a54-426b-9e36-e84c238bc669): Get("Value")
Get Primary: True
Get UUID: A00C
Exist Includes: A00C
Characteristic(00002c07-0000-1000-8000-00805f9b34fb): Get("Value")
Descriptor(FFFF): Get("Value")
Get Primary: True
Get UUID: A00D
Exist Includes: A00D
Characteristic(00002b06-0000-1000-8000-00805f9b34fb): Get("Value")
Descriptor(0260c653-1a54-426b-9e36-e84c238bc669): Get("Value")



I also tried to run the python example inside test/example-gatt-server
but again I am not able to view the device name.

Below are the logs :
=======================================
python3 example-gatt-server
example-gatt-server:395: PyGIDeprecationWarning: GObject.timeout_add
is deprecated; use GLib.timeout_add instead
  GObject.timeout_add(5000, self.drain_battery)
example-gatt-server:652: PyGIDeprecationWarning: GObject.MainLoop is
deprecated; use GLib.MainLoop instead
  mainloop = GObject.MainLoop()
Registering GATT application...
GetManagedObjects
GATT application registered

I even opened the btmon on a different tab but still I am not able to
see anything on that.
Is there any other application we have to run?
Has any one ran  it successfully and able to view/connect and see all
the 3 services it is advertising.

Please advise / ask for any further information , I will provide.

Thanks in advance !

Regards,
R
