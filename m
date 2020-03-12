Return-Path: <SRS0=41cZ=45=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0975CC10DCE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 22:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD79206CD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 22:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zlt0MMbz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgCLWY7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Mar 2020 18:24:59 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:32807 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgCLWY7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Mar 2020 18:24:59 -0400
Received: by mail-pg1-f169.google.com with SMTP id m5so3784014pgg.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2020 15:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wch2aZs8CTCugZR0ebvweouPjx1RFLpQS5DGwhzerlU=;
        b=Zlt0MMbzxA3ssg11J7t6yrIUXlc8r+q54bn9+l7iP547rwQneqTVS7WS+iMZrSpSmU
         PoK0o9L4QIKcSkSgtdsWw+i3P04BzPrnjEi++rIbRV7dxOgrJzWnTKXC/4iu4OR5ZGiC
         S91QIkTJ/IMxuwfbEvKOdN3OnxIDnx+3bLVXD5GuFU9OM3mdN0BDslOZDN7e2kBtTtmg
         EUNsabOrExxoX4HyF/6bGrYCjeDHd+rckt+Lzd9zBEYbXyiK76uHd6UwFU7rYQValg4+
         3OREIr3vKr4XameGbVOaWP9dhSBuUsxz0pBZBIJyeBDrO0LkQ7dH42xVel9QyQsvqnLl
         S1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wch2aZs8CTCugZR0ebvweouPjx1RFLpQS5DGwhzerlU=;
        b=Cp4T5Ndd4kvZoNS1PQYTtTu3Ba2iDQ67sarph7LKVc7YvVjAFxEpTZVlX9znB9MAun
         f1wPVO2HKZuv53wdyjPvbePHHI4CLMB2gVV4g/0658y9hWLw9tg/vMUQDX+/Zk4tuele
         5AZWUfOaM/C3Se1UaLpqsDFAhEhqZuwhBZZJenNam+PoxpsbIRO9CPPlJWPZpAr/3Hne
         VrURKu7AnXd/2EyrOxEQZcYUUeao50H1fzeaUHm18iqlIdhWm92l4kh34YhV/Sv/pKGP
         wVvnkRMBE87dE1bPSn9esFp5U9/zJSdt1RLjcSRDcOxHdUEL5OL8BAIVRJS8oJez2XsL
         WFhg==
X-Gm-Message-State: ANhLgQ2FcGtrPDm90SkIT1K3ncXuDUUMCFU0tSZMR2M5m+x8+Xd2KQnt
        CM5Zby1NTbg0sAFy4Y5djVp5rxJvTEE=
X-Google-Smtp-Source: ADFU+vvrTDMh6qlSTESVZkiTzHmrhx0aTk33BZF7vROP/2LzK21R1lDysAg4iuSMU9ibCOQVzSSfXw==
X-Received: by 2002:a62:be04:: with SMTP id l4mr10480933pff.234.1584051896455;
        Thu, 12 Mar 2020 15:24:56 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x190sm56827659pfb.96.2020.03.12.15.24.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 15:24:55 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/2] Enable use of L2CAP_MODE_EXT_FLOWCTL
Date:   Thu, 12 Mar 2020 15:24:52 -0700
Message-Id: <20200312222454.5079-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables use of L2CAP_MODE_EXT_FLOWCTL with BT_MODE socketopt, in
addition to that add support for DEFER_SETUP to be used with client
sockets so they can be grouped and sent together.

This has been tested by introducing support for L2CAP_MODE_EXT_FLOWCTL
into l2cap-tester which now produces the following trace:

Enable ecred PDUs:
#echo 1 > /sys/module/bluetooth/parameters/enable_ecred

#sudo tools/l2cap-tester -p "L2CAP Ext-Flowctl"
L2CAP Ext-Flowctl Client - Success - init
  Read Index List callback
    Status: 0x00
  New hciemu instance created
  Index Added callback
    Index: 0x0000
  Read Info callback
    Status: 0x00
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x003f
    Supported settings: 0x0001be1b
    Current settings: 0x00000200
    Class: 0x000000
    Name: 
    Short name: 
