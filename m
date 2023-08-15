Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC94C001B0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Aug 2023 19:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239697AbjHOTfG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Aug 2023 15:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239947AbjHOTeq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Aug 2023 15:34:46 -0400
Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAC61980
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Aug 2023 12:34:45 -0700 (PDT)
Received: from github.com (hubbernetes-node-23d0c5c.ash1-iad.github.net [10.56.209.103])
        by smtp.github.com (Postfix) with ESMTPA id 1E93C600A9E
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Aug 2023 12:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1692128085;
        bh=qPI5xLRlck8Ihtr/MLK6zbkod6lq/JopGT6EjtQ2Cjw=;
        h=Date:From:To:Subject:From;
        b=h+2NJH69YHUJaT6RJBnajQU1P58UhEKaCFjo5Llsw+ym7qWVbMeoqWnxZIRxc0YNz
         LmhSZAvO0Hos7ArO0EcasuFcDs8D5IfSbW3jcCxn5Xd0QTwK+u3unyhHcX2bXutuOR
         lq7QGeg69tIOWeeH2dPT2QnQrj1vqPemTeIdePZI=
Date:   Tue, 15 Aug 2023 12:34:45 -0700
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/8bf3a4-d68bfb@github.com>
Subject: [bluez/bluez] d68bfb: doc/test-runner: Update documentation using rst
 fo...
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
  Commit: d68bfb6564eaaba4d0705e2b5837b455320c7151
      https://github.com/bluez/bluez/commit/d68bfb6564eaaba4d0705e2b5837b455320c7151
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-08-15 (Tue, 15 Aug 2023)

  Changed paths:
    A doc/test-runner.rst
    R doc/test-runner.txt
    R tools/test-runner.rst

  Log Message:
  -----------
  doc/test-runner: Update documentation using rst format

This updates test-runner documentation with a few examples using rst
format.


