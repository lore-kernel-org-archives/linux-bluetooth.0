Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF413EB64DC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jun 2023 16:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjF0Qla (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Jun 2023 12:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbjF0QlZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Jun 2023 12:41:25 -0400
Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DECE52
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jun 2023 09:41:11 -0700 (PDT)
Received: from github.com (hubbernetes-node-a3635c1.ash1-iad.github.net [10.56.202.78])
        by smtp.github.com (Postfix) with ESMTPA id ECBF2600090
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jun 2023 09:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1687884070;
        bh=9t7pAo7w8VWRQq5MpllqEBIUk0Vw+t7yXifhpsUKCII=;
        h=Date:From:To:Subject:From;
        b=hcQISaVtHgbUVD1EToLPswxcOXOXw1Aeu4lDD+oTpD0QrWP1hg07lu8DVnvR/JZPR
         pn6/kLQ8ELj3KlyAK7KEwGhjDc2TamItAapZm+Av3aGvDqSjHIBgSCs19Sa/Qv57Kd
         eYqFdstj/RGu+XAJfhTQuGVxajJr79XO7+guZ9DE=
Date:   Tue, 27 Jun 2023 09:41:10 -0700
From:   Marcel Holtmann <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/b00bc6-6b9d16@github.com>
Subject: [bluez/bluez] 6b9d16: android: Fix compiler warning from GCC
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 6b9d167034b741605c3186e78e9742dda8e28e08
      https://github.com/bluez/bluez/commit/6b9d167034b741605c3186e78e974=
2dda8e28e08
  Author: Marcel Holtmann <marcel@holtmann.org>
  Date:   2023-06-27 (Tue, 27 Jun 2023)

  Changed paths:
    M android/gatt.c

  Log Message:
  -----------
  android: Fix compiler warning from GCC

This ignores the following two warnings from the compiler.

  CC       android/gatt.o
android/gatt.c: In function =E2=80=98handle_client_register_for_notificat=
ion=E2=80=99:
android/gatt.c:3733:9: error: =E2=80=98memcpy=E2=80=99 offset [0, 16] is =
out of the bounds [0, 0] [-Werror=3Darray-bounds=3D]
 3733 |         memcpy(&notification->ch, &cmd->char_id, sizeof(notificat=
ion->ch));
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~

  CC       android/gatt.o
android/gatt.c: In function =E2=80=98handle_client_register_for_notificat=
ion=E2=80=99:
android/gatt.c:3735:9: error: =E2=80=98memcpy=E2=80=99 writing 17 bytes i=
nto a region of size 0 overflows the destination [-Werror=3Dstringop-over=
flow=3D]
 3735 |         memcpy(&notification->ch, &cmd->char_id, sizeof(notificat=
ion->ch));
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~

It could be possible that these warnings are valid or they might be a
false positive. However since this is Android based code based on
Android HAL headers, just set pragma to ignore them.


