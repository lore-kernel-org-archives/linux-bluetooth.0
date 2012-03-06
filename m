Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] Add emulator/btvirt to .gitignore
Date: Tue,  6 Mar 2012 16:46:54 -0400
Message-Id: <1331066814-28704-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 .gitignore |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 3db5fd4..137d2e5 100644
--- a/.gitignore
+++ b/.gitignore
@@ -86,6 +86,7 @@ compat/pand
 unit/test-eir
 mgmt/btmgmt
 monitor/btmon
+emulator/btvirt
 
 doc/*.bak
 doc/*.stamp
-- 
1.7.5.4

