Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [RFC BlueZ 11/33] mgmt: Add set broadcaster command
Date: Mon, 27 Aug 2012 13:03:03 -0400
Message-Id: <1346087005-24693-12-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1346087005-24693-1-git-send-email-bruna.moreira@openbossa.org>
References: <1346087005-24693-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jefferson Delfes <jefferson.delfes@openbossa.org>

Implement Set Broadcaster support in MGMT API. Setting TRUE will make
the new data sent by Set Controller Data command to be set in adapter
and the advertising will start. Stop the advertising setting FALSE.
---
 src/mgmt.c |    5 +++++
 src/mgmt.h |    1 +
 2 files changed, 6 insertions(+)

diff --git a/src/mgmt.c b/src/mgmt.c
index 0ff1d71..3d3a8f7 100644
--- a/src/mgmt.c
+++ b/src/mgmt.c
@@ -2045,6 +2045,11 @@ int mgmt_set_fast_connectable(int index, gboolean enable)
 	return 0;
 }
 
+int mgmt_set_broadcaster(int index, gboolean enable)
+{
+	return mgmt_set_mode(index, MGMT_OP_SET_BROADCASTER, enable);
+}
+
 int mgmt_set_observer(int index, gboolean enable)
 {
 	return mgmt_set_mode(index, MGMT_OP_SET_OBSERVER, enable);
diff --git a/src/mgmt.h b/src/mgmt.h
index 7a21f37..e77a804 100644
--- a/src/mgmt.h
+++ b/src/mgmt.h
@@ -31,6 +31,7 @@ int mgmt_set_pairable(int index, gboolean pairable);
 int mgmt_set_name(int index, const char *name);
 int mgmt_set_dev_class(int index, uint8_t major, uint8_t minor);
 int mgmt_set_fast_connectable(int index, gboolean enable);
+int mgmt_set_broadcaster(int index, gboolean enable);
 int mgmt_set_observer(int index, gboolean enable);
 
 int mgmt_start_discovery(int index);
-- 
1.7.9.5

