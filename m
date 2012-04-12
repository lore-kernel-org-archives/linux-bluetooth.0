Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH BlueZ 16/19] input: Fix newline before EOF
Date: Thu, 12 Apr 2012 20:33:07 +0530
Message-id: <1334243001-17016-17-git-send-email-s.syam@samsung.com>
In-reply-to: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
References: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 input/sixpair.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/input/sixpair.c b/input/sixpair.c
index 5c58b9b..5c50a58 100644
--- a/input/sixpair.c
+++ b/input/sixpair.c
@@ -296,4 +296,3 @@ int main (int argc, char **argv)
 
 	return 0;
 }
-
-- 
1.7.4.1

