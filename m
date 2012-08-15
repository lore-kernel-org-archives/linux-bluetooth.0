Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 10/10] gap: Don't store Appearance if value is "unknown"
Date: Wed, 15 Aug 2012 11:20:07 -0300
Message-Id: <1345040407-17767-11-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1345040407-17767-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1345040407-17767-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Core SPEC is not clear regarding the behaviour or the Appearance
characteristic. According to the SPEC, the Appearance characteristic
should be readable without authentication or authorization. This patch
will keep the Appearance characteristic value refresh (read) on every
re-connection if the value is 0x0000.
---
 profiles/gap/gap.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/profiles/gap/gap.c b/profiles/gap/gap.c
index ff5715b..596d0b9 100644
--- a/profiles/gap/gap.c
+++ b/profiles/gap/gap.c
@@ -98,6 +98,9 @@ static void appearance_cb(guint8 status, const guint8 *pdu, guint16 plen,
 
 	device_set_appearance(gap->device, app);
 
+	if (app == 0x0000)
+		goto done;
+
 	adapter_get_address(device_get_adapter(gap->device), &src);
 	device_get_address(gap->device, &dst, &type);
 
-- 
1.7.8.6

