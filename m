Return-Path: <SRS0=5m6h=C6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB09DC4363C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Sep 2020 19:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E30A2223E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Sep 2020 19:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgIUTiX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Sep 2020 15:38:23 -0400
Received: from mga07.intel.com ([134.134.136.100]:24989 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726471AbgIUTiW (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Sep 2020 15:38:22 -0400
IronPort-SDR: REE8uOCoeTEfYthlGto3MyooTezWA+O7pckm2+kppdybE6t3P0rIdb2mlzvpOqRp/AOPsnnABa
 EHg3ndF0p6Zw==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="224613218"
X-IronPort-AV: E=Sophos;i="5.77,287,1596524400"; 
   d="scan'208";a="224613218"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2020 12:38:07 -0700
IronPort-SDR: 1IBt7ZlBeSGoO0XmUJ5TPh1MgTsOOx8UsyRbcI1Iaf1XEsC/mA1mJU3bFh0Xocjer8/L40KvLt
 DBOqCZ8+zqLg==
X-IronPort-AV: E=Sophos;i="5.77,287,1596524400"; 
   d="scan'208";a="309189383"
Received: from han1-mobl3.jf.intel.com ([10.254.86.223])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2020 12:38:06 -0700
From:   tedd.an@linux.intel.com
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [BlueZ V4 RESEND 01/20] android: Add SPDX License Identifier
Date:   Mon, 21 Sep 2020 12:37:46 -0700
Message-Id: <20200921193745.47422-1-tedd.an@linux.intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200921190040.45309-1-tedd.an@linux.intel.com>
References: <20200921190040.45309-1-tedd.an@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds SPDX License Identifier and removes the license text.

-------------------------------------
       License            COUNT
-------------------------------------
 Apache-2.0           :     80
 LGPL-2.1-or-later    :     42
 GPL-2.0-or-later     :      9

License: Apache-2.0
   android/bluetoothd-wrapper.c
   android/tester-hidhost.c
   android/tester-map-client.c
   android/hal-audio-aptx.c
   android/hal-audio.c
   android/hal-handsfree-client.c
   android/tester-gatt.c
   android/hal-pan.c
   android/hal-socket.c
   android/tester-hdp.c
   android/tester-pan.c
   android/tester-avrcp.c
   android/hal-a2dp-sink.c
   android/hal-gatt.c
   android/hal-avrcp.c
   android/tester-a2dp.c
   android/hal-audio.h
   android/hal-bluetooth.c
   android/tester-socket.c
   android/hal-health.c
   android/hal-a2dp.c
   android/hal-ipc.c
   android/hal-avrcp-ctrl.c
   android/hal-sco.c
   android/hal-ipc.h
   android/tester-main.c
   android/hal-audio-sbc.c
   android/hal-utils.c
   android/hal-map-client.c
   android/hal-handsfree.c
   android/hal-log.h
   android/hal.h
   android/hal-utils.h
   android/tester-bluetooth.c
   android/hal-hidhost.c
   android/audio_utils/resampler.h
   android/audio_utils/resampler.c
   android/system/audio.h
   android/hardware/bt_sock.h
   android/hardware/bt_gatt_client.h
   android/hardware/bt_hh.h
   android/hardware/bluetooth.h
   android/hardware/hardware.h
   android/hardware/bt_hf_client.h
   android/hardware/bt_rc.h
   android/hardware/bt_hf.h
   android/hardware/bt_pan.h
   android/hardware/bt_gatt_types.h
   android/hardware/hardware.c
   android/hardware/audio_effect.h
   android/hardware/audio.h
   android/hardware/bt_gatt_server.h
   android/hardware/bt_gatt.h
   android/hardware/bt_hl.h
   android/hardware/bt_mce.h
   android/hardware/bt_av.h
   android/client/if-hh.c
   android/client/if-sco.c
   android/client/pollhandler.h
   android/client/haltest.c
   android/client/tabcompletion.c
   android/client/if-hf-client.c
   android/client/history.h
   android/client/if-audio.c
   android/client/terminal.h
   android/client/if-av.c
   android/client/if-main.h
   android/client/if-av-sink.c
   android/client/terminal.c
   android/client/if-mce.c
   android/client/if-hf.c
   android/client/pollhandler.c
   android/client/if-sock.c
   android/client/if-rc-ctrl.c
   android/client/if-rc.c
   android/client/history.c
   android/client/if-pan.c
   android/client/if-gatt.c
   android/client/if-bt.c
   android/client/if-hl.c

License: LGPL-2.1-or-later
   android/sco.h
   android/socket.c
   android/tester-main.h
   android/hidhost.h
   android/map-client.h
   android/utils.h
   android/hal-msg.h
   android/health.h
   android/avrcp-lib.c
   android/bluetoothd-snoop.c
   android/a2dp.c
   android/bluetooth.h
   android/a2dp-sink.c
   android/handsfree-client.c
   android/audio-msg.h
   android/main.c
   android/pan.c
   android/ipc-tester.c
   android/health.c
   android/socket.h
   android/handsfree.h
   android/avrcp-lib.h
   android/a2dp-sink.h
   android/system-emulator.c
   android/gatt.c
   android/avrcp.h
   android/pan.h
   android/test-ipc.c
   android/hidhost.c
   android/a2dp.h
   android/avrcp.c
   android/sco-msg.h
   android/bluetooth.c
   android/map-client.c
   android/handsfree-client.h
   android/ipc.c
   android/handsfree.c
   android/gatt.h
   android/ipc.h
   android/ipc-common.h
   android/compat/wordexp.h
   android/cutils/properties.h

License: GPL-2.0-or-later
   android/avdtp.h
   android/avctp.c
   android/avdtptest.c
   android/sco.c
   android/log.c
   android/avdtp.c
   android/avctp.h
   android/compat/readline/history.h
   android/compat/readline/readline.h
---
 android/a2dp-sink.c                | 15 +--------------
 android/a2dp-sink.h                | 15 +--------------
 android/a2dp.c                     | 15 +--------------
 android/a2dp.h                     | 15 +--------------
 android/audio-msg.h                | 15 +--------------
 android/audio_utils/resampler.c    | 12 +-----------
 android/audio_utils/resampler.h    | 12 +-----------
 android/avctp.c                    | 15 +--------------
 android/avctp.h                    | 15 +--------------
 android/avdtp.c                    | 15 +--------------
 android/avdtp.h                    | 15 +--------------
 android/avdtptest.c                | 15 +--------------
 android/avrcp-lib.c                | 15 +--------------
 android/avrcp-lib.h                | 15 +--------------
 android/avrcp.c                    | 15 +--------------
 android/avrcp.h                    | 15 +--------------
 android/bluetooth.c                | 15 +--------------
 android/bluetooth.h                | 15 +--------------
 android/bluetoothd-snoop.c         | 15 +--------------
 android/bluetoothd-wrapper.c       | 13 +------------
 android/client/haltest.c           | 13 +------------
 android/client/history.c           | 13 +------------
 android/client/history.h           | 13 +------------
 android/client/if-audio.c          | 13 +------------
 android/client/if-av-sink.c        | 13 +------------
 android/client/if-av.c             | 13 +------------
 android/client/if-bt.c             | 13 +------------
 android/client/if-gatt.c           | 13 +------------
 android/client/if-hf-client.c      | 13 +------------
 android/client/if-hf.c             | 13 +------------
 android/client/if-hh.c             | 13 +------------
 android/client/if-hl.c             | 13 +------------
 android/client/if-main.h           | 13 +------------
 android/client/if-mce.c            | 13 +------------
 android/client/if-pan.c            | 13 +------------
 android/client/if-rc-ctrl.c        | 13 +------------
 android/client/if-rc.c             | 13 +------------
 android/client/if-sco.c            | 13 +------------
 android/client/if-sock.c           | 13 +------------
 android/client/pollhandler.c       | 13 +------------
 android/client/pollhandler.h       | 13 +------------
 android/client/tabcompletion.c     | 13 +------------
 android/client/terminal.c          | 13 +------------
 android/client/terminal.h          | 13 +------------
 android/compat/readline/history.h  | 15 +--------------
 android/compat/readline/readline.h | 15 +--------------
 android/compat/wordexp.h           | 15 +--------------
 android/cutils/properties.h        | 15 +--------------
 android/gatt.c                     | 15 +--------------
 android/gatt.h                     | 15 +--------------
 android/hal-a2dp-sink.c            | 13 +------------
 android/hal-a2dp.c                 | 13 +------------
 android/hal-audio-aptx.c           | 13 +------------
 android/hal-audio-sbc.c            | 13 +------------
 android/hal-audio.c                | 13 +------------
 android/hal-audio.h                | 13 +------------
 android/hal-avrcp-ctrl.c           | 13 +------------
 android/hal-avrcp.c                | 13 +------------
 android/hal-bluetooth.c            | 13 +------------
 android/hal-gatt.c                 | 13 +------------
 android/hal-handsfree-client.c     | 13 +------------
 android/hal-handsfree.c            | 13 +------------
 android/hal-health.c               | 13 +------------
 android/hal-hidhost.c              | 13 +------------
 android/hal-ipc.c                  | 13 +------------
 android/hal-ipc.h                  | 13 +------------
 android/hal-log.h                  | 13 +------------
 android/hal-map-client.c           | 13 +------------
 android/hal-msg.h                  | 15 +--------------
 android/hal-pan.c                  | 13 +------------
 android/hal-sco.c                  | 13 +------------
 android/hal-socket.c               | 13 +------------
 android/hal-utils.c                | 13 +------------
 android/hal-utils.h                | 13 +------------
 android/hal.h                      | 13 +------------
 android/handsfree-client.c         | 15 +--------------
 android/handsfree-client.h         | 15 +--------------
 android/handsfree.c                | 15 +--------------
 android/handsfree.h                | 15 +--------------
 android/hardware/audio.h           | 12 +-----------
 android/hardware/audio_effect.h    | 12 +-----------
 android/hardware/bluetooth.h       | 12 +-----------
 android/hardware/bt_av.h           | 12 +-----------
 android/hardware/bt_gatt.h         | 12 +-----------
 android/hardware/bt_gatt_client.h  | 12 +-----------
 android/hardware/bt_gatt_server.h  | 12 +-----------
 android/hardware/bt_gatt_types.h   | 12 +-----------
 android/hardware/bt_hf.h           | 12 +-----------
 android/hardware/bt_hf_client.h    | 12 +-----------
 android/hardware/bt_hh.h           | 12 +-----------
 android/hardware/bt_hl.h           | 12 +-----------
 android/hardware/bt_mce.h          | 12 +-----------
 android/hardware/bt_pan.h          | 12 +-----------
 android/hardware/bt_rc.h           | 12 +-----------
 android/hardware/bt_sock.h         | 12 +-----------
 android/hardware/hardware.c        | 12 +-----------
 android/hardware/hardware.h        | 12 +-----------
 android/health.c                   | 15 +--------------
 android/health.h                   | 15 +--------------
 android/hidhost.c                  | 15 +--------------
 android/hidhost.h                  | 15 +--------------
 android/ipc-common.h               | 15 +--------------
 android/ipc-tester.c               | 15 +--------------
 android/ipc.c                      | 15 +--------------
 android/ipc.h                      | 15 +--------------
 android/log.c                      | 15 +--------------
 android/main.c                     | 15 +--------------
 android/map-client.c               | 15 +--------------
 android/map-client.h               | 15 +--------------
 android/pan.c                      | 15 +--------------
 android/pan.h                      | 15 +--------------
 android/sco-msg.h                  | 15 +--------------
 android/sco.c                      | 15 +--------------
 android/sco.h                      | 15 +--------------
 android/socket.c                   | 15 +--------------
 android/socket.h                   | 15 +--------------
 android/system-emulator.c          | 15 +--------------
 android/system/audio.h             | 12 +-----------
 android/test-ipc.c                 | 15 +--------------
 android/tester-a2dp.c              | 13 +------------
 android/tester-avrcp.c             | 13 +------------
 android/tester-bluetooth.c         | 13 +------------
 android/tester-gatt.c              | 13 +------------
 android/tester-hdp.c               | 13 +------------
 android/tester-hidhost.c           | 13 +------------
 android/tester-main.c              | 13 +------------
 android/tester-main.h              | 15 +--------------
 android/tester-map-client.c        | 13 +------------
 android/tester-pan.c               | 13 +------------
 android/tester-socket.c            | 13 +------------
 android/utils.h                    | 15 +--------------
 131 files changed, 131 insertions(+), 1653 deletions(-)

diff --git a/android/a2dp-sink.c b/android/a2dp-sink.c
index 7c1e1a03a..0ecb5c392 100644
--- a/android/a2dp-sink.c
+++ b/android/a2dp-sink.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2014  Intel Corporation. All rights reserved.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/android/a2dp-sink.h b/android/a2dp-sink.h
index d2c5ff423..f6da58627 100644
--- a/android/a2dp-sink.h
+++ b/android/a2dp-sink.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2014  Intel Corporation. All rights reserved.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 bool bt_a2dp_sink_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode);
diff --git a/android/a2dp.c b/android/a2dp.c
index 8bcdfd20f..e24f79348 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2013-2014  Intel Corporation. All rights reserved.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/android/a2dp.h b/android/a2dp.h
index 8a7040736..f99779657 100644
--- a/android/a2dp.h
+++ b/android/a2dp.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2013-2014  Intel Corporation. All rights reserved.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 bool bt_a2dp_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode);
diff --git a/android/audio-msg.h b/android/audio-msg.h
index 7b9553ba3..9a7f78bac 100644
--- a/android/audio-msg.h
+++ b/android/audio-msg.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2014  Intel Corporation. All rights reserved.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #define BLUEZ_AUDIO_MTU 1024
diff --git a/android/audio_utils/resampler.c b/android/audio_utils/resampler.c
index ce303750c..c55e910fb 100644
--- a/android/audio_utils/resampler.c
+++ b/android/audio_utils/resampler.c
@@ -1,17 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
 ** Copyright 2011, The Android Open-Source Project
 **
