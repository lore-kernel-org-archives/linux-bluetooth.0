Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111D6C0015E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Jun 2023 08:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjF3IfK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Jun 2023 04:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbjF3Iew (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Jun 2023 04:34:52 -0400
Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C832130
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 01:34:51 -0700 (PDT)
Received: from github.com (hubbernetes-node-28769ec.va3-iad.github.net [10.48.221.52])
        by smtp.github.com (Postfix) with ESMTPA id 9F0488C10E8
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 01:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1688114090;
        bh=CROij0UjyNiwt27DfSts0FpQComl3LANJoJ58Qt1ooA=;
        h=Date:From:To:Subject:From;
        b=Kg9oX+zhCjsiSKQx/GNQ2PkqXmIMnk2H1Hqo7ISTQ9W+AouD7bVCtdJ3RauomZrR8
         BdmLDGGB4UCG3/d1suddqaYyu3j+aIxnmrPG4dNkp2nz2quXhxVPVzzOp0FZKlNajK
         mUnqsbEVaTEwbuIOC6tzG+cdRR9VCMwXQ6pFlEWk=
Date:   Fri, 30 Jun 2023 01:34:50 -0700
From:   BluezTestBot <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/tags/5.67/000000-ee466a@github.com>
Subject: [bluez/bluez]
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

  Branch: refs/tags/5.67
  Home:   https://github.com/bluez/bluez
