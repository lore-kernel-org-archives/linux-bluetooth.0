Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC53ECAAD4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Aug 2022 21:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiH3Vjz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Aug 2022 17:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiH3Vjx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Aug 2022 17:39:53 -0400
Received: from smtp.github.com (out-18.smtp.github.com [192.30.252.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499A910F3
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Aug 2022 14:39:50 -0700 (PDT)
Received: from github.com (hubbernetes-node-c042b6e.va3-iad.github.net [10.48.14.45])
        by smtp.github.com (Postfix) with ESMTPA id B42DF340B76
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Aug 2022 14:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1661895589;
        bh=rVcYLydZMMGdx5N3YPP/ZyeBvOWD+zzkfC7js9cRn1A=;
        h=Date:From:To:Subject:From;
        b=zBq544SQ/E5RV07YgggL+/+PGfNXSn+KNQQfzah0aRyqxRN2+48t+1mp40zVY8yls
         /T2F/1Hb1U8PK4eGaM5bn4NJ833IkBwBfN4zauOjbrVEUN+FEtOXPARl0cql1j2bLl
         U/QacouSRpw4pONdnKWVB0/zr8hlZWCzkn5Ma+38=
Date:   Tue, 30 Aug 2022 14:39:49 -0700
From:   BluezTestBot <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/150bbf-d04b64@github.com>
Subject: [bluez/bluez] 75f73f: shell: Set empty argument if optarg is NULL
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
  Commit: 75f73f6d62645734f9e7a2385902750cf3ad3f16=0D
      https://github.com/bluez/bluez/commit/75f73f6d62645734f9e7a23859027=
50cf3ad3f16=0D
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>=0D
  Date:   2022-08-29 (Mon, 29 Aug 2022)=0D
=0D
  Changed paths:=0D
    M src/shared/shell.c=0D
=0D
  Log Message:=0D
  -----------=0D
  shell: Set empty argument if optarg is NULL=0D
=0D
This sets enmpty string ("") when argument don't set any optarg so the=0D=

application can tell when an option was set or not.=0D
=0D
=0D
  Commit: d297a5873d210df812369a03794f4faeac0bfe22=0D
      https://github.com/bluez/bluez/commit/d297a5873d210df812369a03794f4=
faeac0bfe22=0D
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>=0D
  Date:   2022-08-29 (Mon, 29 Aug 2022)=0D
=0D
  Changed paths:=0D
    M client/main.c=0D
    M client/player.c=0D
=0D
  Log Message:=0D
  -----------=0D
  client: Add -e/--endpoint option to auto register endpoints=0D
=0D
This adds -e/--endpoint option that can be used to auto register=0D
supported endpoints.=0D
=0D
=0D
  Commit: eb62d17e26f6ee6eb489fe9663494233b5480c6e=0D
      https://github.com/bluez/bluez/commit/eb62d17e26f6ee6eb489fe9663494=
233b5480c6e=0D
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>=0D
  Date:   2022-08-30 (Tue, 30 Aug 2022)=0D
=0D
  Changed paths:=0D
    M profiles/audio/bap.c=0D
    M profiles/audio/media.c=0D
    M src/shared/bap.c=0D
    M src/shared/bap.h=0D
=0D
  Log Message:=0D
  -----------=0D
  profiles: Add remote endpoint path to SelectProperties=0D
=0D
This adds the remote endpoint path to the dictionary sent in=0D
SelectProperties.=0D
It allows audio application to know for which remote endpoint the call is=
=0D
done and so for which it should act as an initiator.=0D
=0D
=0D
  Commit: fdff0e3ce3005e64cb137974a3704819bb2b4e0c=0D
      https://github.com/bluez/bluez/commit/fdff0e3ce3005e64cb137974a3704=
819bb2b4e0c=0D
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>=0D
  Date:   2022-08-30 (Tue, 30 Aug 2022)=0D
=0D
  Changed paths:=0D
    M doc/media-api.txt=0D
=0D
  Log Message:=0D
  -----------=0D
  doc: Add remote endpoint path to SelectProperties=0D
=0D
=0D
  Commit: d04b64003d9d7b934165ca0c0e1cdf0a2d3eb2c7=0D
      https://github.com/bluez/bluez/commit/d04b64003d9d7b934165ca0c0e1cd=
f0a2d3eb2c7=0D
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>=0D
  Date:   2022-08-30 (Tue, 30 Aug 2022)=0D
=0D
  Changed paths:=0D
    M src/shared/bap.h=0D
=0D
  Log Message:=0D
  -----------=0D
  profiles: Fix function definition style=0D
=0D
This was found by checkpatch in previous commit:=0D
WARNING:SPACING: Unnecessary space before function pointer arguments=0D
124: FILE: src/shared/bap.h:123:=0D
+	int (*select) (struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,=0D
=0D
Do the same for (*config) and (*clear) for consistence.=0D
=0D
=0D
Compare: https://github.com/bluez/bluez/compare/150bbff449c7...d04b64003d=
9d=0D