-** Licensed under the Apache License, Version 2.0 (the "License");
-** you may not use this file except in compliance with the License.
-** You may obtain a copy of the License at
-**
-**     http://www.apache.org/licenses/LICENSE-2.0
-**
-** Unless required by applicable law or agreed to in writing, software
-** distributed under the License is distributed on an "AS IS" BASIS,
-** WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-** See the License for the specific language governing permissions and
-** limitations under the License.
 */
 
 //#define LOG_NDEBUG 0
diff --git a/android/audio_utils/resampler.h b/android/audio_utils/resampler.h
index 0c7046f51..4ceb3485a 100644
--- a/android/audio_utils/resampler.h
+++ b/android/audio_utils/resampler.h
@@ -1,17 +1,7 @@
+/* SPDX-License-Identifier: Apache-2.0 */
 /*
 ** Copyright 2008, The Android Open-Source Project
 **
-** Licensed under the Apache License, Version 2.0 (the "License");
-** you may not use this file except in compliance with the License.
-** You may obtain a copy of the License at
-**
-**     http://www.apache.org/licenses/LICENSE-2.0
-**
-** Unless required by applicable law or agreed to in writing, software
-** distributed under the License is distributed on an "AS IS" BASIS,
-** WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-** See the License for the specific language governing permissions and
-** limitations under the License.
 */
 
 #ifndef ANDROID_RESAMPLER_H
