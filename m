Return-Path: <cyrus@holtmann.org>
From: Marie Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Marie Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ] shared/ad: Fix license to be LGPL
Date: Mon, 28 Sep 2015 13:53:58 -0700
Message-Id: <1443473638-28118-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Code in the shared directory should be LGPL.  It was mistakenly
checked in as GPL.
---
 src/shared/ad.c | 18 +++++++++++-------
 src/shared/ad.h | 18 +++++++++++-------
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/src/shared/ad.c b/src/shared/ad.c
index 485bd7b..6259eb9 100644
--- a/src/shared/ad.c
+++ b/src/shared/ad.c
@@ -5,15 +5,19 @@
  *  Copyright (C) 2015  Google Inc.
  *
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
  *
- *  This program is distributed in the hope that it will be useful,
+ *  This library is distributed in the hope that it will be useful,
  *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  *
  */
 
diff --git a/src/shared/ad.h b/src/shared/ad.h
index 4b313ab..709563d 100644
--- a/src/shared/ad.h
+++ b/src/shared/ad.h
@@ -5,15 +5,19 @@
  *  Copyright (C) 2015  Google Inc.
  *
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
  *
- *  This program is distributed in the hope that it will be useful,
+ *  This library is distributed in the hope that it will be useful,
  *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  *
  */
 
-- 
2.6.0.rc2.230.g3dd15c0

