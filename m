Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] Two small patches
From: =?UTF-8?Q?Przemys=C5=82aw?= Firszt <przemo@firszt.eu>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	Ping <pinglinux@gmail.com>,
	Peter Hutterer <peter.hutterer@who-t.net>
Content-Type: multipart/mixed; boundary="=-KkkwFvIg2IjVIGCgtmoU"
Date: Mon, 04 Jan 2010 23:17:18 +0000
Message-ID: <1262647038.2983.5.camel@pldmachine>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-KkkwFvIg2IjVIGCgtmoU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi,
2 patches:
- use defined variable is_proximity 
-remove duplicate comment from xf86WacomDefs.h

Those two are not important, but I don't want to leave it till later -
"the later" it might never happen.
--
Przemo

--=-KkkwFvIg2IjVIGCgtmoU
Content-Disposition: attachment; filename="0002-is_proximity-is-defined-so-let-s-use-it.patch"
Content-Type: text/x-patch; name="0002-is_proximity-is-defined-so-let-s-use-it.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From a1865a5f06f165a398d9a87d34c96b59b1d8660c Mon Sep 17 00:00:00 2001
From: Przemo Firszt <przemo@firszt.eu>
Date: Mon, 4 Jan 2010 19:25:20 +0000
Subject: [PATCH 2/3] is_proximity is defined, so let's use it

Signed-off-by: Przemo Firszt <przemo@firszt.eu>
---
 src/wcmCommon.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/wcmCommon.c b/src/wcmCommon.c
index 32ad82e..1c1cc2c 100644
--- a/src/wcmCommon.c
+++ b/src/wcmCommon.c
@@ -779,7 +779,7 @@ void xf86WcmSendEvents(LocalDevicePtr local, const WacomDeviceState* ds)
 	}
 
 	/* don't move the cursor when going out-prox */
-	if (!ds->proximity)
+	if (!is_proximity)
 	{
 		x = priv->oldX;
 		y = priv->oldY;
-- 
1.6.5.7


--=-KkkwFvIg2IjVIGCgtmoU
Content-Disposition: attachment; filename="0003-Remove-duplicate-comment-in-xf86WacomDefs.h.patch"
Content-Type: text/x-patch; name="0003-Remove-duplicate-comment-in-xf86WacomDefs.h.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From 714b4b3b989ae5a36b839bd4fe229999233cd192 Mon Sep 17 00:00:00 2001
From: Przemo Firszt <przemo@firszt.eu>
Date: Mon, 4 Jan 2010 23:13:06 +0000
Subject: [PATCH 3/3] Remove duplicate comment in xf86WacomDefs.h

Signed-off-by: Przemo Firszt <przemo@firszt.eu>
---
 src/xf86WacomDefs.h |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/src/xf86WacomDefs.h b/src/xf86WacomDefs.h
index 1e4a441..34a9375 100644
--- a/src/xf86WacomDefs.h
+++ b/src/xf86WacomDefs.h
@@ -324,10 +324,6 @@ struct _WacomChannel
 
 	WacomDeviceState work;                         /* next state */
 
-	/* the following struct contains the current known state of the
-	 * device channel, as well as the previous MAX_SAMPLES states
-	 * for use in detecting hardware defects, jitter, trends, etc. */
-
 	/* the following union contains the current known state of the
 	 * device channel, as well as the previous MAX_SAMPLES states
 	 * for use in detecting hardware defects, jitter, trends, etc. */
-- 
1.6.5.7


--=-KkkwFvIg2IjVIGCgtmoU--

