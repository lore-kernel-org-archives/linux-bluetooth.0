Return-Path: <SRS0=5m6h=C6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAEBC4363C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Sep 2020 19:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DE0920738
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Sep 2020 19:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgIUTfo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Sep 2020 15:35:44 -0400
Received: from mga18.intel.com ([134.134.136.126]:18041 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727197AbgIUTfo (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Sep 2020 15:35:44 -0400
IronPort-SDR: 6/cfUjo+DPsrUtv4l8yh9IgqRetufFFUY+b5q4Aa7CEQ5q9s1Exyz1vYXntGZ9it4TcOch0X07
 son6HMo3fhWg==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="148221645"
X-IronPort-AV: E=Sophos;i="5.77,287,1596524400"; 
   d="scan'208";a="148221645"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2020 12:35:40 -0700
IronPort-SDR: NGfRTILaVRrxTyyy3RLQDh5++z+kp+QuvwSp6/IfBT/72MQQttifDelBXuqBWt/BnGcc8/7FLz
 YMdTA5q8Y3rA==
X-IronPort-AV: E=Sophos;i="5.77,287,1596524400"; 
   d="scan'208";a="334681709"
Received: from han1-mobl3.jf.intel.com ([10.254.86.223])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2020 12:35:40 -0700
From:   tedd.an@linux.intel.com
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [BlueZ V4 RESEND 09/20] mesh: Add SPDX License Identifier
Date:   Mon, 21 Sep 2020 12:35:33 -0700
Message-Id: <20200921193533.47135-1-tedd.an@linux.intel.com>
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
 LGPL-2.1-or-later    :     48

License: LGPL-2.1-or-later
   mesh/mesh-mgmt.h
   mesh/mesh-mgmt.c
   mesh/net-keys.c
   mesh/mesh-io-api.h
   mesh/mesh.h
   mesh/net-keys.h
   mesh/model.h
   mesh/util.h
   mesh/appkey.c
   mesh/cfgmod.h
   mesh/appkey.h
   mesh/prov.h
   mesh/prov-acceptor.c
   mesh/net.c
   mesh/dbus.h
   mesh/friend.h
   mesh/mesh-io-generic.c
   mesh/main.c
   mesh/util.c
   mesh/dbus.c
   mesh/error.h
   mesh/mesh-config-json.c
   mesh/agent.h
   mesh/pb-adv.c
   mesh/crypto.c
   mesh/crypto.h
   mesh/friend.c
   mesh/pb-adv.h
   mesh/provision.h
   mesh/mesh-config.h
   mesh/mesh-io-generic.h
   mesh/agent.c
   mesh/cfgmod-server.c
   mesh/mesh-io.h
   mesh/keyring.h
   mesh/net.h
   mesh/keyring.c
   mesh/mesh-defs.h
   mesh/mesh.c
   mesh/rpl.c
   mesh/manager.c
   mesh/model.c
   mesh/mesh-io.c
   mesh/node.c
   mesh/prov-initiator.c
   mesh/rpl.h
   mesh/node.h
   mesh/manager.h
---
 mesh/agent.c            | 11 +----------
 mesh/agent.h            | 11 +----------
 mesh/appkey.c           | 11 +----------
 mesh/appkey.h           | 11 +----------
 mesh/cfgmod-server.c    | 11 +----------
 mesh/cfgmod.h           | 11 +----------
 mesh/crypto.c           | 11 +----------
 mesh/crypto.h           | 11 +----------
 mesh/dbus.c             | 11 +----------
 mesh/dbus.h             | 11 +----------
 mesh/error.h            | 11 +----------
 mesh/friend.c           | 11 +----------
 mesh/friend.h           | 11 +----------
 mesh/keyring.c          | 11 +----------
 mesh/keyring.h          | 11 +----------
 mesh/main.c             | 11 +----------
 mesh/manager.c          | 11 +----------
 mesh/manager.h          | 11 +----------
 mesh/mesh-config-json.c | 11 +----------
 mesh/mesh-config.h      | 11 +----------
 mesh/mesh-defs.h        | 12 +-----------
 mesh/mesh-io-api.h      | 11 +----------
 mesh/mesh-io-generic.c  | 11 +----------
 mesh/mesh-io-generic.h  | 11 +----------
 mesh/mesh-io.c          | 11 +----------
 mesh/mesh-io.h          | 11 +----------
 mesh/mesh-mgmt.c        | 11 +----------
 mesh/mesh-mgmt.h        | 11 +----------
 mesh/mesh.c             | 11 +----------
 mesh/mesh.h             | 11 +----------
 mesh/model.c            | 11 +----------
 mesh/model.h            | 11 +----------
 mesh/net-keys.c         | 11 +----------
 mesh/net-keys.h         | 11 +----------
 mesh/net.c              | 11 +----------
 mesh/net.h              | 11 +----------
 mesh/node.c             | 11 +----------
 mesh/node.h             | 11 +----------
 mesh/pb-adv.c           | 11 +----------
 mesh/pb-adv.h           | 11 +----------
 mesh/prov-acceptor.c    | 11 +----------
 mesh/prov-initiator.c   | 11 +----------
 mesh/prov.h             | 11 +----------
 mesh/provision.h        | 11 +----------
 mesh/rpl.c              | 11 +----------
 mesh/rpl.h              | 11 +----------
 mesh/util.c             | 11 +----------
 mesh/util.h             | 11 +----------
 48 files changed, 48 insertions(+), 481 deletions(-)

diff --git a/mesh/agent.c b/mesh/agent.c
index 4d200416f..b0d523d16 100644
--- a/mesh/agent.c
+++ b/mesh/agent.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,16 +6,6 @@
  *  Copyright (C) 2018-2019  Intel Corporation. All rights reserved.
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
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/mesh/agent.h b/mesh/agent.h
index 6cc3d0f71..6664c2226 100644
--- a/mesh/agent.h
+++ b/mesh/agent.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,16 +6,6 @@
  *  Copyright (C) 2018  Intel Corporation. All rights reserved.
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
  */
 
 struct mesh_agent;
diff --git a/mesh/appkey.c b/mesh/appkey.c
index a4771bd7d..7efb8f5c4 100644
--- a/mesh/appkey.c
+++ b/mesh/appkey.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,16 +6,6 @@
  *  Copyright (C) 2017-2019  Intel Corporation. All rights reserved.
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
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/mesh/appkey.h b/mesh/appkey.h
index 23b474a0a..3bb70445b 100644
--- a/mesh/appkey.h
+++ b/mesh/appkey.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,16 +6,6 @@
  *  Copyright (C) 2018-2019  Intel Corporation. All rights reserved.
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
  */
 
 /* TODO: get this number from configuration */
diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index 2e5da863a..0009a1bee 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,16 +6,6 @@
  *  Copyright (C) 2018-2020  Intel Corporation. All rights reserved.
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
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/mesh/cfgmod.h b/mesh/cfgmod.h
index 6d73656a7..f47a42c60 100644
--- a/mesh/cfgmod.h
+++ b/mesh/cfgmod.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,16 +6,6 @@
  *  Copyright (C) 2018  Intel Corporation. All rights reserved.
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
  */
 
 #define CONFIG_SRV_MODEL	SET_ID(SIG_VENDOR, 0x0000)
diff --git a/mesh/crypto.c b/mesh/crypto.c
index 70b96c51b..da227ebbb 100644
--- a/mesh/crypto.c
+++ b/mesh/crypto.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,16 +6,6 @@
  *  Copyright (C) 2018-2019  Intel Corporation. All rights reserved.
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
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/mesh/crypto.h b/mesh/crypto.h
index 7d3f89cde..2f31dc3de 100644
--- a/mesh/crypto.h
+++ b/mesh/crypto.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,16 +6,6 @@
  *  Copyright (C) 2018  Intel Corporation. All rights reserved.
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
  */
 
 #include <stdbool.h>
diff --git a/mesh/dbus.c b/mesh/dbus.c
index 63ea420ed..a7abdc428 100644
--- a/mesh/dbus.c
+++ b/mesh/dbus.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,16 +6,6 @@
  *  Copyright (C) 2018-2019 Intel Corporation. All rights reserved.
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
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/mesh/dbus.h b/mesh/dbus.h
index 89d6b1d31..8f00434d6 100644
--- a/mesh/dbus.h
+++ b/mesh/dbus.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,16 +6,6 @@
  *  Copyright (C) 2018  Intel Corporation. All rights reserved.
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
  */
 
 #define BLUEZ_MESH_PATH "/org/bluez/mesh"
diff --git a/mesh/error.h b/mesh/error.h
index 2809915b0..6d9ccdb59 100644
--- a/mesh/error.h
+++ b/mesh/error.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,16 +6,6 @@
  *  Copyright (C) 2018-2019  Intel Corporation. All rights reserved.
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
  */
 
 /*
diff --git a/mesh/friend.c b/mesh/friend.c
index d27da9592..1e67704b8 100644
--- a/mesh/friend.c
+++ b/mesh/friend.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,16 +6,6 @@
  *  Copyright (C) 2018-2019  Intel Corporation. All rights reserved.
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
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/mesh/friend.h b/mesh/friend.h
index 2351dee31..ba6053426 100644
--- a/mesh/friend.h
+++ b/mesh/friend.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,16 +6,6 @@
  *  Copyright (C) 2018  Intel Corporation. All rights reserved.
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
  */
 
 #define OP_FRND_REQUEST			0x8040
diff --git a/mesh/keyring.c b/mesh/keyring.c
index e8dd1e463..bbe501063 100644
--- a/mesh/keyring.c
+++ b/mesh/keyring.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,16 +6,6 @@
  *  Copyright (C) 2019  Intel Corporation. All rights reserved.
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
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/mesh/keyring.h b/mesh/keyring.h
index 2fab6b0dc..c2d38e9ff 100644
--- a/mesh/keyring.h
+++ b/mesh/keyring.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,16 +6,6 @@
  *  Copyright (C) 2019  Intel Corporation. All rights reserved.
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
  */
 
 struct keyring_net_key {
diff --git a/mesh/main.c b/mesh/main.c
index 5a3cbf290..4356e3f65 100644
--- a/mesh/main.c
+++ b/mesh/main.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,16 +6,6 @@
  *  Copyright (C) 2017-2019  Intel Corporation. All rights reserved.
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
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/mesh/manager.c b/mesh/manager.c
index 8ef681366..d70993e3b 100644
--- a/mesh/manager.c
+++ b/mesh/manager.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,16 +6,6 @@
  *  Copyright (C) 2019  Intel Corporation. All rights reserved.
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
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/mesh/manager.h b/mesh/manager.h
index 5a4c7d94a..a45a1f1c4 100644
--- a/mesh/manager.h
+++ b/mesh/manager.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,16 +6,6 @@
  *  Copyright (C) 2019  Intel Corporation. All rights reserved.
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
  */
 
 bool manager_dbus_init(struct l_dbus *dbus);
diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index 30c90170d..ec9ecb786 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,16 +6,6 @@
  *  Copyright (C) 2018-2019  Intel Corporation. All rights reserved.
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
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/mesh/mesh-config.h b/mesh/mesh-config.h
index 738cff9dd..420775829 100644
--- a/mesh/mesh-config.h
+++ b/mesh/mesh-config.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,16 +6,6 @@
  *  Copyright (C) 2018-2019  Intel Corporation. All rights reserved.
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
  */
 
 #define MIN_COMP_SIZE 14
diff --git a/mesh/mesh-defs.h b/mesh/mesh-defs.h
index 1a41e987b..43bdf5aab 100644
--- a/mesh/mesh-defs.h
+++ b/mesh/mesh-defs.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,17 +6,6 @@
  *  Copyright (C) 2018-2019  Intel Corporation. All rights reserved.
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
- *
  */
 
 #define MESH_AD_TYPE_PROVISION	0x29
diff --git a/mesh/mesh-io-api.h b/mesh/mesh-io-api.h
index 7a5b49c60..61f79f224 100644
--- a/mesh/mesh-io-api.h
+++ b/mesh/mesh-io-api.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,16 +6,6 @@
  *  Copyright (C) 2018  Intel Corporation. All rights reserved.
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
  */
 
 struct mesh_io_private;
diff --git a/mesh/mesh-io-generic.c b/mesh/mesh-io-generic.c
index 67304d201..4eb7f27ce 100644
--- a/mesh/mesh-io-generic.c
+++ b/mesh/mesh-io-generic.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,16 +6,6 @@
  *  Copyright (C) 2018-2019  Intel Corporation. All rights reserved.
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
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/mesh/mesh-io-generic.h b/mesh/mesh-io-generic.h
index 4bf4d5cb7..915e376bf 100644
--- a/mesh/mesh-io-generic.h
+++ b/mesh/mesh-io-generic.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,16 +6,6 @@
  *  Copyright (C) 2018  Intel Corporation. All rights reserved.
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
  */
 
 extern const struct mesh_io_api mesh_io_generic;
diff --git a/mesh/mesh-io.c b/mesh/mesh-io.c
index c4eaecefd..62fc5d12e 100644
--- a/mesh/mesh-io.c
+++ b/mesh/mesh-io.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,16 +6,6 @@
  *  Copyright (C) 2018  Intel Corporation. All rights reserved.
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
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/mesh/mesh-io.h b/mesh/mesh-io.h
index fc0422020..b11c6c6e1 100644
--- a/mesh/mesh-io.h
+++ b/mesh/mesh-io.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,16 +6,6 @@
  *  Copyright (C) 2018  Intel Corporation. All rights reserved.
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
  */
 
 struct mesh_io;
diff --git a/mesh/mesh-mgmt.c b/mesh/mesh-mgmt.c
index 2cf2ebac2..754093dbc 100644
--- a/mesh/mesh-mgmt.c
+++ b/mesh/mesh-mgmt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,16 +6,6 @@
  *  Copyright (C) 2019  SILVAIR sp. z o.o. All rights reserved.
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
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/mesh/mesh-mgmt.h b/mesh/mesh-mgmt.h
index 93ad7995e..90ac14e73 100644
--- a/mesh/mesh-mgmt.h
+++ b/mesh/mesh-mgmt.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,16 +6,6 @@
  *  Copyright (C) 2019  SILVAIR sp. z o.o. All rights reserved.
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
  */
 #include <stdbool.h>
 
diff --git a/mesh/mesh.c b/mesh/mesh.c
index bc170371d..f29e8b6be 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,16 +6,6 @@
  *  Copyright (C) 2018-2019  Intel Corporation. All rights reserved.
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
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/mesh/mesh.h b/mesh/mesh.h
index eb887723d..0f77ebc58 100644
--- a/mesh/mesh.h
+++ b/mesh/mesh.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,16 +6,6 @@
  *  Copyright (C) 2018-2019  Intel Corporation. All rights reserved.
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
  */
 
 #define BLUEZ_MESH_NAME "org.bluez.mesh"
diff --git a/mesh/model.c b/mesh/model.c
index 5716f5e22..c8eb8c607 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,16 +6,6 @@
  *  Copyright (C) 2018-2020  Intel Corporation. All rights reserved.
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
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/mesh/model.h b/mesh/model.h
index 2eec761a0..8df4f205f 100644
--- a/mesh/model.h
+++ b/mesh/model.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,16 +6,6 @@
  *  Copyright (C) 2018-2020  Intel Corporation. All rights reserved.
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
  */
 
 struct mesh_model;
diff --git a/mesh/net-keys.c b/mesh/net-keys.c
index 7dfabf922..e42cac70c 100644
--- a/mesh/net-keys.c
+++ b/mesh/net-keys.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,16 +6,6 @@
  *  Copyright (C) 2019  Intel Corporation. All rights reserved.
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
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/mesh/net-keys.h b/mesh/net-keys.h
index 4f480fcda..70b3d22c3 100644
--- a/mesh/net-keys.h
+++ b/mesh/net-keys.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,16 +6,6 @@
  *  Copyright (C) 2019  Intel Corporation. All rights reserved.
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
  */
 
 #define BEACON_TYPE_SNB		0x01
diff --git a/mesh/net.c b/mesh/net.c
index 6c7311732..01a475d74 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,16 +6,6 @@
  *  Copyright (C) 2018-2019  Intel Corporation. All rights reserved.
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
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/mesh/net.h b/mesh/net.h
index 7bec6d0fc..4dbc94b8b 100644
--- a/mesh/net.h
+++ b/mesh/net.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,16 +6,6 @@
  *  Copyright (C) 2018-2019  Intel Corporation. All rights reserved.
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
  */
 
 #ifndef __packed
diff --git a/mesh/node.c b/mesh/node.c
index f7ac5ff67..76d8fd6e9 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,16 +6,6 @@
  *  Copyright (C) 2017-2020  Intel Corporation. All rights reserved.
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
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/mesh/node.h b/mesh/node.h
index 7874b8692..30d53db33 100644
--- a/mesh/node.h
+++ b/mesh/node.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,16 +6,6 @@
  *  Copyright (C) 2018-2019  Intel Corporation. All rights reserved.
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
  */
 
 struct mesh_net;
diff --git a/mesh/pb-adv.c b/mesh/pb-adv.c
index ae5b81391..c74dae79f 100644
--- a/mesh/pb-adv.c
+++ b/mesh/pb-adv.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,16 +6,6 @@
  *  Copyright (C) 2018-2019  Intel Corporation. All rights reserved.
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
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/mesh/pb-adv.h b/mesh/pb-adv.h
index 80d53d234..5b1e03dae 100644
--- a/mesh/pb-adv.h
+++ b/mesh/pb-adv.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,16 +6,6 @@
  *  Copyright (C) 2018  Intel Corporation. All rights reserved.
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
  */
 
 bool pb_adv_reg(bool initiator, mesh_prov_open_func_t open_cb,
diff --git a/mesh/prov-acceptor.c b/mesh/prov-acceptor.c
index 96f7e15ad..a03ee1ce5 100644
--- a/mesh/prov-acceptor.c
+++ b/mesh/prov-acceptor.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,16 +6,6 @@
  *  Copyright (C) 2018-2019  Intel Corporation. All rights reserved.
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
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/mesh/prov-initiator.c b/mesh/prov-initiator.c
index 4de4df62d..8399282ee 100644
--- a/mesh/prov-initiator.c
+++ b/mesh/prov-initiator.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,16 +6,6 @@
  *  Copyright (C) 2018-2019  Intel Corporation. All rights reserved.
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
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/mesh/prov.h b/mesh/prov.h
index 11b20b31f..99e864c50 100644
--- a/mesh/prov.h
+++ b/mesh/prov.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,16 +6,6 @@
  *  Copyright (C) 2018  Intel Corporation. All rights reserved.
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
  */
 
 #ifndef __packed
diff --git a/mesh/provision.h b/mesh/provision.h
index 1d78ed8e2..1a11b691b 100644
--- a/mesh/provision.h
+++ b/mesh/provision.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,16 +6,6 @@
  *  Copyright (C) 2018  Intel Corporation. All rights reserved.
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
  */
 
 
diff --git a/mesh/rpl.c b/mesh/rpl.c
index 792c52ad6..7cea8e346 100644
--- a/mesh/rpl.c
+++ b/mesh/rpl.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,16 +6,6 @@
  *  Copyright (C) 2020  Intel Corporation. All rights reserved.
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
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/mesh/rpl.h b/mesh/rpl.h
index 2bbbdc9b9..9e988e7c5 100644
--- a/mesh/rpl.h
+++ b/mesh/rpl.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,16 +6,6 @@
  *  Copyright (C) 2020  Intel Corporation. All rights reserved.
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
  */
 
 struct mesh_rpl {
diff --git a/mesh/util.c b/mesh/util.c
index 7d283331a..308e7d998 100644
--- a/mesh/util.c
+++ b/mesh/util.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,16 +6,6 @@
  *  Copyright (C) 2018  Intel Corporation. All rights reserved.
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
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/mesh/util.h b/mesh/util.h
index 93c2d8687..085ec3330 100644
--- a/mesh/util.h
+++ b/mesh/util.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -5,16 +6,6 @@
  *  Copyright (C) 2018  Intel Corporation. All rights reserved.
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
  */
 
 uint32_t get_timestamp_secs(void);
-- 
2.25.4

