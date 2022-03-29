Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889A6C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Mar 2022 16:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239964AbiC2Q4V (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Mar 2022 12:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240036AbiC2Q4C (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Mar 2022 12:56:02 -0400
X-Greylist: delayed 92 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 29 Mar 2022 09:54:18 PDT
Received: from o6.sgmail.github.com (o6.sgmail.github.com [192.254.113.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C886720186
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Mar 2022 09:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        h=from:subject:mime-version:content-type:content-transfer-encoding:to;
        s=smtpapi; bh=R2GQGz5ospX+uLWQBrzqzTZCTMhF6ULH6O1HbK26wk8=;
        b=lX4lJoiQlxhwX71X1t2lf+apfyGxn7tmo/rqVZMs31Lg3dW9oy+Fi7lmQ4yFWNwUzF79
        WWaoTh3QpMWgzRqBQLgfXkXGCxK1cFSG+0jDx52txqLw4ndsznpIdURYhFQh5ub3frZLIj
        EkNqXB2O7SD0VilmuCog9EKIuF+sXyY20=
Received: by filterdrecv-8f7bfc657-8gclk with SMTP id filterdrecv-8f7bfc657-8gclk-1-6243395D-CC
        2022-03-29 16:52:45.972975691 +0000 UTC m=+18037950.383680160
Received: from out-24.smtp.github.com (unknown)
        by geopod-ismtpd-3-3 (SG)
        with ESMTP id o0NAwuJmTsWlH3SzFrE-Vw
        for <linux-bluetooth@vger.kernel.org>;
        Tue, 29 Mar 2022 16:52:45.899 +0000 (UTC)
Received: from github.com (hubbernetes-node-0684b4d.ac4-iad.github.net [10.52.206.123])
        by smtp.github.com (Postfix) with ESMTPA id C1966600EBB
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Mar 2022 09:52:44 -0700 (PDT)
Date:   Tue, 29 Mar 2022 16:52:45 +0000 (UTC)
From:   BluezTestBot <noreply@github.com>
Message-ID: <bluez/bluez/push/refs/tags/5.64/000000-e74df8@github.com>
Subject: [bluez/bluez]
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All
X-SG-EID: =?us-ascii?Q?2PbZbus3sZRLh+DKQJCJo9sT2LmIelcsHP=2FTc9HBCkXXZZYNU+B3HZ+mULwEjX?=
 =?us-ascii?Q?v8G96WS1sKfx2SuqBdChMPUdtDnDIjlsjxI+d8H?=
 =?us-ascii?Q?NazF0hXgL9brnmy9BUJrrdH9maoXnkopkWas69k?=
 =?us-ascii?Q?j0qjL9XaBNG=2FkJNcERMD+O1qCPUUyYgFgg0BDPC?=
 =?us-ascii?Q?kga8WAfqx5T2LVshVLmoY5JDsPfhfeYeZVLCQyk?=
 =?us-ascii?Q?z3YJYnoh+IklafsViq0YF0Tuyae2628+WPd5HZ?=
To:     linux-bluetooth@vger.kernel.org
X-Entity-ID: /f+S0XqulHHajbNb6hGdxg==
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

  Branch: refs/tags/5.64
  Home:   https://github.com/bluez/bluez