diff --git a/android/avctp.c b/android/avctp.c
index 6aa64cf02..c2ea5f4a2 100644
--- a/android/avctp.c
+++ b/android/avctp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -7,20 +8,6 @@
  *  Copyright (C) 2011  Texas Instruments, Inc.
  *
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/android/avctp.h b/android/avctp.h
index f0da2b33c..e82e024f1 100644
--- a/android/avctp.h
+++ b/android/avctp.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -6,20 +7,6 @@
  *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
  *
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #define AVCTP_CONTROL_PSM		23
diff --git a/android/avdtp.c b/android/avdtp.c
index 7fb8cb731..8c2930ec1 100644
--- a/android/avdtp.c
+++ b/android/avdtp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -6,20 +7,6 @@
  *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
  *
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/android/avdtp.h b/android/avdtp.h
index 07516a87c..f45edaead 100644
--- a/android/avdtp.h
+++ b/android/avdtp.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -6,20 +7,6 @@
  *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
  *
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 struct avdtp;
diff --git a/android/avdtptest.c b/android/avdtptest.c
index 98b9ef0fa..e6668bc3c 100644
--- a/android/avdtptest.c
+++ b/android/avdtptest.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2014 Intel Corporation
  *
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 21d01955d..2007d09d2 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2014  Intel Corporation. All rights reserved.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 6554b122d..5adb32188 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2014  Intel Corporation. All rights reserved.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 /* Control PDU ids */
diff --git a/android/avrcp.c b/android/avrcp.c
index f4b138bab..fe092f02d 100644
--- a/android/avrcp.c
+++ b/android/avrcp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2013-2014  Intel Corporation. All rights reserved.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/android/avrcp.h b/android/avrcp.h
index 11e79b7d7..474413b7c 100644
--- a/android/avrcp.h
+++ b/android/avrcp.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2013-2014  Intel Corporation. All rights reserved.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 bool bt_avrcp_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode);
diff --git a/android/bluetooth.c b/android/bluetooth.c
index fb027bf34..c3ad50349 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2013-2014  Intel Corporation. All rights reserved.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/android/bluetooth.h b/android/bluetooth.h
index b139cb15f..13a3f2936 100644
--- a/android/bluetooth.h
+++ b/android/bluetooth.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2013-2014  Intel Corporation. All rights reserved.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 typedef void (*bt_bluetooth_ready)(int err, const bdaddr_t *addr);
diff --git a/android/bluetoothd-snoop.c b/android/bluetoothd-snoop.c
index 25cddee34..0321e69bc 100644
--- a/android/bluetoothd-snoop.c
+++ b/android/bluetoothd-snoop.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2013-2014  Intel Corporation. All rights reserved.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/android/bluetoothd-wrapper.c b/android/bluetoothd-wrapper.c
index 7f668daca..8929df075 100644
--- a/android/bluetoothd-wrapper.c
+++ b/android/bluetoothd-wrapper.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
  * Copyright (C) 2014 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #include <stdio.h>
diff --git a/android/client/haltest.c b/android/client/haltest.c
index e9a92a29a..cb5f68833 100644
--- a/android/client/haltest.c
+++ b/android/client/haltest.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
  * Copyright (C) 2013 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/android/client/history.c b/android/client/history.c
index ca4664cfe..1bc26e3cd 100644
--- a/android/client/history.c
+++ b/android/client/history.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
  * Copyright (C) 2013 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #include <stdlib.h>
