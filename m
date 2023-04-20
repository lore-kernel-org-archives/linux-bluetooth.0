Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B2BC77B73
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Apr 2023 23:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbjDTXQg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Apr 2023 19:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjDTXQf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Apr 2023 19:16:35 -0400
Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C582711
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Apr 2023 16:16:34 -0700 (PDT)
Received: from github.com (hubbernetes-node-18952c6.ash1-iad.github.net [10.56.149.35])
        by smtp.github.com (Postfix) with ESMTPA id A723E9007B1
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Apr 2023 16:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1682032593;
        bh=XdsYWO5iAub0Gt8Szw/84ZHRkzYhJGOOlU24pgzvO0o=;
        h=Date:From:To:Subject:From;
        b=JXOOJWVl+IIgKyV4GEyH//VDEW6pJyHkn9rMsFAjgU4gOZCxdAClCZPnZdiKgPXnk
         YlE/l1ld/pL4ts30XMnkFMmieflz2nsqyIbUQfvG2fIhZpKgIYVNS+DiZ6ErFk+cTp
         ZGDMivSXUTfxzTHODoGQN+zrAErMIVddgV1W1jE4=
Date:   Thu, 20 Apr 2023 16:16:33 -0700
From:   BluezTestBot <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/b56479-d36160@github.com>
Subject: [bluez/bluez] d36160: obexd: AuthorizePush: Support to return folder
 nam...
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
  Commit: d361604594048b1a4df370b969f9d5140c832d30
      https://github.com/bluez/bluez/commit/d361604594048b1a4df370b969f9d5140c832d30
  Author: Guiting Shen <aarongt.shen@gmail.com>
  Date:   2023-04-20 (Thu, 20 Apr 2023)

  Changed paths:
    M doc/obex-agent-api.txt
    M obexd/src/manager.c

  Log Message:
  -----------
  obexd: AuthorizePush: Support to return folder name for file storage

The obex agent usually returns the full path by getting the default
folder and filename from the Filename property of the transfer object
which is not convenient.

The patch helps that the obex agent can return the folder name suffixed
with '/' or new full path or even null which will use the default name
if new_name is NULL and the default folder if the new_folder is NULL in
opp_chkput().


