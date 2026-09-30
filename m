Received: from mail-ed2-f32.google.com (mail-ed2-f32.google.com [74.125.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370503750CF
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 09:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790761400; cv=none; b=TBNW7SHNROImtUksLpDq6oeNae/S6fvlJ+Aiga/1yzv8VtUjKGVs+NLiypxdKQFwANNYZmKY89zkwXBhugMWwPMkMeWUvpgXJ0VzZpm3A13aIsaHxgBaSMyY7QvJhbPnQC/ll3xodk8UZZHrdtNo1m63zobjfSLkW08FS9V4jD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790761400; c=relaxed/simple;
	bh=kYyzalmT8qXq+K3jtt64FvVJdmkZHCMjQwZtY8e+4jI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MN4JOLSgXt/3MTUwc5nM7DJkIAwka/VXu/TjOS7KCEhAYyxRFnNKiHhRctR7FlUU5oCYhmAESANFq6df9NVYanAr/Sqtm5UsezBLljf5No77DKZHCMV02RxfgbVESt3b3Y7g0F8V5lfWyYbqjsn5Qe5LVBJO2rVZ6SS0en7oMoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Igfijpzh; arc=none smtp.client-ip=74.125.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Igfijpzh"
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6acf521a4ddso592903a12.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 02:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790761397; x=1791366197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qaKCJegRtsdZszJHJD3YVo9To6pOLKHUX60fkVzYRI4=;
        b=IgfijpzhMOj3xvfRq9SWJoK7pF0I/jL2jjeMqqzTFnAHHcXqU2IaRShZP5WOsuVMMP
         nVJh8AXLaf9pJZGkz7FE8kwKVcfDoR0KbmCqclv7Bef63KVyvQ6O7MxA4f2Q4X45mFNo
         QYKTDixJPoJLL6yZc/QH3aSlmXvk7P8NISMt9iEtp6vkZBNy7ngxTIxqA1w1f24xxD6m
         mWzEk+yaaB4gT15QBoHvaJsckWkVjxwvoPO/0mkIqUsFX1oO0ymCHz6M6uqWjAL5u/WS
         MrVveNcvmCZdkDxaZAddSiYgqTVZaiMTd5A7iGNuKTF3SERomktTRFVnDo8rf5uLBb2b
         ATvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790761397; x=1791366197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qaKCJegRtsdZszJHJD3YVo9To6pOLKHUX60fkVzYRI4=;
        b=o44kAKqnzVMQpcky0PpekqNRJiDKGzzds4uMH9PX9vL8v0urlDbB+xPfTV58vpeBa1
         LVcqwZFAaUCu2AZujM9ALDw4RYgVUslzZm+fc/FdHRX14ERy69krUAu9lQRwfGciKT6k
         rRjf25CoZSMmU1vqzQUxjOKMOQlCwAw66bO+JXVuFzmgxwgpY1x+rOL6Yb0FdQ+PB18r
         8081udtIj71gEw4UirGMKPzhRskEBmx5mUbheH57xn8euyHw1D6ffWiFhFQN2zrQu1Bt
         XLf+utoVRJGamspzclXhGzxrDlXCkug/xYUevNfKWXx190MQv4Efcfj/8Huzn1nhCQFE
         743A==
X-Gm-Message-State: AFq9FYJDm0uBXOBmLFRHrzBK+sAuWb3LZpZ2NVg3T7J3K+SFiHIsM2BJ
	7M9tUXy821ret/s4DABty8A5VYFN+vvQmvg66Ve05WIPTBPfqY9LllxsQ38bWnCL
X-Gm-Gg: AYBFou03DcCH8bQRNNFKLTaevAp+Ma4Gcg5LUHUIN9+DkmECcIhchTbEqZAbx9C6Nju
	DYCkOoY3egQlFHF/SGjFfiboCj1N3kT3cNyfvgeycC+D/Ig9kn9bNzA6pi6jkhANEPnzMc68H1r
	tZPCtlKbT0M6z/DNhLO0YNJlNieUDVdPy80H5KqWNp50itg19UuNHlz6/huL9MU5QEO54G68FTU
	IIwozJfNXWNNw/yhppvQ8MjhinFiSS1wxLzt6mDvsPsCyHQDPatUi+j1CwhnCyXMX/3bW2Hk0i1
	fqAM+xx3AqY2gPj1bV6jfw/5ZDSVeLc5mOcupeMNGSMWBTK4t/cK3KgBvM2Zmp/GAK2wRwCQInM
	bLhpRD9m/6oYV7frPFou3a6nbwH04Wi4RJ9WzEAK/7oGTFhFBinBBKDAKGifBRDS0IBPxLUzxPM
	un+o0+Zw/UFlyefdGaF9L6RezsXq7dhml9gJQqbU5yxmsc/lPR+zAaivAHX39yNfxDalya6YaUA
	O2Ov7UY5t1ZnmyYfDVDlYlr+EWtzRUYu2wtB5Nf+4Q2fkwmdyImgR+JFnMYilaLgMcWLQurF4WJ
	Lxj6fqWPJ0A8Ks9/vNVeGPy6j7d3aLspJN4QhJ7OMMg=
X-Received: by 2002:a05:6402:304b:b0:6ab:e30:c9a0 with SMTP id 4fb4d7f45d1cf-6ae19e365d2mr407406a12.13.1790761396903;
        Wed, 30 Sep 2026 02:43:16 -0700 (PDT)
Received: from home-fedora.hippo-beardie.ts.net (146-241-156-87.dyn.eolo.it. [146.241.156.87])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ae1539561esm521126a12.13.2026.09.30.02.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 02:43:16 -0700 (PDT)
From: Gianluca Altomani <altomanigianluca@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Gianluca Altomani <altomanigianluca@gmail.com>
Subject: [PATCH BlueZ 1/2] shared/gatt-db: Always notify service removal
Date: Wed, 30 Sep 2026 11:39:27 +0200
Message-ID: <20260930093928.360745-2-altomanigianluca@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930093928.360745-1-altomanigianluca@gmail.com>
References: <20260930093928.360745-1-altomanigianluca@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gatt_db_service_destroy() only notified removal listeners about active
services. A gatt-client discovery keeps services that are not active
yet in its pending_svcs queue, and it only drops them from that queue
through this notification. When such a service is destroyed while the
discovery is in flight, for example through gatt_db_clear_range() after
the link drops mid-discovery, the queue is left pointing at freed
memory, and discovery_op_complete() then dereferences it:

  gatt_db_service_get_active (src/shared/gatt-db.c)
  discovery_op_complete (src/shared/gatt-client.c)

Notify removal whether or not the service was active. The other
removal listeners already ignore services they never saw added, since
services are only announced when they become active.

It is reproduced by connecting over LE, reading one characteristic and
disconnecting about once a second, so that the link repeatedly drops
while bluetoothd is still discovering the peer: on 5.72 bluetoothd
crashed on the 15th connection in 4 runs out of 4.

The same change was found independently in
https://github.com/ownback/airpods-bluez-fix.

Assisted-by: Claude:claude-opus-5-5
---
 src/shared/gatt-db.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 751d4c3da..88c8e9e4e 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -507,8 +507,13 @@ static void gatt_db_service_destroy(void *data)
 	struct gatt_db_service *service = data;
 	int i;
 
-	if (service->active)
-		notify_service_changed(service->db, service, false);
+	/*
+	 * Notify even if the service never became active: gatt-client
+	 * discovery keeps inactive services in its pending list and only
+	 * learns of their removal from this notification, so skipping it
+	 * leaves that list pointing at freed memory.
+	 */
+	notify_service_changed(service->db, service, false);
 
 	for (i = 0; i < service->num_handles; i++)
 		attribute_destroy(service->attributes[i]);
-- 
2.55.0

