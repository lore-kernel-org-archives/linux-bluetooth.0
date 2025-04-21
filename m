Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE14326156E
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Apr 2025 11:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745233525; cv=pass; b=cVO0C2pGziuwGNdfG0EJXrbtKkxrjcYZUyJnH5H7bYQ+aPGwS3Y+SRY1HaHtlOpudA+cXyDls0TnV4/o4KUnlZlSPf3aNi43iNhDl7O3qH015Arvg0vSkJUL6t/HNibw+F33MXtq0SlgRH82dLhubLz0pBLvPqAy8Iv/2wqvUSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745233525; c=relaxed/simple;
	bh=G5XXUK2GwQWdWsqj9b5uoDW+rcK6DvYg5EtneBWZG5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJbIISHwaNb58aoaoYSMthJCYRsXyf8jKe6Qvh25Yn6AENEZargmIHNdsbffkqm7je3Xfx2oc5HDsRnJ8pf8e5Qff/y3XXCAdgZq+/tIaYIw4dzeEugPsQJ3IQ89DQG578BtstjAOOhCMDRSUyL+jBuLMlF7qZLduXMqpBP8yto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=uTsCEGtD; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=dBypivKn; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="uTsCEGtD";
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="dBypivKn"
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4Zh2b15SVXz49Q6J
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Apr 2025 14:05:17 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1745233517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G2aV0hqQanHNGu2qFN0rY0Homt2sDFsu143OQeg15/Q=;
	b=uTsCEGtDjc/RgGZzFqEcj1uGkDr9fILxC//zyKvmfoGyeiiFk9w9sQbwULGYnjQZvZUX92
	dNU4i9au2pJt/MIUc2hEjxsnupjOA7KgFkN+t/muuKOKvuk02ycFt6OkUqW7ZrQgyOKq5N
	x1OcpViu4KHOPYy3zffDVedEe4itc7T9pCzGsT3j2QLzT7w92sD4yoZdMUzUmWQIsGnEzW
	3Vh2UJY2wEvgs0j+R6ZPilHef+t/N9RY8tSOAuEX9piAzECMx/jG86R2uhVRGb6A4Y4FAV
	cGqb1eB0fheU7N0lyP7SGk+hRPaVHK64SUstSr4X8aJGIi9+1OzsClJKVqlyTA==
Received: from monolith.lan (unknown [185.77.218.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4Zh2Zs3x2HzyWZ;
	Mon, 21 Apr 2025 14:05:09 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1745233509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G2aV0hqQanHNGu2qFN0rY0Homt2sDFsu143OQeg15/Q=;
	b=dBypivKn3ZA9IH5mwc9Qj8JttuGlzC/KH1q3vs2zuTgfAmwoTwxmrPWzQFtbqPwYN0TBsC
	ZE1PFwf/bd0kYBTHW0Mn2orfSP91fIhvL6ghdDwZP8bJfhufLPbQJhXkB0wLH5Y8N48Mr1
	uVioXcO/nydAkPahOP7243Wy/heyEwE=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1745233509; a=rsa-sha256; cv=none;
	b=PPKJs3Jb2ts8a/ObRQXimvP/Cwdah/ycWNWmkWeLPMDzxacrDSmR5D++O/I5jslsF0STHs
	D1To14BRUqiwGBIW973i9cJ/2mZui67VL1kapzXUrA1wHv/qCamFp2YuQxEKLBymWiVm3y
	wY7XxOJhTOhqVnhiX/pj9CWmzdxYC/M=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1745233509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G2aV0hqQanHNGu2qFN0rY0Homt2sDFsu143OQeg15/Q=;
	b=eXeaBOor77E8Tu71K/9ZznpJfcVwKO2d/DKhndpHyz+vsugsuonoGpqzVM2znn1P2RZbub
	mi0bgJgspD9Sdf1SqYdhIX48PY+YX6xtEwFtwgc4JIIe+lynFKPavHeHYY9kvMDabjmLAi
	dBL08r6OJFjOGJEFdHpjKEYiieuSnyM=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/2] media: implement SupportedFeatures property
Date: Mon, 21 Apr 2025 14:04:34 +0300
Message-ID: <ebc8762f1d7d65b9fb414d2b538985b23546ab57.1745233468.git.pav@iki.fi>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <fb302ed17cf2a4331d7ca57529cdbdde80376d82.1745233468.git.pav@iki.fi>
References: <fb302ed17cf2a4331d7ca57529cdbdde80376d82.1745233468.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add org.bluez.Media.SupportedFeatures. The value tx-timestamping is
hardcoded as it is currently always enabled.
---
 profiles/audio/media.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 69c6dc671..df36bc2df 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -3340,8 +3340,28 @@ static gboolean supported_uuids(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean supported_features(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	static const char * const features[] = { "tx-timestamping" };
+	DBusMessageIter entry;
+	size_t i;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+				DBUS_TYPE_STRING_AS_STRING, &entry);
+
+	for (i = 0; i < ARRAY_SIZE(features); ++i)
+		dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
+							&features[i]);
+
+	dbus_message_iter_close_container(iter, &entry);
+
+	return TRUE;
+}
+
 static const GDBusPropertyTable media_properties[] = {
 	{ "SupportedUUIDs", "as", supported_uuids },
+	{ "SupportedFeatures", "as", supported_features },
 	{ }
 };
 
-- 
2.49.0

