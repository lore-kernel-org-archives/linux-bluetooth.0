Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC5CC6FD1F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Mar 2023 20:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjCNUYT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Mar 2023 16:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjCNUYQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Mar 2023 16:24:16 -0400
X-Greylist: delayed 142988 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Mar 2023 13:24:09 PDT
Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D102CC77
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Mar 2023 13:24:09 -0700 (PDT)
Received: from github.com (hubbernetes-node-99477de.ac4-iad.github.net [10.52.222.32])
        by smtp.github.com (Postfix) with ESMTPA id 9295F721FAC
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Mar 2023 13:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1678825448;
        bh=/kmBhFtAqosTOb0JZtzkjcmeg7+n6hzqHeM+6iY8I7c=;
        h=Date:From:To:Subject:From;
        b=h0Av+XrnT4VRWQp+x2XuzLvSeS0xTOfWWO50E8IF+NOERIjyvnt7MeDUIW1GEozvu
         Q431YD0hhJ59lPVNwmaWiAvKDa4BBQ903iMTMGIzc/ZYYY+LHiZvZp3r/oM5FR25Ai
         UaRCrODt/C09qJ2r86RYRzSX4WrEtDT3tczFVdTA=
Date:   Tue, 14 Mar 2023 13:24:08 -0700
From:   =?UTF-8?B?xYF1a2FzeiBSeW1hbm93c2tp?= <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/40576a-6ae44c@github.com>
Subject: [bluez/bluez] 932b90: shared/bap: Fix not unregistering idle callback
 on...
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
  Commit: 932b90f6c33e8f428bbfd1d761ff966e7d258c7f
      https://github.com/bluez/bluez/commit/932b90f6c33e8f428bbfd1d761ff9=
66e7d258c7f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-03-14 (Tue, 14 Mar 2023)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix not unregistering idle callback on detach

This make sure idle callback is unregistered before bt_gatt_client is
unref.


  Commit: 605ee768b789602f59f298423dfbad780deeeb8c
      https://github.com/bluez/bluez/commit/605ee768b789602f59f298423dfba=
d780deeeb8c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-03-14 (Tue, 14 Mar 2023)

  Changed paths:
    M src/shared/csip.c

  Log Message:
  -----------
  shared/csip: Fix not unregistering idle callback on detach

This make sure idle callback is unregistered before bt_gatt_client is
unref.


  Commit: 4b704fb45a69ed6e745c5d01cca9622ede4bf522
      https://github.com/bluez/bluez/commit/4b704fb45a69ed6e745c5d01cca96=
22ede4bf522
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-03-14 (Tue, 14 Mar 2023)

  Changed paths:
    M src/shared/gatt-client.c

  Log Message:
  -----------
  shared/gatt-client: Introduce bt_gatt_client_ref_safe

This introduces bt_gatt_client_ref_save which ensures the instaces
which are being destroyed, e.g. ref_count =3D 0, do not attempt to reach
callbacks.


  Commit: e040109302d841750b767e88c26a48e6f832edf3
      https://github.com/bluez/bluez/commit/e040109302d841750b767e88c26a4=
8e6f832edf3
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-03-14 (Tue, 14 Mar 2023)

  Changed paths:
    M src/shared/csip.c

  Log Message:
  -----------
  shared/csip: Fix crash on bt_csip_get_sirk

This fixes the following trace:

Invalid read of size 1
   at 0x1F4282: bt_csip_get_sirk (csip.c:812)
   by 0x176B21: csip_ready (csip.c:259)
   by 0x1F3C74: csip_notify_ready (csip.c:578)
   by 0x1F3C74: csip_idle (csip.c:659)
   by 0x1DCDCC: idle_notify (gatt-client.c:171)
   by 0x1D579A: queue_remove_if (queue.c:279)
   by 0x1D584F: queue_remove_all (queue.c:321)
   by 0x1E036F: notify_client_idle (gatt-client.c:180)
   by 0x1E036F: request_unref (gatt-client.c:199)
   by 0x1DC60D: destroy_att_send_op (att.c:211)
   by 0x1DC60D: handle_rsp (att.c:874)
   by 0x1DC60D: can_read_data (att.c:1064)
   by 0x1F43F4: watch_callback (io-glib.c:157)
   by 0x48BBC7E: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.=
7400.6)
   by 0x4912117: ??? (in /usr/lib64/libglib-2.0.so.0.7400.6)
   by 0x48BB24E: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.7400.6)
 Address 0x0 is not stack'd, malloc'd or (recently) free'd


  Commit: 2762129212f1c4045c2ca3628cb49f42cb024689
      https://github.com/bluez/bluez/commit/2762129212f1c4045c2ca3628cb49=
f42cb024689
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-03-14 (Tue, 14 Mar 2023)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Fix crash attempting to read Sets property

The following set can be observed when a sirk is exists but it is
encrypted leading to info->set to not be set:

Invalid read of size 8
   at 0x1ACDF0: append_set (device.c:1662)
   by 0x1FFEFFF7DF: ???
   by 0x1D4461: queue_foreach (queue.c:207)
   by 0x1AC8DE: dev_property_get_set (device.c:1700)
   by 0x1CF3E2: append_property (object.c:498)
   by 0x1CFA91: append_properties (object.c:527)
   by 0x1CFAFD: append_interface (object.c:542)
   by 0x48D7CEF: g_slist_foreach (gslist.c:887)
   by 0x1CF5A7: append_interfaces (object.c:1104)
   by 0x1CF5A7: append_object (object.c:1119)
   by 0x48D7CEF: g_slist_foreach (gslist.c:887)
   by 0x1CF5D0: append_object (object.c:1122)
   by 0x48D7CEF: g_slist_foreach (gslist.c:887)
 Address 0x8 is not stack'd, malloc'd or (recently) free'd


  Commit: 7b654b16fb04431178c13f96ec163779e3cfd752
      https://github.com/bluez/bluez/commit/7b654b16fb04431178c13f96ec163=
779e3cfd752
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-03-14 (Tue, 14 Mar 2023)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: fix Locations, Context to be PACS not PAC properties

Audio Locations and Contexts are properties of the PACS service, not of
individual PAC, as these are device-wide bitmaps and a single
characteristic may exist on PACS server (PACS v1.0 Sec 3).

Move the attributes out from bt_bap_pac to bt_bap_pacs, and actually
keep track of the values.


  Commit: 6ae44c74aaf93468ddc626a02b8f0420a808b13e
      https://github.com/bluez/bluez/commit/6ae44c74aaf93468ddc626a02b8f0=
420a808b13e
  Author: =C5=81ukasz Rymanowski <lukasz.rymanowski@codecoup.pl>
  Date:   2023-03-14 (Tue, 14 Mar 2023)

  Changed paths:
    M src/shared/btsnoop.c
    M tools/btsnoop.c

  Log Message:
  -----------
  btmon: Fix decoding truncated data

Some platforms use different filtering and for this purpose,
some of the ACL/SCO/ISO/SDP data is truncated.

In such a case, included length is smaller than the original size.
Without this fix, btmon stops working after first truncated packet.


Compare: https://github.com/bluez/bluez/compare/40576ac1badf...6ae44c74aa=
f9
