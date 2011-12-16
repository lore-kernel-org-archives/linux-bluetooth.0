Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 09/11] attrib-server: Mark attrib_channel_detach as deprecated
Date: Fri, 16 Dec 2011 17:09:57 +0100
Message-Id: <1324051799-21439-10-git-send-email-sancane@gmail.com>
In-Reply-To: <1324051799-21439-9-git-send-email-sancane@gmail.com>
References: <1324051799-21439-1-git-send-email-sancane@gmail.com>
 <1324051799-21439-2-git-send-email-sancane@gmail.com>
 <1324051799-21439-3-git-send-email-sancane@gmail.com>
 <1324051799-21439-4-git-send-email-sancane@gmail.com>
 <1324051799-21439-5-git-send-email-sancane@gmail.com>
 <1324051799-21439-6-git-send-email-sancane@gmail.com>
 <1324051799-21439-7-git-send-email-sancane@gmail.com>
 <1324051799-21439-8-git-send-email-sancane@gmail.com>
 <1324051799-21439-9-git-send-email-sancane@gmail.com>
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
index 61bb05b..0414ff7 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -1433,6 +1433,8 @@ int attrib_gap_set(uint16_t uuid, const uint8_t *value, int len)
 {
 	uint16_t handle;
 
+	DBG("Deprecated function!");
+
 	/* FIXME: Missing Privacy and Reconnection Address */
 
 	switch (uuid) {
-- 
1.7.8

