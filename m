Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311B9C54EE9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Sep 2022 21:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiIVVSn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Sep 2022 17:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiIVVSe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Sep 2022 17:18:34 -0400
Received: from smtp.github.com (out-25.smtp.github.com [192.30.252.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D044110F71E
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Sep 2022 14:18:33 -0700 (PDT)
Received: from github.com (hubbernetes-node-8764bfe.ash1-iad.github.net [10.56.224.37])
        by smtp.github.com (Postfix) with ESMTPA id 1A8DE8407E3
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Sep 2022 14:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1663881513;
        bh=bRmme1J9AQvPvTNsseZFRNstSicAZ9ozAKw3UMH7404=;
        h=Date:From:To:Subject:From;
        b=AqwefKjQm0vNOY1p/AUKFRTKeBarNXsOUbTsTlr3mBYdwHE4Lr/0cBpXbPJaK0C0U
         eEQ/pmNJ2DY1JDErfqh0rcvQQ/kl4rRHuOgb9K/aVpt36JMIer1QMwpP9GZm1jxWWH
         QefSSFxjSOmMAb2XEq84+9aZ+GdadqqPRkq1jBIQ=
Date:   Thu, 22 Sep 2022 14:18:33 -0700
From:   Brian Gix <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/0da759-721d5a@github.com>
Subject: [bluez/bluez] 75ba18: mesh: Fix potential memory leak
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
  Commit: 75ba186a9ccd88b7fc871d5d1c6da3f7ac7c29b4
      https://github.com/bluez/bluez/commit/75ba186a9ccd88b7fc871d5d1c6da3f7ac7c29b4
  Author: Brian Gix <brian.gix@intel.com>
  Date:   2022-09-22 (Thu, 22 Sep 2022)

  Changed paths:
    M mesh/mesh-config-json.c

  Log Message:
  -----------
  mesh: Fix potential memory leak

This memory leak will never happen, however since we added a new
return from function that malloc'd memory, the free should still be
done.


  Commit: a76ff5879b755b97043a30682c97788d162bb229
      https://github.com/bluez/bluez/commit/a76ff5879b755b97043a30682c97788d162bb229
  Author: Isak Westin <isak.westin@hotmail.com>
  Date:   2022-09-22 (Thu, 22 Sep 2022)

  Changed paths:
    M mesh/net.c

  Log Message:
  -----------
  mesh: Add interface output filter

According to the mesh profile (3.4.5.2), if TTL is set to 1 for an
outgoing message, that message shall be dropped.


  Commit: b72edcc5ca6fd0b3728a37cfa2bfbf483953ebba
      https://github.com/bluez/bluez/commit/b72edcc5ca6fd0b3728a37cfa2bfbf483953ebba
  Author: Isak Westin <isak.westin@hotmail.com>
  Date:   2022-09-22 (Thu, 22 Sep 2022)

  Changed paths:
    M mesh/model.c

  Log Message:
  -----------
  mesh: Do not accept publication for unbound appkey

If a user tries to configure publication of a model with an appkey that
is not bound to that model, an error should be returned.


  Commit: c9fadca7eba448cc1cd0c9323458e20c665052d8
      https://github.com/bluez/bluez/commit/c9fadca7eba448cc1cd0c9323458e20c665052d8
  Author: Isak Westin <isak.westin@hotmail.com>
  Date:   2022-09-22 (Thu, 22 Sep 2022)

  Changed paths:
    M mesh/cfgmod-server.c

  Log Message:
  -----------
  mesh: Remove RFU check for publication set

It is not stated in the mesh profile that the RFU bits in a Model
Publication Set message have to be zero. In fact, PTS test
MESH/NODE/CFG/MP/BV-01-C is sending that command with non-zero RFU and
expects a reply.


  Commit: 0454e2d0957019768ee2ffc74cc477a15715aced
      https://github.com/bluez/bluez/commit/0454e2d0957019768ee2ffc74cc477a15715aced
  Author: Brian Gix <brian.gix@intel.com>
  Date:   2022-09-22 (Thu, 22 Sep 2022)

  Changed paths:
    M doc/mgmt-api.txt

  Log Message:
  -----------
  mgmt: Add support for Mesh in the kernel

These commands and events allow User space apps to test for Mesh
support, and request incoming mesh packets be delivered and request
outbound mesh packets to be sent. This is the basis for sharing
one controller between the legacy bluetoothd daemon and the mesh
bluetooth-meshd daemon.


  Commit: 721d5a8ae86d1ef1eea35109890b7622324cfc98
      https://github.com/bluez/bluez/commit/721d5a8ae86d1ef1eea35109890b7622324cfc98
  Author: Brian Gix <brian.gix@intel.com>
  Date:   2022-09-22 (Thu, 22 Sep 2022)

  Changed paths:
    M lib/mgmt.h

  Log Message:
  -----------
  lib: Add defines of new MGMT opcodes and events

Populated new opcodes and events into static mgmt_ev and mgmt_op string
arrays.


Compare: https://github.com/bluez/bluez/compare/0da759f1a36d...721d5a8ae86d