diff --git a/android/client/history.h b/android/client/history.h
index 26085b511..b95c69822 100644
--- a/android/client/history.h
+++ b/android/client/history.h
@@ -1,18 +1,7 @@
+/* SPDX-License-Identifier: Apache-2.0 */
 /*
  * Copyright (C) 2013 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 void history_store(const char *filename);
diff --git a/android/client/if-audio.c b/android/client/if-audio.c
index 630b5e685..91008927e 100644
--- a/android/client/if-audio.c
+++ b/android/client/if-audio.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
  * Copyright (C) 2014 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #define _GNU_SOURCE
diff --git a/android/client/if-av-sink.c b/android/client/if-av-sink.c
index a6c867985..5b8c208fb 100644
--- a/android/client/if-av-sink.c
+++ b/android/client/if-av-sink.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
  * Copyright (C) 2014 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #define _GNU_SOURCE
diff --git a/android/client/if-av.c b/android/client/if-av.c
index 798a47aff..c3c91b94b 100644
--- a/android/client/if-av.c
+++ b/android/client/if-av.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
  * Copyright (C) 2013 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #define _GNU_SOURCE
diff --git a/android/client/if-bt.c b/android/client/if-bt.c
index 75403ec4a..68001a151 100644
--- a/android/client/if-bt.c
+++ b/android/client/if-bt.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
  * Copyright (C) 2013 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #define _GNU_SOURCE
diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index fbd938166..d00afffcb 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
  * Copyright (C) 2013 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #define _GNU_SOURCE
diff --git a/android/client/if-hf-client.c b/android/client/if-hf-client.c
index f701a814c..e3793aaf0 100644
--- a/android/client/if-hf-client.c
+++ b/android/client/if-hf-client.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
  * Copyright (C) 2014 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #define _GNU_SOURCE
diff --git a/android/client/if-hf.c b/android/client/if-hf.c
index 68df00b46..581d54248 100644
--- a/android/client/if-hf.c
+++ b/android/client/if-hf.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
  * Copyright (C) 2013 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #define _GNU_SOURCE
diff --git a/android/client/if-hh.c b/android/client/if-hh.c
index 04a54dea2..fac314bd5 100644
--- a/android/client/if-hh.c
+++ b/android/client/if-hh.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
  * Copyright (C) 2013 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #define _GNU_SOURCE
diff --git a/android/client/if-hl.c b/android/client/if-hl.c
index 1498fd5b0..826c81750 100644
--- a/android/client/if-hl.c
+++ b/android/client/if-hl.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
  * Copyright (C) 2014 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #define _GNU_SOURCE
diff --git a/android/client/if-main.h b/android/client/if-main.h
index d239bb2bf..6463be0d6 100644
--- a/android/client/if-main.h
+++ b/android/client/if-main.h
@@ -1,18 +1,7 @@
+/* SPDX-License-Identifier: Apache-2.0 */
 /*
  * Copyright (C) 2013 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #include <stdio.h>
diff --git a/android/client/if-mce.c b/android/client/if-mce.c
index ef1968920..38d3770a3 100644
--- a/android/client/if-mce.c
+++ b/android/client/if-mce.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
  * Copyright (C) 2014 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #define _GNU_SOURCE
diff --git a/android/client/if-pan.c b/android/client/if-pan.c
index b3098ba45..4b47ce23d 100644
--- a/android/client/if-pan.c
+++ b/android/client/if-pan.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
  * Copyright (C) 2013 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #define _GNU_SOURCE
diff --git a/android/client/if-rc-ctrl.c b/android/client/if-rc-ctrl.c
index 39e4b9051..a155ea8d2 100644
--- a/android/client/if-rc-ctrl.c
+++ b/android/client/if-rc-ctrl.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
  * Copyright (C) 2014 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #define _GNU_SOURCE
diff --git a/android/client/if-rc.c b/android/client/if-rc.c
index 6a5bffb6c..9a65f948b 100644
--- a/android/client/if-rc.c
+++ b/android/client/if-rc.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
  * Copyright (C) 2014 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #define _GNU_SOURCE
diff --git a/android/client/if-sco.c b/android/client/if-sco.c
index 6b570d229..fa370c1e9 100644
--- a/android/client/if-sco.c
+++ b/android/client/if-sco.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
  * Copyright (C) 2014 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #define _GNU_SOURCE
diff --git a/android/client/if-sock.c b/android/client/if-sock.c
index a188cf680..ce0e981f8 100644
--- a/android/client/if-sock.c
+++ b/android/client/if-sock.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
  * Copyright (C) 2013 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #define _GNU_SOURCE
diff --git a/android/client/pollhandler.c b/android/client/pollhandler.c
index 6160921d9..ca21a02bf 100644
--- a/android/client/pollhandler.c
+++ b/android/client/pollhandler.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
  * Copyright (C) 2013 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #include <stdio.h>
diff --git a/android/client/pollhandler.h b/android/client/pollhandler.h
index e2f22dfb0..89736640e 100644
--- a/android/client/pollhandler.h
+++ b/android/client/pollhandler.h
@@ -1,18 +1,7 @@
+/* SPDX-License-Identifier: Apache-2.0 */
 /*
  * Copyright (C) 2013 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #include <poll.h>
diff --git a/android/client/tabcompletion.c b/android/client/tabcompletion.c
index dc6faa887..b79a9830b 100644
--- a/android/client/tabcompletion.c
+++ b/android/client/tabcompletion.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
  * Copyright (C) 2013 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #define _GNU_SOURCE
diff --git a/android/client/terminal.c b/android/client/terminal.c
index f7b56de4c..cc8a9c3a4 100644
--- a/android/client/terminal.c
+++ b/android/client/terminal.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
  * Copyright (C) 2013 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #include <stdio.h>
diff --git a/android/client/terminal.h b/android/client/terminal.h
index 0e63936d3..3ce4a7e03 100644
--- a/android/client/terminal.h
+++ b/android/client/terminal.h
@@ -1,18 +1,7 @@
+/* SPDX-License-Identifier: Apache-2.0 */
 /*
  * Copyright (C) 2013 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #include <stdarg.h>
diff --git a/android/compat/readline/history.h b/android/compat/readline/history.h
index decc2f443..555e37aa1 100644
--- a/android/compat/readline/history.h
+++ b/android/compat/readline/history.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 1987-2011 Free Software Foundation, Inc.
  *
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #ifndef _HISTORY_H_
diff --git a/android/compat/readline/readline.h b/android/compat/readline/readline.h
index aaf6f31ec..2d2fa37c0 100644
--- a/android/compat/readline/readline.h
+++ b/android/compat/readline/readline.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 1987-2011 Free Software Foundation, Inc.
  *
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #ifndef _READLINE_H_
diff --git a/android/compat/wordexp.h b/android/compat/wordexp.h
index ff1f21c7e..08c59ee02 100644
--- a/android/compat/wordexp.h
+++ b/android/compat/wordexp.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 1991-2013 Free Software Foundation, Inc.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #ifndef _WORDEXP_H_
diff --git a/android/cutils/properties.h b/android/cutils/properties.h
index 0163eb5cb..3f6229cba 100644
--- a/android/cutils/properties.h
+++ b/android/cutils/properties.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2013  Intel Corporation. All rights reserved.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #include <unistd.h>
diff --git a/android/gatt.c b/android/gatt.c
index 9351a667d..a8a0c488b 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2014  Intel Corporation. All rights reserved.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/android/gatt.h b/android/gatt.h
index 3382df9b2..d16ea5f26 100644
--- a/android/gatt.h
+++ b/android/gatt.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2014  Intel Corporation. All rights reserved.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 bool bt_gatt_register(struct ipc *ipc, const bdaddr_t *addr);
diff --git a/android/hal-a2dp-sink.c b/android/hal-a2dp-sink.c
index a0b7ed1c4..0eecd1ac8 100644
--- a/android/hal-a2dp-sink.c
+++ b/android/hal-a2dp-sink.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
  * Copyright (C) 2014 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #include <stdbool.h>
diff --git a/android/hal-a2dp.c b/android/hal-a2dp.c
index f572875e8..34ca52fc8 100644
--- a/android/hal-a2dp.c
+++ b/android/hal-a2dp.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
  * Copyright (C) 2013 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #include <stdbool.h>
diff --git a/android/hal-audio-aptx.c b/android/hal-audio-aptx.c
index 4e364fc65..254ddf61c 100644
--- a/android/hal-audio-aptx.c
+++ b/android/hal-audio-aptx.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
  * Copyright (C) 2014 Tieto Poland
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #define _GNU_SOURCE
diff --git a/android/hal-audio-sbc.c b/android/hal-audio-sbc.c
index b06cafb7b..9c64d339c 100644
--- a/android/hal-audio-sbc.c
+++ b/android/hal-audio-sbc.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
  * Copyright (C) 2013 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #define _GNU_SOURCE
diff --git a/android/hal-audio.c b/android/hal-audio.c
index 2b25b6e08..d37d6098c 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
  * Copyright (C) 2013 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #define _GNU_SOURCE
diff --git a/android/hal-audio.h b/android/hal-audio.h
index 2b47412fc..389d14fc1 100644
--- a/android/hal-audio.h
+++ b/android/hal-audio.h
@@ -1,18 +1,7 @@
+/* SPDX-License-Identifier: Apache-2.0 */
 /*
  * Copyright (C) 2013 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #include <time.h>
diff --git a/android/hal-avrcp-ctrl.c b/android/hal-avrcp-ctrl.c
index a6137a5ad..41bdf9e7d 100644
--- a/android/hal-avrcp-ctrl.c
+++ b/android/hal-avrcp-ctrl.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
  * Copyright (C) 2014 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #define _GNU_SOURCE
diff --git a/android/hal-avrcp.c b/android/hal-avrcp.c
index b2127ade9..709ebf835 100644
--- a/android/hal-avrcp.c
+++ b/android/hal-avrcp.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
  * Copyright (C) 2014 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #define _GNU_SOURCE
diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index ee3a5e054..d4442e620 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
  * Copyright (C) 2013 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #define _GNU_SOURCE
diff --git a/android/hal-gatt.c b/android/hal-gatt.c
index 2e706cf24..c471f795c 100644
--- a/android/hal-gatt.c
+++ b/android/hal-gatt.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
  * Copyright (C) 2014 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #define _GNU_SOURCE
diff --git a/android/hal-handsfree-client.c b/android/hal-handsfree-client.c
index 93b5746b6..759164bde 100644
--- a/android/hal-handsfree-client.c
+++ b/android/hal-handsfree-client.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
  * Copyright (C) 2014 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #include <stdbool.h>
diff --git a/android/hal-handsfree.c b/android/hal-handsfree.c
index af21b675f..d602df988 100644
--- a/android/hal-handsfree.c
+++ b/android/hal-handsfree.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
  * Copyright (C) 2014 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #define _GNU_SOURCE
diff --git a/android/hal-health.c b/android/hal-health.c
index 5d5b11137..2da389187 100644
--- a/android/hal-health.c
+++ b/android/hal-health.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
  * Copyright (C) 2014 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #include <stdbool.h>
diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
index 1a603269c..2840ce559 100644
--- a/android/hal-hidhost.c
+++ b/android/hal-hidhost.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
  * Copyright (C) 2013 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #include <stdbool.h>
diff --git a/android/hal-ipc.c b/android/hal-ipc.c
index 363072cfc..8b37b7e0e 100644
--- a/android/hal-ipc.c
+++ b/android/hal-ipc.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
  * Copyright (C) 2013 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #include <pthread.h>
diff --git a/android/hal-ipc.h b/android/hal-ipc.h
index 08ed7cc85..a7a8dce51 100644
--- a/android/hal-ipc.h
+++ b/android/hal-ipc.h
@@ -1,18 +1,7 @@
+/* SPDX-License-Identifier: Apache-2.0 */
 /*
  * Copyright (C) 2013 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 struct hal_ipc_handler {
diff --git a/android/hal-log.h b/android/hal-log.h
index 63ff61b13..2d5abd752 100644
--- a/android/hal-log.h
+++ b/android/hal-log.h
@@ -1,18 +1,7 @@
+/* SPDX-License-Identifier: Apache-2.0 */
 /*
  * Copyright (C) 2013 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #define LOG_TAG "BlueZ"
diff --git a/android/hal-map-client.c b/android/hal-map-client.c
index adf04fcef..0956e80aa 100644
--- a/android/hal-map-client.c
+++ b/android/hal-map-client.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
  * Copyright (C) 2014 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #include <stdlib.h>
diff --git a/android/hal-msg.h b/android/hal-msg.h
index ea79fa7df..c6c1e6118 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2013  Intel Corporation. All rights reserved.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 static const char BLUEZ_HAL_SK_PATH[] = "\0bluez_hal_socket";
diff --git a/android/hal-pan.c b/android/hal-pan.c
index 5e1afc80a..ca30911db 100644
--- a/android/hal-pan.c
+++ b/android/hal-pan.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
  * Copyright (C) 2013 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #define _GNU_SOURCE
diff --git a/android/hal-sco.c b/android/hal-sco.c
index f4b4d3160..d7c08a68b 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
  * Copyright (C) 2013 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #define _GNU_SOURCE
diff --git a/android/hal-socket.c b/android/hal-socket.c
index b971074f9..8d47fdd45 100644
--- a/android/hal-socket.c
+++ b/android/hal-socket.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
  * Copyright (C) 2013 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #define _GNU_SOURCE
diff --git a/android/hal-utils.c b/android/hal-utils.c
index 74f292756..453922be7 100644
--- a/android/hal-utils.c
+++ b/android/hal-utils.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
  * Copyright (C) 2013 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #define _GNU_SOURCE
diff --git a/android/hal-utils.h b/android/hal-utils.h
index 9c5994855..4289d431c 100644
--- a/android/hal-utils.h
+++ b/android/hal-utils.h
@@ -1,18 +1,7 @@
+/* SPDX-License-Identifier: Apache-2.0 */
 /*
  * Copyright (C) 2013 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #include <endian.h>
diff --git a/android/hal.h b/android/hal.h
index 709c19758..df2f45db2 100644
--- a/android/hal.h
+++ b/android/hal.h
@@ -1,18 +1,7 @@
+/* SPDX-License-Identifier: Apache-2.0 */
 /*
  * Copyright (C) 2013 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #include <hardware/bluetooth.h>
diff --git a/android/handsfree-client.c b/android/handsfree-client.c
index 65659b899..4c682fbb8 100644
--- a/android/handsfree-client.c
+++ b/android/handsfree-client.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2014  Intel Corporation. All rights reserved.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/android/handsfree-client.h b/android/handsfree-client.h
index 1eb69ff36..344d68520 100644
--- a/android/handsfree-client.h
+++ b/android/handsfree-client.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2014  Intel Corporation. All rights reserved.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 bool bt_hf_client_register(struct ipc *ipc, const bdaddr_t *addr);
diff --git a/android/handsfree.c b/android/handsfree.c
index ebe03728e..2365356c2 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2013-2014  Intel Corporation. All rights reserved.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/android/handsfree.h b/android/handsfree.h
index d4fd649b0..d45bdb69a 100644
--- a/android/handsfree.h
+++ b/android/handsfree.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2013-2014  Intel Corporation. All rights reserved.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 bool bt_handsfree_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode,
diff --git a/android/hardware/audio.h b/android/hardware/audio.h
index 3cc2be545..b612b9d11 100644
--- a/android/hardware/audio.h
+++ b/android/hardware/audio.h
@@ -1,17 +1,7 @@
+/* SPDX-License-Identifier: Apache-2.0 */
 /*
  * Copyright (C) 2011 The Android Open Source Project
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
  */
 
 
