Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49674170889
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 12:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715343253; cv=none; b=mgofisy0Nr5zmi88ePf3AcsjqahgKXIHvJNeZ1qCHU+wa/1SvtVc359imDmjMvKgNA5pce8ZVJad6cH0+JEJnwg5tzo4+oj2HlUAxYnyyPk973doX/5oCfiVh2XXRG8HwlSReRzbbyNDTm4NsQvPrao0MByHs5yW+wOM0QD6ACQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715343253; c=relaxed/simple;
	bh=qz8dsn86PoKyiEMWJOJVKAKfMqx70ZUJV6tnXXFCHS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qqMG5kcRWHZf90j592THZ4lQPb+pFvIOJ/rXD78Jx2oZHiDB1ENoL0vmAuJyqmoSCdrOgy3QUHjFgCii1mj88HeF/7+qIJwXsFRO3Q6moA/e5yPaxCjmkCno4QevhUy4pb3u9PhlB5atTRBZKCEnmRIJDI4TURhw1AzBs2XCw9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 40E7560002;
	Fri, 10 May 2024 12:13:56 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ v2 02/20] attrib/gatt: Guard against possible integer overflow
Date: Fri, 10 May 2024 14:10:12 +0200
Message-ID: <20240510121355.3241456-3-hadess@hadess.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240510121355.3241456-1-hadess@hadess.net>
References: <20240510121355.3241456-1-hadess@hadess.net>
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

