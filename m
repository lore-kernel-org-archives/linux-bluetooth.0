Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FBFCCA47F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jun 2022 20:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237396AbiF3Umq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jun 2022 16:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237313AbiF3Ump (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jun 2022 16:42:45 -0400
Received: from smtp.github.com (out-25.smtp.github.com [192.30.252.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6B913EB6
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 13:42:43 -0700 (PDT)
Received: from github.com (hubbernetes-node-4f7c58d.ash1-iad.github.net [10.56.201.109])
        by smtp.github.com (Postfix) with ESMTPA id 3B081840ABC
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 13:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1656621763;
        bh=Ll2wOUJ1qeGt0pcqeejnMhlXCttD9f5QZoz7/9vxKvk=;
        h=Date:From:To:Subject:From;
        b=kz90HJY6DwvaBtJC/VAC0rhdiFshpf6kYbmnGCyoGg61oWv2jyjIFB9xRyjGzq8MV
         gyFEn3Uy7ApaF84uuOQxe3CNLHaFZ60Kk9GAT8vzJSfeUZzR73/WkGIx5GI+k2bdZX
         wGLty+K/k/YJSx0IxN3NBQqecQkRhEYZdcRpPa8o=
Date:   Thu, 30 Jun 2022 13:42:43 -0700
From:   Brian Gix <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/be7ebf-5351d4@github.com>
Subject: [bluez/bluez] 44658f: avdtp: fix possible minor problems
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
  Commit: 44658fccacda3ade0ca2adbb2643b489671fe477=0D
      https://github.com/bluez/bluez/commit/44658fccacda3ade0ca2adbb2643b=
489671fe477=0D
  Author: lishengyu <lishengyu@uniontech.com>=0D
  Date:   2022-06-30 (Thu, 30 Jun 2022)=0D
=0D
  Changed paths:=0D
    M profiles/audio/avdtp.c=0D
=0D
  Log Message:=0D
  -----------=0D
  avdtp: fix possible minor problems=0D
=0D
It should always be considered that if send_request fails, sep=0D
should be removed from the list and the requested memory freed;=0D
=0D
=0D
  Commit: 8fc3368db84035bee91ce0bea2f7592343e19f81=0D
      https://github.com/bluez/bluez/commit/8fc3368db84035bee91ce0bea2f75=
92343e19f81=0D
  Author: Brian Gix <brian.gix@intel.com>=0D
  Date:   2022-06-30 (Thu, 30 Jun 2022)=0D
=0D
  Changed paths:=0D
    M src/adapter.c=0D
=0D
  Log Message:=0D
  -----------=0D
  core: make bt_uuid_hash() portable across archs=0D
=0D
bt_uuid_t is defined as a byte array, so it can cause alignment errors=0D=

on some architectures, when the two 64 bit halves are treated as u64s.=0D=

This patch ensures proper alignment across all architectures.=0D
=0D
Fixes:=0D
src/adapter.c: In function =E2=80=98bt_uuid_hash=E2=80=99:=0D
src/adapter.c:3617:8: error: cast increases required alignment of=0D
target type [-Werror=3Dcast-align]=0D
  val =3D (uint64_t *)&uuid_128.value.u128;=0D
        ^=0D
cc1: all warnings being treated as errors=0D
=0D
=0D
  Commit: 31690310c096994c553c373ab5464cc39fbfe860=0D
      https://github.com/bluez/bluez/commit/31690310c096994c553c373ab5464=
cc39fbfe860=0D
  Author: Brian Gix <brian.gix@intel.com>=0D
  Date:   2022-06-30 (Thu, 30 Jun 2022)=0D
=0D
  Changed paths:=0D
    M src/device.c=0D
=0D
  Log Message:=0D
  -----------=0D
  core: Fix signed vs unsigned compare=0D
=0D
__time_t is not a portable data type, and can cause sign mismatch on=0D
some compares.=0D
=0D
Fixes:=0D
  CC       src/bluetoothd-device.o=0D
src/device.c: In function =E2=80=98device_is_name_resolve_allowed=E2=80=99=
:=0D
src/device.c:4092:17: error: comparison of integer expressions of=0D
different signedness: =E2=80=98__time_t=E2=80=99 {aka =E2=80=98long int=E2=
=80=99} and=0D
=E2=80=98long unsigned int=E2=80=99 [-Werror=3Dsign-compare]=0D
  if (now.tv_sec >=3D device->name_resolve_failed_time +=0D
                 ^~=0D
cc1: all warnings being treated as errors=0D
=0D
=0D
  Commit: 5351d4d86a08fbdc7f537b4662c5a070dbf1d0b4=0D
      https://github.com/bluez/bluez/commit/5351d4d86a08fbdc7f537b4662c5a=
070dbf1d0b4=0D
  Author: Brian Gix <brian.gix@intel.com>=0D
  Date:   2022-06-30 (Thu, 30 Jun 2022)=0D
=0D
  Changed paths:=0D
    M mesh/mesh-config-json.c=0D
=0D
  Log Message:=0D
  -----------=0D
  mesh: Fix snprintf return values not being checked=0D
=0D
Some versions of the GCC compiler complain when the return value of=0D
snprintf is not checked. This patch cleans up the Mesh JSON parser.=0D
=0D
=0D
Compare: https://github.com/bluez/bluez/compare/be7ebf29b370...5351d4d86a=
08=0D
