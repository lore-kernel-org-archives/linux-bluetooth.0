Return-Path: <cyrus@holtmann.org>
Message-ID: <50659E54.5010206@gmx.de>
Date: Fri, 28 Sep 2012 14:55:48 +0200
From: Christian Cier-Zniewski <c.cier@gmx.de>
MIME-Version: 1.0
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v8 00/13] Heart Rate Profile plugin
References: <1348583267-16816-1-git-send-email-andrzej.kaczmarek@tieto.com> <20120928102503.GA25415@x220>
In-Reply-To: <20120928102503.GA25415@x220>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Johan,

On 28.09.2012 12:25, Johan Hedberg wrote:
>    Heart Rate Profile (HRP) client API
>
>   Makefile.am                    |   9 +-
>
> All patches in this set have been applied. Thanks.
>
>


I had to apply the following patch to get the heart rate profile working.
It is currently missing in HEAD although it was present in the patchset 
provided by Andrzej.

Christian

---

diff --git a/Makefile.am b/Makefile.am
index 3b37198..c27eb01 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -212,7 +212,7 @@ endif

  if GATTMODULES
  builtin_modules += thermometer alert time gatt_example proximity 
deviceinfo \
-                       gatt scanparam
+                       gatt scanparam heartrate
  builtin_sources += profiles/thermometer/main.c \
                         profiles/thermometer/manager.h \
                         profiles/thermometer/manager.c \



