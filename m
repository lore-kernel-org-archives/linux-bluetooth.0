Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Gix, Brian" <brian.gix@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH 1/2] Add test-midi to ignore list
Date: Tue, 24 Jan 2017 18:03:22 +0000
Message-ID: <DEBB0CAA2616974FAE35E4B560B9A43722783FAC@ORSMSX103.amr.corp.intel.com>
References: <1485277866-7071-1-git-send-email-brian.git@intel.com>
In-Reply-To: <1485277866-7071-1-git-send-email-brian.git@intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


For the record, my surname is "gix" and not "git", regardless of what the email below might indicate. I have made that error before, and am certain to make it again... just not on this dev environment.

-----Original Message-----
From: Brian Gix [mailto:brian.git@intel.com] 
Sent: Tuesday, January 24, 2017 9:11 AM
To: linux-bluetooth@vger.kernel.org
Cc: Gix, Brian <brian.gix@intel.com>
Subject: [PATCH 1/2] Add test-midi to ignore list

From: Brian Gix <brian.gix@intel.com>

---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 6257505..c0745b4 100644
--- a/.gitignore
+++ b/.gitignore
@@ -138,6 +138,7 @@ unit/test-avdtp
 unit/test-avctp
 unit/test-avrcp
 unit/test-gatt
+unit/test-midi
 unit/test-gattrib
 unit/test-*.log
 unit/test-*.trs
-- 
1.9.1

