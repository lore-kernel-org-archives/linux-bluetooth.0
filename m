Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F96E743C2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Sep 2023 20:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbjI1UfL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Sep 2023 16:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjI1UfL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Sep 2023 16:35:11 -0400
Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CD6180
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Sep 2023 13:35:08 -0700 (PDT)
Received: from github.com (hubbernetes-node-921c391.ac4-iad.github.net [10.52.142.39])
        by smtp.github.com (Postfix) with ESMTPA id C474B7004E2
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Sep 2023 13:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1695933307;
        bh=kWuW6sHYlv+uAp/kMhy8Q53/MInXNtZhY5KuFdWNN0s=;
        h=Date:From:To:Subject:From;
        b=JjJFvv48IVqmeVcogRUTrowyHomIO7UB/hApKBMqB3VSV5k28yTSdNHVzrm4QJ9E1
         CT4edFY9XdoISdYXRT3+u9TztNyTdyAvM48UZ9SbVGUD+YYom/0V7pg6McMXvK4CDz
         tWmtcJgwMMVGsri8Jd+tyao5DppHHMO0Sz+sxmrw=
Date:   Thu, 28 Sep 2023 13:35:07 -0700
From:   BluezTestBot <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/tags/5.70/000000-c56970@github.com>
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

  Branch: refs/tags/5.70
  Home:   https://github.com/bluez/bluez
