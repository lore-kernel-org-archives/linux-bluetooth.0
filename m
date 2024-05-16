Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94618143723
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 09:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715850233; cv=none; b=uMFjekW/rypUxXIDes9sQMTPT71ELJAvyM58xKsXCSRKA0c8sVawj23o8CyKmhd6y7s6t7BOc+cQRjG41guGq/DRa7CFNGFBzwHQjWifDSJGgpK53HqWIunO9i0FMNxmvAcywZ72/YGfBmEMMlbkEjWFvFEBVnoSFLejuw6ncd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715850233; c=relaxed/simple;
	bh=Jk9CuUK1Vq4XCmvzya9AeYL6PQDfubXCa0q6QxXAV2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G6vV914t1tAstgTJK+S7KWuYvsWJKkOOZNxa53p99NajrkCIpfD2hNf2ho+ZqG++YtlTSZjQNMRQymhXTFvuVG+kMv5BXpQI7Nb58VmmkKbs4ssYGuSgYVrGvGvn2OKsGCnhjmS3V2U381ejQAEYSuzXowMNLrYrHny+SG7GYPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id D63DB1C001A;
	Thu, 16 May 2024 09:03:44 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 13/15] gdbus: Check sprintf retval
Date: Thu, 16 May 2024 11:03:17 +0200
Message-ID: <20240516090340.61417-14-hadess@hadess.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240516090340.61417-1-hadess@hadess.net>
References: <20240516090340.61417-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Error: SNYK_CODE_WARNING (CWE-125): [#def63] [important]
bluez-5.75/gdbus/watch.c:131:11: error[cpp/NegativeIndex]: The value from snprintf, a standard library function that can return a negative value is used as an index. A negative array index can lead to reading or writing outside the bounds of the array. Ensure the value of the index used is within bounds before use.
129|	int offset;
130|
131|->	offset = snprintf(rule, size, "type='signal'");
132|	sender = data->name ? : data->owner;
133|
---
 gdbus/watch.c | 46 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/gdbus/watch.c b/gdbus/watch.c
index 25f367613a52..22f77ea72861 100644
--- a/gdbus/watch.c
+++ b/gdbus/watch.c
@@ -123,29 +123,51 @@ static struct filter_data *filter_data_find(DBusConnection *connection)
 	return NULL;
 }
 
-static void format_rule(struct filter_data *data, char *rule, size_t size)
+static gboolean format_rule(struct filter_data *data, char *rule, size_t size)
 {
 	const char *sender;
-	int offset;
+	int offset, ret;
 
 	offset = snprintf(rule, size, "type='signal'");
+	if (offset < 0)
+		return FALSE;
 	sender = data->name ? : data->owner;
 
-	if (sender)
-		offset += snprintf(rule + offset, size - offset,
+	if (sender) {
+		ret = snprintf(rule + offset, size - offset,
 				",sender='%s'", sender);
-	if (data->path)
-		offset += snprintf(rule + offset, size - offset,
+		if (ret < 0)
+			return FALSE;
+		offset += ret;
+	}
+	if (data->path) {
+		ret = snprintf(rule + offset, size - offset,
 				",path='%s'", data->path);
-	if (data->interface)
-		offset += snprintf(rule + offset, size - offset,
+		if (ret < 0)
+			return FALSE;
+		offset += ret;
+	}
+	if (data->interface) {
+		ret = snprintf(rule + offset, size - offset,
 				",interface='%s'", data->interface);
-	if (data->member)
-		offset += snprintf(rule + offset, size - offset,
+		if (ret < 0)
+			return FALSE;
+		offset += ret;
+	}
+	if (data->member) {
+		ret = snprintf(rule + offset, size - offset,
 				",member='%s'", data->member);
-	if (data->argument)
-		snprintf(rule + offset, size - offset,
+		if (ret < 0)
+			return FALSE;
+		offset += ret;
+	}
+	if (data->argument) {
+		ret = snprintf(rule + offset, size - offset,
 				",arg0='%s'", data->argument);
+		if (ret < 0)
+			return FALSE;
+	}
+	return TRUE;
 }
 
 static gboolean add_match(struct filter_data *data,
-- 
2.44.0

