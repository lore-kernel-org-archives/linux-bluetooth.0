Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C746DC07E9D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Sep 2022 21:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbiIWVRu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Sep 2022 17:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbiIWVRq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Sep 2022 17:17:46 -0400
Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A4812206D
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Sep 2022 14:17:43 -0700 (PDT)
Received: from github.com (hubbernetes-node-58fd791.va3-iad.github.net [10.48.220.28])
        by smtp.github.com (Postfix) with ESMTPA id CEF1FE042F
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Sep 2022 14:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1663967862;
        bh=u8Kh7W3e6zgk7c1E8jxVx0OeYyQcEeLmNCBdLziua9A=;
        h=Date:From:To:Subject:From;
        b=xZ70DxcJCMkYiLyVCH0E6ul7eaWjoUIq6DbnO7pmLb+gjnOVGX8KLPFU87Eo/Rj52
         FOs2T+sxRALxlmfQLu7rLMz02pMvkRUWsWy8VGT5WeSgQ/D+EEuAB3vFpkyEUisAxH
         qI3bf5cXew8MM4fAFlL6/q2mU5O8dz4aQO8PmN6o=
Date:   Fri, 23 Sep 2022 14:17:42 -0700
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/95d9dc-6c7120@github.com>
Subject: [bluez/bluez] 47821c: advertising: parse_secondary: fix loop
 condition
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
  Commit: 47821c473102fe527b5447076987f70e9fcf8c72
      https://github.com/bluez/bluez/commit/47821c473102fe527b5447076987f70e9fcf8c72
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2022-09-23 (Fri, 23 Sep 2022)

  Changed paths:
    M src/advertising.c

  Log Message:
  -----------
  advertising: parse_secondary: fix loop condition

"secondary" isn't an array of pointers, so the iterator can never be
NULL.


  Commit: 2e4327816587ee7d2e3238268cacbdf40faa4b0e
      https://github.com/bluez/bluez/commit/2e4327816587ee7d2e3238268cacbdf40faa4b0e
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2022-09-23 (Fri, 23 Sep 2022)

  Changed paths:
    M src/advertising.c

  Log Message:
  -----------
  advertising: parse_secondary: fix mask value

It looks like a wrong mask value is used here as only the bits mentioned
in adv_secondary::flag can be set again within the loop.

Replace magic number by preprocessor macro.


  Commit: 732eaa7ccf85cb1038343d76a11c3e2b34029c44
      https://github.com/bluez/bluez/commit/732eaa7ccf85cb1038343d76a11c3e2b34029c44
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2022-09-23 (Fri, 23 Sep 2022)

  Changed paths:
    M src/advertising.c

  Log Message:
  -----------
  advertising: parse_secondary: check for NULL iterator

The passed iterator can be NULL as in
gdbus/client.c::properties_changed():
...
   proxy->prop_func(..., ..., iter=NULL, ...)
   +--src/advertising.c::properties_changed(..., ..., iter, ...);
      +--parse_secondary(iter, ...);
...


  Commit: abfb3a807c39ba577f1ed4f12a54c0f2eed2a96c
      https://github.com/bluez/bluez/commit/abfb3a807c39ba577f1ed4f12a54c0f2eed2a96c
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2022-09-23 (Fri, 23 Sep 2022)

  Changed paths:
    M src/advertising.c

  Log Message:
  -----------
  advertising: parse_min_interval: reset min_interval if iter is NULL

Set property to its default value (as done in all other methods listed
in parsers[]).


  Commit: a18d66862da146aaa45d013610bb51052b960f7b
      https://github.com/bluez/bluez/commit/a18d66862da146aaa45d013610bb51052b960f7b
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2022-09-23 (Fri, 23 Sep 2022)

  Changed paths:
    M src/advertising.c

  Log Message:
  -----------
  advertising: parse_[min|max]_interval: reset value if iter is NULL

Set property to its default value (as done in all other methods listed
in parsers[]).


  Commit: 47346e5390bb5c8a80c05b67c345f0d7a4ec7722
      https://github.com/bluez/bluez/commit/47346e5390bb5c8a80c05b67c345f0d7a4ec7722
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2022-09-23 (Fri, 23 Sep 2022)

  Changed paths:
    M src/advertising.c

  Log Message:
  -----------
  advertising: parse_tx_power: reset value if iter is NULL

Set property to its default value (as done in all other methods listed
in parsers[]).


  Commit: ee750bbaf68c519ab9e21e34e5b219e580a60278
      https://github.com/bluez/bluez/commit/ee750bbaf68c519ab9e21e34e5b219e580a60278
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2022-09-23 (Fri, 23 Sep 2022)

  Changed paths:
    M client/gatt.c

  Log Message:
  -----------
  client/gatt: proxy_property_changed: check for NULL iterator

The passed iterator can be NULL as in
gdbus/client.c::properties_changed():
...
   proxy->prop_func(..., ..., iter=NULL, ...)
   +--client/gatt.c::proxy_property_changed(..., ..., iter, ...);
      +--dbus_message_iter_get_arg_type(iter);
...


  Commit: f5cbe08af22e619c535f8933f2950d167ec8a3b9
      https://github.com/bluez/bluez/commit/f5cbe08af22e619c535f8933f2950d167ec8a3b9
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2022-09-23 (Fri, 23 Sep 2022)

  Changed paths:
    M src/gatt-database.c

  Log Message:
  -----------
  gatt: proxy_property_changed: check for NULL iterator

The passed iterator can be NULL as in
src/gatt-database.c::properties_changed():
...
   proxy->prop_func(..., ..., iter=NULL, ...)
   +--client/gatt.c::property_changed_cb(..., ..., iter, ...);
      +--dbus_message_iter_get_arg_type(iter);
...


  Commit: 15895e401e1e29821b67bdc9d12d3bfa67333b35
      https://github.com/bluez/bluez/commit/15895e401e1e29821b67bdc9d12d3bfa67333b35
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2022-09-23 (Fri, 23 Sep 2022)

  Changed paths:
    M src/battery.c

  Log Message:
  -----------
  battery: provided_battery_property_changed_cb: check iterator

The passed iterator can be NULL as in
gdbus/client.c::properties_changed():
...
   proxy->prop_func(..., ..., iter=NULL, ...)
   +--src/battery.c::provided_battery_property_changed_cb(, , iter, );
      +--dbus_message_iter_get_arg_type(iter);
...


  Commit: 6c712030567b76e4ea29adbd816c0e5cc994a45c
      https://github.com/bluez/bluez/commit/6c712030567b76e4ea29adbd816c0e5cc994a45c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-09-23 (Fri, 23 Sep 2022)

  Changed paths:
    M client/gatt.c

  Log Message:
  -----------
  client/gatt: Fix scan-build warning

This fixes the following warning:

client/gatt.c:2146:2: warning: Null pointer passed to 2nd parameter
expecting 'nonnull' [core.NonNullParamChecker]
        memcpy(*dst_value + offset, src_val, src_len);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Compare: https://github.com/bluez/bluez/compare/95d9dc6764fc...6c712030567b