L2CAP Ext-Flowctl Client - Success - setup
  Powering on controller
  Controller powered on
  Client set connectable status 0x00
L2CAP Ext-Flowctl Client - Success - setup complete
L2CAP Ext-Flowctl Client - Success - run
  Connect in progress
  Successfully connected
L2CAP Ext-Flowctl Client - Success - test passed
L2CAP Ext-Flowctl Client - Success - teardown
  Index Removed callback
    Index: 0x0000
L2CAP Ext-Flowctl Client - Success - teardown complete
L2CAP Ext-Flowctl Client - Success - done

L2CAP Ext-Flowctl Client, Direct Advertising - Success - init
  Read Index List callback
    Status: 0x00
  New hciemu instance created
  Index Added callback
    Index: 0x0000
  Read Info callback
    Status: 0x00
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x003f
    Supported settings: 0x0001be1b
    Current settings: 0x00000200
    Class: 0x000000
    Name: 
    Short name: 
L2CAP Ext-Flowctl Client, Direct Advertising - Success - setup
  Powering on controller
  Controller powered on
  Client set connectable status 0x00
L2CAP Ext-Flowctl Client, Direct Advertising - Success - setup complete
L2CAP Ext-Flowctl Client, Direct Advertising - Success - run
  Connect in progress
  Received advertising parameters HCI command
L2CAP Ext-Flowctl Client, Direct Advertising - Success - test passed
L2CAP Ext-Flowctl Client, Direct Advertising - Success - teardown
  Index Removed callback
    Index: 0x0000
L2CAP Ext-Flowctl Client, Direct Advertising - Success - teardown complete
L2CAP Ext-Flowctl Client, Direct Advertising - Success - done

L2CAP Ext-Flowctl Client SMP - Success - init
  Read Index List callback
    Status: 0x00
  New hciemu instance created
  Index Added callback
    Index: 0x0000
  Read Info callback
    Status: 0x00
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x003f
    Supported settings: 0x0001be1b
    Current settings: 0x00000200
    Class: 0x000000
    Name: 
    Short name: 
L2CAP Ext-Flowctl Client SMP - Success - setup
  Powering on controller
  Controller powered on
  Client set connectable status 0x00
L2CAP Ext-Flowctl Client SMP - Success - setup complete
L2CAP Ext-Flowctl Client SMP - Success - run
  Connect in progress
  Successfully connected
L2CAP Ext-Flowctl Client SMP - Success - test passed
L2CAP Ext-Flowctl Client SMP - Success - teardown
  Index Removed callback
    Index: 0x0000
L2CAP Ext-Flowctl Client SMP - Success - teardown complete
L2CAP Ext-Flowctl Client SMP - Success - done

L2CAP Ext-Flowctl Client - Command Reject - init
  Read Index List callback
    Status: 0x00
  New hciemu instance created
  Index Added callback
    Index: 0x0000
  Read Info callback
    Status: 0x00
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x003f
    Supported settings: 0x0001be1b
    Current settings: 0x00000200
    Class: 0x000000
    Name: 
    Short name: 
L2CAP Ext-Flowctl Client - Command Reject - setup
  Powering on controller
  Controller powered on
  Client set connectable status 0x00
L2CAP Ext-Flowctl Client - Command Reject - setup complete
L2CAP Ext-Flowctl Client - Command Reject - run
  Connect in progress
  New connection with handle 0x002a
  Connect failed: Connection refused (111)
L2CAP Ext-Flowctl Client - Command Reject - test passed
L2CAP Ext-Flowctl Client - Command Reject - teardown
  Index Removed callback
    Index: 0x0000
L2CAP Ext-Flowctl Client - Command Reject - teardown complete
L2CAP Ext-Flowctl Client - Command Reject - done