diff --git a/android/hardware/audio_effect.h b/android/hardware/audio_effect.h
index 69ea89617..2c63f1ccf 100644
--- a/android/hardware/audio_effect.h
+++ b/android/hardware/audio_effect.h
@@ -1,17 +1,7 @@
+/* SPDX-License-Identifier: Apache-2.0 */
 /*
  * Copyright (C) 2011 The Android Open Source Project
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
  */
 
 
diff --git a/android/hardware/bluetooth.h b/android/hardware/bluetooth.h
index 74cd1fce6..21253e00a 100644
--- a/android/hardware/bluetooth.h
+++ b/android/hardware/bluetooth.h
@@ -1,17 +1,7 @@
+/* SPDX-License-Identifier: Apache-2.0 */
 /*
  * Copyright (C) 2012 The Android Open Source Project
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
  */
 
 #ifndef ANDROID_INCLUDE_BLUETOOTH_H
diff --git a/android/hardware/bt_av.h b/android/hardware/bt_av.h
index 5252a179b..427244d48 100644
--- a/android/hardware/bt_av.h
+++ b/android/hardware/bt_av.h
@@ -1,17 +1,7 @@
+/* SPDX-License-Identifier: Apache-2.0 */
 /*
  * Copyright (C) 2012 The Android Open Source Project
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
  */
 
 #ifndef ANDROID_INCLUDE_BT_AV_H
