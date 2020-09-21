Return-Path: <SRS0=5m6h=C6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFB1C4363C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Sep 2020 19:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B1EB22262
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Sep 2020 19:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgIUTj0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Sep 2020 15:39:26 -0400
Received: from mga02.intel.com ([134.134.136.20]:55844 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbgIUTj0 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Sep 2020 15:39:26 -0400
IronPort-SDR: yQWklN+d6zeZogJvA3ve4bQGtun+2673bJjnbj0wyKA7yhdiy/mlP4ei7BDPxGujZ4Lmb3mpcU
 A9YifRXohRBA==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="148125419"
X-IronPort-AV: E=Sophos;i="5.77,287,1596524400"; 
   d="scan'208";a="148125419"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2020 12:39:26 -0700
IronPort-SDR: fVzGheHxjtRkIItC7o5+935/I0K+2waPD+6qi4InJyfd3vq4J7JUUkHE+7NiF+n+78PQhacEH1
 p322m2jd226Q==
X-IronPort-AV: E=Sophos;i="5.77,287,1596524400"; 
   d="scan'208";a="321917110"
Received: from han1-mobl3.jf.intel.com ([10.254.86.223])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2020 12:39:25 -0700
From:   tedd.an@linux.intel.com
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [BlueZ V4 RESEND 19/20] test: Add SPDX License Identifier
Date:   Mon, 21 Sep 2020 12:39:18 -0700
Message-Id: <20200921193918.47529-1-tedd.an@linux.intel.com>
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
 LGPL-2.1-or-later    :     35

License: LGPL-2.1-or-later
   test/agent.py
   test/bluezutils.py
   test/dbusdef.py
   test/example-advertisement
   test/example-endpoint
   test/example-gatt-client
   test/example-gatt-server
   test/example-player
   test/exchange-business-cards
   test/ftp-client
   test/get-managed-objects
   test/get-obex-capabilities
   test/list-devices
   test/list-folders
   test/map-client
   test/monitor-bluetooth
   test/opp-client
   test/pbap-client
   test/sap_client.py
   test/simple-endpoint
   test/simple-obex-agent
   test/simple-player
   test/test-adapter
   test/test-device
   test/test-discovery
   test/test-gatt-profile
   test/test-health
   test/test-health-sink
   test/test-hfp
   test/test-manager
   test/test-mesh
   test/test-nap
   test/test-network
   test/test-profile
   test/test-sap-server
---
 test/agent.py                |  1 +
 test/bluezutils.py           |  2 ++
 test/dbusdef.py              |  2 ++
 test/example-advertisement   |  1 +
 test/example-endpoint        |  1 +
 test/example-gatt-client     |  1 +
 test/example-gatt-server     |  1 +
 test/example-player          |  1 +
 test/exchange-business-cards |  1 +
 test/ftp-client              |  1 +
 test/get-managed-objects     |  1 +
 test/get-obex-capabilities   |  1 +
 test/list-devices            |  1 +
 test/list-folders            |  1 +
 test/map-client              |  1 +
 test/monitor-bluetooth       |  1 +
 test/opp-client              |  1 +
 test/pbap-client             |  1 +
 test/sap_client.py           | 15 +--------------
 test/simple-agent            |  1 +
 test/simple-endpoint         |  1 +
 test/simple-obex-agent       |  1 +
 test/simple-player           |  1 +
 test/test-adapter            |  1 +
 test/test-device             |  1 +
 test/test-discovery          |  1 +
 test/test-gatt-profile       |  1 +
 test/test-health             |  1 +
 test/test-health-sink        |  1 +
 test/test-hfp                |  1 +
 test/test-join               |  1 +
 test/test-manager            |  1 +
 test/test-mesh               |  1 +
 test/test-nap                |  1 +
 test/test-network            |  1 +
 test/test-profile            |  1 +
 test/test-sap-server         |  1 +
 37 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/test/agent.py b/test/agent.py
index d8e5534d8..b46cd95f4 100755
--- a/test/agent.py
+++ b/test/agent.py
@@ -1,4 +1,5 @@
 #!/usr/bin/python3
+# SPDX-License-Identifier: LGPL-2.1-or-later
 
 import sys
 import dbus
diff --git a/test/bluezutils.py b/test/bluezutils.py
index cd8964082..85aa24277 100644
--- a/test/bluezutils.py
+++ b/test/bluezutils.py
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: LGPL-2.1-or-later
+
 import dbus
 
 SERVICE_NAME = "org.bluez"
diff --git a/test/dbusdef.py b/test/dbusdef.py
index f1cd35adb..d317c18de 100644
--- a/test/dbusdef.py
+++ b/test/dbusdef.py
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: LGPL-2.1-or-later
+
 import dbus
 import bluezutils
 
diff --git a/test/example-advertisement b/test/example-advertisement
index 96e410683..5f022ee67 100755
--- a/test/example-advertisement
+++ b/test/example-advertisement
@@ -1,4 +1,5 @@
 #!/usr/bin/python
+# SPDX-License-Identifier: LGPL-2.1-or-later
 
 from __future__ import print_function
 
diff --git a/test/example-endpoint b/test/example-endpoint
index a5f0348a0..16651c683 100644
--- a/test/example-endpoint
+++ b/test/example-endpoint
@@ -1,4 +1,5 @@
 #!/usr/bin/python
+# SPDX-License-Identifier: LGPL-2.1-or-later
 
 from __future__ import absolute_import, print_function, unicode_literals
 
diff --git a/test/example-gatt-client b/test/example-gatt-client
index b4bbaa9d9..5e6bef9d7 100755
--- a/test/example-gatt-client
+++ b/test/example-gatt-client
@@ -1,4 +1,5 @@
 #!/usr/bin/env python3
+# SPDX-License-Identifier: LGPL-2.1-or-later
 
 import dbus
 try:
diff --git a/test/example-gatt-server b/test/example-gatt-server
index 689e86ff7..77231c3ad 100755
--- a/test/example-gatt-server
+++ b/test/example-gatt-server
@@ -1,4 +1,5 @@
 #!/usr/bin/env python3
+# SPDX-License-Identifier: LGPL-2.1-or-later
 
 import dbus
 import dbus.exceptions
diff --git a/test/example-player b/test/example-player
index 2beb08e44..1497d1107 100644
--- a/test/example-player
+++ b/test/example-player
@@ -1,4 +1,5 @@
 #!/usr/bin/python
+# SPDX-License-Identifier: LGPL-2.1-or-later
 
 from __future__ import print_function
 
diff --git a/test/exchange-business-cards b/test/exchange-business-cards
index 6805cf71e..9a3aa29fb 100755
--- a/test/exchange-business-cards
+++ b/test/exchange-business-cards
@@ -1,4 +1,5 @@
 #!/usr/bin/python
+# SPDX-License-Identifier: LGPL-2.1-or-later
 
 import sys
 import dbus
diff --git a/test/ftp-client b/test/ftp-client
index 4540602a0..ef756ab2b 100755
--- a/test/ftp-client
+++ b/test/ftp-client
@@ -1,4 +1,5 @@
 #!/usr/bin/python
+# SPDX-License-Identifier: LGPL-2.1-or-later
 
 from __future__ import absolute_import, print_function, unicode_literals
 
diff --git a/test/get-managed-objects b/test/get-managed-objects
index 3156f658f..5125ee524 100755
--- a/test/get-managed-objects
+++ b/test/get-managed-objects
@@ -1,4 +1,5 @@
 #!/usr/bin/python
+# SPDX-License-Identifier: LGPL-2.1-or-later
 
 from __future__ import absolute_import, print_function, unicode_literals
 
diff --git a/test/get-obex-capabilities b/test/get-obex-capabilities
index e8afbad21..a7980a442 100755
--- a/test/get-obex-capabilities
+++ b/test/get-obex-capabilities
@@ -1,4 +1,5 @@
 #!/usr/bin/python
+# SPDX-License-Identifier: LGPL-2.1-or-later
 
 import sys
 import dbus
diff --git a/test/list-devices b/test/list-devices
index 0aac217d1..b112556c3 100755
--- a/test/list-devices
+++ b/test/list-devices
@@ -1,4 +1,5 @@
 #!/usr/bin/python
+# SPDX-License-Identifier: LGPL-2.1-or-later
 
 from __future__ import absolute_import, print_function, unicode_literals
 
diff --git a/test/list-folders b/test/list-folders
index 7321a1527..b4e3f100b 100755
--- a/test/list-folders
+++ b/test/list-folders
@@ -1,4 +1,5 @@
 #!/usr/bin/python
+# SPDX-License-Identifier: LGPL-2.1-or-later
 
 import sys
 import dbus
diff --git a/test/map-client b/test/map-client
index b9695da66..a2d96ae5f 100755
--- a/test/map-client
+++ b/test/map-client
@@ -1,4 +1,5 @@
 #!/usr/bin/python
+# SPDX-License-Identifier: LGPL-2.1-or-later
 
 from __future__ import absolute_import, print_function, unicode_literals
 
diff --git a/test/monitor-bluetooth b/test/monitor-bluetooth
index d9b5472f5..a3977e206 100755
--- a/test/monitor-bluetooth
+++ b/test/monitor-bluetooth
@@ -1,4 +1,5 @@
 #!/usr/bin/python
+# SPDX-License-Identifier: LGPL-2.1-or-later
 
 from __future__ import absolute_import, print_function, unicode_literals
 
diff --git a/test/opp-client b/test/opp-client
index 62d5b8454..4f00a41c0 100755
--- a/test/opp-client
+++ b/test/opp-client
@@ -1,4 +1,5 @@
 #!/usr/bin/python
+# SPDX-License-Identifier: LGPL-2.1-or-later
 
 from __future__ import absolute_import, print_function, unicode_literals
 
diff --git a/test/pbap-client b/test/pbap-client
index 16a786bb1..e6cafdd30 100755
--- a/test/pbap-client
+++ b/test/pbap-client
@@ -1,4 +1,5 @@
 #!/usr/bin/python
+# SPDX-License-Identifier: LGPL-2.1-or-later
 
 from __future__ import absolute_import, print_function, unicode_literals
 
diff --git a/test/sap_client.py b/test/sap_client.py
index 413424c05..fed13aedc 100644
--- a/test/sap_client.py
+++ b/test/sap_client.py
@@ -1,21 +1,8 @@
+# SPDX-License-Identifier: LGPL-2.1-or-later
 """ Copyright (C) 2010-2011 ST-Ericsson SA """
 
 """ Author: Szymon Janc <szymon.janc@tieto.com> for ST-Ericsson. """
 
-""" This program is free software; you can redistribute it and/or modify """
-""" it under the terms of the GNU General Public License as published by """
-""" the Free Software Foundation; either version 2 of the License, or """
-""" (at your option) any later version. """
-
-""" This program is distributed in the hope that it will be useful, """
-""" but WITHOUT ANY WARRANTY; without even the implied warranty of """
-""" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the """
-""" GNU General Public License for more details. """
-
-""" You should have received a copy of the GNU General Public License """
-""" along with this program; if not, write to the Free Software """
-""" Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA """
-
 from array import array
 from bluetooth import *
 import time
diff --git a/test/simple-agent b/test/simple-agent
index a69299a3e..4fdaff1eb 100755
--- a/test/simple-agent
+++ b/test/simple-agent
@@ -1,4 +1,5 @@
 #!/usr/bin/python
+# SPDX-License-Identifier: LGPL-2.1-or-later
 
 from __future__ import absolute_import, print_function, unicode_literals
 
diff --git a/test/simple-endpoint b/test/simple-endpoint
index 78fb5fda5..59ca189ce 100755
--- a/test/simple-endpoint
+++ b/test/simple-endpoint
@@ -1,4 +1,5 @@
 #!/usr/bin/python
+# SPDX-License-Identifier: LGPL-2.1-or-later
 
 from __future__ import absolute_import, print_function, unicode_literals
 
diff --git a/test/simple-obex-agent b/test/simple-obex-agent
index 05ec4eda7..064f6d30b 100755
--- a/test/simple-obex-agent
+++ b/test/simple-obex-agent
@@ -1,4 +1,5 @@
 #!/usr/bin/python
+# SPDX-License-Identifier: LGPL-2.1-or-later
 
 from __future__ import absolute_import, print_function, unicode_literals
 
diff --git a/test/simple-player b/test/simple-player
index 02754c2f4..92682844d 100755
--- a/test/simple-player
+++ b/test/simple-player
@@ -1,4 +1,5 @@
 #!/usr/bin/python
+# SPDX-License-Identifier: LGPL-2.1-or-later
 
 from __future__ import print_function
 
diff --git a/test/test-adapter b/test/test-adapter
index 959a43703..a216140ba 100755
--- a/test/test-adapter
+++ b/test/test-adapter
@@ -1,4 +1,5 @@
 #!/usr/bin/python
+# SPDX-License-Identifier: LGPL-2.1-or-later
 
 from __future__ import absolute_import, print_function, unicode_literals
 
diff --git a/test/test-device b/test/test-device
index b490d53f4..a1e508166 100755
--- a/test/test-device
+++ b/test/test-device
@@ -1,4 +1,5 @@
 #!/usr/bin/python
+# SPDX-License-Identifier: LGPL-2.1-or-later
 
 from __future__ import absolute_import, print_function, unicode_literals
 
diff --git a/test/test-discovery b/test/test-discovery
index cea77683d..eccc7c7e3 100755
--- a/test/test-discovery
+++ b/test/test-discovery
@@ -1,4 +1,5 @@
 #!/usr/bin/python
+# SPDX-License-Identifier: LGPL-2.1-or-later
 
 from __future__ import absolute_import, print_function, unicode_literals
 
diff --git a/test/test-gatt-profile b/test/test-gatt-profile
index 995a65913..a973ae14e 100755
--- a/test/test-gatt-profile
+++ b/test/test-gatt-profile
@@ -1,4 +1,5 @@
 #!/usr/bin/python
+# SPDX-License-Identifier: LGPL-2.1-or-later
 
 from __future__ import absolute_import, print_function, unicode_literals
 
diff --git a/test/test-health b/test/test-health
index 24afa799e..d6b437ed8 100755
--- a/test/test-health
+++ b/test/test-health
@@ -1,4 +1,5 @@
 #!/usr/bin/python
+# SPDX-License-Identifier: LGPL-2.1-or-later
 
 from __future__ import absolute_import, print_function, unicode_literals
 # -*- coding: utf-8 -*-
diff --git a/test/test-health-sink b/test/test-health-sink
index 37e630a21..57665d2ba 100755
--- a/test/test-health-sink
+++ b/test/test-health-sink
@@ -1,4 +1,5 @@
 #!/usr/bin/python
+# SPDX-License-Identifier: LGPL-2.1-or-later
 
 from __future__ import absolute_import, print_function, unicode_literals
 # -*- coding: utf-8 -*-
diff --git a/test/test-hfp b/test/test-hfp
index a8060439e..11e328e54 100755
--- a/test/test-hfp
+++ b/test/test-hfp
@@ -1,4 +1,5 @@
 #!/usr/bin/python
+# SPDX-License-Identifier: LGPL-2.1-or-later
 
 from __future__ import absolute_import, print_function, unicode_literals
 
diff --git a/test/test-join b/test/test-join
index 6dfb2e8c3..969795094 100644
--- a/test/test-join
+++ b/test/test-join
@@ -1,4 +1,5 @@
 #!/usr/bin/env python3
+# SPDX-License-Identifier: LGPL-2.1-or-later
 
 import sys
 import struct
diff --git a/test/test-manager b/test/test-manager
index 4f5994f67..3fa7205a0 100755
--- a/test/test-manager
+++ b/test/test-manager
@@ -1,4 +1,5 @@
 #!/usr/bin/python
+# SPDX-License-Identifier: LGPL-2.1-or-later
 
 from __future__ import absolute_import, print_function, unicode_literals
 
diff --git a/test/test-mesh b/test/test-mesh
index 1e1b8724d..9e4783734 100755
--- a/test/test-mesh
+++ b/test/test-mesh
@@ -1,4 +1,5 @@
 #!/usr/bin/env python3
+# SPDX-License-Identifier: LGPL-2.1-or-later
 
 ###################################################################
 #
diff --git a/test/test-nap b/test/test-nap
index ab67a7509..d5c757b79 100755
--- a/test/test-nap
+++ b/test/test-nap
@@ -1,4 +1,5 @@
 #!/usr/bin/python
+# SPDX-License-Identifier: LGPL-2.1-or-later
 
 from __future__ import absolute_import, print_function, unicode_literals
 
diff --git a/test/test-network b/test/test-network
index 6f0948649..acc7dff65 100755
--- a/test/test-network
+++ b/test/test-network
@@ -1,4 +1,5 @@
 #!/usr/bin/python
+# SPDX-License-Identifier: LGPL-2.1-or-later
 
 from __future__ import absolute_import, print_function, unicode_literals
 
diff --git a/test/test-profile b/test/test-profile
index 27915806f..af1e23f76 100755
--- a/test/test-profile
+++ b/test/test-profile
@@ -1,4 +1,5 @@
 #!/usr/bin/python
+# SPDX-License-Identifier: LGPL-2.1-or-later
 
 from __future__ import absolute_import, print_function, unicode_literals
 
diff --git a/test/test-sap-server b/test/test-sap-server
index ff178af22..ddb1efe9b 100755
--- a/test/test-sap-server
+++ b/test/test-sap-server
@@ -1,4 +1,5 @@
 #!/usr/bin/python
+# SPDX-License-Identifier: LGPL-2.1-or-later
 
 from __future__ import absolute_import, print_function, unicode_literals
 
-- 
2.25.4

