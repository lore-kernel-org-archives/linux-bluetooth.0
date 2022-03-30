Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC36C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Mar 2022 20:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbiC3UI1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Mar 2022 16:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350979AbiC3UIY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Mar 2022 16:08:24 -0400
X-Greylist: delayed 98034 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Mar 2022 13:06:38 PDT
Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125E739830
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 13:06:38 -0700 (PDT)
Received: from github.com (hubbernetes-node-ee50d5c.ash1-iad.github.net [10.56.212.80])
        by smtp.github.com (Postfix) with ESMTPA id 5FCB99034C0
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 13:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1648670797;
        bh=OSHL95w/1Gevs02RvUYSHMxm+C9BQryHEVb3HX0ixbI=;
        h=Date:From:To:Subject:From;
        b=C1tPfBKIrsepZgVseVIBKAgWp+l5F8BkAK0QNAtn6SUD2W4EY3AiR2nc/+HPbzUMp
         olExNdwZGdmqwBpUzEolMpvRMQq881Ur67mszU/aiSsaWRsGH+G0w7cklDlMhxYbh7
         uzXn98t9SCMAArL1j4JBYXi42feCzjDNAc5WO4nA=
Date:   Wed, 30 Mar 2022 13:06:37 -0700
From:   BluezTestBot <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/6cb6e2-4a06a3@github.com>
Subject: [bluez/bluez] 0cc480: shell: Make bt_shell_add_submenu set main menu
 if ...
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

  Branch: refs/heads/master=0D
  Home:   https://github.com/bluez/bluez=0D
  Commit: 0cc480a546e9b4740451dbdaaadc3df8ca1f8c34=0D
      https://github.com/bluez/bluez/commit/0cc480a546e9b4740451dbdaaadc3=
df8ca1f8c34=0D
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>=0D
  Date:   2022-03-30 (Wed, 30 Mar 2022)=0D
=0D
  Changed paths:=0D
    M src/shared/shell.c=0D
=0D
  Log Message:=0D
  -----------=0D
  shell: Make bt_shell_add_submenu set main menu if none has been set=0D
=0D
If not main menu has been set when calling bt_shell_add_submenu then=0D
turns it on it main menu.=0D
=0D
=0D
  Commit: d204e84c0694700f6cb1b8d98d26492de63d4303=0D
      https://github.com/bluez/bluez/commit/d204e84c0694700f6cb1b8d98d264=
92de63d4303=0D
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>=0D
  Date:   2022-03-30 (Wed, 30 Mar 2022)=0D
=0D
  Changed paths:=0D
    M Makefile.tools=0D
    M client/main.c=0D
    A client/player.c=0D
    A client/player.h=0D
    M tools/bluetooth-player.c=0D
=0D
  Log Message:=0D
  -----------=0D
  client: Add support for player submenu=0D
=0D
This moves adds the functionality of bluetooth-player into=0D
bluetoothctl.=0D
=0D
=0D
  Commit: 4a06a31be0453d7c8208108dccbb7cfacf768bc4=0D
      https://github.com/bluez/bluez/commit/4a06a31be0453d7c8208108dccbb7=
cfacf768bc4=0D
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>=0D
  Date:   2022-03-30 (Wed, 30 Mar 2022)=0D
=0D
  Changed paths:=0D
    M profiles/audio/a2dp.c=0D
=0D
  Log Message:=0D
  -----------=0D
  a2dp: Fix crash when SEP codec has not been initialized=0D
=0D
If SEP has not been properly discovered avdtp_get_codec may return NULL=0D=

thus causing crashes such as when running AVRCP/TG/VLH/BI-01-C after=0D
AVRCP/TG/RCR/BV-04-C.=0D
=0D
Prevent remote endpoint registration if its codec is not available.=0D
=0D
Remove queue_isempty check from store_remote_seps since that prevents=0D
cleaning up if no seps could be registered.=0D
=0D
=0D
Compare: https://github.com/bluez/bluez/compare/6cb6e2ddf447...4a06a31be0=
45=0D
