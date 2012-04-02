Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH v2 BlueZ] adapter: Fix segfault when icon is uninitialized
Date: Mon,  2 Apr 2012 16:05:22 -0400
Message-Id: <1333397122-22456-1-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1333394427-9803-1-git-send-email-bruna.moreira@openbossa.org>
References: <1333394427-9803-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If device type is LE and GAP Appearance characteristic does not exist,
the icon will not be initialized.
---
 src/adapter.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index f8f46f8..6afeaad 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2710,6 +2710,8 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
 		if (read_remote_appearance(&adapter->bdaddr, &dev->bdaddr,
 								&app) == 0)
 			icon = gap_appearance_to_icon(app);
+		else
+			icon = NULL;
 
 		emit_device_found(adapter->path, paddr,
 				"Address", DBUS_TYPE_STRING, &paddr,
-- 
1.7.5.4

