Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE8AC6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Mar 2023 16:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjCUQTV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Mar 2023 12:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjCUQTU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Mar 2023 12:19:20 -0400
Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675E635AD
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Mar 2023 09:19:18 -0700 (PDT)
Received: from github.com (hubbernetes-node-333ecee.ac4-iad.github.net [10.52.14.41])
        by smtp.github.com (Postfix) with ESMTPA id 0D9B6521A0B
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Mar 2023 09:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1679415558;
        bh=llpPqKlE5DzPzCEHSgwETH3FIlrOt1veHcLgso0jBRk=;
        h=Date:From:To:Subject:From;
        b=rfdDpKQhH4g0h5gw+NUWDtAzzV/pfbZncoENwFZr19BcwlrnX8glbZofDCuu4UIqS
         No7kb5wvlDgZAn9FGesJ+sViTZwLgFle9R8nngqlyQl++otUSXWup5e7ZBfvwfyOQ9
         OVsABpJt1izMaTj+aLNrKwOtmDF7qOD8XFQJ0XTw=
Date:   Tue, 21 Mar 2023 09:19:17 -0700
From:   BluezTestBot <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/4a3f46-338ba4@github.com>
Subject: [bluez/bluez] 1de417: audio/transport: Propagate errors from
 avrcp_set_v...
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
  Commit: 1de41786c1a22fe0d4f55805f3006ce66e5c65a6
      https://github.com/bluez/bluez/commit/1de41786c1a22fe0d4f55805f3006ce66e5c65a6
  Author: Marijn Suijten <marijn.suijten@somainline.org>
  Date:   2023-03-21 (Tue, 21 Mar 2023)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  audio/transport: Propagate errors from avrcp_set_volume to DBus

Any error while setting absolute volume on the peer, or notifying the
peer of changes was previously going completely unnoticed.  Propagate it
to the logs and back to the DBus "Volume" property setter so that they
aren't misled into thinking that the AVRCP command succeeded.

Note that an error is mostly harmless when the setter of the property is
an audio sink and the peer the audio source: in this case we're only
_notifying_ the peer of the change when it has already been applied on
the sink.

Also improve the other two error messages to more closely describe what
was "invalid" about the argument.


  Commit: 338ba4352b6cadafe61808c21302c0abe2168e02
      https://github.com/bluez/bluez/commit/338ba4352b6cadafe61808c21302c0abe2168e02
  Author: Aaron_shen <aarongt.shen@gmail.com>
  Date:   2023-03-21 (Tue, 21 Mar 2023)

  Changed paths:
    M obexd/src/manager.c

  Log Message:
  -----------
  obexd: reject to accept file when replying reject message

It will accept file when obex agent replied any message
event though the message is org.bluez.obex.Error.Rejected.
The patch helps to reject a Bluetooth object push request if
user replied "org.bluez.obex.Error.Rejected" message according
to the doc/obex-agent-api.txt.


Compare: https://github.com/bluez/bluez/compare/4a3f465a55c9...338ba4352b6c
