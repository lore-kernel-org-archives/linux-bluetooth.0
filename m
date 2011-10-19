Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] add unit/test-eir to .gitignore
Date: Wed, 19 Oct 2011 15:32:30 +0200
Message-Id: <1319031150-10454-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1319031150-10454-1-git-send-email-frederic.danis@linux.intel.com>
References: <1319031150-10454-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 .gitignore |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index c2fa9e9..4083b7c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -84,6 +84,7 @@ test/mpris-player
 compat/dund
 compat/hidd
 compat/pand
+unit/test-eir
 
 doc/*.bak
 doc/*.stamp
-- 
1.7.1

