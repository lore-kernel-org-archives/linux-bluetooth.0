Return-Path: <cyrus@holtmann.org>
From: chanyeol.park@samsung.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/3] adapter: Add warning if there is no authorization agent
Date: Mon, 16 Apr 2012 20:56:33 +0900
Message-id: <1334577394-577-2-git-send-email-chanyeol.park@samsung.com>
In-reply-to: <1334565413.16897.167.camel@aeonflux>
References: <1334565413.16897.167.camel@aeonflux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chan-yeol Park <chanyeol.park@samsung.com>

Sometimes BlueZ Agent is disappear suddenly or not registered
because of agent problem. but Bluez just prints "Operation Not
permiited"

This will help debugging.
---
 src/adapter.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index d10db10..a5bab34 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3107,6 +3107,7 @@ static int adapter_authorize(struct btd_adapter *adapter, const bdaddr_t *dst,
 
 	agent = device_get_agent(device);
 	if (!agent) {
+		warn("Can't find device agent");
 		g_free(auth);
 		return -EPERM;
 	}
-- 
1.7.5.4

