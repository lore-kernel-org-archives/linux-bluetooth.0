Return-Path: <SRS0=5m6h=C6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5961C4346E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Sep 2020 19:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 505E9216C4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Sep 2020 19:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbgIUT1B (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Sep 2020 15:27:01 -0400
Received: from mga05.intel.com ([192.55.52.43]:10394 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbgIUT1A (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Sep 2020 15:27:00 -0400
IronPort-SDR: FD2+p1G00gpwIusJG5PPEc2hADwrfJynpHXa5gM7sCo8iYgTiSeS6/6uLO/g08yASqnpLyozyS
 6WBvTW5+AKpw==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="245301712"
X-IronPort-AV: E=Sophos;i="5.77,287,1596524400"; 
   d="scan'208";a="245301712"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2020 12:26:56 -0700
IronPort-SDR: TLu7aZwbsQE/BBX3FyJPyaTYc9xNNtHDfMVdF3ynX4l/es1vxP7v/JdcMkopUMrPZ+ydVc+pCz
 TuRnrzNmuHsg==
X-IronPort-AV: E=Sophos;i="5.77,287,1596524400"; 
   d="scan'208";a="454192530"
Received: from han1-mobl3.jf.intel.com ([10.254.86.223])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2020 12:26:55 -0700
From:   tedd.an@linux.intel.com
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [BlueZ V4 RESEND 00/20] Add SPDX License Identifier
Date:   Mon, 21 Sep 2020 12:26:39 -0700
Message-Id: <20200921190040.45309-1-tedd.an@linux.intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This series adds SPDX License Identifer to the relavant files and
creates LICENSES folder with full text of licenses used by the BlueZ
tree. The following files were updated with SPDX License Identifier:
   - Source and header files (.c/.h)
   - Build files (Makefile.*)
   - Test scripts (python, bash, and etc)

The SDPX License Identifier is added in form of a comment based on file
type with the same rule from the Linxu kernel source, and added to the
first line of the file or the second line after '#!PATH_TO_INTERPRETER'.

   C source: // SPDX-License-Identifer: <License id>
   C header: /* SPDX-License-Identifer: <License id> */
   scripts: # SPDX-License-Identifier: <License id>

For SPDX-License Identifier, it used the identifer from the SPDX License
list page(https://spdx.org/licenses).

For the summary, currently BlueZ sources have following licenses:

-------------------------------------------
      License              File Count
-------------------------------------------
 GPL-2.0-or-later      :     403
 LGPL-2.1-or-later     :     308
 BSD-2-Clause          :       3
 GPL-2.0-only          :       5
 MIT                   :       2
 Apache-2.0            :      80

Note that these folder/files were ignored:
 - .git/
 - document files
 - configuration files

Tedd Ho-Jeong An (20):
  android: Add SPDX License Identifier
  attrib: Add SPDX License Identifier
  btio: Add SPDX License Identifier
  client: Add SPDX License Identifier
  emulator: Add SPDX License Identifier
  gdbus: Add SPDX License Identifier
  gobex: Add SPDX License Identifier
  lib: Add SPDX License Identifier
  mesh: Add SPDX License Identifier
  monitor: Add SPDX License Identifier
  obexd: Add SPDX License Identifier
  peripheral: Add SPDX License Identifier
  plugins: Add SPDX License Identifier
  profiles: Add SPDX License Identifier
  unit: Add SPDX License Identifier
  src: Add SPDX License Identifier
  tools: Add SPDX License Identifier
  build: Add SPDX License Identifier
  test: Add SPDX License Identifier
  LICENSES: Add License files

 LICENSES/dual/Apache-2.0           | 187 +++++++++++
 LICENSES/preferred/BSD-2-Clause    |  32 ++
 LICENSES/preferred/GPL-2.0         | 354 ++++++++++++++++++++
 LICENSES/preferred/LGPL-2.1        | 503 +++++++++++++++++++++++++++++
 LICENSES/preferred/MIT             |  30 ++
 Makefile.am                        |   2 +-
 Makefile.mesh                      |   1 +
 Makefile.obexd                     |   1 +
 Makefile.plugins                   |   2 +-
 Makefile.tools                     |   2 +-
 android/a2dp-sink.c                |  15 +-
 android/a2dp-sink.h                |  15 +-
 android/a2dp.c                     |  15 +-
 android/a2dp.h                     |  15 +-
 android/audio-msg.h                |  15 +-
 android/audio_utils/resampler.c    |  12 +-
 android/audio_utils/resampler.h    |  12 +-
 android/avctp.c                    |  15 +-
 android/avctp.h                    |  15 +-
 android/avdtp.c                    |  15 +-
 android/avdtp.h                    |  15 +-
 android/avdtptest.c                |  15 +-
 android/avrcp-lib.c                |  15 +-
 android/avrcp-lib.h                |  15 +-
 android/avrcp.c                    |  15 +-
 android/avrcp.h                    |  15 +-
 android/bluetooth.c                |  15 +-
 android/bluetooth.h                |  15 +-
 android/bluetoothd-snoop.c         |  15 +-
 android/bluetoothd-wrapper.c       |  13 +-
 android/client/haltest.c           |  13 +-
 android/client/history.c           |  13 +-
 android/client/history.h           |  13 +-
 android/client/if-audio.c          |  13 +-
 android/client/if-av-sink.c        |  13 +-
 android/client/if-av.c             |  13 +-
 android/client/if-bt.c             |  13 +-
 android/client/if-gatt.c           |  13 +-
 android/client/if-hf-client.c      |  13 +-
 android/client/if-hf.c             |  13 +-
 android/client/if-hh.c             |  13 +-
 android/client/if-hl.c             |  13 +-
 android/client/if-main.h           |  13 +-
 android/client/if-mce.c            |  13 +-
 android/client/if-pan.c            |  13 +-
 android/client/if-rc-ctrl.c        |  13 +-
 android/client/if-rc.c             |  13 +-
 android/client/if-sco.c            |  13 +-
 android/client/if-sock.c           |  13 +-
 android/client/pollhandler.c       |  13 +-
 android/client/pollhandler.h       |  13 +-
 android/client/tabcompletion.c     |  13 +-
 android/client/terminal.c          |  13 +-
 android/client/terminal.h          |  13 +-
 android/compat/readline/history.h  |  15 +-
 android/compat/readline/readline.h |  15 +-
 android/compat/wordexp.h           |  15 +-
 android/cutils/properties.h        |  15 +-
 android/gatt.c                     |  15 +-
 android/gatt.h                     |  15 +-
 android/hal-a2dp-sink.c            |  13 +-
 android/hal-a2dp.c                 |  13 +-
 android/hal-audio-aptx.c           |  13 +-
 android/hal-audio-sbc.c            |  13 +-
 android/hal-audio.c                |  13 +-
 android/hal-audio.h                |  13 +-
 android/hal-avrcp-ctrl.c           |  13 +-
 android/hal-avrcp.c                |  13 +-
 android/hal-bluetooth.c            |  13 +-
 android/hal-gatt.c                 |  13 +-
 android/hal-handsfree-client.c     |  13 +-
 android/hal-handsfree.c            |  13 +-
 android/hal-health.c               |  13 +-
 android/hal-hidhost.c              |  13 +-
 android/hal-ipc.c                  |  13 +-
 android/hal-ipc.h                  |  13 +-
 android/hal-log.h                  |  13 +-
 android/hal-map-client.c           |  13 +-
 android/hal-msg.h                  |  15 +-
 android/hal-pan.c                  |  13 +-
 android/hal-sco.c                  |  13 +-
 android/hal-socket.c               |  13 +-
 android/hal-utils.c                |  13 +-
 android/hal-utils.h                |  13 +-
 android/hal.h                      |  13 +-
 android/handsfree-client.c         |  15 +-
 android/handsfree-client.h         |  15 +-
 android/handsfree.c                |  15 +-
 android/handsfree.h                |  15 +-
 android/hardware/audio.h           |  12 +-
 android/hardware/audio_effect.h    |  12 +-
 android/hardware/bluetooth.h       |  12 +-
 android/hardware/bt_av.h           |  12 +-
 android/hardware/bt_gatt.h         |  12 +-
 android/hardware/bt_gatt_client.h  |  12 +-
 android/hardware/bt_gatt_server.h  |  12 +-
 android/hardware/bt_gatt_types.h   |  12 +-
 android/hardware/bt_hf.h           |  12 +-
 android/hardware/bt_hf_client.h    |  12 +-
 android/hardware/bt_hh.h           |  12 +-
 android/hardware/bt_hl.h           |  12 +-
 android/hardware/bt_mce.h          |  12 +-
 android/hardware/bt_pan.h          |  12 +-
 android/hardware/bt_rc.h           |  12 +-
 android/hardware/bt_sock.h         |  12 +-
 android/hardware/hardware.c        |  12 +-
 android/hardware/hardware.h        |  12 +-
 android/health.c                   |  15 +-
 android/health.h                   |  15 +-
 android/hidhost.c                  |  15 +-
 android/hidhost.h                  |  15 +-
 android/ipc-common.h               |  15 +-
 android/ipc-tester.c               |  15 +-
 android/ipc.c                      |  15 +-
 android/ipc.h                      |  15 +-
 android/log.c                      |  15 +-
 android/main.c                     |  15 +-
 android/map-client.c               |  15 +-
 android/map-client.h               |  15 +-
 android/pan.c                      |  15 +-
 android/pan.h                      |  15 +-
 android/sco-msg.h                  |  15 +-
 android/sco.c                      |  15 +-
 android/sco.h                      |  15 +-
 android/socket.c                   |  15 +-
 android/socket.h                   |  15 +-
 android/system-emulator.c          |  15 +-
 android/system/audio.h             |  12 +-
 android/test-ipc.c                 |  15 +-
 android/tester-a2dp.c              |  13 +-
 android/tester-avrcp.c             |  13 +-
 android/tester-bluetooth.c         |  13 +-
 android/tester-gatt.c              |  13 +-
 android/tester-hdp.c               |  13 +-
 android/tester-hidhost.c           |  13 +-
 android/tester-main.c              |  13 +-
 android/tester-main.h              |  15 +-
 android/tester-map-client.c        |  13 +-
 android/tester-pan.c               |  13 +-
 android/tester-socket.c            |  13 +-
 android/utils.h                    |  15 +-
 attrib/att-database.h              |  15 +-
 attrib/att.c                       |  15 +-
 attrib/att.h                       |  15 +-
 attrib/gatt-service.c              |  15 +-
 attrib/gatt-service.h              |  15 +-
 attrib/gatt.c                      |  15 +-
 attrib/gatt.h                      |  15 +-
 attrib/gattrib.c                   |  15 +-
 attrib/gattrib.h                   |  15 +-
 attrib/gatttool.c                  |  15 +-
 attrib/gatttool.h                  |  15 +-
 attrib/interactive.c               |  15 +-
 attrib/utils.c                     |  15 +-
 btio/btio.c                        |  15 +-
 btio/btio.h                        |  15 +-
 client/adv_monitor.c               |  11 +-
 client/adv_monitor.h               |  11 +-
 client/advertising.c               |  15 +-
 client/advertising.h               |  15 +-
 client/agent.c                     |  15 +-
 client/agent.h                     |  15 +-
 client/display.c                   |  15 +-
 client/display.h                   |  15 +-
 client/gatt.c                      |  15 +-
 client/gatt.h                      |  15 +-
 client/main.c                      |  15 +-
 configure.ac                       |   1 +
 emulator/amp.c                     |  15 +-
 emulator/amp.h                     |  15 +-
 emulator/b1ee.c                    |  15 +-
 emulator/btdev.c                   |  15 +-
 emulator/btdev.h                   |  15 +-
 emulator/bthost.c                  |  15 +-
 emulator/bthost.h                  |  15 +-
 emulator/hciemu.c                  |  15 +-
 emulator/hciemu.h                  |  15 +-
 emulator/hfp.c                     |  15 +-
 emulator/le.c                      |  15 +-
 emulator/le.h                      |  15 +-
 emulator/main.c                    |  15 +-
 emulator/phy.c                     |  15 +-
 emulator/phy.h                     |  15 +-
 emulator/serial.c                  |  15 +-
 emulator/serial.h                  |  15 +-
 emulator/server.c                  |  15 +-
 emulator/server.h                  |  15 +-
 emulator/smp.c                     |  15 +-
 emulator/vhci.c                    |  15 +-
 emulator/vhci.h                    |  15 +-
 gdbus/client.c                     |  15 +-
 gdbus/gdbus.h                      |  15 +-
 gdbus/mainloop.c                   |  15 +-
 gdbus/object.c                     |  15 +-
 gdbus/polkit.c                     |  15 +-
 gdbus/watch.c                      |  15 +-
 gobex/gobex-apparam.c              |  15 +-
 gobex/gobex-apparam.h              |  15 +-
 gobex/gobex-debug.h                |  15 +-
 gobex/gobex-defs.c                 |  15 +-
 gobex/gobex-defs.h                 |  15 +-
 gobex/gobex-header.c               |  15 +-
 gobex/gobex-header.h               |  15 +-
 gobex/gobex-packet.c               |  15 +-
 gobex/gobex-packet.h               |  15 +-
 gobex/gobex-transfer.c             |  15 +-
 gobex/gobex.c                      |  15 +-
 gobex/gobex.h                      |  15 +-
 lib/a2mp.h                         |  15 +-
 lib/amp.h                          |  10 +-
 lib/bluetooth.c                    |  15 +-
 lib/bluetooth.h                    |  15 +-
 lib/bnep.h                         |  15 +-
 lib/cmtp.h                         |  15 +-
 lib/hci.c                          |  15 +-
 lib/hci.h                          |  15 +-
 lib/hci_lib.h                      |  15 +-
 lib/hidp.h                         |  15 +-
 lib/l2cap.h                        |  15 +-
 lib/mgmt.h                         |  15 +-
 lib/rfcomm.h                       |  15 +-
 lib/sco.h                          |  15 +-
 lib/sdp.c                          |  15 +-
 lib/sdp.h                          |  15 +-
 lib/sdp_lib.h                      |  15 +-
 lib/uuid.c                         |  15 +-
 lib/uuid.h                         |  15 +-
 mesh/agent.c                       |  11 +-
 mesh/agent.h                       |  11 +-
 mesh/appkey.c                      |  11 +-
 mesh/appkey.h                      |  11 +-
 mesh/cfgmod-server.c               |  11 +-
 mesh/cfgmod.h                      |  11 +-
 mesh/crypto.c                      |  11 +-
 mesh/crypto.h                      |  11 +-
 mesh/dbus.c                        |  11 +-
 mesh/dbus.h                        |  11 +-
 mesh/error.h                       |  11 +-
 mesh/friend.c                      |  11 +-
 mesh/friend.h                      |  11 +-
 mesh/keyring.c                     |  11 +-
 mesh/keyring.h                     |  11 +-
 mesh/main.c                        |  11 +-
 mesh/manager.c                     |  11 +-
 mesh/manager.h                     |  11 +-
 mesh/mesh-config-json.c            |  11 +-
 mesh/mesh-config.h                 |  11 +-
 mesh/mesh-defs.h                   |  12 +-
 mesh/mesh-io-api.h                 |  11 +-
 mesh/mesh-io-generic.c             |  11 +-
 mesh/mesh-io-generic.h             |  11 +-
 mesh/mesh-io.c                     |  11 +-
 mesh/mesh-io.h                     |  11 +-
 mesh/mesh-mgmt.c                   |  11 +-
 mesh/mesh-mgmt.h                   |  11 +-
 mesh/mesh.c                        |  11 +-
 mesh/mesh.h                        |  11 +-
 mesh/model.c                       |  11 +-
 mesh/model.h                       |  11 +-
 mesh/net-keys.c                    |  11 +-
 mesh/net-keys.h                    |  11 +-
 mesh/net.c                         |  11 +-
 mesh/net.h                         |  11 +-
 mesh/node.c                        |  11 +-
 mesh/node.h                        |  11 +-
 mesh/pb-adv.c                      |  11 +-
 mesh/pb-adv.h                      |  11 +-
 mesh/prov-acceptor.c               |  11 +-
 mesh/prov-initiator.c              |  11 +-
 mesh/prov.h                        |  11 +-
 mesh/provision.h                   |  11 +-
 mesh/rpl.c                         |  11 +-
 mesh/rpl.h                         |  11 +-
 mesh/util.c                        |  11 +-
 mesh/util.h                        |  11 +-
 monitor/a2dp.c                     |  15 +-
 monitor/a2dp.h                     |  15 +-
 monitor/analyze.c                  |  15 +-
 monitor/analyze.h                  |  15 +-
 monitor/avctp.c                    |  15 +-
 monitor/avctp.h                    |  15 +-
 monitor/avdtp.c                    |  15 +-
 monitor/avdtp.h                    |  15 +-
 monitor/bnep.c                     |  15 +-
 monitor/bnep.h                     |  15 +-
 monitor/broadcom.c                 |  15 +-
 monitor/broadcom.h                 |  15 +-
 monitor/bt.h                       |  15 +-
 monitor/control.c                  |  15 +-
 monitor/control.h                  |  15 +-
 monitor/crc.c                      |  15 +-
 monitor/crc.h                      |  15 +-
 monitor/display.c                  |  15 +-
 monitor/display.h                  |  15 +-
 monitor/ellisys.c                  |  15 +-
 monitor/ellisys.h                  |  15 +-
 monitor/hcidump.c                  |  15 +-
 monitor/hcidump.h                  |  15 +-
 monitor/hwdb.c                     |  15 +-
 monitor/hwdb.h                     |  15 +-
 monitor/intel.c                    |  15 +-
 monitor/intel.h                    |  15 +-
 monitor/jlink.c                    |  15 +-
 monitor/jlink.h                    |  15 +-
 monitor/keys.c                     |  15 +-
 monitor/keys.h                     |  15 +-
 monitor/l2cap.c                    |  15 +-
 monitor/l2cap.h                    |  15 +-
 monitor/ll.c                       |  15 +-
 monitor/ll.h                       |  15 +-
 monitor/lmp.c                      |  15 +-
 monitor/lmp.h                      |  15 +-
 monitor/main.c                     |  15 +-
 monitor/packet.c                   |  15 +-
 monitor/packet.h                   |  15 +-
 monitor/rfcomm.c                   |  15 +-
 monitor/rfcomm.h                   |  15 +-
 monitor/sdp.c                      |  15 +-
 monitor/sdp.h                      |  15 +-
 monitor/tty.h                      |  15 +-
 monitor/vendor.c                   |  15 +-
 monitor/vendor.h                   |  15 +-
 obexd/client/bluetooth.c           |  15 +-
 obexd/client/bluetooth.h           |  15 +-
 obexd/client/driver.c              |  15 +-
 obexd/client/driver.h              |  15 +-
 obexd/client/ftp.c                 |  15 +-
 obexd/client/ftp.h                 |  15 +-
 obexd/client/manager.c             |  15 +-
 obexd/client/manager.h             |  15 +-
 obexd/client/map-event.c           |  15 +-
 obexd/client/map-event.h           |  15 +-
 obexd/client/map.c                 |  15 +-
 obexd/client/map.h                 |  15 +-
 obexd/client/mns.c                 |  15 +-
 obexd/client/opp.c                 |  15 +-
 obexd/client/opp.h                 |  15 +-
 obexd/client/pbap.c                |  15 +-
 obexd/client/pbap.h                |  15 +-
 obexd/client/session.c             |  15 +-
 obexd/client/session.h             |  15 +-
 obexd/client/sync.c                |  15 +-
 obexd/client/sync.h                |  15 +-
 obexd/client/transfer.c            |  15 +-
 obexd/client/transfer.h            |  15 +-
 obexd/client/transport.c           |  15 +-
 obexd/client/transport.h           |  15 +-
 obexd/plugins/bluetooth.c          |  15 +-
 obexd/plugins/filesystem.c         |  15 +-
 obexd/plugins/filesystem.h         |  15 +-
 obexd/plugins/ftp.c                |  15 +-
 obexd/plugins/ftp.h                |  15 +-
 obexd/plugins/irmc.c               |  15 +-
 obexd/plugins/mas.c                |  15 +-
 obexd/plugins/messages-dummy.c     |  15 +-
 obexd/plugins/messages-tracker.c   |  15 +-
 obexd/plugins/messages.h           |  15 +-
 obexd/plugins/opp.c                |  15 +-
 obexd/plugins/pbap.c               |  15 +-
 obexd/plugins/pcsuite.c            |  15 +-
 obexd/plugins/phonebook-dummy.c    |  15 +-
 obexd/plugins/phonebook-ebook.c    |  15 +-
 obexd/plugins/phonebook-tracker.c  |  15 +-
 obexd/plugins/phonebook.h          |  15 +-
 obexd/plugins/syncevolution.c      |  15 +-
 obexd/plugins/vcard.c              |  15 +-
 obexd/plugins/vcard.h              |  15 +-
 obexd/src/log.c                    |  15 +-
 obexd/src/log.h                    |  15 +-
 obexd/src/main.c                   |  15 +-
 obexd/src/manager.c                |  15 +-
 obexd/src/manager.h                |  15 +-
 obexd/src/map_ap.h                 |  15 +-
 obexd/src/mimetype.c               |  15 +-
 obexd/src/mimetype.h               |  15 +-
 obexd/src/obex-priv.h              |  15 +-
 obexd/src/obex.c                   |  15 +-
 obexd/src/obex.h                   |  15 +-
 obexd/src/obexd.h                  |  15 +-
 obexd/src/plugin.c                 |  15 +-
 obexd/src/plugin.h                 |  15 +-
 obexd/src/server.c                 |  15 +-
 obexd/src/server.h                 |  15 +-
 obexd/src/service.c                |  15 +-
 obexd/src/service.h                |  15 +-
 obexd/src/transport.c              |  15 +-
 obexd/src/transport.h              |  15 +-
 peripheral/attach.c                |  15 +-
 peripheral/attach.h                |  15 +-
 peripheral/efivars.c               |  15 +-
 peripheral/efivars.h               |  15 +-
 peripheral/gap.c                   |  15 +-
 peripheral/gap.h                   |  15 +-
 peripheral/gatt.c                  |  15 +-
 peripheral/gatt.h                  |  15 +-
 peripheral/log.c                   |  15 +-
 peripheral/log.h                   |  15 +-
 peripheral/main.c                  |  15 +-
 plugins/autopair.c                 |  15 +-
 plugins/external-dummy.c           |  15 +-
 plugins/hostname.c                 |  15 +-
 plugins/neard.c                    |  15 +-
 plugins/policy.c                   |  15 +-
 plugins/sixaxis.c                  |  15 +-
 plugins/wiimote.c                  |  15 +-
 profiles/audio/a2dp-codecs.h       |  15 +-
 profiles/audio/a2dp.c              |  15 +-
 profiles/audio/a2dp.h              |  15 +-
 profiles/audio/avctp.c             |  15 +-
 profiles/audio/avctp.h             |  15 +-
 profiles/audio/avdtp.c             |  15 +-
 profiles/audio/avdtp.h             |  15 +-
 profiles/audio/avrcp.c             |  15 +-
 profiles/audio/avrcp.h             |  15 +-
 profiles/audio/control.c           |  15 +-
 profiles/audio/control.h           |  15 +-
 profiles/audio/media.c             |  15 +-
 profiles/audio/media.h             |  15 +-
 profiles/audio/player.c            |  15 +-
 profiles/audio/player.h            |  15 +-
 profiles/audio/sink.c              |  15 +-
 profiles/audio/sink.h              |  15 +-
 profiles/audio/source.c            |  15 +-
 profiles/audio/source.h            |  15 +-
 profiles/audio/transport.c         |  15 +-
 profiles/audio/transport.h         |  15 +-
 profiles/battery/bas.c             |  15 +-
 profiles/battery/bas.h             |  15 +-
 profiles/battery/battery.c         |  10 +-
 profiles/cups/cups.h               |  15 +-
 profiles/cups/hcrp.c               |  15 +-
 profiles/cups/main.c               |  15 +-
 profiles/cups/sdp.c                |  15 +-
 profiles/cups/spp.c                |  15 +-
 profiles/deviceinfo/deviceinfo.c   |  15 +-
 profiles/deviceinfo/dis.c          |  15 +-
 profiles/deviceinfo/dis.h          |  15 +-
 profiles/gap/gas.c                 |  10 +-
 profiles/health/hdp.c              |  15 +-
 profiles/health/hdp.h              |  15 +-
 profiles/health/hdp_main.c         |  15 +-
 profiles/health/hdp_manager.c      |  15 +-
 profiles/health/hdp_manager.h      |  15 +-
 profiles/health/hdp_types.h        |  15 +-
 profiles/health/hdp_util.c         |  15 +-
 profiles/health/hdp_util.h         |  15 +-
 profiles/health/mcap.c             |  15 +-
 profiles/health/mcap.h             |  15 +-
 profiles/iap/main.c                |  15 +-
 profiles/input/device.c            |  15 +-
 profiles/input/device.h            |  15 +-
 profiles/input/hidp_defs.h         |  15 +-
 profiles/input/hog-lib.c           |  15 +-
 profiles/input/hog-lib.h           |  15 +-
 profiles/input/hog.c               |  15 +-
 profiles/input/manager.c           |  15 +-
 profiles/input/server.c            |  15 +-
 profiles/input/server.h            |  15 +-
 profiles/input/sixaxis.h           |  15 +-
 profiles/input/suspend-dummy.c     |  15 +-
 profiles/input/suspend-none.c      |  15 +-
 profiles/input/suspend.h           |  15 +-
 profiles/midi/libmidi.c            |  16 +-
 profiles/midi/libmidi.h            |  16 +-
 profiles/midi/midi.c               |  20 +-
 profiles/network/bnep.c            |  15 +-
 profiles/network/bnep.h            |  15 +-
 profiles/network/connection.c      |  15 +-
 profiles/network/connection.h      |  15 +-
 profiles/network/manager.c         |  15 +-
 profiles/network/server.c          |  15 +-
 profiles/network/server.h          |  15 +-
 profiles/sap/main.c                |  14 +-
 profiles/sap/manager.c             |  14 +-
 profiles/sap/manager.h             |  14 +-
 profiles/sap/sap-dummy.c           |  14 +-
 profiles/sap/sap.h                 |  14 +-
 profiles/sap/server.c              |  14 +-
 profiles/sap/server.h              |  14 +-
 profiles/scanparam/scan.c          |  15 +-
 profiles/scanparam/scpp.c          |  15 +-
 profiles/scanparam/scpp.h          |  15 +-
 src/adapter.c                      |  15 +-
 src/adapter.h                      |  15 +-
 src/adv_monitor.c                  |  11 +-
 src/adv_monitor.h                  |  11 +-
 src/advertising.c                  |  11 +-
 src/advertising.h                  |  11 +-
 src/agent.c                        |  15 +-
 src/agent.h                        |  15 +-
 src/attrib-server.c                |  15 +-
 src/attrib-server.h                |  15 +-
 src/backtrace.c                    |  15 +-
 src/backtrace.h                    |  15 +-
 src/dbus-common.c                  |  15 +-
 src/dbus-common.h                  |  15 +-
 src/device.c                       |  15 +-
 src/device.h                       |  15 +-
 src/eir.c                          |  15 +-
 src/eir.h                          |  15 +-
 src/error.c                        |  15 +-
 src/error.h                        |  15 +-
 src/gatt-client.c                  |  11 +-
 src/gatt-client.h                  |  11 +-
 src/gatt-database.c                |  11 +-
 src/gatt-database.h                |  11 +-
 src/hcid.h                         |  15 +-
 src/log.c                          |  15 +-
 src/log.h                          |  15 +-
 src/main.c                         |  15 +-
 src/oui.c                          |  15 +-
 src/oui.h                          |  15 +-
 src/plugin.c                       |  15 +-
 src/plugin.h                       |  15 +-
 src/profile.c                      |  15 +-
 src/profile.h                      |  15 +-
 src/rfkill.c                       |  15 +-
 src/sdp-client.c                   |  15 +-
 src/sdp-client.h                   |  15 +-
 src/sdp-xml.c                      |  15 +-
 src/sdp-xml.h                      |  15 +-
 src/sdpd-database.c                |  15 +-
 src/sdpd-request.c                 |  15 +-
 src/sdpd-server.c                  |  15 +-
 src/sdpd-service.c                 |  15 +-
 src/sdpd.h                         |  15 +-
 src/service.c                      |  15 +-
 src/service.h                      |  15 +-
 src/shared/ad.c                    |  15 +-
 src/shared/ad.h                    |  15 +-
 src/shared/att-types.h             |  15 +-
 src/shared/att.c                   |  15 +-
 src/shared/att.h                   |  15 +-
 src/shared/btp.c                   |  15 +-
 src/shared/btp.h                   |  15 +-
 src/shared/btsnoop.c               |  15 +-
 src/shared/btsnoop.h               |  15 +-
 src/shared/crypto.c                |  15 +-
 src/shared/crypto.h                |  15 +-
 src/shared/ecc.c                   |  21 +-
 src/shared/ecc.h                   |  21 +-
 src/shared/gap.c                   |  15 +-
 src/shared/gap.h                   |  15 +-
 src/shared/gatt-client.c           |  15 +-
 src/shared/gatt-client.h           |  15 +-
 src/shared/gatt-db.c               |  15 +-
 src/shared/gatt-db.h               |  15 +-
 src/shared/gatt-helpers.c          |  15 +-
 src/shared/gatt-helpers.h          |  15 +-
 src/shared/gatt-server.c           |  15 +-
 src/shared/gatt-server.h           |  15 +-
 src/shared/hci-crypto.c            |  15 +-
 src/shared/hci-crypto.h            |  15 +-
 src/shared/hci.c                   |  15 +-
 src/shared/hci.h                   |  15 +-
 src/shared/hfp.c                   |  15 +-
 src/shared/hfp.h                   |  15 +-
 src/shared/io-ell.c                |  15 +-
 src/shared/io-glib.c               |  15 +-
 src/shared/io-mainloop.c           |  15 +-
 src/shared/io.h                    |  15 +-
 src/shared/log.c                   |  15 +-
 src/shared/log.h                   |  15 +-
 src/shared/mainloop-ell.c          |  12 +-
 src/shared/mainloop-glib.c         |  15 +-
 src/shared/mainloop-notify.c       |  15 +-
 src/shared/mainloop-notify.h       |  15 +-
 src/shared/mainloop.c              |  15 +-
 src/shared/mainloop.h              |  15 +-
 src/shared/mgmt.c                  |  15 +-
 src/shared/mgmt.h                  |  15 +-
 src/shared/pcap.c                  |  15 +-
 src/shared/pcap.h                  |  15 +-
 src/shared/queue.c                 |  15 +-
 src/shared/queue.h                 |  15 +-
 src/shared/ringbuf.c               |  15 +-
 src/shared/ringbuf.h               |  15 +-
 src/shared/shell.c                 |  15 +-
 src/shared/shell.h                 |  15 +-
 src/shared/tester.c                |  15 +-
 src/shared/tester.h                |  15 +-
 src/shared/timeout-ell.c           |  11 +-
 src/shared/timeout-glib.c          |  11 +-
 src/shared/timeout-mainloop.c      |  11 +-
 src/shared/timeout.h               |  11 +-
 src/shared/tty.h                   |  15 +-
 src/shared/uhid.c                  |  15 +-
 src/shared/uhid.h                  |  15 +-
 src/shared/util.c                  |  15 +-
 src/shared/util.h                  |  15 +-
 src/storage.c                      |  15 +-
 src/storage.h                      |  15 +-
 src/textfile.c                     |  15 +-
 src/textfile.h                     |  15 +-
 src/uinput.h                       |  15 +-
 src/uuid-helper.c                  |  15 +-
 src/uuid-helper.h                  |  15 +-
 test/agent.py                      |   1 +
 test/bluezutils.py                 |   2 +
 test/dbusdef.py                    |   2 +
 test/example-advertisement         |   1 +
 test/example-endpoint              |   1 +
 test/example-gatt-client           |   1 +
 test/example-gatt-server           |   1 +
 test/example-player                |   1 +
 test/exchange-business-cards       |   1 +
 test/ftp-client                    |   1 +
 test/get-managed-objects           |   1 +
 test/get-obex-capabilities         |   1 +
 test/list-devices                  |   1 +
 test/list-folders                  |   1 +
 test/map-client                    |   1 +
 test/monitor-bluetooth             |   1 +
 test/opp-client                    |   1 +
 test/pbap-client                   |   1 +
 test/sap_client.py                 |  15 +-
 test/simple-agent                  |   1 +
 test/simple-endpoint               |   1 +
 test/simple-obex-agent             |   1 +
 test/simple-player                 |   1 +
 test/test-adapter                  |   1 +
 test/test-device                   |   1 +
 test/test-discovery                |   1 +
 test/test-gatt-profile             |   1 +
 test/test-health                   |   1 +
 test/test-health-sink              |   1 +
 test/test-hfp                      |   1 +
 test/test-join                     |   1 +
 test/test-manager                  |   1 +
 test/test-mesh                     |   1 +
 test/test-nap                      |   1 +
 test/test-network                  |   1 +
 test/test-profile                  |   1 +
 test/test-sap-server               |   1 +
 tools/3dsp.c                       |  15 +-
 tools/advtest.c                    |  15 +-
 tools/amptest.c                    |  15 +-
 tools/avinfo.c                     |  15 +-
 tools/avtest.c                     |  15 +-
 tools/bccmd.c                      |  15 +-
 tools/bcmfw.c                      |  15 +-
 tools/bdaddr.c                     |  15 +-
 tools/bluemoon.c                   |  15 +-
 tools/bluetooth-player.c           |  15 +-
 tools/bnep-tester.c                |  15 +-
 tools/bneptest.c                   |  15 +-
 tools/btattach.c                   |  15 +-
 tools/btconfig.c                   |  15 +-
 tools/btgatt-client.c              |  15 +-
 tools/btgatt-server.c              |  11 +-
 tools/btinfo.c                     |  15 +-
 tools/btiotest.c                   |  15 +-
 tools/btmgmt.c                     |  15 +-
 tools/btmon-logger.c               |  15 +-
 tools/btpclient.c                  |  15 +-
 tools/btpclientctl.c               |  15 +-
 tools/btproxy.c                    |  15 +-
 tools/btsnoop.c                    |  15 +-
 tools/check-selftest.c             |  15 +-
 tools/ciptool.c                    |  15 +-
 tools/cltest.c                     |  15 +-
 tools/create-image.c               |  15 +-
 tools/csr.c                        |  15 +-
 tools/csr.h                        |  15 +-
 tools/csr_3wire.c                  |  15 +-
 tools/csr_bcsp.c                   |  15 +-
 tools/csr_h4.c                     |  15 +-
 tools/csr_hci.c                    |  15 +-
 tools/csr_usb.c                    |  15 +-
 tools/eddystone.c                  |  15 +-
 tools/gap-tester.c                 |  15 +-
 tools/gatt-service.c               |  15 +-
 tools/hci-tester.c                 |  15 +-
 tools/hciattach.c                  |  15 +-
 tools/hciattach.h                  |  15 +-
 tools/hciattach_ath3k.c            |  15 +-
 tools/hciattach_bcm43xx.c          |  15 +-
 tools/hciattach_intel.c            |  15 +-
 tools/hciattach_qualcomm.c         |  15 +-
 tools/hciattach_st.c               |  15 +-
 tools/hciattach_ti.c               |  15 +-
 tools/hciattach_tialt.c            |  15 +-
 tools/hciconfig.c                  |  15 +-
 tools/hcidump.c                    |  15 +-
 tools/hcieventmask.c               |  15 +-
 tools/hcisecfilter.c               |  15 +-
 tools/hcitool.c                    |  15 +-
 tools/hex2hcd.c                    |  15 +-
 tools/hid2hci.c                    |  15 +-
 tools/hwdb.c                       |  15 +-
 tools/ibeacon.c                    |  15 +-
 tools/l2cap-tester.c               |  15 +-
 tools/l2ping.c                     |  15 +-
 tools/l2test.c                     |  15 +-
 tools/mcaptest.c                   |  15 +-
 tools/mesh-cfgclient.c             |  11 +-
 tools/mesh-gatt/config-client.c    |  15 +-
 tools/mesh-gatt/config-server.c    |  15 +-
 tools/mesh-gatt/crypto.c           |  15 +-
 tools/mesh-gatt/crypto.h           |  15 +-
 tools/mesh-gatt/gatt.c             |  15 +-
 tools/mesh-gatt/gatt.h             |  15 +-
 tools/mesh-gatt/keys.h             |  15 +-
 tools/mesh-gatt/mesh-net.h         |  15 +-
 tools/mesh-gatt/net.c              |  15 +-
 tools/mesh-gatt/net.h              |  15 +-
 tools/mesh-gatt/node.c             |  15 +-
 tools/mesh-gatt/node.h             |  15 +-
 tools/mesh-gatt/onoff-model.c      |  15 +-
 tools/mesh-gatt/onoff-model.h      |  15 +-
 tools/mesh-gatt/prov-db.c          |  15 +-
 tools/mesh-gatt/prov-db.h          |  15 +-
 tools/mesh-gatt/prov.c             |  15 +-
 tools/mesh-gatt/prov.h             |  15 +-
 tools/mesh-gatt/util.c             |  15 +-
 tools/mesh-gatt/util.h             |  15 +-
 tools/mesh/agent.c                 |  15 +-
 tools/mesh/agent.h                 |  15 +-
 tools/mesh/cfgcli.c                |  12 +-
 tools/mesh/cfgcli.h                |  12 +-
 tools/mesh/config-model.h          |  15 +-
 tools/mesh/keys.c                  |  12 +-
 tools/mesh/keys.h                  |  12 +-
 tools/mesh/mesh-db.c               |  11 +-
 tools/mesh/mesh-db.h               |  11 +-
 tools/mesh/model.h                 |  12 +-
 tools/mesh/remote.c                |  11 +-
 tools/mesh/remote.h                |  11 +-
 tools/mesh/util.c                  |  11 +-
 tools/mesh/util.h                  |  11 +-
 tools/meshctl.c                    |  15 +-
 tools/mgmt-tester.c                |  15 +-
 tools/mpris-proxy.c                |  15 +-
 tools/nokfw.c                      |  15 +-
 tools/obex-client-tool.c           |  14 +-
 tools/obex-server-tool.c           |  14 +-
 tools/obexctl.c                    |  15 +-
 tools/oobtest.c                    |  15 +-
 tools/parse_companies.pl           |   2 +-
 tools/parser/amp.c                 |  15 +-
 tools/parser/att.c                 |  15 +-
 tools/parser/avctp.c               |  15 +-
 tools/parser/avdtp.c               |  15 +-
 tools/parser/avrcp.c               |  15 +-
 tools/parser/bnep.c                |  15 +-
 tools/parser/bpa.c                 |  15 +-
 tools/parser/capi.c                |  15 +-
 tools/parser/cmtp.c                |  15 +-
 tools/parser/csr.c                 |  15 +-
 tools/parser/ericsson.c            |  15 +-
 tools/parser/hci.c                 |  15 +-
 tools/parser/hcrp.c                |  15 +-
 tools/parser/hidp.c                |  15 +-
 tools/parser/l2cap.c               |  15 +-
 tools/parser/l2cap.h               |  15 +-
 tools/parser/lmp.c                 |  15 +-
 tools/parser/obex.c                |  15 +-
 tools/parser/parser.c              |  15 +-
 tools/parser/parser.h              |  15 +-
 tools/parser/ppp.c                 |  15 +-
 tools/parser/rfcomm.c              |  15 +-
 tools/parser/rfcomm.h              |  15 +-
 tools/parser/sap.c                 |  15 +-
 tools/parser/sdp.c                 |  15 +-
 tools/parser/sdp.h                 |  15 +-
 tools/parser/smp.c                 |  15 +-
 tools/parser/tcpip.c               |  15 +-
 tools/rctest.c                     |  15 +-
 tools/rfcomm-tester.c              |  15 +-
 tools/rfcomm.c                     |  15 +-
 tools/rtlfw.c                      |  15 +-
 tools/sco-tester.c                 |  15 +-
 tools/scotest.c                    |  15 +-
 tools/sdptool.c                    |  15 +-
 tools/seq2bseq.c                   |  15 +-
 tools/smp-tester.c                 |  15 +-
 tools/test-runner.c                |  15 +-
 tools/ubcsp.c                      |  20 +-
 tools/ubcsp.h                      |  20 +-
 tools/update_compids.sh            |   1 +
 tools/userchan-tester.c            |  15 +-
 unit/test-avctp.c                  |  15 +-
 unit/test-avdtp.c                  |  15 +-
 unit/test-avrcp.c                  |  15 +-
 unit/test-crc.c                    |  15 +-
 unit/test-crypto.c                 |  15 +-
 unit/test-ecc.c                    |  21 +-
 unit/test-eir.c                    |  15 +-
 unit/test-gatt.c                   |  15 +-
 unit/test-gattrib.c                |  15 +-
 unit/test-gdbus-client.c           |  15 +-
 unit/test-gobex-apparam.c          |  15 +-
 unit/test-gobex-header.c           |  15 +-
 unit/test-gobex-packet.c           |  15 +-
 unit/test-gobex-transfer.c         |  15 +-
 unit/test-gobex.c                  |  15 +-
 unit/test-hfp.c                    |  15 +-
 unit/test-hog.c                    |  15 +-
 unit/test-lib.c                    |  15 +-
 unit/test-mesh-crypto.c            |  11 +-
 unit/test-mgmt.c                   |  15 +-
 unit/test-midi.c                   |  16 +-
 unit/test-queue.c                  |  15 +-
 unit/test-ringbuf.c                |  15 +-
 unit/test-sdp.c                    |  15 +-
 unit/test-textfile.c               |  15 +-
 unit/test-uhid.c                   |  15 +-
 unit/test-uuid.c                   |  15 +-
 unit/util.c                        |  14 +-
 unit/util.h                        |  14 +-
 810 files changed, 1913 insertions(+), 10186 deletions(-)
 create mode 100644 LICENSES/dual/Apache-2.0
 create mode 100644 LICENSES/preferred/BSD-2-Clause
 create mode 100644 LICENSES/preferred/GPL-2.0
 create mode 100644 LICENSES/preferred/LGPL-2.1
 create mode 100644 LICENSES/preferred/MIT

-- 
2.25.4

