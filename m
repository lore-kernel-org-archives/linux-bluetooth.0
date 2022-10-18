Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0BBC433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Oct 2022 20:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiJRUuF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Oct 2022 16:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiJRUty (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Oct 2022 16:49:54 -0400
Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0937F3A6
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Oct 2022 13:49:43 -0700 (PDT)
Received: from github.com (hubbernetes-node-45b6459.ash1-iad.github.net [10.56.201.101])
        by smtp.github.com (Postfix) with ESMTPA id 186C09007B7
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Oct 2022 13:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1666126182;
        bh=MHs61tKqcqRWtDUY5CCjEQkKaoB8zUAvna/w+XfRm40=;
        h=Date:From:To:Subject:From;
        b=Oi5wYEH2g57O1VbQK7O3sgtn8ERpQPZ+C83tfRnSct23U2uQ/M53Rd45GHhm/p1cM
         BN0mP3AyFQ9O1JzAtizPi3HoKQCARInX9JMFwnphf1wsr5jwShjNvpkiidsfbPTMFG
         RcgvC7at6jFzy394H5aM1mOVCNNg5YrQYsEvGMjA=
Date:   Tue, 18 Oct 2022 13:49:42 -0700
From:   Abhay <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/1096a9-07fd4b@github.com>
Subject: [bluez/bluez] d3a204: lib/uuid: Add GMCS UUIDs
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: d3a204b8a2c08d554faab5ad5bb8581620c457bb
      https://github.com/bluez/bluez/commit/d3a204b8a2c08d554faab5ad5bb8581620c457bb
  Author: Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
  Date:   2022-10-18 (Tue, 18 Oct 2022)

  Changed paths:
    M lib/uuid.h

  Log Message:
  -----------
  lib/uuid: Add GMCS UUIDs

This adds GMCS UUIDs which will be used by Media Control Profile.


  Commit: 3973147aa8e424bd2ab78304b54d914208d560d1
      https://github.com/bluez/bluez/commit/3973147aa8e424bd2ab78304b54d914208d560d1
  Author: Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
  Date:   2022-10-18 (Tue, 18 Oct 2022)

  Changed paths:
    M Makefile.am
    A src/shared/mcp.c
    A src/shared/mcp.h
    A src/shared/mcs.h

  Log Message:
  -----------
  shared/mcp: Add initial code for handling MCP

This adds initial code for Media Control Profile for Client Role.


  Commit: 123e1ee1ce063af2e28ed7153627081710aa75af
      https://github.com/bluez/bluez/commit/123e1ee1ce063af2e28ed7153627081710aa75af
  Author: Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
  Date:   2022-10-18 (Tue, 18 Oct 2022)

  Changed paths:
    M Makefile.plugins
    M configure.ac
    A profiles/audio/mcp.c

  Log Message:
  -----------
  profiles: Add initial code for mcp plugin

This adds initial code for mcp plugin which handles Media Control Profile
and Generic Media Control Service for Client Role.
The plugin exposes dbus methods for media control operations
like play, pause which can be invoked using player menu
in bluetoothctl.


  Commit: 07fd4b948251f0613df230ca365b8440808c5a5c
      https://github.com/bluez/bluez/commit/07fd4b948251f0613df230ca365b8440808c5a5c
  Author: Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
  Date:   2022-10-18 (Tue, 18 Oct 2022)

  Changed paths:
    M monitor/att.c

  Log Message:
  -----------
  monitor/att: Add decoding support for GMCS

This adds decoding support for GMCS attributes.

< ACL Data TX: Handle 3585 flags 0x00 dlen 7
      ATT: Read Request (0x0a) len 2
        Handle: 0x0056 Type: Media Control Point Opcodes Supported (0x2ba5)
> ACL Data RX: Handle 3585 flags 0x02 dlen 9
      ATT: Read Response (0x0b) len 4
        Value: 33180000
        Handle: 0x0056 Type: Media Control Point Opcodes Supported (0x2ba5)
              Supported Opcodes: 0x00001833
                Play (0x00000001)
                Pause (0x00000002)
                Stop (0x00000010)
                Move Relative (0x00000020)
                Previous Track (0x00000800)
                Next Track (0x00001000)


Compare: https://github.com/bluez/bluez/compare/1096a99cadfa...07fd4b948251
