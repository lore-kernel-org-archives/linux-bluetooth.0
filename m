Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04840C00A8F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Oct 2023 19:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344219AbjJXTN1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Oct 2023 15:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343884AbjJXTN0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Oct 2023 15:13:26 -0400
Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEBB10C9
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Oct 2023 12:13:24 -0700 (PDT)
Received: from github.com (hubbernetes-node-67fbd61.va3-iad.github.net [10.48.144.34])
        by smtp.github.com (Postfix) with ESMTPA id F2BD48C06D5
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Oct 2023 12:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1698174803;
        bh=pWEcMO1pnlOnsAofX7Fc9b6DpucK5lqKkPlXpum7C5M=;
        h=Date:From:To:Subject:From;
        b=R2hSgeezfbKkmMZq8p2FVeLrLCNwlVQbsUPCD//KevZzljOL8gCST+UUaiX7XUPZo
         q16tiTPVM0zOuWia+S/G6taAN7Ppqtn7t8knjcWRLL99caOh3S0SC4lwjXAu6DD31p
         b9vVFVVss1cRN0elueLeBEaL9CMkPaOndC7uBQUk=
Date:   Tue, 24 Oct 2023 12:13:23 -0700
From:   iulia-tanasescu <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/e126cf-00fdb6@github.com>
Subject: [bluez/bluez] a17455: iso-tester: Add test for bcast receiver PA bind
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
  Commit: a17455cdcd213b4210571d4ec2a066d9daf91b15
      https://github.com/bluez/bluez/commit/a17455cdcd213b4210571d4ec2a066d9daf91b15
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2023-10-24 (Tue, 24 Oct 2023)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: Add test for bcast receiver PA bind

This adds a test for binding a Broadcast Receiver to a number of
BISes after PA sync has been established.


  Commit: 00fdb61d56161f523e975b4c044030f4b40abb6d
      https://github.com/bluez/bluez/commit/00fdb61d56161f523e975b4c044030f4b40abb6d
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2023-10-24 (Tue, 24 Oct 2023)

  Changed paths:
    M btio/btio.c
    M btio/btio.h
    M profiles/audio/bap.c
    M src/shared/bass.c

  Log Message:
  -----------
  btio: Allow binding a bcast listener before accept

This adds btio support for binding a PA sync io to a number of BISes,
before proceeding with BIG Create Sync.


Compare: https://github.com/bluez/bluez/compare/e126cf204907...00fdb61d5616
