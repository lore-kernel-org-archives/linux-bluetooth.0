Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C51C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 21 May 2022 02:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239031AbiEUCAa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 May 2022 22:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbiEUCAa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 May 2022 22:00:30 -0400
Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4628415F6C6
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 May 2022 19:00:26 -0700 (PDT)
Received: from github.com (hubbernetes-node-b354b5c.ac4-iad.github.net [10.52.210.33])
        by smtp.github.com (Postfix) with ESMTPA id 972DB60015E
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 May 2022 19:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1653098425;
        bh=Y7w/vnMXQlrS1+vstsN5r7Sa+FSJnvu592siaIrnTkw=;
        h=Date:From:To:Subject:From;
        b=bZb4WjZ+1MyxOec+5/tGybLaT7/irUQtp/SjbRk/98/smfqX92siEdEY3V7DKLcCN
         om75c3cBZbEN2dtr1kylE4puRsLdrRUwTccGn7j9rOzmiRuY1x/Kg9hCrces6XHosM
         0GuPEKpihXDYkXLy9+jecsYmEP0vZhy5Eram5+XE=
Date:   Fri, 20 May 2022 19:00:25 -0700
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/f1069c-bbdd18@github.com>
Subject: [bluez/bluez] eb47cb: monitor/att: Fix not removing read from queue
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
  Commit: eb47cb5a04cb1db3b87374c0cda799b7e3ef65af
      https://github.com/bluez/bluez/commit/eb47cb5a04cb1db3b87374c0cda799b7e3ef65af
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-05-20 (Fri, 20 May 2022)

  Changed paths:
    M monitor/att.c

  Log Message:
  -----------
  monitor/att: Fix not removing read from queue

The code was using queue_find instead of queue_remove_if so follow up
read wouldn't match the attribute properly.


  Commit: 20e944ece7a1d43d2976289c85c19e5ad2056cbd
      https://github.com/bluez/bluez/commit/20e944ece7a1d43d2976289c85c19e5ad2056cbd
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-05-20 (Fri, 20 May 2022)

  Changed paths:
    M monitor/att.c

  Log Message:
  -----------
  monitor/att: Fix treating Notification/Indication as a request

Notification/Indication shall be treated as response so the correct
database is used.


  Commit: 8e1fd164a7960962235f3757d4e49df7c0229ea0
      https://github.com/bluez/bluez/commit/8e1fd164a7960962235f3757d4e49df7c0229ea0
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-05-20 (Fri, 20 May 2022)

  Changed paths:
    M monitor/att.c

  Log Message:
  -----------
  monitor/att: Fix not matching read frame direction

There could be read frames pending on both direction so this ensures
the direction is matched properly.


  Commit: bbdd18089b45d99f1e5c34bcc27d69d5b3ecabbf
      https://github.com/bluez/bluez/commit/bbdd18089b45d99f1e5c34bcc27d69d5b3ecabbf
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-05-20 (Fri, 20 May 2022)

  Changed paths:
    M monitor/att.c

  Log Message:
  -----------
  monitor/att: Fix parsing of Notify Mutiple

Notify Multiple was parsing handle multiple times causing the length to
be assumed to be a handle.


Compare: https://github.com/bluez/bluez/compare/f1069c4fe106...bbdd18089b45
