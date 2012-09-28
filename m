Return-Path: <cyrus@holtmann.org>
Message-ID: <5065AF25.4020309@gmx.de>
Date: Fri, 28 Sep 2012 16:07:33 +0200
From: Christian Cier-Zniewski <c.cier@gmx.de>
MIME-Version: 1.0
To: johan.hedberg@gmail.com
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v8 00/13] Heart Rate Profile plugin
References: <1348583267-16816-1-git-send-email-andrzej.kaczmarek@tieto.com> <20120928102503.GA25415@x220> <50659E54.5010206@gmx.de> <20120928131647.GA4026@x220>
In-Reply-To: <20120928131647.GA4026@x220>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Am 28.09.2012 15:16, schrieb Johan Hedberg:
> The Makefile.am changes had conflicts because of other GATT profiles I 
> applied earlier, so I had to completely manually fix this and probably 
> made some mistake. Could you please send a proper git patch for this 
> and I'll apply it? Johan 

Enable heart rate profile in Makefile.am.

---
  Makefile.am |    2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

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
--
1.7.10.4

