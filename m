Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEE4C77B7D
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 May 2023 19:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbjEETNT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 May 2023 15:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbjEETM6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 May 2023 15:12:58 -0400
Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAE72270F
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 May 2023 12:12:45 -0700 (PDT)
Received: from github.com (hubbernetes-node-b414d4f.va3-iad.github.net [10.48.137.12])
        by smtp.github.com (Postfix) with ESMTPA id 219205C01D3
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 May 2023 12:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1683313965;
        bh=0xzJpbdhFhaEWyyFg2bGhA6ZINrJJXNFy+FXF1qZ48c=;
        h=Date:From:To:Subject:From;
        b=XQ1gUEeGhzbPBgNZv4ah9/AxDFphbWR/fOS5WicWbqwvFPbw1JGZKAaVglj5PZ4l0
         Z/r00lbUBF7JeLu2B/+tNtVvPPWBCzd6a8iE5DlN6PNeEbvp++RNIvbcnbefq3FLg4
         Chr9FBBW3wqEpJQViEcKzePMqhstMXHJscw/+FiM=
Date:   Fri, 05 May 2023 12:12:45 -0700
From:   iulia-tanasescu <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/3818b9-6bafe1@github.com>
Subject: [bluez/bluez] 4e549c: lib/uuid: Add BASS UUIDs
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
  Commit: 4e549cf48b712088d22028282baabbfc93e5f033
      https://github.com/bluez/bluez/commit/4e549cf48b712088d22028282baabbfc93e5f033
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2023-05-05 (Fri, 05 May 2023)

  Changed paths:
    M lib/uuid.h

  Log Message:
  -----------
  lib/uuid: Add BASS UUIDs

This adds BASS UUIDs which will be used by Basic Audio Profile.


  Commit: d5d921881b7e143f0a879a1b5d5e43ffb1c7c18f
      https://github.com/bluez/bluez/commit/d5d921881b7e143f0a879a1b5d5e43ffb1c7c18f
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2023-05-05 (Fri, 05 May 2023)

  Changed paths:
    M src/shared/att-types.h

  Log Message:
  -----------
  shared/att-types: Add BT_ERROR_WRITE_REQUEST_REJECTED error code

This adds Write Request Rejected Common Profile and Service
Error Code.


  Commit: 18d49830b3e9ba0e346890bc3c0e9dd500eb0c2f
      https://github.com/bluez/bluez/commit/18d49830b3e9ba0e346890bc3c0e9dd500eb0c2f
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2023-05-05 (Fri, 05 May 2023)

  Changed paths:
    M src/shared/util.c
    M src/shared/util.h

  Log Message:
  -----------
  shared/util: Add iovec helpers

This adds iovec helper functions for handling byteorder and alignment
in place.


  Commit: a56c7fd162306460f6f1f0a9a72234cad3308d87
      https://github.com/bluez/bluez/commit/a56c7fd162306460f6f1f0a9a72234cad3308d87
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2023-05-05 (Fri, 05 May 2023)

  Changed paths:
    M Makefile.am
    A src/shared/bass.c
    A src/shared/bass.h

  Log Message:
  -----------
  shared/bass: Add initial code for handling BASS

This adds initial code for Broadcast Audio Scan Service.


  Commit: 6bafe1c66515e576362d0f124450a3f6f4c909aa
      https://github.com/bluez/bluez/commit/6bafe1c66515e576362d0f124450a3f6f4c909aa
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2023-05-05 (Fri, 05 May 2023)

  Changed paths:
    M Makefile.plugins
    M configure.ac
    A profiles/audio/bass.c

  Log Message:
  -----------
  profiles: Add initial code for BASS plugin

This adds initial code for BASS plugin.


Compare: https://github.com/bluez/bluez/compare/3818b99c764e...6bafe1c66515
