Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C87C46CA1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Sep 2023 18:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjIRSgE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Sep 2023 14:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIRSgD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Sep 2023 14:36:03 -0400
Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4897FF7
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Sep 2023 11:35:57 -0700 (PDT)
Received: from github.com (hubbernetes-node-906db76.va3-iad.github.net [10.48.205.121])
        by smtp.github.com (Postfix) with ESMTPA id 76AEB94126B
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Sep 2023 11:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1695062156;
        bh=mn64fg94xwUXXO6kR3D9oBpWvTNmsPqQp8mrr3Yjfog=;
        h=Date:From:To:Subject:From;
        b=KGQ6gC+2P3AP6ei+0jKOHajFNJGgK9gjO2bchw8P8d2pxbw1ePXaBcAQe5kO+/eIZ
         EKoqFt0qykPNPJeXGFecfUjdFlfg34M4JDbaA5/fSQoydDnmcH2gMJ3TZzlKdgVjXN
         GOAK3OWdixZg/h7HaI/ofoxEQIAptEgdXcFlmZso=
Date:   Mon, 18 Sep 2023 11:35:56 -0700
From:   KobaKo <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/7b9d2f-04e18c@github.com>
Subject: [bluez/bluez] 04e18c: configure.ac: Add enable_btpclient and
 enable_mesh...
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
  Commit: 04e18c0dcbc108843b4e53075c55b873e2afb786
      https://github.com/bluez/bluez/commit/04e18c0dcbc108843b4e53075c55b873e2afb786
  Author: Koba Ko <koba.ko@canonical.com>
  Date:   2023-09-18 (Mon, 18 Sep 2023)

  Changed paths:
    M configure.ac

  Log Message:
  -----------
  configure.ac: Add enable_btpclient and enable_mesh for internal ELL

when checking enable_external_ell != 'yes',
even enable_btpclient and enable_mesh are not enabled.
configure still prompt the error.
Then ELL must be installed to pass the configure.