L2CAP Ext-Flowctl Client - Open two sockets - init
  Read Index List callback
    Status: 0x00
  New hciemu instance created
  Index Added callback
    Index: 0x0000
  Read Info callback
    Status: 0x00
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x003f
    Supported settings: 0x0001be1b
    Current settings: 0x00000200
    Class: 0x000000
    Name: 
    Short name: 
L2CAP Ext-Flowctl Client - Open two sockets - setup
  Powering on controller
  Controller powered on
L2CAP Ext-Flowctl Client - Open two sockets - setup complete
L2CAP Ext-Flowctl Client - Open two sockets - run
  Connect in progress, sk = 19 (deferred)
  HCI Command 0x200b length 7
  HCI Command 0x200c length 2
  Connect in progress, sk = 20 
  Client set connectable status 0x00
  HCI Command 0x200c length 2
  HCI Command 0x200d length 25
  HCI Command 0x2016 length 2
  Successfully connected
  Successfully connected
L2CAP Ext-Flowctl Client - Open two sockets - test passed
L2CAP Ext-Flowctl Client - Open two sockets - teardown
  Index Removed callback
    Index: 0x0000
L2CAP Ext-Flowctl Client - Open two sockets - teardown complete
L2CAP Ext-Flowctl Client - Open two sockets - done

L2CAP Ext-Flowctl Client - Open two sockets close one - init
  Read Index List callback
    Status: 0x00
  New hciemu instance created
  Index Added callback
    Index: 0x0000
  Read Info callback
    Status: 0x00
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x003f
    Supported settings: 0x0001be1b
    Current settings: 0x00000200
    Class: 0x000000
    Name: 
    Short name: 
L2CAP Ext-Flowctl Client - Open two sockets close one - setup
  Powering on controller
  Controller powered on
L2CAP Ext-Flowctl Client - Open two sockets close one - setup complete
L2CAP Ext-Flowctl Client - Open two sockets close one - run
  Connect in progress, sk = 19 (deferred)
  HCI Command 0x200b length 7
  HCI Command 0x200c length 2
  Connect in progress, sk = 20 
  Closing first socket! -1
  Client set connectable status 0x00
  HCI Command 0x200c length 2
  HCI Command 0x200d length 25
  HCI Command 0x2016 length 2
  Successfully connected
L2CAP Ext-Flowctl Client - Open two sockets close one - test passed
L2CAP Ext-Flowctl Client - Open two sockets close one - teardown
  Index Removed callback
    Index: 0x0000
L2CAP Ext-Flowctl Client - Open two sockets close one - teardown complete
L2CAP Ext-Flowctl Client - Open two sockets close one - done


Test Summary
------------
L2CAP Ext-Flowctl Client - Success                   Passed       0.068 seconds
L2CAP Ext-Flowctl Client, Direct Advertising - Success Passed       0.023 seconds
L2CAP Ext-Flowctl Client SMP - Success               Passed       0.027 seconds
L2CAP Ext-Flowctl Client - Command Reject            Passed       0.046 seconds
L2CAP Ext-Flowctl Client - Open two sockets          Passed       0.014 seconds
L2CAP Ext-Flowctl Client - Open two sockets close one Passed       0.066 seconds
Total: 6, Passed: 6 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.247 seconds

Luiz Augusto von Dentz (2):
  Bluetooth: L2CAP: Use DEFER_SETUP to group ECRED connections
  Bluetooth: Add BT_MODE socket option

 include/net/bluetooth/bluetooth.h |   2 +
 include/net/bluetooth/l2cap.h     |   5 ++
 net/bluetooth/l2cap_core.c        | 130 +++++++++++++++++++++++++++---
 net/bluetooth/l2cap_sock.c        |  92 ++++++++++++++++-----
 4 files changed, 199 insertions(+), 30 deletions(-)

-- 
2.21.1

