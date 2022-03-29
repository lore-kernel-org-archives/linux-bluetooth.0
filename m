Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7047CC433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Mar 2022 16:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239939AbiC2Q4U (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Mar 2022 12:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240042AbiC2Q4H (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Mar 2022 12:56:07 -0400
X-Greylist: delayed 93 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 29 Mar 2022 09:54:18 PDT
Received: from xtrwsrhn.outbound-mail.sendgrid.net (xtrwsrhn.outbound-mail.sendgrid.net [167.89.101.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86E51FCCC
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Mar 2022 09:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        h=from:subject:mime-version:content-type:content-transfer-encoding:to;
        s=smtpapi; bh=0IX8lR4lqYnWsXoybygpO8z241TI6dRsTYZlR5iy8zg=;
        b=tSG0tAF4/TXH+hp3NnW3QatNRcpX2dNlL+w2mc/LJzfpaHv91JWJRBXu07GyrVbbMO3c
        S2hQwjBdIQ/tp1DOw9OTj/5U9wb4XDr82nYHx+Jw33X+Dj2qVGOSxlfcsEErlNH7uYGKvG
        lzyfaCJBeJ+itT05F5kRXD8XapKyShd/c=
Received: by filterdrecv-58bbc978dc-fsz9x with SMTP id filterdrecv-58bbc978dc-fsz9x-1-6243395C-32
        2022-03-29 16:52:44.43750271 +0000 UTC m=+14915328.564282208
Received: from smtp.github.com (unknown)
        by geopod-ismtpd-4-1 (SG)
        with ESMTP id Crsq_jOuThiWzmw40pqO4A
        for <linux-bluetooth@vger.kernel.org>;
        Tue, 29 Mar 2022 16:52:44.298 +0000 (UTC)
Received: from github.com (hubbernetes-node-0456f9c.va3-iad.github.net [10.48.124.44])
        by smtp.github.com (Postfix) with ESMTPA id 7023C5C0E1B
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Mar 2022 09:52:43 -0700 (PDT)
Date:   Tue, 29 Mar 2022 16:52:44 +0000 (UTC)
From:   Luiz Augusto von Dentz <noreply@github.com>
Message-ID: <bluez/bluez/push/refs/heads/master/42e993-6cb6e2@github.com>
Subject: [bluez/bluez] 8fb8f9: gatt: Print error if gatt_db_attribut_notify
 fails
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All
X-SG-EID: =?us-ascii?Q?NCuo=2Faci8=2Fvc654FLG8ZqCi=2Ftd5PhuN55Q9iF5tvb2ErGMYgqEnmC5+VcxN1HW?=
 =?us-ascii?Q?HZEMO+yd+6Y5QOUrvrilW=2F0jdl96ZLPE+DRGJYJ?=
 =?us-ascii?Q?FrTbm1LgGM=2FiKAXp8NtlMbNII+EFJmRwJeYBfhh?=
 =?us-ascii?Q?SoeSL9eAMPpUTEtB1TRLQ4AXhBlEEETKNksaNuX?=
 =?us-ascii?Q?Npyh0SMYcPQkTU61d2wnZv19A6UixTeBLm5u1QP?=
 =?us-ascii?Q?QJg545T8N6vAcNjNFzu1=2FWSihJ+NI58Pc4C3cRs?=
 =?us-ascii?Q?m7vbLH=2FpYrRegeWaA1irA=3D=3D?=
To:     linux-bluetooth@vger.kernel.org
X-Entity-ID: /f+S0XqulHHajbNb6hGdxg==
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 8fb8f9e73ff8b1f79c668fe1cfb2eb89e3599721
      https://github.com/bluez/bluez/commit/8fb8f9e73ff8b1f79c668fe1cfb2eb89e3599721
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-03-14 (Mon, 14 Mar 2022)

  Changed paths:
    M src/gatt-database.c

  Log Message:
  -----------
  gatt: Print error if gatt_db_attribut_notify fails

This prints an error if gatt_db_attribut_notify fails.


  Commit: 411d63ec33a23bdbad73276067d02f9981229d0b
      https://github.com/bluez/bluez/commit/411d63ec33a23bdbad73276067d02f9981229d0b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-03-14 (Mon, 14 Mar 2022)

  Changed paths:
    M src/shared/gatt-db.c

  Log Message:
  -----------
  gatt-db: Fix gatt_db_attribute_notify

gatt_db_attribute_notify was only accepting passing the Characteristic
Declaration instead of accepting its value as well,
gatt_db_service_foreach_desc also have similar limitation so both have
been updated to allow working with both value and declaration.


  Commit: 41f8c466f3d558b7188470991dc61134f5ebd30d
      https://github.com/bluez/bluez/commit/41f8c466f3d558b7188470991dc61134f5ebd30d
  Author: Marcel Holtmann <marcel@holtmann.org>
  Date:   2022-03-16 (Wed, 16 Mar 2022)

  Changed paths:
    M ChangeLog
    M configure.ac

  Log Message:
  -----------
  Release 5.64


  Commit: a3c9409035deb20ce9d5535ce421f2bd252b92d9
      https://github.com/bluez/bluez/commit/a3c9409035deb20ce9d5535ce421f2bd252b92d9
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-03-23 (Wed, 23 Mar 2022)

  Changed paths:
    M src/log.h

  Log Message:
  -----------
  log: Don't log __FILE__ and __func__ with DBG_IDX

This removes __FILE__ and __func__ from DBG_IDX since users of it may
already contain such information embedded in the format.


  Commit: f9cb7c802f279aab8d49703282ddce4974ffcd26
      https://github.com/bluez/bluez/commit/f9cb7c802f279aab8d49703282ddce4974ffcd26
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-03-23 (Wed, 23 Mar 2022)

  Changed paths:
    M src/shared/mgmt.c

  Log Message:
  -----------
  mgmt: Add DBG macro

This adds mgmt_log wrapper for util_debug and DBG so file and function
names are printed with the logs.


  Commit: b7c807269f1f9260cc2c14ea542bdf79f9b657eb
      https://github.com/bluez/bluez/commit/b7c807269f1f9260cc2c14ea542bdf79f9b657eb
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-03-23 (Wed, 23 Mar 2022)

  Changed paths:
    M src/shared/mgmt.c
    M src/shared/mgmt.h

  Log Message:
  -----------
  mgmt: Introduce mgmt_set_verbose

This introduces mgmt_set_verbose which can be used to enable printing
the the likes hexdump of packets, by default it is disabled since in
most cases the hexdump is not very useful and there are better tools
to collect the hexdumo like btmon.


  Commit: 62c6037ea02b2d7dada43c1d7481fbe79f32dffb
      https://github.com/bluez/bluez/commit/62c6037ea02b2d7dada43c1d7481fbe79f32dffb
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-03-23 (Wed, 23 Mar 2022)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Don't use DBG in mgmt_debug

mgmt_debug callback is used to print debug strings from mgmt instances
which includes the file and function names so using DBG would add yet
another set of file and function prefixes which makes the logs
confusing.


  Commit: 8039d42687fd89ee0aca5ef61c92c631a22a0295
      https://github.com/bluez/bluez/commit/8039d42687fd89ee0aca5ef61c92c631a22a0295
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-03-23 (Wed, 23 Mar 2022)

  Changed paths:
    M src/shared/att.c

  Log Message:
  -----------
  att: Log file and function names

This adds logging of file and function names.


  Commit: e0870ce5e1fe842e11f5d2a8425b4c4594ca0799
      https://github.com/bluez/bluez/commit/e0870ce5e1fe842e11f5d2a8425b4c4594ca0799
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-03-23 (Wed, 23 Mar 2022)

  Changed paths:
    M src/shared/gatt-client.c

  Log Message:
  -----------
  gatt-client: Add DBG macro

This adds gatt_log wrapper for util_debug and DBG macro so file and
function names are printed which is more consistent with other parts of
the daemon code.


  Commit: 55c25d91e4d6bb673e03064244890d40dc58e191
      https://github.com/bluez/bluez/commit/55c25d91e4d6bb673e03064244890d40dc58e191
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-03-23 (Wed, 23 Mar 2022)

  Changed paths:
    M src/shared/gatt-server.c

  Log Message:
  -----------
  gatt-server: Add DBG macro

This adds gatt_log wrapper for util_debug and DBG so file and function
names are printed with the logs.


  Commit: e1b808c128fa0f1a2a5e16387e3b026cf3d6ec83
      https://github.com/bluez/bluez/commit/e1b808c128fa0f1a2a5e16387e3b026cf3d6ec83
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-03-23 (Wed, 23 Mar 2022)

  Changed paths:
    M src/shared/att.c

  Log Message:
  -----------
  att: Rename att_debug and att_verbose to DBG and VERBOSE

att_debug and att_verbose are macros which are more common to be
used as uppercase, this also change them to use DBG like other parts of
the code.


  Commit: 71cec503c8da865ab1e74ea6716a8034264dcb48
      https://github.com/bluez/bluez/commit/71cec503c8da865ab1e74ea6716a8034264dcb48
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-03-23 (Wed, 23 Mar 2022)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Don't use DBG in gatt_debug

gatt_debug callback is used to print debug strings from bt_att which
includes the file and function names so using DBG would add yet another
set of file and function prefixes which makes the logs confusing.


  Commit: 2a2b027176d5ed98483bf08ff335995502918d74
      https://github.com/bluez/bluez/commit/2a2b027176d5ed98483bf08ff335995502918d74
  Author: Inga Stotland <inga.stotland@intel.com>
  Date:   2022-03-26 (Sat, 26 Mar 2022)

  Changed paths:
    M mesh/mesh-io-generic.c
    M mesh/mesh-io-unit.c

  Log Message:
  -----------
  mesh: Fix address overrun error in rx filter

This fixes the following error for invalid read access when registering
filter for incoming messages:

140632==ERROR: AddressSanitizer: stack-buffer-overflow on address...
 #0 0x7f60c185741d in MemcmpInterceptorCommon(...
    #1 0x7f60c1857af8 in __interceptor_memcmp (/lib64/libasan.so...
    #2 0x55a10101536e in find_by_filter mesh/mesh-io-unit.c:494
    #3 0x55a1010d8c46 in l_queue_remove_if ell/queue.c:517
    #4 0x55a101014ebd in recv_register mesh/mesh-io-unit.c:506
    #5 0x55a10102946f in mesh_net_attach mesh/net.c:2885
    #6 0x55a101086f64 in send_reply mesh/dbus.c:153
    #7 0x55a101124c3d in handle_method_return ell/dbus.c:216
    #8 0x55a10112c8ef in message_read_handler ell/dbus.c:276
    #9 0x55a1010dae20 in io_callback ell/io.c:120
    #10 0x55a1010dff7e in l_main_iterate ell/main.c:478
    #11 0x55a1010e06e3 in l_main_run ell/main.c:525
    #12 0x55a1010e06e3 in l_main_run ell/main.c:507
    #13 0x55a1010e0bfc in l_main_run_with_signal ell/main.c:647
    #14 0x55a10100316e in main mesh/main.c:292
    #15 0x7f60c0c6855f in __libc_start_call_main (/lib64/libc.so.6+...
    #16 0x7f60c0c6860b in __libc_start_main_alias_1 (/lib64/libc.so.6+...
    #17 0x55a101003ce4 in _start (/home/istotlan/bluez/mesh/bluetooth-m...


  Commit: 4fefa24097e45153f99cabbc70534d69a2a35ecd
      https://github.com/bluez/bluez/commit/4fefa24097e45153f99cabbc70534d69a2a35ecd
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-03-28 (Mon, 28 Mar 2022)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Fix adding SDP records when operating on LE only mode

If mode is set to BT_MODE_LE SDP protocol won't be operational so it is
useless to attempt to add records.


  Commit: 18fc3abad28cccd2ac7e31963502973af8b86216
      https://github.com/bluez/bluez/commit/18fc3abad28cccd2ac7e31963502973af8b86216
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-03-28 (Mon, 28 Mar 2022)

  Changed paths:
    M profiles/audio/a2dp.c

  Log Message:
  -----------
  a2dp: Don't initialize a2dp_sep->destroy until properly registered

On a2dp_add_sep if the record cannot be properly registred
a2dp_unregister_sep would be called which would attempt to destroy the
user_data causing the following backtrace:

Invalid write of size 8
   at 0x2F41EB: endpoint_init_a2dp_source (media.c:687)
   by 0x2F41EB: media_endpoint_create (media.c:1030)
   by 0x2F6713: register_endpoint (media.c:1155)
   by 0x46983F: process_message (object.c:246)
   by 0x4A574A8: dbus_connection_dispatch (in /usr/lib64/libdbus-1.so.3.19.14)
   by 0x45F0BF: message_dispatch (mainloop.c:59)
   by 0x495239A: ??? (in /usr/lib64/libglib-2.0.so.0.7000.4)
   by 0x495605E: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.7000.4)
   by 0x49AB2A7: ??? (in /usr/lib64/libglib-2.0.so.0.7000.4)
   by 0x4955772: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.7000.4)
   by 0x4CA924: mainloop_run (mainloop-glib.c:66)
   by 0x4CAE1B: mainloop_run_with_signal (mainloop-notify.c:188)
   by 0x2AE791: main (main.c:1258)
 Address 0x6e47a30 is 0 bytes inside a block of size 112 free'd
   at 0x48470E4: free (vg_replace_malloc.c:872)
   by 0x4957CDC: g_free (in /usr/lib64/libglib-2.0.so.0.7000.4)
   by 0x2C2D57: a2dp_unregister_sep (a2dp.c:2588)
   by 0x2D124C: a2dp_add_sep (a2dp.c:2697)
   by 0x2F41D5: endpoint_init_a2dp_source (media.c:687)
   by 0x2F41D5: media_endpoint_create (media.c:1030)
   by 0x2F6713: register_endpoint (media.c:1155)
   by 0x46983F: process_message (object.c:246)
   by 0x4A574A8: dbus_connection_dispatch (in /usr/lib64/libdbus-1.so.3.19.14)
   by 0x45F0BF: message_dispatch (mainloop.c:59)
   by 0x495239A: ??? (in /usr/lib64/libglib-2.0.so.0.7000.4)
   by 0x495605E: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.7000.4)
   by 0x49AB2A7: ??? (in /usr/lib64/libglib-2.0.so.0.7000.4)


  Commit: 62e591578e3f948e187aacf44ede4286fad37ad7
      https://github.com/bluez/bluez/commit/62e591578e3f948e187aacf44ede4286fad37ad7
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-03-28 (Mon, 28 Mar 2022)

  Changed paths:
    M profiles/audio/a2dp.c

  Log Message:
  -----------
  a2dp: Always invalidate the cache if its configuration fails

When a configuration had been restored from last_used cache but it
fails invalidate it so another sep can be used.

Fixes: https://github.com/bluez/bluez/issues/313


  Commit: 6cb6e2ddf4471da365fe89ecd3c62454c9acf510
      https://github.com/bluez/bluez/commit/6cb6e2ddf4471da365fe89ecd3c62454c9acf510
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-03-28 (Mon, 28 Mar 2022)

  Changed paths:
    M src/shared/mgmt.c
    M src/shared/mgmt.h

  Log Message:
  -----------
  mgmt: Remove mgmt_set_verbose

The likes of btmon already decode the commands/events so there is no
need to have the code hexdump their contents.


Compare: https://github.com/bluez/bluez/compare/42e99371584c...6cb6e2ddf447
