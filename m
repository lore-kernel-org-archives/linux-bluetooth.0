Return-Path: <SRS0=cdju=QJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6294C282D8
	for <linux-bluetooth@archiver.kernel.org>; Sat,  2 Feb 2019 00:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A8121479
	for <linux-bluetooth@archiver.kernel.org>; Sat,  2 Feb 2019 00:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxU6fo7J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfBBAC1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Feb 2019 19:02:27 -0500
Received: from mail-pl1-f178.google.com ([209.85.214.178]:46364 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfBBAC0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Feb 2019 19:02:26 -0500
Received: by mail-pl1-f178.google.com with SMTP id e6so790140pls.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Feb 2019 16:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Pn40LjOBqAkqdUj83uQy4Bhnpa+gpppWkj+ETq5LYi4=;
        b=LxU6fo7JPR38+hr0CIWtX7ngzPFmntZUVXeFWABudN+o9EYhi49ZXOWzD8Gtie2O8B
         cvE9ZzsMnhcBfEJulkFdVI+Kz1xGDrhbvuekggn1Vl+arnaDKH/dNbgWncPFcGUdh70/
         tR7pKHentwTM4a9NVnbLPyIr67BzVEEJwiSiW1jSbtHCZo9vSw2KHySGPi2YmAWp2jhm
         tkc8pRKcOUIsQutocmm9Kav15g9yxTVvmc+zT32/Svnm/3xTKfE6IKLI60+1NMGgeqqU
         4JB7A4tY5Wi+NlJi3PUhlTiTTnqUf9edEuKFDAHdj7aOc54IW1jML379HlaFJUDIQDs4
         d3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Pn40LjOBqAkqdUj83uQy4Bhnpa+gpppWkj+ETq5LYi4=;
        b=UGfAmhY6jhLAi4Di90sDqGQ6ZRER0KRTRh27QlMS6Vg4/2ZUE3DUjfp9r4G2COMzVa
         aWh9ylbetaK4MkILXdNCLmNjsS7g5KvEP4n2VnKqgEhdkXDRUHZqjRCEMOb1l+5mvLXi
         bBI5bewWAe1FSC0jFKsCz4wWKjTlG3XXLfirCJuOnb9x4Sdk0c2KBdIZGZfrySpc7RNx
         4+KwDzD9IwNzKw4YBjbIQLz8P2SBdqADPyDNYZkJwOvbZS6N8ikmoubiKlnRIC/udP0b
         dBVcxfw4zQPZzgXJsNGz9b/tX2lGLaK6VEayhQX0o9zO4HqMNkEX90e2SwOaEPdj2X69
         7ieA==
X-Gm-Message-State: AJcUuke2EH/v9ciYN01WhCoFe+0xsH2FaGgQc28k0Vb5zEBbuqSLsYAb
        OLnzSlSv3oVGNf01iX2Julab6tGG
X-Google-Smtp-Source: ALg8bN5w5lNY2PLK4l/7xe5lUZMcvkyroHnKyYPpI7Lt75uKDisVDemMsm2jUk9fAS5k0xTV+aZw/w==
X-Received: by 2002:a17:902:3383:: with SMTP id b3mr40775885plc.170.1549065745547;
        Fri, 01 Feb 2019 16:02:25 -0800 (PST)
Received: from [192.168.1.8] (d50-92-226-235.bchsia.telus.net. [50.92.226.235])
        by smtp.gmail.com with ESMTPSA id d13sm17784064pfd.58.2019.02.01.16.02.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 16:02:24 -0800 (PST)
To:     linux-bluetooth@vger.kernel.org
From:   David Frey <dpfrey@gmail.com>
Subject: Call to GattManager1.RegisterApplication times out
Message-ID: <e7acd19d-f953-0156-bfa3-4d5ab98730ac@gmail.com>
Date:   Fri, 1 Feb 2019 16:02:23 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

I am trying to write a battery service
(https://www.bluetooth.com/specifications/gatt/viewer?attributeXmlFile=org.bluetooth.service.battery_service.xml)
that runs in BlueZ to expose the battery level of a device over BLE.

The application that I have written is available here:
https://github.com/dpfrey/bluez_battery_service

I'm new to GLib/GIO/GObject, so trying to get this working has been
pretty overwhelming due to the complexity of that stack.

I have a USB Bluetooth adapter which is recognized by BlueZ 5.50 that's
running on my computer.  When I run my program, this is the output I get:

$ ./fake_bs
Starting fake battery service!
BusAcquired
NameAcquired
Found object: /org/bluez/hci0 which implements org.bluez.GattManager1
Error registering BS application: Timeout was reached

If you have any ideas why the method call would be timing out, please
let me know.  Also if there is any additional information that would be
helpful in understanding where the failure is occurring, let me know and
I will reply with more information.

Are there any good examples of Bluetooth services implemented in C using
GDBus?  In the BlueZ source tree I found "test/example-gatt-server"
which is written in Python and "tools/gatt-service.c" which is written
in C, but it uses dbus-glib rather than GDBus.  My understanding is that
dbus-glib is deprecated.

Thanks,
David
