Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Francois Beaufort <beaufort.francois@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] Fix nit in HACKING instructions
Date: Wed, 20 Apr 2016 11:25:17 +0200
Message-Id: <1461144317-20684-2-git-send-email-beaufort.francois@gmail.com>
In-Reply-To: <1461144317-20684-1-git-send-email-beaufort.francois@gmail.com>
References: <1461144317-20684-1-git-send-email-beaufort.francois@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 HACKING | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/HACKING b/HACKING
index 28f1009..d93730d 100644
--- a/HACKING
+++ b/HACKING
@@ -146,12 +146,12 @@ backtraces, compiler errors, etc.
 
   # git config format.subjectprefix "PATCH BlueZ"
 
-6) Add a cover letter when introducing a new feature explaning what problem
+7) Add a cover letter when introducing a new feature explaning what problem
 you're trying to solve:
 
   # git format-patch --cover-letter -M origin/master -o outgoing/
   # edit outgoing/0000-*
 
-7) Submit:
+8) Submit:
 
   # git send-email outgoing/*
-- 
2.7.0

