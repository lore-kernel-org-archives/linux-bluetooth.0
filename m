Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 7/8] attrib-server: Mark attrib_channel_detach as deprecated
Date: Tue, 27 Dec 2011 15:33:18 +0100
Message-Id: <1324996399-20245-8-git-send-email-sancane@gmail.com>
In-Reply-To: <1324996399-20245-7-git-send-email-sancane@gmail.com>
References: <1324996399-20245-1-git-send-email-sancane@gmail.com>
 <1324996399-20245-2-git-send-email-sancane@gmail.com>
 <1324996399-20245-3-git-send-email-sancane@gmail.com>
 <1324996399-20245-4-git-send-email-sancane@gmail.com>
 <1324996399-20245-5-git-send-email-sancane@gmail.com>
 <1324996399-20245-6-git-send-email-sancane@gmail.com>
 <1324996399-20245-7-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

All public attrib-server functions are marked as deprecated until
they expose adapter facilities to operate with. This is a
transactional patch toward multiple adapter support is implemented.
All those functions use default adaptar in order to keep backward
compatibility.
---
 src/attrib-server.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 219c7c9..3a3eebb 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -1402,6 +1402,8 @@ int attrib_gap_set(uint16_t uuid, const uint8_t *value, int len)
 {
 	uint16_t handle;
 
+	DBG("Deprecated function!");
+
 	/* FIXME: Missing Privacy and Reconnection Address */
 
 	switch (uuid) {
-- 
1.7.8.1

