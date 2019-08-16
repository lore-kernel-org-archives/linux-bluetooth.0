Return-Path: <SRS0=GHQ/=WM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CF1C3A59C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Aug 2019 09:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51DD8206C1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Aug 2019 09:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8kCgyQw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfHPJdA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Aug 2019 05:33:00 -0400
Received: from mail-vs1-f42.google.com ([209.85.217.42]:36553 "EHLO
        mail-vs1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbfHPJdA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Aug 2019 05:33:00 -0400
Received: by mail-vs1-f42.google.com with SMTP id y16so3332290vsc.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Aug 2019 02:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Uv3tTxlCKCwoo/uZBiiMsQuL11fFw6dLDsTodEWHL5A=;
        b=T8kCgyQwhObBuGxkIZX2Bg6adTqf+OA4IQjl5YY2uW7Y1uqj1iCi/BhbHgVvnBvD2B
         KSi6yPHWiEPglgJVXZo4hRqFRrCQSio5Y26FOmd/MySZ3KgHlbeZbrCttS//bWaf6bED
         X6zhqwOc7KpJ/ZanEou5Qo+PUqPK9OeqreUJ6JuEOxyc/2gNi2n5d10+ZCJ/5XmTt67+
         AloM5j44NuhcEXOCQPEgJo8t4/HeWy4zreMfFtGzCHN1B3mfimDM1jQ02pOLGMN+/8pK
         KkO5tbwFnhKOnrjJC1+KQRmTksb2xkemvIExCkE/7FIiMZL2PtM4acBufUu7xLU7akMZ
         KsmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Uv3tTxlCKCwoo/uZBiiMsQuL11fFw6dLDsTodEWHL5A=;
        b=EBGwr2RmmMBwNBGwGnpxZq7KnoWdSbV5Yow+15XbonnhAGenWsY6035bXdFcy7ElBz
         uFQl02E8soJYfSd+auSDAYRs8IHymnqfAfkiTt8pORxjA6TBTTD3vl9JuTMzg9KbZdo5
         CRRdTAkSmWkh8ScRNKEnurEfrn8h3V+GDISBq9RBu95HV1vTYbZ/q7hP5Tv67RlZN5W9
         HllPsVOLg1lJFDQ2ZSWQMzlGzBvzaHHq9CkbWt0yopmNW90GJOlxzfpcmj3FobnOLirX
         xWahStw4v7AWuv59VhkhPH1afnfzTllTpeLj2Nx6sqMJsPqDE1upHPoEKHtPvPTFF0z0
         4GDg==
X-Gm-Message-State: APjAAAUS0rZ4XJpuG93ktlQMpLINUKYMu0pWQbTc7yqy2nmihFLAwXzn
        G11UhSB47DPpV7VTqHKjEXeHd2y1o1XTqAp7NhmL9nmKTzc=
X-Google-Smtp-Source: APXvYqxUK6YE4H0f2OPkYLUzCiNk8tmzKuKgux3YZeGhtnkXI3Y1OIbquDPDILr4WT12vh9VUWCvd3gMjnx0Z79/SmY=
X-Received: by 2002:a67:8cc7:: with SMTP id o190mr5892059vsd.24.1565947979161;
 Fri, 16 Aug 2019 02:32:59 -0700 (PDT)
MIME-Version: 1.0
From:   Luca Capra <luca.capra@gmail.com>
Date:   Fri, 16 Aug 2019 11:32:48 +0200
Message-ID: <CAAB86tC9+3qLT+prjqK8us3QHVWDZaj5hvsF+_usd2f90ke=eQ@mail.gmail.com>
Subject: GattManager1 RegisterApplication Segmentation fault
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Good morning

I am using bluez 5.50 DBus interface to expose a custom service. Seems
things goes well from logs, but I receive a Segmentation fault after
the registration is complete.

sudo bluetoothd -E -d -n -P hostname
...
bluetoothd[22951]: src/gatt-database.c:manager_register_app()
Registering application: :1.2272:/org/bluez/hci0/app0
bluetoothd[22951]: src/gatt-database.c:proxy_added_cb() Object
received: /org/bluez/hci0/app0/service_000003e8, iface:
org.bluez.GattService1
bluetoothd[22951]: src/gatt-database.c:include_services() path
/org/bluez/hci0/app0
bluetoothd[22951]: include service not found
bluetoothd[22951]: src/gatt-database.c:include_services() path
/org/bluez/hci0/app0
bluetoothd[22951]: include service not found
bluetoothd[22951]: src/gatt-database.c:gatt_db_service_added() GATT
Service added to local database
bluetoothd[22951]: src/adapter.c:adapter_service_add() /org/bluez/hci0
bluetoothd[22951]: src/sdpd-service.c:add_record_to_server() Adding
record with handle 0x1001b
bluetoothd[22951]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00000007-0000-1000-8000-00805f9
bluetoothd[22951]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[22951]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 000003e8-0001-1000-8000-00805f9
bluetoothd[22951]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[22951]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
bluetoothd[22951]: src/adapter.c:add_uuid() sending add uuid command for index 0
bluetoothd[22951]: src/gatt-database.c:client_ready_cb() GATT
application registered: :1.2272:/org/bluez/hci0/app0
Segmentation fault


As a side note, I am setting GattService1 `Includes` to the same
service UUID because bluetoothd would otherwise report an error
parsing the field if let empty or omitted.

bluetoothd[25818]: src/gatt-database.c:manager_register_app()
Registering application: :1.2291:/org/bluez/hci0/app0
bluetoothd[25818]: src/gatt-database.c:proxy_added_cb() Object
received: /org/bluez/hci0/app0/service_000003e8, iface:
org.bluez.GattService1
bluetoothd[25818]: Failed to read "Includes" property of service
bluetoothd[25818]: Failed to add service
bluetoothd[25818]: Failed to create GATT service entry in local database


Do you have a suggestion ?

Thank you
Kind regards

Luca
