Return-Path: <SRS0=7F+K=5F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120EAC4332E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Mar 2020 20:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA7D120775
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Mar 2020 20:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nB4Z/PdZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgCTUka (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Mar 2020 16:40:30 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:38408 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgCTUka (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Mar 2020 16:40:30 -0400
Received: by mail-pl1-f173.google.com with SMTP id w3so3001563plz.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2020 13:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kEeva5iJkpOYpQkRMHSLqHPg11Y9EzOHlIoY9qJTLII=;
        b=nB4Z/PdZmWdEJPF4XrDLJrvLAwUsaZRysezrHi8ij6jgZDbDm3Msqqmg26mULXJx71
         kYQGZmvx2+qAcbp+zK6odhZROvnfvKTlIlkM1qvx1Vr6BlXmAkuGUS0c7emZaRI4ry1z
         MnpujicWJk498zu0lSAFvcEO2iWg4z6J4pYQyZOwrYUvc61jbu+GCMti2ELrRnCe7Cuf
         +aUdNq4MY5W0P0/WwYbWxutQv4FVhg4xV7v+UTzn0EH9MVy6rkQpLfLX7gi7xedlPP9X
         j6jFtYYQadF8wEkb5tOTX5OF3ZmJ+BMl8bLAo2o+Q/UOxCOxVQ/Zd597QerHHa8nE3Yp
         lUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kEeva5iJkpOYpQkRMHSLqHPg11Y9EzOHlIoY9qJTLII=;
        b=TwhpD2uatsuLLp7TcotWk6tzGKA3T3bbCpNOhM1ZeqPKZBbPQftEs4yaZ0VpJYpv8F
         R3QRp9xnXhj5B48fT/SLfCdf9TvwJYpaBmu3DAfiqsVtIm/+n/lRxf6ekai/Xba7mGCT
         Nw/PBxsRtfc9LbGsU85JhyWEsgpyZh7weaUq2MJ8uvkr/Xw028ya/9A812nAw4hsuFdm
         vE31LL+PmIOPJA0abeSnv2Vil4AaAThxwCavQMeoXiqhaQFFPUc3RzclLOq4lVozpnmy
         Yqc5HJkaezc6kzBoHnu1dw9ryRJ7/KDrzAzePOcN9jihi51MPFdxW7SgRBB5tSeiUuPC
         v0Iw==
X-Gm-Message-State: ANhLgQ2QnZsBxn277TEoxvZD/KOprbiR1gtgZVf8T96coTrqz1cJn/vA
        3EphyOirTl/K+K9yV7alfwwiRl2I
X-Google-Smtp-Source: ADFU+vs52A3h8L6WbZJOUkOoayl/rpN0KDPVs8qZW809rrMxLyxk6GIH8H98R6S3EiFS7nZ5rMI6og==
X-Received: by 2002:a17:90a:357:: with SMTP id 23mr11768038pjf.192.1584736827656;
        Fri, 20 Mar 2020 13:40:27 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id e187sm6048744pfe.143.2020.03.20.13.40.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 13:40:26 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 0/3] Enable use of L2CAP_MODE_EXT_FLOWCTL
Date:   Fri, 20 Mar 2020 13:40:23 -0700
Message-Id: <20200320204026.11680-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables use of BT_MODE_EXT_FLOWCTL with BT_MODE socketopt, in
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

Luiz Augusto von Dentz (3):
  Bluetooth: L2CAP: Add get_peer_pid callback
  Bluetooth: L2CAP: Use DEFER_SETUP to group ECRED connections
  Bluetooth: Add BT_MODE socket option

 include/net/bluetooth/bluetooth.h |  11 +++
 include/net/bluetooth/l2cap.h     |   5 ++
 net/bluetooth/l2cap_core.c        | 136 +++++++++++++++++++++++++++---
 net/bluetooth/l2cap_sock.c        | 104 +++++++++++++++++++++++
 4 files changed, 246 insertions(+), 10 deletions(-)

-- 
2.21.1

