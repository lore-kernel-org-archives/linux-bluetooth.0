Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E866AEB64DD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Jul 2023 20:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjGUUbT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Jul 2023 16:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjGUUbS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Jul 2023 16:31:18 -0400
Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DF6B7
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jul 2023 13:31:17 -0700 (PDT)
Received: from github.com (hubbernetes-node-1680148.ac4-iad.github.net [10.52.207.74])
        by smtp.github.com (Postfix) with ESMTPA id 046F81E0876
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jul 2023 13:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1689971477;
        bh=H2aoQ/M2mXFmWm75cAt0l/YOqDHYn1dn5uO1z80ZFfQ=;
        h=Date:From:To:Subject:From;
        b=HPal0jfQAHQejMpRyvvt8EIlB8B4DC8sRaO2kqujbn4lFK5CKM0veOeVuHHzEyaJT
         X8X+JCF3RHpTSASH5sLpPfRa1i47xrOJzSmmKxn5c12uxbv01yLMo8iL35XVTyuvIM
         zKqkVDcHkEZwcaqagJfGWqi8bXzaRDHBs2jhPm5o=
Date:   Fri, 21 Jul 2023 13:31:17 -0700
From:   =?UTF-8?B?xYF1a2FzeiBSeW1hbm93c2tp?= <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/82d3d8-d8ca06@github.com>
Subject: [bluez/bluez] 4337eb: monitor: Fix adv_handle size in the set info
 trans...
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 4337eb25b04cc168a102c56e817fef20bb62cf75
      https://github.com/bluez/bluez/commit/4337eb25b04cc168a102c56e817fe=
f20bb62cf75
  Author: Jakub Tyszkowski <jakub.tyszkowski@codecoup.pl>
  Date:   2023-07-21 (Fri, 21 Jul 2023)

  Changed paths:
    M monitor/bt.h

  Log Message:
  -----------
  monitor: Fix adv_handle size in the set info transfer packet

As per Bluetooth Core 5.4 Vol 4. Part E, 7.8.90,
adv_handle is 1 octet size and not 2.


  Commit: cc9f3a8e510a5ac8c0441a7714256dca969b695b
      https://github.com/bluez/bluez/commit/cc9f3a8e510a5ac8c0441a7714256=
dca969b695b
  Author: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
  Date:   2023-07-21 (Fri, 21 Jul 2023)

  Changed paths:
    M monitor/bt.h

  Log Message:
  -----------
  monitor: Fix invalid Create BIG Test command

As per Bluetooth Core 5.4 Vol 4 Part E, 7.8.104,
max pdu is 2 octect long and there is no adv_handle before encyption
flag


  Commit: aee361c8eb0fd0fa102ed4190de526cc339b8906
      https://github.com/bluez/bluez/commit/aee361c8eb0fd0fa102ed4190de52=
6cc339b8906
  Author: =C5=81ukasz Rymanowski <lukasz.rymanowski@codecoup.pl>
  Date:   2023-07-21 (Fri, 21 Jul 2023)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  btmon: Fix obvious typo


  Commit: d8ca06631b7434ea8837f9c571bfe31d6602d31f
      https://github.com/bluez/bluez/commit/d8ca06631b7434ea8837f9c571bfe=
31d6602d31f
  Author: =C5=81ukasz Rymanowski <lukasz.rymanowski@codecoup.pl>
  Date:   2023-07-21 (Fri, 21 Jul 2023)

  Changed paths:
    M monitor/bt.h
    M monitor/packet.c

  Log Message:
  -----------
  btmon: Make BIG identifier consistent

Bluetooth spec uses BIG Handle as a BIG identifier.
Btmon sometimes use this and sometimes BIG ID.
This patch makes code consistent


Compare: https://github.com/bluez/bluez/compare/82d3d803d4c5...d8ca06631b=
74