diff --git a/android/hardware/bt_gatt.h b/android/hardware/bt_gatt.h
index 42e14c2f1..c48a446c2 100644
--- a/android/hardware/bt_gatt.h
+++ b/android/hardware/bt_gatt.h
@@ -1,17 +1,7 @@
+/* SPDX-License-Identifier: Apache-2.0 */
 /*
  * Copyright (C) 2013 The Android Open Source Project
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
  */
 
 
diff --git a/android/hardware/bt_gatt_client.h b/android/hardware/bt_gatt_client.h
index 8073dd1d6..414e7b075 100644
--- a/android/hardware/bt_gatt_client.h
+++ b/android/hardware/bt_gatt_client.h
@@ -1,17 +1,7 @@
+/* SPDX-License-Identifier: Apache-2.0 */
 /*
  * Copyright (C) 2013 The Android Open Source Project
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
  */
 
 
diff --git a/android/hardware/bt_gatt_server.h b/android/hardware/bt_gatt_server.h
index 0d6cc1e8d..fbb8fe6b8 100644
--- a/android/hardware/bt_gatt_server.h
+++ b/android/hardware/bt_gatt_server.h
@@ -1,17 +1,7 @@
+/* SPDX-License-Identifier: Apache-2.0 */
 /*
  * Copyright (C) 2013 The Android Open Source Project
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
  */
 
 
diff --git a/android/hardware/bt_gatt_types.h b/android/hardware/bt_gatt_types.h
index e037ddcdb..c7c000e8d 100644
--- a/android/hardware/bt_gatt_types.h
+++ b/android/hardware/bt_gatt_types.h
@@ -1,17 +1,7 @@
+/* SPDX-License-Identifier: Apache-2.0 */
 /*
  * Copyright (C) 2013 The Android Open Source Project
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
  */
 
 
