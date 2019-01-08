Return-Path: <SRS0=sr2f=PQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D359C43387
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jan 2019 02:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F3B206A3
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jan 2019 02:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mytenten-com.20150623.gappssmtp.com header.i=@mytenten-com.20150623.gappssmtp.com header.b="cpXjyYWy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbfAHC2W (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Jan 2019 21:28:22 -0500
Received: from mail-pf1-f180.google.com ([209.85.210.180]:41990 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbfAHC2W (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Jan 2019 21:28:22 -0500
Received: by mail-pf1-f180.google.com with SMTP id 64so1122471pfr.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Jan 2019 18:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mytenten-com.20150623.gappssmtp.com; s=20150623;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=5leP/Awp7ZZTrT/P6DWhFVxtQqkUeZJiWsNQsUYiWBQ=;
        b=cpXjyYWyPfAyqxB9+OKCI+78nOcyHKMDIiYOJrfgw0eYdDi+j/KvVPlGd1vN41r7bI
         GwPOpC/YbueuiwgqHwhLj1IkoU2jfCkNDrqPAQnGH0RvYbvu2jMOiYTIlxYppQsvvej6
         3EKXmuenGtdTrrNPIL+GavATsxqlyLDd63JtxmuW4xQFCZ/VSuivxY3lRe54d1OUHNwq
         2RAtTuMWI+LRmRV8ZBKAPodkj+1TAGdkjpCs6N0U1h2ncctmIZcstjHfilQTyJ0mfJR2
         gnutudxO8t+1S1wD0UATKauoF237K2KROV6xm/KrqD4mTqGvvOeA6WPzBgXholdf+way
         RTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=5leP/Awp7ZZTrT/P6DWhFVxtQqkUeZJiWsNQsUYiWBQ=;
        b=GgmVFB8K7+fOO0WzBxUotCroxdpA+uSSCAajcJcAQ3A8j9RmGybXykIqjTDEJMldzC
         HEVE1hFDVaDSkr7aI4XgbUNu9Un35H9sOx4yqbQ1At8oCieDaoX+gSpOQ90iRU0xBkIB
         GDpUwxCn9vAsoNlsB5C4qQs95k6mAg/Zl1TSa5PUzIPAmTWzLqRY/xupivTvE3D/AngZ
         kr9NaffcENcG6jOeF7eWkgLCJdneKLyUvqaS+dZWLSNjyf51UvcUH4e7AgIGGkG8lwhl
         d+9MXKg0M5rtiXQfeMdLyfcpvhHkNOG9z54BQkW5hFL+QCFrgxjRRIoha17MMKbI5CRC
         Jiqw==
X-Gm-Message-State: AJcUukeFDqDitu0Vd6zVDDrHN0uWK1/Wra9hLqt+ZNfqBn6SUFmvONmt
        lP3VC1mahOKI6HQp4Ewoa1rOoBUuOwU=
X-Google-Smtp-Source: ALg8bN5Pcd4pkyoMOAYuqu/7F/O3XzMVSsV75M40jceT2KMJda9CoQ5wFeTg9Q/0O+145t+d9mj2mg==
X-Received: by 2002:a63:c0f:: with SMTP id b15mr13151279pgl.314.1546914501003;
        Mon, 07 Jan 2019 18:28:21 -0800 (PST)
Received: from [192.168.1.85] (ae033236.dynamic.ppp.asahi-net.or.jp. [14.3.33.236])
        by smtp.gmail.com with ESMTPSA id h128sm101657197pgc.15.2019.01.07.18.28.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 18:28:20 -0800 (PST)
From:   Chris Cook <pooh@mytenten.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Not getting connected events
Message-Id: <7A8D5C38-F115-4D39-873D-58B596E467EB@mytenten.com>
Date:   Tue, 8 Jan 2019 11:28:17 +0900
To:     linux-bluetooth@vger.kernel.org
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I'm having an issue using the Bluez stack on an embedded linux platform =
related to Connected events.  Our application uses BLE only and have set =
bredr off. We implemented a handler for properties changed event on the =
Device interface and specifically look for the Connected property.
=20
We can connect external BLE apps and exchange messages fine but we only =
ever see Connected =3D False events and never receive any event =
notification for Connected =3D True. I=E2=80=99ve even resorted to =
printing out all events we recieve from the PropertiesChanged dbus =
handler and no properties changed events ever occur during the time slot =
in which the client is connecting to us. The connected =3D false events =
always occur at the right time (when our app disconnects ).

 In trying to figure this out, I dug through the Blues code stack to =
figure out where this might get dropped=E2=80=A6  Trail (as best I can =
follow) leads me to src/device.c

void device_add_connection(struct btd_device *dev, uint8_t bdaddr_type)


I don=E2=80=99t see any logs being generated for "Device %s is already =
connected" so that brings me to this line as the prime suspect:


if (dev->le_state.connected && dev->bredr_state.connected)
   return;


Not very clear on why this is there.  My limited reasoning skills would =
assume that I shouldn=E2=80=99t be bredr_state.connected
Given that I=E2=80=99ve set  bredr off but I may just not be =
understanding=E2=80=A6.

I'd appreciate it if anyone can give me some insight on why we would be =
seeing this....


Thanks,

Pooh=
