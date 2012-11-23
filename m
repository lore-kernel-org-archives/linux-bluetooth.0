Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 2/2] hog: Fix output report
Date: Fri, 23 Nov 2012 16:08:29 -0300
Message-Id: <1353697709-6497-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1353697709-6497-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1353697709-6497-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Even if we receive the output report with the report id included, we
must send the output report without the report id, as the remote side
is able to infer it using the handle.
---
 profiles/input/hog_device.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/profiles/input/hog_device.c b/profiles/input/hog_device.c
index 994437f..0a5fb58 100644
--- a/profiles/input/hog_device.c
+++ b/profiles/input/hog_device.c
@@ -549,8 +549,13 @@ static void forward_report(struct hog_device *hogdev,
 	int size;
 	guint type;
 
-	data = ev->u.output.data;
-	size = ev->u.output.size;
+	if (hogdev->prepend_id) {
+		data = ev->u.output.data + 1;
+		size = ev->u.output.size - 1;
+	} else {
+		data = ev->u.output.data;
+		size = ev->u.output.size;
+	}
 
 	switch (ev->type) {
 	case UHID_OUTPUT:
-- 
1.8.0