diff --git a/android/hardware/bt_hf.h b/android/hardware/bt_hf.h
index 7dcb40a4b..c3f952415 100644
--- a/android/hardware/bt_hf.h
+++ b/android/hardware/bt_hf.h
@@ -1,17 +1,7 @@
+/* SPDX-License-Identifier: Apache-2.0 */
 /*
  * Copyright (C) 2012 The Android Open Source Project
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
  */
 
 #ifndef ANDROID_INCLUDE_BT_HF_H
diff --git a/android/hardware/bt_hf_client.h b/android/hardware/bt_hf_client.h
index 8acf1b2c5..4a0ec364b 100644
--- a/android/hardware/bt_hf_client.h
+++ b/android/hardware/bt_hf_client.h
@@ -1,17 +1,7 @@
+/* SPDX-License-Identifier: Apache-2.0 */
 /*
  * Copyright (C) 2012-2014 The Android Open Source Project
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
  */
 
 #ifndef ANDROID_INCLUDE_BT_HF_CLIENT_H
diff --git a/android/hardware/bt_hh.h b/android/hardware/bt_hh.h
index dad958680..2dd61beac 100644
--- a/android/hardware/bt_hh.h
+++ b/android/hardware/bt_hh.h
@@ -1,17 +1,7 @@
+/* SPDX-License-Identifier: Apache-2.0 */
 /*
  * Copyright (C) 2012 The Android Open Source Project
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
  */
 
 #ifndef ANDROID_INCLUDE_BT_HH_H
diff --git a/android/hardware/bt_hl.h b/android/hardware/bt_hl.h
index bd29e3abf..d26c054a7 100644
--- a/android/hardware/bt_hl.h
+++ b/android/hardware/bt_hl.h
@@ -1,17 +1,7 @@
+/* SPDX-License-Identifier: Apache-2.0 */
 /*
  * Copyright (C) 2012 The Android Open Source Project
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
  */
 
 #ifndef ANDROID_INCLUDE_BT_HL_H
diff --git a/android/hardware/bt_mce.h b/android/hardware/bt_mce.h
index 5d159b336..4d30ecd87 100644
--- a/android/hardware/bt_mce.h
+++ b/android/hardware/bt_mce.h
@@ -1,17 +1,7 @@
+/* SPDX-License-Identifier: Apache-2.0 */
 /*
  * Copyright (C) 2014 The Android Open Source Project
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
  */
 
 #ifndef ANDROID_INCLUDE_BT_MCE_H
diff --git a/android/hardware/bt_pan.h b/android/hardware/bt_pan.h
index 83e7949b2..2f9f4fb77 100644
--- a/android/hardware/bt_pan.h
+++ b/android/hardware/bt_pan.h
@@ -1,17 +1,7 @@
+/* SPDX-License-Identifier: Apache-2.0 */
 /*
  * Copyright (C) 2012 The Android Open Source Project
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
  */
 
 #ifndef ANDROID_INCLUDE_BT_PAN_H
diff --git a/android/hardware/bt_rc.h b/android/hardware/bt_rc.h
index c565c4875..c1290aeb1 100644
--- a/android/hardware/bt_rc.h
+++ b/android/hardware/bt_rc.h
@@ -1,17 +1,7 @@
+/* SPDX-License-Identifier: Apache-2.0 */
 /*
  * Copyright (C) 2012 The Android Open Source Project
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
  */
 
 #ifndef ANDROID_INCLUDE_BT_RC_H
diff --git a/android/hardware/bt_sock.h b/android/hardware/bt_sock.h
index a4aa046f2..cb2ff072a 100644
--- a/android/hardware/bt_sock.h
+++ b/android/hardware/bt_sock.h
@@ -1,17 +1,7 @@
+/* SPDX-License-Identifier: Apache-2.0 */
 /*
  * Copyright (C) 2012 The Android Open Source Project
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
  */
 
 #ifndef ANDROID_INCLUDE_BT_SOCK_H
diff --git a/android/hardware/hardware.c b/android/hardware/hardware.c
index 42d03ba52..db5696297 100644
--- a/android/hardware/hardware.c
+++ b/android/hardware/hardware.c
@@ -1,17 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
  * Copyright (C) 2008 The Android Open Source Project
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
  */
 
 #define _GNU_SOURCE
diff --git a/android/hardware/hardware.h b/android/hardware/hardware.h
index c7e8cc7e9..74470a31a 100644
--- a/android/hardware/hardware.h
+++ b/android/hardware/hardware.h
@@ -1,17 +1,7 @@
+/* SPDX-License-Identifier: Apache-2.0 */
 /*
  * Copyright (C) 2008 The Android Open Source Project
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
  */
 
 #ifndef ANDROID_INCLUDE_HARDWARE_HARDWARE_H
diff --git a/android/health.c b/android/health.c
index 90253ac00..9a29964b1 100644
--- a/android/health.c
+++ b/android/health.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -6,20 +7,6 @@
  *  Copyright (C) 2010 GSyC/LibreSoft, Universidad Rey Juan Carlos.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/android/health.h b/android/health.h
