Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CD6EE14AA
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Sep 2023 00:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbjIGArB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Sep 2023 20:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242640AbjIGArA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Sep 2023 20:47:00 -0400
Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413971BCA
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Sep 2023 17:45:23 -0700 (PDT)
Received: from github.com (hubbernetes-node-b71b1ee.ac4-iad.github.net [10.52.208.79])
        by smtp.github.com (Postfix) with ESMTPA id 8FB227010B9
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Sep 2023 17:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1694047522;
        bh=4tzTmtVAjWn5WeuK/4wJ1x49Rf51HLJ9KZwyiElCK2Q=;
        h=Date:From:To:Subject:From;
        b=Dy5KkFaNPoqY0DApmwvyL3lXUrgQN2HtiTZpyzcoUC1AONAVJnMbfYiIUjbt+TPHU
         LXpq2uVI52DK4aB7Lupy/qZ0fd91UqVgsqNxjIH/Wn7uWT5NYoeY0cs9hvTcACCS46
         /zhFOH7PwwfhvmdaKxc4gO4eCfkG7DXtcCF8z7vY=
Date:   Wed, 06 Sep 2023 17:45:22 -0700
From:   Claudia Draghicescu <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/2e4771-dc13da@github.com>
Subject: [bluez/bluez] dc13da: btio: Fix BASE copy from getsockopt()
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
  Commit: dc13da09d78b3df761d27ee8f4bf7089afe37788
      https://github.com/bluez/bluez/commit/dc13da09d78b3df761d27ee8f4bf7089afe37788
  Author: Claudia Draghicescu <claudia.rosu@nxp.com>
  Date:   2023-09-06 (Wed, 06 Sep 2023)

  Changed paths:
    M btio/btio.c

  Log Message:
  -----------
  btio: Fix BASE copy from getsockopt()

Fix copy of BASE from getsockopt() and update base length.


