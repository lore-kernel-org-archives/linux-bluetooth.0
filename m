Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20161004142203.GA25818@x1c>
References: <CABi8O6YW-wmG8xF5V7vkGJ8_3Wp98-b57L+1jJK_DxWjz=couQ@mail.gmail.com>
 <CABBYNZ++wDB=Hy6YNXo-UU2xiVEazSHGKd60+=1XNk8yTWKcfw@mail.gmail.com>
 <CABi8O6ZVU5--Kd467Xcg0j-_9noSqXrdhiT=pDcMS3JQcN0eAQ@mail.gmail.com>
 <CABi8O6a+tKHXNqvM43RFuc4TYgpB3tHmaALEtJXXutkZDWS2-w@mail.gmail.com> <20161004142203.GA25818@x1c>
From: Ilya Averyanov <averyanovin@gmail.com>
Date: Tue, 4 Oct 2016 18:24:31 +0300
Message-ID: <CABi8O6YbqHw6U8yD_LuzmoHgrHD3+SqzCZGq6ye-tFqjHN7Xgw@mail.gmail.com>
Subject: Re: [PATCH SBC] Fix for build on windows mingw
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From b2fdd53da7c684b56580c1332a25507530a5702e Mon Sep 17 00:00:00 2001
From: Ilya Averyanov <averyanovin@gmail.com>
Date: Tue, 4 Oct 2016 17:47:17 +0300
Subject: [PATCH] Fix error for build on windows mingw

Errors occur because int32_t type and other types define only in
stdint.h and mingw not include this file by default
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


2016-10-04 17:22 GMT+03:00 Johan Hedberg <johan.hedberg@gmail.com>:
> Hi Ilya,
>
> On Tue, Oct 04, 2016, Ilya Averyanov wrote:
>> What about the patch?
>
> I think Luiz meant for you to resend the patch with the added
> information in the commit message. You can adjust the commit message in
> your local tree using git commit --amend.
>
> Johan