index 0b32fd318..b221677d3 100644
--- a/android/health.h
+++ b/android/health.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2014  Intel Corporation. All rights reserved.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 bool bt_health_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode);
diff --git a/android/hidhost.c b/android/hidhost.c
index 7bc484f11..016382e17 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2013-2014  Intel Corporation. All rights reserved.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/android/hidhost.h b/android/hidhost.h
index e6b87ed2b..ee5dc8024 100644
--- a/android/hidhost.h
+++ b/android/hidhost.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2013-2014  Intel Corporation. All rights reserved.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 bool bt_hid_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode);
diff --git a/android/ipc-common.h b/android/ipc-common.h
index 27736e4d6..599b63a94 100644
--- a/android/ipc-common.h
+++ b/android/ipc-common.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2014  Intel Corporation. All rights reserved.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #define IPC_MTU 1024
diff --git a/android/ipc-tester.c b/android/ipc-tester.c
index c1d0e8ad6..780e1dc4c 100644
--- a/android/ipc-tester.c
+++ b/android/ipc-tester.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2013-2014  Intel Corporation. All rights reserved.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/android/ipc.c b/android/ipc.c
index 2e674284e..3b3c95293 100644
--- a/android/ipc.c
+++ b/android/ipc.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2013-2014  Intel Corporation. All rights reserved.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/android/ipc.h b/android/ipc.h
index fd2b98521..02510e5f1 100644
--- a/android/ipc.h
+++ b/android/ipc.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2013-2014  Intel Corporation. All rights reserved.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 struct ipc_handler {
diff --git a/android/log.c b/android/log.c
index 35917c601..ae172cf73 100644
--- a/android/log.c
+++ b/android/log.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2014  Intel Corporation. All rights reserved.
  *
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 #ifdef HAVE_CONFIG_H
 #include <config.h>
diff --git a/android/main.c b/android/main.c
index b505c2f77..b85709a1d 100644
--- a/android/main.c
+++ b/android/main.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2013-2014  Intel Corporation. All rights reserved.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/android/map-client.c b/android/map-client.c
index e3ad148a0..3360bcd38 100644
--- a/android/map-client.c
+++ b/android/map-client.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2014  Intel Corporation. All rights reserved.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/android/map-client.h b/android/map-client.h
index 0e63072f9..9dc237767 100644
--- a/android/map-client.h
+++ b/android/map-client.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2014  Intel Corporation. All rights reserved.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 bool bt_map_client_register(struct ipc *ipc, const bdaddr_t *addr,
diff --git a/android/pan.c b/android/pan.c
index 1e6d87641..ab4434710 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2013-2014  Intel Corporation. All rights reserved.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/android/pan.h b/android/pan.h
index cfbea96a2..0dc0c1c6f 100644
--- a/android/pan.h
+++ b/android/pan.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2013-2014  Intel Corporation. All rights reserved.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 bool bt_pan_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode);
diff --git a/android/sco-msg.h b/android/sco-msg.h
index d1b13d70d..3eea210d9 100644
--- a/android/sco-msg.h
+++ b/android/sco-msg.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2014  Intel Corporation. All rights reserved.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 static const char BLUEZ_SCO_SK_PATH[] = "\0bluez_sco_socket";
diff --git a/android/sco.c b/android/sco.c
index e8ac6854f..f3e03c605 100644
--- a/android/sco.c
+++ b/android/sco.c
@@ -1,23 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2014 Intel Corporation. All rights reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/android/sco.h b/android/sco.h
index 4e1a2b3cf..4c7291fbe 100644
--- a/android/sco.h
+++ b/android/sco.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2014  Intel Corporation. All rights reserved.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 enum sco_status {
diff --git a/android/socket.c b/android/socket.c
index 15e1bfcc9..74cbcf4ef 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2013-2014  Intel Corporation. All rights reserved.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/android/socket.h b/android/socket.h
index b0e78c6d7..347bc30e3 100644
--- a/android/socket.h
+++ b/android/socket.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2013-2014  Intel Corporation. All rights reserved.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 struct hal_sock_connect_signal {
diff --git a/android/system-emulator.c b/android/system-emulator.c
index edf3e89e0..bf1499df0 100644
--- a/android/system-emulator.c
+++ b/android/system-emulator.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2013-2014  Intel Corporation. All rights reserved.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/android/system/audio.h b/android/system/audio.h
index d2da76db1..0c5af5e84 100644
--- a/android/system/audio.h
+++ b/android/system/audio.h
@@ -1,17 +1,7 @@
+/* SPDX-License-Identifier: Apache-2.0 */
 /*
  * Copyright (C) 2011 The Android Open Source Project
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
  */
 
 
diff --git a/android/test-ipc.c b/android/test-ipc.c
index bb7d15fe0..f11c8f650 100644
--- a/android/test-ipc.c
+++ b/android/test-ipc.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2013-2014  Intel Corporation. All rights reserved.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/android/tester-a2dp.c b/android/tester-a2dp.c
index 554a3941d..c25809245 100644
--- a/android/tester-a2dp.c
+++ b/android/tester-a2dp.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
  * Copyright (C) 2014 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #define _GNU_SOURCE
diff --git a/android/tester-avrcp.c b/android/tester-avrcp.c
index e0e7b7f6a..f2292d4e4 100644
--- a/android/tester-avrcp.c
+++ b/android/tester-avrcp.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
  * Copyright (C) 2014 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #define _GNU_SOURCE
diff --git a/android/tester-bluetooth.c b/android/tester-bluetooth.c
index 6db337a94..f7a6b40d7 100644
--- a/android/tester-bluetooth.c
+++ b/android/tester-bluetooth.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
  * Copyright (C) 2014 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #define _GNU_SOURCE
diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index c10609732..30db7684d 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
  * Copyright (C) 2014 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #define _GNU_SOURCE
diff --git a/android/tester-hdp.c b/android/tester-hdp.c
index b4d14a339..0cc805eac 100644
--- a/android/tester-hdp.c
+++ b/android/tester-hdp.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
  * Copyright (C) 2014 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #define _GNU_SOURCE
diff --git a/android/tester-hidhost.c b/android/tester-hidhost.c
index 73092cda8..f9daf5590 100644
--- a/android/tester-hidhost.c
+++ b/android/tester-hidhost.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
  * Copyright (C) 2014 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #define _GNU_SOURCE
diff --git a/android/tester-main.c b/android/tester-main.c
index 9a14b2899..2bfa770bb 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
  * Copyright (C) 2014 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #define _GNU_SOURCE
diff --git a/android/tester-main.h b/android/tester-main.h
index 6bdfdbcdb..9b835d5eb 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2014  Intel Corporation. All rights reserved.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 #include <glib.h>
diff --git a/android/tester-map-client.c b/android/tester-map-client.c
index ff3f272fc..63ec319b6 100644
--- a/android/tester-map-client.c
+++ b/android/tester-map-client.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
  * Copyright (C) 2014 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #define _GNU_SOURCE
diff --git a/android/tester-pan.c b/android/tester-pan.c
index 74ad107a8..f70ab95b8 100644
--- a/android/tester-pan.c
+++ b/android/tester-pan.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
  * Copyright (C) 2014 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #define _GNU_SOURCE
diff --git a/android/tester-socket.c b/android/tester-socket.c
index ac77e5aeb..540ee70d4 100644
--- a/android/tester-socket.c
+++ b/android/tester-socket.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0
 /*
  * Copyright (C) 2014 Intel Corporation
  *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
  */
 
 #define _GNU_SOURCE
diff --git a/android/utils.h b/android/utils.h
index 7adc2dabc..1902e15f8 100644
--- a/android/utils.h
+++ b/android/utils.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,20 +6,6 @@
  *  Copyright (C) 2013-2014  Intel Corporation. All rights reserved.
  *
  *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 
 static inline void android2bdaddr(const void *buf, bdaddr_t *dst)
-- 
2.25.4

