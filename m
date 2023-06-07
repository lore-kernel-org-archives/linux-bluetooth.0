Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5627DC7EE2E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Jun 2023 20:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjFGUBV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Jun 2023 16:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbjFGUBI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Jun 2023 16:01:08 -0400
Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D482122
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jun 2023 13:01:06 -0700 (PDT)
Received: from github.com (hubbernetes-node-b4bc798.ash1-iad.github.net [10.56.156.25])
        by smtp.github.com (Postfix) with ESMTPA id D74CD9008EA
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jun 2023 13:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1686168065;
        bh=LuZlAeVcNn/ucFTbniOCM7Iq4QZweVWCkEohhfHX56A=;
        h=Date:From:To:Subject:From;
        b=DLCpdrgZaqlhk3f5US9i3HGexU2HvFzmcMVUEcyQptJZe6bWpRIE8OKA1+BBVABga
         ZWWbYgWn/osxVGTjIfhHdrQXaOHMeYKHCpv2dWt1jMxxtIzXSuC9mFHr0LLkAxzjKY
         8wsV4G+kBUjWFGY16EaESJCI0oSjiiYQ+Ws2+zeg=
Date:   Wed, 07 Jun 2023 13:01:05 -0700
From:   Arkadiusz Bokowy <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/52477e-08d627@github.com>
Subject: [bluez/bluez] 8f32fa: battery: Check interface before getting
 property
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
  Commit: 8f32fa24cc9d044263bef468ef940d4353456f31
      https://github.com/bluez/bluez/commit/8f32fa24cc9d044263bef468ef940d4353456f31
  Author: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
  Date:   2023-06-06 (Tue, 06 Jun 2023)

  Changed paths:
    M src/battery.c

  Log Message:
  -----------
  battery: Check interface before getting property

Client can export other interfaces than the BatteryProvide1 on the
registered object manager. So, before getting battery provider specific
property, validate that we are operating on the right interface.

This change will allow client to implement only one object manger for
media applications, players and battery providers without triggering
error message.


  Commit: 08d62744ce179137987154e526e27296cdb1d345
      https://github.com/bluez/bluez/commit/08d62744ce179137987154e526e27296cdb1d345
  Author: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
  Date:   2023-06-06 (Tue, 06 Jun 2023)

  Changed paths:
    M profiles/audio/media.c

  Log Message:
  -----------
  media: Register app objects in proxy_added_cb()

The proxy_added_cb() function is called every time a new client is added
to the application object manager. Registering media endpoint and player
in that proxy_added_cb() callback function will allow to register new
endpoints and players not only during the initial RegisterApplication
call, but also during the application lifetime. For instance, this might
allow to dynamically enable/disable support for additional codecs.


Compare: https://github.com/bluez/bluez/compare/52477e80fc89...08d62744ce17
