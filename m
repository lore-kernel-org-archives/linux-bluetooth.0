Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EB2C433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Oct 2022 21:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiJCVpJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Oct 2022 17:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJCVpH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Oct 2022 17:45:07 -0400
Received: from smtp.github.com (out-25.smtp.github.com [192.30.252.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD6213D6C
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Oct 2022 14:45:05 -0700 (PDT)
Received: from github.com (hubbernetes-node-862e228.ash1-iad.github.net [10.56.212.85])
        by smtp.github.com (Postfix) with ESMTPA id 97ADB84044C
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Oct 2022 14:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1664833504;
        bh=QHbOIdLy/uQIxuKF6kbHj6wlbChNwwJLDpKOe3Ayl6c=;
        h=Date:From:To:Subject:From;
        b=RJUc5cRMLKmUaQmspecS1nS96mpZ4A06Ju6BBKoj8MdXvNAxRa81oqUcji629P7s6
         003qQAVCTFGcjYaOu9nbLxwx0PdFZp//nvxr3Z6m6oGczc1N74mE+2C4XLvUKEvmYl
         W5ES6GfcYqTUk5cwDpPDt+UhnfnhwLWsEzHPLIVk=
Date:   Mon, 03 Oct 2022 14:45:04 -0700
From:   Isak Westin <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/25a31f-291cff@github.com>
Subject: [bluez/bluez] 926d16: mesh: Ignore Secure Network Beacon from subnet
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
  Commit: 926d16db8ae4bb5c40266be5bd6b10023d932c0d
      https://github.com/bluez/bluez/commit/926d16db8ae4bb5c40266be5bd6b10023d932c0d
  Author: Isak Westin <isak.westin@loytec.com>
  Date:   2022-10-03 (Mon, 03 Oct 2022)

  Changed paths:
    M mesh/net.c

  Log Message:
  -----------
  mesh: Ignore Secure Network Beacon from subnet

If this node is a member of a primary subnet and receives a Secure Network
beacon on a secondary subnet with an IV Index greater than the last known
IV Index of the primary subnet, the Secure Network beacon shall be ignored.
See MshPRFv1.0.1 section 3.10.5.


  Commit: 7d050890f01f32ebb394140cf3206ad5a5548d79
      https://github.com/bluez/bluez/commit/7d050890f01f32ebb394140cf3206ad5a5548d79
  Author: Isak Westin <isak.westin@loytec.com>
  Date:   2022-10-03 (Mon, 03 Oct 2022)

  Changed paths:
    M mesh/net.c

  Log Message:
  -----------
  mesh: Ignore SNB with invalid IV Index values

If we are in IV update in progress state, and receive a Secure Network
beacon with an IV index equal to last known IV index + 1, and IV update
flag set to 1, it should be ignored. See MshPRFv1.0.1 section 3.10.5.


  Commit: 9d22d54244307c31b300fd5c321e6c2dea0cc48d
      https://github.com/bluez/bluez/commit/9d22d54244307c31b300fd5c321e6c2dea0cc48d
  Author: Isak Westin <isak.westin@loytec.com>
  Date:   2022-10-03 (Mon, 03 Oct 2022)

  Changed paths:
    M mesh/net.c

  Log Message:
  -----------
  mesh: Allow Key refresh to skip Phase 2

If we are in Key Refresh Phase 1, and receive a Secure Network beacon
using the new NetKey and with KR flag set to 0, Phase 2 should be
skipped. See MshPRFv1.0.1 section 3.10.4.1.


  Commit: 291cff0680095a2bd4dd35ec0ccb5c42cf9c347c
      https://github.com/bluez/bluez/commit/291cff0680095a2bd4dd35ec0ccb5c42cf9c347c
  Author: Isak Westin <isak.westin@loytec.com>
  Date:   2022-10-03 (Mon, 03 Oct 2022)

  Changed paths:
    M mesh/cfgmod-server.c

  Log Message:
  -----------
  mesh: Allow Key Refresh Phase 0 to 3 transition

Transition to Phase 3 from Phase 0 does not cause any state change, but
is a valid transition. See MshPRFv1.0.1 section 4.2.14.


Compare: https://github.com/bluez/bluez/compare/25a31f5a930e...291cff068009
