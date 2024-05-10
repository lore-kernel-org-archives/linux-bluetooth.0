Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3793F1635CA
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 09:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332706; cv=none; b=PyhGKnsGE831NUmR9mXOqHfhZP4Y38aUWpJWFu2mPbIjuHj6NxumcphpmcsdePhUYIKGOG4JKJUrnIkIgSObA8tNs1x80kd0bok8cMLRoph8dvJjXDiF+yh6a2dbgobizf7uWwYuLfy0gwV/oClPZkMMaz2REMWXaafiiypUb9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332706; c=relaxed/simple;
	bh=qz8dsn86PoKyiEMWJOJVKAKfMqx70ZUJV6tnXXFCHS0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJbtMydpaXg9fOshsGKL/lJYubog/fFRKW+qcDF2HBQLhcJa/GO996T2tUKpPZVkKbprVbZnHRj2zbnBiQISAUciVUTXUsYfAF4L90rhqTrpxG9G86IM4H/y812cLN9zSB8PbgR053JD1zbNXcIiddoSe2lbtcAwPjFoJfYNneI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id BFD8A1BF20A
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 09:18:15 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ 02/14] attrib/gatt: Guard against possible integer overflow
Date: Fri, 10 May 2024 11:11:00 +0200
Message-ID: <20240510091814.3172988-3-hadess@hadess.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240510091814.3172988-1-hadess@hadess.net>
References: <20240510091814.3172988-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Error: INTEGER_OVERFLOW (CWE-190): [#def30]
bluez-5.75/attrib/gatt.c:1016:2: known_value_assign: "last" = "65535", its value is now 65535.
bluez-5.75/attrib/gatt.c:1087:2: overflow_const: Expression "dd->start", which is equal to 65536, where "last + 1" is known to be equal to 65536, overflows the type that receives it, an unsigned integer 16 bits wide.
1085|		}
1086|
1087|->		dd->start = last + 1;
1088|
1089|		if (last < dd->end && !uuid_found) {
---
 attrib/gatt.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index b496dd1ebd95..3cedae9d167a 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -1076,10 +1076,12 @@ static void desc_discovered_cb(guint8 status, const guint8 *ipdu,
 	att_data_list_free(list);
 
 	/*
-	 * If last handle is lower from previous start handle then it is smth
-	 * wrong. Let's stop search, otherwise we might enter infinite loop.
+	 * If last handle is lower from previous start handle or if iterating
+	 * to the next handle from the last possible offset would overflow, then
+	 * something is wrong. Let's stop search, otherwise we might enter
+	 * infinite loop.
 	 */
-	if (last < dd->start) {
+	if (last < dd->start || last == G_MAXUINT16) {
 		err = ATT_ECODE_UNLIKELY;
 		goto done;
 	}
-- 
2.44.0

