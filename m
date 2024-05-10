Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911BC16F90D
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 12:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715343259; cv=none; b=DAUvD4OmtsoEpdj/Ygmo64fSL+DVJ/jnP56x8uI+W6AInXSIfZeqdgwhOrGe8uLCcmAiqBpJ//5+90QomQzsR+cSWuTcYGwJoHBW4K14rG3JfQzBv0bl6UXE07wFhcuT5ZwkjwgtlGLNAZCqU5sKexGxx7zFCE5wqntAuq1hQNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715343259; c=relaxed/simple;
	bh=vFe5qKmQHRVEE4cES7AAibKqsLuZAYq13Rek/uW306Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hFdRCTlmCFp29asH7zpX9YhCx0jPalHRMMdlHMTKh/dyMjnkhIE+xMkJFfVYXFoPt/umk62eT1mkPZgwA8WkLZmXh5kVWkr/55cKDXpp5szxZqRSJZGiL06T1QOMIt09GQM27ckz9T8IoCAHGx3++Jy0xVBTjcIrTfQuyMk5nE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2213060015;
	Fri, 10 May 2024 12:14:01 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ v2 18/20] monitor: Work-around memory leak warning
Date: Fri, 10 May 2024 14:10:28 +0200
Message-ID: <20240510121355.3241456-19-hadess@hadess.net>
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

Work-around this warning by making the so pointer global.

Error: RESOURCE_LEAK (CWE-772): [#def29] [important]
bluez-5.75/monitor/jlink.c:87:3: alloc_fn: Storage is returned from allocation function "dlopen".
bluez-5.75/monitor/jlink.c:87:3: var_assign: Assigning: "so" = storage returned from "dlopen(jlink_so_name[i], 1)".
bluez-5.75/monitor/jlink.c:95:2: noescape: Resource "so" is not freed or pointed-to in "dlsym".
bluez-5.75/monitor/jlink.c:96:2: noescape: Resource "so" is not freed or pointed-to in "dlsym".
bluez-5.75/monitor/jlink.c:97:2: noescape: Resource "so" is not freed or pointed-to in "dlsym".
bluez-5.75/monitor/jlink.c:98:2: noescape: Resource "so" is not freed or pointed-to in "dlsym".
bluez-5.75/monitor/jlink.c:99:2: noescape: Resource "so" is not freed or pointed-to in "dlsym".
bluez-5.75/monitor/jlink.c:100:2: noescape: Resource "so" is not freed or pointed-to in "dlsym".
bluez-5.75/monitor/jlink.c:101:2: noescape: Resource "so" is not freed or pointed-to in "dlsym".
bluez-5.75/monitor/jlink.c:102:2: noescape: Resource "so" is not freed or pointed-to in "dlsym".
bluez-5.75/monitor/jlink.c:103:2: noescape: Resource "so" is not freed or pointed-to in "dlsym".
bluez-5.75/monitor/jlink.c:104:2: noescape: Resource "so" is not freed or pointed-to in "dlsym".
bluez-5.75/monitor/jlink.c:116:2: leaked_storage: Variable "so" going out of scope leaks the storage it points to.
114|
115|	/* don't dlclose(so) here cause symbols from it are in use now */
116|->	return 0;
117|   }
118|
---
 monitor/jlink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/monitor/jlink.c b/monitor/jlink.c
index f9d4037f4cdf..e08cc87139c9 100644
--- a/monitor/jlink.c
+++ b/monitor/jlink.c
@@ -47,6 +47,7 @@ struct rtt_desc {
 };
 
 static struct rtt_desc rtt_desc;
+static void *so = NULL;
 
 typedef int (*jlink_emu_selectbyusbsn_func) (unsigned int sn);
 typedef int (*jlink_open_func) (void);
@@ -80,7 +81,6 @@ static struct jlink jlink;
 
 int jlink_init(void)
 {
-	void *so;
 	unsigned int i;
 
 	for (i = 0; i < NELEM(jlink_so_name); i++) {
@@ -109,6 +109,7 @@ int jlink_init(void)
 			!jlink.emu_getproductname ||
 			!jlink.rtterminal_control || !jlink.rtterminal_read) {
 		dlclose(so);
+		so = NULL;
 		return -EIO;
 	}
 
-- 
2.44.0

