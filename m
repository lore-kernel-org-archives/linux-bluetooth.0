Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Ilya Averyanov <averyanovin@gmail.com>
Date: Tue, 2 Aug 2016 18:14:56 +0300
Message-ID: <CABi8O6YW-wmG8xF5V7vkGJ8_3Wp98-b57L+1jJK_DxWjz=couQ@mail.gmail.com>
Subject: [PATCH SBC] Fix for build on windows mingw
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 sbc/sbc_math.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sbc/sbc_math.h b/sbc/sbc_math.h
index 5476860..25b08ea 100644
--- a/sbc/sbc_math.h
+++ b/sbc/sbc_math.h
@@ -24,6 +24,8 @@
  *
  */

+#include <stdint.h>
+
 #define fabs(x) ((x) < 0 ? -(x) : (x))
 /* C does not provide an explicit arithmetic shift right but this will
    always be correct and every compiler *should* generate optimal code */
-- 
2.7.4
