Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 3/4] TODO: Add item related to UUID handling
Date: Mon, 28 Feb 2011 10:44:12 -0300
Message-Id: <1298900653-7567-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1298900653-7567-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1298900653-7567-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 TODO |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index cf37179..9f899b0 100644
--- a/TODO
+++ b/TODO
@@ -17,6 +17,19 @@ Background
 General
 ==========
 
+- UUID128 handling: Create new functions to handle UUIDs on host order.
+  Functions should start with prefix "bt_uuid". In the first phase, attribute
+  server/client and gatttool code should be changed to use these new functions.
+  The idea is to keep the consistency for UUID-16, UUID-32 and UUID-128. SDP
+  functions store UUID-16 and UUID-32 on host order, however UUID-128 is stored
+  on network order/big endian. Attribute Protocol uses little endian, while
+  SDP uses big endian. The idea is always store the UUID values on host order
+  and use utility functions to convert to the proper byte order depending on
+  the protocol: ATT or SDP.
+
+  Priority: high
+  Complexity: C1
+
 - Rename glib-helper file to a more convenient name. The ideia is try to keep
   only sdp helpers functions. bt_* prefix shall be also changed.
 
-- 
1.7.4.1

